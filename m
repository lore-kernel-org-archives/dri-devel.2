Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E760A2617
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaoM/Dk0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A918410E675;
	Thu, 19 Nov 2026 09:05:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2F110E675
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:05:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 259FB60F60;
 Thu, 19 Nov 2026 09:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16E91F000C4;
 Thu, 19 Nov 2026 09:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795079115;
 bh=yItuJl3iymVqaUiyn/bVkdF/eUQVQaDYoZTntV80HCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MaoM/Dk0S59Qy4kwP9famGF0nv5qIR00+gn+IVo8jYinQTHngsDRbxUgMu1cKNjUJ
 Vlsd/zW1+HMP1yG+wi7WZtglpqfErgaFdYSikixUD/Y3XI2RzmTi3/B1CXX8oGnRFN
 DZEJYW4oNfFzCl28ePeAW0lm0CBgqhF9gqPxxQFPDGcSuoyqXNJJ9/QxFPpxvxKGyS
 Yu79FwhzURn/WJct0jYa3fgfJlGP8864aFEsRURZ4OXud9yHTC4Exq64/bkq4+6+e7
 Mfvwkbfz0ZqZJ07xlhn85Pn0HIVsXxnZjoPSpDotpmq+5J2x2TX1CdCWpovueVUnMg
 Grj2R9RyhbvJg==
Message-ID: <sashiko-outbox-222782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 24/29] drm/msm/dp: enable MST on capable sinks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-24-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-24-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:05:15 +0000
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
- [High] drm/msm/dp: missing msm_dp_display_unprepare() on MST unplug
- [High] drm/msm/dp: msm_dp_bridge_detect() sets plugged=3Dtrue and blocks
  MST enablement
- [Medium] drm/msm/dp: unchecked set_mgr_state error in
  msm_dp_display_mst_enable()
- [Medium] drm/msm/dp: msm_dp_display_mode_valid() ignores info for
  dp->connector
- [Medium] drm/msm/dp: race on mst_active and plugged in
  msm_dp_bridge_detect()
--

commit cd4f05789938aa44aebbfa953a74a28b9b779975
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: enable MST on capable sinks

This commit enables MST mode on MST-capable sinks connected to
multi-stream DP controllers and updates the MST topology manager state on
HPD plug and unplug.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 17487a7900d00..7f5247cbae035 100644
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
Does ignoring the return value of msm_dp_mst_display_set_mgr_state() leave
msm_dp->mst_active set to true when drm_dp_mst_topology_mgr_set_mst()
fails?

If drm_dp_read_dpcd_caps(), drm_dp_add_mst_branch_device(), or the DPCD
write fails inside drm_dp_mst_topology_mgr_set_mst(), topology discovery is
not started, but mst_active remains true.  msm_dp_bridge_detect() then
reports the SST connector as disconnected while no MST connectors can be
probed, and msm_dp_irq_hpd_handle() routes HPD IRQs to an uninitialized
topology manager.

Also, can msm_dp_bridge_detect() race with msm_dp_hpd_plug_handle() on
dp->mst_active?

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
	if (dp->mst_active)
		return status;

	guard(mutex)(&priv->plugged_lock);
}

CPU0                                    CPU1
msm_dp_hpd_plug_handle()
  mutex_lock(&dp->plugged_lock)
  msm_dp_display_process_hpd_high()
                                        msm_dp_bridge_detect()
                                          if (dp->mst_active) /* false */
                                          mutex_lock(&priv->plugged_lock)
    msm_dp_display_mst_enable()
      msm_dp->mst_active =3D true
  dp->plugged =3D true
  mutex_unlock(&dp->plugged_lock)
                                          pm_runtime_resume_and_get(...)
                                            <-- proceeds while MST active

Because msm_dp_bridge_detect() does not recheck dp->mst_active after
acquiring priv->plugged_lock, it performs SST DPCD reads concurrently with
the active MST topology manager and leaks the runtime PM reference at end:
because priv->plugged is true.

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
With EDID updates skipped on the primary connector in MST mode, does
msm_dp_display_mode_valid() check an unpopulated display_info when called
from msm_dp_mst_connector_mode_valid()?

msm_dp_mst_connector_mode_valid() passes the MST port connector's
&connector->display_info as info, but msm_dp_display_mode_valid() ignores
info and reads &dp->connector->display_info:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_mode_valid() {
	...
	is_yuv_420 =3D drm_mode_is_420_only(&dp->connector->display_info, mode);
	...
	mode_bpp =3D dp->connector->display_info.bpc * num_components;
}

As a result, is_yuv_420 is always false and bpc is always 0 for MST
connectors, so YUV420-only modes are validated at twice their actual pixel
clock and link rate.  Similarly, msm_dp_needs_periph_flush() checks
&msm_dp_display->connector->display_info, so the peripheral flush bit for
VSC SDP packets is not set for MST YUV420 streams.

>  	msm_dp_link_process_request(dp->link);
> @@ -317,6 +347,9 @@ static int msm_dp_display_process_hpd_high(struct msm=
_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->link->link_caps, false);
> =20
> +	if (mst_mode =3D=3D DRM_DP_MST)
> +		msm_dp_display_mst_enable(dp);

[Severity: High]
Can msm_dp_bridge_detect() prevent msm_dp_display_mst_enable() from ever
running when an MST sink is connected at boot?

During initial connector probing, msm_dp_bridge_detect() runs while
dp->mst_active is still false and sets priv->plugged =3D true:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
	...
	status =3D connector_status_connected;
	priv->plugged =3D true;
}

When msm_dp_hpd_plug_handle() subsequently runs, it sees dp->plugged =3D=3D
true and returns early without calling msm_dp_display_process_hpd_high(),
leaving link_caps uninitialized and MST disabled until the cable is
physically replugged.

>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> =20
>  end:
> @@ -502,6 +535,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_di=
splay_private *dp)
>  						 dp->panel->dpcd,
>  						 dp->panel->downstream_ports);
> =20
> +	if (dp->msm_dp_display.mst_active) {
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
> +		dp->msm_dp_display.mst_active =3D false;
> +	}

[Severity: High]
Does unplugging an MST sink skip msm_dp_display_unprepare() and leave
msm_dp_display->link_ready stuck at true?

When MST streams are disabled while mst_active is true (such as on DPMS
off, when downstream monitors are unplugged from an MST hub first, or
before msm_dp_hpd_unplug_handle() clears mst_active),
msm_dp_mst_stream_post_disable() skips msm_dp_display_unprepare():

drivers/gpu/drm/msm/dp/dp_mst_drm.c:msm_dp_mst_stream_post_disable() {
	...
	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);

	if (!mst->msm_dp->mst_active)
		msm_dp_display_unprepare(mst->msm_dp);
}

Because msm_dp_hpd_unplug_handle() clears mst_active without calling
msm_dp_display_unprepare(), the runtime PM reference and link clocks from
msm_dp_display_prepare_link() are leaked, and link_ready remains true so
subsequent hotplug connections return early from
msm_dp_display_prepare_link() without initializing the PHY or training the
link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D24
