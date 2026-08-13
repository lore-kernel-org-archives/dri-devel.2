Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4C7C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DC610E530;
	Thu, 13 Aug 2026 18:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="leNFQ47u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843F610E50A;
 Thu, 13 Aug 2026 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786645797; x=1818181797;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=B0dqsMpkwIUrnRGCVtdUmeguqcooCthKPAW9knNR3Ts=;
 b=leNFQ47uWP1nCQZQ5Ar0fdzHqqrbnyvu8AtfFC9qWM7GP8jvRaoyyNP3
 36Yy0CcHNQuaKA68kOI69ZqjeCYvy3FGvmsYEIh34eG7+S5ibA9NMej/R
 mMujhNK0eYcJhVbCFjU/Gl1URlj32JCLlm6S1IEejn8yX9u88emBWC81d
 avnCQfMek+Y+DeEfMofOarkI+IbbvqG1rcDRxGn3FRo62uxH7c+XyGLBZ
 HLMH3zl1Uv+LkoL45pTzqBujkV2bqKRp4VwSldrYa8x391oYVz/uf+NOz
 k8BctohR9nkRwUUn7q+PIFbF3uICOneObFr/J4P0BBKhnV3LoMe9Znphr g==;
X-CSE-ConnectionGUID: T1nNUq2iSKC7l1/xFmVLeg==
X-CSE-MsgGUID: T839qMxERXyTXf85sHrp7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87089041"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87089041"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 11:29:56 -0700
X-CSE-ConnectionGUID: T11rymPqR1uF5RHClvsCTw==
X-CSE-MsgGUID: x34PnJ8yQIKgPRVgBDhBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="262689668"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 11:29:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 11:29:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 11:29:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 11:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR4nv4ZaOvMraIN7ujmehV8dVutvgEqfU1ab4cl8jczZ7ZEfTDycVvoBrMBhUGDW8tGGVKKz74hqlPOIi53IyNCv2SsrZqUKAoJCo/GiLVg9R4sCH7ptF47gRx7QXa6v8CibQ4HWHDXLCK5xAdix8hgLprAbGqtDPn90qnp0hEoGKjkqoekUbxf5p+kb49b1LHWFR26RM+TR//YHiXoVgXyuaEP2U/ZTDM4gpHH7p6NrVVQcLtFKFagxl7ceDquyHUaFvzY+uWLrCltcG2UB7iCmevanqFiHVROtkFMPIYM7nzZsHH6+tyGio/dtZlThNvGIqGEiNEoXJVqMLuCbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC5Ct4mUOdqrmTffVTsZdqZWWPYISGYmaDyMGv9IDfc=;
 b=RdBssyl5yorHacuwCyzUdiMvM1et8pRy66b4qVkWCdcc1OkSRH33Q7H20w7nOl98d/QjBU2kkKE/uh1iLDKgZ0o3xMS8liGwl5FlHGTdXJVOLdSffL2AiJgasOjKqLYhf4VMMZugSWdKydh6Vaw/cd0TZv85trdRlC+ahBAxuAbGNLJyOy3GN1+krsO1hMGapdP9trGGOAAGih9Jq2fZN2BmXTwPmZCs+WWmFiiRstIT2Ktx/ydAdXllYfVj+NmYZrKt5kK8hGyzEeEyzInBu+TkmxptOmbRYPYDh5qyE8p+QcmOVT+EWXvR+Vb78PknRWClPdtHlGQe0LG/FFIs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 18:29:52 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:29:52 +0000
Date: Thu, 13 Aug 2026 14:29:47 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-next-fixes
Message-ID: <an4NGzsYN9MOTFII@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CY5PR11MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc6ab59-67d0-4136-5e9a-08def968dda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +i3Pfy7+l/n3tCT0hGDeYKG+46uPjNkhOtnbF92aLHhreF3Zg3KxFRpZooSiEMAEKK6qmLIfOgHcP+nMBGvHRwoDNfTC9uth/TD4OpA9gski2wmE1lbLfWgQozvjWq0q1GtBP/xsUsqLRX2aElkyBBw355x4/IVR+Ct280IIZgFFsFCbsL6XGnadOreldU39JGPWdoO663950ChbEJ94oN7AT8WWrC3ZlWYKbBGKXAALSf1eBS4h7AkB/DrwAFE6X41E5WhBnzBysHJSvHzdpO3atgTUi9axyJzXV/bKFNSnlWqOi2QmzzafmBWcsnOMT2poA8Ns8me/jjZQBWkb3e79MTd/Vdgds4y9UqUVrwu38R3gaBRplNmmEoKg1Sn60ODxsWlFdKNpsoIGrx1ZppuaX2+e8x1IyUAxSeyCIpBXfpkmLweQjGcl8cl7TE5AdPKw6sLciNCJ5PTqt/rTY6BQFUsk6fOEYzf5x+GVZfGKcbJoaXYh8mc/41aI1XGK2rNnYugyNGfDVCcdKcrnRHwwhR0AuSHXLAQwgfsM3UoUJ2sdyNg730R7ZDVB7/rrwzN+iguorbHQrBQqcEle5F+8o0EnaAdMFAykEQYd7dM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QqRiCaUwxpTixIWC3PbZyrK6vErNWzrBsV6IZKeHIF3k08e/XK3/LNYa/0L1?=
 =?us-ascii?Q?mHDZ71Saq3gdrM9gqqPNDlvtwtBw1uLCwYtOSIbSbwPTEZ2Q4gX3fwerPnh8?=
 =?us-ascii?Q?C6T/iR/q86MeZqH8RZFbYhvFj0b5vomF93R5/HBmPMbPQQyG78DH5IjSsozV?=
 =?us-ascii?Q?iKOSLowTESyOZ/SUpVoMVDdTJizoaG5DrLuAs0l2ycaZJ3XBO9MDavKTnnIn?=
 =?us-ascii?Q?ACPQlIpHIDfA/1etcnwsp+s9i6S2fQUdnrxaDMswpduAsQfVoA/0X/hMsu1R?=
 =?us-ascii?Q?JrsGYZIHq8R+IETVGeone0m57C5MlU5txYLBMsbPmuSIGCxPwgLU4fJiRVIs?=
 =?us-ascii?Q?N6sKkSjLwV1l6v4GlZIwZdjmNtKUZ0hVylPtd+XDwnnU6W3iANcPKWF4GUuz?=
 =?us-ascii?Q?m+6jJPcanfnYYNtBK/JEkOdwe8LO6HOWqqhisvDXIrZT/HRKEutQS2Uqsoj/?=
 =?us-ascii?Q?Ap/iWA4bdJEq/yZiLOTVS+t5T4x3rMrCyOpMeSi8B4ubi4EbuMu1RCnWqn82?=
 =?us-ascii?Q?WcRZ7SGnYHUdT4T2I5CIMsn9NuEwRfJz/RPTosG9sthOZNfW37//Y+WqL17y?=
 =?us-ascii?Q?83ib+AfSM+gY7lCY/8wBOc5HBwxueW8rumDOARC3LxHLwuWsPpCxXolSoiNS?=
 =?us-ascii?Q?rxh2zMsYxwCTBX0phcojpBhMkoRG9hXQ0KoBL5tffYaZ2qlRicb2R0mOd3jU?=
 =?us-ascii?Q?EoqTuYSKL6IhgZWOseo+hDemw/h2jiwOLepv2+ym7MkAjAtnU+N0V+VOZTrS?=
 =?us-ascii?Q?GUZBmvbFZ5BaRSz8WB/8NVM+j3VBwx/XG8Laut8qOieCkcjgS7me1UnwUlTq?=
 =?us-ascii?Q?IJH3rwKSZi+eGaobBdIlG73UlPIjAvA/z4MCOFeCHctphd/+LPiZP0YTeIHC?=
 =?us-ascii?Q?2DjPQd7KqNgMlR+lQTO1B3z/HE+vU+Q4MBXZeoCQYWWHpbUY3bmiuJKS6+0i?=
 =?us-ascii?Q?1Jf42nRxVs8vaBXC7uX8AishJQJof/rHk/oD11H+dRNDv3sY7f0M7TbRcroJ?=
 =?us-ascii?Q?OOYzlANeeXIe9HT2K4ptaJFtZkgQcQuJMAwwtp1RHFWEHlf3pS/1oDZcu+Un?=
 =?us-ascii?Q?MML/hcfzEt4vE7FnSmNxt28pDHVqK5xAANLARn16z50oGirWPUo2eQS2Cx4u?=
 =?us-ascii?Q?Vbt5KvH/QUjEnoH8qKoxpiZc1nGt8ZqDPEYdxkcFUajprv8vIfPTfLAkX3MC?=
 =?us-ascii?Q?kIBAFRUZjCuVg5gC+51j7uR6hPZ342m0gHk/hkov4Q9ihy1UYg3+wc+tdBB8?=
 =?us-ascii?Q?lpaauxPOHPtit47PxDuBKBhGT9Z7raryXTqLoO83ejiW7LhqbpCvOozHAqa3?=
 =?us-ascii?Q?fm1vhl/wRuOXEh4IZUlZUaZUnFsi4YvyLDgMiH5lxb27h9fW5DAsr1wRQzU3?=
 =?us-ascii?Q?aPhdzXyJ7/9AsilJfhiFn7rz3qU+Y8lB0NlTW9IWOpRtrsJ1h3r94PL94zur?=
 =?us-ascii?Q?nNmvxPyfe8eoS5AjhFE2Dj2WXhO+9cnOJPcMWuLz2EandTARNT4Aq29+EGOB?=
 =?us-ascii?Q?Ci0r69VGcS823FKtn3g6UMBHnNpbjKEXun0SWrEhmPeKNhr7UYBNkEd4sMIx?=
 =?us-ascii?Q?KL9ryZlyteVijI6uu8XhmJ9KUaEu4hXFZvaMPgu1wlBi4gyh6niCOTSzkQvE?=
 =?us-ascii?Q?cWzb2lfyskifw86nwRIjQcIPLnz6Ts/ZmuDJ9VDjcIuOwPCZqZy61dLhX037?=
 =?us-ascii?Q?C46t06jJglK6CCrdBfGnTrliFFqETJJ1UXiydO4Y8HbXkBYsR3gZN+R8aAHQ?=
 =?us-ascii?Q?ML64kcn+zw=3D=3D?=
X-Exchange-RoutingPolicyChecked: PpOwDJo6kI+TvUwwaCPEgHXgiLvJEYOlQaZtxuew4CWOhySGy+WzvxpXewPTSAoITR+tHugo4Xjx6atQnAWCT2gBty80JUMytUOAJCEr+0iuNWaxDoYtS29sAuidtXM+BU84eekhShcX0/nMDy25rbJrO69PhospHo/Q9dD1Mq7Eoii8zXCpLHfS9dcdgmyy7HKfHvmFZ9f3qI7XjTjh4NsaO2WJnZ+6/scH9UvMd+2R6pGJ8qH/4o/d1qY1Jn5Tj7Ha2FYsclGs60DCrIwEgmDlIKcmcYhc6nHRT3vCmiXP7mpnyrmD7BydL7trj9kN5Lhvi8SS17eFOE7Iz98UCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc6ab59-67d0-4136-5e9a-08def968dda7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:29:52.5826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pzzg4xqJhv5B7TkD3SE+tJacqj4estNEd2og/XOdwANCu4iFYa0wg5zu6ZHgL0RquisuFFj05eNjyJueQE+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
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

Hi Dave and Sima,

Here goes our first drm-xe-next-fixes towards 7.3 with some
small fixes.

Thanks,
Rodrigo.

drm-xe-next-fixes-2026-08-13:
Couple drm-ras fixes, a probe failure clean-up fix, a GT freq
boundaries fixes for BMG/CRI and a Media engines/slice fix.
The following changes since commit 29daacacf4cd84e6917f09de6a99fb170071c14c:

  Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next (2026-08-10 14:48:11 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-fixes-2026-08-13

for you to fetch changes up to 1c4d0c45d762539f174cf1d74b2cb21d18e71363:

  drm/xe/mcr: Take vcs1/vecs1 into account for first media slice (2026-08-13 09:08:07 -0400)

----------------------------------------------------------------
Couple drm-ras fixes, a probe failure clean-up fix, a GT freq
boundaries fixes for BMG/CRI and a Media engines/slice fix.

----------------------------------------------------------------
Ashutosh Dixit (1):
      drm/xe/mcr: Take vcs1/vecs1 into account for first media slice

Raag Jadav (3):
      drm/xe/ras: Fix boot-time ras error processing
      drm/xe/drm_ras: Move has_drm_ras check to drm_ras layer
      drm/xe: Fix xe_device_probe() failure

Vinay Belgaumkar (1):
      drm/xe: Fix a bug in pc_adjust_freq_bounds()

 drivers/gpu/drm/xe/xe_device.c  | 13 ++++++++++++-
 drivers/gpu/drm/xe/xe_drm_ras.c |  3 +++
 drivers/gpu/drm/xe/xe_gt_mcr.c  |  9 +++++++--
 drivers/gpu/drm/xe/xe_guc_pc.c  | 13 ++++++++++---
 drivers/gpu/drm/xe/xe_ras.c     |  9 ---------
 5 files changed, 32 insertions(+), 15 deletions(-)
