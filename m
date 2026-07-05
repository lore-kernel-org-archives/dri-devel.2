Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CA0C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8792A10E44F;
	Sun,  5 Jul 2026 19:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dSqoADfY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DD410E44F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:24:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C27C243643;
 Sun,  5 Jul 2026 19:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B481F00A3A;
 Sun,  5 Jul 2026 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783279452;
 bh=Wn0MnM6l+PFvNgYAf+xGPbe3hRfrMo5I9v9wRVaZ98o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dSqoADfYJ8ZGqKGWtJywmxKoifqHm93CO3fyiipiFno2L4Fsi42m1DwKbharKRSgQ
 hH0f4cYKo4er5zK7ScEay/K4aR4u6UYoxzKjGt6mfmylQXTHJh2RQiJ47nydMTREiP
 rvJsRkICkCpkpvniBfWtmG/MNhwMwmyW0A22p3TSpwm9MaPZsqqdlI9KIiuN6p7r0P
 Ed0IwkgiSppP5u6+RF8O24Xu/LM49RDgo65KQnXeQGgOv+a56qDQRck3OyCDfdosTr
 Mk59cqfZBn/deJXNZ26J8ZwAc46RwLiOehJUcEVA0AtCwW1+Nk1a1Cp7V5qztfooDD
 EpbS2YplwrNnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/13] arm64: dts: qcom: sm8650: move smmu sid 1 to
 new lpac device
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 19:24:11 +0000
Message-Id: <20260705192412.62B481F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Device Tree Forward-Compatibility Breakage (GPU Firmware Crash on =
Older Kernels)
- [High] Resource Leak and Unbalanced PM Runtime in GPU Driver LPAC Initial=
ization
- [Medium] Device Tree Anti-Pattern and Syntax Violation (Overlapping Reg /=
 Mismatched Unit Address)
--

commit e35e1c1ccf71441e2995511a6a0a9c69917e0605
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

arm64: dts: qcom: sm8650: move smmu sid 1 to new lpac device

Moves SID 1 from the GPU node to a new LPAC node to allow SID 1 to use a
different domain when LPAC is used.

> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/q=
com/sm8650.dtsi
> index 1604bc8cff373..44e5f9d4b335f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4133,6 +4133,13 @@ tcsr: clock-controller@1fc0000 {
>  			#reset-cells =3D <1>;
>  		};
> =20
> +		lpac: lpac@3d00000 {
> +			compatible =3D "qcom,lpac";
> +			reg =3D <0x0 0x03d00000 0x0 0x61000>;
> +
> +			iommus =3D <&adreno_smmu 1 0x0>;
> +		};
> +

[Severity: Medium]
Does this node violate the Devicetree specification by overlapping with its
sibling node?

The memory region (0x3d00000) for the lpac@3d00000 node completely overlaps
with the gpu@3d00000 node below.

Also, creating a top-level dummy platform device solely to bind a second
IOMMU SID to a separate struct device (to work around driver domain
isolation limitations) appears to be an architectural anti-pattern.

>  		gpu: gpu@3d00000 {
>  			compatible =3D "qcom,adreno-43051401", "qcom,adreno";
>  			reg =3D <0x0 0x03d00000 0x0 0x40000>,
[ ... ]
> @@ -4144,8 +4151,9 @@ gpu: gpu@3d00000 {
> =20
>  			interrupts =3D <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
> =20
> -			iommus =3D <&adreno_smmu 0 0x0>,
> -				 <&adreno_smmu 1 0x0>;
> +			iommus =3D <&adreno_smmu 0 0x0>;
> +
> +			qcom,lpac=3D <&lpac>;

[Severity: High]
Does removing SID 1 from the gpu@3d00000 node break forward-compatibility
for older kernels?

If an older kernel (which lacks the LPAC DRM driver modifications to parse
qcom,lpac) boots with this updated DT, it will only attach SID 0 to the
GPU's SMMU domain, leaving SID 1 unmapped.

Since the commit message notes that firmware requires both SID 0 and 1
mapped to the same page table during initialization, attempting to boot an
older kernel with this DT could trigger an SMMU context fault and completely
break GPU initialization.


Regarding the DRM driver code that handles the new lpac node:

[Severity: High]
Does the driver initialization leak the LPAC device reference and leave PM
runtime unbalanced?

Looking at adreno_gpu_init() in drivers/gpu/drm/msm/adreno/adreno_gpu.c:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_gpu_init() {
    ...
    gpu->lpac_pdev =3D of_find_device_by_node(lpac_node);
    if (gpu->lpac_pdev) {
        ...
        pm_runtime_enable(&gpu->lpac_pdev->dev);
    }
    ...
}

The driver acquires a reference using of_find_device_by_node() (which
increments the reference count) and calls pm_runtime_enable().

However, adreno_gpu_cleanup() handles the main gpu_pdev but does not seem
to call put_device() or pm_runtime_disable() to clean up gpu->lpac_pdev:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_gpu_cleanup() {
    ...
    if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
        pm_runtime_disable(&priv->gpu_pdev->dev);
   =20
    msm_gpu_cleanup(&adreno_gpu->base);
    ...
}

Could this result in a memory leak of the device structure and trigger an
"Unbalanced pm_runtime_enable!" warning when the GPU driver is unbound
or fails to probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-descriptiv=
e-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com?part=3D4
