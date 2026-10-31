Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34B606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYkqG0/d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A598D10E10D;
	Sat, 31 Oct 2026 08:16:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAECE10E10D
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 08:16:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E31FB600C8;
 Sat, 31 Oct 2026 08:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6493C1F000C1;
 Sat, 31 Oct 2026 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793434588;
 bh=BU8vZrh+E0EyfqHBm3KO7jS+VxWPaY70+PTxu4tT8Pc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gYkqG0/dVWODGI86+tSX8qqPFMXVsJGAsoWLyYbHtsk/2V8kx9zU4bDh8KVyAooCY
 +/sq2tjFPrqeGCoGBfvCvAtHbQgnR9gUtP1o1/LumaDueYYpeB7CJcu20YyUtf0CBL
 5wvzOjSi6TcY/4xbi6umCmAaUz6KyrqBA4of3trjCycC1HzFmvCtiX4Juk6TWZhFBx
 AaUweGdoFVo4t7ooQvrcLMKZYExGR8mHV1/sHosGbEKjmW85XDLHeyHTKs0DAGirE2
 Wr18+kpeIYCcN2Vj5pHCo6tsnLV4BGl+pKpa6u+sHCTfZKuv3MTvRkQF24PlV3wZZv
 ANnU8ix6CG3Sw==
Message-ID: <sashiko-outbox-191822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/msm/dpu: Add SM7250 support
To: "Ishu Brar" <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261031-dpu-sm7250-v1-4-159f403ec405@brar.si>
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
 <20261031-dpu-sm7250-v1-4-159f403ec405@brar.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:16:27 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/dpu: missing qcom,sm7250 entry in qcom_ubwc_configs[] brea=
ks probe
- [Medium] drm/msm/dpu: wrong VIG scaler sblk and decimation caps in sm7250=
 catalog
--

commit c585a6f10d3dc7f0ad4fb0db73946dc4b06530db
Author: Ishu Brar <patches@brar.si>

drm/msm/dpu: Add SM7250 support

This commit adds hardware catalog definitions and device tree matching for
the DPU 6.1 display controller on the Qualcomm SM7250 platform.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_1_sm7250.h b/dri=
vers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_1_sm7250.h
> new file mode 100644
> index 0000000000000..802a96598f362
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_1_sm7250.h
> @@ -0,0 +1,311 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserv=
ed.
> + *
> + * SM7250, SDE hardware revision 6.1.0. Block offsets are relative to the
> + * "mdp" register region.
> + */
> +
> +#ifndef _DPU_6_1_SM7250_H
> +#define _DPU_6_1_SM7250_H
> +
> +static const struct dpu_caps sm7250_dpu_caps =3D {
> +	.max_mixer_width =3D DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +	.max_mixer_blendstages =3D 0x9,
> +	.has_src_split =3D true,
> +	.has_dim_layer =3D true,
> +	.has_idle_pc =3D true,
> +	.has_3d_merge =3D true,
> +	.max_linewidth =3D 2880,
> +	.pixel_ram_size =3D DEFAULT_PIXEL_RAM_SIZE,
> +	.max_hdeci_exp =3D MAX_HORZ_DECIMATION,
> +	.max_vdeci_exp =3D MAX_VERT_DECIMATION,
> +};

[ ... ]

> +static const struct dpu_sspp_cfg sm7250_sspp[] =3D {
> +	{
> +		.name =3D "sspp_0", .id =3D SSPP_VIG0,
> +		.base =3D 0x4000, .len =3D 0x1f8,
> +		.features =3D VIG_SDM845_MASK_SDMA,
> +		.sblk =3D &dpu_vig_sblk_qseed3_2_4,
> +		.xin_id =3D 0,
> +		.type =3D SSPP_TYPE_VIG,
> +		.clk_ctrl =3D DPU_CLK_CTRL_VIG0,
> +	}, {
> +		.name =3D "sspp_1", .id =3D SSPP_VIG1,
> +		.base =3D 0x6000, .len =3D 0x1f8,
> +		.features =3D VIG_SDM845_MASK_SDMA,
> +		.sblk =3D &dpu_vig_sblk_qseed3_2_4,
> +		.xin_id =3D 4,
> +		.type =3D SSPP_TYPE_VIG,
> +		.clk_ctrl =3D DPU_CLK_CTRL_VIG1,
> +	}, {

[Severity: Medium]
Should SSPP_VIG0 and SSPP_VIG1 in sm7250_sspp[] use dpu_vig_sblk_qseed3_3_0
instead of dpu_vig_sblk_qseed3_2_4, and should max_hdeci_exp and
max_vdeci_exp be omitted from sm7250_dpu_caps?

During dpu_kms_hw_init() -> dpu_rm_init() -> dpu_hw_sspp_init(),
sm7250_sspp[] binds sspp_0 and sspp_1 to the DPU 5.x QSEED3LITE v2.4
sub-block (dpu_vig_sblk_qseed3_2_4) and sm7250_dpu_caps advertises hardware
decimation limits.

All other DPU 6.x catalog definitions with a VIG scaler (SM8250, SC7180,
SM6115, SM6350, and SM6375) use dpu_vig_sblk_qseed3_3_0 and omit
max_hdeci_exp and max_vdeci_exp, as hardware decimation was removed in DPU
6.0 (similar to the fixes for SM8250 and SM6115 in commits 03c0c3cb22a4 and
38164e990a42).

[ ... ]

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index da3556eb6ecc2..6eb6f65ada91d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1506,6 +1506,7 @@ static const struct of_device_id dpu_dt_match[] =3D=
 {
>  	{ .compatible =3D "qcom,sm6350-dpu", .data =3D &dpu_sm6350_cfg, },
>  	{ .compatible =3D "qcom,sm6375-dpu", .data =3D &dpu_sm6375_cfg, },
>  	{ .compatible =3D "qcom,sm7150-dpu", .data =3D &dpu_sm7150_cfg, },
> +	{ .compatible =3D "qcom,sm7250-dpu", .data =3D &dpu_sm7250_cfg, },
>  	{ .compatible =3D "qcom,sm8150-dpu", .data =3D &dpu_sm8150_cfg, },
>  	{ .compatible =3D "qcom,sm8250-dpu", .data =3D &dpu_sm8250_cfg, },
>  	{ .compatible =3D "qcom,sm8350-dpu", .data =3D &dpu_sm8350_cfg, },

[Severity: High]
Will probing fail on SM7250 without a corresponding "qcom,sm7250" entry in
qcom_ubwc_configs[] in drivers/soc/qcom/ubwc_config.c?

Both dpu_kms_hw_init() and msm_mdss_init() call qcom_ubwc_config_get_data():

drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:dpu_kms_hw_init() {
	...
	dpu_kms->mdss =3D qcom_ubwc_config_get_data();
	if (IS_ERR(dpu_kms->mdss)) {
		rc =3D PTR_ERR(dpu_kms->mdss);
		DPU_ERROR("failed to get UBWC config data: %d\n", rc);
		goto err_pm_put;
	}
	...
}

Because qcom_ubwc_configs[] has no entry matching "qcom,sm7250",
of_machine_get_match_data(qcom_ubwc_configs) returns NULL and
qcom_ubwc_config_get_data() returns ERR_PTR(-EINVAL), aborting both MDSS and
DPU initialization.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-dpu-sm7250=
-v1-0-159f403ec405@brar.si?part=3D4
