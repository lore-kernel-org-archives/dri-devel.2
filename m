Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3E606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/XBOmZm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B5710E9B6;
	Thu, 26 Nov 2026 11:57:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7607510E9B6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2817845B41;
 Thu, 26 Nov 2026 11:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EB91F000C4;
 Thu, 26 Nov 2026 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694215;
 bh=j04DbHwnonuQvnIaCr/zxjeshzVCFCQJH9SInpd8Roc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E/XBOmZmXAr+mEY5k/zfsE5H1zeW9TJw0KLxJsl6F/6ZYod+eP1LmPCxWaxa3VatB
 PeuI978KAtQLAzwqkDBug/XQozYJn8owknCCST/Ptx8Q6UzO3Q9xqmOdlqTsEzxx42
 RBdlgblu+62sE7UJVRjtXUy5MYiq2OQr73+60E9SAWgDZMdWKVVilrzloDP/bOy5AZ
 nxJZgb1fNDtaVW7RMGUj8YMMjEKGZhm/NRRH1phKvLeMfUjo5vOzAoOm160VhY2xQG
 yfJ/CuT8K64gTZ1qxAp/UYOq3XiQZYv7+DglPI89EnLLB2rHi1cq6FJwHIFIBFnqLl
 k3xxqI71FBVaQ==
Message-ID: <sashiko-outbox-235452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 42/43] drm/vkms: Add connector parent configuration
 in vkms_config
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-42-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-42-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:56:54 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/vkms: use-after-free on stale connector_cfg->connector
  across device reset
- [Medium] drm/vkms: vkms_config_connector_get_parent() fails to detect
  destroyed parent
- [Medium] drm/vkms: reference cycle leak when parent connector is
  destroyed before config
- [Medium] drm/vkms: valid_connector_parents() mishandles static
  connectors with enabled=3D0
- [Low] drm/vkms: vkms_connector_build_path_property() drops port_id at
  16 nesting hops
--

commit ce654c82414edd96edaad21d3e70ad4c756954e2
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Add connector parent configuration in vkms_config

This commit adds parent connector and port_id configuration to
vkms_config_connector and populates the DRM connector PATH property to
emulate MST topologies.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 2c6a53d6f7783..fb6368e53c076 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -498,6 +508,43 @@ static bool valid_connector_colorspaces(const struct=
 vkms_config *config)
>  	return true;
>  }
> =20
> +static bool valid_connector_parents(const struct vkms_config *config)
> +{
> +	struct drm_device *dev =3D config->dev ? &config->dev->drm : NULL;
> +
> +	struct vkms_config_connector *connector_cfg;
> +	const struct vkms_config_connector *parent;
> +	size_t num_connectors =3D 0;
> +	size_t depth;
> +
> +	vkms_config_for_each_connector(config, connector_cfg)
> +		num_connectors++;
> +
> +	vkms_config_for_each_connector(config, connector_cfg) {
> +		bool expected_status =3D connector_cfg->enabled;
> +
> +		parent =3D connector_cfg;
> +		for (depth =3D 0; parent; depth++) {
> +			/* A loop in the parent chain is walked more than
> +			 * num_connectors times.
> +			 */
> +			if (depth > num_connectors) {
> +				drm_info(dev, "Parents of connector should not form a loop\n");
> +				return false;
> +			}
> +
> +			if (expected_status && parent->enabled !=3D expected_status) {
> +				drm_info(dev, "All parents of an enabled connector must be enabled\n=
");
> +				return false;
> +			}
> +
> +			parent =3D vkms_config_connector_get_parent(parent);
> +		}
> +	}
> +
> +	return true;
> +}

[Severity: Medium]
Does valid_connector_parents() mishandle static connectors whose enabled
field is false?

Static connectors (!connector_cfg->dynamic) are always created and
registered by vkms_output_init() regardless of connector_cfg->enabled, and
configfs allows writing 0 to enabled while the device is disabled.  If a
static child connector has enabled =3D=3D false and is attached to a disabl=
ed
dynamic parent, valid_connector_parents() skips the parent check and
vkms_output_init() registers the child with an unpopulated PATH property of
0 while its root parent is never created.  Conversely, an enabled child
attached to a static parent with enabled =3D=3D false is rejected.

[ ... ]

> @@ -1154,7 +1213,8 @@ int vkms_config_connector_set_edid(struct vkms_conf=
ig_connector *connector_cfg,
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_set_edid);
> =20
> -void vkms_config_destroy_connector(struct vkms_config_connector *connect=
or_cfg)
> +void vkms_config_destroy_connector(struct vkms_config *config,
> +				   struct vkms_config_connector *connector_cfg)
>  {
>  	/*
>  	 * Pin the config, then unlink and drop the list's reference. If this
> @@ -1163,13 +1223,41 @@ void vkms_config_destroy_connector(struct vkms_co=
nfig_connector *connector_cfg)
>  	 * nor free the config (pinned). list_del_rcu() because a concurrent
>  	 * dump may still be walking this connector.
>  	 */
> -	vkms_config_get(connector_cfg->config);
> +	vkms_config_get(config);
>  	list_del_rcu(&connector_cfg->link);
>  	connector_cfg->unlinked =3D true;
> +	/*
> +	 * The connector is logically destroyed but stays allocated
> +	 * while its children still hold a reference on it; detach it
> +	 * from its own parent now. Without this, a parent cycle
> +	 * (accepted at link time, rejected when enabling the device)
> +	 * would keep every member of the cycle alive forever, as
> +	 * plain krefs cannot be reclaimed in a loop.
> +	 */
> +	if (connector_cfg->parent) {
> +		struct vkms_config_connector *parent =3D connector_cfg->parent;
> +
> +		connector_cfg->parent =3D NULL;
> +		vkms_config_connector_put(parent);
> +	}
> +
>  	vkms_config_connector_put(connector_cfg);
>  }

[Severity: Medium]
Does destroying a parent connector before vkms_config_destroy() leak
config and its remaining objects via a reference cycle?

When vkms_config_destroy_connector(config, parent) runs while a child in
config->connectors still has child->parent =3D=3D parent, it takes a refere=
nce
on config with vkms_config_get(config) that is only dropped in
vkms_config_connector_release() once parent->refcnt reaches 0.  Because
child->parent keeps parent->refcnt > 0 and child->parent is only cleared
in vkms_config_release() when config->refcnt reaches 0, a subsequent
vkms_config_destroy(config) leaves config, child, and parent pinning each
other permanently.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index e5352aaea85e6..83869e677f157 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
[ ... ]
> +static inline struct vkms_config_connector*
> +vkms_config_connector_get_parent(const struct vkms_config_connector *con=
nector_cfg)
> +{
> +	struct vkms_config_connector *parent =3D connector_cfg->parent;
> +
> +	if (parent && list_empty(&parent->link))
> +		return NULL;
> +
> +	return parent;
> +}

[Severity: Medium]
Does list_empty(&parent->link) ever detect a parent destroyed by
vkms_config_destroy_connector()?

vkms_config_destroy_connector() removes the connector with list_del_rcu()
and sets parent->unlinked =3D true, while the child's reference keeps
parent->refcnt > 0.  list_del_rcu() intentionally leaves parent->link.next
unchanged for RCU readers, so list_empty(&parent->link) evaluates to false
and vkms_config_connector_get_parent() keeps returning the destroyed
parent instead of NULL.  Checking parent->unlinked avoids this.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 93bceba0a1ae6..5655f8b649c66 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -8,6 +8,76 @@
>  #include "vkms_config.h"
>  #include "vkms_connector.h"
> =20
> +/**
> + * vkms_connector_build_path_property() - Build the PATH property string=
 for MST connectors
> + * @connector: The connector to build the PATH property for
> + * @connector_cfg: The connector configuration
> + *
> + * The PATH property format is:
> + *     mst:<drm object ID of root connector>-<dash-separated list of por=
t_id>
> + * For nested MST connectors, this builds the full path like mst:45-2-3-=
4-2
> + */
> +static void vkms_connector_build_path_property(struct vkms_connector *co=
nnector,
> +						       const struct vkms_config_connector *connector_cfg)
> +{
> +	const struct vkms_config_connector *current_cfg =3D connector_cfg;
> +	const struct vkms_config_connector *root_cfg =3D NULL;
> +	struct vkms_connector *root_connector =3D NULL;
> +	char path[128]; /* Increased size for nested MST paths */
> +	int len =3D 0;
> +	u8 port_ids[16]; /* Max 16 levels of nesting */
> +	int port_count =3D 0;
> +	int i;
> +
> +	if (!vkms_config_connector_get_parent(connector_cfg))
> +		return;
> +
> +	while (current_cfg) {
> +		if (port_count < ARRAY_SIZE(port_ids))
> +			port_ids[port_count++] =3D current_cfg->port_id;
> +
> +		if (!vkms_config_connector_get_parent(current_cfg)) {
> +			root_cfg =3D current_cfg;
> +			break;
> +		}
> +
> +		current_cfg =3D vkms_config_connector_get_parent(current_cfg);
> +	}
> +
> +	if (!root_cfg || !root_cfg->connector)
> +		return;
> +
> +	root_connector =3D root_cfg->connector;
> +
> +	len =3D snprintf(path, sizeof(path), "mst:%d", root_connector->base.bas=
e.id);
> +
> +	for (i =3D port_count - 2; i >=3D 0; i--) {
> +		int added =3D snprintf(path + len, sizeof(path) - len,
> +				     "-%u", port_ids[i]);
> +		if (added < 0 || len + added >=3D sizeof(path))
> +			return;
> +		len +=3D added;
> +	}
> +
> +	drm_connector_set_path_property(&connector->base, path);
> +}

[Severity: Low]
Does vkms_connector_build_path_property() drop the first child's port_id
when the chain reaches 16 levels of nesting?

The loop records current_cfg->port_id before checking whether current_cfg
is the root connector, and the formatting loop starts at port_count - 2 to
skip the root's entry.  At 16 hops below the root, port_ids[0..15] fills
with the 16 child port IDs before reaching root_cfg, so starting at
port_count - 2 skips port_ids[15], which holds the first child's port_id
rather than the root's.

> +
> +/**
> + * vkms_connector_update_path_properties() - Update PATH properties for =
all connectors
> + * @vkmsdev: VKMS device
> + *
> + * This should be called after all connectors are created to ensure pare=
nt connectors
> + * have valid DRM object IDs.
> + */
> +void vkms_connector_update_path_properties(struct vkms_device *vkmsdev)
> +{
> +	struct vkms_config_connector *connector_cfg;
> +
> +	vkms_config_for_each_connector(vkmsdev->config, connector_cfg)
> +		if (connector_cfg->connector)
> +			vkms_connector_build_path_property(connector_cfg->connector, connecto=
r_cfg);
> +}
[ ... ]
> @@ -278,6 +352,8 @@ struct vkms_connector *vkms_connector_hot_add(struct =
vkms_device *vkmsdev,
>  		return ERR_PTR(ret);
>  	}
> =20
> +	vkms_connector_build_path_property(connector, connector_cfg);
> +
>  	/*
>  	 * Attach the configuration before registration and serialize the
>  	 * registration with in-flight probes: drm_mode_getconnector() holds

[Severity: High]
Can vkms_connector_build_path_property() and
vkms_connector_update_path_properties() trigger a use-after-free on stale
connector_cfg->connector pointers when a device is disabled and
re-enabled?

When vkms_destroy() tears down a device, neither
vkms_connector_static_cfg_release() nor vkms_connector_dynamic_destroy()
clears connector_cfg->connector.  On the next vkms_create() ->
vkms_output_init(), two paths dereference the freed struct vkms_connector
from the previous device instance:

1. If a dynamic child connector was enabled during the first instance and
   is then disabled while the device is disabled, the next
   vkms_output_init() skips it in the if (connector_cfg->enabled) loop,
   leaving connector_cfg->connector pointing to the freed connector.
   vkms_connector_update_path_properties() then checks only
   if (connector_cfg->connector) and calls
   drm_connector_set_path_property() on the freed connector.

2. If an enabled dynamic child precedes its enabled dynamic root in
   config->connectors, vkms_output_init() calls vkms_connector_hot_add() on
   the child before root_cfg->connector is updated for the new device, and
   vkms_connector_build_path_property() reads root_connector->base.base.id
   from the old freed root connector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D42
