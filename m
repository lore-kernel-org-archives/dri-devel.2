Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFE6CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91E210E2DB;
	Thu,  1 Oct 2026 07:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XMZXyFP3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91F410E294;
 Thu,  1 Oct 2026 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790840508; x=1822376508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Kf8OhlHaW+6gwtQX0znDumi7cSGa097U/Ycgio6nS9c=;
 b=XMZXyFP3vAIC4bKS2DwGqpDAn3hxjEE5yqBBe1GRiKtINn6/qifhHNLo
 JLrTwytSVTHKdOqVJT7AXkOOv/bIRAydn6yqoueReFA4qqv4WXEDmjxi3
 JQe5PeiYssMZ0I8lNrBVA76FxCoP8mFZaZef2DqOBh29QZNfXwtOx25X3
 UGuMfPBR5bvJ7bz9jxtnyYcJskTWYV588izZcaKIW8WyFjs4CQQEu0zER
 MJwFYidwF6bl6+cqT1uZysQYqGaeXjJHr9bNLraoPLtGlzFPjwgZBW+s5
 vXzMhfngZ02pkLSfkbMxYHWIAr5lmPE0KlQoch70iKa3LK+eVwG0xc7ao g==;
X-CSE-ConnectionGUID: gs75zq6VToavpd0bwKJ3Dg==
X-CSE-MsgGUID: GJNhALlQRWuz3uAc7GBmbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102114393"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="102114393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:47 -0700
X-CSE-ConnectionGUID: 8uot/e2eR8W/qanzyJwujQ==
X-CSE-MsgGUID: MGU/pyzJQvOPBzsAfgtQ9w==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 00:41:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWGX8NvTiDI/Pzcek23CpGwOFBl0+/hQheJOAV5PJeIJLhk3E31ids+9AseHpL3QrU1ITD4Wt4+imFSb3IdGCpA9WXRqNq8d/786vzZ7Unn4L3vchgM8A5f8lZVCbVLpry1YgiTGmAmiiOtdLcHQe0oaoTrYwhg23CeG3rBmUdVQGV4ycORaElagscyJolW6YKy8MlhlOthRkdyBdmAY7PNww2Gwn3eFSJmYuhPs8au6PIMugtk0vgiX0+vJ0Y4iONsZ2HlSXTwiUjesIsh2TQZWRJla8UQXUxsADfAwfTae71AUqDyST4fn85n+9nucEVE5k/w0ZaQy8xHNzn/ZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkuD+EjjF0askKQXfBib6AVBPtvSPO2ThusRATlUakY=;
 b=rFWIbFVFeUUX6E1oXEWdskuJzbcpzYBJwtzyTXKnd6n55Up7BJGqPdmZjkIa3Pmdgpdq8vMsepWU9jHRvwtKfCIRxgQ2//QnwqT3ldPPHoXI2VdQAM0PRxU2gZj1qosiL4SltIIhGhW+Fbsbt3TFG4yzkLL2j0ZAwIBo2vTTGJL3XE/61RsIagjfrZbZCD6HoQpO1HICm7+AR4KGbqOixsEzBCfoaJw1B2hbkliyP5xDG9rZg5MBwSJG86iPWKASFHARMCOLdE0K4Fqmns/IaQqAAB0IJEJOlfHeazKvfanFvYFdUpDlNy0B5dXnVluwuvH6KThZI4nWfSBLNIWYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:41:39 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:41:39 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 6/6] drm/i915/selftests: Use drm_* prints in i915_selftest.c
Date: Thu, 1 Oct 2026 07:41:00 +0000
Message-ID: <20261001074100.2694888-7-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c814d2d-53eb-492e-b976-08df1f8f6dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kg77Y+95uyVw7qZPwx1oQodyqmr/gk5Sze7CPwVBGZ5KpkwasaBqdyEZsHhtaI9+Xy5+onTqcaByknhFCLgDmIZwduvIfx7GAtGFjwNlf3G+6ow28IcC1HsIIMTGcqSgFM9Pi/BhLwb+sQXVmn20j6Dsu5BSfXbkgKGfQWBTmwC8T2KaKcSmpuo1EnDKbUVmIXnhZCjMnfu5xRd0R1cZK8ucCNYVztCCNGgA3ZLsp/Jmdh+ZOAnSXbVXdnAYbwMbmtn1Zjzxt8sE7P3Rh6zxNhJ7iT5eFEVuT8BhNFYlohuwshhZM4BDNpoNj/aQzXv+jWYh4Qx1IbfoOjieTn/5E/vZOu4s3uglJleC4rQpGmKBZ+YshLqt2cznQQYn7dEkDqG7DQZz6yfeCwwETO2KjbmtKdLsre29y0NsTwE3w3xX8ZvmwVtcw/KRESoQRac6cgJfHCMhzpwW8+mEvYgGqwzFBtHoMNPwSmgwhKr2eTx2YtJWqSLByujDb9h4boIz+3hfJQ/yiEBS5fZMdQJyDQk7RHnHrxlWfRI9cLurrV/S47YN9W2zFcBDuQMhMEnjm0jpwzgTopfF016QtKB566i3W+inbe+8UkTakv0Y7SNu7aOz0a4/JNCvSlNdkHrd1qottzaNvxAZE5B2tIwlAKa7W3lkbiIXMXcQuM0Z6go=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjWDI052a3C/jMjWHVTjDng+BlLG0frIPd4aw6VsEFfxyTLoZCGj60UIHDln?=
 =?us-ascii?Q?chvDIhjj7YTrLKVr3Wb4BnvNCm5HV7owoYQpGLSinc8kcrT3tSblxSNWFS0b?=
 =?us-ascii?Q?l6Pgi2YULzY7y7PGn1zXw0s6oiXaEWarr7/fYNxOd+UGh6HOCfaARUBso0SZ?=
 =?us-ascii?Q?pNbn6OUJOXlfQaMPGNAQItpHJXYZsf8LgWkp7h0sT164EURvRDqWORFuxVFV?=
 =?us-ascii?Q?w8imI7EgqJUJ/9bJBp8+j3aajhbT1lGsIbOZYYFR8wi846mNO8VL+dndm4PI?=
 =?us-ascii?Q?847hV0SyErbN5kp0+67ZWuu6rBmeBV7Br9frJFl7+5ISj0+h4FsYc2Zr1O2S?=
 =?us-ascii?Q?eG3rYsYqS86ynQPWNOCjqyrgiIbEWgi3ttKUsdKYfFScjPwFe2qrxa2LrzBc?=
 =?us-ascii?Q?RA1U+s5H1WpB98fc5fVnKnzW1LqwZEwP4Y3XJHX8a9QrqqVjZhnJPuD0ieLU?=
 =?us-ascii?Q?SHbCz2Pr/xI8O1PRwCMg5spBAHPLxoez/C1+m4cR2B8zlJ15ARpIwsv1ylwt?=
 =?us-ascii?Q?/Eu5mPrFLL+u72u4bGWWY6g3EmkWKs1ru2OzXPnT3wQACU7DUs3mMvRyV5WG?=
 =?us-ascii?Q?FK3VVaALFO47R0sbp9qjLRvxyk3j2I5LZ+0GedQHZ8ZX7T2eJyHSTYcTb7u8?=
 =?us-ascii?Q?ctGU24tXhVKaXncHqphL5LE8LdoGQwP48PODo90yUBbEkvunPiZ0bN5skI+i?=
 =?us-ascii?Q?cvlh0vESGQLEaRJMF+KbRCO5Obfrd+quiv1iBgd5kddFunUsNvHoVqUXeDTb?=
 =?us-ascii?Q?RfjoMg5NMA0Wzk36l1/+ophxHXvr0NG5gVq+B/3RxV/6B42e8VYTgBJELwfz?=
 =?us-ascii?Q?T7y6MNYyVVysUmjrr3J1UKLZcndMZHBQIKkD+Wo3bxL1E8P0v2H+nKFcImJ2?=
 =?us-ascii?Q?cKSMDxvOkzk42f/QkbYTZeInsC0aDT3+JdhNmNRVByLTFrZ9ztMsC5T0q4Lb?=
 =?us-ascii?Q?RKQg0392AHXDrd9XWLtNrM/TTdEqsq+pa4ogB0aueQ445mhmk4CJ0AlLH40r?=
 =?us-ascii?Q?kZBQiT6Al9rVWdnw5PyAGA2l42rNj1xAd+Y0Hf5rVI+3K50bBuxBwUM01SP4?=
 =?us-ascii?Q?T0TsYNvsuUiy0wfJZfc1oQvJpp/6v354yqUEidmS4fsE+1IqnEcXKhdseAaF?=
 =?us-ascii?Q?QSPUfwDHA9UeERIko3MISBGTS5BXCU64ImoRYFZWJk0+uVWEGSSBhm3531US?=
 =?us-ascii?Q?98xLYTgOWYDdR8N7e3zNbVzHuh/RUNNxkWrsj49nlfScgErPQxLi/cxdGF2R?=
 =?us-ascii?Q?rzOapolEYnvFI1BS0xyR0greh308XwYjmWHH6TxX6EUmYwhlC2ghmuE4QXG5?=
 =?us-ascii?Q?1z/aaeZsAP37igRdaQyGL0npeJ/6z394RloQzBjDeimx2GcmSQ3H+1/5uvZU?=
 =?us-ascii?Q?4YXB2EePvLLtheCKQnqWFLej1tZqnXGDjH0mDGoI2bSMCAiejcAy2ZseBv0y?=
 =?us-ascii?Q?I29olaSW9snW61gNPoGk2ZOERBZ580kRwwi95ClU8KkTx29MEFTHPZR8gE9i?=
 =?us-ascii?Q?GsaBem7Rbmv6M6UlMFlI5vD2apthAx65NaNIkVa2JypUlM8+dI57/dLbp/ZR?=
 =?us-ascii?Q?xUW5wGmTk09fvJM3GUL7iuWhLwASGwQiZ1x7/hNc+6u8RqdVqQ7hHNeajh5r?=
 =?us-ascii?Q?nUGnjT8/9n1Ko3MHX2Xd4p9FO5PBZHNEwo5EpfI0ieBEuABwmrAr1LAH/vU8?=
 =?us-ascii?Q?WV8ub7aPY2lVtVBXmVzo60KbjG9C6L7fqyUWUeWtofCykXL/tDVkJG6WyuIW?=
 =?us-ascii?Q?CcN2kDA7KjO/T4ILifNpu6pFj18AwgY=3D?=
X-Exchange-RoutingPolicyChecked: XyqwVoKBeA/9c5g7ge9m/bYP6dBJ092coT7PxPG9Wa/qB1LKAGujrsCGTdzCEOv1z6F1E6WrDnLohkvcNupKMcXR+MzAOT5RK4EZab3RYvB2chJT5aG1OWaUV5UJb49uw8uovnMQlATULTT4b4xnO+AlIl3MZARHkhuL/ohI0NTvF/HHFfBUry0li+pesS/zoihlL5Mel67+B3H5L69UgOwadijkxPVLE//hjTJcmdf7UCJsvYuDUO2Rxaoq7Xm4GPL8kSiDNvdI94rVFviKaBjMCtoKi1TBx7rWx9DA1nrlSDYxRSqbl1xSOyphTC0y9+l9c/C770nfJyfYESFjOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c814d2d-53eb-492e-b976-08df1f8f6dac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:41:39.2500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkkjQhIn5Knbao5XppHxHL955lfZpRHlH3ZFGll4gOgMTOJkprwzk21oOdTDntUQ2EBWB+muUv432sWf4P4kP0CaQ5Y7xXzq7Wz8IZJTArU=
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

Move away from generic pr prints to drm device context aware
drm_* versions.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
v5:
 * Revert to using drm_* macros;

 drivers/gpu/drm/i915/selftests/i915_selftest.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..10198828e7fb 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -23,6 +23,8 @@
 
 #include <linux/random.h>
 
+#include <drm/drm_print.h>
+
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_regs.h"
@@ -47,7 +49,7 @@ int i915_mock_sanitycheck(void)
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
-	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
+	drm_info(&i915->drm, "%s() - ok!\n", __func__);
 	return 0;
 }
 
@@ -154,7 +156,8 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
 				     timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
+		drm_warn(&i915->drm,
+			 "Timed out waiting for gsc_proxy_completion!\n");
 }
 
 static void
@@ -178,7 +181,8 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait &&
 	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
+		drm_warn(&i915->drm,
+			 "Timed out waiting for huc load via GSC!\n");
 }
 
 static struct mm_struct *get_selftest_mm(int u_pid_nr)
-- 
2.34.1

