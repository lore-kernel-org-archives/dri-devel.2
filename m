Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF92CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD15E1125D0;
	Fri, 16 Oct 2026 06:48:03 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E3E1125C6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcJSm0LUu6ExEk38xsgDwdfL5YHTUJVXWRKQFkinVql+XDaMWnjkRE1I4FosFKXgEJW5CczfBrDRBga1ZtdaLMMSJjIZTgTzu/PZnOg7jYQdfXUhDB/T7yLhIHHZH8LZbs+sIPlW5wwVyTmiTzQVrKU/yj/FZJe+aorZ67Swkpp3+fIEmWgN5H3Dpd2aBMYyPyzyqGWAM6TW2k1dt/Cn+Ga0lP2cAovPDhBNUTz6fFeypVuV1VEJPP5pfZoWQzTV2v5h44dEgXTcRyZsGdGsMxkRXG4Xf4WqakPmritz9TuE/sc+AMBxXPQv6wLHqlXbD+dkKDycUJd0u9y4C5fwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKncnokfbJ8SteKLkFGkQGQ32ITZUXkxtVj8A+Wa2yU=;
 b=sl7m1O0PjO5P815EHVnAuLdkGg3utRQaxjOWuTbRnIQNYQNSsjUtNnzPeyq1XAB56rk6qGOzKwq4xvDs9dVlJWY9RksnRjKWeo5CA91aEq6LNgVzu2ruy65L96AzhXzXrKW7WDMxNnntSEGdb4tkbATbMZkam7N47TWpAYo1eo/mfXXAQsN5giShKCcocrSnp0fg0Z5Pxdrl+ODZbEEho6+GBIVSX+jGcxEXVyuiorlwMIAh9CruaqtoX26NBXJbJwkQyHgtZUrRVyr0EKh3GNBTBgqnBO4GOZJphlE7AAI/rkzWEZv+FOmeQdD/Fi3hMAHC8pvt4oKvsvdQ6aDoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKncnokfbJ8SteKLkFGkQGQ32ITZUXkxtVj8A+Wa2yU=;
 b=EMyYY6RO22oFI0YWbTP0cLQyd6DZcqtbalFwwTjn5UTGHXb8uGC923tbiZLZVrPrwFgQ3wXg69Te3o/GkGcSY0PJGATVlRKHc9u4Uh8+psWQ77O7CMz48rNpH8tfVe5zBS9/ibQKymBwstwzKJwj0zQ0gVHOF+8fmCC52yQo82SzJmuK7BQVmCEz35Vdhv573YecffsDYHa8UcATiRwFEKBPubjgiKDcSHKcTSF//8hnYHNAjpkXa+VJyrKLrR48kyg2tfECPTdOxYBkywlKoA4gRUDYW+C1UM7dDQQAIQ3UnuKglV1Ckx7rwXHb+AYCnAV+RE+wn5GaeNDs7Ick+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:50 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:52 +0900
Subject: [PATCH v2 06/11] ARM: dma-mapping: Handle foreign buffers in
 arm_iommu_get_sgtable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a1b43b-3f0a-4348-90dc-08df2b516525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: aRExBvcp5/QIaxlAx1dEvhYuCF/U7tahA3n36Va6zEdCKOG9bs5JY3qwv1kMBE5zhElttwN8avcIUzEg8Ka4kWflIQhgtuI6yxvQnCA18tvTOtYEBIJb/6diVqaP1/gfze4rrAUvYF0Muh+M4BU4iB7HCiV85cPyZS4qcqFYVmcSY6Km6ha/IiYPeRpsVDTgS3QUViq7uU8o3qBZS27NwU0EajGpwosilRBUJSYhNqMwmNT0cFhaUBdFsh/rE/1YgYsXLmm6FFUo/HAI94Xl4tHT7z/yqLDK++qNvEHYeSvTJPpOGEWvwsH+6+Ms74BnY0tmWbfSY5hyJLrWzp6qukbuurClbe/YcHIO0nTO9lZT097lJTCPiNV+v2yN5r9YPUnOZbv9d/tFc9HL6pyMKW8D5XMq+4yuYvpAiRUrj6BA/EUEpKGZ39eileYgSW12bW8BvKFHiUueOGwTConGZBX84h5hSx7wcIRhNHRQf+c9vqGkAA1gTx9NbudGsJ86exsGN4FGfOCctgCs+69j1tL4oRi0NzYZO706P/aZdg6gjRvX2Xop2f3yDu/sk85OD+wvqaqzFwN4Prqoq02weR3nIiIgMS9C/2RYt4nFDz+sUHyQuOqOZI8h+gR1lVBqvLVehPXc500luaLgukxLukd5FSpAbiKQPuPs3q/J9QsviX/LmR51U5W7kQSGoG7tdla5OwSsq3PPyMXgr6H8mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVp4dlVkNmRWVHA4eGw2RWFIRWZvakxXRnFKbW14SHRlQzhrVzJpWlArQ0hx?=
 =?utf-8?B?Y01CSUN6R1Uwd21rQjhZQlBRMkJhdk9XTkhTT2pYYjJ1NDh6T1RobFJ1NDQx?=
 =?utf-8?B?S2phVTZmRUlNNXZIb292Ukt1VlVwWEhNS3RzSGYrd1hFMU5LWXB2TzNvZ3B3?=
 =?utf-8?B?UXQwcER2NmgrQjY4dEQzMHk0bkRtWjZ5YWdRVGNVQTc2a3pzMDViOVFLd0FJ?=
 =?utf-8?B?a3hYVTBFKzhXc3lEejV1OFhDeFFvVFpoNHdOZWVzL2F6Y1ppLzRqSUkwbjlV?=
 =?utf-8?B?MUJqZFd1K2dzbDdxc0pSdzVDb3p3RVVKelBuWlh0M2FGa2R4MGZPRVQvL0k2?=
 =?utf-8?B?VzdRQnJKMW1ST3dVS0ZOY1pweHJjZE1JZWtkVU5WQWFvS1VNS2ZUTGljYm1p?=
 =?utf-8?B?M0k4U2twT1J4N0tjMGQ5NlBJNGNsNnZENzVOc3NKUFlkdlJldTBwUGY2alNQ?=
 =?utf-8?B?MlIvQVdyeEozZlNxWUNVZ09pTHlUM29WY3k5cW9YeWcvMW8xRnplYjQ5b1Zl?=
 =?utf-8?B?Zml0OHkvdGR3MWVmK2NIWG5hOVdtS040UkFiUUxOS1lRYzZMek8zcDJLUXRR?=
 =?utf-8?B?Mi9kMGhrS1ZGbkFkOE12QnI3a290cU9jMFFTZ0lYWXoreU1BS0ovMHdiMUVU?=
 =?utf-8?B?aXN0Y21JZ1dXcjVVcGE4M01HdG9seEx0YVRBM0E1ZFNLdXhZeCswVURIUjFy?=
 =?utf-8?B?Uk1BUnFCTmh2Ny9BNnZUZCtMODJTSVdOcTRGOTd2VENlUG9xb013cThMN3BH?=
 =?utf-8?B?UW01TE9GaUNNR3FPdUtScUxSRHgvMDRJWDJlcUdhOVJ5UXhtR3V5dEtqYXFR?=
 =?utf-8?B?aFJCNUhoUmVlMXVCbmxuRWJNRVhPNHpIazF2UG1qbGpNZG1TWmJpcHl3dHoz?=
 =?utf-8?B?UGFGQmpGcDhrUStyYnkybGJVbmw3bWJKOVVWemxlSm1Qck9PeURQREphR2hD?=
 =?utf-8?B?U2o3WWRJZnNCU3ZGNVhwVVA1elRCNDA1UFZjcC9uUm5sWjRMaEtOaXR4Y0Rx?=
 =?utf-8?B?ZHVvQnJtT0F3SnJBTTVXcW5mSmMxdUF3c3NoKzRDL2JLdVZSMEE1RktuNzVD?=
 =?utf-8?B?V0xjaHcvUFF1dW54TWxQYnMvcGRSeE1ZWVM0aDRLK25NSzRoRStKTWQrYThW?=
 =?utf-8?B?dXc5RGZPb2pJZFc2MGdXSzFLWnZRNzN4Yk5wRHhTTEJrOEV3SDJhSFVsNlVs?=
 =?utf-8?B?c2orSWtJaklHLzRKNzdkM29RbEcwQ1Erbzk2dkx5TlJxZk5vSE1JWVpXYzRh?=
 =?utf-8?B?bmJhS1VvaGtNOTZpa0VLd1lXZkFiL0kwWTA3OHZlWmFHTSsvb01iYlZTZXpj?=
 =?utf-8?B?cDVFbjduWFdOdWtPWmVscmtMejlXbFNxbTJkQVJqeFZUUTFVQXErUTdaV1Nm?=
 =?utf-8?B?RHVGWm0xZHNyYmR4cFNwWVQ1SGlTd2U3cExjdm9pcG9jQXpFSDJyL0FLSzkx?=
 =?utf-8?B?d25YTkFtS0I3L3o5MTRSZm1aeHVwODBzNWdFYnhEVnhheWU4RDEwUGxKN2dR?=
 =?utf-8?B?TXlxT01oS2FzMzZRR2ZMeWtjMDRHc2Rwbit1bmlZaEErNTdSbGZlZnFjOEdl?=
 =?utf-8?B?ck1CRHZQWWxJTEdDQjFNK3ZMOUtFRkNJUEkxWEhiMFdrTE1Uam1DaXpsRk51?=
 =?utf-8?B?SkZPSzRTUzVoWVVKZ2VqdnlVbGNJcnhzTjFEZVpXUWExU0tCNEk0MzV5Uk44?=
 =?utf-8?B?eUVCYjlRZXJJV1J0Mk9WQUppbUQ4OUlvN0dqdm1KZXdYc3p0ZU9VNnhYTmgv?=
 =?utf-8?B?TGNSeTRjN3MxYlEvODlUdzRodHBvMUdRSVBySzExalJKN1cxb0liNXlRWStp?=
 =?utf-8?B?bW1HdFlSakxSdlJmdUg0MVJIL0gzZm9TRHFwL1Z5OWVrRnJkUmpRcG9jSnRM?=
 =?utf-8?B?L04xRE5YSFFGTnA1QVBOaHdUMHJOaHAvdTJ4NWlHRGZDdHBXM0ZENi9qWmFy?=
 =?utf-8?B?Tnd4OUJzcENjQkJSSHoybFNaMWk1YSswOXBvVnVDa0VmL1lkTlpKdFUrdjlN?=
 =?utf-8?B?Z2gxci8wT0VLNVA3M2I4Y0FQYzJYd0xYUDRTV1hTYkZyd1planNtaXVjQ3dK?=
 =?utf-8?B?K2FmTndGejhjTWU5czNZM0IwUmo1MjcxeVNsWU1RTWJoWnZnM1J3UkVYUHAz?=
 =?utf-8?B?RE82aGxXZXRhMmFlY0xXS1lZU2FId1JZemwvSlMxVlVRRXBYWkMzeWhUWUJk?=
 =?utf-8?B?N2VBU1JTdzRHYmNHSGUxQ2ozcm82dXE4YXVkVVVpRTV6alArMTEwWjh6azBl?=
 =?utf-8?B?SnBDTHp1QWtrdm9WbnQxenBnSGFQdGNtc1A0aDE2ckFiczNYS2ZIQlJpcDZQ?=
 =?utf-8?B?eW5VRWlRSWxUYldXSG9uRVFUREFGOUZJS1NHcmpFcTNIVTg1UEtIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a1b43b-3f0a-4348-90dc-08df2b516525
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:49.9984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Xo8AhNWjigwuEloNXNfDOqD9ci0QzG3qjEFkhjVHwgJl72Y5UVnfS/8GiIdnqHfRe4nf8x2RlO7bK5XqwnZrQ==
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
index d6315baeddb9..c2ec4f107808 100644
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

