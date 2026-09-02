Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D413C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672EE10F08D;
	Wed,  2 Sep 2026 08:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HFuAkkCt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D6610F088;
 Wed,  2 Sep 2026 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337571; x=1819873571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=QlDqKQIYsn/dPqu4n+MEsZzmm44sQNQINQxmdRvSDNQ=;
 b=HFuAkkCtod4dcg3epT+LpHw7uXwi1kJ3kp7C9LC8yfiCpjCl8TlqIaCs
 W0KkdKW2FQn6bb28WPcTeD175IovScOAd+dqN0UhJYTC5/AvWTtjquKoY
 Z+8GvPG/sXnouSiiaQYWl0ta1XwPEhh40gNc+g7m+0ZQSJ2aevMRxRMSP
 ZbL2DmrCPhy43jOCxC172Qv/vK+uf9AUH4yK0fshDzVph34jrkqu3hWNm
 1aUiBBOVp6Di7SLdITHDIfCcPA8vDpTYaRtq17ngyGNbX/kKzhUGEWWyQ
 kNV6iynhXkbxs7+67Hbmp9PgIB2clkxUoeuAthRWMY7jHNsruhnsrPC8Y g==;
X-CSE-ConnectionGUID: YhW6FR0hRcG4wtrIdKMFdA==
X-CSE-MsgGUID: PpaoK8eLTVum8qgW/k4DbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88994795"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88994795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:10 -0700
X-CSE-ConnectionGUID: ovn7CYCaRbWvBpqtp3sOKQ==
X-CSE-MsgGUID: y9Ys4C01Tr6emtSxJT/PzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="294180966"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:26:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:26:09 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX7ud5eehEGepmFFOQoAfvBTJPp0lsjgQozJtvE4emWqRQLVd/IaDt6TZ+UMgDDvYlxHsmMW0D5s1dxk4mZPfxGVhkwXizC4+bQeol5V/Oj1P0JFWmUjjGENaDeH4d+LI0urxhhoZDcWYvlHEbb0ES/ks8MmclDgrLnpSiSymkHKBE88RgUwhEF8mTfh4mUxIn2YgL9sXwMBTFVQryg98tkYX4SE2v/ZnpftPuPVcNORXXlM+ofC7HtJ+aB6+JapddJzTNTRP5tDQkalj5ISynLa4/QniPvUE/mSwixbQDX4y6Y1NzRIec2iAGb5HzUppS3B+kb11Ik2/S3fyHI3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM8om84UObjV+LR20fDUIRhJdqGEH24IP+fmStTym0k=;
 b=NvRIcSHZ25Egy3GoBmjSsgN+u3znTNpqMKHeSkLb5lTVp4wzGBkN4HT5nTon4YbLduh169PqxPiiZKyomxKiTqXVAMK0gt+qpc/fsETbxkJXVVw6JyyNElHVB0/anERDqJ2B1bitKPqNc+7aH8QkBqcA7KPj7hUp3Df5CCKEeO9xe5y0+/imcTLhgPNC73T1qnGsGH6QNRKQIOSqw7qfdWbINEAAagPvehGVOOX+GO51G+petNA98dJBvHok66neFvHX1zvBNZurCQcY10JxIByezAjpBPj0ISMMGu0Yq1tTmbinns2sl9HBaVM87Dw+6eIqhJ8ReC3hFWVWF/nffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DS6PR11MB005518.namprd11.prod.outlook.com (2603:10b6:8:52c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:26:04 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:26:04 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 7/7] drm/i915/gem: Remove iterator and use while loop
Date: Wed, 2 Sep 2026 08:25:25 +0000
Message-ID: <20260902082525.1149367-8-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902082525.1149367-1-krzysztof.karas@intel.com>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0200.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::25) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DS6PR11MB005518:EE_
X-MS-Office365-Filtering-Correlation-Id: 405aac7e-3681-4f20-7be9-08df08cbd46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xFD54c5v+DfBgvR9ZCi5C7SQIK/2UjXOTSoglMwJrGJYo8uJTIjsBv6+7j3bZHaYaBP7AY5KU5sZ+gf59TSeYuH5lctPuNF6FbfUVGxvqA4eHJcn+t+kayA1ZP2EzbA0jgtp9PMWZPaNXBTpX+HEF+Cs/iPh5mIxQdcgv2l68dXJfeOQrMcPsdIDDb2fQdHrSCxvgM1+pZPzjF6q1ZjZCriQkn7QiCfJOsrcZMeSVOzBSe0jlKqbTuD9gezS3jggdZ95Xd9OsfO8cJE1JkjH/NeKLBN65mgECKopKvWn+Auvw8ywJL1z3eoQSM7UGOpKov4CO/bfA0oXWm0oyabX5qVSxHquT6C2+iC4OaEEVHyQTqQf+YEwHK0kyH0tj5ABYcNLuAltF3tjLmNibfsUBa6N17CzKFSOFdYnduuC0cTK3vPcbKILUJU+aL4gvEZLu0utKnmexGbmiHzeREQRNq++GISxDhlBMrUYkFr/u4F2ciezQm4q9J5tgEHVdUfk9xEqCOnk83jVYZmOGrzq76qGlKYMymzEfsihc2JcVY+vToBfMLFkpaVCDbmYktYHHFgnrOQP3rqi6/tf+fS2MnIdiWr74OVmajW7UM3GdmMioqHQeDzCPzisnG+iVz61lCNpWtO5RrjFzCOg4A6Hok9sjzToRuSPojgtf4Bnruc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TM3ttX316rjIwDS7ZWBR/Z3bkGIrkYRi55bw7U4pbG0B+Jl+sU8AQKfF45Gu?=
 =?us-ascii?Q?WvjCnedVEyfSUDfjZeLZvUAMngVE8qJIheg2iz+o/V/Y2qrFT69WelQuvcVO?=
 =?us-ascii?Q?FkDqo1/LE/MJWdu5vpk8TRIMrRYz+D1HLoqBmMIlm7DpYmMQiONMu1kWT/wM?=
 =?us-ascii?Q?UhoFblIQfXL+VqwBcslt0xWbPszKLJJM5GF+87al0b/RHz+XgvlGcrk+KnuM?=
 =?us-ascii?Q?jYF/fvnsG3q11KSu3CmFdvOX6lc0kq+cswcW4iNR7zEVC0gC/DsjfO+I91qt?=
 =?us-ascii?Q?MDytmEeT5cQ+gHXFxknna1GHvEUsxN0I9AcGtiBYfZm6sitsVrTbayEmwhPe?=
 =?us-ascii?Q?3HEIY3ghbToH8K+T2j9aCyBpInK9mzxg6gz7rdaISJZ4am2kLrzmeOnctAuk?=
 =?us-ascii?Q?XTWuqxa4ftC1oUjTbqZk5FaKuznXnMLwY4gj9L1sam4sfHQMUgC52YbKTz5B?=
 =?us-ascii?Q?UKJOH5jblKLhujOWBXdoPUsKcfS9bOZf3YPo5ZAXIn5DT5396G9LOJKsvyFR?=
 =?us-ascii?Q?gAWjx/ZvCZInR79897D0bR+iwhZ2sEI5umc/6qt9A57sEA9oqAvEfH3dVZOs?=
 =?us-ascii?Q?Phpyfe0QILy33YvNH0K7xRQev7XlqqSOphEduH7yBOl/hKFwlIpJf5kb9fK/?=
 =?us-ascii?Q?N1FdHRtcMvZN9dvfbZaABtMfHRzrG17d0Hz6xSupK9N6hjMNA6hw4LfE+iRN?=
 =?us-ascii?Q?5bEsWM0CwsVzayHq4mWYOY0PrFFV61mEL5sJ6MACLtANhsefBvAMbwokxyvq?=
 =?us-ascii?Q?mQ1aybcPLYqB7NGxpwuW3FGvNUZQBK5iAAOFvpJ0ODa1FGIHhlXvLM0KP1zg?=
 =?us-ascii?Q?QJsIJsuS6cHuZBj9VpwHFiT4+bZWZN+NwU/3zliEuwQfjGJ454okFttMtZGh?=
 =?us-ascii?Q?a3BFJcrPcJQTNk8a11pElsEHHFFb1jyFYy0TI92ktTCi/T4RRv1B5MhfHp0P?=
 =?us-ascii?Q?afPts4Lo/W2vBY1K+na6zFGrDQ/oUJUSXkRFgRDg1v6uBt23N4sFioKyiVMM?=
 =?us-ascii?Q?EpfPKk362mQD6FSjXDw9U9Rxq+QcnIBIzfy4oAB2c16Q3Zizz74cHoLaX+cn?=
 =?us-ascii?Q?cwv31UWzcfUtxpuyIj5Q5WbFVAT3zNOMabZkn3YU+ZgelQB5cbRKp5v6vaF/?=
 =?us-ascii?Q?a/oUdMKh2q99n+V1pd8f668fhEqUITvAiX7RLpJ5Pw35zObjmtDgRsTLm8kK?=
 =?us-ascii?Q?zrHbZmc++9m9j6/iVmmEg94R5QGVqfQV3e2jHTiazzQBQPg/GSQzXh/piYI4?=
 =?us-ascii?Q?XD8G5Adndoap/meDEmrP+E1g1ZI/gI2WbhOx9Jxf7SBh9wPHkvOxyMq4+4ye?=
 =?us-ascii?Q?aDUWEffVAYyTs9faICB5D9yMj95J+I71XovFHfuwFXwzsrXJDO3DIRPrMfNf?=
 =?us-ascii?Q?TSrt5gs7u5lng9hjrOKJuhAbhplnu6SEEbmqtgwJNtS2qjTcMAvL4GtW045d?=
 =?us-ascii?Q?b7/VOVsuX4luEXtSO5sznVyuRQ/p2UP/JRKfbUFRB2pPagB0UXArSc8SMxVP?=
 =?us-ascii?Q?1PuqdKgrvDZp4ghs+oBdSF7SDEbrbs4/1pgcnj6IEK0eCsJ71ltPh53oRf9I?=
 =?us-ascii?Q?nqBex/lps5oD9tS3Dky+M2w5jI1PGNkF/wh1cMVnC5g6bDFQ8fzPeB7VSCH7?=
 =?us-ascii?Q?HYZ3YcAn6KU9k+iB1wALkVkOkeAlEn6xnxrYWGrTnPEN6SfXXtokzmqVp8Wf?=
 =?us-ascii?Q?guRVhyKHagezBFpNCz6jBmcHr+UoPhOIAFuMATHykBPqGyq9w19pESvBGFNA?=
 =?us-ascii?Q?GGXOourhgLa/QdCrXbGzC2A3yAFN3Vg=3D?=
X-Exchange-RoutingPolicyChecked: zwZvZ9LnCJeeQzlUsZ7+SO76Vw15MvfQDN79TAxq678cclMDQSapchXH/BkIK9+knx+iTcAd3SPwKbwsXsUTJnwU9Z0ia1YWHJpzXbUzjLYLrDMVUbb4IG6YHKli3DOOu/+lCxdpuooaXPspgg5jaDRR5ChctxIrYwlskBPE58lxyXCjWVAwA9Sj+zgR8faYRjQTbcQOejr+IFlkg/esnMMBOmjMbGubXN4FZ8EJ0q837/e/m10Y6LSnlCMZCTzjTOZaA/xBsIsCnOdjh7M4Ly627G9m6O5/MwGzDsleI1C2U1X+S0Ay7tgam7ol0qMDgUbScoMjxRIluGyWy6bI/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 405aac7e-3681-4f20-7be9-08df08cbd46c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:26:04.6629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwCXoCqlaI6XotZTO/tKz4+mLfXRjbNSzVYisr8w86WiZpcBvkYVlJcQBIwauiesglKQQag92fIVjofklS9QNzdco3SlQSgzvrxaBHiE5m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB005518
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
iterator "i" and use a more descriptive name to indicate how
many pages were already covered. Detect first loop with
st->nents.

Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * restored shrinking to 2 * page_count, as v5 silently narrowed
   it to page_count - pages_done;
 * ran final checks with Claude Opus and added a tag.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 0fa34a4ae466..88ad23928d9a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -135,7 +135,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 unsigned int max_segment)
 {
 	unsigned int page_count; /* restricted by sg_alloc_table */
-	unsigned long i;
+	unsigned long pages_done = 0;
 	struct scatterlist *sg;
 	/* suppress gcc warnings */
 	unsigned long next_pfn = 0;
@@ -167,15 +167,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 	sg = st->sgl;
 	st->nents = 0;
-	for (i = 0; i < page_count; i++) {
+	while (pages_done < page_count) {
 		unsigned long folio_page_index;
 		unsigned long nr_pages;
 		gfp_t gfp = noreclaim;
 
 		/* Grab the next folio if we exhausted the current one. */
-		if (!i || i > folio_end) {
-			folio = shmem_shrink_get_folio(mapping, i, &gfp,
-						       page_count, i915);
+		if (!pages_done || pages_done > folio_end) {
+			folio = shmem_shrink_get_folio(mapping, pages_done,
+						       &gfp, page_count, i915);
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
 				goto err_sg;
@@ -185,14 +185,14 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			folio_end = folio_start + folio_nr_pages(folio) - 1;
 		}
 
-		folio_page_index = i - folio_start;
+		folio_page_index = pages_done - folio_start;
 		nr_pages = min3(folio_nr_pages(folio) - folio_page_index,
-				page_count - i, max_segment / PAGE_SIZE);
+				page_count - pages_done, max_segment / PAGE_SIZE);
 
-		if (!i ||
+		if (!st->nents ||
 		    sg->length >= max_segment ||
 		    folio_pfn(folio) != next_pfn) {
-			if (i)
+			if (st->nents)
 				sg = sg_next(sg);
 
 			st->nents++;
@@ -214,7 +214,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		 * and predict where the next folio begins.
 		 */
 		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
-		i += nr_pages - 1;
+		pages_done += nr_pages;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.34.1

