Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFC1CCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13121125EA;
	Fri, 16 Oct 2026 06:47:58 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17921125E3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2WX8Q2oBWRt9tEPVXQCCrviZrXbqqFSJfw2Qsir9j8pgRdT32tb+BIbFGAwaiKatlW4pK8TRDpSnaD60liDx9tx3CTmNpkxfNbc2W91cbfZqHhALIkpMlwBdBKGbgGwWlR/h+Hp+Epn4hJJmIdg2Hy1Evzc0iI2b/shlQCyZ98GNcong6wpOrusFHV9G0EinYsLCNnamrqns4B5Ma307/wYhxeLSvSEgru2TDoXpvznfersqtb+DTZZKms6Q0IYFHaYkXAxuLaXVMRXitq10pzUyrxTCjqfeJbT4I6dkZqMHTyBTlNYA/RQ3/uoUe3U+E6BypyNqwqKBU2M2Nmbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skELHGXYwmVkFrxaXa2Z2ScMh9pbahl9cfXogy+pSyQ=;
 b=ejC+0pngwuzNuJnuEiDDarPxk0Pdr8+y6GMwlfnHZXZASxYYMtCEMDUEir4JeuAUEEVBA2CepUtE4dNQ/raIlbuhL/1c6E1HcVFhE8n973Lbx71rTbYrHJ+H/nC+RFea7UsrIKhUX1Ovtch2SH5rmjIa7jzT55/vh61mm2SwnbmKC1bYLHtMSB7ZwMhq0tX0cjWThkMyCj2VxMCS1Ogx8DEjyClAExpTPaPM5aBYztUjmE27QAY2AbyTd3v1PYzeKO6SJSbqZzdt18xOpxAxOqrW/72D2d9ChMVd6k+lkHwI+lQ4LMLPlMwnxLi9G8G+CO1FtNCypOiX3iwZCSVAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skELHGXYwmVkFrxaXa2Z2ScMh9pbahl9cfXogy+pSyQ=;
 b=D4ZiFTH74T6HKaXyB2xt1UIVnyvIdhckleAviOfagecjkcNqmC7EpsmmnU1HKO2KZcX8xaM+7lhWwWwiWF+gP5aIzfPcZGt1eYNxUCZ2w/OoCYkpZEhE3CwJV6gHRQllFDOSFl47eiFUTNWwLNmRB1TaZmV0P5a/coUDtkLGHF5dzczTMIRnThqijwVNSy9nvBmgt0wosni9AYkmZ5iAGZLvNq+CPy+t+y6SnnrFb0rZgt0qBFrMcegQTa6vVjfVj4N12iEzgSFyd7rb3jle+VO32jS/6uydPvAWLhX5FDN7jdWRhbXEG91weTGvZ4y04y4GpzesH8q6+ONy4XNvXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:44 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:51 +0900
Subject: [PATCH v2 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5b1057-d2de-4481-3d20-08df2b51620d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 75AVFfB3pWUbZVjRewozz1ZHKS5qhsSOY23tbgK1LXGYVq7Mrn+cCjqNz1pCQcmhxXvPgDBX5R9OBiUSW+fxY7fXiMW43YOyty1ohmrn/2Wuh90Gtk4iUZvwpUA4lx8qyjCIWFf8Vb4zsbxWTRfCfa1oJGfacoAudTrZVXFpk3vjUeL1YjkMEecbMEsXB1yyMa7iXeTWUuLct7/yNW31tl5RFtauitp5g2nyp+Ez3StMuym4i8NleZbMotdVOOYYwGxvttIuVUqdAa5CIdVk3enfsU2LAzCSdmsPakSm9yqkQ8swABWtVlMYstDI8ksUzuidTIVOnuPP+1pTzdnplUjZtuU4qDj8LBWrpi3qyj+1Qg2btz4KJtD6wXIm6LAZNiHuOPnatoERuwIMl7GvCW+ZYr+sRILk3yakyvnGxOmwoX+uIsb5r5+xlX5PrEWkPn6EtB9NtqbRsee46+zZxLRUyv0OQI38W9R1xEc6tcoR8N8vaKvOj4spfnSnwh2S/oWmOyUgRUrJQKyGpFMz6XaKe144k3HiwIY8tKudpxcommRHPAhrOBu4/jARnUNaEJQQjrOPd90+XjkknP4cpkc88coJcrmkz7ucVqjKwuA5hbEcX6iZ7/czVFbTi73OOnQ6tJ35E/k6083rnseaeokwBj2JC0ELAKYgMxheGFubX9wI0YJVi35RAbfs9OuGRHDYFqcWO8R/nDmwwpz+hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3prREZjRjRrZm9COVZ5Q2JEOHFoSkxMTzVaTytycHl4bU5QVkJYY241L29D?=
 =?utf-8?B?YlpRVTJ3TnRDVS9kWVpXeXEwYXRXYUprb2VGM2tOUFpFd3ZMVVRIVmNQY2E4?=
 =?utf-8?B?NmlFV3JZM1hrVmIwbjVuaGxPWTJLVWRLN0dXZG9JRm5NWk94VTkxRS9sbjkr?=
 =?utf-8?B?RTN2VVYwbUxBNmZKK1kveC9yOU1kd1JURW5YNVBWREQreFA0aC94ak5oT25i?=
 =?utf-8?B?ZXg1eStVWHVteEhLalVmNTJLdlV6RUdDOHRNTnJZKzcrMnFJR1d0Y08wVEFO?=
 =?utf-8?B?akdQQlZOTTNVZWNLREpzZU5xTzFVMzUzZEJ4OC9ZRzF1aHhBWnJpZDVGdU5p?=
 =?utf-8?B?UllMdldTa3lqMUZVL3plYVUwZ2t6K2hCWmpDcmlHWlgwRlFsQ2l4Mlh6cHJj?=
 =?utf-8?B?RkhBYXgxZ2lSSEdhZzhyRVA3dlljVkg1YjNmM05iMEx6NW9LZFgxbEJQV2RZ?=
 =?utf-8?B?YlViZjBNSEVDR2I4VmdjQWtVZEcya0xhMXczM1hqeXlMdGJaVG9WRmVrZzcr?=
 =?utf-8?B?R212MmNLeGtQWTBGZ1NQaE1tNlNJamwrc25wckpDalBPQ3Z2Y0x0RVhTaDgx?=
 =?utf-8?B?U3AvYkkwcHFUd1hxUWQ5RCtnVHErZlhOQnhKWStHck15QWlUT203Vlh5NkRn?=
 =?utf-8?B?UnowWDMrU2VTSGhMa0grc3l1NEttWG0vSk1pZ1BjOURYMm53MWg5YTgrbVIw?=
 =?utf-8?B?cU5neGFJeWFHeW1sUVl6Vk82aUxyQ0J2UXdOM1A0aWlkdXNWK2RjeDRWeld0?=
 =?utf-8?B?NUVSUWZ4dmdUVkYxMEoxSzM0M0RjUDh0aFkxdlRJN2lFc0NyQ1A1V0hod2VX?=
 =?utf-8?B?TmFGZGdBTXl0b3BJYVk3VlZ2ODBwOGN0WHAxTWxiS2VjVUpjY1FFa3VmRDVW?=
 =?utf-8?B?N0haY1NhZ1BnYThlSlNPd3I4WHVuejlPa1hvVXpWWTk1ejFrZURqV0dHQUNK?=
 =?utf-8?B?QjE4ekhFK1Rra2NBVnRNL05PL0xtQTkxVzlZVkYycTFSbFErR2xEbURKMUQv?=
 =?utf-8?B?dUg4Zml0eTNuQWFXbjZOalNQVVliTXYyN0w1TFlxK21OUUVHT2dpY2RRcStI?=
 =?utf-8?B?SUdkNlo4OUJXbE9FV2Zkb1BJQUFiV0ltUlZNZVBnWWI2c3ZsZCtZb0YwaDZp?=
 =?utf-8?B?VDgzL2VOSi9UT1UyV2NyckdrOTFyaTUra2pLSjVtV2JSVkdzYmozVkZJYUt6?=
 =?utf-8?B?NVQwWGNRVUFvL2ZQOEI0R1VNVGxBQkQraitFdTFrRCtFWkE2UTJSaFArNSt5?=
 =?utf-8?B?cEQzdHRBaUUzWnhiTFpHSGVSc0NPZnBnc0xVbHBLN1dOWkY2a1FoR1UwS295?=
 =?utf-8?B?QjAyb0xPbFZIN2xMNHJ4SS9vRjdYSGRDc013QjRJUmdma1lqcVlyRHREU3BK?=
 =?utf-8?B?Vm9lMlFXVmJ1T2JiTTN2M2JpQnJWRWxRM0VTdE5YMm5TT2hCYWNGaGdPOTJO?=
 =?utf-8?B?S1o2STVBSXBFVWFrMmlRTUhkSGx6YTE0cVdOUGp1VzArVGdxLzhGdzNQRUFX?=
 =?utf-8?B?QkJhOWhUWC9TblB6NVJGK3NQbkpPWlphNXNYUjJucUpTTnZiVXNTZ3NiVkJB?=
 =?utf-8?B?RzVCaUc2SXFRL1BWcXBpd2l5WVBCTVVSeEswOWtyZ2VuOFBVMENRUFh2ZXNI?=
 =?utf-8?B?Y1E3VUc4bjdCeS84UWNOU0wvWk1reC9WNExpUTZEeUY0ZjI1ZHZrMnB2dHpQ?=
 =?utf-8?B?djMrN01jQlR5Zm9Dd1ZjclhneTN0cURrWGNteFNPdktOL0pORFJpcGFrSUJv?=
 =?utf-8?B?akZnenNYQnpZYTNjNUlYN3NyY1RwWU51WDhtVmwzaENSTkhRTXFSMXpKN3M5?=
 =?utf-8?B?R2d6azU0ZjdMdlc4QVg0TnZEaE5rckRrc3h5MXVRN0NhT2p1UmxiTkFWZC9V?=
 =?utf-8?B?YXplZWJRZ002enR2UGZTanY3SFIvend4RWJpN3VQRE1FL1krVUVlRCs0WW1O?=
 =?utf-8?B?THpwcDQ4cUowM1ZLcGVGdks1TExFdWJVbTZLb0p2TFJ0dmNoQzlkVHcybUlt?=
 =?utf-8?B?S1VtckRRckM5UzJHWkhaT05SNkR3cmFmZ3BDaUN5aVgzeTRsbmRGNDk3bC9o?=
 =?utf-8?B?OEkwbGQvNzkyYUI2R2tCbzVFek5PUXkxa0QrS1c4cUkzcWxoYk4rb3NKYUpS?=
 =?utf-8?B?UlhBSzlLcXNMQlFNNE5uMXVia0xvTkRVUWdVM3V4K2N4TGdnMWVldzl6Y1lC?=
 =?utf-8?B?TUFtSXNoKzdTR1FYQVdLOHl3QkJRczY5RFV0bGwyWStWVVBzNE45Tnc3NFg1?=
 =?utf-8?B?VnVtY1ZVTWlyblgyeGpkUk9zTnZXbUFzUXlMcTFwTWp1alNmQ0Q2M3JjaXl1?=
 =?utf-8?B?b0xVdC9HcG9JcjUyejNGQjkrd1ZQTUtOWHU4YlpQSUFRSXI0Z1V5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5b1057-d2de-4481-3d20-08df2b51620d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:44.9119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj3ufSFd8SI8kTevQEnJuqg+pUfJItJX9g65/qfDnb+3pzX2KhHAz3ndTSO26hX2s/vpdNDP6LEkIOmNzS+gxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

ARM's arch_setup_dma_ops / arm_setup_iommu_dma_ops creates a custom
IOMMU domain for DMA API usage, and continues to do so when the IOMMU
driver doesn't explicitly request a DMA default domain type.

When, however, that DMA default domain is requested and the core owns
the domain, we need to skip our own domain management. Add checks to
arm_setup/teardown_iommu_dma_ops for these cases. In such a case IOVAs
can be allocated from anywhere in the domain's geometry, so also add a
check to ensure the device's dma-ranges cover it. Presently, this is the
case for all platforms except some OMAP platforms with a non-zero
dma-ranges base.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f2d3e8ec3487..d6315baeddb9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1761,13 +1761,33 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static void arm_setup_iommu_dma_ops(struct device *dev)
 {
-	struct dma_iommu_mapping *mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	u64 dma_base = 0, size = 1ULL << 32;
 
 	if (dev->dma_range_map) {
 		dma_base = dma_range_map_min(dev->dma_range_map);
 		size = dma_range_map_max(dev->dma_range_map) - dma_base;
 	}
+
+	/*
+	 * An existing cookie means the core owns the domain. Only set the
+	 * per-binding DMA ops. IOVAs are allocated from the whole aperture,
+	 * so the device's dma-ranges must cover it.
+	 */
+	if (mapping) {
+		const struct iommu_domain_geometry *geo =
+			&mapping->domain->geometry;
+
+		if (dma_base > geo->aperture_start ||
+		    dma_base + size < geo->aperture_end) {
+			dev_err(dev, "dma-ranges do not cover the IOMMU aperture\n");
+			return;
+		}
+
+		set_dma_ops(dev, &iommu_ops);
+		return;
+	}
+
 	mapping = arm_iommu_create_mapping(dev, dma_base, size);
 	if (IS_ERR(mapping)) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
@@ -1792,6 +1812,9 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 	if (!mapping)
 		return;
 
+	if (!mapping->owns_domain)
+		return;
+
 	arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
 }

-- 
2.55.0

