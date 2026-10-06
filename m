Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3638BCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F91910F27F;
	Tue,  6 Oct 2026 09:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hkXPDacw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1D110F26D;
 Tue,  6 Oct 2026 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280768; x=1822816768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=JwGZqXyQfl/3Ko2qr3AQnND2IBINoe8bl78H7w3yfnw=;
 b=hkXPDacwtroBkPch8G1S7gV5KefBsN9NSVSBaGAjHpOTmj6s2vpsw4pO
 PGGwCPf24FyooEXwQBAbrH1hX6qt69QviltnJ/J/t9SZx8FUMJVyqYo7N
 4qZFV8s4W4imifKVZDY8lIVw6tZlLivMuEySSQ7juJVk/PXx8nONTYEAE
 +ciMoHTdWz2HWOeqS9gyAViCe8lLs9Bb//JK4jlhNh3hPawG9D4Y57hXp
 7NY80r8Iys0suJvhYzLlx8qgh9BWd6j1LSvPOQ7/csjfJ62U4QpW3Ihme
 3zswbCOGZFixswD6QIz8VKMKEQ+YGzIf5PHji3xNt76lv8gIuVGq6Vp5F g==;
X-CSE-ConnectionGUID: iKpasRwOT0GHRin87X8TkA==
X-CSE-MsgGUID: Va7ctpMARlqayqgFrBZSQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="95783131"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="95783131"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:28 -0700
X-CSE-ConnectionGUID: 8gcczE5pSbaQZcctrgWYSQ==
X-CSE-MsgGUID: S+7cazzTTsKhzKiT8f9GtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="305039048"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNpeSNWJShhKJq+jj1h7fKyu8T6b7XuX6s1UrP9oWx7NNd9xw899Aznm3YrAbgGweGNgwpA8orCi18trspuGunOcECxUmENfzkZ3tPX3ALZQ8elFty9xigfZJZVWQ18mq5xhqwLXSwEOhaqzrrJrRvc7ZQo387gmNGIQFDFHf4aXbpC/1GkrsTOTTdqSUWctFVuHsdoDAo6hcOjtYJDRtMG/cXCHk5oXiwyriIizTs7wD/FylPUoJtMFUPiNUBpj2B00v++MJADpyHeReclfUBvGedwvQF7bNYZsxKdlH5qXt7Wutcr3Kg2wg/xFERvYWJfRcuVjawVSpMeyFJsf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ILjjpJkRTItE9Wm62jG2PpRvqP5wteGB3gGmcFMUTY=;
 b=qHhhUI2qWifliCQg3LEugBTpCyDmMfCY0ermO6QXdj7Bl6cJubzaKubGAsZeHeSfdsu80HZPf8p6Ag7oXn7kBPWqJ1LLStcss/zFz0so+m55Ry631+orQZKXbSImCBE3rM0c2Jq6ueopEvTnmsq9LPE0ee0iOqEXObcZhLdBpRbPG9chNM/ltzV9gLCb3GCXSR3szynZ8otgungfFJ/LgOGIxn3fS9pBw1i9uBwUHQny8TdvFVKrS0Rdj7SHX9hIYTsuYr1Dngx+C63LmCMZP7MqzPFrIMBTWOqyf5BwPSIJVzghZ52RWyGgJFyL1exQvJ5oSIsqbBcOddG6XyrgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:59:13 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:59:13 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v7 6/6] drm/i915/gem: Remove iterator and use while loop
Date: Tue, 6 Oct 2026 09:58:45 +0000
Message-ID: <20261006095845.451212-7-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006095845.451212-1-krzysztof.karas@intel.com>
References: <20261006095845.451212-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::30) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcdd02b-86df-4cf7-3ca1-08df23907864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZWK1ksMe8+2WJ04Wckr+IxWAKNEdkvOvRiKxxM66Dc0QV5M4NiWGQ5l3CsmWgoyDK19ra9YihjScdjJ40+EuOFV7o1ZbvFgP5Bheo5c9kLxm5Squjkm2tQswxw0dhFeHGxdUA9MeQLG3bdNIt2K8txZldPvEspbxsVDeIEx1wppE4dK198jBd5h1QNjb39667Be80Q4v9+cYvpFDHmtm1reMDVD/2pCJYRTtu2XwzKre3eaC87stpMA1b7zADv2BHcStDEimSRWxHuuVjZ8GBZeJm/71OqYgzKMKBYKRbIQYbXCucFzIRmUHYd5z+QBlWJjXwLcBOkKlzHyVoTgnStghr57Su/mrQ+j2RbmizuWj//TDVfMmBGYDe/IIVjsu+3kK6LXQ9dfM+uiZiF9S6HwMs1oqVowKf+TyrCjckthv3v955BxqqiImJNO3FgfvfYZKmhBjHhRrjCt9uMa+Ngp6TAC9061yW3BNdajJwPb5GErTZsmEKOvLXIgyK0LbsY8BsF8w42pdIwMvU0oPAxBD1TqDZSZTf273o5NAKtlpmEdKO1BgBdLCRjzcfWWVJeoLPLuQqbQjVmzxtZmEyx8SnzDxWL6/e/DhMU3dC0lCeA9PmE/eAUDHFsRODdI/wjrmMO5Vw56jSS2Yhx/EH3dO+Fvv+/GnkbbRVzTEmjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkjqiN7F+wYW8ELSLnLoX/ZV1YtfQUoAQEvI1hhSFUSOeqAQ+oGsE003uXUe?=
 =?us-ascii?Q?NQd3w8SlwjIkGDOtLnrMIiqIx/Lo76JwKjnwVvpNuXqyLUXs6ukbLwABRHQC?=
 =?us-ascii?Q?apP6Dr/XciEzwq/alB0r7rV71wTR7yG399NzLdVrzmesA8UtignVwTkJWsAy?=
 =?us-ascii?Q?0KP2ib16YHfD+gR0PTkxaTx3fHnUGoeKLu6WAU45LWaSFTQvf0VrRWcgvayZ?=
 =?us-ascii?Q?/7s+XWea88brO23meyaXpIGR8+qJu/nKpWBbEF8pH7ADPxVKV+PKvui1L7bP?=
 =?us-ascii?Q?SYdJ0derIZ9b0ZoXVILgEGe40jSSeaR6RDqc/tword3M6Qy95BzhAVVprHux?=
 =?us-ascii?Q?MboNog6MhOJPA/oe0c9Y0WYof4dTsBu/3DgiBiEj7g/stz7XhSRqRvzajT6A?=
 =?us-ascii?Q?OqdOKzOFuKgaOcOOvWq3FeVL7tOWFSe6/iwr8WBBIT7eFUCtX+G2zx9C/bPO?=
 =?us-ascii?Q?aAjEoEZzcVCCMLKHAFkSaU9GHZkW+w4IdsFFmzeYzd5elXpLW81YFNdqA2Ha?=
 =?us-ascii?Q?Z+eTd5n7wBfNX5dXidlOyf/ul+lS+KS6JRYMFOuzGZP3in8LNDBnce0XNETd?=
 =?us-ascii?Q?FEVBqUdVqny6bGq9FFPXS1ZlHPKDIkUoFd6JCnTpY3x3kSQmRV3scePv/neA?=
 =?us-ascii?Q?FKL1ot04EKjeyxxkAOrdCdFPeTtU4ac2eIsg4/DZHDnSF2ib6RP4yV9NzwhD?=
 =?us-ascii?Q?+RyOT0J0vIkvtzhMShHdcKWx058EgXW1qxqLHFxBcWTXnehPd0bpHHFG3FhX?=
 =?us-ascii?Q?ya0ZvEV0MQ3E3UhN2HwlEeXIjZm8tDrqrn8F7D+qV/PvXn2c8LMbartq+58d?=
 =?us-ascii?Q?Jy/PFEVw1N4WnFw/kt8LWpPv5FehM0p/ga7ZRzQJO+VqoJ6C29ecJVCRry04?=
 =?us-ascii?Q?C0UYh/fZ7iBoasFeRJV3xPsIJSglyfDmG5T9y3XJhQqz7goa0VmIzXwl7OfX?=
 =?us-ascii?Q?iG+MUzYcmwRXUBRRshJZbLWTbSdeISgOX1XYBl9fBH/vLmkYohi1XDw0T/Hz?=
 =?us-ascii?Q?Kix9H+zQP+II62L4sZdV3mLuRkEf2KkH55VNxBNmhbSa7xJ+zSWdbENi5/Za?=
 =?us-ascii?Q?Jy8WwqjXJoDWh3hNBi0hbWX76ymN/nlBn8KP3eQ4EK8+svPGx0XTorjCY1Bo?=
 =?us-ascii?Q?HVcMoEjmIx4GjacEgn8zuc0+IoEM8uSq9eacdI/KpKhsAik2S70H00BoOojx?=
 =?us-ascii?Q?hHYA0xMpQsOcotvFhT5Y6nd+cGmObXuUTOalN+GWpEuxvG1REMU9i5JELkVg?=
 =?us-ascii?Q?0DxEVfc7bw4g8mwEnZMR1ahfA9PG/9iSlsTWJ16JZMHDYhS4K0lCGs+g7gSf?=
 =?us-ascii?Q?3OWx+jwTI1bEq5aJUF9G07fBivObxDQ0MCvyOc6I0l85h0QxCzOvlWNHUYdK?=
 =?us-ascii?Q?uSzqZ6N3i18IBuNrj8WJGT4OhFo56dNLUiPqgNukpgHh3m0YxHPAYJLENnLx?=
 =?us-ascii?Q?By5oyNnbC4cR90Uw4IHG/URGPK6tKF98et8o8aMFcBLyR+4AZOAZc784d07Z?=
 =?us-ascii?Q?wZZ8XA21QTOa/M8dl3qXnJLNVOnKJL0/6F28+xLk4uevBqQpGgTFjXq5aQ17?=
 =?us-ascii?Q?Gxsb1IE3ag9fSAI9gx/9HTGDp2dol2ahaWK1+LnrV2h9+pLNuLrmnbkJwjL4?=
 =?us-ascii?Q?/t0HIKJTJQIaD9yiJVsfo8SpI+DpK+sT7QrCXgmuw2hfRt3/bg3lOanTM5Uy?=
 =?us-ascii?Q?k43Zy8esNoIq8Qoffe/29Rb4nEHjq3OSFNb921qrINpE9XNvJ9y2I/3lBwYF?=
 =?us-ascii?Q?4DUfDFdSU96VFaRlyRVqfC0wPIQvl24=3D?=
X-Exchange-RoutingPolicyChecked: U50H5Xs2E2+pT6cOLtstJmxp/ZxcTNK5lP/xCvTGsQX0TrY4YP/pfG2JDM++9pZ2HKT/2eGJfzArvDjtpQyJwg6xRIvKAB9dAnkNbfLJX2JD3h7OLl1iJWra1Ev4xETXfzSLCnrEPuF3lbE0uOGhFg3gZuqhGC+8GNR8ZbFaYZtMEe762hGWwLHtY415z5pzWQ6ttuztefqvmjJjR9giZbYfDOPcRb1SCyEyD607j3PsyDSLSVFLIkbiOj+yqFxO5VLSMIZ0Ops84BdQglbvMNUlGuSFkEEHlb/CDxwO3nW5qZqjv554KGIPG+3Yt886/Qwk0VvXoQfhStYwlhuO9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcdd02b-86df-4cf7-3ca1-08df23907864
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:59:11.3520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KugopmReYmm+GiHXBeqkY5fY7gmxtavaUF7VbPCe07EjJgSal+O30fk/71Itdayv4Lm3Dq0hMHA9HqeszfvpgTDgwf3Zv5fUGncE9deBWCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
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

Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
v7:
 * No functional changes.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index a08cca3e57a2..83cc5839f441 100644
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
@@ -165,15 +165,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 	sg = st->sgl;
 	st->nents = 0;
-	for (i = 0; i < page_count; i++) {
+	while (pages_done < page_count) {
 		unsigned long folio_page_index;
 		unsigned long nr_pages;
 		gfp_t gfp = noreclaim;
 
-		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
+		if (!pages_done || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
 			/* Grab the next folio if we exhausted the current one. */
-			folio = shmem_shrink_get_folio(mapping, i, &gfp,
-						       page_count, i915);
+			folio = shmem_shrink_get_folio(mapping, pages_done,
+						       &gfp, page_count, i915);
 			folio_page_index = 0;
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
@@ -188,12 +188,12 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		}
 
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
@@ -210,7 +210,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		 * can be merged into the same SG entry.
 		 */
 		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
-		i += nr_pages - 1;
+		pages_done += nr_pages;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.34.1

