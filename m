Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E1606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MkAh2/b/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4361110FA28;
	Wed, 18 Nov 2026 00:37:07 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9711610FA1A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaUIj7RXqKVPEJIBsJNVUv0ySvPqFdGzaVMYwn7kSGGtI3LzZvYevkgosSgYTmrx3oj/hjZTBz/+EvRid+zwHgweExqYWW6ybm/fLBIAq0q2c0SO3uEZeNNwpys1EA5Nx5E4Kp7q17qXoXRAkkSHkzpMnQ2KA+wVHGbK7AS+d3vlCcIJDiC5w/mVFs9MrZJpoMq6x0nfyyqhh3LGSjGToqg/ofWNgAnFVBdYuC2qVSVh68EEaQ6pQQwvQv2wPe5jiMUfoFY0fz3sM97URtCth5t/k6DMFxxM0au/D3wEYIJ53SahiAOIuZe1ckN1pijA+Vre6x8wPSdgNj0s9lSRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGhYoEs1BBMD0bp08IvoRxcQzrEhPZo/gB5pZCkg/pM=;
 b=WUn0FstXIjpGf77KD/kxjP6rSFVfX0bunf4J+Gp0DAE7gD9JZCf3XNvqBMFo+dEYhDSVDuCqitRVZ+dNRTCJ9s3/98HWrq0T1Qhi4+aJmFF6XDRR3ZHzhCTS2AMQPiNDBPApWfpCY7a9pGem0EEw4LkSuftMixR1XCFfA27Srzuq3/gQczYK9jniFLVtkrmmaCVcRWFC2i/TpoWfmWV1W0xnbboaj6ANj6EjK0V5pOH4bkgphGbg4df4Mt/Xb4y4IegRqSIhSFEb9pdhPV29MLoXFFTzGMJ/bmE/L2LNguCDyiAsN/rK3Q9DQr9vyLb9m4L7Wt1CCt7C6IKccjfNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGhYoEs1BBMD0bp08IvoRxcQzrEhPZo/gB5pZCkg/pM=;
 b=MkAh2/b/eFSVlsP99kter7pCKoWyJqEG1+wYuVW0KZP/fWxXVw8Os4/mWxsL1DPLGHTk5EdwkU2lVpVglDfivmmq4Ryog5MwoQaqv/GrOTvZ/9smKpK5ILRctzDqBkm4trkG9ZeBjd0H//vr78rb67nbAQZ7zb+AZi4OX9z/VHJphfVrpbhJa8jQVpSXqFF2wnrnAXcfuYmVIk2rzgj7/HTZ9UB9eaHUZmICOxTYj2h5GYts5s1BaX+xUKpZbnA8ioy2woxJuEiHo0cBLq9TldTG+cZ4K6kaGaZeEWAk8YzkT8FleqAkdwvRTUfX8x5bR570fHUBDv1f/n/TLSyaAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:36 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:36 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:16 +0900
Subject: [PATCH v4 07/12] ARM: dma-mapping: Bound IOVA allocation by device
 DMA limits
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-7-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0331.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6392e86c-0681-430c-5ae9-08df450c0070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: KrxTzFuBs4gJf60+i10I7J4HqCAipa0we54tHbXLDCvneQxVvfQlJdPCn+DMjJ1pedmEjrDCGZpoUl17UeG/yKzQgiyzFRj2hsujKi14cDIa0WNs3SQUQhtMjSGnkud/itX+gvQPVXPO6VE7tyNnbpOFNOWyUUuxdey+/4iIQSm3fANe+n/uhEm84ri7APwQLgGYhWairDqp9cSMyyBs0DMnvARNcASGvHqk14J82icsiJLlcdgDCOlE5rZjoRde0m/ekA6GvtQ6ISSmecZU7FF6A1ozIgAoH35EHENf2OOqmVuKSWhVr7+5EqAAsG7JuEeBbjzhMjCVGv5lXmRssauUShrly6r5IObjnvvB9LkBlCZXgnVVsTr1KG51AaYES21bTd8bjLbgttAJQh2XKFQnDPqFBH1voz7Q0+bOeESVz808woEFuF4IW7ZwE2a434XntSZzAQXKlxupGVZi8rAUl57L7Ji+XebmvWF7aTO6SJ5khGF6uKtmt9rYDBDZZLtB5XwonnRX0TPOt2Hek+RMf6U9/gumAy7UhNnAw8FSJCYATn0i9s1Y72hs8m3ikXjZ5VLWIMuK8FG8yZt+5cwAY8SblRbYB5uR6WOzEtBn0HGGx19vMXD5lz8FFHOCAU/RvCipPHl/ELjqg7ur2fMav92xe8tIgLx5Z9/4IgC8R1hgDHye0zNYIVeKOAGkkdFAYqtsqeOhhWrAz5846A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5qVG9kTWF0OC93aEpxelVUTSs5bW4yQU8zVWJjODVxbm05V3k1WFZVWDFG?=
 =?utf-8?B?THBVdXcrOStjdFZtNFAxRStiUVUzM1dZcGE1UXpvMUJiKzhuOXN2am55NUMz?=
 =?utf-8?B?MHVrM3FWTk1MVHZqQVJrU3ZKN29BMHQrZlRLMkZ2cTB3UmZzSjRWZjJwUktT?=
 =?utf-8?B?bWUzK0ZkbnYydXF0OXBCa0g3cTlXTktXM3J3NTNmNHM5d2N5dXBkU2lhb3lL?=
 =?utf-8?B?c2lVcE11V2VMbXhKOHJPUEMxNjVubWdrM3QzcmpKdFdEVnNJNW9sU2dSZk8v?=
 =?utf-8?B?b25BY3hlcUJpU2xpREJsNnlmZFg3U3Qxek0zTzJrZnpaVHVZZWRKZ1RZclFp?=
 =?utf-8?B?bmlOUmpad2gwVGdFZXlyT05Rbng2Q3lpYlZSOVBrTExRZVc4SXpvMUw2WHZY?=
 =?utf-8?B?Y1hkT010RHpMSUdIVGNlWlpHbFA0amlTY3pkcjM0TnlaMHd5b3NQbG8xd2FQ?=
 =?utf-8?B?MEZzVEwwM0NmRjV0NUZiSmovaFk1cDlQOUs1SHpIYkdhSTM4MVB4TktuM3Jp?=
 =?utf-8?B?cmZGcUNIMUNmMDViMmdBQmNoWTcycDZpNDhYbHRJbzZrMDlGTTB4eXg1STlW?=
 =?utf-8?B?MXJjaXNTaGNnU3EvM0ZRcFlpdDI3bkZZRDkvWDF1eGhobDBWS2N4ZVhiS05Z?=
 =?utf-8?B?OS84ZGdLWktyZDYxMjRwcGgvbXRTZGZjOXEvZk9CTy8raUdLVEo2czFPbkJl?=
 =?utf-8?B?QllZOVNZWkQ1RnliaHN0SWlmaUxpYitRZEtWWW0xZFpPelRWY2plTm93dTJD?=
 =?utf-8?B?VVpWMWppeks1a1Q4ZnRma21GaTdsKzM1Y0dCYUkzSVhXa2VZenlDZUt3Wk9z?=
 =?utf-8?B?OG9JRi91dTlUUm5wVzhEWHZpOUp5bjdzdWhtM3MzUURCbnBySXdGNDdUTndU?=
 =?utf-8?B?eU8vN2hrZVVnL2NsbmQ3UXFIOEJud0Rza0tUb0J1b3VacXJrbG9RbGZxRzFr?=
 =?utf-8?B?L0VSenZITDM2SGhUVGlXSUNvZUpkbDBSRnhiVnpXL3g2OVZ1Q3NWQVZVVk1F?=
 =?utf-8?B?bkROS243RHZqUG9UcmYreVBVS1YyOUNNbXo5U2VBbmRSd0xPRGFqMUdRdWlK?=
 =?utf-8?B?ZWhRUFI1SEpwcFA5eDU3akxOYkdsdjk1a0NXOGxILzZmbWpFSk1xbHpwYnpq?=
 =?utf-8?B?eVlRMEhsZ0g0WVE0SEREaUM4aCtjdmJoUEMvVmJ6ZUs3eW9kckZ6NnFwblJw?=
 =?utf-8?B?Z29IUW5RaXIzelRWVEMzdWY1VUhMQmdlSjd6OTN1eCtMSXBPSExpNHMzTytB?=
 =?utf-8?B?NXpVUmNJMkIxZnJlaXRJcVptblpuQ0dEQjhzUlVMSkxvN2FSZTdvZXBPd2dt?=
 =?utf-8?B?cXAwQUU3UWJXSUNzNUg5NG9VQWdxbzNYdm9WYTd0SDlwbHk5S25tVVlrdXl5?=
 =?utf-8?B?NENMR09oZ1cxOE1Va0srdW1peUFDd1dtSnZGMm9KTzdrcnhaTExkcldsVERH?=
 =?utf-8?B?bkt3TUQ5aHAyMlhxcUwwUWoxdDFWQ0crRlVXVit5a0IzQ2czWVdQOWp2UkUy?=
 =?utf-8?B?cUZHbTFaeU1MNExpazFDTUZHZm04RDExTC8vWUFvTXZacG9GL2VUYmhtQmFS?=
 =?utf-8?B?cStEN093bmxyMGQ3ODdjeHYrNjBoRnBaQlFpRUlYWTRaaXFZL0Q5dHBIKzlp?=
 =?utf-8?B?bUJRT2NTMGpEN2l4UW1QOS9WZUxWQW5kZmROc2FWdGpUYVdQS0Q5UFNFdU9L?=
 =?utf-8?B?UC9GMWZsa3pNaDhqbFY4L0I2UmxXWk9vT2JNMUt4VzNPQkVMWTJYM2I5a2Y2?=
 =?utf-8?B?ekVjUXR2Y3BtUGFrVXFmWEd3ekpZc2NKTUMrTy93UGZWd25ibG1GVnhyeDY2?=
 =?utf-8?B?NndzaTZWY0J6NGVPN2F6a0ZtODdmYndyeWZBYmtJM05PaStRbUhqVU9MbCtW?=
 =?utf-8?B?dkpVNENZc05aZE4yZUNOVHRPNXF5VEprZEVDc3hqZ3kyT2dyZkJrT0F6Vzhx?=
 =?utf-8?B?bFRlOEdFeWJMSGZVNDhHYzg4Wmw4emx3NDFHOWVxbVNkRlBmdng4ZXlhSDZ6?=
 =?utf-8?B?TzgzSFFxeHZaUkRjVURBdEdVWmI0WW5ZWmw0ZE4vZXplYitsVnArYWpscmtF?=
 =?utf-8?B?aE1FOEUwaG9La1dsWmptSUZoQysvQy9OSHA4Q1ViSG9lS0ErL1R4Z3ZPeW94?=
 =?utf-8?B?T1JTdDdWUHFOeThCUFVTMkhPUnR1Wjgwa2xxYnFJdWV4NXZVZXVkQlc3WHoz?=
 =?utf-8?B?aW1tV1d0eGRCUTJYZDlvRk9tT0dLY2w1V1BvUXB1am1YN2VwRElQVCtZNG5D?=
 =?utf-8?B?bmJFTUdsSWpjSDIvSE42ZGFSaDQxV0lCUXh2VXNDQTlCMzQ2V0FBUTFpU3Iv?=
 =?utf-8?B?QnFWSkJTaDN5bk5scWNzOTZHT1R5NlFFYnFvUzJST2IreUF0RVp5VE5NWTNY?=
 =?utf-8?Q?4dnYgWyqv7Bc4i+o52/kWdFjz673taSqWVFOg2HGAGMWP?=
X-MS-Exchange-AntiSpam-MessageData-1: V9DH35KUwKFoFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392e86c-0681-430c-5ae9-08df450c0070
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:36.0837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkNp1ouJm+vpuW8BlMMqFSdJOsiRYI1cXkZWq8mhF4Vm25Kg9ZhA+Boh9LMpdat1QhUY7POp9+ArND7OwOj5ag==
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
index e0faf7fba0e4..015d9f831a7b 100644
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
 
@@ -1197,7 +1198,9 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 	size = PAGE_ALIGN(size);
 	*handle = DMA_MAPPING_ERROR;
 
-	iova_base = iova = __alloc_iova(mapping, size);
+	iova = __alloc_iova(mapping, size,
+			    min_not_zero(dma_get_mask(dev), dev->bus_dma_limit));
+	iova_base = iova;
 	if (iova == DMA_MAPPING_ERROR)
 		return -ENOMEM;
 
@@ -1378,7 +1381,8 @@ static dma_addr_t arm_iommu_map_phys(struct device *dev, phys_addr_t phys,
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	dma_addr = __alloc_iova(mapping, len);
+	dma_addr = __alloc_iova(mapping, len,
+				min_not_zero(dma_get_mask(dev), dev->bus_dma_limit));
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return dma_addr;
 

-- 
2.56.1

