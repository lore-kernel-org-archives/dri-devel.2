Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F198C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2AB10E485;
	Tue, 15 Sep 2026 02:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QrWB+nVY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1086210E485
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIqOTahlvlN5oPnWu3xDvg2bwacOmBdbPAIIDtHdS3Dy95CLLMVuAWIs97QFNxXJYV2zL4dRI9v2jztn22+YZhcYiv3Lw/bdgNMuzuA9d7bPnoUurHY0SXzPFLrzHipYuovRVUUXdN0602ZfmoCBU/EuIydjvk49zxMW20EoIEI3HlKJ+Hw+sFB/6NPjYMd/CJ2h5o9qoQgmBM3qiKc5ePqs06+Xy0Xnju0WIN+8GcLG8b3TjEWWTdfUw0vo1VrVqWVpZokCF3zU4QzBlJ8SdcTu8TysNFF5qTOoEhwXL2HoELGH+dFZijP3ogXpygDvddziWumxX5iqY9/SgKFwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Sqk7dzFWSPDpk2HNBqojNlNP/2nb4w+qLhWhO1cdqM=;
 b=Sk+uBRz2V7/UBdHrhHsOaQDHVo+9RGdu78Z4VbGsLPDg7MLqHBu3lcEAVParGIsdURwvUIa0k/gXuNwGapsDGOF8wtMAfSLvRjRUlfE21++Ks4qrLFWIEtpCSayeQlDTloyyM8CRFszac9VXPhLxiDqoVHpDbOQchyQ+uWZ1rFibWR73bGJr9MlhwonqOzdsyeimn8sFhH9AZmV6vgfnPLrasYxbroeRc348qYjVfqC/1/QaTPgv6GMs3BwgEUCIG5pfkrlBDGu21j/iBu5ldGBXO9CQzQQrWAGfnyovNHrpF9M7baJk5PJthV/QXcLjNHCGMpt5va49CN5vJW0YLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Sqk7dzFWSPDpk2HNBqojNlNP/2nb4w+qLhWhO1cdqM=;
 b=QrWB+nVYXJEM8hBfE0ygr9YBAGAVIpOppynLsOY+nsFGkspx8SC8eLd6Q76a8YYk4Wh7oKdQIuXnJmgS1l6ibijjDqeE/oWzi67CGQKdRXRBrP/wWAnKHs6r1hCYblDYemjU3JsxIYzNDak8iw+/tbU+UuHsVbunqqwFQ38djHpoWxbzsjfG1yqbYYh2JWlXbwWX0gg0eXV3EI6Oz41NRKwscgL9vG00fKQsJsl3THzY9nxWBmENHzsm7APR8jO/gs6Vh74qgJls/HjiAirBfn4zGlIhXyIul6xc1TP4/+4NW+Jj/imGcpt2jdhfXRcUzuRl1JuKC3qYd3Dpmodb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:16:23 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:16:22 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:15:06 +0900
Subject: [PATCH 11/11] iommu/tegra-smmu: Use a DMA API default domain per
 swgroup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-11-ba4f9d33a2b8@nvidia.com>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
In-Reply-To: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
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
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: PSBPR02CA0004.apcprd02.prod.outlook.com (2603:1096:301::14)
 To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1b3f60-8603-49ea-16d4-08df12cf5673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: pOkuDKPka32OdyMjsinjT6mSRXyBBvBwLD5mRs/Jdy40NqmlIhSoZTR838GspoduVlf7tWeFnie/5J9tO6lJetfjzRjW4TdnyQp+JJF50I0q4CScnRbDqMjMxx6xlP+pVbI1CB8PWsR5UUjgZDHA9L0rDR5W7C5vSFY0QntofN2zVqFppyJjhshzCpI8e3uvxmFoNvKgx6TeXK4/z4fa5HiOddEYX/lwupeAtE4TzYBEGRgch7Lhb6OGZtsmWI7V914IqUd5Gwkj4Gw/vY3PInbn/NbsqQbK9ruajRmX3xAZ3/ZylFbUzkA1WLJSc3hfzydBHXdFsZJadGga6DVBumu/tTuMEdbFwR6dmNjpEBrJtOk2Tfgmrnz3YWA+A3+P7jTb6BnxYu8SA5oeTP98hEdvb+TlpHPzEyTKn7mPMVe02ZdnB6BBcV9jjBvN2A6Mxv4LaYYqKnpwkZVlzgghjZcxsFXxkdeB37sLJ7EbXa8d+adDFuM9jnOshbj0il1WVeSgrkGMHP/aI9vaBAGjZC+X2quiEPe2H2UlZNmJeRyBidEn8eZS8V6jMQiZl6HhpUvruvS0+wamnwx7XmPhkAJsls/Ekl5T3esoUAWIDfwUNKbvApI2/EyBU/gM3iCckV41Kihhbm1jUSY8riM30hudxz0LY+zPO+8q0JMLKezoG4+WnS+VYZZxw5jS1EYioAUBEGyBCMsHZ+vpF7WCwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVprK1lNM3F0UlpaWE4rSU56cG1aU2VxQUdiMGJYeFZDMnhWQk9EMUlWNHF2?=
 =?utf-8?B?R1NBa2FucEoxWnZhdnJCWlNGaE9xalljaXhaOHBaMnpWTC9sMzMreDg5Z25S?=
 =?utf-8?B?OE43NDZJcFY0MDRTZGlLbTVnRG9RQ0FxcXUrWUNjSmhGbGJYaitqSnVma2h3?=
 =?utf-8?B?WEVnNng1MmgyalZnSTRPalcxSks4SThnL3A4SUJSOG4zUGdhVXdSUjRQVXkx?=
 =?utf-8?B?eFNuRlBIQjZzY3VhRTlnNy9MaklJS3U3cXVkaHBTOU95all5ODgxRytSYm9j?=
 =?utf-8?B?RG1WcGlxTGtxeFBhUThaQjBWeHBYNFVpcmRGVWhNeGhOSmNHb1lhNVJaNEZt?=
 =?utf-8?B?bkcrWlIvOEpobkkwV3FrWjN6VFA4NTlwaXU2WW1EWmlmUjZPbFUwa2lUNnBt?=
 =?utf-8?B?YzNnZ3o5RExrcCtHc0ltSWo0QVMrRVliQ2V0akErS2hGdHNGVHkrcHk2blla?=
 =?utf-8?B?bmFkQWdqbTYwRHN3MHAxQmFDaVUwY0hLTWcxekJSKzVHYTBBK3FjTVY3MEJy?=
 =?utf-8?B?ei9oQThnbm1ockNyUGJaU3Z4WUw5U2tmdXZVMGtFRGl1M1RTT05jSC9tZzhi?=
 =?utf-8?B?KzJNZ3R0MjZyZERaMW1pTFdUbTdtYWU3T2VVMzRDYXNrWVRZUEhibnM1SDZB?=
 =?utf-8?B?RWN6Rm5jeE94N3hSSVZhNC8zRWN3VlZrRkpKR1p6Z1B0bGYyRWNheFp6ci9h?=
 =?utf-8?B?dThtME5LcWVwcWs0NEZnU0VjNkZTVEkyek1TZTU3TEtjYUl6U2srR0gyb1Jp?=
 =?utf-8?B?Zno1aFJzcmlYNjJpRWlyaEZNVUNwMUlNNkNHcEpXMWxMa1BBL3g2TGtpSmsw?=
 =?utf-8?B?czYyT0VuTXI2N2x3Y0swOGdyRW00OHBqZGtqSmMweDd5RFBFYVZ5N080eGZv?=
 =?utf-8?B?VWZlcEk3MGJzbFVJT1NNT3ZEQzZFZEhUV255VitZdWFDTHF0Q3JERUpoRkhV?=
 =?utf-8?B?STZyWGdEZW1iUEdzZFljZDZiU3RkZ3hEL0FrVkpSVjM3Y3VhRXdsYUozSXg0?=
 =?utf-8?B?WlAyY1pMTjBZSWxuTDkzTmhUOHc4NnN1VmhlZ05CdlBrS2ZRMG1SbFIxdE00?=
 =?utf-8?B?NndVMnhpVTRrWmRpQ29tZFVBZEI5M244cTk3ZTNIMkVPK2ZrU0t6dVdkeEFj?=
 =?utf-8?B?MWhRb2RnZFErcloxb1BhOFNDQWxmTElsTlpycG1VWVVUc3Q4cE56RElZdE1F?=
 =?utf-8?B?WmZ4ZDh0cUFiWmp5OG5xWFRpSkxpTWdSQWI4V0JlbnZURGUwZENVeG14NHhE?=
 =?utf-8?B?R0NDWTdwMWUrcnEvOWxzVUFTRlcyWkt4ejZnZWdKOU9rbTVodUY5NFJhOUVP?=
 =?utf-8?B?d2JJV0prMk1TZHlVM0R1Y3dpaitQcm91V3dDa252VHRCcE04Sk5YYTNqV3I5?=
 =?utf-8?B?OHA4b1hRZGJvSnlwM3ZQeXRGam51ZElTVEMxNUsvWERYVVNjM2tmK0ZGV2Q5?=
 =?utf-8?B?M0xxcGhBQ0ZWeDNxN0cybkF6Qis4OU9ocUdpbjI1L3NoZy9qVWp2eUNDdGZ2?=
 =?utf-8?B?Ull2MzNmOElHaTB5Tk9PYnA4MVZweDNpaFpNdnNuMFpZZmNWMEVpY0Z3MWJD?=
 =?utf-8?B?akZCNE9EVzFUUG1mRmtqQ0todkFjR1hIcGJsMmdUMFM3bEJRQ0l3UnlOVXdq?=
 =?utf-8?B?V2lSbG1wSGU4MDZEc0VoK3RhdkFGTkNKZjludEVsM1JPcW9xOWxMN1hQTDlj?=
 =?utf-8?B?SWsvVFptRmJrWVlhZC8vblpkaW5QWE9MSWJuNVphYXBBc05FZUU4d0QrNzhG?=
 =?utf-8?B?NkRPUGl5WjhSZG5GcEx2K29VTWNzM2NFTGd5ZEhjS21jRDBnNzQwOXRDcjVx?=
 =?utf-8?B?ZmdUemRrQzNnVkI3VHh0Y2RhekRkU1Y3NDg3K1FUdndjVWJoSjlldzUyRzBi?=
 =?utf-8?B?OXlicU9ONmtwSWlKRnNHMmNZQmF5ckhqK1V5WVVXbmUyZWVLWmQrcEpZWHVz?=
 =?utf-8?B?UTZzeHZDdk9qSnBGbGdQWWJoWGt5TDg4a1p0WDFoeG1MZDZ4UjNCYmFYdHlZ?=
 =?utf-8?B?bVBoekhyOGZnWXcrOU5kRnRYRnNrV3gwbzlxWlBiQUNkOHlMakJLTUQrR3Nn?=
 =?utf-8?B?aUNtNXZwSjlSclJ6bnBnZDZLNGtkSmRIeFRzbDJTZGN3RU5JQ1FXM0FWMWlD?=
 =?utf-8?B?dWxJc2NsSWtmNXZwdzRQNDlYQmRCdkt0dFRZMWdiZHAveTNRRzU3Mk4zcEpO?=
 =?utf-8?B?dGwvbHNJRldYQnRseWtOdDlCdDY2U2pmRlRIendGdERYVStEOHVwM2pOZUp1?=
 =?utf-8?B?c2xpbFNpNHNCNTZoUmxTbkY4ZS9nWG9mMnVpYVRhelljV1E3L202SmxTSFNY?=
 =?utf-8?B?NkVsTFRQbmxDQzNPQXBUMlFjQnkzVWQwb204dWdqeHgvNVVERVdjeUw3V0NY?=
 =?utf-8?Q?sXO1bDnXUhd3WDhfO2DU189gAHy0eGMY1yNKSM2gPshaW?=
X-MS-Exchange-AntiSpam-MessageData-1: Yyr2qVI29aYD/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1b3f60-8603-49ea-16d4-08df12cf5673
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:16:22.8847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mq3scNwuXO+LDLN7X9SKJxNV/tTwgNWk8dVc1wcr2uI4/4nYWDdzW1zC22uJYcZ9S/d+5W4LTteJuZsxtI4nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Everything is now in place for the Tegra SMMU to give devices a real
IOMMU_DOMAIN_DMA default domain.

Some device drivers still rely on explicit domains (and being able to
detach a legacy ARM DMA domain if any), so DMA default domains are
enabled on a per-swgroup basis via a use_dma_api flag. As drivers are
converted to DMA API usage we can eventually get rid of this. Initially
the flag is enabled for TegraDRM and Host1x devices.

On multi_v7_defconfig (where CONFIG_ARM_DMA_USE_IOMMU was always
enabled), this will fix TegraDRM probing with certain probe orderings
where the legacy implementation's lack of support for multiple devices
in one IOMMU group would cause breakage.

On tegra_defconfig, as this now enables CONFIG_ARM_DMA_USE_IOMMU, all
devices move to either the legacy ARM DMA path or the new one. This
should in principle not cause issues as the drivers would already have
been verified on multi_v7_defconfig.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/Kconfig           |  1 +
 drivers/iommu/tegra-smmu.c      | 58 ++++++++++++++++++++++++++++++++++++++---
 drivers/memory/tegra/tegra114.c | 13 +++++----
 drivers/memory/tegra/tegra124.c | 10 ++++---
 drivers/memory/tegra/tegra30.c  | 16 +++++++-----
 include/soc/tegra/mc.h          |  7 +++++
 6 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6e07bd69467a..817e84e0e6ab 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -252,6 +252,7 @@ config TEGRA_IOMMU_SMMU
 	depends on TEGRA_AHB
 	depends on TEGRA_MC
 	select IOMMU_API
+	select ARM_DMA_USE_IOMMU if ARM
 	help
 	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Tegra
 	  SoCs (Tegra30 up to Tegra210).
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6636a044905f..8a5c3f80fcff 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1037,12 +1037,26 @@ static int tegra_smmu_of_xlate(struct device *dev,
 
 static int tegra_smmu_def_domain_type(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	unsigned int i;
+
+	if (!fwspec || !smmu)
+		return IOMMU_DOMAIN_IDENTITY;
+
 	/*
-	 * FIXME: For now we want to run all translation in IDENTITY mode, due
-	 * to some device quirks. Better would be to just quirk the troubled
-	 * devices.
+	 * Only clients known to work with the DMA API get a DMA default domain.
+	 * The rest keep running in identity mode.
 	 */
-	return IOMMU_DOMAIN_IDENTITY;
+	for (i = 0; i < fwspec->num_ids; i++) {
+		const struct tegra_smmu_swgroup *group;
+
+		group = tegra_smmu_find_swgroup(smmu, fwspec->ids[i]);
+		if (!group || !group->use_dma_api)
+			return IOMMU_DOMAIN_IDENTITY;
+	}
+
+	return IOMMU_DOMAIN_DMA;
 }
 
 static const struct iommu_ops tegra_smmu_ops = {
@@ -1151,6 +1165,40 @@ static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
 	debugfs_remove_recursive(smmu->debugfs);
 }
 
+/*
+ * The default domain type is a property of the IOMMU group, so all swgroups in
+ * one group must agree on use_dma_api. Otherwise the core sees conflicting
+ * def_domain_type and falls back to identity for the whole group.
+ */
+static void tegra_smmu_check_groups(struct tegra_smmu *smmu)
+{
+	const struct tegra_smmu_soc *soc = smmu->soc;
+	unsigned int i, j;
+
+	for (i = 0; i < soc->num_groups; i++) {
+		const struct tegra_smmu_group_soc *group = &soc->groups[i];
+		int dma_api = -1;
+
+		for (j = 0; j < group->num_swgroups; j++) {
+			const struct tegra_smmu_swgroup *swgrp;
+
+			swgrp = tegra_smmu_find_swgroup(smmu,
+							group->swgroups[j]);
+			if (!swgrp)
+				continue;
+
+			if (dma_api < 0)
+				dma_api = swgrp->use_dma_api;
+			else if (swgrp->use_dma_api != !!dma_api)
+				break;
+		}
+
+		WARN(j < group->num_swgroups,
+		     "SMMU group %s mixes DMA API and identity swgroups\n",
+		     group->name);
+	}
+}
+
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc)
@@ -1185,6 +1233,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
+	tegra_smmu_check_groups(smmu);
+
 	smmu->pfn_mask =
 		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 2883c4f91144..024c63bdd480 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -1029,15 +1029,18 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 
 static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
 	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "epp",       .swgroup = TEGRA_SWGROUP_EPP,       .reg = 0x248 },
-	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c },
+	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c,
+	  .use_dma_api = true },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
-	{ .name = "nv",        .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268 },
+	{ .name = "nv",        .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268,
+	  .use_dma_api = true },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
-	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
+	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250,
+	  .use_dma_api = true },
 	{ .name = "msenc",     .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
 	{ .name = "ppcs",      .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
 	{ .name = "vde",       .swgroup = TEGRA_SWGROUP_VDE,       .reg = 0x27c },
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index a38fbf2baf6c..17068aaf163f 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1071,13 +1071,14 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 
 static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
-	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
+	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250,
+	  .use_dma_api = true },
 	{ .name = "msenc",     .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
 	{ .name = "ppcs",      .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
 	{ .name = "sata",      .swgroup = TEGRA_SWGROUP_SATA,      .reg = 0x274 },
@@ -1093,7 +1094,8 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 	{ .name = "sdmmc2a",   .swgroup = TEGRA_SWGROUP_SDMMC2A,   .reg = 0xa98 },
 	{ .name = "sdmmc3a",   .swgroup = TEGRA_SWGROUP_SDMMC3A,   .reg = 0xa9c },
 	{ .name = "sdmmc4a",   .swgroup = TEGRA_SWGROUP_SDMMC4A,   .reg = 0xaa0 },
-	{ .name = "vic",       .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284 },
+	{ .name = "vic",       .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284,
+	  .use_dma_api = true },
 	{ .name = "vi",        .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
 };
 
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 0ee4715413ba..df6b5a499ccc 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1140,19 +1140,23 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 
 static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
 	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "epp",  .swgroup = TEGRA_SWGROUP_EPP,  .reg = 0x248 },
-	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c },
+	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c,
+	  .use_dma_api = true },
 	{ .name = "mpe",  .swgroup = TEGRA_SWGROUP_MPE,  .reg = 0x264 },
 	{ .name = "vi",   .swgroup = TEGRA_SWGROUP_VI,   .reg = 0x280 },
 	{ .name = "afi",  .swgroup = TEGRA_SWGROUP_AFI,  .reg = 0x238 },
 	{ .name = "avpc", .swgroup = TEGRA_SWGROUP_AVPC, .reg = 0x23c },
-	{ .name = "nv",   .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268 },
-	{ .name = "nv2",  .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c },
+	{ .name = "nv",   .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268,
+	  .use_dma_api = true },
+	{ .name = "nv2",  .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c,
+	  .use_dma_api = true },
 	{ .name = "hda",  .swgroup = TEGRA_SWGROUP_HDA,  .reg = 0x254 },
-	{ .name = "hc",   .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250 },
+	{ .name = "hc",   .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250,
+	  .use_dma_api = true },
 	{ .name = "ppcs", .swgroup = TEGRA_SWGROUP_PPCS, .reg = 0x270 },
 	{ .name = "sata", .swgroup = TEGRA_SWGROUP_SATA, .reg = 0x278 },
 	{ .name = "vde",  .swgroup = TEGRA_SWGROUP_VDE,  .reg = 0x27c },
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index ea67972fd585..1cbd990fc0f4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -78,6 +78,13 @@ struct tegra_smmu_swgroup {
 	 * tegra_smmu_enable_translation().
 	 */
 	bool defer_enable;
+
+	/*
+	 * Set once the clients behind this swgroup are known to work with an
+	 * IOMMU_DOMAIN_DMA default domain. All swgroups of a
+	 * tegra_smmu_group_soc must agree.
+	 */
+	bool use_dma_api;
 };
 
 struct tegra_smmu_group_soc {

-- 
2.55.0

