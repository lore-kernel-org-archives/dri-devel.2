Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F9DC61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFF010E4AB;
	Fri, 28 Aug 2026 10:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m2UaRS4M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CCB10E49A;
 Fri, 28 Aug 2026 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911446; x=1819447446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=0WS8Sm6q54VdjU7IvLHOxjFeVCrx1DBE79PpHs6/bxE=;
 b=m2UaRS4MLmZhAGBX+ifEpkWS4ZjkqKmFtzv8MxEL5g0Lo4X8lAT5j8WT
 5doMw6xt9YBJfWNJX62GrP+ebWfW6wvsHYYJcKYvi6IRjDdR/b0cbavG9
 6JzuC+jdgNt0qWviPf95hueknP5PBUpV2HI2GDOhbcxOd0lQ2jW8T96kH
 ZBjeJldWaVQ6MbAMjBCJuWBNEkdvusMq4shBBuqHx5bdOfAtAzOIwuX20
 /lvHhbRmmnn/SSeiZbo9E6L9/N0ILcbhOTvRfRdhNd4/aE58m2K5et8Ai
 NJvhA4uU2doToprs+R1Ssv5niqbz2MOS8xHHldwo5FSx2SvIMKvipBSnd w==;
X-CSE-ConnectionGUID: qHoPRVBsSkmJtrKnS94Xrw==
X-CSE-MsgGUID: MqyxzBBoQ5iy11LIjD4K8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92231321"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92231321"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:06 -0700
X-CSE-ConnectionGUID: Km8cR8QPQpWHlpcAPaBRFg==
X-CSE-MsgGUID: RJFAqSybRSScCXwEXoirew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="261973060"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:04 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYq6ZacPxYPIPvN+t+P+NoopFEqJQGbf6D0F5PkT2p2S6wr7Zqp+3H8kz/mPOuB0ARbrQGX3cZT5Vy+kinI+fI/ly/bDLwH0jnIcxv2ibEkl0u+bdrHDrXK5LG4JHBOSKifHGZ42zpTojHduoDnxJz6QLd+NwNkjT2i0UwhMotiQMmzLd22+YyVs8qpx2h/D0wgvd+uOfCAUm5ocuVtX8yVOcxSUYscx+TVhWNFfP+RklpH2ZdEClbqoyWEe9EzXXPXSQHKYdieejvrMUrvrifuoXIkl8xuO65pOgdl11PpoazYdUqWiUKhuJaEvms6QXZD1ZGXNNqN6XO59fpU05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvW7N60/MMmKEfzU9Zwql38GexWNxO6F7g9yuvPcE3o=;
 b=Zg6Ltt2WzQ39LYF2TbTenh9xDabRFLHI7TOvbHv6x5DQYSh+x36jzYTQSpol7U/YwHswVpswfnscHXBQdad8QJpLIcLWfWy9aMiusz1Qr8CaDssl/pADPnbBN8VEc4qprvizHWejP6sLKGAcel03in0rkWnXqOJ0LAqZkbrsU21Z+Bi5C7j+9Qx+jzcsvLmyIvudxjCA7kkys72z03edgygvkkjUNSADh7POGTj40uzJERGI6QD4O+cAoqpQennjQwilroRjvFYKMfW6ASSqWuviyNHxMkgru+FnWKlRwI8kEIFqW44C47cltVFaJEA8U//FISEw6H3AL1t4knocXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:02 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:04:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 2/8] drm/i915/selftests: Use drm_* prints in live selftests
Date: Fri, 28 Aug 2026 10:03:33 +0000
Message-ID: <20260828100339.72304-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828100339.72304-1-krzysztof.karas@intel.com>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI6PEPF0000022C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e5) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d67d70-fdd9-4434-b602-08df04ebaf85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Giwv+vbBuy3aaAjCyCDH2ahZnY8kS4plBpNMZX9lnQ+mA2gEDBsG9MyNzKSGnwji1gWDiy713BwNMl3F60nMEOC1grZVkf19VIB8t1BkJHqZ+ZvE1QJ9S9e0WTfgRz0UyGDrXe+xUWoEwEAk639xJVqcpq8et+q3gV3Se0+7gV+Bal8C5UcjsEbU5cmaHb4xq38bvcDmvB6DU4UDfco5i/rcsGzqof+7Y/3A2qAuL27fhQt0GW5QDWlw4YVG3hPiEcoM9569ld3kC8rfEtQ+FWgkKmZ1G2kJqwAPkZnWbJtYXw77gkPDbODd/mMbhreRNhw1o6ssdAmm4UdRoIyhWSaVIv6ySt6L/EVUMKtodwz7rGrAyumR2mCb764RwD5xgTweZAFHjUNwdK2GI87MIhjebYKKJSWdG7Ux6dMcbV/QDj91xdJoLw/uDn49nPFVfG0GrXBDoBp5Wn0AeEBgrsa7GdKMale7YdQLX/PaHoHhRS1viPMgyaMA12+dGrdHsajHBFSMkRjIJ9pgBdkzEiaV4SB4ptFhbxJ5+ZBzvGte+t1mKqZ0WzDqwRbMoM1hoV/n/lScDpPW6W1FGElbrmtugeSuYZYyAfkD1CkMEynIVdzPaNR8ON4qHzLDZs3J9kLwqgByk0suIFJkahGj9EHTzqG01peTsvRuJpIyt9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfcWmjNwQBDQYRPYOtHTlGxTx2vxwN9J/jdECglcK71i6f09MptyxabWU0vp?=
 =?us-ascii?Q?YSgz7TxmbyQWZBuaf0oDc/54qrKtqTV4LbCvi01qKMmy7zgSI0QIv0U2yHBl?=
 =?us-ascii?Q?o5IXk0SwXaX58WO+2UxaQ5jAOIxpLJN7LSVaojjCP8GnXV6YWfVJ144IC4bR?=
 =?us-ascii?Q?JSoRcI6bHMbbVTCLGGGRFojpCy6OSbLv5/p/dl1wIleVsRPXkpgLQinYO2PC?=
 =?us-ascii?Q?KKvYjTXWOryrU5Pp7pU1iIfEfZTiuS5sGpd0ePIhHg+ANNxTjDvnqgb1WnZT?=
 =?us-ascii?Q?X62EDaW9a3zZFKm/PRC1RRczpFhxLwbG6VmIb8+0l5E5bq58MDNMM4UFuwUo?=
 =?us-ascii?Q?a5sBqVDpbouiAvjf+ASpY8V0HVTbQjiQ2oF9cz9wjAqpA7DYncl0yUT3G6l+?=
 =?us-ascii?Q?lvRGPTcLe1+oWY1SqBc8Q/5S2aKZgiNk8/SUHukob1yWHjeXwbw3R8houaB5?=
 =?us-ascii?Q?o+VqNuH1ZgT3/lLuC6rauxStVl9eUHr4vBZ5AC38YRIeMRPY80Z+Ywyr13Xq?=
 =?us-ascii?Q?BcWQ8Jd5mEBE9OTQhWa/KztIH/5OB8def9wFgpn3RqL9zJr1CiOS7CGrOEe4?=
 =?us-ascii?Q?QmeIVhSXTlAiHqynMl/qtYxpFulWh4aWphMpF7TTW5Bk4UZ30v19YGScRGhl?=
 =?us-ascii?Q?Nrvqx/HUUwRJXEi7ihIElKnX0otJxM+GJGP7ecJUt4QnmF6BQgbdb53m+zdG?=
 =?us-ascii?Q?VQj76e8tPbKZypFHL/rFZ93dlFFmCJiTnvRVXK+BM6kwwHBRat0oGOTcHyCH?=
 =?us-ascii?Q?c217Ppa+8AWJtWhzobV6A2e0rLAb9TVwtUQLKpE6nQNcBffUdLCWKZzAYp41?=
 =?us-ascii?Q?tHz7js8LIT6zyVgSTdGFBpQJSL6D+abVnvhWSQq2y8d5VBhA0p+hqvozeqSB?=
 =?us-ascii?Q?YVzSaMlA2suPGbNg7+JUWt8Bri11Rez9SuEfKbqe5+CDM2c8+T+GybaTmQP5?=
 =?us-ascii?Q?lxQLaWt+n7OeZq20cLX30t0lDoV93xF1vKzNzWuiZXqq/7pF/JTbNKm2Djxc?=
 =?us-ascii?Q?mmn3FiYJRXGD69/j505ksHSRZy5+O3DxV7b4pIpFBRKC7Erlsz6pPIRhjhEl?=
 =?us-ascii?Q?yo0aBx6syBwJYaF3Pqwkui8270mmH5jtk6LKMDr3Yu8OnKAND+Jbhq7TcMpJ?=
 =?us-ascii?Q?CP7vaJHAVjSSPwG5h6Uub/KdWvyBtHrdWbzxxJGZnTBC0HeMiWQgN+RaOi02?=
 =?us-ascii?Q?GncMWpCeaymkXvY/wCp+BEqzUH9V1MqFAXWWMF+BUceerYGFw29ode1ZytPw?=
 =?us-ascii?Q?iEuS7bV4h/JV+VJitm9nYtopacaY0wLMpVC4xhgA+/78FnPx1gC68r0Ksn4y?=
 =?us-ascii?Q?2ApeNe2HonKHp/tm/Cmh0y474kRdRWMJlQd2IKaaXyxXBPZEv3B+i4jN/u1Q?=
 =?us-ascii?Q?ShAgk7QecyVRqReqUKSdiCqQ/n6eCbFUJGP4ogKMgzmjee9aiv65Ma221jNM?=
 =?us-ascii?Q?mg3RLqbKVZ8aK3/X5XEKzxfXbIN9DTg3d0UfN7iUtoBpC9eLxpcyIEk+5Nfb?=
 =?us-ascii?Q?X2mI3Qo/GL2UxmuOGxROHTcD4hWCcl9w/1FNvGykNI2nP44uSXOt9+/OlZ1b?=
 =?us-ascii?Q?n/RhClvOItPY9OyOtZ64+Bj6eWiSa0iFBNLPrA3b4cNqXDnMDyPNzcYfrq6k?=
 =?us-ascii?Q?GQ0bCq63l4hi5ZI4Wpzaq45kaY1BhTidvkDhOB6eLCbandkGIMAlDfI28O/O?=
 =?us-ascii?Q?jErSJZMr62uutvJLeueLt2pKUobr+mclwM5c823cUEvNUXcENn+oonfZ37PU?=
 =?us-ascii?Q?r176EK7KpQo+Qy2DBxW1ci1i5Ot1oHQ=3D?=
X-Exchange-RoutingPolicyChecked: HWE1QgDM5sFQpPClSJPKPsu8St2vIuc8Fpchy5tkIc4gNK9MFX/SfDLh98HYammIqtGigdhu9sdJlnfEXIRgh/o3qebjUEA50ZLX11RF+FZpj0jKpkmxKir9FyPE0KlxbV9bmTmDRsQtfvl5b8v/HW5O5IDeboVN34zDGOdntfsihpP2SUS7lklBPisPAe8eu+nsHborkA8ZS83VKF6D/mSfmFq0dNI/J/o5njqBPhx2pDQoL80dLDfBYU+3Ahy8yOUlcXSdAmE5ty7HApSCNKbXB9iWVW5cSZqmxwYJm5k80UVwfTirlkrhAPuM1p15c6IDX7+j7is28cfDTSLelQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d67d70-fdd9-4434-b602-08df04ebaf85
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:04:02.1247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8tpSjkJqYPqcs5PfSJ6y44vDIAyeX2wZwsN5Xk5wAPHJNPnLiMx3WZEabKtQOlKqM/SAKS7llNg3O5xgtZ9DWM5nS58HaCHUyxoyo9ccIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
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

Move away from generic pr prints to device context aware drm
versions.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  75 +++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 223 ++++++++-----
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  29 +-
 drivers/gpu/drm/i915/selftests/i915_request.c | 301 +++++++++++-------
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 257 +++++++++------
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  47 +--
 6 files changed, 566 insertions(+), 366 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 718cddde7e73..604289814f79 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -29,6 +29,8 @@
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_print.h"
 
+#include <drm/drm_print.h>
+
 #include "i915_selftest.h"
 
 #include "igt_flush_test.h"
@@ -47,6 +49,7 @@ static void quirk_add(struct drm_i915_gem_object *obj,
 
 static int populate_ggtt(struct i915_ggtt *ggtt, struct list_head *objects)
 {
+	struct drm_i915_private *i915 = ggtt->vm.i915;
 	struct drm_i915_gem_object *obj;
 	unsigned long count;
 
@@ -71,11 +74,13 @@ static int populate_ggtt(struct i915_ggtt *ggtt, struct list_head *objects)
 		quirk_add(obj, objects);
 		count++;
 	} while (1);
-	pr_debug("Filled GGTT with %lu pages [%llu total]\n",
-		 count, ggtt->vm.total / PAGE_SIZE);
+	drm_dbg(&i915->drm,
+		"Filled GGTT with %lu pages [%llu total]\n", count,
+		ggtt->vm.total / PAGE_SIZE);
 
 	if (list_empty(&ggtt->vm.bound_list)) {
-		pr_err("No objects on the GGTT inactive list!\n");
+		drm_err(&i915->drm,
+			"No objects on the GGTT inactive list!\n");
 		return -EINVAL;
 	}
 
@@ -107,6 +112,7 @@ static void cleanup_objects(struct i915_ggtt *ggtt, struct list_head *list)
 static int igt_evict_something(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct i915_ggtt *ggtt = gt->ggtt;
 	LIST_HEAD(objects);
 	int err;
@@ -125,8 +131,9 @@ static int igt_evict_something(void *arg)
 				       0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err != -ENOSPC) {
-		pr_err("i915_gem_evict_something failed on a full GGTT with err=%d\n",
-		       err);
+		drm_err(&i915->drm,
+			"i915_gem_evict_something failed on a full GGTT with err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -140,8 +147,9 @@ static int igt_evict_something(void *arg)
 				       0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_something failed on a full GGTT with err=%d\n",
-		       err);
+		drm_err(&i915->drm,
+			"i915_gem_evict_something failed on a full GGTT with err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -177,7 +185,9 @@ static int igt_overcommit(void *arg)
 
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0, 0);
 	if (vma != ERR_PTR(-ENOSPC)) {
-		pr_err("Failed to evict+insert, i915_gem_object_ggtt_pin returned err=%d\n", (int)PTR_ERR_OR_ZERO(vma));
+		drm_err(&gt->i915->drm,
+			"Failed to evict+insert, i915_gem_object_ggtt_pin returned err=%d\n",
+			(int)PTR_ERR_OR_ZERO(vma));
 		err = -EINVAL;
 		goto cleanup;
 	}
@@ -190,6 +200,7 @@ static int igt_overcommit(void *arg)
 static int igt_evict_for_vma(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct i915_ggtt *ggtt = gt->ggtt;
 	struct drm_mm_node target = {
 		.start = 0,
@@ -209,8 +220,9 @@ static int igt_evict_for_vma(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err != -ENOSPC) {
-		pr_err("i915_gem_evict_for_node on a full GGTT returned err=%d\n",
-		       err);
+		drm_err(&i915->drm,
+			"i915_gem_evict_for_node on a full GGTT returned err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -221,8 +233,8 @@ static int igt_evict_for_vma(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_for_node returned err=%d\n",
-		       err);
+		drm_err(&i915->drm,
+			"i915_gem_evict_for_node returned err=%d\n", err);
 		goto cleanup;
 	}
 
@@ -248,6 +260,7 @@ static int igt_evict_for_cache_color(void *arg)
 		.size = I915_GTT_PAGE_SIZE,
 		.color = i915_gem_get_pat_index(gt->i915, I915_CACHE_LLC),
 	};
+	struct drm_i915_private *i915 = gt->i915;
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	LIST_HEAD(objects);
@@ -273,7 +286,7 @@ static int igt_evict_for_cache_color(void *arg)
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
 				       I915_GTT_PAGE_SIZE | flags);
 	if (IS_ERR(vma)) {
-		pr_err("[0]i915_gem_object_ggtt_pin failed\n");
+		drm_err(&i915->drm, "[0]i915_gem_object_ggtt_pin failed\n");
 		err = PTR_ERR(vma);
 		goto cleanup;
 	}
@@ -290,7 +303,7 @@ static int igt_evict_for_cache_color(void *arg)
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
 				       (I915_GTT_PAGE_SIZE * 2) | flags);
 	if (IS_ERR(vma)) {
-		pr_err("[1]i915_gem_object_ggtt_pin failed\n");
+		drm_err(&i915->drm, "[1]i915_gem_object_ggtt_pin failed\n");
 		err = PTR_ERR(vma);
 		goto cleanup;
 	}
@@ -302,7 +315,8 @@ static int igt_evict_for_cache_color(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("[0]i915_gem_evict_for_node returned err=%d\n", err);
+		drm_err(&i915->drm,
+			"[0]i915_gem_evict_for_node returned err=%d\n", err);
 		goto cleanup;
 	}
 
@@ -315,7 +329,8 @@ static int igt_evict_for_cache_color(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (!err) {
-		pr_err("[1]i915_gem_evict_for_node returned err=%d\n", err);
+		drm_err(&i915->drm,
+			"[1]i915_gem_evict_for_node returned err=%d\n", err);
 		err = -EINVAL;
 		goto cleanup;
 	}
@@ -332,6 +347,7 @@ static int igt_evict_for_cache_color(void *arg)
 static int igt_evict_vm(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct i915_ggtt *ggtt = gt->ggtt;
 	struct i915_gem_ww_ctx ww;
 	LIST_HEAD(objects);
@@ -348,8 +364,9 @@ static int igt_evict_vm(void *arg)
 	err = i915_gem_evict_vm(&ggtt->vm, NULL, NULL);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_vm on a full GGTT returned err=%d]\n",
-		       err);
+		drm_err(&i915->drm,
+			"i915_gem_evict_vm on a full GGTT returned err=%d]\n",
+			err);
 		goto cleanup;
 	}
 
@@ -362,8 +379,9 @@ static int igt_evict_vm(void *arg)
 	}
 
 	if (err) {
-		pr_err("i915_gem_evict_vm on a full GGTT returned err=%d]\n",
-		       err);
+		drm_err(&i915->drm,
+			"i915_gem_evict_vm on a full GGTT returned err=%d]\n",
+			err);
 		goto cleanup;
 	}
 
@@ -443,7 +461,7 @@ static int igt_evict_contexts(void *arg)
 	} while (1);
 	drm_mm_remove_node(&hole);
 	mutex_unlock(&ggtt->vm.mutex);
-	pr_info("Filled GGTT with %lu 1MiB nodes\n", count);
+	drm_info(&i915->drm, "Filled GGTT with %lu 1MiB nodes\n", count);
 
 	/* Overfill the GGTT with context objects and so try to evict one. */
 	for_each_engine(engine, gt, id) {
@@ -469,9 +487,9 @@ static int igt_evict_contexts(void *arg)
 			if (IS_ERR(rq)) {
 				/* When full, fail_if_busy will trigger EBUSY */
 				if (PTR_ERR(rq) != -EBUSY) {
-					pr_err("Unexpected error from request alloc (on %s): %d\n",
-					       engine->name,
-					       (int)PTR_ERR(rq));
+					drm_err(&i915->drm,
+						"Unexpected error from request alloc (on %s): %d\n",
+						engine->name, (int)PTR_ERR(rq));
 					err = PTR_ERR(rq);
 				}
 				break;
@@ -492,16 +510,17 @@ static int igt_evict_contexts(void *arg)
 			err = 0;
 		} while(1);
 		onstack_fence_fini(&fence);
-		pr_info("Submitted %lu contexts/requests on %s\n",
-			count, engine->name);
+		drm_info(&i915->drm, "Submitted %lu contexts/requests on %s\n",
+			 count, engine->name);
 		if (err)
 			break;
 		if (last) {
 			if (i915_request_wait(last, 0, HZ) < 0) {
 				err = -EIO;
 				i915_request_put(last);
-				pr_err("Failed waiting for last request (on %s)",
-				       engine->name);
+				drm_err(&i915->drm,
+					"Failed waiting for last request (on %s)\n",
+					engine->name);
 				break;
 			}
 			i915_request_put(last);
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index e6bd06774816..0c855f00c3ae 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -25,6 +25,8 @@
 #include <linux/list_sort.h>
 #include <linux/prime_numbers.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_context.h"
 #include "gem/i915_gem_internal.h"
 #include "gem/i915_gem_lmem.h"
@@ -34,6 +36,7 @@
 #include "gt/intel_gpu_commands.h"
 #include "gt/intel_gtt.h"
 
+#include "../i915_drv.h"
 #include "i915_random.h"
 #include "i915_selftest.h"
 #include "i915_vma_resource.h"
@@ -268,8 +271,10 @@ static int lowlevel_hole(struct i915_address_space *vm,
 			hole_size = KMALLOC_MAX_SIZE / sizeof(u32);
 		count = hole_size >> 1;
 		if (!count) {
-			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
-				 __func__, hole_start, hole_end, size, hole_size);
+			drm_dbg(&vm->i915->drm,
+				"%s: hole is too small [%llx - %llx] >> %d: %lld\n",
+				__func__, hole_start, hole_end, size,
+				hole_size);
 			break;
 		}
 
@@ -417,6 +422,7 @@ static int fill_hole(struct i915_address_space *vm,
 	const unsigned long max_pages =
 		min_t(u64, ULONG_MAX - 1, (hole_size / 2) >> ilog2(min_alignment));
 	const unsigned long max_step = max(int_sqrt(max_pages), 2UL);
+	struct drm_i915_private *i915 = vm->i915;
 	unsigned long npages, prime, flags;
 	struct i915_vma *vma;
 	LIST_HEAD(objects);
@@ -472,16 +478,23 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
-						       __func__, p->name, err, npages, prime, offset);
+						drm_err(&i915->drm,
+							"%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+							__func__, p->name, err,
+							npages, prime, offset);
 						goto err;
 					}
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (forward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
-						       offset);
+						drm_err(&i915->drm,
+							"%s(%s) (forward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+							__func__, p->name,
+							vma->node.start,
+							vma->node.size,
+							drm_mm_node_allocated(
+								&vma->node),
+							offset);
 						err = -EINVAL;
 						goto err;
 					}
@@ -512,18 +525,22 @@ static int fill_hole(struct i915_address_space *vm,
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (forward) moved vma.node=%llx + %llx, expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       offset);
+						drm_err(&i915->drm,
+							"%s(%s) (forward) moved vma.node=%llx + %llx, expected offset %llx\n",
+							__func__, p->name,
+							vma->node.start,
+							vma->node.size, offset);
 						err = -EINVAL;
 						goto err;
 					}
 
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("%s(%s) (forward) unbind of vma.node=%llx + %llx failed with err=%d\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       err);
+						drm_err(&i915->drm,
+							"%s(%s) (forward) unbind of vma.node=%llx + %llx failed with err=%d\n",
+							__func__, p->name,
+							vma->node.start,
+							vma->node.size, err);
 						goto err;
 					}
 
@@ -551,16 +568,23 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
-						       __func__, p->name, err, npages, prime, offset);
+						drm_err(&i915->drm,
+							"%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+							__func__, p->name, err,
+							npages, prime, offset);
 						goto err;
 					}
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (backward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
-						       offset);
+						drm_err(&i915->drm,
+							"%s(%s) (backward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+							__func__, p->name,
+							vma->node.start,
+							vma->node.size,
+							drm_mm_node_allocated(
+								&vma->node),
+							offset);
 						err = -EINVAL;
 						goto err;
 					}
@@ -591,18 +615,25 @@ static int fill_hole(struct i915_address_space *vm,
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (backward) moved vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
-						       offset);
+						drm_err(&i915->drm,
+							"%s(%s) (backward) moved vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+							__func__, p->name,
+							vma->node.start,
+							vma->node.size,
+							drm_mm_node_allocated(
+								&vma->node),
+							offset);
 						err = -EINVAL;
 						goto err;
 					}
 
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("%s(%s) (backward) unbind of vma.node=%llx + %llx failed with err=%d\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       err);
+						drm_err(&i915->drm,
+							"%s(%s) (backward) unbind of vma.node=%llx + %llx failed with err=%d\n",
+							__func__, p->name,
+							vma->node.start,
+							vma->node.size, err);
 						goto err;
 					}
 
@@ -636,6 +667,7 @@ static int walk_hole(struct i915_address_space *vm,
 		     u64 hole_start, u64 hole_end,
 		     unsigned long end_time)
 {
+	struct drm_i915_private *i915 = vm->i915;
 	const u64 hole_size = hole_end - hole_start;
 	const unsigned long max_pages =
 		min_t(u64, ULONG_MAX - 1, hole_size >> PAGE_SHIFT);
@@ -672,25 +704,28 @@ static int walk_hole(struct i915_address_space *vm,
 		     addr += round_up(obj->base.size, min_alignment)) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s bind failed at %llx + %llx [hole %llx- %llx] with err=%d\n",
-				       __func__, addr, vma->size,
-				       hole_start, hole_end, err);
+				drm_err(&i915->drm,
+					"%s bind failed at %llx + %llx [hole %llx- %llx] with err=%d\n",
+					__func__, addr, vma->size, hole_start,
+					hole_end, err);
 				goto err_put;
 			}
 			i915_vma_unpin(vma);
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
-				       __func__, addr, vma->size);
+				drm_err(&i915->drm,
+					"%s incorrect at %llx + %llx\n",
+					__func__, addr, vma->size);
 				err = -EINVAL;
 				goto err_put;
 			}
 
 			err = i915_vma_unbind_unlocked(vma);
 			if (err) {
-				pr_err("%s unbind failed at %llx + %llx  with err=%d\n",
-				       __func__, addr, vma->size, err);
+				drm_err(&i915->drm,
+					"%s unbind failed at %llx + %llx  with err=%d\n",
+					__func__, addr, vma->size, err);
 				goto err_put;
 			}
 
@@ -719,6 +754,7 @@ static int pot_hole(struct i915_address_space *vm,
 		    u64 hole_start, u64 hole_end,
 		    unsigned long end_time)
 {
+	struct drm_i915_private *i915 = vm->i915;
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	unsigned int min_alignment;
@@ -754,18 +790,18 @@ static int pot_hole(struct i915_address_space *vm,
 		     addr += step) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s failed to pin object at %llx in hole [%llx - %llx], with err=%d\n",
-				       __func__,
-				       addr,
-				       hole_start, hole_end,
-				       err);
+				drm_err(&i915->drm,
+					"%s failed to pin object at %llx in hole [%llx - %llx], with err=%d\n",
+					__func__, addr, hole_start, hole_end,
+					err);
 				goto err_obj;
 			}
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
-				       __func__, addr, vma->size);
+				drm_err(&i915->drm,
+					"%s incorrect at %llx + %llx\n",
+					__func__, addr, vma->size);
 				i915_vma_unpin(vma);
 				err = i915_vma_unbind_unlocked(vma);
 				err = -EINVAL;
@@ -795,6 +831,7 @@ static int drunk_hole(struct i915_address_space *vm,
 		      unsigned long end_time)
 {
 	I915_RND_STATE(prng);
+	struct drm_i915_private *i915 = vm->i915;
 	unsigned int min_alignment;
 	unsigned int size;
 	unsigned long flags;
@@ -819,8 +856,10 @@ static int drunk_hole(struct i915_address_space *vm,
 			hole_size = KMALLOC_MAX_SIZE / sizeof(u32);
 		count = hole_size >> 1;
 		if (!count) {
-			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
-				 __func__, hole_start, hole_end, size, hole_size);
+			drm_dbg(&i915->drm,
+				"%s: hole is too small [%llx - %llx] >> %d: %lld\n",
+				__func__, hole_start, hole_end, size,
+				hole_size);
 			break;
 		}
 
@@ -859,18 +898,18 @@ static int drunk_hole(struct i915_address_space *vm,
 
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
-				       __func__,
-				       addr, BIT_ULL(size),
-				       hole_start, hole_end,
-				       err);
+				drm_err(&i915->drm,
+					"%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
+					__func__, addr, BIT_ULL(size),
+					hole_start, hole_end, err);
 				goto err_obj;
 			}
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
-				       __func__, addr, BIT_ULL(size));
+				drm_err(&i915->drm,
+					"%s incorrect at %llx + %llx\n",
+					__func__, addr, BIT_ULL(size));
 				i915_vma_unpin(vma);
 				err = i915_vma_unbind_unlocked(vma);
 				err = -EINVAL;
@@ -906,6 +945,7 @@ static int __shrink_hole(struct i915_address_space *vm,
 			 unsigned long end_time)
 {
 	struct drm_i915_gem_object *obj;
+	struct drm_i915_private *i915 = vm->i915;
 	unsigned long flags = PIN_OFFSET_FIXED | PIN_USER;
 	unsigned int min_alignment;
 	unsigned int order = 12;
@@ -939,15 +979,17 @@ static int __shrink_hole(struct i915_address_space *vm,
 
 		err = i915_vma_pin(vma, 0, 0, addr | flags);
 		if (err) {
-			pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
-			       __func__, addr, size, hole_start, hole_end, err);
+			drm_err(&i915->drm,
+				"%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
+				__func__, addr, size, hole_start, hole_end,
+				err);
 			break;
 		}
 
 		if (!drm_mm_node_allocated(&vma->node) ||
 		    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-			pr_err("%s incorrect at %llx + %llx\n",
-			       __func__, addr, size);
+			drm_err(&i915->drm, "%s incorrect at %llx + %llx\n",
+				__func__, addr, size);
 			i915_vma_unpin(vma);
 			err = i915_vma_unbind_unlocked(vma);
 			err = -EINVAL;
@@ -1419,8 +1461,9 @@ static int igt_ggtt_page(void *arg)
 		io_mapping_unmap_atomic(vaddr);
 
 		if (val != n) {
-			pr_err("insert page failed: found %d, expected %d\n",
-			       val, n);
+			drm_err(&i915->drm,
+				"insert page failed: found %d, expected %d\n",
+				val, n);
 			err = -EINVAL;
 			break;
 		}
@@ -1539,6 +1582,7 @@ static int igt_gtt_reserve(void *arg)
 {
 	struct i915_ggtt *ggtt = arg;
 	struct drm_i915_gem_object *obj, *on;
+	struct drm_i915_private *i915 = ggtt->vm.i915;
 	I915_RND_STATE(prng);
 	LIST_HEAD(objects);
 	u64 total;
@@ -1578,8 +1622,9 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, total);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
@@ -1587,9 +1632,10 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       total, 2*I915_GTT_PAGE_SIZE);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+				vma->node.start, vma->node.size, total,
+				2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1624,8 +1670,9 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, total);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
@@ -1633,9 +1680,10 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       total, 2*I915_GTT_PAGE_SIZE);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+				vma->node.start, vma->node.size, total,
+				2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1654,7 +1702,8 @@ static int igt_gtt_reserve(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("i915_vma_unbind failed with err=%d!\n", err);
+			drm_err(&i915->drm,
+				"i915_vma_unbind failed with err=%d!\n", err);
 			goto out;
 		}
 
@@ -1665,8 +1714,9 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, offset);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
@@ -1674,9 +1724,10 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       offset, 2*I915_GTT_PAGE_SIZE);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+				vma->node.start, vma->node.size, offset,
+				2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1719,6 +1770,7 @@ static int igt_gtt_insert(void *arg)
 {
 	struct i915_ggtt *ggtt = arg;
 	struct drm_i915_gem_object *obj, *on;
+	struct drm_i915_private *i915 = ggtt->vm.i915;
 	struct drm_mm_node tmp = {};
 	const struct invalid_insert {
 		u64 size;
@@ -1766,9 +1818,10 @@ static int igt_gtt_insert(void *arg)
 					  0);
 		mutex_unlock(&ggtt->vm.mutex);
 		if (err != -ENOSPC) {
-			pr_err("Invalid i915_gem_gtt_insert(.size=%llx, .alignment=%llx, .start=%llx, .end=%llx) succeeded (err=%d)\n",
-			       ii->size, ii->alignment, ii->start, ii->end,
-			       err);
+			drm_err(&i915->drm,
+				"Invalid i915_gem_gtt_insert(.size=%llx, .alignment=%llx, .start=%llx, .end=%llx) succeeded (err=%d)\n",
+				ii->size, ii->alignment, ii->start, ii->end,
+				err);
 			return -EINVAL;
 		}
 	}
@@ -1807,8 +1860,9 @@ static int igt_gtt_insert(void *arg)
 			break;
 		}
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
@@ -1827,7 +1881,8 @@ static int igt_gtt_insert(void *arg)
 		}
 
 		if (!drm_mm_node_allocated(&vma->node)) {
-			pr_err("VMA was unexpectedly evicted!\n");
+			drm_err(&i915->drm,
+				"VMA was unexpectedly evicted!\n");
 			err = -EINVAL;
 			goto out;
 		}
@@ -1851,22 +1906,25 @@ static int igt_gtt_insert(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("i915_vma_unbind failed with err=%d!\n", err);
+			drm_err(&i915->drm,
+				"i915_vma_unbind failed with err=%d!\n", err);
 			goto out;
 		}
 
 		err = insert_gtt_with_resource(vma);
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
 
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset) {
-			pr_err("i915_gem_gtt_insert did not return node to its previous location (the only hole), expected address %llx, found %llx\n",
-			       offset, vma->node.start);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_insert did not return node to its previous location (the only hole), expected address %llx, found %llx\n",
+				offset, vma->node.start);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1901,8 +1959,9 @@ static int igt_gtt_insert(void *arg)
 
 		err = insert_gtt_with_resource(vma);
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&i915->drm,
+				"i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index e9469e27f42a..d2a1a901d47b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -14,6 +14,8 @@
 #include "igt_flush_test.h"
 #include "lib_sw_fence.h"
 
+#include <drm/drm_print.h>
+
 #define TEST_OA_CONFIG_UUID "12345678-1234-1234-1234-1234567890ab"
 
 static int
@@ -263,20 +265,21 @@ static int live_noa_delay(void *arg)
 	t1 = poll_status(rq, 0x102);
 	preempt_enable();
 
-	pr_info("CPU delay: %lluns, expected %lluns\n",
-		ktime_sub(t1, t0), expected);
+	drm_info(&i915->drm,
+		 "CPU delay: %lluns, expected %lluns\n", ktime_sub(t1, t0),
+		 expected);
 
 	delay = intel_read_status_page(stream->engine, 0x102);
 	delay -= intel_read_status_page(stream->engine, 0x100);
 	delay = intel_gt_clock_interval_to_ns(stream->engine->gt, delay);
-	pr_info("GPU delay: %uns, expected %lluns\n",
-		delay, expected);
+	drm_info(&i915->drm,
+		 "GPU delay: %uns, expected %lluns\n", delay, expected);
 
 	if (4 * delay < 3 * expected || 2 * delay > 3 * expected) {
-		pr_err("GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
-		       delay / 1000,
-		       div_u64(3 * expected, 4000),
-		       div_u64(3 * expected, 2000));
+		drm_err(&i915->drm,
+			"GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
+			delay / 1000, div_u64(3 * expected, 4000),
+			div_u64(3 * expected, 2000));
 		err = -EINVAL;
 	}
 
@@ -385,7 +388,7 @@ static int live_noa_gpr(void *arg)
 	i915_request_add(rq);
 
 	if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE, HZ / 2) < 0) {
-		pr_err("noa_wait timed out\n");
+		drm_err(&i915->drm, "noa_wait timed out\n");
 		intel_gt_set_wedged(stream->engine->gt);
 		err = -EIO;
 		goto out_rq;
@@ -396,14 +399,16 @@ static int live_noa_gpr(void *arg)
 		if (store[i] == STACK_MAGIC)
 			continue;
 
-		pr_err("GPR[%d] lost, found:%08x, expected:%08x!\n",
-		       i, store[i], STACK_MAGIC);
+		drm_err(&i915->drm,
+			"GPR[%d] lost, found:%08x, expected:%08x!\n", i,
+			store[i], STACK_MAGIC);
 		err = -EINVAL;
 	}
 
 	/* Verify that the user's scratch page was not used for GPR storage */
 	if (memchr_inv(scratch, POISON_FREE, PAGE_SIZE)) {
-		pr_err("Scratch page overwritten!\n");
+		drm_err(&i915->drm,
+			"Scratch page overwritten!\n");
 		igt_hexdump(scratch, 4096);
 		err = -EINVAL;
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index e1a7c454a0a9..431298f774e6 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -98,49 +98,54 @@ static int igt_wait_request(void *arg)
 	i915_request_get(request);
 
 	if (i915_request_wait(request, 0, 0) != -ETIME) {
-		pr_err("request wait (busy query) succeeded (expected timeout before submit!)\n");
+		drm_err(&i915->drm,
+			"request wait (busy query) succeeded (expected timeout before submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) != -ETIME) {
-		pr_err("request wait succeeded (expected timeout before submit!)\n");
+		drm_err(&i915->drm,
+			"request wait succeeded (expected timeout before submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("request completed before submit!!\n");
+		drm_err(&i915->drm, "request completed before submit!!\n");
 		goto out_request;
 	}
 
 	i915_request_add(request);
 
 	if (i915_request_wait(request, 0, 0) != -ETIME) {
-		pr_err("request wait (busy query) succeeded (expected timeout after submit!)\n");
+		drm_err(&i915->drm,
+			"request wait (busy query) succeeded (expected timeout after submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("request completed immediately!\n");
+		drm_err(&i915->drm, "request completed immediately!\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T / 2) != -ETIME) {
-		pr_err("request wait succeeded (expected timeout!)\n");
+		drm_err(&i915->drm,
+			"request wait succeeded (expected timeout!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) == -ETIME) {
-		pr_err("request wait timed out!\n");
+		drm_err(&i915->drm, "request wait timed out!\n");
 		goto out_request;
 	}
 
 	if (!i915_request_completed(request)) {
-		pr_err("request not complete after waiting!\n");
+		drm_err(&i915->drm, "request not complete after waiting!\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) == -ETIME) {
-		pr_err("request wait timed out when already complete!\n");
+		drm_err(&i915->drm,
+			"request wait timed out when already complete!\n");
 		goto out_request;
 	}
 
@@ -165,34 +170,38 @@ static int igt_fence_wait(void *arg)
 		return PTR_ERR(request);
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) != -ETIME) {
-		pr_err("fence wait success before submit (expected timeout)!\n");
+		drm_err(&i915->drm,
+			"fence wait success before submit (expected timeout)!\n");
 		goto out;
 	}
 
 	i915_request_add(request);
 
 	if (dma_fence_is_signaled(&request->fence)) {
-		pr_err("fence signaled immediately!\n");
+		drm_err(&i915->drm, "fence signaled immediately!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T / 2) != -ETIME) {
-		pr_err("fence wait success after submit (expected timeout)!\n");
+		drm_err(&i915->drm,
+			"fence wait success after submit (expected timeout)!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) <= 0) {
-		pr_err("fence wait timed out (expected success)!\n");
+		drm_err(&i915->drm,
+			"fence wait timed out (expected success)!\n");
 		goto out;
 	}
 
 	if (!dma_fence_is_signaled(&request->fence)) {
-		pr_err("fence unsignaled after waiting!\n");
+		drm_err(&i915->drm, "fence unsignaled after waiting!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) <= 0) {
-		pr_err("fence wait timed out when complete (expected success)!\n");
+		drm_err(&i915->drm,
+			"fence wait timed out when complete (expected success)!\n");
 		goto out;
 	}
 
@@ -245,7 +254,8 @@ static int igt_request_rewind(void *arg)
 
 	/* Simulate preemption by manual reordering */
 	if (!mock_cancel_request(request)) {
-		pr_err("failed to cancel request (already executed)!\n");
+		drm_err(&i915->drm,
+			"failed to cancel request (already executed)!\n");
 		i915_request_add(vip);
 		goto err_context_1;
 	}
@@ -257,12 +267,13 @@ static int igt_request_rewind(void *arg)
 
 
 	if (i915_request_wait(vip, 0, HZ) == -ETIME) {
-		pr_err("timed out waiting for high priority request\n");
+		drm_err(&i915->drm,
+			"timed out waiting for high priority request\n");
 		goto err;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("low priority request already completed\n");
+		drm_err(&i915->drm, "low priority request already completed\n");
 		goto err;
 	}
 
@@ -313,6 +324,7 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 	struct smoke_thread *thread = container_of(work, typeof(*thread), work);
 	struct smoketest *t = thread->t;
 	const unsigned int max_batch = min(t->ncontexts, t->max_batch) - 1;
+	struct drm_i915_private *i915 = t->engine->i915;
 	const unsigned int total = 4 * t->ncontexts + 1;
 	unsigned int num_waits = 0, num_fences = 0;
 	struct i915_request **requests;
@@ -406,10 +418,11 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 					5 * HZ)) {
 			struct i915_request *rq = requests[count - 1];
 
-			pr_err("waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
-			       atomic_read(&wait->pending), count,
-			       rq->fence.context, rq->fence.seqno,
-			       t->engine->name);
+			drm_err(&i915->drm,
+				"waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
+				atomic_read(&wait->pending), count,
+				rq->fence.context, rq->fence.seqno,
+				t->engine->name);
 			GEM_TRACE_DUMP();
 
 			intel_gt_set_wedged(t->engine->gt);
@@ -423,8 +436,9 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 
 			if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
 				      &rq->fence.flags)) {
-				pr_err("%llu:%llu was not signaled!\n",
-				       rq->fence.context, rq->fence.seqno);
+				drm_err(&i915->drm,
+					"%llu:%llu was not signaled!\n",
+					rq->fence.context, rq->fence.seqno);
 				err = -EINVAL;
 			}
 
@@ -523,10 +537,10 @@ static int mock_breadcrumbs_smoketest(void *arg)
 
 		kthread_destroy_worker(threads[n].worker);
 	}
-	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
-		atomic_long_read(&t.num_waits),
-		atomic_long_read(&t.num_fences),
-		ncpus);
+	drm_info(&i915->drm,
+		 "Completed %lu waits for %lu fence across %d cpus\n",
+		 atomic_long_read(&t.num_waits),
+		 atomic_long_read(&t.num_fences), ncpus);
 
 out_contexts:
 	for (n = 0; n < t.ncontexts; n++) {
@@ -632,10 +646,10 @@ static int live_nop_request(void *arg)
 		if (err)
 			return err;
 
-		pr_info("Request latencies on %s: 1 = %lluns, %lu = %lluns\n",
-			engine->name,
-			ktime_to_ns(times[0]),
-			prime, div64_u64(ktime_to_ns(times[1]), prime));
+		drm_info(&i915->drm,
+			 "Request latencies on %s: 1 = %lluns, %lu = %lluns\n",
+			 engine->name, ktime_to_ns(times[0]), prime,
+			 div64_u64(ktime_to_ns(times[1]), prime));
 	}
 
 	return err;
@@ -643,6 +657,7 @@ static int live_nop_request(void *arg)
 
 static int __cancel_inactive(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *i915 = engine->i915;
 	struct intel_context *ce;
 	struct igt_spinner spin;
 	struct i915_request *rq;
@@ -663,7 +678,8 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling inactive request\n", engine->name);
+	drm_dbg(&i915->drm, "%s: Cancelling inactive request\n",
+		engine->name);
 	i915_request_cancel(rq, -EINTR);
 	i915_request_get(rq);
 	i915_request_add(rq);
@@ -671,15 +687,17 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel inactive request\n", engine->name);
+		drm_err(&i915->drm,
+			"%s: Failed to cancel inactive request\n",
+			engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
-		       engine->name, rq->fence.error);
+		drm_err(&i915->drm, "%s: fence not cancelled (%u)\n",
+			engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
 
@@ -690,12 +708,14 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&i915->drm, "%s: %s error %d\n", __func__,
+			engine->name, err);
 	return err;
 }
 
 static int __cancel_active(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *i915 = engine->i915;
 	struct intel_context *ce;
 	struct igt_spinner spin;
 	struct i915_request *rq;
@@ -716,13 +736,15 @@ static int __cancel_active(struct intel_engine_cs *engine)
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling active request\n", engine->name);
+	drm_dbg(&i915->drm, "%s: Cancelling active request\n",
+		engine->name);
 	i915_request_get(rq);
 	i915_request_add(rq);
 	if (!igt_wait_for_spinner(&spin, rq)) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		drm_err(&i915->drm, "Failed to start spinner on %s\n",
+			engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
@@ -732,15 +754,16 @@ static int __cancel_active(struct intel_engine_cs *engine)
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel active request\n", engine->name);
+		drm_err(&i915->drm,
+			"%s: Failed to cancel active request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
-		       engine->name, rq->fence.error);
+		drm_err(&i915->drm, "%s: fence not cancelled (%u)\n",
+			engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
 
@@ -751,12 +774,14 @@ static int __cancel_active(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&i915->drm, "%s: %s error %d\n", __func__,
+			engine->name, err);
 	return err;
 }
 
 static int __cancel_completed(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *i915 = engine->i915;
 	struct intel_context *ce;
 	struct igt_spinner spin;
 	struct i915_request *rq;
@@ -785,11 +810,12 @@ static int __cancel_completed(struct intel_engine_cs *engine)
 		goto out_rq;
 	}
 
-	pr_debug("%s: Cancelling completed request\n", engine->name);
+	drm_dbg(&i915->drm, "%s: Cancelling completed request\n",
+		engine->name);
 	i915_request_cancel(rq, -EINTR);
 	if (rq->fence.error) {
-		pr_err("%s: fence not cancelled (%u)\n",
-		       engine->name, rq->fence.error);
+		drm_err(&i915->drm, "%s: fence not cancelled (%u)\n",
+			engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
 
@@ -800,7 +826,8 @@ static int __cancel_completed(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&i915->drm, "%s: %s error %d\n", __func__,
+			engine->name, err);
 	return err;
 }
 
@@ -846,14 +873,16 @@ static int __cancel_reset(struct drm_i915_private *i915,
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling active non-preemptable request\n",
-		 engine->name);
+	drm_dbg(&i915->drm,
+		"%s: Cancelling active non-preemptable request\n",
+		engine->name);
 	i915_request_get(rq);
 	i915_request_add(rq);
 	if (!igt_wait_for_spinner(&spin, rq)) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		drm_err(&i915->drm, "Failed to start spinner on %s\n",
+			engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
@@ -870,15 +899,16 @@ static int __cancel_reset(struct drm_i915_private *i915,
 	if (i915_request_wait(rq, 0, HZ) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel hung request\n", engine->name);
+		drm_err(&i915->drm,
+			"%s: Failed to cancel hung request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_nop;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
-		       engine->name, rq->fence.error);
+		drm_err(&i915->drm, "%s: fence not cancelled (%u)\n",
+			engine->name, rq->fence.error);
 		err = -EINVAL;
 		goto out_nop;
 	}
@@ -886,15 +916,16 @@ static int __cancel_reset(struct drm_i915_private *i915,
 	if (i915_request_wait(nop, 0, HZ) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to complete nop request\n", engine->name);
+		drm_err(&i915->drm,
+			"%s: Failed to complete nop request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_nop;
 	}
 
 	if (nop->fence.error != 0) {
-		pr_err("%s: Nop request errored (%u)\n",
-		       engine->name, nop->fence.error);
+		drm_err(&i915->drm, "%s: Nop request errored (%u)\n",
+			engine->name, nop->fence.error);
 		err = -EINVAL;
 	}
 
@@ -909,7 +940,8 @@ static int __cancel_reset(struct drm_i915_private *i915,
 out_restore:
 	engine->props.preempt_timeout_ms = preempt_timeout_ms;
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__,
+			engine->name, err);
 	return err;
 }
 
@@ -1102,10 +1134,10 @@ static int live_empty_request(void *arg)
 		if (err)
 			goto out_batch;
 
-		pr_info("Batch latencies on %s: 1 = %lluns, %lu = %lluns\n",
-			engine->name,
-			ktime_to_ns(times[0]),
-			prime, div64_u64(ktime_to_ns(times[1]), prime));
+		drm_info(&i915->drm,
+			 "Batch latencies on %s: 1 = %lluns, %lu = %lluns\n",
+			 engine->name, ktime_to_ns(times[0]), prime,
+			 div64_u64(ktime_to_ns(times[1]), prime));
 out_batch:
 		i915_vma_unpin(batch);
 		i915_vma_put(batch);
@@ -1218,8 +1250,9 @@ static int live_all_engines(void *arg)
 		batch = recursive_batch(engine->gt);
 		if (IS_ERR(batch)) {
 			err = PTR_ERR(batch);
-			pr_err("%s: Unable to create batch, err=%d\n",
-			       __func__, err);
+			drm_err(&i915->drm,
+				"%s: Unable to create batch, err=%d\n",
+				__func__, err);
 			goto out_free;
 		}
 
@@ -1227,8 +1260,9 @@ static int live_all_engines(void *arg)
 		request[idx] = intel_engine_create_kernel_request(engine);
 		if (IS_ERR(request[idx])) {
 			err = PTR_ERR(request[idx]);
-			pr_err("%s: Request allocation failed with err=%d\n",
-			       __func__, err);
+			drm_err(&i915->drm,
+				"%s: Request allocation failed with err=%d\n",
+				__func__, err);
 			goto out_unlock;
 		}
 		GEM_BUG_ON(request[idx]->context->vm != batch->vm);
@@ -1252,8 +1286,9 @@ static int live_all_engines(void *arg)
 	idx = 0;
 	for_each_uabi_engine(engine, i915) {
 		if (i915_request_completed(request[idx])) {
-			pr_err("%s(%s): request completed too early!\n",
-			       __func__, engine->name);
+			drm_err(&i915->drm,
+				"%s(%s): request completed too early!\n",
+				__func__, engine->name);
 			err = -EINVAL;
 			goto out_request;
 		}
@@ -1264,8 +1299,9 @@ static int live_all_engines(void *arg)
 	for_each_uabi_engine(engine, i915) {
 		err = recursive_batch_resolve(request[idx]->batch);
 		if (err) {
-			pr_err("%s: failed to resolve batch, err=%d\n",
-			       __func__, err);
+			drm_err(&i915->drm,
+				"%s: failed to resolve batch, err=%d\n",
+				__func__, err);
 			goto out_request;
 		}
 		idx++;
@@ -1280,8 +1316,9 @@ static int live_all_engines(void *arg)
 					    MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			err = timeout;
-			pr_err("%s: error waiting for request on %s, err=%d\n",
-			       __func__, engine->name, err);
+			drm_err(&i915->drm,
+				"%s: error waiting for request on %s, err=%d\n",
+				__func__, engine->name, err);
 			goto out_request;
 		}
 
@@ -1348,8 +1385,9 @@ static int live_sequential_engines(void *arg)
 		batch = recursive_batch(engine->gt);
 		if (IS_ERR(batch)) {
 			err = PTR_ERR(batch);
-			pr_err("%s: Unable to create batch for %s, err=%d\n",
-			       __func__, engine->name, err);
+			drm_err(&i915->drm,
+				"%s: Unable to create batch for %s, err=%d\n",
+				__func__, engine->name, err);
 			goto out_free;
 		}
 
@@ -1357,8 +1395,9 @@ static int live_sequential_engines(void *arg)
 		request[idx] = intel_engine_create_kernel_request(engine);
 		if (IS_ERR(request[idx])) {
 			err = PTR_ERR(request[idx]);
-			pr_err("%s: Request allocation failed for %s with err=%d\n",
-			       __func__, engine->name, err);
+			drm_err(&i915->drm,
+				"%s: Request allocation failed for %s with err=%d\n",
+				__func__, engine->name, err);
 			goto out_unlock;
 		}
 		GEM_BUG_ON(request[idx]->context->vm != batch->vm);
@@ -1368,8 +1407,9 @@ static int live_sequential_engines(void *arg)
 							   &prev->fence);
 			if (err) {
 				i915_request_add(request[idx]);
-				pr_err("%s: Request await failed for %s with err=%d\n",
-				       __func__, engine->name, err);
+				drm_err(&i915->drm,
+					"%s: Request await failed for %s with err=%d\n",
+					__func__, engine->name, err);
 				goto out_unlock;
 			}
 		}
@@ -1398,16 +1438,18 @@ static int live_sequential_engines(void *arg)
 		long timeout;
 
 		if (i915_request_completed(request[idx])) {
-			pr_err("%s(%s): request completed too early!\n",
-			       __func__, engine->name);
+			drm_err(&i915->drm,
+				"%s(%s): request completed too early!\n",
+				__func__, engine->name);
 			err = -EINVAL;
 			goto out_request;
 		}
 
 		err = recursive_batch_resolve(request[idx]->batch);
 		if (err) {
-			pr_err("%s: failed to resolve batch, err=%d\n",
-			       __func__, err);
+			drm_err(&i915->drm,
+				"%s: failed to resolve batch, err=%d\n",
+				__func__, err);
 			goto out_request;
 		}
 
@@ -1415,8 +1457,9 @@ static int live_sequential_engines(void *arg)
 					    MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			err = timeout;
-			pr_err("%s: error waiting for request on %s, err=%d\n",
-			       __func__, engine->name, err);
+			drm_err(&i915->drm,
+				"%s: error waiting for request on %s, err=%d\n",
+				__func__, engine->name, err);
 			goto out_request;
 		}
 
@@ -1496,7 +1539,8 @@ static void __live_parallel_engine1(struct kthread_work *work)
 	} while (!__igt_timeout(end_time, NULL));
 	intel_engine_pm_put(engine);
 
-	pr_info("%s: %lu request + sync\n", engine->name, count);
+	drm_info(&engine->i915->drm, "%s: %lu request + sync\n", engine->name,
+		 count);
 	thread->result = err;
 }
 
@@ -1525,7 +1569,7 @@ static void __live_parallel_engineN(struct kthread_work *work)
 	} while (!__igt_timeout(end_time, NULL));
 	intel_engine_pm_put(engine);
 
-	pr_info("%s: %lu requests\n", engine->name, count);
+	drm_info(&engine->i915->drm, "%s: %lu requests\n", engine->name, count);
 	thread->result = err;
 }
 
@@ -1592,7 +1636,8 @@ static void __live_parallel_spin(struct kthread_work *work)
 		/* Occupy this engine for the whole test */
 		err = wait_for_all(engine->i915);
 	} else {
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n",
+			engine->name);
 		err = -EINVAL;
 	}
 	igt_spinner_end(&spin);
@@ -1798,8 +1843,8 @@ static int live_breadcrumbs_smoketest(void *arg)
 		}
 		/* One ring interleaved between requests from all cpus */
 		smoke[idx].max_batch /= ncpus + 1;
-		pr_debug("Limiting batches to %d requests on %s\n",
-			 smoke[idx].max_batch, engine->name);
+		drm_dbg(&i915->drm, "Limiting batches to %d requests on %s\n",
+			smoke[idx].max_batch, engine->name);
 
 		for (n = 0; n < ncpus; n++) {
 			unsigned int i = idx * ncpus + n;
@@ -1849,8 +1894,9 @@ static int live_breadcrumbs_smoketest(void *arg)
 		num_fences += atomic_long_read(&smoke[idx].num_fences);
 		idx++;
 	}
-	pr_info("Completed %lu waits for %lu fences across %d engines and %d cpus\n",
-		num_waits, num_fences, idx, ncpus);
+	drm_info(&i915->drm,
+		 "Completed %lu waits for %lu fences across %d engines and %d cpus\n",
+		 num_waits, num_fences, idx, ncpus);
 
 	ret = igt_live_test_end(&live) ?: ret;
 out_contexts:
@@ -2075,9 +2121,9 @@ static int measure_semaphore_response(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: semaphore response %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&ce->engine->i915->drm,
+		 "%s: semaphore response %d cycles, %lluns\n", ce->engine->name,
+		 cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2146,9 +2192,10 @@ static int measure_idle_dispatch(struct intel_context *ce)
 		elapsed[i] = sema[i] - elapsed[i];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: idle dispatch latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&ce->engine->i915->drm,
+		 "%s: idle dispatch latency %d cycles, %lluns\n",
+		 ce->engine->name, cycles >> TF_BIAS,
+		 cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2223,9 +2270,10 @@ static int measure_busy_dispatch(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: busy dispatch latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&ce->engine->i915->drm,
+		 "%s: busy dispatch latency %d cycles, %lluns\n",
+		 ce->engine->name, cycles >> TF_BIAS,
+		 cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2336,9 +2384,10 @@ static int measure_inter_request(struct intel_context *ce)
 		elapsed[i - 1] = sema[i + 1] - sema[i];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: inter-request latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&ce->engine->i915->drm,
+		 "%s: inter-request latency %d cycles, %lluns\n",
+		 ce->engine->name, cycles >> TF_BIAS,
+		 cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2431,9 +2480,10 @@ static int measure_context_switch(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 2] - sema[2 * i + 1];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: context switch latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&ce->engine->i915->drm,
+		 "%s: context switch latency %d cycles, %lluns\n",
+		 ce->engine->name, cycles >> TF_BIAS,
+		 cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2448,6 +2498,7 @@ static int measure_context_switch(struct intel_context *ce)
 static int measure_preemption(struct intel_context *ce)
 {
 	u32 *sema = hwsp_scratch(ce);
+	struct drm_i915_private *i915 = ce->engine->i915;
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT], cycles;
 	u32 *cs;
@@ -2534,17 +2585,19 @@ static int measure_preemption(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 0] - elapsed[i - 1];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: preemption dispatch latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&i915->drm,
+		 "%s: preemption dispatch latency %d cycles, %lluns\n",
+		 ce->engine->name, cycles >> TF_BIAS,
+		 cycles_to_ns(ce->engine, cycles));
 
 	for (i = 1; i <= TF_COUNT; i++)
 		elapsed[i - 1] = sema[2 * i + 1] - sema[2 * i + 0];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: preemption switch latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&i915->drm,
+		 "%s: preemption switch latency %d cycles, %lluns\n",
+		 ce->engine->name, cycles >> TF_BIAS,
+		 cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2636,9 +2689,9 @@ static int measure_completion(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: completion latency %d cycles, %lluns\n",
-		ce->engine->name, cycles >> TF_BIAS,
-		cycles_to_ns(ce->engine, cycles));
+	drm_info(&ce->engine->i915->drm,
+		 "%s: completion latency %d cycles, %lluns\n", ce->engine->name,
+		 cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles));
 
 	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
 
@@ -2929,11 +2982,12 @@ static int perf_series_engines(void *arg)
 				decimal = 0;
 			}
 
-			pr_info("%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
-				name, p->engine->name, ce->timeline->seqno,
-				integer, decimal,
-				div_u64(p->runtime, 1000 * 1000),
-				div_u64(ktime_to_ns(p->time), 1000 * 1000));
+			drm_info(&i915->drm,
+				 "%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
+				 name, p->engine->name, ce->timeline->seqno,
+				 integer, decimal,
+				 div_u64(p->runtime, 1000 * 1000),
+				 div_u64(ktime_to_ns(p->time), 1000 * 1000));
 		}
 	}
 
@@ -3275,10 +3329,11 @@ static int perf_parallel_engines(void *arg)
 			}
 
 			GEM_BUG_ON(engine != p->engine);
-			pr_info("%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
-				name, engine->name, p->count, integer, decimal,
-				div_u64(p->runtime, 1000 * 1000),
-				div_u64(ktime_to_ns(p->time), 1000 * 1000));
+			drm_info(&i915->drm,
+				 "%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
+				 name, engine->name, p->count, integer, decimal,
+				 div_u64(p->runtime, 1000 * 1000),
+				 div_u64(ktime_to_ns(p->time), 1000 * 1000));
 			idx++;
 		}
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 7c4111e60f2e..8e1e54ea0585 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -24,6 +24,8 @@
 
 #include <linux/prime_numbers.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_context.h"
 #include "gem/i915_gem_internal.h"
 #include "gem/selftests/mock_context.h"
@@ -41,19 +43,20 @@ static bool assert_vma(struct i915_vma *vma,
 	bool ok = true;
 
 	if (vma->vm != ctx->vm) {
-		pr_err("VMA created with wrong VM\n");
+		drm_err(obj->base.dev, "VMA created with wrong VM\n");
 		ok = false;
 	}
 
 	if (vma->size != obj->base.size) {
-		pr_err("VMA created with wrong size, found %llu, expected %zu\n",
-		       vma->size, obj->base.size);
+		drm_err(obj->base.dev,
+			"VMA created with wrong size, found %llu, expected %zu\n",
+			vma->size, obj->base.size);
 		ok = false;
 	}
 
 	if (vma->gtt_view.type != I915_GTT_VIEW_NORMAL) {
-		pr_err("VMA created with wrong type [%d]\n",
-		       vma->gtt_view.type);
+		drm_err(obj->base.dev, "VMA created with wrong type [%d]\n",
+			vma->gtt_view.type);
 		ok = false;
 	}
 
@@ -74,30 +77,34 @@ checked_vma_instance(struct drm_i915_gem_object *obj,
 
 	/* Manual checks, will be reinforced by i915_vma_compare! */
 	if (vma->vm != vm) {
-		pr_err("VMA's vm [%p] does not match request [%p]\n",
-		       vma->vm, vm);
+		drm_err(obj->base.dev,
+			"VMA's vm [%p] does not match request [%p]\n", vma->vm,
+			vm);
 		ok = false;
 	}
 
 	if (i915_is_ggtt(vm) != i915_vma_is_ggtt(vma)) {
-		pr_err("VMA ggtt status [%d] does not match parent [%d]\n",
-		       i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
+		drm_err(obj->base.dev,
+			"VMA ggtt status [%d] does not match parent [%d]\n",
+			i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
 		ok = false;
 	}
 
 	if (i915_vma_compare(vma, vm, view)) {
-		pr_err("i915_vma_compare failed with create parameters!\n");
+		drm_err(obj->base.dev,
+			"i915_vma_compare failed with create parameters!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (i915_vma_compare(vma, vma->vm,
 			     i915_vma_is_ggtt(vma) ? &vma->gtt_view : NULL)) {
-		pr_err("i915_vma_compare failed with itself\n");
+		drm_err(obj->base.dev, "i915_vma_compare failed with itself\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!ok) {
-		pr_err("i915_vma_compare failed to detect the difference!\n");
+		drm_err(obj->base.dev,
+			"i915_vma_compare failed to detect the difference!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -126,14 +133,16 @@ static int create_vmas(struct drm_i915_private *i915,
 					return PTR_ERR(vma);
 
 				if (!assert_vma(vma, obj, ctx)) {
-					pr_err("VMA lookup/create failed\n");
+					drm_err(obj->base.dev,
+						"VMA lookup/create failed\n");
 					return -EINVAL;
 				}
 
 				if (!pinned) {
 					err = i915_vma_pin(vma, 0, 0, PIN_USER);
 					if (err) {
-						pr_err("Failed to pin VMA\n");
+						drm_err(obj->base.dev,
+							"Failed to pin VMA\n");
 						return err;
 					}
 				} else {
@@ -332,10 +341,13 @@ static int igt_vma_pin1(void *arg)
 	for (m = modes; m->assert; m++) {
 		err = i915_vma_pin(vma, m->size, 0, m->flags);
 		if (!m->assert(vma, m, err)) {
-			pr_err("%s to pin single page into GGTT with mode[%d:%s]: size=%llx flags=%llx, err=%d\n",
-			       m->assert == assert_pin_valid ? "Failed" : "Unexpectedly succeeded",
-			       (int)(m - modes), m->string, m->size, m->flags,
-			       err);
+			drm_err(obj->base.dev,
+				"%s to pin single page into GGTT with mode[%d:%s]: size=%llx flags=%llx, err=%d\n",
+				m->assert == assert_pin_valid ?
+					"Failed" :
+					"Unexpectedly succeeded",
+				(int)(m - modes), m->string, m->size, m->flags,
+				err);
 			if (!err)
 				i915_vma_unpin(vma);
 			err = -EINVAL;
@@ -346,7 +358,9 @@ static int igt_vma_pin1(void *arg)
 			i915_vma_unpin(vma);
 			err = i915_vma_unbind_unlocked(vma);
 			if (err) {
-				pr_err("Failed to unbind single page from GGTT, err=%d\n", err);
+				drm_err(obj->base.dev,
+					"Failed to unbind single page from GGTT, err=%d\n",
+					err);
 				goto out;
 			}
 		}
@@ -384,8 +398,9 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			dma_addr_t src;
 
 			if (!sg) {
-				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
-				       n, x, y);
+				drm_err(obj->base.dev,
+					"Invalid sg table: too short at plane %d, (%d, %d)!\n",
+					n, x, y);
 				return ERR_PTR(-EINVAL);
 			}
 
@@ -393,15 +408,17 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			src = i915_gem_object_get_dma_address(obj, src_idx);
 
 			if (sg_dma_len(sg) != PAGE_SIZE) {
-				pr_err("Invalid sg.length, found %d, expected %lu for rotated page (%d, %d) [src index %lu]\n",
-				       sg_dma_len(sg), PAGE_SIZE,
-				       x, y, src_idx);
+				drm_err(obj->base.dev,
+					"Invalid sg.length, found %d, expected %lu for rotated page (%d, %d) [src index %lu]\n",
+					sg_dma_len(sg), PAGE_SIZE, x, y,
+					src_idx);
 				return ERR_PTR(-EINVAL);
 			}
 
 			if (sg_dma_address(sg) != src) {
-				pr_err("Invalid address for rotated page (%d, %d) [src index %lu]\n",
-				       x, y, src_idx);
+				drm_err(obj->base.dev,
+					"Invalid address for rotated page (%d, %d) [src index %lu]\n",
+					x, y, src_idx);
 				return ERR_PTR(-EINVAL);
 			}
 
@@ -414,20 +431,23 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			continue;
 
 		if (!sg) {
-			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
-			       n, x, y);
+			drm_err(obj->base.dev,
+				"Invalid sg table: too short at plane %d, (%d, %d)!\n",
+				n, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_len(sg) != left) {
-			pr_err("Invalid sg.length, found %d, expected %u for rotated page (%d, %d)\n",
-			       sg_dma_len(sg), left, x, y);
+			drm_err(obj->base.dev,
+				"Invalid sg.length, found %d, expected %u for rotated page (%d, %d)\n",
+				sg_dma_len(sg), left, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_address(sg) != 0) {
-			pr_err("Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
-			       &sg_dma_address(sg), x, y);
+			drm_err(obj->base.dev,
+				"Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
+				&sg_dma_address(sg), x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -461,8 +481,9 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			dma_addr_t src;
 
 			if (!sg) {
-				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
-				       n, x, y);
+				drm_err(obj->base.dev,
+					"Invalid sg table: too short at plane %d, (%d, %d)!\n",
+					n, x, y);
 				return ERR_PTR(-EINVAL);
 			}
 			if (!left) {
@@ -474,15 +495,17 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			src = i915_gem_object_get_dma_address(obj, src_idx);
 
 			if (left < PAGE_SIZE || left & (PAGE_SIZE-1)) {
-				pr_err("Invalid sg.length, found %d, expected %lu for remapped page (%d, %d) [src index %lu]\n",
-				       sg_dma_len(sg), PAGE_SIZE,
-				       x, y, src_idx);
+				drm_err(obj->base.dev,
+					"Invalid sg.length, found %d, expected %lu for remapped page (%d, %d) [src index %lu]\n",
+					sg_dma_len(sg), PAGE_SIZE, x, y,
+					src_idx);
 				return ERR_PTR(-EINVAL);
 			}
 
 			if (sg_dma_address(sg) + offset != src) {
-				pr_err("Invalid address for remapped page (%d, %d) [src index %lu]\n",
-				       x, y, src_idx);
+				drm_err(obj->base.dev,
+					"Invalid address for remapped page (%d, %d) [src index %lu]\n",
+					x, y, src_idx);
 				return ERR_PTR(-EINVAL);
 			}
 
@@ -495,9 +518,9 @@ assert_remapped(struct drm_i915_gem_object *obj,
 		}
 
 		if (left) {
-			pr_err("Unexpected sg tail with %d size for remapped page (%d, %d)\n",
-			       left,
-			       x, y);
+			drm_err(obj->base.dev,
+				"Unexpected sg tail with %d size for remapped page (%d, %d)\n",
+				left, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -507,22 +530,23 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			continue;
 
 		if (!sg) {
-			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
-			       n, x, y);
+			drm_err(obj->base.dev,
+				"Invalid sg table: too short at plane %d, (%d, %d)!\n",
+				n, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_len(sg) != left) {
-			pr_err("Invalid sg.length, found %u, expected %u for remapped page (%d, %d)\n",
-			       sg_dma_len(sg), left,
-			       x, y);
+			drm_err(obj->base.dev,
+				"Invalid sg.length, found %u, expected %u for remapped page (%d, %d)\n",
+				sg_dma_len(sg), left, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_address(sg) != 0) {
-			pr_err("Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
-			       &sg_dma_address(sg),
-			       x, y);
+			drm_err(obj->base.dev,
+				"Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
+				&sg_dma_address(sg), x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -628,7 +652,9 @@ static int igt_vma_rotate_remap(void *arg)
 
 					err = i915_vma_pin(vma, 0, 0, PIN_GLOBAL);
 					if (err) {
-						pr_err("Failed to pin VMA, err=%d\n", err);
+						drm_err(obj->base.dev,
+							"Failed to pin VMA, err=%d\n",
+							err);
 						goto out_object;
 					}
 
@@ -636,36 +662,47 @@ static int igt_vma_rotate_remap(void *arg)
 
 					if (view.type == I915_GTT_VIEW_ROTATED &&
 					    vma->size != expected_pages * PAGE_SIZE) {
-						pr_err("VMA is wrong size, expected %lu, found %llu\n",
-						       PAGE_SIZE * expected_pages, vma->size);
+						drm_err(obj->base.dev,
+							"VMA is wrong size, expected %lu, found %llu\n",
+							PAGE_SIZE *
+								expected_pages,
+							vma->size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (view.type == I915_GTT_VIEW_REMAPPED &&
 					    vma->size > expected_pages * PAGE_SIZE) {
-						pr_err("VMA is wrong size, expected %lu, found %llu\n",
-						       PAGE_SIZE * expected_pages, vma->size);
+						drm_err(obj->base.dev,
+							"VMA is wrong size, expected %lu, found %llu\n",
+							PAGE_SIZE *
+								expected_pages,
+							vma->size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->pages->nents > expected_pages) {
-						pr_err("sg table is wrong sizeo, expected %u, found %u nents\n",
-						       expected_pages, vma->pages->nents);
+						drm_err(obj->base.dev,
+							"sg table is wrong sizeo, expected %u, found %u nents\n",
+							expected_pages,
+							vma->pages->nents);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->node.size < vma->size) {
-						pr_err("VMA binding too small, expected %llu, found %llu\n",
-						       vma->size, vma->node.size);
+						drm_err(obj->base.dev,
+							"VMA binding too small, expected %llu, found %llu\n",
+							vma->size,
+							vma->node.size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->pages == obj->mm.pages) {
-						pr_err("VMA using unrotated object pages!\n");
+						drm_err(obj->base.dev,
+							"VMA using unrotated object pages!\n");
 						err = -EINVAL;
 						goto out_object;
 					}
@@ -677,19 +714,20 @@ static int igt_vma_rotate_remap(void *arg)
 						else
 							sg = assert_remapped(obj, &view.remapped, n, sg);
 						if (IS_ERR(sg)) {
-							pr_err("Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %d, %d), (%d, %d, %d, %d, %d)]\n",
-							       view.type == I915_GTT_VIEW_ROTATED ?
-							       "rotated" : "remapped", n,
-							       plane_info[0].width,
-							       plane_info[0].height,
-							       plane_info[0].src_stride,
-							       plane_info[0].dst_stride,
-							       plane_info[0].offset,
-							       plane_info[1].width,
-							       plane_info[1].height,
-							       plane_info[1].src_stride,
-							       plane_info[1].dst_stride,
-							       plane_info[1].offset);
+							drm_err(obj->base.dev,
+								"Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %d, %d), (%d, %d, %d, %d, %d)]\n",
+								view.type == I915_GTT_VIEW_ROTATED ?
+								"rotated" : "remapped", n,
+								plane_info[0].width,
+								plane_info[0].height,
+								plane_info[0].src_stride,
+								plane_info[0].dst_stride,
+								plane_info[0].offset,
+								plane_info[1].width,
+								plane_info[1].height,
+								plane_info[1].src_stride,
+								plane_info[1].dst_stride,
+								plane_info[1].offset);
 							err = -EINVAL;
 							goto out_object;
 						}
@@ -698,7 +736,9 @@ static int igt_vma_rotate_remap(void *arg)
 					i915_vma_unpin(vma);
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("Unbinding returned %i\n", err);
+						drm_err(obj->base.dev,
+							"Unbinding returned %i\n",
+							err);
 						goto out_object;
 					}
 					cond_resched();
@@ -726,14 +766,16 @@ static bool assert_partial(struct drm_i915_gem_object *obj,
 		dma_addr_t src;
 
 		if (!size) {
-			pr_err("Partial scattergather list too long\n");
+			drm_err(obj->base.dev,
+				"Partial scattergather list too long\n");
 			return false;
 		}
 
 		src = i915_gem_object_get_dma_address(obj, offset);
 		if (src != dma) {
-			pr_err("DMA mismatch for partial page offset %lu\n",
-			       offset);
+			drm_err(obj->base.dev,
+				"DMA mismatch for partial page offset %lu\n",
+				offset);
 			return false;
 		}
 
@@ -752,38 +794,43 @@ static bool assert_pin(struct i915_vma *vma,
 	bool ok = true;
 
 	if (vma->size != size) {
-		pr_err("(%s) VMA is wrong size, expected %llu, found %llu\n",
-		       name, size, vma->size);
+		drm_err(vma->obj->base.dev,
+			"(%s) VMA is wrong size, expected %llu, found %llu\n",
+			name, size, vma->size);
 		ok = false;
 	}
 
 	if (vma->node.size < vma->size) {
-		pr_err("(%s) VMA binding too small, expected %llu, found %llu\n",
-		       name, vma->size, vma->node.size);
+		drm_err(vma->obj->base.dev,
+			"(%s) VMA binding too small, expected %llu, found %llu\n",
+			name, vma->size, vma->node.size);
 		ok = false;
 	}
 
 	if (view && view->type != I915_GTT_VIEW_NORMAL) {
 		if (memcmp(&vma->gtt_view, view, sizeof(*view))) {
-			pr_err("(%s) VMA mismatch upon creation!\n",
-			       name);
+			drm_err(vma->obj->base.dev,
+				"(%s) VMA mismatch upon creation!\n", name);
 			ok = false;
 		}
 
 		if (vma->pages == vma->obj->mm.pages) {
-			pr_err("(%s) VMA using original object pages!\n",
-			       name);
+			drm_err(vma->obj->base.dev,
+				"(%s) VMA using original object pages!\n",
+				name);
 			ok = false;
 		}
 	} else {
 		if (vma->gtt_view.type != I915_GTT_VIEW_NORMAL) {
-			pr_err("Not the normal ggtt view! Found %d\n",
-			       vma->gtt_view.type);
+			drm_err(vma->obj->base.dev,
+				"Not the normal ggtt view! Found %d\n",
+				vma->gtt_view.type);
 			ok = false;
 		}
 
 		if (vma->pages != vma->obj->mm.pages) {
-			pr_err("VMA not using object pages!\n");
+			drm_err(vma->obj->base.dev,
+				"VMA not using object pages!\n");
 			ok = false;
 		}
 	}
@@ -843,15 +890,17 @@ static int igt_vma_partial(void *arg)
 					goto out_object;
 
 				if (!assert_pin(vma, &view, sz*PAGE_SIZE, p->name)) {
-					pr_err("(%s) Inconsistent partial pinning for (offset=%d, size=%d)\n",
-					       p->name, offset, sz);
+					drm_err(obj->base.dev,
+						"(%s) Inconsistent partial pinning for (offset=%d, size=%d)\n",
+						p->name, offset, sz);
 					err = -EINVAL;
 					goto out_object;
 				}
 
 				if (!assert_partial(obj, vma, offset, sz)) {
-					pr_err("(%s) Inconsistent partial pages for (offset=%d, size=%d)\n",
-					       p->name, offset, sz);
+					drm_err(obj->base.dev,
+						"(%s) Inconsistent partial pages for (offset=%d, size=%d)\n",
+						p->name, offset, sz);
 					err = -EINVAL;
 					goto out_object;
 				}
@@ -860,7 +909,8 @@ static int igt_vma_partial(void *arg)
 				nvma++;
 				err = i915_vma_unbind_unlocked(vma);
 				if (err) {
-					pr_err("Unbinding returned %i\n", err);
+					drm_err(obj->base.dev,
+						"Unbinding returned %i\n", err);
 					goto out_object;
 				}
 
@@ -872,8 +922,9 @@ static int igt_vma_partial(void *arg)
 		list_for_each_entry(vma, &obj->vma.list, obj_link)
 			count++;
 		if (count != nvma) {
-			pr_err("(%s) All partial vma were not recorded on the obj->vma_list: found %u, expected %u\n",
-			       p->name, count, nvma);
+			drm_err(obj->base.dev,
+				"(%s) All partial vma were not recorded on the obj->vma_list: found %u, expected %u\n",
+				p->name, count, nvma);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -890,7 +941,8 @@ static int igt_vma_partial(void *arg)
 			goto out_object;
 
 		if (!assert_pin(vma, NULL, obj->base.size, p->name)) {
-			pr_err("(%s) inconsistent full pin\n", p->name);
+			drm_err(obj->base.dev, "(%s) inconsistent full pin\n",
+				p->name);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -899,7 +951,7 @@ static int igt_vma_partial(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("Unbinding returned %i\n", err);
+			drm_err(obj->base.dev, "Unbinding returned %i\n", err);
 			goto out_object;
 		}
 
@@ -907,7 +959,8 @@ static int igt_vma_partial(void *arg)
 		list_for_each_entry(vma, &obj->vma.list, obj_link)
 			count++;
 		if (count != nvma) {
-			pr_err("(%s) allocated an extra full vma!\n", p->name);
+			drm_err(obj->base.dev,
+				"(%s) allocated an extra full vma!\n", p->name);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -1080,9 +1133,11 @@ static int igt_vma_remapped_gtt(void *arg)
 
 					val = ioread32(&map[offset / sizeof(*map)]);
 					if (val != exp) {
-						pr_err("%s VMA write test failed, expected 0x%x, found 0x%x\n",
-						       *t == I915_GTT_VIEW_ROTATED ? "Rotated" : "Remapped",
-						       exp, val);
+						drm_err(vma->obj->base.dev,
+							"%s VMA write test failed, expected 0x%x, found 0x%x\n",
+							*t == I915_GTT_VIEW_ROTATED ?
+							"Rotated" : "Remapped",
+							exp, val);
 						i915_vma_unpin_iomap(vma);
 						err = -EINVAL;
 						goto out;
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index 514d2200751b..1f58024150fa 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -26,9 +26,12 @@
 
 #include "gt/intel_gt.h"
 
+#include <drm/drm_print.h>
+
 static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
 				unsigned int num_ranges,
-				bool is_watertight)
+				bool is_watertight,
+				const struct drm_device *drm)
 {
 	unsigned int i;
 	s32 prev;
@@ -36,22 +39,22 @@ static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
 	for (i = 0, prev = -1; i < num_ranges; i++, ranges++) {
 		/* Check that the table is watertight */
 		if (is_watertight && (prev + 1) != (s32)ranges->start) {
-			pr_err("%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
-			       __func__, i, ranges->start, ranges->end, prev);
+			drm_err(drm, "%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
+				__func__, i, ranges->start, ranges->end, prev);
 			return -EINVAL;
 		}
 
 		/* Check that the table never goes backwards */
 		if (prev >= (s32)ranges->start) {
-			pr_err("%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
-			       __func__, i, ranges->start, ranges->end, prev);
+			drm_err(drm, "%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
+				__func__, i, ranges->start, ranges->end, prev);
 			return -EINVAL;
 		}
 
 		/* Check that the entry is valid */
 		if (ranges->start >= ranges->end) {
-			pr_err("%s: entry[%d]:(%x, %x) has negative length\n",
-			       __func__, i, ranges->start, ranges->end);
+			drm_err(drm, "%s: entry[%d]:(%x, %x) has negative length\n",
+				__func__, i, ranges->start, ranges->end);
 			return -EINVAL;
 		}
 
@@ -126,7 +129,8 @@ int intel_uncore_mock_selftests(void)
 	for (i = 0; i < ARRAY_SIZE(fw); i++) {
 		err = intel_fw_table_check(fw[i].ranges,
 					   fw[i].num_ranges,
-					   fw[i].is_watertight);
+					   fw[i].is_watertight,
+					   NULL);
 		if (err)
 			return err;
 	}
@@ -161,6 +165,7 @@ static int live_forcewake_ops(void *arg)
 	const struct reg *r;
 	struct intel_gt *gt = arg;
 	struct intel_uncore_forcewake_domain *domain;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_uncore *uncore = gt->uncore;
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
@@ -172,7 +177,7 @@ static int live_forcewake_ops(void *arg)
 
 	/* vlv/chv with their pcu behave differently wrt reads */
 	if (IS_VALLEYVIEW(gt->i915) || IS_CHERRYVIEW(gt->i915)) {
-		pr_debug("PCU fakes forcewake badly; skipping\n");
+		drm_dbg(&i915->drm, "PCU fakes forcewake badly; skipping\n");
 		return 0;
 	}
 
@@ -192,8 +197,8 @@ static int live_forcewake_ops(void *arg)
 		if (IS_GRAPHICS_VER(gt->i915, r->min_graphics_ver, r->max_graphics_ver))
 			break;
 	if (!r->name) {
-		pr_debug("Forcewaked register not known for %s; skipping\n",
-			 intel_platform_name(INTEL_INFO(gt->i915)->platform));
+		drm_dbg(&i915->drm, "Forcewaked register not known for %s; skipping\n",
+			intel_platform_name(INTEL_INFO(gt->i915)->platform));
 		return 0;
 	}
 
@@ -225,8 +230,8 @@ static int live_forcewake_ops(void *arg)
 			if (!domain->wake_count)
 				continue;
 
-			pr_err("fw_domain %s still active, aborting test!\n",
-			       intel_uncore_forcewake_domain_to_str(domain->id));
+			drm_err(&i915->drm, "fw_domain %s still active, aborting test!\n",
+				intel_uncore_forcewake_domain_to_str(domain->id));
 			err = -EINVAL;
 			goto out_rpm;
 		}
@@ -245,23 +250,24 @@ static int live_forcewake_ops(void *arg)
 			err = wait_ack_clear(domain, FORCEWAKE_KERNEL);
 			preempt_enable();
 			if (err) {
-				pr_err("Failed to clear fw_domain %s\n",
-				       intel_uncore_forcewake_domain_to_str(domain->id));
+				drm_err(&i915->drm, "Failed to clear fw_domain %s\n",
+					intel_uncore_forcewake_domain_to_str(domain->id));
 				goto out_rpm;
 			}
 		}
 
 		if (!val) {
-			pr_err("%s:%s was zero while fw was held!\n",
-			       engine->name, r->name);
+			drm_err(&i915->drm, "%s:%s was zero while fw was held!\n",
+				engine->name, r->name);
 			err = -EINVAL;
 			goto out_rpm;
 		}
 
 		/* We then expect the read to return 0 outside of the fw */
 		if (wait_for(readl(reg) == 0, 100)) {
-			pr_err("%s:%s=%0x, fw_domains 0x%x still up after 100ms!\n",
-			       engine->name, r->name, readl(reg), fw_domains);
+			drm_err(&i915->drm,
+				"%s:%s=%0x, fw_domains 0x%x still up after 100ms!\n",
+				engine->name, r->name, readl(reg), fw_domains);
 			err = -ETIMEDOUT;
 			goto out_rpm;
 		}
@@ -279,7 +285,8 @@ static int live_fw_table(void *arg)
 	/* Confirm the table we load is still valid */
 	return intel_fw_table_check(gt->uncore->fw_domains_table,
 				    gt->uncore->fw_domains_table_entries,
-				    GRAPHICS_VER(gt->i915) >= 9);
+				    GRAPHICS_VER(gt->i915) >= 9,
+				    &gt->i915->drm);
 }
 
 int intel_uncore_live_selftests(struct drm_i915_private *i915)
-- 
2.34.1

