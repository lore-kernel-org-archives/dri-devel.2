Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0918606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dr9Se4Ns
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141C910E454;
	Thu, 22 Oct 2026 17:02:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382DD10E204;
 Thu, 22 Oct 2026 17:02:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1ECC6022E;
 Thu, 22 Oct 2026 17:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1883F1F01825;
 Thu, 22 Oct 2026 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792688560;
 bh=7+Q0Nbkc7n+jDW2cu9GRC4aL9Bd+gjLeJYc5xriIBF8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dr9Se4Ns/C1McjZiEpxbT9wosS5WQAUiAfbokbKeMIEi5uPueibMl7gc8Zh0alEpG
 0pQUinUL6fTzInAI16J40QsLtYBM6uRNNXYofQw/R4/SfahWKkx121lELVHUWrQ8I0
 FG5UStvaLCZGYD3b8jBgFfJNe7xe/Wd72SHjBEiOUAITCk9S/IYaLaiSQpOirbVbhQ
 jR/b+EpIkp3kwrOUuauSE+K3aBZBo+qnvBZMSeL2SCszOg8OL5NcbJGOSA+B6X2SIX
 IDwyNYQlqr2eJR74b2sHjIM1Zu+qv96kWKjtq9pX6De9iNB/4a+6QginnQBLwIHHSo
 lRWWmuyJ7EzoQ==
Message-ID: <sashiko-outbox-181840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] drm: Introduce DisplayPort link training
 capabilities and state helpers
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261022-feat_link_cap-v4-3-a4f3f6e8cad9@bootlin.com>
References: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
 <20261022-feat_link_cap-v4-3-a4f3f6e8cad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:02:39 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm: use-after-free on connector->kdev in drm_sysfs_connector_remo=
ve()
- [High] drm: kdev race in drm_sysfs_connector_add() causes -EEXIST failure
- [Medium] drm: unlocked nlanes read in dp_link_attr_visible() races with u=
pdates
- [Medium] drm: missing LTTPR validation in drm_dp_sink_sync_caps()
--

commit 9bbc7a53acf715de24f598695d290cb7880247c1
Author: Kory Maincent <kory.maincent@bootlin.com>

drm: Introduce DisplayPort link training capabilities and state helpers

This commit adds DisplayPort link training capability and state helpers to
drm_dp_helper.c and exposes source, sink, and current link parameters
through a dp_link sysfs attribute group on DisplayPort and eDP connectors.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index 8473dbcd8808a..5e53c6a9d35fd 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c

[ ... ]

> @@ -5135,6 +5136,30 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux =
*aux,
>  }
>  EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_sink_rates);
> =20
> +/**
> + * drm_dp_get_max_lane_count - Get the max lane count from DPCD and LTTPR
> + *			       capabilities
> + * @dpcd: DPCD receiver capabilities
> + * @lttpr_common_caps: LTTPR common capabilities (NULL if no LTTPR suppo=
rted)
> + *
> + * Returns: Number of max lane count
> + */
> +int drm_dp_get_max_lane_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> +			      const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE])
> +{
> +	int nlanes, lttpr_nlanes;
> +
> +	nlanes =3D dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
> +	if (lttpr_common_caps) {
> +		lttpr_nlanes =3D drm_dp_lttpr_max_lane_count(lttpr_common_caps);
> +		if (lttpr_nlanes)
> +			nlanes =3D min(nlanes, lttpr_nlanes);
> +	}
> +
> +	return nlanes;
> +}
> +EXPORT_SYMBOL_GPL(drm_dp_get_max_lane_count);
> +
>  /**
>   * drm_dp_read_edp_sink_rates() - read the sink rates from the eDP DPCD
>   * @aux: DisplayPort AUX channel
> @@ -5196,3 +5221,284 @@ int drm_dp_read_dsc_dpcd(struct drm_dp_aux *aux,

[ ... ]

> +int drm_dp_sink_sync_caps(struct drm_connector *connector, struct drm_dp=
_aux *aux,
> +			  const struct drm_dp_tunnel *tunnel)
> +{
> +	u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE] =3D {0};
> +	struct drm_connector_dp_link_caps link_caps;
> +	int sink_rates[DP_MAX_SUPPORTED_RATES] =3D {0};
> +	u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE] =3D {0};
> +	u8 dpcd_caps[DP_RECEIVER_CAP_SIZE] =3D {0};
> +	struct drm_dp_desc desc =3D {0};
> +	int num_sink_rates, ret;
> +	u8 edp_dpcd_rev =3D 0;
> +
> +	if (!connector)
> +		return -ENODEV;
> +
> +	ret =3D drm_dp_read_dpcd_caps(aux, dpcd_caps);
> +	if (ret < 0) {
> +		drm_dbg_kms(aux->drm_dev, "%s: error reading DPCD capabilities (%d)\n",
> +			    aux->name, ret);
> +		return ret;
> +	}
> +
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		ret =3D drm_dp_dpcd_read_byte(aux, DP_EDP_DPCD_REV, &edp_dpcd_rev);
> +		if (ret < 0)
> +			drm_dbg_kms(aux->drm_dev, "%s: No DPCD eDP revision found\n",
> +				    aux->name);
> +	}
> +
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort &&
> +	    dpcd_caps[DP_DPCD_REV] >=3D DP_DPCD_REV_13) {
> +		ret =3D drm_dp_read_lttpr_common_caps(aux, dpcd_caps, lttpr_common_cap=
s);
> +		if (ret < 0) {
> +			drm_dbg_kms(aux->drm_dev,
> +				    "%s: error reading LTTPR caps, assuming no LTTPR (%d)\n",
> +				    aux->name, ret);
> +			/* LTTPR capabilities are read block by block. Clean the
> +			 * entire capabilities if the read fails to avoid
> +			 * partial garbage
> +			 */
> +			memset(lttpr_common_caps, 0, sizeof(lttpr_common_caps));
> +		}
> +	}

[ ... ]

> +	link_caps.nlanes =3D drm_dp_get_max_lane_count(dpcd_caps, lttpr_common_=
caps);
> +	link_caps.nlink_rates =3D num_sink_rates;
> +	link_caps.link_rates =3D sink_rates;
> +	link_caps.dsc =3D drm_dp_sink_supports_dsc(dsc_dpcd);
> +
> +	return drm_dp_sink_set_caps(connector, &link_caps);
> +}
> +EXPORT_SYMBOL_GPL(drm_dp_sink_sync_caps);

[Severity: Medium]
Can drm_dp_sink_sync_caps() and drm_dp_get_max_lane_count() clamp
sink_link_caps.nlanes and sink_link_caps.link_rates using unvalidated
repeater bytes when a sink does not have repeaters present?

In drivers/gpu/drm/display/drm_dp_helper.c, drm_dp_sink_sync_caps() calls
drm_dp_read_lttpr_common_caps(aux, dpcd_caps, lttpr_common_caps) for any
DisplayPort 1.3 or newer sink and only zeroes lttpr_common_caps if the read
returns a negative error code.

If a sink without repeaters succeeds on that read and returns non-zero
bytes where lttpr_common_caps[0] < 0x14 or
drm_dp_lttpr_count(lttpr_common_caps) <=3D 0, neither
drm_dp_sink_sync_caps(), drm_dp_get_max_lane_count(), nor the 8b/10b path
in drm_dp_read_dpcd_sink_rates() validates the repeater revision or count
the way drm_dp_get_128b132b_link_rates() does:

drivers/gpu/drm/display/drm_dp_helper.c:drm_dp_get_128b132b_link_rates() {
	...
	if (lttpr_common_caps && drm_dp_lttpr_count(lttpr_common_caps) > 0) {
		/* We have a repeater */
		if (lttpr_common_caps[0] >=3D 0x20 &&
	...
}

In addition, drm_dp_sink_sync_caps() passes tunnel to
drm_dp_read_dpcd_sink_rates(), but drm_dp_get_max_lane_count() does not
account for drm_dp_tunnel_max_dprx_lane_count(tunnel).

Should lttpr_common_caps be validated (checking lttpr_common_caps[0] >=3D
0x14 and drm_dp_lttpr_count(lttpr_common_caps) > 0) before clamping
nlanes and 8b/10b link rates, and should tunnel lane count limits also be
applied?

[ ... ]

> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 7b16d32b6ff65..ac9762a066db4 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -340,6 +340,151 @@ static const struct attribute_group *connector_dev_=
groups[] =3D {

[ ... ]

> +static umode_t dp_link_attr_visible(struct kobject *kobj,
> +				    struct attribute *a, int n)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct drm_connector *connector =3D to_drm_connector(dev);
> +	struct drm_connector_dp_link_caps *caps;
> +
> +	if (a =3D=3D &dev_attr_source_link_caps_nlanes.attr ||
> +	    a =3D=3D &dev_attr_source_link_caps_link_rates.attr ||
> +	    a =3D=3D &dev_attr_source_link_caps_dsc.attr)
> +		caps =3D &connector->dp.source_link_caps;
> +	else if (a =3D=3D &dev_attr_sink_link_caps_nlanes.attr ||
> +		 a =3D=3D &dev_attr_sink_link_caps_link_rates.attr ||
> +		 a =3D=3D &dev_attr_sink_link_caps_dsc.attr)
> +		caps =3D &connector->dp.sink_link_caps;
> +	else
> +		caps =3D &connector->dp.cur_link_info;
> +
> +	/* Checking nlanes is enough to decide whether the attributes should
> +	 * be exposed: without lanes there is no working DisplayPort link
> +	 */
> +	return caps->nlanes ? a->mode : 0;
> +}

[Severity: Medium]
What prevents a data race on caps->nlanes in dp_link_attr_visible() when
sink capabilities or active link parameters are updated concurrently?

In drivers/gpu/drm/display/drm_dp_helper.c, drm_dp_sink_set_caps(),
drm_dp_set_cur_link_params(), and drm_dp_sink_reset_caps() modify
sink_link_caps.nlanes and cur_link_info.nlanes under connector->dp.mutex
and release that lock before drm_sysfs_connector_dp_link_update() acquires
connector->dp.sysfs_mutex:

drivers/gpu/drm/display/drm_dp_helper.c:drm_dp_sink_set_caps() {
	...
	scoped_guard(mutex, &connector->dp.mutex) {
		/* Only refresh the group when the visibility changes. */
		update =3D !connector->dp.sink_link_caps.nlanes !=3D !link_caps->nlanes;

		ret =3D drm_dp_copy_caps(&connector->dp.sink_link_caps, link_caps);
		if (ret)
			return ret;
	}

	if (update)
		drm_sysfs_connector_dp_link_update(connector);
	...
}

Meanwhile, dp_link_attr_visible() in drivers/gpu/drm/drm_sysfs.c reads
caps->nlanes without holding connector->dp.mutex during
sysfs_create_group(), sysfs_update_group(), or sysfs_group_change_owner().

If a writer modifies caps->nlanes on another processor while
create_files() in fs/sysfs/group.c iterates over connector_dp_link_attrs,
could dp_link_attr_visible() observe different values of caps->nlanes
across the three attributes in the same group, or cause a concurrent
sysfs_group_change_owner() call to see non-zero visibility before the
kernfs nodes are created?

> +
> +static const struct attribute_group connector_dp_link_group =3D {
> +	.name =3D "dp_link",
> +	.attrs =3D connector_dp_link_attrs,
> +	.is_visible =3D dp_link_attr_visible,
> +};
> +
> +/**
> + * drm_sysfs_connector_dp_link_update - Update the visibility of the DP =
link
> + *                                      attributes
> + * @connector: DisplayPort connector
> + */
> +void drm_sysfs_connector_dp_link_update(struct drm_connector *connector)
> +{
> +	int ret;
> +
> +	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_DisplayPort &&
> +	    connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP)
> +		return;
> +
> +	scoped_guard(mutex, &connector->dp.sysfs_mutex) {
> +		if (!connector->kdev)
> +			return;
> +
> +		ret =3D sysfs_update_group(&connector->kdev->kobj,
> +					 &connector_dp_link_group);
> +	}
> +	if (ret)
> +		drm_err(connector->dev,
> +			"failed to update DP link sysfs attributes: %d\n", ret);
> +}
> +EXPORT_SYMBOL_GPL(drm_sysfs_connector_dp_link_update);

[Severity: High]
Could drm_sysfs_connector_dp_link_update() race with
drm_sysfs_connector_remove() and trigger a use-after-free on
connector->kdev?

In drivers/gpu/drm/drm_sysfs.c, drm_sysfs_connector_dp_link_update()
checks connector->kdev and passes &connector->kdev->kobj to
sysfs_update_group() under connector->dp.sysfs_mutex, without holding
connector->mutex.

However, when drm_connector_unregister() calls
drm_sysfs_connector_remove(), connector->kdev is unregistered and freed
before connector->kdev is cleared and without taking
connector->dp.sysfs_mutex:

drivers/gpu/drm/drm_sysfs.c:drm_sysfs_connector_remove() {
	if (!connector->kdev)
		return;
	...
	device_unregister(connector->kdev);
	connector->kdev =3D NULL;
}

Since device_unregister(connector->kdev) calls device_del() and
put_device() (freeing connector->kdev via drm_sysfs_release()) before
clearing connector->kdev, wouldn't a concurrent call to
drm_sysfs_connector_dp_link_update() from drm_dp_sink_set_caps(),
drm_dp_sink_sync_caps(), drm_dp_set_cur_link_params(), or
drm_dp_sink_reset_caps() observe a non-null connector->kdev and
dereference &connector->kdev->kobj while or after it is freed?

> +
>  int drm_sysfs_connector_add(struct drm_connector *connector)
>  {
>  	struct drm_device *dev =3D connector->dev;
> @@ -376,6 +521,18 @@ int drm_sysfs_connector_add(struct drm_connector *co=
nnector)
> =20
>  	connector->kdev =3D kdev;
> =20
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +	    connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		scoped_guard(mutex, &connector->dp.sysfs_mutex)
> +			r =3D sysfs_create_group(&connector->kdev->kobj,
> +					       &connector_dp_link_group);
> +
> +		if (r) {
> +			drm_err(dev, "failed to create DP connector sysfs: %d\n", r);
> +			goto err_dp_sysfs;
> +		}
> +	}
> +
>  	if (dev_fwnode(kdev)) {
>  		r =3D component_add(kdev, &typec_connector_ops);
>  		if (r)
> @@ -384,6 +541,9 @@ int drm_sysfs_connector_add(struct drm_connector *con=
nector)
> =20
>  	return 0;
> =20
> +err_dp_sysfs:
> +	connector->kdev =3D NULL;
> +	device_del(kdev);
>  err_free:
>  	put_device(kdev);
>  	return r;

[Severity: High]
What happens if drm_sysfs_connector_dp_link_update() runs between
assigning connector->kdev =3D kdev and acquiring connector->dp.sysfs_mutex
in drm_sysfs_connector_add()?

In drivers/gpu/drm/drm_sysfs.c, drm_sysfs_connector_add() publishes
connector->kdev =3D kdev outside connector->dp.sysfs_mutex before calling
sysfs_create_group(&connector->kdev->kobj, &connector_dp_link_group).

If drm_sysfs_connector_dp_link_update() runs in that window (for example,
from a concurrent hotplug or detect worker), it acquires
connector->dp.sysfs_mutex first, sees a non-null connector->kdev, and
calls sysfs_update_group(). Because the dp_link directory does not exist
yet, internal_create_group() in fs/sysfs/group.c creates the dp_link
directory when source_link_caps.nlanes is non-zero.

When drm_sysfs_connector_add() then acquires connector->dp.sysfs_mutex
and calls sysfs_create_group(), kernfs_create_dir_ns() fails because the
directory already exists and triggers sysfs_warn_dup(). That jumps to
err_dp_sysfs, where connector->kdev is cleared and device_del(kdev) and
put_device(kdev) run outside connector->dp.sysfs_mutex, aborting
connector registration and leaving kdev teardown unsynchronized with
drm_sysfs_connector_dp_link_update().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-feat_link_=
cap-v4-0-a4f3f6e8cad9@bootlin.com?part=3D3
