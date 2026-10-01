Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0BCCA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173A210F5AD;
	Thu,  1 Oct 2026 07:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LN7gurBS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1A110E241;
 Thu,  1 Oct 2026 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790840497; x=1822376497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=DaXQw9O1GetHe9diUjX9Fvudufu+gUhp9gMvNFd+tUM=;
 b=LN7gurBShJg/MDx5QBK9kkHVKY5nmGZoGVq0kXKAqDcNI/S3UEbR1j8P
 G3rkXpSfwW0AkIyhe6Cd7hOwrqnPlGCo49TIyW7Zy8iFuPIuhyNyBP1ew
 7QQHe6Se/OW3lw4CmypkRTPBLtJzNnswlQxfj/+nMsDsw49b1gMFpBPnM
 2TL0kEAFmAEZ+yDNCKdIFkooNMgC3V6qpcRnREXPJSOE5PJhqSWcabwVY
 oMkpD1jLXvmng2l2AH2mJkHfSHgrT7j3swKlgQ1cJHBrehi/nPBZT7gLv
 mVY5Kjlgnnbo+5/RUyI6R3/j5FJaMooWnCB1V4Fy+5zQvN0SQIkhWp8ZB A==;
X-CSE-ConnectionGUID: aaE4rlEXR6eeIeqL6glHkg==
X-CSE-MsgGUID: 2BCHWylNTeufMVy7x+Gh8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102114375"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="102114375"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:37 -0700
X-CSE-ConnectionGUID: oyVXK6pBS06ZUH24jn4Tjg==
X-CSE-MsgGUID: FLgyi5KuThWVxFkOKtjtPw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 00:41:36 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raYsp17/8G5ga+PrF9KTWF7F3wGimMsm8XK1dDOZeqkjJejRlSq/4Zpz+RjGdZtFHjUAEBH1zRyWMoxM6kHoBVY90XVjhmnfrvSQhW2QZXOckb1+ccmHnSJH9DVWqXTbaYmoNMkmKwuH+R3dBIvEX38CZMlRVHd/kZzRrFt/360p0ISHK5soDAg7z/3F0FmS2XHZxsEAQb0pgNFTJlFQV/x8MsEHKpEFx/9HUuc855yZyn1FATorg6CAh3HyZO0wMM0UGAqc/U2v+qdkg1oGLjs6yfshDdEbsfZ40AMLzTSt6w9dQjzGVdno9llDsQxtF3bmNMirhl4l07NK/r6KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ+jbQlgYDXd8RSmrCLb4zzVZS5pchvTDAx8v7a3A08=;
 b=mkxGwl4i4zPFx2CMMcwyRHIXvgQYcxR1K2WEKltlvpmnCAWPqSjzaKQKYLAtQ+Heyb56UAkGrTpGMIeAjRfnOmvSaWuXTW3OS9UfZ91GsFW9274gZcngMMdfDSf8wbCPRTH+K0b7BGnyx36J34MdyAwPipFNjtIDGxbXFhV2jiEcuweLwuyeTVFTgu+72IWALAoPUQ+HyiT0WUcLstPhQfKBy0hXyFGZmHkBpWJCZ2DCfXG4Z3O9hAKLAUbR8wHUDe1I5+RDStxIxxKu5UU3UQwLF3en6/+DGQyie6np5kji0tqf4Q4K3ypH5qjVylC4LKKau8+8IJRqpI4+IINAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:41:33 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:41:33 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 4/6] drm/i915/gt/selftests: Use gt_* prints in gt
 standalone tests
Date: Thu, 1 Oct 2026 07:40:58 +0000
Message-ID: <20261001074100.2694888-5-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001074100.2694888-1-krzysztof.karas@intel.com>
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: ed96ca3c-6abc-4771-8482-08df1f8f6a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OxWF88AaRz52sjWCxWEbNhCNGPfQLFozlCzdPfFWtVriZnZ+PWn+CI352gpd9T++CDLbCvrgFIqwxNtAuTu4d0db+vxVAjjOmG9Zf30S7I8tnKkdu9+BtmkcbNdNSx1p5NfCpZiI4eAO37rj61a61vSaXOl8rYJf+X5H4MQTZvuy2h4ayyWGoImRSbgaZcaPJQqtWIkJZB5z0lYWMj4TjG2ljaa50OZtJcfYru2B3qbDH73c91VzCkQVoqlhgc4zsd+YWm1iTbcH+2aL4U0K7QVRfcgoIle6/JRvf3h4vHkmvZ9qGVep4MEC3RGOOOClxMDvchVSzB7Xd8kUYMILreTB61BWepEKieCvAUX6uw3U/2jMlL+Gs2e2pvxM0vMpsiYcpmMe8DNXn8f/NCPunELWWxGBrK0CrJRMuN7vrLjobkpAyzeRqyXAjau6XfkSbUfBGqTuJfmz/WDchu56CVS6jBwkY7TEn1n86zmyVeRAEo08gepm8xpLLyHYv77QvRdkIinT5aKCU1Hp9dyD7ygo52ltmuTjIfvV0VwJQfai5hb6tHn+9osyOZ/m7AzF1Yazd/RBrv9FQUqx6F8/q7gKVWNn1qhpPFOOpK2dUXT6ar0JoBahcgEtaKQx4h175TSeH+5zMJsgPsKzOpvsbczKrbS8qNxcljG9145iGtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmmk+iZwKiqzOY4cYteoSiRBiRXpQXE1ucvnXNMeMKnGmsAd8UxR/4NgrFbO?=
 =?us-ascii?Q?bFBfbtUGDaRcU+L/i0VE6Felu4km250fbygZctXG77ECgxwqyLaqhguJ14uV?=
 =?us-ascii?Q?AuFmjjbpsiiaP1QNutGJM0WNYPSvzglj8pybvdoQ+MHaDN3eOSSYpbKy6HcJ?=
 =?us-ascii?Q?1Fm37RnS2ktkDo/+zoUwdrXfQujDw0Hwfry76cf/aYUQGVFjLo12Yoes3hBE?=
 =?us-ascii?Q?i4Mk8HWUYH23nbiRiaGRmCe1l1q0l7qRONbaqjnjNtuLhmksB8kBN8Cxgkvm?=
 =?us-ascii?Q?uo77Qh9wyC3ECpA5Jm7J3rUgVtRT1p/WMDGvn+PzQWrF08bu9d0sLkyGwRy9?=
 =?us-ascii?Q?NWKd4K8d18QFkpAKSXZKc6olIqWcHGgyifgEZmHEALy/vbDjaSECS9KlkfCK?=
 =?us-ascii?Q?lMApJUZnUAyGqM5Tg0g1CM0ozdulHjm04cY888TWMZJMxgmfNzaGhgSkH9aD?=
 =?us-ascii?Q?mpFOovcl0WpgrjV2ShISN/MGUEU8iV2vTKANQ+fxqnsk9/0/rjf+NHQM9jVF?=
 =?us-ascii?Q?ReFncq32OJNkIZxZ5goL7xGumKIcG5vqsEfM/xnKWqO4ZqLQ5GnL1ZFRxGUn?=
 =?us-ascii?Q?lpc7kYZH7pvqBK8Yq25EcS3Z8CTLqlqK2AwDMJzlXvnWlJcGJy8t9acgcrAf?=
 =?us-ascii?Q?vdpHtKYbTGtNXAxqXAY2G3gTpIWDNDs6SCFcBvmI/xGjC6Ve6g5nExZBUzPj?=
 =?us-ascii?Q?74xQmmeBtwtm/BRpy6XVAFffEHetqDLIGZZxhLsEaAfqXHDK4//qNJ2Kso/n?=
 =?us-ascii?Q?xxThyvU3Xgd/Aq49XGGe/KTyCN6cfA2yW6tKNYoXzZwn0DW9Xznz9TUn5CKR?=
 =?us-ascii?Q?jmc5y3Ol2Rm2Uh0ax392wPo2EvxQNfzNfR7TdYaU7NEiSUBGx88gVaw+Ee/t?=
 =?us-ascii?Q?LRfGQg/PnH8VXggcKaccLzMZWdKkK81obne2LzFkBMrs5WBe+aAajY221obg?=
 =?us-ascii?Q?mxpwkclfNyLFOKhrcdNsmm9ylClIpwHIZhSwr/wpVED9brt74WGO9xkMcios?=
 =?us-ascii?Q?8LquFZL6K0My1j556D7UDgJITaHyqwMUxOSPPXHnSlhpZfU6Wq6jnDK2uD0e?=
 =?us-ascii?Q?BRWrCTWXppPQ2qd3GY3n7EgkYKZZWJus3LZSxHKxa4Ne3SJvxa/Iw/xoSsf5?=
 =?us-ascii?Q?2vVXC22iT//LjC8Js7q/kVyBsbUxVgLS/v4ScsTUvHaJVmAVy9aLq7vGQ1T5?=
 =?us-ascii?Q?9wwA7clhSVn2lGS8ER2QnfFFhmso7+6KhfupHTlwCeEz6bHG54rErP0wphme?=
 =?us-ascii?Q?xiEWJDT08S3fXRAQfse+DpvvMpxQe8nVWyIZxQ3Hj5mwFDiJgQtwNE6IKfh4?=
 =?us-ascii?Q?5TOtkU8KTAU2y13Yey/esQHDpDAn9HViirQ3opo5oRE5FamI4MyGycdXC9V3?=
 =?us-ascii?Q?oRsGj7q1zJPOU7kWKT85/KmFgQXGXQ9foUsUVZcUa7mgqnRRYmoiIeMrya3z?=
 =?us-ascii?Q?sNoxxWhD7BRpzjQ+CUzPO9vbNzKvZ2Gs0AfrSJvpVzySPgRu3B0OQ8stpNwV?=
 =?us-ascii?Q?t+254sUHjccXRzXZKhNwRJY85fO5h8zmaCZ9HoRKUA+wkuR3f9TmdMa1LmwL?=
 =?us-ascii?Q?k1BBWlPoTpsW9GzcclvneyaDPAExX/6T64l/T6HFq66O3uRedaX34ZGcgocD?=
 =?us-ascii?Q?kZN/2VavwQd0HVRCt23TGKnL4+4JI2ZnCaQmneVWqwn31DbiiCxkV6h4kBVJ?=
 =?us-ascii?Q?5iJM34ifnLXBHzKHT8qWMtdTEq+LJkGMQKKUshYaogN8XF4wA0I/vnd4kwtX?=
 =?us-ascii?Q?pA8eMDEiTFLe/beolL5dxGvDj1FFHQk=3D?=
X-Exchange-RoutingPolicyChecked: YDYeq9iLToHk290rwZ+GElMgSAxLm0oqzFkHKhRwvFjCY/3QNYoLXIDifUUA3TvIjJRTBSoLYBdBUXF6bwzUfBzdoEgUBsY5YC9MA63kayoXV2qQYTggLmcbJweZnjVVRhOZO/J8qoa2LQFMH6zdw7nNzTfVROVu5owkBciNVX9VgA8KvCkMzWpYm7ZL6D6FJSDNDwe5kxTr3GullP/fuDUNUl0JNkAZTSszuXhuOT56NzS85RV7c0HagDuRtYDIezBNh7YHNxTPN3Kl45htbTkssNH2GL/fHrSq34TrJJfiEOznzvjvWVVbQFXan+LvWyFQcYUWmkOOW5pDSNZ5iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96ca3c-6abc-4771-8482-08df1f8f6a32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:41:33.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwEmvdfY0v2t11SWvPT6xzAexOgAafqQianxB8yVXcNM3Y+ts4lC0vjEQ5y0vWWhanWD+QbsWTnRqt9dYJnA5cZaiQyqd4rJK6VSVZc2sVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
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
v5:
 * No changes since v4;

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

