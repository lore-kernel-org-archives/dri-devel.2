Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE39EC5DF7E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283F510E71A;
	Mon, 17 Aug 2026 09:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IFawisNf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E368C10E713;
 Mon, 17 Aug 2026 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960632; x=1818496632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=U8B5AScSEY/GlcnE/0BL0m6XiAzm4MZjn4zqXSEYPmg=;
 b=IFawisNfxFF1OgFKdsuHSBSvsUa8ViTi/dCVTHPOCEtW1ymz/iT11yy8
 wsH1OjcFIH559uQnKTdYAShz9jZ68UxvUewCVCGvnpA2vN7tgWnFA+W9E
 0gyz4Qnnp8ZQ0LM1CK0lPbn0gbrK0bfO5mn5aNay6WJzMAQb/nLyi8FuG
 2zlsIYw3HBhMWoXUFM02TiRL2qOxoW0COV41wdIx/JXqUWVowdzbQgKd8
 jUIt/hiD1nhmjjDdsb7MGGVZxC/pDAlQntWh3q/dtLs97XayRrlgg9VPC
 kZY3FMj2A0toYSDQPPYM4m2vr7CXdo9rBog2SeR+xIvulH9jz4ubfLFK1 w==;
X-CSE-ConnectionGUID: pDp5ezZgSCuuI7fheODohA==
X-CSE-MsgGUID: nNA2UxSuRMiCM+l2LTyycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98093756"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98093756"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:11 -0700
X-CSE-ConnectionGUID: kq/bijzeQciPKjUNYHYR8Q==
X-CSE-MsgGUID: yp4UPw+6QbSf1ivSL2JNCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="268713777"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:10 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX714kUThQqAOnEl3m6du5Z062TJC4cLqt0kzxWu9p1bz3CubllZSPq+xDFes1ca4GEH+6tEWdjDeOjSuXGEOJD7VDmoYDVulHWpRqCNiYGbJ35YvKhpcfchsYiqTZ69FnK59jKLWDZZ1PzmysCp8PvKGIem9Q06FV1lV2IKab+/XUr4/yZYWIQ3l1eqFUBTFJvshrKmaWBylkfczwLPIoohQFGby9ofn/1QVZCXEPww0SMFCsNCBCQRpyro5YnbRmHQQ54mmawTRTqhFKJFZW3DdGCSONq1puqRRb3ZI9ciegzDSg2pcuR0wfQNVlAhrgT7sZdYbp8HJeWlOJptlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGbAiQRoZk6tPOF2HmWoo+aK0viL/96y1i+l2rQzJYk=;
 b=do668s/gXECMV65bdthkXbJx+IwLzIqpbsFJI+g+OzfQSpY96zcqqEyc7Sj8YymmTn+V+us8odLUdTlVqq6hb+lwghg3UqQ6BiCBjpoXgL3jy/Yxgky8pfRm7/iJDiPcve8oP7EZltM5JHMNmOqVARneyyOMjscRsG5zpmgCTZK7s5isCGKCItN+hUUI4rXfEDcif1d8p1q0sdEScDA5CzTWdBnyzSAjir9OoFgXjWu+KRWjybRgl5Oi/7ujqprcxZAw2YniAQdBngnCDgmtWlIBDTrPIy3CnuNZ3iFiRe0E8dcbEPzXP3rSrQYtSfvxizLEw8FUITs2MoeEUy8R0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:57:05 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:57:05 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 3/6] iommu/dma: Catch scatterlist length overflows
Date: Mon, 17 Aug 2026 09:56:45 +0000
Message-ID: <20260817095648.2438192-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817095648.2438192-1-krzysztof.karas@intel.com>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: deaad4c4-598e-45a0-09b5-08defc45e4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XvyGsDPOwgUqYJqb3Z/HwKKmHruzUCO4YO1XDyuQle1rCrEAasfcYKIAKHPAtqgfu6bnCMI3bSZl10BhWiinhzY6NN2j6KtFksOo8tDqhG9fuoL5EcKiGGnp8yAxyalBSMIBk87LHBtT8uewibOY6lDRgh7KCBuCvY8K/ww8UtYApwO4c6gl6j9mXUqceaGOlYyXjjvz9B/d+KJGDvtsUwxZudVeGBey/G4+qmhFCkBg19svQYnLYedpZF9THmtTj1tUthp4BI+2vuQsgfBbw8oB1PX6IvjQ8niIVGjSG3gLCyLzqp2fczOrS/WMPXffS41DV66SgAsJrusbXFU13cMitBS6zV7G3qGSHczSUrMmra8Kl02FRm1/ukleITo/z207+XwDGO46A65oNDqfXzwgXE5Cg17zrTQW+AatTkhQvkY0NxXr2IhQNomMd2mcrEfn7OnbZs3vXMVPqZGH98RXJd60J2ibk9s+r/ThlgNnPXIYurs2MOdZorYJTmqn4b3pE3OlnL1jWAOGrsGfYxDPuToip7b2LUcSP6NiXYO8VnubaGrcGjS/DB+2vb2EhG+NEJvwDI/9xKmfirSBJY7e/7jvWu/bEqNPEVkUmZm5ZfrIH1k6Fn3X8LjUBpA+gIvIYkhc3wGiTnUN2GGUcWJNyvbFqBr1r0uf/TFEJRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOfe+6hKBoRllmGGT6Da9ULXcarGZCM40T3hXBbT/tizXKT9AJwNBh7bRbRQ?=
 =?us-ascii?Q?2xUaksgrElZKt0Cv/Ikwprtwfd8jfndeIudbn3LJ3+XiY5IURluLsHBS7XuW?=
 =?us-ascii?Q?cUY5XsV33PUdQJBNxJFCv/WAkonpC1Sgj8hrE63JtQTvyqGffNYS6lu+hJew?=
 =?us-ascii?Q?/iLn44f9jNWMIOd3hHKiMfG1LHR4fKcjLoJPfe82vFYcdtFEk4pQiuk/0Y83?=
 =?us-ascii?Q?jEL395tXFXzyDruRq74kkhPdfwojWIqezM20bHjyXBKWDRujXkDljLo7++Pk?=
 =?us-ascii?Q?zRz3fVqxRku46KLHjM7Rn/AYYrhz3binva7uaXUQJbkNm9cJvl9NChX7Su+f?=
 =?us-ascii?Q?CjPEgISoJrVZQ8UIkFD1j4uVYCpuY3Vv6cQu6tVpcgBaU8IWSh9sDKos2UJY?=
 =?us-ascii?Q?p5vEF83W3z2rn9/hHphLsznU62XJ+7hjrjbiFtQxSl2yqZ5d3VsbuPTm24x1?=
 =?us-ascii?Q?JPHjGWa+1Lac8cYAQScuDy9zVB4PvqDhgPBQhOoX3Vq/joN8x2FhKMBb9tFc?=
 =?us-ascii?Q?4SWIYfKmtwRLX718JDeNXdeQwy9Ow7yPFeb36F2HhceVwxG93n9NlV9jB0sL?=
 =?us-ascii?Q?GWaBxjjmYnRldX80P9pyCkML1JBMQi8hTMJjqBx/AsQUSlFOv7C7d0VQbWmf?=
 =?us-ascii?Q?BppWUjxWAuMMhme1LQXWVZQ2c+uwLOu2S+Gv+PGO682PqSglH/VTSc/qX/Ic?=
 =?us-ascii?Q?i5QuYTMofSCCU3RtGkRNGaI9I5qUT4V6kdqBdAhHAoG5gjrIu+Lbeu3EWjee?=
 =?us-ascii?Q?tyUK1vA/OEqoI0+CPg1dTQ6vV+xJir6B5a6Z0y1vao4ag+FZ+ylsgiYgex3O?=
 =?us-ascii?Q?QEBkScV9aK+aD7yUGCjus0k2nl6AClCMS6MwkuiZoHjs3f0JUsYuyg9BljkE?=
 =?us-ascii?Q?903vzKrq+VJnlyGDtzi0TBkbWFLvf0VYxkrMhEdQ/E/nUfOKYqPmngU7jL+b?=
 =?us-ascii?Q?Vbq6cwRW6ORvVjL/ey0C93KhiO3ZNh1d5MT1mb6W6kQrp9SPEG0CCvOnfjVC?=
 =?us-ascii?Q?D/W2Xzn7rtMYTLpvmUsU2oHakPws+M+svqPPgWRzRglrI0ghPfyYjLyjcxI+?=
 =?us-ascii?Q?lORyCX1Xvlng2vB0Nodua5L/+MmBXL72yM8t/I/Q+U1memUcboPqE3LuZuZL?=
 =?us-ascii?Q?rvGX9lRK07oxMa/ep5zSBB7FHVv9nosnm4P2t15bFP0IciDTyz11Np+zPCJK?=
 =?us-ascii?Q?EvfXjATb1PSD95WURJkBfaYmzGG8hNY1ZW7xHMP4/A+SzktdpgASi9UT2p/b?=
 =?us-ascii?Q?yd4d/qKNQ6g+FqhOY1IxxiU0suBft7QF+HeDORio2JyVY0eSGiS+z9P9FiWi?=
 =?us-ascii?Q?rQas7s5bMKn7A6L5Ol2ZJcYLtFB6GdPmY6kGTi/ydlmUfb+0l75RJfZDR2pq?=
 =?us-ascii?Q?J5EGo5cM60H4kq/XJB0+tiZCx0qDJmKRoDnWRcdu+ayYVOa6HQSdPcFlLokX?=
 =?us-ascii?Q?2GtFSg8dd7IG+S/fFVpg5SIOO1wXqCyjJIqm4XQ7696ua4y4V5ujgO5Ht+9L?=
 =?us-ascii?Q?GwMAyzIJtRzCxc1i1bhSNNEalFNmM4nN83zXmuoEzWd2jEvJZup7I2mLG8rJ?=
 =?us-ascii?Q?Zml/i+fZoxxMd9hM2us6zcxNQ1lSer5dnO+1F83hdM6m0fIBK335SsGdj0Fz?=
 =?us-ascii?Q?NaJY9T4O5SSekOdt51e2/fywmztIwEmWIL/Y6db7/NiuwUFyJ27EUYvFp4PO?=
 =?us-ascii?Q?D7z+uvPafrIYkv/n7WNpCyxeX4xcONw3IWp5H2ww/JlgaxsUPAwZb9xOpc5o?=
 =?us-ascii?Q?nP2B6sGFgBMWRFZh5EvT6Mjm24hNyN0=3D?=
X-Exchange-RoutingPolicyChecked: js8bwy48zNjhPKpCF8nZKEf89ojSnHhyVT0ncD4ZArVuAIwx/XiXW3IQRDRlIbXryFYbNNpUQBYizRG1eEdP9jeSok3Avy4lT3/7jSJiHOfmmafYfh35BB5/XewIby4+Zi4kzbu/D5YlSVPLA+/HtvOxfpxbIV3kpthWOihbdhUHwlS/ymHi6a80aOdHLBb+oOB9LUlI50cFX4OaHtGR0+5sIO3ZmHD40oqer8SRTaNc1YwCX6L/cqBVezyp53U5omd2N0GVW2I3umyOlXEu8BrmCpkhQPrMPI+mMk8Soky9e0q7wqEs7p6fOeiMy4wEnSE8ywkpsY1V7sZQPPZDrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: deaad4c4-598e-45a0-09b5-08defc45e4ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:57:05.4736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 429505Xt7ZGrZetVMNMCaoOZO9kHMzNTHwG7d9n3Gf7MPsibcNO14CtnMEg9bQy14W5uDPO9+uAqRBE2jS+1G7uHx95YyF/yKro/5IaP1/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
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
---
v5 (sashiko review):
 * Included overflow checking on addition, previously silently
 omitted inside iova_align arguments.
 * Added check for zero-mapping via temporary variable comparison.
 * Added overflows_type on s->length to satisfy 64 bit systems.

 drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..0bd5b13f006f 100644
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
@@ -1445,6 +1446,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	for_each_sg(sg, s, nents, i) {
 		size_t s_iova_off = iova_offset(iovad, s->offset);
 		size_t s_length = s->length;
+		size_t s_length_tmp;
 		size_t pad_len = (mask - iova_len + 1) & mask;
 
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
@@ -1476,7 +1478,22 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
-		s_length = iova_align(iovad, s_length + s_iova_off);
+
+		if (check_add_overflow(s_length, s_iova_off, &s_length_tmp)) {
+			ret = -EOVERFLOW;
+			goto out_restore_sg;
+		}
+		s_length = iova_align(iovad, s_length_tmp);
+
+		if (s_length_tmp != 0 && s_length == 0) {
+			ret = -EOVERFLOW;
+			goto out_restore_sg;
+		}
+
+		if (overflows_type(s_length, s->length)) {
+			ret = -EOVERFLOW;
+			goto out_restore_sg;
+		}
 		s->length = s_length;
 
 		/*
@@ -1493,7 +1510,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
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

