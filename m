Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC9606A92A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQYZcd60
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A6010E817;
	Thu, 29 Oct 2026 14:21:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8B010E817
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:21:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E223B41878;
 Thu, 29 Oct 2026 14:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3881F01825;
 Thu, 29 Oct 2026 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283669;
 bh=IkS9wqMZdir418xe0QPyTTSiBp9+aH+dmmmdRNu0iac=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YQYZcd60MhugON9UubfTL0GdlBQR+xHJKVz10rGIQilcinIMPT0Hac4mDiFc8e99a
 S9BLUy4UxvPos4QWY7QnEGjD5zXEvewPiG+Ig4SHuTTMJAxIvfNwfrkXnPwfC5VGwM
 d4boEEac2pV0PWEPj88UQ1ag+d7+Hs9kfRNd8aRk8g/qn2kqaP8oMfXw7A2M0P0pUZ
 KvxQoX3eGkPKudVszfp8Xq7rWHieefCouCWnLHNfgWZqLu9DklLbP3pVPTzLdri2cq
 Msr8UaYiFSTz8rCNAA/2uFH7/CikUQ0JPzHjtFo1T18cIXZGRCkU6ekPSvntE8p/fF
 xr1aYKkuGlv0w==
Message-ID: <sashiko-outbox-189503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 01/14] iommu: arm-smmu-qcom: Configure lpac
 device with split address space
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-1-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-1-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:21:09 +0000
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
- [High] iommu/arm-smmu-qcom: qcom_adreno_smmu_alloc_context_bank() shifts =
GMU to cb 2
- [Medium] iommu/arm-smmu-qcom: undocumented qcom,lpac DT compatible breaks=
 DT ABI
--

commit 89b03a5b08cd9912b4e1abfb59372ce6c00d8186
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

iommu: arm-smmu-qcom: Configure lpac device with split address space

This commit configures the LPAC device to use a split address space by
matching the "qcom,lpac" compatible string, recognizing stream ID 1 in
qcom_adreno_smmu_is_gpu_device(), and reserving context banks 0 and 1 for
GPU and LPAC devices.

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index edd41b5a3b6ac..48a590aaeb5eb 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -35,6 +35,8 @@
>  static const struct of_device_id qcom_smmu_actlr_client_of_match[] =3D {
>  	{ .compatible =3D "qcom,adreno",
>  			.data =3D (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible =3D "qcom,lpac",
> +			.data =3D (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },

[Severity: Medium]
Does adding "qcom,lpac" here and in qcom_smmu_client_of_match[] introduce
an undocumented Device Tree compatible string and break Device Tree
backwards compatibility?

Neither this commit nor the follow-up commits in this series document
"qcom,lpac" in Documentation/devicetree/bindings/, and
Documentation/devicetree/bindings/display/msm/gpu.yaml sets
additionalProperties: false:

Documentation/devicetree/bindings/display/msm/gpu.yaml:
  required:
    - compatible
    - reg
    - interrupts

  additionalProperties: false

which causes dtbs_check validation to fail when an lpac child node is added
under the GPU node in "arm64: dts: qcom: sm8650: move smmu sid 1 to new
lpac device".

Furthermore, existing upstream Device Trees (such as sm8350.dtsi,
sc8280xp.dtsi, sm8450.dtsi, sm8550.dtsi, sm8650.dtsi, hamoa.dtsi,
kodiak.dtsi, lemans.dtsi, and monaco.dtsi) already assign Stream ID 1
directly to the main "qcom,adreno" GPU node:

arch/arm64/boot/dts/qcom/sm8650.dtsi:
  iommus =3D <&adreno_smmu 0 0x0>,
           <&adreno_smmu 1 0x0>;

When booting with an existing sm8650 DTB that lacks the new "qcom,lpac"
child node, gpu->lpac_pdev is NULL and context bank 1 is never allocated,
yet the later commits "firmware: qcom: scm: Configure LPAC aperture",
"drm/msm: initialize LPAC ring", and "drm/msm: enable LPAC on gen70900"
gate LPAC hardware initialization on ADRENO_QUIRK_LPAC rather than
gpu->lpac_pdev.

[ ... ]

> @@ -305,9 +309,9 @@ static int qcom_adreno_smmu_alloc_context_bank(struct=
 arm_smmu_domain *smmu_doma
>  	 */
>  	if (qcom_adreno_smmu_is_gpu_device(dev)) {
>  		start =3D 0;
> -		count =3D 1;
> +		count =3D 2;
>  	} else {
> -		start =3D 1;
> +		start =3D 2;
>  		count =3D smmu->num_context_banks;
>  	}

[Severity: High]
Won't unconditionally changing start from 1 to 2 in the else branch of
qcom_adreno_smmu_alloc_context_bank() shift the Adreno GMU ("qcom,adreno-gm=
u",
SID 5) from context bank 1 to context bank 2 across all Adreno platforms,
and break non-GPU context bank allocation on qcom,sdm630-smmu-v2?

During Adreno GMU initialization on Adreno 6xx/7xx/8xx SoCs, the call chain:

  a6xx_gpu_init() ->
    a6xx_gmu_init() ->
      a6xx_gmu_memory_probe() ->
        msm_iommu_new(gmu->dev, NULL, 0) ->
          iommu_attach_device() ->
            arm_smmu_attach_dev() ->
              arm_smmu_init_domain_context() ->
                qcom_adreno_smmu_alloc_context_bank()

evaluates gmu->dev (SID 5), which takes the else branch (both here and after
the later commit "iommu: arm-smmu-qcom: Fixed mapping between sid and cb for
gpu and lpac") and allocates cbndx 2 instead of cbndx 1, leaving cbndx 1
unused on all SoCs or DTBs without a separate "qcom,lpac" device.

As noted in commit afc95681c30689 ("iommu/arm-smmu-qcom: Add missing GMU
entry to match table"), firmware on platforms such as sc8280xp expects
context bank 1 to be assigned to the GMU; assigning context bank 2 causes
the SMMU to wedge and the GPU to hang without memory access when a GPU
translation fault occurs.

Additionally, on qcom,sdm630-smmu-v2, qcom_adreno_smmuv2_cfg_probe() limits
smmu->num_context_banks to 2:

drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:qcom_adreno_smmuv2_cfg_probe() {
	/* TZ protects several last context banks, hide them from Linux */
	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm630-smmu-v2") &&
	    smmu->num_context_banks =3D=3D 5)
		smmu->num_context_banks =3D 2;
}

With start =3D 2 and count =3D 2, __arm_smmu_alloc_bitmap(smmu->context_map=
, 2, 2)
has an empty allocation range and will unconditionally return -ENOSPC for
any non-GPU device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D1
