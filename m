Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E//yALOn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4251911268F;
	Fri, 30 Oct 2026 08:40:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DD911268F;
 Fri, 30 Oct 2026 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793349615; x=1824885615;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=zboTwJST2QIsT7k2jAbycWIYvDuWYupIs3lzN7ln640=;
 b=E//yALOnvLVL6gPrTtjPSa4aNhNBDgvB61MMEZzLFCgGOvJxNfPSIUUp
 ybrxBfhCVM5mT3xAZAmv1C7gn5+DRbYi+DfV1R5U14l/Hr2T6WcP47+AH
 2U0FSBqcCXqy3NHBs5X1MsSTudceMf09HOBnsBChPOsKc6DccNvVpaqgx
 JuJwhAi6ufPNirYYPEJmy5rDgUda+l+Dl4QXse/jEHQ/M4u3VuB+Ocb1s
 27Pjf3j9fmpb29ZGVZNAOi7y94iNWa8szcyiI+1QVtpdpV/V3njQI1AaT
 zq38+tBHpxhIxsyhYCjLoeMsMv4LIQ/Om5fjqLDQ59/aMJ92XH1MCZFf/ Q==;
X-CSE-ConnectionGUID: UEvIp6gWR1yfLVU7Odt4cw==
X-CSE-MsgGUID: lx79wg42QUemNnvMV/09DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2014986"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2014986"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 01:40:13 -0700
X-CSE-ConnectionGUID: Y8/SU1reSSq5gtWYW7skVA==
X-CSE-MsgGUID: V+zh/j68Qm6LwF+CH1GT6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5705350"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 01:40:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 01:40:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 01:40:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 01:40:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqC45rTftFm21ZfSHMDqNSl6ZJH863c9lRpvEIpnBS/D4IzpDW43nEcy75c4S9Y4LZ+7BrxPsUIhPrnYhJOCeAI7ZacY8yUgN2pt79xh1I39gc6aoIuj0z+NIgOrbKrP9IWYH+ycVxN8moD8i0jb0EY5ZzrxTQkFneEeRSGkEOLj8FlyQd1iFDI/KLXGgQtSfnoxGD7xECB3A8xEU0xX6OgmKB+Of7q1NFuL5bHSyi7VtRrnD+qfYLYeTsW2hGYR/uHd1Spy6G1dF9kgouKjHA0sDFfZw4kC1fjdOseq9W/2rr5dQmOVmjVXI0vevLr2uaM0/wLr6qfUOrRwDx1CzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAPLT3SDgnRKGVG7bwqL5zkX7anl0B/FDum076RkGxo=;
 b=K1vKxFHMSs6eWOmXBBs8Xa5yaS1Ky77wzR2xKrRnXIYRDGD9fsGwLsYr1w63JYSmwB2/ls8A8ncxlvhusdWGBymRYLZpHZWbXmqdYkM4cjvCSJDFkbMGmROBFdS58ppvtRoFXS53VmyC609ePkKjJulyyhD9hbvpva6QA/ZTwT6IzECyGZY2J7AKpYs4Odc0oYajJU0HnDsE339B8xuZnGYDtd1lWpJMofH5gGHICQyG57KIwKAg5pSjlksRlMapfrG5dYB0cNjrP13vjg29wiqJJ2WFEVCingOqTTLm8azQM1QcCOzuyM6HGLtB3WKhOcKYoYrWbYE1fBXfALW19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by MW4PR11MB6762.namprd11.prod.outlook.com
 (2603:10b6:303:20c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:40:10 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:40:10 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH] drm/i915/gt: Use VCS instead of VECS for GuC error capture on
 Gen 12
Date: Fri, 30 Oct 2026 08:39:48 +0000
Message-ID: <20261030083948.131717-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB8PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:10:110::19) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|MW4PR11MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab18aac-3399-4583-90d1-08df36616853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|56012099006|5023799004|11063799006|261026140227099003|261028144727099003|261026121527099003|10067099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: a98/NCQr9XdDY6MbYb2f25vtG/RWRz7lOINqLvHnnyROv+l6hIU+kI4+TRFbeX8SHIkXcBBKOqhfWCSR5zRjlZoBuH0C8ZQZxJIlGu4hqTwf08PKPfGaGTUJ+KIlW9vxd00dPJMh4ZdjRP0ZZwS3UVgN3VJ4UCdwAhvItbqKGGl0IiFr2NcbZSaUTqVRS4hEjgTRS14BltpSY/UNWk4zu35JOvPP4KC+T/pbUY+ZR6EBrslZUB1bgBd5SpmaFTz9FpztAlR7EtjD6jpJKW28FiT2bv/S7Yz4kUOzP4619sSfCS5gjag4RSxqqwIGHmjzvODoL3BBL5Mo3HpWkGyqVIvgYl5aA1wCHomZLgNO8fmeg6Y0DvWVgkc4Ig66bP8PMKJsqyqvELMNPVyPdDz8857QsCKhx5Ahp5pSy5ADyafBRwljfiYW8t4978ZQeg4fsKjN7Mj3ZiJVZmirXliuoekytovk7f/JUN5ynzbobvQTuXF+7yWbMoqEnFS1z41WLFNKWN6cY/eaR8R6zenLLiA3FBrXNzKn5HY0FakHqqQu2vmBA3USmNeWUWO6O0y32UCiFuFMAlvYvxpoESKhm32sQv3bB7Lr753GxFRSNTJDaxRC5u8GWnlfeYvgtgXX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3KDiWWp5s6YYTbrNiHTySleCloxx6WGmGTfaDL5qLw6tDtdUcXXmO0h6sJ8?=
 =?us-ascii?Q?g+tFULbeR9HrCVJMosI9/KLnNup+wc5pf5J750UxCJ+Dhk7yrEawp0B3GS6/?=
 =?us-ascii?Q?Gj+7t4tg5HNU0vMMo97RTL/x2xGDbupMoaKSO4ALORGhKLwFxRZL3W66FQqB?=
 =?us-ascii?Q?+vMEolYE1oQ/pyCJmueejtfQN3Ow2bpPhSb9QMsTJB5R8VCbYxnFUNr2GUBd?=
 =?us-ascii?Q?Lk+bvkCW7mWZkfAPhlFG5Y59DDvPxuWG/ujFg2Lw+gXA0ZCero3QulDetZkV?=
 =?us-ascii?Q?c6OmpcIzWncXNIwuJOy/KyZagEBEwtehnXTT35NmAGxsu2C+ZXCsmTiO272s?=
 =?us-ascii?Q?GG6Cd3tJNt7Xs9I3LEL5HIu4hBXcSHa32HfewHYKGsS3v8LtfV1QJ2EmcoD2?=
 =?us-ascii?Q?ZerdfFKnOPSDUivbY+2V2dhjxrgwHzcL96tmlVmW9Qyg7+Kl7MJSSZT4Abqx?=
 =?us-ascii?Q?7kkcMoP8cRWOV/EML6rjQBzbXQmE6vU3geJcXexbNI53bAj4kB83RkuBK6MB?=
 =?us-ascii?Q?tRIRfQtHVkbWdE5b5wVIBzE4YfBDr/0XCAglEUl7RQXP2M8GJoCcFl/XUf4D?=
 =?us-ascii?Q?eWoeTL3AiKy4mBRpkwem4iWPXy47wYD64v/KaGaHYStJf1ufR3og51vPArjn?=
 =?us-ascii?Q?1hldBnxj3K3iNSjnfESHYRe0ew1dMILX7JoAUOnNhx4GQQ2xDTUo64IZ9mUB?=
 =?us-ascii?Q?9O0DJ8+aq0sYHuOzZ5t0U0io506d+DAoRbjyQrGQcD9aKRQj8YrunHhLRxU5?=
 =?us-ascii?Q?Mx9lWBc+fWMfx2DI/vriQmY68m9HnSuNIxaICshMQdsS6LEw2diMxZyVd/9R?=
 =?us-ascii?Q?UdHTwCwbEN2d+L7YZHhBFMQyIAxmE+grhBTg6xf/KYqFHJq7N4+WgN+TujBb?=
 =?us-ascii?Q?MD5MxuJ3f1yYQjcvvBRVrG8pjZ2WISZWQ2TGTliqgi146ZWykrcTk7ku6Rpn?=
 =?us-ascii?Q?vvY59Ndb2D+KS4/4i37HH/qQZC86LJT8pULn0IrgIPvZozHraRUESweOR8lk?=
 =?us-ascii?Q?5WXE1qOCj347jQuPirEjJg/wnZ+lkWrKjxH+6PF2k0GceODStYqnttaERSP1?=
 =?us-ascii?Q?Sn/7Eh3+KHwuWhrMD1XelDP7wrTVl1DwCvyVunhJdUqzGG7ldc3StO60Er26?=
 =?us-ascii?Q?Sa2MWyn9QxLCvKBe4wHHJ+l8qTy3g3fzOAyn/BrxdTWzUoYghXD6bOyingtQ?=
 =?us-ascii?Q?WdQ46c7JRXfb3u6ocKc9rdbhlDOI/TxZVtmjrDEoV/KWTp+viZqurwZZV952?=
 =?us-ascii?Q?z5kNG00KZHJZu69S6fjvelilx1cbmUyTsMGKb+XD8VWlUqGXbwcDbiS/YcQX?=
 =?us-ascii?Q?e23h1K9okaEYsoEH+1DTJTNz2dtOKkPrR/qZ9RJM5wUpVl8noci7d6rnMu1v?=
 =?us-ascii?Q?t9W3JxXOlCO6a7kZBeDMXi9z+VNwVS1vc/vwrSOsWgLNFXJRlM6t2eMf2PgP?=
 =?us-ascii?Q?EcVyJjG89S8Df6nF6PTxGGs7HSSM6qjfxT/5qGfBv1UWUcx8QoSVmzeh2FlA?=
 =?us-ascii?Q?+PoH15TCTzMmE9Jt3dglFs+vjNm8lZPvfBeyMJu8oOT5W4aXrXvhy6y+wSFK?=
 =?us-ascii?Q?gtFV8+jTxywRfAYsuqqSCKb9njilk8ZrPnF+5iy+lNfOycFOtH4V58keNvvo?=
 =?us-ascii?Q?xt9NP3A7g1NHPCMssllgOMA4PUhkEDm2uKf0W7P0nrw9wzWFA/KXjb/m5M6/?=
 =?us-ascii?Q?XgtuidECi8RMUDfa8qIb6LdPYerGhBQswpLkE9/aa4otDJMU+pehPEHerku0?=
 =?us-ascii?Q?pQFpWD/rdWSpDDkOw9FpJiqREvZJc48=3D?=
X-Exchange-RoutingPolicyChecked: HfXQviUe0A/Y8TWR1d4dREOk/EcERMDxhGtnJo27o5HIhgY3zDIjcaE/gsgXpBbCkFD2dm1M4lHOJeMCu1O8JbXNAySphC8rnW3ek7xhlGOr0q4R9QeY0RsiO2v+qBRf9ZzfUu7h2YkyHNOUUQordbpH+jeSRg/N0f1kMbyMdfbc/kyZltJfuBtX25MP9uyDe3BgqZRSYEG+PxSzSI2L3Ys4/CZaHY4MI/PaRPbRez/82YgQ1n7USQ6t6udATwxFdLuQ2TPXoXkPwDvgsMwWihcdrOv+sTfn/x2Zmx5178OgiHFHXMhimKmSDmu/4qzzWEV5w4agyKZxx7NBUrkhuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab18aac-3399-4583-90d1-08df36616853
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:40:10.1112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOlLjNGDwaCgqeeNhchJeVyucZpDwW4sQtXIYvzq9IcvSJ2MEm1sanRDNRQB5LD8q0aX0zOCUf7Gtf7lGSVyL+ACwcxJr3dSbiD8oBqiL9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6762
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Initial, empty XE_LPD register list for Video-Enhance class was
introduced in [1] until [2] filled it out with debug SFC_DONE
entries, but it was never explained in any of those commits why
using those registers for VECS class specifically was chosen.
Furthermore, in current testing it leads to failures [3], as
gem_exec_capture@capture@vecs0-smem runs report partial captures
on DG1, DG2 and MTL [4].

SFC_DONE resides in the VD forcewake domain and is available
only when the corresponding VCS engine is present (explanation
from [5]), but XE_LP capture table currently associates these
registers with VIDEOENHANCE. Move them to the VIDEO class so GuC
requests them for the class tied to VCS availability.

[1] commit 24492514ccbd
    ("drm/i915/guc: Update GuC ADS size for error capture lists")
[2] commit 8b72c21618de
    ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
[3] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16904
[4] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=igt@gem_exec_capture@capture@vecs0-smem
[5] commit 24d032e2359e
    ("drm/i915: Only access SFC_DONE when media domain is not fused off")

Fixes: 8b72c21618de ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
I could not verify when exactly the issue started happening,
because:
A) all recent reports are red on DG1, DG2 and MTL,
B) checking for "partial-capture" in IGT [6] was introduced way
   later than the driver code asking for SFC_DONE registers.
I assume it has been present for at least a few months, if not
from the very beginning.

From empirical experiments, I was able to identify the classes
that report "partial-capture" during the test: VIDEOENHANCE and
BLITTER, while RENDER_COMPUTE, VIDEO and GSC_OTHER report
"full-capture" for SFC_DONE registers. I simply changed the
class of xe_lp_vec_class_regs inside
"static const struct __guc_mmio_reg_descr_group xe_lp_lists[]"
and ran the complete "capture" subtest mentioned above, so this
change should not (fingers crossed) explode anything.

[6] commit 93d3b0e28d7d
    ("tests/intel/gem_exec_capture: Check for partial register captures")
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
index 865b61057566d..bbf5188ae46cd 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
@@ -187,9 +187,9 @@ static const struct __guc_mmio_reg_descr_group xe_lp_lists[] = {
 	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
 	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
 	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
-	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEO),
+	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEO),
 	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEO),
-	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
+	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
 	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
 	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_BLITTER),
 	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_BLITTER),
-- 
2.34.1

