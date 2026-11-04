Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3373606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LxDMyPGd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A3210FB6B;
	Wed,  4 Nov 2026 11:14:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DD210FB83;
 Wed,  4 Nov 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790878; x=1825326878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=T8hS6VvHKnB7g8bO2RKXyOgNeMkNloU0RKcymVuxegk=;
 b=LxDMyPGdH69mxn4IkWh8OBbDeckEYmGshAuWaEHDyHxaaD/BUbYwgYu2
 /eqtXibahoBDpj7trn/cewBdCERAsl+sRWXMeKaU16kqpgwpsyXbSdTFU
 F01mLlhVsw4KaX1Z3hQLNxAsMecTnpMwcpTvO8rVThXkmufbMy4OmLnTJ
 Y/fv/g0kxcHMkFQzHPqxeIC6C6KnMFowfoiVkNZgK8XZ5sz3fD4BwS/eO
 umJDR6tWtO/JAABfL6AskUH4zpb6MVP8M+XKFw1SEu0IFuc5eA6mzwOdF
 fbGPknIx2ZrKMbb+iLuIffsO7g4Iy89cgIhU8xPD1DW0Cta6BiXDYC5wZ w==;
X-CSE-ConnectionGUID: +lOcu16lRTq022UeS7+tDQ==
X-CSE-MsgGUID: jNFHNQDjTzayT/yWNLaEEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2427047"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2427047"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:14:37 -0800
X-CSE-ConnectionGUID: CG28j/hvQPKiLdCgoCqyVw==
X-CSE-MsgGUID: yEm1QTk3QpS+tH/HTDa/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6512247"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:14:37 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:14:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:14:36 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:14:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSrSUjWjNe8KKR/YWClw6n9+Sr5vD3ej9bNhpXh2yknqT4WLyJGNR0Ppvc62/9nwKp8jNadrEflByfH3TS/LtLpxGGsfW7CQ7D5PgtpZBxK2D/sYRl+E6BZo0WM78e1UTXqZAIVh/EH9GRNZ73vXGGIuMDqXegg3RN+Nb1AeEEHHnX1YZ9i4F2qCIvTDw4dRRQd50syvNf+opSmg2HH/NGWzCJknUT0mwKD7mohGWdC4f4hCb8OodEdROaRNx4hJlLllfMqeY/oG5Qu6SVhqFnHeAeOdFbSqginIkH//1aJAns4AKm3gsOVDIKZOSMu78JDIp4iAoyKCuU3pDDFLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6NrkqsshPOgBzG3Cvd3ybL442covzDqZEiurhTNB2g=;
 b=B/wWR4vzt+QYJseOE4WriWPKihcb3AtcYlYypr0ePLI6JExB657elaFhwE6xxS1LeHmEIFl2NTyOfcWNUD9wI3pGVlBtzDDWfgnVwXiJTieMh0yc6NgQSgELZI0ZGPv1N9I+mMbqK2I46YjhwsFozOoyE4rSsyDo/n8MttVp2xmgo+ftXHwKwKKQCCyy7irQBS576S6NoRJrHJVnECFoMlSxjKqyaUKqHaT/K0U43XPo9KL3Wt9AhBmXmiOh9lpD9dSlMCoy492SGS/UyY+nKa1LEHHNorxKIE/2zXO9LIQPh3YFGG7aHOR8Jmjk3vt3DGrqJraKMFYjlsSs70E+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by SA3PR11MB7625.namprd11.prod.outlook.com
 (2603:10b6:806:305::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:11:31 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:11:30 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v6 6/6] drm/i915/selftests: Use drm_* prints in i915_selftest.c
Date: Wed, 4 Nov 2026 11:11:04 +0000
Message-ID: <20261104111104.946617-7-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104111104.946617-1-krzysztof.karas@intel.com>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|SA3PR11MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: f9949495-9d31-4155-645e-08df3a6460e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261021123027099003|261021121427099003|11063799006|56012099006|261022105027099003|261102123227099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /MGnUvs/M1ZuzJm//S1EBLlBKBS1ZNNbzTd0waTQUa0y+C4kzQZJiaywYOWt32ZX4CspEntlhRU+gURoE/mMsKr9S0VZNAUaUPhG3ZwnrGkVUI1wCH4PsZLkWijIpJufpJNA4rvuPgbVPFtRG7CdlZXbb60sJamubhSSgY5BIbbOOB0qaDaeKCGP05gCdFgQhlmT4aGnSTwg8bzB0aEXezPRX+ZZDph0rMXrY5F3TraXRZ0Z5eMSgcRJgDwvsEeS607XOlxrgTuyCXnzf4GmW9HEKI85zOC2I/wcirFTK3U0KKBZWGDZ1kXWTAMj5x3poN4Aao+S+GdeXC7Ko94W0QfX6S1kBXm2UU3ostn2rxYIx6YiIjYDyjnRPeQsA4PR2DkWGN/q11bbLlZ13C1OQN9vDoDdXVkVwIGh1L5Glli64tPelhFxBfHwN3YZ4S2ZYMgpMX62Vcm/zHLAlbHVl/+JOZoAwjXkVunzuUSx/Q04k46FlfSo0DFXtONmcJbLQIZBwF3IcaDDXRcwB9Vm2308+FArYLWfB7N2kvcovSsnMxroQxCvlBKFqaVYcRulcgUYFitozMcwbOZU3X67/ZvoUxiQhKzTg4D5lZiwuestcLVop+jULL7THt38xeDTqQBvLC1JIIjGXHYmylt5bYd7DwU97jnoQVGHlnsVddA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uk7pKN2ZOf8xp5xTW9uhFoamqIwoTVqTvyGA9CXHcWEU3r4gvLJCvNYCnQ9i?=
 =?us-ascii?Q?+FtDZCc83OazkZ9KxLWCGcnFplYS20AjtT8iVQ4Tbtilg40wK0Lh9/0bw0Fy?=
 =?us-ascii?Q?L1KhWsvZSEAvN8sv3ji/eVfYGvMVV0JIVr1G3hMEdIYeAod+3JxnZgksV8pW?=
 =?us-ascii?Q?pvXXLatIB4B3dXQv+ieNc87idTdwn1dlbJqR+zC4PBuqbWley2+iEpOp+BGm?=
 =?us-ascii?Q?e4y5K3SJKVYJSmCUDlZ2oi7Gw0x4l222C60p1x1841dwCY3zuEe30A9ben/G?=
 =?us-ascii?Q?BFgah8gRU0SigHc65kzXiaUP6pt6VDQ+RuL26sYRWeaxQGfr2fgEhE/fwJV2?=
 =?us-ascii?Q?36802MBK/TIorG842tN4wdwxWfnUOfZ547Vh3LfdMIyvR2iwaezd/EFIK2Gx?=
 =?us-ascii?Q?1iV+6OJSDUHs1w3mPYPFzWjdtFC0iUGAM730Fez9w8vT1KBqj6eQfBbHNG0l?=
 =?us-ascii?Q?fVPgUz6CjOLXzdmQbYG89khbTZlqIuZLnjVQ48Ta7r2y03Ibe/wG0xLSRdbU?=
 =?us-ascii?Q?ZFAsjoByCENJEsm2bSU2fOM7xUnMe4tEnAu8RJtJ5eg+8oozNkpSAYQEfh0K?=
 =?us-ascii?Q?5OPtKk+gKlp1V0cX0YBz/cGozSf7JSOHauI2USStLsGJqka96nxHIfqN7ARa?=
 =?us-ascii?Q?837J70p63BY9+6CthDA4w7G0fVZNj6stRbmLWiEQcw4yjA5hTgnWiGYN9W5s?=
 =?us-ascii?Q?gO3e+iEJeqlfL4zJ6bDARGvp4gjEY2iDv2uWtBfs6jJ7KYAPOJ+5D8vdUkAu?=
 =?us-ascii?Q?ecZI9q9JNsvmuZa6Z8f+5tOkXvjo8ddA9oY3q01NTw+53l6u7XDmX9fbC3SA?=
 =?us-ascii?Q?TP7zwymsoWlLn/tBjRPOI/ZW+oWQwEESRGfD0uJgl2Mmmgpdgl8fi1+xZ4Fh?=
 =?us-ascii?Q?gipmYeyyptng16V6jOAY2rz6M8qSG48oF91tkhKaMZneJHJ7z9M0U6P1jBQ6?=
 =?us-ascii?Q?zrxxqquG93tzzhiPSqJvmxF8/m7R9unwKCqfzAiouQKYhuyAq6t4Nnfasygf?=
 =?us-ascii?Q?/utBgt6EcepKVKavIwABU381dHU3QtR9x97X9C3ASr8Uwivalx/EzaProM/k?=
 =?us-ascii?Q?s6mJuyRaHn1ujPmjNxt7gbMdbSuewCKpqsV2aK9p4MLHBPyOXw7vJ0bpeirF?=
 =?us-ascii?Q?8Cy5UM3gXy076LodyUDnhUihuY5bplo3RttDclCYY/Nt7IhfneMHaw9mgDZ+?=
 =?us-ascii?Q?JgCPZwx1fN2oV6ZDEROxQfrOmuMOYnZi32LIbkv7a31T/3HtT5Qni8q8mUnC?=
 =?us-ascii?Q?CSj6RM56YRobxoTDEeZDR8OS5/LJmuu8LAxyMl0Oyg7/li4YPhA9oSkZPI9t?=
 =?us-ascii?Q?4couQDrJdcrsFEpV9u2+sC+w93nfmXywmHHGAaqxk5rg7o6zhmEErlQ0yxfJ?=
 =?us-ascii?Q?oKEudzgBgq4MaZFOETgBshQ2sYTr58dR65hgv/zGSESSfWc1ugtsp1s+zN+0?=
 =?us-ascii?Q?+g4ARau3kGzwNYWr9DtRFBNalTmIOoS5v86Wl1hl0F5/TIsCNl3o3Og4Jc9F?=
 =?us-ascii?Q?Sf7iqJ3Bkb1oDRVEKxC7MN1ugbG8V+t4QrtFTpKMA+3AaV+RHkrBAEWkx5IT?=
 =?us-ascii?Q?O/grFCjubNapcy4TbW7XXKWBL8GWqmo5CEIeGW0xgRWtVQ4IGGzktGPaF4Vk?=
 =?us-ascii?Q?I+sIWYjpv7b+DVIfIs6UXTTu8C5lIFv+1RyIZU44aw7og1pa1lksL0HtRRfk?=
 =?us-ascii?Q?bM5DxLEdWU6A9qnfXOOvS+5++jwjAcbBcWNSG+7zqMJgBwQSoeVc8oh4khRx?=
 =?us-ascii?Q?33WISJ5+CAKFww0tnowrRJtkJ0h9HE8=3D?=
X-Exchange-RoutingPolicyChecked: 5ZHOCWafhoWLdJyTVpPPBh6WoVh/8tcGH2BFE+ajymaU4aRy7b6HbLo9DjVzDN+bljK3niWqZXUYnzs/5lNQV9YAH8ZIH2REqVWBr3M6jiOV45w/lbuXSEDaCODmkYfZw5/4cE7lBzCJiqqVmdlm0tIDkMUr4Dkbt5ci2ep/baRrs0JoF8/vCkL9416+hfnYgxLeKe1jiJa46FD2MznM5ep8qq7l/Onfghc7hRdRWY32zBuX5KJoaGZpakQ3pAVgCv0ePlZRrcex47ckdEZPKZrpeEXWOTYcDvsisTzdTD3r8yPM9td3t85TfkTG3F5228KQ352Z6r1R3fCIi4sm4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9949495-9d31-4155-645e-08df3a6460e0
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:11:30.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/cpT4UnxzGOeESdrxy7VYh/Uh/ZUbqDfzNxvT1bzqcsjBfjSXbSh92X4UmHgwaBuTZ4Hsy+ezDCAaKSCl1L8Oz+s3Vq+2RBWOKuJvJf024=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7625
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move away from generic pr prints to drm device context aware
drm_* versions.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_selftest.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..10198828e7fb 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -23,6 +23,8 @@
 
 #include <linux/random.h>
 
+#include <drm/drm_print.h>
+
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_regs.h"
@@ -47,7 +49,7 @@ int i915_mock_sanitycheck(void)
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
-	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
+	drm_info(&i915->drm, "%s() - ok!\n", __func__);
 	return 0;
 }
 
@@ -154,7 +156,8 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
 				     timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
+		drm_warn(&i915->drm,
+			 "Timed out waiting for gsc_proxy_completion!\n");
 }
 
 static void
@@ -178,7 +181,8 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait &&
 	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
+		drm_warn(&i915->drm,
+			 "Timed out waiting for huc load via GSC!\n");
 }
 
 static struct mm_struct *get_selftest_mm(int u_pid_nr)
-- 
2.34.1

