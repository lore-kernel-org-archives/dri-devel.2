Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A652C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B60910EAA1;
	Tue, 18 Aug 2026 09:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P+2/nI+y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F0C10EA92;
 Tue, 18 Aug 2026 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047007; x=1818583007;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=aH1QK5XpcFsYjH3gpB1GTN8w2P9UmOIHe8Rm7szxJ0Q=;
 b=P+2/nI+yjm9ci824xs3RHG/oKJJ+5q5vI1eVp7iePpyxpVeChrIxN2ys
 PvCO3ipmspbzgWgHoVHVAsqHYmiU350oWqmV7qSnqLcgo+kNn9a/DZdhj
 cRtMpDKQIPnyfMpHfjHkI4MJixoGt/AyW0V+IIeu/Iy/CMwVMilXkohQM
 SiQFOzrbSZfzylZ8FkiK8e1GpxKOh2piZaWfIfJ6rjXCyOG8pfyUoAVOa
 6fKLQ0CtHblXnELneKpNa7AChrxLu6VGYW3dzlVdOm3ASDJa/5TkDuwi3
 tH5wgNiqY4NGHzLkPdsnPjBvVXAzUzb0B7P8Jx847V0kjqxFVI45Uk0ZK A==;
X-CSE-ConnectionGUID: qL/vllCFSiqZSCENIfNvGw==
X-CSE-MsgGUID: 1SxawdicRU+Of9pu+7hZ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87655728"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87655728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:41 -0700
X-CSE-ConnectionGUID: tFXKBtY4SEaRvRkbRwFDgg==
X-CSE-MsgGUID: lyeBQo+ESqCB9bEy8R4m1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="264736723"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXSWWLOvNx1QlHTQBKoJMhSTWt1k8lfae2DC5tX3NBfoNn93yyxPi3lp1VNpaX5tTeZA0DxRKDeApP7bjGA1G+/LrRm6mulMnpFKquOxiUlDrLwJTwP4daMJzkn+8T3rIrzMWmvp1MdqoFaAJD0ZmnV/UwOHXIiCz6/T4aqRcaWOOthaF7PnLGgSkS+JdSiGumbqK4hnCntBDBicfWYpJNwEo6xe2pn7YMSkeWdwdCnZy1cV3gKY5uWogSXYs/ZtuH6GDNZG+9w7in5xUCtfEVjBU1tkYQhTy2DYL/9H7OQHfFwhjmL6Ob44quIi0q/pYzLTjY9KrHZ64BLcz5wz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vkme1649pTIEddhglzy6lR7UN5csqupEbdd6G+RggY=;
 b=UtjrNkX9ujY7Y8Z/Pvn6vNL+lz07WQEgOM4OVqRyYq+43e5bxod/ZiPhiayzKS7mIA435x+p+STYEyhJUwzUoBThmsM5ep6khPA00K3CGGvUAF0PW7c4+ls8ee2lAAZW2x5iFBfLQGKb/9rgZY7yoaJdh9UqRZtyiCsctzn6q7dK8QrmeYF6GgdIRJU/b5/uJovQdUc7+k949SVEYsIn/fTYb5ekvlchMJuKkbKdLrImDr9owxwSamaj061AWcBY8QSumMSNk5HSZtGMc52jG/Okq7o9oKt9a4wBOcHwwm7fCiDxzLyXiqXg1VtZ+so7bwzDsbQiLYMC4DH3S9f1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:33 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:33 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 0/8] drm/i915/selftests: Modernize printing in i915
 selftests
Date: Tue, 18 Aug 2026 09:56:16 +0000
Message-ID: <20260818095624.3254368-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::6) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba5c71f-334e-4af4-b2f4-08defd0efbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|20046099003|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: KNsb/FgI6Hg7/T6AmREIaAjKJpfEnDL85BqbXqk/Pvzngb7AwDfx1mR0J2EfKTMcyliyrQJt50UvLB1WyIQfaq/cXQI17rDESYNfr0fkGb4fF1Dq4RTZDi+vEF75a3XqTaCtHgS2SLOlU2dtwl2mghvJ2WtyOwFYt3YSzTnmKyZxqfXtE5YVrBEjPZZcByWhq0PztN18Xophbtlx/qwAqLUGpQZEZLRHw6y3dUWmGmoIvtdYdqxah0Vz2TPbcdbQCQsCP0kPRPPjPsmrabT3lI3j6ecPFa3jBQHzeimhfgBQDRemuZvf+WHiowjM5VCJuvuinkLIZgZWcGhw2OLQWdfbyQUzFdZfJDF4UzE88b9WWunIQgnprvC/Jq5BTNYCtbmfhKyEoQnHVSRVVLdeVqp3NjnN7pdK6wnvdN59WoKB9EXPVL5ba/AQULLvtsf9z1CCd3gzZbyCYz+PlGoENtz2u0M2SLxkEGIE+tH1TWTPZswKD9OR3dk+4ol5aQT1HMC19nyN//GoRy6Qw5H2oigZyOPZF3UEMbyXGTYB5VZdzfbBdNFRlTAnTuj07Jb1WJOFBmrnuQ2A/xredncKidQTvi6eSTUN4RVYSH+ePxIiKY3J23y8qqSEXVRyX6+7VZGI8vrkaoR4mAwOTOGqkDKJfq9oW3B//4EuXR/BnCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(20046099003)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ca1X7SkzhlzOtceacJZUPgZo+goSJFSlItUR458WkhaDNqzP0X2VO+v+ovgm?=
 =?us-ascii?Q?VSUegdMoBKRCrjF/6qr/RDz/S/RiSRE5BO9Qfcbhsn56rdMliIzDUOwolTkc?=
 =?us-ascii?Q?/HJFS5rR6DxnE26xh5S5jJgdGmP5KOK5kPvyNFbB8fK+bPCbx3/YFG7FxZAJ?=
 =?us-ascii?Q?uVC24v/FerR1u7ZYKVgdnNS1m7VuoSUHJ4Vb5cUDm/dQMphjKzF8D55MFGTZ?=
 =?us-ascii?Q?cwoSTMyb73VvGdgCwLpYwA9ICGfPVjp3/4DJOsb9BsTaO2VCFB6/QvqUXXYb?=
 =?us-ascii?Q?4JGkVdjRUox/Q4SPYD3k10yXfabJg1tQSd4Gz3oP6uL+A+t4/DTxXfTuB0V8?=
 =?us-ascii?Q?cdfU2/WAMsz1OfpVK7/0SBy2mRQKSal12ltmXZyDQQG77tvW1/iXCyktgoKk?=
 =?us-ascii?Q?jl363R+EiggDkfNlzGDxnpacV8tr5Df8meaDSYn8ZOzg2ShN4hxixca9Hgwl?=
 =?us-ascii?Q?/7CXc6F56PliHNORoFtZF018F7aLghJV4fjnkuUJaHsbmL2tddM5gQp9CLva?=
 =?us-ascii?Q?J0pgHmilpk9lIH97kn35JrbUNmVFSfr3j3KdjH8H18TLNXEa/I8DYq3JFc+k?=
 =?us-ascii?Q?tZdSH47PU3B75ATkEq0rSWn2W2HO3dhmSRzdA7rxEmxzSeGb8IhZWxk/hEf/?=
 =?us-ascii?Q?pOZ67ss2RmMgGhHs07PFgO5BNNoAi0LKWoEeDAUfQHvUFdIdkdsZvCp3sZ89?=
 =?us-ascii?Q?OFUUpqdfb5wJfOEBoAdNrijlaBIW+SrcQgGvWMhTqj9A+8pvR6vaCpm8JIqu?=
 =?us-ascii?Q?psOdnz1jZAj+YBbmpIV3x52RMdE7T7+SP6K1fEXaZDFP0tAFTJo3rDlky3be?=
 =?us-ascii?Q?hoFoRrZfnQJF5JK0m4bLHYkzHIwYQg66Ak4Dra8TRQ4Ke0Mv+1tz9haQGCAZ?=
 =?us-ascii?Q?kii5Sc9abj6yzV01GjhDXuIfvDnlklVVQX/hOKjPSGeApLYkP3xTyRLd6SjN?=
 =?us-ascii?Q?NwAWf584sZimQtrgPBBwOZCs5YxnoZGAc9kTM5PvWG4sUlg+//gZd9Mf3kNi?=
 =?us-ascii?Q?xYiTALVJgsdGzjxcZaFRNotVSAuXGuSSZJtrSZi+aivCfYvE2jULs+2tp21K?=
 =?us-ascii?Q?HXQzw3oIRDRg6TiI25PfrQepMQcr8THbSKsj8do5wpMdapOYUfR2g8J/SmVk?=
 =?us-ascii?Q?lbqX1fft3Lt2tf+InIb8Nq8bIGaCblcDo0pV0MXoQgh6U1ckqPLoo5gF45Bb?=
 =?us-ascii?Q?Yix8+l1R7n9ylMZlaWUNYWsg50u067cDVtOGVPO7HOKsLlz/RGr0fd94JSs5?=
 =?us-ascii?Q?un47z8b6F2eS5z5jclBfKnJ52IK8yWV0Q6byJhy9vUOiCX03722+G3Er7Il7?=
 =?us-ascii?Q?WVufE3ZzC3z8g2ClznY4ERRtTp+7vwglEpt3xKPElU+HrVkGdEzRYAEticTQ?=
 =?us-ascii?Q?Zp3sK8MUwpOW3jTkCxbWvDYAl3eD3RVCl6uRNwZxnS9nciFOrO1n2Nr+wGKa?=
 =?us-ascii?Q?PMYsZAZD0xTJzE/odmX4VtmW9JGTt7mOFpdAhocU8DmO+n0A+t0+izmi/9fD?=
 =?us-ascii?Q?u4Qx9751RtGurN5wDTbwHW73O7hisgVo2Uv1YH4G0UVRD0pGnWU63dkb4WlN?=
 =?us-ascii?Q?NUtgQKY/ygFX45PTV4xYQpI3ccK6U9ZIANDDO4NtwYRJ30JAjFJ+J25oL+5N?=
 =?us-ascii?Q?nDCkKSTAolpUffRAGKUym+pGV8ggF+utN6hZ0P8XFzVImgDBnCbbIDWG3zY3?=
 =?us-ascii?Q?Zp/9N3nGyQC1sx7BWOeue6DQT67y6y/xwM+FvF+/tBYhdnYse3oo67xcmiJz?=
 =?us-ascii?Q?jp8bE2LMMjX0AT2e43tu3aqzky/3y/0=3D?=
X-Exchange-RoutingPolicyChecked: gMvqe8QGAsbJd6rH9FBbhWYcGbZN3zU0r1qqYE7t0bbRAlL2LTdrjj8x0+E/8bsQ/FNip0H4vng/kO6/aYP9M/hAgfSbRsnZ2GIg5xLNhzNXaWFXOKPTaDwCo7sLmI3MQPSVb/iFMjIZZjeGqiLRjraPKV9RojEQifjPQ09jancN9OWOoAKJ5OtCJNj8uPZR57g8ppZiV1zAz5uAp1i0KX61jNdHu3axkKGsuNB+oUY0BTvKN/BO+G1EfJTP9Xj8bhRc9W+8vyevLL7IE4daE+75IgHW7cNOvNoH2UjcW9e/jnMGEWP/Aj1cLD5HAcKmN6kRb/YHxjsV57zDgqMQhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba5c71f-334e-4af4-b2f4-08defd0efbe7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:33.3348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxHKuwdRvtOmLxG2B+5i32VXkQSsDErBdVQA/xbg9YaPlrfXLTjRU4OMzczePttb7ya30nxI/yV0MJOJ6bdUsIsIT+AYVLLbDPwA8cM6bHc=
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

v2:
 * Remove mock devices, where device context is not available (Jani).
 * Fix a typo in alloc_workqueue.

Krzysztof Karas (8):
  drm/i915/selftests: Use drm_* prints in mock selftests
  drm/i915/selftest: Fix a typo in alloc_workqueue call
  drm/i915/selftests: Use drm_* prints in live selftests
  drm/i915/selftests: Use drm_* prints in selftest helpers
  drm/i915/gt/selftests: Use drm_* prints in aggregated gt selftests
  drm/i915/gt/selftests: Use drm_* prints in gt standalone tests
  drm/i915/gt/selftests: Use drm_* prints in gt selftest helpers
  drm/i915/selftests: Use drm_* prints in selftest headers

 drivers/gpu/drm/i915/gt/selftest_context.c    |  27 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  35 +--
 .../drm/i915/gt/selftest_engine_heartbeat.c   |  18 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  50 +--
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 294 +++++++++---------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  25 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c        |  26 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  51 ++-
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |  12 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c        |  55 ++--
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  27 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c        | 252 ++++++++-------
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  86 ++---
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  34 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  91 +++---
 drivers/gpu/drm/i915/i915_selftest.h          |   2 +
 drivers/gpu/drm/i915/selftests/i915_active.c  |  15 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  58 ++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 197 ++++++------
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  24 +-
 drivers/gpu/drm/i915/selftests/i915_request.c | 234 +++++++-------
 .../gpu/drm/i915/selftests/i915_selftest.c    |  56 ++--
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  94 +++---
 drivers/gpu/drm/i915/selftests/i915_syncmap.c | 129 ++++----
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 222 +++++++------
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   6 +-
 .../gpu/drm/i915/selftests/igt_live_test.c    |   5 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c    |   4 +-
 .../i915/selftests/intel_scheduler_helpers.c  |   7 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  59 ++--
 .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  45 +--
 32 files changed, 1210 insertions(+), 1034 deletions(-)

-- 
2.34.1

