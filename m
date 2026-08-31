Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E13C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713BB10E7C0;
	Mon, 31 Aug 2026 09:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UUjJLHsk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83A610E7C0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:47:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 921564363A;
 Mon, 31 Aug 2026 09:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F781F000E9;
 Mon, 31 Aug 2026 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788169667;
 bh=WysrAFyiW3JvlGr9ea5qJ0ibW0huR6fZv1vIpDniSNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UUjJLHskCF+ztKpn7BV+EbI9/+vgp0d7LeeoxPLaufnxUfCzHiegiWjufpHFeeUua
 q/Z4jDGOjEfON9e0g4UcMQ63nxqjhWWWU+bzhzL/ttRH2NZein0kDaGyjEsolU61z+
 vDp0CJ8VQnomVzeaEkLsKGNhlkJRLuK9KqKkfmI/9BKYNfyt6P3UTBhOS5ppEujlBZ
 deGLfKjbcXR9HN/8QfC0OHVbeN87Gq8zj7avxt/P6/sADwZ8NV9F9DOaplaTFo0uxp
 IgkVl8iD5OnCOdph7vrP7UynFSBm1hXLs/wst6j10WYdX1Yf2XhC36y+pR0fP96gMA
 jMA92QgWnpsIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/29] drm/msm/dpu: add per-stream MST encoders
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-22-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-22-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:47:46 +0000
Message-Id: <20260831094747.52F781F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Memory leak of `msm_dp_panel` structures during DRM aggregate devi=
ce bind/unbind.

Pre-existing issues:
- [High] Acquiring a mutex within encoder atomic enable/disable callbacks, =
which run in atomic context.
--

commit e97742ad149cc1b791cf840c7db48478057e92d2
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dpu: add per-stream MST encoders

Unlike SST, where a DP controller is represented by a single encoder,
MST requires an encoder instance for each stream.

Create one DRM encoder per MST stream, associate it with a stream ID,
and initialize it with MST-specific encoder helper callbacks.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 004d5fc460a87..533109b4365c3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2744,6 +2744,24 @@ static const struct drm_encoder_helper_funcs dpu_e=
ncoder_helper_funcs =3D {
>  	.atomic_enable =3D dpu_encoder_virt_atomic_enable,
>  };
> =20
> +static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
> +				      struct drm_atomic_commit *state)
> +{
> +	dpu_encoder_virt_atomic_enable(enc, state);

[Severity: High]
This is a pre-existing issue, but does calling
dpu_encoder_virt_atomic_enable() here violate atomic context rules?

According to subsystem guidelines, atomic_enable callbacks run in an atomic
context where sleeping is forbidden. However,
dpu_encoder_virt_atomic_enable() acquires a sleepable mutex:

static void dpu_encoder_virt_atomic_enable(...)
{
    ...
    mutex_lock(&dpu_enc->enc_lock);
    ...
}

Could this lead to kernel warnings, system instability, or potential deadlo=
cks?

> +}
> +
> +static void dpu_encoder_mst_atomic_disable(struct drm_encoder *enc,
> +				       struct drm_atomic_commit *state)
> +{
> +	dpu_encoder_virt_atomic_disable(enc, state);
> +}
> +

[ ... ]

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index 66cabac0a7264..d6182cec06d58 100644
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

[Severity: High]
If this loop fails on stream_id > 0, do the panels allocated in previous
iterations leak?

Additionally, because the panel allocation in msm_dp_mst_attach_encoder() is
tied to the independent DP device's lifetime, it appears these panels will
also leak on aggregate unbind, as well as on KMS initialization failures
causing probe deferral.

> +			}
> +		}
>  	}
> =20
>  	return 0;

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 94a717ba7c827..93536b6936cbd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -145,6 +145,26 @@ static int msm_dp_mst_encoder_stream_id(struct msm_d=
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

[Severity: High]
Does this allocation leak during DRM aggregate device unbind?

msm_dp_display_get_panel() uses devm_kzalloc tied to the DP component
device (pdev->dev). Because the DP component device outlives the DRM bind
cycle, its devm allocations are not freed on DRM unbind.

Could repeatedly binding and unbinding the DRM aggregate device (e.g., via
sysfs) permanently leak this msm_dp_panel?

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
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D22
