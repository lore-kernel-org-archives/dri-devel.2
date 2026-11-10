Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FA606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGUZlHYF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AE810EB86;
	Tue, 10 Nov 2026 05:23:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CED10EB86
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:23:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA83F41082;
 Tue, 10 Nov 2026 05:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231351F008A3;
 Tue, 10 Nov 2026 05:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288195;
 bh=EQibALfxEgSvYLrJKxMFZv1C0UsRXbO+LwsNQUPU7Ic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SGUZlHYFXcOBOmeLGaFdRl2msU4lgXacqomSCmBSpCGPCOrLeaTU+StDjO5RGqnFQ
 jEAYeGzJKD7qZJW6ozE1Cxy0wk+K3YMvke06pKenVrd7+u6Q9wbWD4R+QXg8gvIrjS
 4Vb9Gq3Rvwpdf0UBsDLt27XZwRqOQbIw+Hib2Kar8H1fhaTMQuejEs3VKYWf9xyZjF
 7VsbZY7SEs52X8FXkzkUKRWDJc3vhZyk+uujBgUFjEFcW+1Oclg2t3aye85sav61Mt
 B4OkIU0/izXUHJW0B2x99Ca/cywsZybV7yih003nUJWAUfkcyV/xxpLl/elxf73ZKk
 gdbvPinNtW+/g==
Message-ID: <sashiko-outbox-206281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/29] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-11-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-11-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:23:14 +0000
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
- [Medium] drm/msm/dp: devm_kzalloc leak and panel state desync in
  msm_dp_display_get_panel()
--

commit 925ddc6c6313feca1fc26113de74e6f96e91e020
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel

This commit adds msm_dp_display_get_panel() and msm_dp_ctrl_get_stream_cnt()
so the DP MST module can initialize and obtain a struct msm_dp_panel for a
given stream ID.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6a522cc71a2ac..fa027659a079f 100644
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
Does calling msm_dp_panel_get() here leak struct msm_dp_panel_private across
KMS component unbind and rebind cycles?

msm_dp_panel_get() allocates the panel with devm_kzalloc() on the DP platfo=
rm
device (&dp->msm_dp_display.pdev->dev), while MST initialization calls
msm_dp_display_get_panel() during KMS component bind and has no correspondi=
ng
release on KMS unbind. Rebinding the KMS component while the DP platform
device stays bound allocates another set of panels on the platform device.

Allocating separate panel instances (including a second panel for
DP_STREAM_0 alongside dp->panel) also leaves dp->panel state such as
msm_dp_mode.out_fmt_is_yuv_420 out of sync when queried through
msm_dp_wide_bus_available().

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
Does this leave dp_panel->hw_revision uninitialized at 0 for panels returned
by msm_dp_display_get_panel()?

msm_dp_ctrl_reset() only populates panel->hw_revision on the SST dp->panel
instance, after msm_dp_display_get_panel() has already allocated separate
per-stream panels:

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_reset() {
    ...
	if (!ctrl->hw_revision)
		ctrl->hw_revision =3D msm_dp_read_ahb(ctrl, REG_DP_HW_VERSION);
	panel->hw_revision =3D ctrl->hw_revision;
    ...
}

When VSC SDP is enabled or disabled on an MST stream (for example, for YUV4=
20
modes), msm_dp_panel_update_sdp() checks whether hw_revision is between
DP_HW_VERSION_1_0 and DP_HW_VERSION_1_2 before writing MMSS_DP_SDP_CFG3, so
that SDP flush write is skipped on DP 1.0 and 1.1 controllers. Even after
commit "drm/msm/dp: move link capabilities to dp_link" moves link
capabilities to struct msm_dp_link, hw_revision remains in struct
msm_dp_panel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D11
