Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19F9CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEDE10F632;
	Fri, 19 Jun 2026 14:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nTAtYs6D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D1710F632
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:23:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BFA743BC9;
 Fri, 19 Jun 2026 14:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A58F1F000E9;
 Fri, 19 Jun 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781878985;
 bh=ZYNrsltmEgRU/lcRFhxxZsR4jeneqoVF93AoyxyGSIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nTAtYs6D1fsQCh3286XqJZr9UGLm7ZKExcTvXXnHvur/f8NVbtSh7uA5ZFxM1sIvS
 AP1VofkewXZNqNoWC5r915KKXqE7GWVAODZjmgRtNdXd7Hc1pMJu591dHjHtMCfD7r
 /eSrKTfFO9kphGrt8nVdr7hdcsjJlW9APmNkzA53CFRPeacbb4ZagaxVCbtpNE1s/k
 pnE8ecMNWguwzJUo6/kuENGQs4g0mPmQc2VGYfgJViJkLro18kgndislJRfvY3rOkO
 Hqia1AjyfildZlBcpH9iqsmA8TTOcP1nGh/1AyGsuOwUik+T2w+WyvcmlruIFTmlBa
 AG15jNEevH7tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 1/4] drm: Introduce DisplayPort connector helpers
 with link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619-feat_link_cap-v2-1-a3dec4c02ad9@bootlin.com>
References: <20260619-feat_link_cap-v2-0-a3dec4c02ad9@bootlin.com>
 <20260619-feat_link_cap-v2-1-a3dec4c02ad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 14:23:04 +0000
Message-Id: <20260619142305.1A58F1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Unconditional read of DP 1.3 Extended Receiver Capability space br=
eaks capability detection on legacy DP sinks.
- [High] Incorrect use of `devm_kmemdup_array` binds memory to the physical=
 device, causing memory leaks for dynamic connectors.
- [High] Incorrect assignment of `sink_dsc_caps` uses the return value of t=
he DPCD read instead of the actual data read.
- [High] Missing `drm_connector_cleanup` on error paths leaves partially in=
itialized connectors on global DRM lists.
- [High] Dangling pointer `connector->kdev` in `drm_sysfs_connector_add` le=
ads to UAF if sysfs group creation fails.
- [High] Raw AUX reads of base DPCD registers bypass DP 1.3+ Extended Recei=
ver Capability overrides.
- [Medium] Sysfs scalar attributes return an empty file (EOF) instead of '0=
' for valid zero values.
- [Medium] Unconditional sysfs group creation litters existing DP drivers w=
ith empty files.
- [Medium] Dangerous unit mismatch for max_link_rate causes 10x value scali=
ng errors in sysfs.
--

commit 9797fc077ec92710d6cc77dd41b9fa876502ade2
Author: Kory Maincent <kory.maincent@bootlin.com>
Subject: drm: Introduce DisplayPort connector helpers with link training st=
ate

This commit adds managed and unmanaged DisplayPort connector initialization
helpers to expose link training capabilities and state to userspace via
sysfs attributes under dp_link.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index a697cc227e289..4603efa46d912 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -4867,3 +4867,147 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, =
int max_lanes)
[ ... ]
> +static int drm_dp_dpcd_read_link_rate_caps(struct drm_dp_aux *aux)
> +{
> +	u8 data;
> +	int ret;
> +
> +	ret =3D drm_dp_dpcd_read_byte(aux, DP_DP13_DPCD_REV + DP_MAIN_LINK_CHAN=
NEL_CODING, &data);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
Does this unconditional read break capability detection on older sinks?

Legacy sinks (DP 1.2 and earlier) do not implement the 0x2200 register space
and typically NACK AUX reads to unimplemented addresses. If this returns an
error, will it abort drm_dp_sink_set_link_caps() and leave capabilities
uninitialized for legacy hardware?

[ ... ]
> +void drm_dp_sink_set_link_caps(struct drm_connector *connector,
> +			       struct drm_dp_aux *aux)
> +{
> +	u32 lane_count, link_rate;
> +	u8 data;
> +	int ret;
> +
> +	if (!connector)
> +		return;
> +
> +	WARN_ON(!drm_modeset_is_locked(&connector->dev->mode_config.connection_=
mutex));
> +
> +	ret =3D drm_dp_dpcd_read_byte(aux, DP_MAX_LANE_COUNT, &data);

[Severity: High]
Does this raw AUX read miss DP 1.3+ Extended Receiver Capability overrides?

For DP 1.3+ sinks with the DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit set,
these base DPCD registers are overridden by values at 0x2200-0x220F. By
bypassing drm_dp_read_dpcd_caps() which handles patching these overrides,
will this report legacy capabilities for modern DP 1.4+ sinks?

> +	if (ret < 0)
> +		return;
> +
> +	lane_count =3D data & DP_MAX_LANE_COUNT_MASK;
> +
> +	ret =3D drm_dp_dpcd_read_link_rate_caps(aux);
> +	if (ret < 0)
> +		return;
> +
> +	link_rate =3D ret;
> +
> +	ret =3D drm_dp_dpcd_read_byte(aux, DP_DSC_SUPPORT, &data);
> +	if (ret < 0)
> +		return;
> +
> +	connector->dp.sink_max_lane_count_caps =3D lane_count;
> +	connector->dp.sink_max_link_rate_caps =3D link_rate;
> +	connector->dp.sink_dsc_caps =3D ret & DP_DSC_DECOMPRESSION_IS_SUPPORTED;

[Severity: High]
Is the wrong variable used for this assignment?

The assignment uses the return code ret instead of the payload variable
data. Since the return code is 1 on success, and
DP_DSC_DECOMPRESSION_IS_SUPPORTED is also 1, will this always evaluate
to true for any sink that acknowledges the DPCD read, regardless of actual
DSC support?

> +}
> +EXPORT_SYMBOL_GPL(drm_dp_sink_set_link_caps);
[ ... ]
> +void drm_dp_set_max_link_params(struct drm_connector *connector, u32 lin=
k_rate,
> +				u32 lane_count)
> +{
> +	if (!connector)
> +		return;
> +
> +	WARN_ON(!drm_modeset_is_locked(&connector->dev->mode_config.connection_=
mutex));
> +
> +	connector->dp.max_link_rate =3D link_rate;
> +	connector->dp.max_lane_count =3D lane_count;

[Severity: Medium]
Is there a unit conversion mismatch here?

Unlike drm_dp_set_cur_link_params() which converts deca-kbps to kbps by
multiplying by 10, this assigns link_rate directly to max_link_rate without
conversion. Since both are exposed via sysfs, will max_link_rate be present=
ed
10x smaller than the actual rate?

> +}
> +EXPORT_SYMBOL_GPL(drm_dp_set_max_link_params);
> +
> +/**
> + * drm_dp_sink_reset_link_caps - Reset DisplayPort sink capabilities
> + * @connector: DisplayPort connector
> + *
> + * This function resets all DisplayPort sink link capabilities and param=
eters
> + * to their default state. This should be called when a sink is disconne=
cted
> + * to clear stale capability information.
> + */
> +void drm_dp_sink_reset_link_caps(struct drm_connector *connector)
> +{
> +	if (!connector)
> +		return;
> +
> +	WARN_ON(!drm_modeset_is_locked(&connector->dev->mode_config.connection_=
mutex));
> +
> +	drm_dp_set_cur_link_params(connector, 0, 0, false);
> +	drm_dp_set_max_link_params(connector, 0, 0);
> +	connector->dp.sink_max_link_rate_caps =3D 0;
> +	connector->dp.sink_max_lane_count_caps =3D 0;
> +	connector->dp.sink_dsc_caps =3D false;
> +}
> +EXPORT_SYMBOL_GPL(drm_dp_sink_reset_link_caps);
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 47dc53c4a738f..aac99fbb44804 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -489,6 +489,128 @@ int drm_connector_init_with_ddc(struct drm_device *=
dev,
>  }
>  EXPORT_SYMBOL(drm_connector_init_with_ddc);
> =20
> +static int drm_dp_source_set_link_caps(struct drm_connector *connector,
> +				       const struct drm_connector_dp_link_caps *link_caps)
> +{
> +	u32 *_link_rates;
> +
> +	_link_rates =3D devm_kmemdup_array(connector->dev->dev,
> +					 link_caps->link_rates,
> +					 link_caps->nlink_rates,
> +					 sizeof(*link_caps->link_rates),
> +					 GFP_KERNEL);

[Severity: High]
Can this allocation leak memory for dynamically plugged connectors?

By using devm_kmemdup_array() tied to the physical device
(connector->dev->dev), the memory is bound to the GPU driver's lifecycle.
Since connectors like MST can be hot-plugged and destroyed independently,
will this leak the array on every plug/unplug cycle until the entire GPU
driver unbinds?

> +	if (!_link_rates)
> +		return -ENOMEM;
[ ... ]
> +int drm_connector_dp_init_with_ddc(struct drm_device *dev,
> +				   struct drm_connector *connector,
> +				   const struct drm_connector_funcs *funcs,
> +				   const struct drm_connector_dp_link_caps *dp_link_caps,
> +				   int connector_type,
> +				   struct i2c_adapter *ddc)
> +{
> +	int ret;
> +
> +	if (!(connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +	      connector_type =3D=3D DRM_MODE_CONNECTOR_eDP))
> +		return -EINVAL;
> +
> +	if (!dp_link_caps)
> +		return -EINVAL;
> +
> +	ret =3D drm_connector_init_with_ddc(dev, connector, funcs, connector_ty=
pe, ddc);
> +	if (ret)
> +		return ret;
> +
> +	return drm_dp_source_set_link_caps(connector, dp_link_caps);

[Severity: High]
Does this error path leave a partially initialized connector on the global =
DRM
lists?

If drm_connector_init_with_ddc() succeeds, it adds the connector to the
DRM device's lists. If drm_dp_source_set_link_caps() then fails, the error
is returned directly without calling drm_connector_cleanup().

Will the caller perceive this as a failure and free the structure, leaving
a dangling pointer in dev->mode_config.connector_list?

> +}
> +EXPORT_SYMBOL(drm_connector_dp_init_with_ddc);
> +
>  static void drm_connector_cleanup_action(struct drm_device *dev,
>  					 void *ptr)
>  {
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a87284..653fecf23d717 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -340,6 +340,95 @@ static const struct attribute_group *connector_dev_g=
roups[] =3D {
[ ... ]
> +#define DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE(_name) \
> +static ssize_t _name##_show(struct device *device, \
> +			    struct device_attribute *attr, \
> +			    char *buf) \
> +{ \
> +	struct drm_connector *connector =3D to_drm_connector(device); \
> +	int ret; \
> +	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL); \
> +	if (!connector->dp._name) { \
> +		drm_modeset_unlock(&connector->dev->mode_config.connection_mutex); \
> +		return 0; \
> +	} \

[Severity: Medium]
Will this return an empty file (EOF) when the property evaluates to false
or 0?

By returning 0 from the sysfs show callback here, userspace will read 0 byt=
es
rather than seeing "0\n". Since 0 and false are valid states for properties
like dsc_en and cur_link_rate, will this prevent userspace from correctly
parsing them?

> +	ret =3D sysfs_emit(buf, "%d\n", connector->dp._name); \
> +	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex); \
> +	return ret; \
> +}
[ ... ]
> @@ -376,6 +465,15 @@ int drm_sysfs_connector_add(struct drm_connector *co=
nnector)
> =20
>  	connector->kdev =3D kdev;
> =20
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +	    connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		r =3D sysfs_create_group(&connector->kdev->kobj, &connector_dp_link_gr=
oup);

[Severity: Medium]
Does this unconditionally expose empty sysfs files for existing DP drivers?

For drivers that have not migrated to use the new drm_connector_dp_init*
helpers, the dp capability struct remains zero-initialized. Will this create
a dp_link directory populated with useless, empty files on all legacy syste=
ms?

> +		if (r) {
> +			drm_err(dev, "failed to create DP connector sysfs: %d\n", r);
> +			goto err_dp_sysfs;
> +		}
> +	}
> +
>  	if (dev_fwnode(kdev)) {
>  		r =3D component_add(kdev, &typec_connector_ops);
>  		if (r)
> @@ -384,6 +482,8 @@ int drm_sysfs_connector_add(struct drm_connector *con=
nector)
> =20
>  	return 0;
> =20
> +err_dp_sysfs:
> +	device_del(kdev);

[Severity: High]
Does this leave a dangling pointer in connector->kdev?

If sysfs_create_group() fails, the code jumps to err_dp_sysfs which
deletes kdev, but connector->kdev is never reset to NULL. When
drm_sysfs_connector_remove() is called later, could it dereference the
freed pointer?

>  err_free:
>  	put_device(kdev);
>  	return r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-feat_link_=
cap-v2-0-a3dec4c02ad9@bootlin.com?part=3D1
