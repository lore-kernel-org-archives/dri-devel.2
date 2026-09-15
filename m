Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D272C88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861A310F862;
	Tue, 15 Sep 2026 02:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ix3MdPnB";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E257010F862
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbpGBbfzU8SZM4HwQC5QLYqOiydOaHsr1hDJ41rRBmi5ee2JiliP3I/eim17veoCDhEl7il62ozeWAD+7Kl+doLGtRhSf05tcDaoYSYriR1vNNXwl6Brny8pp3b7xJLZLFXj56o2qHsGbRD5oOFq7nrKQ6big5z+/FaTQEk3zl2kbIfM4NmTKXSr4k3af9Xsm2mCvLUmHlqtOayFu2X85t44jtdo3ewj9HWG4jr9UwioloqZtsgkRaqH8pJlqHa1quhnM/+GARALHpazpdzDtfzpBkWfouDCKkfhep5lX2rct5gzooRo1GMdzs7RwXA21nk/XE89zXYvRe0oOBtAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTupcniASAaKzcYxvpmVqSWpziKo6ZvVx8jxKLxTw1w=;
 b=TSaNotHQVCpSSPnRpKpChII4bv2WyBH7HRVKy0uFThdemgbR6fSxuJhu9CpIPeGB56fctxrYb/VsWxQ4fbO88vIYtWxkNGWMlOxKA6gtdYdoI6NPBFQoeIiUZCmNkPKGFfk+BJ72aMJ3C/k2g6UzNOCXsOUtWz3SLWrPhZMOtlEgpGELv6KKqSkngzQuRmo07dgpJa+X6kpDhRxei6203H15llPApPjFNvTaDdH5OCezuje5IaTkVjHuOYRTZ3IYgzVE5xz1B9twZsEo/88mpHICkeVfIvHIHnuvvoh1+FKAaHXCAAOX8sq9nYwJP+KXtyu220EQ19MTeSNWaA3Dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTupcniASAaKzcYxvpmVqSWpziKo6ZvVx8jxKLxTw1w=;
 b=Ix3MdPnBV4o/VOLWwyvNxfnelmXjLhU1PltSLzSooD15UXaBPXLM0gR7ljCWkD3n/L+RgErn5o+SzbV1O+d1My/zNkedZ2VHaccyt9YYyx3fOzumAYDdeXbVOVu3NCErshXgEOlgYt3WRmR+su+cfc3cz6Yh3hDh/rbT/2qlVjtqoV0ZmVXQxX4/pWhw27c7sT/QRkvMiWdH9XVsMFPtO4MtD9aq4kFH/393Rvkt3Teq4WonjvZ9U7LBc5NvfQH3Qf8yOKAe1u9kivaE76LgV4+wgaH3xJXaqZ+2/GKeoMULMcGT0zLOVB9UTcm2HqmwjE6lPCGGsy+GNlMG7yB02g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:16:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:16:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:15:01 +0900
Subject: [PATCH 06/11] ARM: dma-mapping: Handle foreign buffers in
 arm_iommu_get_sgtable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-6-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PUVP216CA0028.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16e::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1eff59-4f20-4c7c-f796-08df12cf4a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: gpEsHMCfvwM4RUZn06f2wjZkV3OPHin1FA38kAyOIhp90P19FAAghNUAaEQ3q2iNj0mZ3vPQt8qyyPi4O+C5d/2XUVX/YZgL9wcIyNQE3e9XC/F61srphV0ucticua3G3ozxH98a2nCARZ0H62Rg5bpO3qnmEcny0huKNKnLW6xrYo6iR5BipLY5EumjPipXu2+UEHqVTiK0q7gfJSPuGPWBMRZ9F95PnvlMu72qWx2S/oOyU58xXfvYVlsyP/lBNfSf7Ykb5cF54ancCLRhY6VrScb146KxPAlxp3/FMORiP4HgvLb82m63FH542uwS58HhGQ+OBQKOdlxj+s80pHqEqZzSCn0ICpYjB9a+XgG63p6AbuLOIGzRfp9s2tVcoljkh0CJalIfqO5BpPGpJOutLzAtHJ4QlPjDxBgsCIeRmnUj5OH1BphvFVzKtVbqvYrn15cmy8XRkWgjVMQXR9/10yaOGpWssfwsBUHGUKU4rvpba1YbYchOhYBe7UOmUFx/w415ovnYHi1TIdA+p7oI03WfQjrUf/H5T28GHE+XwseD67JQc/3wf++1NX+ss5djrUUtzUCPxK2zPcQQN9D6XxwscRg2tfUzBl2ahK/PpCNZuAykNhlorUjIzZA+z6B83w2cEklCpzgmmB/i5CMPeJdP2kG8+G84IwQkNmCnOkgMBNRzWGsgbHCJOBAWMzy2S62m3xRvGGm8jVVnuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVZN3VQV1p1R09TNy9GQVM3Zm5GaG1KSmZiYmRQYlIwdXo2R3FHejRoWjJT?=
 =?utf-8?B?YmVBRkRuSktQckxaUEpCckQ5cXFMMWFDOFQzQlVlek1kQ1RMU3I3dGM0L0Ix?=
 =?utf-8?B?UkFxa2hnYUVmTm8zVGhxc0Jzck9uMGtncFlhT1FSRzl5UHN0b2xCTjgwWXFR?=
 =?utf-8?B?Y0wyUzJreHlWOGJBV0RTaGFWc3ZPenFhMTNiOGZocHRmKzAvclBLc0dmYnJK?=
 =?utf-8?B?R091MTcyejA3NlcyMnFHano4YWpJOEM4Smw5MUo2a2ZyK1hPTWtyTUZlNnZo?=
 =?utf-8?B?UDQweEVqM2RVSEs1V2VDd3pXNWR0bVNwN2U2bG52L0dpaFZvaHJMQ3Q0UnNT?=
 =?utf-8?B?THFrbDhsR0l5Q0ZDaXV6T01tSU1PY2hoK1lXUjUxTzB0T05qcnU0NVdPS3l3?=
 =?utf-8?B?WCtvUytVTVFTeVlRNXNJdGNuMkVmQjBKYkU1akVnU01HcTBEVkpLK0xxeFp2?=
 =?utf-8?B?NXZaWjMwWUhoeFl6VDZaNFdBSUFIdzVMMTh6REFjdmNobkNyUkM5dzVYSDE5?=
 =?utf-8?B?SG9OaHJOMmY5VTM4cmVuZ0xocENKQVdxYUlsQ1BWeE53TlpERzkzYkpGaHll?=
 =?utf-8?B?Y09iL2JCQi9nSlBFbEd0ZVp1cDRRNVY5UlQ5Z2dQeGk3YjhJOE92eG1yOVQ1?=
 =?utf-8?B?UnZjNjJscW1lQ0J6OWM5cnZobDVSdUNGa1NWWHc4cVJhYU52TWhMYWxybjV6?=
 =?utf-8?B?K21tcGMvT3k3aDJ0V1cwZGZZTnVNcXh2ZHpQRjQ2b3pQV09HRzlYeSswZjMr?=
 =?utf-8?B?aVJwOXFmUStCVVVPc0p6bSswcE0yL1p4TnNscTdVSkx0V2JUN1FzRjRQMEhx?=
 =?utf-8?B?N2hoWGlyOHJKUjhmSitIaXZYWlViV09MeFd6Yis0YlYwdzNteXNYQjFUdXNi?=
 =?utf-8?B?QjlUdm96YXhjMHljTDFLbkIyQUVMNk5mSTV6aU5CSnJ6OWFDQW5mb0R2Vkd1?=
 =?utf-8?B?L2ZnampVc2NmYyt2RmVVNTQvSTA2aWJjdmtpS3BTR1grZ1FkRmZpdXhmUDNX?=
 =?utf-8?B?OFpzTDJYU2VnNnVZa0lsV1VUNFpEU3V4T3JxT1NJSWNKY1ZSWW1FeWd0b2dC?=
 =?utf-8?B?SkF6ZTl6aVoxQ3k1dzRqYnZONndsSW1BZ1JYTzRrbUdTcUdPZThDNjJmSUZN?=
 =?utf-8?B?MEZiOXpJT0p5SWh2b3NOL1ZPSFdzNndMVkQrK0pseFU5T2FkU0hHbmlTRW1r?=
 =?utf-8?B?MDRIVm1WYmlGYm5EcjU4VXNKOVloOWJoMW5Bbko4dUNIY1F4MGUyVjRVMFNh?=
 =?utf-8?B?NUR2NUhwN3IxREcybTR3UjBTVTVBdEdTV3AyMVV4ZUhJYlhCQUduakNNOHdx?=
 =?utf-8?B?bFdtUW9ub3l1WFNUZnhnWUVncTFOSkdQQUEwSzQ4Tk1NN25uZWtVZ2tPc0Er?=
 =?utf-8?B?NWNlUUVMRnZXRmt2djN0ek12ZHF5UG5tRkJUS3JxU1h4eFdrWWVKRk5WNFVl?=
 =?utf-8?B?RFVaSXVCaFRUL2poT1RqeXNwV3JPczVhNWpCd2ZsWE1WSmI4Zzc3OW9YUFZR?=
 =?utf-8?B?aDdVUWhUT3JnT3VzaDhPdTZDNG1xdm9tcXFCZ1VUNDBMR3dSajdGbUtPaUFB?=
 =?utf-8?B?czFIYVBNcndPT3FsT2ZYRXcxakVvMm0rTUVaS3JhQ3F0VlpWdHd4YzBPQ0ND?=
 =?utf-8?B?ODVHRXB1NjUrREN6NXFFZGtRR09lWjBaYURYb010UG16TE5ZUmVoOFFOcTJL?=
 =?utf-8?B?TFZYQ0NBUWUzME56eW1EZjlKdEx1dlYzWDNPNUVwdUloWkpsdFhCSlpoYUh5?=
 =?utf-8?B?eHhFV0s4ZFZYOHlyRzdCdUExcWZaT0ZPczM1RVQ2T29PeHoxTEhjdWZ1N3Rp?=
 =?utf-8?B?ejV6VkFncTlhZFZPaXdqVUZKWWU3RTFVekNpdlAzSHkrUkhvTks4WHZkbXox?=
 =?utf-8?B?UzNUMUswNmIvNEV1THFPS2RGL0VXUU9Jd0laRFlUOFJ6TGlRQ2ZUbDd6YTRS?=
 =?utf-8?B?Ykx0anBoWFEyaEhCcGk3RDB4T3RlYlFNWWVmV09BZlpiL2YwT3pJeUFGWkJp?=
 =?utf-8?B?aTRFZGZIajlxSEF6NmZ5Z1l6SzFpdEU2dlNHaDYrSDM2YWN6Yi8rTU5CdEtT?=
 =?utf-8?B?QzNERnhDMUFiMWlwc1RlYXBWSXFRcWxnWVNTWXFaVVNoZ1k2RTFpV0lJM3RJ?=
 =?utf-8?B?dEluNkowSE5jdlczaGRFbTRvN0RJbVVkSE5HZnBvR2FuNnR3eTJlR24xZDYz?=
 =?utf-8?B?ME90SFFuRnRLZHVRVVhGTHdaeTNGRkJMRkVOSTVFUG50RTlVS2RTR0pFMytB?=
 =?utf-8?B?UDJFZFFoTWFRWGhxM1dubmVSUGJ0TjJKQTNtNkwzSjR5UDBBSUpJL0FXdE1O?=
 =?utf-8?B?V2JBRkhKN0xsNjVRREt4Mk5CMmlFSWlBZ1FMaHVHZXNOZ0hDU1ZOd3RET256?=
 =?utf-8?Q?aAgExJ227RD6S1D32Ft+23nbn0oDi6ENvuj4wAeMFUecZ?=
X-MS-Exchange-AntiSpam-MessageData-1: vlSx8RIGjdlYgA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1eff59-4f20-4c7c-f796-08df12cf4a44
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:16:02.4683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVmadvcdT6bpCy98fgvtXynyW0GVqdO98je5xKuMJwzLVNhip6QwFBf7/0HcoVe1wN5/Ron42wlXKo4OPY87Ig==
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

arm_iommu_get_sgtable can only describe buffers which came from
arm_iommu_alloc_attrs, and returns -ENXIO for anything else. This is
stricter than iommu_dma_get_sgtable(), which falls back to describing
the buffer as a single chunk.

The difference shows up when a buffer is allocated for one device and
mapped for another, as TegraDRM does. Buffers are allocated on the
host1x logical device, which has no dma_configure and therefore uses
direct DMA ops, and are then mapped for a display controller behind the
SMMU.

Add the same fallback as iommu_dma_get_sgtable().

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 91f12fb91509..22bde6acd1d3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1169,12 +1169,29 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
+	struct page *page;
+	int ret;
 
-	if (!pages)
-		return -ENXIO;
+	if (pages)
+		return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
+						 GFP_KERNEL);
 
-	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
-					 GFP_KERNEL);
+	/*
+	 * The buffer was not allocated through these DMA ops. It may belong to
+	 * a device which is not behind an IOMMU at all, which can happen when a
+	 * buffer is allocated on one device and mapped for another. Describe it
+	 * as a single chunk, as iommu_dma_get_sgtable() does.
+	 */
+	if (is_vmalloc_addr(cpu_addr))
+		page = vmalloc_to_page(cpu_addr);
+	else
+		page = virt_to_page(cpu_addr);
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+
+	return ret;
 }
 
 /*

-- 
2.55.0

