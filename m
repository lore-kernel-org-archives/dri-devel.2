Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95925C5DF83
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F30010EA81;
	Tue, 18 Aug 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CeBFDCFM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D604410EAA5;
 Tue, 18 Aug 2026 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047009; x=1818583009;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=2LauODgUnRR/YwnR1uTWPVGFv6ULQ1sWppWN6S5VblY=;
 b=CeBFDCFM2iUZWXR/lAnHPQlyi9BUEiccqFrV+a+2m+95VfpurG+tQ0XX
 BXpqTmiAwGHG6UlpapI7dMftt4+cCHmueZfrMjd52CFMGtg3HsgUuHszT
 2JhHsElMKFSxz5EACxbVzYEK5zi0O4Z9zV6dLb/PPJVOEC28Lv/bWqsnv
 9xIDY1dZmmMZuPKwQSHh+qDqYfbSy7N42PpBrd6q5q/dMtmuA8NFuDJi1
 +JkSZzePFYjZoVedl8d5YxVywaCDyFi/07Cuj66njcaMqpf/pZKEywoMM
 3kmDL3OnYDFjm6y/AzB8JcYh8/X1EozABufH/v2ZCN0AntSKCYeWQevlo Q==;
X-CSE-ConnectionGUID: 8bArlPPVSa2ynJwWDjoDHg==
X-CSE-MsgGUID: wvN8hy+cSCqd6gx/vt8H1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87655737"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87655737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:49 -0700
X-CSE-ConnectionGUID: GCYkBi2WQeGBTAJNF3tuJg==
X-CSE-MsgGUID: KZNVtIIxQrmDzj3n8Bp73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="264736796"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeVTq11K/EmoGhuHPoL2gwg6BfYndZjISu9yYgVb1MX3hdfDPboWPXAhjpWc1Oqn/qnNTV45YbEdWQJM6boGoty2tJnaHALH3rbKYE5NAMNoN3eH8snzDuMZ71Q14Xn6ctFLX5TGTjJcJ7OkyImP0mQeQ6IO9cFZm4Uovrd50/+DAv/GrKDzOgky4p47X0c8bgtmUeXnNimSJB0vcIbem3aby794THZaMuPwN3BeXwQ8DtTCQwIqac21/DnBk0ostK6osenmQajDLGMiSPCekrcLTdXj2PBrsWfKAzbjp7vxPgM1Zr9Hu4DXKLfdmGV0GNvaAfcs+PF5cPwR+yA/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AskhvMvZIU896jRvqT2gB9mXDhmZh/l6rQ9AAenzrbM=;
 b=MaSTkm7Ppa7MnEwGBlrmO5/p6sLvU6d2FaTxGOf8OdlaLdzpzSMHVgpyNhh8YYHJOSN0bf952UY0qpb/CxK15Od1enFWPfi+FiqZK3R4HF13YR0Gjapom5Op5xGfrCL/YRB3eQk3V9yRw85c0HAejmvB7aoDX96hxxeKneCoe5SIL//2pBKeeqP49BJ7pwauC1rRr1q1RJg3jig8UmqvBr33CgtXAKfvgDEA8cxdPm5KMfSXscxAUHaesGAP3TNjJcaVUd/xc1Q/IzbuyAD2xD38Ei8jItFNO9A8Iu9eJOpOloMGd03ZW6PYxXut3npx4i+lds2sNpqjbo4BF7LT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:44 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:44 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 5/8] drm/i915/gt/selftests: Use drm_* prints in aggregated
 gt selftests
Date: Tue, 18 Aug 2026 09:56:21 +0000
Message-ID: <20260818095624.3254368-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f69b246-5d62-46ab-a412-08defd0f0293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9qdOViYzPl/qohhyn40nE8jjBB4yjXjRTS9DNSxcsE5SqYZ8P/FzqhRioAKvqqubxTdJDUDOigBDNAQ6StOJeP0AjmzARQj12eKqcxxOoO4cgs+L8jGt7MPmtlNGV4vKrvg12OKP6iveBWGx024/hUQo5umIOX7w7qfHqm5cVwT4YaIpqQHi/c0OQYhpeUEEO5KYo0GEFEctLD8ZVOjo2sz7+DaxM5JM5p6BHFjSIWZ3gpV/e7+kjsb8TRWYg7Mi3AhfVnSVwzZEIr3gLAcKoLeu0d6Ai8Q9NSf9PibGHzb1Jh8sfAjmPCqkkcYt6G7ERs85iEo8fem++c8a2YUYCK3T/6/aq5JsrEx49R7p8KeT8Wp1Wsy/SUY4o2VdGs6dUlM3q2Hj6NqdzGWvD5t31UM/9bbwRygt8KIAROdIizb0xAmsVz5fKLtvcvFM6yOtfNn5JFxQXRROpfsUmsgcW6DskwPrED/Ggp53bMVg+eQasuCkg5o6yflIkLeM/zbAy3Wd4sKCBJ0P7ktDLguuFANgz7I1+T3UDKRtmfVkyUGHuWZEhum4Senn0DXmGOL1PeRPiMWz5/C9fgrGSsk3hKklevP3BIFKK1seWN2gGkVKMlB8H4sC+ImgW6xhS/yQyQpKxH0x7g0JG8w1trbrf8j5VHQb0lOXGzh+44FgMDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTg2ZURxWkllUmd4ZzN1cXNUMTRkalhJYVJkOFZzVDFleW15Wkc0S1VuS1Vj?=
 =?utf-8?B?a256dERsWnVPcHFaSzdTTlRjQjBNNjRjTVo5aTIxbTdnTnZJdW9qYlFBWEN1?=
 =?utf-8?B?UkRCQTRUZFduM0VoNTlFS1ZlQ1RNYjZud2gwSUVONmNnU2FYZ1cwWUppTUpK?=
 =?utf-8?B?bGZoaGZoa0tMWXlHeVRQUzZxWmZyUVZ1cHJRY21NdEVOUjlZemZyb25PbFY5?=
 =?utf-8?B?VG9EWHc4V0JEWGVKb2NSLzZIU2lPbFBjNmxURzcrOFczeUpTU3grTVcvTnhY?=
 =?utf-8?B?TU5JMjgxNSt1L25DYVZFQ2pMaHZGWVdrejlLU2toMTkvU0hiR0pHOUtDNTVS?=
 =?utf-8?B?Q2RtZjAvREZSVHFFVDllblBERFE5d041Y3ZxZm5Vdk9EbnREdVVITjBjQXRH?=
 =?utf-8?B?ZkRsLzJuaG8xUlRTVjZ4MXp2NmRaMU80b1ZPRkxkT0Z4ZlNvdGlKUWtDa3dv?=
 =?utf-8?B?eFBIZ2dsS0FwUE1LQTVydjZiNG45UHRZVFRucFdWeEpEcHBxVW5FQmdCRHVD?=
 =?utf-8?B?Rlk1djJSWXk4OWU4V0hoUUdCdmYyKzk3MUpJcEhNZ0RTZmlQYUFnTE1xcm5B?=
 =?utf-8?B?b1BKbit1MHMyelFPd0JYL1FwM2pZMjg2S2JySnhCTW9EdmsrQ3BOelVaaTdQ?=
 =?utf-8?B?UDJnWEd6ZjZtR0tpM1J1YzNodEtYNWtndm5VbjlwelM0MDVlVXR2U1IwY2Zp?=
 =?utf-8?B?UnhUOU5qdElyK2owYktqanF0QWNaUEtqYllJWUZMV1h3bWZqS0w3OUlqeEtV?=
 =?utf-8?B?c3RBTzNEckpJeStsUlRCRlpGZUlEMmJsK3VPMEpCQlI1ZGU4V0twZUh3eVFa?=
 =?utf-8?B?dGo2bEl2QmU3QmE5alVqL2l1UldidGo4WUNzRVcxd01RbW1uRmJEaXhGalVE?=
 =?utf-8?B?VWpUZmxkc1huUDJzM3JPY3g5SnFJK1ArLzY1UUlYays3ZTVDNm5CbytxZExq?=
 =?utf-8?B?U1R1MmZ3dXQvcjV1QlRiclBnYlNpczByK3FHaXB4L3RPSnNQU3NHVHRNNlVS?=
 =?utf-8?B?UjN5N0xGY1l3dlNNc00renJmam5WVmdEN3RtcE1BSEhZcjIvVG11dXoybVl1?=
 =?utf-8?B?eUFuUjZxblBRSHhLOE05QUJua204clluQUtPUm13QUJRU1ROdlcyT04zZEVF?=
 =?utf-8?B?c2VJYW80Qk9vVFA3Mjg4ZDQvQmRoYVJQMjlHcTVObjB3djcvYmZqMjV4eE1S?=
 =?utf-8?B?dTBuekhoeE9KaGF5Q0JTN0NnSDJLTEVWT0tFT0NQTDBIV2tVQ21ramZuQTNl?=
 =?utf-8?B?YThESUN1MEtrZzNBTnhKcDhtZWl1aWUwbFQrek5kWHlTWEM3WW43QVZQcnlw?=
 =?utf-8?B?ZGVhVDR6SGxzS003NHNDOEJQUjdta0RNWm1XaDNBSWpGMnhIbXlKR0RSdDQz?=
 =?utf-8?B?RTNWbndwRGEyTE1wMExJWFVvbFRiNitHRGdaWldETlMrY1pWdXRyNkhiU0pD?=
 =?utf-8?B?MXJvbUdQWVBKRUZOVmRwdUZMY05SNXJ6Mk9xQnRueXkwYThxNSsrbCtRZlNo?=
 =?utf-8?B?Ukp4bFpzRjNRc2MvSUQ1VVFiRGNzS0lrYjg3VFdUbGQ2ZFBhejk2VTlnNW5t?=
 =?utf-8?B?aWhMWldITWhRUzZrK3kwQSswOWlwNzNnb2dkcXptQitJOTY4dDh3T0ZMNFVS?=
 =?utf-8?B?RmczL3E1SlE2emF3SmY4WnR4V2NSMGhaMCsvVHdYTnp1bHd5UXg3NkRQWExj?=
 =?utf-8?B?M2JvdkNmV3pIcGo0L2g5M0s4Tm5YNFIvV0FpZ21LUGNrOGNyTmx4ZnYxeEFh?=
 =?utf-8?B?MFpJZ3RLM2s3b0d2S1psS3p1L3NGUVVJaWJCUWN3d3RiNTNHQ1dTT0FUV3BF?=
 =?utf-8?B?N0ZQb1RGbTRNUDFIdlhFNzNUOWo5dElFK3NwQWVoYWVwMlRIbkY2L085aWNW?=
 =?utf-8?B?aE5KK2k3MEIrc2lCZWMyRkdxa3BURkphZGU3cHVvZVJoSHF4VVlJd291Y1Ro?=
 =?utf-8?B?L3VIWFNqNXVScWZiWTJYRVBCeDNKZkFLNHBCWTV4N0VYTnYrNmlZRnlnbmxN?=
 =?utf-8?B?eisrR0VJTGxqd2ZYV3hONFJ1d0dVMm5xVkZTQkNRQjZEK1hJK3R3enNjRGJX?=
 =?utf-8?B?cUpYVDF2OGUxZ1VXWG1lTjI5ejUxL2xUaDFHRTJNKzhRd1R5RE1SdXNtS1Fk?=
 =?utf-8?B?MEZIUWVzYVh3RWhNK2dEOFdpZTdsbzA0bm5VdHRvR1JHN0R5UDFkdDJudlVK?=
 =?utf-8?B?cVNoYVQ5QmZWanREcS9FMFpHcmJLYzhKenIvN1JyZ2JYcWptZEdkQUVZOWVJ?=
 =?utf-8?B?aVVOVGxGTlptT1cwc1o3NTVZUXBLcFUwcFJRT05hUkZ3ZisraytRM3BqWTB2?=
 =?utf-8?B?T3R0OWtFQ2hiY21Bc2dLb2VmeWtLbGgwSmRhWDZoMm02a0h6UmY5bUw1T0hw?=
 =?utf-8?Q?J1Uv7A5+m1c47SG0=3D?=
X-Exchange-RoutingPolicyChecked: iex1jvqpKRbZns/3Ehqlb7GWnJmG1DeDSV9P2QZy00VhUWfYPX//MnhnnINtwzuhDK8Lj8jehuql9bYCmSskwbKo28S5Sx0jPfqmfk2lHhRTrmEQclqKHt6zTkgnMbfDx99DyT/xcM5/pg2zN8UAposRyzMCZ1TD46GKb5wft5j5UWYy1nFQDlLhqrLMw0RgjXYW1PIh1GLojiysMAnbB4px9wRvaY2UnADqk4BMyEntgJVE0oAZ42R+OIazGZWqPri9/vxlIwjPmjdsajzQ9bnvibNE3umP0ByAEDThgR0AK8w41PHWGFja4oyZhym4BPQgUGY6b1dToRONJ/SFcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f69b246-5d62-46ab-a412-08defd0f0293
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:44.5771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFII1Vkura2Q/HAQAtEoOd+rpLD5+51Eb3zyzcQyerdoVU2G4EghD4Q5S+Tkz6JIzgoh4+dNRlQfhMJzpR2nLOwr/4v8C9OyYQUfmF3rLh0=
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
 drivers/gpu/drm/i915/gt/selftest_context.c    |  27 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  35 +--
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  50 +--
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 294 +++++++++---------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  25 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  51 ++-
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |  12 +-
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  27 +-
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  86 ++---
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  34 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  91 +++---
 11 files changed, 396 insertions(+), 336 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_context.c b/drivers/gpu/drm/i915/gt/selftest_context.c
index ab76703f6e8b..e91617771b59 100644
--- a/drivers/gpu/drm/i915/gt/selftest_context.c
+++ b/drivers/gpu/drm/i915/gt/selftest_context.c
@@ -136,7 +136,8 @@ static int __live_context_size(struct intel_engine_cs *engine)
 		goto err_unpin;
 
 	if (memchr_inv(vaddr, POISON_INUSE, I915_GTT_PAGE_SIZE)) {
-		pr_err("%s context overwrote trailing red-zone!", engine->name);
+		drm_err(&engine->i915->drm,
+			"%s context overwrote trailing red-zone!", engine->name);
 		err = -EINVAL;
 	}
 
@@ -221,8 +222,8 @@ static int __live_active_context(struct intel_engine_cs *engine)
 		return 0;
 
 	if (intel_engine_pm_is_awake(engine)) {
-		pr_err("%s is awake before starting %s!\n",
-		       engine->name, __func__);
+		drm_err(&engine->i915->drm, "%s is awake before starting %s!\n",
+			engine->name, __func__);
 		return -EINVAL;
 	}
 
@@ -250,15 +251,16 @@ static int __live_active_context(struct intel_engine_cs *engine)
 
 		/* Context will be kept active until after an idle-barrier. */
 		if (i915_active_is_idle(&ce->active)) {
-			pr_err("context is not active; expected idle-barrier (%s pass %d)\n",
-			       engine->name, pass);
+			drm_err(&engine->i915->drm,
+				"context is not active; expected idle-barrier (%s pass %d)\n",
+				engine->name, pass);
 			err = -EINVAL;
 			goto out_engine;
 		}
 
 		if (!intel_engine_pm_is_awake(engine)) {
-			pr_err("%s is asleep before idle-barrier\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s is asleep before idle-barrier\n",
+				engine->name);
 			err = -EINVAL;
 			goto out_engine;
 		}
@@ -280,7 +282,7 @@ static int __live_active_context(struct intel_engine_cs *engine)
 		goto err;
 
 	if (!i915_active_is_idle(&ce->active)) {
-		pr_err("context is still active!");
+		drm_err(&engine->i915->drm, "context is still active!");
 		err = -EINVAL;
 	}
 
@@ -374,8 +376,8 @@ static int __live_remote_context(struct intel_engine_cs *engine)
 		return 0;
 
 	if (intel_engine_pm_is_awake(engine)) {
-		pr_err("%s is awake before starting %s!\n",
-		       engine->name, __func__);
+		drm_err(&engine->i915->drm, "%s is awake before starting %s!\n",
+			engine->name, __func__);
 		return -EINVAL;
 	}
 
@@ -403,8 +405,9 @@ static int __live_remote_context(struct intel_engine_cs *engine)
 			break;
 
 		if (i915_active_is_idle(&remote->active)) {
-			pr_err("remote context is not active; expected idle-barrier (%s pass %d)\n",
-			       engine->name, pass);
+			drm_err(&engine->i915->drm,
+				"remote context is not active; expected idle-barrier (%s pass %d)\n",
+				engine->name, pass);
 			err = -EINVAL;
 			break;
 		}
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 5ffa5e30f419..583b56956634 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -207,8 +207,8 @@ static int perf_mi_bb_start(void *arg)
 		if (err)
 			break;
 
-		pr_info("%s: MI_BB_START cycles: %u\n",
-			engine->name, trifilter(cycles));
+		drm_info(&gt->i915->drm, "%s: MI_BB_START cycles: %u\n",
+			 engine->name, trifilter(cycles));
 	}
 	if (perf_end(gt, wakeref))
 		err = -EIO;
@@ -365,8 +365,8 @@ static int perf_mi_noop(void *arg)
 		if (err)
 			break;
 
-		pr_info("%s: 16K MI_NOOP cycles: %u\n",
-			engine->name, trifilter(cycles));
+		drm_info(&gt->i915->drm, "%s: 16K MI_NOOP cycles: %u\n",
+			 engine->name, trifilter(cycles));
 	}
 	if (perf_end(gt, wakeref))
 		err = -EIO;
@@ -400,11 +400,10 @@ static int intel_mmio_bases_check(void *arg)
 			u32 base = info->mmio_bases[j].base;
 
 			if (ver >= prev) {
-				pr_err("%s(%s, class:%d, instance:%d): mmio base for graphics ver %u is before the one for ver %u\n",
-				       __func__,
-				       intel_engine_class_repr(info->class),
-				       info->class, info->instance,
-				       prev, ver);
+				drm_err(NULL,
+					"%s(%s, class:%d, instance:%d): mmio base for graphics ver %u is before the one for ver %u\n",
+					__func__, intel_engine_class_repr(info->class),
+					info->class, info->instance, prev, ver);
 				return -EINVAL;
 			}
 
@@ -412,22 +411,20 @@ static int intel_mmio_bases_check(void *arg)
 				break;
 
 			if (!base) {
-				pr_err("%s(%s, class:%d, instance:%d): invalid mmio base (%x) for graphics ver %u at entry %u\n",
-				       __func__,
-				       intel_engine_class_repr(info->class),
-				       info->class, info->instance,
-				       base, ver, j);
+				drm_err(NULL,
+					"%s(%s, class:%d, instance:%d): invalid mmio base (%x) for graphics ver %u at entry %u\n",
+					__func__, intel_engine_class_repr(info->class),
+					info->class, info->instance, base, ver, j);
 				return -EINVAL;
 			}
 
 			prev = ver;
 		}
 
-		pr_debug("%s: min graphics version supported for %s%d is %u\n",
-			 __func__,
-			 intel_engine_class_repr(info->class),
-			 info->instance,
-			 prev);
+		drm_dbg(NULL,
+			"%s: min graphics version supported for %s%d is %u\n",
+			__func__, intel_engine_class_repr(info->class),
+			info->instance, prev);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
index 10e556a7eac4..3545a86956f4 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
@@ -5,6 +5,8 @@
 
 #include <linux/sort.h>
 
+#include <drm/drm_print.h>
+
 #include "gt/intel_gt_print.h"
 #include "i915_selftest.h"
 #include "intel_engine_regs.h"
@@ -128,8 +130,9 @@ static int __measure_timestamps(struct intel_context *ce,
 	}
 	i915_request_put(rq);
 
-	pr_debug("%s CTX_TIMESTAMP: [%x, %x], RING_TIMESTAMP: [%x, %x]\n",
-		 engine->name, sema[1], sema[3], sema[0], sema[4]);
+	drm_dbg(&engine->i915->drm,
+		"%s CTX_TIMESTAMP: [%x, %x], RING_TIMESTAMP: [%x, %x]\n",
+		engine->name, sema[1], sema[3], sema[0], sema[4]);
 
 	*d_ctx = sema[3] - sema[1];
 	*d_ring = sema[4] - sema[0];
@@ -159,15 +162,16 @@ static int __live_engine_timestamps(struct intel_engine_cs *engine)
 	d_ring = trifilter(s_ring);
 	d_ctx = trifilter(s_ctx);
 
-	pr_info("%s elapsed:%lldns, CTX_TIMESTAMP:%lldns, RING_TIMESTAMP:%lldns\n",
-		engine->name, dt,
-		intel_gt_clock_interval_to_ns(engine->gt, d_ctx),
-		intel_gt_clock_interval_to_ns(engine->gt, d_ring));
+	drm_info(&engine->i915->drm,
+		 "%s elapsed:%lldns, CTX_TIMESTAMP:%lldns, RING_TIMESTAMP:%lldns\n",
+		 engine->name, dt, intel_gt_clock_interval_to_ns(engine->gt, d_ctx),
+		 intel_gt_clock_interval_to_ns(engine->gt, d_ring));
 
 	d_ring = intel_gt_clock_interval_to_ns(engine->gt, d_ring);
 	if (3 * dt > 4 * d_ring || 4 * dt < 3 * d_ring) {
-		pr_err("%s Mismatch between ring timestamp and walltime!\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s Mismatch between ring timestamp and walltime!\n",
+			engine->name);
 		return -EINVAL;
 	}
 
@@ -181,8 +185,9 @@ static int __live_engine_timestamps(struct intel_engine_cs *engine)
 		d_ring *= engine->gt->clock_frequency;
 
 	if (3 * d_ctx > 4 * d_ring || 4 * d_ctx < 3 * d_ring) {
-		pr_err("%s Mismatch between ring and context timestamps!\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s Mismatch between ring and context timestamps!\n",
+			engine->name);
 		return -EINVAL;
 	}
 
@@ -232,7 +237,7 @@ static int __spin_until_busier(struct intel_engine_cs *engine, ktime_t busyness)
 	while (intel_engine_get_busy_time(engine, &unused) == busyness) {
 		dt = ktime_get() - start;
 		if (dt > 10000000) {
-			pr_err("active wait timed out %lld\n", dt);
+			drm_err(&engine->i915->drm, "active wait timed out %lld\n", dt);
 			ENGINE_TRACE(engine, "active wait time out %lld\n", dt);
 			return -ETIME;
 		}
@@ -284,9 +289,9 @@ static int live_engine_busy_stats(void *arg)
 		preempt_enable();
 		dt = ktime_sub(t[1], t[0]);
 		if (de < 0 || de > 10) {
-			pr_err("%s: reported %lldns [%d%%] busyness while sleeping [for %lldns]\n",
-			       engine->name,
-			       de, (int)div64_u64(100 * de, dt), dt);
+			drm_err(&engine->i915->drm,
+				"%s: reported %lldns [%d%%] busyness while sleeping [for %lldns]\n",
+				engine->name, de, (int)div64_u64(100 * de, dt), dt);
 			GEM_TRACE_DUMP();
 			err = -EINVAL;
 			goto end;
@@ -323,9 +328,9 @@ static int live_engine_busy_stats(void *arg)
 		preempt_enable();
 		dt = ktime_sub(t[1], t[0]);
 		if (100 * de < 95 * dt || 95 * de > 100 * dt) {
-			pr_err("%s: reported %lldns [%d%%] busyness while spinning [for %lldns]\n",
-			       engine->name,
-			       de, (int)div64_u64(100 * de, dt), dt);
+			drm_err(&engine->i915->drm,
+				"%s: reported %lldns [%d%%] busyness while spinning [for %lldns]\n",
+				engine->name, de, (int)div64_u64(100 * de, dt), dt);
 			GEM_TRACE_DUMP();
 			err = -EINVAL;
 			goto end;
@@ -358,7 +363,7 @@ static int live_engine_pm(void *arg)
 	 * tell us.
 	 */
 	if (intel_gt_pm_wait_for_idle(gt)) {
-		pr_err("Unable to flush GT pm before test\n");
+		drm_err(&gt->i915->drm, "Unable to flush GT pm before test\n");
 		return -EBUSY;
 	}
 
@@ -386,8 +391,9 @@ static int live_engine_pm(void *arg)
 
 			p->critical_section_begin();
 			if (!intel_engine_pm_get_if_awake(engine))
-				pr_err("intel_engine_pm_get_if_awake(%s) failed under %s\n",
-				       engine->name, p->name);
+				drm_err(&engine->i915->drm,
+					"intel_engine_pm_get_if_awake(%s) failed under %s\n",
+					engine->name, p->name);
 			else
 				intel_engine_pm_put_async(engine);
 			intel_engine_pm_put_async(engine);
@@ -396,8 +402,8 @@ static int live_engine_pm(void *arg)
 			intel_engine_pm_flush(engine);
 
 			if (intel_engine_pm_is_awake(engine)) {
-				pr_err("%s is still awake after flushing pm\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s is still awake after flushing pm\n", engine->name);
 				return -EINVAL;
 			}
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 21e5ed9f72a3..83667c38340a 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -89,20 +89,16 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 	} while (time_before(jiffies, timeout));
 
 	if (rq->fence.error != -EIO) {
-		pr_err("%s: hanging request %llx:%lld not reset\n",
-		       engine->name,
-		       rq->fence.context,
-		       rq->fence.seqno);
+		drm_err(&engine->i915->drm, "%s: hanging request %llx:%lld not reset\n",
+			engine->name, rq->fence.context, rq->fence.seqno);
 		return -EINVAL;
 	}
 
 	/* Give the request a jiffy to complete after flushing the worker */
 	if (i915_request_wait(rq, 0,
 			      max(0l, (long)(timeout - jiffies)) + 1) < 0) {
-		pr_err("%s: hanging request %llx:%lld did not complete\n",
-		       engine->name,
-		       rq->fence.context,
-		       rq->fence.seqno);
+		drm_err(&engine->i915->drm, "%s: hanging request %llx:%lld did not complete\n",
+			engine->name, rq->fence.context, rq->fence.seqno);
 		return -ETIME;
 	}
 
@@ -419,12 +415,10 @@ static int live_unlite_ring(void *arg)
 			n++;
 		}
 		intel_engine_flush_submission(engine);
-		pr_debug("%s: Filled ring with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
-			 engine->name, n,
-			 ce[0]->ring->size,
-			 ce[0]->ring->tail,
-			 ce[0]->ring->emit,
-			 rq->tail);
+		drm_dbg(&engine->i915->drm,
+			"%s: Filled ring with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
+			engine->name, n, ce[0]->ring->size, ce[0]->ring->tail, ce[0]->ring->emit,
+			rq->tail);
 		GEM_BUG_ON(intel_ring_direction(ce[0]->ring,
 						rq->tail,
 						ce[0]->ring->tail) <= 0);
@@ -444,15 +438,15 @@ static int live_unlite_ring(void *arg)
 		err = wait_for_submit(engine, rq, HZ / 2);
 		i915_request_put(rq);
 		if (err) {
-			pr_err("%s: preemption request was not submitted\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: preemption request was not submitted\n",
+				engine->name);
 			err = -ETIME;
 		}
 
-		pr_debug("%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
-			 engine->name,
-			 ce[0]->ring->tail, ce[0]->ring->emit,
-			 ce[1]->ring->tail, ce[1]->ring->emit);
+		drm_dbg(&engine->i915->drm,
+			"%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
+			engine->name, ce[0]->ring->tail, ce[0]->ring->emit,
+			ce[1]->ring->tail, ce[1]->ring->emit);
 
 err_ce:
 		intel_engine_flush_submission(engine);
@@ -644,8 +638,8 @@ static int live_hold_reset(void *arg)
 
 		/* Check that we do not resubmit the held request */
 		if (!i915_request_wait(rq, 0, HZ / 5)) {
-			pr_err("%s: on hold request completed!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: on hold request completed!\n",
+				engine->name);
 			i915_request_put(rq);
 			err = -EIO;
 			goto out;
@@ -655,8 +649,8 @@ static int live_hold_reset(void *arg)
 		/* But is resubmitted on release */
 		execlists_unhold(engine, rq);
 		if (i915_request_wait(rq, 0, HZ / 5) < 0) {
-			pr_err("%s: held request did not complete!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: held request did not complete!\n",
+				engine->name);
 			intel_gt_set_wedged(gt);
 			err = -ETIME;
 		}
@@ -764,22 +758,21 @@ static int live_error_interrupt(void *arg)
 
 			err = wait_for_submit(engine, client[0], HZ / 2);
 			if (err) {
-				pr_err("%s: first request did not start within time!\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: first request did not start within time!\n",
+					engine->name);
 				err = -ETIME;
 				goto out;
 			}
 
 			for (i = 0; i < ARRAY_SIZE(client); i++) {
 				if (i915_request_wait(client[i], 0, HZ / 5) < 0)
-					pr_debug("%s: %s request incomplete!\n",
-						 engine->name,
-						 error_repr(p->error[i]));
+					drm_dbg(&engine->i915->drm, "%s: %s request incomplete!\n",
+						engine->name, error_repr(p->error[i]));
 
 				if (!i915_request_started(client[i])) {
-					pr_err("%s: %s request not started!\n",
-					       engine->name,
-					       error_repr(p->error[i]));
+					drm_err(&engine->i915->drm, "%s: %s request not started!\n",
+						engine->name, error_repr(p->error[i]));
 					err = -ETIME;
 					goto out;
 				}
@@ -787,11 +780,12 @@ static int live_error_interrupt(void *arg)
 				/* Kick the tasklet to process the error */
 				intel_engine_flush_submission(engine);
 				if (client[i]->fence.error != p->error[i]) {
-					pr_err("%s: %s request (%s) with wrong error code: %d\n",
-					       engine->name,
-					       error_repr(p->error[i]),
-					       i915_request_completed(client[i]) ? "completed" : "running",
-					       client[i]->fence.error);
+					drm_err(&engine->i915->drm,
+						"%s: %s request (%s) with wrong error code: %d\n",
+						engine->name, error_repr(p->error[i]),
+						i915_request_completed(
+							client[i]) ? "completed" : "running",
+						client[i]->fence.error);
 					err = -EINVAL;
 					goto out;
 				}
@@ -802,9 +796,10 @@ static int live_error_interrupt(void *arg)
 				if (client[i])
 					i915_request_put(client[i]);
 			if (err) {
-				pr_err("%s: failed at phase[%zd] { %d, %d }\n",
-				       engine->name, p - phases,
-				       p->error[0], p->error[1]);
+				drm_err(&engine->i915->drm,
+					"%s: failed at phase[%zd] { %d, %d }\n",
+					engine->name, p - phases,
+					p->error[0], p->error[1]);
 				break;
 			}
 		}
@@ -964,8 +959,9 @@ slice_semaphore_queue(struct intel_engine_cs *outer,
 
 	if (i915_request_wait(head, 0,
 			      2 * outer->gt->info.num_engines * (count + 2) * (count + 3)) < 0) {
-		pr_err("%s: Failed to slice along semaphore chain of length (%d, %d)!\n",
-		       outer->name, count, n);
+		drm_err(&outer->gt->i915->drm,
+			"%s: Failed to slice along semaphore chain of length (%d, %d)!\n",
+			outer->name, count, n);
 		GEM_TRACE_DUMP();
 		intel_gt_set_wedged(outer->gt);
 		err = -EIO;
@@ -1174,8 +1170,8 @@ static int live_timeslice_rewind(void *arg)
 
 		err = wait_for_submit(engine, rq[A2], HZ / 2);
 		if (err) {
-			pr_err("%s: failed to submit first context\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: failed to submit first context\n",
+				engine->name);
 			goto err;
 		}
 
@@ -1192,8 +1188,8 @@ static int live_timeslice_rewind(void *arg)
 
 		err = wait_for_submit(engine, rq[B1], HZ / 2);
 		if (err) {
-			pr_err("%s: failed to submit second context\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: failed to submit second context\n",
+				engine->name);
 			goto err;
 		}
 
@@ -1222,21 +1218,21 @@ static int live_timeslice_rewind(void *arg)
 				;
 
 			if (!time_before(jiffies, timeout)) {
-				pr_err("%s: rq[%d] timed out\n",
-				       engine->name, i - 1);
+				drm_err(&engine->i915->drm, "%s: rq[%d] timed out\n",
+					engine->name, i - 1);
 				err = -ETIME;
 				goto err;
 			}
 
-			pr_debug("%s: slot[%d]:%x\n", engine->name, i, slot[i]);
+			drm_dbg(&engine->i915->drm, "%s: slot[%d]:%x\n", engine->name,
+				i, slot[i]);
 		}
 
 		/* XZY: XZ < XY */
 		if (slot[Z] - slot[X] >= slot[Y] - slot[X]) {
-			pr_err("%s: timeslicing did not run context B [%u] before A [%u]!\n",
-			       engine->name,
-			       slot[Z] - slot[X],
-			       slot[Y] - slot[X]);
+			drm_err(&engine->i915->drm,
+				"%s: timeslicing did not run context B [%u] before A [%u]!\n",
+				engine->name, slot[Z] - slot[X], slot[Y] - slot[X]);
 			err = -EINVAL;
 		}
 
@@ -1347,8 +1343,9 @@ static int live_timeslice_queue(void *arg)
 		engine->sched_engine->schedule(rq, &attr);
 		err = wait_for_submit(engine, rq, HZ / 2);
 		if (err) {
-			pr_err("%s: Timed out trying to submit semaphores\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Timed out trying to submit semaphores\n",
+				engine->name);
 			goto err_rq;
 		}
 
@@ -1361,8 +1358,8 @@ static int live_timeslice_queue(void *arg)
 		err = wait_for_submit(engine, nop, HZ / 2);
 		i915_request_put(nop);
 		if (err) {
-			pr_err("%s: Timed out trying to submit nop\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Timed out trying to submit nop\n", engine->name);
 			goto err_rq;
 		}
 
@@ -1385,8 +1382,8 @@ static int live_timeslice_queue(void *arg)
 			struct drm_printer p =
 				drm_info_printer(gt->i915->drm.dev);
 
-			pr_err("%s: Failed to timeslice into queue\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Failed to timeslice into queue\n", engine->name);
 			intel_engine_dump(engine, &p,
 					  "%s\n", engine->name);
 
@@ -1501,8 +1498,9 @@ static int live_timeslice_nopreempt(void *arg)
 		 * enough to see if it is timesliced in by mistake.
 		 */
 		if (i915_request_wait(rq, 0, slice_timeout(engine)) >= 0) {
-			pr_err("%s: I915_PRIORITY_BARRIER request completed, bypassing no-preempt request\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: I915_PRIORITY_BARRIER request completed, bypassing no-preempt request\n",
+				engine->name);
 			err = -EINVAL;
 		}
 		i915_request_put(rq);
@@ -1648,8 +1646,8 @@ static int live_busywait_preempt(void *arg)
 		/* Low priority request should be busywaiting now */
 		if (i915_request_wait(lo, 0, 1) != -ETIME) {
 			i915_request_put(lo);
-			pr_err("%s: Busywaiting request did not!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Busywaiting request did not!\n", engine->name);
 			err = -EIO;
 			goto err_vma;
 		}
@@ -1680,8 +1678,9 @@ static int live_busywait_preempt(void *arg)
 		if (i915_request_wait(lo, 0, HZ / 5) < 0) {
 			struct drm_printer p = drm_info_printer(gt->i915->drm.dev);
 
-			pr_err("%s: Failed to preempt semaphore busywait!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Failed to preempt semaphore busywait!\n",
+				engine->name);
 
 			intel_engine_dump(engine, &p, "%s\n", engine->name);
 			GEM_TRACE_DUMP();
@@ -1871,7 +1870,7 @@ static int live_late_preempt(void *arg)
 
 		i915_request_add(rq);
 		if (!igt_wait_for_spinner(&spin_lo, rq)) {
-			pr_err("First context failed to start\n");
+			drm_err(&engine->i915->drm, "First context failed to start\n");
 			goto err_wedged;
 		}
 
@@ -1885,7 +1884,7 @@ static int live_late_preempt(void *arg)
 
 		i915_request_add(rq);
 		if (igt_wait_for_spinner(&spin_hi, rq)) {
-			pr_err("Second context overtook first?\n");
+			drm_err(&engine->i915->drm, "Second context overtook first?\n");
 			goto err_wedged;
 		}
 
@@ -1893,7 +1892,8 @@ static int live_late_preempt(void *arg)
 		engine->sched_engine->schedule(rq, &attr);
 
 		if (!igt_wait_for_spinner(&spin_hi, rq)) {
-			pr_err("High priority context failed to preempt the low priority context\n");
+			drm_err(&engine->i915->drm,
+				"High priority context failed to preempt the low priority context\n");
 			GEM_TRACE_DUMP();
 			goto err_wedged;
 		}
@@ -1993,7 +1993,7 @@ static int live_nopreempt(void *arg)
 
 		i915_request_add(rq_a);
 		if (!igt_wait_for_spinner(&a.spin, rq_a)) {
-			pr_err("First client failed to start\n");
+			drm_err(&engine->i915->drm, "First client failed to start\n");
 			goto err_wedged;
 		}
 
@@ -2012,22 +2012,23 @@ static int live_nopreempt(void *arg)
 
 		/* Wait long enough for preemption and timeslicing */
 		if (igt_wait_for_spinner(&b.spin, rq_b)) {
-			pr_err("Second client started too early!\n");
+			drm_err(&engine->i915->drm, "Second client started too early!\n");
 			goto err_wedged;
 		}
 
 		igt_spinner_end(&a.spin);
 
 		if (!igt_wait_for_spinner(&b.spin, rq_b)) {
-			pr_err("Second client failed to start\n");
+			drm_err(&engine->i915->drm, "Second client failed to start\n");
 			goto err_wedged;
 		}
 
 		igt_spinner_end(&b.spin);
 
 		if (engine->execlists.preempt_hang.count) {
-			pr_err("Preemption recorded x%d; should have been suppressed!\n",
-			       engine->execlists.preempt_hang.count);
+			drm_err(&engine->i915->drm,
+				"Preemption recorded x%d; should have been suppressed!\n",
+				engine->execlists.preempt_hang.count);
 			err = -EINVAL;
 			goto err_wedged;
 		}
@@ -2089,7 +2090,8 @@ static int __cancel_active0(struct live_preempt_cancel *arg)
 
 	err = wait_for_reset(arg->engine, rq, HZ / 2);
 	if (err) {
-		pr_err("Cancelled inflight0 request did not reset\n");
+		drm_err(&arg->engine->i915->drm,
+			"Cancelled inflight0 request did not reset\n");
 		goto out;
 	}
 
@@ -2152,13 +2154,15 @@ static int __cancel_active1(struct live_preempt_cancel *arg)
 		goto out;
 
 	if (rq[0]->fence.error != 0) {
-		pr_err("Normal inflight0 request did not complete\n");
+		drm_err(&arg->engine->i915->drm,
+			"Normal inflight0 request did not complete\n");
 		err = -EINVAL;
 		goto out;
 	}
 
 	if (rq[1]->fence.error != -EIO) {
-		pr_err("Cancelled inflight1 request did not report -EIO\n");
+		drm_err(&arg->engine->i915->drm,
+			"Cancelled inflight1 request did not report -EIO\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -2234,7 +2238,8 @@ static int __cancel_queued(struct live_preempt_cancel *arg)
 		goto out;
 
 	if (rq[0]->fence.error != -EIO) {
-		pr_err("Cancelled inflight0 request did not report -EIO\n");
+		drm_err(&arg->engine->i915->drm,
+			"Cancelled inflight0 request did not report -EIO\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -2246,13 +2251,15 @@ static int __cancel_queued(struct live_preempt_cancel *arg)
 	 */
 	if (intel_engine_has_semaphores(rq[1]->engine) &&
 	    rq[1]->fence.error != 0) {
-		pr_err("Normal inflight1 request did not complete\n");
+		drm_err(&arg->engine->i915->drm,
+			"Normal inflight1 request did not complete\n");
 		err = -EINVAL;
 		goto out;
 	}
 
 	if (rq[2]->fence.error != -EIO) {
-		pr_err("Cancelled queued request did not report -EIO\n");
+		drm_err(&arg->engine->i915->drm,
+			"Cancelled queued request did not report -EIO\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -2300,7 +2307,8 @@ static int __cancel_hostile(struct live_preempt_cancel *arg)
 
 	err = wait_for_reset(arg->engine, rq, HZ / 2);
 	if (err) {
-		pr_err("Cancelled inflight0 request did not reset\n");
+		drm_err(&arg->engine->i915->drm,
+			"Cancelled inflight0 request did not reset\n");
 		goto out;
 	}
 
@@ -2371,7 +2379,8 @@ static int __cancel_fail(struct live_preempt_cancel *arg)
 	intel_engine_set_heartbeat(engine,
 				   engine->defaults.heartbeat_interval_ms);
 	if (err) {
-		pr_err("Cancelled inflight0 request did not reset\n");
+		drm_err(&engine->i915->drm,
+			"Cancelled inflight0 request did not reset\n");
 		goto out;
 	}
 
@@ -2490,7 +2499,7 @@ static int live_suppress_self_preempt(void *arg)
 
 		i915_request_add(rq_a);
 		if (!igt_wait_for_spinner(&a.spin, rq_a)) {
-			pr_err("First client failed to start\n");
+			drm_err(&engine->i915->drm, "First client failed to start\n");
 			st_engine_heartbeat_enable(engine);
 			goto err_wedged;
 		}
@@ -2513,7 +2522,7 @@ static int live_suppress_self_preempt(void *arg)
 			igt_spinner_end(&a.spin);
 
 			if (!igt_wait_for_spinner(&b.spin, rq_b)) {
-				pr_err("Second client failed to start\n");
+				drm_err(&engine->i915->drm, "Second client failed to start\n");
 				st_engine_heartbeat_enable(engine);
 				goto err_wedged;
 			}
@@ -2524,10 +2533,9 @@ static int live_suppress_self_preempt(void *arg)
 		igt_spinner_end(&a.spin);
 
 		if (engine->execlists.preempt_hang.count) {
-			pr_err("Preemption on %s recorded x%d, depth %d; should have been suppressed!\n",
-			       engine->name,
-			       engine->execlists.preempt_hang.count,
-			       depth);
+			drm_err(&engine->i915->drm,
+				"Preemption on %s recorded x%d, depth %d; should have been suppressed!\n",
+				engine->name, engine->execlists.preempt_hang.count, depth);
 			st_engine_heartbeat_enable(engine);
 			err = -EINVAL;
 			goto err_client_b;
@@ -2595,12 +2603,13 @@ static int live_chain_preempt(void *arg)
 		if (ring_size < 0)
 			ring_size += rq->ring->size;
 		ring_size = rq->ring->size / ring_size;
-		pr_debug("%s(%s): Using maximum of %d requests\n",
-			 __func__, engine->name, ring_size);
+		drm_dbg(&engine->i915->drm, "%s(%s): Using maximum of %d requests\n",
+			__func__, engine->name, ring_size);
 
 		igt_spinner_end(&lo.spin);
 		if (i915_request_wait(rq, 0, HZ / 2) < 0) {
-			pr_err("Timed out waiting to flush %s\n", engine->name);
+			drm_err(&engine->i915->drm, "Timed out waiting to flush %s\n",
+				engine->name);
 			i915_request_put(rq);
 			goto err_wedged;
 		}
@@ -2648,8 +2657,8 @@ static int live_chain_preempt(void *arg)
 				struct drm_printer p =
 					drm_info_printer(gt->i915->drm.dev);
 
-				pr_err("Failed to preempt over chain of %d\n",
-				       count);
+				drm_err(&engine->i915->drm,
+					"Failed to preempt over chain of %d\n", count);
 				intel_engine_dump(engine, &p,
 						  "%s\n", engine->name);
 				i915_request_put(rq);
@@ -2669,8 +2678,9 @@ static int live_chain_preempt(void *arg)
 				struct drm_printer p =
 					drm_info_printer(gt->i915->drm.dev);
 
-				pr_err("Failed to flush low priority chain of %d requests\n",
-				       count);
+				drm_err(&engine->i915->drm,
+					"Failed to flush low priority chain of %d requests\n",
+					count);
 				intel_engine_dump(engine, &p,
 						  "%s\n", engine->name);
 
@@ -2867,12 +2877,10 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
 		n++;
 	}
 	intel_engine_flush_submission(engine);
-	pr_debug("%s: Filled %d with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
-		 engine->name, queue_sz, n,
-		 ce[0]->ring->size,
-		 ce[0]->ring->tail,
-		 ce[0]->ring->emit,
-		 rq->tail);
+	drm_dbg(&engine->i915->drm,
+		"%s: Filled %d with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
+		engine->name, queue_sz, n, ce[0]->ring->size, ce[0]->ring->tail,
+		ce[0]->ring->emit, rq->tail);
 	i915_request_put(rq);
 
 	/* Create a second request to preempt the first ring */
@@ -2889,15 +2897,15 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
 	err = wait_for_submit(engine, rq, HZ / 2);
 	i915_request_put(rq);
 	if (err) {
-		pr_err("%s: preemption request was not submitted\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: preemption request was not submitted\n", engine->name);
 		err = -ETIME;
 	}
 
-	pr_debug("%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
-		 engine->name,
-		 ce[0]->ring->tail, ce[0]->ring->emit,
-		 ce[1]->ring->tail, ce[1]->ring->emit);
+	drm_dbg(&engine->i915->drm,
+		"%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
+		engine->name, ce[0]->ring->tail, ce[0]->ring->emit,
+		ce[1]->ring->tail, ce[1]->ring->emit);
 
 err_ce:
 	intel_engine_flush_submission(engine);
@@ -2999,8 +3007,8 @@ static int live_preempt_gang(void *arg)
 			engine->sched_engine->schedule(rq, &attr);
 		} while (prio <= I915_PRIORITY_MAX &&
 			 !__igt_timeout(end_time, NULL));
-		pr_debug("%s: Preempt chain of %d requests\n",
-			 engine->name, prio);
+		drm_dbg(&engine->i915->drm, "%s: Preempt chain of %d requests\n",
+			engine->name, prio);
 
 		/*
 		 * Such that the last spinner is the highest priority and
@@ -3024,8 +3032,9 @@ static int live_preempt_gang(void *arg)
 				struct drm_printer p =
 					drm_info_printer(engine->i915->drm.dev);
 
-				pr_err("Failed to flush chain of %d requests, at %d\n",
-				       prio, rq_prio(rq));
+				drm_err(&engine->i915->drm,
+					"Failed to flush chain of %d requests, at %d\n",
+					prio, rq_prio(rq));
 				intel_engine_dump(engine, &p,
 						  "%s\n", engine->name);
 
@@ -3319,8 +3328,8 @@ static int live_preempt_user(void *arg)
 		}
 
 		if (READ_ONCE(result[0]) != NUM_GPR) {
-			pr_err("%s: Failed to release semaphore\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: Failed to release semaphore\n", engine->name);
 			err = -EIO;
 			goto end_test;
 		}
@@ -3335,9 +3344,9 @@ static int live_preempt_user(void *arg)
 
 			for (gpr = 1; gpr < NUM_GPR; gpr++) {
 				if (result[NUM_GPR * i + gpr] != 1) {
-					pr_err("%s: Invalid result, client %d, gpr %d, result: %d\n",
-					       engine->name,
-					       i, gpr, result[NUM_GPR * i + gpr]);
+					drm_err(&engine->i915->drm,
+						"%s: Invalid result, client %d, gpr %d, result: %d\n",
+						engine->name, i, gpr, result[NUM_GPR * i + gpr]);
 					err = -EINVAL;
 					goto end_test;
 				}
@@ -3601,8 +3610,9 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 		kthread_destroy_worker(worker[id]);
 	}
 
-	pr_info("Submitted %lu crescendo:%x requests across %d engines and %d contexts\n",
-		count, flags, smoke->gt->info.num_engines, smoke->ncontext);
+	drm_info(&smoke->gt->i915->drm,
+		 "Submitted %lu crescendo:%x requests across %d engines and %d contexts\n",
+		 count, flags, smoke->gt->info.num_engines, smoke->ncontext);
 
 	kfree(arg);
 	return 0;
@@ -3630,8 +3640,9 @@ static int smoke_random(struct preempt_smoke *smoke, unsigned int flags)
 		}
 	} while (count < smoke->ncontext && !__igt_timeout(end_time, NULL));
 
-	pr_info("Submitted %lu random:%x requests across %d engines and %d contexts\n",
-		count, flags, smoke->gt->info.num_engines, smoke->ncontext);
+	drm_info(&smoke->gt->i915->drm,
+		 "Submitted %lu random:%x requests across %d engines and %d contexts\n",
+		 count, flags, smoke->gt->info.num_engines, smoke->ncontext);
 	return 0;
 }
 
@@ -3787,10 +3798,11 @@ static int nop_virtual_engine(struct intel_gt *gt,
 
 		for (nc = 0; nc < nctx; nc++) {
 			if (i915_request_wait(request[nc], 0, HZ / 10) < 0) {
-				pr_err("%s(%s): wait for %llx:%lld timed out\n",
-				       __func__, ve[0]->engine->name,
-				       request[nc]->fence.context,
-				       request[nc]->fence.seqno);
+				drm_err(&gt->i915->drm,
+					"%s(%s): wait for %llx:%lld timed out\n",
+					__func__, ve[0]->engine->name,
+					request[nc]->fence.context,
+					request[nc]->fence.seqno);
 
 				GEM_TRACE("%s(%s) failed at request %llx:%lld\n",
 					  __func__, ve[0]->engine->name,
@@ -3819,9 +3831,9 @@ static int nop_virtual_engine(struct intel_gt *gt,
 	if (err)
 		goto out;
 
-	pr_info("Requestx%d latencies on %s: 1 = %lluns, %lu = %lluns\n",
-		nctx, ve[0]->engine->name, ktime_to_ns(times[0]),
-		prime, div64_u64(ktime_to_ns(times[1]), prime));
+	drm_info(&gt->i915->drm, "Requestx%d latencies on %s: 1 = %lluns, %lu = %lluns\n",
+		 nctx, ve[0]->engine->name, ktime_to_ns(times[0]),
+		 prime, div64_u64(ktime_to_ns(times[1]), prime));
 
 out:
 	if (igt_flush_test(gt->i915))
@@ -3880,8 +3892,8 @@ static int live_virtual_engine(void *arg)
 	for_each_engine(engine, gt, id) {
 		err = nop_virtual_engine(gt, &engine, 1, 1, 0);
 		if (err) {
-			pr_err("Failed to wrap engine %s: err=%d\n",
-			       engine->name, err);
+			drm_err(&engine->i915->drm, "Failed to wrap engine %s: err=%d\n",
+				engine->name, err);
 			return err;
 		}
 	}
@@ -3954,10 +3966,9 @@ static int mask_virtual_engine(struct intel_gt *gt,
 
 	for (n = 0; n < nsibling; n++) {
 		if (i915_request_wait(request[n], 0, HZ / 10) < 0) {
-			pr_err("%s(%s): wait for %llx:%lld timed out\n",
-			       __func__, ve->engine->name,
-			       request[n]->fence.context,
-			       request[n]->fence.seqno);
+			drm_err(&gt->i915->drm, "%s(%s): wait for %llx:%lld timed out\n",
+				__func__, ve->engine->name, request[n]->fence.context,
+				request[n]->fence.seqno);
 
 			GEM_TRACE("%s(%s) failed at request %llx:%lld\n",
 				  __func__, ve->engine->name,
@@ -3970,9 +3981,10 @@ static int mask_virtual_engine(struct intel_gt *gt,
 		}
 
 		if (request[n]->engine != siblings[nsibling - n - 1]) {
-			pr_err("Executed on wrong sibling '%s', expected '%s'\n",
-			       request[n]->engine->name,
-			       siblings[nsibling - n - 1]->name);
+			drm_err(&gt->i915->drm,
+				"Executed on wrong sibling '%s', expected '%s'\n",
+				request[n]->engine->name,
+				siblings[nsibling - n - 1]->name);
 			err = -EINVAL;
 			goto out;
 		}
@@ -4272,8 +4284,8 @@ static int preserved_virtual_engine(struct intel_gt *gt,
 
 	for (n = 0; n < NUM_GPR_DW; n++) {
 		if (cs[n] != n) {
-			pr_err("Incorrect value[%d] found for GPR[%d]\n",
-			       cs[n], n);
+			drm_err(&gt->i915->drm, "Incorrect value[%d] found for GPR[%d]\n",
+				cs[n], n);
 			err = -EINVAL;
 			break;
 		}
@@ -4400,8 +4412,8 @@ static int reset_virtual_engine(struct intel_gt *gt,
 	/* Check that we do not resubmit the held request */
 	i915_request_get(rq);
 	if (!i915_request_wait(rq, 0, HZ / 5)) {
-		pr_err("%s: on hold request completed!\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: on hold request completed!\n", engine->name);
 		intel_gt_set_wedged(gt);
 		err = -EIO;
 		goto out_rq;
@@ -4411,8 +4423,8 @@ static int reset_virtual_engine(struct intel_gt *gt,
 	/* But is resubmitted on release */
 	execlists_unhold(engine, rq);
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
-		pr_err("%s: held request did not complete!\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: held request did not complete!\n", engine->name);
 		intel_gt_set_wedged(gt);
 		err = -ETIME;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
index 07eaf71955c4..3a0a7580ab58 100644
--- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
@@ -5,6 +5,8 @@
 
 #include <linux/sort.h>
 
+#include <drm/drm_print.h>
+
 #include "intel_engine_regs.h"
 #include "intel_gt_clock_utils.h"
 
@@ -85,7 +87,7 @@ static int live_gt_clocks(void *arg)
 	int err = 0;
 
 	if (!gt->clock_frequency) { /* unknown */
-		pr_info("CS_TIMESTAMP frequency unknown\n");
+		drm_info(&gt->i915->drm, "CS_TIMESTAMP frequency unknown\n");
 		return 0;
 	}
 
@@ -109,20 +111,21 @@ static int live_gt_clocks(void *arg)
 		time = intel_gt_clock_interval_to_ns(engine->gt, cycles);
 		expected = intel_gt_ns_to_clock_interval(engine->gt, dt);
 
-		pr_info("%s: TIMESTAMP %d cycles [%lldns] in %lldns [%d cycles], using CS clock frequency of %uKHz\n",
-			engine->name, cycles, time, dt, expected,
-			engine->gt->clock_frequency / 1000);
+		drm_info(&engine->i915->drm,
+			 "%s: TIMESTAMP %d cycles [%lldns] in %lldns [%d cycles], using CS clock frequency of %uKHz\n",
+			 engine->name, cycles, time, dt, expected,
+			 engine->gt->clock_frequency / 1000);
 
 		if (9 * time < 8 * dt || 8 * time > 9 * dt) {
-			pr_err("%s: CS ticks did not match walltime!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: CS ticks did not match walltime!\n",
+				engine->name);
 			err = -EINVAL;
 			break;
 		}
 
 		if (9 * expected < 8 * cycles || 8 * expected > 9 * cycles) {
-			pr_err("%s: walltime did not match CS ticks!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: walltime did not match CS ticks!\n",
+				engine->name);
 			err = -EINVAL;
 			break;
 		}
@@ -146,7 +149,7 @@ static int live_gt_resume(void *arg)
 		intel_gt_suspend_late(gt);
 
 		if (gt->rc6.enabled) {
-			pr_err("rc6 still enabled after suspend!\n");
+			drm_err(&gt->i915->drm, "rc6 still enabled after suspend!\n");
 			intel_gt_set_wedged_on_init(gt);
 			err = -EINVAL;
 			break;
@@ -157,7 +160,7 @@ static int live_gt_resume(void *arg)
 			break;
 
 		if (gt->rc6.supported && !gt->rc6.enabled) {
-			pr_err("rc6 not enabled upon resume!\n");
+			drm_err(&gt->i915->drm, "rc6 not enabled upon resume!\n");
 			intel_gt_set_wedged_on_init(gt);
 			err = -EINVAL;
 			break;
@@ -165,7 +168,7 @@ static int live_gt_resume(void *arg)
 
 		err = st_llc_verify(&gt->llc);
 		if (err) {
-			pr_err("llc state not restored upon resume!\n");
+			drm_err(&gt->i915->drm, "llc state not restored upon resume!\n");
 			intel_gt_set_wedged_on_init(gt);
 			break;
 		}
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 5b986a7687d9..3df6e231a698 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -5,6 +5,8 @@
 
 #include <linux/sort.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_internal.h"
 #include "gem/i915_gem_lmem.h"
 
@@ -92,7 +94,7 @@ static int copy(struct intel_migrate *migrate,
 			continue;
 
 		if (err != -EDEADLK && err != -EINTR && err != -ERESTARTSYS)
-			pr_err("%ps failed, size: %u\n", fn, sz);
+			drm_err(&i915->drm, "%ps failed, size: %u\n", fn, sz);
 		if (rq) {
 			i915_request_wait(rq, 0, HZ);
 			i915_request_put(rq);
@@ -106,7 +108,7 @@ static int copy(struct intel_migrate *migrate,
 
 	if (rq) {
 		if (i915_request_wait(rq, 0, HZ) < 0) {
-			pr_err("%ps timed out, size: %u\n", fn, sz);
+			drm_err(&i915->drm, "%ps timed out, size: %u\n", fn, sz);
 			err = -ETIME;
 		}
 		i915_request_put(rq);
@@ -116,8 +118,8 @@ static int copy(struct intel_migrate *migrate,
 		int x = i * 1024 + i915_prandom_u32_max_state(1024, prng);
 
 		if (vaddr[x] != x) {
-			pr_err("%ps failed, size: %u, offset: %zu\n",
-			       fn, sz, x * sizeof(u32));
+			drm_err(&i915->drm, "%ps failed, size: %u, offset: %zu\n",
+				fn, sz, x * sizeof(u32));
 			igt_hexdump(vaddr + i * 1024, 4096);
 			err = -EINVAL;
 		}
@@ -304,8 +306,7 @@ static int clear(struct intel_migrate *migrate,
 						     true, &rq);
 			if (rq && !err) {
 				if (i915_request_wait(rq, 0, HZ) < 0) {
-					pr_err("%ps timed out, size: %u\n",
-					       fn, sz);
+					drm_err(&i915->drm, "%ps timed out, size: %u\n", fn, sz);
 					err = -ETIME;
 				}
 				i915_request_put(rq);
@@ -318,7 +319,7 @@ static int clear(struct intel_migrate *migrate,
 		err = fn(migrate, &ww, obj, val, &rq);
 		if (rq && !err) {
 			if (i915_request_wait(rq, 0, HZ) < 0) {
-				pr_err("%ps timed out, size: %u\n", fn, sz);
+				drm_err(&i915->drm, "%ps timed out, size: %u\n", fn, sz);
 				err = -ETIME;
 			}
 			i915_request_put(rq);
@@ -335,8 +336,8 @@ static int clear(struct intel_migrate *migrate,
 				i915_prandom_u32_max_state(1024, prng);
 
 			if (vaddr[x] != val) {
-				pr_err("%ps failed, (%u != %u), offset: %zu\n",
-				       fn, vaddr[x], val, x * sizeof(u32));
+				drm_err(&i915->drm, "%ps failed, (%u != %u), offset: %zu\n",
+					fn, vaddr[x], val, x * sizeof(u32));
 				igt_hexdump(vaddr + i * 1024, 4096);
 				err = -EINVAL;
 			}
@@ -355,8 +356,7 @@ static int clear(struct intel_migrate *migrate,
 						     false, &rq);
 			if (rq && !err) {
 				if (i915_request_wait(rq, 0, HZ) < 0) {
-					pr_err("%ps timed out, size: %u\n",
-					       fn, sz);
+					drm_err(&i915->drm, "%ps timed out, size: %u\n", fn, sz);
 					err = -ETIME;
 				}
 				i915_request_put(rq);
@@ -377,8 +377,9 @@ static int clear(struct intel_migrate *migrate,
 									 ccs_bytes_left), prng);
 
 				if (vaddr[offset + x]) {
-					pr_err("%ps ccs clearing failed, offset: %ld/%d\n",
-					       fn, i * PAGE_SIZE + x * sizeof(u32), ccs_bytes);
+					drm_err(&i915->drm,
+						"%ps ccs clearing failed, offset: %ld/%d\n",
+						fn, i * PAGE_SIZE + x * sizeof(u32), ccs_bytes);
 					igt_hexdump(vaddr + offset,
 						    min_t(int, 4096,
 							  ccs_bytes_left * sizeof(u32)));
@@ -394,7 +395,7 @@ static int clear(struct intel_migrate *migrate,
 
 	if (err) {
 		if (err != -EDEADLK && err != -EINTR && err != -ERESTARTSYS)
-			pr_err("%ps failed, size: %u\n", fn, sz);
+			drm_err(&i915->drm, "%ps failed, size: %u\n", fn, sz);
 		if (rq && err != -EINVAL) {
 			i915_request_wait(rq, 0, HZ);
 			i915_request_put(rq);
@@ -540,7 +541,7 @@ static void spinner_kill(struct timer_list *timer)
 	struct spinner_timer *st = timer_container_of(st, timer, timer);
 
 	igt_spinner_end(&st->spin);
-	pr_info("%s\n", __func__);
+	drm_info(st->spin.hws->base.dev, "killing spinner\n");
 }
 
 static int live_emit_pte_full_ring(void *arg)
@@ -633,7 +634,7 @@ static int live_emit_pte_full_ring(void *arg)
 		cs += sz;
 		intel_ring_advance(rq, cs);
 
-		pr_info("%s emit=%u sz=%d\n", __func__, rq->ring->emit, sz);
+		drm_info(&i915->drm, "%s emit=%u sz=%d\n", __func__, rq->ring->emit, sz);
 
 		prev = rq;
 	} while (rq->ring->space > (rq->reserved_space +
@@ -646,7 +647,7 @@ static int live_emit_pte_full_ring(void *arg)
 	 * This should wait for the spinner to be killed, otherwise we should go
 	 * down in flames when doing i915_request_add().
 	 */
-	pr_info("%s emite_pte ring space=%u\n", __func__, rq->ring->space);
+	drm_info(&i915->drm, "%s emite_pte ring space=%u\n", __func__, rq->ring->space);
 	it = sg_sgt(obj->mm.pages->sgl);
 	len = emit_pte(rq, &it, obj->pat_index, false, 0, CHUNK_SZ);
 	if (!len) {
@@ -880,11 +881,9 @@ static int __perf_clear_blt(struct intel_context *ce,
 		return err;
 
 	sort(t, ARRAY_SIZE(t), sizeof(*t), wrap_ktime_compare, NULL);
-	pr_info("%s: %zd KiB fill: %lld MiB/s\n",
-		ce->engine->name, sz >> 10,
-		div64_u64(mul_u32_u32(4 * sz,
-				      1000 * 1000 * 1000),
-			  t[1] + 2 * t[2] + t[3]) >> 20);
+	drm_info(&ce->engine->i915->drm, "%s: %zd KiB fill: %lld MiB/s\n", ce->engine->name,
+		 sz >> 10, div64_u64(mul_u32_u32(4 * sz, 1000 * 1000 * 1000),
+		 t[1] + 2 * t[2] + t[3]) >> 20);
 	return 0;
 }
 
@@ -963,11 +962,9 @@ static int __perf_copy_blt(struct intel_context *ce,
 		return err;
 
 	sort(t, ARRAY_SIZE(t), sizeof(*t), wrap_ktime_compare, NULL);
-	pr_info("%s: %zd KiB copy: %lld MiB/s\n",
-		ce->engine->name, sz >> 10,
-		div64_u64(mul_u32_u32(4 * sz,
-				      1000 * 1000 * 1000),
-			  t[1] + 2 * t[2] + t[3]) >> 20);
+	drm_info(&ce->engine->i915->drm, "%s: %zd KiB copy: %lld MiB/s\n", ce->engine->name,
+		 sz >> 10, div64_u64(mul_u32_u32(4 * sz, 1000 * 1000 * 1000),
+		 t[1] + 2 * t[2] + t[3]) >> 20);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
index d73e438fb85f..770516c6c7da 100644
--- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
@@ -13,6 +13,8 @@
 #include "selftests/igt_spinner.h"
 #include "selftests/intel_scheduler_helpers.h"
 
+#include <drm/drm_print.h>
+
 struct live_mocs {
 	struct drm_i915_mocs_table table;
 	struct drm_i915_mocs_table *mocs;
@@ -169,8 +171,9 @@ static int check_mocs_table(struct intel_engine_cs *engine,
 
 	for_each_mocs(expect, table, i) {
 		if (**vaddr != expect) {
-			pr_err("%s: Invalid MOCS[%d] entry, found %08x, expected %08x\n",
-			       engine->name, i, **vaddr, expect);
+			drm_err(&engine->i915->drm,
+				"%s: Invalid MOCS[%d] entry, found %08x, expected %08x\n",
+				engine->name, i, **vaddr, expect);
 			return -EINVAL;
 		}
 		++*vaddr;
@@ -203,8 +206,9 @@ static int check_l3cc_table(struct intel_engine_cs *engine,
 
 	for_each_l3cc(expect, table, i) {
 		if (!mcr_range(engine->i915, reg) && **vaddr != expect) {
-			pr_err("%s: Invalid L3CC[%d] entry, found %08x, expected %08x\n",
-			       engine->name, i, **vaddr, expect);
+			drm_err(&engine->i915->drm,
+				"%s: Invalid L3CC[%d] entry, found %08x, expected %08x\n",
+				engine->name, i, **vaddr, expect);
 			return -EINVAL;
 		}
 		++*vaddr;
diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 2cfc23c58e90..4744f08692c5 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -14,6 +14,8 @@
 #include "selftests/igt_atomic.h"
 #include "selftests/igt_spinner.h"
 
+#include <drm/drm_print.h>
+
 static int
 __igt_reset_stolen(struct intel_gt *gt,
 		   intel_engine_mask_t mask,
@@ -147,8 +149,9 @@ __igt_reset_stolen(struct intel_gt *gt,
 		    !__drm_mm_interval_first(&gt->i915->mm.stolen,
 					     page << PAGE_SHIFT,
 					     ((page + 1) << PAGE_SHIFT) - 1)) {
-			pr_debug("unused stolen page %pa modified by GPU reset\n",
-				 &page);
+			drm_dbg(&gt->i915->drm,
+				"unused stolen page %pa modified by GPU reset\n",
+				&page);
 			if (count++ == 0)
 				igt_hexdump(in, PAGE_SIZE);
 			max = page;
@@ -160,12 +163,14 @@ __igt_reset_stolen(struct intel_gt *gt,
 	ggtt->vm.clear_range(&ggtt->vm, ggtt->error_capture.start, PAGE_SIZE);
 
 	if (count > 0) {
-		pr_info("%s reset clobbered %ld pages of stolen, last clobber at page %ld\n",
-			msg, count, max);
+		drm_info(&gt->i915->drm,
+			 "%s reset clobbered %ld pages of stolen, last clobber at page %ld\n",
+			 msg, count, max);
 	}
 	if (max >= I915_GEM_STOLEN_BIAS >> PAGE_SHIFT) {
-		pr_err("%s reset clobbered unreserved area [above %x] of stolen; may cause severe faults\n",
-		       msg, I915_GEM_STOLEN_BIAS);
+		drm_err(&gt->i915->drm,
+			"%s reset clobbered unreserved area [above %x] of stolen; may cause severe faults\n",
+			msg, I915_GEM_STOLEN_BIAS);
 		err = -EINVAL;
 	}
 
@@ -223,7 +228,7 @@ static int igt_global_reset(void *arg)
 	intel_gt_reset(gt, ALL_ENGINES, NULL);
 
 	if (i915_reset_count(&gt->i915->gpu_error) == reset_count) {
-		pr_err("No GPU reset recorded!\n");
+		drm_err(&gt->i915->drm, "No GPU reset recorded!\n");
 		err = -EINVAL;
 	}
 
@@ -287,7 +292,8 @@ static int igt_atomic_reset(void *arg)
 		reset_finish(gt, awake);
 
 		if (err) {
-			pr_err("__intel_gt_reset failed under %s\n", p->name);
+			drm_err(&gt->i915->drm,
+				"__intel_gt_reset failed under %s\n", p->name);
 			break;
 		}
 	}
@@ -347,8 +353,9 @@ static int igt_atomic_engine_reset(void *arg)
 				local_bh_enable();
 
 			if (err) {
-				pr_err("intel_engine_reset(%s) failed under %s\n",
-				       engine->name, p->name);
+				drm_err(&engine->i915->drm,
+					"intel_engine_reset(%s) failed under %s\n",
+					engine->name, p->name);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
index c3c918248989..543aeef4fa35 100644
--- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
@@ -3,6 +3,10 @@
  * Copyright © 2021 Intel Corporation
  */
 
+#include <drm/drm_print.h>
+
+#include "uc/intel_guc.h"
+
 #define NUM_STEPS 5
 #define H2G_DELAY 50000
 #define delay_for_h2g() usleep_range(H2G_DELAY, H2G_DELAY + 10000)
@@ -23,13 +27,21 @@ struct slpc_thread {
 	int result;
 };
 
+static struct intel_gt *selftest_slpc_to_gt(struct intel_guc_slpc *slpc)
+{
+	struct intel_guc *guc = container_of(slpc, struct intel_guc, slpc);
+
+	return guc_to_gt(guc);
+}
+
 static int slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 freq)
 {
+	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
 	int ret;
 
 	ret = intel_guc_slpc_set_min_freq(slpc, freq);
 	if (ret)
-		pr_err("Could not set min frequency to [%u]\n", freq);
+		drm_err(&gt->i915->drm, "Could not set min frequency to [%u]\n", freq);
 	else /* Delay to ensure h2g completes */
 		delay_for_h2g();
 
@@ -38,12 +50,12 @@ static int slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 freq)
 
 static int slpc_set_max_freq(struct intel_guc_slpc *slpc, u32 freq)
 {
+	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
 	int ret;
 
 	ret = intel_guc_slpc_set_max_freq(slpc, freq);
 	if (ret)
-		pr_err("Could not set maximum frequency [%u]\n",
-		       freq);
+		drm_err(&gt->i915->drm, "Could not set maximum frequency [%u]\n", freq);
 	else /* Delay to ensure h2g completes */
 		delay_for_h2g();
 
@@ -57,13 +69,13 @@ static int slpc_set_freq(struct intel_gt *gt, u32 freq)
 
 	err = slpc_set_max_freq(slpc, freq);
 	if (err) {
-		pr_err("Unable to update max freq");
+		drm_err(&gt->i915->drm, "Unable to update max freq");
 		return err;
 	}
 
 	err = slpc_set_min_freq(slpc, freq);
 	if (err) {
-		pr_err("Unable to update min freq");
+		drm_err(&gt->i915->drm, "Unable to update min freq");
 		return err;
 	}
 
@@ -72,23 +84,24 @@ static int slpc_set_freq(struct intel_gt *gt, u32 freq)
 
 static int slpc_restore_freq(struct intel_guc_slpc *slpc, u32 min, u32 max)
 {
+	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
 	int err;
 
 	err = slpc_set_max_freq(slpc, max);
 	if (err) {
-		pr_err("Unable to restore max freq");
+		drm_err(&gt->i915->drm, "Unable to restore max freq");
 		return err;
 	}
 
 	err = slpc_set_min_freq(slpc, min);
 	if (err) {
-		pr_err("Unable to restore min freq");
+		drm_err(&gt->i915->drm, "Unable to restore min freq");
 		return err;
 	}
 
 	err = intel_guc_slpc_set_ignore_eff_freq(slpc, false);
 	if (err) {
-		pr_err("Unable to restore efficient freq");
+		drm_err(&gt->i915->drm, "Unable to restore efficient freq");
 		return err;
 	}
 
@@ -143,8 +156,8 @@ static int vary_max_freq(struct intel_guc_slpc *slpc, struct intel_rps *rps,
 
 		/* GuC requests freq in multiples of 50/3 MHz */
 		if (req_freq > (max_freq + FREQUENCY_REQ_UNIT)) {
-			pr_err("SWReq is %d, should be at most %d\n", req_freq,
-			       max_freq + FREQUENCY_REQ_UNIT);
+			drm_err(&rps_to_i915(rps)->drm, "SWReq is %d, should be at most %d\n",
+				req_freq, max_freq + FREQUENCY_REQ_UNIT);
 			err = -EINVAL;
 		}
 
@@ -179,8 +192,8 @@ static int vary_min_freq(struct intel_guc_slpc *slpc, struct intel_rps *rps,
 
 		/* GuC requests freq in multiples of 50/3 MHz */
 		if (req_freq < (min_freq - FREQUENCY_REQ_UNIT)) {
-			pr_err("SWReq is %d, should be at least %d\n", req_freq,
-			       min_freq - FREQUENCY_REQ_UNIT);
+			drm_err(&rps_to_i915(rps)->drm, "SWReq is %d, should be at least %d\n",
+				req_freq, min_freq - FREQUENCY_REQ_UNIT);
 			err = -EINVAL;
 		}
 
@@ -224,19 +237,19 @@ static int slpc_power(struct intel_gt *gt, struct intel_engine_cs *engine)
 	if (err)
 		return err;
 
-	pr_info("%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
-		engine->name,
-		min.power, min.freq,
-		max.power, max.freq);
+	drm_info(&engine->i915->drm, "%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
+		 engine->name, min.power, min.freq, max.power, max.freq);
 
 	if (10 * min.freq >= 9 * max.freq) {
-		pr_notice("Could not control frequency, ran at [%uMHz, %uMhz]\n",
-			  min.freq, max.freq);
+		drm_notice(&engine->i915->drm,
+			   "Could not control frequency, ran at [%uMHz, %uMhz]\n",
+			   min.freq, max.freq);
 	}
 
 	if (11 * min.power > 10 * max.power) {
-		pr_err("%s: did not conserve power when setting lower frequency!\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: did not conserve power when setting lower frequency!\n",
+			engine->name);
 		err = -EINVAL;
 	}
 
@@ -265,10 +278,11 @@ static int max_granted_freq(struct intel_guc_slpc *slpc, struct intel_rps *rps,
 
 		/* If not, this is an error */
 		if (!(perf_limit_reasons & GT0_PERF_LIMIT_REASONS_MASK)) {
-			pr_err("Pcode did not grant max freq\n");
+			drm_err(&gt->i915->drm, "Pcode did not grant max freq\n");
 			err = -EINVAL;
 		} else {
-			pr_info("Pcode throttled frequency 0x%x\n", perf_limit_reasons);
+			drm_info(&gt->i915->drm, "Pcode throttled frequency 0x%x\n",
+				 perf_limit_reasons);
 		}
 	}
 
@@ -290,7 +304,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 		return 0;
 
 	if (slpc->min_freq == slpc->rp0_freq) {
-		pr_err("Min/Max are fused to the same value\n");
+		drm_err(&gt->i915->drm, "Min/Max are fused to the same value\n");
 		return -EINVAL;
 	}
 
@@ -298,12 +312,12 @@ static int run_test(struct intel_gt *gt, int test_type)
 		return -ENOMEM;
 
 	if (intel_guc_slpc_get_max_freq(slpc, &slpc_max_freq)) {
-		pr_err("Could not get SLPC max freq\n");
+		drm_err(&gt->i915->drm, "Could not get SLPC max freq\n");
 		return -EIO;
 	}
 
 	if (intel_guc_slpc_get_min_freq(slpc, &slpc_min_freq)) {
-		pr_err("Could not get SLPC min freq\n");
+		drm_err(&gt->i915->drm, "Could not get SLPC min freq\n");
 		return -EIO;
 	}
 
@@ -313,7 +327,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 	 */
 	err = slpc_set_min_freq(slpc, slpc->min_freq);
 	if (err) {
-		pr_err("Unable to update min freq!");
+		drm_err(&gt->i915->drm, "Unable to update min freq!");
 		return err;
 	}
 
@@ -322,7 +336,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 	 */
 	err = intel_guc_slpc_set_ignore_eff_freq(slpc, true);
 	if (err) {
-		pr_err("Unable to turn off efficient freq!");
+		drm_err(&gt->i915->drm, "Unable to turn off efficient freq!");
 		return err;
 	}
 
@@ -349,8 +363,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: Spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: Spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -387,15 +400,16 @@ static int run_test(struct intel_gt *gt, int test_type)
 		}
 
 		if (test_type != SLPC_POWER) {
-			pr_info("Max actual frequency for %s was %d\n",
-				engine->name, max_act_freq);
+			drm_info(&engine->i915->drm, "%s: Max actual frequency was %d\n",
+				 engine->name, max_act_freq);
 
 			/* Actual frequency should rise above min */
 			if (max_act_freq <= slpc->min_freq) {
-				pr_err("Actual freq did not rise above min\n");
-				pr_err("Perf Limit Reasons: 0x%x\n",
-				       intel_uncore_read(gt->uncore,
-							 intel_gt_perf_limit_reasons_reg(gt)));
+				drm_err(&engine->i915->drm,
+					"Actual freq did not rise above min\n");
+				drm_err(&engine->i915->drm, "Perf Limit Reasons: 0x%x\n",
+					intel_uncore_read(gt->uncore,
+						intel_gt_perf_limit_reasons_reg(gt)));
 				err = -EINVAL;
 			}
 		}
@@ -525,7 +539,7 @@ static int live_slpc_tile_interaction(void *arg)
 		kthread_flush_work(&threads[i].work);
 		status = READ_ONCE(threads[i].result);
 		if (status && !ret) {
-			pr_err("%s GT %d failed ", __func__, gt->info.id);
+			drm_err(&gt->i915->drm, "%s GT %d failed ", __func__, gt->info.id);
 			ret = status;
 		}
 		kthread_destroy_worker(threads[i].worker);
diff --git a/drivers/gpu/drm/i915/gt/selftest_tlb.c b/drivers/gpu/drm/i915/gt/selftest_tlb.c
index a5184f09d1de..dd5054e99582 100644
--- a/drivers/gpu/drm/i915/gt/selftest_tlb.c
+++ b/drivers/gpu/drm/i915/gt/selftest_tlb.c
@@ -20,6 +20,8 @@
 #include "selftests/igt_flush_test.h"
 #include "selftests/i915_random.h"
 
+#include <drm/drm_print.h>
+
 static void vma_set_qw(struct i915_vma *vma, u64 addr, u64 val)
 {
 	GEM_BUG_ON(addr < i915_vma_offset(vma));
@@ -68,7 +70,7 @@ pte_tlbinv(struct intel_context *ce,
 				 va->size, align);
 	err = i915_vma_pin(va,  0, 0, addr | PIN_OFFSET_FIXED | PIN_USER);
 	if (err) {
-		pr_err("Cannot pin at %llx+%llx\n", addr, va->size);
+		drm_err(&ce->engine->i915->drm, "Cannot pin at %llx+%llx\n", addr, va->size);
 		goto out;
 	}
 	GEM_BUG_ON(i915_vma_offset(va) != addr);
@@ -91,11 +93,11 @@ pte_tlbinv(struct intel_context *ce,
 	addr = igt_random_offset(prng, addr, addr + align, 8, 8);
 
 	if (va != vb)
-		pr_info("%s(%s): Sampling %llx, with alignment %llx, using PTE size %x (phys %x, sg %x), invalidate:%llx+%llx\n",
-			ce->engine->name, va->obj->mm.region->name ?: "smem",
-			addr, align, va->resource->page_sizes_gtt,
-			va->page_sizes.phys, va->page_sizes.sg,
-			addr & -length, length);
+		drm_info(&ce->engine->i915->drm,
+			 "%s(%s): Sampling %llx, with alignment %llx, using PTE size %x (phys %x, sg %x), invalidate:%llx+%llx\n",
+			 ce->engine->name, va->obj->mm.region->name ?: "smem",  addr, align,
+			 va->resource->page_sizes_gtt, va->page_sizes.phys,
+			 va->page_sizes.sg, addr & -length, length);
 
 	cs = i915_gem_object_pin_map_unlocked(batch, I915_MAP_WC);
 	*cs++ = MI_NOOP; /* for later termination */
@@ -147,10 +149,11 @@ pte_tlbinv(struct intel_context *ce,
 
 	if (va == vb) {
 		if (!i915_request_completed(rq)) {
-			pr_err("%s(%s): Semaphore sanitycheck failed %llx, with alignment %llx, using PTE size %x (phys %x, sg %x)\n",
-			       ce->engine->name, va->obj->mm.region->name ?: "smem",
-			       addr, align, va->resource->page_sizes_gtt,
-			       va->page_sizes.phys, va->page_sizes.sg);
+			drm_err(&ce->engine->i915->drm,
+				"%s(%s): Semaphore sanitycheck failed %llx, with alignment %llx, using PTE size %x (phys %x, sg %x)\n",
+				ce->engine->name, va->obj->mm.region->name ?: "smem", addr, align,
+				va->resource->page_sizes_gtt, va->page_sizes.phys,
+				va->page_sizes.sg);
 			err = -EIO;
 		}
 	} else if (!i915_request_completed(rq)) {
@@ -171,12 +174,13 @@ pte_tlbinv(struct intel_context *ce,
 		tlbinv(ce->vm, addr & -length, length);
 
 		if (wait_for(i915_request_completed(rq), HZ / 2)) {
-			pr_err("%s: Request did not complete; the COND_BBE did not read the updated PTE\n",
-			       ce->engine->name);
+			drm_err(&ce->engine->i915->drm,
+				"%s: Request did not complete; the COND_BBE did not read the updated PTE\n",
+				ce->engine->name);
 			err = -EINVAL;
 		}
 	} else {
-		pr_err("Spinner ended unexpectedly\n");
+		drm_err(&ce->engine->i915->drm, "Spinner ended unexpectedly\n");
 		err = -EIO;
 	}
 	i915_request_put(rq);
@@ -271,8 +275,8 @@ mem_tlbinv(struct intel_gt *gt,
 
 	GEM_BUG_ON(A->base.size != B->base.size);
 	if ((A->mm.page_sizes.phys | B->mm.page_sizes.phys) & (A->base.size - 1))
-		pr_warn("Failed to allocate contiguous pages for size %zx\n",
-			A->base.size);
+		drm_warn(&gt->i915->drm,
+			 "Failed to allocate contiguous pages for size %zx\n", A->base.size);
 
 	ppgtt = i915_ppgtt_create(gt, 0);
 	if (IS_ERR(ppgtt)) {
diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
index 4e4c420ae67f..4c96b143f09b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
@@ -16,6 +16,8 @@
 #include "selftests/intel_scheduler_helpers.h"
 #include "selftests/mock_drm.h"
 
+#include <drm/drm_print.h>
+
 #include "gem/selftests/igt_gem_utils.h"
 #include "gem/selftests/mock_context.h"
 
@@ -193,8 +195,9 @@ print_results(const struct intel_engine_cs *engine, const u32 *results)
 		u32 expected = get_whitelist_reg(engine, i);
 		u32 actual = results[i];
 
-		pr_info("RING_NONPRIV[%d]: expected 0x%08x, found 0x%08x\n",
-			i, expected, actual);
+		drm_info(&engine->i915->drm,
+			 "RING_NONPRIV[%d]: expected 0x%08x, found 0x%08x\n",
+			 i, expected, actual);
 	}
 }
 
@@ -233,8 +236,9 @@ static int check_whitelist(struct intel_context *ce)
 
 		if (expected != actual) {
 			print_results(engine, vaddr);
-			pr_err("Invalid RING_NONPRIV[%d], expected 0x%08x, found 0x%08x\n",
-			       i, expected, actual);
+			drm_err(&engine->i915->drm,
+				"Invalid RING_NONPRIV[%d], expected 0x%08x, found 0x%08x\n",
+				i, expected, actual);
 
 			err = -EINVAL;
 			break;
@@ -304,8 +308,9 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 	intel_wakeref_t wakeref;
 	int err;
 
-	pr_info("Checking %d whitelisted registers on %s (RING_NONPRIV) [%s]\n",
-		engine->whitelist.count, engine->name, name);
+	drm_info(&engine->i915->drm,
+		 "Checking %d whitelisted registers on %s (RING_NONPRIV) [%s]\n",
+		 engine->whitelist.count, engine->name, name);
 
 	ce = intel_context_create(engine);
 	if (IS_ERR(ce))
@@ -317,7 +322,7 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 
 	err = check_whitelist(ce);
 	if (err) {
-		pr_err("Invalid whitelist *before* %s reset!\n", name);
+		drm_err(&engine->i915->drm, "Invalid whitelist *before* %s reset!\n", name);
 		goto out_spin;
 	}
 
@@ -327,7 +332,7 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 
 	/* Ensure the spinner hasn't aborted */
 	if (i915_request_completed(rq)) {
-		pr_err("%s spinner failed to start\n", name);
+		drm_err(&engine->i915->drm, "%s spinner failed to start\n", name);
 		err = -ETIMEDOUT;
 		goto out_spin;
 	}
@@ -342,14 +347,14 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 	igt_spinner_end(&spin);
 
 	if (err) {
-		pr_err("%s reset failed\n", name);
+		drm_err(&engine->i915->drm, "%s reset failed\n", name);
 		goto out_spin;
 	}
 
 	err = check_whitelist(ce);
 	if (err) {
-		pr_err("Whitelist not preserved in context across %s reset!\n",
-		       name);
+		drm_err(&engine->i915->drm,
+			"Whitelist not preserved in context across %s reset!\n", name);
 		goto out_spin;
 	}
 
@@ -363,8 +368,8 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 
 	err = check_whitelist(ce);
 	if (err) {
-		pr_err("Invalid whitelist *after* %s reset in fresh context!\n",
-		       name);
+		drm_err(&engine->i915->drm,
+			"Invalid whitelist *after* %s reset in fresh context!\n", name);
 		goto out_spin;
 	}
 
@@ -565,8 +570,7 @@ static int check_dirty_whitelist(struct intel_context *ce)
 		if (GRAPHICS_VER(engine->i915) >= 8)
 			lrm++, srm++;
 
-		pr_debug("%s: Writing garbage to %x\n",
-			 engine->name, reg);
+		drm_dbg(&engine->i915->drm, "%s: Writing garbage to %x\n", engine->name, reg);
 
 		/* SRM original */
 		*cs++ = srm;
@@ -646,8 +650,8 @@ static int check_dirty_whitelist(struct intel_context *ce)
 err_request:
 		err = request_add_sync(rq, err);
 		if (err) {
-			pr_err("%s: Futzing %x timedout; cancelling test\n",
-			       engine->name, reg);
+			drm_err(&engine->i915->drm, "%s: Futzing %x timedout; cancelling test\n",
+				engine->name, reg);
 			intel_gt_set_wedged(engine->gt);
 			goto out_unmap_scratch;
 		}
@@ -657,8 +661,9 @@ static int check_dirty_whitelist(struct intel_context *ce)
 			/* detect write masking */
 			rsvd = results[ARRAY_SIZE(values)];
 			if (!rsvd) {
-				pr_err("%s: Unable to write to whitelisted register %x\n",
-				       engine->name, reg);
+				drm_err(&engine->i915->drm,
+					"%s: Unable to write to whitelisted register %x\n",
+					engine->name, reg);
 				err = -EINVAL;
 				goto out_unmap_scratch;
 			}
@@ -689,15 +694,18 @@ static int check_dirty_whitelist(struct intel_context *ce)
 			idx++;
 		}
 		if (err) {
-			pr_err("%s: %d mismatch between values written to whitelisted register [%x], and values read back!\n",
-			       engine->name, err, reg);
+			drm_err(&engine->i915->drm,
+				"%s: %d mismatch between values written to whitelisted register [%x], and values read back!\n",
+				engine->name, err, reg);
 
 			if (ro_reg)
-				pr_info("%s: Whitelisted read-only register: %x, original value %08x\n",
-					engine->name, reg, results[0]);
+				drm_info(&engine->i915->drm,
+					 "%s: Whitelisted read-only register: %x, original value %08x\n",
+					 engine->name, reg, results[0]);
 			else
-				pr_info("%s: Whitelisted register: %x, original value %08x, rsvd %08x\n",
-					engine->name, reg, results[0], rsvd);
+				drm_info(&engine->i915->drm,
+					 "%s: Whitelisted register: %x, original value %08x, rsvd %08x\n",
+					 engine->name, reg, results[0], rsvd);
 
 			expect = results[0];
 			idx = 1;
@@ -708,8 +716,9 @@ static int check_dirty_whitelist(struct intel_context *ce)
 					expect = results[0];
 				else
 					expect = reg_write(expect, w, rsvd);
-				pr_info("Wrote %08x, read %08x, expect %08x\n",
-					w, results[idx], expect);
+				drm_info(&engine->i915->drm,
+					 "Wrote %08x, read %08x, expect %08x\n",
+					 w, results[idx], expect);
 				idx++;
 			}
 			for (v = 0; v < ARRAY_SIZE(values); v++) {
@@ -719,8 +728,9 @@ static int check_dirty_whitelist(struct intel_context *ce)
 					expect = results[0];
 				else
 					expect = reg_write(expect, w, rsvd);
-				pr_info("Wrote %08x, read %08x, expect %08x\n",
-					w, results[idx], expect);
+				drm_info(&engine->i915->drm,
+					 "Wrote %08x, read %08x, expect %08x\n",
+					 w, results[idx], expect);
 				idx++;
 			}
 
@@ -985,8 +995,9 @@ static bool result_eq(struct intel_engine_cs *engine,
 		      u32 a, u32 b, i915_reg_t reg)
 {
 	if (a != b && !pardon_reg(engine->i915, reg)) {
-		pr_err("Whitelisted register 0x%4x not context saved: A=%08x, B=%08x\n",
-		       i915_mmio_reg_offset(reg), a, b);
+		drm_err(&engine->i915->drm,
+			"Whitelisted register 0x%4x not context saved: A=%08x, B=%08x\n",
+			i915_mmio_reg_offset(reg), a, b);
 		return false;
 	}
 
@@ -1007,8 +1018,9 @@ static bool result_neq(struct intel_engine_cs *engine,
 		       u32 a, u32 b, i915_reg_t reg)
 {
 	if (a == b && !writeonly_reg(engine->i915, reg)) {
-		pr_err("Whitelist register 0x%4x:%08x was unwritable\n",
-		       i915_mmio_reg_offset(reg), a);
+		drm_err(&engine->i915->drm,
+			"Whitelist register 0x%4x:%08x was unwritable\n",
+			i915_mmio_reg_offset(reg), a);
 		return false;
 	}
 
@@ -1211,7 +1223,7 @@ live_gpu_reset_workarounds(void *arg)
 	if (!lists)
 		return -ENOMEM;
 
-	pr_info("Verifying after GPU reset...\n");
+	drm_info(&gt->i915->drm, "Verifying after GPU reset...\n");
 
 	igt_global_reset_lock(gt);
 	wakeref = intel_runtime_pm_get(gt->uncore->rpm);
@@ -1266,7 +1278,7 @@ live_engine_reset_workarounds(void *arg)
 		bool ok;
 		int ret2;
 
-		pr_info("Verifying after %s reset...\n", engine->name);
+		drm_info(&engine->i915->drm, "Verifying after %s reset...\n", engine->name);
 		ret = intel_selftest_modify_policy(engine, &saved,
 						   SELFTEST_SCHEDULER_MODIFY_FAST_RESET);
 		if (ret)
@@ -1287,7 +1299,8 @@ live_engine_reset_workarounds(void *arg)
 
 			ret = intel_engine_reset(engine, "live_workarounds:idle");
 			if (ret) {
-				pr_err("%s: Reset failed while idle\n", engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: Reset failed while idle\n", engine->name);
 				goto err;
 			}
 
@@ -1311,7 +1324,7 @@ live_engine_reset_workarounds(void *arg)
 
 		ret = request_add_spin(rq, &spin);
 		if (ret) {
-			pr_err("%s: Spinner failed to start\n", engine->name);
+			drm_err(&engine->i915->drm, "%s: Spinner failed to start\n", engine->name);
 			igt_spinner_fini(&spin);
 			goto err;
 		}
@@ -1325,8 +1338,8 @@ live_engine_reset_workarounds(void *arg)
 		if (!using_guc) {
 			ret = intel_engine_reset(engine, "live_workarounds:active");
 			if (ret) {
-				pr_err("%s: Reset failed on an active spinner\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: Reset failed on an active spinner\n", engine->name);
 				igt_spinner_fini(&spin);
 				goto err;
 			}
-- 
2.34.1

