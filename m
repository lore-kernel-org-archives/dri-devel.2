Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00217606A330
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LusYo5e/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6995C10E251;
	Tue, 20 Oct 2026 15:30:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8DCD010E687
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:30:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B008516F8;
 Tue, 20 Oct 2026 08:30:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823C23F7B4;
 Tue, 20 Oct 2026 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792510234; bh=uX61sNx/pMOXT8smCyah17rnMVB+Ex6Ja4uPMIwFAAg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LusYo5e/E9i+iF1dMk4IpxTeUvZsvx2T1cz4iq5jALW9HTUcRxR4K6412qCsht28i
 M1Pj/Fz4RmC/EkQHLKa/8gqjVUH82jWPY+ITsoiZewYZKLNr+Q3hpsYBD7tPJ3HL2/
 APV4RlGoaBr+cY6wATyO0XqANhu+8yQlXbwkpsKs=
Message-ID: <605a143f-d452-408f-9fcf-259af8ad004b@arm.com>
Date: Tue, 20 Oct 2026 16:30:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-11-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-11-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> Everything is now in place for the Tegra SMMU to give devices a real
> IOMMU_DOMAIN_DMA default domain.
> 
> Some device drivers still rely on explicit domains (and being able to
> detach a legacy ARM DMA domain if any), so DMA default domains are
> enabled on a per-swgroup basis via a use_dma_api flag. As drivers are
> converted to DMA API usage we can eventually get rid of this. Initially
> the flag is enabled for TegraDRM and Host1x devices.
> 
> On multi_v7_defconfig (where CONFIG_ARM_DMA_USE_IOMMU was always
> enabled), this will fix TegraDRM probing with certain probe orderings
> where the legacy implementation's lack of support for multiple devices
> in one IOMMU group would cause breakage.
> 
> On tegra_defconfig, as this now enables CONFIG_ARM_DMA_USE_IOMMU, all
> devices move to either the legacy ARM DMA path or the new one. This
> should in principle not cause issues as the drivers would already have
> been verified on multi_v7_defconfig.
> 
> Also set .release_domain to the identity domain to ensure the AS is
> released appropriately now that the domain can be non-static.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/iommu/Kconfig           |  1 +
>   drivers/iommu/tegra-smmu.c      | 59 ++++++++++++++++++++++++++++++++++++++---
>   drivers/memory/tegra/tegra114.c | 13 +++++----
>   drivers/memory/tegra/tegra124.c | 10 ++++---
>   drivers/memory/tegra/tegra30.c  | 16 ++++++-----
>   include/soc/tegra/mc.h          |  7 +++++
>   6 files changed, 87 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a..817e84e0e6ab 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -252,6 +252,7 @@ config TEGRA_IOMMU_SMMU
>   	depends on TEGRA_AHB
>   	depends on TEGRA_MC
>   	select IOMMU_API
> +	select ARM_DMA_USE_IOMMU if ARM
>   	help
>   	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Tegra
>   	  SoCs (Tegra30 up to Tegra210).
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6779528a9e7c..1c1910f25553 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -994,16 +994,31 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   
>   static int tegra_smmu_def_domain_type(struct device *dev)
>   {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
> +	unsigned int i;
> +
> +	if (!fwspec || !smmu)
> +		return IOMMU_DOMAIN_IDENTITY;

Dead code - by this point tegra_smmu_probe_device() has already run (and 
we've literally reached this call via dev_iommu_ops(dev)) so the device 
is definitely valid.

> +
>   	/*
> -	 * FIXME: For now we want to run all translation in IDENTITY mode, due
> -	 * to some device quirks. Better would be to just quirk the troubled
> -	 * devices.
> +	 * Only clients known to work with the DMA API get a DMA default domain.
> +	 * The rest keep running in identity mode.
>   	 */
> -	return IOMMU_DOMAIN_IDENTITY;
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		const struct tegra_smmu_swgroup *group;
> +
> +		group = tegra_smmu_find_swgroup(smmu, fwspec->ids[i]);
> +		if (!group || !group->use_dma_api)

Similarly, dev->iommu_group is already assigned with whatever valid 
group tegra_smmu_device_group() returned, so you could perhaps just do a 
single iteration over smmu->groups for the lookup.

Thanks,
Robin.

> +			return IOMMU_DOMAIN_IDENTITY;
> +	}
> +
> +	return IOMMU_DOMAIN_DMA;
>   }
>   
>   static const struct iommu_ops tegra_smmu_ops = {
>   	.identity_domain = &tegra_smmu_identity_domain,
> +	.release_domain = &tegra_smmu_identity_domain,
>   	.def_domain_type = &tegra_smmu_def_domain_type,
>   	.domain_alloc_paging = tegra_smmu_domain_alloc_paging,
>   	.probe_device = tegra_smmu_probe_device,
> @@ -1108,6 +1123,40 @@ static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
>   	debugfs_remove_recursive(smmu->debugfs);
>   }
>   
> +/*
> + * The default domain type is a property of the IOMMU group, so all swgroups in
> + * one group must agree on use_dma_api. Otherwise the core sees conflicting
> + * def_domain_type and falls back to identity for the whole group.
> + */
> +static void tegra_smmu_check_groups(struct tegra_smmu *smmu)
> +{
> +	const struct tegra_smmu_soc *soc = smmu->soc;
> +	unsigned int i, j;
> +
> +	for (i = 0; i < soc->num_groups; i++) {
> +		const struct tegra_smmu_group_soc *group = &soc->groups[i];
> +		int dma_api = -1;
> +
> +		for (j = 0; j < group->num_swgroups; j++) {
> +			const struct tegra_smmu_swgroup *swgrp;
> +
> +			swgrp = tegra_smmu_find_swgroup(smmu,
> +							group->swgroups[j]);
> +			if (!swgrp)
> +				continue;
> +
> +			if (dma_api < 0)
> +				dma_api = swgrp->use_dma_api;
> +			else if (swgrp->use_dma_api != !!dma_api)
> +				break;
> +		}
> +
> +		WARN(j < group->num_swgroups,
> +		     "SMMU group %s mixes DMA API and identity swgroups\n",
> +		     group->name);
> +	}
> +}
> +
>   struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>   				    const struct tegra_smmu_soc *soc,
>   				    struct tegra_mc *mc)
> @@ -1142,6 +1191,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>   	smmu->dev = dev;
>   	smmu->mc = mc;
>   
> +	tegra_smmu_check_groups(smmu);
> +
>   	smmu->pfn_mask =
>   		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
>   	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
> diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
> index 2883c4f91144..024c63bdd480 100644
> --- a/drivers/memory/tegra/tegra114.c
> +++ b/drivers/memory/tegra/tegra114.c
> @@ -1029,15 +1029,18 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
>   
>   static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
>   	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
> -	  .defer_enable = true },
> +	  .defer_enable = true, .use_dma_api = true },
>   	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
> -	  .defer_enable = true },
> +	  .defer_enable = true, .use_dma_api = true },
>   	{ .name = "epp",       .swgroup = TEGRA_SWGROUP_EPP,       .reg = 0x248 },
> -	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c },
> +	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c,
> +	  .use_dma_api = true },
>   	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
> -	{ .name = "nv",        .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268 },
> +	{ .name = "nv",        .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268,
> +	  .use_dma_api = true },
>   	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
> -	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
> +	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250,
> +	  .use_dma_api = true },
>   	{ .name = "msenc",     .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
>   	{ .name = "ppcs",      .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
>   	{ .name = "vde",       .swgroup = TEGRA_SWGROUP_VDE,       .reg = 0x27c },
> diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
> index a38fbf2baf6c..17068aaf163f 100644
> --- a/drivers/memory/tegra/tegra124.c
> +++ b/drivers/memory/tegra/tegra124.c
> @@ -1071,13 +1071,14 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
>   
>   static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
>   	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
> -	  .defer_enable = true },
> +	  .defer_enable = true, .use_dma_api = true },
>   	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
> -	  .defer_enable = true },
> +	  .defer_enable = true, .use_dma_api = true },
>   	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
>   	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
>   	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
> -	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
> +	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250,
> +	  .use_dma_api = true },
>   	{ .name = "msenc",     .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
>   	{ .name = "ppcs",      .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
>   	{ .name = "sata",      .swgroup = TEGRA_SWGROUP_SATA,      .reg = 0x274 },
> @@ -1093,7 +1094,8 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
>   	{ .name = "sdmmc2a",   .swgroup = TEGRA_SWGROUP_SDMMC2A,   .reg = 0xa98 },
>   	{ .name = "sdmmc3a",   .swgroup = TEGRA_SWGROUP_SDMMC3A,   .reg = 0xa9c },
>   	{ .name = "sdmmc4a",   .swgroup = TEGRA_SWGROUP_SDMMC4A,   .reg = 0xaa0 },
> -	{ .name = "vic",       .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284 },
> +	{ .name = "vic",       .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284,
> +	  .use_dma_api = true },
>   	{ .name = "vi",        .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
>   };
>   
> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
> index 0ee4715413ba..df6b5a499ccc 100644
> --- a/drivers/memory/tegra/tegra30.c
> +++ b/drivers/memory/tegra/tegra30.c
> @@ -1140,19 +1140,23 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
>   
>   static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
>   	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240,
> -	  .defer_enable = true },
> +	  .defer_enable = true, .use_dma_api = true },
>   	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244,
> -	  .defer_enable = true },
> +	  .defer_enable = true, .use_dma_api = true },
>   	{ .name = "epp",  .swgroup = TEGRA_SWGROUP_EPP,  .reg = 0x248 },
> -	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c },
> +	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c,
> +	  .use_dma_api = true },
>   	{ .name = "mpe",  .swgroup = TEGRA_SWGROUP_MPE,  .reg = 0x264 },
>   	{ .name = "vi",   .swgroup = TEGRA_SWGROUP_VI,   .reg = 0x280 },
>   	{ .name = "afi",  .swgroup = TEGRA_SWGROUP_AFI,  .reg = 0x238 },
>   	{ .name = "avpc", .swgroup = TEGRA_SWGROUP_AVPC, .reg = 0x23c },
> -	{ .name = "nv",   .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268 },
> -	{ .name = "nv2",  .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c },
> +	{ .name = "nv",   .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268,
> +	  .use_dma_api = true },
> +	{ .name = "nv2",  .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c,
> +	  .use_dma_api = true },
>   	{ .name = "hda",  .swgroup = TEGRA_SWGROUP_HDA,  .reg = 0x254 },
> -	{ .name = "hc",   .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250 },
> +	{ .name = "hc",   .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250,
> +	  .use_dma_api = true },
>   	{ .name = "ppcs", .swgroup = TEGRA_SWGROUP_PPCS, .reg = 0x270 },
>   	{ .name = "sata", .swgroup = TEGRA_SWGROUP_SATA, .reg = 0x278 },
>   	{ .name = "vde",  .swgroup = TEGRA_SWGROUP_VDE,  .reg = 0x27c },
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index ea67972fd585..1cbd990fc0f4 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -78,6 +78,13 @@ struct tegra_smmu_swgroup {
>   	 * tegra_smmu_enable_translation().
>   	 */
>   	bool defer_enable;
> +
> +	/*
> +	 * Set once the clients behind this swgroup are known to work with an
> +	 * IOMMU_DOMAIN_DMA default domain. All swgroups of a
> +	 * tegra_smmu_group_soc must agree.
> +	 */
> +	bool use_dma_api;
>   };
>   
>   struct tegra_smmu_group_soc {
> 

