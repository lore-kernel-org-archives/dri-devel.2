Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F21606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwrMyqBR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2740D1121B5;
	Thu, 19 Nov 2026 08:51:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B2C1121B5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:51:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4F0345EF9;
 Thu, 19 Nov 2026 08:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E2B1F000C4;
 Thu, 19 Nov 2026 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078282;
 bh=tGdXedpMISZQ+EuUN5b13Gq1aEzns3LJXvK+Cfw0Sv8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SwrMyqBRMOnym53/tmbx27uKpYrbnOM7R6fOQFqtAF+cndwVlCilrGLZ/Unbbs6+8
 vdp/PXTKxUnfBMfvvwL4F7Ucss7Lz3OSKUYa0O5aiub811qIY9kZM5H1gIpkNrEG6p
 Xm+/+OEXeJ6s5LK6O7PqzqVxmgeokO3RWIb8uzRKRwCAJaKtm82KMWJJdf2+bKNhyt
 8StB6gv6+49uiS+pMQ8a5styNoh86jvLX/Xxz3qCGo8feCuf9cfyVaCPFus4oi7Qh2
 IRjm2+BqilOjXcZFKEnx2xh1Y2yJ3l01aG+AeD5KIDuGr3IMT9kISnJ48gVTnoTWvd
 FkKHC1Up9VY2A==
Message-ID: <sashiko-outbox-222730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/29] drm/msm/dpu: add per-stream MST encoders
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-16-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-16-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:51:22 +0000
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
- [High] drm/msm/dpu: KMS init failure on SC8180X in
  _dpu_kms_initialize_displayport()
- [Medium] drm/msm/dp: devres leak of msm_dp_panel in
  msm_dp_mst_attach_encoder()
--

commit b76c85c1a18e10745adde0bb5001dc9b1e93e31a
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dpu: add per-stream MST encoders

This commit creates a DRM encoder for each DP MST stream, associates it
with a stream ID and panel, and sets up MST-specific encoder helper
callbacks.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index 3c3203ca32c76..92691d39dcb24 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -688,6 +688,21 @@ static int _dpu_kms_initialize_displayport(struct dr=
m_device *dev,
>  				return rc;
>  			}
>  		}
> +
> +		for (int stream_id =3D 0; stream_cnt > 1 && stream_id < stream_cnt; st=
ream_id++) {
> +			info.stream_id =3D stream_id;
> +			encoder =3D dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
> +			if (IS_ERR(encoder)) {
> +				DPU_ERROR("encoder init failed for dp mst display\n");
> +				return PTR_ERR(encoder);
> +			}

[Severity: High]
Does this break KMS initialization on SC8180X?

In arch/arm64/boot/dts/qcom/sc8180x.dtsi, mdss_dp0 and mdss_dp1 both
specify stream_pixel and stream_1_pixel in clock-names, so
msm_dp_get_mst_max_stream() returns stream_cnt =3D=3D 2.  However, the SC81=
80X
DPU catalog only has one INTF_DP entry per controller because the shared
MST interface uses a dummy controller_id:

drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h:sc8180x_intf[] {
    ...
	/* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this=
 is supported */
	{
		.name =3D "intf_3", .id =3D INTF_3,
		.base =3D 0x6b800, .len =3D 0x280,
		.type =3D INTF_DP,
		.controller_id =3D 999,
    ...
}

When stream_id =3D=3D 1, dpu_encoder_init() -> dpu_encoder_setup_display() =
->
dpu_encoder_get_intf() finds no second matching INTF_DP entry and returns
NULL, causing _dpu_kms_initialize_displayport() to fail with -ENOMEM and
aborting display initialization on SC8180X.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index a2900ff3b0ab3..ef5fb70863b81 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -147,6 +147,26 @@ static int msm_dp_mst_encoder_stream_id(struct msm_d=
p_mst *mst,
>  	return -1;
>  }
> =20
> +int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int st=
ream_id,
> +			      struct drm_encoder *encoder)
> +{
> +	struct msm_dp_mst *mst =3D dp_display->msm_dp_mst;
> +	struct msm_dp_panel *dp_panel;
> +
> +	dp_panel =3D msm_dp_display_get_panel(dp_display, stream_id);
> +	if (!dp_panel) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] failed to allocate panel for stream %d\n", stream_id);
> +		return -ENOMEM;
> +	}

[Severity: Medium]
Does calling msm_dp_display_get_panel() during KMS initialization leak
struct msm_dp_panel_private across DRM component master bind/unbind
cycles?

msm_dp_display_get_panel() calls msm_dp_panel_get(), which allocates the
panel with devm_kzalloc() on the subordinate DP platform device
(&dp->msm_dp_display.pdev->dev).  When the DRM master unbinds (or if a
later step in msm_drm_init() fails), msm_dp_mst_unregister() frees struct
msm_dp_mst, but the devres allocations on the persistent DP platform
device remain and are reallocated on each subsequent bind.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D16
