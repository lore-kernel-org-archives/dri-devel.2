Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CE606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CSptXftj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504BE10FA1B;
	Wed, 18 Nov 2026 00:36:44 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002DB10FA0D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh+v3wNDVLXgMTsptoxqNF8Hwmq0HmbYmmvDNE5TFyLz4WSuX9SNQ8iKYyKeghiGvybkM3wOIRCTUpmhMUCn+FCZRt0MVRe6PeBWXko4qJAm9LLL8Yz1rSSX+aM47gY2v+JX4ne8/ZjvQTbYaMB9v/J8y6N/wNwxMFOelwcX8vETsfeZMF4C40HKajRANiy1EO+B5z5IEByymB9GGDWULnZJSFzweX+4jWzO59LMD6i3bg4/7JmrTfo5ZWpdxMehiuP+nz43O9VHZ1LfoiGQJ4cU1Ze3WPvMJzEpn1EvmZJQF3oIdab649ih4NP5g7IsSiqGSHzmg/NMXGRy9BxuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV8Oxg77PlQXwIa+PtE75HZNxzEGh9Q2snEBIGH5+Wc=;
 b=SnaYqLDc2eADyOGLIsDizr84vSdxDGc/ZUDyw+N26ouHY+iSABc5U6KmaxFtdCUwk8DIIBWFLOev4dsJRKN3KRxCMsJnFhcli2gUeZ5XFGrazrrl/tAVhIq7TAYkokYhxHf4n+Rv64ogyYpDGlS0SmV8CdLOTcAmf4LqQODM5TjFxf2ReBQDrucaV8zR+NUPvZIlBRb+rPjx2ZNDAi2s46e0P1KC8Z8XJC455QYwUh2atPF2c0UpmLEn6toYCEl0aeoY2xAhYQFkneh4panJpfYarcLFgdoqntD+FPUNy93IQZoJPsfShCj89Q4eWMuZx5el5/I50SlycW4p58i43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV8Oxg77PlQXwIa+PtE75HZNxzEGh9Q2snEBIGH5+Wc=;
 b=CSptXftjwgJTVm1J3HJnAvmnkEhMRymYyIKmg7D94VqBuKT2qUO4bjhiHKP5YRNI7AMf++yqVlvVPeQ63c112zSrvZdWNLSlkbhTJeUYMrQH8PTEneUWSSKqo1pYYzMT/kMLhjDv8dYAEg9RSVf2ulni03O9SS5wMlEZRzeyNteP78cM78iEVI2yjPEuMdRowcEOFEZnKLXkXfkq0qs8oGsobXkQ6wkusIIMOFShO5gXxVv7CVvLhmlxyZjyreDe3gRMYYwhnAkFWMnUqEhGbpStlMsLIxrJh4EPibXo3hyx469bCN90KxQ5CkdPYw4kZR34ovNGgbxasg2GCJEhjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:25 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:24 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:13 +0900
Subject: [PATCH v4 04/12] ARM: dma-mapping: Split mapping initialization
 from allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-4-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 04354004-0fa2-4fef-e46d-08df450bf9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261102124527099003|261102130727099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: vMffd5M+Z7YEF4dQuy19VDzbz2CdR1jNOBEKBi2xjNAvSXR+n843qWxaArc624E97L9jpEzFpu5EfQzq9/aRcoSIBOjkl/KcQHXR//pPdlDGYoNDM2Vm2iQe8hdDJVCEA4qNfrS/ByrpLSGqOZADhyzfzdNcpxG1Jduzrxy/Y+EBKwIYiGsd2X6oZoD/oP7Bc0FDQxoVUYE96HMu8lGhL7dpfQl3tLH6x0a/WfqrGEHV3UGV6yjs+Z+2BPcm3HPUjE3hJXcGnFohtaRQdeVFdeuGv3s6AOHS59EqQUOzemQq9ihHvhxAX0WfMq8ARV8fPCFLl9xqf5l4akjnrruKF6umgcXHnvjaXC6Uyw1wHRwZyAylS6GGm0G2Pep5mVjaQAMp3bJbN2j3YwGyAr/pQmLpo81Xhl//sQEgW97OaAjXqMs07Y1LOF31faUuzin19Xo8DsfUzDV2/tviMv0eBgnd+mtsxYK1TnQ80xA3RepQLv3Gv+JKhzv5uGKy5RqPhG7P7pVansciqAf+4hmhaqJwR5fgSeNK9GkLW0UIICOWoa8rt3VuH2EjEa4IFr93272Jd2GY01Vah+0dzMM65Nh5rArLSKkyRebXofNpIqMKjexEiBsNa+PCBbUiplwzFDbNEFHcH4KC0tsg+ac/gc8K9klQTTQJjXOkceGNg9vNu8qGIw8x1kojntwEoc9kRh+Zdj8dAo6ofa9GEZrcpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261102124527099003)(261102130727099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRWK284cW1VVTJrZFdFWTFvSExXaE4veHlCZjNNam9XejgrdzZCUWpLWW9z?=
 =?utf-8?B?cWhNQmRHUnJHTHJQTmp3TlhOamYzSWJKOGpSTWRwWWRMOUVLdmVaRnY0VFhB?=
 =?utf-8?B?TE9wVUFzc0REUkpGMnY1K2J5aVQ3THFidTN4aGo3VG1ZTmgrWmZPc201N1hZ?=
 =?utf-8?B?QjR6TnplQ2dJVkdUU0ZtOTZwUjhWZ2JselV0WkpMOTM5ODJJdXlvaWtBUEF6?=
 =?utf-8?B?WHFTbHpmajBUWDRYdFVZQjA3SHRlOXA0RmNSWjN6T01RWDVyWmV3L1ZPK25j?=
 =?utf-8?B?VkF0bCtNTVFTUlYzaE5sZVltVG5IZjVuS2J5NzllNVB2V1BJUzVBcGFESHVZ?=
 =?utf-8?B?cHdKVVpzZUVmd3B4NHdnMkFmbnZGTmRBUi9UVFhPZ214RzUvZDFxTzN1eVNO?=
 =?utf-8?B?L2krTmtLay9SQVBmZStaMDQyZEhtUWhTZ0hyelBEQkdQaklNd2VXV0s3ZEdq?=
 =?utf-8?B?YmNlcVZzN0lDU3E2TjdFYlZMVENhdUMyaURKRTl5ZDVzcyt4S0VFcnl6SVRF?=
 =?utf-8?B?dEo0QlhOaGVkTjNyRDZ6NDVSc0loZ0w5ZjlGWENJRUx0bjdvYUxidTRpZWpx?=
 =?utf-8?B?Qk8rVUgwMHU3VE80TUdzTzRCR05Cd3I5VjQxWTJsTGRhbWdXV0oxQVNYNWdj?=
 =?utf-8?B?eTBHaVc3akdtMC93cmFBczFjRllGTjF1NVRqcDlaQ1RnNm5va3VIZXZCZHpl?=
 =?utf-8?B?UFYyN2FvTW9NSHREOEJTUktpSEo5RWJCYkhxQ2JrNjNldTY0SEVLNEZIOTVO?=
 =?utf-8?B?U0F1L2dOUmNWVzgyUUFmeGs4VDNyakt4bGVwVkhITnB2M2FMazA4S3lsQ25X?=
 =?utf-8?B?OHg1L2JsTnFQbWhMYzBUMGxNSXBMQzhZOUxJaDhKSzk2L1UrQUNLb1NFTXZx?=
 =?utf-8?B?UnNLNE5UamlIR2UxcDhJODJ4WnFHZGwwNENYQjM0VHBYN0dJQnV1SzNMYlk3?=
 =?utf-8?B?bEtNMDhoVFVEdGlIQ0dqVFNLODA2ZkxJbnVwcW15cFhhQXBzV1FJM0llY3Bl?=
 =?utf-8?B?eDQ5am1FZkJKd2V6alB1WGxBZis5alEzYWc1VVBKZkpqVkxpUmh6eHltQmF5?=
 =?utf-8?B?ZmFJQWJxUVJ3WWwwcXZZMWVaS2wxaXVKdVhKczFmaFUrU1FBY3JxaFkydXlD?=
 =?utf-8?B?cWhDNDNmRzhYTm8xbEg5REl2eDNJMTFCUHZmR2YzZ1BqUVVGOStWeTVvZjV1?=
 =?utf-8?B?UENwOFZYU1JDdXJLWFc4SU02RnZOK1FsdmpqejBpSmt3bE5PVUhCVjNJeHFH?=
 =?utf-8?B?bEJldEluT1ZSb01VN2NnaU9TOHQ1WGlKQjI3bXJTOW9BaHYrcTZrNVI2RFh4?=
 =?utf-8?B?VkpmM0pybFE3bUxINGZzK212eHowc2kzeW16Uk9iaEhEa2R4Z0lPeHloWHFa?=
 =?utf-8?B?MEx4UlpXNWpoUmp5d2J2cXpDQ21HZjIrb24vY2tkWDNlZFV5QU8yMHZic3Vo?=
 =?utf-8?B?ZENoL05jSTVBNVVKRHZLZ0pRYnlzRzFpZFhYekVuSW9QVHVrNnZ4aW5mSGQz?=
 =?utf-8?B?WnozcXZrSm9pTXdlcWd1NlhpZXU1QXJXTXhVVTdwQXhQR2EyYk85Y3JJR3p6?=
 =?utf-8?B?QlZHZjNEZEpTYjFIN3JIK3JVU1JSdXBTV3hJQ3pMQUZSZ3JIVkdtMUJpd3RV?=
 =?utf-8?B?WW93T0tkL2ZRbWIwRC95UmJaT1ZhT29VVERVUlI5VHA0TXN2VjRsRTd6WWgx?=
 =?utf-8?B?azdJRDNMYnZjSHBoMlp0K2g2ZndkRkNzVVkxdURUMW90U25qWmQ2Z09kSXIy?=
 =?utf-8?B?K3dTUXIrNDd5MXA2S0RtMWNnMmNTc2oyK1poVDFvV1ptUVA2Y0doalU4dzdO?=
 =?utf-8?B?S2QzMUNaZk13bVdMcmI5bTkzdFZkWkw3eUx0R1U0ek95MU1IRlZkRGd0NXJQ?=
 =?utf-8?B?TERWbDVoMjFtZWxXRUFuMVFFT1hmOFVNTnF6MDVKT1EvakNsek5PcGFtY05I?=
 =?utf-8?B?UG5mb3ZjZFV3NWM0bzVMeGVqOWVyNFVHNitPcFMrazhhNjdLcFRRVjZDMm91?=
 =?utf-8?B?RU1DdStpQVdYU3FZTUpuNVMxSjZDMGRHREtCTHZqcGFiNUhPRkxiMDRJUitY?=
 =?utf-8?B?emZCa29aWXV6ZnBLWlRaNHRCaGNucnZKMGQ2czZZMzVaR2xpVFZuVVc5SUpF?=
 =?utf-8?B?YVhqc0xvT0tkcTFOQzFxRndXdlpVUWExK1lqTXRTYWJ5dGl5dEl2azdwbGUr?=
 =?utf-8?B?M2dyZjVNSm4raU9xaTBoNEppNjUwMGpQU2xwSk5OeE54QkpDVXRoSUJWSzFa?=
 =?utf-8?B?RmNQZWwxR3hMMW9Pek55QmhYa21CMmZIbU9ISUxzZnJiUzY5RW84MFVZclRy?=
 =?utf-8?B?RXJjK1hONm5RS0Zwdmh1enBBVWs1aVg4QkNLdjJEWWdNY09yaUVXcThjWis1?=
 =?utf-8?Q?p78+ehbPU4j/GAqhsuG04TJ+GBbGYLXnU/Z4UKwRZPpRl?=
X-MS-Exchange-AntiSpam-MessageData-1: +WrCzYUU+NO43A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04354004-0fa2-4fef-e46d-08df450bf9c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:24.9210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvnqdN1TICANlyqjwO2lFAEDQBesoVjYTge4naDrJ19wo3s0o2FNnta9CWmZKgQ12LL8HQSOCwOdb2mmi0e2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arm_iommu_create_mapping allocates the mapping object, its IOVA bitmap
and the corresponding IOMMU domain together. Separate the complicated
part of mapping initialization, the bitmap initialization, into a new
function, __arm_iommu_init_mapping. This allows the default domain path
added later in the series to initialize the mapping object before the
bitmap address range is known and later call _init_mapping to initialize
the bitmaps.

No functional change.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 109 +++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index fb2eb0ed7bb8..e3de7be174e5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1473,6 +1473,57 @@ static const struct dma_map_ops iommu_ops = {
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
 };
 
+static int __arm_iommu_init_mapping(struct dma_iommu_mapping *mapping,
+				    dma_addr_t base, u64 size)
+{
+	unsigned int bits, bitmap_size;
+	unsigned long **bitmaps;
+	int extensions = 1;
+
+	/* currently only 32-bit DMA address space is supported */
+	if (size > DMA_BIT_MASK(32) + 1)
+		return -ERANGE;
+
+	bits = size >> PAGE_SHIFT;
+	bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
+	if (!bitmap_size)
+		return -EINVAL;
+
+	if (bitmap_size > PAGE_SIZE) {
+		extensions = bitmap_size / PAGE_SIZE;
+		bitmap_size = PAGE_SIZE;
+	}
+
+	bitmaps = kcalloc(extensions, sizeof(*bitmaps), GFP_KERNEL);
+	if (!bitmaps)
+		return -ENOMEM;
+
+	bitmaps[0] = kzalloc(bitmap_size, GFP_KERNEL);
+	if (!bitmaps[0]) {
+		kfree(bitmaps);
+		return -ENOMEM;
+	}
+
+	mapping->bitmap_size = bitmap_size;
+	mapping->nr_bitmaps = 1;
+	mapping->extensions = extensions;
+	mapping->base = base;
+	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	mapping->bitmaps = bitmaps;
+
+	return 0;
+}
+
+static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
+{
+	int i;
+
+	for (i = 0; i < mapping->nr_bitmaps; i++)
+		kfree(mapping->bitmaps[i]);
+	kfree(mapping->bitmaps);
+	kfree(mapping);
+}
+
 /**
  * arm_iommu_create_mapping
  * @dev: pointer to the client device (for IOMMU calls)
@@ -1489,75 +1540,41 @@ static const struct dma_map_ops iommu_ops = {
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 {
-	unsigned int bits = size >> PAGE_SHIFT;
-	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
-	int extensions = 1;
-	int err = -ENOMEM;
-
-	/* currently only 32-bit DMA address space is supported */
-	if (size > DMA_BIT_MASK(32) + 1)
-		return ERR_PTR(-ERANGE);
-
-	if (!bitmap_size)
-		return ERR_PTR(-EINVAL);
-
-	if (bitmap_size > PAGE_SIZE) {
-		extensions = bitmap_size / PAGE_SIZE;
-		bitmap_size = PAGE_SIZE;
-	}
+	int err;
 
-	mapping = kzalloc_obj(struct dma_iommu_mapping);
+	mapping = kzalloc_obj(*mapping);
 	if (!mapping)
-		goto err;
+		return ERR_PTR(-ENOMEM);
 
-	mapping->bitmap_size = bitmap_size;
-	mapping->bitmaps = kcalloc(extensions, sizeof(unsigned long *),
-				   GFP_KERNEL);
-	if (!mapping->bitmaps)
-		goto err2;
-
-	mapping->bitmaps[0] = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!mapping->bitmaps[0])
-		goto err3;
-
-	mapping->nr_bitmaps = 1;
-	mapping->extensions = extensions;
-	mapping->base = base;
-	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	err = __arm_iommu_init_mapping(mapping, base, size);
+	if (err) {
+		kfree(mapping);
+		return ERR_PTR(err);
+	}
 
 	spin_lock_init(&mapping->lock);
 
 	mapping->domain = iommu_paging_domain_alloc(dev);
 	if (IS_ERR(mapping->domain)) {
 		err = PTR_ERR(mapping->domain);
-		goto err4;
+
+		__arm_iommu_free_mapping(mapping);
+		return ERR_PTR(err);
 	}
 
 	kref_init(&mapping->kref);
 	return mapping;
-err4:
-	kfree(mapping->bitmaps[0]);
-err3:
-	kfree(mapping->bitmaps);
-err2:
-	kfree(mapping);
-err:
-	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
 static void release_iommu_mapping(struct kref *kref)
 {
-	int i;
 	struct dma_iommu_mapping *mapping =
 		container_of(kref, struct dma_iommu_mapping, kref);
 
 	iommu_domain_free(mapping->domain);
-	for (i = 0; i < mapping->nr_bitmaps; i++)
-		kfree(mapping->bitmaps[i]);
-	kfree(mapping->bitmaps);
-	kfree(mapping);
+	__arm_iommu_free_mapping(mapping);
 }
 
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)

-- 
2.56.1

