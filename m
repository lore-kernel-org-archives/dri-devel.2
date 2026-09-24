Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30D5C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E44F10E462;
	Thu, 24 Sep 2026 12:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BIHykbep";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6489710E462;
 Thu, 24 Sep 2026 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251364; x=1821787364;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=2Ifkf9YmUUlbV2bjsMfUCTKQaxewpdoGMDHgPHX5CGY=;
 b=BIHykbepd4sEMBE6jLfYYMqs1jbjnqw46ivvJhYybwqrPJgU12119vwC
 xZZ3W8zuBBUskuII1Oen8mFFZzeRabc68Z+OSKM2BH9TGOT4J2NoPqoVU
 XJM50YNq0O6Y5wkl/L+ZD1Go4TmikZn1Qd7rc7nlrvNsp7Zq80QwOqZNX
 dOIe7sJFl5Ts0mRqC5CPspbF2AB85rVVlbwuzLGvLxQFaAgquizaXd/dk
 fjP/GDeCFd8pp8OBRYpoiF9R275S4EG1/1VyKaB5XYVwiFrvIwApDlREs
 LIyW1c7EVa914Duk8af7WB7hSU8fJjC0bl2v8jNG8zzVtacy7+J6Qvwwz w==;
X-CSE-ConnectionGUID: jtW6SkrfQ0Sx0dKBp1XLaA==
X-CSE-MsgGUID: Y5k9Y506QWmv+DhiLIOqIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="94838149"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="94838149"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:43 -0700
X-CSE-ConnectionGUID: xgpZilqWTUyCCHVEl4pSkA==
X-CSE-MsgGUID: JUA1P+p6S3iZlrRP1OmKuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="300272216"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:02:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKpKwX60En+mCJ4cptnf41FjwUQaazDGj/qe1lS8urKn+6wf+2lrAdzUOuPK3OLtacLKgr5P5NHmbtfKCnG2W2cOPaszKbg/BVpTJ7xdM5NS/I4AWRxMmARnFOpJBmCqNXBbn1Ahnf6mFZ0igvxSL7FxrBB9tOfi4WQEcPjPmTSn16W8CqrHvD6AlQGB2j+Js0QB8vsK6kJ4G56p2UYSgZT0RNT/LGt7JB6X44OE//ioEoJ4l1McN3eGZx77PLzCm0BokoEuI4VbL2qfJyNk9wgwGEyHSQbQoUWYAI4jO38ReM+YF3l1eyvo93veMnt8LM9rfTjhb5wm8/bWWkLi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsnY7oUnos1aQHtKeUDwsZtDlC2lMFDACsD+An+ISIM=;
 b=QKOyjqP5D9U9LFX3HDdrO7wTbvdnlAZLDH6QCxjSR6lM0aZyIjaUZRz3nPgj/Hpldkm6RBdcyPZqIjpF0ef/5v02vonYkGRTk7UnD5SUa/YQZNBMa2uUAdrRz7I6VsKUidFvrnKrQPbUFYqj3pXfvxkyOedv4vFO+Pk1e5vuoHGBiLnM6YugKAJxHOQ534kbhB0jro+nXV2lt/VQrYTBmdrx0S3E62pr3exkFq9aOiA0va0MrcXBcoD+vqV51bXyUv6jUVueXE8jwmW4ZW5kv2Pg9jNRdKrUcF3iInY1eSaQYxnGkauHUjhIVPou3tncbXyD/ZPwtqIRJaJeExix1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:02:13 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:02:12 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 0/7] drm/i915/selftests: Modernize printing in i915
 selftests
Date: Thu, 24 Sep 2026 12:01:40 +0000
Message-ID: <20260924120147.1305127-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: bab5d301-4996-4ba0-6a35-08df1a33ab11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|6133799003|20046099003;
X-Microsoft-Antispam-Message-Info: ECJZ4cDSBXtRi/B0SjKVCZi5VDVRt32xu/Ua3WSntKmEkhMJkVUC+mDmRGQi17mtTU0JfAFak4oqysK0txqmtic7M7BebqOJcbUMwpHFvyyciRwPIIAM7YGFFl+kFwT1u1X+GG0iCNNJ2PMG6rreYyuv1JiZpOc9v46+d2DoKCCfkdXu3BZRlNO9rLQt/hNGMWkpcHXFiU/j4XYDeEacb6SuBJMTSYtv9YpnKFjy/4ysWSr0NLxJHqMONMKA2mZZc6yAqdvjZ0UkUUxxHtLu/83eyFyfJ+/IHvI92qHAhFrjOiM0rzEMPGIU1cLKEcmsWKV4X+gQMh1tMjvCFukpVTwlBMzVozoW8RKJ8feTf2QPzIBjCO80CLCe5KGiSpqpAO3F5ZCxs5GOghhOemVXye1GgCOM6NJi5eYWtuzu3kRqX8jHq0/yRJLWX3U51AcGl3nqlQ8WSKNQ6yYw2e0rBLOrC3mJ+Vf8xGFUvDLiU/LMOiRkWkItb+KWbTRIZoy0DFliMdPFWcQt5qmCi/tmCjZma79Uc7nsGoxDvMnuQaKYREIQYm5WipxWVvZ4cB11w4gkV4wWeJL7dxsE9zEqBkwpxhUxtD9z4csb2pRWXFmkAvDI+GtjMrptzKT3u5MLRkHBHgl62bYV9/ay5XAbIBA3gSTzuCjIPjmHpI+XsMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(6133799003)(20046099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqYM6Hp60ET6YBKSYblG+ndPpkMDp1Jk9/3LZZnn1CxsSzhQPYwXo+kcLqtk?=
 =?us-ascii?Q?0Ugljs7gRBn56o4Ms2CQlqmd/uZN/AUopcs9UENzxnKYCs0eZgoLYh6roSeK?=
 =?us-ascii?Q?3gqvQ82vmqeYxs8lPo/WyKWY6mix1dYk/0Fqz5Vg6BpD8eV4FiQukD5RE91k?=
 =?us-ascii?Q?8f6AIZHkupAerYhOFkjMhDHxI2huxmn6+bL+RdylkpcyU/8lxPKeFth1aGSb?=
 =?us-ascii?Q?Orw/mh0MwG2aoYTTMy3RAHVLhZKiRr9HSqhPBJsX3yR6UVYtw2lHeO3Scrwt?=
 =?us-ascii?Q?aVm+r5iL1YvnTm2CTm7O9s6Oey++2UCWQGOWIEqn5lRmJeiC5rvGl7IhcXvP?=
 =?us-ascii?Q?GgdXOytYCQW+wz9AWSMRy7lL+EKgQnlsdQNa5C1R7bd360vyttCZMktsHC6e?=
 =?us-ascii?Q?23fE0brFnWnpkr5dR56lK2hb+SVZILIhVQ6WJ8sa+TrW7KHHP6PL4DufMkLX?=
 =?us-ascii?Q?Rm8MWwAMLtrlJZbhfeV13Jm9y2b6paRIzi4VRO272T0ViWx9qw3dWvZunHFs?=
 =?us-ascii?Q?+r57s3lSovhhIzol0DbYqsJX0NhNG/YOouEqMSbFhnCchbatEMdBLg5maS1B?=
 =?us-ascii?Q?KzpzdladqkLFV+NIT14U7228ipmE4NZvLyMnwn8Er7Zj1J5xOlqCm8yUS5C3?=
 =?us-ascii?Q?AyZpKa2kCQqNvK5Ro0NovcmuNvDzFJXtxR6bMDOEtmB41/mrNXPqJg6Lk10b?=
 =?us-ascii?Q?CBjGx0HELGEMae+iQbo8lkuYXhS1jfCEcljWqIBTyhSDbNDo3K/VoiAdkcBT?=
 =?us-ascii?Q?RZf7JeuA/tN4/lvdNfj6a+OWbIEA8MY7BUocGGZOkHyzO/LPyAq34QBp9zYP?=
 =?us-ascii?Q?1Fc6L8UZTkd2eysfAwLaHwxJ31adkmfQjfVoLWptsdggqmMyLGBO04He65Ni?=
 =?us-ascii?Q?wE9khwIPz2JKdSr3CQ2K9QJYDWFWEHtW9sf+jlVxSF8gqHn81GzHDiJrsSQH?=
 =?us-ascii?Q?sQjLFzzLT5Vofh4eVNGBxvNVp+ZBq4u7MMzwQfxyx5A9Tpl5ec44nNN9qTpZ?=
 =?us-ascii?Q?m2xm+Up/zo4r5PQl7w19Jl+i7MhXI6MIaMPSfiHEPxTOPbt8CHzdniY0vFSe?=
 =?us-ascii?Q?vxzv5Jml71YJWI44gYp3d+VJ5ZyFSTI+myrDLFRxswVB0yvNYkPKUkoiGnWZ?=
 =?us-ascii?Q?7nRZmP/yeNyvKfk8qocGo9F6jja9uk6xe6mpS/VewB+gBGiy1Ii4JSLyv9gH?=
 =?us-ascii?Q?M06ASKyXyFQMoiS9z+xItA5z4S6GTIW0dwy6xnMh5Rpt/Oljh+cktDSiIIro?=
 =?us-ascii?Q?SQpNmtUq3tsd0sLHD8/16VOjcTf3vJ/dQNqnAo/UazpYh1UfOYUcGhbJSaJJ?=
 =?us-ascii?Q?gbBBMipgEs+BVEEzhLjecfcFsXr7fL+f6xwz5AEITQ47lm+MLvBpj1oRx4MP?=
 =?us-ascii?Q?qPvNgEmHFORXL91uozwdGNe9oAnSHz9L/qD32rlHbaqQVUbnSh9Fv8mFrLuC?=
 =?us-ascii?Q?WVfHHcVzCnQUXRUvzvstCdRFLVPCDRIbF9RLKkrst4IEkihD2I8DePhkCT7o?=
 =?us-ascii?Q?Cs7N3FCkxLOjJlvO1FKXfJI/kW4Ifo655UvdQtxJDC9rs1tSqpfAc3CR7eiL?=
 =?us-ascii?Q?J273mbrVG68QUAskFupmjyHCsZ2lhaIVTzfamfOqHv8QifvAaUFgH4CjCoHm?=
 =?us-ascii?Q?AWIH9mf+wA8Hw6rv1VWiLFQ0FwS2TwgvziVZ8+AcY1VnKrrtrGLDxFlsDkMi?=
 =?us-ascii?Q?xKzm/cdBd5HhQXd5dfLd3dWj5qvJ2mbJIubaIz9YeiQT5tz5IqaIfybG4buO?=
 =?us-ascii?Q?sYkksJcyvP3PFw38RLG4eFoKoQrRORU=3D?=
X-Exchange-RoutingPolicyChecked: 1Q+plVmKJGzpKi9kl45v1orCvabNv/82oJhQUxAqUFQNb/9NVImjo1aDSvsWxBY2ufhIV9mMU4gXhVbRs1Q6ekwJqizqGdZRlzboWm4iklJSBezPJ9iMKwJYOvaJzapb1B6BrMFWvYD0AfNCkR8pcim5mH/VZj8qTGq30cljFl+ttCJvUzG1vqeQ4myuOpXtGJvURQl8eUf+tsJJnOc53RGnejv/d0RXUs4J7BW9EU9AQiKBM4C83PYoAKyO44ce+SbeAaeLEJIXJvegZ2993TsHlCYTa6jpHATRzAp8B2xWr8S8nRW1CHL2xiKGGHyabKk2Z825LBpSMDs3UmesVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5d301-4996-4ba0-6a35-08df1a33ab11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:02:12.8043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj6SncvsSrkpM+O727C5PaOtB4PG3x/FG/Sv1eaLRnMrnW6ALNcUVINybPm/5uNr2fp4tJUqKrxIJlFu3sSh9p2go8VhtK5QkgB/t4o5G7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
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
information. Xe has its own family of prints, so it would be
beneficial to add an equivalent to i915 as well. Additionally,
Use gt_* prints where GT context is available. Start small and
convert i915 selftests first.

v4 (Andi, Krzysztof Niemiec, Jani):
- dropped "Add drm_device to selftest wrappers" (Andi Shyti);
- added a new i915_* family of printer macros (i915_printk.h)
  (Andi Shyti);
- switched many drm_* conversions to gt_*/i915_* where a GT or
  device reference is reachable (Andi Shyti, Krzysztof Niemiec,
  Jani Nikula);

Krzysztof Karas (7):
  drm/i915/selftests: Use gt_*/drm_* prints in core selftests
  drm/i915: Add i915_* printer macros
  drm/i915/selftests: Use gt_*/i915_* prints in selftest helpers
  drm/i915/gt/selftests: Use gt_* prints in aggregated gt selftests
  drm/i915/gt/selftests: Use gt_* prints in gt standalone tests
  drm/i915/gt/selftests: Use gt_* prints in gt selftest helpers
  drm/i915/selftests: Use i915_* prints in i915_selftest.c

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
 drivers/gpu/drm/i915/i915_printk.h            |  55 ++++
 drivers/gpu/drm/i915/selftests/i915_active.c  |  13 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 ++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 ++++++++----
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
 drivers/gpu/drm/i915/selftests/i915_request.c | 206 +++++++++------
 .../gpu/drm/i915/selftests/i915_selftest.c    |   8 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 187 +++++++++-----
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   4 +-
 .../gpu/drm/i915/selftests/igt_live_test.c    |   7 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c    |   4 +-
 .../i915/selftests/intel_scheduler_helpers.c  |   7 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
 .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
 29 files changed, 1013 insertions(+), 509 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/i915_printk.h

-- 
2.34.1

