Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E63606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeMvbE/D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD2A10EDD9;
	Tue, 10 Nov 2026 05:42:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622DE10EDD9
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:41:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A050A6142A;
 Tue, 10 Nov 2026 05:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8241F008A1;
 Tue, 10 Nov 2026 05:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794289315;
 bh=TDBfV6e3Q+yi0aHILN3z3zDVT4vv0AWCv3ZQ9z5zlro=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LeMvbE/DdNYXLNSYbVhxIzAB6f7MqRfRK5SBz/RkAaqfD49iPVSvQNOQNkpNYEVo9
 IHIxxLxa6DpA4EK4Z/Tr/6e/yqEVfJu4FdmW+VtMCgbCQ2jgflQaoE5hq2O04nbdhv
 Ewd89YLQ/ZHlnot4z1rBvnovziKzIDpL9I0LL9ZNTdHU9Q/gA2E3ijfZfOAO/QAFR3
 GEvbd9qRjHUKX9UiMoMN77IMUfSvV3432PjVKk5mMm0wW5y77PI4I/X/68Htv3Mzi/
 B+UHcwciILqUXUG/mzRhg4kPmxlw8ci6TykEZavCFVPk0208y/aioBVMdjYNsXgFEU
 GgCfAcJhrzfDw==
Message-ID: <sashiko-outbox-206327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/29] drm/msm/dp: enable MST on capable sinks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-24-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-24-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:41:54 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/msm/dp: missing msm_dp_display_unprepare() on MST unplug
  leaks link state
- [High] drm/msm/dp: msm_dp_bridge_detect() sets plugged=3Dtrue and blocks
  MST enablement
- [Medium] drm/msm/dp: msm_dp_display_mode_valid() ignores info for
  dp->connector
- [Medium] drm/msm/dp: race on mst_active and plugged in
  msm_dp_bridge_detect()
--

commit 528430aaec68343e6d71d11efbbb0165c741ffc9
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: enable MST on capable sinks

This commit enables MST on capable DP sinks when connected to a multi-stream
controller, skips reading the primary connector's EDID in MST mode, and
toggles the MST topology manager state on HPD connect and disconnect.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index f87eea19c4f58..eeb0e04949000 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -270,10 +271,34 @@ static int msm_dp_display_lttpr_init(struct msm_dp_=
display_private *dp, u8 *dpcd
>  	return lttpr_count;
>  }
> =20
> +static void msm_dp_display_mst_enable(struct msm_dp_display_private *dp)
> +{
> +	struct msm_dp *msm_dp =3D &dp->msm_dp_display;
> +	int ret;
> +
> +	/* Clear any pre-existing MST state before enabling MST. */
> +	ret =3D drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=3D%d\n", ret);
> +		return;
> +	}
> +
> +	ret =3D drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
> +	if (ret < 0) {
> +		DRM_ERROR("sink MST enablement failed\n");
> +		return;
> +	}
> +
> +	msm_dp->mst_active =3D true;
> +	msm_dp_mst_display_set_mgr_state(msm_dp, true);
> +}

[Severity: Medium]
Can msm_dp_bridge_detect() race with msm_dp_hpd_plug_handle() on
dp->mst_active?

msm_dp_hpd_plug_handle() holds dp->plugged_lock across several AUX
transactions in msm_dp_display_process_hpd_high() before
msm_dp_display_mst_enable() sets msm_dp->mst_active =3D true, whereas
msm_dp_bridge_detect() checks dp->mst_active only before acquiring
priv->plugged_lock:

CPU0                                  CPU1
msm_dp_hpd_plug_handle()
  mutex_lock(&dp->plugged_lock)
  msm_dp_display_process_hpd_high()
                                      msm_dp_bridge_detect()
                                        if (dp->mst_active) // false
                                        mutex_lock(&priv->plugged_lock)
    msm_dp_display_mst_enable()
      msm_dp->mst_active =3D true
      msm_dp_mst_display_set_mgr_state(..., true)
  dp->plugged =3D true
  mutex_unlock(&dp->plugged_lock)
                                        pm_runtime_resume_and_get(...)
                                        drm_dp_read_dpcd_caps(...)
                                          <-- runs SST probe while MST is
                                              active and leaks runtime PM r=
ef

Once CPU0 releases plugged_lock, CPU1 proceeds without rechecking
dp->mst_active, performs SST AUX reads concurrently with the active MST
topology manager, and leaves an extra runtime PM reference from
pm_runtime_resume_and_get() unbalanced because priv->plugged is true at the
end label.  If one of those AUX reads fails transiently, CPU1 also resets
priv->plugged =3D false and drops runtime PM while MST is active.

Rechecking dp->mst_active after acquiring priv->plugged_lock in
msm_dp_bridge_detect() would avoid this race.

>  static int msm_dp_display_process_hpd_high(struct msm_dp_display_private=
 *dp)
>  {
>  	struct drm_connector *connector =3D dp->msm_dp_display.connector;
>  	const struct drm_display_info *info =3D &connector->display_info;
> +	enum drm_dp_mst_mode mst_mode =3D DRM_DP_SST;
>  	int rc =3D 0;
>  	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>  	const struct drm_edid *drm_edid =3D NULL;
> @@ -288,14 +313,19 @@ static int msm_dp_display_process_hpd_high(struct m=
sm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
> =20
> -	drm_edid =3D drm_edid_read_ddc(connector, &dp->aux->ddc);
> -	drm_edid_connector_update(connector, drm_edid);
> +	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) > 1)
> +		mst_mode =3D drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd);
> =20
> -	if (!drm_edid) {
> -		DRM_ERROR("panel edid read failed\n");
> -		/* check edid read fail is due to unplug */
> -		if (!msm_dp_aux_is_link_connected(dp->aux))
> -			return -ETIMEDOUT;
> +	if (mst_mode !=3D DRM_DP_MST) {
> +		drm_edid =3D drm_edid_read_ddc(connector, &dp->aux->ddc);
> +		drm_edid_connector_update(connector, drm_edid);
> +
> +		if (!drm_edid) {
> +			DRM_ERROR("panel edid read failed\n");
> +			/* check edid read fail is due to unplug */
> +			if (!msm_dp_aux_is_link_connected(dp->aux))
> +				return -ETIMEDOUT;
> +		}
>  	}

[Severity: Medium]
When mst_mode =3D=3D DRM_DP_MST skips updating the primary connector's EDID,
does msm_dp_display_mode_valid() read an unpopulated display_info?

In MST mode, each downstream connector populates its own display_info in
msm_dp_mst_connector_get_modes() and passes it as the info argument to
msm_dp_display_mode_valid().  However, msm_dp_display_mode_valid() ignores
info and reads dp->connector->display_info instead:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_mode_valid() {
	...
	is_yuv_420 =3D drm_mode_is_420_only(&dp->connector->display_info, mode);
	...
	mode_bpp =3D dp->connector->display_info.bpc * num_components;
}

Because dp->connector->display_info is never populated for MST, is_yuv_420
is always false (validating 420-only modes at twice their actual pixel and
link clock, or failing to reject them when VSC SDP is unsupported) and bpc
is always 0.  Similarly, msm_dp_needs_periph_flush() checks
drm_mode_is_420_only(&msm_dp_display->connector->display_info, mode) on the
unpopulated primary connector and never flushes VSC SDP packets for MST
YUV420 streams.

>  	msm_dp_link_process_request(dp->link);
> @@ -317,6 +347,9 @@ static int msm_dp_display_process_hpd_high(struct msm=
_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->link->link_caps, false);
> =20
> +	if (mst_mode =3D=3D DRM_DP_MST)
> +		msm_dp_display_mst_enable(dp);
> +
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> =20
>  end:

[Severity: High]
If an MST sink is connected at boot and msm_dp_bridge_detect() runs before
msm_dp_hpd_plug_handle(), will msm_dp_display_mst_enable() ever be called?

During initial connector probing (for example via drm_client_setup()),
msm_dp_bridge_detect() runs while dp->mst_active is still false and sets
priv->plugged =3D true:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
	...
	status =3D connector_status_connected;
	priv->plugged =3D true;
}

When the HPD thread subsequently runs msm_dp_hpd_plug_handle(), it sees
dp->plugged =3D=3D true and returns 0 without calling
msm_dp_display_process_hpd_high():

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_hpd_plug_handle() {
	...
	guard(mutex)(&dp->plugged_lock);

	if (dp->plugged)
		return 0;

	...
	ret =3D msm_dp_display_process_hpd_high(dp);
}

As a result, msm_dp_panel_read_link_caps() and msm_dp_display_mst_enable()
never run, leaving link capabilities uninitialized and MST disabled until
the cable is physically replugged (even with the later patch in this series,
commit "drm/msm/dp: mark the SST bridge disconnected when an MST-capable
sink is present", which leaves priv->plugged =3D true in
msm_dp_bridge_detect()).

> @@ -502,6 +535,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_di=
splay_private *dp)
>  						 dp->panel->dpcd,
>  						 dp->panel->downstream_ports);
> =20
> +	if (dp->msm_dp_display.mst_active) {
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
> +		dp->msm_dp_display.mst_active =3D false;
> +	}
> +
>  	/* signal the disconnect event early to ensure proper teardown */
>  	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);

[Severity: High]
Does unplugging an MST sink skip msm_dp_display_unprepare() and leave
link_ready stuck at true?

When an MST stream is enabled, msm_dp_mst_stream_enable() calls
msm_dp_display_prepare_link(), which acquires a runtime PM reference,
initializes the PHY, trains the link, and sets link_ready =3D true.  When a=
ll
MST streams are later disabled (for example during DPMS off, or when
downstream monitors are unplugged from an MST hub before the hub itself is
unplugged), msm_dp_mst_stream_post_disable() skips
msm_dp_display_unprepare() because mst_active is still true:

drivers/gpu/drm/msm/dp/dp_mst_drm.c:msm_dp_mst_stream_post_disable() {
	...
	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);

	if (!mst->msm_dp->mst_active)
		msm_dp_display_unprepare(mst->msm_dp);
}

When the MST sink is then unplugged, msm_dp_hpd_unplug_handle() clears
mst_active without calling msm_dp_display_unprepare() (and even if streams
are torn down concurrently with unplug, msm_dp_mst_display_set_mgr_state()
is called before mst_active is set to false and without mst_lock, so
msm_dp_mst_stream_post_disable() can still observe mst_active =3D=3D true).
This leaks the runtime PM reference and leaves the DP link clocks on, the
PHY initialized, and link_ready set to true, causing subsequent hotplug
connections to return early from msm_dp_display_prepare_link() without PHY
initialization or link training.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D24
