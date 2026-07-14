Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E80C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB9710E0A0;
	Tue, 14 Jul 2026 18:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GpN/4xeR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C3A10E0A0;
 Tue, 14 Jul 2026 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784052946; x=1815588946;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NzpoBpBz74OC3gNKgQkpNXC81aRBlsl6tDOmSPawuSM=;
 b=GpN/4xeRCv2sy6Xdro/W9QomB+vBN17LRiI4xvKmpvZC/XRBwmvZRKQS
 wJ5jgj0BngeE3Rv+gsYIt+romq7yQ9nes9wti1ofFk7L5A3L8yBZN2VPq
 NeT3n+gnQ2rJG6YskOFrahXbhrdiufsgD6DCg/1Ri32ND08h51rd6p0Dx
 GoK/TVXd3ZHAxfQQe994VjrRNNWPWDqiWYRqFaNmsWmLt2DO+k/8ztebz
 jT8ZW2DlMCn4sU0ydjHpthY8PKHhlu8JLjsWAIXfmqcpDxMnjXUIvqmHD
 PnKs2GKwzsWxDsPf+bn2UulF4/Cch+uHxqjiLIZFzdKkh6oW5UAU3fIwv Q==;
X-CSE-ConnectionGUID: DTjSZRaWTjeUizojHeQdHA==
X-CSE-MsgGUID: /7aO6jw8SduBa8uz+7+yjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95829685"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="95829685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 11:15:45 -0700
X-CSE-ConnectionGUID: fPPOAtEXQCaAy4zkbIM/ng==
X-CSE-MsgGUID: 3QlWECiwQVWifY5eQ8O3Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="294143537"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 11:15:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:15:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 11:15:45 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:15:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxzsUXG52NiZq0uu86gtAV8t/2t3jzC1iPb+gcl8Gem9LTUToclaBf2Mo0aEe/uAxxKooVq+CxbzpHcQqGPPXs7xgRlAKMGeCECDnK/C8UKTXbsz5eDWVosoYgqajJCr6SLHysD4LvM7OZKMZN31H/jTnLNv0Z6aQebtvAT04XTlzA+gYZauFRbieeNZretbTqSPyxOJeuXCZPj7MQHRZjzQdMRniO7eACfLZMWbwNLWgKa1rrYTCOsLXcAvBVt8fUe3xKGZkAjSYRm7SnCIf2BBwQOy4uMR/O6rbiDEXyb6rwt/qQ0ATHGXvRX1e9157bu8DyL6PbqhVCwlmyngVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/41xGssclKYUAc9+tmKuf5YwX/oqgclpv3p6lbj2Oec=;
 b=vzfDra6QLzkqJz20OrgUxbyv2Ug12bcL+y/7sBZHYYiVsLVED+fh5H98MdBE5xSmpU5uyqBUAbhJD5EKI2yK+iMBRyXygwAesyI9VW5LcIJ18cgBMpxMXzSbAKfnccUS4f/EYFF3fRoRdDnGT1y8PGdhpHajvpUeUZmG0CGzj72PGcTUZhRA7k1Lgs3rL+q6e9sz5OE3loFm6v5EWK1rAjwHCqGPcNVuNQkbkyYHsy1fnGq+Yp8K7RjxboIFWkPA11Gff8nzsZv3ub0Nra0SokufIi8/bCqY5zwwFhWCc7vPhV44KSZyJ0ghyeO6hPXOO1zovJSW+d0ARcA7BmJbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by DM3PPFC3B7BD011.namprd11.prod.outlook.com (2603:10b6:f:fc00::f49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 18:15:43 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::53aa:3f7a:59cd:e057]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::53aa:3f7a:59cd:e057%3]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 18:15:43 +0000
Date: Tue, 14 Jul 2026 11:15:41 -0700
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
CC: Ashutosh Dixit <ashutosh.dixit@intel.com>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/oa: Check managed mutex initialization errors
Message-ID: <alZ8zR98JSfuSYAx@soc-5CG1426VCC.clients.intel.com>
References: <20260713083053.321091-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20260713083053.321091-1-lilinmao@kylinos.cn>
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|DM3PPFC3B7BD011:EE_
X-MS-Office365-Filtering-Correlation-Id: b040e785-bad3-4e0f-c294-08dee1d3eafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: r5G75FmerPCvc1BDuXl1hZN6nc2DV11ut6/DafyE7EVSgSy6UXnDF7kkJQKa9oaOuyisG3XxjiIN/77U27FInAtgL+r8VcEM/eOLo1Rs603ODvSM/H8fJl4SmuvGCVRKlw9jgaR3znDu1fDMxjtiWCRqWllMytsGJKCKcHPsF1YT6vM/iDNklIPOCKfIDR0VsTtAtLwSgKhjWZJSBk9S2ieBB6f41ulBwdfRQZDNA23clSBo+GB9CFoIiRvqP8b+NwRIb0YsqdBdgErpevZ6pOGwgG3G5K8Xmr5dUK1+GPX6C9nNk3+HMLPMxvxUjqUYg+0g7FW/44x2ARGa6ufcsAqrn3kh5YXgXkrGihQ2i+3g0kBky1L9wt0SEl01zpxCTOpu/8+G6ckp+wHW97U71YaE/PX55GsHBQnka9kYrYX1vP6boUteCzghKpgEDe4G6nG+gU6C3+PxxrN2lCneMxEHWCSBeHM92ne0Dz5rLwg3EcqLf0zG4z1o/w+vfVfZgZ9r+MIgr4Xhfz209vPGDISYstWk84vPSejsTahQ/pfaC8f3WGyBg9pHh9mIxTH22lfk8T4OJm3tXVRmP2KpRZOPiGUywU9RN7HXiLnc1tA+xFgaFylp4+C6i44uiTrlPCvxrD4JRdzEN28ByY8hEo9MQYzPM5uRHAllK5N+sGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7408.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDYydjQ2N2dvajJBUjVQNFB0OG9WdFlpdS8wcDAyUkJSL0lpSlk3cXE3Sm1X?=
 =?utf-8?B?dlgvcFc5SjF4ZWhmdlBoMG9jcXJWa0xvMUJ0SDRzVjFERTlnazJWZTQ2a01z?=
 =?utf-8?B?K0sydnRzUldNREQzNTZ1aktXNHV1amhGUm1xVkRWaWVOVkNCRGhBMXF3QlBU?=
 =?utf-8?B?M0kvZ2duN2grbVBZSXpHbFNmUlEzdGlvSmJlQ2pSaUtMSkdMNU5ZMzFHVEpt?=
 =?utf-8?B?LzBob3hWWUFUK1MzL1RLNkZ1ekErKzY0R3RiSnMrQlNRaktwKzR5WXBEMkph?=
 =?utf-8?B?Z3NDcXNwOFFoTlVZbEFzblJtQUE4L0hJZm9uUDY2ek9tdkJZNlVWOEtXS1ZC?=
 =?utf-8?B?eDR5S3d1NGkrQ3BjQk1telZpVERxTUVLWmlmZmdoakVZd25mOVZCczhsTTJ6?=
 =?utf-8?B?dTUwVkRFcFlvSGgzYmtTUjBtMllqTERVZk5zNGJiT3JYeHJDajMyTkdhSmI4?=
 =?utf-8?B?OHpvRWxRVGh2QVZWTHJsOG5TaThyUzc1bEg5eVd5OG9sV3NQb0pQV3dQbS9k?=
 =?utf-8?B?TEE3YTg2S1F2VDRBdDVmalJoMHhyRklWbnRITllROUZka0k1QklWdzNqTmhN?=
 =?utf-8?B?VlpjY2k4T0UwR0ZFaEM0dm1NSGNVOEFCeEF0bWFXTTZFS21iU3phWmxTWUp4?=
 =?utf-8?B?cVY2OTkyNnMwd1ZYOG5jcmluZ1RGMjc1eHUyNUNkZWE2VWlNWmg4U1o0Lzdk?=
 =?utf-8?B?T2U5NU82K3JIb21ZWXE5YVFKbm0xeGd3S0JDeU5vWFkxTlQ4bXZjdHFrSTdX?=
 =?utf-8?B?b2d6UmVkVDRCRE41cDVwWWpRV1ExR29EM0NHYmhRTFBsQ3VzMWE2cHRSNkYr?=
 =?utf-8?B?MXg2Q3loMmxiUys5cTA1bXBpSW1YVXB3SjEweStBNFI5MXkrQmZ1bFRhNTZj?=
 =?utf-8?B?OExRQnc4VFhtczZ5aytITlZDUHBoTDY4SWtmZGVwWUlnVU04YnFhb2YrZ251?=
 =?utf-8?B?WjBaWDBZN3JLYlFvV1NiSkhCSUN3NU5rMC9NaXBqdGpXSlhZSzBicktWcjY4?=
 =?utf-8?B?RkdnNXNESEh0cWdKTjBFT3hhRkdMU3haUUowVll3RW1VeHNMTkJsZVova3Rp?=
 =?utf-8?B?OURuRHhhTU1aRml4dVI5YWczeDdtQWdMOXBYVmFqUGNTTDg1bXRCMVhkYmlh?=
 =?utf-8?B?RTFDOU5zSDRJcjB2N0pHTFF0b3NKWHI3Y2NVQnpxQWY2ZHFnN0YwZXNrancx?=
 =?utf-8?B?blN6bDR1S3ZieW5JcEVOTHpXanZPbDdjSkl5QVMrM2JWUmhOdi9wWndTNml2?=
 =?utf-8?B?OE54UmpudlR1aUNkTjdsY3R3eFVFcGFIRzB6ZHdGamFsL083NjBoY2J4MnVV?=
 =?utf-8?B?WW9QSUhEZGxlcjNpVXhwaDYvY0xaZ1FnbXFuTVlGOG5LUFJrbWpwaUgxTG5O?=
 =?utf-8?B?eU1pRXA2cVZBWXArTDgyK0NMMExMZ3dPT2haUk9QbTdaVmhzdGRNR2w2Rjda?=
 =?utf-8?B?aWtRTkxTU0dldDFER0NIL1lrejhVMTI3NzhIcjR6NVVLL3VTbVFvRW5OZ05r?=
 =?utf-8?B?cDFNdkYyK0M5VU1VaUNzWGN6WEU0ZE5XTmZ2TWx4MVM4b3RyT0plNDJPN1Fz?=
 =?utf-8?B?a0dXTGlOZWFhaVpFQ3hYVGtLZEVmOUlkOG0wSlp6cDNnejU1a1hKT1UxbGgx?=
 =?utf-8?B?MHJtV2d2cS9laVMycUxJcWEzRXhITDV4ZDNTTXdlN1pwcDZHV1QwTHlxR1NV?=
 =?utf-8?B?TjR0YWc5MkxRTEZRS09Gb0ZHcDFUUzViQUl4T3NwWmJhU3cydVBoelh1QXQ3?=
 =?utf-8?B?SGx0aHEvbjRPWDltSForZCtLYmgwdFZLRnlBSS96aDZESjFZbTBCSmNqb0gx?=
 =?utf-8?B?ZHVPSm5aaWVCMUFzMGxKbnM0cUxmSWRobDlIRTl3RWdWZVpLRGxmbmViclQ2?=
 =?utf-8?B?M1VUTEFyeXdUWXBZL204dVk4c2FzWjB5Q2ttUkhTWWRwRFJkRGdPZG02dG82?=
 =?utf-8?B?M3ZnOEkwL2tvQyswa0ZYWDhqemZuNHduNkNRbW9aNzN2V1hKdzNyRnlsN0hK?=
 =?utf-8?B?eVEwWERreVc3bU9WSTZjanR2YVU2bGlDNTNKenhZM0dsbjRIWXgzNERxeVZM?=
 =?utf-8?B?OXVYZElsOUp1S1NBVkVlTDd3NTRJVHFqVVpQWVF2b2wyYWFSZktSTDN0QW1k?=
 =?utf-8?B?TWNYeDRydC95WkJ5YVp2SVVYV2lkekp5Z3hyVzNscUlIUVdaUzhRU0pRRTNo?=
 =?utf-8?B?eE5CbWVaZytFNzU0R1BoL3owSHhrTnFiS3pLTCtGc0g0bkNsSWNEOElzL3dD?=
 =?utf-8?B?VG1JbFRzb1RyZmEydmJScm5rb3lpdGRtQTMrckwzM0VnRmRjZXV1ckdFenZW?=
 =?utf-8?B?eitYRG9NUnp2d04vMWhpUnF1b1NTM0pweDlZSjZRWjJ0VGdsK1J3eEhWR1Mz?=
 =?utf-8?Q?bViCt+RlgVwqIM2c=3D?=
X-Exchange-RoutingPolicyChecked: BZGB+99tRCsrklgPjttBTrMxw3LS9BB9JRH67rKBWPHckHaeGnEMT+3I/i+J2MTlhUpaTOFq3+4V4nm/9NASxdcQ64o7d1kz6qvrnQSq2zHqFF30z5drSPpBHoxKJNjPagGo7M6AoHDi2CUOH6J4VFtj0NRxpto1OygUPxFjEYF92xTyRcRzsJveSe+2sK0iIgna237A0BSy9EXOT8kpvkZfdlEXu2/XyU/AuIMiVySffsP2UGySIUi7QzzIpVnElwJh+QY4Gz42J2BSorjp+9m5Nv20BL5IcMTctRISw4yROF83EmybaCvZFfyGrKUlx9TiDbWfdh0L9os9P7lppQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b040e785-bad3-4e0f-c294-08dee1d3eafb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:15:43.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5Ak4Tuou3ggC7RRl3aMoHghKwrli0dZi5UUleHWfY2PYFYhFwwAnEXqlG8FbWCLXiolOYDHrqq7sDd1O+immg1r63her+PtEG0ZBmmbdX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC3B7BD011
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

On Mon, Jul 13, 2026 at 04:30:53PM +0800, Linmao Li wrote:
>drmm_mutex_init() can fail while registering its managed cleanup action.
>On failure, the reset path destroys the mutex, so continuing OA setup
>leaves an unusable lock that later paths may acquire.
>
>Return the error from per-GT OA initialization and abort device-wide OA
>initialization if the metrics lock cannot be initialized.
>
>Fixes: a9f905ae7b6f ("drm/xe/oa/uapi: Initialize OA units")
>Fixes: cdf02fe1a94a ("drm/xe/oa/uapi: Add/remove OA config perf ops")
>Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Thanks for addressing this. LGTM, 

Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>



>---
> drivers/gpu/drm/xe/xe_oa.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
>index 2dce6a47202c..f3a0d5bf7894 100644
>--- a/drivers/gpu/drm/xe/xe_oa.c
>+++ b/drivers/gpu/drm/xe/xe_oa.c
>@@ -2713,9 +2713,7 @@ static int xe_oa_init_gt(struct xe_gt *gt)
>
> 	__xe_oa_init_oa_units(gt);
>
>-	drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
>-
>-	return 0;
>+	return drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
> }
>
> static void xe_oa_print_gt_oa_units(struct xe_gt *gt)
>@@ -2855,7 +2853,10 @@ int xe_oa_init(struct xe_device *xe)
> 	oa->xe = xe;
> 	oa->oa_formats = oa_formats;
>
>-	drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
>+	ret = drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
>+	if (ret)
>+		goto exit;
>+
> 	idr_init_base(&oa->metrics_idr, 1);
>
> 	ret = xe_oa_init_oa_units(oa);
>-- 
>2.25.1
>
