Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0176DC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DA810E777;
	Thu, 16 Jul 2026 10:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QE94x3L7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32F010E777;
 Thu, 16 Jul 2026 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784196827; x=1815732827;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=4syZO/DIFeAH5karKslxieAhaQuHyFcbkJRPcdOro94=;
 b=QE94x3L7KTcYRyiR5Mb2LvWgGyc4JcFYmwHrZ0OqkxvN0ElTZWDVLXvH
 P2p8f/FPwGBphDstweZNiXtPWXDrnPf5jzcu2o34idq5tGQ1PCPyksXla
 toZJvwOH/k2xTYkuVsWKDmHtyDapL0Nnye0QpUJtsJeSBJA2SJ+ZkH6BY
 ep2HQbFRabDFZAdPpoqzTaHRJidh4PbX7QdjOZbcRepQirfTx+oSe6l0z
 Aq5ZpAx1ktZINrjriWsosAb0HfbNRu4t4tnm5QvSZBMlJgi1qTZEjczQE
 TaDlMhFNjTb6lOYaaS8r0tBtH2UhEpK2y9gC6mthAtpGfjWnUo2MEs60X Q==;
X-CSE-ConnectionGUID: RxF5COFzSiabCvU+D0wpcw==
X-CSE-MsgGUID: h3QAvgoUSZCQleILPI2u9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95204482"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="95204482"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 03:13:47 -0700
X-CSE-ConnectionGUID: Sx+hfvIRSi+ws6o0vPP4lg==
X-CSE-MsgGUID: dqW34S7DRV6qUjN4gVUrBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="280905645"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 03:13:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:13:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 03:13:46 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOxRgckvuPLTIURHvUF4h9hXjqcvWb+iQNjDkoLcBFw3PusonL1tDZBDOQroEibCPNcK2pf6ZhecsQVJlbAHTuRDIGVmC7HSO2oyTEXTxKXcbPCwwbFIccJ0iH1C9Z3VQKxXZu1pByx5jOEtfSa0b85SGf7Ez9LedF9JEnzT5v0bxlY32R6J50uladoszPr0E3rYi04dHd4UtLd7+YLB3RC0tLF/An+ohfryxjAsfF1t0JIdzs4WFd7jIza3rseLrYndZmkVmTm4lqozxy3On0ggeLALxlLPeCqQG2na/DVBVUPuYVKoyfQVGIO6HjdHgdH2qMSciQnpilxCWaQs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvVLJHGTT8+PxzKU8Oqa+we4mX3D2/E3t0POUI2U0oE=;
 b=rtuYoI5wzgbEkg/ezVjImv+dIIHbB+XQ+Jc7U6q+OVKkX0UlQFXd2FbDW43zCqzbgEMvsCxz0ef3Q+F4URdqTFvokpdDrk3ueSSwIcAyQFtcJjDb2b6PY/Sfmhk1DnG7WLZlpy9UZm6Nt8neTxJrhYT/Jtjxd/SNJsgJNycSB1YOyO4F4ezULZWN2QI4xafjYLFUGol1+/iH/mzfLkfAzdK5nNpTZXM+CcAwX7WtNpacvwkD4D0JioLan2Tw+WoPA3QZa3WahVJOJ8RLGgtF/tQayhq28KFnDGUiF/Yc7sWL5oCzS1gcKjAKWyMdlns0WAtiLHqJtODJEq0nxdln9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by CY2PR11MB637721.namprd11.prod.outlook.com (2603:10b6:930:110::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 10:13:44 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 10:13:44 +0000
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <maarten.lankhorst@linux.intel.com>, <andi.shyti@linux.intel.com>,
 <krzysztof.karas@intel.com>, <krzysztof.niemiec@intel.com>,
 <intel-gfx@lists.freedesktop.org>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: [PATCH] drm/fb-helper: guard against NULL fb_helper->funcs in restore
 path
Date: Thu, 16 Jul 2026 12:14:33 +0200
Message-ID: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU7P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::20) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|CY2PR11MB637721:EE_
X-MS-Office365-Filtering-Correlation-Id: 196f64fd-64b8-42d9-5817-08dee322eab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: NarGmylqMuDt5x6Q1EYaDaGnphmkWqZSrPRwlI0PXIaXfEyVovSKKxBUiaNuo2QXQv6tK1kfSzy5zBIn8XDc/B0kTBJCJt3ye8nfrc0CsBvW5PjQTsRlm5ktWib6WQyPYQ7sI+4O73QVH1u3Ks8dDxToHa2qLPKuRlNnhB1ZTPfH/2iKqWnLynlDIXT3WtkZvXiDgPpQGULQgFnp/lW+Fb9SMooPNc2eVBEeFkv/Crypu/XxgnW559PfBtwk8z5SHUDGjl+RHoYUGtyMeVa2xzXk5LnD4FDWFvSSClT3sDcQNMXY21EZ7WqyG7qYT1ItcxEtuRC76GnHfkJlJEVdOlyuLi74cYsY4/gZBody8WY9s8Xu4G1AZL28WP33AOmjoTfFNgq3apty4KB+nmk8qKPf1nlTeacrAzKZ5XQ9PP3kJbLb7s0CmlY3trEaP6pQbA0y6vyRu7inq/cSi6mtY7EKPBdGiDz6V0jV6lk8UOO/sRIJOkeFPrCQi/yLaj9re9aw0esATy9JWQfCc51J5LJITElOiqNN4bNeLPEIhXzGUCIu1TsmIAAdC6toQwxQ+RoHNYYS+9XqhNyFWWy+OUlwyvLVXgfUjXsoxvTG/INqIQArOzIdieuuA7lndxCaJbpJXThCtF6vont24X+WLPfaLUG98K4iITdEJ+RZtYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6909.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+M7DYGzf7+kTsJwZPR6a4jB3yq8Cp0u9QVFmBkFeu3cZsCUqlDoY2/JmyghJ?=
 =?us-ascii?Q?DxLC5kNdoXV21BXOTkGkOFyFMrEayhWjZdtF1XCwGpP78+HvseD2l5zz9D9q?=
 =?us-ascii?Q?vnOS4euFEoF2rcKuUR9idg8xJN3cHXNMxybzQ4siG6MlXjnjXTVtGx8KOvvt?=
 =?us-ascii?Q?ky+ZJhKNErFF0DB1BspCZu0x6AF1CfG2V5EVpmcw3EYHI0oMhDpNHWtDjWDH?=
 =?us-ascii?Q?lFYjor9AQf+aDHPErldRc8q6wtB0aZShvBxk9r6xbJ3OPn176K5FcmxE+5RP?=
 =?us-ascii?Q?HjK7GGM64WWVsn7fS2s/yjtERACHKKlu/Vp3eLIA752sdmmsl0gbMX3xXtUl?=
 =?us-ascii?Q?BwiE/EG3sgMfh4p0sdCK2uAi38x3N03ogsrWIKhWXieTgBQos+xMAxHahYFX?=
 =?us-ascii?Q?JLlgkoTXx0ZUf7PPoe1P2wQtuWGPbph+o44EzlfP0wEuCT0ZzWpPcWy4BAgV?=
 =?us-ascii?Q?+SGK+zRYoV9u+FneUKfNuv+1Ziyw+tP3Fh6UpYia35QZYnQG91h0QaU+9I6h?=
 =?us-ascii?Q?2/H8uWhHIuTmrqPHXpiB1lCgLBH4oMy5kc3iDaEJsp/SmZvMBTmTQfox4+6y?=
 =?us-ascii?Q?vnklIS/IvRqlat2N6E6FkM1XM2eApZU7NTK/ttqBGxLEju111V9q47/msLhm?=
 =?us-ascii?Q?KqMDkDZHdqhirnoUnXG53JhTAtCavPQgySHGEtEeX+Cl6/26sGTp7OD8st//?=
 =?us-ascii?Q?YVIiq5MMqZaoK+ihbw7bde9F10uf453CqpAIeolquo3FCONwqwTgN6NI1d+f?=
 =?us-ascii?Q?IJAM+AQweqlpuf/rnUA9AIk4+pavq5QcTy2oW69YnP2GZnaXOV/H7qMvwPn7?=
 =?us-ascii?Q?Al/nbS745yLhkezdzwR+GS5oWzw/nBbKNO4EAO2m6eioFssBeWmwgRdcXV9C?=
 =?us-ascii?Q?3eidiUevGRG0tWLPvJxQELQRt0fkwrsRIP4TVZiIKQem0pyHb3s6RmTHIMA2?=
 =?us-ascii?Q?1ITZfs8j+9gocMhoPRX+dw8pNxhPQxLHYRGZVt8s8BvoPSLir7CqlH+DZT0/?=
 =?us-ascii?Q?Mzszcipq9ejeS2ZI3zSdPJx1ah/O/ddrD5bwzXkh1wdE7wP8kTIsuGnOaI7u?=
 =?us-ascii?Q?piWzd0TgdYr/YX2ZRcRIWW8uCI60bf+W9yh2+BXSodfSxmzLl+XciVaRg0L1?=
 =?us-ascii?Q?uSEe1EqjmxI8z1cZwGbzH2Lr6npGYzDvV55XeSw8kqr+kem9nMVSGfPpTRzk?=
 =?us-ascii?Q?EHxW0LRLiHsOzSkMIAfu2FnGqkUaJ39x/ETVQybxlBGIPpMgIvsobQZCGXdc?=
 =?us-ascii?Q?/LLSH6t6ypHBNUtxBOhczpG4Ke/UtUtIJgZOhQOY3v3iIgG7a719lQoTEACc?=
 =?us-ascii?Q?DQVwoLf7c70AL+benUXCrtvLm+3t+KGQM6P7M/9XBGfxPulLX+pD4iLTfg9a?=
 =?us-ascii?Q?fPpaDMQ7XN50za2uRfcTW3YGQhmCdEWxdNDJUwOiqwO0bGxI8O/ccGWohUHZ?=
 =?us-ascii?Q?Y1P20tMfbivz4vBTAOpFnjhgUBEvln6DRNkMZ8HCJdQS27/sS8X32TnTxM5i?=
 =?us-ascii?Q?tJWlX3YjLl0alacTdrTCvc+FJjnlRyEFQ9AiAT1LPIj9qtRtzYWds/4HK/+X?=
 =?us-ascii?Q?jdTg/4YQA/vyn8BGLwF17o1TtupY2oiVo1HLOoo4u+3F8ek17ktbHJjdv2Pk?=
 =?us-ascii?Q?BPgmjczNRLEppH6Pj+QDvGs1iDesYd5SOoTG85w5VnL6wezvmVKdeEzbm/Wm?=
 =?us-ascii?Q?2CKyOA3IgKRrvOo34u90B9WYOWJ0EkZaY2jymU5EeU1/zcMY46xGAf7CLtL5?=
 =?us-ascii?Q?e7tZ/W60LbihxNfh693fbI7EOXRZrAQ=3D?=
X-Exchange-RoutingPolicyChecked: eniPyRavltW9pn8c87PxnQ4ncV4gEjeZcxNADcOboc4zVLgaRuDZz0RbzANisgjnR9+nRY3FXN19MWc+NLrQek49GC3oYGP5q325ikLeyD8XF0Njorv8sH4/3VS6ceUbAl/5xwFb/Owh4ucZnmos+00kkJFAUwzif8J7IQRUY12LGZGyycTYgz6i6z7lZWuERYEcyZlmrbhhCDPzJ01YtaRbHE5xtDucgJLaH3A9jBT2V72ONj/S/2LZakPG2+NdfElX4Ls2TjoALpaPcG3AuoFb8Gjwz3lOdhmmXgouGOrCjiC1tIaSked+ppcz2BxS3mbaPsrkZDHig7OFCWTdZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 196f64fd-64b8-42d9-5817-08dee322eab8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 10:13:44.3082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M8tYfKJgqhMVuMXIjiTB2PneIn5rH5JvMxrHW2/nmejOJa0xlHWUHXe+LE3OGJj0S/a28aTi8djOkvskzSqvil21uP5AwOqUmDfcm0Da/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB637721
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

When a driver's fbdev probe callback fails before assigning
fb_helper->funcs (e.g. i915's intel_fbdev_driver_fbdev_probe() bailing
out early on a DMA/GGTT pin failure), the fbdev client stays registered
with fb_helper->funcs == NULL. Any later restore, such as on drm fd close
via drm_client_dev_restore() -> drm_fbdev_client_restore(), reaches
__drm_fb_helper_restore_fbdev_mode_unlocked() and unconditionally
dereferences fb_helper->funcs->fb_restore, causing a NULL pointer
dereference.

Guard the fb_restore call with a NULL check on fb_helper->funcs.

Fixes: 2ef5754c9649 ("drm/i915/display: fbdev: Move custom restore code to new callback")
Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 7b11a582f8ec..77ae9bd5ef3d 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -146,7 +146,7 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
 	if (do_delayed)
 		drm_fb_helper_hotplug_event(fb_helper);
 
-	if (fb_helper->funcs->fb_restore)
+	if (fb_helper->funcs && fb_helper->funcs->fb_restore)
 		fb_helper->funcs->fb_restore(fb_helper);
 
 	return ret;
-- 
2.53.0

