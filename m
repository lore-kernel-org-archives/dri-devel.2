Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C725AC88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E866010E578;
	Tue, 15 Sep 2026 02:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NoAkidm2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E5610E578
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:32:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E787C418EE;
 Tue, 15 Sep 2026 02:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70BD1F000FF;
 Tue, 15 Sep 2026 02:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789439529;
 bh=Rn8L3THVcIGq/nwpqyi7bTj1TTxb/tSodcaF+ZGPJgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NoAkidm2UpLEqraCCA/wU4TSLA8oL/kgZYD3v1836rXCGHFy/+xaV3nS5WutmoOcF
 CsWS+DvXmxSUunJ1nHGV2KvR2O9MuDOd6oWChsSyZo1fztjwxv8eY3qMQpD6Z1FFIl
 /EWj9mB6qXMoM0Ov+egQ0Dss8jb+BXL6ew+JWRl2xwP46WQUErdyPer71pO20Pw/gY
 BnXKFMLf74JWwjKeEGhNslPRUVzGnMJ24wpR+Bi0d8c/cqfEFFKeQkb/iiywC1EU1m
 JNgzPrHbWPMZG13Fc/fXhd8oLW1P5YfS2Rb0LZu9J6KzKSTmdPekYTQbHcry8ACn21
 U4W5eIz4pENKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] iommu/tegra-smmu: Defer display client
 translation to driver handover
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915-b4-arm32-iommu-dma-cookie-v1-8-ba4f9d33a2b8@nvidia.com>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
 <20260915-b4-arm32-iommu-dma-cookie-v1-8-ba4f9d33a2b8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:32:09 +0000
Message-Id: <20260915023209.B70BD1F000FF@smtp.kernel.org>
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
- [Critical] iommu/tegra-smmu: type confusion in tegra_smmu_enable_translat=
ion() on ARM SMMU
--

commit 35f909bd1b8b88cf1f8f29602efafacdd3b66778
Author: Mikko Perttunen <mperttunen@nvidia.com>

iommu/tegra-smmu: Defer display client translation to driver handover

Bootloaders may leave display controllers scanning out a boot splash
while the kernel boots. Enabling translation for them without special
care during that time would cause translation faults. This patch
defers enabling translation until the display controller is reset.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 0b3fcc7011b35..2ae4da07bbc99 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
[ ... ]
> @@ -2751,6 +2752,13 @@ static int tegra_dc_init(struct host1x_client *cli=
ent)
>  		return err;
>  	}
> =20
> +	/*
> +	 * Enable translation now that the final domain is attached.
> +	 * The hardware was reset at probe and has not been programmed
> +	 * since.
> +	 */
> +	tegra_smmu_enable_translation(client->dev);

[Severity: Critical]
Does this code call the Tegra SMMU API unconditionally on all Tegra display
controllers? Newer SoC generations (Tegra186 and later) use the ARM SMMU
instead of the Tegra SMMU, which means this could pass a device managed by
the ARM SMMU driver into a Tegra SMMU specific function.

[ ... ]
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 67e7a7b925f0c..6636a044905f6 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
[ ... ]
> @@ -417,6 +423,49 @@ static void tegra_smmu_disable(struct tegra_smmu *sm=
mu, unsigned int swgroup,
>  	}
>  }
> =20
> +/**
> + * tegra_smmu_enable_translation - Release a client's swgroups to transl=
ation
> + * @dev: memory client device, already quiesced by its driver
> + *
> + * Enables translation for swgroups which were left in bypass at attach =
time
> + * because the client could still have been running from a pre-kernel
> + * configuration. Must be called after @dev has been attached to the dom=
ain it
> + * will use. Safe to call for any device; clients which were not deferre=
d are
> + * unaffected.
> + */
> +void tegra_smmu_enable_translation(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +	struct tegra_smmu *smmu =3D dev_iommu_priv_get(dev);

[Severity: Critical]
Is it safe to blindly retrieve the IOMMU private data via
dev_iommu_priv_get() and cast it to a struct tegra_smmu pointer without
validating that the device is actually managed by the Tegra SMMU driver?

On ARM SMMU systems, this private data actually points to a completely
different structure (like struct arm_smmu_master_cfg or
struct arm_smmu_master) that is significantly smaller.

> +	struct iommu_domain *domain;
> +	unsigned int i;
> +
> +	if (!fwspec || !smmu)
> +		return;
> +
> +	domain =3D iommu_get_domain_for_dev(dev);
> +	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
> +		return;
> +
> +	mutex_lock(&smmu->lock);

[Severity: Critical]
Because lock is at a large offset in struct tegra_smmu, could dereferencing
this type-confused pointer to acquire the mutex access memory out of bounds
of the ARM SMMU configuration structure? This looks like it would lead to
heap corruption and a kernel oops during the display controller probe path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-b4-arm32-i=
ommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com?part=3D8
