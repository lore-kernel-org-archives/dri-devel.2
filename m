Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7632DCA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 20:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08EB10E58C;
	Sat,  3 Oct 2026 20:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q9hxfL4P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424B210E58C
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 20:12:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4ED0A600CB;
 Sat,  3 Oct 2026 20:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A21F0089B;
 Sat,  3 Oct 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791058348;
 bh=PETVYlALKVpYI3mZ6kwLDBMO2S9eWoODGUp/4KNKTeA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q9hxfL4PvJjthTELW+6DEXd+Qd0x3NLqX8FbXmnPRh9IcZumW4rZ/KRkLQwmR6tdI
 NZ1/YLiMio24cmxkfw+PWI+AlypJUYZGsshH183I23bNeH34Jv9dDAxzi0X4/wKr28
 tVdOAM2jWBwkXFRMdL+J8ao6fMknUQQhx2lMb65S2C+NLTtTLrzJ7NLRZwdfbRGthv
 Zi5+W3jR6XQxDoTd2OBcf4+QGiS7tIxY+pCxmxYS65Fo0kiDt0ZFupJF11J3f6dqp9
 elgzOEGPuf9ac5ua6Vw2eq8uKph7D/Qw8tSEV87iDkyyYyDPdgo+OKL1Y7SNbdRUFT
 x9UPJIoFBrpdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8188: Add the MFGCFG
 phandle to the GPU
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261003200132.866240-4-michal@nozomi.space>
References: <20261003200132.866240-1-michal@nozomi.space>
 <20261003200132.866240-4-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 20:12:27 +0000
Message-Id: <20261003201227.9D4A21F0089B@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panfrost: missing GPU timestamp quirk on MT8370
--

commit ad326344199c9c294e6415c92318bcef828d8630
Author: Micha=C5=82 Kope=C4=87 <michal@nozomi.space>

arm64: dts: mediatek: mt8188: Add the MFGCFG phandle to the GPU

This commit adds the MFGCFG phandle to the GPU node in the MT8188 device
tree. The GPU driver requires this configuration block to enable the GPU
timestamp counter, which otherwise reads zero.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
> index 14a320f0c70cb..b4be89bf55bf7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -2266,6 +2266,7 @@ gpu: gpu@13000000 {
>  				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
>  				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
>  			interrupt-names =3D "job", "mmu", "gpu";
> +			mediatek,mfgcfg =3D <&mfgcfg>;

[Severity: Medium]
Since we are enabling the GPU timestamp counter via the MFG configuration
block for the MT8188, does the MT8370 SoC also need its corresponding quirk
updated in the panfrost driver to avoid breaking userspace timestamp querie=
s?

Looking at drivers/gpu/drm/panfrost/panfrost_drv.c, the mediatek_mt8370_data
struct is defined as:

static const struct panfrost_compatible mediatek_mt8370_data =3D {
	.num_supplies =3D ARRAY_SIZE(default_supplies) - 1,
	.supply_names =3D default_supplies,
	.num_pm_domains =3D 2,
	.pm_domain_names =3D mediatek_pm_domains,
	.pm_features =3D BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
	.gpu_quirks =3D BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
};

This struct lacks .vendor_quirk =3D panfrost_gpu_mt8188_quirk.

When the driver probes on MT8370 using the mediatek,mt8370-mali compatible,
the missing quirk means the MFG configuration block is never enabled. As a
result, the GPU timestamp counter will read zero on the MT8370 SoC.

Could this be an omission, or is it intentional to skip the vendor quirk
for MT8370?

>  			nvmem-cells =3D <&gpu_speedbin>;
>  			nvmem-cell-names =3D "speed-bin";
>  			operating-points-v2 =3D <&gpu_opp_table>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003200132.8662=
40-1-michal@nozomi.space?part=3D3
