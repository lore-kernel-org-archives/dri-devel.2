Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71545C9831C
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608B710F4C4;
	Thu, 24 Sep 2026 12:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HjJNd7/7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EC710F4C2;
 Thu, 24 Sep 2026 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251388; x=1821787388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=+hUEZ6eCPX9dFL36j7Y4KfBk4V7/CjabxoO7qAU0b4s=;
 b=HjJNd7/7hytcAAH6CZwG7nNSYaDzYFgbWYFTpqwC/bNDV/ZB8Wu3yT0i
 EXn+0nLYb4U7Zcfihlya/iVC/GudDiLFxrItpx/vGcF7iEJBlSD31tgXB
 22zgzvgtkTtEkVJ4JcCHmGQhsnZfXquKvkgMR7k/5LLJDTSS44/SqkFDy
 vLTHX00H32/DnDMuq7Z7XroDOQFOBJQTzVOVdKB2QAbrZMv2m/FhCPw9I
 jQ1bCkKqAh+onqw70Hs1lCQh36NSmZNILSVCrJzqiY58TO8D9niuDnGjb
 vEPeEIQBhFengmvk2ehdLzZOLIZudHlK8bE6X9ytTLCkTodBMqBl8L7yE g==;
X-CSE-ConnectionGUID: 0nU/8vqwR0ykYx/Z0SHCBw==
X-CSE-MsgGUID: UE2mBAeFQlyly7Ug0jBxcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91123440"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="91123440"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:03:00 -0700
X-CSE-ConnectionGUID: AuABy/0TSYyXS/fp2RxXyg==
X-CSE-MsgGUID: D+5afGfMT4G4jgmqlApyGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="270492691"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:03:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:02:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2cuZlOktH/PBlP4LLDKHMf1D02MdGdq/MV+XAjfpgSsF1uMO9w9pHMfyxCXrLLPhRl3BVF4xg/gsNkGZKgKzi6xg4s4TS0XAmhvMDexHNKSmpzcX8Rh9oSxJ+fZ6RVS1AbTyx8kaoGCg6gywW7iZPTI5fa4NvFq3gw9GFA42BvFW15x21/3BkEOuPRNSBg6QFu5Q4CONS4RddFgwOxwsSGd/gYqRcf8DRFcyWhVVI//ZcUFpYTDJ0rvntOPKwv5v2FR/uaavRTDzrbDrnpBlp8CiSip8tGDLWyvpCS+hRQR3AeQTZQY3degavXeE4qTzV+QO55xv0ukP+qHNNzjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrJWCjdeYjfmgv3x13cHc2Xd8ZoELAV6SrsXaOW9lK4=;
 b=uOwQqBh+G320RdWc71Btmfs2m2+483DOfUyky5negomuR8sdWEkWdKN6oSABgdo78UxzzuCNlTgwRgL7DT4WgUyeXSOD/FZY17YtvIYxew0Nr/m+vUndXnPsNWD2s4X/yfhWXvJDnJyWDmWsfMMMzGiK/mZARA1/OF/ZC3c8VryvDu+mcC94A+dxx1mvZN303xxkjIBJhc0zDIQuM75u8vZLsQZ40S75D2CZrSKPSGxO0Xzj9oWIRG1j5HXLljLFaVrr6JIEbyA7jSVmjX3l5/qNmVWIgeuzAi1PKwRVViAUaV3PujBi8zGjv0IvPjpLEteFsBQZULqqzlJKhjuhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:02:44 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:02:44 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 5/7] drm/i915/gt/selftests: Use gt_* prints in gt
 standalone tests
Date: Thu, 24 Sep 2026 12:01:45 +0000
Message-ID: <20260924120147.1305127-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c4f4ce2-d9cd-4962-0b3c-08df1a33bd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 1QPxU4onQBtJB2hQvuqcGkmhggBC5gaS+sdECg1BeB/DKrHWcKeBL+y4F1PX3n9uhpkuSIwwOwsqU6bcsquZVXbpQAFmlAaolal49Uj9KdUBsCM+dUTzKk4goLb/z4Cwk0TwzT3zEJY7/Qbu/K9ID3avtAx3MicLUFm4+LFyUZDC1ktJ1gUb8kOi8IzFmErA1LphKMSi3iuaEKPFriJs4pYbzd2u5CEstA54WJ8pqi0zKHdmyAnOY//PJTkHW1CsBt/KP6LdemKXO8k173MB3rEfBSzb64HqmhjIevAZ3y1fzXq6eIfXBpkQNkwaTUnMyUClcYNICs4lm6oOn9mAXuOVVfUPqZxYRo6NL84a4+TQfZPOSksdFGQ0nWqhEVED3fl6HHD2ri0lKa9UkI/yUjJPT65Uvl0QPDzOZ0eTrfnOFB6t+FgTDGfN5SrU9jJYdTK/c+0BciDeGbwELa+QFn5vySB7GL0ZXFj+OkFt/Islf46pgScKvD19gm6ifRl5NvtZtfDDoXDG0VO0Jula0492Vp6QXGkV+P/iJmrZ0ZMpryd69rhWMOsTu6XfxFGECr9J3b1NEYO6IQ1/oZ57UwKK9ORcFFwzPE6Z6fHfRfkoquRBFMM/aR8nVKmTBJJ3O+ymroWOwLxFMdjn8kJSXuqazWSpIyVxEup2dtc5oYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdFQqqsrce7SKe/gsJ3BX5iuWiS3niE6sOa8uCgJ9fp1uWcRnlldg+76FQ+o?=
 =?us-ascii?Q?/U41UXN6oWQ8fHp7H8XeR2Hy+tS8Tc0Z27KEjx2FZHSktMloMD7lBcYUSjnh?=
 =?us-ascii?Q?JVKB++MaV5JhSSG2OWwZGI6q+wHpid9V03YnBf+j4+KDtpGPcQrxKDw7jJRa?=
 =?us-ascii?Q?RV+He4ipZQUrSflUwW4YyvHBxASWVJ9cq0LeG/AILd+bA3hlIQbtb511z/0m?=
 =?us-ascii?Q?spitPa5YDgencMBA8XptZMPtkdF15ujzfn7cJ0/EAglfVBXR/Ev2ZJ/QbHF3?=
 =?us-ascii?Q?gcMb26ohJFOdZBsnZHNgMGeXsBwuaC3q4xAXj4hhLlqxrc+jW7GQ7lGCuwh2?=
 =?us-ascii?Q?F1LT4yAoiYu8khttCJFUTXbPalJncH6ANOLIRrElQ5VTVtLYQEOiGbp0kUX5?=
 =?us-ascii?Q?a/4VjWSOfYj+V8v76KXksv99/NI7sI+bg+bphhKe8GsEVW7bnul2xWKgGid/?=
 =?us-ascii?Q?Vmak5NLfjKCNOETzrW+1JgXwcOIcPVLpoQRk/tJePuBfUOws3SGiXfx3R8uP?=
 =?us-ascii?Q?QX9lrs6kOtFnuD90HhmXbnw3qnyPfoL88cOFIVn61bdoi+ET/fMYd2OaalvS?=
 =?us-ascii?Q?s3Ae6j8jpmFukkwHTfRdqhWE0pVTZm9FjeNM1mTzwoguqSK9hemdpsUgpQGG?=
 =?us-ascii?Q?+XuvkLxX5sBR1Wvfph0jsKqcFE5itb5eVK021gnYnwKs6uw26fbOAZ7jWsf4?=
 =?us-ascii?Q?EU9jcbsR6RHEY4SGGfP1613KTXk8iftpfwr/b+ZQHADg57aJawrYCE+kDM88?=
 =?us-ascii?Q?9GkcyAbRresSGG5Z6wVZ5IKyUhIqUD/mXh5xkVDAQ/E2sTxtxMcV+lchwbZm?=
 =?us-ascii?Q?Vp18Ib36XqDlf0JQYZ4XcyQsvjyLmFTzi5lV4GqCJB0nFmOQaPySm1Nxh/sp?=
 =?us-ascii?Q?rs4nR8JWqrBB83OUO846oJefcvTyfthH3d//LPUSpc8ZGn5VAXLmqfptmQ7u?=
 =?us-ascii?Q?hxseA7eiOTyuD9Wb55gwSTxR2+VwN98TAsqav8HouPR7FBCd5dqVE2840EZi?=
 =?us-ascii?Q?xGX9N4fDyleiyXCC+HhbBTDSQBtz4cKEVufSgxDKr6sMMrcWzVFVZ1+usOQL?=
 =?us-ascii?Q?G6BQUFrIsQvYpAiWO1gc6u4tQTGZYFl94ya34xxLzTj7XtSJnwrLxvqo9Hsj?=
 =?us-ascii?Q?3yn/HfL1Cz2/5oHHCXCjNnCqnZ/hur2t1U+6h9/3LwA4ikLiuvjQLbspcttZ?=
 =?us-ascii?Q?cL2zNPrwct37JmykMOAgpWHkUf4wUIeasm30HaWrppRgP/TJMyNwGZQT4B4m?=
 =?us-ascii?Q?uDCHLbVXQ+3w0iQoVFYtUdHICJdzGET/1SE3QRLOphiGpapcMs2WKpVcT4TG?=
 =?us-ascii?Q?GLbh0LycWu86uWiXuF1Om/AWD6Po9mqMvqsz6Zj8kqS+9skpWoxXtFxO4dEu?=
 =?us-ascii?Q?dAGTf3HUJFXWOV/ChoSZemWwOQcrT2KsnJn+1lXTP6wJ7hPy0fStjFXxRNKF?=
 =?us-ascii?Q?1uuIUlnc0Q1LrwTvaaVMriMwjYmXetUSJKlxSBelVv4yIOrb4/y92KSnvASj?=
 =?us-ascii?Q?8vc2IRB6CnIbtTYJBSN0ExZu4UU3lfnZD8udc6wyw1/zYgH7kg5mfuVptY2a?=
 =?us-ascii?Q?v3JpHzSoZw1Cd3jkqQZRZEybs7yaD8hGrzmGnJZ/hj6aQE0fv37+LEGf54N+?=
 =?us-ascii?Q?hBXzcYTYlrp5y64jkWVzesuAuwZLXXZDGHlkVMOmIqTygY+zpaU67q/C4U9x?=
 =?us-ascii?Q?8+el1O5xXgSP7ZNXznDePXiBl/bnxy8Pbf3w0fFKWeXtVEbmv+JUQegXrfhq?=
 =?us-ascii?Q?edyzb/7Zc4HGKpQaGDASFLwwK+zdCXo=3D?=
X-Exchange-RoutingPolicyChecked: Q9mEMaMT/N2y+MAd4NNp0exY8mSgs4gLV4MjImmjpb4yF5LwmmoYyBp6L0hgIJ0ybt7EblzC6FqNuKAjhI9VbCr/PYRcwv0Rfcl2f0spuraBb2nuRYI4ZDUmWn2CVUlrknme3sIjMjrAnpjir6WPaSJma46QucgVcukP9Hy6njnHaL+/a5mQ8jb8pToe0z+B5fWy3H3fsfYPkCNH1KRiqDs4hcDjdtBiCEvo/Mj8iDcswgF8yTm1adKN1MFN/qJcBCxCNXA/4ZBkfV9Lacbf1CwHye3RQJNZ8oAbVVPVoutnoMRRFgB5Ti8hVUvbHlrmefzZGIFp/J34KTpa4EU8zA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4f4ce2-d9cd-4962-0b3c-08df1a33bd7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:02:43.6086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDrdWD/F7I6lD2ZS1dV2SBty9zV3s1v0CGAnZOrx/P7eaM8QSp3VUjPahRzVw1YsQDBmmO9ZLx6/scRN37614IPo6sbNC2610lK02Jg3Gtg=
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

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with device and the tile it came from.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
- switch drm_* to gt_* throughout both files (Andi Shyti);
- restore the RC0 power/freq message that had been
  inadvertently downgraded from _err to _dbg level (Andi Shyti);

 drivers/gpu/drm/i915/gt/selftest_rc6.c |  32 ++++---
 drivers/gpu/drm/i915/gt/selftest_rps.c | 126 ++++++++++++++++---------
 2 files changed, 103 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_rc6.c b/drivers/gpu/drm/i915/gt/selftest_rc6.c
index 68fb1830d411..a88b39733364 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rc6.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rc6.c
@@ -6,6 +6,7 @@
 #include "intel_context.h"
 #include "intel_engine_pm.h"
 #include "intel_gpu_commands.h"
+#include "intel_gt_print.h"
 #include "intel_gt_requests.h"
 #include "intel_ring.h"
 #include "intel_rps.h"
@@ -80,7 +81,8 @@ int live_rc6_manual(void *arg)
 	res[1] = rc6_residency(rc6);
 	rc0_freq = intel_rps_read_actual_frequency_fw(rps);
 	if ((res[1] - res[0]) >> 10) {
-		pr_err("RC6 residency increased by %lldus while disabled for 1000ms!\n",
+		gt_err(gt,
+		       "RC6 residency increased by %lldus while disabled for 1000ms!\n",
 		       (res[1] - res[0]) >> 10);
 		err = -EINVAL;
 		goto out_unlock;
@@ -92,10 +94,12 @@ int live_rc6_manual(void *arg)
 
 		if (!rc0_power) {
 			if (rc0_freq)
-				pr_err("No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
+				gt_err(gt,
+				       "No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
 				       rc0_freq);
 			else
-				pr_err("No power and freq measured while in RC0\n");
+				gt_err(gt,
+				       "No power and freq measured while in RC0\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -114,7 +118,8 @@ int live_rc6_manual(void *arg)
 	dt = ktime_sub(ktime_get(), dt);
 	res[1] = rc6_residency(rc6);
 	if (res[1] == res[0]) {
-		pr_err("Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
+		gt_err(gt,
+		       "Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
 		       intel_uncore_read_fw(gt->uncore, GEN6_RC_STATE),
 		       intel_uncore_read_fw(gt->uncore, GEN6_RC_CONTROL),
 		       res[0]);
@@ -124,21 +129,25 @@ int live_rc6_manual(void *arg)
 	if (has_power) {
 		rc6_power = div64_u64(NSEC_PER_SEC * rc6_sample_energy[1],
 				      ktime_to_ns(dt));
-		pr_info("GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
+		gt_info(gt,
+			"GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
 			rc0_power, rc6_power);
 
 		if (2 * rc6_power > rc0_power) {
-			pr_err("GPU leaked energy while in RC6!\n"
+			gt_err(gt,
+			       "GPU leaked energy while in RC6!\n"
 			       "GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
 			       "RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
 			       "RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
-			       rc6_freq, rc0_freq, rc0_sample_energy[0], rc0_sample_energy[1],
+			       rc6_freq, rc0_freq,
+			       rc0_sample_energy[0], rc0_sample_energy[1],
 			       rc6_sample_energy[0], rc6_sample_energy[1]);
 
 			diff = res[1] - res[0];
 			threshold = (9 * NSEC_PER_MSEC * sleep_time) / 10;
 			if (diff < threshold)
-				pr_err("Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
+				gt_err(gt,
+				       "Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
 				       res[0], res[1]);
 			err = -EINVAL;
 			goto out_unlock;
@@ -265,12 +274,13 @@ int live_rc6_ctx_wa(void *arg)
 			}
 
 			intel_gt_pm_wait_for_idle(gt);
-			pr_debug("%s: CTX_INFO=%0x\n",
-				 engine->name, READ_ONCE(*res));
+			gt_dbg(gt, "%s: CTX_INFO=%0x\n",
+			       engine->name, READ_ONCE(*res));
 
 			if (resets !=
 			    i915_reset_engine_count(error, engine)) {
-				pr_err("%s: GPU reset required\n",
+				gt_err(gt,
+				       "%s: GPU reset required\n",
 				       engine->name);
 				add_taint_for_CI(gt->i915, TAINT_WARN);
 				err = -EIO;
diff --git a/drivers/gpu/drm/i915/gt/selftest_rps.c b/drivers/gpu/drm/i915/gt/selftest_rps.c
index be77fba2ec49..0c5bccfddd3a 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rps.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rps.c
@@ -15,6 +15,7 @@
 #include "intel_gpu_commands.h"
 #include "intel_gt_clock_utils.h"
 #include "intel_gt_pm.h"
+#include "intel_gt_print.h"
 #include "intel_rc6.h"
 #include "selftest_engine_heartbeat.h"
 #include "selftest_rps.h"
@@ -204,12 +205,12 @@ static void show_pstate_limits(struct intel_rps *rps)
 	struct drm_i915_private *i915 = rps_to_i915(rps);
 
 	if (IS_BROXTON(i915)) {
-		pr_info("P_STATE_CAP[%x]: 0x%08x\n",
+		gt_info(rps_to_gt(rps), "P_STATE_CAP[%x]: 0x%08x\n",
 			i915_mmio_reg_offset(BXT_RP_STATE_CAP),
 			intel_uncore_read(rps_to_uncore(rps),
 					  BXT_RP_STATE_CAP));
 	} else if (GRAPHICS_VER(i915) == 9) {
-		pr_info("P_STATE_LIMITS[%x]: 0x%08x\n",
+		gt_info(rps_to_gt(rps), "P_STATE_LIMITS[%x]: 0x%08x\n",
 			i915_mmio_reg_offset(GEN9_RP_STATE_LIMITS),
 			intel_uncore_read(rps_to_uncore(rps),
 					  GEN9_RP_STATE_LIMITS));
@@ -264,7 +265,8 @@ int live_rps_clock_interval(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
+			gt_err(gt,
+			       "%s: RPS spinner did not start\n",
 			       engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
@@ -290,7 +292,8 @@ int live_rps_clock_interval(void *arg)
 						  GEN6_RP_CUR_UP_EI),
 			     10)) {
 			/* Just skip the test; assume lack of HW support */
-			pr_notice("%s: rps evaluation interval not ticking\n",
+			gt_notice(gt,
+				  "%s: rps evaluation interval not ticking\n",
 				  engine->name);
 			err = -ENODEV;
 		} else {
@@ -330,20 +333,23 @@ int live_rps_clock_interval(void *arg)
 			u32 expected =
 				intel_gt_ns_to_pm_interval(gt, dt);
 
-			pr_info("%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
+			gt_info(gt,
+				"%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
 				engine->name, cycles, time, dt, expected,
 				gt->clock_frequency / 1000);
 
 			if (10 * time < 8 * dt ||
 			    8 * time > 10 * dt) {
-				pr_err("%s: rps clock time does not match walltime!\n",
+				gt_err(gt,
+				       "%s: rps clock time does not match walltime!\n",
 				       engine->name);
 				err = -EINVAL;
 			}
 
 			if (10 * expected < 8 * cycles ||
 			    8 * expected > 10 * cycles) {
-				pr_err("%s: walltime does not match rps clock ticks!\n",
+				gt_err(gt,
+				       "%s: walltime does not match rps clock ticks!\n",
 				       engine->name);
 				err = -EINVAL;
 			}
@@ -424,7 +430,8 @@ int live_rps_control(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
+			gt_err(gt,
+			       "%s: RPS spinner did not start\n",
 			       engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
@@ -434,7 +441,8 @@ int live_rps_control(void *arg)
 		}
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not set minimum frequency [%x], only %x!\n",
+			gt_err(gt,
+			       "%s: could not set minimum frequency [%x], only %x!\n",
 			       engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
@@ -451,7 +459,8 @@ int live_rps_control(void *arg)
 		limit = rps_set_check(rps, f);
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not restore minimum frequency [%x], only %x!\n",
+			gt_err(gt,
+			       "%s: could not restore minimum frequency [%x], only %x!\n",
 			       engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
@@ -474,7 +483,8 @@ int live_rps_control(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
+		gt_info(gt,
+			"%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
 			engine->name,
 			rps->min_freq, intel_gpu_freq(rps, rps->min_freq),
 			rps->max_freq, intel_gpu_freq(rps, rps->max_freq),
@@ -483,7 +493,8 @@ int live_rps_control(void *arg)
 
 		if (limit != rps->max_freq) {
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
+				gt_warn(gt,
+					"%s: GPU throttled with reasons 0x%08x\n",
 					engine->name, throttle);
 			show_pstate_limits(rps);
 		}
@@ -523,14 +534,14 @@ static void show_pcu_config(struct intel_rps *rps)
 
 	wakeref = intel_runtime_pm_get(rps_to_uncore(rps)->rpm);
 
-	pr_info("%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
+	gt_info(rps_to_gt(rps), "%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
 	for (gpu_freq = min_gpu_freq; gpu_freq <= max_gpu_freq; gpu_freq++) {
 		int ia_freq = gpu_freq;
 
 		snb_pcode_read(rps_to_gt(rps)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 			       &ia_freq, NULL);
 
-		pr_info("%5d  %5d  %5d\n",
+		gt_info(rps_to_gt(rps), "%5d  %5d  %5d\n",
 			gpu_freq * 50,
 			((ia_freq >> 0) & 0xff) * 100,
 			((ia_freq >> 8) & 0xff) * 100);
@@ -669,7 +680,8 @@ int live_rps_frequency_cs(void *arg)
 
 		if (wait_for(intel_uncore_read(engine->uncore, CS_GPR(0)),
 			     10)) {
-			pr_err("%s: timed loop did not start\n",
+			gt_err(gt,
+			       "%s: timed loop did not start\n",
 			       engine->name);
 			goto err_vma;
 		}
@@ -680,7 +692,8 @@ int live_rps_frequency_cs(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_cs_frequency_at(rps, engine, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+		gt_info(gt,
+			"%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
 			engine->name,
 			min.count, intel_gpu_freq(rps, min.freq),
 			max.count, intel_gpu_freq(rps, max.freq),
@@ -692,7 +705,8 @@ int live_rps_frequency_cs(void *arg)
 				   2, 3)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+			gt_err(gt,
+			       "%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
 			       engine->name,
 			       max.freq * min.count,
 			       min.freq * max.count);
@@ -706,7 +720,8 @@ int live_rps_frequency_cs(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
+				gt_info(gt,
+					"%s: %x:%uMHz: %lluKHz [%d%%]\n",
 					engine->name,
 					act, intel_gpu_freq(rps, act), count,
 					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
@@ -807,7 +822,8 @@ int live_rps_frequency_srm(void *arg)
 			goto err_vma;
 
 		if (wait_for(READ_ONCE(*cntr), 10)) {
-			pr_err("%s: timed loop did not start\n",
+			gt_err(gt,
+			       "%s: timed loop did not start\n",
 			       engine->name);
 			goto err_vma;
 		}
@@ -818,7 +834,8 @@ int live_rps_frequency_srm(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_frequency_at(rps, cntr, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+		gt_info(gt,
+			"%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
 			engine->name,
 			min.count, intel_gpu_freq(rps, min.freq),
 			max.count, intel_gpu_freq(rps, max.freq),
@@ -830,7 +847,8 @@ int live_rps_frequency_srm(void *arg)
 				   1, 2)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+			gt_err(gt,
+			       "%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
 			       engine->name,
 			       max.freq * min.count,
 			       min.freq * max.count);
@@ -844,7 +862,8 @@ int live_rps_frequency_srm(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
+				gt_info(gt,
+					"%s: %x:%uMHz: %lluKHz [%d%%]\n",
 					engine->name,
 					act, intel_gpu_freq(rps, act), count,
 					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
@@ -915,7 +934,7 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_add(rq);
 
 	if (!igt_wait_for_spinner(spin, rq)) {
-		pr_err("%s: RPS spinner did not start\n",
+		gt_err(engine->gt, "%s: RPS spinner did not start\n",
 		       engine->name);
 		i915_request_put(rq);
 		intel_gt_set_wedged(engine->gt);
@@ -923,7 +942,8 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	}
 
 	if (!intel_rps_is_active(rps)) {
-		pr_err("%s: RPS not enabled on starting spinner\n",
+		gt_err(engine->gt,
+		       "%s: RPS not enabled on starting spinner\n",
 		       engine->name);
 		igt_spinner_end(spin);
 		i915_request_put(rq);
@@ -931,14 +951,16 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	}
 
 	if (!(rps->pm_events & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: RPS did not register UP interrupt\n",
+		gt_err(engine->gt,
+		       "%s: RPS did not register UP interrupt\n",
 		       engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->min_freq) {
-		pr_err("%s: RPS did not program min frequency\n",
+		gt_err(engine->gt,
+		       "%s: RPS did not program min frequency\n",
 		       engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
@@ -955,13 +977,15 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_put(rq);
 
 	if (rps->cur_freq != rps->min_freq) {
-		pr_err("%s: Frequency unexpectedly changed [up], now %d!\n",
+		gt_err(engine->gt,
+		       "%s: Frequency unexpectedly changed [up], now %d!\n",
 		       engine->name, intel_rps_read_actual_frequency(rps));
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_iir & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
+		gt_err(engine->gt,
+		       "%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
 		       engine->name, rps->pm_iir,
 		       intel_uncore_read(uncore, GEN6_RP_PREV_UP),
 		       intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
@@ -981,13 +1005,15 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	rps_set_check(rps, rps->max_freq);
 
 	if (!(rps->pm_events & GEN6_PM_RP_DOWN_THRESHOLD)) {
-		pr_err("%s: RPS did not register DOWN interrupt\n",
+		gt_err(engine->gt,
+		       "%s: RPS did not register DOWN interrupt\n",
 		       engine->name);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->max_freq) {
-		pr_err("%s: RPS did not program max frequency\n",
+		gt_err(engine->gt,
+		       "%s: RPS did not program max frequency\n",
 		       engine->name);
 		return -EINVAL;
 	}
@@ -999,14 +1025,16 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	sleep_for_ei(rps, timeout);
 
 	if (rps->cur_freq != rps->max_freq) {
-		pr_err("%s: Frequency unexpectedly changed [down], now %d!\n",
+		gt_err(engine->gt,
+		       "%s: Frequency unexpectedly changed [down], now %d!\n",
 		       engine->name,
 		       intel_rps_read_actual_frequency(rps));
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_iir & (GEN6_PM_RP_DOWN_THRESHOLD | GEN6_PM_RP_DOWN_TIMEOUT))) {
-		pr_err("%s: DOWN interrupt not recorded for idle, pm_iir:%x, prev_down:%x, down_threshold:%x, down_ei:%x [prev_up:%x, up_threshold:%x, up_ei:%x]\n",
+		gt_err(engine->gt,
+		       "%s: DOWN interrupt not recorded for idle, pm_iir:%x, prev_down:%x, down_threshold:%x, down_ei:%x [prev_up:%x, up_threshold:%x, up_ei:%x]\n",
 		       engine->name, rps->pm_iir,
 		       intel_uncore_read(uncore, GEN6_RP_PREV_DOWN),
 		       intel_uncore_read(uncore, GEN6_RP_DOWN_THRESHOLD),
@@ -1043,7 +1071,8 @@ int live_rps_interrupt(void *arg)
 	with_intel_gt_pm(gt, wakeref)
 		pm_events = rps->pm_events;
 	if (!pm_events) {
-		pr_err("No RPS PM events registered, but RPS is enabled?\n");
+		gt_err(gt,
+		       "No RPS PM events registered, but RPS is enabled?\n");
 		return -ENODEV;
 	}
 
@@ -1186,7 +1215,8 @@ int live_rps_power(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
+			gt_err(gt,
+			       "%s: RPS spinner did not start\n",
 			       engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
@@ -1207,28 +1237,33 @@ int live_rps_power(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
+		gt_info(gt,
+			"%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
 			engine->name,
 			min.power, intel_gpu_freq(rps, min.freq),
 			max.power, intel_gpu_freq(rps, max.freq));
 
 		if (10 * min.freq >= 9 * max.freq) {
-			pr_notice("Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
+			gt_notice(gt,
+				  "Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
 				  min.freq, intel_gpu_freq(rps, min.freq),
 				  max.freq, intel_gpu_freq(rps, max.freq));
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
+				gt_warn(gt,
+					"%s: GPU throttled with reasons 0x%08x\n",
 					engine->name, throttle);
 			continue;
 		}
 
 		if (11 * min.power > 10 * max.power) {
-			pr_err("%s: did not conserve power when setting lower frequency!\n",
+			gt_err(gt,
+			       "%s: did not conserve power when setting lower frequency!\n",
 			       engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
+				gt_warn(gt,
+					"%s: GPU throttled with reasons 0x%08x\n",
 					engine->name, throttle);
 
 			err = -EINVAL;
@@ -1273,9 +1308,9 @@ int live_rps_dynamic(void *arg)
 		return -ENOMEM;
 
 	if (intel_rps_has_interrupts(rps))
-		pr_info("RPS has interrupt support\n");
+		gt_info(gt, "RPS has interrupt support\n");
 	if (intel_rps_uses_timer(rps))
-		pr_info("RPS has timer support\n");
+		gt_info(gt, "RPS has timer support\n");
 
 	for_each_engine(engine, gt, id) {
 		struct i915_request *rq;
@@ -1318,18 +1353,21 @@ int live_rps_dynamic(void *arg)
 		min.freq = wait_for_freq(rps, rps->min_freq, 2000);
 		min.dt = ktime_sub(ktime_get(), min.dt);
 
-		pr_info("%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
+		gt_info(gt,
+			"%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
 			engine->name,
 			max.freq, intel_gpu_freq(rps, max.freq),
 			ktime_to_ns(max.dt),
 			min.freq, intel_gpu_freq(rps, min.freq),
 			ktime_to_ns(min.dt));
 		if (min.freq >= max.freq) {
-			pr_err("%s: dynamic reclocking of spinner failed\n!",
+			gt_err(gt,
+			       "%s: dynamic reclocking of spinner failed\n!",
 			       engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
+				gt_warn(gt,
+					"%s: GPU throttled with reasons 0x%08x\n",
 					engine->name, throttle);
 
 			err = -EINVAL;
-- 
2.34.1

