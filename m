Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A068C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D2F10E2AD;
	Wed, 16 Sep 2026 09:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m2ENwf4X";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D9810E0C1;
 Wed, 16 Sep 2026 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789551754; x=1821087754;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1dew7JADKQrCKHs4+6dE6yRhjJDqKQzMfscWOjWaKc0=;
 b=m2ENwf4XHMbKd6fHW1yyWUyTTKFIGSQca0lMgOODBK/uFvF1vfotqlFD
 jBiA1s0ePRuWDXsl5YaOd3wNRPTkYe9WIjhWEg03XC4o65ZUgh99iB57J
 Z5I7Pc4F9mnG7WOCdQDb8qkqPEMEpg5DXGLgGHIf/bfuhRVPO8WJyvKdu
 gdq2JE2vg7bheVW+BrApErs6YBOj1iLdvzQAPAt7dMDqY58c5fflYaeIM
 blWgimwkS6GOWT+OCXQdYsu8ehGXhqaqtsTBbe7p5ZYHvpf6q28a8sybz
 PQun0cpP7AI4sBKtBZB+lXPIUpcmgTDsevng43XNJMvJ5BB37pAvFsTMK A==;
X-CSE-ConnectionGUID: cpb3mLXSRVCicbVGD0SPtg==
X-CSE-MsgGUID: BU2u2lkUQl+49pKHzaTV6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100521850"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100521850"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:42:34 -0700
X-CSE-ConnectionGUID: 1jvMzvNbTWijagL1htEuWg==
X-CSE-MsgGUID: siKWi2YLTmGeCeWv0wg5UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276818451"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:42:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:42:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 02:42:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZCUUbEbTfOUZNWMo9d9SCp0tnCikM3IsRv6+Fo5bfCqYmToK1mloA6J68C/uE3dNN5UGLg6ytFPh2fOFKph0vLLlZpjVb6Y7cw21VphoMUnd6bhkrovZA1MwX4U/fN6xC5T5SXGOWfkuWxhi0dAGDpxSZReKRsdbc1sbllbyl4a+OBx4SGRwEE8UU70+Hn9ymISUNqqC5nGwyWhYWC59eEQNEUGkXQjs4UrL1iQfujzAa+8iYU404e1Tnwjtc+HgduC5RFYLpFt4fujU+htUsNq8+cy+81/VA0IajWHP8TpLe4mP61U4XFAAi2hp7blebxoevNgkfQkKSBt7l3Vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc1rGR8iqADeu6XKZh3dvsDG+h53ez5oPfaw5U5s5Kw=;
 b=IYWFBFX/ajzc2mdp92TR2RtEchD/RyYdaNbQHMtZTjg2mGD9FRyhIS0xQbTXIyO3Umq4ep0Gr/87kNWVZj7yNaqyinEVvU3/mBzEnhLG9YKvqmCXWtzbrALbiPvGn9UK+x6JVerPcWgGlfzAdTmK5QMPRzRIvp5ScmIlYx7aTVJkU5HaaAAprZsAjTtbE9vDQ6auMGgJdcrNDg2ztXNDeddxwLkd9IHLpJcvhwRmn3sBXaZ5akqFriyLHU4Wxx+JP0Km4RObQJbre0l1lGVA2zENP9J7n9qihaBMlrrEptjjSwc3vXrOTnU6GJxipJ8CXOWnQyk94gAKA5kCu+wZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by PH9PR11MB681838.namprd11.prod.outlook.com (2603:10b6:510:419::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:42:29 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 09:42:29 +0000
Message-ID: <50260a2d-a529-4f42-ab37-b48d9d015d54@intel.com>
Date: Wed, 16 Sep 2026 15:12:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 0/9] drm/i915/color: Enable SDR plane color pipeline
To: <intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>, Simon Ser
 <contact@emersion.fr>, Alex Hung <alex.hung@amd.com>, Daniel Stone
 <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>, "Maarten
 Lankhorst" <maarten.lankhorst@intel.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>, Pranay Samala <pranay.samala@intel.com>,
 Swati Sharma <swati2.sharma@intel.com>, Naveen Kumar
 <naveen1.kumar@intel.com>, Robert Mader <robert.mader@collabora.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0357.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::6) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|PH9PR11MB681838:EE_
X-MS-Office365-Filtering-Correlation-Id: 701b573b-421c-474b-0e24-08df13d6d30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|11063799006|5023799004|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EPgnipEP21ujCiHKOS8QmkE6UfsJGOhsaINOIwKzID3uv1bzFNznimTvMKhMnA24hmMzas+nvK2RhzKmLmntZv5WMnrS/OiBvJ+aw7tS0JM/4iTbfy7AjnLPXMpdEoFYhzUN5sQ/4U6tje1AFE4gC3fPikxtVYwK5nCpxHQ1FMobCAcAfBLTgLenyGJ/ZWsb+mQa1ObY0CjcDeCM5un81z2D8JdG57aiM1FceMqzK2ZQdxT3Un9X4/Y35gdE9hwS95yfVEWw6a24f0d6104/fcJA27uUNX+LI+BgLNG+1I7lh27TtqtlKa4dfXK6yt0+3wqN5fGYm3BBFN5gGULT7aal3Zi2LneYTErvAHaLvMlFl4r5XPmRamU/bGnWzcT67CQ35nIzwif8l1mSNCr6cOzsXzWQSqT4bHyfpX2S7ERDjksSn7JbM0cCZpMCT9MBqF2exVGVRLkc4XYw1Z3to2toK4GQ11+La8n5S4E729hzWhK4XMXmt7q/x2vJh35PMxcg5jpqK4l2HJSMG8iKkt2LeT5L5nMxWfe/k1jiBaocUk1VaPcrgYCEmxlhXxggOW/J7ig1v4tozJiG15aUZSjiJ7ZHPtWpCiAaue4yg8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmN1QitnTjNENi9EdkpuZ0d4ZmRGR01tRjd5c3d3YitFcmRnK1R4eVNyQnVR?=
 =?utf-8?B?Q1lqeWlvZGszQTEzckdUYXVZOXJXcTlBQmpXMjV5VEZka05sbU42d3VSYldk?=
 =?utf-8?B?cmJkaGxYb3lUWjQvYkNzUFFoWExHdVF4anVLUUlxYkd4SSsyZkhKSTRWVmJj?=
 =?utf-8?B?T1FhTXhIUjY3UHpGR2dEWHcwdGphQjVXN3RJNmFjQkJEbjBwT2VtbXlmMkha?=
 =?utf-8?B?L0t0ZWZjUkFvSWRGTG01dWluVW10WWhLekplUklsbGJqZ3REdlVpajlianBK?=
 =?utf-8?B?QXMwbmRGbFJsb3VadHR6TFB5VkwzYmVmaklqbVJ6Nmc3ajdFRkFURTNTWjl6?=
 =?utf-8?B?RGVnR0tCMUxqR0tBSXNXQzExRVVkS3pSbUZwVWdjY0FXQUpFVTRNNGsvYlRj?=
 =?utf-8?B?djM2S2hNOERpdWY2UFMwL29nSXkwWk12VjlrQm8xd3o0RVlPOEpyWjgrOVJt?=
 =?utf-8?B?VXJ2NGdsT1U1UkttUHhjaEYxb3FOZDVySG1sRGFPQVAza043RjFmaklpLzBp?=
 =?utf-8?B?NmNCRDUxUk5NTXJYbzg0YXBCL1BCTjdrTGZQMENwM3VVT2tKOGNrUTJZR01j?=
 =?utf-8?B?VzNoczFqbm9Ic1hCYnI5OXZBWWdoWGdJZWJTcjBhZU8vUnoxeGJvUnZxRzlV?=
 =?utf-8?B?dEtoZVU2dVJIN0NqSjZzS2JSMnJGcTFqMElGQUczNUxjcXhIWHo4MHUyYlM4?=
 =?utf-8?B?L1F4cUhheCswTnoySHNVcC9KaUtzZkthaWhPS0pzQ1Z3cVlEV0VRZHNKR1hy?=
 =?utf-8?B?cVRxSEYya01FVXk3enA4bCtHRnZLN21Mb09iaU5UaENvbEtzY2VkVlZiSTJ0?=
 =?utf-8?B?eGpKMHVqZjBmM3dsWGRUNUVxeDU2cnB2WkZTREthM0pERWFwa1pORmdQYkJv?=
 =?utf-8?B?UHg0WWR3bUliV3g3Z0lSeEwwRDNJUWV6NHdOaWpMMmRiYVhRU1lLS3pGNGJD?=
 =?utf-8?B?ZldHTS9rRXdwQWhrdkxLbzB3YWNtUUliYk1HUG1CdldyWVFtM2hzTUE0Viti?=
 =?utf-8?B?VDRoZDl2M2pBZjBsRUZBbkpaNU9aZTFIMGFTUVQyaEF3YzBKU20yQjg0Y0M2?=
 =?utf-8?B?d0VhUGFMajJ2YnpmUURudVh2azE3QUlmckV3aEJWcCsybFJyNlhhSFQvd003?=
 =?utf-8?B?eG9mKzU4ZWdkQSs0K29vSnhSeUtvakR1WW5ROWNZOXE5SEh3NzZBTHErUVVi?=
 =?utf-8?B?QU9KTkt3QlFaRVlCQjVoUGo4blVjUDJXV1Y1cVpkb0JDUjQ1WHpKd2NTV1J2?=
 =?utf-8?B?V3RHSzlkSXVjZ2NaaWZJM2JtL2Z6amJJNnQ0UmVxMHY2QXZaNU0zanpmMGN3?=
 =?utf-8?B?NDJsNXBYcFlqU2JOMndHY2F2bHF1S0dTaUNQWDdxSlRTWlY5WjVzbEdCdzlF?=
 =?utf-8?B?U1luWmZiMUtjVE5PSmZsWTdhMW1ybGorbWl5WCttS2hIU2kvNnFodE5obURQ?=
 =?utf-8?B?Z1Z2cThvL1Vwd2dVUm5mUmF1eGpNZUxBUGgwQVpPREV2WVZaMTlMeXZHTWNM?=
 =?utf-8?B?enNBQStrU3A1Z1NDa2I2c29qalg4T1BkY3pBN05IUGxjdVJhdmFkbm4rUzhV?=
 =?utf-8?B?QkxCa2VNLzdGb2k0YzhPb0hyYVNIQVBSN092YWxHZ2luTkpxRExrV1JJT0N6?=
 =?utf-8?B?ZkUvTE54QytONlN5NmNLWUZLRWkvbk1Sd2M4MWNIM25TbmZWNGM4Y1pTTDJS?=
 =?utf-8?B?Tjc0dVBPUmEwZ3JPMGdnY1VTMlZxblFTZW1waU1tZmhEZjZNWVpEcDVlTTB6?=
 =?utf-8?B?K2o4amR5M3hoMHhJUEVqTkhCSnRjV0E0bkhJdXh2bkE0cFhuSldZN1FPRENE?=
 =?utf-8?B?aVY3ZUppMnRjSnVNMGJsS0ZRdHlpaGdvMU0wRW0xZW5jbGUveGNuNkdiUWlI?=
 =?utf-8?B?NlVEZk5NazlJWXdnUnJ0UGVrVjc3TUZ2eGhJMlIxWFRFVStJVUJ5cmpwdXlM?=
 =?utf-8?B?MjhRRHdzU2VwODFrVVZDSS9ZeHV6dU1SdUtCZkpxdVBHMVJGTUo3UEVSQ1BU?=
 =?utf-8?B?eDhkVWtRMHdoaUtZTjFGUVE2ODV1b1NUc2ZsUDBJNmIwVURPQm9DQ3g3dmVp?=
 =?utf-8?B?MWhFdHBxWHh4czJuNi9LLzR3YzlDQmhQelhBRzFIa3ZoNk0zT2ovbVZzQkZV?=
 =?utf-8?B?UUJXWmd3Nk5oa1JHMEhTU3hYTS93a0JyMC9kUlJSRW1pU2lCRElLdmNNZzk0?=
 =?utf-8?B?dkRNMFEyNXdSaXRicjlENmVxdldodG9TbmNkUnYyWEM5V1JueS9oa2pQWGlr?=
 =?utf-8?B?bUNlUnp3YXN4NEt5WDhVVWtuaDIxbVROUm9CRDhXTW8yTFpobDJPd1dtQU9m?=
 =?utf-8?B?TnVzS1BuRHcrbG43Q0RLMGp1c2dVUnlkR2VrQXY1YTJBUHR4djhrUzY2bGF1?=
 =?utf-8?Q?ohf/7ooyUKmJLixk=3D?=
X-Exchange-RoutingPolicyChecked: wwUuxCdoGsokP2pWGjuKtDlIiblNBWueU+Ic1rSED848jcgVAQgdm6DN9B8nKdEvASlf/wgav1GygaUCeAyO9/lshWc5GaJOlbsIwS1/0EYJiZr64ZsD1z23wl8WUq7fFWfb+JTfNU30syCVpY6IYXGo8bp/FmchcmYXcMYaYnqAYDydJc7uE5sq0EEB9eN7WNsFJJI5vKIJyr0M8oocLfw98X6pyikVpbNqnOeIXEvKbG0L+H0tFA1T58G3UCUN6ALHjgqXL3ahdNigx45b+5AFvzuugGZ0GVpoieNEMNOUjXrumNeSZK3C5iz8BbUXbO/gv+ZJ2N4HJbh2+NcyeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 701b573b-421c-474b-0e24-08df13d6d30a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:42:29.7579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUQPs50BofsZ3koYeN+X0bGMN6/cuqMDPcyij4Z1o6/4vZgJErGcclbOPm3DurSSaWsPnTWcnmeolpyO+cJB7x+UMbIgKpSQepLEim9cDXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB681838
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



On 8/4/2026 6:00 PM, Chaitanya Kumar Borah wrote:
> This series adds color pipeline support for SDR planes in i915 and
> exposes the functionality to userspace through the DRM colorop
> framework.
> 
> In contrast to HDR planes, SDR planes have LUTs with smaller sizes
> and a fixed function CSC block in contrast to a programmable CTM.
> 
> The series first introduces a new DRM colorop type,
> DRM_COLOROP_FIXED_MATRIX, which represents fixed-function CSC blocks where
> userspace selects predefined hardware conversion modes instead of
> programming arbitrary matrices. It also adds the YUV correction HW block.
> With this the color pipeline can accept both limited range and full range
> YUV framebuffers.
> 
> With that, the SDR plane color pipeline looks like.
> 
> [YUV Range Correct] -> [1D LUT] -> [CSC] -> [1D LUT]

Thank you for the reviews, pushed to drm-intel-next.

> 
> v2:
>   - Naming changes [Pekka]
>   - Adds YUV color range correct block
> 
> v3:
>   - Fix NC matrix enum name and string [Melissa]
>   - Extract and simplify glk_plane_color_ctl_input_csc into
>     helpers (new prep patches)
>   - Restructure SDR pre/post-CSC LUT loops to match HDR function
>     pattern
>   - Drop HDR pre-CSC LUT clamping fix (submitted separately)
>   - Rebase
> 
> v4:
>   - For CI
>   - Rebase
> 
> v5:
> - Do not skip programming legacy property if color pipeline is not set.
>    Support for YUV buffers in color pipeline uAPI is a work in progress.
>    Therefore, color-pipeline-aware userspace might still use the legacy
>    COLOR_RANGE and COLOR_ENCODING property while keeping the color
>    pipeline to Bypass. Therefore, skip programming based on legacy
>    properties only when a color pipeline is set.
> 
> v6:
> - Drop YCbCr limited-to-full and RGB709-to-RGB2020 matrices
>    until there is a non-IGT userspace implementation. [Robert]
> - Drop pre-CSC LUT and YUV range correct blocks from the
>    pipeline in favor of a simpler [CSC] -> [1D LUT] pipeline.
>    The Fixed Matrix CSC handles both full and limited range
>    YCbCr conversions internally.
> 
> 
> IGT series (needs update): https://patchwork.freedesktop.org/series/165021/
> A rough updated IGT implementation with some additional test can be found here.
> https://github.com/ckborah/igt-sandbox/tree/color/sdr-sw-ref
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@intel.com>
> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> Cc: Pranay Samala <pranay.samala@intel.com>
> Cc: Swati Sharma <swati2.sharma@intel.com>
> Cc: Naveen Kumar <naveen1.kumar@intel.com>
> Cc: Robert Mader <robert.mader@collabora.com>
> 
> Chaitanya Kumar Borah (7):
>    drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
>    drm/i915/color: Add CSC on SDR plane color pipeline
>    drm/i915/display: extract glk_plane_color_ctl_input_csc helper
>    drm/i915/display: simplify glk_plane_color_ctl_input_csc
>    drm/i915/display: Program CSC on SDR planes based on Fixed Matrix
>      Colorop
>    drm/i915/color: Add support for 1D LUT in SDR planes
>    drm/i915/color: Add color pipeline support for SDR planes
> 
> Pranay Samala (2):
>    drm/i915/color: Extract HDR post-CSC LUT programming to helper
>      function
>    drm/i915/color: Program Plane Post CSC registers for SDR planes
> 
>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>   drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
>   drivers/gpu/drm/i915/display/intel_color.c    |  76 ++++++++---
>   .../drm/i915/display/intel_color_pipeline.c   |  30 ++++-
>   .../drm/i915/display/intel_display_limits.h   |   1 +
>   .../drm/i915/display/intel_display_types.h    |   1 +
>   drivers/gpu/drm/i915/display/intel_plane.c    |  53 +++++++-
>   .../drm/i915/display/skl_universal_plane.c    |  42 +++---
>   include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
>   include/uapi/drm/drm_mode.h                   |  12 ++
>   11 files changed, 420 insertions(+), 40 deletions(-)
> 

