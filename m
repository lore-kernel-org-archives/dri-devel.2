Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D4310AB82A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D9010E677;
	Thu, 26 Mar 2026 23:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cTB0njo4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDB410E245;
 Thu, 26 Mar 2026 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774566539; x=1806102539;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gfnqNviXN7MZ7oqvLqPOvTrBVaKf+reuBlaBgvx0OWI=;
 b=cTB0njo4wu3VD6ySfAOR8puzCt38vmIup+vuCEi7WLVvIgutkNucaFqv
 +uhHJG8qWeSRlRm83CFsFI/KUp82sG5YLfqYbKtuLmd+yB825tYS0g277
 dlGktOv9WBfXj2a6faWp5pPStp1/QAtlofS//MkWCzTlU+NtHP4gs0VMN
 wOw0A+ySKQYShO5x2Ssk3uEDGKcAuZxOx5HqFwypJK9shLvT9/eoZWCDM
 IFEL4O5k5GR39/hSGbbr06ZTVTIIhK02qhW3peljJjYpEZZkaRIGKk5Yn
 jO7+6YVZTVIJNJZ03uW5BX5qB3XlbRdcOWtSPlsSKRErf2oxjaJ370NpT Q==;
X-CSE-ConnectionGUID: 59BtwlClReu8f2cFmcAXxg==
X-CSE-MsgGUID: rLIf8Ak2RBqunwOLArsZYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75522261"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75522261"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 16:08:59 -0700
X-CSE-ConnectionGUID: LyTE9gwUSOmHSxeejDQ0IQ==
X-CSE-MsgGUID: E29fiwfRTtiJaHRl2U6RpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="229204980"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 16:08:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 16:08:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 16:08:57 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 16:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOBc4CYZIMl4Ny0a5D7H0sP3PI7TQW4xh+CA48RvFgEd032++jeB/CBNmQclNofkc2NNemauFdjD54eF/bBKOjpgzfOV3TNKzwo0d6CMmgvfLOzrMjfbzlhjurRpxCKWYgzVPpcGn7cBOEj+sYbcZEQRZgSejDKOWgRKGnLOLCcgWewR4jjV0fwg9vvxoMXXJ5GVFJlnnZjUubQZK5A6A8p1CsU8tndtVBcDs0s7cykSjE3RS+lYaVwPJB1a3cKdL3BO3e0PvzuPqs2GAycu/yoW89wiQaRQ1AH4IsgAB1dDggj1ZqCY9GIG457767w7GfDalMGK5pVH0vSo9dF2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3b2efHukF8R/Rfl5JFpKA/bIhlVlNt2DzD5/sqVZ3I=;
 b=geIXQ51T3bVkkP2MGfJkYx3DkD46pIqP+1dN0AD3CinFR8rbSX3Bm+hf8L0cX7x+WQg79VhZQoFvWECj+r99sYLmrimMarR/P82FSG0mV14DYspayAMsom6W2VubvZSQ53zolX+Q2O+YDWAyEATboWQM/NPMdPoz0udCsrrQnDyLm+0tmKkQuwXej7BDjFIh33aEkJC1JqHpa6a+WDMnHRQkJVS0wMc73O+oYL2lrrPPQcV4CuhP7qWvJwn7YnXo4ikVvyBmCYmKncd/B+xsIpxz5Gq8Fd7IHIBBYfUh6L6aipaEcnk7v2GQHbIYN1OwitlBpko5Ol9RBOz58eY4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6683.namprd11.prod.outlook.com (2603:10b6:510:1c6::9)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Thu, 26 Mar
 2026 23:08:55 +0000
Received: from PH8PR11MB6683.namprd11.prod.outlook.com
 ([fe80::a62c:97d9:446:ccca]) by PH8PR11MB6683.namprd11.prod.outlook.com
 ([fe80::a62c:97d9:446:ccca%4]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 23:08:55 +0000
Message-ID: <2d569d28-12bf-4f8e-b662-282c9cad0556@intel.com>
Date: Thu, 26 Mar 2026 16:08:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ras: Fix memory leak in doit_reply_value() error path
To: Shuicheng Lin <shuicheng.lin@intel.com>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>
CC: Riana Tauro <riana.tauro@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260307184541.257941-1-shuicheng.lin@intel.com>
Content-Language: en-US
From: "Bai, Zongyao" <zongyao.bai@intel.com>
In-Reply-To: <20260307184541.257941-1-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PH8PR11MB6683.namprd11.prod.outlook.com
 (2603:10b6:510:1c6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6683:EE_|PH8PR11MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 59444608-bc79-4737-8edd-08de8b8ca75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5Wfq3CSwBEms9Bg2JK2jOpOflWwAeRmxJ2fb/+ePcQtFzVsbc/wUGEpbhiCQjsnmvHQORTJASrspFk1zN/AqPlilZA6ogaGR/ATYv+37ct2AjWoCwi1ARFg6wHhOKuf7uB2bk96jXyeVB7hT8Akvv5E9waNwJwO96MEBy17gsHx73xLJC9/8ojzlOq2n3Q/ruMRCKwicbWnAgehNhKWE7yXuNxHNxpFBHkeosRRPOUfy/Q56XYToOo+7P6Jl+RL/6YEvPuKDry1WcR8zdEBC0MKygDp/gOxWdcZ6Lbq+fRQkQZ04Jzxid6CxNPUnhVZvYk53feJMruUrHhDH9wFSK1+7Yin1DQW5p2z50yd5UNVDiRJgZ3NkNb5ADXJrbaMz4fqJauOVwgy50d87iuSgoVou2MYe5aEzUEvez7wPtToZPw6bjPOhM/OGr9pjvE8CDt25OCSSFIMeqK5TMnDMVd+3ldKN1Z0ofYdiJCOC1KdnwRR5dhVjtTVe1EmNHrs2FTBnHvt5ucQjKcKmEH3wKGofBRyxRcfal2kAnWoKlrO5BcA8fRZWAXxRaNJvNS01Eh9/6PPMKvGb0/NywUtKC1oHb1JHODqFglvCPn+260HT1zdNROE5q8j/5vw1HsjFgq4fTz8mYA48KhbK53DoTdfaMIrPcFER9yr+gfARkDUdRJ5gf4o3hbdw/cLGodkIJQoWT4MxRiL7q1YYwnsMLCFePjC1c6/BxUWM6kT9LgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6683.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGJvUHZZUU1iN0dMcnB2YWdCN2U4aUJtaVBFUU9qNEpXOGhFTXFCTkxscWZk?=
 =?utf-8?B?VEU2andETWV4OVV4NzRwdFpmYkx2bE1QbEVjb1g1ZEsxemNDbmZ4MC9vVGZT?=
 =?utf-8?B?V3BnTHJxZ3FtRVZoOHpQeWxYQ0ZhNWFJcHV0cEhTMVFYbGNMazAwRlYyTkdt?=
 =?utf-8?B?U3JaSmZkN2N4THhBWEdJTC8zZ3dOWTVCS3BJczN3ZURLcFdrWlViQ0JndnBl?=
 =?utf-8?B?aHMxQ1UyYXRXZ2NGbk80RTZpb0RrUE5tZVJVZ0ovSGM4RmpZa3lMdkJOemRs?=
 =?utf-8?B?TjNFV1FLY2xSV2VvRURUNTkveEdMY3U0eUtHNG1ETzdXMU9nRUJUQnJ2N1Qw?=
 =?utf-8?B?UzNuUTUvc3kxNjI4MEEwcVE3NEE1OEpYdy8yVWptU0VJYmNHNDRkRlMwWUky?=
 =?utf-8?B?ZWFycy8zamZnYzZnYnNkV28zUUtDTDJkZnFtM2E4VWQzVG5hUXJjaEtnZTAz?=
 =?utf-8?B?RVF6NHk1TU9kaHRJMFlyR3ZjZmVRRkgvbDQ1eHpGRHc1U3prSW9Ta3RXM25w?=
 =?utf-8?B?WG91d0ZxSVRHU2VZd1A3M0lkUEFPQzFNL2ZUbEl3TzIzcThVQ1ZzcjQ2UEla?=
 =?utf-8?B?UDN1eVp4SUQ1enN0OU5PUFNNT2xZa3FTQk16VEdVeXlTVXR0ZmI5UitnMHJL?=
 =?utf-8?B?bEYvc1VTaDVtdWZwTTA1ajA0TlFqVXhqajhxMCtFKyszRks0eVBtR0R4Rmt1?=
 =?utf-8?B?RVBQZ0ZxTzR6YjRjcFhXSks4cU5UUFk0RkJ6RlpxYm15Y3gvK2xFeTg1WVBX?=
 =?utf-8?B?bEJvMVJuRzlmeFpUTWRuNW5TeENWNUtra1RKSlU4dU42ZTd4TXQ0eVF3UXFM?=
 =?utf-8?B?ZzlXQytOTGNXZkFmQTJ6eVMrczlra1JZajBKemkrb3ZMR3VPb0hsWFJCT2ZZ?=
 =?utf-8?B?dlBZN2xqNSsxK2hIdVZCOHA2dkZBODZCM2ZCRWUvazdJZ2pJVzNIVXlmdXdo?=
 =?utf-8?B?S0MxY3FrS2NRQlF1cWpMMGk0R2Mzd3ZHb2Y2c1lWaFQvc2lqMllDRjVJRGl1?=
 =?utf-8?B?aU1nR1oxNEpwUHRzcGZzZVA5bnQzL21BTHQzbDJtd0x5TkFzYjhuZU5WUllB?=
 =?utf-8?B?YVNEaFI1TVJMOHNFalN6aGZDSUdnSjRuYTU0ZTBob0VZcGhZUGJubHFLNWFr?=
 =?utf-8?B?dU5UME1wL1hYaURuWUlKLzdyZm8zZXlwMDdsVVRndk5sOHd5RXduUERFUk1z?=
 =?utf-8?B?bEpHeWs2c3ZrK0ZZcEczb1lFa2tKeXhKTDU3aDhNS3YwWEQvQVdBQWw4Qlpv?=
 =?utf-8?B?UmF2b1QrUWZQQ1Rid2dBcis0LzVneURCcU5xbUphRmtrWkI2aHl6Nk0xcFNJ?=
 =?utf-8?B?ejlOZ1g0VytYcENCNk1CY3M3VVA1RHZEVlFlVjlDOW9iRE90VkFnN2RNcndl?=
 =?utf-8?B?UGxUM0JUdlJ4RXdpRHNWRTUwZzIvcG9IeWlwSTFPeUtCdkpxYVB2amVrNG5M?=
 =?utf-8?B?UzZsTm5peDFPZnRlaHhxSjdEcXNDRDl5WXdGUmdIYnhocjNHakhSeEZUUm9z?=
 =?utf-8?B?QVdZZHY1T1YrSmlPWkxYWTBqUzYwS1VZN2ZXUmJMT01jTEJhNm96V1I4NTdo?=
 =?utf-8?B?Y3hCSzZRRzFhRTUwVWM0b3N5TnZvam0wRGRUY3lZaEkyZlN5c21zd1U4eUFW?=
 =?utf-8?B?TXhHY3QrU2hDZ2NoT0lrcW1sK2JsQkJmK0t0bWdxMERSTzVKRm9uSlBTdW91?=
 =?utf-8?B?TFAyb0NMd3ljWGJ0MGIxVkpnOExHTnBjVkk3L1VaMXB2emNuK2ZsRm03RTlu?=
 =?utf-8?B?dXlPWEh2NnJuWE5wMG0xbC9xeXVvTVBJQ1BFVmgzYlB5OGVFUXhlWDN6ejRm?=
 =?utf-8?B?SVFyL0c0bkc4MkMzMFNsQjFYTzVUcU9MR3VRcWtnaDFMK1N6Zko5ZElYd3dZ?=
 =?utf-8?B?aEpUdWtOakNQNTJmejNqZU5WVVR1NHI1ZzRjY3UybGhPM3FQVk1EYStxQUkw?=
 =?utf-8?B?OWRjN2N4YXlMTG5YWDlSMzY0UTJIQnZQZ3BrYlRiekRVOGRtNXFKUzFxaVFP?=
 =?utf-8?B?aXd4eWl2dm9wTFpIcTQ3NTlTaVBJMEJGczlvcldLeE1LTy9oWWNPRk04dk5x?=
 =?utf-8?B?MVUzT2hsUHhIMTNlRjRLb1l3WjRKTWMzTGc0UGQxK3lISWtEdXZnUzZrVFdx?=
 =?utf-8?B?cURJNEs4WVhmeXBxeS9VYzZpWUJTMVhOUlhOYlFObDhDcmwyM3lGaE5obFU1?=
 =?utf-8?B?bDc4bW5DbUN2ZlNpSkJ0dlAxQnZib0N0ZEpUanQ4NTljK1RqTnhLY3NPaXdM?=
 =?utf-8?B?Rm5ZWHEwWVYyS2QrZ0VlQ1JiTUcrVkJuc1Z6dlpaT2NLWHAwbWwvRzAxalU4?=
 =?utf-8?B?TEhpdG52eWhLSTNscmVJRktRUlBIM2VXZnBTaWpUZmYyWVpQbitkdz09?=
X-Exchange-RoutingPolicyChecked: G+7PJ2KSXsuxXywi9KOI2GRVzaaVdSeMu2jEhH/eHRzoPPuZx8XEUrvtF/7BANA2tyb7grDzIKRJu+6sP6JD0XPkiSRYs/8ke5ghh4J02k5YmCxE0DUU6MGsmVbRVdTnlFYdKIRkbbZ71LBna6nDcJiBVUIXFCqzgt4WUHgXk7gqhVQh5Z5mKDFXk6VCLJE21pb2/Yy9k1qK1xP4EmybNZhzN6E5RmaJlOQGUu0GsgrgqZ7gYOxvAYaDJGmOlxqNxhElhoUqLWMiZQ5RFv02SHrxzvhWTNpmGmrq1f0UG6eKyZOAQ7hH1aTc6ncPoTU3A6rU0TPiswXSBdrY0fguJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59444608-bc79-4737-8edd-08de8b8ca75e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6683.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 23:08:55.4472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1d5kU6z+IPFEwLHqzZsH/dXhvORVZo08PuZrpG7jxGSLqaEvW9wlEazzF/LbqYeDZZYCGZTPsFgllDpukACAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
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

LGTM

Reviewed-by: Zongyao Bai <zongyao.bai@intel.com>

On 3/7/2026 10:45 AM, Shuicheng Lin wrote:
> If get_node_error_counter() fails after genlmsg_iput() has succeeded,
> the allocated msg sk_buff is leaked. Refactor the error paths to use
> goto labels, fixing the leak and eliminating duplicate cleanup code.
>
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Cc: Riana Tauro <riana.tauro@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>   drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b2fa5ab86d87..e98a9e74cfd3 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -195,25 +195,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   
>   	hdr = genlmsg_iput(msg, info);
>   	if (!hdr) {
> -		nlmsg_free(msg);
> -		return -EMSGSIZE;
> +		ret = -EMSGSIZE;
> +		goto err_free_msg;
>   	}
>   
>   	ret = get_node_error_counter(node_id, error_id,
>   				     &error_name, &value);
>   	if (ret)
> -		return ret;
> +		goto err_cancel_msg;
>   
>   	ret = msg_reply_value(msg, error_id, error_name, value);
> -	if (ret) {
> -		genlmsg_cancel(msg, hdr);
> -		nlmsg_free(msg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_cancel_msg;
>   
>   	genlmsg_end(msg, hdr);
>   
>   	return genlmsg_reply(msg, info);
> +
> +err_cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +err_free_msg:
> +	nlmsg_free(msg);
> +	return ret;
>   }
>   
>   /**
