Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D46CD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E1C113049;
	Mon,  1 Jun 2026 09:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gIxhfzXy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFB4113048;
 Mon,  1 Jun 2026 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780305251; x=1811841251;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lyZIsAP4v9tgCsebNIC7mKjAaABjFX75AKkx/I7tH6g=;
 b=gIxhfzXyTYlc3rtBN2ssouVtNiwolDiVDEwrpM2q+NoXyMwOI6AfbA/X
 jzmadqzER8KKR25uQH3WZghFZ9YMVhBpTdxVyjQDrBu8WFBEiAkVK9Sm0
 /ip07GDXE2E4IFlY+f/lJe1Do6k5WepYBXDUYF3jvB4oiT59y7SLO4J2m
 MeDK/v+QTFE4EoiC+mLmjId4oe9C7rt1LXhWB/uq5PD5ijoGGb38v6vIw
 ic/9yP4c+Kd9ohiBy/MPUHWNJEPQcmFeyvXcPVabsIM0wRAoRC8Vv0nH6
 QFAlu+yH5kUU08sgcxklZIUCUdQq6x3l/X4GyUf4lBeB3Jh4jZ8b+Wn2J g==;
X-CSE-ConnectionGUID: wq6LZhe6RiWPS06RtCqhOg==
X-CSE-MsgGUID: hxmjPgzGSHedpBgB97pSew==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="106508320"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="106508320"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:14:11 -0700
X-CSE-ConnectionGUID: o5TPZuBHQXy6/aOwpaiuCg==
X-CSE-MsgGUID: fhA5qtUlRWaFSB+KpakjoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="267155224"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:14:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:14:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:14:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewLU0ZSMuTIydmWWKWP9Wu8KPEuyEjmA0lSRVoh9/7Wf2q4Om6/7A3065b5PpgAZs+3vj+18f5mMhVDpQWLKgnS+PSp1KsdI/miQPicFCFZiPtzDRlhBruOKuDkJWo7UI0OdzIS1IreaFlBNp8YOnNYEC42icfmq48j82OQMptlmWbYPvVAgKNvlT7ZsjgBynznQ+sK9fomvcM24O5Q5W+y01wdTCD8FZMvE0h4BmyAhp0gccN9n4zR8IA0dceKdMv+QfezxlK9+Yw7t0yTVkIovN5EuOVW80MqLOhPiBPcoaVHR1snJ4VEijbEl4taWqszOlIGtaYa7/l34f9Avag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B1Fv9orHkVOGiPnqMnsE/Z8A8ayAYx1GRJJDZNugf4=;
 b=vZJwEcDh6hs//fwOfWQ1vt2TxtbxZ2DBWlqnTr9+FeCXRUbpjFPMgryQkjdWcBfXMtBbMKoed35IDwGqF16SPEHdPTauamrGTMnTBRt/icu2bbtd0o+qVxJcMzLhqCNPpsnl+fzzuASR9Y+pIhNeXxGc7R/5Dh1OmuM8i3puZ+iRxG4PM7c0onlVU8FVr0k5gZJxic3dF8tIXisApN8jcIYawCGIVcYNTmtGbtD2gKGCz/b+hEFIODMhXW9IVwAtuMWLciubEKXWm7otRP3v5hbyIqsLdIAkpl0kW2idyJEOJpCn/v0th5Unrjt37U+WouYm2Jmy2UV2h5ROj4fmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH3PR11MB8240.namprd11.prod.outlook.com (2603:10b6:610:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 09:14:06 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:14:06 +0000
Message-ID: <9039cade-614c-4410-a689-26008fa94776@intel.com>
Date: Mon, 1 Jun 2026 14:43:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/xe/drm_ras: Add per node cleanup action
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <dev@lankhorst.se>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <kuba@kernel.org>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260523050212.557292-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH3PR11MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 084bf1f5-b2e8-4fde-bec4-08debfbe218b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Pp6Br3VWKocIgqloVSsZvCUKOQolveSvbVtSoCboBuu5QieAwHo5BwFH7n3/LBGyn9y+cx3+ocbpb+dz1s8EZyZoOtVh+tZd6u3gz3hyWeqgLBBsNPYUVhiCIX75y8661Jk6sU7hXmoZPyAI1U7eetm+dJVTrm15Rf+ZQeO66fl4TPz2dKpuVI6NiNELhNqSM6yZcilp0PphObNxJuSw/ipTxfy1y8TAc2Kh1yhB7SRqsW5uVADd+bAwW3BT/mP/dSzwrwlAtKTBCd3ReyKIpQvGSOr/nOAN8VZsppH1oen7Sk7KnIixaZmvpJVFze/XDtO6cEP+TH2mSsrazz8+k5WruywV4pboKCwkc1VyY0+Ahe4+ovTHW6B5w0SOoOjxR55ph9TQDaLdPs+Ri+JL/+g3p+Xu1h0jGC6xQt6UO0NPgQUOY9/UoZtAZ1qIvb6reA07M0qYi4CIaO1yu1PKgDyeJkkgWLMRZPE9A+97BVRbNWQzWLjebRqTWDyc1+m+rxPbWaS8K8omgJau8HR6MlN59nqJi7f71d05MG4vXReNdRgu99xxNXeVfRs/wfR9tBxIi7exqWaeHNUi0+zrsh4nb6Jeo2ZJRSp6MVFhwOU/pbPS0GN3e1MPx8Lfa68lMTUlR1foABbKqwfcqprBEEmaWEh+D6c1v3qm/22LHZ2RBOV2sZqSSNwLAI/HgILxjOh2eiciKVFv2dLL7C3iAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnd3WFdMaHFSMkVxNFpBZWZwQlpSTWpYNVNtR2ZKN2p1eTI4RGxVQ0FqdFdS?=
 =?utf-8?B?YW54MFZHSzU5Mjh0OUFuQTBzK3dGU0V5eHZZRDVkQlN2U1hMZjBHVGtYOUZy?=
 =?utf-8?B?K3REWHNLNCtydWplRUIyMEJmTU1ERTRla3hSTm1kSDY5c0lMNC9MR2VRWndz?=
 =?utf-8?B?LzQvcTRObjNTdng5ZkdNdjI0K3I4OGh2eGk1OUpjSiswb08wOTV0RTk3QzNZ?=
 =?utf-8?B?ZkJUQjJ4QVNTKzRnSFRBaEVkUHZVLzFrWlNRRUU5UlJoNStwLzMzT3BEYSs3?=
 =?utf-8?B?dnhvV291ejV3d1BpTVVhRDRqejlSVVErZVZVbnM2cUJhcnhFWXlHMzFaSFhQ?=
 =?utf-8?B?VHZQQVVKelNRZnlYb2NoV3RFZVVpMEs5ZUpaSkkrbmhKUGJSajIrVDB0M0hK?=
 =?utf-8?B?S1lwckVmeVBPYkpXaTh4M2lMeTFaUjl5WkdibXB3ZTlTYnBvenBqdzFxWkRP?=
 =?utf-8?B?RlBTT0VYNjYzSFFZSWVDSmRTK0F2YWt3WENlY1NiT29NbjlYODJ1V2Q4RjVz?=
 =?utf-8?B?MGRaQTlmbTRYQzBSWXNCU2RHZWp3WUNQY2JlMEd0Uk9zTzVNN1ZZc3IxSUpT?=
 =?utf-8?B?ZTA2UUhYK09ENDVkNTJiYllaNWlwR3hkSjAySmhnNnJlaitZUkNucG9wc3lG?=
 =?utf-8?B?bDJ0VEhvSEtQcU5PdG9MNjVhT2YzdkRzdEJORTZoK1d4dEQvOGMrL2JUYndR?=
 =?utf-8?B?VUljM24vdW5XSk5rbkpzcWlzWU1uczBZcUZiTTZlZ012RmliWWNTWEcwY1VY?=
 =?utf-8?B?bzJwclZ6UG0wdmZjdVN4Y040U3NEQWxIeDdWVU5JZGtUSmViOXZEWER0dzJB?=
 =?utf-8?B?TjdsdW43NzdacWRsbE95N1hDWExSY2RzU0FzTHlrVm9ObE5FMlRPSGpTY0tr?=
 =?utf-8?B?V3d6dTRKNWlvUUhjZGtrdFNBN2MrbHZJUG1oK1prdXA3ZVF2VXBEd3E4bzFN?=
 =?utf-8?B?YU5kZTJ2N3lEWjZvVnRoZSsycnFGV3Y4Uk1Gb3pucVdQV1RLUVNkSm9NVWoy?=
 =?utf-8?B?M2NKY0J4NWsxNW5KUE9jelpZYjJNSFpMaCtYZzAxUit4RmF0Mll3SWFnbDJY?=
 =?utf-8?B?YnViNjRXVCt1b29JQ281MlpLd3NlS3QwR1BVYnNmWWowWGRSQnNsc3IycmFW?=
 =?utf-8?B?UEpWeUpscElSVnlwNnVvdWRzTFdyd0dYcHJ0T2JtQm9RNUY2OFVGZHkzYThR?=
 =?utf-8?B?OWRJbWowSkRVTzd0WGFtQ29PNUxiM1lwckxaNHdxQ1pIZEpROVkrZUNORmlh?=
 =?utf-8?B?TWdWSDdxSm1tdldyQXlhSzQyS2VGU2xyTzdwcHFtNW43VStvTUdFNXlSWEg5?=
 =?utf-8?B?N0FndjdaamtqTTRzVzl2SmxMYkhBT2NXTzRhYklXaXIrajBxYTh6MHV5TkZC?=
 =?utf-8?B?Y2QwczRDSWJOMGYvTXROUjlLd1EvQTNEN0lOdVErQ0ZSL0pZU1EwRXVxUFVk?=
 =?utf-8?B?VSt3Q0RpUXN1VHVKYk5iMkN4TkI4TFR1U1FiL2NrNUtlYzFaSFBFV3FUQUlx?=
 =?utf-8?B?dzR6eGtkTmFpVm1PWEhlTE41UkQ0OXo0cS9Wa3o3Nmx5UVBKQXRNNHY2OGds?=
 =?utf-8?B?V2JqbXJpRmlWaC82QUVndzYvWVU3dmUvM1gxeDdWV2MwMlFsa1M5eXdhYjgv?=
 =?utf-8?B?T0NIajZCc0paYmFtTCtGOFZVWVRocDJ1aWx5Tlh1Sk52U0xNeGVNbHRIbWY4?=
 =?utf-8?B?ZW9NRDUzbkFVc3JwNGdLcmFTejdKWmhNVmZjRitHUUpqbzQxMmx2VDZJRk1Z?=
 =?utf-8?B?ck56QjJ2b3BPbldrb2tjdWJqR3JuOHN1eFhsRzlGS1RLa1kwQ2pnbEMzaVRs?=
 =?utf-8?B?MEZjMHRoR2gzVjJsS0dtaVRDQTNBT2Y3Ri94U0VVSzJaTEgvTFJiWGNGbWJt?=
 =?utf-8?B?Ui9oYVc0V2I3YUppbWVhRm1XMExoL3hiejF1ZjFMTkpNWUU5eFhMOGIybk9K?=
 =?utf-8?B?YUZFMEZicmYxeVVSdVJYNUkrQm9HTVFwNW9Hb1Y3amd0NTN3UDVrcEVpcGh2?=
 =?utf-8?B?SENNcGF1NE9OaUM2WXplVUFPcUc0TkVNS01wWXY1VlJZMS8xdngrLzVlQnYy?=
 =?utf-8?B?RXVNSzQrallFOHAxRTRQTXpscnErS01YVlVpTTRmdjRKNkdyc1lra0FuNTh1?=
 =?utf-8?B?aVhGWkhoU2dyc3VGaFBqa214V3JuVU04S0IvWnhGekxiMmR3SnRETm1IYkhw?=
 =?utf-8?B?UTBWdkxFbTExNFliWXdMMnBRVUpyNE9hdHRyYjhKbWhtbUsxdGhtbEdVcFBI?=
 =?utf-8?B?cWFHR1k3NkUxZ2x4SVozQ0J5SUhGZDBrMnFxVFVXaVlxK2VabVl6RnhTQS9n?=
 =?utf-8?B?NVV3Y3ZZSVpMaWV2VkJxYXU0RlRKYy96SWlRTEhMTmZocFREMWxBZz09?=
X-Exchange-RoutingPolicyChecked: s9MIkbwMOkEBT/ehdfhH8yqJepuR4JxfzPNhe7MZ09+1s8uwKGb5w5fqnDLT6x5mBKOiLw/XeqPy1YLxYdsFTE+oh9imji1wfFCSTc1QGRjbAVHApm3GB/X2F0f8T8llKVTnh4Mz0+5p+fqMBijv0DrZRm06PxGW6KIKczyoFEC4iHTsa1gaG0gUV6US8Qya4KWXnKcecGTlbNWQ4T8Bw3/zUZke6iS8nLfBQeZmwn8YGoedxsqmTgl3ihyLkRFveSeqLxksNJF4SYr8ShFoa9X9EZlf2lAuYWeKDMCCSDNsakD4Sc97fcV6UZ+ah+/0jHe/VPc7mzWYmyBymsfsng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 084bf1f5-b2e8-4fde-bec4-08debfbe218b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:14:06.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDHvih9eI/Z1v1o46EGwX6/eNSR05/5HX5XuMxTPZEFT+ycwCT8hX6ZVYpQOURQ8yVkZpjAva2pP8OcBQDMZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8240
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


On 5/23/2026 10:30 AM, Raag Jadav wrote:
> cleanup_node_param() is not registered for previous node in case of counter
> allocation failure, which results in stale memory of previous node that
> isn't cleaned up on unwind. Add per node cleanup action which guarantees
> cleanup on unwind and also simplifies the cleanup logic.
>
> Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 59 +++++++++++++--------------------
>   1 file changed, 23 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index c1d5ac198a7c..b901976203fc 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -131,53 +131,46 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
>   	return 0;
>   }
>   
> -static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
> +static void cleanup_node_param(struct drm_ras_node *node)
>   {
> -	struct drm_ras_node *node = &ras->node[severity];
> -
> -	ras->info[severity] = NULL;
> -
>   	kfree(node->device_name);
>   	node->device_name = NULL;
>   }
>   
> +static void cleanup_node(struct drm_device *drm, void *node)
> +{
> +	drm_ras_node_unregister(node);
> +	cleanup_node_param(node);
> +}
> +
>   static int register_nodes(struct xe_device *xe)
>   {
>   	struct xe_drm_ras *ras = &xe->ras;
> -	int i;
> +	struct drm_ras_node *node;
> +	int i, ret;
>   
>   	for_each_error_severity(i) {
> -		struct drm_ras_node *node = &ras->node[i];
> -		int ret;
> +		node = &ras->node[i];
>   
>   		ret = assign_node_params(xe, node, i);
> -		if (ret) {
> -			cleanup_node_param(ras, i);
> -			return ret;
> -		}
> +		if (ret)
> +			break;
>   
>   		ret = drm_ras_node_register(node);
> -		if (ret) {
> -			cleanup_node_param(ras, i);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
> -{
> -	struct xe_device *xe = arg;
> -	struct xe_drm_ras *ras = &xe->ras;
> -	int i;
> +		if (ret)
> +			break;
>   
> -	for_each_error_severity(i) {
> -		struct drm_ras_node *node = &ras->node[i];
> +		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> +		if (ret)
> +			break;
On failure of drmm_add_action_or_reset , action is called. We don't need 
to cleanup_node_param again Thanks Riana
> +	}
>   
> -		drm_ras_node_unregister(node);
> -		cleanup_node_param(ras, i);
> +	if (ret) {
> +		cleanup_node_param(node);
> +		ras->info[i] = NULL;
>   	}
> +
> +	return ret;
>   }
>   
>   /**
> @@ -206,11 +199,5 @@ int xe_drm_ras_init(struct xe_device *xe)
>   		return err;
>   	}
>   
> -	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
> -	if (err) {
> -		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
> -		return err;
> -	}
> -
>   	return 0;
>   }
