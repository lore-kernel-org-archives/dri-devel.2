Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D7AC61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B31810F329;
	Fri, 28 Aug 2026 10:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jZBu2tPO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C00F10E49F;
 Fri, 28 Aug 2026 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911455; x=1819447455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=u84090IHjGttOnY1ndtwAGuYPtVSCjG16Q0XL6rtglE=;
 b=jZBu2tPOPf37mKQ/wtax80d2mGItLBkZ0RGaiKBf9+LyJ0+z7inI7JCc
 Q3qof1DgN0XPnJn5XQhdFgVtz8Rq7mTEDi3b1tFEa3+ryGo6HYyBSqLau
 TACGEZ7vv8hiHK/uYpeFf4vySXvd7fT+rJaU4KPcNeoDOxrVXTrqbKLsY
 LGGvI7biuj31X8e8aKnycXoNQw1lUmOQNW/yEG3wWRgZBaDDqZiory/MV
 QeKS6CpjCCX8HKAgavnXNzok9KmseMcO0Plz0z0fF3kkICi08H4PMTNNd
 uaZziY/Jgavcw8QVJhwZhwN+SjTW3abUX/OgceOmfuMTGhknBAeBDrYBj w==;
X-CSE-ConnectionGUID: uk1/g89WSrmuvn3Sq1ytZQ==
X-CSE-MsgGUID: YCCuV4ULSImOsJorB4eeyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88541262"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88541262"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:15 -0700
X-CSE-ConnectionGUID: fLmA9zYmQJWpPymjEuiNIg==
X-CSE-MsgGUID: APd131mWQLu/XATqvFylHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="270070569"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHlBtOowh4olKnDnEXolMq5SpOB8EklKe+3rcPmkkeTRGqJBYdPUqU9Wlfct6HvLn/7u/gbFX5XlEFADMrTbhhGhxVQvwS0CEW5TEwKwSdGyo7413GBC9kbYMzwh8OrsdNSibPufsuPFasXBMB6I3KPfY3PdYONDdWOfDZKmE34NaeAHxo2qfkU6boWAjLuYFbZ9GSGWHbZre6feBE94dqb2Jj4J1wJMWKYAJgZvJ6AEk1Wb2i3zY6Xy03Uo9ZnCnx0ZvPRGkoaQHte2hvqi8TDf9mm1Ml46lSdr43oAm6s9hXdKowvxE4Rvrf/bXQTzzh766LHFbNCOgXapX5Bmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvdQbxU9ZQKgTfC0EbyJH23z8H5HpqzfAH5v/RYaNj8=;
 b=Qi0UPRtSfkVzpPZyuj2pUuZ5h8ya9JpRae7VcnxQZkwnsTVxV7aLOElOkDbA1MOhsDVvXfrVvAJTt5BYeWIE0/XSpT/tih/Jl2d33WRUbtrX4FpPsIZJDlhf7fi1GuEfzdIlilbr+80xH62stc/sfMtm7WII9kQL68A3fnZyz6yw6q20Ne95wi9mZuvyUguOsaTXrMl3hVsg7f/C2o5eOu/hrUa/0tOm8r8gsrkFudpqcA0G+J189AJX8NV+kHKDafypScvZx0LMJFjosbQtwQnHZv/H0LCal9ARcJParZtnKTJSmH49fkoH/oTCzVQPLmf4nNdLrNO8Wnsk23wZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:12 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:04:12 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 7/8] drm/i915/selftests: Use drm_* prints in selftest
 headers
Date: Fri, 28 Aug 2026 10:03:38 +0000
Message-ID: <20260828100339.72304-8-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b9d1865-9f49-43ca-289b-08df04ebb5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fDIXW7/Q/ewIJMYpdM7HmRnn83neiL6m2naO3DQkS/M4vCyzom+AzB87MppN5QzM6XY+FviqO6dSMFmLDZvN3/MowUIrmOm+18XnZjAkZeoIZqW1R0CfdcVDKuZgvjkZaJBetuDXf4iTlK+/I7dXjLjP8OrW6hONOKI/uc/3/bHc09ZrCH32giSmC2pEKjFVEnVbzRHAwzypPpoosFklArV+RoLlvD37vVSW9BU4a9C70DKRlw5zEMpL6CvAfkFryO5/LceXd121fy/xqfU4Lw89IqBrBp/Tc0Xme9Ilhf5kVyJ8ZFvEgvEiYvowMCDXP0GojWlUzKRaHVvFhjil8wesyRhQ3MRmASYX+TsHGEKBvKcQx7wAw2wxMfEQWcgmGIHPElF7uYaQkFoZ/dla4fjU1H0Il/Vff2zWp7Lia0cCYF+ZQ4/Zs2GT6FHP6FMBcAwppa6Fq9NMPd5cpqvm47bTMOty45Zt4NP0kYgHpQXJNo8lUnbIdMD5bjXPjgdRuKuwcFki00WX6bFy+Ik0g+gvtMtUFACcvSd8zS4oqlncppHreaGXsHh2XoWqbH/t3lO46Do11WmoOCh9oWSvHU3YyOORIZseGB1Qo9K8qZQ/MTt7n1c6ooKZ8dQFevZIrRyQIekmqZwVmx9w/TJCysDCJxir2Bai+eUnHwG/cQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tJMOa1bG3HqxhSZ9kJnO5Lmqmylp+fZwcleD16TSx8ZUIn5WTKYgEiOhit8?=
 =?us-ascii?Q?YWsrnLSX6tPpAogbR/gfNdZ9R5GYHHTYJXBZ053rTZ+lHudyD0lzGMEx7JHR?=
 =?us-ascii?Q?Fi2g688iJWQkuyjhUaWPjI8Zz/hvYnjy0yeir68e28JgnV0+cYSI50PKa+3U?=
 =?us-ascii?Q?2TRZnYfFrP+TiGygypDjFewCQA/SSc6oOcXobRWUtO+UthYXSriS1cB9W6g3?=
 =?us-ascii?Q?L/Ew6+g006jX6lE2X3EJGRroT/uy4QcHeOHchaFVKD7ac2LaUFl9qARE1lwJ?=
 =?us-ascii?Q?0ZEfS45OeCvk5SGlEU0wvDwxd0U9cegI2MbQUYdTn8MfAkm4uHU8fBvO35yw?=
 =?us-ascii?Q?8ug8F0RWg+a/SBYHxZAxPjusjEUWxtA+lTcCkNvU41xjHqRj0o5S3bwtxwtf?=
 =?us-ascii?Q?fSLzqTNExjRQLvVod00agZCoV0JIYbz2TDEwIqUB4RaRwndSJ9QCADPGbFJt?=
 =?us-ascii?Q?4vYSEnUDSkKdV8zTkdIep7TYbsXSdYK6qiuvkuNXgSbFn1XhVxocq2CFPGmU?=
 =?us-ascii?Q?IQPQI+/X2ykFbKN93u+2nzy8Y4DGMLKduqhKVXPZqYHQjS8W9bDmN1PYQ8Qn?=
 =?us-ascii?Q?xEvRI9w8fWu3z5HelSQJ3tQZiIllXrKla0WTB6O0XFNlcekX0Ls6vFwz/zTH?=
 =?us-ascii?Q?NMD5KVRCOD+ea9SUTtUughY2BPaeF88eGk4KO0MPGAFpDO0pbco1Ek6fEGvX?=
 =?us-ascii?Q?hpHQ2BxgrMBcwVeNFlVDIeIv4G0vtgAf0oIIk14v1QUZve8vmNi10e+Vj1QA?=
 =?us-ascii?Q?o9WP9I2SbeFd4Zwtd8C+JShrAya4rryViQKgmOOBp1BFCGP3vlTThJnGgdKd?=
 =?us-ascii?Q?iowq9OFUA6OTibcKgu9WcF3koeWIK4GEtqei6GKLfKmmFR5L1QCOqJ4H/uql?=
 =?us-ascii?Q?Ns0QJQWapCcBzNXqMvkAyKmO/O4M/l7xlYgPmmg0PtGg30CEgiJpS1rsN0wC?=
 =?us-ascii?Q?wNG6rxFlGZTdJnQaarK6A3zD5ONdd3XrpuHxzzqTIwh0ajjG2lIYKDgfJUSz?=
 =?us-ascii?Q?bm9eJV8m+sYsiSLGWz3BNsG/KNmpvbMkNWGJla6nqSu6uQF8JHF5U/T3g5Rq?=
 =?us-ascii?Q?SzvSKheUnn/oUXaZI4FeuMHMb6/+LxxepKrk63cUSOAOhanBQDXlyIEEmoIu?=
 =?us-ascii?Q?TU1XEXSv5ywRmEVO4FLT9L6WyWaarY2PsPxQ/s6d39CqbzsovDvhhUrtOpHY?=
 =?us-ascii?Q?hhYM+vBKBNbFdJHxpHZQQMyhAsa6vZ65LwvimMKem7CwUZlb89fnHLl8JZtJ?=
 =?us-ascii?Q?vCNxhgxhkEee5K4ORIRABTC7vnMB7+0Go+e6LF9UEl4fAVpKiCZ8YeLZ9uxL?=
 =?us-ascii?Q?PxIT6/Hd87y8O72IUQNEdIdrixzcIlnWMd1uoFoKoa/nTMV871uyMpI5z5y8?=
 =?us-ascii?Q?h7Lonk2EuVRJIVQkybUIDNF3GYJ4d6AnKlg615ieAWy0PlVRWyhQwe+PGkAx?=
 =?us-ascii?Q?0R+sU6oYb5GJZpZjnMbwcUYTjihuuMeBJZxzbtv103COhfn8ZxnkAgU2bFhO?=
 =?us-ascii?Q?/Q0pxYvuM28G87rjiwkvJL4J+XqccZfz00QaBMgtCVxxGR2SaDGX5inkBchm?=
 =?us-ascii?Q?KvzZg1/k4MXHfcNBku8ORi8z6DRHOOBQfpc6+SNxA4g2aGmJ11l1raruMOP6?=
 =?us-ascii?Q?oBTy6nZhEHlMs48qexknG2/G+gwfxavS4K0y8oZnQt8whrdbhOyQOp+zorn9?=
 =?us-ascii?Q?6q/mTlklS9/O9BhPbD0Q10UNlMeRdplzPxhHBIP7dutiNchaqbjxQ6eI3Qzq?=
 =?us-ascii?Q?Bl7nA5w3vhS9/n/Zac8geqMduyd0S84=3D?=
X-Exchange-RoutingPolicyChecked: fVBl8vQG9oUmqTj+MhLfg47FF7Ha4Ha9XIEozb0WLpge9NRQ51WNZQ/cS+UV0RgmBt53ydSs02Qs4MB0unijqADPER1BbGPJVltvZ5v9plGbcnhnbv7ujQynwci9XIBEHLaIvRxUm17xEnpIO5lJ9N7qn86UCd1HCNMm59sHqKkrqgRIVY7wUTwqSeEUg5/+eIVFAtxFODkZ3bGjZjICmsnApysRj/2g9n8ZII4o4Om3zp/krnrxQt9lWN1nRFYKsiv7pfUe+MNM0K3Hxdj2x5Yvt9gKLQeMJd72Z1gkjhUqjrQzP62v9uVaEjmw6fwelahYhSrRh/mrWBAW0QrXbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9d1865-9f49-43ca-289b-08df04ebb5c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:04:12.4878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufV+EWOMcpqsstbINPhlCUoofoDdBkOXeQxeh1D1KANkK4PnVSSE/kT+vht2cAPnF12PYWoHJf7ecSk82oD89TpAcXOoNQOjaG3QeM8fW4c=
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
 drivers/gpu/drm/i915/selftests/i915_selftest.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..fa840a7e651e 100644
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
 
@@ -154,7 +156,7 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
 				     timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
+		drm_warn(&i915->drm, "Timed out waiting for gsc_proxy_completion!\n");
 }
 
 static void
@@ -178,7 +180,7 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait &&
 	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
+		drm_warn(&i915->drm, "Timed out waiting for huc load via GSC!\n");
 }
 
 static struct mm_struct *get_selftest_mm(int u_pid_nr)
-- 
2.34.1

