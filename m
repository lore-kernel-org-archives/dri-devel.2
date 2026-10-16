Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8BDCCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B801125F4;
	Fri, 16 Oct 2026 06:48:08 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E8D1125C6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0KMngbGjN/+/FOi5ZzKp4FUOdZtu8ma2awjtI3a7+ylh0uCKFXfoxhhZMkwnkubdcDnkYya7zVFcB5F+V8yNSzv8chydL/TrbqmcCzleH9ZmKVUm4oQVgQIUs37dZzW4nw/9a+dAXY6FeU9Y5HQRm8AdPsskfs9Orq5XRemidWe5OFLa8jNl1px4VIL786xlu187y0rJT14prgcUrIfASWj/3nCzVb3z+K9clKxsnHvNUviT1Zr7fEvOzChvh0itjvygIInpzqGUN06fKMPOhyP9tv0zFSXYU4Wy1EkKK6NVE0AtQ3TiJJxZEVi5uwt59kay9QpYyqBWp0kvP5lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbYwVjX1w253oNkzMi5EarZnzZyILMj2AiqbENbLWMQ=;
 b=QC0aIMWLUe5SLL1ci15dUBxOBxScAGcDpjHWzwe52vj2IuCcCLAM3zEPX2TypLTwA42DDK1arxMANd9Snz3jwL6Xe4il/aWjszT1TTU2+ygIx/5QSpiZ4odICPYh9gilv8SzhzPJcm47z1kg6gX4PERtfXvoHI1+XSzYD0Al0TOJlaBuFIBKrofUB7J0oiMWqVa10kN5MGk45uOBONnbxFJlTBKrULuoGBARWl0igmy6fGaqJ3sXHYTeyid1j2Hxm5hQOcVG/+USh7zmU+oA073tYHqXyoc+jMA9Br2ODs3IRdu36pmEmXNMBLhKkOpx2Lwt7o/czMdxPVUZcebzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbYwVjX1w253oNkzMi5EarZnzZyILMj2AiqbENbLWMQ=;
 b=NVHGawXv4rrjggCD9paPZs/qo41kHxDldQjdqREq6BtmGZ3e7CM768V1kXCE8Y29fkwb3A3v1dlNmlTLpQs5R/qY14Or/WAv13a6PC7qpFCHFd37sV1YIoAzJqRk/sv7V3G3K/CefqPlU1BL24Appe/D7HzFbKcRcJwkketKoaONa/ExiGU9DULnHv5G2upQ5uf0r671v1T9kg7LEgPfu6ZlXVmcEzPEpzMnaA0b7NYusFxHajVjYQij7wu5sOKA1kkzbJHlwscvpkOvMzeJfDxjc4npc3JkEgaBDyZ+Rqx0+FjxgTIGSz6IUA1mrGS4cYuLCRUhWF0bAAThkr6f+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:55 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:55 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:53 +0900
Subject: [PATCH v2 07/11] iommu: Let 32-bit ARM drivers opt into a DMA API
 default domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-7-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0125.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: a6111762-edd4-4c43-096d-08df2b516856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|5023799004|56012099006|10067099003|22082099003|11063799006|921020|18002099003|3023799007|261009223027099003;
X-Microsoft-Antispam-Message-Info: Ec2gWHSU2yQDWN8WRNNhOIs3bZW9Z3cMCuHpxGsPbIVadz1EhCq1K6o32UNfPDrIDNS/EoKEjcUDtA7S3POh+GquKBozhDRhSFBjG9VXa+Q5/EGXMTFEO6ZDQ11onrO4PYN6K+eBRiE8VcGcBvifRrPYgJuRBroeuBzX7ePo5OnY3GkGepfNlo6xQ4lktDzUfTmDcue9DvAOMf2HmT7PJTIZgYpAilfXLpVcQetBvyeoHMYSselZ+/wIDZ5Kulj1d4oJxKvMwXPMMtCT8jUxTEeRuHFKQNBWdMBKtRTxiIc3mcCF5e7u64y96VXQloUZJBU4y1oot6y+8sNbFFvNw6Jjbp0qqwO7lLVV3QhyhZK1aznA8Vt2N4qmvr7EgxxWFapcMimlmPT+2erkM+dNiFeZW8hnA8w5xjSf0GzdN4J/FozuivZsjmYQR4gcFvXaeo4jN6rzvI30pu+ng2yGBDPX0JgckYoR4ZiPaa61hhdUyndrO/kUYyNn63Z77HiBVInJUgFZ+FLbSIdb+LaODm42senVGaAppdpULPn7U+d1BPdAzIVvK/KSacRbkNkTzrRgnnGgF0ekvUPRUUA5a46PtFYDb4r0VGL7eT1YZAqEp2FEd8yl5W3ylj/1eDWYvjDGnzB4Nea3Wd1j7YjpnOS6XVt1uCNpyT1LaUA1sWkOlxfsEVjPCp7WhQlf5dPUdVkPT5onk09o5II17irJ3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(5023799004)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(3023799007)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3RrWmdhZ3ZBZ1pMakNxdk1uVytpVzhPWEFzL2Urdkd2SFFlUE14cUNZUEJj?=
 =?utf-8?B?bHZQMk9OYTJuVjIvWEFzakJONjV6ekdJQk5nbTl5b3FqVnYwcStnRzdaVzhO?=
 =?utf-8?B?cm1TbEdKZnlneVZ6bGVkMDdYZmRpOWZZWkhjSkwvQ1hjOGd3WW53YnlldU5L?=
 =?utf-8?B?QTJJN2E1SVNGN2grTkw0azM3RTRIUUdrSTM1VjMxRjZxdFZuSUJ3OGwraFNj?=
 =?utf-8?B?NUpYNUhZa0FXSTA1a2VrVUl0MFdZYTF1SmYvclJGcTVWVk9lSGlIQVpLVWZl?=
 =?utf-8?B?SXhYcHpSWEQxK1FKeXYwbUgvWEliTzR2Mld4cGNVWW1HVVBCY1pLMHFMMW1v?=
 =?utf-8?B?Z0FFbHBkVVY2UFNhejlkWStURUN2UXI0TkhaaE9rTHZmUGY5SjA5SitndEM0?=
 =?utf-8?B?UFIrZ3BKZkp0RlhpSjdpUWNDbVA3eFR2VzJzY3Z2cXIzVGJybkRwQ05rUGRM?=
 =?utf-8?B?TXJBWkZCVW5KNjFWcE0wMzBuNWVDeEdsNk0ybTFmYmE0bHdkaCtwTHdJYXJa?=
 =?utf-8?B?ckFMaU9DU0RQMk52SEd6NG9QTVYrVnBpT1Y2c1NjYXZmRlIySGNmbkZTUzNR?=
 =?utf-8?B?OXcxcERPOHhuUnlaNFBYVkNIYzVnMWZZV1JEdVpjRkVxMWtuay9wRTV5Z0hr?=
 =?utf-8?B?b05XYlJ3VlJjOTR6VWthdVdQUXFwMWRjN0xETitSN1htYktldVFialVNMnd6?=
 =?utf-8?B?Z1RENUhPbTVvUGUySFV1cEpEdXVUMm42TVNDc2pJVy9jOHlxRlJQVm9yd1VH?=
 =?utf-8?B?alVKVURyV3ErclZyM0EzVC9FMFpOdWtGK21aNGo0bGFwR1p1QTVwZmMyYXkx?=
 =?utf-8?B?OGszUk5BbG5DV3c3NVh0cjZaM3pmZmRVc09qSDVoT3pYdlBCS2FYNitrL3Ra?=
 =?utf-8?B?RlJsNDFZRHBxRlRPb2M1cXJKRzFmbkJabTh3K0M4Rk1oWlpiSmo2cDRDQWdx?=
 =?utf-8?B?ZlFRckxrandLL2toVjdEakhjdm4veXVyTnppYlZaY1lSYUhyWlZzWURkSy90?=
 =?utf-8?B?UHJZYWlod0RKbW01cDhIY0tqbjY4MDNJaFpUaFVrNmU4Q2Z1ZEtPM0JsRGIw?=
 =?utf-8?B?S2NnbkZpdERtQlhKWmloajdZYlM4bS9ETHJWQTNpV1pUQ29YaFhyZndDaVFZ?=
 =?utf-8?B?WHU1bEgxa3ZQNjRSWGJvUUxFbmhPQ2IxdUU3c29NdVNnZjZrdGI4cTlqNTky?=
 =?utf-8?B?K2h1WElqb1VtZ1dQNldjU2hHNWVHZ1h0T0FnVUc2VWgzQ21MOG5rdUtURTV6?=
 =?utf-8?B?N2VtaTFLMHV4ZlM3dERWSUFzSHZlTzltcStITG5NTHA0cndVdUhDVHNiZUZH?=
 =?utf-8?B?TitXbDE5NmhleTVzaWx0RnpHUCtzTzlBS3EyTmRoa292WTNDNE5VNzBaWjdq?=
 =?utf-8?B?dkJtNUdoL21xL2NNTDRmSS9wMkR6c3o0R1RKYWVCWUtzT2lUVllqYlByUzEv?=
 =?utf-8?B?bzhvOXhha0Q2dXJFdFpOSkxOTnYrYS9hTUNLdVo2N2IweVNQcjYwNGdZRmMy?=
 =?utf-8?B?YzkvZ0NTRWkvWjIzNXpYTklBUTVMNjJXWGpRRUUwL0l6TDE3NjFFU0xZb1RL?=
 =?utf-8?B?MHpQRHlUVENicUp6RXI5cDgrbzBRWXZ6Slk2UllHbmZnQ05qTDVmbUFGbnBZ?=
 =?utf-8?B?NGk0bHdnU2dOSEFtMFpmL2dSMTRFWGg2RDNGZC95dlNaMnNMOUM0NXFoTXJS?=
 =?utf-8?B?MW1VMk4ycmkrTGVMMW96MFRLOWVhYWhlbm45QjAxeEJwZk14NmNTYmVLYVRi?=
 =?utf-8?B?NStwdm1tMFZ3UlgzZW9kMlFrOGl2RXZVdTh4MWQ3d3Y5QXBWYzY5bUh5OWlh?=
 =?utf-8?B?L1hiOW5IN21Ua0dXWHFHeFRDRXpmeUw3WTVOQTVRUVFNQkdvRjdaUGFHbUp5?=
 =?utf-8?B?Zm5tRmJPSWVLVE9MbTczeUtQNExQandMSk1idE03NGFUWWY4N0hTejVBMVFp?=
 =?utf-8?B?VVk5YU52d3pxZ2VXRklNOWRMdjVLb0J6UFJET0srN1FxZUh4TVVsdzAycTdo?=
 =?utf-8?B?TDVWNHpLZDRMQWhhSTE5UkJ4MmRweks2bytVUERHaDFWekFIZVllSms0ZVJy?=
 =?utf-8?B?b2JQWUp5dCtpQjRpNGxPNDlMWWNtY0c1NTJTYVhhMmtyN1FQVjJzSEVHSEFv?=
 =?utf-8?B?ZlVXZlJ4R1hENE51c2lqRzNoVEpDUDlDNVByelBOeXViZlNZNk9mcWdiQmo3?=
 =?utf-8?B?NTJGbnRMNGRRWmFobDlNYzZqQVgrc001WktHVm9ibWhlZThDOFMraHRSUDFq?=
 =?utf-8?B?RWdzeWZndHkxZ0xxYWl0dGxTN3pxK1doc3ZmbzFac01SWWlndDhGY3FFS3g4?=
 =?utf-8?B?M1V5dlFIRGc2bk56TGJJQytzZFA5VXdiQm94a21JT3Bsbm96Qk1jUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6111762-edd4-4c43-096d-08df2b516856
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:55.3527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vbe30ODLnwVeLiBLexuxYebLEp8iP0JOfVZOi0iHlGMYjsUIGWwh/LHhoaIkoiZvMPMIQYaOed+o82bKpcDuVw==
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
index 5fbb76d44a1e..0d812c4b9f08 100644
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

