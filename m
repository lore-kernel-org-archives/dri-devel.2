Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57084606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ask09M8p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E77E112180;
	Thu, 19 Nov 2026 08:36:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C800112180
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:36:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3C2D611DA;
 Thu, 19 Nov 2026 08:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338A21F000C4;
 Thu, 19 Nov 2026 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795077402;
 bh=b+APG7jyeK4e/+t9tCUaBfi31ccnxhmQo20mqKtmCYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ask09M8pkFhmhLQt9BLSlbHVzHSvfnEkAY5rtoLdlP+EfAb98DWk74CUXKi7LgQyp
 X0C+P+1VN5NfwTja2qWmn3XvbmlSE23hWZ4dl3i3VvfahDZBDyTSXuZkfkoi3A3kcp
 Lhxify/YvyC+uR24Bmx03zOoKIRJhVYVEXdVkiEYA6cJqbQZNbQWZgFajexkPMgovP
 5AOFITP+djo0tGt3yec4mwTUMuU+g9ckOVdbs1DUXo1Y1+55TdN0Vak2R7YuhJP6so
 +nLLbJdBIR4gsxYsf9cTK09nz6XPd0ZLKsshbVySOOA3BNw9QpxavKyUBoP2u3B+fb
 duHwErE133Kjw==
Message-ID: <sashiko-outbox-222684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/29] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-11-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-11-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:36:41 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/msm/dp: uninitialized hw_revision in
  msm_dp_display_get_panel()
- [Medium] drm/msm/dp: devm_kzalloc leak and panel desync in
  msm_dp_display_get_panel()
--

commit 81d0774848cd7711009ffa760c18571f4cc9c705
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel

This commit adds msm_dp_ctrl_get_stream_cnt() and msm_dp_display_get_panel()
to allocate and initialize per-stream struct msm_dp_panel instances for DP
MST.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 544b76e2c6f6e..d3d798a1da1a9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -536,6 +536,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_displ=
ay_private *dp)
>  	return rc;
>  }
> =20
> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_disp=
lay,
> +					      enum msm_dp_stream_id stream_id)
> +{
> +	struct msm_dp_display_private *dp;
> +	struct msm_dp_panel *dp_panel;
> +
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> +
> +	if (stream_id >=3D msm_dp_ctrl_get_stream_cnt(dp->ctrl)) {
> +		DRM_ERROR("invalid stream_id %d\n", stream_id);
> +		return NULL;
> +	}
> +
> +	dp_panel =3D msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, d=
p->link,
> +				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
> +				    dp->pixel_base[stream_id]);

[Severity: Medium]
Does calling msm_dp_panel_get() here leak the devm_kzalloc() allocation on
&dp->msm_dp_display.pdev->dev across KMS component unbind/rebind or bind
failure?

msm_dp_panel_get() ties the allocation lifetime to the DP platform device,
whereas msm_dp_display_get_panel() is called during KMS component bind
(_dpu_kms_initialize_displayport() -> msm_dp_mst_attach_encoder()) with no
matching release when KMS unbinds.  Allocating separate panel instances
(including a second DP_STREAM_0 panel alongside dp->panel) also leaves
dp->panel->msm_dp_mode.out_fmt_is_yuv_420 out of sync with active MST stream
panels when checked by msm_dp_wide_bus_available().

> +
> +	if (IS_ERR(dp_panel)) {
> +		DRM_ERROR("failed to initialize panel\n");
> +		return NULL;
> +	}
> +
> +	dp_panel->stream_id =3D stream_id;
> +
> +	return dp_panel;
> +}

[Severity: Medium]
Does this leave dp_panel->hw_revision set to 0 on panels returned for MST
streams?

msm_dp_ctrl_reset() only populates panel->hw_revision on the SST dp->panel
instance, and msm_dp_display_get_panel() runs during KMS bind before
msm_dp_display_host_init() reads REG_DP_HW_VERSION.  When VSC SDP is enabled
or disabled on an MST stream (for example, YUV420 modes via
msm_dp_panel_timing_cfg() -> msm_dp_panel_setup_vsc_sdp_yuv_420()),
msm_dp_panel_update_sdp() checks:

drivers/gpu/drm/msm/dp/dp_panel.c:msm_dp_panel_update_sdp() {
	u32 hw_revision =3D panel->msm_dp_panel.hw_revision;

	if (hw_revision >=3D DP_HW_VERSION_1_0 &&
	    hw_revision < DP_HW_VERSION_1_2) {
		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3, UPDATE_SDP);
		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3, 0x0);
	}
}

With hw_revision left at 0, the MMSS_DP_SDP_CFG3 update pulse is skipped on
DP 1.0 and 1.1 controllers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D11
