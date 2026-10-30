Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80450606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB664vRk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59A111272A;
	Fri, 30 Oct 2026 10:29:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B2811272A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:29:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D11DB40AE8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B71F0093A;
 Fri, 30 Oct 2026 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356165;
 bh=6WrMHBWvDHZfLjv4kLZXkJEJhSvjfQvtKYfcexhRroA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XB664vRkWOvNFPZUaP+28HOXzFN6CWbLmr/EiXVK9Z/ACugCJ7eH4r212weu/1XNa
 YJIMSLjlbQGejwkQ5wGVXJZo6/1LojbcigxgbloPJP/n5XvW0/+IlLlKG7rHBPYABs
 S0rkRZRNJAuN58QGAvzBEsHRadV4d+2ynaLC3SuQacoZwh0RvuPnCcIIa1PLpyonxg
 TgfScaORpBYhJ2jkQP5dwpAl6t8v6KPekt4XS0/YBOHR9JckqwCddKRL/QKPmpdPWu
 CgyrlASDkV/XC4+KR29wt+m3wjaUpE+v5FFBibkjQvspH6bTvw7XaXho32YPYEETvk
 rBbQLSSc7sKBQ==
Message-ID: <sashiko-outbox-190829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFT 8/8] drm/msm/a6xx: Wire up IFPC on A615-family GPUs
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-8-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-8-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:29:25 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/a6xx: missing revn 618 on sm7150 and revn 615 in adreno_is=
_a615_family()
- [Medium] drm/msm/a6xx: QoS register mismatch between a640_pwrup_reglist a=
nd hw_init()
--

commit c21799f522c1e10807d8ac16ef0e01ab2fd9a092
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/a6xx: Wire up IFPC on A615-family GPUs

This commit enables ADRENO_QUIRK_IFPC and wires up a630_ifpc_reglist and
a640_pwrup_reglist for the A615-family entries in a6xx_gpus[].

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index 2d59f7735c907..257771d4eb4d5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1012,7 +1012,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  			[ADRENO_FW_GMU] =3D "a630_gmu.bin",
>  		},
>  		.gmem =3D SZ_512K,
> -		.quirks =3D ADRENO_QUIRK_4GB_VA,
> +		.quirks =3D ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
>  		.funcs =3D &a6xx_gpu_funcs,
>  		.zapfw =3D "a615_zap.mdt",
> @@ -1021,6 +1022,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  			.protect =3D &a630_protect,
>  			.gmu_cgc_mode =3D 0x00000222,
>  			.prim_fifo_threshold =3D 0x0018000,
> +			.ifpc_reglist =3D &a630_ifpc_reglist,
> +			.pwrup_reglist =3D &a640_pwrup_reglist,

[Severity: Medium]
Should the A615-family entries in a6xx_gpus[] either use a630_pwrup_reglist
or have hw_init() updated to program REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL for
this family?

In drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init(), all six A615-family
entries have .family =3D ADRENO_6XX_GEN1 and fall into the final else branc=
h,
which writes 0x3 to REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL and leaves
REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL unprogrammed:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
	...
	if (adreno_is_a610_family(adreno_gpu) ||
	    adreno_is_a640_family(adreno_gpu) ||
	    adreno_is_a650_family(adreno_gpu)) {
		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
	} else if (adreno_is_a7xx(adreno_gpu)) {
		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x2120212);
	} else {
		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
	}
	...
}

Later in hw_init(), a6xx_patch_pwrup_reglist() snapshots the current values
of the registers listed in info->a6xx->pwrup_reglist via gpu_read() so the =
CP
can restore them after each IFPC GX power collapse:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_patch_pwrup_reglist() {
	...
	reglist =3D adreno_gpu->info->a6xx->pwrup_reglist;
	if (reglist) {
		for (i =3D 0; i < reglist->count; i++) {
			*dest++ =3D reglist->regs[i];
			*dest++ =3D gpu_read(gpu, reglist->regs[i]);
		}
		lock->list_length +=3D reglist->count * 2;
	}
	...
}

Because a640_pwrup_reglist_regs lists REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL
rather than REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL (which is the only difference
between a640_pwrup_reglist and a630_pwrup_reglist), won't every IFPC cycle
lose the programmed REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL value and replay the
uninitialized REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL register instead?

>  		},
>  		.speedbins =3D ADRENO_SPEEDBINS(
>  			/*
> @@ -1044,7 +1047,8 @@ static const struct adreno_info a6xx_gpus[] =3D {
>  		.gmem =3D SZ_512K,
>  		.inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
>  		.quirks =3D ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,

[Severity: High]
Does enabling ADRENO_QUIRK_IFPC on the qcom,sm7150 (0x06010800) and A615
(0x06010500) entries cause them to run IFPC with A630 PDC and GMU clock
gating settings instead of A618/A615-family settings?

The qcom,sm7150 entry in drivers/gpu/drm/msm/adreno/a6xx_catalog.c omits
.revn =3D 618, unlike the generic 0x06010800 entry right below it. In addit=
ion,
adreno_is_a615_family() in drivers/gpu/drm/msm/adreno/adreno_gpu.h does not
check for revn 615:

drivers/gpu/drm/msm/adreno/adreno_gpu.h:
/* TODO: 615/616 */
static inline int adreno_is_a615_family(const struct adreno_gpu *gpu)
{
	return adreno_is_a618(gpu) ||
	       adreno_is_a619(gpu);
}

Because adreno_is_a618() checks adreno_is_revn(gpu, 618), both
adreno_is_a618() and adreno_is_a615_family() evaluate to false on
qcom,sm7150. In drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_rpmh_init(),
this causes the driver to program A630 PDC sleep/wakeup values instead of
A618 values:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_rpmh_init() {
	...
	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640_family(adreno_gpu))
		pdc_address_offset =3D 0x30090;
	else if (adreno_is_a619(adreno_gpu))
		pdc_address_offset =3D 0x300a0;
	else
		pdc_address_offset =3D 0x30080;
	...
	if (adreno_is_a618(adreno_gpu) || adreno_is_a619(adreno_gpu) ||
			adreno_is_a650_family(adreno_gpu))
		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x2);
	else
		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x3);
	...
}

With ADRENO_QUIRK_IFPC setting gmu->idle_level =3D GMU_IDLE_STATE_IFPC, the=
 GMU
will execute those PDC sequences on every IFPC power collapse. Missing revn
618 on qcom,sm7150 and revn 615 in adreno_is_a615_family() also causes
a6xx_set_hwcg() in drivers/gpu/drm/msm/adreno/a6xx_gpu.c to program A630 GMU
CGC delay and hysteresis values (0x10111 / 0x5555) instead of A615-family
values (0x111 / 0x555), and causes a6xx_hfi_send_bw_table() to skip
a618_build_bw_table() on qcom,sm7150.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-topic-a6xx=
_ifpc-v1-0-6992841a9a32@oss.qualcomm.com?part=3D8
