Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B99FC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1857510E4A3;
	Fri, 28 Aug 2026 10:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F4JtPY+Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3FD10E4A3;
 Fri, 28 Aug 2026 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911452; x=1819447452;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=T3aEuRO2KTNzZBuy81jyk1/PqVwksqPVPVeuagxx/1M=;
 b=F4JtPY+Z336Qp0paVXJZM49xg2623lP0JVyHMqHvcXBUsLNnkKclfKTv
 ITob5jGM/gBL7WDm32OlTaSJHsDfFUQMKOJtjQQS/2i/+heg201NCimVk
 X+Dmd3rD5Kx68q5upRDgbCblyJUzLeZ2+hvO3nnJXIqM5hdfCuhgqGS0H
 /Su6U38tRcK2v8p+2bTHmEx2JV2lPPGaDYPQ33Qo6Ncfi76dXx6nrn6z3
 vlT+ay446WI9M4gNyBpQbM5bL0RWiMM91ybPxR3pMS3r68PQeHsViwRPF
 hCZvHlmvskEdj5HoEWYZ/o21lo4p1lhni35AOUjvr9IopmkwnJ1QdGqS2 Q==;
X-CSE-ConnectionGUID: FlukTOfeT2+onNIxSxdLqw==
X-CSE-MsgGUID: 5pCBiSfZTQ6DvmBCRytKCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105791709"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="105791709"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:12 -0700
X-CSE-ConnectionGUID: lCmRwtzrQsy54c8LodtSKA==
X-CSE-MsgGUID: PZjv+2whS2uesWIZHNhi4g==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMWARAl5/uBRWLT319ktyPFyit7iBPQPWNDHvldgyEv7ZiqRpPiRZvAKhBUgDZYIcFP5h6sh6HNkervr8seYtCpjiuPR/IbtXBjZ0/hQzkSPrvrNFR92AUNvTXngulJzQaQXIMLWq9i6JL45ZZK0ivbrCAoc+VfGySpX4HbuMbp2fkT2MWJH/OvkV1u01O5eplMYeKig27M9ai7xNzZcBAvZz+ryet/vs0SpwnlxtOdD3beEV1ppghtGYq6A0Rzv9iCmHyV8H53MxcbQA7RdCk+MsVyhgvapUUmtA8I6OApmcUp2nYnT+dMdVnCXw0zFL+NnG8QHxW7xXcSiAFHJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOV2AMqujo8qEq7cP4YkJf1Kf1SYVy/U9Mbo4Z+dg6Y=;
 b=xsoU0fGnBc3MoiZVHw9TPXq738CTiWYpfuObIn8MEkMji2eA243bA9v1hStWLVR2U3V7/p5/90CRca1bkxpjPCM64xM0J3455qvov8xMq+1ruew0Fwj7Iq6eggkt97ywbNrC8Pt9RAj80E2U/hJAaATV6OOgAm2/khkArTxRNWZDxJazX8aE49jiC3O8JA26OUDLzUs5SA9LUIXLEMXFAGbBEsDAZFykiuxel+bCqKEjU4PGMpeLMHAy844BGfn9I361CyEuYor6JyzFfg/HCrlAiHGSs3EbMvdNPD8QVT6G1LL60UONB3A/lToQczy/pds8I/2qmT/3aFqoFLNP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:08 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:04:08 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 5/8] drm/i915/gt/selftests: Use drm_* prints in gt
 standalone tests
Date: Fri, 28 Aug 2026 10:03:36 +0000
Message-ID: <20260828100339.72304-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38943afb-5cda-4c0d-8b4c-08df04ebb347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: YOBnr8VeB9e6c09TPaZaalnkci108j0ZgkgYA+zPRsHiTXBQTCT5OW4ZdsMtOfStlMPBJiV0+/uoQHWcEAtqiDniZbhUi8U9tXkHd1R53HJzl9Ofxjzj/mT0tFmizS4uDo4myrW8BmK0UqW21w8t8EqfL6DYuQ7eZKP5m10X11+9D9m5F5PAnPUnuJU/R100jzSutXBS4xbaWevINREFH8VLt8TZ4s0srK3n/JcZyWSOOCyNh/hPTwMXtwY8llHM503Rl6gHVixzSSk/C8xACEXbGEqvsnbnNETM3HWMYFsbPYCc9EOe4ttquX7k9B2wpIfhocnzHt+BEsbsptJs/rQ5db5LFImJeQqY6XIE+e2vPaTxrQbMoRUviDxE7XMs5Jf2OlcE0X7CHrL1M3sV6C9Q6pN4FNt233yZGL+EfTnGLdG982abUTNHWj6S7DzKRdma9aLZaLRlCPS5vnPoPEKXWfE2ZQ6wfZxzKGZE8VC+PwBWnugM4CR4CYFu40gXePqUN02SyulhCPx0h4jqvSQfa5wysThan3AkhqoebHfXDLWophYbDjWTSbjJj5V3wGL/yjuzT494V9EC5k5VaF6ys3oaSO/dddnuSu6JfpkMDxNw7pnku8Ec/+np6aEnhHYzNU3uwQeUiWIsliCUuVW95lLy5k7MGHCDKqiJHK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OczGad+DcBOTmI4vkccW31PJlXuvy1D3pW3BZK3eZ7lNNoz2K/+IXizCdux?=
 =?us-ascii?Q?aunobddGVqISaf0XZbwjKMHZvSIAMlFPW537w5jHQJN6I/FvBkYmQDv3igk2?=
 =?us-ascii?Q?Rwc8UK23rOyu9ArDKDjcLyXirMYzmpARFxBOOC6eN/I8Eyzq6bEoU/cFRR/u?=
 =?us-ascii?Q?n15hBUxFjPQzs55lhonONC/GQgVeGpIHoeF41+3CojGzazc9PoNwge/DHCdt?=
 =?us-ascii?Q?U3mfabtTTcMhbjvJ5mWV2+65s9NaVWzQ0+B/Q3plNoH8I++xT37gzj8yxsQw?=
 =?us-ascii?Q?7dNbiTWaMuhi2uzNBdIKEo3O1rExwQ5QN6zhkJh0eK6axz6gkjBCTtNS3euS?=
 =?us-ascii?Q?KxvpUQxkBWi6VaIt+t2XU2Tog/BJ2OyNnKrbfoygJvDFemp/kY38YkZhM6id?=
 =?us-ascii?Q?1nyxEEq43MBCXHwtwM4kSGJltwwAh8FLhBjzeukarVPYBR3ZMU6aAO5HAirR?=
 =?us-ascii?Q?oQY46Q2oCyeldvj6NkyiXQ40rTXBST0V8rgJ+TQmdYN7+HF7hms+ugllyGbe?=
 =?us-ascii?Q?7hAl8BfyLeF9fWgwJPgmo/lqKgY7Usal0dsiv/k9zn/R+DZYI6Kbxa6FpzaI?=
 =?us-ascii?Q?Ml+u63W0kcS38qTxlv0UufBKHOpQMXkeyjaNOIeZoYotqp+UcZcpOEkucU9Y?=
 =?us-ascii?Q?TEvsIZoUOPHVytbCT47NeEk4HfhXcI/J5fuTbrLtA/ydt9znyejBDIFS2Gpn?=
 =?us-ascii?Q?AF5XqjEvuNyOhsBbKa34f0/Wr0lXepsD2ArIQNp4eDvVMPkRZR8iR/Lokqj8?=
 =?us-ascii?Q?9hg+pSLKs45pkqIfsKuybW01wVebcKAY13y37hhVt417puQ3tvYZYlL0TX4G?=
 =?us-ascii?Q?+MSX0mUfJUQtJbic66vMe+dqWHKj9pNp5eX7E3dExLXDVjyWwj9IIf4VrDnw?=
 =?us-ascii?Q?ZMD5/TOKZ5sqb5nldm5628FdzBx8D8/3ulrLnBauB2q5lIBvl2FJTj94cr5D?=
 =?us-ascii?Q?JyZ9wqfgZ11qwkuaGebZt2FaOPC9mgPz9vkAQiXF03oVmWUTU/+937RUdiCR?=
 =?us-ascii?Q?OjLUsfv+zuQes7Z/jr3Eqlafbnrp+xJ0uwq0yafXoEbbnPVMpmUVuxyPl9X5?=
 =?us-ascii?Q?kjL1Xv1E9bKssbazy1qX6MvzVxkL1SyTq9VibYHpoywXESdrxQuiLume0qlU?=
 =?us-ascii?Q?19u5tEM0YK6Kp4ei7iAzsH6cJLz1v8jYEMTgwj2XvFULaJmye96wKd6cUiDs?=
 =?us-ascii?Q?hXY/S6FHRlYTEwbLrAR8DLxkcS44tL0wie4u+0zIjA0On5meeOcvBpcthDEu?=
 =?us-ascii?Q?EEoUFG38ebKLXhEB9uRP6rES0ctup4twI7JE126ngG90zVaLcxgYk6AQBCJk?=
 =?us-ascii?Q?oAKYa2fnmEcEfpdHRoBUTJDaSUyYIgS9+Zxq/PXZbqZw1Nam2Y92BDRy8Pvl?=
 =?us-ascii?Q?lLzSLMi8E9GEeRYdgWhj7Mf6Kbv0902522B3IpfnYNaiSJhh31BM1wn62Tdp?=
 =?us-ascii?Q?ZCYybPk9DOpPqByxTnx1V/R+rMeZ5tXwOsMIqd+9coWL/2gsvB/uZDPBr2WL?=
 =?us-ascii?Q?CiwjM7r1SLzMw/69Og+NhsnzzPzepqO7GIclGByLOKT9A5pX+RJ30DawmjpW?=
 =?us-ascii?Q?Vy/32Pt3l8MHCd6FyxvvABrBXkm7Ewy1sycM1wvefOR2/dqscls5X9a31whv?=
 =?us-ascii?Q?YeNA7OfupUyYP00cS4n0mNznJ8zkKHoor7z6CfCaypCe1JWpVMlsR4T+PAX7?=
 =?us-ascii?Q?ZiApgRC0r+HytdlvlZCiqyFhjieWYr3yRVyFeOD4dEzlyaogy0oMt3d9vyo6?=
 =?us-ascii?Q?aDQ9eEsdp35jnd70EihleHxuJwS43nM=3D?=
X-Exchange-RoutingPolicyChecked: DvvnXrvPpl61mprRnO1S63jj0R8g5puLGThbPhGH5+MCPFzigINAdIbt+dWjxXZ878ka3fwZ1vMnZnspSRnEuoilNvREgz6DkS6VBk17eCgHVp61hoGAQZslsbEwGavNLBNOIE2AyK0hxulPIeZskIOrNdHhDVlwAQDch3ougfOoi2ZvTMiXuHgmLwpVzRHES2EQw2HdC0qIg4QGbQUameUwqBvbRSQiKC1sMoAWH65jXDUsbYN4QUHKrPMMKk3DKjvlsQQC1s/9nuS1o8Qbj77+NTW5uUXA/OjgQbsiQeo87GT8ygoGsfGfkvPRbcivyZFq9tqolDXxxvNe5Ya8Bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38943afb-5cda-4c0d-8b4c-08df04ebb347
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:04:08.2876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpuVV7sfOzabqXnWMTKLftUtcAdpbrrNHiD+jiggRbs3121glzDLiP+q5r8BKyfmMdL2JbKWqVtmhwPTSR2AC0qvYVIT04Bkoeidk7weKNk=
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
 drivers/gpu/drm/i915/gt/selftest_rc6.c |  59 +++--
 drivers/gpu/drm/i915/gt/selftest_rps.c | 297 ++++++++++++++-----------
 2 files changed, 203 insertions(+), 153 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_rc6.c b/drivers/gpu/drm/i915/gt/selftest_rc6.c
index 68fb1830d411..c744579a942f 100644
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
@@ -32,6 +34,7 @@ static u64 rc6_residency(struct intel_rc6 *rc6)
 int live_rc6_manual(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rc6 *rc6 = &gt->rc6;
 	struct intel_rps *rps = &gt->rps;
 	intel_wakeref_t wakeref;
@@ -80,8 +83,9 @@ int live_rc6_manual(void *arg)
 	res[1] = rc6_residency(rc6);
 	rc0_freq = intel_rps_read_actual_frequency_fw(rps);
 	if ((res[1] - res[0]) >> 10) {
-		pr_err("RC6 residency increased by %lldus while disabled for 1000ms!\n",
-		       (res[1] - res[0]) >> 10);
+		drm_err(&i915->drm,
+			"RC6 residency increased by %lldus while disabled for 1000ms!\n",
+			(res[1] - res[0]) >> 10);
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -92,10 +96,12 @@ int live_rc6_manual(void *arg)
 
 		if (!rc0_power) {
 			if (rc0_freq)
-				pr_err("No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
-				       rc0_freq);
+				drm_dbg(&i915->drm,
+					"No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
+					rc0_freq);
 			else
-				pr_err("No power and freq measured while in RC0\n");
+				drm_err(&i915->drm,
+					"No power and freq measured while in RC0\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -114,32 +120,37 @@ int live_rc6_manual(void *arg)
 	dt = ktime_sub(ktime_get(), dt);
 	res[1] = rc6_residency(rc6);
 	if (res[1] == res[0]) {
-		pr_err("Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
-		       intel_uncore_read_fw(gt->uncore, GEN6_RC_STATE),
-		       intel_uncore_read_fw(gt->uncore, GEN6_RC_CONTROL),
-		       res[0]);
+		drm_err(&i915->drm,
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
+		drm_info(&i915->drm,
+			 "GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
+			 rc0_power, rc6_power);
 
 		if (2 * rc6_power > rc0_power) {
-			pr_err("GPU leaked energy while in RC6!\n"
-			       "GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
-			       "RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
-			       "RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
-			       rc6_freq, rc0_freq, rc0_sample_energy[0], rc0_sample_energy[1],
-			       rc6_sample_energy[0], rc6_sample_energy[1]);
+			drm_err(&i915->drm,
+				"GPU leaked energy while in RC6!\n"
+				"GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
+				"RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
+				"RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
+				rc6_freq, rc0_freq, rc0_sample_energy[0],
+				rc0_sample_energy[1], rc6_sample_energy[0],
+				rc6_sample_energy[1]);
 
 			diff = res[1] - res[0];
 			threshold = (9 * NSEC_PER_MSEC * sleep_time) / 10;
 			if (diff < threshold)
-				pr_err("Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
-				       res[0], res[1]);
+				drm_err(&i915->drm,
+					"Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
+					res[0], res[1]);
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -218,6 +229,7 @@ randomised_engines(struct intel_gt *gt,
 int live_rc6_ctx_wa(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_engine_cs **engines;
 	unsigned int n, count;
 	I915_RND_STATE(prng);
@@ -265,13 +277,14 @@ int live_rc6_ctx_wa(void *arg)
 			}
 
 			intel_gt_pm_wait_for_idle(gt);
-			pr_debug("%s: CTX_INFO=%0x\n",
-				 engine->name, READ_ONCE(*res));
+			drm_dbg(&i915->drm, "%s: CTX_INFO=%0x\n",
+				engine->name, READ_ONCE(*res));
 
 			if (resets !=
 			    i915_reset_engine_count(error, engine)) {
-				pr_err("%s: GPU reset required\n",
-				       engine->name);
+				drm_err(&i915->drm,
+					"%s: GPU reset required\n",
+					engine->name);
 				add_taint_for_CI(gt->i915, TAINT_WARN);
 				err = -EIO;
 				goto out;
diff --git a/drivers/gpu/drm/i915/gt/selftest_rps.c b/drivers/gpu/drm/i915/gt/selftest_rps.c
index be77fba2ec49..35de41c96923 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rps.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rps.c
@@ -6,6 +6,8 @@
 #include <linux/pm_qos.h>
 #include <linux/sort.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_internal.h"
 
 #include "i915_reg.h"
@@ -204,21 +206,22 @@ static void show_pstate_limits(struct intel_rps *rps)
 	struct drm_i915_private *i915 = rps_to_i915(rps);
 
 	if (IS_BROXTON(i915)) {
-		pr_info("P_STATE_CAP[%x]: 0x%08x\n",
-			i915_mmio_reg_offset(BXT_RP_STATE_CAP),
-			intel_uncore_read(rps_to_uncore(rps),
-					  BXT_RP_STATE_CAP));
+		drm_info(&i915->drm, "P_STATE_CAP[%x]: 0x%08x\n",
+			 i915_mmio_reg_offset(BXT_RP_STATE_CAP),
+			 intel_uncore_read(rps_to_uncore(rps),
+					   BXT_RP_STATE_CAP));
 	} else if (GRAPHICS_VER(i915) == 9) {
-		pr_info("P_STATE_LIMITS[%x]: 0x%08x\n",
-			i915_mmio_reg_offset(GEN9_RP_STATE_LIMITS),
-			intel_uncore_read(rps_to_uncore(rps),
-					  GEN9_RP_STATE_LIMITS));
+		drm_info(&i915->drm, "P_STATE_LIMITS[%x]: 0x%08x\n",
+			 i915_mmio_reg_offset(GEN9_RP_STATE_LIMITS),
+			 intel_uncore_read(rps_to_uncore(rps),
+					   GEN9_RP_STATE_LIMITS));
 	}
 }
 
 int live_rps_clock_interval(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rps *rps = &gt->rps;
 	void (*saved_work)(struct work_struct *wrk);
 	struct intel_engine_cs *engine;
@@ -264,8 +267,9 @@ int live_rps_clock_interval(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: RPS spinner did not start\n",
+				engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -290,8 +294,9 @@ int live_rps_clock_interval(void *arg)
 						  GEN6_RP_CUR_UP_EI),
 			     10)) {
 			/* Just skip the test; assume lack of HW support */
-			pr_notice("%s: rps evaluation interval not ticking\n",
-				  engine->name);
+			drm_notice(&i915->drm,
+				   "%s: rps evaluation interval not ticking\n",
+				   engine->name);
 			err = -ENODEV;
 		} else {
 			ktime_t dt_[5];
@@ -330,21 +335,24 @@ int live_rps_clock_interval(void *arg)
 			u32 expected =
 				intel_gt_ns_to_pm_interval(gt, dt);
 
-			pr_info("%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
-				engine->name, cycles, time, dt, expected,
-				gt->clock_frequency / 1000);
+			drm_info(&i915->drm,
+				 "%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
+				 engine->name, cycles, time, dt, expected,
+				 gt->clock_frequency / 1000);
 
 			if (10 * time < 8 * dt ||
 			    8 * time > 10 * dt) {
-				pr_err("%s: rps clock time does not match walltime!\n",
-				       engine->name);
+				drm_err(&i915->drm,
+					"%s: rps clock time does not match walltime!\n",
+					engine->name);
 				err = -EINVAL;
 			}
 
 			if (10 * expected < 8 * cycles ||
 			    8 * expected > 10 * cycles) {
-				pr_err("%s: walltime does not match rps clock ticks!\n",
-				       engine->name);
+				drm_err(&i915->drm,
+					"%s: walltime does not match rps clock ticks!\n",
+					engine->name);
 				err = -EINVAL;
 			}
 		}
@@ -372,6 +380,7 @@ int live_rps_clock_interval(void *arg)
 int live_rps_control(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rps *rps = &gt->rps;
 	void (*saved_work)(struct work_struct *wrk);
 	struct intel_engine_cs *engine;
@@ -424,8 +433,9 @@ int live_rps_control(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: RPS spinner did not start\n",
+				engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -434,8 +444,9 @@ int live_rps_control(void *arg)
 		}
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not set minimum frequency [%x], only %x!\n",
-			       engine->name, rps->min_freq, read_cagf(rps));
+			drm_err(&i915->drm,
+				"%s: could not set minimum frequency [%x], only %x!\n",
+				engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			show_pstate_limits(rps);
@@ -451,8 +462,9 @@ int live_rps_control(void *arg)
 		limit = rps_set_check(rps, f);
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not restore minimum frequency [%x], only %x!\n",
-			       engine->name, rps->min_freq, read_cagf(rps));
+			drm_err(&i915->drm,
+				"%s: could not restore minimum frequency [%x], only %x!\n",
+				engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			show_pstate_limits(rps);
@@ -474,17 +486,19 @@ int live_rps_control(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
-			engine->name,
-			rps->min_freq, intel_gpu_freq(rps, rps->min_freq),
-			rps->max_freq, intel_gpu_freq(rps, rps->max_freq),
-			limit, intel_gpu_freq(rps, limit),
-			min, max, ktime_to_ns(min_dt), ktime_to_ns(max_dt));
+		drm_info(&i915->drm,
+			 "%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
+			 engine->name, rps->min_freq,
+			 intel_gpu_freq(rps, rps->min_freq), rps->max_freq,
+			 intel_gpu_freq(rps, rps->max_freq), limit,
+			 intel_gpu_freq(rps, limit), min, max,
+			 ktime_to_ns(min_dt), ktime_to_ns(max_dt));
 
 		if (limit != rps->max_freq) {
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 			show_pstate_limits(rps);
 		}
 
@@ -523,17 +537,17 @@ static void show_pcu_config(struct intel_rps *rps)
 
 	wakeref = intel_runtime_pm_get(rps_to_uncore(rps)->rpm);
 
-	pr_info("%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
+	drm_info(&i915->drm, "%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
 	for (gpu_freq = min_gpu_freq; gpu_freq <= max_gpu_freq; gpu_freq++) {
 		int ia_freq = gpu_freq;
 
 		snb_pcode_read(rps_to_gt(rps)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 			       &ia_freq, NULL);
 
-		pr_info("%5d  %5d  %5d\n",
-			gpu_freq * 50,
-			((ia_freq >> 0) & 0xff) * 100,
-			((ia_freq >> 8) & 0xff) * 100);
+		drm_info(&i915->drm, "%5d  %5d  %5d\n",
+			 gpu_freq * 50,
+			 ((ia_freq >> 0) & 0xff) * 100,
+			 ((ia_freq >> 8) & 0xff) * 100);
 	}
 
 	intel_runtime_pm_put(rps_to_uncore(rps)->rpm, wakeref);
@@ -607,6 +621,7 @@ int live_rps_frequency_cs(void *arg)
 {
 	void (*saved_work)(struct work_struct *wrk);
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rps *rps = &gt->rps;
 	struct intel_engine_cs *engine;
 	struct pm_qos_request qos;
@@ -669,8 +684,8 @@ int live_rps_frequency_cs(void *arg)
 
 		if (wait_for(intel_uncore_read(engine->uncore, CS_GPR(0)),
 			     10)) {
-			pr_err("%s: timed loop did not start\n",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: timed loop did not start\n", engine->name);
 			goto err_vma;
 		}
 
@@ -680,22 +695,22 @@ int live_rps_frequency_cs(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_cs_frequency_at(rps, engine, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
-			engine->name,
-			min.count, intel_gpu_freq(rps, min.freq),
-			max.count, intel_gpu_freq(rps, max.freq),
-			(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * max.count,
-						     max.freq * min.count));
+		drm_info(&i915->drm,
+			 "%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+			 engine->name, min.count, intel_gpu_freq(rps, min.freq),
+			 max.count, intel_gpu_freq(rps, max.freq),
+			 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * max.count,
+						      max.freq * min.count));
 
 		if (!scaled_within(max.freq * min.count,
 				   min.freq * max.count,
 				   2, 3)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
-			       engine->name,
-			       max.freq * min.count,
-			       min.freq * max.count);
+			drm_err(&i915->drm,
+				"%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+				engine->name, max.freq * min.count,
+				min.freq * max.count);
 			show_pcu_config(rps);
 
 			for (f = min.freq + 1; f <= rps->max_freq; f++) {
@@ -706,11 +721,12 @@ int live_rps_frequency_cs(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
-					engine->name,
-					act, intel_gpu_freq(rps, act), count,
-					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
-								     act * min.count));
+				drm_info(&i915->drm,
+					 "%s: %x:%uMHz: %lluKHz [%d%%]\n",
+					 engine->name, act,
+					 intel_gpu_freq(rps, act), count,
+					 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
+								      act * min.count));
 
 				f = act; /* may skip ahead [pcu granularity] */
 			}
@@ -746,6 +762,7 @@ int live_rps_frequency_srm(void *arg)
 {
 	void (*saved_work)(struct work_struct *wrk);
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rps *rps = &gt->rps;
 	struct intel_engine_cs *engine;
 	struct pm_qos_request qos;
@@ -807,8 +824,8 @@ int live_rps_frequency_srm(void *arg)
 			goto err_vma;
 
 		if (wait_for(READ_ONCE(*cntr), 10)) {
-			pr_err("%s: timed loop did not start\n",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: timed loop did not start\n", engine->name);
 			goto err_vma;
 		}
 
@@ -818,22 +835,22 @@ int live_rps_frequency_srm(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_frequency_at(rps, cntr, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
-			engine->name,
-			min.count, intel_gpu_freq(rps, min.freq),
-			max.count, intel_gpu_freq(rps, max.freq),
-			(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * max.count,
-						     max.freq * min.count));
+		drm_info(&i915->drm,
+			 "%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+			 engine->name, min.count, intel_gpu_freq(rps, min.freq),
+			 max.count, intel_gpu_freq(rps, max.freq),
+			 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * max.count,
+						      max.freq * min.count));
 
 		if (!scaled_within(max.freq * min.count,
 				   min.freq * max.count,
 				   1, 2)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
-			       engine->name,
-			       max.freq * min.count,
-			       min.freq * max.count);
+			drm_err(&i915->drm,
+				"%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+				engine->name, max.freq * min.count,
+				min.freq * max.count);
 			show_pcu_config(rps);
 
 			for (f = min.freq + 1; f <= rps->max_freq; f++) {
@@ -844,11 +861,12 @@ int live_rps_frequency_srm(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
-					engine->name,
-					act, intel_gpu_freq(rps, act), count,
-					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
-								     act * min.count));
+				drm_info(&i915->drm,
+					 "%s: %x:%uMHz: %lluKHz [%d%%]\n",
+					 engine->name, act,
+					 intel_gpu_freq(rps, act), count,
+					 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
+								      act * min.count));
 
 				f = act; /* may skip ahead [pcu granularity] */
 			}
@@ -899,6 +917,7 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 			      struct igt_spinner *spin)
 {
 	struct intel_uncore *uncore = engine->uncore;
+	struct drm_i915_private *i915 = engine->i915;
 	struct i915_request *rq;
 	u32 timeout;
 
@@ -915,31 +934,34 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_add(rq);
 
 	if (!igt_wait_for_spinner(spin, rq)) {
-		pr_err("%s: RPS spinner did not start\n",
-		       engine->name);
+		drm_err(&i915->drm, "%s: RPS spinner did not start\n",
+			engine->name);
 		i915_request_put(rq);
 		intel_gt_set_wedged(engine->gt);
 		return -EIO;
 	}
 
 	if (!intel_rps_is_active(rps)) {
-		pr_err("%s: RPS not enabled on starting spinner\n",
-		       engine->name);
+		drm_err(&i915->drm,
+			"%s: RPS not enabled on starting spinner\n",
+			engine->name);
 		igt_spinner_end(spin);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_events & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: RPS did not register UP interrupt\n",
-		       engine->name);
+		drm_err(&i915->drm,
+			"%s: RPS did not register UP interrupt\n",
+			engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->min_freq) {
-		pr_err("%s: RPS did not program min frequency\n",
-		       engine->name);
+		drm_err(&i915->drm,
+			"%s: RPS did not program min frequency\n",
+			engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
@@ -955,17 +977,19 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_put(rq);
 
 	if (rps->cur_freq != rps->min_freq) {
-		pr_err("%s: Frequency unexpectedly changed [up], now %d!\n",
-		       engine->name, intel_rps_read_actual_frequency(rps));
+		drm_err(&i915->drm,
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
+		drm_err(&i915->drm,
+			"%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
+			engine->name, rps->pm_iir,
+			intel_uncore_read(uncore, GEN6_RP_PREV_UP),
+			intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_UP_EI));
 		return -EINVAL;
 	}
 
@@ -976,19 +1000,22 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 				struct intel_engine_cs *engine)
 {
 	struct intel_uncore *uncore = engine->uncore;
+	struct drm_i915_private *i915 = engine->i915;
 	u32 timeout;
 
 	rps_set_check(rps, rps->max_freq);
 
 	if (!(rps->pm_events & GEN6_PM_RP_DOWN_THRESHOLD)) {
-		pr_err("%s: RPS did not register DOWN interrupt\n",
-		       engine->name);
+		drm_err(&i915->drm,
+			"%s: RPS did not register DOWN interrupt\n",
+			engine->name);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->max_freq) {
-		pr_err("%s: RPS did not program max frequency\n",
-		       engine->name);
+		drm_err(&i915->drm,
+			"%s: RPS did not program max frequency\n",
+			engine->name);
 		return -EINVAL;
 	}
 
@@ -999,21 +1026,22 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	sleep_for_ei(rps, timeout);
 
 	if (rps->cur_freq != rps->max_freq) {
-		pr_err("%s: Frequency unexpectedly changed [down], now %d!\n",
-		       engine->name,
-		       intel_rps_read_actual_frequency(rps));
+		drm_err(&i915->drm,
+			"%s: Frequency unexpectedly changed [down], now %d!\n",
+			engine->name, intel_rps_read_actual_frequency(rps));
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
+		drm_err(&i915->drm,
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
 
@@ -1043,7 +1071,8 @@ int live_rps_interrupt(void *arg)
 	with_intel_gt_pm(gt, wakeref)
 		pm_events = rps->pm_events;
 	if (!pm_events) {
-		pr_err("No RPS PM events registered, but RPS is enabled?\n");
+		drm_err(&gt->i915->drm,
+			"No RPS PM events registered, but RPS is enabled?\n");
 		return -ENODEV;
 	}
 
@@ -1135,6 +1164,7 @@ static u64 measure_power_at(struct intel_rps *rps, int *freq)
 int live_rps_power(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rps *rps = &gt->rps;
 	void (*saved_work)(struct work_struct *wrk);
 	struct intel_engine_cs *engine;
@@ -1186,8 +1216,9 @@ int live_rps_power(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: RPS spinner did not start\n",
+				engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -1207,29 +1238,33 @@ int live_rps_power(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
-			engine->name,
-			min.power, intel_gpu_freq(rps, min.freq),
-			max.power, intel_gpu_freq(rps, max.freq));
+		drm_info(&i915->drm,
+			 "%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
+			 engine->name, min.power, intel_gpu_freq(rps, min.freq),
+			 max.power, intel_gpu_freq(rps, max.freq));
 
 		if (10 * min.freq >= 9 * max.freq) {
-			pr_notice("Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
-				  min.freq, intel_gpu_freq(rps, min.freq),
-				  max.freq, intel_gpu_freq(rps, max.freq));
+			drm_notice(&i915->drm,
+				   "Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
+				   min.freq, intel_gpu_freq(rps, min.freq),
+				   max.freq, intel_gpu_freq(rps, max.freq));
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 			continue;
 		}
 
 		if (11 * min.power > 10 * max.power) {
-			pr_err("%s: did not conserve power when setting lower frequency!\n",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: did not conserve power when setting lower frequency!\n",
+				engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 
 			err = -EINVAL;
 			break;
@@ -1252,6 +1287,7 @@ int live_rps_power(void *arg)
 int live_rps_dynamic(void *arg)
 {
 	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_rps *rps = &gt->rps;
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
@@ -1273,9 +1309,9 @@ int live_rps_dynamic(void *arg)
 		return -ENOMEM;
 
 	if (intel_rps_has_interrupts(rps))
-		pr_info("RPS has interrupt support\n");
+		drm_info(&i915->drm, "RPS has interrupt support\n");
 	if (intel_rps_uses_timer(rps))
-		pr_info("RPS has timer support\n");
+		drm_info(&i915->drm, "RPS has timer support\n");
 
 	for_each_engine(engine, gt, id) {
 		struct i915_request *rq;
@@ -1318,19 +1354,20 @@ int live_rps_dynamic(void *arg)
 		min.freq = wait_for_freq(rps, rps->min_freq, 2000);
 		min.dt = ktime_sub(ktime_get(), min.dt);
 
-		pr_info("%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
-			engine->name,
-			max.freq, intel_gpu_freq(rps, max.freq),
-			ktime_to_ns(max.dt),
-			min.freq, intel_gpu_freq(rps, min.freq),
-			ktime_to_ns(min.dt));
+		drm_info(&i915->drm,
+			 "%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
+			 engine->name, max.freq, intel_gpu_freq(rps, max.freq),
+			 ktime_to_ns(max.dt), min.freq,
+			 intel_gpu_freq(rps, min.freq), ktime_to_ns(min.dt));
 		if (min.freq >= max.freq) {
-			pr_err("%s: dynamic reclocking of spinner failed\n!",
-			       engine->name);
+			drm_err(&i915->drm,
+				"%s: dynamic reclocking of spinner failed\n!",
+				engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 
 			err = -EINVAL;
 		}
-- 
2.34.1

