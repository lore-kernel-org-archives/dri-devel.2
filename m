Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E28CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26D510E2F1;
	Thu,  1 Oct 2026 07:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HPtg3Ys6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D910210E07A;
 Thu,  1 Oct 2026 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790840482; x=1822376482;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=jMptLmJVzXWlc8tw86J9xrWbqjiJ7RtYUhdyzsPX8Mo=;
 b=HPtg3Ys63voFIORxmYRXh1f6MUpdCPgP2aslq8WdR1XGTP/c5y9WtGg0
 /t8sNBDBklMzJgtkOO5TEh9FPF6eg/Zw+06v3Ftwa+wsUHVIDiILgL5Qo
 gu4mMHgUG0S+Yw0qxzK2E60xZCFz8Q/MjLrqWVXjaEH7yAqrxcVmRpwF3
 OhydXDuqxrHWaIG/gj0gcv2aXsJTAGVEMtemJW8DJsbfjKmK4mVpp+I9w
 k+pNN+Qq+PWGzXOWGgPHfSVjwDhv09LtFn/G3lM+KXCl8eGG8x7QkKVS0
 n/S9lT2myEjQful0PkAGQuRgEezc1hcHGiK3aGYP3xRDzDpBjPXiaO0kV g==;
X-CSE-ConnectionGUID: o3OL5fYlQv2sQbf3Tpp1Rw==
X-CSE-MsgGUID: lb4NznzNSH+N8kr9keLI4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="79151458"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="79151458"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:22 -0700
X-CSE-ConnectionGUID: QarkTXwuRviK91+z1ziHcw==
X-CSE-MsgGUID: yjDiHM71QtGzFx+lZWyTgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="279216735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 00:41:22 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKrOlEHqioL02dnCKzPl5fHV62s8580qUCtoZoImEBMAlu+FQpBWY0Qq8g4rVEiUJfANR08/e3zIJ3HZE7i1MiQTikUv/pzMZSDbVOCfotGT0eO+cLFpWh1/6PBSg1R74l2lgV2DjIORWzXbJrRYgKvB7/2czXgkOC0eZ+98PJ/gx+ckVXUrCDx47qxzoiwhyhwyvF1wylNaJQgXpaAS3PhWsCeJ5dEXIKmfY7vfZBtIojBVxX0kYzyKHlOmwqQ5w7eNeOhVqIS/L2sKFArWXjpcxFJ9l5Z27yx+q+qaxdWyKyxCHs3Sz1SNoKEIwQCLE7At0ZlA+x+oe8IjS970QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6YHmu60wiCau6CI5iKqNZoPbFyrSHh/7+VoP3KDZ5A=;
 b=OJelGCW1APhjco3pSeRnunrnWCskZDCTAltr8zhzkWNza6DsO96Xxot+NIrZGfGuW630smnr7eZxcOnqR6FlBUEhD6g9X74isbSSrTOgJmf80MLjS20jvkVMWhm6+jzi48S3SYgGpv19mmHFysCd/Pk+HIdvuQUusE9rsGs8vKEX3s3jbCQSN56WlARwWfT1IxzSiR4vPJqlYuwovwdUuHb0Lzo7j/KHP1LePQAg8okIgkSKRNnoaYk0+INcmixz6cV8U7oei80fGgNVEk/w59TKduVgFG6jBGWUuu/vTYQ7Z9NPu8OWKt8x1q/8WhjNRhydvh3PrDnaZAowA2jZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:41:14 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:41:13 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 0/6] drm/i915/selftests: Modernize printing in i915
 selftests
Date: Thu, 1 Oct 2026 07:40:54 +0000
Message-ID: <20261001074100.2694888-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: b24754ea-04c0-44b9-f692-08df1f8f5e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|6133799003|11063799006|20046099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4xZcwvmG3/vHjea0M2S5ieIhqXqH8FOyyzwajLA+KV6Xp9P44UtCXwVkV2VuD1dGBDP7XlMuJLGUwCwFaevXVWNsJVKECVm7lSmh8szbDIaGJfOE4BpxkyAuhjlpdYGu0GIniuaKfV8xYPn0Ak5nOd630tlhKjVyFlLVX5tgEALo+3WQecrrsXVzNwjvjX3plN9H94TIwtptkBZEGZVWRgvJpBmdnpYXhyiQHc5rdzQW0/f3KXIBiY5hEFjO7+jSOffjjb5h+s4NRNgo2JOev4XhXAGU77c1GBJEP+TWq5Yq8/65m8/v0TRydwYnI9ggeLFiit7gDN/d84wDS/DS1tMLTZGz0sv2cc0WWEljX3r+1QAMqPhAuqv0NtYFW6trto0RqklnBImOHljqZQONjDU5LdItsMrqQJcnhZohGAxh/DmvxyZN4CXDQygzldMzvcELz5BwsosPQjSrC9SVh9ipiOQNgJ7uEejDETPhKZVubfpTaiXZpbIRlgcoX3QL/KeLBtTNNvH86dEdB6VYjEfrBpKzkuDAHf328PSGIn2s8k91CTkzjYci9smtw3dLZG1+aP/HLxOknHa7sG5Bdf710vvOmSt2CW+watrtXPeygMbsQJFx78XKBTeLgJkDJ0at0MEmDpb/Wy/nrZw3Jh6jcPVmOgMjvyBFwGck+iE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(20046099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xJbP9hVxFrx3vG7VryYFEjMUwVSBFTBZRcCNQbRxjyxFweFuHmp6kZcaxSTz?=
 =?us-ascii?Q?0WPs42pC2e/my0GLtbqkPX3DSXC8ch6OOI3MqueE/CQE+A0ov1lakdQkCkJg?=
 =?us-ascii?Q?AjY+DWp5Guc9cJJoNKpOtWVR9bMiajWfhARiVM48kOhrsZlCRdiAHeiNiy3w?=
 =?us-ascii?Q?kZFRKVU0OKh8jvZyuhDHzTv6Lu6atHzvx9S1RmGi0ym7JOO3LG3a73UCa6VT?=
 =?us-ascii?Q?o7cUzM2EQn/T7rxGv8dj93kI9bcR8rHQXy0JK/bppCtVQFPapqgp50TEuzFG?=
 =?us-ascii?Q?GifOWJGLn5ToAQHfeBMYwu9J4go+uqTSsxZ4tLyH/i1A+++zgaFhyCbcCesC?=
 =?us-ascii?Q?AcvpfbD5ibtUv3+aJl7KpZSq4JpmcLHUI6C9sWpl06xVjWi9rZHS3eUcUNPk?=
 =?us-ascii?Q?mfxgWy8eCztWlM79wCjkYh3KypMFrRu8zBGdhIgV5tx76Ll7Nxov+QlRpXRW?=
 =?us-ascii?Q?G7d0tNqtUUsaiatHQWXYxLo//NaeIhPb5EVKoBqjV7wmaJSvufx8hWXS4zYM?=
 =?us-ascii?Q?F26O0aecf+E9xr8g/H/WsALLH3XmAyREamEnY04kf8wl5C/Z3Fy/8kygyF0X?=
 =?us-ascii?Q?w2mFzGsqycsuNMXEnQvsUtUUQtyvE7vQJd0k3ZNHNKN7OXt3tkhNIqoaVndl?=
 =?us-ascii?Q?4D5O2Z7V+wJ8/ewgy3q20nMllJnRxDZwIIZ1hmPfy1VjwAnlSey/5hNRg8KY?=
 =?us-ascii?Q?ks8+NVGtHQssHpZMIREE4ZoqEDGyITAhW/KBDDGcDsI0+OsDup0OmeadFGLj?=
 =?us-ascii?Q?QgOe1dAWG9h44sjgZ9ydsG2+BY+WIqtd7HDHJbj7Q0XnCXl0oZIlDjPzzKPv?=
 =?us-ascii?Q?VIVsiRwcLgpDBNxVejdMTmmXec6u0S5XYXevV5JUO1jLpjpZ7q9Onau0kp82?=
 =?us-ascii?Q?Y47+clL82E2QsbZegD+3I4l3P2H3qBmqbWhMbuUWaESuvTyAUQhVs3mEAO7b?=
 =?us-ascii?Q?1ZyGcKsXBS52r4eNtAyChszS77DNuWVdZekVtjlACipoALwsFgcuDaV6dkAA?=
 =?us-ascii?Q?9jaBAOiKTKTTmEgKIBa3luObb/iZef5r7BR+B8OGtRRzHA4AaPVb77b+DOtD?=
 =?us-ascii?Q?mZA33ndib8EYdrF9lHXKrAz+dkiCQATlPJcb3+lFUrY+2uYoXJCMGWFjjfjX?=
 =?us-ascii?Q?CdFSe8OqOh2zLKN0sfZsqcMdSfsuUHo7BTbGm2lCI4Wh6w9fDfKDuU7b6Thc?=
 =?us-ascii?Q?UXd71/PD/r/SuavF1Bm9mhz5mGjC7lRRceCdUQvMz6PckpLxK6PvcYU8Q6fR?=
 =?us-ascii?Q?wxAx0ffeeN/dCorX10GdA8P6MStrKdBjr1PRjcJMITqtGGBciV51EwymmE+2?=
 =?us-ascii?Q?e/d+ehUbPWs40Tl9rKXTGwzN2nXQIw5iBaiB9zglFv9LcBWQznUWEIrFEcm4?=
 =?us-ascii?Q?Q/hByQsXocdslq9Zcd3MmJOQHySjdRT7R++HzjHkg9Oel9KWAq4+xTSS8s/d?=
 =?us-ascii?Q?h95fOPVE4aPWJvnSW3SpRBfFZISk6CUm0nc70CcMW9lK4Fp35w2pVgm/eHAF?=
 =?us-ascii?Q?RFmHI+oVvBRwyBIdRe6sfZhPuuOhmBqjjK8/ERsQd16nvg8TBb1lSjv754Lw?=
 =?us-ascii?Q?qlzmZweyrgDQM80qkn40fbSsa5rkf6V3cGco5yS+3AlHK9JNdB2YXnqBm5Pt?=
 =?us-ascii?Q?aglJT5TDtP+8uKDZ320AMfFnK/eYsB0R0zEsfacnyOC9TXLKzGYbbEJoabEA?=
 =?us-ascii?Q?kLXWyHxTs5oQmhMaQ8GIpIlA4gvbCa3WmYOviRym/2vW06ALpC4Lmi1DqdWA?=
 =?us-ascii?Q?RiA5sSyoNuu/PwaLJpyc+yeLTWV7f98=3D?=
X-Exchange-RoutingPolicyChecked: HKV43Hyp3NTQEW+jW3tIjhQ06nvxFPZhYPMDgA2EwrI3ScxlRe/kb5PMrJiNde8kas6JEIz22XJMdShnfUhH25Hnn1T9iMrD7bG4hT6qp4jwU18rECiz01CTLsOpUWjsDEedNEbTRtJyVGBrlatTwfmWjczKwo/uiN7hDLwYQjKs5ojpufyvSFYsFf4v7iIqfZq5RY6BtSz/9/7qL0KzbIXqx1xY/P9tXuxtS2Uyt+ySBN5qOnE4bE4wURUm9CTek8J+OABqdpnyLkwOlP6SNlKKM3G8deYouVrq2R+qZfD6HfUbOaVBg8P3zdPahgJlo3uk1486uHmet2X6u7lC7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b24754ea-04c0-44b9-f692-08df1f8f5e65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:41:13.5943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZKPfjg2AidhVVggJOKRYi0sAbmyJfo/r5nDafWROcsHpSy1KwyS9S05ecjXqHz5L+kwhJZqb95A3pMKRJiDmxEHM3Sriry204jb9AS0Tv8=
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

Currently, in many instances, i915 functions call pr_* macros
to write a message to the system log. This way of printing
lacks device context, which could be a valuable source of
information. Many files in DRM already use drm_* prints to
include that context, so it would be beneficial to do the same
for i915 as well. Start small and convert i915 selftests first.

v5:
 * Reverted adding i915_* family of print macros (Jani, Andi);

Krzysztof Karas (6):
  drm/i915/selftests: Use gt_*/drm_* prints in core selftests
  drm/i915/selftests: Use gt_*/drm_* prints in selftest helpers
  drm/i915/gt/selftests: Use gt_* prints in aggregated gt selftests
  drm/i915/gt/selftests: Use gt_* prints in gt standalone tests
  drm/i915/gt/selftests: Use gt_* prints in gt selftest helpers
  drm/i915/selftests: Use drm_* prints in i915_selftest.c

 drivers/gpu/drm/i915/gt/selftest_context.c    |  20 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |   5 +-
 .../drm/i915/gt/selftest_engine_heartbeat.c   |   7 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  31 ++-
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 243 +++++++++++-------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  21 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c        |  25 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  47 ++--
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |   7 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c        |  32 ++-
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  20 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c        | 126 +++++----
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  79 ++++--
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  24 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  70 +++--
 drivers/gpu/drm/i915/selftests/i915_active.c  |  12 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 ++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 ++++++++----
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
 drivers/gpu/drm/i915/selftests/i915_request.c | 206 +++++++++------
 .../gpu/drm/i915/selftests/i915_selftest.c    |  10 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 187 +++++++++-----
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   4 +-
 .../gpu/drm/i915/selftests/igt_live_test.c    |   6 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c    |   4 +-
 .../i915/selftests/intel_scheduler_helpers.c  |   7 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
 .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
 28 files changed, 958 insertions(+), 509 deletions(-)

-- 
2.34.1

