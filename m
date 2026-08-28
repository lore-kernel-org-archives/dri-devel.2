Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E19C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71AF10F32B;
	Fri, 28 Aug 2026 10:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SEE8tpNI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B280A10E4AC;
 Fri, 28 Aug 2026 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911458; x=1819447458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=CQts+NZ/x/AeBOLEJWCWYre992pJkQgmsjZc5zSupGs=;
 b=SEE8tpNI6mehRT1sywpS2lUYTg3rb4miihLliL00NlsGibrDppa/nsc/
 kd1Q8OjDNtl2r1eTXUC7ENdRXO+GbWL9tuWWxqkKHAVgg08EW/E0Jos5T
 oaNP0LZQC6jTrx9pEQ0LaH8tk08jCKKWO7sXEPklqm4NK9sw8wrxbPec/
 UjwiBZNAQYJwaup09loyXwNyRqvT3uw01y819SFiP6xpti9IVQTW5622x
 ZnZxVAmEPcGl3scDaJ/CFVITgoqPvwamIclCrPI6x2tA/h3ut8lX49rV+
 u9biRv6aAEihlAulAyDr+ra8VIX7LcvHnLhzCYooEDuk7pWvz+JpWQONO g==;
X-CSE-ConnectionGUID: 9HB69trWSEagx0UzBHh+sQ==
X-CSE-MsgGUID: tYLlQa1lQZ2CqmS+nwny3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88541273"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88541273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:17 -0700
X-CSE-ConnectionGUID: oekkUP/ISuqDN6jyHX1nFw==
X-CSE-MsgGUID: IhWLJ2KlR8698JL3QvPtdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="270070587"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOHlpBLPIOGUT4eNIZaW4C8Errkc+PRsPggP0mQglXLaHL44BkzT50go685KD9V2TNGX9Fjp3bATDufd5CvcnGzT14Pg7AE37RoDAJK7Y1Kwp+A0hlSiEd3z3wsx7Fkax+LWtbHsg1Gr96V7FaLhNVLdGF9dl3MlQ0RAmDY89FbqRwAZI1CaTKOwBVzAJlUl/P/v/51zRf2W0kKwVnxeaxm6W4t8kR9Fmeuy6pJRyqUohTkMCfHwjGO2WFEed1u60yN6lcpU2cKLp2Vj00/h8ONwAU5E+ZX6GWARAoyfChaXYXkGYM26RQ9D8i8R/uSnVJR1lfSlvsnVRv6IWys00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MZ3Sss/dNOEfT2RsExdZmgEHiQ4ZDYFlmolL9/GmZ4=;
 b=NJDAyGBFeuyXGiQchSfFFAHmn9QNoVSdJKE1D/zujFukcKlXYrseGonCsfrMUwJpQfs4CSF5RBrZxp1wUEO6GcJ7TqLqkXBo0lQkR4lbER56r8sE7AQ/aNs5aCuoHa/e48bQjFfw262pUCd4EkDZPZdDOALQbjqzKkODvrGADzbrUMoQZNqPLesPdCxwdWpFFwvG9S8BWii9NEPt9ADQuhy7+b+ti4S6nXJUSkcwvb1Z+ZC2RdBoKfnTpIDFYubdu0FFx4Wx/OuQvansX1Vrz/t9PSl/dnkJoSQ9FD61WoJvDG43C9XC2IcTVocBVRln7KPMAIkPfWpL2pi4VlqbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:14 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:04:14 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 8/8] drm/i915/selftests: Add drm_device to selftest wrappers
Date: Fri, 28 Aug 2026 10:03:39 +0000
Message-ID: <20260828100339.72304-9-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: e344af51-78f5-4121-824f-08df04ebb702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 0nkpG6d35UlRXpZk2/oVykJTbcPiQMC021nCmb2kqnKllDlCiVuaD9x7kS+0iz+xr9tla5+pCLFIHYvHxMlLkY/t0NQg893d6JYGcrsCq4yxNofRpxIPTjZUZHfgq91gYUjP2tLfsBmI8e4tgj6Mggx9XfgkkNrcJ9QK4B6pJ0UKrtHZb1LMsHqvbUE6C/TU8K4UTMVJFg3VJzsBi89DXJTZ93OMadol5vw5PWF5fSa3CP2Ltq5A/ckJ7LS45sKvxFgTXuKm1el98/vTUy2Cg0cYnUG4GbyunC+lVwujIwqjhnhFRYBm9kYdz7AqgvRj7MtrDtzdN3aO36+iU3MQC17xSMAkfGDc/YPgoqmOqHzkIOvh6PodqYpwgf8GVGHx3Z55WaEO39mUX1+987wPHfWefgS8UGNonGWhhTDKTlGqMmN04gAdpcrv9xkNHk6r8c/iK5kUTXpYdakBgqzexXmHZKPwgpLkBR/hRvgFNsS62hAsi3pM7Midk/QMSCF1K3sAiKuqXeDT0XSs7wjbLFwwb0n5XaGLe1oh5zUImlwwozbpJTJRnnSXU3HIGm14luMmsxEVkAdq7OAenD3EEhdlHBMGvbkKUPgaUp6LMMvU4tyjKzYQVkiCEfwn5ON81PJagsgUnNv3h+XJNGGWobaBt6DqOfPUKmG8q5uJJLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?giKB5EE3siwKahREzG1tZxcRq+vVNUw/JLB4W7UZMnt/GEU6bQlctC1mjsXD?=
 =?us-ascii?Q?tIQ1KjhRXe8eiUh4paMTYEtqVz36jb9EW3cpiBkzHSNprsfMPSkGEbrONth0?=
 =?us-ascii?Q?ms6du2rp14OeNy5i4a80NJWxYdCc6MJzk6dkJGXrRkoE0PTCkl3+lGD5WDhX?=
 =?us-ascii?Q?DpYa6AS+Fpcip74rP+qkvannvj3koBy0hiuaQH6EKXBnOK1EpzDfbUH4sfY6?=
 =?us-ascii?Q?CSP55fd0hkZcMG6QHi3xFGbyDJpga0PXnIQBXhLt/lfxAkVER7hoRhqQe/L8?=
 =?us-ascii?Q?bXD3m0KnY/6Jkgk6/BPDdALrOx7VIevJMzZ4ZafbSdLPP4Cn+SpCi7Kl1Mfb?=
 =?us-ascii?Q?s2gnTV8/k/gZ600UX8P6ynE+eZO08VPoLAnG/ltuF0PIG13PrjJnbnZcG+hJ?=
 =?us-ascii?Q?D3YnlA1weBUXu808PXqiR097L7GUjCAWWWWuEUFsb3QUv6sCxrxdZM4R7mSY?=
 =?us-ascii?Q?25KMnQDxkDZ3NUzzPbYi1Dg0ZSbQvE9YCurnmlCzOWRD6qysTQXrdVd3zdkJ?=
 =?us-ascii?Q?ZGxmzK6YCVjznfcba29zhB9PfSnb0BwgqtHItNmZpd1FcH0AG6jyyvEaeqb7?=
 =?us-ascii?Q?cvSq2g2dSQ/W+VoHxo+WYa4MNYtCJt9lDQFLcbrzDnf4k9SPhnn5+BV+xi9S?=
 =?us-ascii?Q?OskOjbRYbGownFaRk3uRTH4rRwKjTnTrcj/FyqOv0zQUmkmEDq14JaDrydcJ?=
 =?us-ascii?Q?nI66TJbH5d6mlZV3/esrRiCHx8W00mW3aLRAJW7rgzjFmgmD67TStWDcxPBL?=
 =?us-ascii?Q?DTP/VRLdPD59tMsuZBFw6GYGvjXuqRmxn60SL3WnUihkWZbADa2XlcnABqlp?=
 =?us-ascii?Q?tFQO2vWeNyI0PddMecGKzg1V7CXZVpPuy/r2vqzC6bAX3pVsZ0uqoFIxpmZb?=
 =?us-ascii?Q?9+aaeKAurACAtpHbIBwt3SUC/xz4P6LDH0CWeaOO/FAIUX0JoUFVhg5Rwea+?=
 =?us-ascii?Q?XU4AgB4uIb5jaKm4gx/j5L4iHsemnxV1ON5TKAC5WEpw9lSGppvgxFYrXAXQ?=
 =?us-ascii?Q?4v9dEkNZj7e2w6SN4mDkbytVIZwMjGxBQjnFm3TgkA3ktd0rSdNUm+JzAeUE?=
 =?us-ascii?Q?HuZNQwbXCZvEo2HUekuXpb7w2uj+FQeRQm9NuZcqOCn5e6IngYnX3b/THZO8?=
 =?us-ascii?Q?442YSPM+CzdmUeAYZLfY8CH9ntspwthvFdf28Ve/KvMo36a5DVSy+xkj5k5T?=
 =?us-ascii?Q?17eRVEC+7ODCRAPMeCP0Fe6IgutngPMaq/xITBFAoRWlCi6sYTSsoOeVt4h+?=
 =?us-ascii?Q?RAq/Sun5oV8Yakc1Tz9xGZlbIvoYJHS8LkOdX88PGqV/FNL1EF0st4eIRCs/?=
 =?us-ascii?Q?/JvvYvAfqQLMbyF6yQAtSt60rlaSK7ZCvHsS79d5myfV3IqNHDE3U0GXVrpY?=
 =?us-ascii?Q?WC5DKAqhoIHMSy8F1WPdhqR7LvNtMdItkcZ5/r7u5B+cChBzJdzXmCgbv/iZ?=
 =?us-ascii?Q?ZuN4TkRbUcKoJZt6wMwYxX6IqMlSXqVjic9Dk1O//NQFtmXTUKmoqg328vjE?=
 =?us-ascii?Q?WKeoBshm7QoxipvDeJmhlOuMG8kH9ljE1RHqw2+jmDwyh/xfwox3dMTr95CI?=
 =?us-ascii?Q?suH5Dn9EnrtBkUMLop/ZFy8ccjhM+992cvWBabPrsYSchsEz0iRCXSScH6hi?=
 =?us-ascii?Q?Oq9E61z+n0EcTEmegORiMl7GC1o8/JKa9Mz/N/tW8ugPtwFhMZ0A43x/hNGm?=
 =?us-ascii?Q?SxJD0Minit0aBGbRX3Y4bVbFjYxE8jHYDRQAUlnBQUQHI2Yw/MHsbyxKgM6x?=
 =?us-ascii?Q?fjuwTpBaRPjWMYDoaRcUrDvDm5Flw5A=3D?=
X-Exchange-RoutingPolicyChecked: PSprSaAK8PWjiXQVOXMvvGmI1DSChRIBZbxuqiAcJpQ8efux8WVVz48vWXrMOn9b0rcJEIS/daM18qLckSVt0rfLotcW+305wjWHsJOP4pTpUie15Lr1n0fPrlNdbFVbyXvRSp7/lxIdMv9o71kXB2fNkc1i3wK/wT+KkVScaY3UGZIpIlVXDEm+p/hfnfiH5cbdIM5t4neDVRNyr0JWJb05rxfVlx7eqTnaeqMBINOHNZycqUKMewOQoIGXvP3FpHyuuwv9QmdIm8Ui+IOpgoPWUw5fkjX65gopM1cyAA20RQkUmXRIUNnY4+OCAeobjz0aPJKEklMMIbCDVeEdGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e344af51-78f5-4121-824f-08df04ebb702
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:04:14.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UsDTk3h1hwMU/M85zxuOS5T52j+fqQdlDzSO1ItjDCX5TL1Yg2FjTQxBs8fBiiDNDiDQXfVwiTKbiTCZtbuJ+9JJVxB0MIrrrYt+0klI04=
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

Pass device pointer to the selftest wrapper macros, so we can
use device context in message printing.

If the caller chooses not to pass a device, use old style
formatting instead of embedding NULL device into the messages.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  4 +-
 .../i915/gem/selftests/i915_gem_client_blt.c  |  2 +-
 .../i915/gem/selftests/i915_gem_coherency.c   |  2 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |  2 +-
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  4 +-
 .../drm/i915/gem/selftests/i915_gem_migrate.c |  2 +-
 .../drm/i915/gem/selftests/i915_gem_mman.c    |  4 +-
 .../drm/i915/gem/selftests/i915_gem_object.c  |  4 +-
 .../drm/i915/gem/selftests/i915_gem_phys.c    |  2 +-
 drivers/gpu/drm/i915/gt/selftest_context.c    |  2 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  4 +-
 .../drm/i915/gt/selftest_engine_heartbeat.c   |  2 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c  |  2 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  4 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |  2 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |  2 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  4 +-
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |  2 +-
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  2 +-
 drivers/gpu/drm/i915/gt/selftest_ring.c       |  2 +-
 .../drm/i915/gt/selftest_ring_submission.c    |  2 +-
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  2 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  4 +-
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  2 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  2 +-
 drivers/gpu/drm/i915/gt/st_shmem_utils.c      |  2 +-
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c     |  2 +-
 .../drm/i915/gt/uc/selftest_guc_hangcheck.c   |  2 +-
 .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   |  2 +-
 drivers/gpu/drm/i915/i915_selftest.h          | 16 ++---
 drivers/gpu/drm/i915/selftests/i915_active.c  |  2 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c     |  2 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  4 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  4 +-
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c |  6 +-
 .../gpu/drm/i915/selftests/i915_selftest.c    | 63 ++++++++++++++-----
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
 drivers/gpu/drm/i915/selftests/i915_syncmap.c |  2 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     |  4 +-
 .../drm/i915/selftests/intel_memory_region.c  |  6 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  2 +-
 44 files changed, 113 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 44718e728291..50199faf0a0e 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1991,7 +1991,7 @@ int i915_gem_huge_page_mock_selftests(void)
 		goto out_put;
 	}
 
-	err = i915_subtests(tests, ppgtt);
+	err = i915_subtests(tests, ppgtt, &i915->drm);
 
 out_put:
 	i915_vm_put(&ppgtt->vm);
@@ -2021,5 +2021,5 @@ int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
index 1d4d7cfb3f9c..48ac2b7d80df 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
@@ -742,5 +742,5 @@ int i915_gem_client_blt_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
index 2a0c0634d446..316bab3d86ab 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
@@ -430,5 +430,5 @@ int i915_gem_coherency_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_gem_coherency),
 	};
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 9d405098f9e7..f85f4b8b1ef3 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -1912,5 +1912,5 @@ int i915_gem_context_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index 2fda549dd82d..a1c611d287c8 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -541,7 +541,7 @@ int i915_gem_dmabuf_mock_selftests(void)
 	if (!i915)
 		return -ENOMEM;
 
-	err = i915_subtests(tests, i915);
+	err = i915_subtests(tests, i915, &i915->drm);
 
 	mock_destroy_device(i915);
 	return err;
@@ -556,5 +556,5 @@ int i915_gem_dmabuf_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_dmabuf_import_same_driver_lmem_smem),
 	};
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
index d8f4a10d71de..553bf14f8274 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
@@ -524,5 +524,5 @@ int i915_gem_migrate_live_selftests(struct drm_i915_private *i915)
 	if (!HAS_LMEM(i915))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index d01acfb7d93d..a15bdec2177b 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1860,12 +1860,12 @@ int i915_gem_mman_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_mmap_gpu),
 	};
 
-	ret = i915_live_subtests(tests, i915);
+	ret = i915_live_subtests(tests, i915, &i915->drm);
 	if (ret)
 		return ret;
 
 	if (current->mm)
-		ret = i915_live_subtests(vma_tests, i915);
+		ret = i915_live_subtests(vma_tests, i915, &i915->drm);
 	else
 		pr_warn("No current->mm to safely borrow userspace memory from. Skipping VMA tests.\n");
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
index 19e374f68ff7..4317e6a5362e 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
@@ -83,7 +83,7 @@ int i915_gem_object_mock_selftests(void)
 	if (!i915)
 		return -ENOMEM;
 
-	err = i915_subtests(tests, i915);
+	err = i915_subtests(tests, i915, &i915->drm);
 
 	mock_destroy_device(i915);
 	return err;
@@ -95,5 +95,5 @@ int i915_gem_object_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_gem_huge),
 	};
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
index d43d8dae0f69..9c05e8db3861 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
@@ -80,7 +80,7 @@ int i915_gem_phys_mock_selftests(void)
 	if (!i915)
 		return -ENOMEM;
 
-	err = i915_subtests(tests, i915);
+	err = i915_subtests(tests, i915, &i915->drm);
 
 	mock_destroy_device(i915);
 	return err;
diff --git a/drivers/gpu/drm/i915/gt/selftest_context.c b/drivers/gpu/drm/i915/gt/selftest_context.c
index d9d279991eda..e02eb41205a5 100644
--- a/drivers/gpu/drm/i915/gt/selftest_context.c
+++ b/drivers/gpu/drm/i915/gt/selftest_context.c
@@ -458,5 +458,5 @@ int intel_context_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(gt))
 		return 0;
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 28c019547b34..88f8ee5efa42 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -384,7 +384,7 @@ int intel_engine_cs_perf_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
 
 static int intel_mmio_bases_check(void *arg)
@@ -439,5 +439,5 @@ int intel_engine_cs_mock_selftests(void)
 		SUBTEST(intel_mmio_bases_check),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index d26441ee837b..3d22f1f85f95 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -275,7 +275,7 @@ int intel_heartbeat_live_selftests(struct drm_i915_private *i915)
 	saved_hangcheck = i915->params.enable_hangcheck;
 	i915->params.enable_hangcheck = INT_MAX;
 
-	err = intel_gt_live_subtests(tests, to_gt(i915));
+	err = intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 
 	i915->params.enable_hangcheck = saved_hangcheck;
 	return err;
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
index 2813f0c717a9..acf3ae1da919 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
@@ -434,5 +434,5 @@ int live_engine_pm_selftests(struct intel_gt *gt)
 		SUBTEST(live_engine_pm),
 	};
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &gt->i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 97dc44cf615f..6764d8284d6c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -4573,5 +4573,5 @@ int intel_execlists_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
index 4e583fcb1cf9..534012012c34 100644
--- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
@@ -202,7 +202,7 @@ int intel_gt_pm_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
 
 int intel_gt_pm_late_selftests(struct drm_i915_private *i915)
@@ -219,5 +219,5 @@ int intel_gt_pm_late_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 00dfc37221fa..3234d88a611a 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -2028,7 +2028,7 @@ int intel_hangcheck_live_selftests(struct drm_i915_private *i915)
 
 	wakeref = intel_runtime_pm_get(gt->uncore->rpm);
 
-	err = intel_gt_live_subtests(tests, gt);
+	err = intel_gt_live_subtests(tests, gt, &i915->drm);
 
 	intel_runtime_pm_put(gt->uncore->rpm, wakeref);
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 23f04f6f8fba..0e8c9626ee56 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -1990,5 +1990,5 @@ int intel_lrc_live_selftests(struct drm_i915_private *i915)
 	if (!HAS_LOGICAL_RING_CONTEXTS(i915))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index fb348aa82e05..321ca87b7d06 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -824,7 +824,7 @@ int intel_migrate_live_selftests(struct drm_i915_private *i915)
 	if (!gt->migrate.context)
 		return 0;
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
 
 static struct drm_i915_gem_object *
@@ -1046,5 +1046,5 @@ int intel_migrate_perf_selftests(struct drm_i915_private *i915)
 	if (!gt->migrate.context)
 		return 0;
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
index 770516c6c7da..6b927e7d6c21 100644
--- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
@@ -453,5 +453,5 @@ int intel_mocs_live_selftests(struct drm_i915_private *i915)
 	if (!get_mocs_settings(i915, &table))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 938218e0d5bc..02acac8cd04c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -398,5 +398,5 @@ int intel_reset_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(gt))
 		return -EIO; /* we're long past hope of a successful reset */
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring.c b/drivers/gpu/drm/i915/gt/selftest_ring.c
index 2a8c534dc125..97ffcaadd412 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring.c
@@ -106,5 +106,5 @@ int intel_ring_mock_selftests(void)
 		SUBTEST(igt_ring_direction),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
index 600333ae6c8c..1234b74ee407 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
@@ -295,5 +295,5 @@ int intel_ring_submission_live_selftests(struct drm_i915_private *i915)
 	if (to_gt(i915)->submission_method > INTEL_SUBMISSION_RING)
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
index 531dbc08c8c3..c8096c7c628e 100644
--- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
@@ -584,5 +584,5 @@ int intel_slpc_live_selftests(struct drm_i915_private *i915)
 			return 0;
 	}
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
index 29d860a5c9c8..bd9d39cfdffe 100644
--- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
+++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
@@ -448,7 +448,7 @@ int intel_timeline_mock_selftests(void)
 		SUBTEST(bench_sync),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
 
 static int emit_ggtt_store_dw(struct i915_request *rq, u32 addr, u32 value)
@@ -1425,5 +1425,5 @@ int intel_timeline_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_tlb.c b/drivers/gpu/drm/i915/gt/selftest_tlb.c
index 89420f07f681..e81567067991 100644
--- a/drivers/gpu/drm/i915/gt/selftest_tlb.c
+++ b/drivers/gpu/drm/i915/gt/selftest_tlb.c
@@ -405,7 +405,7 @@ int intel_tlb_live_selftests(struct drm_i915_private *i915)
 		if (intel_gt_is_wedged(gt))
 			continue;
 
-		err = intel_gt_live_subtests(tests, gt);
+		err = intel_gt_live_subtests(tests, gt, &i915->drm);
 		if (err)
 			return err;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
index 8b74d62e7ca5..460233fdb333 100644
--- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
@@ -1404,5 +1404,5 @@ int intel_workarounds_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/st_shmem_utils.c b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
index b279fe88b70e..b00e29737c11 100644
--- a/drivers/gpu/drm/i915/gt/st_shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
@@ -59,5 +59,5 @@ int shmem_utils_mock_selftests(void)
 		SUBTEST(igt_shmem_basic),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
index 63a75272924f..e201410c2e2c 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
@@ -415,5 +415,5 @@ int intel_guc_live_selftests(struct drm_i915_private *i915)
 	if (!intel_uc_uses_guc_submission(&gt->uc))
 		return 0;
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
index 83801c992488..bcce2afaa4f7 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
@@ -158,5 +158,5 @@ int intel_guc_hang_check(struct drm_i915_private *i915)
 	if (!intel_uc_uses_guc_submission(&gt->uc))
 		return 0;
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
index 18077801b2e6..89a1ad08ddb0 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
@@ -180,5 +180,5 @@ int intel_guc_multi_lrc_live_selftests(struct drm_i915_private *i915)
 	if (!intel_uc_uses_guc_submission(&gt->uc))
 		return 0;
 
-	return intel_gt_live_subtests(tests, gt);
+	return intel_gt_live_subtests(tests, gt, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index e29ca298e7eb..f102d61bfa3b 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -29,6 +29,7 @@
 #define STACK_MAGIC	0xdeadbeef
 
 struct pci_dev;
+struct drm_device;
 struct drm_i915_private;
 
 struct i915_selftest {
@@ -88,24 +89,25 @@ int __i915_subtests(const char *caller,
 		    int (*teardown)(int err, void *data),
 		    const struct i915_subtest *st,
 		    unsigned int count,
-		    void *data);
-#define i915_subtests(T, data) \
+		    void *data,
+		    struct drm_device *device);
+#define i915_subtests(T, data, device) \
 	__i915_subtests(__func__, \
 			__i915_nop_setup, __i915_nop_teardown, \
-			T, ARRAY_SIZE(T), data)
-#define i915_live_subtests(T, data) ({ \
+			T, ARRAY_SIZE(T), data, device)
+#define i915_live_subtests(T, data, device) ({ \
 	typecheck(struct drm_i915_private *, data); \
 	(data)->gt[0]->uc.guc.submission_state.sched_disable_delay_ms = 0; \
 	__i915_subtests(__func__, \
 			__i915_live_setup, __i915_live_teardown, \
-			T, ARRAY_SIZE(T), data); \
+			T, ARRAY_SIZE(T), data, device); \
 })
-#define intel_gt_live_subtests(T, data) ({ \
+#define intel_gt_live_subtests(T, data, device) ({ \
 	typecheck(struct intel_gt *, data); \
 	(data)->uc.guc.submission_state.sched_disable_delay_ms = 0; \
 	__i915_subtests(__func__, \
 			__intel_gt_live_setup, __intel_gt_live_teardown, \
-			T, ARRAY_SIZE(T), data); \
+			T, ARRAY_SIZE(T), data, device); \
 })
 
 #define SUBTEST(x) { x, #x }
diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 79b55df1e71a..8bb9994aa116 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -262,7 +262,7 @@ int i915_active_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_subtests(tests, i915);
+	return i915_subtests(tests, i915, &i915->drm);
 }
 
 static struct intel_engine_cs *node_to_barrier(struct active_node *it)
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index ad650f67114a..e5ee5ddad81a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -258,5 +258,5 @@ int i915_gem_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 604289814f79..5abb0b9d7ae7 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -571,7 +571,7 @@ int i915_gem_evict_mock_selftests(void)
 		return -ENOMEM;
 
 	with_intel_runtime_pm(&i915->runtime_pm, wakeref)
-		err = i915_subtests(tests, to_gt(i915));
+		err = i915_subtests(tests, to_gt(i915), &i915->drm);
 
 	mock_destroy_device(i915);
 	return err;
@@ -586,5 +586,5 @@ int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 0c855f00c3ae..5c3f9626f19a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -2004,7 +2004,7 @@ int i915_gem_gtt_mock_selftests(void)
 
 	mock_init_ggtt(gt);
 
-	err = i915_subtests(tests, gt->ggtt);
+	err = i915_subtests(tests, gt->ggtt, &i915->drm);
 
 	mock_device_flush(i915);
 	i915_gem_drain_freed_objects(i915);
@@ -2038,5 +2038,5 @@ int i915_gem_gtt_live_selftests(struct drm_i915_private *i915)
 
 	GEM_BUG_ON(offset_in_page(to_gt(i915)->ggtt->vm.total));
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index d2a1a901d47b..7b95b0719765 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -442,7 +442,7 @@ int i915_perf_live_selftests(struct drm_i915_private *i915)
 	if (err)
 		return err;
 
-	err = i915_live_subtests(tests, i915);
+	err = i915_live_subtests(tests, i915, &i915->drm);
 
 	destroy_empty_config(&i915->perf);
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index 431298f774e6..5c4d8137916c 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -572,7 +572,7 @@ int i915_request_mock_selftests(void)
 		return -ENOMEM;
 
 	with_intel_runtime_pm(&i915->runtime_pm, wakeref)
-		err = i915_subtests(tests, i915);
+		err = i915_subtests(tests, i915, &i915->drm);
 
 	mock_destroy_device(i915);
 
@@ -1928,7 +1928,7 @@ int i915_request_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
 
 static int switch_to_kernel_sync(struct intel_context *ce, int err)
@@ -3354,5 +3354,5 @@ int i915_request_perf_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_subtests(tests, i915);
+	return i915_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index fa840a7e651e..7feda1ae7d20 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -224,7 +224,8 @@ static struct mm_struct *get_selftest_mm(int u_pid_nr)
 static int __run_selftests(const char *name,
 			   struct selftest *st,
 			   unsigned int count,
-			   void *data)
+			   void *data,
+			   struct drm_device *device)
 {
 	struct mm_struct *mm = NULL;
 	int u_pid_nr = -1;
@@ -243,8 +244,15 @@ static int __run_selftests(const char *name,
 
 	set_default_test_all(st, count);
 
-	pr_info(DRIVER_NAME ": Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
-		name, i915_selftest.random_seed, i915_selftest.timeout_ms);
+	if (device)
+		drm_info(device, "Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
+			 name, i915_selftest.random_seed,
+			 i915_selftest.timeout_ms);
+	else
+		pr_info(DRIVER_NAME
+			": Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
+			name, i915_selftest.random_seed,
+			i915_selftest.timeout_ms);
 
 	/*
 	 * If we are running in a kthread on a multi NUMA system and the user passed
@@ -258,7 +266,11 @@ static int __run_selftests(const char *name,
 			if (unlikely(!current->mm)) {
 				mmput(mm);
 				mm = NULL;
-				pr_warn("Could not set mm as current->mm\n");
+				if (device)
+					drm_warn(device,
+						 "Could not set mm as current->mm\n");
+				else
+					pr_warn("Could not set mm as current->mm\n");
 			}
 		}
 	}
@@ -277,7 +289,11 @@ static int __run_selftests(const char *name,
 			return -EINTR;
 		}
 
-		pr_info(DRIVER_NAME ": Running %s\n", st->name);
+		if (device)
+			drm_info(device, "Running %s\n", st->name);
+		else
+			pr_info(DRIVER_NAME ": Running %s\n", st->name);
+
 		if (data)
 			err = st->live(data);
 		else
@@ -301,8 +317,9 @@ static int __run_selftests(const char *name,
 	return err;
 }
 
-#define run_selftests(x, data) \
-	__run_selftests(#x, x##_selftests, ARRAY_SIZE(x##_selftests), data)
+#define run_selftests(x, data, device) \
+	__run_selftests(#x, x##_selftests, ARRAY_SIZE(x##_selftests), \
+			data, device)
 
 int i915_mock_selftests(void)
 {
@@ -311,7 +328,7 @@ int i915_mock_selftests(void)
 	if (!i915_selftest.mock)
 		return 0;
 
-	err = run_selftests(mock, NULL);
+	err = run_selftests(mock, NULL, NULL);
 	if (err) {
 		i915_selftest.mock = err;
 		return 1;
@@ -352,7 +369,7 @@ int i915_live_selftests(struct pci_dev *pdev)
 	__wait_gsc_proxy_completed(i915);
 	__wait_gsc_huc_load_completed(i915);
 
-	err = run_selftests(live, i915);
+	err = run_selftests(live, i915, &i915->drm);
 	if (err) {
 		i915_selftest.live = err;
 		return err;
@@ -377,7 +394,7 @@ int i915_perf_selftests(struct pci_dev *pdev)
 	__wait_gsc_proxy_completed(i915);
 	__wait_gsc_huc_load_completed(i915);
 
-	err = run_selftests(perf, i915);
+	err = run_selftests(perf, i915, &i915->drm);
 	if (err) {
 		i915_selftest.perf = err;
 		return err;
@@ -495,7 +512,8 @@ int __i915_subtests(const char *caller,
 		    int (*teardown)(int err, void *data),
 		    const struct i915_subtest *st,
 		    unsigned int count,
-		    void *data)
+		    void *data,
+		    struct drm_device *device)
 {
 	int err;
 
@@ -509,18 +527,31 @@ int __i915_subtests(const char *caller,
 
 		err = setup(data);
 		if (err) {
-			pr_err(DRIVER_NAME "/%s: setup failed for %s\n",
-			       caller, st->name);
+			if (device)
+				drm_err(device, "%s: setup failed for %s\n",
+					caller, st->name);
+			else
+				pr_err(DRIVER_NAME "/%s: setup failed for %s\n",
+				       caller, st->name);
 			return err;
 		}
 
-		pr_info(DRIVER_NAME ": Running %s/%s\n", caller, st->name);
+		if (device)
+			drm_info(device, "Running %s/%s\n", caller, st->name);
+		else
+			pr_info(DRIVER_NAME ": Running %s/%s\n", caller, st->name);
+
 		GEM_TRACE("Running %s/%s\n", caller, st->name);
 
 		err = teardown(st->func(data), data);
 		if (err && err != -EINTR) {
-			pr_err(DRIVER_NAME "/%s: %s failed with error %d\n",
-			       caller, st->name, err);
+			if (device)
+				drm_err(device, "%s: %s failed with error %d\n",
+					caller, st->name, err);
+			else
+				pr_err(DRIVER_NAME
+				       "/%s: %s failed with error %d\n",
+				       caller, st->name, err);
 			return err;
 		}
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index ecb2d718f6a6..ddb3c63ddd63 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -763,5 +763,5 @@ int i915_sw_fence_mock_selftests(void)
 		SUBTEST(test_dma_fence),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
index 88fa845e9f4a..163782c7c276 100644
--- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
@@ -612,5 +612,5 @@ int i915_syncmap_mock_selftests(void)
 		SUBTEST(igt_syncmap_random),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 8e1e54ea0585..c754de5afa02 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -997,7 +997,7 @@ int i915_vma_mock_selftests(void)
 
 	mock_init_ggtt(gt);
 
-	err = i915_subtests(tests, gt->ggtt);
+	err = i915_subtests(tests, gt->ggtt, &i915->drm);
 
 	mock_device_flush(i915);
 	i915_gem_drain_freed_objects(i915);
@@ -1163,5 +1163,5 @@ int i915_vma_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_vma_remapped_gtt),
 	};
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
index 8307390943a2..ba6e6c5bbb2f 100644
--- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
@@ -1363,7 +1363,7 @@ int intel_memory_region_mock_selftests(void)
 		goto out_unref;
 	}
 
-	err = i915_subtests(tests, mem);
+	err = i915_subtests(tests, mem, &i915->drm);
 
 	intel_memory_region_destroy(mem);
 out_unref:
@@ -1389,7 +1389,7 @@ int intel_memory_region_live_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
 
 int intel_memory_region_perf_selftests(struct drm_i915_private *i915)
@@ -1401,5 +1401,5 @@ int intel_memory_region_perf_selftests(struct drm_i915_private *i915)
 	if (intel_gt_is_wedged(to_gt(i915)))
 		return 0;
 
-	return i915_live_subtests(tests, i915);
+	return i915_live_subtests(tests, i915, &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index 1f58024150fa..a1b77e752379 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -296,5 +296,5 @@ int intel_uncore_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_forcewake_ops),
 	};
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return intel_gt_live_subtests(tests, to_gt(i915), &i915->drm);
 }
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index 7e59591bbed6..88ad1d7e14f7 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -380,5 +380,5 @@ int scatterlist_mock_selftests(void)
 		SUBTEST(igt_sg_trim),
 	};
 
-	return i915_subtests(tests, NULL);
+	return i915_subtests(tests, NULL, NULL);
 }
-- 
2.34.1

