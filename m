Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CD606A328
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tOQIktcS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969B210ED0A;
	Mon, 26 Oct 2026 09:21:14 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F52C10ED0A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9Eq5EalFAdymi1djbhQ6t21WCT9bqIEC3N06fxdfrzyPTkqYDwYE8yBSawbaAkL2sDlF3gxDkE8/5FvwzRfvni2zINatdP+qal4hIBAnbCPOZKqAiibLKHglRQtGY+LrKhqC7gME45DFZlf7Xrg5r0zOF/sSFXsq0UNsc5+oioSUVrlbpGbELuik6/2Bmiuv3xQmGPZuJZMT7n6h59YHd5UrQkyhLPiZO+x9AV4eUK3ujJgPlt1QmWt2brbKbLBapzTLJ7f+RxQJfwH+p18RkyQMwtNihQwMiCN8WBy3bS2WkBkWq26z9/0kBibJmS0rQ4ogD4zRcbYu66i2uNyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJy9fPEnMj1tbpBWZ/rWtdxNeFC4NEFmHsWXyvqWZ70=;
 b=ok4IgTMAELej68I09ZPWlsvoWA3NeF5YoqLBAnj7LqNJWE0HFWSi5F2MydUTdwNzTsMZjh1bcfI20E3IeDW5CeCXcd15/0nA2jVouSnz6CAurLrOAOMzVhzlWMrxJMl2mTXlp8u8Z7GG5R0PQEebo4tc42RDA5Ski03xgitbMcyIVtlPmgr1klmVpfUouzBOBsNh8+/2nrC4zVdyLaawAppWLti7aSQrPxEzZaJ5rwP/g+7LanIh0764YF3F6Gu3zOtiPC6ZtTVWWG980hb0hO0spkYcWzGaXkPpzVrO0ccDOu0JPM1qqk2Ygk3WK56DoQdx6Iw0zp7yLdcZs/X2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJy9fPEnMj1tbpBWZ/rWtdxNeFC4NEFmHsWXyvqWZ70=;
 b=tOQIktcSNJceVrB9dQZklMKY29XDr2o/0k3HgNmjRpbO3ce12HwPAquEwdYGgG9wanxp0xRf1jgximPQF+O2bHooR5uzsUgKpPlANag+LPhdsPVlsFfz8PhLvSH7/2RoVtfhomN/5wUsBcRNfU4BmxlbZucE1KXJOq9yImdkWKTAq7he2xbpl0dU02jbL+22uat64yP7OhWktWbB3uql835QdCmQEmBRJcCdi/R6tc4NJODfFv0iDGXtnCE/XqRmhXoJqnxRjTW3AZk7MW2PJ1jb/5zt0NN69UCkr4E1FftO/3NhMeBZv5yajy+N9abVdqbDeZrWW5mnjUBx77TEyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:21:00 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:31 +0900
Subject: [PATCH v3 06/10] ARM: dma-mapping: Bound IOVA allocation by device
 DMA limits
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-6-3901d74b1ff2@nvidia.com>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0337.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c30ff6-fd77-49cb-5741-08df334272bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|10070799003|366016|10067099003|921020|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iaYWTRcCPN2omjGqOtb/CWiZFb48slJ6FVh+tL4SW5vF+GiridjJBPSOrxCd+A1joZ1399ZsgKeGXiRbGw77lPgEV7SB1wPqBpEhOpxunyKXaFOPfYTmjc6Ira2bTiq0UcV5jm6eWwCyin6opMYukvBnrsoRkcM3tBuFwZxcaLbA7XQLvzFQpBT/yFeWfQsX1Ovtr5stn6fGOmwY14MZn+SztcyQL10uA2d5IFvQjtyb0IX00azMOtCuzx6Woj4V5BGp+NPe8CxMMFj+VEl8K0mC9zgKkF9K7zSSvfxjE2r/CapVCgu3qUzDpl8Wn+RBeBAkZu6poaHRzjdUA+VlwEJvb0SjAV1lA9btl1b58ySV8Vwx7iXAbRjxXwLQp78uijW8iDZ2Cdy85JZVb1uSdikWKd0aHZaVXfAK+7gSz3N28eNhgFTW5XvxyE24u8/SuM86zRku7JTvDL5lwUb/y8DWtbChU/ZA9mU6hQ/KKhax+uJyi75v2wgdCQi7TiXCcsCZUGIP6KvagTUzyYTQox9O/RMmpKYmLY9fzc3qUfzOFKOA4JMjseBc9pHQ3SHFz1GEX5CDYlz64pWqZl1f0fNZjIiZoXM0BbQN+xWT9v6PKil+CFdPJK7r4+i/NRHI0sSV2yiIHQBetK8/grnBoqGMyj/bO3nh/1u3BieTm8q9tqdr1bWXi85zhvQfxcsT7JOhGbijD+/w81iyWG12sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(10070799003)(366016)(10067099003)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzlid0hFbVBuQ0hzalJhcVhjcnNXNWlhQ29Rc3BLOGtTL2E2NG5OZTV6WW5x?=
 =?utf-8?B?N0o4UllYNnAxdEx6bDVRcWVsWVRZUHNoaDBtU00xbk1wekZuczBweHNOelBL?=
 =?utf-8?B?ZEYwcE96SWY3eHZzVGluSmFJSWlaeXpRR0JlTG1JOW1SZ2wxaURSd0J0M1Aw?=
 =?utf-8?B?cGdpTmxBNC9VQXBUdnJEcW05S3B3dU02WEpxVFloZUpaSUU5ME9DU3NoU2ZR?=
 =?utf-8?B?WFdTNStLNGxhaGMyOWUxakNWNElqZXJyckhZc0NjSTF5RlQxdC9zS3BqUE45?=
 =?utf-8?B?WVVQcmxKVlU4NTZUTlYvWHVnZ1pyVWk2TklGS3dmN3Z6Sk9MUWczeEJIZE9j?=
 =?utf-8?B?Y0xKV2laUVQ1WVdBU1F5MWNoeStXc3IyU0Evb1o5MWZqYmw2eS84dldBcGJJ?=
 =?utf-8?B?RzgyQnVaS1pNZkNjQ2NVSFdEV1kwT0J2aUIrR0J2VkZiclN0bmVvUU0yYkRP?=
 =?utf-8?B?MEQ2MHFOUE13UjBQUG9LalR1SkFHM0p3cDlCbUkxTHlJYjFBWmhvQ1dKZnFU?=
 =?utf-8?B?YTFMc1pQS2xsQVYySmhHNnJSWGpURnN6dElnVE50NXpEWE5SRVBnUC9nRkF2?=
 =?utf-8?B?clZ6L1cwMW5lY2NQMFBkQWNSTW5hUnhwczdlU3dxck5ackZOUk1RcVVTNXhV?=
 =?utf-8?B?akxXN1paWkxBL1VXMUF0VzJ4SS83am91am0xY3E1dFFPOVNUNlhBZlIvdlRZ?=
 =?utf-8?B?ZlgvRkl1M2FiZ1Z4ekkxaVBRRmc1M0d2Zkl1L3BCRjFOVVNqdmJkTFBMWUQy?=
 =?utf-8?B?VDdCN0VpOXZBZi9OSUZvVVpkRlBRc2ZqZkR1bWhEMnhqLzVyRC9LMlArZW4z?=
 =?utf-8?B?WnRORzB2Z2FISWxldWhXVDNNOHVFS1NBcWJrZHM3cnVtUmMzNmFLWm5HS1dM?=
 =?utf-8?B?Y3gwMXpwN1Z6ZVFMb0dPUlRHSWduem1Kc2xGcERJMmJYck12NFF5M1JvREM4?=
 =?utf-8?B?MU9KRFgxa0d1VmowK1BnQm9PYnVxR3U3eHRTbDhxWlpmcGpwbitTVmE0TGpz?=
 =?utf-8?B?ZGlJZDZBOWZDNlh0T0l5WmdxZjBHZExJK0pKYVQ3eUE1YjhRbWNXTEFRWThu?=
 =?utf-8?B?MXFOaXZGM3k3T20rWW1FNWhUUXlpN211WXZVT3NsaDIrTFlsSmZWd2Y3UnVO?=
 =?utf-8?B?a0FEd0crQXhFZlMvTmZKcDhkeHpIa0NTaEMvazRzeHBOdEhXa2J0OHNwNkp2?=
 =?utf-8?B?ejh0dWQ1VU8zbWtnWjZBVExLZG1ZTVZuMkcvZU9lRGcrSW5qUkNhZVhFaXdo?=
 =?utf-8?B?R0MyckI3YUxOallCbGRsM3NoM05reUZKK3c2SHF0UnJBY3ZVV2MxS2xpbEhY?=
 =?utf-8?B?eWYwdnZmOWtXZWZqSTF4aHVPKy9UTVAya2NLNUpoRkxPcjU0NmVvOWZJZTNh?=
 =?utf-8?B?WFU3WnFDK0RkSkk4UFpHajBtV2ViN09MNG8veGlvUWNTNWVjRkZCb3A0NVVZ?=
 =?utf-8?B?emhxcEplWUFMVjJBZUNyS3I3NVRHU3FNOGxNVEhKbGJHOHhqOERtS0J6bFl6?=
 =?utf-8?B?ZmRESC9TejE4bW40elAxQ1I5ZkNlM2R4bXY3TDloMkVzWHoyci9iSFNJeGhT?=
 =?utf-8?B?bW1LZzJuN083dlRoNmlBQWs3bFdicDZnME1COGhDaHQxUWN6OXZ5ODM2Sisw?=
 =?utf-8?B?UVRYWFJuOENIanYzVGpYaEI1MklIK1p5N29RMUlCRm9YUENDYTRtbFc5eGpV?=
 =?utf-8?B?YzE1aFZRV1FjZUlKa212REI1NktLWXUvV010b0xBM3FySkJIejFmZjZEci92?=
 =?utf-8?B?Z3RzaUpiNnRSZmsrRk92ckRQTXIvekNKOWV3NFpIb0FrUjY3R01WanB2czJV?=
 =?utf-8?B?VEZzeDd3RzB1NDVVS0R4Yk9lOERhK2VpdkR5Y2tOVGtibGtmVlBJMHk4NTBr?=
 =?utf-8?B?TWFwSUVLQjlFUlIyUWQzQ0R3OVRnYWZzVVpDWnV6bjlNQmp0Zjd3bEk2L3pS?=
 =?utf-8?B?OWp3R3UyZmpGQTRlQVc4V2hWVUZJUVhaWGgyZVc3TjRYR1B4djh6dmhlMmdM?=
 =?utf-8?B?S2JpSXRqTW53TlpKT3RscXozd2ZnV0lsUWN2NFRBRTJqa2ZLNUtZQ2pkMzEv?=
 =?utf-8?B?V0tKYVpLYVQ3S3lrRndhamxOUUFoV1JrZms3djZ4UERiUDJVaFNTYzZDWHho?=
 =?utf-8?B?S2RyTnk2OXduV3VFcUZBVjRzM2J4TEsvakV0eTloQ2xQSjFOTmhiNzFmSUhE?=
 =?utf-8?B?cFNsaU9TNUVYSUFRejg5MVMyZzZZV1gxYjVXN0M5L2tyOVZpdzBnUTVqSWFq?=
 =?utf-8?B?TDJKakZVNzBoTTZyK3l2UFRJVDhFcGpmMkdaN2UxdUF3QWQ1ZWVZb1UyclJl?=
 =?utf-8?B?NnVVK1E1TEhxcVdITmo0QzVGRGZUN21IcHo4K3NKTVFud0F5TGVaNkRRMW1m?=
 =?utf-8?Q?9X3MzZZ9yKwgx4IRlFMiodhsgA7OymNHgT5lQ4DYsnyoY?=
X-MS-Exchange-AntiSpam-MessageData-1: OyULLRSxbrL1bw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c30ff6-fd77-49cb-5741-08df334272bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:59.8004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm5zb16zerQVc9pe8KdhDdt6nUd/UtnhZ4vYbrfTBazTbeLIgC2lGeXZ88JB3y2L2zDiCiScHgYkST/1Cu7kWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The legacy unmanaged DMA domain path sets up the IOVA bookkeeping based
on the dma_range_map of the device. This property however is not
necessarily available during the time we create the bookkeeping with
core-owned default domains, and doesn't take into account the device's
DMA mask.

Resolve this by passing the device's DMA limit to __alloc_iova and
refusing allocations that would go above that limit. Allocation logic is
unchanged except for the check.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b82cf58f8bc7..3703f9e2c9a2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -752,7 +752,7 @@ static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
 
 static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
-				      size_t size)
+				      size_t size, u64 dma_limit)
 {
 	unsigned int order = get_order(size);
 	unsigned int align = 0;
@@ -776,7 +776,6 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 		if (start >= mapping->bits)
 			continue;
 
-		bitmap_set(mapping->bitmaps[i], start, count);
 		break;
 	}
 
@@ -786,27 +785,28 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	 * address range of size bytes.
 	 */
 	if (i == mapping->nr_bitmaps) {
-		if (extend_iommu_mapping(mapping)) {
-			spin_unlock_irqrestore(&mapping->lock, flags);
-			return DMA_MAPPING_ERROR;
-		}
+		if (extend_iommu_mapping(mapping))
+			goto fail;
 
 		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
 				mapping->bits, 0, count, align);
 
-		if (start >= mapping->bits) {
-			spin_unlock_irqrestore(&mapping->lock, flags);
-			return DMA_MAPPING_ERROR;
-		}
-
-		bitmap_set(mapping->bitmaps[i], start, count);
+		if (start >= mapping->bits)
+			goto fail;
 	}
-	spin_unlock_irqrestore(&mapping->lock, flags);
 
 	iova = mapping->base + (mapping_size * i);
 	iova += start << PAGE_SHIFT;
+	if ((u64)iova + PAGE_ALIGN(size) - 1 > dma_limit)
+		goto fail;
 
+	bitmap_set(mapping->bitmaps[i], start, count);
+	spin_unlock_irqrestore(&mapping->lock, flags);
 	return iova;
+
+fail:
+	spin_unlock_irqrestore(&mapping->lock, flags);
+	return DMA_MAPPING_ERROR;
 }
 
 static inline void __free_iova(struct dma_iommu_mapping *mapping,
@@ -965,7 +965,8 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size,
 	dma_addr_t dma_addr, iova;
 	int i;
 
-	dma_addr = __alloc_iova(mapping, size);
+	dma_addr = __alloc_iova(mapping, size,
+				min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit));
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return dma_addr;
 
@@ -1194,7 +1195,9 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 	size = PAGE_ALIGN(size);
 	*handle = DMA_MAPPING_ERROR;
 
-	iova_base = iova = __alloc_iova(mapping, size);
+	iova = __alloc_iova(mapping, size,
+			    min_not_zero(dma_get_mask(dev), dev->bus_dma_limit));
+	iova_base = iova;
 	if (iova == DMA_MAPPING_ERROR)
 		return -ENOMEM;
 
@@ -1375,7 +1378,8 @@ static dma_addr_t arm_iommu_map_phys(struct device *dev, phys_addr_t phys,
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	dma_addr = __alloc_iova(mapping, len);
+	dma_addr = __alloc_iova(mapping, len,
+				min_not_zero(dma_get_mask(dev), dev->bus_dma_limit));
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return dma_addr;
 

-- 
2.55.0

