Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF8606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNqVQCet
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1E010E916;
	Tue, 10 Nov 2026 05:18:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4E610E916
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:18:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1206244F95;
 Tue, 10 Nov 2026 05:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D156F1F008A1;
 Tue, 10 Nov 2026 05:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794287897;
 bh=Q0hRqJN661fzGKJx+w1Bwbq9zzUpYK2RTgc6iwA+2bk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BNqVQCetHOiwIAG9L9C7INqCuQYcidtME1WsdpkjsIuuvoXXRfkwLuLf7opbdqoXQ
 oJYBxOLfgFPmzZC2Og/P5+Qgzmi2Htcm33habHKiSJHJ5R4pZ/A0j02cAebwXK8vab
 eFoCtzA6lCLvM1X5WDGnnEFr25/TJVy0pWRrbml8P6C327YWkH72QTSXw47+23xsL2
 hhMM5mMK8bGwVRpXPC3i2UPXIdqNxxAeYVRbP39MQZMNmFJ2M2S6m0VPs/G1UfbCg+
 WNxoV3dS9aoE7KW9vaZwVEbZNmtiOBAedTkZyQ36xsesiVhXw/+69xIg50Kjr+qtxG
 mINFxxfFjKcbg==
Message-ID: <sashiko-outbox-206272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/29] drm/msm/dpu: add per-stream MST encoders
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-16-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-16-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:18:15 +0000
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

commit 866340b38e0036903bdb9a49a2dd242e4d969ea0
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dpu: add per-stream MST encoders

This commit initializes one DRM encoder per DisplayPort MST stream with
MST-specific helper callbacks and attaches each encoder and stream panel to
the DP MST state.

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
> +
> +			rc =3D msm_dp_mst_attach_encoder(priv->kms->dp[i], stream_id, encoder=
);
> +			if (rc) {
> +				DPU_ERROR("dp_mst attach_encoder failed, rc =3D %d\n", rc);
> +				return rc;
> +			}
> +		}
>  	}
> =20
>  	return 0;

[Severity: High]
Does this break DPU KMS initialization on SC8180X?

On SC8180X, arch/arm64/boot/dts/qcom/sc8180x.dtsi defines both stream_pixel
and stream_1_pixel on mdss_dp0 and mdss_dp1, so msm_dp_get_mst_max_stream()
returns stream_cnt =3D 2.  However, sc8180x_intf[] only defines one INTF_DP
entry for MSM_DP_CONTROLLER_0 and one for MSM_DP_CONTROLLER_1, while the
shared MST interface has a dummy controller_id:

drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h:
	/* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this=
 is supported */
	{
		.name =3D "intf_3", .id =3D INTF_3,
		.base =3D 0x6b800, .len =3D 0x280,
		.type =3D INTF_DP,
		.controller_id =3D 999,

When stream_id =3D=3D 1, dpu_encoder_init() -> dpu_encoder_setup_display() =
->
dpu_encoder_get_intf() cannot find a second matching INTF_DP entry and
returns NULL, causing dpu_encoder_init() to return ERR_PTR(-ENOMEM) and
aborting _dpu_kms_initialize_displayport() and all display initialization.

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
> +
> +	mst->mst_encoders[stream_id].enc =3D encoder;
> +	mst->mst_encoders[stream_id].stream_id =3D stream_id;
> +	mst->mst_encoders[stream_id].dp_panel =3D dp_panel;
> +
> +	return 0;
> +}

[Severity: Medium]
Does calling msm_dp_display_get_panel() here leak struct
msm_dp_panel_private across DRM component master unbind/rebind cycles or KMS
init failure?

msm_dp_mst_attach_encoder() runs during DRM master bind in
_dpu_kms_initialize_displayport(), but msm_dp_display_get_panel() ->
msm_dp_panel_get() allocates the panel with devm_kzalloc() on the persistent
subordinate DP platform device (&dp->msm_dp_display.pdev->dev).  When the
DRM master unbinds or msm_drm_init() fails later, dpu_kms_destroy() ->
msm_dp_mst_unregister() -> msm_dp_mst_mgr_destroy() frees mst and drops
mst->mst_encoders[stream_id].dp_panel, leaving the devres allocation behind
on the DP device and allocating a new panel on the next bind.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D16
