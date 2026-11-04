Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E011606A333
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZuXLjGL0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499AB10FB54;
	Wed,  4 Nov 2026 11:11:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F7410FB48;
 Wed,  4 Nov 2026 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790691; x=1825326691;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=gAuCRjrediR7Vrb8oySXGgPvW4iQfjMxQ+8+sDuhaFg=;
 b=ZuXLjGL0V5ywkvftrQA1xzBFxuFPyGB1pKrOwIYiVR2MBD2Nwq+4FqVc
 LD+JH2K++byQsO8gmTmYwwJi5VTlZk8OHgfEJ4smscXIMfsrQf4OdZEhL
 BaEFQwxKur36FfMfnb3fgh5EBrBAnSPtZe3HsGRx1kdiZguQ6CC/iE2pC
 IBllyz0UUCFWcGhmaAXLghaeCJF0vy4ldypjcyXX8as/4vlptXCsfQ2qe
 XBc3p0Dhr8eBZcbiEzDXp6GNhB9iJiLyb9nThHYCbaSQkpDb5i6C76jXH
 08vtYgzdCGFRSYEqwIklebXNO1Gw3hpf6ffu7HhKm99VVnnXDI7yB1H9T g==;
X-CSE-ConnectionGUID: WF7YWQK3RKGvn6crN/B/3w==
X-CSE-MsgGUID: IHrAYdSsR4yArvt6oZaN5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2415377"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2415377"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:31 -0800
X-CSE-ConnectionGUID: HW2jtRRlTCCfcx6hAHasNQ==
X-CSE-MsgGUID: 8s/Gj03BQ3Sq9E/UuSl8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6708214"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:29 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:11:29 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlWamv+mfPWnaNNZN8aIqEirZWWFyQOcCUQfzLBwRR7r1ZzNg2WUa/Om/QLY1GOhMkEUULE7fb6c4xjceOXoJMACd3x5DTzW/2PHPJtiMngneHnVbI3EFOkPct7DJu2IXljlFcOpu590P1U9QyS5JafRik5aBiJEZoz/dmss6yjCx7U8NNHQH+p89hzlTCHEfrC13nCDASAy6gNFPzG14caPGdI2dW89BifV14ZGKpvTn5TQFM91hDZvP8vNUF/1oiOo5ncL7ecaPX3WxuS89MFdl3OUqooJEBL0xxvudbnOVRXlrHe6hxLQOYSCZ1NKl0pKs968x8mHc9YpdiJGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwo1Xjw4W11Wv+6T0UrJz0+Yz1QfLxaOqYWJgBTBwEM=;
 b=gAkT0m2P5qv1a/oaTbJ/kqGZEnQN5j3or7TydExq16KJxZ/9C9b1jNMBj51bVbA4kOQ7Ynu+k/m1aXaGjfOIY+6CdFLBjwzhNFQL2m8zm6vkkEZhinluhPB1h5SeDyzkGg6LnLYQmbasNeQ3jNlwxKQ6rvtLA9mzQZMUh/Xz3oOe0X2HTkc5LMFiLS4IY3jSsflgxQ+Jk9K4zAvosi4RiLnMZDNeDSr2wVjSGdO8DKRqAR816eDd6xvSGtJ2ePV19zCjgGcjIXIXuUt0TdY5w0lsy/m++T2wC0BFs1W6BZhh5rnwEyJyZ1nHTaCYmT/NGwOCPXYocvmd4rD3nRNiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA3PR11MB589729.namprd11.prod.outlook.com
 (2603:10b6:208:620::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:11:27 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:11:26 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v6 4/6] drm/i915/gt/selftests: Use gt_* prints in gt
 standalone tests
Date: Wed, 4 Nov 2026 11:11:02 +0000
Message-ID: <20261104111104.946617-5-krzysztof.karas@intel.com>
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
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|IA3PR11MB589729:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd96cc9-4346-4fe0-b25b-08df3a645e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|3023799007|11063799006|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: ljzQW2melbwWjlHIo2R5EagS2b1+ud54Gj2Bf4x8oZR19A6UrytwlFvoGmIRuNyXw5aoV23Era8HwiEtsLODgL0vz496STDdvIvPMMuwFCxc3KNy1Tl1STDDW2kwFkwy/BXolandSY7Qg8cfd38aLU1G0ZL1Eos+YOt2PbnjA+psdIMJEA/Thvq28igi+h6Gq/bUmRqgBGVTyzzx2a+gR4gmiVJF+kpCr7Sm3HaPAWgD63OmQTx4YLJR1SVTHRtjtYz2SckXZ/Sdl0IAL0xs2FZVbI2EJSPTe2RK2Un6ED/L6H1sSup+s1v1N9MuRnAga1QmAbOa62DqytLx+I88UZlB/L6Yo3Uqt6bIuuVEBcAtpUqkw7b0lVp7zAUDOqzniMoEOTMn4SOVafFbipGfj3HXkiW9TCdqbIYxHfRsP/4TGDAJcYmdyTDQ9BxvVHj0bNPbpM+UlLV7TAVHmLs9icieS68i8dx46cGaoDgu3g2XafpmA/5huBk1aDuAgE4Be9uGYt6YYM/c9QdW1ausyJm8xEf7hapylBsOkCI5as/tJMATjLlZqrdRoZJTmG26Z213cppLj7z65FZVZhtXsycqdDsp5zEW7PgUHr65Ny4myB31/eqCAO8f2xCvyxcM4i5wHu+6YUwH8xAYgO1VXWUlvCyfkGYkrJ8NS6AbrWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YYKO2tab7U96pxJXMkKzoKkLE2aglZrHGWkYF5lWfvamDsaByLEV2hiFa61L?=
 =?us-ascii?Q?1jKNRxMBaPTzhiIj7Yn0VAf6Fuf/gzysYpey55Tz8CWzKjNdEAlDoM88zdik?=
 =?us-ascii?Q?OB0x5RiRcJgBD6/uZg1tzfftXFF3sDot4CvpQY2sclVj1CWw+t7diK0Qb98v?=
 =?us-ascii?Q?f7ElAyQtklCbvxHRfE/emIWrxz2t3WDAh7PH5IqsQvVUdjVPLCXCgzsHaQqz?=
 =?us-ascii?Q?AHEm0jANlwNBb4OlAhfSq+4hZugsd4n/camG/ux+UxGu5/8dC4yfSYNxhYpj?=
 =?us-ascii?Q?5PJf4i+75soSHd/0t70aBDta1OZYX4/txa7HCZZIAeb28yzrPOWv2TPOk9pt?=
 =?us-ascii?Q?NlA4bQMlfLqk67n00RTwQtY3V3rog0GuF8hOkxDILEy4sKrLvoxF4sdiBFCF?=
 =?us-ascii?Q?OhSgaqJMOWCcsdTEV4fDVBLhmdTCHk61DnrtoMXkMpuLDW77qwy1CUhrTU3y?=
 =?us-ascii?Q?zHxdaixJBUXZuNycEtjIz9GpxDFv41NzU9poexrsriRDnkVCxkmZob6fYb6d?=
 =?us-ascii?Q?yBsrd94SntjQtp39OLk2umvb9PdbGAThZcdDTYplORlXzOFEhE0cABoilfwc?=
 =?us-ascii?Q?/O9aYPEkYT6eTuGtX1KoExeLYgFjbqVrmLUVp+drbPHfU/C32xV9LkMx8btP?=
 =?us-ascii?Q?PsszqdipQJnZ7+nEcW+fPZhs+IKcRiYDv7E4A7nRtSqfBm2hVUj6fksv+DLm?=
 =?us-ascii?Q?LTSADeSpP23SeYadkqyOxn4P+TojiW1HmP2BohfFtr8k/rLa/HfzL7zGN/kK?=
 =?us-ascii?Q?8jcl8rjDPZ7HIWyWKAdRCytjaxhmQ1Us1UE39KtI8VJeyLCrLC35PAZZlVGm?=
 =?us-ascii?Q?L0HdOHQL8CR67Fur1txn25J7aFQHoe1uOFwBOxClw8/sRlsU2IMMQYrBE/29?=
 =?us-ascii?Q?4PwQAno6zldiX2QmsVoaNOSggXwE4QdPARguSpGdXrrb/a3WajyQ3swM/lGq?=
 =?us-ascii?Q?4fvuA2VIPdxq6Tsw1EmUJ+pJ0agYqsDcYaDRLOhfyXBPcb/jWc4pV18B1153?=
 =?us-ascii?Q?MYD2gOXOnILvIehs4Tn9oWDoIuXU4WKbQ/vclCGkBIdggWgPO+BxD0W4Fyo2?=
 =?us-ascii?Q?bU4yhv5R0fgJbv/sZsWQvTUCN3AcsW+Kt/cv7J4VlCpeHdaIdiCW1lDCIpm6?=
 =?us-ascii?Q?A0+JfglWVb8DSavhmWjDQJkKQkOPgw/qJzKg3W2lhw5yz2lCSbmO5HCKhEm6?=
 =?us-ascii?Q?FQ0FZMJoHIIbG+wyMq+4NaW/D8kgLTJQAmib+pUgEgRkvaxRMWmlZ4CFuk4c?=
 =?us-ascii?Q?J3cDXYcki0cs56QwuFxCwL/mbrm9aNGGHPZS8yCmk/FJznSJyTClU5w1C2I9?=
 =?us-ascii?Q?sYNbnViT3tS0jqmLDCJS15qpoHQpFy9MSVSvAol+cJPJxBqcf6AEU9yYERqV?=
 =?us-ascii?Q?P2gKQm8qiflXIll+xpG06ZNmjvZsvL08oMooKSUXBDQ/3f4T7XB3JWKhvyhv?=
 =?us-ascii?Q?KrMe/UfTJUuAp6S0kqlzRRF2w+HwDidKQs0wyyRE0ZfF+WgRTFQpZjpW3WKG?=
 =?us-ascii?Q?riijnbKD6i7BgVKvpNC1VBoliYwpCaF5Tew6+tE0Kq8k9gImSCfzk6LlhpTR?=
 =?us-ascii?Q?mXJ3QFcRgMLudYdi4m/gThWBO8l4siu4H5rXIwYAGurZayX1ECD10LUB7ffo?=
 =?us-ascii?Q?JgqHJLFeIWwoBe/hddxIcBNj9VKmXHGaEGhiv7AcXSrr4cohgYZBqgURygXH?=
 =?us-ascii?Q?OjdbV1/QsRe6FOtYV34SvBNmkjIma93zzd3xdaDRb3dK3BZum6K2bfm6+mdw?=
 =?us-ascii?Q?lu44roPHhquEkRim89uUCu557WQ1zGc=3D?=
X-Exchange-RoutingPolicyChecked: wh+tKNuih9eRzxQj2VgTCybfyN3kMFMMB82nAYN1hKj0GColNXABNv/A01dAP3tKN2wTaxYopFSniW5+Vgo3znDBnIWXYVY0pCXY8HWJ95IKh36b7AwfSq5S+WZN1s8dQoL/0EjD8oAH2Wz3eTjkPdY5LqafBs77VnmTHoLPKjmFxb0btEjblGnrOa5tWljZcPLMuZ7dcmqdAyRA82d7d1iqtE97xby39lzBSc470rE/lSGNxy2RMtlJw3MA0TK5sM3GA3RmHOl6uCoXz8xGUDT2QV93k2VGiyE2UWxekuK31CifA2w2oejuJRBzWqnEwbmjOjBnLqGmInZ07RsasA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd96cc9-4346-4fe0-b25b-08df3a645e3f
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:11:26.3196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgktBZLyjPpd7tZ8989Q0LAay5pd+qdTA4+EfXPtO4VAMl8pAtfkBZ26A+4QPtBuuRGUpnJRaPoiXinrlNDnk2573GW2WwS5+WBpuhK9kGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB589729
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

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
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

