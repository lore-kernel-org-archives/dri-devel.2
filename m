Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF478C5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3A910E70C;
	Mon, 17 Aug 2026 09:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="boSwX3OY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE38010E71C;
 Mon, 17 Aug 2026 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960623; x=1818496623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=8H3ULHu+I3XQFaaAx0hlI17gt9dZ0wlV/d5LmOYtZfI=;
 b=boSwX3OYTI9OXU1aHVdPAkbkxnuFTOCUSvUj/fTumyXpixwQO4J6QvjR
 LDOQUp9rYbbS7V1feE3Z8f1TRyTm+xM02Ck9NE7cMe+mnjK5S+6X9tPRO
 YGvX3+07FSPd/+7eBKBVvE/7v3cWDsAbQfAYL6Zk2WZQwHVLOK7MoUVuM
 63U3CNkqXOrZct+Q7KT8g1c/23z0ZGzNRNEWLRP8CWyyzN28ao/I4LHGO
 LTO4DVhGWVvTq+mvmonvZXPrq8dqj7yCQ7vrLGXG2Rw8buf/TBkW0zCA8
 P5QQrvv/0uHnTPlY4QktV4HiY8mAylnnJVsCpuf3vlyjw5NHMCzi+sUE9 w==;
X-CSE-ConnectionGUID: W9XthyNHR+i5Dcy1Pxb27Q==
X-CSE-MsgGUID: xEX+bEbXTEGKHgt9p87KMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86551598"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86551598"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:03 -0700
X-CSE-ConnectionGUID: C1zugHOvQ6GjHqkKpnVQEQ==
X-CSE-MsgGUID: V1R+uT9PSZ2EpUk/w6I5IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="269148254"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlwV+ALyMoQgaYiMIU0Nf9qmFjflB7RB+38/tssj5yfFbzuKDB9UYmH2fvaIwVuO7gBmxM1MxG8ZA3HELHYB9dCp5zWDr5s9o3MxYXu06Von/OtU5Dugw4HQDoVjNeEcdCbnydNFgjztEsZRs77lG6BgUvBGl05tmtfnrwQycdMTbnQ3wte7AQtdV9A/QU9Tz9ZBin3ay2ERx9V5Z57Plp0utofr4RYaMBDQCZnLWmA7fcVAz8go6ipQI6fHew8X5R0a7rSsB6niYYuztP5o4ZFj5mJ0HAmorK6xd2RFDJwv+nAEutF221HaE/+ROmjimHpb8r7NcnZF9A4PZSNgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+T2v7S0NSr/ulAEB1aM3DJVll5fAwOFJWTghoVPmN8=;
 b=rPEWCw2CXPtHw0sazUBlhIDqZ8SDG1dFV/mhkJnpMvEADORcbG0oBrVperMsEnnrwvc/p4T2U9+doItQqraL8TFJ4YsXPU2ClRiXGyQf4s6MFMM/fZoE77XqytQcihLML/qAGuQXkKSyuAg0nRl1/gRc8INx/emlqZ6tv6DWuzFhw53OAqT/yLgMAEQifuSYS9Ol6x+abV/pfGKc3JgtU0F6xtBZASgWdPiQybPdLK5gKMQd2fftFkeP8x6ow1nXIq5v7hezbXFGnDsasl2f07yYYC3c/TvRKVvPE4pstSZEc4nyuWu95BriooQAvnovpW2iuCJ0ExYsXqJmNzV6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:56:59 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:56:59 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 1/6] drm/i915/gem: Count mapped pages in a folio
Date: Mon, 17 Aug 2026 09:56:43 +0000
Message-ID: <20260817095648.2438192-2-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3cab4a99-4b8c-4a28-d0d1-08defc45e15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aD1aeNxs2U95IJYAmIor016Of6Q6imYs/twW4zqdY9KMDNkdeAQMn0YGsX4jspd6/9zqswC2M6ywX0hccsrhC9OGFEvb4EeoptxEtKdWdP2sb9m5+uHqOl/EO3SOz/clYY/Nkuux0YxS6G88wnjkR4sq8Isvtp6cfV+GP1il4+kfWmfhy6GBAIZ9KlW/Dn4e8WDwL/LHxm8u2c9GrJU5iJ4qhHQl67HKVVe+z9KT/MSBMDqG8jyVu+IbInaab8/cK+/QECUh6G7KJLyAW/pMAY9Uib+GpxN6VpP0c6CA6e3mhatZZzZb8XyhH2HpElxpcu0fUzbv6zdZFq2sffN7OoV7evtTaPVwDTMict0XZU/gr2MMfwlxtMZ1ePdEDt5CV1BecBqIZ4Ejp8m67WHP/STn0TPk0VALJCSeu3ZyqjVS8ctS2ARZUURqoXRXk1Vf5pCI6DmICs45ZXbkf/rWgoRJjeJra4H/Q5wu1yqxWYLVt4mag47Ydfs+scqsMpXGwHkP6bF4pzvsDU4j1O2RPN8SILvI4UFKRVMDEf+TsugxCRshp6fWvevBS1IzE8DNyHSVe7FZAs2CAi2V8cXua0Ds7tY5+HwGhzIQDqJIc+kB4BKIFYYNGWc5ZRkgR2O3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2UbfMaqmgmjAIZ4+WNsd5ls+ih5zzcr9xiMuiUYIMrINQIprqS5b0Co4rtbR?=
 =?us-ascii?Q?4W7kmCXOnuDnMQmmOy+XVbSfhQgudV8COUWKlzDGE5YGFke+fZTNIVFaK8jQ?=
 =?us-ascii?Q?ZehDLrTx7jAtVjWskDoUoJrFxT5guA5T57F79gcKuormf1gE9Onx3mjqAnT2?=
 =?us-ascii?Q?5KJZPm7HFNqgG5U3Us9A04H4EqvxsiRLbCm9PnN4/oSEYq8ek4Y1+xxDpPd6?=
 =?us-ascii?Q?bBov/gfaKTZpwKyLy6bkIfa7ZWFcEH4USXXSp/ze+CidvnRPUmPgHdHJPPH1?=
 =?us-ascii?Q?03UywPi4vktSB6yy08MO/1YDTBuzhzHXM81U009ToVnz+hF2zgu4MPdhzheb?=
 =?us-ascii?Q?DFf/ttCtR3a91cqERPDz06V/tOlae/XN3ixzhr27io1ZwGYWdQLA/qwOrF8j?=
 =?us-ascii?Q?5xT/wgh2dJ8jHwRlfODsKizg8Td3GN6iMr6fnNnE0PnPX1qAptkYaLJMzt/O?=
 =?us-ascii?Q?HndVusCZjVHctHKQ4y7JvqWQpy+jMBc29JlHUegKTif5i/F/qGIanZ5mxfwX?=
 =?us-ascii?Q?fFdem5bA4uU15c5Pse7GtX2vTiL781amtRLXxKEWHl7s8MXznEJiaA4b1NMw?=
 =?us-ascii?Q?Ao5gf3k3+ZeElb5Dmad4iWI/5ITWyZZsQ2f7fOpA565n89Iu9Yc1hnH9O0/W?=
 =?us-ascii?Q?qUNRe3KBHbFdr43zj/zGgDcpBXV00N12sApBHRAREgThjKul03r0YsO2AEtb?=
 =?us-ascii?Q?KiiR65VCHiCW12JgrcGJIgsSe5goud7GfAQ49NGOlaZbhQSGwazwckc3ivlT?=
 =?us-ascii?Q?We+ePX43LCMAN1Udus/vIywf5b85d8LpbLLXiXQzyEu2u7UW9g0VlS5t2eRU?=
 =?us-ascii?Q?9n2iyXTsqazbw9GvUrEqgMcD+7OGjcZ2Y29TbWlQpptnQpBQuusAuQOAnbal?=
 =?us-ascii?Q?rPWjBoW5zFz868SE74Wk5lCEAtwBLbLxZJYWIPLjfZt2KP7h+bwD5cJIDTz9?=
 =?us-ascii?Q?xmk3IyfxOKzfrPOS+jbIxU1ZwMBgMDCmJ8N0gLOZqejKQE4L5/zJGlDDTJY0?=
 =?us-ascii?Q?im7ocwnpuF40sx1CjE+STwSqxH92yzP3yoaPElP+D1j6/jGSFIZ1g2Xghp5Q?=
 =?us-ascii?Q?wIZ9PsuvFM4ontzqPzeiVgxt12/ySRpII6tu+8T15D4eDvaENpsKI6cq3Xpr?=
 =?us-ascii?Q?k2WMs0XUqE738BpyPhkcfto+4XWDehDUqswTebNuI8toemxfC/ZqDA+SKunG?=
 =?us-ascii?Q?yBJkM9N5W2YG/+UQfRWp8wVYnEi+N/Diz3uB/EDD8E8VoVt26vPrHue3xThx?=
 =?us-ascii?Q?8Ob6vh+e5/HO2fPCrMpUHgRxjPxiKjiIglHdCmLnGBOdP9uiQ+WoY/ybNekg?=
 =?us-ascii?Q?sg3v2LsbbIOpo0Yn1H4ZHS6YMegSnIyzdAHNEsFgnvqqcNXuQkdw00i83ufa?=
 =?us-ascii?Q?rJLkrGRt8rKsUBt3XAfFVgxcCTkNPz+BcQpIULLOyLzEVcYkYM2rfrVi/A48?=
 =?us-ascii?Q?HPOqEwYlt0Vo+GtDrkPrwpI3G2tycCbJf8NkAV4V795SBF4g72EztaSVfhc8?=
 =?us-ascii?Q?C3J8NFKfhJxdb0LF9JYBcDypDtvEA2bgO12+3sYtSNzacdtonMFJglS3T20p?=
 =?us-ascii?Q?s6ec7TPEXc7rmXS1DuCY42FtYGCM29NwAEDkO2f+qzcnDl6+lUUKCz1QiBNQ?=
 =?us-ascii?Q?A0FAWvPPjPLLiTEsK1B2mCmLGhD1spCgtz2Ng1SY4YygWlJ4W9f6dDvCE8j/?=
 =?us-ascii?Q?z8rUNHwXOj04/YZCD/725ae1ERiKowh0Gp7tYJeEOSbzRmli9ud/ajKRktLN?=
 =?us-ascii?Q?l3EmOJoVMej9o6X+t08UmlPyhZavCgA=3D?=
X-Exchange-RoutingPolicyChecked: swUTLq/o/abzwidWs7kLuAD07mj3ZEP/OZjGPBUtkrIF/+gMXmjUDsfHoUunQwQHtFhQ5ltr2nzYWpokeZSX5g04i524QxEoASkBnRUwh9tF8EJ8uG5f4fcNXoyARuAMZ7Rt2DCLehTg+ETBR4yXwYqUolxzJx8uvyjZlh2cPYxUFcP0jBtJNgY6hjZe/H4QjfRx6icm+ZG7ilbc9+ZnDtur6IBXZhee/ScGA+JHr5M91exhBKUYCAk3iNt1QVBMPXG7jXPsQe7XLFkcu/NaFXdWtN13xnKCPFzWjpPBIqJ1+iQCwC0kNtrqgJoyGzNQBUhv44NwC2VMRfYPciAkKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cab4a99-4b8c-4a28-d0d1-08defc45e15a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:56:59.8199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmbDRL112tiZ4jbWgpFYVGirn/zurJ7wkuFysFbtQnZVelNrv52fiqJA8ridOABAkb16K6Lnb0TvQmdIFaBlwWVE6X8gxeWKe9tqbYfVsCg=
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

Before addition of commit 029ae067431a
("drm/i915: Fix potential overflow of shmem scatterlist length")
and after folios were introduced complete folios were always
allocated, possibly overloading the scatterlist capacity which
was never truly limited to PAGE_SIZE when requested via
max_segment. The above commit addressed scatterlist overloading,
but unintentionally disabled PAGE_SIZE as a valid max_segment
value and failed to take care of remaining pages from folios
above max_segment boundary.

This created a state, where multitude of scatterlists were used
for the same folio, but never counting enough of its pages to
jump to the next folio.

Track how many pages have already been counted in a folio and
use that number as an offset on consecutive allocations from the
same folio to ensure it is fully covered before reading next
folio.

Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterlist length")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v5:
 * Moved max_segment value validation before allocating shmem table
 (Sebastian).
 * Aligned comments (Sebastian).

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 121 ++++++++++++++--------
 1 file changed, 76 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 06543ae60706..f338dc39fad1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 unsigned int max_segment)
 {
 	unsigned int page_count; /* restricted by sg_alloc_table */
-	unsigned long i;
+	unsigned long next_pfn = 0; /* suppress gcc warning */
+	unsigned long folio_start = 0;
+	unsigned long folio_end = 0;
+	struct folio *folio = NULL;
 	struct scatterlist *sg;
-	unsigned long next_pfn = 0;	/* suppress gcc warning */
 	gfp_t noreclaim;
+	unsigned long i;
 	int ret;
 
 	if (overflows_type(size / PAGE_SIZE, page_count))
@@ -85,6 +88,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	if (size > resource_size(&mr->region))
 		return -ENOMEM;
 
+	if (max_segment < PAGE_SIZE)
+		return -EINVAL;
+
 	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
 
@@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	sg = st->sgl;
 	st->nents = 0;
 	for (i = 0; i < page_count; i++) {
-		struct folio *folio;
+		unsigned long folio_page_index = 0;
 		unsigned long nr_pages;
 		const unsigned int shrink[] = {
 			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
@@ -109,71 +115,95 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
-		do {
-			cond_resched();
-			folio = shmem_read_folio_gfp(mapping, i, gfp);
-			if (!IS_ERR(folio))
-				break;
+		/* Grab the next folio if we exhausted the current one. */
+		if (!i || i > folio_end) {
+			do {
+				cond_resched();
+				folio = shmem_read_folio_gfp(mapping, i, gfp);
+				if (!IS_ERR(folio))
+					break;
 
-			if (!*s) {
-				ret = PTR_ERR(folio);
-				goto err_sg;
-			}
+				if (!*s) {
+					ret = PTR_ERR(folio);
+					goto err_sg;
+				}
 
-			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-			/*
-			 * We've tried hard to allocate the memory by reaping
-			 * our own buffer, now let the real VM do its job and
-			 * go down in flames if truly OOM.
-			 *
-			 * However, since graphics tend to be disposable,
-			 * defer the oom here by reporting the ENOMEM back
-			 * to userspace.
-			 */
-			if (!*s) {
-				/* reclaim and warn, but no oom */
-				gfp = mapping_gfp_mask(mapping);
+				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
 
 				/*
-				 * Our bo are always dirty and so we require
-				 * kswapd to reclaim our pages (direct reclaim
-				 * does not effectively begin pageout of our
-				 * buffers on its own). However, direct reclaim
-				 * only waits for kswapd when under allocation
-				 * congestion. So as a result __GFP_RECLAIM is
-				 * unreliable and fails to actually reclaim our
-				 * dirty pages -- unless you try over and over
-				 * again with !__GFP_NORETRY. However, we still
-				 * want to fail this allocation rather than
-				 * trigger the out-of-memory killer and for
-				 * this we want __GFP_RETRY_MAYFAIL.
+				 * We've tried hard to allocate the memory by reaping
+				 * our own buffer, now let the real VM do its job and
+				 * go down in flames if truly OOM.
+				 *
+				 * However, since graphics tend to be disposable,
+				 * defer the oom here by reporting the ENOMEM back
+				 * to userspace.
 				 */
-				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-			}
-		} while (1);
+				if (!*s) {
+					/* reclaim and warn, but no oom */
+					gfp = mapping_gfp_mask(mapping);
+
+					/*
+					 * Our bo are always dirty and so we require
+					 * kswapd to reclaim our pages (direct reclaim
+					 * does not effectively begin pageout of our
+					 * buffers on its own). However, direct reclaim
+					 * only waits for kswapd when under allocation
+					 * congestion. So as a result __GFP_RECLAIM is
+					 * unreliable and fails to actually reclaim our
+					 * dirty pages -- unless you try over and over
+					 * again with !__GFP_NORETRY. However, we still
+					 * want to fail this allocation rather than
+					 * trigger the out-of-memory killer and for
+					 * this we want __GFP_RETRY_MAYFAIL.
+					 */
+					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+				}
+			} while (1);
+
+			folio_start = folio_pgoff(folio);
+			folio_end = folio_start + folio_nr_pages(folio) - 1;
+		}
+
+		folio_page_index = i - folio_start;
+		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
+			ret = -EINVAL;
+			folio_put(folio);
+			goto err_sg;
+		}
 
 		nr_pages = min_array(((unsigned long[]) {
-					folio_nr_pages(folio),
+					folio_nr_pages(folio) - folio_page_index,
 					page_count - i,
 					max_segment / PAGE_SIZE,
 				      }), 3);
 
 		if (!i ||
 		    sg->length >= max_segment ||
-		    folio_pfn(folio) != next_pfn) {
+		    folio_pfn(folio) + folio_page_index != next_pfn) {
 			if (i)
 				sg = sg_next(sg);
 
 			st->nents++;
-			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
+			sg_set_page(sg, folio_page(folio, folio_page_index),
+				    nr_pages * PAGE_SIZE, 0);
 		} else {
+			/*
+			 * If our prediction about folio placement is true and
+			 * scatterlist still has space left for more pages,
+			 * then we land here.
+			 */
 			nr_pages = min_t(unsigned long, nr_pages,
 					 (max_segment - sg->length) / PAGE_SIZE);
 
 			sg->length += nr_pages * PAGE_SIZE;
 		}
-		next_pfn = folio_pfn(folio) + nr_pages;
+
+		/*
+		 * We assume folios are placed one after the other in memory
+		 * and predict where the next folio begins.
+		 */
+		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
 		i += nr_pages - 1;
 
 		/* Check that the i965g/gm workaround works. */
@@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	i915_sg_trim(st);
 
 	return 0;
+
 err_sg:
 	sg_mark_end(sg);
 	if (sg != st->sgl) {
-- 
2.34.1

