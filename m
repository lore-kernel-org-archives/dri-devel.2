Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2558C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F9F10F016;
	Wed, 15 Jul 2026 12:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKM/ZYii";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5E710F001;
 Wed, 15 Jul 2026 12:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApyvqHfAobTa984KFn+gIM7Vl68Sb3r+3AuYyEzihy0vPWu0wTn3klFv5ZVEo04upVx1KR66LBAuwHGyNpToTS2KUIozQ0nWHrDA1gRHxxyV9XCDp9K3x7FL7bPxXSs4+xKPWEr/vAA3t1W2Unp6hNEwLPeheZXFblAiEI+I2A5E4VF1JS7FXGcHRRrXyFtu0npBBDTqwgXh4OQWpTrUXMd8m7YyA5qFO0rtckBjeYxbvAm32WAnoWBJe/GGUtV6Qwn5ELl3re7zKQJ93jJDfKfsmBTbkXBqKE2fTc5wKqhm4poN4pOVP34Hjq/DYk+uMB+0DzoR856/Py2Ws4Lw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZQLQp3hBE6zs3n+xvMCr2woCYj1t9i+pLqvZzQMjWo=;
 b=PSXbjgKE2J5oLS1EmxQ9Cs4jDK7QFWCYRDTeiLh8pp8s0uzNFPfW++EcGpQBo9qQ8z9I3gOgcMxMAlT7bu3RjJXznzbtGqg8ZlXZbQRCNO6jkGVpwmxDM/GayJPDgxvz7ggR1tArQ00pcRNsRLYot+mclDxKkTI46gsX2Yp/zq6Fsw0t7V9O7CZLeFPx3XY8Y0GqeQGZhBSgNjOyPn6D2Nehul3wyPps7NkvOkHOZ173RTK804cy7fb/cITMQPHWLYs9kW2zemW0LpudpFqyGAxRWxGTua0mVYuKcB6TQIiuensi7yqHg62Q4QlYv1/CvrTsYoHmB3vRdEfbjwKa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZQLQp3hBE6zs3n+xvMCr2woCYj1t9i+pLqvZzQMjWo=;
 b=HKM/ZYiiKtCCz8PqdLS1eCkWRPLXQqF5ZDZAj9N89IRnOU8oT5ZP5qu0pR7m5lZV0UrXYRkgQ7mu6aOqnrprqNw2uCIgBxj/QWggY+/OXuar8La+0Mkv03k28MCgGVbXyt3oWbjGR0uQWiq+b/CspvETs1Z2jE/jcUtr0OSTCys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 12:11:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 12:11:28 +0000
Message-ID: <57f36bfd-0419-478f-a104-f044022bdc3a@amd.com>
Date: Wed, 15 Jul 2026 14:11:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifiers for AMD GFX6-8
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Dieter@nuetzel-hh.de
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260715105757.13125-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 432f20ab-96dc-495d-99f4-08dee26a32c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|3023799007|6133799003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dWuX5j09vH/gNkG7V5GXA4LM3a6s1C+5+x6Lg7dg4Tl8hAy0pPna9Bet08i6EuByFrcSPv69ItPkwH11tnMiLkU905nr8eC8Fxxfj1KoJuU+7fbkPvRUXGdXDKbdWYPVoq7K0kAWdT5ww4xOAKQD0gOTv6QnsdX4r5G5aPM8ga0IZKKjPNfKVAc8dSM1MaqNVMSOEBfIDoLiZRbJHXcc+6zXYRFu+HyxIopsfakYVMWKlC0hpCdd5Rx+nXQJDDpzbEugmDJBO1qvNiCxU3O/llCpXmfvaFIc5s7zQPCtG9zJlj2iALmoHgx40JrqiPL17THXOrsWxHoCov3VRZai83j3/6B4daA+HwkTZHeE5330msQAWhmDV+nMZB+iaAMiBmxojmmKcZJwuxb5J7zP0/LLqW7WEXW5O8aGwp8OvR46DGHHnHMcKYdlQkvRuHqBcYpeEh5FTf7fIu/ynuOBvZ4IFW3yS6GgidI+pZjTiCGFObRzHsqEqV9XZHewT7PWhT/5Lp2825wraxrFYtrl0WLYko+ytwjeMTiYm6l4hxsafW+hrLSnJQmFrZlVrZQoXYG7DvgctMyYGnqHTn0JbV8Z0aVr+17H4UNldP1lJBwx4TI7lAF6tEiLWJuj0XqCzxHbbG0kovf1K1z8km2jMKz4GCjmEG7Q4ErL2SrSh44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG5sbWUxQkNIbEpHak10YnNxQnJMRFREZU9iTXIrUGFqQTV6OUxXMjFlTzVq?=
 =?utf-8?B?N0JqVWZucUR3ZXNMMkxlS2svVlpLNVQwbDNUUFduV05UZTJQQkY2K3l2QStP?=
 =?utf-8?B?cXJST3dVaEl3T3FXUWRTQkg4SjhOYmVvc1lUZDVYSXQyTXZhNFBjQkpsOFBZ?=
 =?utf-8?B?dC9YQ0tDaWc4Y2gyTG01TnJFNlBOdXZCNnpTdFQrSFB1ZVllYlZ1aGFrYm5j?=
 =?utf-8?B?RmZEWGtPLy9VS0wxN25NbUFVVURqQ1BxMkh6RlAzYzBKOEZGc3kyYzNla3lX?=
 =?utf-8?B?M0NwZVZ0c3FkMEc1MGQ2NTdTYkhwY2RNNG56bFNYd0ZWWFl2OWZFV1RiWjNt?=
 =?utf-8?B?VWJOUk5rRURhaDBwbUZaQ1JvVUtwSzNZRE5wUU14Q2MwcWEvRkQwWm5mbDRs?=
 =?utf-8?B?VGVWaXRyYzBrM3A3ZEFyVEZEaEM2d3BkeURkVG8vYmVSM0Q1UnpURDlXYXkz?=
 =?utf-8?B?S3pTUEc1L1RLMG01ZVFFdVVYNVJwRFdDdW5MbFJrZEM4U2UvZ1RKVEdmY293?=
 =?utf-8?B?R3hyNHFZbUhQSk10MWZ5YmFDeUlKMWFraVF2d1lxYzFUcjFNN1ZodEx6SUty?=
 =?utf-8?B?R00zaFNkenZjK1ZoUmJXN3FOMVJKa1dWYTFFR09rNkplWDU2amQzTVBBK012?=
 =?utf-8?B?SWlyVXFiQVJ1UnpjMk5RU3U2V2J2RjRqcFBPc0g3SDdHV01WVmdBYnVEWmVt?=
 =?utf-8?B?cXBtOE5NdlNDUEpoTEJRNTBIVHVVSTlpL2wxbHJLdHpmZUV3YUQzUDZQcjlI?=
 =?utf-8?B?YlhuUUtORW9hKzlveHZGZ0JBeWxoeTFjeFFJZi9YdWxvMmpnWVNNMlMxQXYx?=
 =?utf-8?B?eFNoVHlTUFJHMEFXMDZIaWc2RkFmTDk4U2pOek5NRnBrR0tZRzdlajAwZEtv?=
 =?utf-8?B?RmcrQXN6VXI2SElFZC9JRWdVYlQ1bVNlejZXdjdmNm5YMmZkdWR4WjI0bkxZ?=
 =?utf-8?B?dFNIZHpOSE9icHhPSWdmaWhzaWJpb0x4alowQ2VlckFxaXBjam8vUVdQMXps?=
 =?utf-8?B?MW41VlBGZUZ4KzkrYVBZY2FaUW0zelpsWFVNNmxlUVRTT0ZVR1RzMGJyMWoz?=
 =?utf-8?B?TkhDZ0hCbFFhbFlNdjRyNUQvYnhkdThHUXZGWnRaTmczMHROL3VuMXJZcEVT?=
 =?utf-8?B?VEgzUUF0THU3dXNadERxRW5uZVhVNTR1cm93WmQ5WHRQTVJXUitETldsQ3FE?=
 =?utf-8?B?WFBlSzBrUzd4NjI5OTZiR1BjYis3TTU4aWZuajdJaEZSZDlEeGZJakV0amt5?=
 =?utf-8?B?c1ZxaElscHRobDNXSDdsejF3VXVMdjQzeDMwNHkrMHE5RlNxdFcyNmt2T2NR?=
 =?utf-8?B?OHZUZnJEeTJlRHk0aVVYNnUyZlo1elh1UEVudTNHUFRTT0NEQnFmRXhuZ1gr?=
 =?utf-8?B?NFM5RXUyLzhTWEJDOHM0UWgycmUyNENYRG9SNkxCdkhvQWx6OVNGUUdPVWd2?=
 =?utf-8?B?cVlUWFRVM0tuOG1TYWVTRXBxUmJvTzFCTFl2b2oxK1JFYW9va0NndEZIZVJX?=
 =?utf-8?B?ai9INGFRcWk1OWovbkxKZ3g4VUxtamVrNzRtRUtxOWZaeUU0WWo0MnZjQzZs?=
 =?utf-8?B?VzUzL2xyWXA4NC8rcEQxSmMxblRpNkdDQUN1dmtCN0cyOWxPZ3I3dnI1ZEpa?=
 =?utf-8?B?dXQ2WHF2QUZWRC8wY25MM29sMHgxVnJzUEFHQysrekIrWTBOOWNEUlYxMGMw?=
 =?utf-8?B?cURWQWNySjQzK3MzektMSUMvaU9LZ3dQNDFYNXNQOTVCeVFnRk1XZ202TE1q?=
 =?utf-8?B?YnFCSnNsRVU2a3NKMWVUamtsS1c1UlJMeVRES09zY2lNa3BsemFReERFOHdR?=
 =?utf-8?B?Z202QTdOVmNISGlLM1hWUmxvZGl6V2JqZUxmMlJ3LzJFVmFnanpOZnIyYlBu?=
 =?utf-8?B?VUw2QWFjZFprQWJyRGNycktmSm1LaS9GZzVnZEF6Tm5ybzNXMVpNR21lbG1G?=
 =?utf-8?B?RWpSU05IS2pFNTBKZmphUkl3YXJMZzh5NDJOeXBPQ25IOE5JekJMcTd6Zkcv?=
 =?utf-8?B?cnByZ0hPOFJDMVE5V0J0cEtRYlJVM3J3Zzl1d3AzdUhSL3h3aVUzTUIxaDRZ?=
 =?utf-8?B?akpLNkp5WUpBRjVCYnoxcWVjV3d0TTdsMkN2bEt2L1g2QkdlRWx4Wk5DN2dF?=
 =?utf-8?B?SVg0Q0F3WVA0dlA2YkRYS0NiK0dmVzQ2cVNJb0psN2NqZTNld1lwTmZDOXFo?=
 =?utf-8?B?ZzhJWVllbitLUGxybXZNOUE2Y1ViOTlVc1BUYTFUQlNBRkJDRWkxZEhIM0RC?=
 =?utf-8?B?YkZKTVRxOGtNSUtDTUE3eWR2aGRZcE1tM1VSYStpYnd3ZzU2eU5PRnRjT09N?=
 =?utf-8?Q?J67CUcwBUbFcFhtnVv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432f20ab-96dc-495d-99f4-08dee26a32c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:11:28.0727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Httr+SgvOpfXzTYySq/iR4SZUnbIYgUxwBkNqYC3pEvlV8XWkqBIEuwEOv/NO6ie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850
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



On 7/15/26 12:57, Timur Kristóf wrote:
> GFX6-8 are the oldest GPUs supported by the amdgpu
> kernel driver, and the last ones that didn't support
> DRM format modifiers until now. These are the Southern
> Islands, Sea Islands and Volcanic Islands families
> of GPUs.
> 
> On GFX6-8, the GFX block can only use pre-determined tiling
> modes which are programmed by the kernel according to the
> tiling mode table. GFX6 uses the GB_TILE_MODE0...31 registers,
> and GFX7-8 also has GB_MACROTILE_MODE0...15 registers.
> DCC is also supported on GFX8, albeit not displayable.
> 
> Note that the tiling table is uAPI and userspace relies on
> specific modes being present at specific indices.
> 
> How the tiling works is primarily determined by the
> so-called array mode.
> Use the TILE field to specify the array mode.
> 
> Pixel data is organized into micro tiles.
> Each micro tile may be 8x8 / 8x8x4 / 8x8x8 pixels,
> depending on the array mode.
> Add the MICROTILE field to specify microtile mode.
> 
> Microtiles may be further organized into macro tiles,
> which have many configurable parameters. Macro tile mode
> selection depends on how many bits per pixel an image has.
> Add the PIPE_CONFIG, TILE_SPLIT, BANK_WIDTH, BANK_HEIGHT,
> MACRO_TILE_ASPECT, NUM_BANKS fields to specify parameters
> of macro tiled modes.
> 
> Furthermore, tiling is also influenced by memory
> configuration. Old RFC patches received feedback
> concerning that, so I looked into it specifically:
> GB_ADDR_CONFIG.ROW_SIZE needs to be considered when
> calculating TILE_SPLIT, but does not need to be included
> in the modifiers, and also PIPE_INTERLEAVE matters,
> but it's hardcoded to the same value on all GFX6-8 GPUs
> and changing it would break userspace, so let's assume
> it isn't going to change. Therefore we don't need to
> include that in modifiers. Mesa also reads NUM_RANKS
> but actually doesn't use its value on GFX6-8.
> 
> As a side note, tiling works similarly on GFX4-5
> (that is Evergreen and Northern Islands). But that
> will need some additional PIPE_CONFIG enum values
> as well as some extra fields not relevant to GFX6-8.
> 
> Initially, let's only expose the tiling modes that are
> most relevant to sharing buffers between different
> processes:
> 
> Exposed array modes (TILE field):
> - 1D_TILED_THIN1: micro tiled only
> - 2D_TILED_THIN1: macro tiled
> 
> Exposed micro tile modes (MICROTILE field):
> - DISPLAY: supported by DCE (the display engine)
> - THIN: more efficient but not displayable
> 
> Exposed macro tile modes:
> All possible parameters (25088 permutations).
> 
> More modes may be exposed in the future as needed.
> 
> Technically, the amount of possible combinations
> of all possible tiling parameters is in the range
> of hundreds of thousands, but in practice, there are
> just a handful of possible modifiers for a surface.
> 
> For example on GFX8, a surface would have these
> modifiers, from best to worst performance:
> 
> - 2D_TILED_THIN1 + THIN + DCC + macrotile params [1]
> - 2D_TILED_THIN1 + THIN + macrotile params [1]
> - 2D_TILED_THIN1 + DISPLAY + macrotile params [1]
> - 1D_TILED_THIN1 + THIN
> - 1D_TILED_THIN1 + DISPLAY
> - LINEAR
> 
> [1] The macro tiling parameters depend on how many
> bits per pixel of the specific surface has and
> how the chip is configured. There is only one set
> of valid macrotile params for a given surface.
> 
> DCC is only supported by GFX8 and newer, and only
> with non-displayable macrotiling modes.
> 
> When sharing buffers between different GFX6-8 GPUs,
> it is very unlikely that they support the exact same
> macrotiling configuration, so they will likely need
> to use micro tiled modes, which are still much better
> than using linear buffers. (Note that currently Mesa
> always uses LINEAR when copying between two GPUs.)
> 
> Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Marek Olšák <maraeo@gmail.com>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Feel free to add Acked-by: Christian König <christian.koenig@amd.com> to the entire series.

> ---
>  include/uapi/drm/drm_fourcc.h | 209 +++++++++++++++++++++++++++++++---
>  1 file changed, 191 insertions(+), 18 deletions(-)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index e527b24bd824..7a0a1e5dac75 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1620,36 +1620,69 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>   * For multi-plane formats the above surfaces get merged into one plane for
>   * each format plane, based on the required alignment only.
>   *
> - * Bits  Parameter                Notes
> - * ----- ------------------------ ---------------------------------------------
> + * Bits    Parameter                Notes
> + * ------- ------------------------ ---------------------------------------------
> + *
> + * DRM format modifier fields on AMD GPUs:
> + *     7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
> + *    12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
> + *      13 DCC                      Delta Color Compression, supported on GFX8 and newer
> +     55:14 (chip specific)          See below for details, depends on GFX block version
> + *   63:56 Vendor                   Value is DRM_FORMAT_MOD_VENDOR_AMD
> + *
> + * Chip specific fields on Gfx9 and newer:
> + *      14 DCC_RETILE
> + *      15 DCC_PIPE_ALIGN
> + *      16 DCC_INDEPENDENT_64B
> + *      17 DCC_INDEPENDENT_128B
> + *   19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
> + *      20 DCC_CONSTANT_ENCODE
> + *   23:21 PIPE_XOR_BITS            Only for some chips
> + *   26:24 BANK_XOR_BITS            Only for some chips
> + *   29:27 PACKERS                  Only for some chips
> + *   32:30 RB                       Only for some chips
> + *   35:33 PIPE                     Only for some chips
> + *   55:36 -                        Reserved for future use, must be zero
> + *
> + * Chip specific fields on Gfx6-8:
> + *   16:14 MICROTILE                Micro tile format
> + *   21:17 PIPE_CONFIG              Number of pipes and how pipes are interleaved
> + *   24:22 TILE_SPLIT               Tile split size
> + *   26:25 BANK_WIDTH               Number of tiles in the X direction in the same bank
> + *   28:27 BANK_HEIGHT              Number of tiles in the Y direction in the same bank
> + *   30:29 MACRO_TILE_ASPECT        Macro tile aspect ratio
> + *   32:31 NUM_BANKS                Number of banks
> + *   55:33 -                        Reserved for future use, must be zero
>   *
> - *   7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
> - *  12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
> - *    13 DCC
> - *    14 DCC_RETILE
> - *    15 DCC_PIPE_ALIGN
> - *    16 DCC_INDEPENDENT_64B
> - *    17 DCC_INDEPENDENT_128B
> - * 19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
> - *    20 DCC_CONSTANT_ENCODE
> - * 23:21 PIPE_XOR_BITS            Only for some chips
> - * 26:24 BANK_XOR_BITS            Only for some chips
> - * 29:27 PACKERS                  Only for some chips
> - * 32:30 RB                       Only for some chips
> - * 35:33 PIPE                     Only for some chips
> - * 55:36 -                        Reserved for future use, must be zero
>   */
>  #define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
>  
>  #define IS_AMD_FMT_MOD(val) (((val) >> 56) == DRM_FORMAT_MOD_VENDOR_AMD)
>  
> -/* Reserve 0 for GFX8 and older */
> +#define AMD_FMT_MOD_TILE_VER_GFX6 0
>  #define AMD_FMT_MOD_TILE_VER_GFX9 1
>  #define AMD_FMT_MOD_TILE_VER_GFX10 2
>  #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
>  #define AMD_FMT_MOD_TILE_VER_GFX11 4
>  #define AMD_FMT_MOD_TILE_VER_GFX12 5
>  
> +/*
> + * Gfx6-8 tiling modes.
> + * A complete reference implementation is found in addrlib in the Mesa code base.
> + *
> + * - Microtiled modes (1D):
> + *   Pixel data is organized into micro tiles of 8x8 pixels.
> + *
> + * - Macrotiled modes (2D):
> + *   Micro tiles are further organized into macro tiles.
> + *   These are optimized for even load distribution among memory channels.
> + *
> + * Note that only THIN1 modes are exposed here.
> + * THICK and XTHICK are for 3D images and not relevant to DRM format modifiers.
> + */
> +#define AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 0x2
> +#define AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1 0x4
> +
>  /*
>   * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
>   * version.
> @@ -1748,6 +1781,146 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  #define AMD_FMT_MOD_PIPE_SHIFT 33
>  #define AMD_FMT_MOD_PIPE_MASK 0x7
>  
> +/*
> + * MICRO_TILE_MODE, 3 bits. Determines the micro tile format.
> + * Only relevant to Gfx6-8.
> + *
> + * DISPLAY - Displayable tiling
> + * THIN - Non-displayable tiling, a.k.a thin micro tiling
> + * DEPTH, THICK - not exposed, not relevant to DRM format modifier use cases
> + * ROTATED - not exposed, not implemented in Linux or Mesa
> + */
> +#define AMD_FMT_MOD_MICROTILE_SHIFT 14ULL
> +#define AMD_FMT_MOD_MICROTILE_MASK 0x7
> +
> +#define AMD_FMT_MOD_MICROTILE_DISPLAY 0x0
> +#define AMD_FMT_MOD_MICROTILE_THIN 0x1
> +
> +/*
> + * PIPE_CONFIG, 5 bits. Number of pipes and how pipes are interleaved on the surface,
> + * which means the shader engine tile size and packer tile size.
> + * Typically matches the number of memory channels, or number of RBs.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + *
> + * P<n>_<a>x<b>_<c>x<d>
> + * where:
> + * <n> - number of pipes
> + * <a>x<b> - shader engine tile size
> + * <c>x<d> - packer tile size
> + */
> +#define AMD_FMT_MOD_PIPE_CONFIG_SHIFT 17ULL
> +#define AMD_FMT_MOD_PIPE_CONFIG_MASK 0x1f
> +
> +#define AMD_FMT_MOD_PIPE_CONFIG_P2 0x0
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_8x16 0x4
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x16 0x5
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x32 0x6
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_32x32 0x7
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16 0x8
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16 0x9
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16 0xa
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16 0xb
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16 0xc
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32 0xd
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32 0xe
> +#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16 0x10
> +#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16 0x11
> +
> +/*
> + * TILE_SPLIT, 3 bits.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + *
> + * On GFX6 (or with depth tiling modes on GFX7 and newer),
> + * the GFX block uses the GB_TILE_MODE.TILE_SPLIT field directly.
> + *
> + * On GFX7 and newer with non-depth tiling modes, the GFX block uses a
> + * split factor which is stored in the GB_TILE_MODE.SAMPLE_SPLIT field.
> + * SAMPLE_SPLIT may be: 0 - 1 byte; 1 - 2 bytes; 2 - 4 bytes; 3 - 8 bytes.
> + * The actual tile size and tile split bytes are calculated as follows:
> + *
> + *    bpp = ... <- bits per pixel in the current image
> + *    thickness = ... <- depends on array mode; may be: 1, 4, 8
> + *    num_samples = ... <- number of samples in the current image
> + *    tile_size_pixels = 8 * 8
> + *    tile_bytes_1x = thickness * tile_size_pixels * bpp / 8
> + *    sample_split_factor = 1 << SAMPLE_SPLIT
> + *    tile_split_bytes = clamp(tile_bytes_1x * sample_split_factor, 256, dram_row_size_bytes)
> + *    tile_bytes = clamp(tile_bytes_1x * num_samples, 64, tile_split_bytes)
> + *
> + * In both cases, the display block (DCE) has no SAMPLE_SPLIT
> + * and just needs the tile split bytes in the GRPH_CONTROL.GRPH_TILE_SPLIT field.
> + * To maximize compatibility between GFX6-7, we don't include the SAMPLE_SPLIT
> + * in the format modifiers.
> + *
> + * The actual tile split in bytes is: 64 << field value
> + * Possible values of this field:
> + *
> + * 0 - Tile split is 64 bytes
> + * 1 - Tile split is 128 bytes
> + * 2 - Tile split is 256 bytes
> + * 3 - Tile split is 512 bytes
> + * 4 - Tile split is 1 KiB
> + * 5 - Tile split is 2 KiB
> + * 6 - Tile split is 4 KiB
> + */
> +#define AMD_FMT_MOD_TILE_SPLIT_SHIFT 22ULL
> +#define AMD_FMT_MOD_TILE_SPLIT_MASK 0x7
> +
> +/*
> + * BANK_WIDTH, 2 bits. Number of tiles in the X direction in the same bank.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * The actual bank width is: 1 << field value
> + * Possible values:
> + *
> + * 0 - bank width is 1
> + * 1 - bank width is 2
> + * 2 - bank width is 4
> + * 3 - bank width is 8
> + */
> +#define AMD_FMT_MOD_BANK_WIDTH_SHIFT 25ULL
> +#define AMD_FMT_MOD_BANK_WIDTH_MASK 0x3
> +
> +/*
> + * BANK_HEIGHT, 2 bits. Number of tiles in the Y direction in the same bank.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * The actual bank height is: 1 << field value
> + * Possible values:
> + *
> + * 0 - bank height is 1
> + * 1 - bank height is 2
> + * 2 - bank height is 4
> + * 3 - bank height is 8
> + */
> +#define AMD_FMT_MOD_BANK_HEIGHT_SHIFT 27ULL
> +#define AMD_FMT_MOD_BANK_HEIGHT_MASK 0x3
> +
> +/*
> + * MACRO_TILE_ASPECT, 2 bits. Macro tile aspect ratio.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * Possible values:
> + *
> + * 0 - aspect ratio is 1:1
> + * 1 - aspect ratio is 4:1
> + * 2 - aspect ratio is 16:1
> + * 3 - aspect ratio is 64:1
> + */
> +#define AMD_FMT_MOD_MACRO_TILE_ASPECT_SHIFT 29ULL
> +#define AMD_FMT_MOD_MACRO_TILE_ASPECT_MASK 0x3
> +
> +/*
> + * NUM_BANKS, 2 bits. Number of banks.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * The actual number of banks is: 2 << field value
> + * Possible values:
> + *
> + * 0 - number of banks is 2
> + * 1 - number of banks is 4
> + * 2 - number of banks is 8
> + * 3 - number of banks is 16
> + */
> +#define AMD_FMT_MOD_NUM_BANKS_SHIFT 31ULL
> +#define AMD_FMT_MOD_NUM_BANKS_MASK 0x3
> +
>  #define AMD_FMT_MOD_SET(field, value) \
>  	((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
>  #define AMD_FMT_MOD_GET(field, value) \

