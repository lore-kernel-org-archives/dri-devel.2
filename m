Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB41C61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E7310E649;
	Fri, 28 Aug 2026 18:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ke/xhGrY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A8E10F44D;
 Fri, 28 Aug 2026 18:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787940520; x=1819476520;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=S0zTN68bFGzr9lEaew31Ly2FdUPjSJy8Tc4J0G2Jxdk=;
 b=Ke/xhGrYGnER+/cjLWgpNZpQ77B+IT1GpvN12eqOwgowklvu0MYpgM+f
 gDM/dpaA7GdVA5Cnq/gsj//gdWY/4jMK8cWIX6dzPTpzcEc0eFHunZU3m
 HUNBzcssYzVzenROYzDhPz7Vt5Sf/Pv1GpROxhdAXOG7FFXsvrL3b2d/K
 pSKGXO9DOj3rttKRqheDKcXskBBGHosTA2nq1/nuwbjH/6ekk8gbxh+CA
 PyK3+bpb7fSI1NPLeIHEIsCoEa/HKEO+kPwbvIlFRC3nz+gQwjQnCINqY
 jqB3HS8C/edgbcXMlyfAt40psF6xQpe469Y8PwsJjuo0DShLQScyhu2Vt w==;
X-CSE-ConnectionGUID: 2Neb+bvPSPy/q5h3f36sLA==
X-CSE-MsgGUID: pFGZPWrPRjeMB2hunLb+ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="105980573"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="105980573"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 11:08:40 -0700
X-CSE-ConnectionGUID: y2gWeW9oRVCmLqvbtJxaaA==
X-CSE-MsgGUID: 5rgUlF/3QyuDgVvXUKxWGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="265636178"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 11:08:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 11:08:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 11:08:39 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 11:08:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf4AIVc6bycrikLwSO5NKLlgp433qSVus8KDZLSH4M5QBPIliWxnGM0NnzbhroUQhR/5dWq7wn5MOdfDzLcKP3NuZeL80Hk9gtXaA+MEBbg4ZtrYE3BmHB3o3EBSOIHqv1eY0DUWQ0bT9992mARjggPbmEeMYshijsHEjVTKVMkW1dnUcXkZMnMKgeklZ53tg+uIC+yPu6dPSlOGNoS22rpwbhBJWhDDG/25Nam5JDT3zVbSwdPtbQro69BduMtYEP8ET95uMdNqN/NKJjVUsKZKlFb5gIfMLsWibpsBJWUqoXuDz4HHvS3hPZjRKMfS8ITNuQvLnlZ4KO3EyTUPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHVmponkF573me9umJIJYtx+iQthClClYPQAVvAWzig=;
 b=Z0SmJxFPm3jqLA+PLRy8lFphJr77okNq2c9b1WwfR06vl2xW8PzQLxa4ml/ke/y9520KlnlMz04m5I1ieS7YAonG9yBp+zRNZcB2xJGfCsqj/Oal6V2IWS/b/6TQrh3JfBPVhJy5lIC/O9fJIuUIlDyDmMe4SunUQwOHM/jT9hsDv9uitrv1GdO0GEGlEIONLM89FCJ3fj2llHWr7r832WpAFd9TH97Rd2ArjU8qwNwinywSQCcOtgjhqOmyc8DoMbR+LDqXcH42BZNgmwJjvOTgxIjZRBXQwhHNMu88I5D/WxSYCxqFEAzwIOz6/oGEWdsrDBsRV2fIr3f/TlkJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by SAVPR11MB9573.namprd11.prod.outlook.com (2603:10b6:806:4e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 18:08:37 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:08:37 +0000
Date: Fri, 28 Aug 2026 20:08:31 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 7/8] drm/i915/selftests: Use drm_* prints in selftest
 headers
Message-ID: <apHOQ8d4Kfz_HeMX@kniemiec-mobl1>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-8-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-8-krzysztof.karas@intel.com>
X-ClientProxiedBy: DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|SAVPR11MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9780218e-b8ab-478b-23b9-08df052f61dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|56012099006|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: HNyV99S4y9HRoXNOR1gxkK8FAK0svc9R4h4tfqAn9pQDDOqnV1pJP3iF66vqTchsnSsr62BymFO31Q0oqyajg2bEVVJ+0PDhe/8+IOHGJjXP7CKXWYLZc2wEMrpbs9K1LjXJgm0MjBniW4oz3ENfNU9NzB2KmxisvKbafcs2Bydob/rOVqZ58605xWoQg8OHT+BxSTdC79hC47Ftq48z7ReZT6EB4VoAozkDCBXuzaDeAoqTfF0HcRw3RUH4uq6Q3f8/R+ebUOAjpxdRNwuNFEjGYQUclEJZ5YI1/Hasb/oHxBojOcVEkoFPsvHKt3OZQNmmCobyrlEwUqdTFSZ1RnVEn8CnnBf7T7uwLay2QqInmyNJul/odt70wk2mZRb5grPAJ4HUFeLnx5m2DLtUR3giQNYxdOFRcvqOumJogP74TZs/w+BJuUwOdt+zeIEjo/eU1J7PG3QQUlKzhQ1iIBgcGmD8ia/g03+c4HiGWOj41VoI7lukcJ0U/bfKH1gGy6AKDfKwq5e3QBvw88iP5gifsEuctlO5wkDaIZ7zGaFWiZjZalNwWCxSJ4UCC7R/ge37rBzGGcRtQAmsKdHoWhFPfTGJlr3rrOs3kCc7GbL/qFzJCBEBcWKF+9tklyTAevBVUY69uzXzXvDNYOp6NFDWbZmebPuLsSmkLR1UdU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(56012099006)(4143699003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHY1NUJqM3c3clMrYkcySUdKeHFJODhKbUtKNFFnanpCb29yNjhMSmF6aCtX?=
 =?utf-8?B?eWlUVjg0MlJDb1pNRE9tMGthOFRSTlpSSTA2c3RtTXAyckVId0tzL056RlQ4?=
 =?utf-8?B?M0ZpOVlsNWlVNnhJQTRBbWJvZEh0cXlEcndKRnBpMDgzeHBEVDRQclJaQmVU?=
 =?utf-8?B?TEJ6cHlkWmowTU1DY2NmTndabXZKUXJVSEhvMDBOY2R3Z05JTm0yODNBQmp4?=
 =?utf-8?B?OFlXb0tvMTh5Ylcwakxld3lCRG1xQllOM1d1SjdDNzNHTDZobjNjcFlCdXU3?=
 =?utf-8?B?d2JGRjk4NytvdnFXSkRIL0t2N2J3Sm1yT21QR0ppZElmNm5FZmNYZ2VkTWQr?=
 =?utf-8?B?TUFldVpjdXN4dStlOVVHZElPVm9oRS9jWStvaTdTYzBpSUduV1dBZVZJV2la?=
 =?utf-8?B?WkdGcGc0NmRDckVzY2s5YXZmZTZUdHJuL0t6emh0MGZHekEyLzdsZHorY0t1?=
 =?utf-8?B?RkVBbU9nVWszdDYyam0wVGdXTWlRSkV1d2l4TDNrVkxtRUp1ZXUzUmd0OTcv?=
 =?utf-8?B?T3JpR0dSUEQ4VSt5dTdzbDNFTUtmMHIrcHVPRE1qb2dZQTA2d1ZOSDBpWlRU?=
 =?utf-8?B?ZTNNckFTWkZTWXplWG9temFYTGEvT0llWkJkOEJBRS9qZHlMRWdOM0R5ZmhH?=
 =?utf-8?B?ekZsUjExT1Zad0dlWFA2WnB2dXVWbGhkZ1B1NmdXQzdzVDFTM3ZMNWp6RUwz?=
 =?utf-8?B?MVoxU2N5ZkVoMnlrRmJTSi9VQzJ2OEpvTUJVYTJ0YUNFVXhpN1JsL0JVaVBR?=
 =?utf-8?B?VTJkNGpMSmExUk5UUzRyR1FrTm1nd3BqK1VDbXJtNmY3MVhCV3IyZXU0dXRm?=
 =?utf-8?B?QkVxTDJIRC9hN1JqLzhZQUlqQ05WL0FVMG9rdlJ4OGY3RUZ3V2ZRWURsT0JP?=
 =?utf-8?B?MVhEV1gwbTJvZVVJaS9CNmRFblRON01HUFNFVzQ3VkRJZmtHakdMNFFtMHdN?=
 =?utf-8?B?NnVxOEtSM1ZLWFJac2VsT2w3bmppRHBOcDlrVkVFNDVvMUs2VEFBd3pXaWtW?=
 =?utf-8?B?LytPTFAweUlLcldUUlJ4OCs3UGV6UDdqMWgyeUJwQVNQdzFpeTNTWVZhUG1v?=
 =?utf-8?B?Q21RWk9tMnVQZWtqUkhWV2RmQUUxcUpIblp2c0EvYzlOK0hldyszc0lQWlEz?=
 =?utf-8?B?MzBRMGQ3T0R2bjZUdmZhc3ZCa2FCRi9sMkIvRXRSS1I0UmkyNm1FTWpLUm1w?=
 =?utf-8?B?VHkzeDhwUnVQWnVBcEdxVGdSRnNna0IyN1VQMnpqZ3pGL3BqTUZDcGQvaVJm?=
 =?utf-8?B?NEN1VEdFM2lCVkJLMWg1OHg3SDhqaEtHQWMzeHpLRnd5bnBNRklIZnRKeWIv?=
 =?utf-8?B?WHptN1MvVTR2OTBUSk4xK2ZJRFpNUzhpUlFqeDhHTnVaU09TS0VGU3FyV056?=
 =?utf-8?B?SnJuc1ozYVdOaGt1MFVnYVdTelhHY0l2aTJScFJDSkZLZmhJd3FaK05hZTho?=
 =?utf-8?B?Y3JIWHdzN3lLL0p6RG9mcjIzYm1jZnhDWGtXb1R5NnFEN2xCSndLRHByb2dP?=
 =?utf-8?B?a3ViVFVvc01jaHdCZ1dKL3hZZnRsZ0JkV3lXdWN6T0hwZkFjdjdURm5LWnlZ?=
 =?utf-8?B?TlhnbXRrUjZqY3MrZFk0NTdtTWRsZzh5R1RiUkhNVGFQYWlpbkFrUWNydTkw?=
 =?utf-8?B?OC9zdEFRb1JGSS83N3l2Y3RmSS9QVjZkTTZWZUdQbE1XUUp4WXVzTEgrV2NY?=
 =?utf-8?B?ejMvYlRNWktPYzdvQ285Y0pmMkt6YnVtVmkvT0ovdE8rOWFoWGtaL29xY0hZ?=
 =?utf-8?B?NzJESCtwSWkzVFBwWjVRTk5qcnpyd1RyNzBILzlwalZvMk5DRGhDSXErbksr?=
 =?utf-8?B?a011Q0d1UWZObWJFbVlwc1IwRTVydDA2SDVsRm5Hc0tQaHA0QjFGU2lxZkdr?=
 =?utf-8?B?ODQxcy9yL05OeVBISFNubGMrSmd0WE9rcnFBZ0FTNHoydE15bHRaL3E5Vjl5?=
 =?utf-8?B?ay83MmdOTGd2UGpFL3RQblJFQWRMSEZlYTU3cTkvWHp2Q0F2Ymc0dVZML2sw?=
 =?utf-8?B?UUtNNGxIUlQ4ZFVlSFJjRDlCYmFib3k5Qlo4eThlQzJ1L2NaQXlvbjhSNWF1?=
 =?utf-8?B?TUFqZWpKUmhWR0cxeWE5WG5xMmMyZityNFhwMVlzc3RIMnU4bi9HRytlMVdX?=
 =?utf-8?B?bjhJVVJrT3ZEMW92bHFVVkxOQ004SnpXaGtGWlJ6aDVLSVVsZXFLYlNIQkll?=
 =?utf-8?B?aGE4RE5uK21iR0ExdjNCWWk0cUV3NW8rZXBPbm91NDdSVmIxRmlJSjdnVDJ4?=
 =?utf-8?B?dUlWTVkrTkJpK1NzcW5UV0pEMTZ0Q3FjRWJYYm56aDgvSzVZdnRFWUs3cHU4?=
 =?utf-8?B?T2pndzJvVGRFMVhpWnZIRFVMcXpjMjF1WFA5SHVCRGNHRFNxbkFpVVVGSitU?=
 =?utf-8?Q?9u4nJmsd8Opfl+Z4=3D?=
X-Exchange-RoutingPolicyChecked: 2se7giVFLsGC4L1RZ96Sn1cTcmhANu5W8WmaIB7U17tmE1eL1ix/cBt3J1KoXkBI6M0HplIpH/elC2EYMUZXo4ZXSn6dYhGZH+xcd8L3MdQOYfOOZZv+MUSsBhKELeD2BqC6BafJkzg0IHesTpVjfFIJi4ngvO/K/AxhvJKUM4EqY5fPnbM20gNw6IBPKYoS3kf4zrwZL5wFD7R4f6cgUrACv7fJMGIvlf3gr5pWS8MPvCRfhypEDbChHYPIHDlpMVy4rvm5RxNUJz/m0AI/2DX8rcn6NfIw1GyCRwF0TDWXoihmT1Q73hNZOvg6rwuSsz1sCmjhx/dTHMUOt5HmJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9780218e-b8ab-478b-23b9-08df052f61dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:08:37.4576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmb0u2EleVVMOzWGrwGEhzkW0/8C8/gd6zJXW/6+0eu5709PaqIPdSYsiAITzGprItE7EC44ONKD8fnkk9sOfU7Rbucz057toZx1QtAd2Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9573
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

Hi Krzysztof,

On 2026-08-28 at 10:03:38 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/selftests/i915_selftest.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
> index 3adcfdab75ae..fa840a7e651e 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
> @@ -23,6 +23,8 @@
>  
>  #include <linux/random.h>
>  
> +#include <drm/drm_print.h>
> +
>  #include "gt/intel_gt.h"
>  #include "gt/intel_gt_pm.h"
>  #include "gt/intel_gt_regs.h"
> @@ -47,7 +49,7 @@ int i915_mock_sanitycheck(void)
>  
>  int i915_live_sanitycheck(struct drm_i915_private *i915)
>  {
> -	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
> +	drm_info(&i915->drm, "%s() - ok!\n", __func__);
>  	return 0;
>  }
>  
> @@ -154,7 +156,7 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
>  
>  	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
>  				     timeout_ms))
> -		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
> +		drm_warn(&i915->drm, "Timed out waiting for gsc_proxy_completion!\n");
>  }
>  
>  static void
> @@ -178,7 +180,7 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
>  
>  	if (need_to_wait &&
>  	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
> -		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
> +		drm_warn(&i915->drm, "Timed out waiting for huc load via GSC!\n");
>  }
>  
>  static struct mm_struct *get_selftest_mm(int u_pid_nr)
> -- 
> 2.34.1
> 

LGTM

Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Thanks
Krzysztof
