Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B1C5DF85
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DF910EAA0;
	Tue, 18 Aug 2026 09:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BOVzgeib";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF81D10EA9E;
 Tue, 18 Aug 2026 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047007; x=1818583007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=iXAvzG68w59MkRzhfCOy5/M8bSTOZGVIX8nqne8MJ+s=;
 b=BOVzgeibTyRxq26pOsBY/QS2HRsUMe1HN892iMx8oKOsRxqxDcf9SrIm
 2dCPwCLbNAqxphZwDKm8pT+LLJHvbFqG5ekqba9En2gYIjl2+K1yEjTOx
 KMKw3BC+suK4HqEinQeG8952DZplQR82UY2ad3A/rqstkwoGSITeqcm18
 J0foPB87ab2sMxDuGv2oqp2T/VKB080qYfyDBWQ3C1JDw42oCB+rw1oAt
 TF8hqHjPKTgQnj9SudoELkzyRYT260YiR5S/iX4P5zMPrYmqlYQgpyiPm
 /xqc9IYQKSxvJkoP72b4K3BS6YyqfZRmHJHNfin3Eq45sb1HmWVD3AcOI g==;
X-CSE-ConnectionGUID: TUQqmKYvQQKJF+MKI2YZSQ==
X-CSE-MsgGUID: JY9aD5AnTlWOUFboUOdyrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87655729"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87655729"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:42 -0700
X-CSE-ConnectionGUID: eYHUQN0ZTIOXntzP+lpBEA==
X-CSE-MsgGUID: qxC2hmZOSQ6/KU7ojwVetg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="264736737"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpaJCoEGFapmRUTvxFvAjNtr1Q5QOOexoO1dJ7SBUZtpWyM9qbYc59bc5V7N4jvvCScrBV7SMf2CHm1LiFdh2XWmpBB8/AOE847NESXDc36hsJEMz1vw+iz4HkoyG3BDQnppy7DB2QNb4X4nYlf9DEB8VG2Bq5nbE/vp7oHTDNDx3EUQmjDlJg8yD7ZaTvaMYu0r2BEgngo4/PzrY7WDMRIeky4Ni7rJQgJezVwhuA2lcPpRsQSlLy+s8muAT0puNQfzCLEaEEUBkUQphpnGkw0OkFSsR7SqIVMQDk7HuzCT2WBy04E1DKPda5M55PY5yeXqEdnOmfUh2C3rH6ZFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cQDgYizwJNB2YhoPeqa28J1EdeDCP7nsRav1EV38v4=;
 b=k5bjIvv8zsr20zu5xrWnGFnbVfQICMN27U4N0669aN3/NcKswCLEeuCGgc5jXz7Jk8HgseMv1PNd39BzoFTnow2I4Pi7tMBV7Pt1M4ZUEtlmH0LopoUD/XeYHxASGRJPcJtv9smdvXb5R8O4CR1mEe9VpsBruhv4QPbczR3WJ7V1RVIm9OV63KQI9sAap53i5zCX8tJfyVvH5zAfoCIURd3cT0cFtVgqhHyZOD3S0Nd/2FHWSE4AwG6uEbmTLBuOVaoxK9hX1W9sIOMem0G8gCkbJ7zue3T/ExPyOVyz50z3+wmXuk7vP14mMmxe6/YnmomniwZfpSZN3gvVxVHbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:35 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:35 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 1/8] drm/i915/selftests: Use drm_* prints in mock selftests
Date: Tue, 18 Aug 2026 09:56:17 +0000
Message-ID: <20260818095624.3254368-2-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 502ab56e-49e1-47dc-a81a-08defd0efd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: yX3eEXqpOJvEZULiFZ0ITdooKtS0SD7Aj0RWoojTP43vvU6Jm9nxZsgU7LLLPcDiO+2Sd4NUJx3U/rwVr/+fwIn5ftTyUNeQbo9EbVMTdf/nHmOvQK5ciQugpvlQfLEMmYTXR6cDbblR857H1mlouYiGjFnc16Tr8JG3HxDdXsuDYH8G/Mnp7CJB/ZLmXEMkzIWNCkKPg8cEin+kwHp/dv1tnpCkgTvFokT5IOvqQFjVnmyPkl7lV/vlzCW81KhM1iAhqL3a180/DbTEFthJmDID2lO8GjVmbnSKRoyTODY1VqBRLHPCJqHJTqftso45JIV5GTJdhsasKgJc//eA59EVHrJ0yK3kcjpsNQ/N31hj0u3QGl4VjPfdRIv0y3aZkocw/LhsTrJu3uxe2trlMlYJrCP8VM5i/S7o5Hjv0JDdQ7OlMrQTM75ouTvEjTurLayPwMKIx+07GlADrtw+zZFEwiBWe74aUaU2JBA7PDLkw5t2s0jSfYm2cQaL2ISep+aLuq/zqUMLtgh52jlhi6JoCCJHn+G5DBV0qjPjOO/Be+Xezlt2e65auQ1H3I91ksrHWyVdBYAyHg0Kc4jPlpJyTknKdFoxC93g9LP7UAkHEJyovyVRwUgMHpQkNuuoBT+O52jwJrXNPzjgKhgTMt7Or8asGs9X1uICiHZDiaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDJmrbFgbJB+rK7U3nW7MFVuyPDntE2Xrc5t09cETDuVHoIeyoMFnv67jRn3?=
 =?us-ascii?Q?YpzGT85tbJQ5mKrLf7/vzlQMu4FlJOEf6yjA9QRgvLGUDZPTB3D1RSOZMZE3?=
 =?us-ascii?Q?9ZgSuaiJ3h7TZH6/Cz0+Av0fVhFfDisgkR9yK+sJJ3b2ldMLC89gaTcERXIu?=
 =?us-ascii?Q?oP07js3yAZT+Ai2WfU96tPuGeitoDiOXHkoXoMJf6qK5EiI0dpfTmmj9occ4?=
 =?us-ascii?Q?fNMwhKR9XwSg15bSG3Yheqq/5RKDHN9doHamegu0GhI7vbf8Vu2becpR0C6C?=
 =?us-ascii?Q?C++cWOEwlsB29DXlM4yayGmdZdhLLwbqxUMeCaWPJhTcDqBQEL6u5tvhqq1x?=
 =?us-ascii?Q?6SrJqVv7GZOSEzkJo+pGb90JOk0JMj1wp9A9D6ErNjBDT3Mg2stuaFAhDNPZ?=
 =?us-ascii?Q?r4uPcvDpoV6bZv+YMEbwa3Kcqjlayl0DyIKnys4e39d6w0Lhr9cHpSnHLQWn?=
 =?us-ascii?Q?lzlIbrRpUka7ccT6N8jRs9jCQy5/xmILda4Jp9tMFg5GEVg+BAVa2b4jhoO9?=
 =?us-ascii?Q?bdJgxHGwsWXnwKmOgT3ixEYWXLzzncK+nTTNhFf3yag3R3ZVNFBN2Hk+WmNQ?=
 =?us-ascii?Q?qKSIIxxCMajXxviw3M9bkJVOc/FisGiDImVRkc7wrmz8CyGeiHOwJJPuBQxR?=
 =?us-ascii?Q?9IxiwY8UX5q0woE8ms4fi1vh9RQeloZSQGPLMX0Oqj3bdZwPXk+qw7HVcb/9?=
 =?us-ascii?Q?aiG8HQ7XE150fPptnD0Efpl2FUMbYz42Jlauja+ubMRCQyPezFB7+YoPerh8?=
 =?us-ascii?Q?VTsZyJ3IOuxPJlmVA4O719tdgkWjYS0JPIuj1flt2QfEYXPK2wIUb7MRLHpW?=
 =?us-ascii?Q?AfJSwH/26nGTcmcKLe/CrWR8MksybOCjoTiomfIYcWD+GbMo7vRwl09uT1VY?=
 =?us-ascii?Q?elSn7wFgq+zDDwzWk8ApcyqHCFP6nZenrm+UTF8D8h8Wvhi59VGo7FsSxfbm?=
 =?us-ascii?Q?5v6UEX1WmBP4Mdlbo0M7Q3clAMcEJBATypubHHhmBTuqyXnQWAbygozMUTKl?=
 =?us-ascii?Q?5fImRXG4HyOJLJ65XEtA7y20meQ0SFak/GD+FyD9u7cPhWJ/YuGoNFdMF3za?=
 =?us-ascii?Q?/m+bss90yxoqVbrUOCyGxT/1z1qJXj0qcBD/dogTKf6udkX1yCHMK36o3vh3?=
 =?us-ascii?Q?uD8bu6TyNTI/GUND+ofV/ALKP0S4qSMysioJ3DXLZlgYLS2ReDZIc5UIsukf?=
 =?us-ascii?Q?EOk7b2MVGijGioXGmEZbSsYoKnRbcsSSVsTujyyYzw8fczy/cAap7LfSqYl9?=
 =?us-ascii?Q?iafObZ0QOoG9/AJhxYhvoE31JypEQ/d41kAiljzya7sR0dvGSAzOc+CiDeBK?=
 =?us-ascii?Q?KRQJUpZ8pH3y/qblXpchHP106SJfjpKpN6cuoqYW8M0L1rtQtjpMeYB9xSOH?=
 =?us-ascii?Q?fPvdXeGT6aPH31Y/lf2nhcyq9AF1bobiwC97TrYHLKyQNQ4yEMB+6AFo1YW+?=
 =?us-ascii?Q?du3OtdhA6a/Us/imndkem/lcI+f4ohPpk6FV1QaGgXxbJ2G0AlgGT1e2WpRh?=
 =?us-ascii?Q?lJ7IEe4zhQNqT4UAIPnwnaLZNATbfW42pf6khfvRI+19CBCb2HVfKnKaWm5q?=
 =?us-ascii?Q?59hwZwpooM8JKAj1NxmZOdXaJOQutXZs1YO3tIa3IPdHsU08W9iQQYZB8/R9?=
 =?us-ascii?Q?ml0sHy2RZ21B6birCH6w/SzRYdBhR6aMUQS5UAOm4m+Tu61CTzt+CMJKHGzS?=
 =?us-ascii?Q?UEIQnimUQR9mRkFabk/UKLS6aej7CsNLZBQushcv4bfOcqdyFW0GqmUPt/RS?=
 =?us-ascii?Q?cCcuGhIa51wa9E/2yzKPB5Qi2p9toTg=3D?=
X-Exchange-RoutingPolicyChecked: Bh/pLyECdOWJLzVvxT/Kk7N9IWYqpbk07EzRczlgMKG0Xw9ZUcvAR3WRApyeeRoclyZIzisj+59Aq71AvYOz0ufgYzWj3Zaust/l/GMuG7nTAT4Nxj0y1mjY6ebkRsCDqCQVutv4U0CD3jYXPgth8rXJEMA4BVTyEjHYdpTEDd/DCX8wSFh5+sKJKRCdOf1vq5dTFPBUqD6v9r1QOrGSFcKdyKT2GAm83NLHUKY2u3zL6ySWemJ4c5dOOk1E4xNbygvDWwzDH3NdOfYxWqfAxKYSrgzLfydpivCGS5OE5u2XMxognzF2rWdJuWUB6djSF5mN2qF07XFu2NtU+9aO1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 502ab56e-49e1-47dc-a81a-08defd0efd4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:35.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpr/CbwUvCrEq8xy3h+FmKlEtSbV9RvlTRJwBp5u62SxioopREjVd4fe8C050j3VtXolcBYmQI6yUJE7bKekbpq2tJDuMKSdFhzmRmQZFkc=
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
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  92 +++++++------
 drivers/gpu/drm/i915/selftests/i915_syncmap.c | 129 ++++++++++--------
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  45 +++---
 3 files changed, 144 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index 6a305322e30d..462704e575f5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -26,6 +26,8 @@
 #include <linux/delay.h>
 #include <linux/prime_numbers.h>
 
+#include <drm/drm_print.h>
+
 #include "../i915_selftest.h"
 
 static int
@@ -107,7 +109,7 @@ static int test_dag(void *arg)
 		return -ENOMEM;
 
 	if (i915_sw_fence_await_sw_fence_gfp(A, A, GFP_KERNEL) != -EINVAL) {
-		pr_err("recursive cycle not detected (AA)\n");
+		drm_err(NULL, "recursive cycle not detected (AA)\n");
 		goto err_A;
 	}
 
@@ -119,7 +121,7 @@ static int test_dag(void *arg)
 
 	i915_sw_fence_await_sw_fence_gfp(A, B, GFP_KERNEL);
 	if (i915_sw_fence_await_sw_fence_gfp(B, A, GFP_KERNEL) != -EINVAL) {
-		pr_err("single depth cycle not detected (BAB)\n");
+		drm_err(NULL, "single depth cycle not detected (BAB)\n");
 		goto err_B;
 	}
 
@@ -130,19 +132,19 @@ static int test_dag(void *arg)
 	}
 
 	if (i915_sw_fence_await_sw_fence_gfp(B, C, GFP_KERNEL) == -EINVAL) {
-		pr_err("invalid cycle detected\n");
+		drm_err(NULL, "invalid cycle detected\n");
 		goto err_C;
 	}
 	if (i915_sw_fence_await_sw_fence_gfp(C, B, GFP_KERNEL) != -EINVAL) {
-		pr_err("single depth cycle not detected (CBC)\n");
+		drm_err(NULL, "single depth cycle not detected (CBC)\n");
 		goto err_C;
 	}
 	if (i915_sw_fence_await_sw_fence_gfp(C, A, GFP_KERNEL) != -EINVAL) {
-		pr_err("cycle not detected (BA, CB, AC)\n");
+		drm_err(NULL, "cycle not detected (BA, CB, AC)\n");
 		goto err_C;
 	}
 	if (i915_sw_fence_await_sw_fence_gfp(A, C, GFP_KERNEL) == -EINVAL) {
-		pr_err("invalid cycle detected\n");
+		drm_err(NULL, "invalid cycle detected\n");
 		goto err_C;
 	}
 
@@ -152,15 +154,15 @@ static int test_dag(void *arg)
 
 	ret = 0;
 	if (!i915_sw_fence_done(C)) {
-		pr_err("fence C not done\n");
+		drm_err(NULL, "fence C not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(B)) {
-		pr_err("fence B not done\n");
+		drm_err(NULL, "fence B not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(A)) {
-		pr_err("fence A not done\n");
+		drm_err(NULL, "fence A not done\n");
 		ret = -EINVAL;
 	}
 err_C:
@@ -191,7 +193,7 @@ static int test_AB(void *arg)
 	if (ret < 0)
 		goto err_B;
 	if (ret == 0) {
-		pr_err("Incorrectly reported fence A was complete before await\n");
+		drm_err(NULL, "Incorrectly reported fence A was complete before await\n");
 		ret = -EINVAL;
 		goto err_B;
 	}
@@ -203,12 +205,12 @@ static int test_AB(void *arg)
 
 	i915_sw_fence_commit(B);
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B is not done\n");
+		drm_err(NULL, "Fence B is not done\n");
 		goto err_B;
 	}
 
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A is not done\n");
+		drm_err(NULL, "Fence A is not done\n");
 		goto err_B;
 	}
 
@@ -246,7 +248,7 @@ static int test_ABC(void *arg)
 	if (ret < 0)
 		goto err_C;
 	if (ret == 0) {
-		pr_err("Incorrectly reported fence B was complete before await\n");
+		drm_err(NULL, "Incorrectly reported fence B was complete before await\n");
 		goto err_C;
 	}
 
@@ -254,25 +256,25 @@ static int test_ABC(void *arg)
 	if (ret < 0)
 		goto err_C;
 	if (ret == 0) {
-		pr_err("Incorrectly reported fence C was complete before await\n");
+		drm_err(NULL, "Incorrectly reported fence C was complete before await\n");
 		goto err_C;
 	}
 
 	ret = -EINVAL;
 	i915_sw_fence_commit(A);
 	if (i915_sw_fence_done(A)) {
-		pr_err("Fence A completed early\n");
+		drm_err(NULL, "Fence A completed early\n");
 		goto err_C;
 	}
 
 	i915_sw_fence_commit(B);
 	if (i915_sw_fence_done(B)) {
-		pr_err("Fence B completed early\n");
+		drm_err(NULL, "Fence B completed early\n");
 		goto err_C;
 	}
 
 	if (i915_sw_fence_done(A)) {
-		pr_err("Fence A completed early (after signaling B)\n");
+		drm_err(NULL, "Fence A completed early (after signaling B)\n");
 		goto err_C;
 	}
 
@@ -280,15 +282,15 @@ static int test_ABC(void *arg)
 
 	ret = 0;
 	if (!i915_sw_fence_done(C)) {
-		pr_err("Fence C not done\n");
+		drm_err(NULL, "Fence C not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B not done\n");
+		drm_err(NULL, "Fence B not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A not done\n");
+		drm_err(NULL, "Fence A not done\n");
 		ret = -EINVAL;
 	}
 err_C:
@@ -343,28 +345,28 @@ static int test_AB_C(void *arg)
 
 	ret = 0;
 	if (i915_sw_fence_done(A)) {
-		pr_err("Fence A completed early\n");
+		drm_err(NULL, "Fence A completed early\n");
 		ret = -EINVAL;
 	}
 
 	if (i915_sw_fence_done(B)) {
-		pr_err("Fence B completed early\n");
+		drm_err(NULL, "Fence B completed early\n");
 		ret = -EINVAL;
 	}
 
 	i915_sw_fence_commit(C);
 	if (!i915_sw_fence_done(C)) {
-		pr_err("Fence C not done\n");
+		drm_err(NULL, "Fence C not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B not done\n");
+		drm_err(NULL, "Fence B not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A not done\n");
+		drm_err(NULL, "Fence A not done\n");
 		ret = -EINVAL;
 	}
 
@@ -424,17 +426,17 @@ static int test_C_AB(void *arg)
 	i915_sw_fence_commit(B);
 
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A not done\n");
+		drm_err(NULL, "Fence A not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B not done\n");
+		drm_err(NULL, "Fence B not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(C)) {
-		pr_err("Fence C not done\n");
+		drm_err(NULL, "Fence C not done\n");
 		ret = -EINVAL;
 	}
 
@@ -483,14 +485,14 @@ static int test_chain(void *arg)
 	for (i = nfences; --i; ) {
 		if (i915_sw_fence_done(fences[i])) {
 			if (ret == 0)
-				pr_err("Fence[%d] completed early\n", i);
+				drm_err(NULL, "Fence[%d] completed early\n", i);
 			ret = -EINVAL;
 		}
 	}
 	i915_sw_fence_commit(fences[0]);
 	for (i = 0; ret == 0 && i < nfences; i++) {
 		if (!i915_sw_fence_done(fences[i])) {
-			pr_err("Fence[%d] is not done\n", i);
+			drm_err(NULL, "Fence[%d] is not done\n", i);
 			ret = -EINVAL;
 		}
 	}
@@ -553,7 +555,7 @@ static int test_ipc(void *arg)
 
 	usleep_range(1000, 2000);
 	if (READ_ONCE(ipc.value)) {
-		pr_err("worker updated value before i915_sw_fence was signaled\n");
+		drm_err(NULL, "worker updated value before i915_sw_fence was signaled\n");
 		ret = -EINVAL;
 	}
 
@@ -561,7 +563,7 @@ static int test_ipc(void *arg)
 	i915_sw_fence_wait(ipc.out);
 
 	if (!READ_ONCE(ipc.value)) {
-		pr_err("worker signaled i915_sw_fence before value was posted\n");
+		drm_err(NULL, "worker signaled i915_sw_fence before value was posted\n");
 		ret = -EINVAL;
 	}
 
@@ -584,7 +586,7 @@ static int test_timer(void *arg)
 	preempt_disable();
 	timed_fence_init(&tf, target = jiffies);
 	if (!i915_sw_fence_done(&tf.fence)) {
-		pr_err("Fence with immediate expiration not signaled\n");
+		drm_err(NULL, "Fence with immediate expiration not signaled\n");
 		goto err;
 	}
 	preempt_enable();
@@ -594,7 +596,9 @@ static int test_timer(void *arg)
 		preempt_disable();
 		timed_fence_init(&tf, target = jiffies + delay);
 		if (i915_sw_fence_done(&tf.fence)) {
-			pr_err("Fence with future expiration (%lu jiffies) already signaled\n", delay);
+			drm_err(NULL,
+				"Fence with future expiration (%lu jiffies) already signaled\n",
+				delay);
 			goto err;
 		}
 		preempt_enable();
@@ -603,12 +607,12 @@ static int test_timer(void *arg)
 
 		preempt_disable();
 		if (!i915_sw_fence_done(&tf.fence)) {
-			pr_err("Fence not signaled after wait\n");
+			drm_err(NULL, "Fence not signaled after wait\n");
 			goto err;
 		}
 		if (time_before(jiffies, target)) {
-			pr_err("Fence signaled too early, target=%lu, now=%lu\n",
-			       target, jiffies);
+			drm_err(NULL, "Fence signaled too early, target=%lu, now=%lu\n",
+				target, jiffies);
 			goto err;
 		}
 		preempt_enable();
@@ -692,7 +696,7 @@ static int test_dma_fence(void *arg)
 
 	err = -EINVAL;
 	if (i915_sw_fence_done(timeout) || i915_sw_fence_done(not)) {
-		pr_err("Fences immediately signaled\n");
+		drm_err(NULL, "Fences immediately signaled\n");
 		goto err;
 	}
 
@@ -702,25 +706,25 @@ static int test_dma_fence(void *arg)
 	sleep = jiffies_to_usecs(delay) / 3;
 	usleep_range(sleep, 2 * sleep);
 	if (time_after(jiffies, end)) {
-		pr_debug("Slept too long, delay=%lu, (target=%lu, now=%lu) skipping\n",
-			 delay, end, jiffies);
+		drm_dbg(NULL, "Slept too long, delay=%lu, (target=%lu, now=%lu) skipping\n",
+			delay, end, jiffies);
 		goto skip;
 	}
 
 	if (i915_sw_fence_done(timeout) || i915_sw_fence_done(not)) {
-		pr_err("Fences signaled too early\n");
+		drm_err(NULL, "Fences signaled too early\n");
 		goto err;
 	}
 
 	if (!wait_event_timeout(timeout->wait,
 				i915_sw_fence_done(timeout),
 				2 * (end - jiffies) + 1)) {
-		pr_err("Timeout fence unsignaled!\n");
+		drm_err(NULL, "Timeout fence unsignaled!\n");
 		goto err;
 	}
 
 	if (i915_sw_fence_done(not)) {
-		pr_err("No timeout fence signaled!\n");
+		drm_err(NULL, "No timeout fence signaled!\n");
 		goto err;
 	}
 
@@ -728,7 +732,7 @@ static int test_dma_fence(void *arg)
 	dma_fence_signal(dma);
 
 	if (!i915_sw_fence_done(timeout) || !i915_sw_fence_done(not)) {
-		pr_err("Fences unsignaled\n");
+		drm_err(NULL, "Fences unsignaled\n");
 		goto err;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
index 88fa845e9f4a..3eae3c6fa312 100644
--- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
@@ -25,6 +25,8 @@
 #include "../i915_selftest.h"
 #include "i915_random.h"
 
+#include <drm/drm_print.h>
+
 static char *
 __sync_print(struct i915_syncmap *p,
 	     char *buf, unsigned long *sz,
@@ -102,7 +104,7 @@ static int check_syncmap_free(struct i915_syncmap **sync)
 {
 	i915_syncmap_free(sync);
 	if (*sync) {
-		pr_err("sync not cleared after free\n");
+		drm_err(NULL, "sync not cleared after free\n");
 		return -EINVAL;
 	}
 
@@ -121,7 +123,7 @@ static int dump_syncmap(struct i915_syncmap *sync, int err)
 		goto skip;
 
 	if (i915_syncmap_print_to_buf(sync, buf, PAGE_SIZE))
-		pr_err("%s", buf);
+		drm_err(NULL, "%s", buf);
 
 	kfree(buf);
 
@@ -146,14 +148,13 @@ static int igt_syncmap_init(void *arg)
 static int check_seqno(struct i915_syncmap *leaf, unsigned int idx, u32 seqno)
 {
 	if (leaf->height) {
-		pr_err("%s: not a leaf, height is %d\n",
-		       __func__, leaf->height);
+		drm_err(NULL, "%s: not a leaf, height is %d\n", __func__, leaf->height);
 		return -EINVAL;
 	}
 
 	if (__sync_seqno(leaf)[idx] != seqno) {
-		pr_err("%s: seqno[%d], found %x, expected %x\n",
-		       __func__, idx, __sync_seqno(leaf)[idx], seqno);
+		drm_err(NULL, "%s: seqno[%d], found %x, expected %x\n",
+			__func__, idx, __sync_seqno(leaf)[idx], seqno);
 		return -EINVAL;
 	}
 
@@ -169,20 +170,21 @@ static int check_one(struct i915_syncmap **sync, u64 context, u32 seqno)
 		return err;
 
 	if ((*sync)->height) {
-		pr_err("Inserting first context=%llx did not return leaf (height=%d, prefix=%llx\n",
-		       context, (*sync)->height, (*sync)->prefix);
+		drm_err(NULL,
+			"Inserting first context=%llx did not return leaf (height=%d, prefix=%llx\n",
+			context, (*sync)->height, (*sync)->prefix);
 		return -EINVAL;
 	}
 
 	if ((*sync)->parent) {
-		pr_err("Inserting first context=%llx created branches!\n",
-		       context);
+		drm_err(NULL, "Inserting first context=%llx created branches!\n", context);
 		return -EINVAL;
 	}
 
 	if (hweight32((*sync)->bitmap) != 1) {
-		pr_err("First bitmap does not contain a single entry, found %x (count=%d)!\n",
-		       (*sync)->bitmap, hweight32((*sync)->bitmap));
+		drm_err(NULL,
+			"First bitmap does not contain a single entry, found %x (count=%d)!\n",
+			(*sync)->bitmap, hweight32((*sync)->bitmap));
 		return -EINVAL;
 	}
 
@@ -191,8 +193,7 @@ static int check_one(struct i915_syncmap **sync, u64 context, u32 seqno)
 		return err;
 
 	if (!i915_syncmap_is_later(sync, context, seqno)) {
-		pr_err("Lookup of first context=%llx/seqno=%x failed!\n",
-		       context, seqno);
+		drm_err(NULL, "Lookup of first context=%llx/seqno=%x failed!\n", context, seqno);
 		return -EINVAL;
 	}
 
@@ -229,8 +230,8 @@ static int igt_syncmap_one(void *arg)
 		}
 		max++;
 	} while (!__igt_timeout(end_time, NULL));
-	pr_debug("%s: Completed %lu single insertions\n",
-		 __func__, max * (max - 1) / 2);
+	drm_dbg(NULL, "%s: Completed %lu single insertions\n",
+		__func__, max * (max - 1) / 2);
 out:
 	return dump_syncmap(sync, err);
 }
@@ -244,14 +245,16 @@ static int check_leaf(struct i915_syncmap **sync, u64 context, u32 seqno)
 		return err;
 
 	if ((*sync)->height) {
-		pr_err("Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
-		       context, (*sync)->height, (*sync)->prefix);
+		drm_err(NULL,
+			"Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
+			context, (*sync)->height, (*sync)->prefix);
 		return -EINVAL;
 	}
 
 	if (hweight32((*sync)->bitmap) != 1) {
-		pr_err("First entry into leaf (context=%llx) does not contain a single entry, found %x (count=%d)!\n",
-		       context, (*sync)->bitmap, hweight32((*sync)->bitmap));
+		drm_err(NULL,
+			"First entry into leaf (context=%llx) does not contain a single entry, found %x (count=%d)!\n",
+			context, (*sync)->bitmap, hweight32((*sync)->bitmap));
 		return -EINVAL;
 	}
 
@@ -260,8 +263,8 @@ static int check_leaf(struct i915_syncmap **sync, u64 context, u32 seqno)
 		return err;
 
 	if (!i915_syncmap_is_later(sync, context, seqno)) {
-		pr_err("Lookup of first entry context=%llx/seqno=%x failed!\n",
-		       context, seqno);
+		drm_err(NULL, "Lookup of first entry context=%llx/seqno=%x failed!\n",
+			context, seqno);
 		return -EINVAL;
 	}
 
@@ -306,20 +309,20 @@ static int igt_syncmap_join_above(void *arg)
 				continue;
 
 			if (!join->height) {
-				pr_err("Parent with no height!\n");
+				drm_err(NULL, "Parent with no height!\n");
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (hweight32(join->bitmap) != 2) {
-				pr_err("Join does not have 2 children: %x (%d)\n",
-				       join->bitmap, hweight32(join->bitmap));
+				drm_err(NULL, "Join does not have 2 children: %x (%d)\n",
+					join->bitmap, hweight32(join->bitmap));
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (__sync_child(join)[__sync_branch_idx(join, context)] != sync) {
-				pr_err("Leaf misplaced in parent!\n");
+				drm_err(NULL, "Leaf misplaced in parent!\n");
 				err = -EINVAL;
 				goto out;
 			}
@@ -350,8 +353,9 @@ static int igt_syncmap_join_below(void *arg)
 				goto out;
 
 			if (sync->height) {
-				pr_err("Inserting context=%llx (order=%d, step=%d) did not return leaf (height=%d, prefix=%llx\n",
-				       context, order, step, sync->height, sync->prefix);
+				drm_err(NULL,
+					"Inserting context=%llx (order=%d, step=%d) did not return leaf (height=%d, prefix=%llx\n",
+					context, order, step, sync->height, sync->prefix);
 				err = -EINVAL;
 				goto out;
 			}
@@ -363,16 +367,17 @@ static int igt_syncmap_join_below(void *arg)
 			u64 context = step * BIT_ULL(order);
 
 			if (!i915_syncmap_is_later(&sync, context, 0)) {
-				pr_err("1: context %llx (order=%d, step=%d) not found\n",
-				       context, order, step);
+				drm_err(NULL, "1: context %llx (order=%d, step=%d) not found\n",
+					context, order, step);
 				err = -EINVAL;
 				goto out;
 			}
 
 			for (idx = 1; idx < KSYNCMAP; idx++) {
 				if (i915_syncmap_is_later(&sync, context + idx, 0)) {
-					pr_err("1: context %llx (order=%d, step=%d) should not exist\n",
-					       context + idx, order, step);
+					drm_err(NULL,
+						"1: context %llx (order=%d, step=%d) should not exist\n",
+						context + idx, order, step);
 					err = -EINVAL;
 					goto out;
 				}
@@ -385,8 +390,8 @@ static int igt_syncmap_join_below(void *arg)
 			u64 context = step * BIT_ULL(order);
 
 			if (!i915_syncmap_is_later(&sync, context, 0)) {
-				pr_err("2: context %llx (order=%d, step=%d) not found\n",
-				       context, order, step);
+				drm_err(NULL, "2: context %llx (order=%d, step=%d) not found\n",
+					context, order, step);
 				err = -EINVAL;
 				goto out;
 			}
@@ -423,17 +428,19 @@ static int igt_syncmap_neighbours(void *arg)
 				goto out;
 
 			if (sync->height) {
-				pr_err("Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
-				       context, sync->height, sync->prefix);
+				drm_err(NULL,
+					"Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
+					context, sync->height, sync->prefix);
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (sync->bitmap != BIT(idx + 1) - 1) {
-				pr_err("Inserting neighbouring context=0x%llx+%d, did not fit into the same leaf bitmap=%x (%d), expected %lx (%d)\n",
-				       context, idx,
-				       sync->bitmap, hweight32(sync->bitmap),
-				       BIT(idx + 1) - 1, idx + 1);
+				drm_err(NULL,
+					"Inserting neighbouring context=0x%llx+%d, did not fit into the same leaf bitmap=%x (%d), expected %lx (%d)\n",
+					context, idx,
+					sync->bitmap, hweight32(sync->bitmap),
+					BIT(idx + 1) - 1, idx + 1);
 				err = -EINVAL;
 				goto out;
 			}
@@ -473,9 +480,10 @@ static int igt_syncmap_compact(void *arg)
 				goto out;
 
 			if (sync->height) {
-				pr_err("Inserting context=%llx (order=%d, idx=%d) did not return leaf (height=%d, prefix=%llx\n",
-				       context, order, idx,
-				       sync->height, sync->prefix);
+				drm_err(NULL,
+					"Inserting context=%llx (order=%d, idx=%d) did not return leaf (height=%d, prefix=%llx\n",
+					context, order, idx,
+					sync->height, sync->prefix);
 				err = -EINVAL;
 				goto out;
 			}
@@ -483,22 +491,23 @@ static int igt_syncmap_compact(void *arg)
 
 		sync = sync->parent;
 		if (sync->parent) {
-			pr_err("Parent (join) of last leaf was not the sync!\n");
+			drm_err(NULL, "Parent (join) of last leaf was not the sync!\n");
 			err = -EINVAL;
 			goto out;
 		}
 
 		if (sync->height != order) {
-			pr_err("Join does not have the expected height, found %d, expected %d\n",
-			       sync->height, order);
+			drm_err(NULL,
+				"Join does not have the expected height, found %d, expected %d\n",
+				sync->height, order);
 			err = -EINVAL;
 			goto out;
 		}
 
 		if (sync->bitmap != BIT(KSYNCMAP) - 1) {
-			pr_err("Join is not full!, found %x (%d) expected %lx (%d)\n",
-			       sync->bitmap, hweight32(sync->bitmap),
-			       BIT(KSYNCMAP) - 1, KSYNCMAP);
+			drm_err(NULL, "Join is not full!, found %x (%d) expected %lx (%d)\n",
+				sync->bitmap, hweight32(sync->bitmap),
+				BIT(KSYNCMAP) - 1, KSYNCMAP);
 			err = -EINVAL;
 			goto out;
 		}
@@ -508,28 +517,28 @@ static int igt_syncmap_compact(void *arg)
 			struct i915_syncmap *leaf = __sync_child(sync)[idx];
 
 			if (leaf->height) {
-				pr_err("Child %d is a not leaf!\n", idx);
+				drm_err(NULL, "Child %d is a not leaf!\n", idx);
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (leaf->parent != sync) {
-				pr_err("Child %d is not attached to us!\n",
-				       idx);
+				drm_err(NULL, "Child %d is not attached to us!\n", idx);
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (!is_power_of_2(leaf->bitmap)) {
-				pr_err("Child %d holds more than one id, found %x (%d)\n",
-				       idx, leaf->bitmap, hweight32(leaf->bitmap));
+				drm_err(NULL, "Child %d holds more than one id, found %x (%d)\n",
+					idx, leaf->bitmap, hweight32(leaf->bitmap));
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (leaf->bitmap != BIT(idx)) {
-				pr_err("Child %d has wrong seqno idx, found %d, expected %d\n",
-				       idx, ilog2(leaf->bitmap), idx);
+				drm_err(NULL,
+					"Child %d has wrong seqno idx, found %d, expected %d\n",
+					idx, ilog2(leaf->bitmap), idx);
 				err = -EINVAL;
 				goto out;
 			}
@@ -582,8 +591,9 @@ static int igt_syncmap_random(void *arg)
 			u64 context = i915_prandom_u64_state(&ctx);
 
 			if (i915_syncmap_is_later(&sync, context, seqno) != expect) {
-				pr_err("context=%llu, last=%u this=%u did not match expectation (%d)\n",
-				       context, last_seqno, seqno, expect);
+				drm_err(NULL,
+					"context=%llu, last=%u this=%u did not match expectation (%d)\n",
+					context, last_seqno, seqno, expect);
 				err = -EINVAL;
 				goto out;
 			}
@@ -595,7 +605,8 @@ static int igt_syncmap_random(void *arg)
 
 		phase++;
 	} while (!__igt_timeout(end_time, NULL));
-	pr_debug("Completed %lu passes, each of %lu contexts\n", phase, count);
+	drm_dbg(NULL, "Completed %lu passes, each of %lu contexts\n",
+		phase, count);
 out:
 	return dump_syncmap(sync, err);
 }
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index 7e59591bbed6..d8fbe5a8060b 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -24,6 +24,8 @@
 #include <linux/prime_numbers.h>
 #include <linux/prandom.h>
 
+#include <drm/drm_print.h>
+
 #include "i915_selftest.h"
 #include "i915_utils.h"
 
@@ -53,14 +55,16 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
 		unsigned int npages = npages_fn(n, pt->st.nents, rnd);
 
 		if (page_to_pfn(page) != pfn) {
-			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg)\n",
-			       __func__, who, pfn, page_to_pfn(page));
+			drm_err(NULL,
+				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg)\n",
+				__func__, who, pfn, page_to_pfn(page));
 			return -EINVAL;
 		}
 
 		if (sg->length != npages * PAGE_SIZE) {
-			pr_err("%s: %s copied wrong sg length, expected size %lu, found %u (using for_each_sg)\n",
-			       __func__, who, npages * PAGE_SIZE, sg->length);
+			drm_err(NULL,
+				"%s: %s copied wrong sg length, expected size %lu, found %u (using for_each_sg)\n",
+				__func__, who, npages * PAGE_SIZE, sg->length);
 			return -EINVAL;
 		}
 
@@ -70,8 +74,8 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
 		pfn += npages;
 	}
 	if (pfn != pt->end) {
-		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
-		       __func__, who, pt->end, pfn);
+		drm_err(NULL, "%s: %s finished on wrong pfn, expected %lu, found %lu\n",
+			__func__, who, pt->end, pfn);
 		return -EINVAL;
 	}
 
@@ -90,8 +94,9 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
 		struct page *page = sg_page_iter_page(&sgiter);
 
 		if (page != pfn_to_page(pfn)) {
-			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg_page)\n",
-			       __func__, who, pfn, page_to_pfn(page));
+			drm_err(NULL,
+				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg_page)\n",
+				__func__, who, pfn, page_to_pfn(page));
 			return -EINVAL;
 		}
 
@@ -101,8 +106,8 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
 		pfn++;
 	}
 	if (pfn != pt->end) {
-		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
-		       __func__, who, pt->end, pfn);
+		drm_err(NULL, "%s: %s finished on wrong pfn, expected %lu, found %lu\n",
+			__func__, who, pt->end, pfn);
 		return -EINVAL;
 	}
 
@@ -120,8 +125,9 @@ static noinline int expect_pfn_sgtiter(struct pfn_table *pt,
 	pfn = pt->start;
 	for_each_sgt_page(page, sgt, &pt->st) {
 		if (page != pfn_to_page(pfn)) {
-			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sgt_page)\n",
-			       __func__, who, pfn, page_to_pfn(page));
+			drm_err(NULL,
+				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sgt_page)\n",
+				__func__, who, pfn, page_to_pfn(page));
 			return -EINVAL;
 		}
 
@@ -131,8 +137,8 @@ static noinline int expect_pfn_sgtiter(struct pfn_table *pt,
 		pfn++;
 	}
 	if (pfn != pt->end) {
-		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
-		       __func__, who, pt->end, pfn);
+		drm_err(NULL, "%s: %s finished on wrong pfn, expected %lu, found %lu\n",
+			__func__, who, pt->end, pfn);
 		return -EINVAL;
 	}
 
@@ -275,7 +281,7 @@ static const npages_fn_t npages_funcs[] = {
 	NULL,
 };
 
-static int igt_sg_alloc(void *ignored)
+static int igt_sg_alloc(void *arg)
 {
 	IGT_TIMEOUT(end_time);
 	const unsigned long max_order = 20; /* approximating a 4GiB object */
@@ -305,7 +311,7 @@ static int igt_sg_alloc(void *ignored)
 
 				prandom_seed_state(&prng,
 						   i915_selftest.random_seed);
-				err = expect_pfn_sgtable(&pt, *npages, &prng,
+					err = expect_pfn_sgtable(&pt, *npages, &prng,
 							 "sg_alloc_table",
 							 end_time);
 				sg_free_table(&pt.st);
@@ -322,7 +328,7 @@ static int igt_sg_alloc(void *ignored)
 	return 0;
 }
 
-static int igt_sg_trim(void *ignored)
+static int igt_sg_trim(void *arg)
 {
 	IGT_TIMEOUT(end_time);
 	const unsigned long max = PAGE_SIZE; /* not prime! */
@@ -348,8 +354,9 @@ static int igt_sg_trim(void *ignored)
 			if (i915_sg_trim(&pt.st)) {
 				if (pt.st.orig_nents != prime ||
 				    pt.st.nents != prime) {
-					pr_err("i915_sg_trim failed (nents %u, orig_nents %u), expected %lu\n",
-					       pt.st.nents, pt.st.orig_nents, prime);
+					drm_err(NULL,
+						"i915_sg_trim failed (nents %u, orig_nents %u), expected %lu\n",
+						pt.st.nents, pt.st.orig_nents, prime);
 					err = -EINVAL;
 				} else {
 					prandom_seed_state(&prng,
-- 
2.34.1

