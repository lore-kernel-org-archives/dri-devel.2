Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BB4C61DDA
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230D710E4A7;
	Fri, 28 Aug 2026 10:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hez077OU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6244110E49A;
 Fri, 28 Aug 2026 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911448; x=1819447448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=rS7Wt10+Qd4LwK9AJ6UEQd/RoEAmILPfTYZpbf2kDr4=;
 b=hez077OUzkx16kaWyEaXzPaolgs8/iG4I2MMHQWOa4K2jduj/Ng2phdC
 r1CDBm5p2dckVt2RhfEA6qK9aoRo5HHDEEbh2aWmmHQ7b/YlakprFtaeh
 Mk0i6pH2uWw4ZB2RMaJI9e3C1Nqac1Pkz2Jt1rSa4Qx2J3SEWMq0pFLbo
 NJau/IG/cRpvM1boG7YXpoiyaDhSumFYV+WR/DK0BPkSrVKbL2iVQHhIQ
 59uiWEoxl7S8JB2TWeC+gL/qiB4uMmxO1PDoGMU9OXE6ph3oCS5vxlOQq
 ppiyZajC7ZmyYFnyeMpAhUhdZ4E9WwhZFPMRFR2BZ33woj+aagn3Sjt5+ g==;
X-CSE-ConnectionGUID: XhhUVMjaTr6Q2M4w2PdDgQ==
X-CSE-MsgGUID: MbCtxj3UQiOkVXIwJd0+BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105791699"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="105791699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:07 -0700
X-CSE-ConnectionGUID: PV36n9hXRYKhoHoYHVOIvg==
X-CSE-MsgGUID: jtZLKpPIQ2ei+lDhyuQiJg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:06 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuKIaJmXJjMEVPcSjQ1dJzR6BMDZBNG7SCVfrjlVMKpO8D/kNDBQsT6WRoL19qgEKFWYpZcGwkyHXq/8wXl4VIjl/7yJdVjNluvH/Vpioa8qZ+y3w+WWS6mBl+GQLkd1F8HZpUQDqsG69mmy0v/aXzvwOLfSiBoQ2gacfxMH3WvrOtUsstLoO/Xld440CVkU21AmJYSmvcDeFkYSH18wy80ZJ/vZGHaMoyXdZyve8V4tt0oz4i0TkEmHlgaUTpdq+OjGBI25m3+YK5w6KNBIfz3/f8gamfY1Z6RbL+PUXkXBrRS3emLFNaqbO6ZwgiD7LO4HK4mlWRh/26cAWS7Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD/qDIPtPDrdhFbzZhT4c/icwRUX/gTwH1UaHZ2C5ec=;
 b=yLBWWnTQjt7O8eoGeF4GHW/jy2LGQ3SHG8r15eYyrWPmw72PGvfoj32p9wFK1LYulsxB2b+YKG1MSZi9V2vXw9it5QrMR/tdZH7YVs6w6snVYviHZ/0YsOJ60Rr17ffU8eyfcsuS/SnPex9/EcBQ+qvCa1a464z9LYm5faFcCq8hupkA94ip8MgaoTJG1qeefz5F+ituymDRLugR0s2fTnBoLLbjg4e6aGwcPtrmSDWKNpr2H5BFhfp8nlLvS/Dgc6nEEkVTyrJbKvVYYw+ESU9evowMXXWAuHvnNTVSk61jnjS9qYcg39q52Ef2xZ/rr9WdtGUQw622OaiB5/ZjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:04 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:04:04 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 3/8] drm/i915/selftests: Use drm_* prints in selftest
 helpers
Date: Fri, 28 Aug 2026 10:03:34 +0000
Message-ID: <20260828100339.72304-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828100339.72304-1-krzysztof.karas@intel.com>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF0000022C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e5) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee1002f-937f-43f6-f941-08df04ebb0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: x/HHTYK1PRkeJieY34a/G7l9vh3q7tAqywjmNRsGrPXmI1yrwdPekedLCwML3PayBgp/tVhfb6XwPVFDUg/r/6virdk7FIFG9GbKIND9IeC/fk7X67nwlEmq8ripT2dMfm6FOSHRw3tUa+l8sON9Po0HtEbfZB2Z1k6e+hHC4O7FA+Wr2/MOJ+gRdrbrcaoMQX+S6BAamv7ddwsG4yYjzD1ni71YxY4FPiQP2Sd0DDeY3Df9Q9EhE7AhWlg4smYWuu1BCFYtYLy6HS0R0nsznIg1M5cHAZEqzJJQvelxI+Qnkj4xf9ZfmEcJBtU8HcXNlcKgPtrKzvttgtleUXBkn+b0G18dspLwMEbfTw0xM9glqlLmkQuXKCx5kNEhc1Ays6WfasuXo4is2ndvKfyLittfExfBh1E6nGjlB6Ruf8UDtSaDScfQdlfbdeq0FWBYtTzdpF8kcwJtYJilj9QQ3toT0bDn4NjiczpFol+sqqVMWy8qTaBlEn0/PNiwt0LS7T4bG2Abg5razGGsyDpho7wN4/lA7zXDcA/l+zV5FUQzXLoc6Tzq5sGPAtSjrEmAEC4IaoGYxq0RBX41mhKM2i+4BKpfIatBLB1HSvAeCaOkQTIQYbxsPFUliLDGXuLimUYPQ2JAquSUpLDlDXo6YduSCIWi81j+XgEloJmtY1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTR0akd6cXhFcFdoNis2UkJwVmQxVXBhK0NIclQ1clJaY3J1SStub3pBN3Vz?=
 =?utf-8?B?UnZrUlQ5WTUvQ0RVSnpOWVVndDlPT3VpaXc5L250Z0QwSHNadEszOFBvN1gy?=
 =?utf-8?B?UUVQV29qeDhsbFlRaUVFRDNyYzJaVjdyY2NJSEcvUWxieGxTajZncEo0SGhj?=
 =?utf-8?B?NXFmek9jNUFiTTRQVUQyNkRRaUZOMDBqVHFEZGFBNkxybzBKalhoc01zVDgz?=
 =?utf-8?B?SStHUWplN1ErWENmQmp4RkxlWlB1d2t6THpNSjJ6RmxWTWVhbDhLVDZZS3B2?=
 =?utf-8?B?Q01hdnlCd21pVFZBc0J5dUNFajlhSDRMVjhYV3VaUWUrY1ppbEZwUHJ2SlFu?=
 =?utf-8?B?S0RVMDAzcUtDL2FPZnRhaSswbUVkcm1WeVVTTkpMeitXek1Ubkk1UXJ2dloy?=
 =?utf-8?B?Uzgwa1QrcVF4S2pKSHJWazdVZ2pEeWQvN2pGcGJGV0thWVYxYzg0c095T3pV?=
 =?utf-8?B?N0lmMlIzdjNrVERQRTE1ZkZIZ0k3cVo3cHJQV0hERXR3bXQrUXlTYmdFVVNL?=
 =?utf-8?B?UFNVMjhHa3ZPR3lMVlUzQUZUdmxrWjRKay9TdEFtOVJZRzh5b1loSHpCbmtZ?=
 =?utf-8?B?Y09qYVRpS3E2Z2pzRlNaVTEvaGgwaXNoREgzeXZ3N1BpN2dGYzhDQUpYTU5Z?=
 =?utf-8?B?Z2RndTlMbzQ0QWoxVnhobmplbjRHclVqaGxhVGJJMTNTYkxlL0FleG5JUTA1?=
 =?utf-8?B?dUhmcm5hd0tBV2xUK2tEUTZqTmVKOEY4MGNiL2dWWTd1L3ZwTXo0Uisvd1dr?=
 =?utf-8?B?L2RlcXJFanYxekVZYTJSRE1kS3B5ekNSUk5XQlp0Z2ZIY3M3b3hkQTdkanFC?=
 =?utf-8?B?c2xtc01GcStLRWFSU3lVK25JRUUvdWVkK3dPOUEwZ2xNMXhLMmdpbVFZYmdI?=
 =?utf-8?B?eUo5T202aCtwL3ladDR6N1doU0VGNjZkV1FTQmFYYmU3ZElPek1LTngwbUhH?=
 =?utf-8?B?Z3lndlkwckQ3Q1dBZ1R2UE5QNklrNnhtR0lKV3JtSGkzemFZU3RqcWwrTFJy?=
 =?utf-8?B?QVZ1V0QrZlcvNDFHdjhzM3V1bDlza0RSdG5VdzZyYmtLWml2WVMwV1c4OEp6?=
 =?utf-8?B?am8rSkhXWHpuZ1BGM1ZsREVXMzQrZzJRN0RXUFNkbDYzNDVQMkFQK1EvQzhE?=
 =?utf-8?B?RURUdHVwRjdYWmZSd1JIdUVQWks0M0lXdDlrdDRYd0JCUWQ2di8xV2trZHh1?=
 =?utf-8?B?eEp5K0dNS0IraXN0VjBJM09wRExHRENuYkI3cGJJb0VUdk1kMU5QVmRVVzA5?=
 =?utf-8?B?VG9heHJIdHBKT0txOHo2azJPQUVVL0FlNW1kSGg5S1lCWFkrcjVpVDczSkZ2?=
 =?utf-8?B?c2k3aWdRb2NrV1A5SkpjZTNpaitvMlZjTUFSb0JJNFdGNWRHMFBEbUFPQ3FO?=
 =?utf-8?B?UUl5NUdoTktIMVdHakRucTJIdU00WGMwNi9GMkZqanI2Vzl5cWo4cUhMNW13?=
 =?utf-8?B?cFMwTWdDZEtXTkRJWHpGWWZ1ZTdQYjVUeHlxQUVnRlpTRitybU9OM0loNlBV?=
 =?utf-8?B?NjQ3SFc4bEh1dEowM0ZJTlRxWk9RVjh3bmFiMmFVYW5GRlZPeUJlNUZ3ZGVz?=
 =?utf-8?B?QTN0bnd3eDBUeklSbEJsZmlwRVR2ZlVIVkRLVG1LSWJkbTExd3BobUIxWFNX?=
 =?utf-8?B?V3o3SHRYWjVwNDgwM3plLzFqdktyODVUSHVqaG80Z01ib1lGWG9JRnlOcGRQ?=
 =?utf-8?B?d0J0WUhlMXhLM1lMNWl0TmhZU0tTVTEwZjBad0hXQzMyeUtocnpHNHNEQ2g4?=
 =?utf-8?B?bmtuS29OTUlWM2dVRlpVRC9vV242Z0NLeDU1S3NqblQ2Q2xBemU5UEhySHpH?=
 =?utf-8?B?TGxhZkV4Q2hIMFo5OHZLL3NMaTVhcm83QnZack1HOWhxY3pEZE9ubGpMQUR0?=
 =?utf-8?B?N2hZa0V1cXNIQ2VJdkhWQk9IcEJFMTcwajFWNEVjVGxFWVBsYU5TSzVsSFJo?=
 =?utf-8?B?UzA5U0RyQ0d5Q2ZqdmpUeFBtWVBqQll6ZFJBT2tMVVMwQ0JOc0NDbFJPbnY5?=
 =?utf-8?B?NmVKdzNPclBHWk5xb0krTDNib3Z0cWNuTzljSXREWDk5R1FReG4zVWdpWmNp?=
 =?utf-8?B?SHc3aFN6c1ZTczBES0RLMDVNam96a0NIc2NHYlF5dENiVjNEeGk1U2dHWlhO?=
 =?utf-8?B?OXVvanlDL1lsSWp4SVp5a2JNc3BISEU3OVd6VWJxTmtqUTYrb1NCeEFCNHB1?=
 =?utf-8?B?SlRPamZCQm1oVk1JNlJqeVBXNWhvL3oySVZXbUw0cnZGeEVXY2RwbU43RVND?=
 =?utf-8?B?YnJoMk9ablgvWFpGdXJEWTl4UWFqbVEyUVJSRFZ3NllsZnVDUEkwU05kaUlO?=
 =?utf-8?B?eWJLVTRLeGxhdU5LUlU3UXVCOXU4ZC9sN1V6NFUzc1FEZU9Ta0dDQitVUXNw?=
 =?utf-8?Q?OycYdfutSG3mqWgs=3D?=
X-Exchange-RoutingPolicyChecked: Kq0969mdMgJaY5Amtl654VG2rmhr/FigarP0r9UysF7OJ1XzYDiT3sXNIJI8Ihe6w8eaXq/Fs700Uho+TvqzUfcmSBXjERybWamWBmqTROt6ncNkCjbHERYVevMQV4PiWG2iJljEudsVNOfHsvkF2RdG2/ZaVkv10tAA6FqogSXqO9IPhR+g/yIKVH66pK7AxHvgQjHy23tHPlkAPgzzznaS1ChZe+46bhpovNghTxzF3bD4r+7HTTTGXCva8JL4JwVr61yTaeNfR2lqGIAFg+b3Y2ErN3llhTpb02GKiD3mReR7AQVx9x71TyYX0emJPX9iFIosDrxbUxMzahS5pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee1002f-937f-43f6-f941-08df04ebb0ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:04:04.1520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdAnUReSIvbdnRxUd75mC0KOgDoscd8YXbl7YGKkjKVj1lpXbrbJpDnc4+1550B6QEU3L+YRWq2Mx/0cpGnEgppkVexCihlZVCnzr/gc33s=
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

Move away from generic pr prints to device context aware drm
versions.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_active.c         | 12 +++++++-----
 drivers/gpu/drm/i915/selftests/igt_flush_test.c      |  7 +++++--
 drivers/gpu/drm/i915/selftests/igt_live_test.c       |  6 +++---
 drivers/gpu/drm/i915/selftests/igt_reset.c           |  5 ++++-
 .../gpu/drm/i915/selftests/intel_scheduler_helpers.c |  8 ++++++--
 drivers/gpu/drm/i915/selftests/mock_gem_device.c     |  4 +++-
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..79b55df1e71a 100644
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
 
@@ -236,7 +237,8 @@ static int live_active_barrier(void *arg)
 
 	__i915_active_wait(&active->base, TASK_UNINTERRUPTIBLE);
 	if (!READ_ONCE(active->retired)) {
-		pr_err("i915_active not retired after flushing barriers!\n");
+		drm_err(&i915->drm,
+			"i915_active not retired after flushing barriers!\n");
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
index a2838c65f8a5..7902ed9ad339 100644
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
+	drm_dbg(&gt->i915->drm, "%s: current gpu_error=%08lx\n", __func__,
+		gt->reset.flags);
 
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

