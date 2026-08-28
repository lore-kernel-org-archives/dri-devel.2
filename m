Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B005C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A4410F341;
	Fri, 28 Aug 2026 10:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WU6zkit6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A29E10E4A9;
 Fri, 28 Aug 2026 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911454; x=1819447454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=EpcVfKNikTlfOhHoaOG5nS5RfvsgI+OqUSKh+1ZTw5U=;
 b=WU6zkit6fr3f64kFSbiz8YXN9FTSEnqjNwru8Q2mqJblT7kHVJHfU8wX
 ORloFwBpitmuyTHNLAsWBalzG8e444N6pESawugXTIJmwHHzFr951i8eI
 /rq1hItXHkyVyHqFuDUF1nBYct3kmbcE0ACaBDjBXwW3F6LdkPQyvvBaM
 MGBLHnsO0MgcRFjSnNYT7PRLTJuNMYBdxHJTozGlCtods92gX+roEKUdE
 2qDZ62lXmHvO9g/eDa5NumAZeTEIBSQO5AzcYdo+ABCNdh0qnQ1bUT8h4
 sS/qEjwhO8Gy0paZGM97XBFM2pEaKv0qpf1udB3nZWtFNtHFn05RUTVX/ g==;
X-CSE-ConnectionGUID: JeXLHHFhTp6mtPwDqQsUqQ==
X-CSE-MsgGUID: lrZT9l7+RO2q3qnsbQdIdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105791711"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="105791711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:14 -0700
X-CSE-ConnectionGUID: MS2t36kOSoqllPnJa5qGPQ==
X-CSE-MsgGUID: 8Ahm61AmQtuKQ1nJsFchmA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:12 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX2TJ6OsqYenyMRdW+EeqY57qe63rmF1w4CR2gn5um8vs0Wh+a5or7UBx86ZmB3Hix6h8M9QqIJ3jdw4FGV95+kZVypYrloXHtZwE29kvyOC/3ETa4KErhW/rPjcE0WrqN6rQZplvb9y1AsFFGVuFGbDWnp5hiLQmw2GrfZ1ZiuxYAQszbB+40J5WDPdh8g1lXudryGFyOchcHQTIDl6ZwBKD/4KOcqAALf0jVvAo8af83bxEILt9W+4QzYQF64sUxBWszeWI8eLU1vlJc98F+3eoYqfsHfRVHAKJxHbPTHGKsxz1NdsQeMXNsP3nUJP7OwC9KssD9z7J0g+daQXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze9TnQ+Ht0pR/ORrdWBTIs0RkIQoNowCFi4LF+SbkgE=;
 b=xvZddCZkRWGg74rm5BrwIWiXUZUz2vb3tu5wwlFzBGUA93Jfvkex9mSnBfBsWVY2ZXdMyG6+7fdgg96APeVf4VSZExOwLPXhx6llY3fOuB08bTNZRFKsNahOV4dp8xjnjcBWSYa6LciYpvu5nBIDWHX3Fq2/QRIKXEPMgPgXZHyTmBjFqti1kly0GZj5VdkqB3iEmwlu+L7PjXeSFXCP//FwGjwIFyT2cG7S4Trevq7xbWgxPVwALDPVmVI1YKkScJyT0GcX5PTX0BNUKI9rvOvuurpJZ9Ld+QXerGFW52YYt1+hKGhjpcu8DR/gVj9xqMjPdPsCWiDNkgeYRNhucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:10 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:04:10 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 6/8] drm/i915/gt/selftests: Use drm_* prints in gt selftest
 helpers
Date: Fri, 28 Aug 2026 10:03:37 +0000
Message-ID: <20260828100339.72304-7-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 001303e4-406c-4527-4870-08df04ebb484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: kDLoqwM3woGQd1fXHksGf0aJSZRSmu+QOk2RCSj1X9s+Gz4Sn7/iuR6dFwZMoZdGJFkr4wLRUabtInDy3FQgEjbAqvoVnfXW9n3IynGKjQaJdREC+c6ia/gzVMU8gkKuo1Th3ofvb04JuXJn1VN3fbp/p+0015jXEtDdbUAkhugBeTTCag+O1LuGlRDazfKLPP3uCoQOGRPOUztt8C11/VIFFhwQbmEa0EhV3OYWADhn3n41t6ArYCM2knT+U6upsFewQPfKB2+TjTnwZ5xhN3ejBVkKsumSGhpiyr62vTO2TQISKr32ubDSVJ4TruGIZm0SzhqdmxyMdaQ2W3KOriZyxU1di64WMF668CcHzRnQngQz1xKNgEBlDZmd2eh7UtdnZ63ojhJ3tZhipZfSWfeIK9G7NlcjYGr8BZ9tiZFNF+LGPfpRw1XkdJoUBpAJTqGkZ8Ja5tdEWkbM1sj7lMeRIS5eAgOFKoyajsAKywMa1QXnohGroSVp5wKxVXbVzt11z6Xla0KBhbB8b9+bXm6Bfa59uptpfwYjphZAzoHouStimgrv4h54ONvmkiN921iDYNtGXS2x95X0u0NTB9cIOIWF77yULo6BJ7jLx2iufecBxGSQtjP5Ed1HhCpxKVm6chr3y9gmhK3N9y9QKZnYPQNYpzHinL5j+cBuT0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RO/K6BhtM9X3HbPB3LVVSV797SNf/Gh0nS+ADWd+RwyMiGQjsU4ci3dg7c8K?=
 =?us-ascii?Q?XHQ4EE9xqz1uF5K31RxENzDVuoe00J8ok3JUw9+7MqE6a3sZdfIVJdBncPOW?=
 =?us-ascii?Q?elw1aQab64YgU+Gdbcu8UWYbvEvdSVjrMppJF+CSIG3QPYZLYGIOKmwc2lml?=
 =?us-ascii?Q?IOnP2v9dLQhbAeGOqyE3s1Xf7CZ+peb2HlbGP0COJwVu7tbR8QJa5p8YJn/m?=
 =?us-ascii?Q?f7Cf6cXEcaMNqX/eCb/srByEL7Q4Ah57bTBpeoTwseZUcvTBmlgFDvocGVjX?=
 =?us-ascii?Q?dMauq4VEnJkT+wVMXw0ey3RcxIN2Ts4L2Wke7qKA3QPesc8PVPMfFVWbEXRn?=
 =?us-ascii?Q?dAe95CMUtOVhZheluN5yVJec/dR171biT6BcVmybPcl87P+9kYevZs5USAvj?=
 =?us-ascii?Q?iFia3TBnDTmVGS2iUSkvtszkoSEFo5qi6VAw0NuaR9VL2+09Ymvc1Yybb+LA?=
 =?us-ascii?Q?j7rPF5/3I8Hc8SpjSVeqKwMxbOx1GxzMLPquimRxGMJNl2PtPf+E+cFSVr8i?=
 =?us-ascii?Q?F1oKNIsAtiFT8OS6Q5WKKSQe6czst15CAdz9YuDe+OfuYogh2wLc7SBKBtWc?=
 =?us-ascii?Q?u4wMyZq6asWz2Yoc1fd0E9r4fp1ojKi29tuSsyCbxJjmCdmuf7slgvyqIbTF?=
 =?us-ascii?Q?J8QoYm8kYJ7fI9blXZQRZflbho/ujDsavBF0Zzw8KSwGVzZDg+2KQc6Y1Ikf?=
 =?us-ascii?Q?O0JXEPaRq2O2Y1dWD+bF2AlfkGeOsb0Cm44Kyvb6kHYiY+eqlN03n4KkIqiG?=
 =?us-ascii?Q?qefCiQuY4VnUDQNQEI74GxPVhNZ1TPAGJNQj34iZcE5Bn6GWveuWAdgSbDfp?=
 =?us-ascii?Q?isPOfPkkvimfvJ7k8o3L+dGPJS1xw9Yj/VgKhYgjJOVcJw/oojJUi9OxYkmK?=
 =?us-ascii?Q?IkamqoVlp+mq7FGu5mlf/rUBkT7p13j7wDSzC7IcSEeA/nE2I9hJAnN22dua?=
 =?us-ascii?Q?saLfLKClVJdkQEKWf3J0X+d3sZM8wRUQKZ0fqhBvA31tAsDmGkWUgwUzUipk?=
 =?us-ascii?Q?Txg9DOMGuGjnEVbkvzIFahcM1EXeTWdqOeEZuDDtdH3Orm2TOEpiXpOYKQuL?=
 =?us-ascii?Q?z48hdYJW+2YT7UM7OWrdfKuhlxxFNFTketX+mTe8dAUGhtne6MpjT04JgNGg?=
 =?us-ascii?Q?MI3SfFgXH6zLxVtKsyo+yar/C9DsbJFN10Is8tgn7Q094MsIiGZoiWFNmRYj?=
 =?us-ascii?Q?Y3KCyvtWKa++2FAtcDOcU5fCfX2QTbOHFdUXskrP5pnH28EQ76H/xcfynPDu?=
 =?us-ascii?Q?uTX3tA6gLsIVUVzYYx8Migm67A4XSNXHPizRzigckvdf57rsXsm3tpLxfJyw?=
 =?us-ascii?Q?KAKj9ehLPj3cq6tD2+mZ9x+QpZSpMe8bcR4z9Rx6XnQNe2Q+yO44tPJ7racs?=
 =?us-ascii?Q?NUHBaL9WC6GlGgQr1gC31MdY3f8SIU432m7x254Stv+DFeOFDss2r+TS8qY3?=
 =?us-ascii?Q?l17HGHDuP8fniu8udPlyKKDs1icUhce1w3DW+7tYbtyNPcxESKzIFcostUe8?=
 =?us-ascii?Q?7VQuUmSCuG1x0wLTmQOoKymjwovCcdtMvIwAhpeDwzYk1573yG885poeNxJf?=
 =?us-ascii?Q?9+pjFJzijwZ8iJWmPSrHpe3pzfonCH2dRZ3hDMgu7x/rgZtHmCzcpYrMCmcm?=
 =?us-ascii?Q?TLNlu2jskS7mB+0R2i7/CH/ZbbdIvanyPVbAW7szua4Uxn/XEIYEjxbNdQCa?=
 =?us-ascii?Q?PcytpcPbg3hqM6u/NU9aYCAVG4CA8yFMHO7DB8lET2SQA8LsbOa7Pc0ZE5V9?=
 =?us-ascii?Q?C2+I3M8Xhn580N2ReBPh7Q1h1PeY/5U=3D?=
X-Exchange-RoutingPolicyChecked: fY5B7CcLUfuWOKQQsjnS42YWAqIFP47WJvXjM5lYllFXyxkL9EB39rbJ8yUqzUhuY3vIMRpppb/VtSF5TOSeI9nDtxq9Uydlzzyq+nE6GddUBcPmkb58NIQ8TZ3DKLZpxGNyeTOyx9cE2WRKyWOpShzNgsLE2kgVH8lDvJyIDlv0TvMBeyQP5c/bRNpUmlV/UmMf8q9w7Upq27RQfcyVuwvYb0Q2c8kG0035loLGvME0rbICB5zetgTmNO8PmzD18hnyktP2XgCL0NcizvPVTISNxwk2Hs9UoyOohRQaaLxwIF4B0HC/hDylJQ8QTh6z7Vp67chq5WVg605/T7Odwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 001303e4-406c-4527-4870-08df04ebb484
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:04:10.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtjcUB9BjiRKEsToFt2e8WJRwG+0gSMGlFRIA4bZwuXHExT4cWSwPsLraIReLn+JMH+huGVzvlZRTKTJ+nkTrrZKcBmSfMC7n279SbREyC8=
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
 .../drm/i915/gt/selftest_engine_heartbeat.c   | 13 +++++----
 drivers/gpu/drm/i915/gt/selftest_llc.c        | 29 ++++++++++++-------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index b893a8fde895..d26441ee837b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -195,6 +195,7 @@ static int live_idle_pulse(void *arg)
 
 static int __live_heartbeat_off(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *i915 = engine->i915;
 	int err;
 
 	intel_engine_pm_get(engine);
@@ -202,8 +203,8 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (!delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat not running\n",
-		       engine->name);
+		drm_err(&i915->drm, "%s: heartbeat not running\n",
+			engine->name);
 		err = -EINVAL;
 		goto err_pm;
 	}
@@ -215,15 +216,15 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat still running\n",
-		       engine->name);
+		drm_err(&i915->drm, "%s: heartbeat still running\n",
+			engine->name);
 		err = -EINVAL;
 		goto err_beat;
 	}
 
 	if (READ_ONCE(engine->heartbeat.systole)) {
-		pr_err("%s: heartbeat still allocated\n",
-		       engine->name);
+		drm_err(&i915->drm, "%s: heartbeat still allocated\n",
+			engine->name);
 		err = -EINVAL;
 		goto err_beat;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
index 779fadcec7c4..17a86e876f9f 100644
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
@@ -32,28 +35,34 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 		val = gpu_freq;
 		if (snb_pcode_read(llc_to_gt(llc)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 				   &val, NULL)) {
-			pr_err("Failed to read freq table[%d], range [%d, %d]\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq);
+			drm_err(&i915->drm,
+				"Failed to read freq table[%d], range [%d, %d]\n",
+				gpu_freq, consts.min_gpu_freq,
+				consts.max_gpu_freq);
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
+				gpu_freq, consts.min_gpu_freq,
+				consts.max_gpu_freq,
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
+				gpu_freq, consts.min_gpu_freq,
+				consts.max_gpu_freq,
+				intel_gpu_freq(rps, gpu_freq * scaler),
+				found, ring_freq);
 			err = -EINVAL;
 			break;
 		}
-- 
2.34.1

