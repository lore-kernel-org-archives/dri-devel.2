Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hdhkw7UQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3D810ECF1;
	Mon, 26 Oct 2026 09:21:02 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E86B10ECF1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT6p7dp7ZZTjwbFxQ48OREHtFyNZ5YzA/w2jRczZNgh/ARPvoLE11EBAl7J2ZcFFy4jPAc3R8buw9YlUNdoNFxAH4eIy2A5U8ZncOeeLX05clwZtOHsFvQ9gYVp7Tn0QRZoKpNO/ZhYRwiK2Af3p2qIdXFkS5E2hNs+V5i3UBezTz+TpWGkPIIMVAorjW960LJp9W0LxeUOQk2JgO+f+2EFBq+Bc9HKEZaHNLatm2V5Wj/jzoV/XhbLb9TP8gO7WEPOfr8KAMpRIJpFO59owE0ERofjDAGuhW3V3s/SFHUncPlt3sy6Ptv6sLZ4T1jUdsN4QbqzJZjZlKuMs+cfnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfedf0dNAsZbPLWPTD+dW5GzvBoPlxfU+VWrRkg/KDQ=;
 b=A33/0xF0NnESNOMm0dy9L+2BFksHDX5n3L6pzh3RY6ai3/eagHCwcJPVkG3wY+xWVr3WhpQ0tdJZbw1JE+A2FfDJmpQIRyWLRPXJNtm2FDBzR1N459fqEvHZsJ0r73v0agGHrusop3HGRr9BebKWGY0HcKXDK4EtMyXguXoRf3cNLBKLpY3dBsKGnNxWkJxQdsmGy7ie4opTPpPYaI/gEuSpqEkZqOy+Lpz3Q9XCcX1nkMwn/9UeoVJYFD+Bbl7BBdQjPkbyPfJBzDXhIFSxfZ8vcAwWD5HDcHuGtQmec2hCFPVTpkBNwpv25PiHMZc1tgISRbLiDi7ln+Jm2ifzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfedf0dNAsZbPLWPTD+dW5GzvBoPlxfU+VWrRkg/KDQ=;
 b=hdhkw7UQnc/9lvG5gtP08PAPjFvdqWxG1ZKkxJTJcShNvFZZ5lzWlVvFKSp9pXOv2dFpjIliGOoRV7jfvxMA1Bsb9hrlvWWJDyRwLRtP8DXb08o4gPeDweF4mEfxyOGDBboerWVIZ8EHv+vyWMfqqunh1a2R4Hvc63pYDnckeHbWpG0/GFm2nZ+opGOhvjXMZT/C2wfmsGleQkqo2XWZfy1wzoyUTumwmuY0ngJ6fVYZzOmxq2RodeCD0mPKE8vev8j3GRvIcbDR/LLNriocs0A9hgWNHBCX8fagtjdw2DbgXMcBCSfRt4SsCTxaS2bJTII7wRzSVWMBX4X4XxOhAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:20:49 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:28 +0900
Subject: [PATCH v3 03/10] ARM: dma-mapping: Split mapping initialization
 from allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-3-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db30dbd-a2ef-4f39-f7c2-08df33426c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|10070799003|7416014|376014|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: acCcxjE2p7DiocSLXCrac2sU/33msRx7rXnkJRIbK4MBBmPE9ETeav7KRiyG3hnz39X0PU8hA9OnYw9SHAKXyCL7G1CZyaX5ayIraQGbjnTKMJl7mjxXrAOlIIxdwU9H5n2gj/f284TPEoWI7hluD+LJZCh6lkGgKL01mOeLWmjnH/T9HkcAgdaynMsv4nYUoaLaCwoRI4FNzkt7GiMA2oTFz7dL28TQexONunHi6W07h/OXf25BFdiYpSwMiMv7AtGgj0HNuKrE5a3V1kzDMehnG0bXTNLBZQScHV06qhNKFLkWIFMoMrRVLRq8pXYzFvaMn0IVydkg9dAMZufHA8oIdWZq47C9aXLgx11ijNFdYQ2qydwaCYDcCMr5Hp19hfuQ69+7AdvM7+cC5RW+WxypPNle3rbIG0+LtJHZz10Y9Celt/btqLHc9HNjjncc4ab81B56i5EZxqxSnYdX5RA1TDD4s0hv6b/ooJR92vDrwpi3Qloj+L/JsZsnTnHqyA/sPAOKbBQoSiDM48DpkDs53OWUb7Zsjz77IdBTj1CAc0Wc1UtOZOLhacLDjJIbMY62TwOqenE8ea08y1mhjTd1vW0SGiks2fhOlj+29wFDjgre76sXRdmxeib3JksWUu1eF7VWqALy2Oz7dug4jkPNjvbKkuErYi7TWgJFnOm29d10S/yEsNH456CcgiD33ahaTRS62LLlkw+sXS4LAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(7416014)(376014)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGFBdGswdTNvdW9iWld1QjNCdnZObzNCcFlrYlh0VGNycmpRK1NUTTEzZ0p1?=
 =?utf-8?B?enluejhrRXVrVGtLM2Vjc3hPc2VQWU9PVXlCZGM0dFB5RE1VaURaUzhyays4?=
 =?utf-8?B?d3RmZStNYnF4YlFLNzNuLzQreHd3dDVabGgvWXNJSWNTYmY1Z1lSYi9YYXhP?=
 =?utf-8?B?M2M4cHBPM2NvQzR0V1BaS0JBKzBSbUJnYklHN2hiWlJsWDZjV2IyL1padWt3?=
 =?utf-8?B?MEZNSzVzQjZHckRJbzIwbExGL1Q5aWVSODdQNnhaUlpoeGkwdlpqQmg2YkdP?=
 =?utf-8?B?dmozU1E5Ny9DdXdOWXcrZGxoY0dQaEYwZWxPRTEvcG9XUFordUlTaWN0bUFt?=
 =?utf-8?B?ODJEWWpVMEt1b0NYTmt6azEvTTZlZ0xnQnJSTDFlVzRaUkhseEM0ODBRd2Ev?=
 =?utf-8?B?T054UTZkdjNtZ29mSnVOb1JPc0pic1d2YS9ZbWpDTVdWTjJiVTl3VXROVDcx?=
 =?utf-8?B?blZSYzNXdFA4T00xOGNhMHZjdjdzUDgrVmdIelk2K0N5TlBQNzJ4WDRMajEx?=
 =?utf-8?B?UXBkcHdMdElZZkozbmVsdzh1R1pTWGZYUERiQXVqMVR1RnZidHFoVEZZa1Zk?=
 =?utf-8?B?QTFPUE4zdXNDRGN0eXFXL01MclY4Mkc4NHZtNWl5c0NOVnhOUTk3alhIL05q?=
 =?utf-8?B?TGlQRXd2WlJBeGhzWTlhTlJDbVFWOEhqaHRXdWt1SURuUG1lQzFTb3RMQW84?=
 =?utf-8?B?VVhDQ2JJR3lyWlVRQkx0cWg3NEltK0E3T1MvQkNCRytpbzVmMlZmdXZGeWZD?=
 =?utf-8?B?MmtqbGdybUNKOUZUOFNaTmE5aDBTKzN2Y1ZCVWl2QlR1ZXFhZ0U1anMzWmNi?=
 =?utf-8?B?M0xqOWZ3aW52VjVKUGZqVTgyT3AvK01zY2tUN2c4bDc3UE5XTGUrNGFweHVI?=
 =?utf-8?B?bTZBb3RmQ011NzMzNzJRd3VZOFZzRVp4amZYZ3k5R25LSVpzMUtZb0NFdHBt?=
 =?utf-8?B?QVpNdFFGc0RIVzl6RzNXSTM0Y1laZXBGc3Yzai80S0JRaXBSN29UYnJHUHZa?=
 =?utf-8?B?aUpZSk5EVWwwL2hzc0o3UWU0M285RU9XZmhWV0Nqbm83anhCQm95emc4cG1v?=
 =?utf-8?B?bGE3VzgwOUNpcmZ4c0tCZXJoQy9SeGRNaDNTa2RPZkhUaVhVQWUyWWVidFdY?=
 =?utf-8?B?N05Wb2dCazlEMTNPTDFiSzJocEpMdy95VTBUMHNhTFgyeXgrd2VITGNFKzh2?=
 =?utf-8?B?RlJERm1jV0FyWE5pdURUaGFsVFlBMHJwbGtmTDk4WDNRRFdLOXROY1VZT0FW?=
 =?utf-8?B?cHNrK3NvMkZ6WkVNbXRzY1doTnpLMTVqNVBxUFp3ZDl4ZXJ1Y1ByakVKVlhi?=
 =?utf-8?B?ekxMVTRSWkM1WnZyVS9nLzFMS1lTUGhodXJLZVBUcHZoazdpMHRDbExMeVcy?=
 =?utf-8?B?RmRtV011aTFIS2lGNWx5dXJ1MDhtNm5DSGJORUpkb1pLUSs0eFJFTlNkWStv?=
 =?utf-8?B?cVR3eU4xNzgrV3FlQ2s2Mnk3R3BheUFJMlVCbUg4Zy92SmFEdTQrZjlCL0l6?=
 =?utf-8?B?Snh5cm9ZdG1FOGVNUlVBYmVRRi8rNis5NU9YY3laM25jRVpKRFZJWlhWV0ZT?=
 =?utf-8?B?Q0MxUHRXL2tBYTVSdi82TUwwR3FwQjlVbUlMK2kySXQ3aUNvQ3VyMmtES3cr?=
 =?utf-8?B?cElEb3hiRm8rLzBTM3VTT21TY3VHaEZTb05KUk9IWU9OaFpibWZjM0daSGFl?=
 =?utf-8?B?WFgzQUJ6clcwMTdlQkdRQThzckJsVGZRNEJ3eS92dlMwL0I4T1lyR0gveU9C?=
 =?utf-8?B?YkJKVVpmS3RNRUpvNS9TVE1IQkdKWjUvMWlheVZCTXJSTkxydXArUUdHbU83?=
 =?utf-8?B?WnhnZThmZkVHeEt5ZURPTWRNeGdJaVlEdkRuZlp4MGRBUDdhdThOTW0zOENv?=
 =?utf-8?B?Z2pDV1RCYVNpQzlRTFhGd3RCdG5tR3VXa0VBVHB4V00yM1RadE9UbFB5MkNE?=
 =?utf-8?B?enRhQUx3RHlTSElXSG8wV3I1VXNuSmpOQzkzY2hRYkVURmNkT1BlbThqZTdB?=
 =?utf-8?B?azJ0bXVibWNVZ3pzRktRakR1SkZmRTJLRG1PME5oK1cwM2RxYzVBdDBla3oz?=
 =?utf-8?B?ak9QcnM1TmdiQ3B5SXd6ZDQwdkxXRDJDR1Q4RFNlTVF3cDRDS2tRNmViT1ZN?=
 =?utf-8?B?SzhkeHRkSWpIbGhGOWVzVFg5a3FSQmN2Q0dEYjhYWlhLdlZsSEtnUXQxcXRq?=
 =?utf-8?B?bU11M25XT1dQcWJBQllURWZ0NnJEdUh0eVpmQURsWTUzck41VXp4dWZXK21i?=
 =?utf-8?B?S2NGMnBlN1pBQVNCMHlJRTh4c0t2ekdRemJsbzdPRlllSS9LeUs5QjBEbDBz?=
 =?utf-8?B?UXpkWWlsSFdtUExOQjNvTk5MN0pNaE1MQ25iS29NbFUrQ2VQdk40UTdHYTha?=
 =?utf-8?Q?FstTc/cJt4ixHSE/UZ61iCsGB9+FnE3zjDUa8OXEAVG5e?=
X-MS-Exchange-AntiSpam-MessageData-1: J5gIa92W4d7A6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db30dbd-a2ef-4f39-f7c2-08df33426c06
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:48.5337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh/pBDw0FlXdmuaXN1Gu3HVEd6GHOXEOovDl5PxO5UsuEKgZECJ/ir959eiY/NAUpXqZdyczooAaphygzxryqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
index 7761099dde9e..7ef7c268c583 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1470,6 +1470,57 @@ static const struct dma_map_ops iommu_ops = {
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
@@ -1486,75 +1537,41 @@ static const struct dma_map_ops iommu_ops = {
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
2.55.0

