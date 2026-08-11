Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F8C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA61C10EBC0;
	Tue, 11 Aug 2026 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GHEEf7oh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356A110E80D;
 Tue, 11 Aug 2026 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455199; x=1817991199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=nOVkDt2tkC2lAtMXmcpDU+ptuDnPJw/MtTSaF+S6N70=;
 b=GHEEf7ohS2Yld6FvMXQeLEHOXQrnFHIGD1daZIyXcTShI8EaV1QobsxM
 t3q2r00ols/TkKPILMnVvrKgjfW+AqL49lNuwoblvKkr0m5+3Dh39vUpB
 vUaZPM4hY6DfMm3iCDm8lXLgsGWCeVj6+URhyWP7tRgOtD8c8GDC9n61H
 dTWm8x3sobROaVUiaylXkMBnueU3QS/Vd/Te//GvZ4iwSuF/URIMFkQuO
 n+7k6mvhxnDYa/OeVqqtMTR79lcYcN2/6it9xGw8RAXzT2LGyxTe4FvXJ
 Vh+EarAeYDcBXVP/tM8OlYqktpXGRjwQYTJ/PEMwjkUEl42cDcqGA4115 w==;
X-CSE-ConnectionGUID: NHO8AS3iRXqkyBHyJXGqXg==
X-CSE-MsgGUID: 6+ePOBilRAWOdzelehoC+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104374860"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="104374860"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:19 -0700
X-CSE-ConnectionGUID: K8HeStQeSoaAqIdo+Xxu5Q==
X-CSE-MsgGUID: 5zvTTowvQAuo5cysiU3WxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="267187696"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6BTR3Hpl0H7Uqg8rQ5fMPmGczq5fSOerxu8AVz+d/rE8MQ9d+/4BgQhHfQb+DLZe7bvUmRyRcJP9C8xxSwYyVhRF2xnxnRDKWgeMQL4jiD0R+NPdYCA8qYuPFyyL8R9gox4EB4+SvVkTNWFeH6nCgSEwlsWqgzKRatAyOVSZw9xrissYjo+lYeEYIBI0pNld5HVA00+FPPCOgtTawacVA9Qdnvv2lLusi4fyaxmckf6xHH5aj6hIvPDitOjdxrlN1YJaZDw8UpSeoRhEhm8rySldDXneYMQaPQ98XO8AkBZ1xu8EgZSb2MEknLXWOq0PU233r1/E8HNI0tFngNC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yz4Bni2PG8LbuCKCtfMWyt67zIVT8H+HxetgKs4g10=;
 b=fzr7bkoOSFnkDPWXfMZMKt4Bjaae9C4FUu/XEl6N1pq513ClWXTaqfDh4V/WS9fheE5WCPlsMEd0Cpp1qAsDwnifJsctDfit6tJznaTwE4sRTCffc7NFxuFeU5+mQOHHNwbxeF4DAD9oMdqjiT9V48Ps8ClZCkhN6jza3liewkd144j1pipAKqQUbOhN2QrkRidD3zXGvnYx82Wsoe1dW6hHy2qNTaivfeeVAd71lQaHklccm6no3Kwi0qqPabCLvw0nkBT3Vg0hAdpEQjMvI8DBYLxWyxwdv7koETjElQL0dLfGbVSS50gmOlKKTzVyy4gKOrSFmYeMsRat6d3X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 13:33:12 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:12 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 2/7] drm/i915/selftests: Use drm_* prints in live selftests
Date: Tue, 11 Aug 2026 13:32:52 +0000
Message-ID: <20260811133257.1133097-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811133257.1133097-1-krzysztof.karas@intel.com>
References: <20260811133257.1133097-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::20) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce9fdb6-7352-4efc-0273-08def7ad16fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: A1cxy7Y5vwxwlMLL1NCY+MyE5Jx0sf4p8LQZUyW6Iulc6jf41K4QnyWHJSKA0QCJomqBjzEHObvlMqPKIpTbMxc4Ik88bcfyz3Nsl3ZhBrTJl+H5DVFDz38fvXmB4wdDWN2eYA3W3C1nVsiekabf3Dp2tBAfzyNEa1W9RbgJyeyAV/x/V/rGjEiLv+SzaZDl6CTLXaGqI1l/RKwMtGNtTSPEFO5cqwDMn4lkTa5NX3hDqqIwJQPrY+u9damM2ffYhXELAjQH02Ysn+h6uKDwrtlAhy12r1EpzhPfdzcAFZfRocUpSJKTeGuOCHhyTYPw4TRCeTSnYIq7hfwbgJtP3IXVf38GQBJxJzLl/R4XF7aAJRqavdhndYt9zfcUEIloqJzq4V20DyDNfucsIrnGr11XLE/smC2EhgKPC4idAYkmoN7N/Bf/HCT8gVyf69mIQ+oTNizbsTZw4lWcI5oajRsBg88mYx2xlpABOR+KsN6QIdmB+p5A41lZd2q09m7ERKDenBMVvPZIZBfwUlt3RyNw0FpW4tENExWf6GlSQ5S7SwCaYZFLRDEoSOEgj9YcAuHlIQ3zgletKuSF8k9I1wMp9HuLpP2nHwNM9En90XXfUPSkvmTsBTyi4l6F8LfzGfhbxdiRqUPJdyBUcK+yAmSD1UxINX3lKPhECE4BmFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HoMyvfZd1jMe4iiqr6FsBcIdzwAkWYRh51z1Lqslz/jaLVVqFV63q0O5lGg?=
 =?us-ascii?Q?m3GS8Ozzhv74FYsuKBbyNnwGnDJkia+kEoJhL9nOm7Ax/6ifPmL7dVWpL937?=
 =?us-ascii?Q?Zxu5NgsYnF6frWKpqA0jiJuBJfy1L3JClMciAE/SY3VONQrnslD46d8IQMmK?=
 =?us-ascii?Q?WS15KEVUlyDctc/p1fqu0yNJwYwmBrisTTlg4mZSP6KwX3DLwoNKyYPMLTUf?=
 =?us-ascii?Q?Y/n0sKkiFibhf05BA+F/T14hrJaZuCHq14YTGrTJ4jIooEFrIFFMrvsYCYl5?=
 =?us-ascii?Q?NxY1nv8Oh4MBEzLiF9Qm38vMXlfKXcP9PqU6hpiNkf55GZn2wneRp7HgN/SV?=
 =?us-ascii?Q?4/BIkoWFeze4GqJKLGqamQ29NOaUBJYOoLxztYMHj9CTqSFotASD5wldwn0M?=
 =?us-ascii?Q?U/NJy9eH12JMRK3vU4mMZg3Bygwl1Yqf1v2DGuRGyRFOu1Vzf8c8W0DHtdCr?=
 =?us-ascii?Q?+9Bf0bEy3MKJwIRvMxc7cn5Cmh0qPcs8UNNbP1Bu1YIs749Jaspz3Yu+1ZS4?=
 =?us-ascii?Q?U3/bSyzeAQY81KwhcFTC16pKT4yU2Fwct62SK4QyFS0qlwKc/i1QfYMdPmln?=
 =?us-ascii?Q?uvY23w/O1W8arI7iFvmQ3FOGV8qHcs1GgSc6adrbvXMI/4S+L1lacrw6+191?=
 =?us-ascii?Q?5QsKsvro7aNBQP0VgInufesSdF/tWH9pLKxboiuzj/ToRlYcOL4OkoKj4/4D?=
 =?us-ascii?Q?LMBUY2YYp0AIKyR3qdn8dDT2MwroCC0mr+7McHH60tt8qCW9MFywBDQ9E0ZK?=
 =?us-ascii?Q?1iWFsgQxWaflIXRb8Q8n2yOny3g16+ZZePPbrNJQVCNWAginz8BGRD/ZRvyd?=
 =?us-ascii?Q?aWKMcQjYg4v6fLdyUHlQ7NBBTQDCFSQjzo5M9mIQoopsdn/XCIkeSODNrTEf?=
 =?us-ascii?Q?12+4YLm/90nIEZ68ZcFMKf3Zr6hZ5pKn+H0j3o6/MEvtfEJZSpv2i+ecvPFp?=
 =?us-ascii?Q?ZPgO+DWa59H/3uJGRU/fUNheK6Fq1VCylU5h5fpgZ7h4loKlNkxYP4Zdhb/U?=
 =?us-ascii?Q?oXClMJIuF5YgmT+bSmAPEBaOXK+fiRk82bNs8SZ8j4Vc3Kq2HpOKuMVHJO/w?=
 =?us-ascii?Q?kSYw7TWrhpJ8xl1Ae7i7VKC6UjgxSwGDCT7MWtZCgrKVLFYkP/QMpsQzO/O3?=
 =?us-ascii?Q?DL7yNSwt05B2aRwyPqS6I31nmT370e8maDWR7TFe62S6sFD+VmyZN+5TSivQ?=
 =?us-ascii?Q?3e0BbyQP60xeNGASE2zeSHWpBlTsRWxckb68w5XoTB5ZFyFGegAB+tIUXGOU?=
 =?us-ascii?Q?V+FEy53McIUsDjR/UNTlpjWTfX8jjOHbb0fGEMOsddYdzJansgO12egyj3b0?=
 =?us-ascii?Q?02GfRFadzv901iAOZs246XcGGBkcQxmzpAqOPasfm7CM+l6GJx/+oMXHXB6B?=
 =?us-ascii?Q?WpbeuUOpZCFU31RRWpT9Sld7cVP5qSL1zNcL4eprv31tKU5NIze4qCkav/Qd?=
 =?us-ascii?Q?WvMU7XeEHebIGbGL9a95ngab2mDRwdQMz6/wzgWF6oI9yIFTQpkQ5SKmttjJ?=
 =?us-ascii?Q?7s5Jfy5XNbrmROczIbDoga5Nd71qVmbNsRNd7ahkj43bMP5GMQB+6uMpJmLx?=
 =?us-ascii?Q?IxhNUioIrAwExw61a8dYEaHOpM74QW0p+4BhNJG8yF1YSpvK3l8tZ4P6SACM?=
 =?us-ascii?Q?7FsZfBeVJ8AJHJvA2qjQnKtHHzMlp4oJECar1jrWg0imtbf+sfOaGEBldgV9?=
 =?us-ascii?Q?LMcrn9PGxdTX7sapJ/60GdeOTRgdwRRKrABbugZwsa2Tw2bl52n84krvw83+?=
 =?us-ascii?Q?xKq4ouYcQFWqPMNNgv4c/CEJfuiYntc=3D?=
X-Exchange-RoutingPolicyChecked: LLt2NSGeEe4uEeeJoHNv//V9n+tWXGrDQHfDy1n0za6YhHCakW6Oxs2DEraCFrnzE5sk38SeHwjWQIdjroNYUsBIAae0kaWE2514Ts9PLyW19n229AKYm2/Vqdow36fiTf4GkD2xe70iiOu7KZ3ov5Y1eByqnMoVKWru9Vfufcvqw4QQJBPMolRPj5un9DJwsXbbFLgwJDbShHwzBdamOU0fzaxkOUq0bpd/Ejv8DrKiXrBHUsY8pZ34yAagMaY6sJsDhovyn2dcx79FjB58YQV6dpuBycYEXabt5mXkLx64xpCHBZKyeS1QiewcdheZ98mXeCZQJsK50SVTFMJfUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce9fdb6-7352-4efc-0273-08def7ad16fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:12.3996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Giz+Nph+xr0p5SMW6+ib8VyvJM+cBPKOvEjGPU8Xg1Z3gnKmgBFMCsWTpJjg1FBotY5I8H3d0TBZu1fAU8s+zILDUAbGp4wcHxk+F2x5KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
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

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  69 +++---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 198 ++++++++-------
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
 drivers/gpu/drm/i915/selftests/i915_request.c | 144 +++++------
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 225 ++++++++++--------
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  89 ++++---
 6 files changed, 434 insertions(+), 321 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 718cddde7e73..a70168d46d49 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -29,6 +29,8 @@
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_print.h"
 
+#include <drm/drm_print.h>
+
 #include "i915_selftest.h"
 
 #include "igt_flush_test.h"
@@ -71,11 +73,11 @@ static int populate_ggtt(struct i915_ggtt *ggtt, struct list_head *objects)
 		quirk_add(obj, objects);
 		count++;
 	} while (1);
-	pr_debug("Filled GGTT with %lu pages [%llu total]\n",
-		 count, ggtt->vm.total / PAGE_SIZE);
+	drm_dbg(&ggtt->vm.i915->drm, "Filled GGTT with %lu pages [%llu total]\n",
+		count, ggtt->vm.total / PAGE_SIZE);
 
 	if (list_empty(&ggtt->vm.bound_list)) {
-		pr_err("No objects on the GGTT inactive list!\n");
+		drm_err(&ggtt->vm.i915->drm, "No objects on the GGTT inactive list!\n");
 		return -EINVAL;
 	}
 
@@ -125,8 +127,9 @@ static int igt_evict_something(void *arg)
 				       0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err != -ENOSPC) {
-		pr_err("i915_gem_evict_something failed on a full GGTT with err=%d\n",
-		       err);
+		drm_err(&gt->i915->drm,
+			"i915_gem_evict_something failed on a full GGTT with err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -140,8 +143,9 @@ static int igt_evict_something(void *arg)
 				       0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_something failed on a full GGTT with err=%d\n",
-		       err);
+		drm_err(&gt->i915->drm,
+			"i915_gem_evict_something failed on a full GGTT with err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -177,7 +181,9 @@ static int igt_overcommit(void *arg)
 
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0, 0);
 	if (vma != ERR_PTR(-ENOSPC)) {
-		pr_err("Failed to evict+insert, i915_gem_object_ggtt_pin returned err=%d\n", (int)PTR_ERR_OR_ZERO(vma));
+		drm_err(&gt->i915->drm,
+			"Failed to evict+insert, i915_gem_object_ggtt_pin returned err=%d\n",
+			(int)PTR_ERR_OR_ZERO(vma));
 		err = -EINVAL;
 		goto cleanup;
 	}
@@ -209,8 +215,9 @@ static int igt_evict_for_vma(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err != -ENOSPC) {
-		pr_err("i915_gem_evict_for_node on a full GGTT returned err=%d\n",
-		       err);
+		drm_err(&gt->i915->drm,
+			"i915_gem_evict_for_node on a full GGTT returned err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -221,8 +228,8 @@ static int igt_evict_for_vma(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_for_node returned err=%d\n",
-		       err);
+		drm_err(&gt->i915->drm, "i915_gem_evict_for_node returned err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -273,7 +280,7 @@ static int igt_evict_for_cache_color(void *arg)
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
 				       I915_GTT_PAGE_SIZE | flags);
 	if (IS_ERR(vma)) {
-		pr_err("[0]i915_gem_object_ggtt_pin failed\n");
+		drm_err(&gt->i915->drm, "[0]i915_gem_object_ggtt_pin failed\n");
 		err = PTR_ERR(vma);
 		goto cleanup;
 	}
@@ -290,7 +297,7 @@ static int igt_evict_for_cache_color(void *arg)
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
 				       (I915_GTT_PAGE_SIZE * 2) | flags);
 	if (IS_ERR(vma)) {
-		pr_err("[1]i915_gem_object_ggtt_pin failed\n");
+		drm_err(&gt->i915->drm, "[1]i915_gem_object_ggtt_pin failed\n");
 		err = PTR_ERR(vma);
 		goto cleanup;
 	}
@@ -302,7 +309,8 @@ static int igt_evict_for_cache_color(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("[0]i915_gem_evict_for_node returned err=%d\n", err);
+		drm_err(&gt->i915->drm,
+			"[0]i915_gem_evict_for_node returned err=%d\n", err);
 		goto cleanup;
 	}
 
@@ -315,7 +323,8 @@ static int igt_evict_for_cache_color(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (!err) {
-		pr_err("[1]i915_gem_evict_for_node returned err=%d\n", err);
+		drm_err(&gt->i915->drm,
+			"[1]i915_gem_evict_for_node returned err=%d\n", err);
 		err = -EINVAL;
 		goto cleanup;
 	}
@@ -348,8 +357,9 @@ static int igt_evict_vm(void *arg)
 	err = i915_gem_evict_vm(&ggtt->vm, NULL, NULL);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_vm on a full GGTT returned err=%d]\n",
-		       err);
+		drm_err(&gt->i915->drm,
+			"i915_gem_evict_vm on a full GGTT returned err=%d]\n",
+			err);
 		goto cleanup;
 	}
 
@@ -362,8 +372,9 @@ static int igt_evict_vm(void *arg)
 	}
 
 	if (err) {
-		pr_err("i915_gem_evict_vm on a full GGTT returned err=%d]\n",
-		       err);
+		drm_err(&gt->i915->drm,
+			"i915_gem_evict_vm on a full GGTT returned err=%d]\n",
+			err);
 		goto cleanup;
 	}
 
@@ -443,7 +454,7 @@ static int igt_evict_contexts(void *arg)
 	} while (1);
 	drm_mm_remove_node(&hole);
 	mutex_unlock(&ggtt->vm.mutex);
-	pr_info("Filled GGTT with %lu 1MiB nodes\n", count);
+	drm_info(&i915->drm, "Filled GGTT with %lu 1MiB nodes\n", count);
 
 	/* Overfill the GGTT with context objects and so try to evict one. */
 	for_each_engine(engine, gt, id) {
@@ -469,9 +480,10 @@ static int igt_evict_contexts(void *arg)
 			if (IS_ERR(rq)) {
 				/* When full, fail_if_busy will trigger EBUSY */
 				if (PTR_ERR(rq) != -EBUSY) {
-					pr_err("Unexpected error from request alloc (on %s): %d\n",
-					       engine->name,
-					       (int)PTR_ERR(rq));
+					drm_err(&i915->drm,
+						"Unexpected error from request alloc (on %s): %d\n",
+						engine->name,
+						(int)PTR_ERR(rq));
 					err = PTR_ERR(rq);
 				}
 				break;
@@ -492,16 +504,17 @@ static int igt_evict_contexts(void *arg)
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
index e6bd06774816..8185ad886ac0 100644
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
@@ -268,8 +271,9 @@ static int lowlevel_hole(struct i915_address_space *vm,
 			hole_size = KMALLOC_MAX_SIZE / sizeof(u32);
 		count = hole_size >> 1;
 		if (!count) {
-			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
-				 __func__, hole_start, hole_end, size, hole_size);
+			drm_dbg(&vm->i915->drm,
+				"%s: hole is too small [%llx - %llx] >> %d: %lld\n",
+				__func__, hole_start, hole_end, size, hole_size);
 			break;
 		}
 
@@ -472,16 +476,20 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
-						       __func__, p->name, err, npages, prime, offset);
+						drm_err(&vm->i915->drm,
+							"%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+							__func__, p->name, err, npages, prime,
+							offset);
 						goto err;
 					}
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (forward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
-						       offset);
+						drm_err(&vm->i915->drm,
+							"%s(%s) (forward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+							__func__, p->name, vma->node.start,
+							vma->node.size,
+							drm_mm_node_allocated(&vma->node), offset);
 						err = -EINVAL;
 						goto err;
 					}
@@ -512,18 +520,20 @@ static int fill_hole(struct i915_address_space *vm,
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (forward) moved vma.node=%llx + %llx, expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       offset);
+						drm_err(&vm->i915->drm,
+							"%s(%s) (forward) moved vma.node=%llx + %llx, expected offset %llx\n",
+							__func__, p->name, vma->node.start,
+							vma->node.size, offset);
 						err = -EINVAL;
 						goto err;
 					}
 
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("%s(%s) (forward) unbind of vma.node=%llx + %llx failed with err=%d\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       err);
+						drm_err(&vm->i915->drm,
+							"%s(%s) (forward) unbind of vma.node=%llx + %llx failed with err=%d\n",
+							__func__, p->name, vma->node.start,
+							vma->node.size, err);
 						goto err;
 					}
 
@@ -551,16 +561,20 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
-						       __func__, p->name, err, npages, prime, offset);
+						drm_err(&vm->i915->drm,
+							"%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+							__func__, p->name, err, npages, prime,
+							offset);
 						goto err;
 					}
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (backward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
-						       offset);
+						drm_err(&vm->i915->drm,
+							"%s(%s) (backward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+							__func__, p->name, vma->node.start,
+							vma->node.size,
+							drm_mm_node_allocated(&vma->node), offset);
 						err = -EINVAL;
 						goto err;
 					}
@@ -591,18 +605,21 @@ static int fill_hole(struct i915_address_space *vm,
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (backward) moved vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
-						       offset);
+						drm_err(&vm->i915->drm,
+							"%s(%s) (backward) moved vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+							__func__, p->name, vma->node.start,
+							vma->node.size,
+							drm_mm_node_allocated(&vma->node), offset);
 						err = -EINVAL;
 						goto err;
 					}
 
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("%s(%s) (backward) unbind of vma.node=%llx + %llx failed with err=%d\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       err);
+						drm_err(&vm->i915->drm,
+							"%s(%s) (backward) unbind of vma.node=%llx + %llx failed with err=%d\n",
+							__func__, p->name, vma->node.start,
+							vma->node.size, err);
 						goto err;
 					}
 
@@ -672,25 +689,26 @@ static int walk_hole(struct i915_address_space *vm,
 		     addr += round_up(obj->base.size, min_alignment)) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s bind failed at %llx + %llx [hole %llx- %llx] with err=%d\n",
-				       __func__, addr, vma->size,
-				       hole_start, hole_end, err);
+				drm_err(&vm->i915->drm,
+					"%s bind failed at %llx + %llx [hole %llx- %llx] with err=%d\n",
+					__func__, addr, vma->size, hole_start, hole_end, err);
 				goto err_put;
 			}
 			i915_vma_unpin(vma);
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
-				       __func__, addr, vma->size);
+				drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
+					__func__, addr, vma->size);
 				err = -EINVAL;
 				goto err_put;
 			}
 
 			err = i915_vma_unbind_unlocked(vma);
 			if (err) {
-				pr_err("%s unbind failed at %llx + %llx  with err=%d\n",
-				       __func__, addr, vma->size, err);
+				drm_err(&vm->i915->drm,
+					"%s unbind failed at %llx + %llx  with err=%d\n",
+					__func__, addr, vma->size, err);
 				goto err_put;
 			}
 
@@ -754,18 +772,16 @@ static int pot_hole(struct i915_address_space *vm,
 		     addr += step) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s failed to pin object at %llx in hole [%llx - %llx], with err=%d\n",
-				       __func__,
-				       addr,
-				       hole_start, hole_end,
-				       err);
+				drm_err(&vm->i915->drm,
+					"%s failed to pin object at %llx in hole [%llx - %llx], with err=%d\n",
+					__func__, addr, hole_start, hole_end, err);
 				goto err_obj;
 			}
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
-				       __func__, addr, vma->size);
+				drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
+					__func__, addr, vma->size);
 				i915_vma_unpin(vma);
 				err = i915_vma_unbind_unlocked(vma);
 				err = -EINVAL;
@@ -819,8 +835,8 @@ static int drunk_hole(struct i915_address_space *vm,
 			hole_size = KMALLOC_MAX_SIZE / sizeof(u32);
 		count = hole_size >> 1;
 		if (!count) {
-			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
-				 __func__, hole_start, hole_end, size, hole_size);
+			drm_dbg(&vm->i915->drm, "%s: hole is too small [%llx - %llx] >> %d: %lld\n",
+				__func__, hole_start, hole_end, size, hole_size);
 			break;
 		}
 
@@ -859,18 +875,16 @@ static int drunk_hole(struct i915_address_space *vm,
 
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
-				       __func__,
-				       addr, BIT_ULL(size),
-				       hole_start, hole_end,
-				       err);
+				drm_err(&vm->i915->drm,
+					"%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
+					__func__, addr, BIT_ULL(size), hole_start, hole_end, err);
 				goto err_obj;
 			}
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
-				       __func__, addr, BIT_ULL(size));
+				drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
+					__func__, addr, BIT_ULL(size));
 				i915_vma_unpin(vma);
 				err = i915_vma_unbind_unlocked(vma);
 				err = -EINVAL;
@@ -939,15 +953,16 @@ static int __shrink_hole(struct i915_address_space *vm,
 
 		err = i915_vma_pin(vma, 0, 0, addr | flags);
 		if (err) {
-			pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
-			       __func__, addr, size, hole_start, hole_end, err);
+			drm_err(&vm->i915->drm,
+				"%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
+				__func__, addr, size, hole_start, hole_end, err);
 			break;
 		}
 
 		if (!drm_mm_node_allocated(&vma->node) ||
 		    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-			pr_err("%s incorrect at %llx + %llx\n",
-			       __func__, addr, size);
+			drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
+				__func__, addr, size);
 			i915_vma_unpin(vma);
 			err = i915_vma_unbind_unlocked(vma);
 			err = -EINVAL;
@@ -966,8 +981,7 @@ static int __shrink_hole(struct i915_address_space *vm,
 		if (err)
 			break;
 
-		if (igt_timeout(end_time,
-				"%s timed out at offset %llx [%llx - %llx]\n",
+		if (igt_timeout(end_time, "%s timed out at offset %llx [%llx - %llx]\n",
 				__func__, addr, hole_start, hole_end)) {
 			err = -EINTR;
 			break;
@@ -1419,8 +1433,7 @@ static int igt_ggtt_page(void *arg)
 		io_mapping_unmap_atomic(vaddr);
 
 		if (val != n) {
-			pr_err("insert page failed: found %d, expected %d\n",
-			       val, n);
+			drm_err(&i915->drm, "insert page failed: found %d, expected %d\n", val, n);
 			err = -EINVAL;
 			break;
 		}
@@ -1578,18 +1591,19 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, total);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
 
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
-		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       total, 2*I915_GTT_PAGE_SIZE);
+		    vma->node.size != 2 * I915_GTT_PAGE_SIZE) {
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+				vma->node.start, vma->node.size, total, 2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1624,18 +1638,19 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, total);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
 
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
-		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       total, 2*I915_GTT_PAGE_SIZE);
+		    vma->node.size != 2 * I915_GTT_PAGE_SIZE) {
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+				vma->node.start, vma->node.size, total, 2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1654,7 +1669,7 @@ static int igt_gtt_reserve(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("i915_vma_unbind failed with err=%d!\n", err);
+			drm_err(&ggtt->vm.i915->drm, "i915_vma_unbind failed with err=%d!\n", err);
 			goto out;
 		}
 
@@ -1665,18 +1680,19 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, offset);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
 
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset ||
-		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       offset, 2*I915_GTT_PAGE_SIZE);
+		    vma->node.size != 2 * I915_GTT_PAGE_SIZE) {
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+				vma->node.start, vma->node.size, offset, 2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1730,7 +1746,7 @@ static int igt_gtt_insert(void *arg)
 			0, ggtt->vm.total,
 		},
 		{
-			2*I915_GTT_PAGE_SIZE, 0,
+			2 * I915_GTT_PAGE_SIZE, 0,
 			0, I915_GTT_PAGE_SIZE,
 		},
 		{
@@ -1738,7 +1754,7 @@ static int igt_gtt_insert(void *arg)
 			0, 4*I915_GTT_PAGE_SIZE,
 		},
 		{
-			-(u64)2*I915_GTT_PAGE_SIZE, 2*I915_GTT_PAGE_SIZE,
+			-(u64)2 * I915_GTT_PAGE_SIZE, 2 * I915_GTT_PAGE_SIZE,
 			0, 4*I915_GTT_PAGE_SIZE,
 		},
 		{
@@ -1766,9 +1782,9 @@ static int igt_gtt_insert(void *arg)
 					  0);
 		mutex_unlock(&ggtt->vm.mutex);
 		if (err != -ENOSPC) {
-			pr_err("Invalid i915_gem_gtt_insert(.size=%llx, .alignment=%llx, .start=%llx, .end=%llx) succeeded (err=%d)\n",
-			       ii->size, ii->alignment, ii->start, ii->end,
-			       err);
+			drm_err(&ggtt->vm.i915->drm,
+				"Invalid i915_gem_gtt_insert(.size=%llx, .alignment=%llx, .start=%llx, .end=%llx) succeeded (err=%d)\n",
+				ii->size, ii->alignment, ii->start, ii->end, err);
 			return -EINVAL;
 		}
 	}
@@ -1807,8 +1823,9 @@ static int igt_gtt_insert(void *arg)
 			break;
 		}
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
@@ -1827,7 +1844,7 @@ static int igt_gtt_insert(void *arg)
 		}
 
 		if (!drm_mm_node_allocated(&vma->node)) {
-			pr_err("VMA was unexpectedly evicted!\n");
+			drm_err(&ggtt->vm.i915->drm, "VMA was unexpectedly evicted!\n");
 			err = -EINVAL;
 			goto out;
 		}
@@ -1851,22 +1868,24 @@ static int igt_gtt_insert(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("i915_vma_unbind failed with err=%d!\n", err);
+			drm_err(&ggtt->vm.i915->drm, "i915_vma_unbind failed with err=%d!\n", err);
 			goto out;
 		}
 
 		err = insert_gtt_with_resource(vma);
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
 
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset) {
-			pr_err("i915_gem_gtt_insert did not return node to its previous location (the only hole), expected address %llx, found %llx\n",
-			       offset, vma->node.start);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_insert did not return node to its previous location (the only hole), expected address %llx, found %llx\n",
+				offset, vma->node.start);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1901,8 +1920,9 @@ static int igt_gtt_insert(void *arg)
 
 		err = insert_gtt_with_resource(vma);
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=%d\n",
-			       total, ggtt->vm.total, err);
+			drm_err(&ggtt->vm.i915->drm,
+				"i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=%d\n",
+				total, ggtt->vm.total, err);
 			goto out;
 		}
 		track_vma_bind(vma);
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index e9469e27f42a..3bb7f1cadd4c 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -14,6 +14,8 @@
 #include "igt_flush_test.h"
 #include "lib_sw_fence.h"
 
+#include <drm/drm_print.h>
+
 #define TEST_OA_CONFIG_UUID "12345678-1234-1234-1234-1234567890ab"
 
 static int
@@ -263,20 +265,23 @@ static int live_noa_delay(void *arg)
 	t1 = poll_status(rq, 0x102);
 	preempt_enable();
 
-	pr_info("CPU delay: %lluns, expected %lluns\n",
-		ktime_sub(t1, t0), expected);
+	drm_info(&stream->engine->i915->drm,
+		 "CPU delay: %lluns, expected %lluns\n",
+		 ktime_sub(t1, t0), expected);
 
 	delay = intel_read_status_page(stream->engine, 0x102);
 	delay -= intel_read_status_page(stream->engine, 0x100);
 	delay = intel_gt_clock_interval_to_ns(stream->engine->gt, delay);
-	pr_info("GPU delay: %uns, expected %lluns\n",
-		delay, expected);
+	drm_info(&stream->engine->i915->drm,
+		 "GPU delay: %uns, expected %lluns\n",
+		 delay, expected);
 
 	if (4 * delay < 3 * expected || 2 * delay > 3 * expected) {
-		pr_err("GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
-		       delay / 1000,
-		       div_u64(3 * expected, 4000),
-		       div_u64(3 * expected, 2000));
+		drm_err(&stream->engine->i915->drm,
+			"GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
+			delay / 1000,
+			div_u64(3 * expected, 4000),
+			div_u64(3 * expected, 2000));
 		err = -EINVAL;
 	}
 
@@ -385,7 +390,7 @@ static int live_noa_gpr(void *arg)
 	i915_request_add(rq);
 
 	if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE, HZ / 2) < 0) {
-		pr_err("noa_wait timed out\n");
+		drm_err(&stream->engine->i915->drm, "noa_wait timed out\n");
 		intel_gt_set_wedged(stream->engine->gt);
 		err = -EIO;
 		goto out_rq;
@@ -396,14 +401,15 @@ static int live_noa_gpr(void *arg)
 		if (store[i] == STACK_MAGIC)
 			continue;
 
-		pr_err("GPR[%d] lost, found:%08x, expected:%08x!\n",
-		       i, store[i], STACK_MAGIC);
+		drm_err(&stream->engine->i915->drm,
+			"GPR[%d] lost, found:%08x, expected:%08x!\n",
+			i, store[i], STACK_MAGIC);
 		err = -EINVAL;
 	}
 
 	/* Verify that the user's scratch page was not used for GPR storage */
 	if (memchr_inv(scratch, POISON_FREE, PAGE_SIZE)) {
-		pr_err("Scratch page overwritten!\n");
+		drm_err(&stream->engine->i915->drm, "Scratch page overwritten!\n");
 		igt_hexdump(scratch, 4096);
 		err = -EINVAL;
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index e1a7c454a0a9..c531f1050fb2 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -98,49 +98,49 @@ static int igt_wait_request(void *arg)
 	i915_request_get(request);
 
 	if (i915_request_wait(request, 0, 0) != -ETIME) {
-		pr_err("request wait (busy query) succeeded (expected timeout before submit!)\n");
+		drm_err(&i915->drm, "request wait (busy query) succeeded (expected timeout before submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) != -ETIME) {
-		pr_err("request wait succeeded (expected timeout before submit!)\n");
+		drm_err(&i915->drm, "request wait succeeded (expected timeout before submit!)\n");
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
+		drm_err(&i915->drm, "request wait (busy query) succeeded (expected timeout after submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("request completed immediately!\n");
+		drm_err(&i915->drm, "request completed immediately!\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T / 2) != -ETIME) {
-		pr_err("request wait succeeded (expected timeout!)\n");
+		drm_err(&i915->drm, "request wait succeeded (expected timeout!)\n");
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
+		drm_err(&i915->drm, "request wait timed out when already complete!\n");
 		goto out_request;
 	}
 
@@ -165,34 +165,34 @@ static int igt_fence_wait(void *arg)
 		return PTR_ERR(request);
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) != -ETIME) {
-		pr_err("fence wait success before submit (expected timeout)!\n");
+		drm_err(&i915->drm, "fence wait success before submit (expected timeout)!\n");
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
+		drm_err(&i915->drm, "fence wait success after submit (expected timeout)!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) <= 0) {
-		pr_err("fence wait timed out (expected success)!\n");
+		drm_err(&i915->drm, "fence wait timed out (expected success)!\n");
 		goto out;
 	}
 
 	if (!dma_fence_is_signaled(&request->fence)) {
-		pr_err("fence unsignaled after waiting!\n");
+		drm_err(&i915->drm, "fence unsignaled after waiting!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) <= 0) {
-		pr_err("fence wait timed out when complete (expected success)!\n");
+		drm_err(&i915->drm, "fence wait timed out when complete (expected success)!\n");
 		goto out;
 	}
 
@@ -245,7 +245,7 @@ static int igt_request_rewind(void *arg)
 
 	/* Simulate preemption by manual reordering */
 	if (!mock_cancel_request(request)) {
-		pr_err("failed to cancel request (already executed)!\n");
+		drm_err(&i915->drm, "failed to cancel request (already executed)!\n");
 		i915_request_add(vip);
 		goto err_context_1;
 	}
@@ -257,12 +257,12 @@ static int igt_request_rewind(void *arg)
 
 
 	if (i915_request_wait(vip, 0, HZ) == -ETIME) {
-		pr_err("timed out waiting for high priority request\n");
+		drm_err(&i915->drm, "timed out waiting for high priority request\n");
 		goto err;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("low priority request already completed\n");
+		drm_err(&i915->drm, "low priority request already completed\n");
 		goto err;
 	}
 
@@ -406,7 +406,8 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 					5 * HZ)) {
 			struct i915_request *rq = requests[count - 1];
 
-			pr_err("waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
+			drm_err(&t->engine->i915->drm,
+				"waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
 			       atomic_read(&wait->pending), count,
 			       rq->fence.context, rq->fence.seqno,
 			       t->engine->name);
@@ -423,7 +424,7 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 
 			if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
 				      &rq->fence.flags)) {
-				pr_err("%llu:%llu was not signaled!\n",
+				drm_err(&t->engine->i915->drm, "%llu:%llu was not signaled!\n",
 				       rq->fence.context, rq->fence.seqno);
 				err = -EINVAL;
 			}
@@ -523,7 +524,7 @@ static int mock_breadcrumbs_smoketest(void *arg)
 
 		kthread_destroy_worker(threads[n].worker);
 	}
-	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
+	drm_info(&i915->drm, "Completed %lu waits for %lu fence across %d cpus\n",
 		atomic_long_read(&t.num_waits),
 		atomic_long_read(&t.num_fences),
 		ncpus);
@@ -632,7 +633,7 @@ static int live_nop_request(void *arg)
 		if (err)
 			return err;
 
-		pr_info("Request latencies on %s: 1 = %lluns, %lu = %lluns\n",
+		drm_info(&i915->drm, "Request latencies on %s: 1 = %lluns, %lu = %lluns\n",
 			engine->name,
 			ktime_to_ns(times[0]),
 			prime, div64_u64(ktime_to_ns(times[1]), prime));
@@ -663,7 +664,7 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling inactive request\n", engine->name);
+	drm_dbg(&engine->i915->drm, "%s: Cancelling inactive request\n", engine->name);
 	i915_request_cancel(rq, -EINTR);
 	i915_request_get(rq);
 	i915_request_add(rq);
@@ -671,14 +672,16 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel inactive request\n", engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Failed to cancel inactive request\n",
+				engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
@@ -690,7 +693,7 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->name, err);
 	return err;
 }
 
@@ -716,13 +719,13 @@ static int __cancel_active(struct intel_engine_cs *engine)
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling active request\n", engine->name);
+	drm_dbg(&engine->i915->drm, "%s: Cancelling active request\n", engine->name);
 	i915_request_get(rq);
 	i915_request_add(rq);
 	if (!igt_wait_for_spinner(&spin, rq)) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
@@ -732,14 +735,14 @@ static int __cancel_active(struct intel_engine_cs *engine)
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel active request\n", engine->name);
+		drm_err(&engine->i915->drm, "%s: Failed to cancel active request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
@@ -751,7 +754,7 @@ static int __cancel_active(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->name, err);
 	return err;
 }
 
@@ -785,10 +788,10 @@ static int __cancel_completed(struct intel_engine_cs *engine)
 		goto out_rq;
 	}
 
-	pr_debug("%s: Cancelling completed request\n", engine->name);
+	drm_dbg(&engine->i915->drm, "%s: Cancelling completed request\n", engine->name);
 	i915_request_cancel(rq, -EINTR);
 	if (rq->fence.error) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
@@ -800,7 +803,7 @@ static int __cancel_completed(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->name, err);
 	return err;
 }
 
@@ -846,14 +849,15 @@ static int __cancel_reset(struct drm_i915_private *i915,
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling active non-preemptable request\n",
+	drm_dbg(&engine->i915->drm,
+		"%s: Cancelling active non-preemptable request\n",
 		 engine->name);
 	i915_request_get(rq);
 	i915_request_add(rq);
 	if (!igt_wait_for_spinner(&spin, rq)) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
@@ -870,14 +874,14 @@ static int __cancel_reset(struct drm_i915_private *i915,
 	if (i915_request_wait(rq, 0, HZ) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel hung request\n", engine->name);
+		drm_err(&engine->i915->drm, "%s: Failed to cancel hung request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_nop;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 		goto out_nop;
@@ -886,14 +890,14 @@ static int __cancel_reset(struct drm_i915_private *i915,
 	if (i915_request_wait(nop, 0, HZ) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to complete nop request\n", engine->name);
+		drm_err(&engine->i915->drm, "%s: Failed to complete nop request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_nop;
 	}
 
 	if (nop->fence.error != 0) {
-		pr_err("%s: Nop request errored (%u)\n",
+		drm_err(&engine->i915->drm, "%s: Nop request errored (%u)\n",
 		       engine->name, nop->fence.error);
 		err = -EINVAL;
 	}
@@ -909,7 +913,7 @@ static int __cancel_reset(struct drm_i915_private *i915,
 out_restore:
 	engine->props.preempt_timeout_ms = preempt_timeout_ms;
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->name, err);
 	return err;
 }
 
@@ -1102,7 +1106,7 @@ static int live_empty_request(void *arg)
 		if (err)
 			goto out_batch;
 
-		pr_info("Batch latencies on %s: 1 = %lluns, %lu = %lluns\n",
+		drm_info(&i915->drm, "Batch latencies on %s: 1 = %lluns, %lu = %lluns\n",
 			engine->name,
 			ktime_to_ns(times[0]),
 			prime, div64_u64(ktime_to_ns(times[1]), prime));
@@ -1218,7 +1222,7 @@ static int live_all_engines(void *arg)
 		batch = recursive_batch(engine->gt);
 		if (IS_ERR(batch)) {
 			err = PTR_ERR(batch);
-			pr_err("%s: Unable to create batch, err=%d\n",
+			drm_err(&i915->drm, "%s: Unable to create batch, err=%d\n",
 			       __func__, err);
 			goto out_free;
 		}
@@ -1227,7 +1231,7 @@ static int live_all_engines(void *arg)
 		request[idx] = intel_engine_create_kernel_request(engine);
 		if (IS_ERR(request[idx])) {
 			err = PTR_ERR(request[idx]);
-			pr_err("%s: Request allocation failed with err=%d\n",
+			drm_err(&i915->drm, "%s: Request allocation failed with err=%d\n",
 			       __func__, err);
 			goto out_unlock;
 		}
@@ -1252,7 +1256,7 @@ static int live_all_engines(void *arg)
 	idx = 0;
 	for_each_uabi_engine(engine, i915) {
 		if (i915_request_completed(request[idx])) {
-			pr_err("%s(%s): request completed too early!\n",
+			drm_err(&i915->drm, "%s(%s): request completed too early!\n",
 			       __func__, engine->name);
 			err = -EINVAL;
 			goto out_request;
@@ -1264,7 +1268,7 @@ static int live_all_engines(void *arg)
 	for_each_uabi_engine(engine, i915) {
 		err = recursive_batch_resolve(request[idx]->batch);
 		if (err) {
-			pr_err("%s: failed to resolve batch, err=%d\n",
+			drm_err(&i915->drm, "%s: failed to resolve batch, err=%d\n",
 			       __func__, err);
 			goto out_request;
 		}
@@ -1280,7 +1284,7 @@ static int live_all_engines(void *arg)
 					    MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			err = timeout;
-			pr_err("%s: error waiting for request on %s, err=%d\n",
+			drm_err(&i915->drm, "%s: error waiting for request on %s, err=%d\n",
 			       __func__, engine->name, err);
 			goto out_request;
 		}
@@ -1348,7 +1352,7 @@ static int live_sequential_engines(void *arg)
 		batch = recursive_batch(engine->gt);
 		if (IS_ERR(batch)) {
 			err = PTR_ERR(batch);
-			pr_err("%s: Unable to create batch for %s, err=%d\n",
+			drm_err(&i915->drm, "%s: Unable to create batch for %s, err=%d\n",
 			       __func__, engine->name, err);
 			goto out_free;
 		}
@@ -1357,7 +1361,7 @@ static int live_sequential_engines(void *arg)
 		request[idx] = intel_engine_create_kernel_request(engine);
 		if (IS_ERR(request[idx])) {
 			err = PTR_ERR(request[idx]);
-			pr_err("%s: Request allocation failed for %s with err=%d\n",
+			drm_err(&i915->drm, "%s: Request allocation failed for %s with err=%d\n",
 			       __func__, engine->name, err);
 			goto out_unlock;
 		}
@@ -1368,7 +1372,7 @@ static int live_sequential_engines(void *arg)
 							   &prev->fence);
 			if (err) {
 				i915_request_add(request[idx]);
-				pr_err("%s: Request await failed for %s with err=%d\n",
+				drm_err(&i915->drm, "%s: Request await failed for %s with err=%d\n",
 				       __func__, engine->name, err);
 				goto out_unlock;
 			}
@@ -1398,7 +1402,7 @@ static int live_sequential_engines(void *arg)
 		long timeout;
 
 		if (i915_request_completed(request[idx])) {
-			pr_err("%s(%s): request completed too early!\n",
+			drm_err(&i915->drm, "%s(%s): request completed too early!\n",
 			       __func__, engine->name);
 			err = -EINVAL;
 			goto out_request;
@@ -1406,7 +1410,7 @@ static int live_sequential_engines(void *arg)
 
 		err = recursive_batch_resolve(request[idx]->batch);
 		if (err) {
-			pr_err("%s: failed to resolve batch, err=%d\n",
+			drm_err(&i915->drm, "%s: failed to resolve batch, err=%d\n",
 			       __func__, err);
 			goto out_request;
 		}
@@ -1415,7 +1419,7 @@ static int live_sequential_engines(void *arg)
 					    MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			err = timeout;
-			pr_err("%s: error waiting for request on %s, err=%d\n",
+			drm_err(&i915->drm, "%s: error waiting for request on %s, err=%d\n",
 			       __func__, engine->name, err);
 			goto out_request;
 		}
@@ -1496,7 +1500,7 @@ static void __live_parallel_engine1(struct kthread_work *work)
 	} while (!__igt_timeout(end_time, NULL));
 	intel_engine_pm_put(engine);
 
-	pr_info("%s: %lu request + sync\n", engine->name, count);
+	drm_info(&engine->i915->drm, "%s: %lu request + sync\n", engine->name, count);
 	thread->result = err;
 }
 
@@ -1525,7 +1529,7 @@ static void __live_parallel_engineN(struct kthread_work *work)
 	} while (!__igt_timeout(end_time, NULL));
 	intel_engine_pm_put(engine);
 
-	pr_info("%s: %lu requests\n", engine->name, count);
+	drm_info(&engine->i915->drm, "%s: %lu requests\n", engine->name, count);
 	thread->result = err;
 }
 
@@ -1592,7 +1596,7 @@ static void __live_parallel_spin(struct kthread_work *work)
 		/* Occupy this engine for the whole test */
 		err = wait_for_all(engine->i915);
 	} else {
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n", engine->name);
 		err = -EINVAL;
 	}
 	igt_spinner_end(&spin);
@@ -1798,7 +1802,7 @@ static int live_breadcrumbs_smoketest(void *arg)
 		}
 		/* One ring interleaved between requests from all cpus */
 		smoke[idx].max_batch /= ncpus + 1;
-		pr_debug("Limiting batches to %d requests on %s\n",
+		drm_dbg(&i915->drm, "Limiting batches to %d requests on %s\n",
 			 smoke[idx].max_batch, engine->name);
 
 		for (n = 0; n < ncpus; n++) {
@@ -1849,7 +1853,8 @@ static int live_breadcrumbs_smoketest(void *arg)
 		num_fences += atomic_long_read(&smoke[idx].num_fences);
 		idx++;
 	}
-	pr_info("Completed %lu waits for %lu fences across %d engines and %d cpus\n",
+	drm_info(&i915->drm,
+		 "Completed %lu waits for %lu fences across %d engines and %d cpus\n",
 		num_waits, num_fences, idx, ncpus);
 
 	ret = igt_live_test_end(&live) ?: ret;
@@ -2075,7 +2080,7 @@ static int measure_semaphore_response(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: semaphore response %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm, "%s: semaphore response %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2146,7 +2151,7 @@ static int measure_idle_dispatch(struct intel_context *ce)
 		elapsed[i] = sema[i] - elapsed[i];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: idle dispatch latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm, "%s: idle dispatch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2223,7 +2228,7 @@ static int measure_busy_dispatch(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: busy dispatch latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm, "%s: busy dispatch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2336,7 +2341,7 @@ static int measure_inter_request(struct intel_context *ce)
 		elapsed[i - 1] = sema[i + 1] - sema[i];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: inter-request latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm, "%s: inter-request latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2431,7 +2436,7 @@ static int measure_context_switch(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 2] - sema[2 * i + 1];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: context switch latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm, "%s: context switch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2534,7 +2539,8 @@ static int measure_preemption(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 0] - elapsed[i - 1];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: preemption dispatch latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm,
+		 "%s: preemption dispatch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2542,7 +2548,8 @@ static int measure_preemption(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 1] - sema[2 * i + 0];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: preemption switch latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm,
+		 "%s: preemption switch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2636,7 +2643,7 @@ static int measure_completion(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: completion latency %d cycles, %lluns\n",
+	drm_info(&ce->engine->i915->drm, "%s: completion latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2929,7 +2936,8 @@ static int perf_series_engines(void *arg)
 				decimal = 0;
 			}
 
-			pr_info("%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
+			drm_info(&i915->drm,
+				 "%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
 				name, p->engine->name, ce->timeline->seqno,
 				integer, decimal,
 				div_u64(p->runtime, 1000 * 1000),
@@ -3275,7 +3283,7 @@ static int perf_parallel_engines(void *arg)
 			}
 
 			GEM_BUG_ON(engine != p->engine);
-			pr_info("%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
+			drm_info(&i915->drm, "%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
 				name, engine->name, p->count, integer, decimal,
 				div_u64(p->runtime, 1000 * 1000),
 				div_u64(ktime_to_ns(p->time), 1000 * 1000));
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 7c4111e60f2e..ff08cad8680d 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -24,6 +24,8 @@
 
 #include <linux/prime_numbers.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_context.h"
 #include "gem/i915_gem_internal.h"
 #include "gem/selftests/mock_context.h"
@@ -41,19 +43,19 @@ static bool assert_vma(struct i915_vma *vma,
 	bool ok = true;
 
 	if (vma->vm != ctx->vm) {
-		pr_err("VMA created with wrong VM\n");
+		drm_err(obj->base.dev, "VMA created with wrong VM\n");
 		ok = false;
 	}
 
 	if (vma->size != obj->base.size) {
-		pr_err("VMA created with wrong size, found %llu, expected %zu\n",
+		drm_err(obj->base.dev,
+			"VMA created with wrong size, found %llu, expected %zu\n",
 		       vma->size, obj->base.size);
 		ok = false;
 	}
 
 	if (vma->gtt_view.type != I915_GTT_VIEW_NORMAL) {
-		pr_err("VMA created with wrong type [%d]\n",
-		       vma->gtt_view.type);
+		drm_err(obj->base.dev, "VMA created with wrong type [%d]\n", vma->gtt_view.type);
 		ok = false;
 	}
 
@@ -74,30 +76,34 @@ checked_vma_instance(struct drm_i915_gem_object *obj,
 
 	/* Manual checks, will be reinforced by i915_vma_compare! */
 	if (vma->vm != vm) {
-		pr_err("VMA's vm [%p] does not match request [%p]\n",
+		drm_err(obj->base.dev,
+			"VMA's vm [%p] does not match request [%p]\n",
 		       vma->vm, vm);
 		ok = false;
 	}
 
 	if (i915_is_ggtt(vm) != i915_vma_is_ggtt(vma)) {
-		pr_err("VMA ggtt status [%d] does not match parent [%d]\n",
+		drm_err(obj->base.dev,
+			"VMA ggtt status [%d] does not match parent [%d]\n",
 		       i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
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
 
@@ -126,14 +132,16 @@ static int create_vmas(struct drm_i915_private *i915,
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
@@ -332,7 +340,8 @@ static int igt_vma_pin1(void *arg)
 	for (m = modes; m->assert; m++) {
 		err = i915_vma_pin(vma, m->size, 0, m->flags);
 		if (!m->assert(vma, m, err)) {
-			pr_err("%s to pin single page into GGTT with mode[%d:%s]: size=%llx flags=%llx, err=%d\n",
+			drm_err(obj->base.dev,
+				"%s to pin single page into GGTT with mode[%d:%s]: size=%llx flags=%llx, err=%d\n",
 			       m->assert == assert_pin_valid ? "Failed" : "Unexpectedly succeeded",
 			       (int)(m - modes), m->string, m->size, m->flags,
 			       err);
@@ -346,7 +355,8 @@ static int igt_vma_pin1(void *arg)
 			i915_vma_unpin(vma);
 			err = i915_vma_unbind_unlocked(vma);
 			if (err) {
-				pr_err("Failed to unbind single page from GGTT, err=%d\n", err);
+				drm_err(obj->base.dev,
+					"Failed to unbind single page from GGTT, err=%d\n", err);
 				goto out;
 			}
 		}
@@ -384,8 +394,9 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			dma_addr_t src;
 
 			if (!sg) {
-				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
-				       n, x, y);
+				drm_err(obj->base.dev,
+					"Invalid sg table: too short at plane %d, (%d, %d)!\n",
+					n, x, y);
 				return ERR_PTR(-EINVAL);
 			}
 
@@ -393,15 +404,16 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			src = i915_gem_object_get_dma_address(obj, src_idx);
 
 			if (sg_dma_len(sg) != PAGE_SIZE) {
-				pr_err("Invalid sg.length, found %d, expected %lu for rotated page (%d, %d) [src index %lu]\n",
-				       sg_dma_len(sg), PAGE_SIZE,
-				       x, y, src_idx);
+				drm_err(obj->base.dev,
+					"Invalid sg.length, found %d, expected %lu for rotated page (%d, %d) [src index %lu]\n",
+					sg_dma_len(sg), PAGE_SIZE, x, y, src_idx);
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
 
@@ -414,20 +426,23 @@ assert_rotated(struct drm_i915_gem_object *obj,
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
 
@@ -461,8 +476,9 @@ assert_remapped(struct drm_i915_gem_object *obj,
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
@@ -474,15 +490,16 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			src = i915_gem_object_get_dma_address(obj, src_idx);
 
 			if (left < PAGE_SIZE || left & (PAGE_SIZE-1)) {
-				pr_err("Invalid sg.length, found %d, expected %lu for remapped page (%d, %d) [src index %lu]\n",
-				       sg_dma_len(sg), PAGE_SIZE,
-				       x, y, src_idx);
+				drm_err(obj->base.dev,
+					"Invalid sg.length, found %d, expected %lu for remapped page (%d, %d) [src index %lu]\n",
+					sg_dma_len(sg), PAGE_SIZE, x, y, src_idx);
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
 
@@ -495,9 +512,9 @@ assert_remapped(struct drm_i915_gem_object *obj,
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
 
@@ -507,22 +524,22 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			continue;
 
 		if (!sg) {
-			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
-			       n, x, y);
+			drm_err(obj->base.dev,
+				"Invalid sg table: too short at plane %d, (%d, %d)!\n", n, x, y);
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
 
@@ -628,7 +645,8 @@ static int igt_vma_rotate_remap(void *arg)
 
 					err = i915_vma_pin(vma, 0, 0, PIN_GLOBAL);
 					if (err) {
-						pr_err("Failed to pin VMA, err=%d\n", err);
+						drm_err(obj->base.dev,
+							"Failed to pin VMA, err=%d\n", err);
 						goto out_object;
 					}
 
@@ -636,36 +654,41 @@ static int igt_vma_rotate_remap(void *arg)
 
 					if (view.type == I915_GTT_VIEW_ROTATED &&
 					    vma->size != expected_pages * PAGE_SIZE) {
-						pr_err("VMA is wrong size, expected %lu, found %llu\n",
-						       PAGE_SIZE * expected_pages, vma->size);
+						drm_err(obj->base.dev,
+							"VMA is wrong size, expected %lu, found %llu\n",
+							PAGE_SIZE * expected_pages, vma->size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (view.type == I915_GTT_VIEW_REMAPPED &&
 					    vma->size > expected_pages * PAGE_SIZE) {
-						pr_err("VMA is wrong size, expected %lu, found %llu\n",
-						       PAGE_SIZE * expected_pages, vma->size);
+						drm_err(obj->base.dev,
+							"VMA is wrong size, expected %lu, found %llu\n",
+							PAGE_SIZE * expected_pages, vma->size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->pages->nents > expected_pages) {
-						pr_err("sg table is wrong sizeo, expected %u, found %u nents\n",
-						       expected_pages, vma->pages->nents);
+						drm_err(obj->base.dev,
+							"sg table is wrong sizeo, expected %u, found %u nents\n",
+							expected_pages, vma->pages->nents);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->node.size < vma->size) {
-						pr_err("VMA binding too small, expected %llu, found %llu\n",
-						       vma->size, vma->node.size);
+						drm_err(obj->base.dev,
+							"VMA binding too small, expected %llu, found %llu\n",
+							vma->size, vma->node.size);
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
@@ -677,19 +700,20 @@ static int igt_vma_rotate_remap(void *arg)
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
@@ -698,7 +722,8 @@ static int igt_vma_rotate_remap(void *arg)
 					i915_vma_unpin(vma);
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("Unbinding returned %i\n", err);
+						drm_err(obj->base.dev,
+							"Unbinding returned %i\n", err);
 						goto out_object;
 					}
 					cond_resched();
@@ -726,14 +751,15 @@ static bool assert_partial(struct drm_i915_gem_object *obj,
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
+				"DMA mismatch for partial page offset %lu\n", offset);
 			return false;
 		}
 
@@ -752,38 +778,40 @@ static bool assert_pin(struct i915_vma *vma,
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
+				"(%s) VMA using original object pages!\n", name);
 			ok = false;
 		}
 	} else {
 		if (vma->gtt_view.type != I915_GTT_VIEW_NORMAL) {
-			pr_err("Not the normal ggtt view! Found %d\n",
-			       vma->gtt_view.type);
+			drm_err(vma->obj->base.dev,
+				"Not the normal ggtt view! Found %d\n", vma->gtt_view.type);
 			ok = false;
 		}
 
 		if (vma->pages != vma->obj->mm.pages) {
-			pr_err("VMA not using object pages!\n");
+			drm_err(vma->obj->base.dev, "VMA not using object pages!\n");
 			ok = false;
 		}
 	}
@@ -843,15 +871,17 @@ static int igt_vma_partial(void *arg)
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
@@ -860,7 +890,7 @@ static int igt_vma_partial(void *arg)
 				nvma++;
 				err = i915_vma_unbind_unlocked(vma);
 				if (err) {
-					pr_err("Unbinding returned %i\n", err);
+					drm_err(obj->base.dev, "Unbinding returned %i\n", err);
 					goto out_object;
 				}
 
@@ -872,8 +902,9 @@ static int igt_vma_partial(void *arg)
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
@@ -890,7 +921,7 @@ static int igt_vma_partial(void *arg)
 			goto out_object;
 
 		if (!assert_pin(vma, NULL, obj->base.size, p->name)) {
-			pr_err("(%s) inconsistent full pin\n", p->name);
+			drm_err(obj->base.dev, "(%s) inconsistent full pin\n", p->name);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -899,7 +930,7 @@ static int igt_vma_partial(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("Unbinding returned %i\n", err);
+			drm_err(obj->base.dev, "Unbinding returned %i\n", err);
 			goto out_object;
 		}
 
@@ -907,7 +938,7 @@ static int igt_vma_partial(void *arg)
 		list_for_each_entry(vma, &obj->vma.list, obj_link)
 			count++;
 		if (count != nvma) {
-			pr_err("(%s) allocated an extra full vma!\n", p->name);
+			drm_err(obj->base.dev, "(%s) allocated an extra full vma!\n", p->name);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -1080,9 +1111,13 @@ static int igt_vma_remapped_gtt(void *arg)
 
 					val = ioread32(&map[offset / sizeof(*map)]);
 					if (val != exp) {
-						pr_err("%s VMA write test failed, expected 0x%x, found 0x%x\n",
-						       *t == I915_GTT_VIEW_ROTATED ? "Rotated" : "Remapped",
-						       exp, val);
+						const char *kind;
+
+						kind = *t == I915_GTT_VIEW_ROTATED ?
+							"Rotated" : "Remapped";
+						drm_err(vma->obj->base.dev,
+							"%s VMA write test failed, expected 0x%x, found 0x%x\n",
+							kind, exp, val);
 						i915_vma_unpin_iomap(vma);
 						err = -EINVAL;
 						goto out;
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index 514d2200751b..881e8a1b809d 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -26,9 +26,14 @@
 
 #include "gt/intel_gt.h"
 
+#include "mock_gem_device.h"
+
+#include <drm/drm_print.h>
+
 static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
 				unsigned int num_ranges,
-				bool is_watertight)
+				bool is_watertight,
+				struct drm_i915_private *i915)
 {
 	unsigned int i;
 	s32 prev;
@@ -36,22 +41,25 @@ static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
 	for (i = 0, prev = -1; i < num_ranges; i++, ranges++) {
 		/* Check that the table is watertight */
 		if (is_watertight && (prev + 1) != (s32)ranges->start) {
-			pr_err("%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
-			       __func__, i, ranges->start, ranges->end, prev);
+			drm_err(&i915->drm,
+				"%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
+				__func__, i, ranges->start, ranges->end, prev);
 			return -EINVAL;
 		}
 
 		/* Check that the table never goes backwards */
 		if (prev >= (s32)ranges->start) {
-			pr_err("%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
-			       __func__, i, ranges->start, ranges->end, prev);
+			drm_err(&i915->drm,
+				"%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
+				__func__, i, ranges->start, ranges->end, prev);
 			return -EINVAL;
 		}
 
 		/* Check that the entry is valid */
 		if (ranges->start >= ranges->end) {
-			pr_err("%s: entry[%d]:(%x, %x) has negative length\n",
-			       __func__, i, ranges->start, ranges->end);
+			drm_err(&i915->drm,
+				"%s: entry[%d]:(%x, %x) has negative length\n",
+				__func__, i, ranges->start, ranges->end);
 			return -EINVAL;
 		}
 
@@ -61,7 +69,7 @@ static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
 	return 0;
 }
 
-static int intel_shadow_table_check(void)
+static int intel_shadow_table_check(struct drm_i915_private *i915)
 {
 	struct {
 		const struct i915_mmio_range *regs;
@@ -82,20 +90,23 @@ static int intel_shadow_table_check(void)
 		range = range_lists[j].regs;
 		for (i = 0, prev = -1; i < range_lists[j].size; i++, range++) {
 			if (range->end < range->start) {
-				pr_err("%s: range[%d]:(%06x-%06x) has end before start\n",
-				       __func__, i, range->start, range->end);
+				drm_err(&i915->drm,
+					"%s: range[%d]:(%06x-%06x) has end before start\n",
+					__func__, i, range->start, range->end);
 				return -EINVAL;
 			}
 
 			if (prev >= (s32)range->start) {
-				pr_err("%s: range[%d]:(%06x-%06x) is before end of previous (%06x)\n",
-				       __func__, i, range->start, range->end, prev);
+				drm_err(&i915->drm,
+					"%s: range[%d]:(%06x-%06x) is before end of previous (%06x)\n",
+					__func__, i, range->start, range->end, prev);
 				return -EINVAL;
 			}
 
 			if (range->start % 4) {
-				pr_err("%s: range[%d]:(%06x-%06x) has non-dword-aligned start\n",
-				       __func__, i, range->start, range->end);
+				drm_err(&i915->drm,
+					"%s: range[%d]:(%06x-%06x) has non-dword-aligned start\n",
+					__func__, i, range->start, range->end);
 				return -EINVAL;
 			}
 
@@ -108,6 +119,7 @@ static int intel_shadow_table_check(void)
 
 int intel_uncore_mock_selftests(void)
 {
+	struct drm_i915_private *i915;
 	struct {
 		const struct intel_forcewake_range *ranges;
 		unsigned int num_ranges;
@@ -123,15 +135,27 @@ int intel_uncore_mock_selftests(void)
 	};
 	int err, i;
 
+	i915 = mock_gem_device();
+	if (IS_ERR(i915))
+		return PTR_ERR(i915);
+
 	for (i = 0; i < ARRAY_SIZE(fw); i++) {
 		err = intel_fw_table_check(fw[i].ranges,
 					   fw[i].num_ranges,
-					   fw[i].is_watertight);
+					   fw[i].is_watertight,
+					   i915);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	err = intel_shadow_table_check();
+	err = intel_shadow_table_check(i915);
+	if (err)
+		goto out;
+
+	err = 0;
+
+out:
+	mock_destroy_device(i915);
 	if (err)
 		return err;
 
@@ -172,7 +196,8 @@ static int live_forcewake_ops(void *arg)
 
 	/* vlv/chv with their pcu behave differently wrt reads */
 	if (IS_VALLEYVIEW(gt->i915) || IS_CHERRYVIEW(gt->i915)) {
-		pr_debug("PCU fakes forcewake badly; skipping\n");
+		drm_dbg(&gt->i915->drm,
+			"PCU fakes forcewake badly; skipping\n");
 		return 0;
 	}
 
@@ -192,8 +217,9 @@ static int live_forcewake_ops(void *arg)
 		if (IS_GRAPHICS_VER(gt->i915, r->min_graphics_ver, r->max_graphics_ver))
 			break;
 	if (!r->name) {
-		pr_debug("Forcewaked register not known for %s; skipping\n",
-			 intel_platform_name(INTEL_INFO(gt->i915)->platform));
+		drm_dbg(&gt->i915->drm,
+			"Forcewaked register not known for %s; skipping\n",
+			intel_platform_name(INTEL_INFO(gt->i915)->platform));
 		return 0;
 	}
 
@@ -225,8 +251,9 @@ static int live_forcewake_ops(void *arg)
 			if (!domain->wake_count)
 				continue;
 
-			pr_err("fw_domain %s still active, aborting test!\n",
-			       intel_uncore_forcewake_domain_to_str(domain->id));
+			drm_err(&gt->i915->drm,
+				"fw_domain %s still active, aborting test!\n",
+				intel_uncore_forcewake_domain_to_str(domain->id));
 			err = -EINVAL;
 			goto out_rpm;
 		}
@@ -245,23 +272,26 @@ static int live_forcewake_ops(void *arg)
 			err = wait_ack_clear(domain, FORCEWAKE_KERNEL);
 			preempt_enable();
 			if (err) {
-				pr_err("Failed to clear fw_domain %s\n",
-				       intel_uncore_forcewake_domain_to_str(domain->id));
+				drm_err(&gt->i915->drm,
+					"Failed to clear fw_domain %s\n",
+					intel_uncore_forcewake_domain_to_str(domain->id));
 				goto out_rpm;
 			}
 		}
 
 		if (!val) {
-			pr_err("%s:%s was zero while fw was held!\n",
-			       engine->name, r->name);
+			drm_err(&engine->i915->drm,
+				"%s:%s was zero while fw was held!\n",
+				engine->name, r->name);
 			err = -EINVAL;
 			goto out_rpm;
 		}
 
 		/* We then expect the read to return 0 outside of the fw */
 		if (wait_for(readl(reg) == 0, 100)) {
-			pr_err("%s:%s=%0x, fw_domains 0x%x still up after 100ms!\n",
-			       engine->name, r->name, readl(reg), fw_domains);
+			drm_err(&engine->i915->drm,
+				"%s:%s=%0x, fw_domains 0x%x still up after 100ms!\n",
+				engine->name, r->name, readl(reg), fw_domains);
 			err = -ETIMEDOUT;
 			goto out_rpm;
 		}
@@ -279,7 +309,8 @@ static int live_fw_table(void *arg)
 	/* Confirm the table we load is still valid */
 	return intel_fw_table_check(gt->uncore->fw_domains_table,
 				    gt->uncore->fw_domains_table_entries,
-				    GRAPHICS_VER(gt->i915) >= 9);
+				    GRAPHICS_VER(gt->i915) >= 9,
+				    gt->i915);
 }
 
 int intel_uncore_live_selftests(struct drm_i915_private *i915)
-- 
2.34.1

