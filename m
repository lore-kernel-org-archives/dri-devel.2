Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F4606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAIa0M1o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409D111232C;
	Thu, 29 Oct 2026 14:08:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE15A112320
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:08:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E637860214;
 Thu, 29 Oct 2026 14:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E3E1F01825;
 Thu, 29 Oct 2026 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793282914;
 bh=FLBXHlCEs2kPIfWpcXVMdhfJTkUxBWWwKgf1Y8KgijQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NAIa0M1oz5PurvDw4lZZMxKdkCSCWJubNZvfLN6XSS26BwnnDzneXzvyjxUk05M4h
 Jlbmo+vKZZBEYqVsEOoztMJpHbsCd2iwrH9eyh5t1ZdudpABGD1b6Fc6ueRh0Wl02E
 H9wKy0JoCL2mBlyFsu8tWQhpMAJ7itYMDAZm/xUQFOtppP+lnpBFGHlpLYBhLreQeJ
 SqcOIudIMesjhQqeHXz051q4YTdZFWPMGZ2esC0YgUGma01Cig78U93oZzbdBoZmhR
 HwV0A7gwVF+FoUr7ovNydmWCO5vRgr7Ll2cUTDiBcndpNrY1g6ROWBjXKNj/pYiuHQ
 0RfZtNeRsIKuA==
Message-ID: <sashiko-outbox-189478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 05/14] firmware: qcom: scm: Configure LPAC aperture
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:08:34 +0000
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
- [High] drm/msm/adreno: missing lpac_pdev check in adreno_hw_init()
- [Low] firmware: qcom: scm: broken mask macro and unmasked context_bank ar=
gument
--

commit ea6cfd100e49bc2229349870a3f6d5f6dfcedd94
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

firmware: qcom: scm: Configure LPAC aperture

This commit adds qcom_scm_set_gpu_smmu_lpac_aperture() to configure the
SMMU LPAC aperture via SCM and calls it from adreno_hw_init() when
ADRENO_QUIRK_LPAC is set.

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 9b06a69d3a6d7..92093399f20d9 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1204,6 +1204,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spa=
re)
>  EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
> =20
>  #define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
> +#define QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK	GENMASK(7, 1)
> =20
>  bool qcom_scm_set_gpu_smmu_aperture_is_available(void)
>  {
> @@ -1229,6 +1230,23 @@ int qcom_scm_set_gpu_smmu_aperture(unsigned int co=
ntext_bank)
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
> =20
> +int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank)
> +{
> +	struct qcom_scm_desc desc =3D {
> +		.svc =3D QCOM_SCM_SVC_MP,
> +		.cmd =3D QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
> +		.arginfo =3D QCOM_SCM_ARGS(4),
> +		.args[0] =3D 0xffff0000 | (1 << 8 | context_bank),
> +		.args[1] =3D 0xffffffff,
> +		.args[2] =3D 0xffffffff,
> +		.args[3] =3D 0xffffffff,
> +		.owner =3D ARM_SMCCC_OWNER_SIP
> +	};
> +
> +	return qcom_scm_call(__scm->dev, &desc, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_lpac_aperture);

[Severity: Low]
Should QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK be dropped or defined as BIT(8),
and should context_bank be masked with FIELD_PREP() in
qcom_scm_set_gpu_smmu_lpac_aperture()?

Currently QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK is defined as GENMASK(7, 1)
and never used, while qcom_scm_set_gpu_smmu_aperture() masks context_bank
into bits 7:0:

drivers/firmware/qcom/qcom_scm.c:qcom_scm_set_gpu_smmu_aperture() {
	...
	.args[0] =3D 0xffff0000 | FIELD_PREP(QCOM_SCM_CP_APERTURE_CONTEXT_MASK, co=
ntext_bank),
	...
}

In qcom_scm_set_gpu_smmu_lpac_aperture(), ORing an unmasked context_bank
with (1 << 8) could clobber bit 8 or upper bits of args[0] if a caller
passes a value larger than 0xff.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 1dedeb19946ec..65d34d0cfc380 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -658,6 +658,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm=
_gpu *gpu,
>  int adreno_hw_init(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +	const struct adreno_info *info =3D adreno_gpu->info;
>  	int ret;
> =20
>  	VERB("%s", gpu->name);
> @@ -668,6 +669,11 @@ int adreno_hw_init(struct msm_gpu *gpu)
>  		ret =3D qcom_scm_set_gpu_smmu_aperture(0);
>  		if (ret)
>  			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret=
);
> +		if (info->quirks & ADRENO_QUIRK_LPAC) {
> +			ret =3D qcom_scm_set_gpu_smmu_lpac_aperture(1);
> +			if (ret)
> +				DRM_DEV_ERROR(gpu->dev->dev, "unable to set lpac SMMU aperture: %d\n=
", ret);
> +		}
>  	}

[Severity: High]
Does adreno_hw_init() also need to check gpu->lpac_pdev before calling
qcom_scm_set_gpu_smmu_lpac_aperture(1)?

In adreno_gpu_init(), gpu->lpac_pdev is only populated when the device tree
contains a qcom,lpac child node:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_gpu_init() {
	...
	lpac_node =3D of_get_compatible_child(pdev->dev.of_node, "qcom,lpac");
	if (lpac_node)
		gpu->lpac_pdev =3D of_find_device_by_node(lpac_node);
	...
}

And adreno_iommu_create_vm() only creates the separate LPAC IOMMU domain
(which allocates SMMU context bank 1) when gpu->lpac_pdev is non-NULL:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_iommu_create_vm() {
	...
	mmu =3D msm_iommu_gpu_new(&pdev->dev,
				gpu->lpac_pdev ? &gpu->lpac_pdev->dev : NULL,
				gpu, quirks);
	...
}

When booting a GPU with ADRENO_QUIRK_LPAC on an existing DTB that does not
have the qcom,lpac child node, gpu->lpac_pdev is NULL and context bank 1 is
never allocated. Won't calling qcom_scm_set_gpu_smmu_lpac_aperture(1)
unconditionally on ADRENO_QUIRK_LPAC configure the LPAC aperture to an
unallocated context bank?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D5
