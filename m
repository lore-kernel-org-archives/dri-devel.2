Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4449C5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069CF10EBBC;
	Tue, 11 Aug 2026 13:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GNYE6lkQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AAA10E8B9;
 Tue, 11 Aug 2026 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455198; x=1817991198;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=nhSjKhQfyBqh8vLrw3fwAO1CnroTxADgOjESNhupGFA=;
 b=GNYE6lkQEvdCLQl4SuZ4PrB2R80aP6DuqJ2CHE69tvSVlyDet3hASXaC
 n5e+fCB2uyDIhtRP7C2iN1TrB40ofWLGyg1ollN/mfJf3P68P5WUDc2jk
 jxjtZK13dSS5snH+49r+Z7E2tYnhE0qX8Z6CdJ6jBNO91PK/YrDa0rIbB
 aGqj5EJYDgiJuv8NQKNnU2SnrSjCSel68Ww0i4LSGg15+8TSd8TynaIuf
 iw2UGicOUAnBCwFKoe5wdTmz38agOD8VoY4HfyrovTaZdpP0aM7KrbNEk
 Wsf3HuY38T1MHm4loojaf8J+WgnVqcJ25k7ESUy5rYAZVHObtcgAXKdHf w==;
X-CSE-ConnectionGUID: p4w8tQanQAunfTNQJuvoEQ==
X-CSE-MsgGUID: kBpQPYsdQZa4wj9cMR7spQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104374859"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="104374859"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:18 -0700
X-CSE-ConnectionGUID: aDezBL6+RMGxTaXnEmorAw==
X-CSE-MsgGUID: 7PywIT53Si6tqw9jZ/4Txg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="267187693"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9hUJorG3MTACpGtjWccul6+pcVlMdxHy+GcDAIinJ0RKa7NoRc3mLVtcSQr1ZybcUhReACyR1hm/O/EgabraijrvMP8C56j7fFaI3qFCTyUfsQECGsqAhncKfYpAMK6N9FdT5LY8i6+8I3pdUTo6TslQnkLf9JEQV5uECkqQ4g+8VPxW7aG/K8fOLPuaVzy+Xy/9iu9eH2LrtSg7eF3UjuAUtQ4PIMka7kXUj+vro+04/St8230fCNoPbDmtmfdoufxi8Ai9Oy3wuhMitNWmzf5q8pC+amsrUAgdqhiov2aswX2+ZevXskgYWw2lxtJFLNs6aLByRmr3Zqu6V9cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3i9HK3YQYu0cmFEVZVNxrtIVqLnR769EfFGVr2h58Q=;
 b=mYj8xybvp2oqPJ2Bb+8GH3iqZjasPN6D21+SWRLwqijIljqJQ1dZsRLjFTTO4SbkJ5Nq0Kt86E5wiWit//1Jkntpsi37QEVCgF1SQlrvtQOd2C0I7k+KLiAuHe8VWozw8gH+aiE1DYrv/4dpSgQaX5OMK905K5y63rA/SuuKa2ot2d3O4a7vUDX28Z0Kv1gx9p7fN8Svf+S5sKq+2m0+LdNtMlxgbyKp4Gwzs5MuHKcwZerpNiHKQUNsgVVWwKP6I962r7kawrBkLjaVGguRjarMhxwCUGY0sCYKdtnbIhZvc3xtUPEkpsRCpUy6PAjO0up/Y0+X7Ne+qYFoclAm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 13:33:14 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:14 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 3/7] drm/i915/selftests: Use drm_* prints in selftest
 helpers
Date: Tue, 11 Aug 2026 13:32:53 +0000
Message-ID: <20260811133257.1133097-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811133257.1133097-1-krzysztof.karas@intel.com>
References: <20260811133257.1133097-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::20) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: bb667486-4a26-4b84-f528-08def7ad1865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: jesMQzoB6N4zG/MtJlcDJb6Cok5UHJ16W/2YBl7Qz0C+qwYJjpk3NrdITcFjh/1MKaNeoAFRiahkJPKwjFtYL5VEzIfukKsQ/I4Qp2GMwCTqK86/YKnpTBH8GkOHwTKkwc89yst+4CFLNt5gBDgvgL35XUO4UB53a84WExxh9dFY3rDL2kLQ6vcV2wHOOBse/5uMyQnMwpn1JPTtWkQJq5RrflaegJpEC0UR8l5ib5rOdT0a+F4GccmKo8Drgzt/KcAsH/nc0A2aYPcjfJekLitU9MDDRBpyLZxFJAPY6e6OTr7AgUSwdLbcFXTwxjw4XwVqK+KYQnYxfvFvZp3JoFnjSVaWZVkJZ4Cz0dTshN+5XxJlEtSUwyQk1Xg9fakfxNyeOEa9v3EIUpCbvAFrUngKavGW9jGliBIA6ZD5/z0NLrw1O4DRjKDEvi1w3XFv2/VFDVdnyfN2UlG4X44EL1q3EWd77lRBY1UVt7w7qIx29DcgrlRzx5qAOUnfxoCvtggjwBWlJDnhmk9DKk3l/LwdNhhZffn5SWah1OcW/us7VsuNEV66QjO3g47HszKiT2tyY7/b6R+d2blbhJjrgVI321AcIC1bo9W70dYBClRptBUXm9a+kuo6PYQjK7Eu1bfHXOPodEjrpzGJQabBQjNl/EORONTT9L+8S4nWLZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNCcllwRStwcEQ4TzVzbHBOaDlGRHh5OVZZYk9tS01RYiswOU9tWUs4NXJs?=
 =?utf-8?B?M3hVU2Y0cnJwdUJEb3lTQTh6ZE1RZDFCdURTSXFZKyt6YmtMTWdmd3Z3RG9I?=
 =?utf-8?B?WnM5b1VFcGVhNjJQeVZFUmRKNEFPMGdnOWxGeVROSHdUQkhLb0M3c2NpcXlJ?=
 =?utf-8?B?a3ZvelpSYjJnTVpxNk5YSWJxcTRlMi9QVXg3eVpsaGlSNGVXWnVNaEE1djhH?=
 =?utf-8?B?RVBEdnAyTXVsL1k2L2lYSzJjREFOd2ZnME9yUjBYMGhuK2JPU0JuaTlEdndh?=
 =?utf-8?B?YUNDcGZ6Mm5OODNNVkVVZno0dENNbmRxWlpWeXZzZzhCRW44MGprQXNHS3RP?=
 =?utf-8?B?dzRITWI1M2w3aTZZeE0zNHEzL2Zac1JMQ3djSEpDT2FDdEg5UDlWY0R4dEV1?=
 =?utf-8?B?dTJzSFhKT2swcEpWM0FGTSthenUwL1J0TVFJYTBwSDEvTW1HbUxlRFptWDRK?=
 =?utf-8?B?MXp0NGJhaVVLVU5mNGdjRlh1YTBGbXZBYTFHSnM1WWVhRjlJdTNnS1RGV3dh?=
 =?utf-8?B?cnl6enUwT0ppOVh0SnRJc29UalV4Y3FoTmxoZ1BkVEd1MW5zbWlGeWtFOWpJ?=
 =?utf-8?B?ekRZSEhaclN0QWtlc2QydGxCZDhsejgySnJFWkVBeGkwencwY3l0bXd5RFlk?=
 =?utf-8?B?bllFVXg1cDZ1QmlxbFZZSUx5RHFCNUlheW1aZEhoU3pEQzlQUmh3dDZCZVpp?=
 =?utf-8?B?cWZkUWFSVVJneXRrU01nUm8vaGJXUkcrUkUranFyYkVQcFRnbDcrUUVKM284?=
 =?utf-8?B?T3dvMWVyZW5SK0RMTkVpVlFTK1huMThjTURrOWxYekk3WXE2WTFjazdERmRK?=
 =?utf-8?B?MSswczYwVDdqVEhrQ0lqRkhVYzdmOU1aaVI3b2k2WkU0WWlwNUptOEdWcDlX?=
 =?utf-8?B?eEJxNVVLdWFSVlRNSnFrZzc4ZTRQNGp5VytUcUNnZmVVNTgvZCtFaUVqbnI4?=
 =?utf-8?B?bys3Y1N6QjhhYU9lbklwZDd6bUxHZUdPT05CelFldzBSc3RlWDl5SC9jSkY1?=
 =?utf-8?B?K0FPcmwvdk83ZWkwSSs2NTYrclA1R3l0UzFZZUR1UFFsTUk1RHZIY2R6b3Jz?=
 =?utf-8?B?NTNENnBLZXEvdG84UE9ISy95RVBrS0NtZ2ZGK09STXl3bW13VlE2NGVDcFhX?=
 =?utf-8?B?NVRCMmE2TjM3dmNnQk5IcTFIVW00a09MTXJmQmZiczhuVHhaQUV5WEEzTk56?=
 =?utf-8?B?Y2VvNktnMEg3aU9ManNiSmxYQ2k3UjhkWFBvV3l4ZlJDSUpoQ1pwQjNoWlJE?=
 =?utf-8?B?enJWVnVyeFR3eU5sTFlJdWFHS3NPRTVTZUE4MHhxdmNLcXJXUFJpcm1KaW9a?=
 =?utf-8?B?ZkhSRVJTRkJzVVdGZ2pNclB0SDNuVGkzZjJrb1p6SVc3dXdNSTVYL2NiWGJz?=
 =?utf-8?B?UlNjV0M5aC95a0N5UTREVDkxS1BZdU9YUUpoeUNFdVNiYzlVTXdTaEtOY2pu?=
 =?utf-8?B?SytsWWc4LzJjTldjTFFTZVZtNFFvQkYxb1pXOUxZQTRRclYzWTFQZ1VnQ0lk?=
 =?utf-8?B?OHZjSVRJaU11QWVNU2JXcllXV0kra1FiNjB2YlgvSTg2S1kvSEZac2hIOVc1?=
 =?utf-8?B?c1BRQ1pEWWtacXA1YlBwa2ljUHZMbFEzVStqdFBqQ2pZaUUrajV1NWdBSkE2?=
 =?utf-8?B?Z0pRbngzV3dmN0t0My9NTmpEQ20yTlZRMEowaVkrTHdzbjNUaUlHSWFNZmZJ?=
 =?utf-8?B?NG8yTExMN0V0aU9HTEdhMWpEeVcwM05WWmtSdFZuZE4rQUtERmRjQUxVQmxC?=
 =?utf-8?B?NlJDSmFTK2R3dGJFOHlWQ2VLTXFMOTl2MVF2T1kwaklsRjNhY0JOZFRzRmxE?=
 =?utf-8?B?UjB6RThScjg3QzdYWnhxVDN1YmZOa0JwYXVNNFFxOEpHcDZLMURzUjdLUVJh?=
 =?utf-8?B?MENFbzhWSWE4TmhObTN0aFVlRFpBL1h4Q3c3bkQ1VGIwOXBRZnNPcGJYUzdD?=
 =?utf-8?B?ZDN3bDdnSTJ4aHlyR0FGcU1FYVdRRnJFd29INXFpUmxQTy8vTjRDUVNiTTBD?=
 =?utf-8?B?bENkZEpKNlFmSWZCY0NRVUZzcC9ZQWMxOU1aeDVVazZnOHN1SFZkNjlaV3pC?=
 =?utf-8?B?NDNORXA0NE5SMkZHM1pCNitnWUYvenkzNUttVXZ2aFlyZTlqWHpZNmFoT2Vm?=
 =?utf-8?B?UktSclpHUTdweGpEaUJVaUdjclpuV0h0blhudHZqRkFickN3UEhMWlFpa285?=
 =?utf-8?B?cUhUejlnQk9uL2hTZEE1K3FZb2Q5UnZYcVV3cjFmcENWNHBDZ2YraDBEOEpq?=
 =?utf-8?B?ckRxQXNiakVBY0ZGUjRhOEVxS2ZSaXBoUndyWUdOVldUZUg2R2dKd2plMDdP?=
 =?utf-8?B?L0RVNTdDU2xKMEFnMXFBY3dBWXJDdXIyTGFzb0xjRHVSbVlWV0lGdUIzQnpY?=
 =?utf-8?Q?fBU0NZO9XEJ+3iu0=3D?=
X-Exchange-RoutingPolicyChecked: LW8Nf1ZzNvFw+jPERs5ZIEG7sr2VhQcYP0hlhyhjF+v9l26dSSjr/MiulJC9qi7T8SWK3se/V7twNB2m5yhz5IFfJ2WjPhjlYL3l5WeCG+hXh00A8VjKyivzP3xEsUEeyL4Rr3/fhytqohsqyF6DubwuUdirlBUdH+Zl6ad3GxWnqeiT6LtUesAAnLrfY1fUPJnMYaWCDGLL9GD65rr/z+O7CB1nrvDLNRHVWm6Zr09Y1tZfwiGaUHbo4dNp/lEnLQgCPRwkdyGMSFJeuf8ectnEge+mUbJtgN+MfdrHryRQiw0+6Ygfbah4NDRYW4bcjJmANQMAnY8S8D0Fg0Lenw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb667486-4a26-4b84-f528-08def7ad1865
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:14.5808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VG94woAAI+VGQlYU5BhGXFWlNKu4bhqE7Zwmo+Y+UTfIVk8lVFWDAQpjAQqjbbjDO7peswYQFLPMQCwcF6ISAXxFRjH8AVb4FEBq62LWkk=
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

Move away from generic pr prints to device context aware drm
versions.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_active.c      | 15 ++++++++++-----
 drivers/gpu/drm/i915/selftests/igt_flush_test.c   |  7 +++++--
 drivers/gpu/drm/i915/selftests/igt_live_test.c    |  6 +++---
 drivers/gpu/drm/i915/selftests/igt_reset.c        |  5 ++++-
 .../drm/i915/selftests/intel_scheduler_helpers.c  |  8 ++++++--
 drivers/gpu/drm/i915/selftests/mock_gem_device.c  |  4 +++-
 6 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..105de5d0d3b5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -115,7 +115,7 @@ __live_active_setup(struct drm_i915_private *i915)
 			err = i915_active_add_request(&active->base, rq);
 		i915_request_add(rq);
 		if (err) {
-			pr_err("Failed to track active ref!\n");
+			drm_err(&i915->drm, "Failed to track active ref!\n");
 			break;
 		}
 
@@ -124,12 +124,13 @@ __live_active_setup(struct drm_i915_private *i915)
 
 	i915_active_release(&active->base);
 	if (READ_ONCE(active->retired) && count) {
-		pr_err("i915_active retired before submission!\n");
+		drm_err(&i915->drm, "i915_active retired before submission!\n");
 		err = -EINVAL;
 	}
 	if (atomic_read(&active->base.count) != count) {
-		pr_err("i915_active not tracking all requests, found %d, expected %d\n",
-		       atomic_read(&active->base.count), count);
+		drm_err(&i915->drm,
+			"i915_active not tracking all requests, found %d, expected %d\n",
+			atomic_read(&active->base.count), count);
 		err = -EINVAL;
 	}
 
@@ -236,7 +237,11 @@ static int live_active_barrier(void *arg)
 
 	__i915_active_wait(&active->base, TASK_UNINTERRUPTIBLE);
 	if (!READ_ONCE(active->retired)) {
-		pr_err("i915_active not retired after flushing barriers!\n");
+		struct drm_printer p = drm_err_printer(&i915->drm, __func__);
+
+		drm_printf(&p, "i915_active not retired after flushing barriers!\n");
+		i915_active_print(&active->base, &p);
+
 		err = -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.c b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
index c383d31d46b0..86164d1258c6 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
@@ -7,6 +7,8 @@
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_requests.h"
 
+#include <drm/drm_print.h>
+
 #include "i915_drv.h"
 #include "i915_selftest.h"
 
@@ -35,8 +37,9 @@ int igt_flush_test(struct drm_i915_private *i915)
 
 		/* 2x longest preempt timeout, experimentally determined */
 		if (intel_gt_wait_for_idle(gt, HZ * timeout_ms / 500) == -ETIME) {
-			pr_err("%pS timed out, cancelling all further testing.\n",
-			       __builtin_return_address(0));
+			drm_err(&gt->i915->drm,
+				"%pS timed out, cancelling all further testing.\n",
+				__builtin_return_address(0));
 
 			GEM_TRACE("%pS timed out.\n",
 				  __builtin_return_address(0));
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.c b/drivers/gpu/drm/i915/selftests/igt_live_test.c
index 7d41874a49c5..c1fbd98d3164 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.c
@@ -59,9 +59,9 @@ int igt_live_test_end(struct igt_live_test *t)
 		return -EIO;
 
 	if (t->reset_global != i915_reset_count(&i915->gpu_error)) {
-		pr_err("%s(%s): GPU was reset %d times!\n",
-		       t->func, t->name,
-		       i915_reset_count(&i915->gpu_error) - t->reset_global);
+		drm_err(&i915->drm, "%s(%s): GPU was reset %d times!\n",
+			t->func, t->name,
+			i915_reset_count(&i915->gpu_error) - t->reset_global);
 		return -EIO;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.c b/drivers/gpu/drm/i915/selftests/igt_reset.c
index a2838c65f8a5..7f845e5fc667 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.c
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.c
@@ -4,6 +4,8 @@
  * Copyright © 2018 Intel Corporation
  */
 
+#include <drm/drm_print.h>
+
 #include "igt_reset.h"
 
 #include "gt/intel_engine.h"
@@ -16,7 +18,8 @@ void igt_global_reset_lock(struct intel_gt *gt)
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
 
-	pr_debug("%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
+	drm_dbg(&gt->i915->drm, "%s: current gpu_error=%08lx\n",
+		__func__, gt->reset.flags);
 
 	while (test_and_set_bit(I915_RESET_BACKOFF, &gt->reset.flags))
 		wait_event(gt->reset.queue,
diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
index e14ac0ab1314..83f66fe4a9d5 100644
--- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
+++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
@@ -5,6 +5,8 @@
 
 #include <linux/jiffies.h>
 
+#include <drm/drm_print.h>
+
 //#include "gt/intel_engine_user.h"
 #include "gt/intel_gt.h"
 #include "i915_drv.h"
@@ -24,7 +26,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
 	for_each_engine(engine, gt, id)
 		return engine;
 
-	pr_err("No valid engine found!\n");
+	drm_err(&gt->i915->drm, "No valid engine found!\n");
 	return NULL;
 }
 
@@ -60,7 +62,9 @@ int intel_selftest_modify_policy(struct intel_engine_cs *engine,
 		break;
 
 	default:
-		pr_err("Invalid scheduler policy modification type: %d!\n", modify_type);
+		drm_err(&engine->i915->drm,
+			"Invalid scheduler policy modification type: %d!\n",
+			modify_type);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 796c9b070e41..c0dadcd961bb 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -169,7 +169,9 @@ struct drm_i915_private *mock_gem_device(void)
 	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
 				  struct drm_i915_private, drm);
 	if (IS_ERR(i915)) {
-		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
+		dev_err(&pdev->dev,
+			"Failed to allocate mock GEM device: err=%ld\n",
+			PTR_ERR(i915));
 		devres_release_group(&pdev->dev, NULL);
 		put_device(&pdev->dev);
 
-- 
2.34.1

