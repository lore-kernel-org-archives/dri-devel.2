Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C432C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DA310EAA6;
	Tue, 18 Aug 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FO57HZEl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D6A10EA72;
 Tue, 18 Aug 2026 09:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047014; x=1818583014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=D4gjZRZ2OOlDup8Kc69m8N6Me1BwLRCcGegeR7Rlx2A=;
 b=FO57HZElhFv7w9uAKLGC4PGVGe4ToeHT3qlnYPryO/MfgmVxG+2aAWCZ
 +H0OKEAiC+D75aIL0/69jW1CVP0duAiSxXZXwXz4b0BIa7ApC2cTMroQ+
 Nte1KQaGNhzMHug7Bp9nMLF3gYieXA+RoQLxIuRxW1Mp2swCk5HJkhjd7
 e691atVEuYNSmYEBJkh675zLubN7vFQXKyWJG/dMp965LGlU10at4+qHI
 1BZEpe0p0hBcpQ9usiw3HtNDsEEL60Xx/dj6wM4chlzu6LBGww7UrY/qw
 CqsN+BzThtfAEi236cFVmQ+2buUi+6lw9w15tZBHYpQU4u57ulg2zxeAt w==;
X-CSE-ConnectionGUID: h2YdgB+OT8qysyDj/bjCaQ==
X-CSE-MsgGUID: Hh3CsC8uRwOG9kRjRAg9yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113076540"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="113076540"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:53 -0700
X-CSE-ConnectionGUID: qEer8Ja5SAaWk02KwlB2Vg==
X-CSE-MsgGUID: +JE/tZybSJuxClIKsGufqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288687586"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:52 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+jdaCjxFk44ovL3THZ3iIhijUEcI61RP0CKteRDPCgtwwicN+R4uVQiVAGa5Z/4lJ1vHj2FDQogWGHlX2ortUKfU3EuOqu+UJwneCD70/vK3f6u3sEBGFDLBUYrdmmuLtm/2dM7OWTI0tbdxoV52en2uvsthiiVqXqrnTHTU54g0YCTlv7mQozdjVqcrkFiikkP8crT5FfuM+GmCrQ6XXwoSFcncMgkz75KQonLkXedO4enFGnDzK4C+DwpMzHnn/a37eQ7hQaDWwfPXAn5lQ5ck07xwKH+azPMwczob7UDgb5id5DgcKYL/F2pZxhBB7lHHuF3lbG0WmhiYF7bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp/NNGOm4dbKCZkvk4gG19r9Q4+mORBfk7hz8wOuEMM=;
 b=J/NEcEZXQMztomddf6qogy88y4CApRNPyeYcbE3b9Gh4qNWwup6yHMPS7zAIhT2kdsESOoEMDB0QfBsMPe+eLJE4L+7R8FBcnHBFXrTexPPVHYs14lS7UQ2RBoSDQEvmAuz/49QbvReDEsMMsdmI8D/+L91zAayBLnFOMXOnqqT4/ewYn7zVyBaeUFoOQ6RGRMFE7kni3P43QZhVniPtP6xARZJbmTnofej18LOxGLA1EJNgMMnJ5++GxJWQU6gBrz98ZzrN69T1QG1PX+gLRISFwD7czAO7pBhIshsAij6HuKzTVZZvAaHvHvHjuyv5I4eQ++Wb6AucwAnxDH2o3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:50 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:50 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 8/8] drm/i915/selftests: Use drm_* prints in selftest
 headers
Date: Tue, 18 Aug 2026 09:56:24 +0000
Message-ID: <20260818095624.3254368-9-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3b32e38-2499-476b-6d96-08defd0f0667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: WJrwNLQ0WKFiNRmxv5/UVgZV4Lny6ncvUKlhWN/auJbc8J9foTwfq/e2gvKd2++bk0VDUiwt25B/J06+KUFTE+uHJuy/RKwofgOCzRx4l8M4Jxqyia3LlYv8VL+od1kKeplFwbFFpCb++pb7NSaT2Wp17khk7k0QXX7VXFEkfVLG+KSBvPtBnGQp64hNjZ57rdTs2hm3XhmoXLytbfBvN4mnkSxMrY4kDOKLvpgAstJJHWRLyUM0Jq+QjydMbcfycMM4TCBCCEBLBAKghek7trFIZ96dFKtRswBTJuhGknrgXq/NbVarfz9pyMugjKwmkjLDz1ZC1ukcO9vLZRmZKi+hQSHAH0zI2mc1h5BfLdqfw6+pQ21GPvKUhtjD96ltevo8COyw815oR8m75xryYKPjS7IlZQZt8+PtBvWiy3uKlyGdd12TF/0xlXR/K+H3xKxLZ0DApdMRE/ZkSpkPDp+cC2RJyuZGGBiMIvJtZq3/08ILH9EYxSNue7Y9FLxcBL468ILWl9NRxg6hPRRx5nUxJi9n3aEF2KbfYkY1goPGTwVtEBZqIazNwYXx52wbRjj4THljHEnSa927wLK52yYa4Gcy5O41gWZsUixKvl/riG/beAXzqM02AqhcTqq71rgJR8HTL60IXm2lNbo1JXzufpvLT3p9lwCN7e4y74E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCfxnjJd8sCrOGmrAsHlNLPraj7WuWXxFVYqNg+ZXf4QoTArrf9lizieNQHo?=
 =?us-ascii?Q?llAE/8fTH6u3OrziG4LsBeQi0AJeHvjFmtAXxU/qYS9KR3bb/HC/El50CNZk?=
 =?us-ascii?Q?1CNAfqf8ZqDHfkHxs15iwNhh4Yq3jiGcw6nlXEknxGGn2x1+NNL9Mg+jJ7+q?=
 =?us-ascii?Q?GdwxgZnaMDES1ECL4T7UAl39g3IkJSVVIUO679EWk3BNbMk57SrTUAQkxV+D?=
 =?us-ascii?Q?jf0atw8vhyopxwKOnu06c44CCkHK2xbBBbdjaWHD3oH29+Ltoh9HK3mSj1g2?=
 =?us-ascii?Q?y8AV6uMjtr1paHe/arcG4XTuKv51nwXNYs8DnZ+N2ocpRgHEil9chpucNGWa?=
 =?us-ascii?Q?l56l7yCVehOUVNME5vx483yCTMjkYfmX8jkRmyP7fZ4VJ9uHOFdKbD1VjHpW?=
 =?us-ascii?Q?hhiBmudHXRUhWXu9KCMdu0cp+VEic4E3EHy4nLFqthJh9irwUgWpMLByRN7U?=
 =?us-ascii?Q?roisbSOHiAygOneQqWSVXR0jZR8rdozCAjJpw2NMwM8joF45Gb1K+IHU1VKY?=
 =?us-ascii?Q?DUA1kXoSP9VUGR6EQ11q0noke/IndogYQ/AqDoqwnI7S6JF3Ho0ZoJGEkH0+?=
 =?us-ascii?Q?ZxXtjk5mkoWhc+D7ldhQ2QaW7uqTLGHlyS/0nkGDaw3G2oaoTwrhUK2nhOjT?=
 =?us-ascii?Q?0yidMnQ+dz/S343FFwtVz7IvzQVGHnezO66GzLJlD7707c03mG0ptSk7r8QQ?=
 =?us-ascii?Q?DGQHGMQ7S27zAQfO8mNMoDcHopGtctIYgPILDQCLozGqWQob2jcSRvnwVKuj?=
 =?us-ascii?Q?n4yfpW+BfPXTie0VbYdrKfScveKZVa3zFYHTxbA+G/mJ+hsJ31bkPe6FgZR8?=
 =?us-ascii?Q?8NaSzXsWiGRDO5vsY8CausVcpvsOVbWaCAPyVLrVnqs+tVyr/PlcsPuVR75o?=
 =?us-ascii?Q?mQ8WfcwOp5G8zx5qp5fP5OqiEmhoOAh0jpfs2+NJ/mQl1iIQOlKbsLUgGQKc?=
 =?us-ascii?Q?C5aD49ltmRR56k2/F+4MCJj2fJI9wBw6i4DPZB9Fv0it7Ya42opKuVk3vdAZ?=
 =?us-ascii?Q?nR29ExVhx0NuWvuX2kKkC3mu84OttImOUzW+dwDLqSdSghQ4OQTd8URPxwI8?=
 =?us-ascii?Q?UDdx67Vd0j4itZlA00l2z1oPUDw8+KPJFRCzulBPVk1tC4NOeztP3JNBPTCP?=
 =?us-ascii?Q?JUR3FbeHhTnS2XTGDZpvZLcRkdrZdtkrNOG2VfSPirziuJOt03ohyxVFUnqz?=
 =?us-ascii?Q?xxLfyfb7R5NcXy+JqQkLW+zdcUXbFmmU2EQZMD1BNA+rdbmjt51bSltdm20A?=
 =?us-ascii?Q?zyTTeNIFwIQ6cumBWatVi7iy6VzDnCGQ1izRg41/5T5KfOFK//dkUy8EecwB?=
 =?us-ascii?Q?Nu2tu/8wX3uW5xaeqRKE7H+PQci47CLgPfovW8DDL9uxVUpR8WwO//A0AnEL?=
 =?us-ascii?Q?0iEtmv7P7c9VFoaRQg9VoKXf9l1aQruMCssjgf9LjcyHg9sjf0Ps8AxlYY8v?=
 =?us-ascii?Q?BGANc0z4DNsk6IPCKfMYAuJok1e4CMkSmotKHq0DhsT7CQv6wKpz8MZJ+Hcq?=
 =?us-ascii?Q?anng6f92Tsn83wFWY/Ox3H8YEfIvoxnh5nU89rJHDmyIdLBUqqH58L4hit+N?=
 =?us-ascii?Q?WZZcqLN6cWW7QdOfzXsga+JbKkfGOhAFgagHSyW0Psjg1+adbr3CJdXHhIha?=
 =?us-ascii?Q?RzoMBpuTFqh57god0w+ZjD5UzVXHbjkkcnW+bWZh+Wt0XQf6VZpHDf+MLbl5?=
 =?us-ascii?Q?HqYI2Crg91e3jaG3usZZ92tZFNeMhDvknOLhE8M+rmns5PD6ULjQhJKxTT7/?=
 =?us-ascii?Q?AzH1gp+HJN5L3bL9a5QKyewNyyUqNms=3D?=
X-Exchange-RoutingPolicyChecked: IS0yzvvmYlBbSDIkuC0Vff9/yF80cYkUunsHaPDxzqCAEV56qzTMk5Ciibdh7v6xGWzLrj6AQJ0gjzsgnf8Y+jV7wD0/I9ncmr0QueJFX/auVsnS9oOIrVjhqLqCbbmJTfQ4cz9q7WgTzmSQq7z0M1ckjA46i+Rf3DE2jKIY0L3O5nGAbMjxHj263nxU+kK/G3WD2ozjeaBBzExxW0pa9tV1V/t0QUzkbDB8NuGYj6KYi82VKXvq+v0QRR5TadazZPlB7XHVupK2OWdFVYqDt0DggbnMWVSNQNmqLUAaBbxOVhLrQjFdOrIF132H1NW8Sjygej7N+EEvdr8o2Ezjhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b32e38-2499-476b-6d96-08defd0f0667
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:50.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlOC4z80yoLu1KDGRHELxW8V/aSOtB8eDJsOP3MJw33/HNVMtw7waTer2LRGlMarsE0T7YJWQDBsYGV9CoMoNS6Q2nRG2ba+u8eni6BzFZQ=
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
v2:
 * Derive drm device from i915 context instead of passing
 another argument to selftests.

 drivers/gpu/drm/i915/i915_selftest.h          |  2 +
 .../gpu/drm/i915/selftests/i915_selftest.c    | 56 ++++++++++---------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index e29ca298e7eb..66707d7b35d3 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -29,6 +29,7 @@
 #define STACK_MAGIC	0xdeadbeef
 
 struct pci_dev;
+struct drm_device;
 struct drm_i915_private;
 
 struct i915_selftest {
@@ -84,6 +85,7 @@ int __intel_gt_live_setup(void *data);
 int __intel_gt_live_teardown(int err, void *data);
 
 int __i915_subtests(const char *caller,
+		    const struct drm_device *drm,
 		    int (*setup)(void *data),
 		    int (*teardown)(int err, void *data),
 		    const struct i915_subtest *st,
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..6550b05e7636 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -23,6 +23,8 @@
 
 #include <linux/random.h>
 
+#include <drm/drm_print.h>
+
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_regs.h"
@@ -41,13 +43,13 @@ struct i915_selftest i915_selftest __read_mostly = {
 
 int i915_mock_sanitycheck(void)
 {
-	pr_info(DRIVER_NAME ": %s() - ok!\n", __func__);
+	drm_info(NULL, "%s() - ok!\n", __func__);
 	return 0;
 }
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
-	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
+	drm_info(&i915->drm, "%s() - ok!\n", __func__);
 	return 0;
 }
 
@@ -154,7 +156,7 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
 				     timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
+		drm_warn(&i915->drm, "Timed out waiting for gsc_proxy_completion!\n");
 }
 
 static void
@@ -178,10 +180,10 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait &&
 	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
+		drm_warn(&i915->drm, "Timed out waiting for huc load via GSC!\n");
 }
 
-static struct mm_struct *get_selftest_mm(int u_pid_nr)
+static struct mm_struct *get_selftest_mm(const struct drm_device *drm, int u_pid_nr)
 {
 	struct task_struct *task = NULL;
 	struct mm_struct *mm = NULL;
@@ -192,19 +194,19 @@ static struct mm_struct *get_selftest_mm(int u_pid_nr)
 
 	u_pid = find_get_pid(u_pid_nr);
 	if (!u_pid) {
-		pr_warn("Could not find PID: %d\n", u_pid_nr);
+		drm_warn(drm, "Could not find PID: %d\n", u_pid_nr);
 		return NULL;
 	}
 
 	task = get_pid_task(u_pid, PIDTYPE_PID);
 	put_pid(u_pid);
 	if (!task) {
-		pr_warn("Could not find task for PID: %d\n", u_pid_nr);
+		drm_warn(drm, "Could not find task for PID: %d\n", u_pid_nr);
 		return NULL;
 	}
 
 	if (task->flags & PF_KTHREAD) {
-		pr_warn("Task not in userspace: %d\n", u_pid_nr);
+		drm_warn(drm, "Task not in userspace: %d\n", u_pid_nr);
 		put_task_struct(task);
 		return NULL;
 	}
@@ -212,7 +214,7 @@ static struct mm_struct *get_selftest_mm(int u_pid_nr)
 	mm = get_task_mm(task);
 	put_task_struct(task);
 	if (!mm) {
-		pr_warn("Could not find address space of task with PID: %d\n", u_pid_nr);
+		drm_warn(drm, "Could not find address space of task with PID: %d\n", u_pid_nr);
 		return NULL;
 	}
 
@@ -224,6 +226,8 @@ static int __run_selftests(const char *name,
 			   unsigned int count,
 			   void *data)
 {
+	struct drm_i915_private *i915 = data;
+	struct drm_device *drm = i915 ? &i915->drm : NULL;
 	struct mm_struct *mm = NULL;
 	int u_pid_nr = -1;
 	int err = 0;
@@ -241,8 +245,8 @@ static int __run_selftests(const char *name,
 
 	set_default_test_all(st, count);
 
-	pr_info(DRIVER_NAME ": Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
-		name, i915_selftest.random_seed, i915_selftest.timeout_ms);
+	drm_info(drm, "Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
+		 name, i915_selftest.random_seed, i915_selftest.timeout_ms);
 
 	/*
 	 * If we are running in a kthread on a multi NUMA system and the user passed
@@ -250,13 +254,13 @@ static int __run_selftests(const char *name,
 	 * to prepare a safe environment for the mmap selftests.
 	 */
 	if (!current->mm && u_pid_nr > 0) {
-		mm = get_selftest_mm(u_pid_nr);
+		mm = get_selftest_mm(drm, u_pid_nr);
 		if (mm) {
 			kthread_use_mm(mm);
 			if (unlikely(!current->mm)) {
 				mmput(mm);
 				mm = NULL;
-				pr_warn("Could not set mm as current->mm\n");
+				drm_warn(drm, "Could not set mm as current->mm\n");
 			}
 		}
 	}
@@ -275,7 +279,7 @@ static int __run_selftests(const char *name,
 			return -EINTR;
 		}
 
-		pr_info(DRIVER_NAME ": Running %s\n", st->name);
+		drm_info(drm, "Running %s\n", st->name);
 		if (data)
 			err = st->live(data);
 		else
@@ -299,8 +303,8 @@ static int __run_selftests(const char *name,
 	return err;
 }
 
-#define run_selftests(x, data) \
-	__run_selftests(#x, x##_selftests, ARRAY_SIZE(x##_selftests), data)
+#define run_selftests(x, drm, data) \
+	__run_selftests(#x, drm, x##_selftests, ARRAY_SIZE(x##_selftests), data)
 
 int i915_mock_selftests(void)
 {
@@ -309,7 +313,7 @@ int i915_mock_selftests(void)
 	if (!i915_selftest.mock)
 		return 0;
 
-	err = run_selftests(mock, NULL);
+	err = run_selftests(mock, NULL, NULL);
 	if (err) {
 		i915_selftest.mock = err;
 		return 1;
@@ -350,7 +354,7 @@ int i915_live_selftests(struct pci_dev *pdev)
 	__wait_gsc_proxy_completed(i915);
 	__wait_gsc_huc_load_completed(i915);
 
-	err = run_selftests(live, i915);
+	err = run_selftests(live, &i915->drm, i915);
 	if (err) {
 		i915_selftest.live = err;
 		return err;
@@ -375,7 +379,7 @@ int i915_perf_selftests(struct pci_dev *pdev)
 	__wait_gsc_proxy_completed(i915);
 	__wait_gsc_huc_load_completed(i915);
 
-	err = run_selftests(perf, i915);
+	err = run_selftests(perf, &i915->drm, i915);
 	if (err) {
 		i915_selftest.perf = err;
 		return err;
@@ -495,6 +499,8 @@ int __i915_subtests(const char *caller,
 		    unsigned int count,
 		    void *data)
 {
+	struct drm_i915_private *i915 = data;
+	struct drm_device *drm = i915 ? &i915->drm : NULL;
 	int err;
 
 	for (; count--; st++) {
@@ -507,18 +513,16 @@ int __i915_subtests(const char *caller,
 
 		err = setup(data);
 		if (err) {
-			pr_err(DRIVER_NAME "/%s: setup failed for %s\n",
-			       caller, st->name);
+			drm_err(drm, "%s: setup failed for %s\n", caller, st->name);
 			return err;
 		}
 
-		pr_info(DRIVER_NAME ": Running %s/%s\n", caller, st->name);
+		drm_info(drm, "Running %s/%s\n", caller, st->name);
 		GEM_TRACE("Running %s/%s\n", caller, st->name);
 
 		err = teardown(st->func(data), data);
 		if (err && err != -EINTR) {
-			pr_err(DRIVER_NAME "/%s: %s failed with error %d\n",
-			       caller, st->name, err);
+			drm_err(drm, "%s: %s failed with error %d\n", caller, st->name, err);
 			return err;
 		}
 	}
@@ -557,7 +561,7 @@ void igt_hexdump(const void *buf, size_t len)
 
 		if (prev && !memcmp(prev, buf + pos, rowsize)) {
 			if (!skip) {
-				pr_info("*\n");
+				drm_info(NULL, "*\n");
 				skip = true;
 			}
 			continue;
@@ -567,7 +571,7 @@ void igt_hexdump(const void *buf, size_t len)
 						rowsize, sizeof(u32),
 						line, sizeof(line),
 						false) >= sizeof(line));
-		pr_info("[%04zx] %s\n", pos, line);
+		drm_info(NULL, "[%04zx] %s\n", pos, line);
 
 		prev = buf + pos;
 		skip = false;
-- 
2.34.1

