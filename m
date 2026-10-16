Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F30CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CD51125D4;
	Fri, 16 Oct 2026 07:01:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC8D81125D4
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:01:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41301404A1;
 Fri, 16 Oct 2026 07:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064791F000C4;
 Fri, 16 Oct 2026 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792134067;
 bh=EIfFJoZMvzAXAOvK7ywBeqYExTQFffFM+1cUJyNjTho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=idjE2ccPpJS3J5tDHxT/04G3RebS6gDuVk6Ivfh0CXuolyksuwV9MtZIMIXIJJ5Q3
 XL9HKrMMNSFBiea2nHtYObyZ+CfCPokeNeKSbuFg04BpoZFmOtPAZx5GDtf5j+CRLN
 ZgWP8SdXfMKaA5T7C6FmjMpNf1tkZ9M5Bl0j4NLkeUbHlsFSPJ7erZZtX6DPWnPe2q
 iy5SauU0Ugh4/2PYKtGfJnYNM3meENFFaec7cYjsjBI7ou9/A4dpF5oTq7nwvOYazz
 EbZPdB3Pr5nlsGYO5GALbHKefpXNAIK4C2HEwjiAuA1tZBiVWkBDWFOmNZ7586RJRD
 BVs1/KKk/EXIQ==
Message-ID: <sashiko-outbox-173894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] iommu/tegra-smmu: Defer display client
 translation to driver handover
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-8-b06842a01938@nvidia.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-8-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:01:06 +0000
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
- [Critical] iommu: tegra SMMU isolation bypass for display controllers via=
 defer_enable
--

commit d4d42b6a74ebf50531a4c2f625710578bc863c34
Author: Mikko Perttunen <mperttunen@nvidia.com>

iommu/tegra-smmu: Defer display client translation to driver handover

Bootloaders may leave display controllers scanning out a boot splash
while the kernel boots. Enabling translation for them without special
care during that time would cause translation faults.

Because of this, tegra_smmu_def_domain_type has kept every device on an
identity domain at boot, and TegraDRM has parallel custom IOMMU domain
management code paths for these clients.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 67e7a7b925f0c..6779528a9e7cc 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -368,7 +368,13 @@ static void tegra_smmu_enable(struct tegra_smmu *smm=
u, unsigned int swgroup,
>  		value =3D smmu_readl(smmu, group->reg);
>  		value &=3D ~SMMU_ASID_MASK;
>  		value |=3D SMMU_ASID_VALUE(asid);
> -		value |=3D SMMU_ASID_ENABLE;
> +		/*
> +		 * A deferred client is set up completely, but with translation
> +		 * gated off, so it stays in bypass until its driver calls
> +		 * tegra_smmu_enable_translation().
> +		 */
> +		if (!group->defer_enable)
> +			value |=3D SMMU_ASID_ENABLE;

[Severity: Critical]
If a generic driver like vfio-platform binds to this device (for example, to
pass the display controller through to a VM), it attaches an unmanaged IOMMU
domain and expects isolation to be enforced.

Since tegra_smmu_enable() completes without setting SMMU_ASID_ENABLE for
deferred clients, does this silently leave the hardware in bypass mode even
after the IOMMU domain is successfully attached?

This could allow an untrusted guest VM to program the DMA engine to read or
write arbitrary host physical memory, bypassing IOMMU isolation.

>  		smmu_writel(smmu, value, group->reg);
>  	} else {
>  		pr_warn("%s group from swgroup %u not found\n", __func__,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-b4-arm32-i=
ommu-dma-cookie-v2-0-b06842a01938@nvidia.com?part=3D8
