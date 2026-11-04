Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC3606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Irs9ztfe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D2A10FB55;
	Wed,  4 Nov 2026 11:11:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE44410FB55;
 Wed,  4 Nov 2026 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790699; x=1825326699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5l5+km03jZ8rnsqmcn/0V5gdGxspQsqMTyJUil383jQ=;
 b=Irs9ztfecZmBxN/NMYZJleFU9Zk/oTjA3fF5RuO69ZXy/cXfS0DTjii/
 DLmA5I52xajHHyV3ClFx0ywrXCIq4aNw4ZhbcdWQgYJXO/zVPU8QKBDG6
 eU9FpJC8SFwjKGjxjhQVTT5YSCMH/LrKec4g8bPpXT8kpsdsHQC5NdjRg
 Uog4M9oZIUJj62L9eob+DrFrDy+RiaTQpg/p4q8iRKF4Vd1Owy24HyQL7
 MBDntmpV/VL3FvI95h4OaS0PzFHq2iOSnBCnJGYdboATGT98k9TB07iut
 D4AqgAouRfF93oepvmTNybLxlAeo3sL4sFrac2hXLVC6852VTh2gAonXq g==;
X-CSE-ConnectionGUID: wCfmUEeBSV64KsYtwJsoXw==
X-CSE-MsgGUID: nrs+y/y6SDOMKgFlIVkvrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553588"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2553588"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:32 -0800
X-CSE-ConnectionGUID: s4uYIzW9RbW99DglBWSKqw==
X-CSE-MsgGUID: hntJVW4WSlm9lIBXKxYkiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6546267"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:11:23 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ognxLULamohFUqBU6/nMqw/jyvbMA70pi0N4Gmc2aasGo+i8YLep5RxZQp3LzNhGw0lMpMawQrJZgXZID50CXcMDLvg5EZRTzc8ICUTivHBh1ljLuAhvZpuBQ+i2K31ycTMTq1Gkp325kH/3U9z7N5JlbYlq1ytxIbYGFDxqRax3w/Rfzqv94sUTCSeCxwXmMcSk3JKAFa7LJRdX6/CizEiRdR6BsyCCFLjqJ0uUQdExPmJulU0+aSmYVk51QPwwg1J5yolRZjcIg8yp79DIJnzkY67z0Ole2mmnEvhih6qgElzprCLlDnFDOX6VoC+YJiLSXr5j6IWgvdGrki1Tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fITWepEG9F63/SsGqHytAfegNu4QdUQ6UkdXFwxN9j8=;
 b=C3ta4knlJf0TW8tGb8sBp4RC0AqyBKQSgvxTOFR44rI3nVElsXYdYyCClfJk3SCgDnpRypHlNU9hRRsBe7m8icqDUFSArVA9/gCYiIWEVPfxzCJVYWJr/tjRUv9Y8EWQLYoaptOxONKpGQhNLfNF9prS7ai+GB2/GNf3KrSIaIp/GIEvTZMBOKCXA2S89auwmzZZOK8X84ocWFzTnFDzTe6pHpBarIMIXfQwZAbyuuPRAakWtmMzcSTPxPVxwzVpfz/bNr5GUYMhdr8Hi/ALslG+LIMQx8aSorBrxM9TDk5F5AnKfkDvqzKgq4N/vuE5PdLylm4AmSH6J3BiMYbf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7892.namprd11.prod.outlook.com
 (2603:10b6:208:3fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:11:20 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:11:19 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v6 1/6] drm/i915/selftests: Use gt_*/drm_* prints in core
 selftests
Date: Wed, 4 Nov 2026 11:10:59 +0000
Message-ID: <20261104111104.946617-2-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104111104.946617-1-krzysztof.karas@intel.com>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|IA1PR11MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 92335cd6-0274-4ae7-43b1-08df3a645a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261022105027099003|261022115727099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261102123227099003|11063799006|10067099003|22082099003|56012099006|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jlWsmlbBtXe7m5xfJYgZi76WHMyN4e/1/RTUCWzeqNGjXv84NHJArNAeWRz6lVw9FcZ+VXEBthBLs9bRxkEpz8d1i+OU78XE/KI4b3cFiIsMoAhyCDCbVfOvBGOo6THHUBHGi6AJDG8if4wwnykYF2Vf5zjkaMyiO5RIuARUFy9iggqFvr1Ur+L08KELAS51wuG1P1ko9Ac3ICjuewIJpQ2CaOflnka65nf2xNFUScQg/TkRgRCs7taKOmjhWe0pPd0l5uleHRB9TqWWBtZq7I8uNXyrNlmH+rsX6cNaC55w1s+eEydGg/Bk0YxVFmoXRgp20CgtBgFm190A720JIPXvhYY9BOM36yUfw9Jnq/ycEupxXFmIv2FXGjHEXknUMfq7IZlp1BERlBqFM4Rt/qJnmqf0ogbD0qFUmdbBgdHqM4D5MDKNRDFi2VAt0NRakkFtcgDfT4h+q3jyr7YFfpM1RZkBYHUtiTI9n0klwaSbYGhjnQ+QOw/aDgbS7u5C4srwVw3F9uBElRz9IMUtmmcWehVx6L/sgvHg13YgN0O7GgI5J60q2nWouIZjKr7fyHTuBJGa8qh0xNGLhHRukSFh8px+v/y65boKB49tl0PkgyHtIGonW+T1rAG8HFMKIUIMCjiZOwRpXHfPfGy9KGODDE7c6b5BO/J/4zxcGmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261022105027099003)(261022115727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261102123227099003)(11063799006)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+Xa13qJRn5oJFvWhPvfA3pK9dt71B//aV5OZbEIq+XL1Y0P6qG2dbBr8PjY?=
 =?us-ascii?Q?6haHBjQEx9LO7std+GAET8F66eEj3sWeMna8dpaMljbAxVJaIa55OgAdcaVn?=
 =?us-ascii?Q?29QpScnuJUsEH7vuUGC/WSK6/r6axOoe40bEJjOWULQLW0Na4Yn0Bnaiana2?=
 =?us-ascii?Q?lKGIlwRVlRmQ2ODgbOj8+Q7YMsU3fQAp8ku6dgwWi0LH8TfhSw3xn65bv2z/?=
 =?us-ascii?Q?JcUuBlrL7q3WKnm5AyCph1qz7PdYLBUBWsK21K+7cffMOYxEmhy20G7Y5cx+?=
 =?us-ascii?Q?Xtd8H0yUB0uQBTq/9E5qbYWxoqJZG4zl+mXF3b2ogjrusaNwM/ZbyQ7tOu4I?=
 =?us-ascii?Q?gv6ypPm+e0x1KsGIVYhOe/aVp7bFDeY+ihRwJ9rnAylN8rsR2fNMUvPmdjyT?=
 =?us-ascii?Q?zpe6xyMGdv/w9r0dtN7sN0t4atYNlCgtE4kXjB++N5GlKw9zkLIvmyT89eGT?=
 =?us-ascii?Q?dF5Pae1YZMMjPB7ufSw48cl5mp8uMXZxxJcUyW9P6KdWj/DiLSqaxWHnX+Sr?=
 =?us-ascii?Q?KIKi4j/ChK/cwhwkOmoIIJ8ql8SHy6c2RTpORYoEAh3ORWPggAgBFQTCB5Pz?=
 =?us-ascii?Q?BzmUDt4kP1/uv+jZDOhArdb8Srt+fTAjoANzJMk6DAt0ULyiY4QzPvLJtrO7?=
 =?us-ascii?Q?uKrTsowqOG8wM2ONCnvql8kFwcrqcD6VCjtyxWnFUa0GiLmhsRMhI15T8hZn?=
 =?us-ascii?Q?dNJ3q4lpGifJpmkCQ3q4oXS1q3ox7PtFEyVgkh17SSWAyf2lQ++aipw8KW9X?=
 =?us-ascii?Q?QYzL+QYSbVNWAmZDth9mp0o7A76MXhEDwULdlLUQHaJrPUXUlZJSf5anjlep?=
 =?us-ascii?Q?m2zLuFuPlyZ4UImkfpRT60FgavVJg/v+QO55PB8LGXDz32RGndvZY8G4/5/w?=
 =?us-ascii?Q?xePWy1bmyl1zrjebd7OH1SYmhikdX49RXZYTDRH5cqtebyG6++x75yl5+0O4?=
 =?us-ascii?Q?3hupXfQghgDNA6K62+TYkjzGB5GIliWfCM4QQBjUuPGfjMvksVc4reW3bTIM?=
 =?us-ascii?Q?AIw7QVVffYuw+ZX6x/Qp72CN2aAH7UT8XTVxADrzuc+ZKx+tybkh782faRtx?=
 =?us-ascii?Q?gNH3wUfAGt2iqSpxqona0XbRznKT+u0QTFOSUjcScsaANZ4G1uY4SPP9F9My?=
 =?us-ascii?Q?9f4/VR5Yb3Ag9u053PxkgOM59+C/Pe/fBM0JEnzJpdgIkB55chO/hFusKKsz?=
 =?us-ascii?Q?ZBCN6QNJV0g235Tef3HTZJV0l5CFW2ujkWlH6+Ozq9Ql1kh1Wcsa8oe/DkV9?=
 =?us-ascii?Q?juKKA4jaKoOiiX2jcsDFptJd6OHYNKNHQ3obd7nmSO5g2li5TORDPMx8nmGY?=
 =?us-ascii?Q?5qCQ6P6e0dWtl+NWBq6joOJ+VvLSqwSrDSfG4JGcvBEPWg4RmtbrYXwVnex8?=
 =?us-ascii?Q?K/+jwojqMzZHiaVjyiK9Wiz2UWtTu/1miX6o0O41ePGc3u3EFf6hVo0bJnbH?=
 =?us-ascii?Q?yJvXppptlYyVnOQLoU5IRjEW6qlZ8oiSrL75oukLyLdwSNacqXF4iTehgq8g?=
 =?us-ascii?Q?zBHdu9reTv5VA+WvcbD/FvpepVZTpxbVzrRAVVOXWBCZkpZrsXPavN4Ajwzc?=
 =?us-ascii?Q?0lp8uyOqBibTrt8TO4TI2Lemckh9hiLqc9X9jTJrior6FzlLzGUkelxah67x?=
 =?us-ascii?Q?TK2CHPOb3wdFg976VOYTpeUC8/vtM2rmU+Tiwdcocl3lqILCKJYwo64u8lLV?=
 =?us-ascii?Q?aJ2S4QveIR3vc1SegCUvKOBrIo2yD5DYicSc1UFAfIrof6h2eUgCLwjMoONn?=
 =?us-ascii?Q?nOgPxc3ZEtoFqTYL/8a6DUSbPwaatt4=3D?=
X-Exchange-RoutingPolicyChecked: tBq3unbbQTpFAb94876fGNhZyx3mvL7Zvta3ANv//d3yhvokrXgWrZP7U6qkYEC9LjdqvFLNOeiU/o1SvxV91karvOxWJ7h9wwkPWY/a+Hwltk8j5vCu9Hy/Ytpj/lpOLpaTTf3lEYGkHcMbSUAKW+47X1j9w1/PPJrvr6MjmJUf4hEW+5Oj6u49Jmh0zs16E+eGW6UZ3gt8jUKyvAs3yy6KqKEezVxs5f7ln47M0xroBxz1rRr88VDsCXAU4QuS8e4jSlEs+oufRKTxgMneFR663WCTO40q+LTC90LyN9psM7R7mqkfeOdZ9vWHJR6d4Hpy6iAUQ5R+kd4ymS1lxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92335cd6-0274-4ae7-43b1-08df3a645a2c
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:11:19.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CimKugtiF573nqEd0wqAjBmUc7pHJ/iNsafWQhFL1x9scRRcWxYK1QvD8eCbAyT0V+0LevcKFSQeyoON2Bysl2lOjTRUHwHBj7WWIz+F13Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7892
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

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with device and the tile it came from.

i915_perf.c now uses drm_* prints, as it reports on a device
wide perf stream with no GT to attribute the message to.

Ensure that 80 character line limit is respected wherever
possible.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 +++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 +++++++++-----
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
 drivers/gpu/drm/i915/selftests/i915_request.c | 208 ++++++++++++------
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 184 +++++++++++-----
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
 6 files changed, 432 insertions(+), 230 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 718cddde7e73..b399a1b18906 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -71,11 +71,13 @@ static int populate_ggtt(struct i915_ggtt *ggtt, struct list_head *objects)
 		quirk_add(obj, objects);
 		count++;
 	} while (1);
-	pr_debug("Filled GGTT with %lu pages [%llu total]\n",
-		 count, ggtt->vm.total / PAGE_SIZE);
+	gt_dbg(ggtt->vm.gt,
+	       "Filled GGTT with %lu pages [%llu total]\n", count,
+	       ggtt->vm.total / PAGE_SIZE);
 
 	if (list_empty(&ggtt->vm.bound_list)) {
-		pr_err("No objects on the GGTT inactive list!\n");
+		gt_err(ggtt->vm.gt,
+		       "No objects on the GGTT inactive list!\n");
 		return -EINVAL;
 	}
 
@@ -125,8 +127,9 @@ static int igt_evict_something(void *arg)
 				       0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err != -ENOSPC) {
-		pr_err("i915_gem_evict_something failed on a full GGTT with err=%d\n",
-		       err);
+		gt_err(gt,
+		       "i915_gem_evict_something failed on a full GGTT with err=%d\n",
+			err);
 		goto cleanup;
 	}
 
@@ -140,7 +143,8 @@ static int igt_evict_something(void *arg)
 				       0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_something failed on a full GGTT with err=%d\n",
+		gt_err(gt,
+		       "i915_gem_evict_something failed on a full GGTT with err=%d\n",
 		       err);
 		goto cleanup;
 	}
@@ -177,7 +181,9 @@ static int igt_overcommit(void *arg)
 
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0, 0);
 	if (vma != ERR_PTR(-ENOSPC)) {
-		pr_err("Failed to evict+insert, i915_gem_object_ggtt_pin returned err=%d\n", (int)PTR_ERR_OR_ZERO(vma));
+		gt_err(gt,
+		       "Failed to evict+insert, i915_gem_object_ggtt_pin returned err=%d\n",
+		       (int)PTR_ERR_OR_ZERO(vma));
 		err = -EINVAL;
 		goto cleanup;
 	}
@@ -209,7 +215,8 @@ static int igt_evict_for_vma(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err != -ENOSPC) {
-		pr_err("i915_gem_evict_for_node on a full GGTT returned err=%d\n",
+		gt_err(gt,
+		       "i915_gem_evict_for_node on a full GGTT returned err=%d\n",
 		       err);
 		goto cleanup;
 	}
@@ -221,8 +228,7 @@ static int igt_evict_for_vma(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_for_node returned err=%d\n",
-		       err);
+		gt_err(gt, "i915_gem_evict_for_node returned err=%d\n", err);
 		goto cleanup;
 	}
 
@@ -273,7 +279,7 @@ static int igt_evict_for_cache_color(void *arg)
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
 				       I915_GTT_PAGE_SIZE | flags);
 	if (IS_ERR(vma)) {
-		pr_err("[0]i915_gem_object_ggtt_pin failed\n");
+		gt_err(gt, "[0]i915_gem_object_ggtt_pin failed\n");
 		err = PTR_ERR(vma);
 		goto cleanup;
 	}
@@ -290,7 +296,7 @@ static int igt_evict_for_cache_color(void *arg)
 	vma = i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
 				       (I915_GTT_PAGE_SIZE * 2) | flags);
 	if (IS_ERR(vma)) {
-		pr_err("[1]i915_gem_object_ggtt_pin failed\n");
+		gt_err(gt, "[1]i915_gem_object_ggtt_pin failed\n");
 		err = PTR_ERR(vma);
 		goto cleanup;
 	}
@@ -302,7 +308,8 @@ static int igt_evict_for_cache_color(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("[0]i915_gem_evict_for_node returned err=%d\n", err);
+		gt_err(gt,
+		       "[0]i915_gem_evict_for_node returned err=%d\n", err);
 		goto cleanup;
 	}
 
@@ -315,7 +322,8 @@ static int igt_evict_for_cache_color(void *arg)
 	err = i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (!err) {
-		pr_err("[1]i915_gem_evict_for_node returned err=%d\n", err);
+		gt_err(gt,
+		       "[1]i915_gem_evict_for_node returned err=%d\n", err);
 		err = -EINVAL;
 		goto cleanup;
 	}
@@ -348,7 +356,8 @@ static int igt_evict_vm(void *arg)
 	err = i915_gem_evict_vm(&ggtt->vm, NULL, NULL);
 	mutex_unlock(&ggtt->vm.mutex);
 	if (err) {
-		pr_err("i915_gem_evict_vm on a full GGTT returned err=%d]\n",
+		gt_err(gt,
+		       "i915_gem_evict_vm on a full GGTT returned err=%d]\n",
 		       err);
 		goto cleanup;
 	}
@@ -362,7 +371,8 @@ static int igt_evict_vm(void *arg)
 	}
 
 	if (err) {
-		pr_err("i915_gem_evict_vm on a full GGTT returned err=%d]\n",
+		gt_err(gt,
+		       "i915_gem_evict_vm on a full GGTT returned err=%d]\n",
 		       err);
 		goto cleanup;
 	}
@@ -443,7 +453,7 @@ static int igt_evict_contexts(void *arg)
 	} while (1);
 	drm_mm_remove_node(&hole);
 	mutex_unlock(&ggtt->vm.mutex);
-	pr_info("Filled GGTT with %lu 1MiB nodes\n", count);
+	gt_info(gt, "Filled GGTT with %lu 1MiB nodes\n", count);
 
 	/* Overfill the GGTT with context objects and so try to evict one. */
 	for_each_engine(engine, gt, id) {
@@ -469,7 +479,8 @@ static int igt_evict_contexts(void *arg)
 			if (IS_ERR(rq)) {
 				/* When full, fail_if_busy will trigger EBUSY */
 				if (PTR_ERR(rq) != -EBUSY) {
-					pr_err("Unexpected error from request alloc (on %s): %d\n",
+					gt_err(gt,
+					       "Unexpected error from request alloc (on %s): %d\n",
 					       engine->name,
 					       (int)PTR_ERR(rq));
 					err = PTR_ERR(rq);
@@ -492,7 +503,7 @@ static int igt_evict_contexts(void *arg)
 			err = 0;
 		} while(1);
 		onstack_fence_fini(&fence);
-		pr_info("Submitted %lu contexts/requests on %s\n",
+		gt_info(gt, "Submitted %lu contexts/requests on %s\n",
 			count, engine->name);
 		if (err)
 			break;
@@ -500,7 +511,8 @@ static int igt_evict_contexts(void *arg)
 			if (i915_request_wait(last, 0, HZ) < 0) {
 				err = -EIO;
 				i915_request_put(last);
-				pr_err("Failed waiting for last request (on %s)",
+				gt_err(gt,
+				       "Failed waiting for last request (on %s)\n",
 				       engine->name);
 				break;
 			}
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index e6bd06774816..0505937b78cd 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -32,8 +32,10 @@
 #include "gem/selftests/mock_context.h"
 #include "gt/intel_context.h"
 #include "gt/intel_gpu_commands.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_gtt.h"
 
+#include "i915_drv.h"
 #include "i915_random.h"
 #include "i915_selftest.h"
 #include "i915_vma_resource.h"
@@ -268,8 +270,10 @@ static int lowlevel_hole(struct i915_address_space *vm,
 			hole_size = KMALLOC_MAX_SIZE / sizeof(u32);
 		count = hole_size >> 1;
 		if (!count) {
-			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
-				 __func__, hole_start, hole_end, size, hole_size);
+			gt_dbg(vm->gt,
+			       "%s: hole is too small [%llx - %llx] >> %d: %lld\n",
+			       __func__, hole_start, hole_end, size,
+			       hole_size);
 			break;
 		}
 
@@ -472,15 +476,21 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
-						       __func__, p->name, err, npages, prime, offset);
+						gt_err(vm->gt,
+						       "%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+						       __func__, p->name, err,
+						       npages, prime, offset);
 						goto err;
 					}
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (forward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
+						gt_err(vm->gt,
+						       "%s(%s) (forward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+						       __func__, p->name,
+						       vma->node.start,
+						       vma->node.size,
+						       drm_mm_node_allocated(&vma->node),
 						       offset);
 						err = -EINVAL;
 						goto err;
@@ -512,18 +522,22 @@ static int fill_hole(struct i915_address_space *vm,
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (forward) moved vma.node=%llx + %llx, expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       offset);
+						gt_err(vm->gt,
+						       "%s(%s) (forward) moved vma.node=%llx + %llx, expected offset %llx\n",
+						       __func__, p->name,
+						       vma->node.start,
+						       vma->node.size, offset);
 						err = -EINVAL;
 						goto err;
 					}
 
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("%s(%s) (forward) unbind of vma.node=%llx + %llx failed with err=%d\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       err);
+						gt_err(vm->gt,
+						       "%s(%s) (forward) unbind of vma.node=%llx + %llx failed with err=%d\n",
+						       __func__, p->name,
+						       vma->node.start,
+						       vma->node.size, err);
 						goto err;
 					}
 
@@ -551,15 +565,21 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
-						       __func__, p->name, err, npages, prime, offset);
+						gt_err(vm->gt,
+						       "%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+						       __func__, p->name, err,
+						       npages, prime, offset);
 						goto err;
 					}
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (backward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
+						gt_err(vm->gt,
+						       "%s(%s) (backward) insert failed: vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+						       __func__, p->name,
+						       vma->node.start,
+						       vma->node.size,
+						       drm_mm_node_allocated(&vma->node),
 						       offset);
 						err = -EINVAL;
 						goto err;
@@ -591,8 +611,12 @@ static int fill_hole(struct i915_address_space *vm,
 
 					if (!drm_mm_node_allocated(&vma->node) ||
 					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
-						pr_err("%s(%s) (backward) moved vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
-						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_node_allocated(&vma->node),
+						gt_err(vm->gt,
+						       "%s(%s) (backward) moved vma.node=%llx + %llx [allocated? %d], expected offset %llx\n",
+						       __func__, p->name,
+						       vma->node.start,
+						       vma->node.size,
+						       drm_mm_node_allocated(&vma->node),
 						       offset);
 						err = -EINVAL;
 						goto err;
@@ -600,9 +624,11 @@ static int fill_hole(struct i915_address_space *vm,
 
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("%s(%s) (backward) unbind of vma.node=%llx + %llx failed with err=%d\n",
-						       __func__, p->name, vma->node.start, vma->node.size,
-						       err);
+						gt_err(vm->gt,
+						       "%s(%s) (backward) unbind of vma.node=%llx + %llx failed with err=%d\n",
+						       __func__, p->name,
+						       vma->node.start,
+						       vma->node.size, err);
 						goto err;
 					}
 
@@ -672,16 +698,18 @@ static int walk_hole(struct i915_address_space *vm,
 		     addr += round_up(obj->base.size, min_alignment)) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s bind failed at %llx + %llx [hole %llx- %llx] with err=%d\n",
-				       __func__, addr, vma->size,
-				       hole_start, hole_end, err);
+				gt_err(vm->gt,
+				       "%s bind failed at %llx + %llx [hole %llx- %llx] with err=%d\n",
+				       __func__, addr, vma->size, hole_start,
+				       hole_end, err);
 				goto err_put;
 			}
 			i915_vma_unpin(vma);
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
+				gt_err(vm->gt,
+				       "%s incorrect at %llx + %llx\n",
 				       __func__, addr, vma->size);
 				err = -EINVAL;
 				goto err_put;
@@ -689,7 +717,8 @@ static int walk_hole(struct i915_address_space *vm,
 
 			err = i915_vma_unbind_unlocked(vma);
 			if (err) {
-				pr_err("%s unbind failed at %llx + %llx  with err=%d\n",
+				gt_err(vm->gt,
+				       "%s unbind failed at %llx + %llx  with err=%d\n",
 				       __func__, addr, vma->size, err);
 				goto err_put;
 			}
@@ -754,7 +783,8 @@ static int pot_hole(struct i915_address_space *vm,
 		     addr += step) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s failed to pin object at %llx in hole [%llx - %llx], with err=%d\n",
+				gt_err(vm->gt,
+				       "%s failed to pin object at %llx in hole [%llx - %llx], with err=%d\n",
 				       __func__,
 				       addr,
 				       hole_start, hole_end,
@@ -764,7 +794,8 @@ static int pot_hole(struct i915_address_space *vm,
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
+				gt_err(vm->gt,
+				       "%s incorrect at %llx + %llx\n",
 				       __func__, addr, vma->size);
 				i915_vma_unpin(vma);
 				err = i915_vma_unbind_unlocked(vma);
@@ -819,8 +850,10 @@ static int drunk_hole(struct i915_address_space *vm,
 			hole_size = KMALLOC_MAX_SIZE / sizeof(u32);
 		count = hole_size >> 1;
 		if (!count) {
-			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
-				 __func__, hole_start, hole_end, size, hole_size);
+			gt_dbg(vm->gt,
+			       "%s: hole is too small [%llx - %llx] >> %d: %lld\n",
+			       __func__, hole_start, hole_end, size,
+			       hole_size);
 			break;
 		}
 
@@ -859,7 +892,8 @@ static int drunk_hole(struct i915_address_space *vm,
 
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-				pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
+				gt_err(vm->gt,
+				       "%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
 				       __func__,
 				       addr, BIT_ULL(size),
 				       hole_start, hole_end,
@@ -869,7 +903,8 @@ static int drunk_hole(struct i915_address_space *vm,
 
 			if (!drm_mm_node_allocated(&vma->node) ||
 			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-				pr_err("%s incorrect at %llx + %llx\n",
+				gt_err(vm->gt,
+				       "%s incorrect at %llx + %llx\n",
 				       __func__, addr, BIT_ULL(size));
 				i915_vma_unpin(vma);
 				err = i915_vma_unbind_unlocked(vma);
@@ -939,14 +974,16 @@ static int __shrink_hole(struct i915_address_space *vm,
 
 		err = i915_vma_pin(vma, 0, 0, addr | flags);
 		if (err) {
-			pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
-			       __func__, addr, size, hole_start, hole_end, err);
+			gt_err(vm->gt,
+			       "%s failed to pin object at %llx + %llx in hole [%llx - %llx], with err=%d\n",
+			       __func__, addr, size, hole_start, hole_end,
+			       err);
 			break;
 		}
 
 		if (!drm_mm_node_allocated(&vma->node) ||
 		    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
-			pr_err("%s incorrect at %llx + %llx\n",
+			gt_err(vm->gt, "%s incorrect at %llx + %llx\n",
 			       __func__, addr, size);
 			i915_vma_unpin(vma);
 			err = i915_vma_unbind_unlocked(vma);
@@ -1419,7 +1456,8 @@ static int igt_ggtt_page(void *arg)
 		io_mapping_unmap_atomic(vaddr);
 
 		if (val != n) {
-			pr_err("insert page failed: found %d, expected %d\n",
+			gt_err(ggtt->vm.gt,
+			       "insert page failed: found %d, expected %d\n",
 			       val, n);
 			err = -EINVAL;
 			break;
@@ -1578,7 +1616,8 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, total);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=%d\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=%d\n",
 			       total, ggtt->vm.total, err);
 			goto out;
 		}
@@ -1587,9 +1626,10 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       total, 2*I915_GTT_PAGE_SIZE);
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+			       vma->node.start, vma->node.size, total,
+			       2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1624,7 +1664,8 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, total);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=%d\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=%d\n",
 			       total, ggtt->vm.total, err);
 			goto out;
 		}
@@ -1633,9 +1674,10 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       total, 2*I915_GTT_PAGE_SIZE);
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+			       vma->node.start, vma->node.size, total,
+			       2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1654,7 +1696,8 @@ static int igt_gtt_reserve(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("i915_vma_unbind failed with err=%d!\n", err);
+			gt_err(ggtt->vm.gt,
+			       "i915_vma_unbind failed with err=%d!\n", err);
 			goto out;
 		}
 
@@ -1665,7 +1708,8 @@ static int igt_gtt_reserve(void *arg)
 
 		err = reserve_gtt_with_resource(vma, offset);
 		if (err) {
-			pr_err("i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=%d\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=%d\n",
 			       total, ggtt->vm.total, err);
 			goto out;
 		}
@@ -1674,9 +1718,10 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
-			       vma->node.start, vma->node.size,
-			       offset, 2*I915_GTT_PAGE_SIZE);
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
+			       vma->node.start, vma->node.size, offset,
+			       2 * I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1766,7 +1811,8 @@ static int igt_gtt_insert(void *arg)
 					  0);
 		mutex_unlock(&ggtt->vm.mutex);
 		if (err != -ENOSPC) {
-			pr_err("Invalid i915_gem_gtt_insert(.size=%llx, .alignment=%llx, .start=%llx, .end=%llx) succeeded (err=%d)\n",
+			gt_err(ggtt->vm.gt,
+			       "Invalid i915_gem_gtt_insert(.size=%llx, .alignment=%llx, .start=%llx, .end=%llx) succeeded (err=%d)\n",
 			       ii->size, ii->alignment, ii->start, ii->end,
 			       err);
 			return -EINVAL;
@@ -1807,7 +1853,8 @@ static int igt_gtt_insert(void *arg)
 			break;
 		}
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=%d\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=%d\n",
 			       total, ggtt->vm.total, err);
 			goto out;
 		}
@@ -1827,7 +1874,8 @@ static int igt_gtt_insert(void *arg)
 		}
 
 		if (!drm_mm_node_allocated(&vma->node)) {
-			pr_err("VMA was unexpectedly evicted!\n");
+			gt_err(ggtt->vm.gt,
+			       "VMA was unexpectedly evicted!\n");
 			err = -EINVAL;
 			goto out;
 		}
@@ -1851,13 +1899,15 @@ static int igt_gtt_insert(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("i915_vma_unbind failed with err=%d!\n", err);
+			gt_err(ggtt->vm.gt,
+			       "i915_vma_unbind failed with err=%d!\n", err);
 			goto out;
 		}
 
 		err = insert_gtt_with_resource(vma);
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=%d\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=%d\n",
 			       total, ggtt->vm.total, err);
 			goto out;
 		}
@@ -1865,7 +1915,8 @@ static int igt_gtt_insert(void *arg)
 
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset) {
-			pr_err("i915_gem_gtt_insert did not return node to its previous location (the only hole), expected address %llx, found %llx\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_insert did not return node to its previous location (the only hole), expected address %llx, found %llx\n",
 			       offset, vma->node.start);
 			err = -EINVAL;
 			goto out;
@@ -1901,7 +1952,8 @@ static int igt_gtt_insert(void *arg)
 
 		err = insert_gtt_with_resource(vma);
 		if (err) {
-			pr_err("i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=%d\n",
+			gt_err(ggtt->vm.gt,
+			       "i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=%d\n",
 			       total, ggtt->vm.total, err);
 			goto out;
 		}
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index e9469e27f42a..b4a75d82e6be 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -6,6 +6,8 @@
 
 #include <linux/kref.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_pm.h"
 #include "gt/intel_gt.h"
 
@@ -263,20 +265,22 @@ static int live_noa_delay(void *arg)
 	t1 = poll_status(rq, 0x102);
 	preempt_enable();
 
-	pr_info("CPU delay: %lluns, expected %lluns\n",
-		ktime_sub(t1, t0), expected);
+	drm_info(&i915->drm,
+		 "CPU delay: %lluns, expected %lluns\n", ktime_sub(t1, t0),
+		 expected);
 
 	delay = intel_read_status_page(stream->engine, 0x102);
 	delay -= intel_read_status_page(stream->engine, 0x100);
 	delay = intel_gt_clock_interval_to_ns(stream->engine->gt, delay);
-	pr_info("GPU delay: %uns, expected %lluns\n",
-		delay, expected);
+	drm_info(&i915->drm,
+		 "GPU delay: %uns, expected %lluns\n", delay, expected);
 
 	if (4 * delay < 3 * expected || 2 * delay > 3 * expected) {
-		pr_err("GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
-		       delay / 1000,
-		       div_u64(3 * expected, 4000),
-		       div_u64(3 * expected, 2000));
+		drm_err(&i915->drm,
+			"GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
+			delay / 1000,
+			div_u64(3 * expected, 4000),
+			div_u64(3 * expected, 2000));
 		err = -EINVAL;
 	}
 
@@ -385,7 +389,7 @@ static int live_noa_gpr(void *arg)
 	i915_request_add(rq);
 
 	if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE, HZ / 2) < 0) {
-		pr_err("noa_wait timed out\n");
+		drm_err(&i915->drm, "noa_wait timed out\n");
 		intel_gt_set_wedged(stream->engine->gt);
 		err = -EIO;
 		goto out_rq;
@@ -396,14 +400,16 @@ static int live_noa_gpr(void *arg)
 		if (store[i] == STACK_MAGIC)
 			continue;
 
-		pr_err("GPR[%d] lost, found:%08x, expected:%08x!\n",
-		       i, store[i], STACK_MAGIC);
+		drm_err(&i915->drm,
+			"GPR[%d] lost, found:%08x, expected:%08x!\n", i,
+			store[i], STACK_MAGIC);
 		err = -EINVAL;
 	}
 
 	/* Verify that the user's scratch page was not used for GPR storage */
 	if (memchr_inv(scratch, POISON_FREE, PAGE_SIZE)) {
-		pr_err("Scratch page overwritten!\n");
+		drm_err(&i915->drm,
+			"Scratch page overwritten!\n");
 		igt_hexdump(scratch, 4096);
 		err = -EINVAL;
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index e1a7c454a0a9..81c527221a6b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -26,8 +26,6 @@
 #include <linux/prime_numbers.h>
 #include <linux/sort.h>
 
-#include <drm/drm_print.h>
-
 #include "gem/i915_gem_internal.h"
 #include "gem/i915_gem_pm.h"
 #include "gem/selftests/mock_context.h"
@@ -36,6 +34,7 @@
 #include "gt/intel_engine_user.h"
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_clock_utils.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_gt_requests.h"
 #include "gt/selftest_engine_heartbeat.h"
 
@@ -98,49 +97,54 @@ static int igt_wait_request(void *arg)
 	i915_request_get(request);
 
 	if (i915_request_wait(request, 0, 0) != -ETIME) {
-		pr_err("request wait (busy query) succeeded (expected timeout before submit!)\n");
+		gt_err(to_gt(i915),
+		       "request wait (busy query) succeeded (expected timeout before submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) != -ETIME) {
-		pr_err("request wait succeeded (expected timeout before submit!)\n");
+		gt_err(to_gt(i915),
+		       "request wait succeeded (expected timeout before submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("request completed before submit!!\n");
+		gt_err(to_gt(i915), "request completed before submit!!\n");
 		goto out_request;
 	}
 
 	i915_request_add(request);
 
 	if (i915_request_wait(request, 0, 0) != -ETIME) {
-		pr_err("request wait (busy query) succeeded (expected timeout after submit!)\n");
+		gt_err(to_gt(i915),
+		       "request wait (busy query) succeeded (expected timeout after submit!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("request completed immediately!\n");
+		gt_err(to_gt(i915), "request completed immediately!\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T / 2) != -ETIME) {
-		pr_err("request wait succeeded (expected timeout!)\n");
+		gt_err(to_gt(i915),
+		       "request wait succeeded (expected timeout!)\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) == -ETIME) {
-		pr_err("request wait timed out!\n");
+		gt_err(to_gt(i915), "request wait timed out!\n");
 		goto out_request;
 	}
 
 	if (!i915_request_completed(request)) {
-		pr_err("request not complete after waiting!\n");
+		gt_err(to_gt(i915), "request not complete after waiting!\n");
 		goto out_request;
 	}
 
 	if (i915_request_wait(request, 0, T) == -ETIME) {
-		pr_err("request wait timed out when already complete!\n");
+		gt_err(to_gt(i915),
+		       "request wait timed out when already complete!\n");
 		goto out_request;
 	}
 
@@ -165,34 +169,38 @@ static int igt_fence_wait(void *arg)
 		return PTR_ERR(request);
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) != -ETIME) {
-		pr_err("fence wait success before submit (expected timeout)!\n");
+		gt_err(to_gt(i915),
+		       "fence wait success before submit (expected timeout)!\n");
 		goto out;
 	}
 
 	i915_request_add(request);
 
 	if (dma_fence_is_signaled(&request->fence)) {
-		pr_err("fence signaled immediately!\n");
+		gt_err(to_gt(i915), "fence signaled immediately!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T / 2) != -ETIME) {
-		pr_err("fence wait success after submit (expected timeout)!\n");
+		gt_err(to_gt(i915),
+		       "fence wait success after submit (expected timeout)!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) <= 0) {
-		pr_err("fence wait timed out (expected success)!\n");
+		gt_err(to_gt(i915),
+		       "fence wait timed out (expected success)!\n");
 		goto out;
 	}
 
 	if (!dma_fence_is_signaled(&request->fence)) {
-		pr_err("fence unsignaled after waiting!\n");
+		gt_err(to_gt(i915), "fence unsignaled after waiting!\n");
 		goto out;
 	}
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) <= 0) {
-		pr_err("fence wait timed out when complete (expected success)!\n");
+		gt_err(to_gt(i915),
+		       "fence wait timed out when complete (expected success)!\n");
 		goto out;
 	}
 
@@ -245,7 +253,8 @@ static int igt_request_rewind(void *arg)
 
 	/* Simulate preemption by manual reordering */
 	if (!mock_cancel_request(request)) {
-		pr_err("failed to cancel request (already executed)!\n");
+		gt_err(to_gt(i915),
+		       "failed to cancel request (already executed)!\n");
 		i915_request_add(vip);
 		goto err_context_1;
 	}
@@ -257,12 +266,13 @@ static int igt_request_rewind(void *arg)
 
 
 	if (i915_request_wait(vip, 0, HZ) == -ETIME) {
-		pr_err("timed out waiting for high priority request\n");
+		gt_err(to_gt(i915),
+		       "timed out waiting for high priority request\n");
 		goto err;
 	}
 
 	if (i915_request_completed(request)) {
-		pr_err("low priority request already completed\n");
+		gt_err(to_gt(i915), "low priority request already completed\n");
 		goto err;
 	}
 
@@ -313,6 +323,7 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 	struct smoke_thread *thread = container_of(work, typeof(*thread), work);
 	struct smoketest *t = thread->t;
 	const unsigned int max_batch = min(t->ncontexts, t->max_batch) - 1;
+	struct intel_gt *gt = t->engine->gt;
 	const unsigned int total = 4 * t->ncontexts + 1;
 	unsigned int num_waits = 0, num_fences = 0;
 	struct i915_request **requests;
@@ -406,7 +417,8 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 					5 * HZ)) {
 			struct i915_request *rq = requests[count - 1];
 
-			pr_err("waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
+			gt_err(gt,
+			       "waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
 			       atomic_read(&wait->pending), count,
 			       rq->fence.context, rq->fence.seqno,
 			       t->engine->name);
@@ -423,7 +435,8 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 
 			if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
 				      &rq->fence.flags)) {
-				pr_err("%llu:%llu was not signaled!\n",
+				gt_err(gt,
+				       "%llu:%llu was not signaled!\n",
 				       rq->fence.context, rq->fence.seqno);
 				err = -EINVAL;
 			}
@@ -523,7 +536,8 @@ static int mock_breadcrumbs_smoketest(void *arg)
 
 		kthread_destroy_worker(threads[n].worker);
 	}
-	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
+	gt_info(to_gt(i915),
+		"Completed %lu waits for %lu fence across %d cpus\n",
 		atomic_long_read(&t.num_waits),
 		atomic_long_read(&t.num_fences),
 		ncpus);
@@ -632,7 +646,8 @@ static int live_nop_request(void *arg)
 		if (err)
 			return err;
 
-		pr_info("Request latencies on %s: 1 = %lluns, %lu = %lluns\n",
+		gt_info(engine->gt,
+			"Request latencies on %s: 1 = %lluns, %lu = %lluns\n",
 			engine->name,
 			ktime_to_ns(times[0]),
 			prime, div64_u64(ktime_to_ns(times[1]), prime));
@@ -663,7 +678,8 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling inactive request\n", engine->name);
+	gt_dbg(engine->gt, "%s: Cancelling inactive request\n",
+	       engine->name);
 	i915_request_cancel(rq, -EINTR);
 	i915_request_get(rq);
 	i915_request_add(rq);
@@ -671,14 +687,16 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel inactive request\n", engine->name);
+		gt_err(engine->gt,
+		       "%s: Failed to cancel inactive request\n",
+		       engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
@@ -690,7 +708,8 @@ static int __cancel_inactive(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		gt_err(engine->gt, "%s: %s error %d\n", __func__,
+		       engine->name, err);
 	return err;
 }
 
@@ -716,13 +735,15 @@ static int __cancel_active(struct intel_engine_cs *engine)
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling active request\n", engine->name);
+	gt_dbg(engine->gt, "%s: Cancelling active request\n",
+	       engine->name);
 	i915_request_get(rq);
 	i915_request_add(rq);
 	if (!igt_wait_for_spinner(&spin, rq)) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		gt_err(engine->gt, "Failed to start spinner on %s\n",
+		       engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
@@ -732,14 +753,15 @@ static int __cancel_active(struct intel_engine_cs *engine)
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel active request\n", engine->name);
+		gt_err(engine->gt,
+		       "%s: Failed to cancel active request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
@@ -751,7 +773,8 @@ static int __cancel_active(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		gt_err(engine->gt, "%s: %s error %d\n", __func__,
+		       engine->name, err);
 	return err;
 }
 
@@ -785,10 +808,11 @@ static int __cancel_completed(struct intel_engine_cs *engine)
 		goto out_rq;
 	}
 
-	pr_debug("%s: Cancelling completed request\n", engine->name);
+	gt_dbg(engine->gt, "%s: Cancelling completed request\n",
+	       engine->name);
 	i915_request_cancel(rq, -EINTR);
 	if (rq->fence.error) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 	}
@@ -800,7 +824,8 @@ static int __cancel_completed(struct intel_engine_cs *engine)
 out_spin:
 	igt_spinner_fini(&spin);
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		gt_err(engine->gt, "%s: %s error %d\n", __func__,
+		       engine->name, err);
 	return err;
 }
 
@@ -846,14 +871,16 @@ static int __cancel_reset(struct drm_i915_private *i915,
 		goto out_ce;
 	}
 
-	pr_debug("%s: Cancelling active non-preemptable request\n",
-		 engine->name);
+	gt_dbg(engine->gt,
+	       "%s: Cancelling active non-preemptable request\n",
+	       engine->name);
 	i915_request_get(rq);
 	i915_request_add(rq);
 	if (!igt_wait_for_spinner(&spin, rq)) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		gt_err(engine->gt, "Failed to start spinner on %s\n",
+		       engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_rq;
@@ -870,14 +897,15 @@ static int __cancel_reset(struct drm_i915_private *i915,
 	if (i915_request_wait(rq, 0, HZ) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to cancel hung request\n", engine->name);
+		gt_err(engine->gt,
+		       "%s: Failed to cancel hung request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_nop;
 	}
 
 	if (rq->fence.error != -EINTR) {
-		pr_err("%s: fence not cancelled (%u)\n",
+		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
 		       engine->name, rq->fence.error);
 		err = -EINVAL;
 		goto out_nop;
@@ -886,14 +914,15 @@ static int __cancel_reset(struct drm_i915_private *i915,
 	if (i915_request_wait(nop, 0, HZ) < 0) {
 		struct drm_printer p = drm_info_printer(engine->i915->drm.dev);
 
-		pr_err("%s: Failed to complete nop request\n", engine->name);
+		gt_err(engine->gt,
+		       "%s: Failed to complete nop request\n", engine->name);
 		intel_engine_dump(engine, &p, "%s\n", engine->name);
 		err = -ETIME;
 		goto out_nop;
 	}
 
 	if (nop->fence.error != 0) {
-		pr_err("%s: Nop request errored (%u)\n",
+		gt_err(engine->gt, "%s: Nop request errored (%u)\n",
 		       engine->name, nop->fence.error);
 		err = -EINVAL;
 	}
@@ -909,7 +938,8 @@ static int __cancel_reset(struct drm_i915_private *i915,
 out_restore:
 	engine->props.preempt_timeout_ms = preempt_timeout_ms;
 	if (err)
-		pr_err("%s: %s error %d\n", __func__, engine->name, err);
+		gt_err(engine->gt, "%s: %s error %d\n", __func__,
+		       engine->name, err);
 	return err;
 }
 
@@ -1102,7 +1132,8 @@ static int live_empty_request(void *arg)
 		if (err)
 			goto out_batch;
 
-		pr_info("Batch latencies on %s: 1 = %lluns, %lu = %lluns\n",
+		gt_info(engine->gt,
+			"Batch latencies on %s: 1 = %lluns, %lu = %lluns\n",
 			engine->name,
 			ktime_to_ns(times[0]),
 			prime, div64_u64(ktime_to_ns(times[1]), prime));
@@ -1218,7 +1249,8 @@ static int live_all_engines(void *arg)
 		batch = recursive_batch(engine->gt);
 		if (IS_ERR(batch)) {
 			err = PTR_ERR(batch);
-			pr_err("%s: Unable to create batch, err=%d\n",
+			gt_err(engine->gt,
+			       "%s: Unable to create batch, err=%d\n",
 			       __func__, err);
 			goto out_free;
 		}
@@ -1227,7 +1259,8 @@ static int live_all_engines(void *arg)
 		request[idx] = intel_engine_create_kernel_request(engine);
 		if (IS_ERR(request[idx])) {
 			err = PTR_ERR(request[idx]);
-			pr_err("%s: Request allocation failed with err=%d\n",
+			gt_err(engine->gt,
+			       "%s: Request allocation failed with err=%d\n",
 			       __func__, err);
 			goto out_unlock;
 		}
@@ -1252,7 +1285,8 @@ static int live_all_engines(void *arg)
 	idx = 0;
 	for_each_uabi_engine(engine, i915) {
 		if (i915_request_completed(request[idx])) {
-			pr_err("%s(%s): request completed too early!\n",
+			gt_err(engine->gt,
+			       "%s(%s): request completed too early!\n",
 			       __func__, engine->name);
 			err = -EINVAL;
 			goto out_request;
@@ -1264,7 +1298,8 @@ static int live_all_engines(void *arg)
 	for_each_uabi_engine(engine, i915) {
 		err = recursive_batch_resolve(request[idx]->batch);
 		if (err) {
-			pr_err("%s: failed to resolve batch, err=%d\n",
+			gt_err(engine->gt,
+			       "%s: failed to resolve batch, err=%d\n",
 			       __func__, err);
 			goto out_request;
 		}
@@ -1280,7 +1315,8 @@ static int live_all_engines(void *arg)
 					    MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			err = timeout;
-			pr_err("%s: error waiting for request on %s, err=%d\n",
+			gt_err(engine->gt,
+			       "%s: error waiting for request on %s, err=%d\n",
 			       __func__, engine->name, err);
 			goto out_request;
 		}
@@ -1348,7 +1384,8 @@ static int live_sequential_engines(void *arg)
 		batch = recursive_batch(engine->gt);
 		if (IS_ERR(batch)) {
 			err = PTR_ERR(batch);
-			pr_err("%s: Unable to create batch for %s, err=%d\n",
+			gt_err(engine->gt,
+			       "%s: Unable to create batch for %s, err=%d\n",
 			       __func__, engine->name, err);
 			goto out_free;
 		}
@@ -1357,7 +1394,8 @@ static int live_sequential_engines(void *arg)
 		request[idx] = intel_engine_create_kernel_request(engine);
 		if (IS_ERR(request[idx])) {
 			err = PTR_ERR(request[idx]);
-			pr_err("%s: Request allocation failed for %s with err=%d\n",
+			gt_err(engine->gt,
+			       "%s: Request allocation failed for %s with err=%d\n",
 			       __func__, engine->name, err);
 			goto out_unlock;
 		}
@@ -1368,7 +1406,8 @@ static int live_sequential_engines(void *arg)
 							   &prev->fence);
 			if (err) {
 				i915_request_add(request[idx]);
-				pr_err("%s: Request await failed for %s with err=%d\n",
+				gt_err(engine->gt,
+				       "%s: Request await failed for %s with err=%d\n",
 				       __func__, engine->name, err);
 				goto out_unlock;
 			}
@@ -1398,7 +1437,8 @@ static int live_sequential_engines(void *arg)
 		long timeout;
 
 		if (i915_request_completed(request[idx])) {
-			pr_err("%s(%s): request completed too early!\n",
+			gt_err(engine->gt,
+			       "%s(%s): request completed too early!\n",
 			       __func__, engine->name);
 			err = -EINVAL;
 			goto out_request;
@@ -1406,7 +1446,8 @@ static int live_sequential_engines(void *arg)
 
 		err = recursive_batch_resolve(request[idx]->batch);
 		if (err) {
-			pr_err("%s: failed to resolve batch, err=%d\n",
+			gt_err(engine->gt,
+			       "%s: failed to resolve batch, err=%d\n",
 			       __func__, err);
 			goto out_request;
 		}
@@ -1415,7 +1456,8 @@ static int live_sequential_engines(void *arg)
 					    MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			err = timeout;
-			pr_err("%s: error waiting for request on %s, err=%d\n",
+			gt_err(engine->gt,
+			       "%s: error waiting for request on %s, err=%d\n",
 			       __func__, engine->name, err);
 			goto out_request;
 		}
@@ -1496,7 +1538,8 @@ static void __live_parallel_engine1(struct kthread_work *work)
 	} while (!__igt_timeout(end_time, NULL));
 	intel_engine_pm_put(engine);
 
-	pr_info("%s: %lu request + sync\n", engine->name, count);
+	gt_info(engine->gt, "%s: %lu request + sync\n", engine->name,
+		count);
 	thread->result = err;
 }
 
@@ -1525,7 +1568,7 @@ static void __live_parallel_engineN(struct kthread_work *work)
 	} while (!__igt_timeout(end_time, NULL));
 	intel_engine_pm_put(engine);
 
-	pr_info("%s: %lu requests\n", engine->name, count);
+	gt_info(engine->gt, "%s: %lu requests\n", engine->name, count);
 	thread->result = err;
 }
 
@@ -1592,7 +1635,8 @@ static void __live_parallel_spin(struct kthread_work *work)
 		/* Occupy this engine for the whole test */
 		err = wait_for_all(engine->i915);
 	} else {
-		pr_err("Failed to start spinner on %s\n", engine->name);
+		gt_err(engine->gt, "Failed to start spinner on %s\n",
+		       engine->name);
 		err = -EINVAL;
 	}
 	igt_spinner_end(&spin);
@@ -1798,8 +1842,8 @@ static int live_breadcrumbs_smoketest(void *arg)
 		}
 		/* One ring interleaved between requests from all cpus */
 		smoke[idx].max_batch /= ncpus + 1;
-		pr_debug("Limiting batches to %d requests on %s\n",
-			 smoke[idx].max_batch, engine->name);
+		gt_dbg(engine->gt, "Limiting batches to %d requests on %s\n",
+		       smoke[idx].max_batch, engine->name);
 
 		for (n = 0; n < ncpus; n++) {
 			unsigned int i = idx * ncpus + n;
@@ -1849,8 +1893,9 @@ static int live_breadcrumbs_smoketest(void *arg)
 		num_fences += atomic_long_read(&smoke[idx].num_fences);
 		idx++;
 	}
-	pr_info("Completed %lu waits for %lu fences across %d engines and %d cpus\n",
-		num_waits, num_fences, idx, ncpus);
+	drm_info(&i915->drm,
+		 "Completed %lu waits for %lu fences across %d engines and %d cpus\n",
+		 num_waits, num_fences, idx, ncpus);
 
 	ret = igt_live_test_end(&live) ?: ret;
 out_contexts:
@@ -2013,6 +2058,7 @@ static u32 hwsp_offset(const struct intel_context *ce, u32 *dw)
 
 static int measure_semaphore_response(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT], cycles;
@@ -2075,7 +2121,8 @@ static int measure_semaphore_response(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: semaphore response %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: semaphore response %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2088,6 +2135,7 @@ static int measure_semaphore_response(struct intel_context *ce)
 
 static int measure_idle_dispatch(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT], cycles;
@@ -2146,7 +2194,8 @@ static int measure_idle_dispatch(struct intel_context *ce)
 		elapsed[i] = sema[i] - elapsed[i];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: idle dispatch latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: idle dispatch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2159,6 +2208,7 @@ static int measure_idle_dispatch(struct intel_context *ce)
 
 static int measure_busy_dispatch(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT + 1], cycles;
@@ -2223,7 +2273,8 @@ static int measure_busy_dispatch(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: busy dispatch latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: busy dispatch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2262,6 +2313,7 @@ static int plug(struct intel_engine_cs *engine, u32 *sema, u32 mode, int value)
 
 static int measure_inter_request(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT + 1], cycles;
@@ -2336,7 +2388,8 @@ static int measure_inter_request(struct intel_context *ce)
 		elapsed[i - 1] = sema[i + 1] - sema[i];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: inter-request latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: inter-request latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2353,6 +2406,7 @@ static int measure_inter_request(struct intel_context *ce)
 
 static int measure_context_switch(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	struct i915_request *fence = NULL;
@@ -2431,7 +2485,8 @@ static int measure_context_switch(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 2] - sema[2 * i + 1];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: context switch latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: context switch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2447,6 +2502,7 @@ static int measure_context_switch(struct intel_context *ce)
 
 static int measure_preemption(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT], cycles;
@@ -2534,7 +2590,8 @@ static int measure_preemption(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 0] - elapsed[i - 1];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: preemption dispatch latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: preemption dispatch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2542,7 +2599,8 @@ static int measure_preemption(struct intel_context *ce)
 		elapsed[i - 1] = sema[2 * i + 1] - sema[2 * i + 0];
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: preemption switch latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: preemption switch latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2567,6 +2625,7 @@ static void signal_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
 
 static int measure_completion(struct intel_context *ce)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	u32 *sema = hwsp_scratch(ce);
 	const u32 offset = hwsp_offset(ce, sema);
 	u32 elapsed[TF_COUNT], cycles;
@@ -2636,7 +2695,8 @@ static int measure_completion(struct intel_context *ce)
 	}
 
 	cycles = trifilter(elapsed);
-	pr_info("%s: completion latency %d cycles, %lluns\n",
+	gt_info(gt,
+		"%s: completion latency %d cycles, %lluns\n",
 		ce->engine->name, cycles >> TF_BIAS,
 		cycles_to_ns(ce->engine, cycles));
 
@@ -2929,7 +2989,8 @@ static int perf_series_engines(void *arg)
 				decimal = 0;
 			}
 
-			pr_info("%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
+			gt_info(p->engine->gt,
+				"%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
 				name, p->engine->name, ce->timeline->seqno,
 				integer, decimal,
 				div_u64(p->runtime, 1000 * 1000),
@@ -3275,7 +3336,8 @@ static int perf_parallel_engines(void *arg)
 			}
 
 			GEM_BUG_ON(engine != p->engine);
-			pr_info("%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
+			gt_info(engine->gt,
+				"%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
 				name, engine->name, p->count, integer, decimal,
 				div_u64(p->runtime, 1000 * 1000),
 				div_u64(ktime_to_ns(p->time), 1000 * 1000));
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index fc068dab27f4..aa2527314ab0 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -28,6 +28,8 @@
 #include "gem/i915_gem_internal.h"
 #include "gem/selftests/mock_context.h"
 
+#include "gt/intel_gt_print.h"
+
 #include "i915_scatterlist.h"
 #include "i915_selftest.h"
 
@@ -38,21 +40,23 @@ static bool assert_vma(struct i915_vma *vma,
 		       struct drm_i915_gem_object *obj,
 		       struct i915_gem_context *ctx)
 {
+	struct intel_gt *gt = vma->vm->gt;
 	bool ok = true;
 
 	if (vma->vm != ctx->vm) {
-		pr_err("VMA created with wrong VM\n");
+		gt_err(gt, "VMA created with wrong VM\n");
 		ok = false;
 	}
 
 	if (vma->size != obj->base.size) {
-		pr_err("VMA created with wrong size, found %llu, expected %zu\n",
+		gt_err(gt,
+		       "VMA created with wrong size, found %llu, expected %zu\n",
 		       vma->size, obj->base.size);
 		ok = false;
 	}
 
 	if (!intel_gtt_view_is_normal(&vma->gtt_view)) {
-		pr_err("VMA created with wrong type [%d]\n",
+		gt_err(gt, "VMA created with wrong type [%d]\n",
 		       vma->gtt_view.type);
 		ok = false;
 	}
@@ -74,30 +78,34 @@ checked_vma_instance(struct drm_i915_gem_object *obj,
 
 	/* Manual checks, will be reinforced by i915_vma_compare! */
 	if (vma->vm != vm) {
-		pr_err("VMA's vm [%p] does not match request [%p]\n",
-		       vma->vm, vm);
+		gt_err(vm->gt,
+		       "VMA's vm [%p] does not match request [%p]\n", vma->vm,
+		       vm);
 		ok = false;
 	}
 
 	if (i915_is_ggtt(vm) != i915_vma_is_ggtt(vma)) {
-		pr_err("VMA ggtt status [%d] does not match parent [%d]\n",
+		gt_err(vm->gt,
+		       "VMA ggtt status [%d] does not match parent [%d]\n",
 		       i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
 		ok = false;
 	}
 
 	if (i915_vma_compare(vma, vm, view)) {
-		pr_err("i915_vma_compare failed with create parameters!\n");
+		gt_err(vm->gt,
+		       "i915_vma_compare failed with create parameters!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (i915_vma_compare(vma, vma->vm,
 			     i915_vma_is_ggtt(vma) ? &vma->gtt_view : NULL)) {
-		pr_err("i915_vma_compare failed with itself\n");
+		gt_err(vm->gt, "i915_vma_compare failed with itself\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!ok) {
-		pr_err("i915_vma_compare failed to detect the difference!\n");
+		gt_err(vm->gt,
+		       "i915_vma_compare failed to detect the difference!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -126,14 +134,16 @@ static int create_vmas(struct drm_i915_private *i915,
 					return PTR_ERR(vma);
 
 				if (!assert_vma(vma, obj, ctx)) {
-					pr_err("VMA lookup/create failed\n");
+					gt_err(vm->gt,
+					       "VMA lookup/create failed\n");
 					return -EINVAL;
 				}
 
 				if (!pinned) {
 					err = i915_vma_pin(vma, 0, 0, PIN_USER);
 					if (err) {
-						pr_err("Failed to pin VMA\n");
+						gt_err(vm->gt,
+						       "Failed to pin VMA\n");
 						return err;
 					}
 				} else {
@@ -332,8 +342,11 @@ static int igt_vma_pin1(void *arg)
 	for (m = modes; m->assert; m++) {
 		err = i915_vma_pin(vma, m->size, 0, m->flags);
 		if (!m->assert(vma, m, err)) {
-			pr_err("%s to pin single page into GGTT with mode[%d:%s]: size=%llx flags=%llx, err=%d\n",
-			       m->assert == assert_pin_valid ? "Failed" : "Unexpectedly succeeded",
+			gt_err(ggtt->vm.gt,
+			       "%s to pin single page into GGTT with mode[%d:%s]: size=%llx flags=%llx, err=%d\n",
+			       m->assert == assert_pin_valid ?
+				       "Failed" :
+				       "Unexpectedly succeeded",
 			       (int)(m - modes), m->string, m->size, m->flags,
 			       err);
 			if (!err)
@@ -346,7 +359,9 @@ static int igt_vma_pin1(void *arg)
 			i915_vma_unpin(vma);
 			err = i915_vma_unbind_unlocked(vma);
 			if (err) {
-				pr_err("Failed to unbind single page from GGTT, err=%d\n", err);
+				gt_err(ggtt->vm.gt,
+				       "Failed to unbind single page from GGTT, err=%d\n",
+				       err);
 				goto out;
 			}
 		}
@@ -374,6 +389,7 @@ assert_rotated(struct drm_i915_gem_object *obj,
 	       const struct intel_rotation_info *r, unsigned int n,
 	       struct scatterlist *sg)
 {
+	struct intel_gt *gt = to_gt(to_i915(obj->base.dev));
 	unsigned int x, y;
 
 	for (x = 0; x < r->plane[n].width; x++) {
@@ -384,7 +400,8 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			dma_addr_t src;
 
 			if (!sg) {
-				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
+				gt_err(gt,
+				       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
 				       n, x, y);
 				return ERR_PTR(-EINVAL);
 			}
@@ -393,14 +410,16 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			src = i915_gem_object_get_dma_address(obj, src_idx);
 
 			if (sg_dma_len(sg) != PAGE_SIZE) {
-				pr_err("Invalid sg.length, found %d, expected %lu for rotated page (%d, %d) [src index %lu]\n",
-				       sg_dma_len(sg), PAGE_SIZE,
-				       x, y, src_idx);
+				gt_err(gt,
+				       "Invalid sg.length, found %d, expected %lu for rotated page (%d, %d) [src index %lu]\n",
+				       sg_dma_len(sg), PAGE_SIZE, x, y,
+				       src_idx);
 				return ERR_PTR(-EINVAL);
 			}
 
 			if (sg_dma_address(sg) != src) {
-				pr_err("Invalid address for rotated page (%d, %d) [src index %lu]\n",
+				gt_err(gt,
+				       "Invalid address for rotated page (%d, %d) [src index %lu]\n",
 				       x, y, src_idx);
 				return ERR_PTR(-EINVAL);
 			}
@@ -414,19 +433,22 @@ assert_rotated(struct drm_i915_gem_object *obj,
 			continue;
 
 		if (!sg) {
-			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
+			gt_err(gt,
+			       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
 			       n, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_len(sg) != left) {
-			pr_err("Invalid sg.length, found %d, expected %u for rotated page (%d, %d)\n",
+			gt_err(gt,
+			       "Invalid sg.length, found %d, expected %u for rotated page (%d, %d)\n",
 			       sg_dma_len(sg), left, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_address(sg) != 0) {
-			pr_err("Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
+			gt_err(gt,
+			       "Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
 			       &sg_dma_address(sg), x, y);
 			return ERR_PTR(-EINVAL);
 		}
@@ -451,6 +473,7 @@ assert_remapped(struct drm_i915_gem_object *obj,
 		const struct intel_remapped_info *r, unsigned int n,
 		struct scatterlist *sg)
 {
+	struct intel_gt *gt = to_gt(to_i915(obj->base.dev));
 	unsigned int x, y;
 	unsigned int left = 0;
 	unsigned int offset;
@@ -461,7 +484,8 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			dma_addr_t src;
 
 			if (!sg) {
-				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
+				gt_err(gt,
+				       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
 				       n, x, y);
 				return ERR_PTR(-EINVAL);
 			}
@@ -474,14 +498,16 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			src = i915_gem_object_get_dma_address(obj, src_idx);
 
 			if (left < PAGE_SIZE || left & (PAGE_SIZE-1)) {
-				pr_err("Invalid sg.length, found %d, expected %lu for remapped page (%d, %d) [src index %lu]\n",
-				       sg_dma_len(sg), PAGE_SIZE,
-				       x, y, src_idx);
+				gt_err(gt,
+				       "Invalid sg.length, found %d, expected %lu for remapped page (%d, %d) [src index %lu]\n",
+				       sg_dma_len(sg), PAGE_SIZE, x, y,
+				       src_idx);
 				return ERR_PTR(-EINVAL);
 			}
 
 			if (sg_dma_address(sg) + offset != src) {
-				pr_err("Invalid address for remapped page (%d, %d) [src index %lu]\n",
+				gt_err(gt,
+				       "Invalid address for remapped page (%d, %d) [src index %lu]\n",
 				       x, y, src_idx);
 				return ERR_PTR(-EINVAL);
 			}
@@ -495,7 +521,8 @@ assert_remapped(struct drm_i915_gem_object *obj,
 		}
 
 		if (left) {
-			pr_err("Unexpected sg tail with %d size for remapped page (%d, %d)\n",
+			gt_err(gt,
+			       "Unexpected sg tail with %d size for remapped page (%d, %d)\n",
 			       left,
 			       x, y);
 			return ERR_PTR(-EINVAL);
@@ -507,20 +534,23 @@ assert_remapped(struct drm_i915_gem_object *obj,
 			continue;
 
 		if (!sg) {
-			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
+			gt_err(gt,
+			       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
 			       n, x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_len(sg) != left) {
-			pr_err("Invalid sg.length, found %u, expected %u for remapped page (%d, %d)\n",
+			gt_err(gt,
+			       "Invalid sg.length, found %u, expected %u for remapped page (%d, %d)\n",
 			       sg_dma_len(sg), left,
 			       x, y);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (sg_dma_address(sg) != 0) {
-			pr_err("Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
+			gt_err(gt,
+			       "Invalid address, found %pad, expected 0 for remapped page (%d, %d)\n",
 			       &sg_dma_address(sg),
 			       x, y);
 			return ERR_PTR(-EINVAL);
@@ -628,7 +658,9 @@ static int igt_vma_rotate_remap(void *arg)
 
 					err = i915_vma_pin(vma, 0, 0, PIN_GLOBAL);
 					if (err) {
-						pr_err("Failed to pin VMA, err=%d\n", err);
+						gt_err(vm->gt,
+						       "Failed to pin VMA, err=%d\n",
+						       err);
 						goto out_object;
 					}
 
@@ -636,36 +668,47 @@ static int igt_vma_rotate_remap(void *arg)
 
 					if (intel_gtt_view_is_rotated(&view) &&
 					    vma->size != expected_pages * PAGE_SIZE) {
-						pr_err("VMA is wrong size, expected %lu, found %llu\n",
-						       PAGE_SIZE * expected_pages, vma->size);
+						gt_err(vm->gt,
+						       "VMA is wrong size, expected %lu, found %llu\n",
+						       PAGE_SIZE *
+							       expected_pages,
+						       vma->size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (intel_gtt_view_is_remapped(&view) &&
 					    vma->size > expected_pages * PAGE_SIZE) {
-						pr_err("VMA is wrong size, expected %lu, found %llu\n",
-						       PAGE_SIZE * expected_pages, vma->size);
+						gt_err(vm->gt,
+						       "VMA is wrong size, expected %lu, found %llu\n",
+						       PAGE_SIZE *
+							       expected_pages,
+						       vma->size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->pages->nents > expected_pages) {
-						pr_err("sg table is wrong sizeo, expected %u, found %u nents\n",
-						       expected_pages, vma->pages->nents);
+						gt_err(vm->gt,
+						       "sg table is wrong sizeo, expected %u, found %u nents\n",
+						       expected_pages,
+						       vma->pages->nents);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->node.size < vma->size) {
-						pr_err("VMA binding too small, expected %llu, found %llu\n",
-						       vma->size, vma->node.size);
+						gt_err(vm->gt,
+						       "VMA binding too small, expected %llu, found %llu\n",
+						       vma->size,
+						       vma->node.size);
 						err = -EINVAL;
 						goto out_object;
 					}
 
 					if (vma->pages == obj->mm.pages) {
-						pr_err("VMA using unrotated object pages!\n");
+						gt_err(vm->gt,
+						       "VMA using unrotated object pages!\n");
 						err = -EINVAL;
 						goto out_object;
 					}
@@ -677,7 +720,8 @@ static int igt_vma_rotate_remap(void *arg)
 						else
 							sg = assert_remapped(obj, &view.remapped, n, sg);
 						if (IS_ERR(sg)) {
-							pr_err("Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %d, %d), (%d, %d, %d, %d, %d)]\n",
+							gt_err(vm->gt,
+							       "Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %d, %d), (%d, %d, %d, %d, %d)]\n",
 							       intel_gtt_view_is_rotated(&view) ?
 							       "rotated" : "remapped", n,
 							       plane_info[0].width,
@@ -698,7 +742,9 @@ static int igt_vma_rotate_remap(void *arg)
 					i915_vma_unpin(vma);
 					err = i915_vma_unbind_unlocked(vma);
 					if (err) {
-						pr_err("Unbinding returned %i\n", err);
+						gt_err(vm->gt,
+						       "Unbinding returned %i\n",
+						       err);
 						goto out_object;
 					}
 					cond_resched();
@@ -719,6 +765,7 @@ static bool assert_partial(struct drm_i915_gem_object *obj,
 			   unsigned long offset,
 			   unsigned long size)
 {
+	struct intel_gt *gt = vma->vm->gt;
 	struct sgt_iter sgt;
 	dma_addr_t dma;
 
@@ -726,13 +773,15 @@ static bool assert_partial(struct drm_i915_gem_object *obj,
 		dma_addr_t src;
 
 		if (!size) {
-			pr_err("Partial scattergather list too long\n");
+			gt_err(gt,
+			       "Partial scattergather list too long\n");
 			return false;
 		}
 
 		src = i915_gem_object_get_dma_address(obj, offset);
 		if (src != dma) {
-			pr_err("DMA mismatch for partial page offset %lu\n",
+			gt_err(gt,
+			       "DMA mismatch for partial page offset %lu\n",
 			       offset);
 			return false;
 		}
@@ -749,41 +798,47 @@ static bool assert_pin(struct i915_vma *vma,
 		       u64 size,
 		       const char *name)
 {
+	struct intel_gt *gt = vma->vm->gt;
 	bool ok = true;
 
 	if (vma->size != size) {
-		pr_err("(%s) VMA is wrong size, expected %llu, found %llu\n",
+		gt_err(gt,
+		       "(%s) VMA is wrong size, expected %llu, found %llu\n",
 		       name, size, vma->size);
 		ok = false;
 	}
 
 	if (vma->node.size < vma->size) {
-		pr_err("(%s) VMA binding too small, expected %llu, found %llu\n",
+		gt_err(gt,
+		       "(%s) VMA binding too small, expected %llu, found %llu\n",
 		       name, vma->size, vma->node.size);
 		ok = false;
 	}
 
 	if (view && !intel_gtt_view_is_normal(view)) {
 		if (memcmp(&vma->gtt_view, view, sizeof(*view))) {
-			pr_err("(%s) VMA mismatch upon creation!\n",
-			       name);
+			gt_err(gt,
+			       "(%s) VMA mismatch upon creation!\n", name);
 			ok = false;
 		}
 
 		if (vma->pages == vma->obj->mm.pages) {
-			pr_err("(%s) VMA using original object pages!\n",
+			gt_err(gt,
+			       "(%s) VMA using original object pages!\n",
 			       name);
 			ok = false;
 		}
 	} else {
 		if (!intel_gtt_view_is_normal(&vma->gtt_view)) {
-			pr_err("Not the normal ggtt view! Found %d\n",
+			gt_err(gt,
+			       "Not the normal ggtt view! Found %d\n",
 			       vma->gtt_view.type);
 			ok = false;
 		}
 
 		if (vma->pages != vma->obj->mm.pages) {
-			pr_err("VMA not using object pages!\n");
+			gt_err(gt,
+			       "VMA not using object pages!\n");
 			ok = false;
 		}
 	}
@@ -843,14 +898,16 @@ static int igt_vma_partial(void *arg)
 					goto out_object;
 
 				if (!assert_pin(vma, &view, sz*PAGE_SIZE, p->name)) {
-					pr_err("(%s) Inconsistent partial pinning for (offset=%d, size=%d)\n",
+					gt_err(vm->gt,
+					       "(%s) Inconsistent partial pinning for (offset=%d, size=%d)\n",
 					       p->name, offset, sz);
 					err = -EINVAL;
 					goto out_object;
 				}
 
 				if (!assert_partial(obj, vma, offset, sz)) {
-					pr_err("(%s) Inconsistent partial pages for (offset=%d, size=%d)\n",
+					gt_err(vm->gt,
+					       "(%s) Inconsistent partial pages for (offset=%d, size=%d)\n",
 					       p->name, offset, sz);
 					err = -EINVAL;
 					goto out_object;
@@ -860,7 +917,9 @@ static int igt_vma_partial(void *arg)
 				nvma++;
 				err = i915_vma_unbind_unlocked(vma);
 				if (err) {
-					pr_err("Unbinding returned %i\n", err);
+					gt_err(vm->gt,
+					       "Unbinding returned %i\n",
+					       err);
 					goto out_object;
 				}
 
@@ -872,7 +931,8 @@ static int igt_vma_partial(void *arg)
 		list_for_each_entry(vma, &obj->vma.list, obj_link)
 			count++;
 		if (count != nvma) {
-			pr_err("(%s) All partial vma were not recorded on the obj->vma_list: found %u, expected %u\n",
+			gt_err(vm->gt,
+			       "(%s) All partial vma were not recorded on the obj->vma_list: found %u, expected %u\n",
 			       p->name, count, nvma);
 			err = -EINVAL;
 			goto out_object;
@@ -890,7 +950,8 @@ static int igt_vma_partial(void *arg)
 			goto out_object;
 
 		if (!assert_pin(vma, NULL, obj->base.size, p->name)) {
-			pr_err("(%s) inconsistent full pin\n", p->name);
+			gt_err(vm->gt, "(%s) inconsistent full pin\n",
+			       p->name);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -899,7 +960,7 @@ static int igt_vma_partial(void *arg)
 
 		err = i915_vma_unbind_unlocked(vma);
 		if (err) {
-			pr_err("Unbinding returned %i\n", err);
+			gt_err(vm->gt, "Unbinding returned %i\n", err);
 			goto out_object;
 		}
 
@@ -907,7 +968,9 @@ static int igt_vma_partial(void *arg)
 		list_for_each_entry(vma, &obj->vma.list, obj_link)
 			count++;
 		if (count != nvma) {
-			pr_err("(%s) allocated an extra full vma!\n", p->name);
+			gt_err(vm->gt,
+			       "(%s) allocated an extra full vma!\n",
+			       p->name);
 			err = -EINVAL;
 			goto out_object;
 		}
@@ -1080,7 +1143,8 @@ static int igt_vma_remapped_gtt(void *arg)
 
 					val = ioread32(&map[offset / sizeof(*map)]);
 					if (val != exp) {
-						pr_err("%s VMA write test failed, expected 0x%x, found 0x%x\n",
+						gt_err(to_gt(i915),
+						       "%s VMA write test failed, expected 0x%x, found 0x%x\n",
 						       intel_gtt_view_is_rotated(&view) ? "Rotated" : "Remapped",
 						       exp, val);
 						i915_vma_unpin_iomap(vma);
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index 514d2200751b..7e25e98f0fb7 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -25,6 +25,7 @@
 #include "../i915_selftest.h"
 
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 
 static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
 				unsigned int num_ranges,
@@ -161,6 +162,7 @@ static int live_forcewake_ops(void *arg)
 	const struct reg *r;
 	struct intel_gt *gt = arg;
 	struct intel_uncore_forcewake_domain *domain;
+	struct drm_i915_private *i915 = gt->i915;
 	struct intel_uncore *uncore = gt->uncore;
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
@@ -171,8 +173,8 @@ static int live_forcewake_ops(void *arg)
 	GEM_BUG_ON(gt->awake);
 
 	/* vlv/chv with their pcu behave differently wrt reads */
-	if (IS_VALLEYVIEW(gt->i915) || IS_CHERRYVIEW(gt->i915)) {
-		pr_debug("PCU fakes forcewake badly; skipping\n");
+	if (IS_VALLEYVIEW(i915) || IS_CHERRYVIEW(i915)) {
+		gt_dbg(gt, "PCU fakes forcewake badly; skipping\n");
 		return 0;
 	}
 
@@ -189,11 +191,12 @@ static int live_forcewake_ops(void *arg)
 
 	/* We have to pick carefully to get the exact behaviour we need */
 	for (r = registers; r->name; r++)
-		if (IS_GRAPHICS_VER(gt->i915, r->min_graphics_ver, r->max_graphics_ver))
+		if (IS_GRAPHICS_VER(i915, r->min_graphics_ver, r->max_graphics_ver))
 			break;
 	if (!r->name) {
-		pr_debug("Forcewaked register not known for %s; skipping\n",
-			 intel_platform_name(INTEL_INFO(gt->i915)->platform));
+		gt_dbg(gt,
+		       "Forcewaked register not known for %s; skipping\n",
+		       intel_platform_name(INTEL_INFO(i915)->platform));
 		return 0;
 	}
 
@@ -225,7 +228,8 @@ static int live_forcewake_ops(void *arg)
 			if (!domain->wake_count)
 				continue;
 
-			pr_err("fw_domain %s still active, aborting test!\n",
+			gt_err(gt,
+			       "fw_domain %s still active, aborting test!\n",
 			       intel_uncore_forcewake_domain_to_str(domain->id));
 			err = -EINVAL;
 			goto out_rpm;
@@ -245,14 +249,15 @@ static int live_forcewake_ops(void *arg)
 			err = wait_ack_clear(domain, FORCEWAKE_KERNEL);
 			preempt_enable();
 			if (err) {
-				pr_err("Failed to clear fw_domain %s\n",
+				gt_err(gt,
+				       "Failed to clear fw_domain %s\n",
 				       intel_uncore_forcewake_domain_to_str(domain->id));
 				goto out_rpm;
 			}
 		}
 
 		if (!val) {
-			pr_err("%s:%s was zero while fw was held!\n",
+			gt_err(gt, "%s:%s was zero while fw was held!\n",
 			       engine->name, r->name);
 			err = -EINVAL;
 			goto out_rpm;
@@ -260,7 +265,8 @@ static int live_forcewake_ops(void *arg)
 
 		/* We then expect the read to return 0 outside of the fw */
 		if (wait_for(readl(reg) == 0, 100)) {
-			pr_err("%s:%s=%0x, fw_domains 0x%x still up after 100ms!\n",
+			gt_err(gt,
+			       "%s:%s=%0x, fw_domains 0x%x still up after 100ms!\n",
 			       engine->name, r->name, readl(reg), fw_domains);
 			err = -ETIMEDOUT;
 			goto out_rpm;
-- 
2.34.1

