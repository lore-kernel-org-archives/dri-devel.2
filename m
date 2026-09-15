Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F350C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EEF10F865;
	Tue, 15 Sep 2026 02:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="d6cKwftU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED7B210F865
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcJhU7gkrXYXZ/zoc+AMcqzaSdI/JBbQZ3VIb9wV7Me70BQLb6Q7f3vm06GOZ44vqurGYsMVzZJPO7lpmvv/HxK7slR9vSWszdev2I8bwOjpi8GpFCUD6Qq38XCvRG3Zvtj+NkWMhlA8GfKgBgDA7Cfu1dGgAoGH1VGm9L+p+AuZhuqg6Tky7UXxdUHs9R8Jaczzs7f4wJ6QLhzlsHiKUcccSxCZ5L623dr69yktvQbG970lp/fPnePZCaR3AbXb5sM8Wt1nQsKP+xTlk4C3AIytdLgLAe7p0Cv49SvWnnRCpypy7Ju/vpMwNSCAJji+POD+YOhO/2uLt5kXsbbL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9t54wN71arLgNRLTjdvSK+1bC7OucSnoT8rV9I/cZw=;
 b=gDOlFI5XTj1oHaaqB8tnJ7XEDn9EkIVhLVaP/lfmpuHPdQ2MvJd7OIvOs4t5Jh8A5ecVfabbiPQF6nAdStRiQcQTn+RB/KXy1AotSdqXErP9Z886jMkzCJ57UsxHqAtGi6BDv0tQupaOwhC1+VN+m9Eyaxv8KzddJzRQQtAIT7lp4Bqdp8w0ZpKPj3dbxHLPpRF/XLOqlVaOpId6CxqHLerKw4qKD45vVkdu/Q6Rr1xawqZgY63bZlmBTHYkjpZgjbIEVhCoeW2Jh/nshbnzSHvy4hcgy5jWWMAWHR69exa9hvm8+cAO+33UL8DSBBf3AGR+K7OGO2rpYbz987STwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9t54wN71arLgNRLTjdvSK+1bC7OucSnoT8rV9I/cZw=;
 b=d6cKwftUa2YXtthv/dEMycy6uFNPaz1QkgF4FFYfIsTyuHE8Uku8WoT5LIhQKGfuQLwEpTZklLNEAoc8e43b59IJPRfJRsNxTUSv4meSQypJoswrwbVwm+3kqiHAl0sRQ53RvNN+OI8mzXIzMZZnREEDu4EQmXJ+Po44lYIXMjheTREvGbI0Hi0Eh5tnyOoU9Zu+fY8ICjWG92eh8eMa9U34nbHklPdhTUJGWijh1KDMzi3FpOQ0lNIDG4a8g6QWDGOmj4ZXmpv73R+2638k7cAt2KPW8Fx9g41dEZ6MStDu+bFQZ911phIkfPBkJ6CLilobMoPfRHPgg/+yDuEDMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:16:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:16:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:15:02 +0900
Subject: [PATCH 07/11] iommu: Let 32-bit ARM drivers opt into a DMA API
 default domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-7-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PUVP216CA0001.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16f::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: af59e93e-3c37-4144-5e00-08df12cf4cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|22082099003|18002099003|5023799004|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Spy68dydwKJy5YCFhR7Cl1WMZBQHGsW7lysjyW8gNhgNX8qnuGx65lEyRCHaF8F8dkqRtjf7JjcrdM7fwmOrEc62I07br6iGrXYQ2o6MZvNPlnkpVEdNyl7OJjJF5B+ib7dXwSZKdYmwYlFKDwU7e/775QUefWDA54P0YszSa4AvD8THxKcPZiHuiEkMXoMOyQchA3Z0tFx2CC4Puk52JQH1QFeHuirV83t5IPA230ScnnnD/52CUo4DG0vDjbscOaOgIIlolkeounwExMvb/a4c0g7AqnIlS6WstRPr7A6ZT9GqCRu4YjyNM5P8K6x7h0kzyqeWQt1sNql3b9pTyX1vcgNsgu/7B2sfNShn3AmifEBxBiEMauNQzCJTyIIgw5Z9ExjTiebWg6P4/ODwpT0O4IAbNfMr7yPiWSnZLaY/9+A8/94J+vVzMhttlO82xszskUcfkg5OeerApieBAsutnWCAZll/FJY23sWpzH0aCCAxuyS2uMM0c4SXllwArY+mcIEUVomlE+x06CAOJWENpzpU1XJVuDGJY3HGfwLpJFm4OCEAHH42JBaQUZQM2b7vV0/IoshNsZ8NnjV8PzJ13Bk26tkTDO6xdJQWnWjqZwUJ+4ItBm7jhC//LoSxOmMVBd7Uk/GTMrhNkR91pm7KKjNd2PLQUqVpuFOCZ9O1CpPnBODxpWZnFdNB3L7UOwIFooG/k88TKSZZyqCF3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RTYk1VV1o0VGFKUkI2NTF3ZGdEU0dwcVNwUFVjbTFFdWZtK3ZQMHBEVFp6?=
 =?utf-8?B?UWN6UGVTWjBnUWNYTWlTemlHN0M4RkJQNjFDMUNEZTEzNjBOYlZqeUZ1U2tt?=
 =?utf-8?B?cFJvOVJIZk1oVTJTa3dwNTd5MkprZ3Ryb3ZCSEF2QVNpN3dNdlpNNy80Y04r?=
 =?utf-8?B?ZkhBTDhHdlI0eCtiUkgySW5VYVgrTVZmV3BaaEI3SzArRHJkVFl1QktMWVEw?=
 =?utf-8?B?Q3VzRXBuOEVLa3BKMDlWdWowZVBhR21LWmFYZ1NoRW1QNG80ald2SkhxZ0Ew?=
 =?utf-8?B?cnNRN3QybHdJOVVQQkp6M0g3L2lvaU1vZmNFeTBLOHZRWW9DOFQ4OU8wdkVO?=
 =?utf-8?B?bVJiOXN6ek1uejAvNXBkVTZSRk1HYjhURFUzWDNZS09zVXBjRmM1cXQwTjFE?=
 =?utf-8?B?VG1CWWFkSUFUVnllQ2dsVlFLWnRhNmljMThZY1FwajZnWGRyTzdkbEplL0ZQ?=
 =?utf-8?B?NnNCdTlWc0lkRFoxNjZ0T3A1dUtaQVptS2RZMEMyWXpINm5RREE5S1NyUmlS?=
 =?utf-8?B?MWw4WWxmN05jK1hJZ0FGWXNHODBzNStmd2dqSmF2ODc2R01RMW5mcjUwYWdF?=
 =?utf-8?B?OERaTm9zSGdBYU1TRFNWL2lIM2Y5U3hRRUd5Y2FwbGswbE1VTTBWWUFwdnFy?=
 =?utf-8?B?YjFJZ3JCcVc5MHlSTnhFcW9FM2tNbXNOK2lRdFl5cENhVC9uMm5zbTdzOEJr?=
 =?utf-8?B?Rm5Hd3VBVTVpM2tDMEJ3aERLQm55OWtGdy8wbjBFMld5SU8rZlFGeld3bVlq?=
 =?utf-8?B?ck1OZU1EL0ZKeEpsSGh0bU56UGR3a3NwSzIwbE00TENSRm1DSTRHOUQ3blJT?=
 =?utf-8?B?bGhCWVRSd2l3Witvd2lrUVJGYzlSSklKOXJYS3hiVFFkL3BZbG5XMHB4WGJR?=
 =?utf-8?B?cENpenFoVitDcTV5aWpHVFRmNTFoeEYzOWNMUG1zOENkOXhDWW5jNmg5M0hE?=
 =?utf-8?B?a3N6c1BVYUFGRitSd1ZuclpRSlM5SUxzVE8za1RFbm96S0tZbHJ4d1RVUlhY?=
 =?utf-8?B?aWpsc28rQUE3ek9rWHBoNXZ6YWxnbzcvekYxUTZnYmVmZVZUUzE2UGExUFJK?=
 =?utf-8?B?UmtQeWJhWXIwRkg2WTBLZUc0RUx1eFhzUURQSkVtR21JdkIwUEJwK0VlZWVj?=
 =?utf-8?B?SnpoU3VCcmhWVEExYytQMHhVQzZFSzNWMFpHY1YxNUVad2ptREMvd2JIVU5V?=
 =?utf-8?B?eDBjTFZlTjFBWWlXZU9Xa3phYjBTem5hb3hkNUYydm1Dck1ScjNVby9Zd0dk?=
 =?utf-8?B?REs5bWw2MEpoWjhjbWxkdjhVenEvMXFncjRLMnphSm1rWFR6QXJBMmcrOHlZ?=
 =?utf-8?B?bWJZb3RlVG90c2pIMXBjRjRVUSs4bDMvUjhUU1FNd1BLRTNJRUdZYzJRZFQ0?=
 =?utf-8?B?eS9jQU55YUd1eVRiWWIxYXFZODlDV1QxMC9VR0M2bEF6czZwRi8zMVFnWXhY?=
 =?utf-8?B?NTVIdWZVYUpqeDE2SHRMdnRSYkIxVEphOXdnVjNab3A4UDhVUjk1NUNRdXVk?=
 =?utf-8?B?R1ZISEdEQndkc2RFU0JnSXVFM3VLYnE0dU1OamZGWVdHSXZ3Ym1Ualh5eWgw?=
 =?utf-8?B?dm1WYlEwNDV0Rlk1dmhwbEhkMDl4NUlJcGE3d2M2VVhiS2dwWVA0T2hzcnNN?=
 =?utf-8?B?Sk5MK3lrYjh0eGpMZkd5MmhtVmVUZFh3RU9LSlhIM1FWYlpZWjFlbmM3M2FP?=
 =?utf-8?B?NzZHSjJIeVFJd285Q1JlZE9id0U5WGRYenk1d0pxMURzaWh3WGF3azJRUXN2?=
 =?utf-8?B?bVdwNi9XUlM0TWJrcDJHanV6bnJGdTNuWlh6MGsxZHFJK3AwcUJONFY4Rjdh?=
 =?utf-8?B?TDFCTHgvMFppNVlXTm91Y2RlYVhlT081TXBEaVFnd2IybWQrTXJQYTBVZnBy?=
 =?utf-8?B?WTFSNzlzQmtMN1NiT0hhQUNWMjBCeDRYZkVZeTc2cytzbi80Skwxa25CUzlz?=
 =?utf-8?B?a2NCOUt6cHg4WWY5MmNnV2o3YnhXa3pQSmhyRnExVFVaeGdHK2NyQUphMjJG?=
 =?utf-8?B?WktLdEVjTFZGOG5aQW5Wci84R3NLTWQyUkZXTXp3ai9FS2YwZlRLSUJONlp2?=
 =?utf-8?B?VHpyK2hoeGQrNUc2NENramlpVVRRM2NOSTV1OVpGUml2dEd2anJYdjRjdlhO?=
 =?utf-8?B?cjlHaWYwQUJpN2FPWTBIbk5DeDZWZytSUmdVQUZSQ2tzSzZQWm9ZVW9lejJQ?=
 =?utf-8?B?Q0hYZHMvaWI5RExNNmUvT1ZBS0NJNGRSSVpKWEg5VlBqV25ZZFNGUTZtbnEz?=
 =?utf-8?B?cW51U2dYWkVIbFVGVmxPQlhsdDM5c3F5ZXVMRzEvd2tXWFlSd25LenE2aDN0?=
 =?utf-8?B?c0xocE9wbDhIZHV2WG84VExmd2VlQW8vb0tZQS9PRVJuanNoSVBxdTVTcW1C?=
 =?utf-8?Q?0BgPCEF4zKTVBq07aA44/FyAUFzLlxjJkQu+/PWTxjgVY?=
X-MS-Exchange-AntiSpam-MessageData-1: Zgw6AgtJDXp/Pg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af59e93e-3c37-4144-5e00-08df12cf4cd3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:16:06.8410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tS5WIUASaC6jtdjtPl6bwbbBYujiDf94yruCMOt32vdAeE8/x6U6P+8Lwt6wDyrvxJbdMT++QzLmDZYFl6YYQ==
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

iommu_get_default_domain_type() unconditionally forces IDENTITY on
32-bit ARM as ARM_DMA_USE_IOMMU installs its own UNMANAGED domain on top
of whatever the group already had. Now that the ARM DMA API state is an
ordinary domain cookie, IOMMU drivers can ask for a real
IOMMU_DOMAIN_DMA default domain instead. Drop the override so that
->def_domain_type is honoured, and let a driver-requested DMA domain
through the !CONFIG_IOMMU_DMA guard when ARM_DMA_USE_IOMMU can back it.

IOMMU_DOMAIN_DMA stays strictly opt-in on 32-bit ARM and is never the
fallback to avoid unexpected changes, as drivers today return 0 from
->def_domain_type while expecting the legacy behaviour.

Behaviour is therefore unchanged for every existing 32-bit ARM IOMMU
driver:

- exynos-iommu, omap-iommu, rockchip-iommu, msm_iommu, ipmmu-vmsa,
  mtk_iommu*, sun50i-iommu and qcom_iommu have no ->def_domain_type,
  so iommu_get_def_domain_type() returns the unchanged cur_type of 0,
  which is forced to IDENTITY as before.
- arm-smmu returns IDENTITY for legacy bindings and 0 otherwise, which
  ends up in the same place.
- tegra-smmu returns IDENTITY explicitly, and keeps doing so until a
  later patch.

Also move the static_assert on the two DMA API implementations being
mutually exclusive to drivers/iommu/dma-iommu.h, next to the
declarations that depend on it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/dma-iommu.h |  3 +++
 drivers/iommu/iommu.c     | 20 +++++---------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 71b23cb698c0..24fa4165450f 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -12,6 +12,9 @@
  * IOMMU_DOMAIN_DMA default domains. Only one provider can be compiled in at a
  * time.
  */
+static_assert(!(IS_ENABLED(CONFIG_IOMMU_DMA) &&
+		IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)));
+
 #if defined(CONFIG_ARM_DMA_USE_IOMMU)
 
 #include <asm/dma-iommu.h>
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 43dd69662fac..6b4c328852db 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1884,18 +1884,6 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 
 	lockdep_assert_held(&group->mutex);
 
-	/*
-	 * ARM32 drivers supporting CONFIG_ARM_DMA_USE_IOMMU can declare an
-	 * identity_domain and it will automatically become their default
-	 * domain. Later on ARM_DMA_USE_IOMMU will install its UNMANAGED domain.
-	 * Override the selection to IDENTITY.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
-		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
-				IS_ENABLED(CONFIG_IOMMU_DMA)));
-		driver_type = IOMMU_DOMAIN_IDENTITY;
-	}
-
 	for_each_group_device(group, gdev) {
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
@@ -1913,11 +1901,13 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 
 	/*
 	 * If the common dma ops are not selected in kconfig then we cannot use
-	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
-	 * selected.
+	 * IOMMU_DOMAIN_DMA at all, unless this is ARM32 and the driver asked
+	 * for it explicitly, where CONFIG_ARM_DMA_USE_IOMMU provides the
+	 * implementation. Force IDENTITY if nothing else has been selected.
 	 */
 	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
-		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA))
+		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA &&
+			    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
 			return -1;
 		if (!driver_type)
 			driver_type = IOMMU_DOMAIN_IDENTITY;

-- 
2.55.0

