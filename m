Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5881AC5CFED
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2782110E8EA;
	Tue, 11 Aug 2026 13:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c7bfLfbq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE84010EBC5;
 Tue, 11 Aug 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455209; x=1817991209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=TBM75t4CNV7SWgasDud4ZPzf7hIescP/4Ef4qJ9io5A=;
 b=c7bfLfbqhUZr+V193UdY7FaI5YRWc9Ay+WaMcdyRGF0mdh8iTyd3cQLF
 K1l35OXgrTg+r6dzq1m6FJvj9VR+Cn48w0Og1RafIVWuMUnm8WPHIC3Z5
 FADUsbCxuE+ffMvpEKy+ji2CyBN5Er8udJ6qGKt1ADRfqdMlEYZV0Kcb5
 5AFfgGrd9B60aefkOAMrSj9yLd2g+FXBAZsDX6JZepps6i9ZCn66uXzZe
 zqDLUDomghvpQlzOxJvG544ejFtFoZh3t8KP4tvRXW7cvIVsRoPRZg4CF
 YjEMGUxIJXr6UthbHzNofyUpWE6tldhg48kqE1XYXUKzjfurIqcsMu4s+ A==;
X-CSE-ConnectionGUID: orN9Q6bHS36FMdPb5gIhBA==
X-CSE-MsgGUID: hhfvfheGRa+fNcBIEMo4HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97331660"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="97331660"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:28 -0700
X-CSE-ConnectionGUID: 9xPE/4NnRGSyoAI447dOmQ==
X-CSE-MsgGUID: ytY0IO3NS6y+hDL34fA0tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="260730346"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zp9QhTLZ8kqDp0sz5BOHXAiEFsml3LHygbJI6gfKP8PqJ18sLkJ39JiunW9Z73kjyxmk5u81Qm+F5KFDV8VgnUayK6nLnP4G1HrIEstIAnHOQVZoui/+PjyH/iYdREDhpgJGORG3N88NoZohYUkYETMXwM3dDmaUO8wqCAF/Boh8jtl9u7NCeEVQkZdoQtGbdcShnS23usb0/PLQdn+nr6FUvD8A0aYCzLMss197SuuCvBcaQfKMIyfrCsCocboh6knBHBLCKK2l0mcPCOGMo0S68BgZxcVPo1i7iioFRwIOtK8Z8ZaOmXQjneA6IlKIY2onrCzj8Rrev8RYHu8Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgm/xRRXAfjRm6XX9mt/zwbXvUzBv7T+IDY1zKWtAPo=;
 b=BUCG0I18bsm3cQTaTiBzziU3aRXLoAyNp4cQu2RgZlD8j0rHgs2Xm6s8tEc85/5d64WXl0gIArWZBTCVGI+UM7ZYM+Q+bmTs8M+lCiCPh5H3xiquTYogZBKehz7qIG1Kwz5v2rrgePDhVcgttKdmHyK3YPRnOx+kfOWmWCHQla8D/azrrO0x8ya9zbkv3U09Ertgeu+H8JodU6A7z3ZNSut4yLPFmzRxYnzfmHL42S8/tI7Q0J31e+pT2/immQNfhLcP/vD/FRUwNUTGyr9jIlVSyEKZzZ81ApL43mlaRohK5qqQUP2fpnsfilKXXBWNMckeLFmGGY2KkAoX2r3bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 13:33:25 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:24 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 7/7] drm/i915/selftests: Use drm_* prints in selftest
 headers
Date: Tue, 11 Aug 2026 13:32:57 +0000
Message-ID: <20260811133257.1133097-8-krzysztof.karas@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SJ0PR11MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: f4295e31-21b2-4643-e643-08def7ad1e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6476ifpuVC3WVsSUvmQYtIbDPVtxFW6pZBS4uD1RYw3xLmJ8Rx/PolDhbW/jiOydvl5dyX3vz6TeMwvdJRfgn2nXLrptkKcZHGeHkeJLZCfjlMQgkXKGlQrBcMwGT7FzNUnImyavS3pLS8sJG5bysJQqXGOx3wIO0oTNWiYQv8oYzyF20WKvlDDbj2fcM8b/jUTeSntkoLhtbQMM1tr69ceW8inRdg06rwSGXOtuls3wNY0Jgr4+CX0PJMh8agK3COo9pWaPOuM0KC1m6lk87PNuxB56zMS8IZ4tLXsdbBX+9q9641CnEDdOWhMe3GJrb82oALAJSgV/WGPZilEYPznX6hLVJqWDAHIyswwMB21llbU1TMhRngI8hRuzUhStn3+0z8zOMkUYymsMxxSMsq1id/6R24EVe5yG0mrG7EHFzn7f/XLQ1QspbgWekkYUD2BZfP+0PgYnBKln0gLVLeR9hNSsGzEs/a1uOl8b+WA+DNKtfzoAwymV1K5ytrq2qfiBUFfjRGRb/85DglSNY8YkHz3VMB4jgv3RzyCf3K5JhtM0QYsRJY3xvQDbcwv45bXE5y8/Ln+l+f1Wd4LUc4Z66QrTs9z6H60SlcMaecqddJAlCdCBS7TgFYpsSBxLQmjAc7p+kEwcVAHVHV4KwjipLju7+chI882ES84UcOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vy6pmsR4I420F/XBYdZDSbCVij6gabZhJg7JGDi06mXFS04upwKMim/VdYyF?=
 =?us-ascii?Q?kbsD0FMl3Ln8F9KhePWvq0KBOT1E1wxF5WtoEZBavlgUJZfa1+EK7wQt666p?=
 =?us-ascii?Q?kEsb20W/53lMv4IHlUY/5YmfFSBD6CFzG0DwQ0PqdVTfGSY3R2thovDmdBxV?=
 =?us-ascii?Q?edlfNqkNYK3lSYQ5oIMOvUUqUhJuu4Kzr0qa+WQ2rJDeFQ1p+u52vtL7E4Q6?=
 =?us-ascii?Q?GEbImKEVLNKNjnD/zCjN+Fam65keIStHYsF4xkXdm1EloPS2f0Im+XLc4LGV?=
 =?us-ascii?Q?Tkoo4n3CJFuxTJLU6tFQ8qDGXN66k/KNhZH4z33FYIHfup7Wh4+js55RLA3O?=
 =?us-ascii?Q?yWD34LcJqSRjb/ctr3sY2u4nsHy7xywHgBb/bMn6+g92eEtom7z+PGvzVcWI?=
 =?us-ascii?Q?E7+h1kIk9+4lBuef3oEMyXIqIbv68t7c1X8jmKqE6FEgVMDfVV/j1WjqYgt3?=
 =?us-ascii?Q?FIvKhkXO8Jnfcj9CNhWxWMLGZC3zvGCmqyZJ0SI0zoog6xLuRr7mwz1o2r4r?=
 =?us-ascii?Q?ajzWhRuieCa1Ih51m3Bcb4B1zqEN5h+s5AARimBDlGjLhHkiHtDnrh3p/s1s?=
 =?us-ascii?Q?OeP74fOOhajF3lxzzHp5uavknQEQdXwgRSzE3RyhspXblu0cANXhpTF8qApQ?=
 =?us-ascii?Q?FHs3AECvxtTvpWlvpF57jqQNX8UuRuSHMPSQUsqlN7ztL1hhWrvpaSUG6+kI?=
 =?us-ascii?Q?MunXwzAyVNFC41PwDMQjDv3fCNK9sFCTah0bMf5qvkD1EAJf2dxQP5904zjD?=
 =?us-ascii?Q?aMrelkRT4mDUE6ios9GFITOTU3ghGojU1manXqHLE1ZD+qz2+WdYXc0ZXtRx?=
 =?us-ascii?Q?J0jsISLkVMF+uGQNsZT1Sr4f1KV8rs0myptmGoft3itE5PYcVDIa9uaR3BdB?=
 =?us-ascii?Q?XBVvYAA8q7DJAXoJW24aOTk7DjBCR9SW6soNcnprofm3685Y3KI2TN9MPy7r?=
 =?us-ascii?Q?WzLAeFnD6uMq3eMQVMvCp/OFaHOabl8cla79VzagPALpCJHn3qPaiJsMy85j?=
 =?us-ascii?Q?ayvaaUBwNCfzTLSAI0l93cbAea21Vf2krpbEEjOChuacZ3EkrNxWKgTALhYc?=
 =?us-ascii?Q?WjbKyhv3uUuIFkj9eJeKR71pw3VwSUOnq1VAatzmk+NBL/1Z45/E23ET1aow?=
 =?us-ascii?Q?xfLRzaSSP1vjo9idUjh4HPz5SCdi8oAwkS9U2m9kLWS9JK15p7bBsw1plbvd?=
 =?us-ascii?Q?hmXKefcv1J2aep9uajM/pK6B7XmnWq3tWO9zE4IAp+VM523T8UNG/lhQGKhp?=
 =?us-ascii?Q?q5eNzoUKXxeIAY1V6jQxsX3hRSP1BLXbUqql42Zk8aGL3KqjGGNV95xdPMNI?=
 =?us-ascii?Q?ydOmKyp2X6cu7WlK321BfFmX7uiMtZfiuvsMEZAXCwgFV0O0HUFCLppecIKO?=
 =?us-ascii?Q?J89QeDCwkY1o5CLLeuGSNGTqlPnrte9VJUPP2ROnCrgOg+j1CqX53qkwd/dt?=
 =?us-ascii?Q?VvTc6R14VmO1oNjHo7kEWvCQB9Lo3vnZkQTt/h8G8pZpqbY1XKTBuDrz+/7X?=
 =?us-ascii?Q?hU8XabbUctGqo7Ro7nC0KvfEuzEylJGtFGq4G01BKPmUScMw8K0Dc+2Y5y+7?=
 =?us-ascii?Q?pZUP+gah/UaNLp9Hnzy4Sd0/zB/SPkrMf7dLQeM4XtidGyWSQpvFtIghMJWw?=
 =?us-ascii?Q?bEiVye6+Q3egWFj9SNaMwsko+SMSnwEKIGZekU1hmjVCP7qWbJxKEIjlWXqS?=
 =?us-ascii?Q?dy7L7zLL6NptvwQVg5UVb+x6uZ/qcmkHUgzTUCulO24tnyEsApkVtOFzJs4q?=
 =?us-ascii?Q?+1xGyUHlWkX5OHbJIIcGv+totQoXJJ4=3D?=
X-Exchange-RoutingPolicyChecked: JOrksj1nEZUxfooiNbIIP2KjNlmBgVkmWwxklx/A2tnPcJuFCgSlFzKLO8c5rLAHUSQSFpyEUASYtsqlaSNR7ssOo+LG1eMtGBJNeV47nwibpxa25EW2dH4J3DIe8PJ1WOiyI5d3ZAXHxMs8dfS7Kri86/c8cV96Z+H3UFxqvOYBTiDuZled/Eo5JlEEiK/cUwg97zB9NdiXgfSJT1TU/KZTUTT0ijUDJ99LpcM8Y0jN1HlmEL8riWTi6jCdLFWy9EduTeMKS82XxKQVguyEkcSV4v2GSDi2B3Q7DHf3MLFX1IHs9gkvJX1H6G+xMnj0856ljdhve5A8N4sHbHMVLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4295e31-21b2-4643-e643-08def7ad1e6d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:24.7378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcvLlxezc+NnhHbrdu3uyvo6Ca+W9Rbgjof3urlOkIptjEoZLuR3v5VpeagVdinIn3VFI+kDIZtTu9BkaLw4hu0+pxoau3AasX7UnorKlCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
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
 drivers/gpu/drm/i915/i915_selftest.h          |  5 ++
 .../gpu/drm/i915/selftests/i915_selftest.c    | 56 ++++++++++---------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index e29ca298e7eb..59bb1574e2fe 100644
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
@@ -91,12 +93,14 @@ int __i915_subtests(const char *caller,
 		    void *data);
 #define i915_subtests(T, data) \
 	__i915_subtests(__func__, \
+		    NULL, \
 			__i915_nop_setup, __i915_nop_teardown, \
 			T, ARRAY_SIZE(T), data)
 #define i915_live_subtests(T, data) ({ \
 	typecheck(struct drm_i915_private *, data); \
 	(data)->gt[0]->uc.guc.submission_state.sched_disable_delay_ms = 0; \
 	__i915_subtests(__func__, \
+			&(data)->drm, \
 			__i915_live_setup, __i915_live_teardown, \
 			T, ARRAY_SIZE(T), data); \
 })
@@ -104,6 +108,7 @@ int __i915_subtests(const char *caller,
 	typecheck(struct intel_gt *, data); \
 	(data)->uc.guc.submission_state.sched_disable_delay_ms = 0; \
 	__i915_subtests(__func__, \
+			&(data)->i915->drm, \
 			__intel_gt_live_setup, __intel_gt_live_teardown, \
 			T, ARRAY_SIZE(T), data); \
 })
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..84da45a2e8c5 100644
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
 
@@ -220,6 +222,7 @@ static struct mm_struct *get_selftest_mm(int u_pid_nr)
 }
 
 static int __run_selftests(const char *name,
+			   const struct drm_device *drm,
 			   struct selftest *st,
 			   unsigned int count,
 			   void *data)
@@ -241,8 +244,9 @@ static int __run_selftests(const char *name,
 
 	set_default_test_all(st, count);
 
-	pr_info(DRIVER_NAME ": Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
-		name, i915_selftest.random_seed, i915_selftest.timeout_ms);
+	drm_info(drm,
+		 "Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
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
@@ -489,6 +493,7 @@ int __intel_gt_live_teardown(int err, void *data)
 }
 
 int __i915_subtests(const char *caller,
+		    const struct drm_device *drm,
 		    int (*setup)(void *data),
 		    int (*teardown)(int err, void *data),
 		    const struct i915_subtest *st,
@@ -507,18 +512,17 @@ int __i915_subtests(const char *caller,
 
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
+			drm_err(drm, "%s: %s failed with error %d\n",
+				caller, st->name, err);
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

