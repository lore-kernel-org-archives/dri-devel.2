Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1385C5CFEE
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD8F10EBC5;
	Tue, 11 Aug 2026 13:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HXOMMn+y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDFE10EBC7;
 Tue, 11 Aug 2026 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455207; x=1817991207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=p9GMPK4m7b2AL7bmfNsoP1+QK6ZcUsU148c5phYgkAg=;
 b=HXOMMn+yvX6ON40Hn1vs8FsqCzujUsDkxKahkN/zJQnp/tVrg0ESEzJX
 sEmfI7F/Y+CvPARFJ1afHVQd2d85g0k9v0fq+tq7XMXa+D/h7tUQWqkUL
 EEcqrArQWiiUIyyqHQ9MRSm3eBzuAhGXGpMvG+XLZVU7xwEOZ51JqnBNf
 AWGRj8aX2kMQ7NaKLj3JkSsJCkYdOUhspL19icTbT7SKmOb0CDBnDxrmT
 eOCAWhQz9Mx9ECI2DjOXEUVU1Ec6BvmSA8unBMOn74S2b0tZQaVWJ8kwF
 sPkcMacV/jeMHngR6xis3GhE7qXizS7MMDWENHY1iIFye5l1f28P09sjl Q==;
X-CSE-ConnectionGUID: wjZWcnZ6SR2B+G/Z1C0I4w==
X-CSE-MsgGUID: D0mGFOV8SL23KPGzc8kJmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104374874"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="104374874"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:27 -0700
X-CSE-ConnectionGUID: 9gtALF4vQ2Gc7x0okNbv4Q==
X-CSE-MsgGUID: xYmdxdaRTsiq73JggFq+gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="267187715"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:26 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsQoFFx1yevFpTCrwMQLY0yyHxM11mjjfMoBCyMsDTVp6nMmI+1SWe02rhDQ815PjySTAMbZjlcVwF2IJDIG3huZWkv4xtIqU8ok9nOUiQg2/zmJ7udRj3D/JkX20NARFV92CyhKJ7Nj5DC7lCueNKWWAvRx8jHQWM7Y33wJJoziZsmOVbIss+5CxoGKWKm9lLEo8h2GDBVqumbTsVHz05Mt9lK88hBp3mgLnOvTV0NgcgsaDlZj/xU9rnmFhXthOsyeuNjIpe18w08PegTGSPXvyrwzSqYhlItYBiESUDNud9fPqg7NZwSrrdOzm3NOP0b365V+uLxyqAUuH9cy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvgeBeKlg59tRCPF4knfHekyyEpVS2Nvm8sztrcVvyk=;
 b=TRId7u1NpALApPXKdxLFvdDcsvAL/nF4lBtdUwsovf0ycSQKShCha0Sa2nhYZuGxoefJvuMYD7Tz/0mi1nFnWQBH+VZiKMXZd0cGPo21ciLwfaIGr2aKrIHRZsra2zFfXU13XAMskFu+kDQ05laVKlPxGp2rkbwyeqrGbTDAhAptOBCZQdiszyLoaD9/gCnILrvdein8k2ohgz+86olcYat75EFWBX7O/r7b0Kxa/+H3ATHNIMHwCBqglVexe0ZVZl9lYQGAavVeCSG0KGWd34iZojhKeNqG9Y6eLlQP3HZ7A6sAcMv3k9jpRVRIT2oAZmQ2EDCCAc6OqewV+XWq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Tue, 11 Aug 2026 13:33:19 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:19 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 5/7] drm/i915/gt/selftests: Use drm_* prints in gt
 standalone tests
Date: Tue, 11 Aug 2026 13:32:55 +0000
Message-ID: <20260811133257.1133097-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4800a32c-9fae-4cba-4e07-08def7ad1b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9mxfvVRsHdmt5czi40BfT++jFOV7No5phVYYLSZquCrQzzJrffSIdDNCF+j2xzv/7Gt/kJaAuY3km5zF7ZkrPlHP8ba4yyQaM4TFVvWqoP+hXXb8jyImKfpbJKZmxzXpAkUzQPIvZ7vb3hQs3mEDIPTFSpNz7mziVCBF6Wh4V+ChYIZxaTnWuGVQiIuQCnHT3ryeNJuL6yiTl/xouTEq6UIlQnQZ7B9HffDSFc8aMD9JdwfpJlT4QcXETxumRZdBJRXFMJ99m9GHraIOg+s0MYKbKqcWLW5oYU7qZhGLfk9QlNRKeqvPV/Ckdjk/r874GLX3wTjVN4KOJHzxQWrzk3xMoqIm63o9Y7/x57N7De/1qieIIBtJUcwYMYBF/aXwjkGJiDtbis0onM9x+6CwkPuD0dy+Kuz6e+gl2d6Cob+zc2aIzcD1YDSZhUwB17p7azLm+Y7nzNNNAzK91Joq/VACl99evnk1Wxj5jf+7Cdws8RxuDph6FRlIxpSG/LyIT/brMvqV9y59fzq0VZqkL7fFS0/m6w/osd5FbAdmv1NcRBy7fyB/yPdL7YuKXZYIF3DrvFJDrOcDvQ2Ewi9Oh3OOOX5NEjVoRuStYGXBVyzk13zCEnsfm03o9U07wn6A/Os+91c+xRHChn2V6kjao43A/97h3p9CzteXqZU1Fis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RP754FT0e2QFw4BeymEtpkq7Zt7z132oBJxOb5Y23ISfHgNNhiq1NcfDtG7D?=
 =?us-ascii?Q?zxqiQGUNQGxjw3URowUrgi78TnrXTuG8xtiVwEhJmmQfyIZE+vwEPmMrSVVh?=
 =?us-ascii?Q?VmQwy8MPQI08VNpMGGJtbuC3k+GCBFNS1udnGaS3YAuGZ13j6Jeg1D1/cTsA?=
 =?us-ascii?Q?vxUmXR+sdQMVV2sZajZoj7z76WGvxO1CZuc6lghLr8AwIxi5cW6pJWGckROX?=
 =?us-ascii?Q?cnss54j0J8c4xRtCPr8N/7hk5TZQPrvU1Z800Kvv3ZrbFvKqCGWwIaCem+uH?=
 =?us-ascii?Q?3nZhUoy7AFSp5sjJJKW9nTY2Xy4WBV7cAu4/MO6JnXMLLyTQrzexjpUuyJsu?=
 =?us-ascii?Q?ykK7HRHc4pwdgSIVpEH48kKA/pKwASX3GtusEnBGnFzot/WeeSROf34pqt8Q?=
 =?us-ascii?Q?EdFosRUeWRWpZDtLKAbvmynMknKy2Ii1KAgcjCyeT8w9hINR7o50p7lXV56N?=
 =?us-ascii?Q?EENgw1P8J4sffbtSQGNdE4ijERYHg0kDeXJDsSQPiORnO0NrLdPcXtA1XFQL?=
 =?us-ascii?Q?zYP2r2wTIwqQnmNXOWO9kcS5M+jm0NcMNW1/oNwWnsIsnZN9fv2v8wSQp73g?=
 =?us-ascii?Q?CdAOKMaeUjZIzXbFkppxfEz09Q7AoHEqGwxQZ694mT4mfJNbNOxLpT+BmGjw?=
 =?us-ascii?Q?k2EeqYdV5iT6T+VEPDmMpxkxx/egRuZHJCK4ZlYKeo9K82z46MjN8pInRa2v?=
 =?us-ascii?Q?bFcsZ55lDa55wR6eeagfHAukkFWvl8LzD13P5ioaD3v+e+Dc3aXax5NxfLfo?=
 =?us-ascii?Q?ImxiygSQH8HA2/fHzlGXHvShxUzLv58sXoGW/qDh/gQTheputzMDsYbGDBDT?=
 =?us-ascii?Q?cyIpU6e3q/lGsY5YQz84w3TXoWE7bpWbsjrG/EP4RRL9HSOMDDWXH0sNg/cF?=
 =?us-ascii?Q?CQQOULtllabfVapS2Wy24mW67BOKQyLLg8+GwE23o3CWLDlFf5hxaw0NFTar?=
 =?us-ascii?Q?znlOWFNjM9UgHc3X7q/buVnkTr+oG8ULjIoBxeDOgKdY2Tf+HFIFLTLKiWrG?=
 =?us-ascii?Q?+mvp4tobongO1TjY78HK1L8pMpGLPz0a4vnP5OOzQqRRaApwzbnI1i8HrzKS?=
 =?us-ascii?Q?DQipE+b4PYEfM+1Mj3ouUk177w/OURfblYxvJXoBoQHW+9DJxG4jAtca8q5N?=
 =?us-ascii?Q?o5fuEe3cICf8loylrbZFSQOilUMi79OthzjSV+LmOztZ2lCBucJcf2i+t2nQ?=
 =?us-ascii?Q?p+Zo7TbWWzc1UtmAj93GCOwNpyOYxP8ALCT6jKRj93zZj4rsVERaLqGuEBmU?=
 =?us-ascii?Q?wMkQwUiIMSCr8Pb8LvWpkvk3AdZ4yUZOMkHbkTUekx8OjDy2X1EI7XaJZpGn?=
 =?us-ascii?Q?ogtN07RyQRkn1oqiIwcW6fbZaBhGpqZSt/aL/lwsMgsLupZF6w21zuCQCW95?=
 =?us-ascii?Q?T0YxMSHjCbMz95JNBOCjo3aRFzm80cypsiQ4Dh/2yPrggCtn1pW4RbyZX4To?=
 =?us-ascii?Q?s2nwYMspmcHg1rUDl93BoMbBhTxOfYjIvXWEd6x2qiKDnPhCslSwSLlviCGu?=
 =?us-ascii?Q?SqQ0sdtBHQp8tE5SG1aI7eZ4tEm5LLRuxD18TNAlqJQReDP18Bv6Hg4E6OrZ?=
 =?us-ascii?Q?hJYGTSNe9XlxJZWn7zERx5uE2RwAyq+nQLNmqAAy0U7dFFgR98ddHgU8ctEn?=
 =?us-ascii?Q?RrLVa/9VHozAB0pTLAO0Gsoqk/rGXaa6z+ZWmWgTX7H4azBRWjpEqhtq3y5t?=
 =?us-ascii?Q?WzfJXO7hRFfTWsuOHGAu4XlrsOU92vtVVe10dB6uofpd9mIwv3o+aW7m819w?=
 =?us-ascii?Q?jWS9k7h4B08Qz9dDssGuNkBQkNrZp3E=3D?=
X-Exchange-RoutingPolicyChecked: kBPxgpiXe0uV5bfjs2K4a0LhL+5kF//nXBwJanDcqD6tIIGZLS3+peatdopWkXqWIjABlQaUPxfhoo60FxQMQ82gEvKpouWAu+SmjKeOFBZXM9tZ+JLFWWBqiwaH0laqP713EXeu2njX4tL43f2jkbL8ZcVSZto7MtZxRdCLeALuagKO05JDVsJSRQRd15U9YHk5OHH3p6X0bZ0XtD+IxbR9JG1vKLPtixS7XjUcFmpdY4KVlr9fjq0Ze3+qzqjsCgCx9LRJYTroYBrk0azn/gt6QDt16f40EXQSMeevaZaceoPAR/7AXRffvk7qQ6DLXEbVUwSRab3udKxuqxP3Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4800a32c-9fae-4cba-4e07-08def7ad1b21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:19.2140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSPAhx8kbMGuh5WsrqLsOfA9iqj41H8kez7TMbzHU7Sxcj6im50UfU1tGthwBXWPLvgR5Mh2l79chEfOAF0zQKKtVrtFf/P95JQoGDRwoSI=
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
 drivers/gpu/drm/i915/gt/selftest_rc6.c |  56 ++++---
 drivers/gpu/drm/i915/gt/selftest_rps.c | 218 ++++++++++++++-----------
 2 files changed, 156 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_rc6.c b/drivers/gpu/drm/i915/gt/selftest_rc6.c
index 90f30b988d68..9bdc22d61626 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rc6.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rc6.c
@@ -14,6 +14,8 @@
 #include "selftests/i915_random.h"
 #include "selftests/librapl.h"
 
+#include <drm/drm_print.h>
+
 static u64 rc6_residency(struct intel_rc6 *rc6)
 {
 	u64 result;
@@ -80,8 +82,9 @@ int live_rc6_manual(void *arg)
 	res[1] = rc6_residency(rc6);
 	rc0_freq = intel_rps_read_actual_frequency_fw(rps);
 	if ((res[1] - res[0]) >> 10) {
-		pr_err("RC6 residency increased by %lldus while disabled for 1000ms!\n",
-		       (res[1] - res[0]) >> 10);
+		drm_err(&gt->i915->drm,
+			"RC6 residency increased by %lldus while disabled for 1000ms!\n",
+			(res[1] - res[0]) >> 10);
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -92,10 +95,12 @@ int live_rc6_manual(void *arg)
 
 		if (!rc0_power) {
 			if (rc0_freq)
-				pr_debug("No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
-					 rc0_freq);
+				drm_dbg(&gt->i915->drm,
+					"No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
+					rc0_freq);
 			else
-				pr_err("No power and freq measured while in RC0\n");
+				drm_err(&gt->i915->drm,
+					"No power and freq measured while in RC0\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -114,32 +119,37 @@ int live_rc6_manual(void *arg)
 	dt = ktime_sub(ktime_get(), dt);
 	res[1] = rc6_residency(rc6);
 	if (res[1] == res[0]) {
-		pr_err("Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
-		       intel_uncore_read_fw(gt->uncore, GEN6_RC_STATE),
-		       intel_uncore_read_fw(gt->uncore, GEN6_RC_CONTROL),
-		       res[0]);
+		drm_err(&gt->i915->drm,
+			"Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
+			intel_uncore_read_fw(gt->uncore, GEN6_RC_STATE),
+			intel_uncore_read_fw(gt->uncore, GEN6_RC_CONTROL),
+			res[0]);
 		err = -EINVAL;
 	}
 
 	if (has_power) {
 		rc6_power = div64_u64(NSEC_PER_SEC * rc6_sample_energy[1],
 				      ktime_to_ns(dt));
-		pr_info("GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
-			rc0_power, rc6_power);
+		drm_info(&gt->i915->drm,
+			 "GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
+			 rc0_power, rc6_power);
 
 		if (2 * rc6_power > rc0_power) {
-			pr_err("GPU leaked energy while in RC6!\n"
-			       "GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
-			       "RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
-			       "RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
-			       rc6_freq, rc0_freq, rc0_sample_energy[0], rc0_sample_energy[1],
-			       rc6_sample_energy[0], rc6_sample_energy[1]);
+			drm_err(&gt->i915->drm,
+				"GPU leaked energy while in RC6!\n"
+				"GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
+				"RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
+				"RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
+				rc6_freq, rc0_freq,
+				rc0_sample_energy[0], rc0_sample_energy[1],
+				rc6_sample_energy[0], rc6_sample_energy[1]);
 
 			diff = res[1] - res[0];
 			threshold = (9 * NSEC_PER_MSEC * sleep_time) / 10;
 			if (diff < threshold)
-				pr_err("Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
-				       res[0], res[1]);
+				drm_err(&gt->i915->drm,
+					"Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
+					res[0], res[1]);
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -265,13 +275,13 @@ int live_rc6_ctx_wa(void *arg)
 			}
 
 			intel_gt_pm_wait_for_idle(gt);
-			pr_debug("%s: CTX_INFO=%0x\n",
-				 engine->name, READ_ONCE(*res));
+			drm_dbg(&engine->i915->drm, "%s: CTX_INFO=%0x\n",
+				engine->name, READ_ONCE(*res));
 
 			if (resets !=
 			    i915_reset_engine_count(error, engine)) {
-				pr_err("%s: GPU reset required\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: GPU reset required\n", engine->name);
 				add_taint_for_CI(gt->i915, TAINT_WARN);
 				err = -EIO;
 				goto out;
diff --git a/drivers/gpu/drm/i915/gt/selftest_rps.c b/drivers/gpu/drm/i915/gt/selftest_rps.c
index be77fba2ec49..3edeae4f7fe0 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rps.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rps.c
@@ -6,6 +6,8 @@
 #include <linux/pm_qos.h>
 #include <linux/sort.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_internal.h"
 
 #include "i915_reg.h"
@@ -204,12 +206,12 @@ static void show_pstate_limits(struct intel_rps *rps)
 	struct drm_i915_private *i915 = rps_to_i915(rps);
 
 	if (IS_BROXTON(i915)) {
-		pr_info("P_STATE_CAP[%x]: 0x%08x\n",
+		drm_info(&i915->drm, "P_STATE_CAP[%x]: 0x%08x\n",
 			i915_mmio_reg_offset(BXT_RP_STATE_CAP),
 			intel_uncore_read(rps_to_uncore(rps),
 					  BXT_RP_STATE_CAP));
 	} else if (GRAPHICS_VER(i915) == 9) {
-		pr_info("P_STATE_LIMITS[%x]: 0x%08x\n",
+		drm_info(&i915->drm, "P_STATE_LIMITS[%x]: 0x%08x\n",
 			i915_mmio_reg_offset(GEN9_RP_STATE_LIMITS),
 			intel_uncore_read(rps_to_uncore(rps),
 					  GEN9_RP_STATE_LIMITS));
@@ -264,8 +266,8 @@ int live_rps_clock_interval(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: RPS spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -290,8 +292,9 @@ int live_rps_clock_interval(void *arg)
 						  GEN6_RP_CUR_UP_EI),
 			     10)) {
 			/* Just skip the test; assume lack of HW support */
-			pr_notice("%s: rps evaluation interval not ticking\n",
-				  engine->name);
+			drm_notice(&engine->i915->drm,
+				   "%s: rps evaluation interval not ticking\n",
+				   engine->name);
 			err = -ENODEV;
 		} else {
 			ktime_t dt_[5];
@@ -330,21 +333,24 @@ int live_rps_clock_interval(void *arg)
 			u32 expected =
 				intel_gt_ns_to_pm_interval(gt, dt);
 
-			pr_info("%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
-				engine->name, cycles, time, dt, expected,
-				gt->clock_frequency / 1000);
+			drm_info(&engine->i915->drm,
+				 "%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
+				 engine->name, cycles, time, dt, expected,
+				 gt->clock_frequency / 1000);
 
 			if (10 * time < 8 * dt ||
 			    8 * time > 10 * dt) {
-				pr_err("%s: rps clock time does not match walltime!\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: rps clock time does not match walltime!\n",
+					engine->name);
 				err = -EINVAL;
 			}
 
 			if (10 * expected < 8 * cycles ||
 			    8 * expected > 10 * cycles) {
-				pr_err("%s: walltime does not match rps clock ticks!\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: walltime does not match rps clock ticks!\n",
+					engine->name);
 				err = -EINVAL;
 			}
 		}
@@ -424,8 +430,8 @@ int live_rps_control(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: RPS spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -434,8 +440,9 @@ int live_rps_control(void *arg)
 		}
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not set minimum frequency [%x], only %x!\n",
-			       engine->name, rps->min_freq, read_cagf(rps));
+			drm_err(&engine->i915->drm,
+				"%s: could not set minimum frequency [%x], only %x!\n",
+				engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			show_pstate_limits(rps);
@@ -451,8 +458,9 @@ int live_rps_control(void *arg)
 		limit = rps_set_check(rps, f);
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not restore minimum frequency [%x], only %x!\n",
-			       engine->name, rps->min_freq, read_cagf(rps));
+			drm_err(&engine->i915->drm,
+				"%s: could not restore minimum frequency [%x], only %x!\n",
+				engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			show_pstate_limits(rps);
@@ -474,7 +482,8 @@ int live_rps_control(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
+		drm_info(&engine->i915->drm,
+			 "%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
 			engine->name,
 			rps->min_freq, intel_gpu_freq(rps, rps->min_freq),
 			rps->max_freq, intel_gpu_freq(rps, rps->max_freq),
@@ -483,8 +492,9 @@ int live_rps_control(void *arg)
 
 		if (limit != rps->max_freq) {
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 			show_pstate_limits(rps);
 		}
 
@@ -523,14 +533,14 @@ static void show_pcu_config(struct intel_rps *rps)
 
 	wakeref = intel_runtime_pm_get(rps_to_uncore(rps)->rpm);
 
-	pr_info("%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
+	drm_info(&i915->drm, "%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
 	for (gpu_freq = min_gpu_freq; gpu_freq <= max_gpu_freq; gpu_freq++) {
 		int ia_freq = gpu_freq;
 
 		snb_pcode_read(rps_to_gt(rps)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 			       &ia_freq, NULL);
 
-		pr_info("%5d  %5d  %5d\n",
+		drm_info(&i915->drm, "%5d  %5d  %5d\n",
 			gpu_freq * 50,
 			((ia_freq >> 0) & 0xff) * 100,
 			((ia_freq >> 8) & 0xff) * 100);
@@ -669,8 +679,8 @@ int live_rps_frequency_cs(void *arg)
 
 		if (wait_for(intel_uncore_read(engine->uncore, CS_GPR(0)),
 			     10)) {
-			pr_err("%s: timed loop did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: timed loop did not start\n", engine->name);
 			goto err_vma;
 		}
 
@@ -680,7 +690,8 @@ int live_rps_frequency_cs(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_cs_frequency_at(rps, engine, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+		drm_info(&engine->i915->drm,
+			 "%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
 			engine->name,
 			min.count, intel_gpu_freq(rps, min.freq),
 			max.count, intel_gpu_freq(rps, max.freq),
@@ -692,10 +703,11 @@ int live_rps_frequency_cs(void *arg)
 				   2, 3)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
-			       engine->name,
-			       max.freq * min.count,
-			       min.freq * max.count);
+			drm_err(&engine->i915->drm,
+				"%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+				engine->name,
+				max.freq * min.count,
+				min.freq * max.count);
 			show_pcu_config(rps);
 
 			for (f = min.freq + 1; f <= rps->max_freq; f++) {
@@ -706,7 +718,8 @@ int live_rps_frequency_cs(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
+				drm_info(&engine->i915->drm,
+					 "%s: %x:%uMHz: %lluKHz [%d%%]\n",
 					engine->name,
 					act, intel_gpu_freq(rps, act), count,
 					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
@@ -807,8 +820,8 @@ int live_rps_frequency_srm(void *arg)
 			goto err_vma;
 
 		if (wait_for(READ_ONCE(*cntr), 10)) {
-			pr_err("%s: timed loop did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: timed loop did not start\n", engine->name);
 			goto err_vma;
 		}
 
@@ -818,7 +831,8 @@ int live_rps_frequency_srm(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_frequency_at(rps, cntr, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+		drm_info(&engine->i915->drm,
+			 "%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
 			engine->name,
 			min.count, intel_gpu_freq(rps, min.freq),
 			max.count, intel_gpu_freq(rps, max.freq),
@@ -830,10 +844,11 @@ int live_rps_frequency_srm(void *arg)
 				   1, 2)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
-			       engine->name,
-			       max.freq * min.count,
-			       min.freq * max.count);
+			drm_err(&engine->i915->drm,
+				"%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+				engine->name,
+				max.freq * min.count,
+				min.freq * max.count);
 			show_pcu_config(rps);
 
 			for (f = min.freq + 1; f <= rps->max_freq; f++) {
@@ -844,7 +859,8 @@ int live_rps_frequency_srm(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
+				drm_info(&engine->i915->drm,
+					 "%s: %x:%uMHz: %lluKHz [%d%%]\n",
 					engine->name,
 					act, intel_gpu_freq(rps, act), count,
 					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
@@ -915,31 +931,31 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_add(rq);
 
 	if (!igt_wait_for_spinner(spin, rq)) {
-		pr_err("%s: RPS spinner did not start\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS spinner did not start\n", engine->name);
 		i915_request_put(rq);
 		intel_gt_set_wedged(engine->gt);
 		return -EIO;
 	}
 
 	if (!intel_rps_is_active(rps)) {
-		pr_err("%s: RPS not enabled on starting spinner\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS not enabled on starting spinner\n", engine->name);
 		igt_spinner_end(spin);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_events & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: RPS did not register UP interrupt\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not register UP interrupt\n", engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->min_freq) {
-		pr_err("%s: RPS did not program min frequency\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not program min frequency\n", engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
@@ -955,17 +971,19 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_put(rq);
 
 	if (rps->cur_freq != rps->min_freq) {
-		pr_err("%s: Frequency unexpectedly changed [up], now %d!\n",
-		       engine->name, intel_rps_read_actual_frequency(rps));
+		drm_err(&engine->i915->drm,
+			"%s: Frequency unexpectedly changed [up], now %d!\n",
+			engine->name, intel_rps_read_actual_frequency(rps));
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_iir & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
-		       engine->name, rps->pm_iir,
-		       intel_uncore_read(uncore, GEN6_RP_PREV_UP),
-		       intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
-		       intel_uncore_read(uncore, GEN6_RP_UP_EI));
+		drm_err(&engine->i915->drm,
+			"%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
+			engine->name, rps->pm_iir,
+			intel_uncore_read(uncore, GEN6_RP_PREV_UP),
+			intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_UP_EI));
 		return -EINVAL;
 	}
 
@@ -981,14 +999,14 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	rps_set_check(rps, rps->max_freq);
 
 	if (!(rps->pm_events & GEN6_PM_RP_DOWN_THRESHOLD)) {
-		pr_err("%s: RPS did not register DOWN interrupt\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not register DOWN interrupt\n", engine->name);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->max_freq) {
-		pr_err("%s: RPS did not program max frequency\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not program max frequency\n", engine->name);
 		return -EINVAL;
 	}
 
@@ -999,21 +1017,23 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	sleep_for_ei(rps, timeout);
 
 	if (rps->cur_freq != rps->max_freq) {
-		pr_err("%s: Frequency unexpectedly changed [down], now %d!\n",
-		       engine->name,
-		       intel_rps_read_actual_frequency(rps));
+		drm_err(&engine->i915->drm,
+			"%s: Frequency unexpectedly changed [down], now %d!\n",
+			engine->name,
+			intel_rps_read_actual_frequency(rps));
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_iir & (GEN6_PM_RP_DOWN_THRESHOLD | GEN6_PM_RP_DOWN_TIMEOUT))) {
-		pr_err("%s: DOWN interrupt not recorded for idle, pm_iir:%x, prev_down:%x, down_threshold:%x, down_ei:%x [prev_up:%x, up_threshold:%x, up_ei:%x]\n",
-		       engine->name, rps->pm_iir,
-		       intel_uncore_read(uncore, GEN6_RP_PREV_DOWN),
-		       intel_uncore_read(uncore, GEN6_RP_DOWN_THRESHOLD),
-		       intel_uncore_read(uncore, GEN6_RP_DOWN_EI),
-		       intel_uncore_read(uncore, GEN6_RP_PREV_UP),
-		       intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
-		       intel_uncore_read(uncore, GEN6_RP_UP_EI));
+		drm_err(&engine->i915->drm,
+			"%s: DOWN interrupt not recorded for idle, pm_iir:%x, prev_down:%x, down_threshold:%x, down_ei:%x [prev_up:%x, up_threshold:%x, up_ei:%x]\n",
+			engine->name, rps->pm_iir,
+			intel_uncore_read(uncore, GEN6_RP_PREV_DOWN),
+			intel_uncore_read(uncore, GEN6_RP_DOWN_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_DOWN_EI),
+			intel_uncore_read(uncore, GEN6_RP_PREV_UP),
+			intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_UP_EI));
 		return -EINVAL;
 	}
 
@@ -1043,7 +1063,8 @@ int live_rps_interrupt(void *arg)
 	with_intel_gt_pm(gt, wakeref)
 		pm_events = rps->pm_events;
 	if (!pm_events) {
-		pr_err("No RPS PM events registered, but RPS is enabled?\n");
+		drm_err(&gt->i915->drm,
+			"No RPS PM events registered, but RPS is enabled?\n");
 		return -ENODEV;
 	}
 
@@ -1186,8 +1207,8 @@ int live_rps_power(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: RPS spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -1207,29 +1228,33 @@ int live_rps_power(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
+		drm_info(&engine->i915->drm, "%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
 			engine->name,
 			min.power, intel_gpu_freq(rps, min.freq),
 			max.power, intel_gpu_freq(rps, max.freq));
 
 		if (10 * min.freq >= 9 * max.freq) {
-			pr_notice("Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
-				  min.freq, intel_gpu_freq(rps, min.freq),
-				  max.freq, intel_gpu_freq(rps, max.freq));
+			drm_notice(&engine->i915->drm,
+				   "Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
+				   min.freq, intel_gpu_freq(rps, min.freq),
+				   max.freq, intel_gpu_freq(rps, max.freq));
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 			continue;
 		}
 
 		if (11 * min.power > 10 * max.power) {
-			pr_err("%s: did not conserve power when setting lower frequency!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: did not conserve power when setting lower frequency!\n",
+				engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 
 			err = -EINVAL;
 			break;
@@ -1273,9 +1298,9 @@ int live_rps_dynamic(void *arg)
 		return -ENOMEM;
 
 	if (intel_rps_has_interrupts(rps))
-		pr_info("RPS has interrupt support\n");
+		drm_info(&gt->i915->drm, "RPS has interrupt support\n");
 	if (intel_rps_uses_timer(rps))
-		pr_info("RPS has timer support\n");
+		drm_info(&gt->i915->drm, "RPS has timer support\n");
 
 	for_each_engine(engine, gt, id) {
 		struct i915_request *rq;
@@ -1318,19 +1343,22 @@ int live_rps_dynamic(void *arg)
 		min.freq = wait_for_freq(rps, rps->min_freq, 2000);
 		min.dt = ktime_sub(ktime_get(), min.dt);
 
-		pr_info("%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
-			engine->name,
-			max.freq, intel_gpu_freq(rps, max.freq),
-			ktime_to_ns(max.dt),
-			min.freq, intel_gpu_freq(rps, min.freq),
-			ktime_to_ns(min.dt));
+		drm_info(&engine->i915->drm,
+			 "%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
+			 engine->name,
+			 max.freq, intel_gpu_freq(rps, max.freq),
+			 ktime_to_ns(max.dt),
+			 min.freq, intel_gpu_freq(rps, min.freq),
+			 ktime_to_ns(min.dt));
 		if (min.freq >= max.freq) {
-			pr_err("%s: dynamic reclocking of spinner failed\n!",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: dynamic reclocking of spinner failed\n!",
+				engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 
 			err = -EINVAL;
 		}
-- 
2.34.1

