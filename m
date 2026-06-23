Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39617CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4063410EC4B;
	Tue, 23 Jun 2026 18:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z2FxbtVX";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C9910EC4A;
 Tue, 23 Jun 2026 18:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXKrR57hUlfxc3oRWhuOgrmIn/IhuCbILOGAo4jW9WHvMi9c7nnZC3XQsHTltNbwxyQ86hC7AcUduGF2yD50Oix1uNsk8vXxRkwTy3dNEAqna5+4YNP8nxicrwoPOr0c/8+WxhdMaaYDNHqFLdk4wByEJmEvZk8bN9cfAGO8S2RTn0u30XFLeMFHK8k9rCiIy0aWsvESAJMQB7eZ1Gq4y7Orzvdw2my4H6hjuwKyBEKcrvbrRUiW4OVNf7ORexeksIce/2EmUNB1tWMn6lrTGFeCrEQaiA1MCy4PReU7I7m/SIXPDeoUL35sO7l+X+h3YaGv2/UPmcOgyujrs8TCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdMHL0YiAW9dyk2JKEVbBScsGdR02rBm94cBBkNZqgs=;
 b=edPZ/bSrWkEIYii7ksFr2nWnaNWQdNMxiasO4hhex3DsLtDKtt2VWuZezwdqHMo/UHzP50ytadYU4WMRVrYe7gUQXPmIhEcKL1NUn69R9XSMz9j0DPSbWGcBjbO+2l1vPGj2NK4KHEMXIQAjzcaCMW78n/KMJ84TyDmkt2sQwrKE1uZ0OHcV2ihqau4jXyVTXejxrZw0OIG6unfosc4ZIt2c88vpxcSNqfaJCXm1YkVTR/Mf5K6Lug1D/S1fl0g1lZBGaarlaLXtZGTjWoYXQ48SVluVsH1GvOO3a8yM/fDuPmqGFQV0zHIImlze0Z9zhF4SIcAidzpRmUlG81ti8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdMHL0YiAW9dyk2JKEVbBScsGdR02rBm94cBBkNZqgs=;
 b=z2FxbtVXDK2M5qKpwTHX5kd+PV4cBD2b+5utmT8ACq3f2TIfRv9ooornnjIs5gAE22bdfRdCmbKiagtvr3M3Egusi9k1XMwVKtmN7VjGEtAp1gexgF5m55pafiCiN1VZLNIXmEV1ZukHgRcr2aXYagUIO5FG1+KO9/nerdegGKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 18:46:44 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 18:46:43 +0000
Message-ID: <599664a9-f91d-453d-a76b-9698510f1a5f@amd.com>
Date: Tue, 23 Jun 2026 14:46:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] better LUT segmentation for EOTFs
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20260506191606.15022-1-mwen@igalia.com>
 <2a48f435-10d9-4e6e-8979-bfd61451a93e@igalia.com>
 <7934974e-adf1-4507-98ab-708095cce491@amd.com>
 <a6759f05-f372-4775-ae2f-e9af60ab89dc@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <a6759f05-f372-4775-ae2f-e9af60ab89dc@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 63677c61-0a86-419e-d6a8-08ded157c556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: v5gF4JwLdaA65enjQ/Jk5wO/MvPb/ajCqEvclMIIWpeK5f7aVgSxBdDjcQnxnPxNeNRf9WMDafHCecqI8l2614yS+qsRs+7bKHbalk7efUKG8l2fvy1PxkxXZEBhhP4H5n4s4HvlL7hDL5yP5bBJ0oUBpMj6ZNpUo5wy6lMa2tFTTbTIOhzTyIEdT2GrgO67ogsoy2sBjV+BSnWJf3UOyKEvM62oOiQMwPjlVLgf56yQYaUyeqG2GowUPvAfRRro4T27P49ioqQMLDvTJOv7KQkekLGoF/I0u1lvNsc+vYoYh7Hx7LSKTXM8gkq8BgtLJxwJd1t1zFNGYA+DjJGyvB3R9rrMQUmAA3qF/dTp39MqLCGaiop1o8VJIY+Qpd22JX7j8b2c3KCQ5itRHlneXMVBvUEFyIh/QpZi2pVDuEPJoSLGYjtxWvK+H5vvVUOWhtbXpbB6D8oeIM7U5LiQu4EGWhj+ewg2jiJDfPRzO15oYXQwqGf0ANTACuwyD2YVbFMglpUkU8ykDueORV18YF+MxQo+oa0SHYtmSRxR69vsTQ/Hom2exujXQOPA1Qw8Q8hr4CAoVUtfQ9Sp+w1u1hr90UnDVGP8cU+kZuqefZZ/XHquCOzPW/s+8hRXzzVC4nf1IitPOBJxXWgZQtmpmwOcjW034jhoauQEIfCkXew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEdPdlFKeEJHTnNsNko3eExPdGdQS1RDeU84M0NaNUNYTWN3V3I5bGZuNVBv?=
 =?utf-8?B?RzVSaVplM1VTQjAvRXgxVHFrR2xxcURYM3pObWxUejUrU204dlpNSmswN25z?=
 =?utf-8?B?L3ZxaXI4QkdSWUp0d2U0VWIvYWpZKzZNTDN4NWxuNWc2THQwN2EwTXpWUUhx?=
 =?utf-8?B?cmNQNDJBbnphZndqQjIrL1pUeE5FUk1XQkVMVzdHK1ArMHBqdGVpYUprRXZB?=
 =?utf-8?B?N09TUGZ3bjRibGFDZzJQaFRLN3JlMG1PV3NudFRMREhqcnpJT05pMmtUbUZN?=
 =?utf-8?B?Z1FnejhPRStyZWxFTVhNZEZFOTdXbnlEcXdWL0hQM3ZtZGNNVitXVHUwT3M2?=
 =?utf-8?B?dnR0RFJSTWlmTEtyWk1HT2MvaXJuVVhDQXZZL1B3ZVVKc01ReWNFaUUyRkkw?=
 =?utf-8?B?eG1VY1ovRnVsMkgxc0RNUWZxa1Vrc29wdXFMY2pLM3d5czdwY1VrOEZqODN3?=
 =?utf-8?B?a2pSRnNIZkx3NEptMVpySm5rRTcwNlRJSjhtTVhnVkZYWC91L21LMDdhTkZ2?=
 =?utf-8?B?L1VENUZ3eVE0WVdROUtsa2E2Z3dGOVBLM1k0YWV2NGRpblovckdWQlkyUDBD?=
 =?utf-8?B?ajROTGxPa01Vb1lIVkhNNTYrcmZiNjNPYWkwa292K2RnUVVNdXZqZkFKYkY1?=
 =?utf-8?B?WE95MEF0RkIyS0lNdUFoeDlMRk04SmJOenNkZThub2RHdUtoUWpxN2Jiek9r?=
 =?utf-8?B?L3lxcHhMVUdqV0ZKWENxOE52RTdPa3dPSW9DWjluUi9NOExOT1NpNDlJUnBr?=
 =?utf-8?B?UkFZUHJNbGphWmhITG9jOGhHRUxXWTRFUGM3aWxSeUxlOEp6aEVVOEtyVUlL?=
 =?utf-8?B?am16bXVJY3FZV2pqajFOVFNNRGxzN3puR1Z0dUNXUWhOTUNGR3RSVDRRUnZQ?=
 =?utf-8?B?TVdqb3hrWXdnaHZoTzRtd1pVMUc5bmN5ZHJTMUFZU01KNGlCbUgxWW5Xc3d3?=
 =?utf-8?B?cXd3UE5DNlVOL2lMT1FDS2MvV0lma2psc2tzb3hybFNUL1pnanNieUV5S0p0?=
 =?utf-8?B?SjFwdkM4bEhWdUpyQnJsTUh3UXdqbno2Z0N0dkdWUmFuam51cVE2MzFpcmhF?=
 =?utf-8?B?VGFLTkkvY3JEcG94RnRtSjZhTGpxbGNMcWtZam5jaEpMRWJLOG9yNUJiRWFY?=
 =?utf-8?B?cG9VU2puc0VFS3ZaWTgxMEpaQ0haUTJsUlova0x3dWx3VVA4b21iODNxWHNo?=
 =?utf-8?B?WVZrUEZUTnFOeUU0RUNpcTgyWXVSTFZJQXY4ck1ZZG1kUGJQQ0lGNWdQV3FL?=
 =?utf-8?B?VG14U1NLbWdDNkhQdVIyQ1NTdUU4TmZ2OFpuSDNVU0V4Q2cvM2RrS1RNWldt?=
 =?utf-8?B?NDBIMWNKU2VYbjNWUEI2cXQzbC9Cb3JqSEVlbzY5UVdudnhLN002eVhZaVpH?=
 =?utf-8?B?ZnF2VVVJaUZQTU52Rlc5d2xaRFAxZGRwNEprdlBINUFnMEx2YnAvKzdHMk1j?=
 =?utf-8?B?VVJqT05Da1ZPejAva2JmRFhrK1NHUk5UbDZMbHhJem5oLzY4T2RjQndIMkE4?=
 =?utf-8?B?VzNxL2haVEYyN0s3ak54Ull1emdKT2tQL3J2QW9VQWY4REJ4eSt5Q1lFQU5J?=
 =?utf-8?B?ODlTa1YrSjRmbHZXSGpxQXNrWWFieXc4UWdSV3ZuSDRTUHd2VlVhSW90V204?=
 =?utf-8?B?Ukh6YmRNU2NIRHJQMTJxNExQaDEzWlFHS01ONUhpbEx1TWpGTUNyM0lDNy9S?=
 =?utf-8?B?K1RQTit5NWxsRGxTNkxKYXZFaXhsV1J5WHFpbFFFU1k4UHM3bkZjK05yRis4?=
 =?utf-8?B?dmkvTVNxRVl2dHNEODVwMk05TSsxdjBpdWNwL2tYZDdVeko4NlQ4UWJCNU1j?=
 =?utf-8?B?VVdDYlV2cFVZSkZTUzQ1NjhuU0ZiSmpvM3IxYWNYRGVkQ3lDUWNZNHJESis2?=
 =?utf-8?B?NGVSUUcyVlVSdG5wREpLSFM4T3RwYUNmTnBiZ1dMNVF1ZzMwOHBWeWFLc3FY?=
 =?utf-8?B?VmJhbFlTYTZkbW5YSmtDYVh6NlBHa1RLSmJXUWhvYkN2YVFHYWNuOG94eVIx?=
 =?utf-8?B?VFpadXo0eTQ0cDIrcUJ2OFQvbHI1Z3R1aC9PRjFJRTRpaVFRSXdERG02cmlq?=
 =?utf-8?B?dHVBRmFwb1lkOEwrUFJFWkVTa0FYVDF2eWttaldCSjJUSWJFTlc0WkE1REdu?=
 =?utf-8?B?VGtEdUkxUDNqR1lwT05zNGwrQWF3UytIOE5KYzRzdkVkQXNqVFFRc213Y002?=
 =?utf-8?B?KzdPcERZajEvODdxMWl6Zm4vVko1dDdjb2d6WUptYTh2SjFCOFErNDFNSkps?=
 =?utf-8?B?NDJHZ2FTelNzTW9nLzNKV0tmUndtVlZQekN4MTZ1SWNZeTdLNGtKQ1Nwb0dh?=
 =?utf-8?B?Z3hoTlE2K3dXNmJIeGpkK25JTmhmNGVldmdxcVhrUHp3c0hTQ09KZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63677c61-0a86-419e-d6a8-08ded157c556
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:46:43.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkn/06o1+T38/mBtrjijG0H+nsm3Qc5tIzmAh8JCupyMo/8ksyEbggsj6BScePm4HtcG+EFKan+X3sklAccG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

On 2026-06-19 06:54, Melissa Wen wrote:
> 
> 
> On 31/05/2026 19:15, Harry Wentland wrote:
>> On 2026-05-21 10:50, Melissa Wen wrote:
>>>
>>>
>>> On 06/05/2026 21:11, Melissa Wen wrote:
>>>> Hi,
>>>>
>>>> With an external HDR monitor, we can see gradient banding around the sun
>>>> in the intro of Ori and the Will of the Wisps game on steamOS/Gamescope.
>>>> Gamescope uses AMD predefined transfer functions for degamma,
>>>> shaper/pre-3D-LUT and blend/post-3D-LUT plus CRTC regamma, however, only
>>>> degamma block has hardware curves. Shaper, blend, regamma predefined TFs
>>>> are software-computed by AMD color module into PWL LUTs. In addition, we
>>>> cannot use hardware curves on PRE_DEGAM with subsampled format, so that,
>>>> predefined TFs are also translated to LUTs in this situation, using
>>>> GAMCOR block instead. For this translation, the driver originally used
>>>> the same helper for EOTFs and inverse EOTFs, even though they differ in
>>>> input domain, number of regions and number of TF points per region.
>>>
>>> Hello,
>>>
>>> Can someone review this series - and merge it, if everything is okay?
>>>
>>
>> Series is
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Hey Harry,
> 
> Thanks for reviewing.
> Was this series applied to AMD's branch?
> 

Queued th v3 for merge. Should make it in by tomorrow after going through our CI.

Harry

> Melissa
> 
>>
>> Harry
>>
>>> Thanks,
>>>
>>> Melissa
>>>
>>>>
>>>> Baring this in mind, patch 1 maps degamma predefined curves as LUT using
>>>> GAMCOR block for AMD driver-specific property that are still in use by
>>>> current gamescope. This was inspired by a similar patch from Harry for
>>>> colorop [1]. Patch 2 reverts commit 8b89acc0b2ba ("drm/amd/display:
>>>> Remove unused cm3_helper_translate_curve_to_degamma_hw_format") to
>>>> reintroduce cm3_helper_translate_curve_to_degamma_hw_format() and patch
>>>> 3 wire it up for encoded -> linear-light LUTs (degamma/blend). With 16
>>>> samples per region across 12 regions for blend LUT (where hardware
>>>> fixed-function curves are not available and predefined TFs are
>>>> software-computed into LUTs), banding becomes almost imperceptible.
>>>>
>>>> Patch 4 and 5 increase precision in the brightest half, where PQ/SRGB
>>>> EOTFs are steeper, by enabling up to 256 samples per region and halving
>>>> the per-region point count across 9 regions (128 in [0.5, 1], 64 in
>>>> [0.25, 0.5], …). This better matches the shape of PQ/SRGB EOTFs.
>>>> Although patches 4 and 5 seem conceptually correct to me, I couldn't see
>>>> clear improvement in the bright end with or without them.
>>>>
>>>> This series targets DCN3+ hw families. With this series:
>>>> - degamma and blend LUTs use
>>>>    cm3_helper_translate_curve_to_degamma_hw_format(): encoded input,
>>>>    non-zero end slope, up to 256 points linearly interpolated between
>>>>    adjacent TF pts, fitting [0,1] encoded input range.
>>>> - shaper and regamma LUTs continue using
>>>>    cm3_helper_translate_curve_to_hw_format(): linear-light input, zero
>>>>    end slope, 16 points per region across 32 regions.
>>>>
>>>> [1] https://lore.kernel.org/dri-devel/20260330153451.99472-8- harry.wentland@amd.com/
>>>>
>>>> [v1] https://lore.kernel.org/dri-devel/20260414220237.184289-1- mwen@igalia.com/
>>>> Changes:
>>>> - new patch for GAMCOR usage in case of degamma predefined TF with subsampled formats
>>>> - fix misleading information regarding degamma hw curves (Kruno)
>>>> - clarify LUT segmentation choice using 8-bit sRGB as a reference (Kruno)
>>>>
>>>> Best Regards,
>>>>
>>>> Melissa
>>>>
>>>> Melissa Wen (5):
>>>>    drm/amd/display: use GAMCOR for degamma private props in subsampled
>>>>      format
>>>>    Revert "drm/amd/display: Remove unused
>>>>      cm3_helper_translate_curve_to_degamma_hw_format"
>>>>    drm/amd/display: use a separate helper to translate degamma curves
>>>>    drm/amd/display: support up to 256 samples per region in degamma/blend
>>>>      LUT
>>>>    drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT
>>>>
>>>>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  16 +-
>>>>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 184 ++++++++++++++++++
>>>>   .../display/dc/dwb/dcn30/dcn30_cm_common.h    |   4 +
>>>>   .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  10 +-
>>>>   4 files changed, 204 insertions(+), 10 deletions(-)
>>>>
>>>
>>
> 

