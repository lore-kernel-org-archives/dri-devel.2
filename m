Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F09C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FA210EA9A;
	Tue, 18 Aug 2026 09:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mpQFM7+n";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9124310EA72;
 Tue, 18 Aug 2026 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047006; x=1818583006;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=EuzOY1VkT5wHBkGd734b/AiDgzdGn4dYrX4CiQHvNKs=;
 b=mpQFM7+nFe+/yVh4d+hU1CH+InlyhPC6DEwvOZEIdRJYweVPH3WI9yIK
 bpA7c2bSQ2CrcyvBCSEsvV+pEtfHf3T/3bTelgaf+V+xB9WBnC3R8cw5Q
 O2iWarhBglv+/nhm3qbgpPt0VlBTSPIgu1vhUxY+7erX9hLT0/yXQXmdz
 C+NOEHnKiN92qdSjaxCgYwKM2pwQYMKe3U1sCMjNVYk2gzt4jsv6Aw5jE
 w4Oh42UFB5KeCbG2WBQLMffN71j24KiQSpF6NEHA9NtVssOSMt/z3hSVF
 U8kuLMqcTnr45xDlbAWLsSi8gce6yATI5XSj07WFtvMa1kfeZpcOP3fN3 A==;
X-CSE-ConnectionGUID: ejXfsoW7Tii9Xd2qkpc0Tw==
X-CSE-MsgGUID: OPhEZumjTQGcv0kDPOXDJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113076529"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="113076529"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:45 -0700
X-CSE-ConnectionGUID: WbaoQ4ueRLSbaK0SsY3dvA==
X-CSE-MsgGUID: tBg5yYXGRr6ixMskwzF8XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288687548"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:45 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zShtJc4m1LrL4XWvP+xMQQRQKsFHWhGFtRkFagQdwYK5tVKdXqRsyEseNXFR+tK50+VBeuyXZQ+or3TQRC2DMyMixfjoebIuxFqmc7HCpT3cdaXXWQjF3lCEkE9B/k0zSfxkOGrJu/F6mkCnJN/REuOEBTfnBvG5fMZlWfi9OfhXMVEaYaIRjMaERmtNz0NPYVX5sEfqpbWSIugdi+rJ0yzKsAxt+9FlAtbP7+egkre0Uxm+Rz6/f8Q4Y5/avrhA67gl5aCKJadfl6QaxRAUYWh5CkQrLhGMxJkUtsVSFmmsvw5W0v3G07Iv+6yzGy+0w6k/sS8XRhlfVtesqFiB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPQ14ZCi8VTtCYhyStlfMU6hvJBIAThjq+fZ4phD31g=;
 b=JAqCSlbhxYqAmBX1s9uio0DEenp656aiRpqw/qlZX67zSkZA/DxxzDGiZdE57xzoG/wnqLkU0wzLE8PErenynCxOOi+zxHG9fi21w6Qd0IKXLAykWCaLosMxsFqpJuEpOJeyg8YA6crM/Moa9JyA7G3eA9b0qbivJcwyEFt1VhGJ61ptm3IUMx0FJ57di1lGaQ+rw6BpY9QtL4M5ShObNLo0j3KN20OiNcvOAiNmWMSS1bcUg9Wjqm4uhLNFBT2B6ijUgXUmLnrAPkxEfU0aHmS2jtEYY7iekT9ZjQVAuoETmqm6LdJ2zjlUsLVLqr3+MebmvXalxiCdptKPdNXk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:42 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:42 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 4/8] drm/i915/selftests: Use drm_* prints in selftest
 helpers
Date: Tue, 18 Aug 2026 09:56:20 +0000
Message-ID: <20260818095624.3254368-5-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818095624.3254368-1-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::6) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f59bb8b-263c-4f55-5e30-08defd0f014d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6CBtPnp6LcmUz2GlRIjpR9s2vhdy7xiToLdGLEhmapFlnGZyEXwno4nzFKkJ1fkqZLO38r2XI5EfN4Smx0UH9drPF1wuZGJm95YBoQJTNarcD/l0W+Y5yJQN8hR/liushLZGL/ezMMi3xy+guHX+WxSF4phrgmjKZgJUu8SmX8BI+jZZCCUTOSCTeI8JNBR/Zv6c1weZMs9jMoaJ7tLq5PIcDMg2wKjRANzWJROolqqqs8An37NkR78M8ZNozzxAWS5yq+CtnTAWSYs8+rXr8z8lBwsUoP/rvgGyXCotWnljOmbGX0QCwUI8NzkNXcS2aib7FaHzrnPqwRW808JNus2zvpiTSjSwqoCMXerW+9LVcGF0ECKMzsq/sqQSHjcN4Dgpq5l4tlFd616eoVAF5eYG9hq5sm0VNoPazsxmlQ21UtXUxPND7uU2hi2EhHY7v4+umfpIGwjk/Fgw4X7uVyQ1bG5QVUwuBKaalL+ZxqN+1jrzEMAa/rrzBhD8BdS8raqXP072ab5xgR1TmvfgYLcxVqM8wkuM2NY/ixUHlNgXs+S1ws0xe69JAFvTKX+87RGUXK7vZ46b+OnM+/rjZWCgMbV9kW5GflHotIH64WeH2C0nWJWMU1Auc5XUDYH9KqbqqwDxQNCLih1W9bX4YRiqH7nQr4L716bOwuRYw0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhFeHhvUUptcDRzRyt2aFF1MDJiR1N6TW9kdFBnK1ZJdElVcUpUTXNSMEFG?=
 =?utf-8?B?OVFjTU9DUXBpR2dOMUhKNlJhTGJsVTN1WFVtMjI5UFdGWHdtSFQ4TkVOOXpC?=
 =?utf-8?B?MUNTcllmV2NhWFFEbjY1QXBqeE9GVTJzeFVUOFFsdUEvbm9lMEhlMDRRZ092?=
 =?utf-8?B?L1U3Ni9DOWpZdlpnOVpOVmpCWitqa0dJY0NGeWp4OTRYRHAvdzZrTVd1RnhY?=
 =?utf-8?B?MVFUYWRwbUJZUmhhbHpGV3pQbEdzY1pCZGtIRkdTeVgrU014cksxV0JaNHhU?=
 =?utf-8?B?SU5rL0dCakZrVm1PanZCN2ZsdmFXZGdzem9LWGRsV0xjR1RxSXlSd0MrZk1K?=
 =?utf-8?B?YVlNMjNnQ3Z1WHAzelFCU1M3SjN0Y2tqNjVEeDJUdkVrdFFtMUFFQldJd1Fl?=
 =?utf-8?B?cHQ1cEVhMHFHc3VMT3FGSkUvZG5DNDlOazY5SUE1OTNIL1JmY2NycXV1YWtJ?=
 =?utf-8?B?Rjk0dlBkbm5USTZPSTVKdTZjK2JvTklpMkVCMEQ2eUwyelNXR2s4TjNYTm1y?=
 =?utf-8?B?bUhBUnhsdjNaeExWNEErbml5cDdFRFllLzExdFd3WlN6VWVXK3doaisvUm5K?=
 =?utf-8?B?M2g0Y2M5Qkp4b0h4ODBleDhrSm9mcFVUaXQxYWluOCtYSFF2b2JUWWdQNkRr?=
 =?utf-8?B?Q3ZJM3BteTZFNmZFUG0vSWZEKzR5cUZoWEh6QlF4V21JOXh3U0VqVkQ0NzEr?=
 =?utf-8?B?OXlQWUZOYWRmallISDlrakNiYXd1c3dTQmxNNno1c1VIUmZzT0UyandKVE1P?=
 =?utf-8?B?dFU5OHErbTI3anM2UDQwWFR6UTZBRmh3VFhqUGFlNUZnSTJLdjRSaCt1Ky9K?=
 =?utf-8?B?WmNCOGdiK3dMaHhSY2N5c1FKbWRCQkROUWhaMkUxdTFUcW16ODJ3R3VkeXlT?=
 =?utf-8?B?OWRHbk1PV1pIMk00YkxzTk5GNWgyeFFjWmlpcmgwSHRTOXRNT2xxVEF5bHhI?=
 =?utf-8?B?SmtSKzhTN2xlNUpualFrQVo2L3hDRVhSMmpMSFV0S2JZSTlpNXdqcUR0cjFy?=
 =?utf-8?B?L0U3TDVzR3FJU3NnMS9kckF4bTAxMjFFQ3NXcm5UTTlET1h1RDhoWldqWW9x?=
 =?utf-8?B?YXNmeW9jSU92andPUUhnQ2FrOGkwOVVYVzFQZXBmMUJmWTVyeEdnN2tEVVR6?=
 =?utf-8?B?bzMwWWtCUENSZWwxYUNRTnFNZTBHeDRRRm90ZzNwZUwwU21qL29XQjdNR0tD?=
 =?utf-8?B?MDZyYmdZS3E4SDliM3k3Z1AwQ05Lb0c3ajZtTHZMZzhVN0lpekdZZnM5YjFq?=
 =?utf-8?B?M1NSY013dkVrVHpTRUpTdjVNdis1TFkvelBId0F2M250VlhvQndhM0w4My8r?=
 =?utf-8?B?bkhLMGRLSzZIc3gvN0NaT2g1ZnpLUmNUYmI3Q2ZJMWRTYnV6VVFQYXJrM1A5?=
 =?utf-8?B?NVQySlN5bHBpeDd4cm12OWd0TWFRUU5QMVJWb2Myc0tHZkNBMHk0OE9aQnZi?=
 =?utf-8?B?amMwL05qazZmbkduSDNIWndMRmVrVmkrQ0xuNDFIS3ljYzE1VDJOMDYrZHJ2?=
 =?utf-8?B?NmtmbWJqWDBpRmtDdXFaUDhTMHpwbGRkVWlIaitZRE9EbGpMdXV3NEg3d29U?=
 =?utf-8?B?NkxFeHp3b3pidzZOQ0E3cDJGZ1Y3ODlLMDA2M05rZGkyQjliVXE5TGJkZkxz?=
 =?utf-8?B?ZE92RlJoQjFrUTA2bkV1NFFDYUY0RlhjcGZzK1hidEE4TERlUUx5UGFoaGRk?=
 =?utf-8?B?NG9NUk5ZQzBOYWU4MndGL3VCendhYkY4MHhhOGJvRE5aUTdxNEhPUUxzcUNo?=
 =?utf-8?B?b2cwRE1hNlk2VWJNblNrbGtGWU5pV3UzOTNTclNkNm52Q1BwbER0UHhFcHNx?=
 =?utf-8?B?TW9lY2R4STczM2tzWDlUUkg3NWVVTHhWNFU3V2JPVlk3TnhZbUJMS1hnUFdj?=
 =?utf-8?B?WGhRSlpCN3ZZRzZnZVBWUHN2RTZFRDNLZHJKemtIZXUwbU9iOTdmSWU0aTlw?=
 =?utf-8?B?dGVKa3JqSXRyNktnK3hidmE0cnhET3BrcmZNM1FJdlJIR0xvSU5zN0xsVEZx?=
 =?utf-8?B?Y2d0cVFvOFE1NnlwQ3JobEVqSVNEdGsrWFJoVnVZS2hzbmdNOXZrUUpEN2pk?=
 =?utf-8?B?WENCQm5SeTN6VGVLVExJc2FpRWV4ZVl5dEVOeTc5d3JGQTJKNUU5dGVTL1Nx?=
 =?utf-8?B?dVgxYzFsZFgzejlOZjF3VUJ1blJGUjg0cjBjU1JhZWdnb1VEbHY4ZEcvVEw1?=
 =?utf-8?B?bjJ5U2dFQ3pXZ3RFeEFWbmpLbTJrSDd5YzdScGdpbW9BVUpGRm90L291UWt2?=
 =?utf-8?B?cjd5V2dJMlFzc3NuTGVLOGlPSHNFbTZ0L0UxeGpiOVdSMnVnRUVTTGpvdTAr?=
 =?utf-8?B?N3V0YmhpREUyN3JrRERBU0R0RUFwUHdnUmhRODdUdllDK2dxTkxWbVBRRytx?=
 =?utf-8?Q?AgH0CCzEatHnRVMs=3D?=
X-Exchange-RoutingPolicyChecked: at+o2zGQ8roCMNfvLE9nHFCZexUJYG0IxtT9Acf3cV9Jc1A5cA8iPegUWMurgZgqVxWvMsbt48tdj/WABOCPv32mKdA5KLfXq5VhPU9pDKUDLoQ2ec5sYKPgHRsia6AwhMp9zTpAgzCrGvRa5XkeSIbIihllVoQvGiYXMgqt0y+9KLwAbjEf+CNVVwvJdaJKt54B79iSjmbQhUlphUa+/XpafygmnQXq8Dhoar25xFUrpShr+0fy8jI3nU+kFxKnPxoYeuRVZtyUqiJkKeFYyXOwPlG7SoztE2kTJ0dRrzGpUTcVRyIxHQf9am2piL/XCAAbdZ2dHZD3pzv5RfqQiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f59bb8b-263c-4f55-5e30-08defd0f014d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:42.3535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UI8pQClizb4hr4aJmhYMrbQ25WDRPkpcE+Hr4ZgmGi8Grh1pskGvhwMghB4vZlDf2Q0onNbW91njf3wyghBnTEzPZZnrWQp4J2oDU6WwQBw=
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

Move away from generic pr prints to device context aware drm
versions.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_active.c      | 15 ++++++++++-----
 drivers/gpu/drm/i915/selftests/igt_flush_test.c   |  6 ++++--
 drivers/gpu/drm/i915/selftests/igt_live_test.c    |  5 ++---
 drivers/gpu/drm/i915/selftests/igt_reset.c        |  4 +++-
 .../drm/i915/selftests/intel_scheduler_helpers.c  |  7 +++++--
 drivers/gpu/drm/i915/selftests/mock_gem_device.c  |  4 +++-
 6 files changed, 27 insertions(+), 14 deletions(-)

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
index c383d31d46b0..b981d06c3f32 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
@@ -7,6 +7,8 @@
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_requests.h"
 
+#include <drm/drm_print.h>
+
 #include "i915_drv.h"
 #include "i915_selftest.h"
 
@@ -35,8 +37,8 @@ int igt_flush_test(struct drm_i915_private *i915)
 
 		/* 2x longest preempt timeout, experimentally determined */
 		if (intel_gt_wait_for_idle(gt, HZ * timeout_ms / 500) == -ETIME) {
-			pr_err("%pS timed out, cancelling all further testing.\n",
-			       __builtin_return_address(0));
+			drm_err(&gt->i915->drm, "%pS timed out, cancelling all further testing.\n",
+				__builtin_return_address(0));
 
 			GEM_TRACE("%pS timed out.\n",
 				  __builtin_return_address(0));
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.c b/drivers/gpu/drm/i915/selftests/igt_live_test.c
index 7d41874a49c5..fa93f9720dad 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.c
@@ -59,9 +59,8 @@ int igt_live_test_end(struct igt_live_test *t)
 		return -EIO;
 
 	if (t->reset_global != i915_reset_count(&i915->gpu_error)) {
-		pr_err("%s(%s): GPU was reset %d times!\n",
-		       t->func, t->name,
-		       i915_reset_count(&i915->gpu_error) - t->reset_global);
+		drm_err(&i915->drm, "%s(%s): GPU was reset %d times!\n", t->func, t->name,
+			i915_reset_count(&i915->gpu_error) - t->reset_global);
 		return -EIO;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.c b/drivers/gpu/drm/i915/selftests/igt_reset.c
index a2838c65f8a5..0ab280db7dd4 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.c
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.c
@@ -4,6 +4,8 @@
  * Copyright © 2018 Intel Corporation
  */
 
+#include <drm/drm_print.h>
+
 #include "igt_reset.h"
 
 #include "gt/intel_engine.h"
@@ -16,7 +18,7 @@ void igt_global_reset_lock(struct intel_gt *gt)
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
 
-	pr_debug("%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
+	drm_dbg(&gt->i915->drm, "%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
 
 	while (test_and_set_bit(I915_RESET_BACKOFF, &gt->reset.flags))
 		wait_event(gt->reset.queue,
diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
index e14ac0ab1314..a5f379f27352 100644
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
 
@@ -60,7 +62,8 @@ int intel_selftest_modify_policy(struct intel_engine_cs *engine,
 		break;
 
 	default:
-		pr_err("Invalid scheduler policy modification type: %d!\n", modify_type);
+		drm_err(&engine->i915->drm, "Invalid scheduler policy modification type: %d!\n",
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

