Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC16ECD6E57
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 17:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D50F10E6EB;
	Sun, 31 May 2026 17:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klw+bb9h";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBB210E4C3;
 Sun, 31 May 2026 17:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxzqDS4be3lvw/mvKdl5iNZsu9lBUNoWB5vX0MVvQNbl43XllsTf1AwX9mJmxWV+aNoJNqulq916DyuBEm9U7w0SZVFSvpZoUNQ8Bb0OojNwAE3fuvGC8Boz+kybfuDbdpYufYDCmd+0Bj6MIYPwczreAWSI8CUTjXq9FMz2ETugHz3TLi2Sv56f9k5dLEiL4SyPq90iBlBsDBOUmYAK1nC6jgGor7+nFmzXx/+ZIg2I7cz6KGGWFk7PPja5CYm1m1/Il0QpfZ3LIxwuv70xYSS3dsx8Iz+7wVocfKU9RmdzUKJTd3B4FxlxhFDhJfLt2cNc8oPsBx+AY5a51KX3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAGoNt1gzRdz1TlTw7JlyEaLP1GSNOkKXxngtkwkg5Y=;
 b=J5k6DddAj5odVUW2ulhFNov7ZfJ8HazPjf3K2wizZucbbtOSR8qiu7VN1BGfQI3/6TPVlSr7rBSqAGjK4tVqd3Kvk5MnS/NrcDm/0vj58cpZXq+jPlY8T+IJabUgeY7w13knvEygBX4UaK9hrMTB9UJNIDRQpTes9nPA3hdRFqH4jD5mjrpu7P+jyHXKgTYbhnBBKsczRgRO/9mpIitzX/B9Pc3TqYhVxj1wa9Vl1CMMtphiA0MiE4UhuV2gly/aLXJAfsG/OVAsczH3taWyV2/54NFDC9G+RvBX2LJGXA4m2OWdj1pR29MazTJu27a35aW9M7Wd6lVcMfrBIAnuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAGoNt1gzRdz1TlTw7JlyEaLP1GSNOkKXxngtkwkg5Y=;
 b=klw+bb9hhNNDp8U9d6YjNiwFcqO6s+ozyJtSy4nz1mfPfkuPBPc3awTPgKMoFdn1ofh5PhSzmveLzKXdMIaAR34fEbTmJJmMEmYNnpGWxHE/HioApr+XrFJ7nYeQ3PzGzgY4ydTioKyRqMoal4qbpfSfzygjxOvORc+EsEKpcqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Sun, 31 May
 2026 17:15:24 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 17:15:23 +0000
Message-ID: <7934974e-adf1-4507-98ab-708095cce491@amd.com>
Date: Sun, 31 May 2026 13:15:13 -0400
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
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <2a48f435-10d9-4e6e-8979-bfd61451a93e@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::13) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7841499d-fa44-4f60-2de3-08debf383368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: istCGwK1nCPoYVZohECx5HP67T8k1YJllbmSdIuxMWtfS7kyHCSVgevTacx8ME1NxhFRziP8O0NUzIfYEnSWHLFELv6Q/qgp0mHwqNPqN87JdlSTNJLIbeHutODfKCY8snK6P6f/pST6qXY/vB0riZWuYlimXwWfv6J4nR3iCwAlb443K2mv7+Nd/GrFpoF3/Y9YiZxbQWOlSyZxoHq4PSRqj0vw4cO2FOOtWOeazzmOTdJrYQ/WPtLijMnpPn6LKs4vfbrRXrsniPQGiVxruIuLy8T2LmHxYjQMNx+rzOhCk7nI7zG3u3PSpf2/uFuM54YdGlGwek70iZmC/2/rB4Z1sBzNzGEirkNiozMZnnFbV1Eeh2QY+tr2gEMlBlazuwufVyGLVAHI72qehB3Y9mOuyCCo6VaAg50rPh6Po7zgrNx4W6fQyQ9NN2fMlbzoIq3JhKWf4Ah6LzRemSrjRE9Xhtz7P/SnBsKL84DyOHJOvx4NDD93RzYezwL+v8RLM8HSJzM4VbZwMN3wjRHZEwKdHNs6Ik68z0joi3DyEHnymw8PzToLkQCMbOeGgzM3rtqqTp0vMkHI+mni0cU66B6pcS0eWOjbgYMY48uPshPLGnRPzLvyxHkDjMJSp1iXpzZKHmVUnYx10D5TmAitZ/8Xc9fu9H/JAacRX5x6CdTOz77v6JwLznYLopTIrjKF8HUhD4vUzcJj/XbH4MoWsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFQT2pxZ2xpZm4zR21nQ09sZnFQUnQ1V0dnRjdxU2FoTlZGRTF1SnloQ1hP?=
 =?utf-8?B?KzNQcW1RMmJmWXRzWkptTkhPNmRPMGJhRzF2MXBZaDBKenRkMWdibjViZkpS?=
 =?utf-8?B?K3FhTHplM2dOTkdKSEd3bm5nK3JRS2dmTUVMeWdhcTFLdDlUZi9FWWpSaFo5?=
 =?utf-8?B?MU1qYnE1dmpmM0RKSU93bmxTUUlXeUtWMlJlL1NYNUtKZ3Uvd3J2aFNFMnVk?=
 =?utf-8?B?RlNTNjRBVjR3Yit4eTZsZG1rekEzSk9DS2l6eEl1Q2VMbEh4VmxNTlVRZlFx?=
 =?utf-8?B?dnZ5N1dCbCtnZEVUcGJyT1JHcS9GdjRYZHZ4Wi81a25nZmplV2Z5U0NNRlI2?=
 =?utf-8?B?QXordlFCbXYvZWxQVHpjVk9SdUpvQk41WGtoM0RKbHR3VzJjZjdaNERXYXRL?=
 =?utf-8?B?dzFzamlZNnZKWllzazNyNW1DT1RQR3JBRExkU1RLUEVJWWdLMUdYTjY1TC9O?=
 =?utf-8?B?SDQxSXNMTTJZQ21wQXJGbHRnVHpRNEFtNmdKQU50UkN6M09EQ1c4N0NGbFhm?=
 =?utf-8?B?dlpFeDN3SGtmSkV0Z3ZyMHltUk9YTGttRWtxZGRSdWRFcFQ0cXJxLzY3NThU?=
 =?utf-8?B?aW5kTXJZNmhjcHY2eE5IS01uMFZQWHV4RXU5WGkydmVURE1ST3QwOC9PUGxp?=
 =?utf-8?B?NXdHcW9mUDZpWE9BeTRWOEZKeVE5TklZa20vM0J3R3VoZ1NDT2N1RytsSElh?=
 =?utf-8?B?SXh2bkFkdkN0WVR3NEpOOGtSRnlTNlE2aFNEajlWRkgxM2hCakllM0lDOFFS?=
 =?utf-8?B?dk5vbFdsT3ZGSDBQK3EyMm41SHpHVzNrRElWamtmK2NwTE5XeXVEVWtpNXdv?=
 =?utf-8?B?aVVhZzJEbHNRZnBGZDlCMnJQWENIQzJOV245N3lSa2Y2ck5qaFhqL1IzWi8z?=
 =?utf-8?B?cW1lTFFxZ21IbkdOTzZERWtYU1M2ZEUza21zOG41M0VMb0F6MnFQSk0zSXVK?=
 =?utf-8?B?Z09JblJFb2NJYzRsdm8zKzRvTklhUWhsdk9taXJMVVRvVDRYanR2YjNlb1ZW?=
 =?utf-8?B?b2VDYXAvT3JnWnc3K0tHeXcyUTUxSHkxcWViZ05HSWtielJQTklpc0xwaWlY?=
 =?utf-8?B?WUNqU0VvOUpwWGpOZDR5UXdCalBVb2N4d1A0RER3RFZ0Y2hIN2ZTclVEeDhh?=
 =?utf-8?B?ckFCYWN4dU9zQlUxSjRTNnc4Mis4dHB2TExHVzBqSFMvaG9GMWc2T3dNd1RU?=
 =?utf-8?B?dGE0andZbytRSzRIdHphdzR0cFlRODJkYUNsdU1ZQTBUZ0tlREg5MWszaWZD?=
 =?utf-8?B?MGsrVE9sUDloT09rOWE2cXhpSTJtNlhvejJTWUh2SHZzU1hHNWJ5NUF6N1BU?=
 =?utf-8?B?Y1JwYWw0dWdjTXRzeHE3K0R4L1NZTllMM2RYOVJieitia1lFdGpGSjdVL2J2?=
 =?utf-8?B?OUVqSFpwL011V21JVGQrMWc2WnlRMnZMVlZRbnZ6YXoza0pTdURnbVFITDVN?=
 =?utf-8?B?YWRYVlptNFJ6NXZXQWxJWElTdWp0Wlp3M1ZMaTJYSDErN1lnekpDbUUwWmkr?=
 =?utf-8?B?Y1VOams0UFo1L3EraWdWWHloQUpkMmc5UW1zU05QN3hqc0cvTGUvSUg5T01W?=
 =?utf-8?B?N3pLRmxSVWNubHRocEpOaVQzNmhsRzNPT3F1SjAxYjdtTkZhU3VqYjdYb2c5?=
 =?utf-8?B?RFpLL3FhMkxHQjZOQzA2MGRyTmVKVEdtc0hZbStESGVSMFFJZTcwSUFzOEpG?=
 =?utf-8?B?WC9Zc01CRTMvUVpxaFNiUTZQYzJmSnRsZ1NRdS9aT1J0Q2xIR1ZKMGxtYVgr?=
 =?utf-8?B?clAwWSt4QXhZeW5Qc3NZKytUTklueU5PUzIyc0I0RnRzaUlwZDNTd2Rua0w0?=
 =?utf-8?B?blJNWUYvUDdzUlVibjFtY3ZHNTRVZ0ZDc0Y5SWhVSWtKSnQ3d0JsbWlxZUxa?=
 =?utf-8?B?MXNpTjRzVXBYcHVNS0phdVVqOW91YXY3dVNUQUo4U3dPcGtVVEdEWlJ0WlVP?=
 =?utf-8?B?USs1RlNHdmsxSmkxd2tBVC9rS3FuK2JvZklEb0hyNnp6cXN0SFEwczBKcG1M?=
 =?utf-8?B?bUtpUHpwUFl6d29HVGlyZGVhcUlvMmlmVXJDSVBFTVFHTStwdzdsL1dla3h2?=
 =?utf-8?B?aXlKSmRaN2ZaWGRCd1VjcnNvb3pIMllZaSs3MmpJa3dkNktMcEpMRCtrTUhF?=
 =?utf-8?B?bTBpc0Y3Y0k4K1N2WHU4dG9YemNKZ3NydGlYem9WYmNJY3dXZzJhQnNjTE44?=
 =?utf-8?B?R3VIdjczSitIUmxnWmdXcVVMMDVwUWdGM2V6cFdhZ0REWkdQOE9yekFZZnEw?=
 =?utf-8?B?UlFZcnhTTVZWcGNpUHVYQWI3R2ZKeVJSTDNla1B6UWIzYVo0S1JTR2RsamRR?=
 =?utf-8?B?R3ZaTnNuaGZQUkhiSDhVYjFYY1lWdTZGRUZ1VHpEcjQ4allrTU5vUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7841499d-fa44-4f60-2de3-08debf383368
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 17:15:23.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtLbad0snrY7Kt/JnQEQuGGkt2D/YDhuX226FCyMAW0tH22Yl1hRfat608fCEX1kMgUhW/uiVPdIuytTLv7YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

On 2026-05-21 10:50, Melissa Wen wrote:
> 
> 
> On 06/05/2026 21:11, Melissa Wen wrote:
>> Hi,
>>
>> With an external HDR monitor, we can see gradient banding around the sun
>> in the intro of Ori and the Will of the Wisps game on steamOS/Gamescope.
>> Gamescope uses AMD predefined transfer functions for degamma,
>> shaper/pre-3D-LUT and blend/post-3D-LUT plus CRTC regamma, however, only
>> degamma block has hardware curves. Shaper, blend, regamma predefined TFs
>> are software-computed by AMD color module into PWL LUTs. In addition, we
>> cannot use hardware curves on PRE_DEGAM with subsampled format, so that,
>> predefined TFs are also translated to LUTs in this situation, using
>> GAMCOR block instead. For this translation, the driver originally used
>> the same helper for EOTFs and inverse EOTFs, even though they differ in
>> input domain, number of regions and number of TF points per region.
> 
> Hello,
> 
> Can someone review this series - and merge it, if everything is okay?
> 

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Thanks,
> 
> Melissa
> 
>>
>> Baring this in mind, patch 1 maps degamma predefined curves as LUT using
>> GAMCOR block for AMD driver-specific property that are still in use by
>> current gamescope. This was inspired by a similar patch from Harry for
>> colorop [1]. Patch 2 reverts commit 8b89acc0b2ba ("drm/amd/display:
>> Remove unused cm3_helper_translate_curve_to_degamma_hw_format") to
>> reintroduce cm3_helper_translate_curve_to_degamma_hw_format() and patch
>> 3 wire it up for encoded -> linear-light LUTs (degamma/blend). With 16
>> samples per region across 12 regions for blend LUT (where hardware
>> fixed-function curves are not available and predefined TFs are
>> software-computed into LUTs), banding becomes almost imperceptible.
>>
>> Patch 4 and 5 increase precision in the brightest half, where PQ/SRGB
>> EOTFs are steeper, by enabling up to 256 samples per region and halving
>> the per-region point count across 9 regions (128 in [0.5, 1], 64 in
>> [0.25, 0.5], …). This better matches the shape of PQ/SRGB EOTFs.
>> Although patches 4 and 5 seem conceptually correct to me, I couldn't see
>> clear improvement in the bright end with or without them.
>>
>> This series targets DCN3+ hw families. With this series:
>> - degamma and blend LUTs use
>>    cm3_helper_translate_curve_to_degamma_hw_format(): encoded input,
>>    non-zero end slope, up to 256 points linearly interpolated between
>>    adjacent TF pts, fitting [0,1] encoded input range.
>> - shaper and regamma LUTs continue using
>>    cm3_helper_translate_curve_to_hw_format(): linear-light input, zero
>>    end slope, 16 points per region across 32 regions.
>>
>> [1] https://lore.kernel.org/dri-devel/20260330153451.99472-8- 
>> harry.wentland@amd.com/
>>
>> [v1] https://lore.kernel.org/dri-devel/20260414220237.184289-1- 
>> mwen@igalia.com/
>> Changes:
>> - new patch for GAMCOR usage in case of degamma predefined TF with 
>> subsampled formats
>> - fix misleading information regarding degamma hw curves (Kruno)
>> - clarify LUT segmentation choice using 8-bit sRGB as a reference (Kruno)
>>
>> Best Regards,
>>
>> Melissa
>>
>> Melissa Wen (5):
>>    drm/amd/display: use GAMCOR for degamma private props in subsampled
>>      format
>>    Revert "drm/amd/display: Remove unused
>>      cm3_helper_translate_curve_to_degamma_hw_format"
>>    drm/amd/display: use a separate helper to translate degamma curves
>>    drm/amd/display: support up to 256 samples per region in degamma/blend
>>      LUT
>>    drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT
>>
>>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  16 +-
>>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 184 ++++++++++++++++++
>>   .../display/dc/dwb/dcn30/dcn30_cm_common.h    |   4 +
>>   .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  10 +-
>>   4 files changed, 204 insertions(+), 10 deletions(-)
>>
> 

