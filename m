Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147E6CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E3A1125DC;
	Fri, 16 Oct 2026 06:48:28 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018BD112606
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBIFU+qKCr8t0dr3DIAkjyDCD1zHEHVWFTvE/sMdnepDNDBPDinSMoQxLPA1FlTSQv+ylBt4UhJamU5HpPvYN/NxvDSwaxZKf6im6eLnEtMQ9d53/w9tremakHOqfjE7aljmtVkrxRKpUWTJHK/f2Y835xXDeZokwckdkn6iTJ6TTMB0mCcHcr1uYC7iT/kbBANAieO4G+IlzeK3U16M1dlp/l00DPdfFAw0gKG2uw63ZiXbrfZPSlw61SiYAG1HkzxiU+aQFa2O5TyI8uETs8WV8qAnVKkEdkKfuGUfDMq/eAQsB6QRyvMq6ti1D9IpxaVHM3QywjXwYv9xwvccrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y97hwP+flT/vPrFqBcYtLdYmPpHLrKi3GlINWNUKI50=;
 b=c5algmkVlX0PdpFGsuV1smq7KBqoIzarkO49QAw3ywcDUIc50gwkH2TnxzfGXdG2QZfORx7Z7JOpl8C8jArgT41wIYGRuSXKPR/jkpxbLIYyF1EoWO+6Hn1vFjCRnLq2fk5AGp5gBD/REU5gJZsQacktjFq5eS7K0OUY6UMt+QdGuOJz4nBFyo9nwMZfLb/dIyOgWvX1KZNqkIIQ2oSQR9rRzYnnSM0Zvc/zxA8AcUTRyGlQ5H+9Zx1LhHshzO34Xcur9ZAewf5H4gnp2phbM5Qmo+5fxfnimbyNLH+Cg22t2hqUWhAIQmWK9FUUjy9L3dhvut7jZW6E3bG5fw6cXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y97hwP+flT/vPrFqBcYtLdYmPpHLrKi3GlINWNUKI50=;
 b=BWOfu16o46IT2NGFgcMW/VekJelZHQYKHEFsls8Q+Hf3v58JQ7C++Wj9rbetJuzzR6no2aW0v6/FCk7mFKCmLhuzHIRfGxaCHvxAhQpO/S7FKz4g2h8ZKI7f1Iy58+g9/lXaeeaVjnBlitE0CFr5RM5i4RVkEMof647RdmW7KIqNn+SZJnV3Yx2P+1hGw33QxDqdhL2lOpC3WkApuIEpBWu9nFvXRUabnqc7fK7E9C0s1CF34eYdffnyaebelLkTa4WpQGEjrnr6KDmmWsclPQZffYglkJo0Jta9RpIEMHTqE2CvmHAQ9IK84QXBjYfnEclWzDonWP2S2i6L9fvl2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 06:48:16 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:48:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:57 +0900
Subject: [PATCH v2 11/11] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-11-b06842a01938@nvidia.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 904cd8ae-c0f2-4804-0467-08df2b5174b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261009223027099003|56012099006|10067099003|921020|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WugfJ24CEX1SMZqAR0/maKD1IabjLqy7nrwagl/jg/6i4thxbk9fJ/VdusMBOlPdDwlXnz3rZ49ZBOmTePJlXu0mqso9kadrCNoEky3cP+1IcebMCyFH0OKzLK0To5GKtLeboISO//bsY7ppkF0jXWxmkGxzoZ4utxzdyumt282BOLliOSYsaKjEgS9yIABnOFOJGVyyHqm689TOvW5ykGAWb6MFpw5HLvDs2rqHowK8jczOXMU8E2zYMXJTTTp23VGK+zZLsdeDFzwmOAjhgPnfS+j4d8HodeQWjmbSr7hAMoTAfnkTpLuBGgilvTjzjRaN263vUaGFvUXYRLq2kpWOt+8JwSIxv+0kcShdoqWn8Hy0pcja+fzCT1ufObJbRN2d0CslJN3z6Ekxvbfum2DuSo+MCYQQCq5vfnFdZzdZRldrLecypv80+YpA5xkEGGHo9iw5/vOHNsJh5oLyM8XnrgHuT1/q8undnUaZ/qXeKythNii8KBjEfppR9dnQ8ZFfS7G6XKZEXml8+ZPOzBsSJ74lIUJArDf8gOorh0fb0Mc5rodM81QBMCwUZ+MNAynGaNqQRuOwhh1GkIojuw9O3ACFrZLZxD1EcR9dTQXVkhuUcr9ar23Pw1K9MtnS/rNNjYAAg6K3ouAtDpRPYkwlf0G6IntH+qxITTVc0yWl96Rya4d4aLOXAd/Exub2vLvLE84+JIOuyN7QBRhP5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(56012099006)(10067099003)(921020)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDMzUVBZdTBEZmhSRkxMT3NKZmtTVFVDaklMK0hLY2JFOUVYWXk1d3ZhdkVh?=
 =?utf-8?B?NzRqME9FRXVnTVB2U1NNN2JNZzk4YmJuMTRON05jbEF4OUcrL202SzkvUkN1?=
 =?utf-8?B?VXlSZTl6SEtRdzZsSnRDOWpuTzBSQ2NGeWFnYVdycks3QlFYcUdtcVdSWEVN?=
 =?utf-8?B?dnYvNEt1NHovaWZKdWZwVTUrY3NmbHN3dTBFNG44NWRyb3dEajk0THNQckY1?=
 =?utf-8?B?MUUvbEw4RDM2UlNqN1M4WWVQaHp1NXNQeHhLdVFvelB1TlZ6MkxDMTB4T3lv?=
 =?utf-8?B?b3ZZWkQ1V2k2Q3haSVdFejNNc1VPUGdLZ2Vha3dnZ3dzK01oa1ozZU00RzA2?=
 =?utf-8?B?bUhJN1dndWRXMFVWaGk3NndKY2JCV0VmRFA0VkUxaXRyRjgzbWRia0tSQWQr?=
 =?utf-8?B?Um9BMDdMZlQ5MGVQMVZOUWhOSnlaZVEyR1hEcndkQ2lzMVpwaDI0cUpZUkdu?=
 =?utf-8?B?N0NHOG1GREFMYlVsMlFTYzVFdU93bXNRUU1SVGwrRHRXUDlNTTRqZHJKbmh5?=
 =?utf-8?B?YXhWRlVrUGRoTjBDUllFejdQaGdTaGJJdy9GRE5YbWxqR291eXlSOEwrekpp?=
 =?utf-8?B?ZmRaSWVlMkRrV2UxSWpYOFFlQTh0TGZEaGYrNVAxWExpMGJjbDNwUmR3b2dL?=
 =?utf-8?B?WDFZRFIzTEdtTjRMSytUSTZQMFNSM3lLQ24zZ2RERXlIbi9NY3M2bnFYTjF5?=
 =?utf-8?B?c3g0SDZiZ0VqSXFtQlRVTVVRRzFMamRwTUE0alo3dGs0OEJKNkFaMjJlVXg0?=
 =?utf-8?B?MSthZVZvYzZSUXMxNDZmc3c2bTYyL3hhb1hYVlB1c05kcFgrNU5KNkRDZzUw?=
 =?utf-8?B?ZjZXclhRVDd6bGNpRnhlRjFhQmkyendoblBvOXhOUmJnN1ZHRTIvanVwbnRx?=
 =?utf-8?B?emZjbTZMZS9GTUE5QjdTQit2Yi9UYVJibGdBVDhvTlpRenBpbjFLUGxkSHps?=
 =?utf-8?B?YlE2NDdZbEpjWjFKQ2hHUVJGTGd1eWdncEZhR1dEOGMwSUIrUjlRTmZtWEhk?=
 =?utf-8?B?Rk01R2NIUSsvamYrNkJtRXc0dVl5OHdLbU80RUxhckhaU2Zxd3JtYy84SHph?=
 =?utf-8?B?eXAwVmNMbTVXM1hrUW9vK001NkdCSUtyazAwZUl2S3JPMU82cThCK0JCcW5C?=
 =?utf-8?B?Y3JLQW4rR3FWZkMyU2JoUWt2QnkvYlRNUkZ0M0tPdjlzWWF4OUR5aGxHNlh5?=
 =?utf-8?B?a0V1eHFta2N4bzg0bHVOZUpucGVIeHlmMnZzbENvTlkzVEJ4L29kVEVGSkF1?=
 =?utf-8?B?WDI2UGdyN1RpRFJXcVFuREZIK3JORGpUd1V3WTJtbVZGUG10MEVORWdKbVlU?=
 =?utf-8?B?VVZuRjN0QTR1VlFJd2RWMGRsK1hONDlYRVJJSmdFNkNUR2szZUN0TUVVWVpr?=
 =?utf-8?B?bFkxaEdKVTlOWDlESFIwU0tGY01oZi9HeHhHQlMzeHd0cGQya0l1SG1RMjdn?=
 =?utf-8?B?SUpYa2dFc2VJMkc4TTh5ZTR5SmQxc3ZxTHpxMW1EbFN2VTdkSmg4YlozQ3NC?=
 =?utf-8?B?RVQvTWxqdVBsblRTY2U1RjJkQWtaRWFSZkhrcFlHTDR3ZmFOUElxUG05SUhQ?=
 =?utf-8?B?WjEvMjBmVVBLUnlaMmI4bHJaZll0MnFZVUpyeExiQ2RSUG83OHRkL2dQbHA2?=
 =?utf-8?B?VTNkc3JtTlhac0JoUHZJb2xaUzhNWDZNWVNQdkxTMWxFdUxSUFhBeUpzTTQ0?=
 =?utf-8?B?V1ByZGd5K294RDlxazZObFFKYmpBRXVIWmJhNUFvV1pDRmcrNkRGU1JZWi9v?=
 =?utf-8?B?a3JGcjM3dmxpeEZROHFYcmlwaTBDY2VEYmh6T2hYVzY5aXgzNk1ib2dLMkFX?=
 =?utf-8?B?WFF4R1hhVUtOUEtPcEd2MXJNUXpWdWlLeXZodGd2M1pWdGkvRFZ5WnFYZ3VS?=
 =?utf-8?B?SXAxa1l6NkJ6aURJMldYbE9DaEFzMGQxMEhuMnpSKytMY1hyTFhrQ3lWb1pV?=
 =?utf-8?B?QWI5c0M1WkJLYzg2dnlPUWJZTitBYjJZdXFGT2NHRXpCN2tVYWZrL1J2ejFC?=
 =?utf-8?B?c1BpVzRQMStLZ0o5TE5QYVZyUWUxSk81TWFaRUk0YjVuNE9VVUNqcld4QytY?=
 =?utf-8?B?L05NN0ZBKzZLYzF4N2tjREh2K08xVzRRdndFdDFmVWVHNDZRYllqYlJTWldq?=
 =?utf-8?B?aUcya3ZVV2ZJZzZzbHlrcjVyc1daV1dhejl2ZHQxQjdaenFyQlJ3K0VRTjdR?=
 =?utf-8?B?VjIrTHhVeE4ySHpQd00wWThiRGpRZ1RBL2dKb1A1MTZ2eUwrMnpnZXdTdWx0?=
 =?utf-8?B?Mkh4T1RZc2RXaTdUV2FKbGIreGF3Y2NXTG5LSXNxaysvVjE5anA5emlnSWdF?=
 =?utf-8?B?NWM4RUQ3eEZjbE5TbjZZQU9lUUtaMjJ0RUtTUnNpWXZMTWRaMG9uUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904cd8ae-c0f2-4804-0467-08df2b5174b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:48:16.1010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8wwa3zbG9LwZ55PaQTpRfk9Y5/OOZgfVgDJZeGM2U+JLLUfUh+6mef5wxiV2pVXoDu++sZKB9+PxifxlG654g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Also set .release_domain to the identity domain to ensure the AS is
released appropriately now that the domain can be non-static.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/Kconfig           |  1 +
 drivers/iommu/tegra-smmu.c      | 59 ++++++++++++++++++++++++++++++++++++++---
 drivers/memory/tegra/tegra114.c | 13 +++++----
 drivers/memory/tegra/tegra124.c | 10 ++++---
 drivers/memory/tegra/tegra30.c  | 16 ++++++-----
 include/soc/tegra/mc.h          |  7 +++++
 6 files changed, 87 insertions(+), 19 deletions(-)

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
index 6779528a9e7c..1c1910f25553 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -994,16 +994,31 @@ static int tegra_smmu_of_xlate(struct device *dev,
 
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
 	.identity_domain = &tegra_smmu_identity_domain,
+	.release_domain = &tegra_smmu_identity_domain,
 	.def_domain_type = &tegra_smmu_def_domain_type,
 	.domain_alloc_paging = tegra_smmu_domain_alloc_paging,
 	.probe_device = tegra_smmu_probe_device,
@@ -1108,6 +1123,40 @@ static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
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
@@ -1142,6 +1191,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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

