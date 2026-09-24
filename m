Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB634C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89F910F4BE;
	Thu, 24 Sep 2026 12:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AkAncQGA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE4810F4BE;
 Thu, 24 Sep 2026 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251389; x=1821787389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=2Bw3DXnpCUougjLO7Q+YwFfliklcG3pTqZpKPrj7zRE=;
 b=AkAncQGAcvUsTD6cwf1GqYDeG40cBUU97r9gVRiAxhq0Lifk44/R+gHh
 shaX7MZqRWUkqwY9iFu8ilXD6ytj0ZN6r3y+KN2LK2+9ff+OvmkZlofgp
 Lx2+G9bfAgSABxq7jK4Di0EDRk1XJc5HdGpkMyoltOxZGNmpVENH3BruQ
 +fdwG/5sk9mUMuCT1GjWO0jcbYBBoKtEsfu0ymCl1FVIe653+vkoOrg/t
 BcOIvz5WPUKrwz5HDYELrEwFEn9suoe4iBwUGvH3uGqqgP9s4bjBI60+d
 XonzltEKoq9US+rZh8vVbNxqZbdXbLzuofoEGZPufyxr+v0A3l/IRE11B Q==;
X-CSE-ConnectionGUID: ySlHBj5ZQJCg/lh1BAMKFg==
X-CSE-MsgGUID: taTfYfC/RXmILSG8+XMK1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93516983"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93516983"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:03:09 -0700
X-CSE-ConnectionGUID: qbzI7yyMTJyrkVN377YkEQ==
X-CSE-MsgGUID: f6v2dUwsTD6XoE4WulJJIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="272148580"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:03:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:03:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:03:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwbBj31U4CXlYViQ4TKKBocdGYqqsKOqZfnFNr2d9UuZDSokZKZfArOX88RQlKuwxiaziltJwFrAVs/9WuNe9VUk2yFkD1ePQUxHbjP9jtbEEAjmoNkVjbnBCo1nuGbmR0VepOl1OND4zRKnXKKKDfL0qkw9zq59f8KxWUPzV8E89FQhJqnwKbtubA516ibFHmkU/pTSDzg/jts6wmwuE25vvvOnMssPaQ4AZ1hXkWUP5Yoy50YPEcBF4CCsLEELNV2mhH7baD4MHpZk/k4nc/h5EtIdSAJgwbNCxcel9eS4ekUvS/v9TkddoRBAblVYZQhG40ahTVFijajPZYO7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X+DsImTogWAwIrOv1lb+WFl+NF7pwRVbRdRqLBRw/I=;
 b=htfO0Lhu6EwqPe7+A9F6jbyh394qORU8jgzAePyim95fzGz4Mfl1SFAvDNrcBiGQbFzmPv7DAruXqK59t+F4gGS5kkkpjWnZ3nLJKi0l4HHjVXquv9e3SEGYiNZQjEcqNBLU8PJWfMyo4eqgkc4plkZY8X/xKSt9UxNaq/mYjzoVKip2uODID8BlAe+8ejprNsV//HM6TGkA+M7GV0jrU4rLPqAyNpf5JbF2iQWB+lgP0Spvyjw5gVpD5G55hg7sf8ju88xwo0WDu3nI7u19WVGZ4Bi0Are8nR0DrQQvT2GJEQ4C3qHnvhs3PdBa6GzVIo0BTJU/FWtAqeG6PGWtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:03:05 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:03:05 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 7/7] drm/i915/selftests: Use i915_* prints in
 i915_selftest.c
Date: Thu, 24 Sep 2026 12:01:47 +0000
Message-ID: <20260924120147.1305127-8-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924120147.1305127-1-krzysztof.karas@intel.com>
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9cffea-d450-4d3d-1885-08df1a33ca96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A1uyFgVS7wDEnBBvd5WC4VoP0uICIW3wH7AnqohFvTzZenDEIgo+TUf+PHbJCbAM5WagKbufJfzkcRsHWT4fMmA5YvekTpTvAhtPEO8CN+ywWdcKnnTvOp2nvsM1AiSUwEQiqj/A8p8TFYX/Cifokh+AxIoEq7+e6L/UT8q4InW+nugZpzcughdk3RcvmRfBrrthO1Y/VIGMPCdgOf/48ngM+d65M/bY6s1yXRlLc12ceunZOLn1IsfGAPsxIx2MJtZ0k934kamRcyE2WEOMoUZQ9ze7LnsIgpdQz6MPWT21DCa1bUfwn7SM9jljoQO25F3PoEeukRuUp4a+COZPRasa8LwRMBYN8HoXzL9NnlDg5MgrcjkRp/dB8kDYkJ2y+SKYoTCImHuRESTUYSRzjNbgVQt5VEq8qCPYsOsGAKVxHmZ08BLKQj9vS4vn+qWVnK8I8QVWqYj+/IF0PXkbWvYbeUJoWR3eSsKji41Hz8IUH7JUlolNc1pWicPVcqW1r39x8AfEQBrSn1IBfhW+c6cc8ZF5IrKrdWbtVExakuub98A3TY+Nt3FX5vLBrv73pskD9S03udqBUjLjyJL4k4ripI3Cr3tviZg1oVfpYFInXGqtDxk6eEpALowUkydYlPVmlDlBHm9YEHaAvNWVQcTEPT7wBg+vc6bw2RdIIow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CY4w2Ao4nggwrVGJuF0Sqh6KbaI6sClY5nu7722cuCXD5JGuI4V2rgVpoEmR?=
 =?us-ascii?Q?f9422/MIZ9RFyZhjfb6qOWyrW1kY6bkuZIDkACizty/0+7i/eaDpfAhs4CEJ?=
 =?us-ascii?Q?EUbW+PPJ8ZZz7LSnHDoybm79OmCwHZo6fXkXgttf5gPOiFHgEkDpyTpaTCsX?=
 =?us-ascii?Q?SbgG2D9Y1YA2VfEa1NMADipBGJ9rHs/mZVPJNnso73duSo/F7zHDKPrPQYfh?=
 =?us-ascii?Q?jP6rC370lmxH48/iwXzcffOFsTrqjJf74cFHbyqev8nQOBEoS/EIkuk0clyg?=
 =?us-ascii?Q?jRXfVsuqvfFdNlxuBV07HKHg1ylQkRhNM9v7+nkLRSfKCj9QLHAwLMLTzNnK?=
 =?us-ascii?Q?jRuXGjOWPh3YV/IWnXahNJBj3QFjEsAJ084CnGZVstjXahpirFanK0Y4p5dl?=
 =?us-ascii?Q?Njc2PvxU01ozPQAjs1spWmsZ+6YMvBTDlNANml8bU2APKm6/z/nlHfrgruc8?=
 =?us-ascii?Q?Grr1cRr0doPfTjVjFjBaduwO7IzQNfH/D92fnNDiFNeVzcexns4B6F/pNBTC?=
 =?us-ascii?Q?eRVMBnt7YsSJUi1m9+nmli5ZvIKYIKv9U4JzHxcdhZaZizG02f/gf12auMsQ?=
 =?us-ascii?Q?0tdU87yqIA1R27ft6D1cbQ8r/SNKIiut32M5aSn3bkTU31tI6l5J2dUgU6N4?=
 =?us-ascii?Q?cRUPPby5ySAam3h0I5gcwDdBO/j+x8xfzqz2eTKjmzw1okCPFIY0lZ+Iobz2?=
 =?us-ascii?Q?9x/7dOn4Fev7u/8Sh8+08daPu9chRtlFoIPvgr3TG3CA3idWe4sdSeLB0Q1e?=
 =?us-ascii?Q?pi5Qn2gt70qYLtI4shFsshZbX7tOMLa1CmTbN/l2iRZt1H/FX+2lnwET6GBh?=
 =?us-ascii?Q?hJw0PoZibbcjAhVw8y14QcOWdozXntDv5B7sKDtu4BanTtRTkZYzoo7LwhWp?=
 =?us-ascii?Q?M+TnpxhbxUtERBFSRYfwWwgctxOH3mzbW1Ygrbo4vyHpFUe7atUXONtuXLJl?=
 =?us-ascii?Q?MZg+8z/dXmNKS/N5dgd0L8MeE3WKANXeVL8su+W3Qf+NcOVSWTWBRaR7Kjp+?=
 =?us-ascii?Q?ypH0dEEk8hB6o+HA6Nk0Qr0qu3+WE0vGT8Zxv/Oo/pzq3IT8b3Svxsqwf3jg?=
 =?us-ascii?Q?VHv4S8cSKclaC+0Yzq6iWxGHfZ15B+DbV1Alzr/gnzOOuHSkhKd7ZQu4tA0G?=
 =?us-ascii?Q?spOpz3gxGOVGugesAp6FJHzZ6EQSJ0pJfZ2jnMJsKPEeRcDultmPksgxA2aR?=
 =?us-ascii?Q?mucnlHsOrgwgQYA71jVNORsryVtQkmSlEyDzTf9/nAHEK9hr8scrWefLCXjs?=
 =?us-ascii?Q?jNiGXWSVOjI3FRs7uMFrA8nu+v8ULAzIoJUyzhFFbLEu0YdkXf/nBGizy2Yy?=
 =?us-ascii?Q?ACH8SUeYrgOzDhhDfVG6qjbR5S5E6bw6HzWIw/8sycVqsqW1vI3kyHZzaRus?=
 =?us-ascii?Q?0rejGx9aLmLKJBesUIdTnQrSWgJjG04JH3ptL9TEh+ZRkru0y4FNFNgrJTxa?=
 =?us-ascii?Q?qv9s8FeOyaSUFZ4s/0naqNPL9DrChx7bgvEE0h16NDdwJmwU4uoeH/S5tS2G?=
 =?us-ascii?Q?hnuufQoQCpaLNrH4pjWOEm6rriu0UCGuop3oRPmcHvJ9MABDicrjZkPP/KUm?=
 =?us-ascii?Q?kVDVyxWc7vdygxNGEYlScluDTEKHlkyZvA4FsMayuErNMSoZqqUiZ3au9piU?=
 =?us-ascii?Q?KeIsIcxBTATCvkkPhk8hxajCknH7ruyafx92wkfSoSh7kQn7mwUg1PyeJ51t?=
 =?us-ascii?Q?rMqBwITPqTj9uQbE1O6K0iX/1m6mXUepwg17vXmzjWxFybKm47N+Vt1jj1R9?=
 =?us-ascii?Q?mxm/C4Aj2s6DHWSQvgJ5m3wDdDw/6xo=3D?=
X-Exchange-RoutingPolicyChecked: Io7vkjREBsJzGI1MkMvtNFxhyiGEupYEUXyTrGWsD3KyCYhK4k5Hdxz9AiEMEpNzoTRu10EKybPCb7KmU8jy7q+oezy6lWBToff1/I/MOzOdL4LxEsrNpBBFmxzu1TIeC+rfe4V9t8K+ZZM/uy5Hyq1p9qSnbv3/Fk1ZmA5WAZnimohsITwhVzJ5eTpXFDCM5tqw1ZcFWOAmWKKYuOiIaKjsoKC1H8c9wNqGZLyeUTYNreW82qZaDkePNPXjUa8IWS7AT20pp3YU9OcXKxYbNzafo879eeT2PC90zgbl0U64kgTQ39De12nnMrBQAGf8rzgt+uQk2pI1LmHrcbOakA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9cffea-d450-4d3d-1885-08df1a33ca96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:03:05.5609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+ASPQMeoWNjjvcFRDYW8PS4txk9hu4SaDt/xKos8soEKTdYOajU079WfbT972EgHzRoSIafAlIHX/pDuIJYU8Z8UCzDZFF0yDkGV97Gelk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
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

Move away from generic pr prints to drm device context aware
i915_* versions.

Assisted-by: GitHub-Copilot:claude-opus-5
Assisted-by: GitHub-Copilot:claude-sonnet-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
- renamed from "Use drm_* prints in selftest headers" (the title
  did not match the change) and switched to the new i915_*
  prints instead of drm_*;

 drivers/gpu/drm/i915/selftests/i915_selftest.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..4e2566189879 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -23,6 +23,8 @@
 
 #include <linux/random.h>
 
+#include "i915_printk.h"
+
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_regs.h"
@@ -47,7 +49,7 @@ int i915_mock_sanitycheck(void)
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
-	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
+	i915_info(i915, "%s() - ok!\n", __func__);
 	return 0;
 }
 
@@ -154,7 +156,7 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
 				     timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
+		i915_warn(i915, "Timed out waiting for gsc_proxy_completion!\n");
 }
 
 static void
@@ -178,7 +180,7 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait &&
 	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
+		i915_warn(i915, "Timed out waiting for huc load via GSC!\n");
 }
 
 static struct mm_struct *get_selftest_mm(int u_pid_nr)
-- 
2.34.1

