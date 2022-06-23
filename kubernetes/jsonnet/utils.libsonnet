{
  applicationize(manifests):: {
    [kind]: {
      [object.metadata.name]: object
      for object in manifests
      if object.kind == kind
    }
    for kind in std.set([manifest.kind for manifest in manifests])
  },
  dehelminize(manifests)::
    local removeHelmLabels =
      local labels = ['helm.sh/chart', 'app.kubernetes.io/managed-by'];
      { metadata+: $.mixins.removeLabels(labels) };

    local removeTemplateHelmLabels =
      { spec+: { template+: removeHelmLabels } };

    std.map(
      function(manifest) manifest +
                         removeHelmLabels +
                         if manifest.apiVersion == 'apps/v1' then removeTemplateHelmLabels else {},
      manifests
    ),
  mixins: {
    removeLabels(labels):: {
      local superLabels = super.labels,
      labels: { [f]: superLabels[f] for f in std.objectFields(superLabels) if !std.member(labels, f) },
    },
  },
}
