Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD504606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsmYpsxa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E53711282E;
	Thu, 22 Oct 2026 17:04:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A26C10E452;
 Thu, 22 Oct 2026 17:03:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73C6C6022E;
 Thu, 22 Oct 2026 17:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E010E1F01825;
 Thu, 22 Oct 2026 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792688634;
 bh=G1xYxUlhmCIu9kcyxuPzDLjzrFfv8HjHjzqyRt2y6Z8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RsmYpsxarw2oh7iQdclzyjJ6Jju/PjhFQO/3fSKox7wAejqgKgOjZu4fJrRo45Fuv
 rML/c7ckFSUsRgo1ncEHQggZPqPoZ0embthtgsZ/SiHHuW1DtaHxlHyNP4gzfPIGBu
 OV0V29GeNS3l59g3wQEItjeIWt187R5wW//pN+ciIOu04AbOjQtQxUAounncEFTZV9
 U5MOYQ/vAOVXyyN8/SmGXcv/3psx9O1pX/Qj2pLtw9sDzjJwsVHLvtBRip3rxdCjmC
 l5r0Q+SiWeM9Sh5ifflHwfWjlVr6SHi8W5jRiw0HufwHIyjMN45z6DM4nyZtma4zVB
 6At2Jw6ikt+8Q==
Message-ID: <sashiko-outbox-181845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] drm/i915/display/dp: Use dp_connector helpers to
 expose link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261022-feat_link_cap-v4-5-a4f3f6e8cad9@bootlin.com>
References: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
 <20261022-feat_link_cap-v4-5-a4f3f6e8cad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:03:53 +0000
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
- [High] drm/i915/dp: UAF and panel resource leak on kmemdup_array() failur=
e in intel_dp_init_connector()
- [Medium] drm/i915/display/dp: missing cur_link_info update on fastboot st=
ate readout
- [Medium] drm/i915/dp: inaccurate source and sink lane count caps in sysfs
- [Medium] drm/i915/dp: intel_dp_report_link_train() reports wrong DSC stat=
e on MST
--

commit cf7507ada926b43d170f5de858f0ce21a02b59f4
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/i915/display/dp: Use dp_connector helpers to expose link training state

This commit wires up the DRM core DisplayPort sysfs helpers in the i915
driver to report source capabilities, sink capabilities, and active link
training parameters under dp_link/. It also stores the unclamped DPCD sink
rates in dpcd_sink_rates and num_dpcd_sink_rates so the raw sink rates can
be exposed to userspace.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index bbd76c0ff04b6..925d0ec939f55 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c

[ ... ]

> @@ -6141,6 +6150,20 @@ void intel_dp_dpcd_set_probe(struct intel_dp *inte=
l_dp, bool force_on_external)
>  			      intel_dp_needs_dpcd_probe(intel_dp, force_on_external));
>  }
> =20
> +static void intel_dp_set_sink_caps(struct intel_connector *connector,
> +				   struct intel_dp *intel_dp)
> +{
> +	struct drm_connector_dp_link_caps link_caps;
> +
> +	link_caps.nlanes =3D drm_dp_get_max_lane_count(intel_dp->dpcd,
> +						     intel_dp->lttpr_common_caps);
> +	link_caps.link_rates =3D intel_dp->dpcd_sink_rates;
> +	link_caps.nlink_rates =3D intel_dp->num_dpcd_sink_rates;
> +	link_caps.dsc =3D drm_dp_sink_supports_dsc(connector->dp.dsc_dpcd);
> +
> +	drm_dp_sink_set_caps(&connector->base, &link_caps);
> +}
> +
>  static int
>  intel_dp_detect(struct drm_connector *_connector,
>  		struct drm_modeset_acquire_ctx *ctx,

[ ... ]

> @@ -6243,6 +6268,8 @@ intel_dp_detect(struct drm_connector *_connector,
> =20
>  	intel_dp_print_rates(intel_dp);
> =20
> +	intel_dp_set_sink_caps(connector, intel_dp);
> +
>  	if (intel_dp->is_mst) {
>  		/*
>  		 * If we are in MST mode then this connector
> @@ -6990,11 +7017,14 @@ intel_dp_init_connector(struct intel_digital_port=
 *dig_port,
>  			struct intel_connector *connector)
>  {
>  	struct intel_display *display =3D to_intel_display(dig_port);
> +	struct drm_connector_dp_link_caps link_caps;
>  	struct intel_dp *intel_dp =3D &dig_port->dp;
>  	struct intel_encoder *encoder =3D &dig_port->base;
>  	struct drm_device *dev =3D encoder->base.dev;
>  	enum port port =3D encoder->port;
> +	int *rates;
>  	int type;
> +	int ret;
> =20
>  	if (drm_WARN(dev, dig_port->max_lanes < 1,
>  		     "Not enough lanes (%d) for DP on [ENCODER:%d:%s]\n",
> @@ -7069,6 +7099,27 @@ intel_dp_init_connector(struct intel_digital_port =
*dig_port,
>  	intel_dp_set_common_link_params(intel_dp);
>  	intel_dp_reset_link_params(intel_dp);
> =20
> +	rates =3D kmemdup_array(intel_dp->source_rates,
> +			      intel_dp->num_source_rates,
> +			      sizeof(*rates),
> +			      GFP_KERNEL);
> +	if (!rates) {
> +		intel_dp_aux_fini(intel_dp);
> +		goto fail;
> +	}

[Severity: High]
Can this error path cause a use-after-free of dig_port and leak panel
resources when kmemdup_array() fails on an eDP connector?

At this point in
drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_init_connector(),
intel_edp_init_connector() has already succeeded. For eDP,
intel_edp_init_connector() enables PPS VDD, initializes connector->panel,
and calls intel_pps_init_late() in
drivers/gpu/drm/i915/display/intel_pps.c, which schedules
intel_dp->pps.panel_vdd_work:

drivers/gpu/drm/i915/display/intel_dp.c:intel_edp_init_connector()
  intel_panel_init(connector, drm_edid);
  intel_edp_backlight_setup(intel_dp, connector);
  intel_edp_add_properties(intel_dp);
  intel_pps_init_late(intel_dp);
    edp_panel_vdd_schedule_off(intel_dp);

Jumping to fail only flushes display->power.domains.async_put_work and
cleans up the base DRM connector without cancelling panel_vdd_work or
tearing down the panel:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_init_connector()
fail:
	intel_display_power_flush_work(display);
	drm_connector_cleanup(&connector->base);

	return false;

When intel_dp_init_connector() returns false, callers such as
intel_ddi_init() in drivers/gpu/drm/i915/display/intel_ddi.c and
g4x_dp_init() in drivers/gpu/drm/i915/display/g4x_dp.c immediately free
connector and dig_port while dig_port->dp.pps.panel_vdd_work is still
queued on display->wq.unordered, and intel_dp->pps.vdd_wakeref along with
connector->panel resources (fixed_edid, fixed_modes, VBT panel data, and
backlight) are leaked.

Also, since drm_dp_source_set_caps() already duplicates
link_caps.link_rates internally via drm_dp_copy_caps() and its failure is
treated as non-fatal below, could link_caps.link_rates pass
intel_dp->source_rates directly (or treat the allocation failure as
non-fatal) instead of aborting connector init?

> +
> +	link_caps.nlanes =3D dig_port->max_lanes;
> +	link_caps.nlink_rates =3D intel_dp->num_source_rates;
> +	link_caps.link_rates =3D rates;
> +	link_caps.dsc =3D HAS_DSC(display);
> +
> +	ret =3D drm_dp_source_set_caps(&connector->base, &link_caps);

[Severity: Medium]
Should source and sink lane count capabilities account for VBT lane limits
and DP tunnel bandwidth allocation mode?

In drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_init_connector(),
intel_dp->source_rates is clamped to VBT limits by
intel_dp_set_source_rates(), but link_caps.nlanes uses raw
dig_port->max_lanes instead of intel_dp_max_source_lane_count(dig_port):

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_max_source_lane_count()
{
	int vbt_max_lanes =3D intel_bios_dp_max_lane_count(dig_port->base.devdata);
	int max_lanes =3D dig_port->max_lanes;

	if (vbt_max_lanes)
		max_lanes =3D min(max_lanes, vbt_max_lanes);

	return max_lanes;
}

Similarly, in
drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_set_sink_caps(),
link_caps.link_rates uses intel_dp->dpcd_sink_rates (populated via
drm_dp_read_dpcd_sink_rates() with intel_dp->tunnel), whereas
link_caps.nlanes calls drm_dp_get_max_lane_count(intel_dp->dpcd,
intel_dp->lttpr_common_caps) directly. When USB4/Thunderbolt DP tunnel
bandwidth allocation mode is active, intel_dp->dpcd[DP_MAX_LANE_COUNT] can
be masked by the tunnel, unlike max_dprx_lane_count(intel_dp) /
intel_dp->max_sink_lane_count which queries
drm_dp_tunnel_max_dprx_lane_count(intel_dp->tunnel).

Would using intel_dp_max_source_lane_count(dig_port) for source_link_caps
and intel_dp->max_sink_lane_count (or max_dprx_lane_count(intel_dp)) for
sink_link_caps report more accurate lane counts in dp_link/ sysfs?

> +	if (ret)
> +		drm_dbg_kms(display->drm,
> +			    "failed to set source link rates, skipping.\n");
> +
> +	kfree(rates);
> +
>  	/* init MST on ports that can support it */
>  	intel_dp_mst_encoder_init(dig_port, connector->base.base.id);
> =20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index cb92cff906146..c77cb124f1419 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -1758,6 +1758,18 @@ static void link_recovery_reset(struct intel_dp_li=
nk_training *link_training)
>  	link_training->recovery_state =3D INTEL_DP_LINK_RECOVERY_IDLE;
>  }
> =20
> +static void intel_dp_report_link_train(struct intel_dp *intel_dp)
> +{
> +	struct intel_connector *connector =3D intel_dp->attached_connector;
> +
> +	if (!connector)
> +		return;
> +
> +	drm_dp_set_cur_link_params(&connector->base, intel_dp->link_rate,
> +				   intel_dp->lane_count,
> +				   connector->dp.dsc_decompression_enabled);
> +}

[Severity: Medium]
How is cur_link_info_dsc supposed to behave when DisplayPort MST is
enabled?

In MST mode,
drivers/gpu/drm/i915/display/intel_dp_mst.c:mst_stream_pre_enable() enables
DSC decompression on the dynamic MST stream connector rather than on
intel_dp->attached_connector, and only calls primary_encoder->pre_enable()
(which reaches intel_dp_stop_link_train()) for the first stream:

drivers/gpu/drm/i915/display/intel_dp_mst.c:mst_stream_pre_enable()
	intel_dp_sink_enable_decompression(state, connector, pipe_config);

	if (first_mst_stream) {
		primary_encoder->pre_enable(state, primary_encoder,
					    pipe_config, NULL);

Meanwhile, primary_encoder->pre_enable() skips
intel_dp_sink_enable_decompression() when is_mst is true, so
intel_dp->attached_connector->dp.dsc_decompression_enabled remains false.

As a result, in
drivers/gpu/drm/i915/display/intel_dp_link_training.c:intel_dp_report_link_=
train(),
connector->dp.dsc_decompression_enabled is always false for MST links,
while the root intel_dp->attached_connector is marked
connector_status_disconnected in
drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_detect() and the active
MST stream connectors have unpopulated dp_link/ sysfs attributes.

> +
>  /**
>   * intel_dp_stop_link_train - stop link training
>   * @intel_dp: DP struct
> @@ -1787,6 +1799,8 @@ void intel_dp_stop_link_train(struct intel_dp *inte=
l_dp,
>  	intel_dp_program_link_training_pattern(intel_dp, crtc_state, DP_PHY_DPR=
X,
>  					       DP_TRAINING_PATTERN_DISABLE);
> =20
> +	intel_dp_report_link_train(intel_dp);

[Severity: Medium]
What happens to cur_link_info when an active DP or eDP link is inherited
from firmware via fastboot without a full modeset?

During driver probe or resume, hardware state readout runs
intel_modeset_setup_hw_state() -> intel_modeset_readout_hw_state(), which
calls intel_dp_sync_state() and intel_dp_connector_sync_state() in
drivers/gpu/drm/i915/display/intel_dp.c:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_sync_state()
	if (crtc_state) {
		intel_dp_reset_link_params(intel_dp);
		intel_dp_set_link_params(intel_dp, crtc_state->port_clock, crtc_state->la=
ne_count);
		intel_dp->link.active =3D true;
	}

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_connector_sync_state()
	if (crtc_state && crtc_state->dsc.compression_enable) {
		drm_WARN_ON(display->drm,
			    !connector->dp.dsc_decompression_aux);
		connector->dp.dsc_decompression_enabled =3D true;
	} else {
		connector->dp.dsc_decompression_enabled =3D false;
	}

When subsequent commits take the fastset path instead of a full modeset,
intel_dp_stop_link_train() in
drivers/gpu/drm/i915/display/intel_dp_link_training.c is never called.
Consequently, drm_dp_set_cur_link_params() is never invoked, leaving
connector->dp.cur_link_info.nlanes at 0 and hiding the cur_link_info_*
sysfs attributes on an active display.

Should drm_dp_set_cur_link_params() also be called during hardware state
readout when crtc_state is active?

> +
>  	if (intel_dp_is_uhbr(crtc_state)) {
>  		ret =3D poll_timeout_us(ret =3D intel_dp_128b132b_intra_hop(intel_dp, =
crtc_state),
>  				      ret =3D=3D 0,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-feat_link_=
cap-v4-0-a4f3f6e8cad9@bootlin.com?part=3D5
