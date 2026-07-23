Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20E4C531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1EE10F091;
	Thu, 23 Jul 2026 10:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FO9NH8T1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999E910F086;
 Thu, 23 Jul 2026 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802379; x=1816338379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=uHwFbDhikrXNoy+fw3vQl7f4kDjiE7/K0bTYR5CM5F8=;
 b=FO9NH8T1Nf2QOnL6zAyow3OHafW95qAr+DWb219DDhS8JggOe9hIOGVr
 IEPNvwowCJ4QqEf5ZlPGmB24B8Ejq0BfAa3vd3Ul36GS/Lle+7fDCfWr6
 I9HMEmEmjo/lIiE88FKBoHX6Es+w2SqfKNDnin/Hpw+TL0qhXnSBIU5RD
 jiMAOsnF5GkC4gcd2KBNliCfpoiQtbaM7o264+dqjhKAVlQmVPYR8sJOl
 QBPsr9OsuDiCEWMPhK0TQZ3ZrXm5xeby4KgyK61NfDPumExo94RKMdZj5
 LJOB0OMaYWn4I8oEjiJElvMe/neaJELWix7dJ4dGK8Jw6wGU1AVdqalKt g==;
X-CSE-ConnectionGUID: bx/hZjZaTiutdjiHP8aieg==
X-CSE-MsgGUID: 4mLUPN8sRy+XHbyupQH/7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85649086"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85649086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:18 -0700
X-CSE-ConnectionGUID: NBT8dr3iQ0yRoP7WHY9UfQ==
X-CSE-MsgGUID: ZXtI+TmTQmiFJW+l/FlCHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="288365382"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:26:15 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvYLXFxOlVCxIS8iVbLgKyQtedTcsHnlmLjqj4pukjI0DYNa35mNA/x62VKIn0CRhvOzrpn2GcWx3QTGu5NrRw9uBqeGZCA9R8S0TBRzCJV+H54GjRlQB74VmgZ54Ivkv5Diq5AWjqTaxZr7VezpJYXRNmT6kn9uI6wFh91iNYP8KT2Umo0pyCPqxBT2DbWr0cp9Jx/lNDUT1Pps9/G13CO1BR+QK03fpzSjsBzEV4BW1FNTOYXrASUCcSM3viNQulrgZKlEUyo6opinZEwdBIPkAy3l7WQc4JqYTl2fJC4z+hltOE9DCXNXUI9eEdA7JzQs+5EUFXM05Ih24hbSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXjBJEvMhLFwRIvRERol8ftKNby2VrPD61+lqRxrxIQ=;
 b=q2CaIRdyruJF2B7ueA22MDf3NHWcmvopEKq60k4wJav80J6pDufBEGh6lDMvE2wIwXsS+nl4D4gQWTye8IuLd/0mvyAY/R8x+pvwKLSGNdurqxAA+EnA1FV8Zzl28fLT7DzeN8GYGbsXNxLHsrdWii9QC3ZayLshzY7g1O0pYrDGPhRy/R5OIAveTd10urDT9bsBY2ocpPdKUs9d2hxMMi9Bz/BtVzUnp1+lZoJizhzlAVesd0IiN2EdwwDTJRRzG6W+DnD7V90lTLpsxofOcAJ5eyTZv+xUoYSEqXlI+2lQE2sLc77fkmvLM+OqelMlEjVvhbv/nx+YpjTVcekkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:26:13 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:26:13 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 5/5] drm/i915/gem: Remove iterator and use while loop
Date: Thu, 23 Jul 2026 10:25:42 +0000
Message-ID: <20260723102542.3245495-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 315ccaf5-8118-421c-f1fa-08dee8a4d254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rgP3VlWs0Am60k49n5rhAxsQzWB6qrXCnnT5D7piC5TR/4c2kAPCur3HO0Xt8pYmeDD1zp/iVo1wa2kcI3Ykc5UDL7MKakTeKIRcdhG+vw+ctGd78J7keAkA1/mctlu1p5BuQphuintJ9q66fpAD6aA/yEdNH+vLj/CtggY48CCXDMphmvFzTPAFAm17NRnmTsm2TSo8VWYZQg1T43EfrOygS8AbB3Ko+naIQ1QuVcpLZh9gpCubzxy3Uhf19Yz2ZshuIREmLeUVB/8M0Wl+3JXMiT4bOcX4U2LugZ/bUVSkxA2i/4rVXyNOd1up5AioWOghBNMq/45qhxgTz7Qjw/dm1AC+YZIVPLIj+6h00SJx5RWwGUj/o5H7/0/9la/liJ/aP9gCjq1XTCm6CJoDFFf313Ik3JislFM9eEGeR4Xk9RJJU8PoFaCaNk2AZGpNZzabcXVqm+9zh6AeluV4Fc5jTIzD3C4qMifY6HMtYdlfvm0zP6OTPh/6cR53bmMeD3d14nfrzVJOZ1+1dOEhrJYUbwOzUARd08K6JIwMHeDwLizVW5P/ZtWGQSr9G61baMpTRIGMDYmWinB2tEINDPcE6Vx0nqzWoBmQwGkhnt4AFmLv3XpQUJHxmbcZ+wl6jUEUKOPNGYy1lko1FnotYw2G1fz+F1Ns4XcmZxd39Cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5TAJpb4JL3NI4y7szzAsxUt/vWFKI65Sl3L68iEapB9cAZkIxLeYag5UJTKD?=
 =?us-ascii?Q?1Gk6OsQjigLjg8D11zm+2Z5WDde7Eb34ddYJ1Tm4mrcRPnFmt2j2+eENfjRY?=
 =?us-ascii?Q?96kE8o/JOpzNeKU0RAuuxRZ/m2k7O9OVoAUf5qnDl1x5CU2s08QVnXwVxjv/?=
 =?us-ascii?Q?D3n6yvaKQVH6LYR9wlRVbshh6H6c9m9FRkksaRMHZi6Vi5P7U2XluJbOBRYS?=
 =?us-ascii?Q?hn7mXxFLYqSrR3CUc9ii9NWm1RXlQY3TsA/CxbN83inMXHEILM1T3BgCnhmH?=
 =?us-ascii?Q?uVGVMilaGD+C9S+IH/p9uJJ4dXDb+2nLzaw/RPqyQy8xvhfLixMATW73e+Nl?=
 =?us-ascii?Q?kV+ch5XSkjvXA56QR+6xC6GA+YrTlXslPaFS8UFzNd2zjqpn1RHeMzXai6Xe?=
 =?us-ascii?Q?RKqjRRWWzZ/9ircLwLPTCrGC4Mp3BJx9Sg+jnyc34owxgpRvkmb3BYAW8QGv?=
 =?us-ascii?Q?ZlXNi3BlcZInQ6leJfsHwhwuN8SATEjvdot7BWmY8omYQHN6tWgWOfrEBggE?=
 =?us-ascii?Q?TJ+WLdPXRLDKhvDVU+5fXMCgOCAT1tKa8z21dji1Voum7NBXrE0U1nGBp5+u?=
 =?us-ascii?Q?RJmfqG2Fpg5+9SgLB0bSKtR0pD9ghV2/klcSxnDmETsG9ob76rzAhEWoj66j?=
 =?us-ascii?Q?3gHJRMUjacWTV0/InOfcrqHHm/5hrmKamGJI79CSPnxvQQbJQ8Ld8CfpmL8O?=
 =?us-ascii?Q?CwiAy6KzrMknz6g68yhzaaf3ayaXuxyTWaWXmxy8VcZa58OlKEkHPJLO6iuy?=
 =?us-ascii?Q?2iSU9yGaQaJTyCAqgjJBqBA/rppCqmerFztDV3IJz95UqLrOR7mYlviEjBZT?=
 =?us-ascii?Q?Xfvybgd0zR2txmdyLY4YJGU0DklXtVBCHUlbYtH8AF5tZ01uY7KC429zlQmY?=
 =?us-ascii?Q?jV0ln371oF5G1hQ07H6Zs3mRx6Y4NaB2XalMsEGhHJ80FlJXmWSHthcHyZL5?=
 =?us-ascii?Q?iF4pikWGezgpzrMFN9uZdAOHS1zaCBf0FmkSKR0IS6nH5uDhkeRWoMu59W7Q?=
 =?us-ascii?Q?UU/b1Omktwed4g3Gm9q1+S4tIFpkkoYBdJcZkA6n3aHiJ6qblA56NOzpBcAx?=
 =?us-ascii?Q?Tu5U4aKKAi5SblvdqQgmGMPP5t1S/WKppRYy9wqaKTGz2DfBPODh7e0krkUA?=
 =?us-ascii?Q?uNG+Fj1Sg9Atm+LvTaE4Z7kFCf6J5lxYzO7e9R0B7wnzgQ3r1b19g5hFo2yE?=
 =?us-ascii?Q?wIEbZlKhAv+eXePfHtYCCMB8d/sAq27arCt+NWctE9PTfVGeBYMJRDmoRSv6?=
 =?us-ascii?Q?0Yujoc6Jb0i06p7GNFybCgJLB1LV4PAGCXgEhuFp0P0frFq1EtvLKKfThQiV?=
 =?us-ascii?Q?V1gYfvEIQUcmBkZPYzJoQbMF7uM2NJAXMj+oxSGHNgMfsc63OwVulBrt0C9f?=
 =?us-ascii?Q?8Wpd2EMYQdzEUvkbru1O09rKxQhMuqAXBPLyy7HvmPQPuHa8BniCED8lUw/s?=
 =?us-ascii?Q?r1b7ELUdYPy0kbp+axeJXZALlYJiJbqzVXvGDvdgFOnupjgONRIHPq8E1okU?=
 =?us-ascii?Q?Yfp64EkqehKzptbuv2+KGOUEIapGlmbCU5dFh2NjfJwqb1QoCpAY6+5BQ9ac?=
 =?us-ascii?Q?6i+YShQejRlGbgG5QW9zMbtFDnaJgS1/srlGky7cjxlb3rtB/0aKbh68nAic?=
 =?us-ascii?Q?gdh2d2Mx/s68+qsiyxP5TyAei4hi0AxfTEGJjB21RfBg3H+vsqi+yM6G7BoJ?=
 =?us-ascii?Q?192nrtlcDmzjDmb1kyBiHT4nH0XBbxD8FVBTkptmdHRyjtooU6G6NLrhSNEb?=
 =?us-ascii?Q?ns/B6x6UdAfCTlv8uzenUQWOGw3nu0M=3D?=
X-Exchange-RoutingPolicyChecked: G8N3clp9vMLNwAdf84lIPObrfU0TrZam9eCdI87e4jEm3CtMQ60bxTOY6vDWixodI3AR8eFI2SCfnU4ZsYRapJ09TFdr4hrmAm3l4hz1xrqF28STPVMh2Z3pp1EhRnUTefhXnj9/5GTeH5/qh2nVYb9o8tfvRUHkt62QbSy3MOYDT+9hTuA6QzJIfQWPSWgZ9p/OhOUOjDDPSpKSE6mC1T/QclJuemvMWNlIvSGXlTqxF/usyBp96tXhNRQNuhRs2RzsEKYKK66T4ELqAyGsRKjhtVveIWLFZXlRuUZ3SR8JlRe4Tv/oy6AMMQcILJaX/X5AU7yuIVy0FbjBxXQVBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ccaf5-8118-421c-f1fa-08dee8a4d254
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:26:13.6276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUvFXbA2SHNAAHyZ9/vbYm34OcsHS+zxqdgivXDzULBsKO0WwU4dqxve2xpTQthzy51QJLt2ubhjNKhFZZd7k5kb9dseSYG02duzvwS/Uq4=
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

Change the main "for" loop into "while" to get rid of obscure
iterator "i" and use more descriptive name to indicate how many
pages were already covered. Detect first loop with st->nents.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
 * Removed "else if" and reverted to having all three conditions
  inside first "if" (Janusz);

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ac8022997553..f8fe5e3a4eb4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -137,11 +137,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned int page_count; /* restricted by sg_alloc_table */
 	unsigned long next_pfn = 0; /* suppress gcc warning */
 	unsigned long folio_start = 0;
+	unsigned long pages_done = 0;
 	unsigned long folio_end = 0;
 	struct folio *folio = NULL;
 	struct scatterlist *sg;
 	gfp_t noreclaim;
-	unsigned long i;
 	int ret;
 
 	ret = set_page_count_from_size(size, &page_count, mr);
@@ -166,15 +166,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 	sg = st->sgl;
 	st->nents = 0;
-	for (i = 0; i < page_count; i++) {
+	while (pages_done < page_count) {
 		unsigned long folio_page_index = 0;
 		unsigned long nr_pages;
 		gfp_t gfp = noreclaim;
 
 		/* Grab the next folio if we exhausted the current one. */
-		if (!i || i > folio_end) {
-			folio = shmem_shrink_get_folio(mapping, i, gfp,
-						       page_count, i915);
+		if (!pages_done || pages_done > folio_end) {
+			folio = shmem_shrink_get_folio(mapping, pages_done, gfp,
+						       page_count - pages_done, i915);
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
 				goto err_sg;
@@ -184,7 +184,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			folio_end = folio_start + folio_nr_pages(folio) - 1;
 		}
 
-		folio_page_index = i - folio_start;
+		folio_page_index = pages_done - folio_start;
 		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
 			ret = -EINVAL;
 			folio_put(folio);
@@ -193,14 +193,14 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 		nr_pages = min_array(((unsigned long[]) {
 					folio_nr_pages(folio) - folio_page_index,
-					page_count - i,
+					page_count - pages_done,
 					max_segment / PAGE_SIZE,
 				      }), 3);
 
-		if (!i ||
+		if (!st->nents ||
 		    sg->length >= max_segment ||
 		    folio_pfn(folio) + folio_page_index != next_pfn) {
-			if (i)
+			if (st->nents)
 				sg = sg_next(sg);
 
 			st->nents++;
@@ -223,7 +223,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		 * and predict where the next folio begins.
 		 */
 		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
-		i += nr_pages - 1;
+		pages_done += nr_pages;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.34.1

