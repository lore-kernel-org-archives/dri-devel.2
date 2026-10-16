Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA07CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259671125CC;
	Fri, 16 Oct 2026 06:47:49 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F66E1125C6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HohE81ycKNBWjixZolcn6xeJafayyvtvrhqOS8fskPQYUgdh7yGaA8dQWjAuOzqzWtWPBiUguHqgsdDtKlW3dVtLlv5gxsNP4dlfwcye3U+3TW1UYVYwTqOAo/27Bo4bZinu/NcoUAsg8/zNGyB91BP3c48Q8pr6iIXU+YQEfV/uF71QCkJM+WWFiWiY/SORx8X8QQEjINhtfM19rUpNoSeVAA+GRFt6AGoYGwm446d1A84z47sSTZ3wN26UG9ogY3AT0kne972kVUib1x4825TcySv+tgPwLrbRvhvVsBygjPS/2oUuxlT+vtV106zKVOoYCrhu8ujv1D9qHfwaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eztv2pkxGzkvVc9YxuQ1gvpWePiBoARhk1XhzQSd4jg=;
 b=i4XMzT6V55T6nrID75L2gcZSPOKb2mr8Vfjk+fwbetQJrwwjGlPRDzNmYbiuFgzWgspWPgjBG/D7X3DadRC/yLTBXQYa0ywEP16qajzA279LFk9MxamxFMplsSFxTEsbOpUopH/L02HNJDhVsN/9FhUpvgDjmeRYu0eaOqHx+D9LNTI8pd722rqdhrOe44En56mxrPKHOiHzbXvB48QduNjJSSeWshcFj+wqDZn0kB9T+jiYevVlMLhwGokHwJ+DiusIslvv0SlrxxFmTTZYh16rBMKD097u6E3WgmiPbkDBqJ5N2BcW0GKXfZm+0ya+IwdIWPOor78nEGMwSmB0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eztv2pkxGzkvVc9YxuQ1gvpWePiBoARhk1XhzQSd4jg=;
 b=tNHVw2rOzB9/lGxUOmAT+eLdPQZv5q+r3stg6taOwplLxL4Ie+Zp92fEMZamSQiC8doj+vLLKOwEdKMoGGcCwMFlxA5Ny8WW7759iTVAk73nbbQfZkk0XtA9WD/wnCQRucU1BOE43aqv7gIPUtkyN+MeWVrM/jUmeth3pKamqvBL8m/aAq4+WsltnZFRPxsBGK4iqjLvKzX3h9R4qF5tOT0AgVfXwd0frkY2Pnj86Y3jDS30K1JVCeMs9Y9LdQOwwR2uTbG8n3nxYhLUD9N4Gr8Ge3zxsaEi+dEAZ0TGFkiWixyl8gkxn5BslbgHOUOO6iQHdr+iwqMwl/4+lw318w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:34 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:34 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:49 +0900
Subject: [PATCH v2 03/11] ARM: dma-mapping: Split mapping allocation from
 domain allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-3-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::23) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: f31e185f-653c-4369-f01b-08df2b515b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|6133799003|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: hokfLMFytylJr8fAp3VlNcNsm/lJjIZvJUlUTLrkqnGvX+Vzd36SXuvvmU0UdogoKgj48eTHufF5x9U+4UYYlAluimXVQTcoDn4ufEWQBXVpJriD53VgIe58J6fCcxBpyFqOujKmqzAWeL+/rxICozn2vN7sycET73GoUfRXgOkBJiC9BJDJQpTgrU0r8pi5Hs1KnWeomjV4lhikdbwCH+Z4v2eqKxdjINp9IPy1nBb3og0zH0yQ9HU86UXwoFOQ1W6McUSGnh/5uDKKzh3JCH3gu0PTOdeNUgiZySi4xbURLUMnw4HwZuqgv2M7WF+vXhkgleQbp8hj1wEKGcsasp4hZXD+d5kLjkUIRcdAbKrgteHPx/fFvFYSisFC2egpa1dlTI5uJZZ9wamDkkGQlI+U9l9n5tdWKwOvGQQ3vncnMnH+xFKm9IP2/qxBE4u81fmBHsCm4BDLC3hINF1UnwkFr7H5lEFc44/oiOcTUa9s8Wy6v5/vUFmWngzgDeDA8NOdqogG2SbkMM0V81/2v2qmvzjMfY9CuoT4dRURlZI31w3MDbWd+uUc/IDkmhoaZiPn8d74eKmV1y1y52DsvFws8UG24QfYC2tbxMzgogwshfO9+EFHsFRzQibNdRpRxbUtql4vXTTSiyEz9YGBXab5ePKcixQoSLOHjiSikQg3Nbwy8DcJD8vY6C9TE+QSiCXdbip4f5yE9+gu7Kt+dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(6133799003)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JVNHdpRHVVaitzaVpWMDIwTEh0ZTRYN3E0b0hTcUxqbVcrZEJoZExwcXU4?=
 =?utf-8?B?Wnh6Vng1aUwwd0s5RFVaYzFOVmFOVWdTUDRKenJwSnU5anU3VDdocEduZ29G?=
 =?utf-8?B?U3BOblJiN0xCZ3ZxTThPcE9VWjhaV2VxU3ovUTBzL3BLcXNuQUtad2NlYVNZ?=
 =?utf-8?B?cWxhdjFVT0M5RGFBL0c1TVNwOEpQQ2RNMXY2a3VpT0tVSTV4WGM3Z2xlYWdr?=
 =?utf-8?B?cDJZVUMrb09iMjJMZE4wcXY0N3ExYU9oWnlkcjQ5MTJFRENNalNmOHJtMkVI?=
 =?utf-8?B?WGlYRlovREJOUXhlMkdrTmgwMm5uYk5pOXI2NWUwdjl3VmZLb244bW9JY2JO?=
 =?utf-8?B?RUxLUDJPcGpEckJhc2I3aHZrekJRb3dvekV5KzZ2dmJjYXRqekpnZ3F6Y0xk?=
 =?utf-8?B?eGdnbmt4R1FEbzArM3AwNUsrUmk5NHY2aEdnQnIzR0x6cDVQV1lxUWlOb3JU?=
 =?utf-8?B?SkNRYTUyYXFxUjJuU0NyVlV6Zzh1eXNWc0pKTTU4VUJ5ZzR3K3BOTzhRcCsz?=
 =?utf-8?B?dzh4TjltZ0FOWGdsMWlGa01LN2hnYnl2RXJzeUYzQzNkNDNLWWJqd2Ezdmdz?=
 =?utf-8?B?U1BaMXhwLzg1Q2JBYjR0THJrUDMvN0pqbWJtU0RaT24xOHBJRURXOGlFYXJC?=
 =?utf-8?B?TFpWRlZjQ1hHUmswTFlYQkdVYUlhMnJlSTYrM1dBNlJNUW1pVklHMHVrR1Qz?=
 =?utf-8?B?NzZkZUFJZlc1ZkJ6bjRBUkhVNHN6TEVEWFRpU3pPSUxWZEJvSDJTWGY2SWZs?=
 =?utf-8?B?SXZYTnd0MmtQbXpZZ1huYUpqaVFqR0RFV2ZYSFprRDdHZ2JvaXZUMDAxRUVp?=
 =?utf-8?B?N1ZzOGRtNkk0ZGNxUXJweFRVZG9nQ0ppMGhudjQ2NllTOERVQWV1aXdMNzNB?=
 =?utf-8?B?QzB4MWtqdnR5MG1IUEhDeStIQldjbmRhNmVVOFFlR0pzRmhuRElaK0JPL0oy?=
 =?utf-8?B?Y3FUVmw1eDUveHFCM3MxR1kybjdPWXpGVHdISlVMZVEwU1BZZzIvR0drWGY3?=
 =?utf-8?B?c2ZpMXM2UkFPSzBSYzdZLzB3UkY2UVhVTTJLbm9VVTg0R2VqcXlYY2MvWEEx?=
 =?utf-8?B?Y0IxSVN1blMyeGJkWEtnN2IxMUt4SkZSSzBkNFpYMndKT0FWN3QyaVJsdy92?=
 =?utf-8?B?RFFCQnpZbDdZZlVEcEl2T0NFSjNYSlJmaUo4d1liaG5nTnY2cWNCS0JwNkkw?=
 =?utf-8?B?bTI3b0greGhHc3BLRmlFbFBtNlZ1Z0Jsbkg2U0U1YWdDQnowQXg0dFk4WUpO?=
 =?utf-8?B?TUZVcXY5em1jYUJvZzV1cVFGbytDemFiWG9XMU4zWGZ6dFd3NndNeUpUbHlm?=
 =?utf-8?B?YnZwOUZDL3UwNWRibmlwKzIxOXAzUUJaWTJKRkF1Q2hwUmZIc0NJTG1xWlAr?=
 =?utf-8?B?Mi8xZ2E1L2FsNzYrdlZ2ZHBhZjNlTGxWcGlJZnlXQlAyTnlyTSt2dnhYWkwr?=
 =?utf-8?B?bFJiekZlMEFBZ0xCdjBZL3I4L3Q3WTdxeWswV1ZnWDBIZHFrNTJPVlJDcFVM?=
 =?utf-8?B?T2lHRzQ3eDdTVUJGMStlcFh6dFpJYWF4dmVlYnhISW9GS0JpeURmMVVOMFNn?=
 =?utf-8?B?QWtUSTdVVEZtZ0pZQzZWOWh2VkJaeWhhSDhJZlpsQnNjNVRpMWNrUXBEeGh4?=
 =?utf-8?B?M0wydXE4RjRaRkJ6UEZWbjlsS1JwU0ZjeDE4eVh4Y1ExcUNRN1cwVHpBcEha?=
 =?utf-8?B?U0tvdU9HVnZoTTF3a045cWV4RFAyRFVoQ3l4ZWZzUVhDbllwSEx4Y1hyS0Nh?=
 =?utf-8?B?QTZyTWZ0emNwQ1F1YjNGV3JIb0tmRmtnN2dQZWZuTnl1UGcrdnA0YzFhR1JU?=
 =?utf-8?B?SS90QzdQVGhEWnZ4eFZQRExOZDQwNGpqcFkwbngyVC8zeUhUOThLM2F1YzdB?=
 =?utf-8?B?dWdJUVNrK2JTK3ZOb003dUdVam9RVnJnUzRKTW5OZW9FNFlyS2pocUp3ZmhM?=
 =?utf-8?B?Tkk3TXNmMlAvRktFWkxNaDBQa2VlSEdvbUx0Q2Vnc0hrbHZCVTcrbTJqaEJU?=
 =?utf-8?B?ampNUFcwTWpXdFlkd3lpRFlNVjBrOWpHUWZGOFhkdXV1MS9yb2IxQnlFZ0ZO?=
 =?utf-8?B?YmVpeXZGdEVaVHlOaElXZ0tSMFpMMkg3dTFDM2lqREg2bG1JYy92Tnc2Mlow?=
 =?utf-8?B?dS84VkdDaHUzeTlQVWk0U1BvL004NjlxcC9pUU10Rit0SHQrTlJhUWQ0MnUv?=
 =?utf-8?B?cXdMU0JGaXZPZFBuZHRSL093L1poblloRDMya2R2NTM5USt6MnUyUHRrVmNp?=
 =?utf-8?B?UXNxdWptcFFySVNkMGd0WEdQcytjZFFrS2Vwd0hhdW82UWZQazdwaldvTVht?=
 =?utf-8?B?NTZjRGVsaktHci9laHl4UzBUdHVOeXkrTmZ3aWFDL01lV1NkRm9tdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31e185f-653c-4369-f01b-08df2b515b9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:34.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjsmZ+Wo4M7r1M+TweBn6wtmLr8bzFVCTLtiPHRYXeV+L1/4SJLcALYm3SnGd63xEky4KfpkJTPrCXXQBGuOng==
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
index 7761099dde9e..4284950a9246 100644
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

