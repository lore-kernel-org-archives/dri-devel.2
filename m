Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD23C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D04D10EBD0;
	Tue, 11 Aug 2026 13:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lT95vvCz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C098F10EBB6;
 Tue, 11 Aug 2026 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455208; x=1817991208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=JjfALjuA4UGX+yLNXRWNAb9Q+ORVzqZrKUcAMCopdJ0=;
 b=lT95vvCzhFHNa5MRXA5m2RYE2SxzrSL9zj0Rp6RJv5XdhdnaiHy8tkZM
 kQve1yD/FiI+WDk0O76/Kflv6nDj0iJ8GYWZrWZh2QihsjwXmcXs1gBsr
 +bekk0991ktWuJICq9d01Af91hKreoEiKZbb9MPd5PZjO88TQ7X2d4Q87
 bQYgB3qfwkylFsf+zH2lzOwpjIN0vkDzxRKlOhUMSumwby58XqFCsohwF
 b4oD/lZYlS2Cb48qTEjETGw22POIUsFJa2oN/J+pRwqKKIMi55992wXqt
 xhz0XM8Xa3bxb+N0+O9IlYKsgSx0V7XPz7vTdZNfaR8J01cGwUt3nQtCv Q==;
X-CSE-ConnectionGUID: ScLi4eMsQGiwktIcLdHSZQ==
X-CSE-MsgGUID: QtL/atJkQnygESTjM4sKig==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104374875"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="104374875"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:28 -0700
X-CSE-ConnectionGUID: qtQ4lxkFQ12S03V6/FKSNw==
X-CSE-MsgGUID: MyanyYObT/6gsBdvY3wwBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="267187720"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9v8IAqfwzVmhgD17DeE7d+45yo3v9FnvGibxRFvjQGKS6EE1/fI5jShBiFAGG6RwZRNpItAzEJIdkJJ7/i8u3LGKH9XSPvrF70cxuS4jIrI9uUkeQPT4HglfSmt91WMHcqCeSDwUNJopAekuL+ZXoHBdmUSaS0XZ6L/ZeiOIEo6acUNqVVTfBSV17JR1xB4Z+QiZh/KdlxMLVNpqPDfXcHmR/A9oi6KE+WUnEp/SaQTr0scdWSkGgyoZo1N2WphQoZqCz5GfOtlQnY2Iqw+Vt2kYScZRZtGyV0v656IfZJF9d0b+gqb1Jm9P/oJROTt2zo0zhXlOSgvgse4BHO7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWW2eCgrPl9Y46CJJGTlSW6rxs47Mdhie8kQT2XT5s8=;
 b=t0qMlF90bx7DBtp/2W5jMuNPy82lv1nljfOfqH/1w5abCrPW9tCMuZEjNegs0SYlSP0uob5qMN6U7x9UCm7q4ML9LXFB/J+rK36V6/55ISVzw0ukFA2rVI8Yj37QXBcF7e80fyLvPQYEvnzDo29gS4tC5yrNyPJStfBE5jIrFY+U43v9CoyW7Wk8mdAABtgTilBPNRz8ZZnVPMM0p8uuHixxMetPXOE+tAJXVPnYONU6E3xIjYbv5mjA4PewaCMGaluj4EoT8Eq8hVQJD/YUQEpwqtIDoEHG/KyRxGA4KbGxAx9W6vhJnZ1yUSnQHklujXtHZj6dvhomGQde5xEpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Tue, 11 Aug 2026 13:33:22 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:22 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 6/7] drm/i915/gt/selftests: Use drm_* prints in gt
 selftest helpers
Date: Tue, 11 Aug 2026 13:32:56 +0000
Message-ID: <20260811133257.1133097-7-krzysztof.karas@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 936f2913-bfaa-45af-64f2-08def7ad1c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iS9PwIUSJHg9YlcJleWeV6+0PsP5rZk7fnvxigGi5Bfjo1KVivsLEgHPTv/mmJR+ihIwnd6kA/R8I2cc4V/RuAXweWNng/0N7W6pRTRwxf+w2Vac+dkvHM2r6tAbapKaJrlZICywr3W1aO0r0X/RUFMEqUZPJ+oO56XpbkT449Y4MTXJzBcobd5RDtTwWPxx+ClQsNba6WPzBSgiwll5sxig9K/3SHd0wpHhMXnVjRaEj6u1fO/ybqHSWJMvP+9F7p8xv6rfWBuutv0gfNzCpMO1F54MJykEEb00Q31BlDLfpwp3JrRwWhGfsUod8etvTnoYQPGyI1QsFcrMWdVkkM5TcP1uzidpw67GDkJC7XGqFiZihrWGMCzyn1qXSLiNHIIw0W5kTmqu3nM1NfF2B1cRdE0ESaTnML/LSmKF/mhsvxiOcDhixvyLY9fFBClAauXSPWnl6/mnIw8ao62lzbW5ui71Y3LDLd0BOTuRtB98KXW1GwdLmGmZq5DVS5wO2JRa0aR11e0XGxmmzUN5DfymN6tid6QJy9icmW438uxIiLNCGZf62H026DwWMlwsNagyPlOjD1iYFxE00NxuFmloDRlpqP9fy5wGiXV5K0DuED1eg/lKsj0pE0A31fTTH14J98RtV4Ty8EJsAf4bv9K4w9jEctq57gcZ/Hv6Blg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73Hw3wj/MuIAYvVFX36W3JmDYKVOjcaDBd0XLX2LRVS6q3fSWgdZYIFrdISg?=
 =?us-ascii?Q?P8tKyBGm0NJL3Y1ZImbkIDHaXsjYiC2IAx22FXskr0wUHi6VZlPjZ0OmvZQo?=
 =?us-ascii?Q?ImqxQpA6YnhPEVLUEaJxFigXc5GD94nuFxxRsWXPv28oAXE5pJUofupmQb14?=
 =?us-ascii?Q?7/A2l57d6GWV6WahiJ3MCjIJ33wO0hIMr6wHASoTTuJLBfORXRIK3lJr37b6?=
 =?us-ascii?Q?CbLgb5zPuRHAmlOLTNVbS98sEP4CAFAoCzIKpIhfJQeSUOra0NV2GUv0WNSe?=
 =?us-ascii?Q?bVd3jESKazJYXeT8EwkgFJ4NKvAgHrt+JSDZ1ZHTEoxNB5Kre9m+sIdeaxgI?=
 =?us-ascii?Q?49Y3Upx3apCRdku5E2Z1TUPkjliIoDfrbhZQycsFYQCjld7XH70sxhP9OgBJ?=
 =?us-ascii?Q?cX2KN79i63BuXhOYJzkx4rjHLfCK9wkAoY8Hk8GoZhzEvW47vlzd3YywZbHV?=
 =?us-ascii?Q?8rcauOkkQyvb+oD6imKghJLXPhsYYc087CHBBfbh+L1ihFS4UbF4dsgbCoZP?=
 =?us-ascii?Q?89C0ReG12fHOwltxB+kVPkWIC0OnLTM7utPMcur6GioPBTdO1DndAxuhBd04?=
 =?us-ascii?Q?183mjtb76d7Z72OmQLp/SHy7gZF3Z+vCraREhl1TvwrErr8esd1OX4w7Hxk8?=
 =?us-ascii?Q?1ASO0RJdIZXLWRs8b3hHPprDjYMioNyNvBLyeMDSnRmEKGKhmZlAXX7c7GOP?=
 =?us-ascii?Q?dxL5vB8DBDuwXJ2SIad5VXxsylYjCXNa+8iP1YkN1ZH/l7hvSPa8wvtfU7m2?=
 =?us-ascii?Q?YybM0uP+3/bNgV3/qoU+FUXQyBfCq6zwJYE1AbsyXgtqRE8G2desj7fHcP41?=
 =?us-ascii?Q?XtWsuJGwOoXwWC3hvqhB1rNa+kt1CNkCezt4EwoeFb8NVP84CM5XtS8cq9Kl?=
 =?us-ascii?Q?z0ziP5bJOAj9cVgEFndtNdsATsKORFmEDijkCbKLDGyURcQs18a8iOHeJmPY?=
 =?us-ascii?Q?E6d7iaj85qKFmufDoicCBqChsQdUp1SlgllB3n9wkWNogdDbQfThhOSBbzdJ?=
 =?us-ascii?Q?q03AH0KJH+BdvC3nhDAMRGBUJh9yvUOQg8xnb5DhIdyZ4AWCDVkZpd5mDD4k?=
 =?us-ascii?Q?mO7EMjL9NSZ4jlU/81X5fYYX8lIYcQogHTCjvCRqPx1v9FoLZ36QT6j6YebK?=
 =?us-ascii?Q?/WW9nWCAXMrgi1P3/onUgJJLhIjF4JrZhG8GFxYosaVh1lJhcZY66SMOVmgb?=
 =?us-ascii?Q?sDa0H6gQGd1ol8TW1J1WIWXLHGAESOz451C4DmW9M2aXDHsu6ZCoZc2M8GrF?=
 =?us-ascii?Q?8a7E1SeCUiP/O0NKGrzEsB4ZzmDwsgaLMiOfVtn2SgfCjeY2IuLqS6WOZ8T7?=
 =?us-ascii?Q?WXhGy8MDney+O7Cm8n4igdFGmB7rpAmQAJb8V9ri5xqdPIusXG3HdfBKOVMH?=
 =?us-ascii?Q?jflQqdQ+BZM7WrX08lGFzPPXpLZ1uToWZEYo1h0Dq11zVt2L99QLHOJFlbNU?=
 =?us-ascii?Q?DuLeLTc/bLQvYpRUYOhWuFF5KFdIZvYA7Ju43lO1GPO1rDrpbW1EF137Nx3I?=
 =?us-ascii?Q?Z4NDlJE3A1WX6cCeo3Wuc7D5GD5SmkvyLfvPNu+zd4zHLYmLno5Nbfq+Ts9O?=
 =?us-ascii?Q?zHuU2g5kGRSaZ/RMg1LAPCCWZiUdoiCfvfxPVpIWavp0iRvOBi/Zw1v3Rark?=
 =?us-ascii?Q?2r0wwghsXwHHVSzXbicP7IoNkyLMpAGtM6ZbVq2ptFpdMmH9wCWy6/AHS/jY?=
 =?us-ascii?Q?LFR5AyuMLkkoyRO52NYKRYwOIjxdQjWguEm2ZiIiZw8t7GE60GC96Hz8HQnK?=
 =?us-ascii?Q?zaPGFteX2XY5rHmjmt4KwJOnuq+hMtA=3D?=
X-Exchange-RoutingPolicyChecked: Canmrslqkkj+B22r0Kp7HLJ17xx0j7PczDzyeSrJp6aR84ErJGYAmcAP21L0+yOuYuMQyHJzWoZAj0IXDVpd5nRP9Sed3BSMo1agDlh3Uo5c4x5FaR25kz1IAvW5HWk6PyvaltgbVnsPnyTVzKQ2g9PPVRd+5oK0gMgXMk3bxFMaDaMHshEq4H2hat7Ff2yugJu3BvmKaEs40gOKdW3ScLj4xaD0D1IyGAPjzEf8DsvlxBdVzVgca45TVs8ZWv6zBcx2Y2qMZLKeTPgml+DHeF+LY5cNMoUVGz5CohpLEDp2hfr0Q00a/zq4FzKH3Bf2248zXYEnsmSGw3G5fTrZSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 936f2913-bfaa-45af-64f2-08def7ad1c73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:22.2018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5JzisnF2J9Q5FYtdR4B2zrXtWtiThIdipJyHD9fF+pIXLxt5/8KHbYCuVHOj0XrLzgbXho0/C3hn83aab6J0grEcUN6rO9djKhvFs2uoXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
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

