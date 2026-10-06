Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1E3CA6002
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A64C10F272;
	Tue,  6 Oct 2026 09:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qh/tQX2S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2749B10F26B;
 Tue,  6 Oct 2026 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280767; x=1822816767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=2MdJexRulpmV010rlAUmRSesYJvwmr+/POXfPv3ED04=;
 b=Qh/tQX2SWKCDKshmVcVRtH2iRkFpFvBd0/l3jMVZF6YfailufRDJKZqe
 J1ebyo4KUE8ln5bBU/RY1S/y1h1x2UOG+Kh9mxbwOtrQ7dfe1AZrX3Y9x
 enWoK3PD+drTvGovoRuupzVr4r+0dgdNyIDGXRgcNZTzDAcQe3SbUypFn
 lbnzyMNgAPMrFBYI3QseV23XdMNR/wFUclDNwatqwKikcfCArklGHtF5P
 4+jfEA5L2j31Ylsu2nXmo5d6tpnwZEZJmmQCiez8KrP7awnkrogcXIH7/
 fB4MKZwDPYYOTY+Ezf7gHPYcavyEw5KMNr5kqOgoOIMZxiPRCrelbOFJY w==;
X-CSE-ConnectionGUID: r4zVz/W3SvWJLDg5TFc4cA==
X-CSE-MsgGUID: ArvZ7WQDRLSgoCyvESV3dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="16186"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="16186"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:27 -0700
X-CSE-ConnectionGUID: JccyBEAtQdmAOCtaRGE45Q==
X-CSE-MsgGUID: KRchiCpwR5OSx3HHVbSlqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276616000"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:26 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=remTQBK7rXqgJgwtYfeHw/4wTHVP7fn64ksOR2/O48UhXOqnC7jgOSVzc43OlfpKd2ovbbJirQ6A0updU6D0FXNKCkrtrQv1IKcExXRsrlWBp6zS8lW8cFZaOdTYRT7Jn/PoGJA4nME64ddEJl+KvKy6+DNyjZ24UMVnHx6bA6kc68mqfuFygCXhMty8m6KH5KNQzgIGE/tq2SdrM7O2VqwQgHpKXN3+3WCU1jrvMr7rqXem1zVUzFjxondUtwcGc1mNVML4DvGee1kcIyPPdiYXsk47xK0k2Q80JAF8+HU8b5dH4Wwf0LmbtMYdzUxHu2md2wIhXw2YY1vgAO3r4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw6QBSjIEZVxA5F/4Hzl0+nk44h2o16EsRxT5EFPanI=;
 b=heNGxKPV84xlzQAhZddyiiHxHP1a47O09z/r6WmCRzMhVtyz9W3QaF/yMPvO+VoZgwNK74/Hmm0WZkY0L7lYJ3S/sRWTZ/jTMmqf2hXYOGpfDoAqyObmGhZkE2Fp2HE8JKsLNqkAlxzUfet6ShphJRaMevMxft2s2DqPDz7CMhApYwD9EhRpupxFZQ3Bx7oEp8eRHcdj6IsV5Vfp85EgkOKsiGC+B0sbgaFEEJNr3xy4hROeSKYjU4XK7qnqc6tS2VNizBfPMku7JSWBmTfH+sKsU6XG/XStHlFgZ7Q7iPNk0m9y5sclUJ30fel4+haWb9WlGVxq20eIIz/+nFTQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:59:10 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:59:09 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v7 5/6] drm/i915/gem: Read and shrink memory in a separate
 function
Date: Tue, 6 Oct 2026 09:58:44 +0000
Message-ID: <20261006095845.451212-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84a8dbfa-f844-472e-9295-08df2390772b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EBg3E5E3GivruTp0Wfo5bnaHRI8z/q9tJAN/T9dcK0wtth/IdqQz8IqvcE+XN6EjAvdqjquo+FhFyPvfjS5YKZOBYzjiXfk0tuaW4/89IrTpF6nXDGUnODokl3WM/1Hj41PAoA2NThDi25Hk9kfyvTXKVNGO0Z8dqsNz9cYj/TuL/nGAhHEw+wiETW5VD0fVoz8zHt5Oa+NZj8uTzthnkspDZwqwPRsQNMwwspEcaknFS7A0otAYYepiYf40RtoUZc9fXHvi4KUcu4N8CWJvfW/jeSj27qNYDiYiyD6zQjosJsFn7MvqILjFKPlUzMcMNSIUfLssFhsicJ6e2ApZGS/ydfnniH3yNrUrd+GOxYv4tw8cHwRqnidxtp8b+St/mld3NTZoNQ/FqGZ3vQMLCntN+Wom13K2qhmOh3AOP32ml0IQJVXHMC7WVRUkk2LUIkCVDrHqCyZXC7UCGgoKT2CmL6orJ3RgL564V03ouj7ExNULQ5nbibJMXcRYtxg7UEnO0K7c8auV6Okzwz74SijWps6feo6nt4M5ruz1Q9ReOy0D4PeMEW8NC7c0E8I9Vb3h2Xknq1oosMK4uQ8da9aOu9+xt3GzTkTzuHyvS5GrYSCNEhl7gQU2A2MlVHWIOj+y23j55iHtRYcnrXM9BzxpBer8tJ4Yex/NWg0jQGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKqfA5maZ1d1Tp+uX8TVa6oWaYKvfGOIcy8380dk0N/5EgNgIjxlQj37+yxn?=
 =?us-ascii?Q?i7e5PNUr+WlKHhz2BCIVNpOWxwdT6GYrCtuAd9KTGas3Z6sPg8KJrH8sBPJP?=
 =?us-ascii?Q?X6Bhb3ekbXesfUfMfGBzhjpFkVGYTlXtdWOizW+I1HPH5UYywxmpdV4FotrL?=
 =?us-ascii?Q?/jrne4EwlE13f57dbvnCmAfhLwXaOFi+ooOQGLZWS15vJSTZShZoAXsSAvur?=
 =?us-ascii?Q?jKi0EjjrQc0AEfd9e5nqCEYYdaJpGWKOCKfBr8HTJ3GrlKjpzSxA1I/KbTuj?=
 =?us-ascii?Q?HgyXDygaUA8vbwMK0r0Ry6NxNyL7jjGTfr51ie5VCBXZRw0ps++0JCqMt/Vs?=
 =?us-ascii?Q?fGn4PIF4D7YpLg/7pch52AaX6kBQpQtrAhv/lXHgXF3QOhnrS4fKKp2OHIgl?=
 =?us-ascii?Q?9zA7YK1MLemldd030lyKkZSCvnVep1QwzVD364z5TDDUrAKOeYBL3e/E4bZU?=
 =?us-ascii?Q?hzQuZErczhAyE0An27X6iKOlvXiY9KIXoa7VIHUSu4/0prjZqlUmxPcyu7ct?=
 =?us-ascii?Q?jSAxGl6/GTTRQ2chhnyOK1dfqEGTOn5kuDHWt5clP83TgS0NjAMbWIgtCVux?=
 =?us-ascii?Q?DSEXZ4IUvofruIIHMyUsxsxPQUyAeuRqmy7ythuvd2LlKX8U2xDIMYFrUShx?=
 =?us-ascii?Q?OJEuEhztYuHjohXKt9apt1qN8fqDsxc6Cp2bbCR/ZGk72IpgR/rMpocndVRh?=
 =?us-ascii?Q?42ygbwKXWlrBtMpfZJx/75DwfJXyGJOEAxr/nrAi9s+uHVg89ZD9OYVBpZmY?=
 =?us-ascii?Q?5a0qbpNuCy1PblOkr27eYHqodgi6qtdu2DkqOzJ+q1Jbs+LWmKiTz2we4Z72?=
 =?us-ascii?Q?DXkjOalHU0S/VwrY4WdJsQx4mrFU/+DeATW+WPBcFjh9ANXTveVRY276Z6G0?=
 =?us-ascii?Q?5OmpzZ10ejVdmhfPvU8mdhgIUNjbR7RpkOAITPZ27mFkXxWZpDBFfrMWRYHw?=
 =?us-ascii?Q?YTEF1x3S64snCHqohMePe2r+wKwtjI3G4zInHaCDS4Ba47+GBaguJwnzYyeJ?=
 =?us-ascii?Q?vFUu+GLZBW+TZaQksQSAT+U0qyIWR3GlcIDhmuaBT41+++55vfyLfF50aVsM?=
 =?us-ascii?Q?eRCG3W8qUPEk6+q796IlBX7eF86uCPMTSN/T1OeelLUS30GOBqvHUcJltWTX?=
 =?us-ascii?Q?+eXQ8iAPWtjtNSe/9xactWer9/wm97M5Lvt+8GS16aPv9Z8osTV0e8C36JUq?=
 =?us-ascii?Q?+6jjClb+YbLDqa2ouxS0Gf2JE44+QvMhRbWJoEiZrofSdP6qHLfuZUD5BKOj?=
 =?us-ascii?Q?VNTTQ8luiOHePlIlIwo2t1QGtMs/MpWZNm15X6mtBNIKUCJF+fcS3xjDKbRg?=
 =?us-ascii?Q?1xc3hDjiZfKfZOtAXTurN1SesPxyBJ1tQwZlF/oqi+V5ZLAonI5U6qnB4Gy4?=
 =?us-ascii?Q?mTK+tg1804PYcx2bcyIChmML5Jzl9AYen6HJv3ljwCwp7Hb8+mnuojwBzpVp?=
 =?us-ascii?Q?Q+FoDTWdPCn1ZgMFcrWto6/LmCWhx0tfqRR793YtnSPmHAyrBRXfOC/UFdhI?=
 =?us-ascii?Q?GbhO3K1sYVtTWrMdJtxuS+W3qMIch81JNnLkmPrDP6StmksqqB60uix1SIOT?=
 =?us-ascii?Q?uRCsOjHK8XvYRFIO5b+ipDHyRTJf3DsRCf94UTWiZ+pAkk7MtG1EJPmTV57O?=
 =?us-ascii?Q?ONisYg4V5UQ0A2l/KG+F7L8yKIwgd4QbfAjAwA8CkXtWyKULCMzdf34H9Ok5?=
 =?us-ascii?Q?+HqZEmXp7OItSnYGfKuPnw3x1SunKoLwvBdT4bWpSbx0tXvK0Oy5PWPIEWJD?=
 =?us-ascii?Q?QB4ZR1C1RIKAxothOeJJ/NHm1QDl1oI=3D?=
X-Exchange-RoutingPolicyChecked: ZJF5ER/ycF/oON/1EBI9MNUmvO0A5hEWKdTkwSprm3DyT576GPSXOlr7u3vK1S3VciW5/opV8owoVAU4WtZ8RHpJk0syjyuqFwZAccEn0OIeRGdl067iVotCRNFrHFmNFtOqhe6cRWt+GuncyBY3HyjquxRxVA409PqF3wU1ABDNz3ttw1PR+A/26rO7EbrrhcSnWc5ea5faJpwC+5V+cNopeS2p4zZFYN0+fn5joKuEKuQDdHcURIJqQqW0daOGgfRv2B4qAjuUWDhRZcYTeVdH2M5IxNyTXu1801+kGY2XpdsWLy/4Ap4AAkFkgJrevE6NFn7Jbatfys2vPFEb5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8dbfa-f844-472e-9295-08df2390772b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:59:09.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggEX/fZAMVi/nC8fxCtD/D5oB5rrENFVg4mmBVcHFW7WuyEtwPBGUSIbZlpeKN3HIpcjJajGQ8MxobEDc8nb+J/MBVvtxjTLveOdcQkqj2s=
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

Continue unloading shmem_sg_alloc_table by placing reading
folios and shrink call into a new helper.
Make the loop a bit more reader-friendly by removing iteration
over a structure and replacing it with inlined instructions.

Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
v7:
 * No functional changes.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 105 ++++++++++++----------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 256ef414755f..a08cca3e57a2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -79,6 +79,56 @@ static int validate_set_page_count(size_t size, unsigned int *page_count,
 	return 0;
 }
 
+static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
+					    unsigned long folio_index,
+					    gfp_t *gfp, unsigned int page_count,
+					    struct drm_i915_private *i915)
+{
+	struct folio *folio;
+
+	cond_resched();
+	folio = shmem_read_folio_gfp(mapping, folio_index, *gfp);
+	if (IS_ERR(folio)) {
+		i915_gem_shrink(NULL, i915, 2 * page_count, NULL,
+				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
+
+		/*
+		 * We've tried hard to allocate the memory by reaping
+		 * our own buffer, now let the real VM do its job and
+		 * go down in flames if truly OOM.
+		 *
+		 * However, since graphics tend to be disposable,
+		 * defer the oom here by reporting the ENOMEM back
+		 * to userspace.
+		 *
+		 * Reclaim and warn, but no oom.
+		 */
+		*gfp = mapping_gfp_mask(mapping);
+
+		/*
+		 * Our bo are always dirty and so we require
+		 * kswapd to reclaim our pages (direct reclaim
+		 * does not effectively begin pageout of our
+		 * buffers on its own). However, direct reclaim
+		 * only waits for kswapd when under allocation
+		 * congestion. So as a result __GFP_RECLAIM is
+		 * unreliable and fails to actually reclaim our
+		 * dirty pages -- unless you try over and over
+		 * again with !__GFP_NORETRY. However, we still
+		 * want to fail this allocation rather than
+		 * trigger the out-of-memory killer and for
+		 * this we want __GFP_RETRY_MAYFAIL.
+		 */
+		*gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+		/* Retry once after shrinking and gfp modification. */
+		cond_resched();
+		folio = shmem_read_folio_gfp(mapping, folio_index, *gfp);
+	}
+
+	return folio;
+}
+
 int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
@@ -118,58 +168,17 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	for (i = 0; i < page_count; i++) {
 		unsigned long folio_page_index;
 		unsigned long nr_pages;
-		const unsigned int shrink[] = {
-			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
-			0,
-		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
 		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
 			/* Grab the next folio if we exhausted the current one. */
-			do {
-				cond_resched();
-				folio = shmem_read_folio_gfp(mapping, i, gfp);
-				folio_page_index = 0;
-				if (!IS_ERR(folio))
-					break;
-
-				if (!*s) {
-					ret = PTR_ERR(folio);
-					goto err_sg;
-				}
-
-				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-				/*
-				 * We've tried hard to allocate the memory by reaping
-				 * our own buffer, now let the real VM do its job and
-				 * go down in flames if truly OOM.
-				 *
-				 * However, since graphics tend to be disposable,
-				 * defer the oom here by reporting the ENOMEM back
-				 * to userspace.
-				 */
-				if (!*s) {
-					/* reclaim and warn, but no oom */
-					gfp = mapping_gfp_mask(mapping);
-
-					/*
-					 * Our bo are always dirty and so we require
-					 * kswapd to reclaim our pages (direct reclaim
-					 * does not effectively begin pageout of our
-					 * buffers on its own). However, direct reclaim
-					 * only waits for kswapd when under allocation
-					 * congestion. So as a result __GFP_RECLAIM is
-					 * unreliable and fails to actually reclaim our
-					 * dirty pages -- unless you try over and over
-					 * again with !__GFP_NORETRY. However, we still
-					 * want to fail this allocation rather than
-					 * trigger the out-of-memory killer and for
-					 * this we want __GFP_RETRY_MAYFAIL.
-					 */
-					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-				}
-			} while (1);
+			folio = shmem_shrink_get_folio(mapping, i, &gfp,
+						       page_count, i915);
+			folio_page_index = 0;
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
+				goto err_sg;
+			}
 		} else {
 			/* 
 			 * Otherwise, we are still inside the same folio,
-- 
2.34.1

