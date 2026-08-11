Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B58DC5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3391910E319;
	Tue, 11 Aug 2026 13:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EEiWNByk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BF889C86;
 Tue, 11 Aug 2026 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455194; x=1817991194;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=XLxHycq2/QdJmtRY261TWJ+C7toMLNJX6jKf4X/oTWM=;
 b=EEiWNBykuUr81STpF+1oanuafIjrs3hKz6IRzEuJdBV/qHBftoLASbZ8
 l1slVYd04T6d72CTZYFeWkt3sAGyw1oRxJMoADbW0dmo+NvX9Cq1sALhl
 WAgfZ2sDdirCo3btW/dUQHubA/kJAqMlP62ptRB1z8HkTIa+UO0R76P40
 PFkKIGK0nQMRcPeLgoa9Dmg5XHpEtELAdK1wFsRf7Mywr4gLTjNlbfDdf
 vPEIKtJQEwvd2f/ZcNUaB0zuorZuI9AIXeF7E1cWyjkj3ird+zKCaWZJ2
 JC7JYcOTCit7eb3kyAl23wieyXbXo/spSYoGVko3lKYNBHhWXSy9g6Gio A==;
X-CSE-ConnectionGUID: kKlA5Zx6QbWMdlWAwZXsQA==
X-CSE-MsgGUID: NQ7QyAZ7R1ihCqvhmNFjoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104374847"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="104374847"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:14 -0700
X-CSE-ConnectionGUID: 93t18BmBRYaUNWHoC9QczQ==
X-CSE-MsgGUID: Yypuk6cdTmORw5hQBPuISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="267187680"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:12 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0cuAyZ2FuNpAEfhgr8boYmACf4iBRvkdi/U/gLoa2+7QBLJjjejACKPeDf+tW07pjEqFM6ItMortkLyC89C4F0bCZRYxBKlcFxtBypDeE7F5WT0zEbRT2v6yFVBUS5ZxFw8sNMm8iLmMrDWxOz0o67L+YgjntZae4Vg+0sKMr2pONil8hmS4NDPYDqGxhJjHlxKvaX1I4F8axlFSK1VJywuqO1p3Y0Glyaeue0pha69Ugz9QxCGbU3ne47JREsxDCqdaEKVe9zEWcFcXZ5knFQyyBFtl2AN0rxt5rNSNibFKyUR5EOGOcww/ADLxQU074kjgmA+JeKm3gH01hmamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3hB1Xw/gLK06992826S7qdfmoNnwuDG/VsKPBUb9pE=;
 b=PQbb18IDNzWRqGc5pL0lKx+/oIWK6XIpI1Lfl4ZkOa1L/z8aeQqB2+Tn87/sJBkLYzwHpuxqtM0DD9fdl8+LOAN0EVgqWH4L6QQ4vyaw8IOg17ZhZlucY173nFEoPfclw/Elc34A9clVv1KAt+KJ4qQHYuhN4bkn40G8bx3meXfT+geMKbETzc7qAZOsj2Nv7MLdhKKdrIlFXEKVEW/lE181Gg8uPwVTf2n5T2pFjz89i9cEhzTJwi+B+GoHjgqx5Ld067FKWm9xNQaSXXyFE56sawIexcBRwVfWq0rg3V4Ql4HwDJ+BvMO0MBFCHxdM5HQGSkY5j6RK/Awf9ksLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 13:33:09 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:07 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 0/7] drm/i915/selftests: Modernize printing in i915
 selftests
Date: Tue, 11 Aug 2026 13:32:50 +0000
Message-ID: <20260811133257.1133097-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::20) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3a9585-980e-43c3-4748-08def7ad141c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|20046099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: XMrSt2QHIwrNlOqp+JrsVV91WYbxb61XlT8WBcMl44HnwRvu46UG1BkumPU54T05S04qOrJbqtlFxeGu4Lls7GzacLOzmGQoFNgsHXzG+aB0pUKuQVRh11x0Ui3kz2cc3BJiSY6n0uvblOR4rc0U22bABW9OqsikQIBq4ildey9dPXu2ueleOz56xRdTBYqTZymVRyQb7yFPVtnj0gcbH8hC6LjEo2bqO2abz6rs+rVzLQaYjk6q3i97GCWJ/C1YzzlTuVgJx2e3dTeT1CGJtCClRkAn31jE9iFe5yvuUgvXgEuB5FjpsM/bfsEdmdsOpGdknmZ9DkSKP+HExoDOUqfZkTVKMlQOkfrRbRKXyVg2wsY9wdAPuPMkTxde0rlSOte34bTZ4wnbzo/Wqo4NCiU+OF0Rq8dSwMjydkTDgT2ieyql7QZdnuMCi41nnstHwGUUjIveY5pl+OP480TtzPZM/DhHRvuqvWXThA5U+YZ+97jPa9AUs9osHopJeAhiMQrVsWZ7RMhZx83S/q2Tofho3TmUwDgZs5fpJ1gvzpoKHLlVsvAn7UVHlKyb8D42rODJZAdiZ2sdW0Khm+5PboIdNEMGR4lLrQQh33ZAHcjD4AZ81r0HeUZGHGcdOcEdMHQN+Zo4eNoNvRPV37sexCkiIepW8qiwnFPZYe5FJOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(20046099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ITd8aKRHGNj+nZ+Ny46i61P8aFS4zBdN8DnpvGiYasGJvLfqGb1sIN9PJLM?=
 =?us-ascii?Q?8iHde4N969wrqTiYDkeK1LQ8nIz2KTI9KV6w4wEFMDcn1bJJPAAgqxBo+0Li?=
 =?us-ascii?Q?CUIvRpNEhAQ56Zz3tZxPxYS+CUW5KkivQjy64eWZIjetNfmUlcTFAy1PtBZ+?=
 =?us-ascii?Q?TPviETx8G87vbwJQ5oZHqe/Q0iw5U2Rqpeu9fxiDmEopN33FnZbigp+azvEa?=
 =?us-ascii?Q?+BFzVKha8pqjPRX1zz3EammKst+OZGfkxrX4t0PrHfiyHuOo79UvQFkMWK5C?=
 =?us-ascii?Q?Q3/CCzJwESqGisUf7QzbAx1iPt/jsoBrPIQrvT9THDG73VFBHa2XS104Jxxk?=
 =?us-ascii?Q?x1EilMcrFDpeDpIgcb38j9H3iwCy+vDuJmVcHi8ctfU9h6hKUY8I6lQsHSQD?=
 =?us-ascii?Q?Y75ibGzAHyjwV3Q+fsuIB5hUljQpQCDX2piUWCBXnxCjECtriEpyprf0BPGH?=
 =?us-ascii?Q?RPQkgIYN93NZSQ42rTbXuq7l+HVWjQsenrjLQJ+OH1kVHQqOd177zx7hG8K9?=
 =?us-ascii?Q?WitMPjCOuVyEpn7nz93vd/Vz0QnlP0AIL1/tdnz2y37QxIb2tTIl/K1OlnjN?=
 =?us-ascii?Q?eipoJzwN3dgfAO5ddaOlFLpN1RbyAIDjmdyVkbhwpjyg+cUln0VOx0ehyfWG?=
 =?us-ascii?Q?LAUqqQqUay6+9vx6O19CGd5fl+oTQYOo5szMXvYzyiLxTJqjYguHYIptd2cn?=
 =?us-ascii?Q?O9eQ6oT/k0iLkBsJ2kVTQc34mLt0tLVkuKJDagIkesRJi/j28VcQQi2r7mlx?=
 =?us-ascii?Q?jXWArDh7Is9ZNjimzRrBlPGMQXLa6eohzUo2MszTpzBzLuiSBIn5cLhk55QV?=
 =?us-ascii?Q?5owQ5oBJgpYVRm3lrU7R6+kLTsZPZL9x5p4NqFHnX4tQswKt/CzLrbcGN5EJ?=
 =?us-ascii?Q?5SKtW0Bj9KN7+d7V1bm6kVa471l8T+w55pnHcpuU+EmXPxWal/+kMDykJ8Qn?=
 =?us-ascii?Q?bykpddR6ZJFALmSgRPBgwcAWHY1uLGwsoSF0phhLLwvTcGvu5ob515gefDBY?=
 =?us-ascii?Q?qbmXE9h7NNmjHJsCbC77D6OSGIieI4DInyNIwY/HPmL+0k8HhCu+LZKdyi8H?=
 =?us-ascii?Q?Wi3msET7doTgPa+7mYJnl8CS7XX3azmJ1l40kc7g22NpslWikj7R0pga7Key?=
 =?us-ascii?Q?mEu3JouX3ukmD7SoQzgs4jeuYQdDH0z/NHrzgMO5dBAs6ZzT5T64OZjzpIV6?=
 =?us-ascii?Q?RhHqDBhFpP3U77JPOHe72qpmHRBjuqXRjwkP4Hzmw4cUZlr+ZpVwyRbO5Lw6?=
 =?us-ascii?Q?onw7VMFrJi5LR0kX7CcM+TnwnY0VQ5IVWNae40bMurqqhWSWEhde0T11WgPd?=
 =?us-ascii?Q?7duiCn2AFoUSY1zG+tyVFz1RKp9RH6R/SeznGk6AuprnAL8+EjUBBBigjeBT?=
 =?us-ascii?Q?F9JKRDXqulv57cWNELY7uhKm/6gANsv/iTeokJqEjr79Nw0A50kH+Yyqm7MV?=
 =?us-ascii?Q?XhXkpGh9z6U9NmbBgRb8FxyqZI1UDyVFaoYycstwIs9/xXCOub6p0VaUUTT2?=
 =?us-ascii?Q?sLY/quTPAxh9xagh2rEq0t1JF9hvv4SOqo8pNh3cOgoGEHJBPX7+FZrAik3n?=
 =?us-ascii?Q?bwtdmwRhHChqubF5T7sJ+RM5fEPiA8fetFfoPpFiLBK4nMBk/Qi4TAl7JVol?=
 =?us-ascii?Q?9thBqhLCagzOQkdm31N8wUhzcaSlD6jNoxmQG4sr0sTh0xy4MkEFAMoo33wR?=
 =?us-ascii?Q?Y1jV1ydR4jHIiICgvoMWAO6tvrEz3QWhSgQoZGtXc/EcxgEYiqW8ulRN4Gkw?=
 =?us-ascii?Q?cSF9XQT60SCNJfDD1O/SU4Kq/gX4v/8=3D?=
X-Exchange-RoutingPolicyChecked: O5yn79oJmQ6FI+j1jW7GbqepVyPGnMXtvsgjYQkzAHCk1ldWW1CBIJ7lR0o5TKWCS90O37L0okSAFlgniy2Xhl1Vyb+qfdlTycU86kjUOMoHNoHY98rs5no/BLB1O5TyPuHQUkRU7c1TOiO+2Plzjy3mNOXeF8gb1eWgli9ZrAd87kxbycF3lRYXyyvvM7sNpCQ9nLFxK88RGP2PWnj0TYorhB4ZXRakPVybfkAVeptk6JYaC9ZI02zYP6jVJaWpIKwlMUFeJ8ih0+EUAmdF+vM74jrun8q7wtwE8krWycPAjVRExz8KgVDTl/xBQw/+pcGeA0W+8KYgCd4lTdP8aQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a9585-980e-43c3-4748-08def7ad141c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:07.4445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbzjtTXMBPcdGLkXnyQUt7ODRHuFpbjgVpYnpQ4ssJ2eG2XElI5roEu+MMaiKaFQP8WxZmmijD/ZwOEb2r+P1TcBCe/Cs4UsDduV1hDo9mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
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

Krzysztof Karas (7):
  drm/i915/selftests: Use drm_* prints in mock selftests
  drm/i915/selftests: Use drm_* prints in live selftests
  drm/i915/selftests: Use drm_* prints in selftest helpers
  drm/i915/gt/selftests: Use drm_* prints in aggregated gt selftests
  drm/i915/gt/selftests: Use drm_* prints in gt standalone tests
  drm/i915/gt/selftests: Use drm_* prints in gt selftest helpers
  drm/i915/selftests: Use drm_* prints in selftest headers

 drivers/gpu/drm/i915/gt/selftest_context.c    |  30 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  26 +-
 .../drm/i915/gt/selftest_engine_heartbeat.c   |  18 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  54 ++--
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 290 ++++++++++--------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  30 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c        |  26 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  62 ++--
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |  12 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c        |  56 ++--
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  27 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c        | 218 +++++++------
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  85 +++--
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  37 ++-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  99 +++---
 drivers/gpu/drm/i915/i915_selftest.h          |   5 +
 drivers/gpu/drm/i915/selftests/i915_active.c  |  15 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  69 +++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 198 ++++++------
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 +-
 drivers/gpu/drm/i915/selftests/i915_request.c | 144 +++++----
 .../gpu/drm/i915/selftests/i915_selftest.c    |  56 ++--
 .../gpu/drm/i915/selftests/i915_sw_fence.c    | 124 +++++---
 drivers/gpu/drm/i915/selftests/i915_syncmap.c | 205 ++++++++-----
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 225 ++++++++------
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   7 +-
 .../gpu/drm/i915/selftests/igt_live_test.c    |   6 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c    |   5 +-
 .../i915/selftests/intel_scheduler_helpers.c  |   8 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  89 ++++--
 .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  75 +++--
 32 files changed, 1388 insertions(+), 947 deletions(-)

-- 
2.34.1

