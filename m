Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E025C98307
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A926A10E864;
	Wed, 23 Sep 2026 08:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bkAGS5/T";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E615710E7A2;
 Wed, 23 Sep 2026 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790152775; x=1821688775;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uz1OQUzl4MvqVHjsp45Hu5QYIheXxt0cRWaSi8YtNEI=;
 b=bkAGS5/TPAMl9vbPiIwlAEA/Sw3E6jk+VyNizm3TtJ7rNO16lCKogsts
 36Ly+nD2nkviNIvOYGIBuxoP5bEyWDpmI9kc/bfcGOtn423GFpZAorLTn
 KrhF71RjWsPPtIygm6YSdBEOKuk2BJqXv7xODjc+ysveChuMNEj7AQiht
 a29c9/gIZGd7xqnQpz273M/HFEhan/DPQZfnjXWogr8ANvigOZidHdet1
 qvWgGqdAB1SxQXZU1VBSZQgQ+dNtm2P/KUBFKovYE8ZyOeHNnLE7gYUNR
 cocjoYAAX+LWpGvUduzvgEypPRqnjkxYCeTA9ZniXZE9oVvNm+4Coj/tQ w==;
X-CSE-ConnectionGUID: KON1etQpSJOw46masu3OPw==
X-CSE-MsgGUID: K941xurJS4y6CUkeyF9JRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1317691"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1317691"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 01:39:35 -0700
X-CSE-ConnectionGUID: JIm1BUHvRueUK/6UDRo8Hg==
X-CSE-MsgGUID: BKv2jqpwQD+IBjU7SX78Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="273689512"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 01:39:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:39:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 01:39:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL+tIyJN9t4UjpeVOxXk3qqX/CPrnP3EEna4Z0B3RhADRDZk2oBIT3Fgkx1zdgQ6KIePaYftPCrzU5mBJyt1LMTRmhmmPz+WFxYr0Vv1En3HnLa7UYRrqV7zL5inVxurvk63MZuy3Qpd9iiy7kZ2J3F1lpYckPF3dYoVNJr5L1q2S9wxR+VVLPnmsfWx96EuqnY2KRP0998BRd+gq3XTUbS5miXlppc6V2k7+CqU9IVr0LGi+7K09xTLVeII/GchOIhq8Lp2fldDzTsPKTbrkeJeMMOpMx7XNhGO/Y0ZW/CejYjCQUQaZwQ63Tj13I3/m3IqFrzkEopBxshFqiS3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/rsNJSrDCwY1o+O4qsteRBOcp+LWxeavG6s/SmfX64=;
 b=N0Z4AnDc/fQ1Yd4ECrBas0RsruWSpOiF1Wn/CdDp3XrR3D9WwG+XjigByaxcNGUuREjxGR09z2/B1n/Rvo048ugsuLDAZD/4DV0+lKJ8kfceQPggKb+Wc+0xxpshkhXg+VgR7gn56Tl6+gavQrJvhiW+OHrbLugCm/hjJkOxh8DroYzNEtCxTEfhRuz+wQBdd2qplrwpWNQk02ubGozK2ofL4r8fO36OWrKdk440iS0vP8tQZXSwbEMLvIuBrIOM/nGitBB13rV+Wx2jgczgpHb70YLiLRNnQVjFGcmyVHhD3Lnj4PCqsYNNnN9VOSR+MVMCkUMuG9l5WUDLZUYreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:39:31 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::942f:90a0:fade:3848]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::942f:90a0:fade:3848%4]) with mapi id 15.21.0406.007; Wed, 23 Sep 2026
 08:39:31 +0000
Message-ID: <48830e07-7399-4d26-9130-06dcaebb3c94@intel.com>
Date: Wed, 23 Sep 2026 14:09:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/pagemap: Drop ratelimiting from dev_unhold_work debug
 trace
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
References: <20260921062648.1166903-2-varun.gupta@intel.com>
 <20260921063310.89D4D1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Gupta, Varun" <varun.gupta@intel.com>
In-Reply-To: <20260921063310.89D4D1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::17) To BL1PR11MB5366.namprd11.prod.outlook.com
 (2603:10b6:208:31c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5366:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d7c86a-9ce9-40e0-3a96-08df194e3018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AUWNrgIgas/3zUQ1FTaUeWhdYDtJ8KS/Hhr9ab8LfTW5LsT/jTP+Ex5ivaElIyBvepzoRXXccaKGhnfa63Jvfo1nZQf0BHyAxVr/q3PhhbCR5ARrPWKzB+yUEgfGeS9FEny9NUX9X4XlLHLvEuaCiNn6H/9/ybcPmaVRCByGzBTO7UiCHnXApBgEPL9cx7YJKO4NSfDr3bNVD0zHFXs3j9XvNTRQCZBiyWvZcv7mWrFHWxrV80w1s9zTh8SiYqHwF88G1Ap2HQ+WELYK97ctbwJo0+o16e/kYTJ9WXJaInw6nR22fQRToJM7xAuifMOSpQMPLTpV1pbm/SWyaRtCVwSwF87rqlMa3wdPhYJQIgEJZvtYjq18EhPaCOMSGCOUn++D8I3ZpodXSw7+08T6WfiEdvb/XqGFYYgmPy8cTQdYDDUGVJJ/Sj/V6TtXgJO+TV0UH74Cl1lflE+tLhmZpOiQETwDUDYCZFON0fyi4C5n0xDe90GxQxQnsoHvKLNlfW9nuch4xRhHK99Rij/Qz8FTe+anNlCxGiai4ZkeUlgHGBmx2GyW2elanP22nvNEseIoKeZvXIm5assyFWP4bKLnSYZycn8V8LTtfRV/U3GQEhRDbsRaP4aHxVpCrzDdo25KHlvIwYPwZE3h4EUHTYPVkQiwU0hSsiRZPpYuOno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUw2VXI4aE0xWFZ5Q3IycFgxYVgzNy9pL0NBbmV4cnJUNmlGR05zR0F4NDhN?=
 =?utf-8?B?a1VLUWJqQmZDd1FHYllmVWZMT3BmOUZ4cHVkRVk2M0hBYmIvbFd4S1VKeDNu?=
 =?utf-8?B?M2lRUGJOK25WZkxmTjlWdnJXWUxsdkZWN1VDMkk0S3BEdnh4RmJDMlpsUmM2?=
 =?utf-8?B?UkZ6aG8rNXBmc3RFQ0MvV2ZIUlNkQVhYSXBpd3E3bGY1eW1LMkZESCtVbHA4?=
 =?utf-8?B?RVcrTmp6TVB2Umpra0JqRWFPMkJEOTBka2FFMi9SYWswL0FYMklaUHplV0xt?=
 =?utf-8?B?VmtidDV5VXlQcnA2bU9zcE1iM21FVWZnNjJ3N0JsazJtY3RuRE85WjhBMnBT?=
 =?utf-8?B?QW5QSGtnMG5XcWZId3d6M2hyYWZsMDB4NThvVVIzbmR6TE1yTHVyQ0FVS05U?=
 =?utf-8?B?RkhPWjBVa0QrZTNIdVlwcnhhaDZiSUl6QnJGcXErWjZJOWRPRWZnenQ0dis4?=
 =?utf-8?B?ZzR5THFIMm5GY3RBck1GOWdQUjRaRWFlQ3k2emJqQTQ4NExlNFBsZHY4NDho?=
 =?utf-8?B?SGpxWE9GWFYrSENOYU9rUjlrWjFKZFFLVnpCcTJacnFsWCt1WDdJcXlIVTdm?=
 =?utf-8?B?cDhIMjFHTjVhS0RvaThQTlR1WnIzN0VLUE5zUmlranNOZWZMUXZybFlrVlpF?=
 =?utf-8?B?NjhuOEI0Nlo4OURvbUxlamdnWHprb1hFbzI1ano2QzA2NHZHSVdMdVlYODhm?=
 =?utf-8?B?TjQwUGtSemdJN3VBVkVoWjN2QVVYOXlzL05mM3pKMW5uL1RhZjR5dXhNUnBl?=
 =?utf-8?B?YVNTS21ndkZ6WHR0cWJwYTFKb0JOUFAxWTlUY2Zwb1NQZjZzeTFPd0tmU2RY?=
 =?utf-8?B?VHhLb1phalVUMkZGR1A3SXlndzR4THhBQ3VtTFNGYWhQc1RMRkZjR1hXY3k0?=
 =?utf-8?B?ZHRRaTl4YmNIWk5UdzE0bEdPckYwRnkrRTJkUmlLWjV5SXdmTi8vRVNIN0dU?=
 =?utf-8?B?cWJyTWxmc29FSWtPaVl6ZGlWMG5ZMmxsU0EzcDFPMFpCbTlvMkRmNG9HcW5C?=
 =?utf-8?B?VXEyaEsrNmF1TzhhUEdYR3N2emdGNmQwS0NQdVlwV3VXOVNXSTc2b1hoZHZy?=
 =?utf-8?B?ejY3ZXk4YVk4bmhqRnFrbldoREFKc0JWVVBBb0dGU29SVFo4Zy91em1pdkVQ?=
 =?utf-8?B?aEhIWUdIUnlsaFJJa2VMV1pNYTlCRFMycnpuSGxrWUpIcHNmOU81SzJGR3pI?=
 =?utf-8?B?RWYydTVNZUJhMzZ2RlZiTG8yQllPSmlBcEYxRG1ZdEFZaXJkS2VEOTc3VStu?=
 =?utf-8?B?VHhmWDlMWXdqSUt0aWZGQXJ5YTdLY3hPZkUveFd6RTlhS3NpWWpuZ3lSSkZa?=
 =?utf-8?B?REZLMEtvWFRtVzBVakdRUWNLT01ySEdDZnNHZFM3TTRDQUhJUGpjQkowK2Ez?=
 =?utf-8?B?T0w1Vkh4SWpjYXVMOEpobEtub2RkZmJaZmdmeGZzMlMvcTd1UU80U1dqVnNj?=
 =?utf-8?B?b2tiUVFmQXlGRzV2Q2Q1TEtQci9DdlJocTZkMGdyd2lWcW04OWdZaThiUEJ3?=
 =?utf-8?B?bGtkdW14NUpKVHRiN0hDZnU3VzRIUytwd2lQWGowOEpTMGhlblJ2MjVlRWw1?=
 =?utf-8?B?VDc5aHVaWVA5V3I1SGVLZDZVVmpyQmFtdXcyWVRaYkxLTEx6MzdGUWUrL1RM?=
 =?utf-8?B?eitZNitrbTZRVkdxbkRrSnpUZU1mQ3VKOFFwSWNnNENPZ3daNjExSVVrb3E3?=
 =?utf-8?B?OW1tczBJRnoxV3Y0K3VuektyY2lFS2FJb1YxQjF0Tm5pTm1wZXQ0OFMxVHVZ?=
 =?utf-8?B?VDUrRHBWYjdVRmFGY0FUN0FsMVhVbUdpTVd5ek1Xdnk3K1RtbFBiN1JwS0tG?=
 =?utf-8?B?a1VqMWp0VGJLbWpwZVE3ZjZqYW5KVmFZTTAyTm15RW1XMSt4TXByNEQxT0o3?=
 =?utf-8?B?aytKRy9PZmo5SkNDL29KZHQ1bUdWMzFYaTN1S0tKUG9NK1M4VzFscG85cW1E?=
 =?utf-8?B?QkVCWnpmYkRFeUVsU2l5cnNBSDZqVHZwWi9Gd2ZrSnZlTWVFNStmQVJxSnlV?=
 =?utf-8?B?bjVXdmxqY0M5eGMwbThCUFd1UEFPU1MwKyt1ZmNXL1lXRGN3WmcvZjRQOXpO?=
 =?utf-8?B?NzdpbmppU3hlMUdUNlBKRUZhcEN5ZDV2VE5nSldJODV5VXl4bDhCcGdmK0ZK?=
 =?utf-8?B?R3hJN0xCVTlQdlg5SVQyUnJ4N1NDSjV2cEJTZllKU3NoK2ZibldXSkhQTm5X?=
 =?utf-8?B?MUVkNXQvVG9wQVU2NTNzNUNySm1xT2s4c1crdlVyWmR0V3R1M3U5T0FEVXVy?=
 =?utf-8?B?OUd4MUF4M2lKWnRyRXJVQmNJTTl5SkFHcE91MFVjL213bHpWOEZDSFRuQXU5?=
 =?utf-8?B?SndGUnBjRE0rK2lMUGVaaWJqeGpXUDJ4aEttdlM3dXR1ampEVXFUUT09?=
X-Exchange-RoutingPolicyChecked: zWfPc3Vn5Al/Hw7vuTNL9kY5NO2SMcpRvYPlyhpNqBuy4VhUE+sLVIHZmgZartVON7oKaCH2qxSinuIPVPv4X9g5TaJ4GYqiqGoFPn19Yf6EvlQASL/Mj4z6eXDGhBwHLsFIis3NagorQIU2XSDnfozucZmdtLHMXz56J5Y5gKmJDHJ/1vfJW8EXivaQ9+kpiOrRCLcpIGuVCupdYJotKCTJO5IhSVBg/ReYUGNJ/gVp1PzKBsX+QmClKCS65kZieE865Jp+BX1aMF9dTIBxhiZPPlLll0DU8IXioe/zKvQuWzg1ADX/DJR0aTTj7u30Hb36oMisWhUZq+ntXgQQqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d7c86a-9ce9-40e0-3a96-08df194e3018
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:39:31.8614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hV65xbVNMat0NNvPFEw01HgvAebBc+RMWVLebQkVn/hkMxh5cjVSA6pXgXG3WlfBxjKrbFgub+3WruFkzILjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
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


On 21-Sep-26 12:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] drm/pagemap: CPU stall re-introduced by unbounded drm_dbg() loop
> --
>
> commit ea1ff5e58f9772cc1eaec3db21133d24e24bd4f0
> Author: Varun Gupta <varun.gupta@intel.com>
>
> drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace
>
> This commit reverts the use of drm_dbg_ratelimited back to drm_dbg in
> drm_pagemap_dev_unhold_work to avoid "callbacks suppressed" notifications
> from the kernel's ratelimiting subsystem.
>
>> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
>> index c66c58f85c345..743988036a5f8 100644
>> --- a/drivers/gpu/drm/drm_pagemap.c
>> +++ b/drivers/gpu/drm/drm_pagemap.c
>> @@ -1102,7 +1102,7 @@ static void drm_pagemap_dev_unhold_work(struct work_struct *work)
>>   		struct drm_device *drm = dev_hold->drm;
>>   		struct module *module = drm->driver->fops->owner;
>>   
>> -		drm_dbg_ratelimited(drm, "Releasing reference on provider device and module.\n");
>> +		drm_dbg(drm, "Releasing reference on provider device and module.\n");
> [Severity: Medium]
> Does this code re-introduce a serial console bottleneck and potential CPU stall
> during teardown?
This does not introduce a stall, it is handled by the WQ_UNBOUND change. 
This log was ratelimited to
just prevent log flooding but it in turn introduces a suppressed warning.
> When tearing down an unbounded number of DRM pagemaps,
> drm_pagemap_dev_unhold_work() iterates over the entire
> drm_pagemap_unhold_list. If DRM debugging is enabled, drm_dbg() is now
> called for every single entry unconditionally.
>
> If the goal is to prevent the "callbacks suppressed" warning from the
> ratelimiting subsystem, would it be better to drop the repetitive log
> entirely, or perhaps log once outside the loop, rather than reverting
> the CPU stall fix?
>
>>   		drm_dev_put(drm);
>>   		module_put(module);
>>   		kfree(dev_hold);
