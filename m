Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E9DC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEE610F085;
	Thu, 23 Jul 2026 10:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PI/vwrZL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1081910F074;
 Thu, 23 Jul 2026 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802365; x=1816338365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=aoF+ZCL3dkUN9DNd+PXHgsjleQY2bzeGIWxbSh7nu3Y=;
 b=PI/vwrZL9ywDFm4pq4ugC1Xrcu4kTwYj7WidWTnEVMFX+U7itwAJrdR3
 g/LBOzqHr1jC80KvrMitmPj/jY3jWwLlZ4ef9sBjv15vK/iE58CvFX1mj
 sA5EfQQvFbFwLMUZ38B2YbKKY+sLIQgFFlOt06pSLlB3+oKwnD/kGY1pP
 h3JHwRNP0OO4piXAcGbvT2oDSwU9fvm709WkxIjFO7reu92JmC7fAw2lk
 szOW5bhkWykcSPVjBgrn6wW/LWcmL++Z6HxOmb174jdnYmV3Q6bDvVbt0
 CRerLc2vpZdKvSOhnueyC2IzUB2bxuF9dgg/iqDsDuPKMbbr/7JO3bdfc A==;
X-CSE-ConnectionGUID: rPCyy7QBSPmdwsnNayEsFw==
X-CSE-MsgGUID: 0nFsWJXaTpiLUvDuxGwGsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85471140"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85471140"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:04 -0700
X-CSE-ConnectionGUID: I2fiVpovSDORmmAn9IdykQ==
X-CSE-MsgGUID: Bv5sm7k+SxaCNYXJKApwjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="255726963"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:26:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIjxFBaPwdv1hx/yMY+c5PnkRJpPfyYlnS/2DwIRVKcD82C3YkeigzoB9tr1HXy+xE0u1+SZG+AzFXQDPGjpUtAuv1b8+mJb4Fi4VWXi4Se8MAMYc5rQN8K+6wnonYE+zRD5PosbO7XoQYviQ82P5USavidC7+0OtcUZ0EbfHUbyNoTBHR0Hd11dLRIH+IlkbUgw90uQbVGBI41zZ3TyDFbva42UVE/oCpLuVZ0x251C/6v8hsFjK9Dnh+H08uasEJOFkbj2bqmVT/E7/btXRTM+4BQUol8OKmjy7zDHLeXmTjlcYKfGNYBoyhvt+Np/LwLi0eZoVFDVvR7zvqfTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS4bvIUqCDa/jkXu7GIjG0fkM5PtsagzkZNlH4IgBrw=;
 b=KlyntXhMe3qVBSARVV6cUXixMm6J8+5VxV+2qRqWSQejJSHEKqZAmgettHICCU/XVqTblAu7KP/NbpKv+iNwPxkocp1bDzViMhtZ07+oO5BFvP7Zbd2Jlas49PuADyodvrvhMEKGOgamagMMiGzc463Sbr15wgATiruVQgy26tDOTUEx85pWMWE6GaiYSqoH833+0lZaz0+pk74sIEy0qjO1YZo5wXNKPs7AOF8mrJ8dJQ40XStIyy33aF63u2FXnJSm7xGtDtA01/UWOVNx84R1nd4SbozEtKt/N2742Jx04k1LJzbeAP2Tj6xMqkFlmPBotmRGG8uSmQXvNdraKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:26:02 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:26:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 2/5] iommu/dma: Catch scatterlist length overflows
Date: Thu, 23 Jul 2026 10:25:39 +0000
Message-ID: <20260723102542.3245495-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723102542.3245495-1-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|EAYPR11MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2d7e35-ed6f-4dfc-76ce-08dee8a4cbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5bR/xTaZuDuYvp6f+Hh0A3dawaLGp99Ad/d65hEA2ewmLo0PuqN3loruCagewY3HiejTJAq2VgekZ5iH6ebx9ZJ8ToujwPk06jO/Pfx1eOszthYliv0+jMvqHLI48E+VJHElVGtcmLNPPWTyo8oAdPiAJpwjXX87kg3YvEYYTnmvKctXqhwAqFHorq9c5E/ouneorlaxAWXaTTU+2wAZ/UI/NdzUaDqkyLafoYs6g7097VXfuOYGC9eXxBr7zNuwt9ebUVC/Vz/2hktDQqwLICw9bTGFYTtJGClDHKfHgv+lglEm0wpZGcQkQ6HxHA9iGcxRmXK11GbrgOqNxbU/iKdOalA6eXhuLfXad8dZYVzE+tcMk8xeUr1qX8A5o4TS8skLfsxDl9Ib/8DoC7MFbSNKx6AkVbPk8AmBu7hAdlIDGQrqFgbm86xCADadVnWjj0KN1Uceq6IA+x8RbYENlDjINnC2qbhXlxUq/xGE1/mv01aV43f6Eeu9+O0i2/ms+D0YYldeuVfife7kIpHtYJ6Q5o9HE3nQhO8YA3M1Tbx4zdLDq/yJs6COP4+OWWFJuGqVXT+OQUVZKBbHPML2OCxt2gGCbtxGCu8lKbfKB6gRtfV77xTUKrVUCwrHDt1eTESxvAX+hMw+yIeMp6ZbLg7QQX5sB+VgYr26whMWsUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FkJ0h0aZGp/1zDdmJhl4bujcJOrhlhuASNsKdv89Dtq1BZVYrQttHW+UHor?=
 =?us-ascii?Q?AgF8YHnpFUwhLg0+ccViluOy5y5PyypYLyE74Q0El/ZHxi9Qzv767K1zNb64?=
 =?us-ascii?Q?Bu7+7kf+dhDCfEJbsfrLOJoIHgRb8/jd7Ox7zRwndxeC5D7nj7z/3rGMYEil?=
 =?us-ascii?Q?oVNzYU0DpZ/pvIHpNTbcTs5jJujBcYCKSzIWL1RSiHBI6DMBsVf9hwVKsqdA?=
 =?us-ascii?Q?4oxlMfdDhs4zJk48aQaymPkERhIoWI1sHL4LFLTXKaAJBH4Jj0f5iLhyR25w?=
 =?us-ascii?Q?gWn0dr0HSHtCMPQhETAdj8fUXXjSzHVC8ktFQJPJADnZT7JtRgsn6SlSN0z9?=
 =?us-ascii?Q?PAltiWBdYe5LtWXbn1PjyJTX5lDs6fUjF95vaoeorCwD9pHdXrzmZN9XWm6R?=
 =?us-ascii?Q?ibRuNgbnkIEjKYcKWi1doTGwC53xCq7k8DFNXZ0ii/NbB3CN11DdN0Xjm+9i?=
 =?us-ascii?Q?APkakqOrKQQeXFTt+OF5vwgOS8R0Q85YqQa2xHddnk2XsRqT6IOr1xvSr7Es?=
 =?us-ascii?Q?ww3t1JyeSF8AUTsWVocmW4kKE7lWOpaGy70rts0TEtVTe40EeTeCDPk4kgfh?=
 =?us-ascii?Q?8PPmHxD7OdOQOsG53LKT+D6FGbhpzgIQNUVhtTwh0zH0di/DBIkAN83lrwD0?=
 =?us-ascii?Q?u7F+d9Q2aZiTMdqn1/6XIwonPiXFKsTltFqy9KR1FPaEam3//kqolHaUCRzn?=
 =?us-ascii?Q?kQTJKDACFNg7uv9Bc9WYiL8//jhIO6b7QvAl4F8E5W+qqcKUVYMtRqLl9onh?=
 =?us-ascii?Q?tLBkNz3D31dQei3NI2TrgPEjyUCNriHdgJHdhTuvsKnFtvRemvTAlsEaDHwb?=
 =?us-ascii?Q?Y1ZKgxqKqfNdFcKSTLXiY+/raLK38oTwZR7D7BYztob9Kdpygnw6FZnRafF8?=
 =?us-ascii?Q?yT6ZIdyJ/7v00Z4oSFGFWi2Yxt9aAJQlbeLpJvh7hoJ8TCgEm/mCjsnKMdSl?=
 =?us-ascii?Q?xpLkgY3Nx14aQa1JZx+PE6BunkD2hj0JUHsyVb0iyqvbWFmpO3r4EYa3cClf?=
 =?us-ascii?Q?+xMomxVfcqfACo53hPT/6VtypPQT1Le2N/Yu/p1I22QHL9y0w7Xnixq5mesx?=
 =?us-ascii?Q?vaOW8UrVjnGCIMoVeYJLdwxxkSvpAJ/zNBv8u6fb4xb8dMDyFsVOv3h6oFtr?=
 =?us-ascii?Q?tBQL3cMatte+QW9OxGJdVBYODsyci3PHulsbfVpeu9xQkyTpL7uCXRUieDFl?=
 =?us-ascii?Q?EMHT5dlh3X6o7WALzh+w+xlNAooBGcbi8peaR9hiAiVuS5YuTs8la8t8UXQt?=
 =?us-ascii?Q?CwiozUc3dRQMcWkLWlrj8APexNmwwWOFb5xGnxFWWG5Oaw/yClpJR7HKqpJl?=
 =?us-ascii?Q?mThpZDm+L11vVD6ped30DqYiqC+OE5VVULeSLtbiHCekPXD2QyIez6ubwHyK?=
 =?us-ascii?Q?qR0x7+L957yNR21tmG96i4I8SnlxtqBW8ngtZghXVmR2LvS05yJ6XkXaQ9iw?=
 =?us-ascii?Q?Sy6q79UhY/hDeCZ7YkeAG/rZy1yHmhGhHku93/vODkokaSY3X5k9QWeN65/A?=
 =?us-ascii?Q?LSsqoWn2C4NunNSbCI5FHSI3PosEm9ifCj7rbQSdxdym/YyAkTkPOqWDGMGW?=
 =?us-ascii?Q?8FwLltWWetDd2U0y0V4HnIRDL3Tg7/CHs2Yho4nSy/F7K9JQpSStlMBFqMY4?=
 =?us-ascii?Q?Ul3wxpNBf2Ov/4+838eJqcCIemRVxWMmFwX/4U6gHKxF520dYCnTgJFDJbJy?=
 =?us-ascii?Q?+kUaLOWBNZSmHkLpHBRRPxhr965DRMBNXHDDStPeyVfJ3uSkdlPtPFZP3cs8?=
 =?us-ascii?Q?ZPEKcUJMVXIS6WIMYa3opScDyQJFxyY=3D?=
X-Exchange-RoutingPolicyChecked: OXhEG3Ot5k5TK2+f+o84gQzl3dor5Z2uCHT7pe0jkX3/yYwm9Pnk6rRmYHjcxLombM+8Hb86popJyShR6OBvpxKjkwcjS9MaED/DeU6OVVifFHnLr46im5CrdbVBBeaIqOUJkIpPai6pFTNhQ6R1x3CD5xjwP6qReCFReXg1RpsD26rzUS/HGktPH7zIrE2Kg4VfB8uATqimW6ByAKBRg2kq7yQ2/z0Us8uYcPh7uDfHKj9qaNSDZDtvNhGcsY1HwX01m1tBElrQrbQbc5DuF48RrAc4UAlGr4y7c2FEn91y9AgA07uhlxmhArF0iCEANmxNgNtWjdiIxuE9ZqbPsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2d7e35-ed6f-4dfc-76ce-08dee8a4cbac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:26:02.4433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/PAso1fMWA4+a3mrP1AZWS9g6p6kPGUy25bom/1WzfkD4s3IyczArjqLmnw7lXqinpdLK7UTM+FcPnNAfQkLOZm9Km47ydgA/3YHemH7C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9969
X-OriginatorOrg: intel.com
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

It is possible, when a very large mapping uses only one
scatterlist, that padding overflows scatterlist's length field.
This results in:
 1) silently wrapping the value
 2) smaller than desired mappings produced by iommu_map_sg
 3) leaving mapped bytes in memory (no iommu_unmap)

Address this issue by adding overflow detection for scatterlist
length field.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
v4:
 * Added value wrap check before s->length assignment (Robin);

 drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 381b60d9e7ce..3ca3196a41b0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,6 +21,7 @@
 #include <linux/iommu-dma.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
+#include <linux/limits.h>
 #include <linux/list_sort.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
@@ -1477,6 +1478,12 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		if ((s_length & UINT_MAX) == 0) {
+			/* Prevent possible wrapping upon assignment to s->length. */
+			ret = -EOVERFLOW;
+			goto out_restore_sg;
+		}
+
 		s->length = s_length;
 
 		/*
@@ -1493,7 +1500,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 *   time through here (i.e. before it has a meaningful value).
 		 */
 		if (pad_len && pad_len < s_length - 1) {
-			prev->length += pad_len;
+			unsigned int new_prev_len;
+			/*
+			 * For large mappings spanning multiple GBs we
+			 * may not be able to fit all needed padding into
+			 * sg->length.
+			 */
+			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
+				ret = -EOVERFLOW;
+				goto out_restore_sg;
+			}
+
+			prev->length = new_prev_len;
 			iova_len += pad_len;
 		}
 
-- 
2.34.1

