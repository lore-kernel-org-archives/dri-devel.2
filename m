Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C597C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDCC10F1C3;
	Wed, 23 Sep 2026 21:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CVpf8q4J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB7F10E9A6;
 Wed, 23 Sep 2026 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790198460; x=1821734460;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pQvWnT/o0xngh2QKnHHDJ/olfsiW6dlTWg/z0/n+LHs=;
 b=CVpf8q4J5Obk1BXq/S43lXjwndbAVzQ0xSCHpyHBsZbXZc7QMRjKTufq
 /h64P63Ao4kL6LIJwRuxwJKjgblpYL8E///EMzB//kAe7+3CP+pvbaBgc
 gf331EOcWsc0abB5clUjWAXP7W0jst4bmQob229qRlZ5luvOnn95Up3oD
 soVKj4NOIyeLcyZhUWnIDAuZ2m6xKqd8mZXf9uUEm8Mhxd7RJ4l/ubDVS
 5sqXt9SpZLvxLcswEx/Kxh9JlqZ1syGKnxVbIt7B+XqqosRzhgdUJ/uIU
 USCJM8q1H+3SbORWf10ZKQU9GnMGToaf2aQKqhtAGT7C4QwlkZ88k/YLK A==;
X-CSE-ConnectionGUID: 9mlu0PFnQ6WB/f0av0aTRQ==
X-CSE-MsgGUID: GAzpgeVZQVeRxYDg5192Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="102299697"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="102299697"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 14:20:57 -0700
X-CSE-ConnectionGUID: Mwm6wTE5TmOCJTDxG8iHwg==
X-CSE-MsgGUID: Fe+H3J0bTrS7WDPbzXPG3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="301732842"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 14:20:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 14:20:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 14:20:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 14:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaNT6C4W3k5W/IyU6mO+nLMhEAMQPG5rS8JsYGTU4SW5f9d8aLaJOWLkiiPPtsAWEYA2+eCxbi+qxjI7CxzwAuKIUDEdQwklboQyINB7pRm9IhOrTAEEzSmZjl+bGNXURH27z/GO9iCEf0mkv73TK+v+MKWuFO9pXyhuHpN7J+uCuW8jrXsDyZ8rkrbvSp/ojQKwfhVDf/Hpw5j50lH/YpCzuXC+9pf+8tW+lUJozdHw+EnCYwiAUcnoS5HtrHWalVJ9+OG78sDQLiuQy3fPIwkHprS9Z2130fZIvYMHqcTQICAZIKQnXB5o+sj4yklmDD7GWQE20MMbdgVfZoZvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAwqnd/Alg7VrYAcf8+gAX87SZfhNCOMmdE/wTzsXkA=;
 b=HkXCMoBVqQjfdyuNtMGddU7qhVzVEr4Z3r6x4vGMz4CPmB1LzROX4tnwLORUVp3tLfbhhOoo0ulfwSWL3pMEXdxwHRPkbjwTuYs8lJAtQ5VZuZh3sClEI5tleOPw1htPW9rEaCTWGc7sGrq2Q9hxC3mryCQhJqZTTKOW+EuZbNNaWggPeaK++d1jcGb6uHLPDxGuAnX8gKjsJx0rXWTAV0iDpSC+VGlZSULWje0GcdBWvIBzpKROUScvZXE4L445mAydtmHzeNeVAkLH8E0JUuCvpyB2iktNnR/KyCRYbuAG1r+QcrEH4jniknnfYwZ9nCGNYLVUBP9OIAgu8L2OsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SA3PR11MB7533.namprd11.prod.outlook.com (2603:10b6:806:306::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 21:20:53 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:20:53 +0000
Message-ID: <8e01832b-4a94-4f0b-86c3-71664d22a326@intel.com>
Date: Wed, 23 Sep 2026 14:20:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
To: Matt Roper <matthew.d.roper@intel.com>
CC: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>
References: <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179014632773.19856.4107893493544612438@jlahtine-mobl>
 <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179018246485.152778.2589066724213973485@jlahtine-mobl>
 <6e40b68c-bbfa-47b6-81e9-5076738d0abd@intel.com>
 <20260923202952.GA730830@mdroper-desk1.amr.corp.intel.com>
Content-Language: en-US
From: "Yao, Jia" <jia.yao@intel.com>
In-Reply-To: <20260923202952.GA730830@mdroper-desk1.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To PH8PR11MB8040.namprd11.prod.outlook.com
 (2603:10b6:510:238::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8040:EE_|SA3PR11MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: d5490748-6372-46f2-be61-08df19b88c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|42112799006|376014|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: SEtXDvmKl3/D9Um7jhcNPcK356h2oE8P5MG5L7+VVJSGbGehn5o5utDUOEkEtQRtXMsWb+O0ao5JfpXhEmxCPlI84rAChu+ppq+XCl1fSyllaxkVsQJZRbMZvG7RiTqmibveL1wYFQysJNySKrrvNzm4uOWPebilzP2n6PHSG7nQDZX7dl+VBg0+LVhUJbUR5IeZQ9Il5iMLDraESOHoGFt/VTJIvcPb0QRjC8mIN4bTelC6OvBqIcaUDSJxvpjLtLzbE/YZj76oO7fLNOD/ssQl2lF77pUIyB521oJmfJI4UyxKRCKKSg9/2EEas2jd69JiukyPTOjLuYTaTYzpAIlk0RvKyKdxTAHviODL0jb3w8t9odyIofpAixqdCkbs4Ao0AFHOAxlCG+F0RHMRCoK1y3SCkTLi+TK6D//X5CDP2fUfZBiK7qNkuus9+TTYSY1iE2+WrAWckUF4DuLWQQ6i6vfT0B10Ne9KjjgkKNL1mHXOCnIhlDtuEG2j9C604bk1pSjDgqaWGGC88b2w+Mu6b2Sp/tG6kqoSyeERk9wnF3Aqn/v1TnEIXR3KJbZAekzzj1PDe5v1fF4rlYG5H+63+3sV1Qq/SBJXX0yAQKB3JTrNRqNsIbA08rqpxSdVcufbexOG13dRHn2vLJJCj1tEueT7HyJhNTCv+KYx1W0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(42112799006)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHc5M3FIWk9OVWdweVlnUlY2bUFRUFFqSm84Y1l1NDRNK3QvWUZZbHdYdjdW?=
 =?utf-8?B?Z01jZVBNenRVeS92aWRzY2tiaFBFY3dSTlhMYlpIR3QzeVBmM1IzbEZ5Q3Jr?=
 =?utf-8?B?dFdvUFVmaXJSY2k1aGVBWlcveEtUSGhheW03U0Q5RWRhb3dqUkdLYXY0U2J2?=
 =?utf-8?B?YUFoYWpoTmNzUEx4eXVpcHVmK2ZhcFBkVUxuQ041cXU3US9iMlJrL0Rkbno1?=
 =?utf-8?B?NGx1L0hwREZlVEJFeU15cmVydHppcWFUaS82RW1WVzFOb1AweXpmQklKQzlM?=
 =?utf-8?B?eDh1MWYvL2taZ1R2Yi9kYVg0Z0FCS0Nrakpleld0aUZNc1h6WUgxSEs4SXpp?=
 =?utf-8?B?NXBtNktwaEE4THowbzhoZW9XTkI0RkgvUE5QVGxadk43ZE4zTHFmeDc5Y3Za?=
 =?utf-8?B?OXNHRmFQOUpsM3RtY0ZlWGJjMkFDVGhyOVNLL0w3V2tXS2hVWXFONHMvV0sw?=
 =?utf-8?B?aGxyNEpaOWRlRTBHMzhlUCs0TjhLUmxnRVdxZ3Fndm1zdEx5dHYzc2xGMmsx?=
 =?utf-8?B?SVA4eDVDNElHTDlXVkN0aTI1MXR1T3U5MEt5cjA2TDVlb25xTWsyWDFIbUQ3?=
 =?utf-8?B?dFFiVmxmSHdmWDhlRW9HbUdnd3hBQmI2WDJmd0JBcHVhaFFXcGM0UG1JUm9a?=
 =?utf-8?B?SDJvS0pVQURvUWtvSHBuYng5RFRtVnJVWnZTVHpyUXE0OVJGMG5EUmVLbE56?=
 =?utf-8?B?aCtSZ1hZTmtoVEdOOTJMOFNnV3V1MThrK0RoVG9wOHNhVzZmQm1MckkzTzlk?=
 =?utf-8?B?WDB5N0w1WXNrckhqUzRoSG1kTXlRbm9HVXJaRjlzYkNlZzNOeXhSRnU3ZU96?=
 =?utf-8?B?aHR0YkRVa2VyUkEycjdPM3pTdVF2RGhxVk5WcUhHZHhaUDA0ZW1mdndpWk5K?=
 =?utf-8?B?cTZwQ0RrcEFjODNLd0pjeXovRDdidmk0WkJoME9iUzF4d3FLOEl6aWpLcmdL?=
 =?utf-8?B?bW1JNUNydGxPM0RIbUlHaVlNNnN0YlRzWnNjcnBKeHFsZlRia1ovOTE4TG53?=
 =?utf-8?B?QnYrY01xSzY3NGhWRHJqcWRMelZMcXVSZTJnckE3UXJuVkRDV212RHJwTXFT?=
 =?utf-8?B?d1h1Z01pUzdYZG4yS25ESWFWZUJYd2k1SzZpRFFxU3c3K25LRDNlams5SU9E?=
 =?utf-8?B?RnF5a3ZWSFg0eDRQNThoMEhqS0lFZGFva2JaWXFaazBxemtVbW00VjVlN0pr?=
 =?utf-8?B?OWVnSFN6RHFrdzFGbVVKNUVyQnUzQmV2M1RyYVd0dEdGZ3lkV0hEUzd1RkJM?=
 =?utf-8?B?UE92dStPSFBYdEJGOUpINjdQVVVvdlFKY2xGYWQxOGVpdm9tLzVQRjFNUW0x?=
 =?utf-8?B?eWRNLzF2c1EveW1tL3pGV0l5TWJmQWxDclVWQXoxeENRS044RjBlWWY2MjBF?=
 =?utf-8?B?a01kV1dtc3lSSkZiUkNBdHA2bytDZVgwVmVRTXBMODBRSHE4ZEZkbzg3RjFm?=
 =?utf-8?B?UzNVWk56dEVKWW1taHdNdzdzckdWMUVsNjJTVWR5cVcydFFDQXB6VVlMUkxw?=
 =?utf-8?B?akJKY3hHMEZEbHZPMElzRXErdE53dG4xS2RRbGxxOE5ta0VhZEd0MUErNlVz?=
 =?utf-8?B?Q05NU2FFODJwOHFralY1NkYxNUpHOW1TLzUxeDZGcytnUzl3M3R2V3ZGUC9U?=
 =?utf-8?B?c2hUNHNxWHpGQ3NOZEZKVitUUHNneHl3N0x2TURXS2FtblU0Nm93bUdHMmds?=
 =?utf-8?B?cXRQQU9CZ01TTUQyNm9VTFIvVnEzSkUvelZQMEM2bW85M1dodDZnSnoxVGI3?=
 =?utf-8?B?c1ZEdVd3K1FRVGJKN1VNRy9GN2srMG1wV3pscTU0cnE5SzRQODloZ0UrNzZP?=
 =?utf-8?B?eXgvcHo2b2ZMeHdkUTNCNjlscHA5N0todWJvdjl6bUlJZi85dlVXZG5EYzlw?=
 =?utf-8?B?akV0V0dxRkRBSWVYSWhvUjZMcXdiWjVTbFhiWFJlcit6L2dhandzeVdPaDIr?=
 =?utf-8?B?Z1dCUXZyNWtIbnBSU2h0U0lOQzZqaUdsU3kwc2ZYVXd3YytERTBPOVRLRlV4?=
 =?utf-8?B?SmZxMDNOaFkvYU1oYW0rRnVGMS9nVGdQT1E0T0JqeEt6d2d6WGlWVXFHVnJ6?=
 =?utf-8?B?SUFNeG9yaEYzV2IreTEraHNEOFVnOU1oVStDUVZ3U1piWURGN29YT2hjc2RC?=
 =?utf-8?B?UlAzT2pjQndya21ZbDVaOXZ2bFZuQ0hlQ2RQWWVIMkNSc2lNYXVDSTQ3VWVa?=
 =?utf-8?B?M2NzYlc0SU40ZFZmaTFYYktRdTFzSW8xNmtRR0FmTERGdThFNDFRL1dveHVp?=
 =?utf-8?B?eUdEaVdCOXNFK0Y3RCtLOElHd0lZaG1rdi9JaGsySU4rRjdlSDBmWHB0V0Ns?=
 =?utf-8?B?Rmxsa013amc4SWNwcnpDUEM4ZjdGeTExazdkVE5DT3BrT1BKZEtYdz09?=
X-Exchange-RoutingPolicyChecked: etqtyeyG62RJRMbx3XwPCM6JIov6FQCeDpi2OZk3RRcfzAn0X9pUdLHohUtGdvDJlqlG7LqsGBiYB3FBpgk5vH6NJLll3+UczevFZXW5faJTLjp7yust42Swg1EyGYrXXr87NBJcoLoQJzx7uAE0Y8U1uQbg1kv8BHwFg1U9W60KpfY/h3D6kRUjjrG/dlUKwSZ87Dupbyid7a2GMCz+g1QrTRfPxlZZfgF3BjLX8jEo9nLD7o1MJtZjdxNRVtWGsKleUnwBii3mr7e58XD7RICXaYtFYFREo+TTxMuicRuXWF1P1RsQCH3nB4YCJPYVgcSfsw0t+PsGoYnkZ3BXgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5490748-6372-46f2-be61-08df19b88c45
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:20:53.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxL4Mhom2zRvRCWlkqORAfP4tvCwzV5t474ABsr6a1/AJSJqx/4tihtKmMtOeMYfAggO/mmWaTx64Xefljz7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
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


On 9/23/2026 1:29 PM, Matt Roper wrote:
> On Wed, Sep 23, 2026 at 11:06:56AM -0700, Yao, Jia wrote:
>> On 9/23/2026 9:54 AM, Joonas Lahtinen wrote:
>>> Quoting Yao, Jia (2026-09-23 19:01:32)
>>>> Hi @Joonas Lahtinen,
>>>>
>>>> When shifting from WA option #2 to option #1,    removing a global setting ->   adding a per-context setting.  We thought it was a per-context operation.  However, due to the "weakest link" effect, this remains a global operation.
>>>> Thus, making it per-client has no effect either.  Containers will interfere with each other.
>>> They would not. On the impacted SKU, the RCS and CCS at any given time
>>> can only run workloads with matching address space. Those workloads must
>>> originate from the same DRM client as there is no address space sharing
>>> across DRM clients implemented in i915.
>>>
>>> It's only when multi-CCS SKU would need the same W/A, we would need
>>> further scheduling decision to ensure 2 CCS workloads are not competing
>>> for the global setting.
>>>
>>> With per DRM client enforcement, both RCS and CCS should be able to
>>> write the global setting without a conflict. And when a context from new
>>> DRM client is scheduled it, it should be able to program the global
>>> value to its liking as the same address space limitation guarantees the
>>> other workloads are not in the HW anymore.
>>>
>>> Regards, Joonas
>> I understand the benefit of address-space isolation.
>>
>> However, The bit 15 appears to be a global register rather than an
>> address-space-specific state.
> That's why we're doing the special dance with INDIRECT_CTX --- by
> re-writing the register on every context switch, we've somewhat turned a
> global register into a per-context register.
>
> If it were possible for two completely unrelated contexts to be running
> at the same time (e.g., one on RCS and one on CCS), then we'd wind up
> with a case where:
>
>   * LRC A switches in on engine X and sets the register the way it wants
>   * LRC B switches in on engine Y and changes the register to the other
>     setting, even though LRC A is still running in parallel
>
> But fortunately that's not possible on DG2-G11.  On that platform
> there's only a single CCS engine (so no possibility for conflicts
> between, for example, CCS0 and CCS1).  And there's also another
> workaround (implemented in the GuC's scheduler) that ensures that the
> RCS and CCS engines are only allowed to run concurrently for LRCs that
> have the same address space.  If you try to run two unrelated contexts
> at the same on the RCS and CCS, then they'll run sequentially rather
> than in parallel.
>
>
> Matt

I see. However, if the GuC scheduler already guarantees that workloads 
from different address spaces are serialized, why don't we use a per-VM 
(per-address-space) setting instead of a per-client one?

Thanks,

Jia

>
>> If the register itself is not address-space isolated,
>>
>> I'm struggling to see how address-space isolation alone resolves the
>> concern.
>>
>> Thanks,
>>
>> Jia
>>
>>>> Thanks,
>>>> Jia
>>>>> -----Original Message-----
>>>>> From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>>>> Sent: Tuesday, September 22, 2026 11:52 PM
>>>>> To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
>>>>> reviews@lists.linux.dev
>>>>> Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; Roper,
>>>>> Matthew D <matthew.d.roper@intel.com>; Tvrtko Ursulin
>>>>> <tursulin@ursulin.net>
>>>>> Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
>>>>> Wa_22013059131
>>>>>
>>>>> Quoting Yao, Jia (2026-09-22 17:34:08)
>>>>>> Hi @Joonas Lahtinen,
>>>>>>
>>>>>> For RCS -> UNSET
>>>>>> For CCS
>>>>>> 1. Old compute runtime -> UNSET
>>>>>> 2. New compute runtime -> USER
>>>>>>
>>>>>> If we take there's only one compute runtime version, and priority USER >
>>>>> UNSET?  Where's the conflict come from?
>>>>>
>>>>> See below.
>>>>>
>>>>>> But if we take there's more than one compute runtime version, and their
>>>>> priority is equal,  UNSET can cover USER,  USER can cover UNSET,  even with
>>>>> two clients they could cover each other.
>>>>>
>>>>> I didn't follow this part. How does the priority come into play?
>>>>>
>>>>> We have to keep switching the mode as the DRM clients come and go.
>>>>>
>>>>>> We should take it easy.
>>>>>> Once we reached USER, set by new compute, we should latch it, for the WA
>>>>> has been implemented by USER.
>>>>>
>>>>> That won't work. If you are running two different containers, you may have
>>>>> different compute runtime versions. Also, Mesa can be submitting to CCS too
>>>>> for async compute, AFAIK.
>>>>>
>>>>> To properly cover things, we should make it into per DRM-client setting and
>>>>> switch the mode accordingly when different DRM client is run.
>>>>>
>>>>> And for the given SKU with only one CCS, as explained earlier, it should be
>>>>> already guaranteed that two different DRM clients are not active on the
>>>>> hardware at the same time due to the address space mathing requirement
>>>>> between RCS and CCS.
>>>>>
>>>>> If this needs to be extended to multi CCS SKUs, then it'd be a bigger
>>>>> implementation effort.
>>>>>
>>>>> Regards, Joonas
>>>>>
>>>>>> Thanks,
>>>>>> Jia
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>>>>>> Sent: Monday, September 21, 2026 11:47 PM
>>>>>>> To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
>>>>>>> reviews@lists.linux.dev
>>>>>>> Cc: dri-devel@lists.freedesktop.org;
>>>>>>> intel-gfx@lists.freedesktop.org; Roper, Matthew D
>>>>>>> <matthew.d.roper@intel.com>; Tvrtko Ursulin <tursulin@ursulin.net>
>>>>>>> Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
>>>>>>> Wa_22013059131
>>>>>>>
>>>>>>> Quoting Yao, Jia (2026-09-21 20:33:03)
>>>>>>>> Hi @Lahtinen, Joonas,
>>>>>>>>
>>>>>>>> The key is LSC_CHICKEN_BIT_0 is a global register.
>>>>>>>>
>>>>>>>> Even we use per-client,  we should consider the following cases:
>>>>>>>>
>>>>>>>> 1. Should conflicting configurations within a client be rejected?
>>>>>>>> I recommend the first setting should be latched.
>>>>>>>   From uAPI perspective it would be simpler to set this at the DRM
>>>>>>> client level at once. However we don't seem to have such uAPI in
>>>>>>> active use currently (all
>>>>>>> drm_noop) so you'd have to compare the complexity between indirectly
>>>>>>> setting it at DRM client level by first created context or adding
>>>>>>> such an uAPI to set it explicitly per client.
>>>>>>>
>>>>>>>> 2. Should conflicting configurations across different clients be rejected?
>>>>>>>> I think the latter setting can cover previous one.
>>>>>>> DRM clients need to be indepenent from the driver perspective, we
>>>>>>> can't do that.
>>>>>>>
>>>>>>> The whole point of making it per DRM client is that given the
>>>>>>> impacted SKU only has 1 CCS engine. We have the address space
>>>>>>> matching requirement between CCS and RCS, so when both CCS and RCS
>>>>>>> are running, we know they belong to the same DRM client and thus
>>>>>>> they will not conflict with the WA mode. And if only one of them is
>>>>>>> running, there can be no conflict either as it's just one context.
>>>>>>>
>>>>>>>> Even like this, still can't cover all the race condition.
>>>>>>> Which race conditions do you think would remain? We definitely have
>>>>>>> to eliminate any race conditions to land this.
>>>>>>>
>>>>>>> Regards, Joonas
