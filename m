Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5DBC88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4F410F85F;
	Tue, 15 Sep 2026 02:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hh15l8eG";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AC510F85F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTLnBDnQ9tS+78nkEwl48bKe7yZPxVFW6IqgQUxLF+QoQeZCC5FMSk5Dn67ankFP1X6xfAHhFcBPdK9/Ht+WMhVOZv/n9T4Yw+MutlWCfmpKj48JdWL03u6f0lP4uBaxWzpU0vTZrEAr+dRiBPZHwsnEd2hf72wy5Bu3LySnDsOskK9EL2K1C+R+Hzy6JmSOKatdTjAPmy6HcE14h6ebS241BVg99W12nmhCtjHBtzG4l3a54ipq6ni7TbWy/4m+reIhB/WNQG5RwVDtJNxC8NQ50zX2b8NqZwo3tT8UU4P1Dk8bZyCsBpSEWuob8zdnCRljL3CvpQofO1A0yBfy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDb3wQXN8Pbs/IzKjIEGl0sl0o7yxHkY8T4LnsukhkE=;
 b=Xcg5wafSfT68AjdjzV2Wzer3ow5ps1bXoGfu2he9XPCgK6AZAd8UQm2cUV+qWXj3+zKPIIglpfZ0C1fpER3+xH0ZnQBksTorTUbw+N0JpGqthFr3pKElwdahrh7sqvK6A5NkDRLDpKbTiZ5HglFfRHUEbF+QmI7qU3YBJ5XO6pGtNsTnnnrsyrURlzm47X75dirWtRZcdv0qhf33bXBnav1t0yq41WM//WRcGSarCMiWkK6TyeZOCHACYxuTOF6qJ8ckFoBiRzvMrdE10hPy1GM3kudgxwOgzd9XjjC/0fYv6cfS+XYJu0ghlBWSqfyYEeP3YOsTpBjgspEerNPPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDb3wQXN8Pbs/IzKjIEGl0sl0o7yxHkY8T4LnsukhkE=;
 b=Hh15l8eG8h1GUnslwkSJscP0n0sYbL45JT2UmYNiDHeWlx2LWlSIkLtZZ8Uw6OnBJ8lZYfesUDhioOYDOffYzDAuBiV56xnOPoTBIgshD2DMGTdbtXIeHDIhHrSM+qONU7sw1rt7rBLCRVkIilznjV0kuKvZ3HjLkcgpxE5EHmy2LeVFJceWmFbpjQgPnZDKChhGd3u11JExST6jviIlVDDCtEgQ2gQLqvJRkeDiBqwuT7rZDPcQHjiy7GrhzV6BF4j7/0nVcqpzBoshsYGn6S0bN2fmAPc2dSIsA73+lnt2ag8EVkQjsEmqZGt+2KKH2PtJT5cYxwgJa64VYwqx9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:15:48 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:15:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:14:58 +0900
Subject: [PATCH 03/11] ARM: dma-mapping: Split mapping allocation from
 domain allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-3-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PS2PR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:300:5b::24) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efc565e-cf4b-4400-be5b-08df12cf41f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: v59mDQHhf/p2GfXtnYI9npC0x7SzF3LzStv1ujzXhhXXcADjmc0BjeMwh6NV+gQuzcBDCK9SV2+6rPnA8vhobuhznMFmhyZj9DNbJ2SWpaw91plLeeyX8uVfu3IHJ0Gj+gJCux/uVFiS3Fpi+ZDpHGP3BcnuoDG11WDnTvlB0k/8Bd7rEdpDpZf24LeMiK5O23CTEyP6CuIQ92p+0bz0HF0/uiUEuD57de990bSkjaorScTXyH8rT1uXrMr5RggWZGODG4AWOJttc2/SzOzECt8rtH1WcEY/t8ZtC0hZTr09/kniillhsL+dLr8P8z+xgTyjZzNCARj78+oxcuAzR1c2VPkuPjD0sPle9vKa+imErWIq+d+j2CrsuHHHF9VxKwis6Tt09TiKBuBC1PkcTjLYtLVWrmlfeK05wOEjit7U4Yf9PAWgG+ySbVlZKFnIj8u8azXJZDnqTMupSPWZ0vKNZADzgqFbMUN/xOjp9LkHlOxMdfTMOukVEq9WCzjgdq5N92rK1UTHkUV94t6YgjNXcE0BoWucoWng28aveTYG1w7ayra1IhB8J7gZsN925Qq0JVR1VUUiEg6fXrf7CmIAX+Y9xA8ibvvfDKeIrt/kL1Etihs8s8vLmrwDOzmaKz3pvZK/sCzxkhvXVqiQRFVNZXMoZb/K3pHYFnP348HoRnP9ragPvREO2C4L0Q/CnV/E29I0RB2aPjb+QNm1Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmdaT2dnKzdaYjBvYUpzaW44RTVJRXZPWUlTSk1abGpyZFM3cWJGQXdRZ3hT?=
 =?utf-8?B?cERGTk5pMCs3cWVOTzhBSlp0dlk0eVVaVEtwWjk0bGM3THpVbDJqQ1M1UzFB?=
 =?utf-8?B?NFljdTFiUkNTdGNUcDFzOTdhL1dYYVQ3S3d4T0NGbUJKRm1ScnBQb0ltWCsy?=
 =?utf-8?B?bHB0am4xekdZYUc5K2xNY0pncnhyblBGbmNwT1NKNEp2TWlPancrOWpyZ3pu?=
 =?utf-8?B?Tkhwd0xZWHg1NGZKaXhxRFozS1AxWEZvQmhsTFNGZjJHeTgrYTREenhCZ3VQ?=
 =?utf-8?B?azBweUJHRmxhTGlZazFHYzd6UlBNcTN0MjRNdnFSQ1dJYURmcHltSEZia240?=
 =?utf-8?B?QXhUV0NaZTNYNUg4ZitUeTFkL05XTFloZzRGZDZOK3paaTQwSlVIMGNVSXRq?=
 =?utf-8?B?bjUzOHR2T3lYaGVYWjZWZ3pOVXRBN1ZQOExnaGdKSWI3NmlOU0ZPQTNzNXZi?=
 =?utf-8?B?blc2alVCUWRIc3E2S3RmZ3hTTWdDNkNYbzdkRVZEdTJwQjJhZ2pNNTI5c1px?=
 =?utf-8?B?cTkvVldFUC9hUm9YM2Y4SDQzUGZjd1RVYmpMRWRwTjNmbkdweHJGRGpLd3ln?=
 =?utf-8?B?OWpWY254N1pWemlUK0ZTRExLQ2Q0UXBJSmFTVjlFNVNLbTlvck44Y29OdUZ1?=
 =?utf-8?B?WElUTGRueEwzY0JLZ2pEMnYrbVIrTncyOFV2YWhXdk5Takdzc0MzZk1kQTVx?=
 =?utf-8?B?bTIzbFVHYklFNXV2emVOS2M4dUU2R0lZQ0hETUE2WlFXSEh6L1EyeTFMNUE0?=
 =?utf-8?B?N3VETER1eWE4QmRwaHVuK1plUnk5dUVWVW4zK3A2YnlaV1ZPNTB6TTBwM0NL?=
 =?utf-8?B?MEl2dEgyQzJlRGQzVGJoQ3BYTE9RVC9LVzlCRHFTY0VPd253Rkg1N2V1VUFP?=
 =?utf-8?B?WU5COEFPUHZUNVo4M3U2Nm1NYzdLRTJaNitmc1FrNU5UbjhjRDZqS3MxMjVY?=
 =?utf-8?B?OGlEMVdGT0NheDZsTGtWTDdndlZrWEgrTzVtejNiRitZbUFWRVZ0R0dFREVX?=
 =?utf-8?B?YUYwRll6YUtpOGpqOE1wRnlEVktlRks1NW9aanpsOTR3ZU1rMzJRVUMvbmFz?=
 =?utf-8?B?M0ZxdmZROHRLU3RhekF5SkhoR3ZrTUR4VW1hMGlWc3FHUFNzblBNNmlIZ0RP?=
 =?utf-8?B?aTJPMHpIU0swUytHSi9VaENEMS9rUFRqdkY5MXV5MUFDeVp2SHNrMXUvcXhJ?=
 =?utf-8?B?cUtGWTFxTlZNZXdRWmoybWJXWmRlKzU3dU9wQmR0ckpVNXZjbEhzWTA4bTEw?=
 =?utf-8?B?K3RQTEY1d210VVd3TXZNLzAvaU9MT01odmxlTGNIQ09wZFA1elJHMHUyM2VU?=
 =?utf-8?B?cmkxOG9QUHQ0VkJpL3E2SFZaQStwK25qSTQxbFRxZExTZUNTc0NKYVIyYStz?=
 =?utf-8?B?ZDE1djVwRkQxb1huRGkzMUw5Smt5R3BENmt2UllCOWw1Z0p0d1ovdnJpNGtW?=
 =?utf-8?B?SjdGU3pyZ2Q5Rml5b2NSNHhRaHdkNXo3ZkE2bTZmemZ2REZLNEE3cHk2RW9r?=
 =?utf-8?B?YWpnRFRoRjdJbGs2eldjY1YwbkU3WndMTG54M2kyaEVPb1Q3OTVuTFgrazI1?=
 =?utf-8?B?L0N3UExsS2xwN203SlJPMENVSUd2eERkN3dkODlja011MXhxZGoySHBsRmtr?=
 =?utf-8?B?WDBJOVNvUkFhL0x4RGYxa3kyQkFNcmhITzdpYW51R1BsRVNBWW85S1JrRllM?=
 =?utf-8?B?NG9TMHRMcVRyazRDTFFmMHZlOU5XV0JKdzNhTFhDU2JkRVE2M3Q2T29MQnor?=
 =?utf-8?B?VmpnUStIWFd4b0h2dG1qTGxCV2o5bzlvaWgweTVqNXVubW5FQmhiN0VLdEcv?=
 =?utf-8?B?azBxK0h2c2pQYzI1Tm96TUEvekFOZmR2YW5DbUl2ZnEwang4aU9WdDd3eEh5?=
 =?utf-8?B?a01NWnNwazZhUEVTTEJqQWs1bmRtV0U1N1FzenorK1hycHBhTGxUeXVUeXJB?=
 =?utf-8?B?ZnVQZmdsbG1HVWh6MmFuMmF5WDVHZFo1MUNkbWpGdXdlZ3pGaHJ5SGlROEc4?=
 =?utf-8?B?STRFZ3Y0ekNScncwOXViMG5naEM0dUNaN3NFY2tIZ09DTENsckFOYloxN3d4?=
 =?utf-8?B?RnFnUHpzVTVtbEc5UnNvQU5ySEs3YnZSSEE3K3BVMmhiZXlCaG5IVXh3Y0Jn?=
 =?utf-8?B?NjFyajRXQUQ0dmhjMFpid0NJMmV1RU41VCtiNEtUNmJMMXM1a1NRK2FTRDNx?=
 =?utf-8?B?ck1WVEtORjVBMnM1ZWFMZUtSenB5QkkyYmowcVhGNDFFR0dLWTkyTDVRYzhL?=
 =?utf-8?B?c0N0WTIyMmx0R0dUVzA5aEt6MENSbS9SbmZ0OUQ4ZXZSRmFIbzVsdDRZNkVW?=
 =?utf-8?B?K0k2dHRRT0tES0pHUVJLODg3UURwNnVtcUZ4RmJud0lEQS9OaUVPWXB0RUpq?=
 =?utf-8?Q?qLGx4L2EaQhcIW0UsJxqtRuP0qNCuGPWj5weTh1E3qoa/?=
X-MS-Exchange-AntiSpam-MessageData-1: tlvIR/o62bG/QA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efc565e-cf4b-4400-be5b-08df12cf41f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:15:48.6521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbagr8w8DqpekmwPBNLRFWpZ5YH5wio0UrglMrtXAiigsF/ROIsOJaDTFyhOaIA2KUouxLmJpMz2+7q07rTmpw==
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

arm_iommu_create_mapping() allocates two separate things: address space
bookkeeping tracking allocated IOVA ranges; and the corresponding IOMMU
domain.

Split out the former into __arm_iommu_alloc_mapping(), with a matching
__arm_iommu_free_mapping(), so that the bookkeeping can be created
independently when a domain is allocated outside the ARM dma-mapping
code. A later patch uses this to turn struct dma_iommu_mapping into an
IOMMU domain cookie.

No functional change.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 76 +++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f9bc53b60f99..a7ad194960ce 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1470,21 +1470,8 @@ static const struct dma_map_ops iommu_ops = {
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
 };
 
-/**
- * arm_iommu_create_mapping
- * @dev: pointer to the client device (for IOMMU calls)
- * @base: start address of the valid IO address space
- * @size: maximum size of the valid IO address space
- *
- * Creates a mapping structure which holds information about used/unused
- * IO address ranges, which is required to perform memory allocation and
- * mapping with IOMMU aware functions.
- *
- * The client device need to be attached to the mapping with
- * arm_iommu_attach_device function.
- */
-struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
+static struct dma_iommu_mapping *
+__arm_iommu_alloc_mapping(dma_addr_t base, u64 size)
 {
 	unsigned int bits = size >> PAGE_SHIFT;
 	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
@@ -1525,16 +1512,7 @@ arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 
 	spin_lock_init(&mapping->lock);
 
-	mapping->domain = iommu_paging_domain_alloc(dev);
-	if (IS_ERR(mapping->domain)) {
-		err = PTR_ERR(mapping->domain);
-		goto err4;
-	}
-
-	kref_init(&mapping->kref);
 	return mapping;
-err4:
-	kfree(mapping->bitmaps[0]);
 err3:
 	kfree(mapping->bitmaps);
 err2:
@@ -1542,21 +1520,61 @@ arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 err:
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
-static void release_iommu_mapping(struct kref *kref)
+static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
 {
 	int i;
-	struct dma_iommu_mapping *mapping =
-		container_of(kref, struct dma_iommu_mapping, kref);
 
-	iommu_domain_free(mapping->domain);
 	for (i = 0; i < mapping->nr_bitmaps; i++)
 		kfree(mapping->bitmaps[i]);
 	kfree(mapping->bitmaps);
 	kfree(mapping);
 }
 
+/**
+ * arm_iommu_create_mapping
+ * @dev: pointer to the client device (for IOMMU calls)
+ * @base: start address of the valid IO address space
+ * @size: maximum size of the valid IO address space
+ *
+ * Creates a mapping structure which holds information about used/unused
+ * IO address ranges, which is required to perform memory allocation and
+ * mapping with IOMMU aware functions.
+ *
+ * The client device need to be attached to the mapping with
+ * arm_iommu_attach_device function.
+ */
+struct dma_iommu_mapping *
+arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
+{
+	struct dma_iommu_mapping *mapping;
+
+	mapping = __arm_iommu_alloc_mapping(base, size);
+	if (IS_ERR(mapping))
+		return mapping;
+
+	mapping->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(mapping->domain)) {
+		int err = PTR_ERR(mapping->domain);
+
+		__arm_iommu_free_mapping(mapping);
+		return ERR_PTR(err);
+	}
+
+	kref_init(&mapping->kref);
+	return mapping;
+}
+EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
+
+static void release_iommu_mapping(struct kref *kref)
+{
+	struct dma_iommu_mapping *mapping =
+		container_of(kref, struct dma_iommu_mapping, kref);
+
+	iommu_domain_free(mapping->domain);
+	__arm_iommu_free_mapping(mapping);
+}
+
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 {
 	int next_bitmap;

-- 
2.55.0

