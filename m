Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C62C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023AD10E487;
	Fri, 28 Aug 2026 10:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QBk3qsyC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3F210E487;
 Fri, 28 Aug 2026 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911444; x=1819447444;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=2mWejYeBEpDTe+C6yoyUp7sF/ccaPX+G6A/HOynOu0I=;
 b=QBk3qsyCoANBbXgWeeUVLDDJzhYQkXDbN2fDIZMHIlLId3qqPTw5IYKI
 nWqVGynMvBfz7mj259QjegzgOAq7MUbu5Fu+3PH0wQp/J29G3xE8eMgTu
 x6oGq9jkbQORCk2hSYq6lYUAYcLJsqFu7/mAqdQfFTRh5WjrJRq8xHlja
 TAYoy9q3HkNl0IyfXOXcM5XzyR6XMhCImFwYOxItJIT3EQpHBhRUfiUNY
 fM1OCAO1Or93aO+qSJqC92DeztDTOE9Oo97q/gN/l3TEF6TtR//ypKyzd
 dJ3nlccXqglcH0v1xIxwdKtod+PPPssTEHkQQGglY8J6CC/m24sMo92Q8 w==;
X-CSE-ConnectionGUID: 2hYMBpGOR9eUqXrm6rgWxQ==
X-CSE-MsgGUID: xoBAdnO/STStgkVuvFeBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92231312"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92231312"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:03 -0700
X-CSE-ConnectionGUID: A58N37XXT82k4DizDIJ5tg==
X-CSE-MsgGUID: g12C5jxbQlWApKeqHVzzCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="261973047"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:02 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSjg1lC85oHHIO6Cs9PnNsxZef/WP2s4nAy9CtBQiv83UTHFPL+M8jm1p2q4Ak1Fu6qawN8rCZ0Xpu05nFlmgcF624FN+vdIWxqEsRgR4Ey0juZEEmmiKvI1boVZU8FDDCGJSAtAJNa7+5axDtvQPP232MSEjocg2jqdV2ZGjzAl5ChxvT8heo/1QDTTKQaGzTN7IE/vYyM/Xh3imGFjXGTU0tYbHDO5T5XEtKyNWIJgRtrKJx9lTTdLXwSm0Tn1Z1q87hOLDz5pS+IL7QmZQV2vNRZ4RhCfmqYnWuiDIeRBm6GMT6AoJcm/ImIYL/JV2UFpuH8DEs3gliPP8DR/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPyb2mj2eZGqfeNsSp2QIY6egTmkO3RdhScR00dyWXI=;
 b=EvwKq4ptt7pi32cGz2zEM0dKgpzq6qNr5HkcGqZzR0fR3eOBsRSbT0ZZ3zzyPUjTSoQ3flEwRppPidQieMPohhQgr9+glzTDUEszkWS1sR2NufIdY+hzC+R1dynvwf0agy4kkh1mfdylG/8SKdZyNVou/H7NOGQphgcwjbwurnYKQBny6Y8N3QFtDOZHDzSo7mC0tBHv10yjFJDBLpslJxI8/N3blLcx3w7aA9D+7Uz8KZzqZRm5+33I8q08Id28J8qD+WyD7pAZsr7ykDDf1QBViPI02yK+tnen14xgMNHGp2o3q+rZ8KSPYF7umhpfYCv43nwRC+3/fDbDj905pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:03:59 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:03:57 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 0/8] drm/i915/selftests: Modernize printing in i915
 selftests
Date: Fri, 28 Aug 2026 10:03:31 +0000
Message-ID: <20260828100339.72304-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI6PEPF0000022C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e5) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fca2a49-f434-46ac-56b0-08df04ebace2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|20046099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 7Tv6fe4zJoYUI292C+2lopNzJui1Jp4JgzUNXes/ZhgaQrdoD3/mAmyaIIplVaK8NnU+b/nrkHF5UbWp4BfNZjkKVCjD3GO1ywr4F07iiwKLvpRuwIg8sIKaLPAav1vDA5j9EVAUSdrEd6WhtVSerRak/vMnEfwXzmz6QTikbpeuZ880a4hd2ElF5JWLsitllF8IwxvzHfcS5+tp2HbJhznLo1fCzDbZ+4hyRLQU5W9U9mh+BYRX0/Ao6/2ZtoJkftSVK8rYcdGOWfKf9ngX7jOetmNq6MaIfp887OY6Ju+pv2EWw1OAu/0v8gYkz+OkUcK+PHdFFre4xC0DZpNHr7gzrVrgYmVWZ8NGaPqZMA7WviLjd8Z9HhMk0zw6h5Du99wI8t90/i1h7ZNQl15Moom1RQXY4g0coNhpSYU9YgJU6RJXcCN4BlIOeisXrs8RFUMeQXMLDjYtTyHnrJVMg6OeklZZL0TZWZgZqMKDwkJUVFEK9uzptATXsmAIEGUKKXwwtrAE8vjTAP+FAJh2Dhqcz4CBt8U+my/fqi4FLfluwjBa5M76PYKMouX2SpzR/fT/xiWvI6tTKPG8Bxna2PUFBAMpfYXdE5UzP/8c/eJmvwvFxHc8ZwYHEi6yGC1VgDAoUoilR1qZ5LPan8D5wb+/7iZsWok/GrYN9CL3loU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(20046099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2L2O9W4X5xFnr1ix4fzok9ohY6ZU4iIyklslf1FrBjQ1YKR0xW9DJFZmpFtw?=
 =?us-ascii?Q?XHAjgos1kWR59sWfX247OJBDPXOJ5qqzcP9JNy8FqEFHS2d8+DzhDLMExyLJ?=
 =?us-ascii?Q?LK68rPCuMxbWPXTLPbtCFoaB0u5L1dOrhHq8DXgBzjNen80ZaZ9KtHFBddwT?=
 =?us-ascii?Q?DyefSERCTutLnj+NNjinjtLGG23Vmbr45tRu7wofeZw9TsCFssysvOdmvj1j?=
 =?us-ascii?Q?ORh0/a6ApOjsiTOJuOL0cUWkgGfmSymNucNOS0fsQ3X7UTYWae0CiI6QAoHd?=
 =?us-ascii?Q?orUSPhrYRUX8zmxIjrVOxzmZQNMXS3AACPe/6imt/ypz2AW0rXPlCEeGrVaC?=
 =?us-ascii?Q?CR01sU606tvurSqogMKUHYWScbJ91e8T98wDQqAT0vt40wwsLmXtI6FgvByJ?=
 =?us-ascii?Q?j8O0GO5dCNHOV5FJ2kPkcRN+ohL3k6u8Jsd+LSNsvdkS5NwqFFLir8gsA+Y6?=
 =?us-ascii?Q?nAXep/0RwetqJ5+MNKB4RhEdipfz/V76kAZ+tMru2ttCmxSZiFrgzzWsnzgL?=
 =?us-ascii?Q?5wKrcqC1aGQqif6XJaopgsSUXdKxgCxpSF7PepUHrpjA6/GfRcGygiuVz25Z?=
 =?us-ascii?Q?S4VHLx5Q1m1Uo5gbrjnWOHiunReERFA7jsrhCZvNDY2ujO3acRWWGBle9jbL?=
 =?us-ascii?Q?7f4YdIJb06Aij8tm9aXxqclp9eBXKprl22ZwAF4c3dQLJEa2L/Z99OnoYZCH?=
 =?us-ascii?Q?69FNK5Wwu/nSK9P4YzC8825KdW3xdF3vsWZQIve6dCsC+yBVL/jyE3buF08D?=
 =?us-ascii?Q?J1KwCJaLY5Wz6QpuS2+4TcjLGhTFnv6gY9JnSBGe6vl5HhYsRaxztK6Y/6t2?=
 =?us-ascii?Q?/MFVNJ8lA/zJW0LRVEEIeyZaGDtMI2rRdzg08s1b11qSIfjrVqx/fmvYwe+4?=
 =?us-ascii?Q?/KY+XtIMA1QYzTFLjyjL3eqe0eBREKIapWnhs1LTZ0hKZH9s1Mf6OlyBykip?=
 =?us-ascii?Q?h1DrIXxeDPUwSSg50Fvk96XWafFzbYyG/z7Rk5zId4YpSvKvxrUEv9lNyUwC?=
 =?us-ascii?Q?/LJORPZ8JLSkpOkC+pY8Z09VlyhVolYstqFDRCIU45JY4fAVPcRQ1SQ/KAPZ?=
 =?us-ascii?Q?ya67kkhwwpc61PiqLA3T1mHhusGhKxdNhFQzlZc8cmSJ04oY008+HtV2y7+C?=
 =?us-ascii?Q?N9LpnpNKnOKtEpJDxFgtDKGs+oyVUtRS+VGX7UHrarCfMTj+PEHDGzE5etIu?=
 =?us-ascii?Q?cOLkXwVDmqkAO4TtcgDj5/G+UNJH4NPaZXczcHDLDyTMPxgHLj9oZhN0LkAd?=
 =?us-ascii?Q?arKVvCB2Ia2gRmMx282cAMe2TKuqizmbO+suCRyIMmL22Y8MshCfrfnWPVPx?=
 =?us-ascii?Q?LG/VNBaTYk+CqJbwKflN+t2f9g5angWGPnA0gsB+SOPixR/H0pnrmK5Me/6I?=
 =?us-ascii?Q?8iz2N7eh+jemdvBeXDzOHROkduj1WFEeuWXwT2CevrVpFVAyrav+TEX0HZ1m?=
 =?us-ascii?Q?nR+wr84r7eE2l6gx6ZCRo01b2ooAy7X2qXGBkTH/oGfVUswF1HneQqgxWQN5?=
 =?us-ascii?Q?wu1HmkSaNchvD93+EMlwA1yHFEMum/ao+k1Uo2H6JWruoeiLP0N6CfkuATek?=
 =?us-ascii?Q?CWJ3IcfeGO7vY5mSMIoo/RCUAma7ftjiBHQ/nqJY1BuwjOs58lp7g9OwZ5HD?=
 =?us-ascii?Q?4QdPupOGB/dwB+bgIhtNSK1RCC2nEutpF78T5irzrNQhWKuse+4t3ALgPbC7?=
 =?us-ascii?Q?m+naStoBIQDkfwQqcAISGr65vxMPy05D87tkw5VjuMHbmRzuNYngtV1Yf1EO?=
 =?us-ascii?Q?qBTgcoQ8MmNPWjO0+IJcZ3BhfDNxMaQ=3D?=
X-Exchange-RoutingPolicyChecked: qF/t26+b3/Asy1j+zsiMwMroTYAdwn+KHJhhj/w8QpGqgudN4QczPSk3xebvranMXoFr1Z3X7NSuOQdiwjLX1uGoUWfXyBmb5gXgYRXvAkoGwQWelUZwl7j8u/KLYpMTVJlHbSYWH9EG3Fu0N0JDHC1f09ZFaumayS/u7ru4offhUsC0uStyGS9BdF2QjrTIpdZIbAowuqVQYq2wTFLHUIevaASKiZibwDHwxk9fkpQbdjK7AS5BHNFEYgyvZtKwJBgia2SuS8oWRVptDgZqh0XJvt8sx6ecDtIvM9/+leg5r8LgbgcIojgKKDS5PFOCQEMPDE97MBYgtpapn2EusQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fca2a49-f434-46ac-56b0-08df04ebace2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:03:57.5665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxO16BQijGOYC3fRfA8gpgGYD+fyxpsEe63XYn7ZPStZGRoI8cM8gk73qAKPkcanaC7YvamGOz4RsUJnRRpiomSSIF/SK4ATdpw9Tb6l5MA=
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

Currently, in many instances, i915 functions call pr_* macros
to write a message to the system log. This way of printing
lacks device context, which could be a valuable source of
information. Many files in DRM already use drm_* prints to
include that context, so it would be beneficial to do the same
for i915 as well. Start small and convert i915 selftests first.

I do not anticipate this series to pass BAT runs due to
filtering warnings and error messages in our CI. Since the
formatting is slightly different, expected messages will be
detected as new issues.

v3 (Janusz, sashiko):
- keep pr_* where no device exists;
- pass struct drm_device explicitly through selftest wrappers
  instead of casting void *data;
- fall back to pr_* when device is NULL, to avoid "NULL device"
  output;
- keep lines limited to 80 characters where possible;
- drop unrelated reformatting;
- introduce local drm_i915_private variable for multiple complex
  dereferences;

Krzysztof Karas (8):
  drm/i915/selftest: Fix a typo in alloc_workqueue call
  drm/i915/selftests: Use drm_* prints in live selftests
  drm/i915/selftests: Use drm_* prints in selftest helpers
  drm/i915/gt/selftests: Use drm_* prints in aggregated gt selftests
  drm/i915/gt/selftests: Use drm_* prints in gt standalone tests
  drm/i915/gt/selftests: Use drm_* prints in gt selftest helpers
  drm/i915/selftests: Use drm_* prints in selftest headers
  drm/i915/selftests: Add drm_device to selftest wrappers

 .../gpu/drm/i915/gem/selftests/huge_pages.c   |   4 +-
 .../i915/gem/selftests/i915_gem_client_blt.c  |   2 +-
 .../i915/gem/selftests/i915_gem_coherency.c   |   2 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |   2 +-
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |   4 +-
 .../drm/i915/gem/selftests/i915_gem_migrate.c |   2 +-
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   4 +-
 .../drm/i915/gem/selftests/i915_gem_object.c  |   4 +-
 .../drm/i915/gem/selftests/i915_gem_phys.c    |   2 +-
 drivers/gpu/drm/i915/gt/selftest_context.c    |  35 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  12 +-
 .../drm/i915/gt/selftest_engine_heartbeat.c   |  15 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  60 +--
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 355 +++++++++++-------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  36 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |   2 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c        |  29 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |   2 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  69 ++--
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |  14 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c        |  59 +--
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  30 +-
 drivers/gpu/drm/i915/gt/selftest_ring.c       |   2 +-
 .../drm/i915/gt/selftest_ring_submission.c    |   2 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c        | 297 ++++++++-------
 drivers/gpu/drm/i915/gt/selftest_slpc.c       | 105 ++++--
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |   4 +-
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  41 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    | 106 ++++--
 drivers/gpu/drm/i915/gt/st_shmem_utils.c      |   2 +-
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c     |   2 +-
 .../drm/i915/gt/uc/selftest_guc_hangcheck.c   |   2 +-
 .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   |   2 +-
 drivers/gpu/drm/i915/i915_selftest.h          |  16 +-
 drivers/gpu/drm/i915/selftests/i915_active.c  |  14 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c     |   2 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  79 ++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 227 ++++++-----
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  31 +-
 drivers/gpu/drm/i915/selftests/i915_request.c | 307 ++++++++-------
 .../gpu/drm/i915/selftests/i915_selftest.c    |  71 +++-
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |   4 +-
 drivers/gpu/drm/i915/selftests/i915_syncmap.c |   2 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 261 ++++++++-----
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   7 +-
 .../gpu/drm/i915/selftests/igt_live_test.c    |   6 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c    |   5 +-
 .../drm/i915/selftests/intel_memory_region.c  |   6 +-
 .../i915/selftests/intel_scheduler_helpers.c  |   8 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  49 +--
 .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c  |   2 +-
 52 files changed, 1455 insertions(+), 955 deletions(-)

-- 
2.34.1

