Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF9DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F89010F85C;
	Tue, 15 Sep 2026 02:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDuX/+m8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D96E10F85C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHcHrtXx7JbgQljPrkjJaWjVZdtzGBP6hLTn7TFAK/boDz4EECT+aH0DvOqodl3vR91b/8bt3ofv4Bf8L4i3FcuoT859S5EvSgOsLawBB/u+qqvS5RACRh6Ri+Trd9ktH8YR/7mV5rbF64Q3T7tP0zcS3jic8wI3nng7dNDCOFYM9Ks4JON6pPOStMNqbPTRbowXmcnS3W0keM5qKKJadpyAld2LCkyhVTuMGp0nMhK1HmPR5+6PezyTtpCFDzgUuYgQLEAILc/5v+E3NbO3X99thU1JDbBCS86iRk53hnN+fBOdYsj/4+PDOo4x3xPd81y4lpUQPKAa0Q2b0cIgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPn5bdFiGPzOkaTxBoI1ZVuA9Ou1zvp5vngZJNDLjPY=;
 b=padVKlOjqQVp1nBDEkwQcX5jYDUHv07iaT0fqLW5BllEKuqYIvutkTQo4NYYAE20c1rDSY7ZEP7z9mYx4JQxe0eR4DUuGl4TH97YNPFkri3xmp1nuOFrTzM1C/FQqFHA6STbc9ALWwXsqV5xXx915TymJItgRW7WofKPZsSucbhnxxJ+k272JUzc9VzQLMnVLOYCOGp/OBSRxKRnpmFrho8E+N2tx39BMtJwcGyvXQbXZNAgrpeR80xUl2IcTybHZIpmnjJ9q0sRCtdnl7Ds867RBAjzvzNcIOWb6ujf93jPo8lNklunWX16BzXxdE73bkDcIPHIdUH+7njrz5B8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPn5bdFiGPzOkaTxBoI1ZVuA9Ou1zvp5vngZJNDLjPY=;
 b=RDuX/+m8Nl/x9A9HH8Kn2Kux2T324MQNV0BzGVk6KbIIYU1Yv6NTMmmnBsaMv10qOSSwM+Pp6Ybdciy/OT+pv9hQlWS8RF9WX7DYeIaWQnAemNW0tHgplZO6Bk9e7cEmq0pI52tO79dRSNeKcJq/3El5EHJ3FW7qrgJjOSoX2EJ5UmiZ4MlL+GPBfe5JFn465Pxy+aDZFMDoDmJU2WjJnse5VDK21ZM0iQA7+KxT0ao1c4Eg7w3z2Ffr+u7iXLLp1kJejS0ZwQ3+kMy/005ewvJsI3UFnSE8pqwt5RkjLDgUWthgZpLFg5N4QO3bjNtt3QIrab1EDWbOUouwxdy6Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:15:39 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:15:39 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:14:56 +0900
Subject: [PATCH 01/11] iommu: Add iommu_teardown_dma_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-1-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PSBPR02CA0005.apcprd02.prod.outlook.com (2603:1096:301::15)
 To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b26f8393-3991-4a87-a14c-08df12cf3c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 1s0yWPYNOA7fAosnYlKLzIxouSQHLtMu2L0J04oDwVuxWuAFdKWmact8QaOXtLobTVlOjAAciq2uVwLh/B/SWVNpMiFVxpim+6aA0JsjR8XCkjVGB8qJ79wV1jVi4rGdvEmiYo7VfqZlNAUtlJrquB6Hnkujz05mav4KlTN9R3kl9rSjjgEwg8iTbWtQpBxCBPOtCJGhaKBbdtai+EUWtVAoHu6XuTf4t0NbHGOUPZowh8OH1qELR1+PRJBMCY9mPcxSk1fgC0d+l/tjm36hvxJUKaqSqcfGN6BEmIAzPinPNdyod71I1aivNy3OV64W6px7TiKvgOPIIvGXGLUY3l7uP5eqCbTGyWAPUK2eVspTuLkCqV6fvqUsWG5/ap684dIli68qWHfgByNsTOd33lkHyXBb1isi0SA3rTOflLwk0pVXKndOExLz2IQXCHQm/I7xv5P0Klja9G5rAuVXfdcZaWcxdM/0R5RlJZ4aHNOoMlClUZn0kDXviK94t4ltPSmYsZVb4oMFRw3isW91SQGC/7xkrlQesH4zWnrGbrxDLHVbXGKtlAxUuFpfZQUJA0Zii7dr3JUkDsh6hNBFoSz5bYJnKKm8Jghh39R92l2tUe69bdvLCf7h8pDZ/EiRQf7adxzc2t75fAHwOZz8uNnVK34iCyQF+WoU3pgA/ZZeEwamsq1qX+bKnD2shl5NQHlPgeRvfp0r+ldySHRTBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5Ma0RRRjExZXpXTk1ydkQ0M2FndEhWYmVwTjBhUElnSmpVcVVDNWV5Yk5D?=
 =?utf-8?B?K0hGNTFtSERPOXF1a1NCYzhQQkNOeVVjb25SNmNYMmU2dGIxaWNxTk1FdXVE?=
 =?utf-8?B?bkxFOUo0MkFTcnAvQktQV0UwQ29CaHNKZmkyOEV6TGtuNGcrcFZ4WHk2NjJk?=
 =?utf-8?B?V2dUaHBzMHd0N1NldUJ4R3VGbVlGMzNWdEJzQ3RXYklPdk1ZYlNDK1lBZGdp?=
 =?utf-8?B?Y3FOZnV6K0U4bHltQ3lHT1JSUTVONUlTOUlMbkhxQ0VCLzk1WmlBNERseVNs?=
 =?utf-8?B?UC85T2U0cG9qb1BrYUU3RTRiK0VHa0FrWmRDSmpnWmZoM1VmbGYzV3Y4Tkgr?=
 =?utf-8?B?NkJMVjlld0xlT3pPNE9nbml4Vks5bzNzNjd5VWRJYVR5SkoySGhqdW53WnBE?=
 =?utf-8?B?ZkU2Rjl5R3Jsckp4YllWNFFGY2JBczA3VzVUeFhUbEtQVGhuM1JlRGd1YnZP?=
 =?utf-8?B?d211MW1tV0JWNHpaaHpwcXRJY2FSRzlvdTdJc3hldUJTaXlZdTg1SW81SzJQ?=
 =?utf-8?B?bkxaSjFKRTN2UmZvV1IwWFJIcjVNVGs0VE1wK044MjFHd3B5U1g1TDdhc3dj?=
 =?utf-8?B?UmlwM2cxSmNzKzZtUVpxNWFnczI1dEVORnEwMWs2Y2FuS2JlVGxSMU5TRk01?=
 =?utf-8?B?TVg2b2NQbXR3YWZPaFYwWXZ5VE1mdmRub3N4dkxMNE5KZVZVQXZOalJMMHFt?=
 =?utf-8?B?cUZoWUp5cFFUQ1dqNjVkRU9oM0dWb0hNd3dqK0pCdmxoMHk0eEdJVG1ONGZY?=
 =?utf-8?B?SFd3RXhKaTEvNUlXMUwvUHJqT091bmVhcFB6OFBJRDllTnJ1NGU3Z3R0YmZR?=
 =?utf-8?B?TDNFck1xR3dFbW1mekRPOHhIMzRnSDRJcFZmR3dDUFRocGF5d01WUitwNkpF?=
 =?utf-8?B?STd4NkdURTVhem5IVE9WdVBmZFltbWxXYjc0ai9idDdxQjNROVBtQ3dhVGpl?=
 =?utf-8?B?QmppUnlCSk5tRDJuNmlJd25mZzIvbHZSY2xWaWM3S2FTTlFrTmkrdWY5SHdF?=
 =?utf-8?B?dXZGZFUxd05hbzVlTEtheExBd0tHMlBraVNyRjk0bjA0eHAvYWdIQzU2UTJ0?=
 =?utf-8?B?OVlwcEliVFNDY0dxWVN0QzI4NU1jWlJBRG5ENlpBRFBaN2xGbWpCNy9oQkpa?=
 =?utf-8?B?SnVjNTQrQTVxYUFhbGxBWm1xZEdvZUZmWkJIczhuRlVtQkxvWnFyZjNuQjlE?=
 =?utf-8?B?U0t6aXV3cnBQbWx4WDkzN1RvcjlZVldvYnBxazk5ei9RamxoMmFGZ2p4RHhB?=
 =?utf-8?B?eGRWVGd6UCtwVk1kZ3pYUCtZbDRheFpha0JWZlBEMTNNU0swK29jSG92K1Zw?=
 =?utf-8?B?UnpxMjJmSVRXcStkNEovRExhcHpOU0w1a1JKbEZpQ0l3dzZXajc5YkZtbzEr?=
 =?utf-8?B?eEFPWGhuL0VsY2JlWlZ1bi90ZU9xM210VUR0NHptY1Y4UkVNY1poSU1FOFFI?=
 =?utf-8?B?LzlVaElsRUtXWU5lMlRCVjN3ZUFpdDlrUHFJOTRvZ2tUWjJrL2NKMjYrUVRq?=
 =?utf-8?B?TUhSam5LZFpwcTNPUjRZZ0JSdGtNYlJYTWliNm1KRGttdDE2K3VFRGI5NXli?=
 =?utf-8?B?UWp3Vm0zS0h5b3lJYmZjTTFlWk1OTkRHazZKTmU0VUJBbjhKMnI0SXovTC9v?=
 =?utf-8?B?dGFVcjRqa1RueU5yRUJSZkwyT2ZIRXNYYWF3SmZNVnFOKzVpUksvTHFoSmFJ?=
 =?utf-8?B?bTlaTU9sTUREcFVCWXpkMmhLK3FqVVE5ajgzSWt1elJzRmJURnZsQlJ1SjND?=
 =?utf-8?B?Rng2bTE0RlpWVXB6MFk2ZjVSYTdxMWlieEJLTW9lTW1MbjI3cU8yeG1sSXIv?=
 =?utf-8?B?dHcyZEFrRGpmZ25xYkY2d0NHbkI1dXplQ1N0NUtGRE9OeUU2Ny80NXdFT3ha?=
 =?utf-8?B?T3lHSyswWW9FYks3RVpObnk0ZmhKd2Y3bmY5MlFhTkhSd3J1M1hvRmtTT1ho?=
 =?utf-8?B?WmIxVXUrOU4vOGs0M2FEUzRuT0tDUlU4ZTZMTUMyQ3RPTmJPclFpL2Y0S05L?=
 =?utf-8?B?THhocll2cVg2Q3hOQ09iZ2c5a2FWc1FQaUhYUmNQdjBETElWWG9KUjZDWm1m?=
 =?utf-8?B?KzQvQUpoV2VqOXcveSt5M1lGMlBSRGJESlBsN2gyWVVLMDVkWUxFbXZOSWRz?=
 =?utf-8?B?NVlTK1d4dmNjSDEzVEY1TUEyVTZTUXNpeHMwNytKdlg0UmhRTUltZFo0amNT?=
 =?utf-8?B?QkxIWmIrSG9QdUEvOG53Mm5OVkFoSVZHdDByNG1mT1dpWTlnKytzeXpDRkpQ?=
 =?utf-8?B?ZDRCWXVST1JnZGI2dHViM1pFdEluV1RTYklubEdoQjNKK2ZTaExjR3Z1Zitx?=
 =?utf-8?B?czN1ZWJmamFqM0pRU2dVRlI4bEdFeDkxNzNCWU5IblZYMTEzVW5vbVlkNTF5?=
 =?utf-8?Q?aLtd4hU6k17waJtuTquf4uaSTbMwuRzsLXHzhzvrYK/Ty?=
X-MS-Exchange-AntiSpam-MessageData-1: h+wlVKlfhmZ0RA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26f8393-3991-4a87-a14c-08df12cf3c6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:15:39.3226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR01opopVMq+ds4xqU0+lq2s6+M5xLqbyzrXq+pSL+16F3YiY+snbFPZx5zIzsVuXsS0vFaD4SDe922lqs+KdA==
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

Add a counterpart to iommu_setup_dma_ops, tearing down state set by it.

Currently this teardown is open-coded in iommu_deinit_device; however
when 32-bit ARM gains a parallel implementation of iommu_setup_dma_ops
it becomes nicer to have a matching parallel iommu_teardown_dma_ops as
well.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 5 +++++
 drivers/iommu/dma-iommu.h | 5 +++++
 drivers/iommu/iommu.c     | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..26674eec5996 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2166,6 +2166,11 @@ void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
 	dev_clear_dma_iommu(dev);
 }
 
+void iommu_teardown_dma_ops(struct device *dev)
+{
+	dev_clear_dma_iommu(dev);
+}
+
 static bool has_msi_cookie(const struct iommu_domain *domain)
 {
 	return domain && (domain->cookie_type == IOMMU_COOKIE_DMA_IOVA ||
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d00252563..349d6a57e5a0 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -10,6 +10,7 @@
 #ifdef CONFIG_IOMMU_DMA
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
+void iommu_teardown_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
@@ -31,6 +32,10 @@ static inline void iommu_setup_dma_ops(struct device *dev,
 {
 }
 
+static inline void iommu_teardown_dma_ops(struct device *dev)
+{
+}
+
 static inline int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	return -EINVAL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..75687d1aafe9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -611,8 +611,7 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
-	if (IS_ENABLED(CONFIG_IOMMU_DMA))
-		dev_clear_dma_iommu(dev);
+	iommu_teardown_dma_ops(dev);
 }
 
 static struct iommu_domain *pasid_array_entry_to_domain(void *entry)

-- 
2.55.0

