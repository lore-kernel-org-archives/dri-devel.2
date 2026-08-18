Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09E0C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344CA10EAA5;
	Tue, 18 Aug 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kAX0FXl0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0882E10EA72;
 Tue, 18 Aug 2026 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047013; x=1818583013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=JjfALjuA4UGX+yLNXRWNAb9Q+ORVzqZrKUcAMCopdJ0=;
 b=kAX0FXl0sfOuGKhD624RtKyGsMfSju0IQJr4VGn3MN6GcXU713c+DK3p
 GUoZPeg6uaLxA5MzH1zcOL171s+xl1b6yrkYZvxMSGwCPzgI9smbFTZ/q
 /x6DPCYTKX6qqEEEPthg3d4DFTUoY7o7o0bcO4g+VOSnSpeBsVr7QwQWd
 rz16J/Z5lzvHKUSct+aeoQTMtxCEeztoe1zZLR78Q0Hx3n//BSxomofDu
 XaF0UaFS6w+Qb8RH28hj6ZVgbJiHD8zpfNWHJTm1KPXDK8AEIJi11j0a+
 VzHzwgiBiU54S1MuDxe4HCwZ191pTM+qiokFPrK9eSeAJABtAfpWPRZbm w==;
X-CSE-ConnectionGUID: AVYtM7VDQQWfzgD4OvTR2g==
X-CSE-MsgGUID: bFelWnd6QWy+rlwZRGHlIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87655740"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87655740"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:53 -0700
X-CSE-ConnectionGUID: FXCM+CXRSp2N80zwkmZV5w==
X-CSE-MsgGUID: TzZnl+ruQXiriFv5/ruVLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="264736822"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:52 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmPZKryLN+1GZ3VFgPRmNcur+Tg5qq/6zaLMcmxzOcu8d1nSZcA4uA82uvwAI5/XNzyPGgmoiAzfCEXZXFTUZh9z2tPO0ZxdDwDgMxD1jFAZZQVasxFcwXGd9wjzPwrhXNnE4N24Pt8EDTi9/5pw7xL5KYcbgyW+6IQCd+55Lvq3wGgyxLhO5kWPLtCVs02OtBrIZ3alhdLJetmAEwMYicbEVFBrDKE5TRnA7+Y1jCjTadvUEifl23Ed0cT3J6auGSgLg+Pla06PkkpMN5w9Nct1N3TNUFKhYOckJ4b/I7fpVCGSx/uxQAzmmA2bbCFAyvt+CA4LeZwT+WGNgaIITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWW2eCgrPl9Y46CJJGTlSW6rxs47Mdhie8kQT2XT5s8=;
 b=e43k6C/tVDopdH57xTqTP8HFZa/yTJ8j9bOr5uFj+1Y4tAEiI5j0rpS7R7YyXj9nRNXfnp4/IpmDNSaGBBxis+74fPJ64qRQCwHRhwtKupXFpBZ687YqQU2kBuNI9nL/ZBlM4WOMx62Yc7lRBGmwRQT16xmKjmnjcjSP3aj6W8NMev1lB6zpTwMreitqDh52rHAIPcpotYsx5iPd3hOn3pknqiDA3fadBqrzqpGPXwijtCuGn5AT28ev3lv8Z39rRn4gK8xTYI/ohvpceTmlhs552FieVCZwarKSqh7GXXC5cpTz8bdvXNYoYc9Zx3eKi4ZTUxfGjjst5iVCYzM5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:48 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:48 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 7/8] drm/i915/gt/selftests: Use drm_* prints in gt selftest
 helpers
Date: Tue, 18 Aug 2026 09:56:23 +0000
Message-ID: <20260818095624.3254368-8-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818095624.3254368-1-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::6) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca911ca-07ee-4e9f-4c6c-08defd0f0528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: aJqgTa/sgT/Vdbl4K6lTmwGYH0r/c83IDdx3WDf+J383nYm2WaW1mtqFsKuyVjTANJ8kqNDsiYjuSL+v4AViCTlZ4S4wAzYzsVXGdH7kJvHyPiW2VMpy8IT4u3RO7it7hRLWeec+Lv/P3QCLYSdksnIJ3PrKirq/MrHMvWuFpUNLAahG9VOW4rtAs20eRe7P8ErYpQXgd8w4BSBRA3wj1UjL/aQ6FozIwPtWGWqfvjPDR6efFUSQGQeNZHIsEK3MbVIsT5PUJkL9SIetq2engC4kCT6aBrMlDzx8W67hdaFUsZ6hObzFv1bRONT35S0TvhzPiZOc4pRQKljGJ4VQt1tzZGQsIa/4fw+EHfeAuuRc2WDh9FaeCSUnyPdOVyiuzvlWTRdCqzxmXXv/Pynn/00bktDukZ1+7ZsJOm1XAjmY07tsOSEf5kVlvtkVyjAVzG0KRouzGc7XOlfEbd8pwdhW+bfdRWi3F3EtIjB4rfTCoPGlwP2FmF3cBGQ/HeWVxLbrNZW2Yp2UXAbHYtLN/p08+6F9P8wucYftxULxKT05GuQt386KJwq+65MRjWsoenZ/ElZ91+jpxMdPKfKxaNtALTBEbMZp5g3SFNluA96dcu+jWoPbkRDIzPkIPo9Qd7eHB1uVpLSEI+iZ4mDSIRfpffAQP5Oeho/tdNRUL1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MY4Fugr722JzuArBxaW7kTgJMn/S1+J4rhaYGa++aOKLstenA6jiwjbaUEpt?=
 =?us-ascii?Q?gKruUCs7TI+h9R6J/BNmZYX6KGlWTuiXHDFECSEEQxG3GuzHkVPOWopoZsX3?=
 =?us-ascii?Q?ZWxlsTEcqFHggxlGmyinJPx4uCW0WYimHUW8k9gktC2utCN1eBPu7FPOD4oo?=
 =?us-ascii?Q?AAi/2f7sDCH4h94YqE507DxUAzTjq9g7rG4ohWHevQ8th8bsgpXQunAKRQpf?=
 =?us-ascii?Q?Qq7kxoqiUI594i33rtVDGcf5AcCkrfYq9sz3YFbhzrYRsyA226KaNdBN+cky?=
 =?us-ascii?Q?md46Y0u2plwTd/LFUAWdM4tZTMxRjxS59E/8iAlC+MqqQzAtzvEprfiYX8+g?=
 =?us-ascii?Q?HjpVWLLRi8aDCKD3r17sN5J/5ME2cP6b2ahO8LqsnAJeU8r6K4qOdphLHPoG?=
 =?us-ascii?Q?ub26QhD4j6ULa3NDzuNNcYWgmQAzXsFCNdBi2TgCiwZKHrqSdhkm2/72FOaf?=
 =?us-ascii?Q?RowjpgsUkHCtS2gANzmfsoIykIL+qAwD4I8wa+8d8TTPZud5p0VR4D2MdEL/?=
 =?us-ascii?Q?Ph3n7HiXp9LoYP7i51O0A+ult4rBvLoYndpwP554R9Sx1UhzW2xRrDGFUumS?=
 =?us-ascii?Q?p+KhLoBcewcw+wqHQ0FHZJdlRsRndUsqgNAnr+b15QRzcXN1Xoda6aa5ESP9?=
 =?us-ascii?Q?Oi30FQQd0n5/SI7eJpa6xxU/DjPht6K3guoLyMsO9BnXrZWglHH7VHXcEyWY?=
 =?us-ascii?Q?hmVkExPLyePMBlIiFJKmyr25D8LKsT+6F/b+h8rFIYq9UDhr9Nz+qiszfmpX?=
 =?us-ascii?Q?EUoOC9Gfli3ePYEHSeLCtxKI716ejsIhczaKvhE6SOps36iol09CumanpQH4?=
 =?us-ascii?Q?1tzi/IFgMp+PCVpVnu43vepkJ6ZIXsUAuGT3tzKYtOUfdJg29E4wRiO0U4px?=
 =?us-ascii?Q?7BSDxXUy3YNaI82pF3M70HCnW9UiNzbCSXdRSgOfCa90CcdDcPxBcQ+MPvaj?=
 =?us-ascii?Q?xDiTbc+SCZeeBoiSCDO6t7JWu5ffhlHzx5iOQLrKDCQz8salmBVP7n6FP1GX?=
 =?us-ascii?Q?oboj1ney95nnCY5ST8BS8XV0JXurviIx43xjlR5jDTehnhqUrVRY9QYF28d7?=
 =?us-ascii?Q?1aYCEkLTCaS1fvBdvnO80SpKqOaVXm8r3nnjgmyurRmI/J6uYm1xohKxSSxu?=
 =?us-ascii?Q?XZBdVmL4Vlsz01gUchF97NozzTdnQ6nvgCdu3/XE4T90iwTAsG4xq4RaE2Jp?=
 =?us-ascii?Q?udPpLcivUezRA3AYCW3nR2mj9SkukQMJ3OxL/ZzWaOGh8lM9D4ZgD+ae2W3V?=
 =?us-ascii?Q?8OEkX2uJXw1bw+pk1KOVrSkEaEtRKWEzB4Sy6ylprcvBg+F9GFrKW3ce+PIU?=
 =?us-ascii?Q?9XCYFj9U9am6x0agbDhKkMdCmHq8lRBMUGzYKdxjzf4DrDz0XbUl3kepfaNi?=
 =?us-ascii?Q?A/3kzATN0D22Dl8iIG7xGbnff52LKQTjkA9Ol5sEtyUM6TDwXrvb91HkrVOY?=
 =?us-ascii?Q?Niw5z70TXglpOzsapPNFsO21IePGEG4jz7Ft5yU8Q0m4BibtEDDat3GZX3KN?=
 =?us-ascii?Q?jNwz/lJ3RJfnUzJhbBTwWonnJ3Q3GHF1TZlBWnRUuWPpQSMdd80x1y7CK8NM?=
 =?us-ascii?Q?Ck8bsLe2v6xNtzj6waa/nHJTE7HpCOlrin0gN1Xj6VueydpwitNHFpk3bDU7?=
 =?us-ascii?Q?0x1P7Z5cVcCdkNq82UwuNVVJtQAKx8BeJNWa8NecAl5bbJe27EpOBs8bKBWR?=
 =?us-ascii?Q?jarARrVRFSuXJkH5iv9KaB7Wa2WM6pqMOXsZJHoJ5rHtOQMHpwYN+Jl/P43O?=
 =?us-ascii?Q?ZgjNVE1uhwx7p8VgnR/d6Mi7pt9yt1c=3D?=
X-Exchange-RoutingPolicyChecked: II53CsJmt90dIFRXUBP95AkQj2z23OYeqW5Be3bIbQybiOuhT976DfIfE/w7F4aOC5NAH9YPDyzaN5TgVfdbVpk+bcwkp7cdhOoZL9GmI8hHLgkTkbB7sqKmjC9bwNzIGrjSB9WC1oqJbncu0FuW61fqlWDeli+2DP3jsbD3MrjJQEoZR+8axEYHFHIaFa91m4tYSE3CO59tC0Ymgl1cFjIH+01EVnFBuQFICcUjX6FBGVXnpLuTSyga1QMJnXwfwUBGjVEUqYpytYZQpQxQoi1ZTFDS4hHOEClI66s9QugbSbbsdbuaBPhEhEXAnWDw9aqZ+W9WB4NudWCrRSicIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca911ca-07ee-4e9f-4c6c-08defd0f0528
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:48.7586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynlTk6kQs6sAgZn/TuSVFyJv1OJfAkuorCVglFZF89DOlVsZYQytrUy+HSPfH35cQJOySCSBu+y20RG2KBoW1YKlvf5lSbhPSIhw/g4fjn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
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
 .../drm/i915/gt/selftest_engine_heartbeat.c   | 18 ++++++++-----
 drivers/gpu/drm/i915/gt/selftest_llc.c        | 26 ++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index b893a8fde895..6f5962eaca3b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -202,8 +202,10 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (!delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat not running\n",
-		       engine->name);
+		struct drm_printer m = drm_err_printer(&engine->i915->drm, "heartbeat off");
+
+		drm_printf(&m, "%s: heartbeat not running\n", engine->name);
+
 		err = -EINVAL;
 		goto err_pm;
 	}
@@ -215,15 +217,19 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat still running\n",
-		       engine->name);
+		struct drm_printer m = drm_err_printer(&engine->i915->drm, "heartbeat off");
+
+		drm_printf(&m, "%s: heartbeat still running\n", engine->name);
+
 		err = -EINVAL;
 		goto err_beat;
 	}
 
 	if (READ_ONCE(engine->heartbeat.systole)) {
-		pr_err("%s: heartbeat still allocated\n",
-		       engine->name);
+		struct drm_printer m = drm_err_printer(&engine->i915->drm, "heartbeat off");
+
+		drm_printf(&m, "%s: heartbeat still allocated\n", engine->name);
+
 		err = -EINVAL;
 		goto err_beat;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
index 779fadcec7c4..6f204b4346f4 100644
--- a/drivers/gpu/drm/i915/gt/selftest_llc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_llc.c
@@ -6,6 +6,8 @@
 #include "selftest_llc.h"
 #include "intel_rps.h"
 
+#include <drm/drm_print.h>
+
 static int gen6_verify_ring_freq(struct intel_llc *llc)
 {
 	struct drm_i915_private *i915 = llc_to_gt(llc)->i915;
@@ -23,6 +25,7 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 	     gpu_freq <= consts.max_gpu_freq;
 	     gpu_freq++) {
 		struct intel_rps *rps = &llc_to_gt(llc)->rps;
+		u32 scaler = GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1;
 
 		unsigned int ia_freq, ring_freq, found;
 		u32 val;
@@ -32,28 +35,31 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 		val = gpu_freq;
 		if (snb_pcode_read(llc_to_gt(llc)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 				   &val, NULL)) {
-			pr_err("Failed to read freq table[%d], range [%d, %d]\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq);
+			drm_err(&i915->drm,
+				"Failed to read freq table[%d], range [%d, %d]\n",
+				gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq);
 			err = -ENXIO;
 			break;
 		}
 
 		found = (val >> 0) & 0xff;
 		if (found != ia_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
-			       found, ia_freq);
+			drm_err(&i915->drm,
+				"Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
+				gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
+				intel_gpu_freq(rps, gpu_freq * scaler),
+				found, ia_freq);
 			err = -EINVAL;
 			break;
 		}
 
 		found = (val >> 8) & 0xff;
 		if (found != ring_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
-			       found, ring_freq);
+			drm_err(&i915->drm,
+				"Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
+				gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
+				intel_gpu_freq(rps, gpu_freq * scaler),
+				found, ring_freq);
 			err = -EINVAL;
 			break;
 		}
-- 
2.34.1

