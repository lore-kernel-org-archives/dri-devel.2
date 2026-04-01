Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA134107639C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1030F10EB11;
	Wed,  1 Apr 2026 19:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rY8UrzBI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9AF10E35A;
 Wed,  1 Apr 2026 19:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRGXEwWnfgxDMX+3nED14nNDQrHWSy8b4ugUh2kTKZ7ONvrzbIM24CIJLRrz0vWlp1OpYpu8T/bwIKGXs56sdIjTHDI5drRKYvjqbd9+eN6w8oxqyOP9FomO9jf6b1PJv3bWPX2a1OM2xkhOqhZvl9rEMfk29dYarxLx/gSNWs6pmtmL7zI05RzPyYs6R7grG4GiSosI2h0VR/b0vHzmYcZ1VolA6+C1fHeZ72fqAfNUW+gD5wALHkYkwioKsfN6k3TclH03Egvi0E8dcThdaXPrfkVZWqOiNIwQ/oqpZx9xP5G4SbNVtqnenIAWNuP/wNpo3ppBQkHnhYU3ZVdpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kPNfJxiQu3a4OiAZXCtk3U88dZf+4g/kcPZM0zEb04=;
 b=qZqOXC2y6uRllSepyUNS5m+zYWSM6hmqSuYooaZFQBvMIzBsAvP/0uzkY9+6aYu7WAW4/2Tg5v6QGLPwTq6Rr15mjQaSOyFDxAQkN5o2abzgqug62NbKcw3XO9vcOnuJjA5cTB58B10ThblaiWAuvwVhWK24E5YwHa3rAB8Fxz6DoLI8G8gFWr/XTMyXJuuSe0NuHzQAuNzlVDIts9oGv3s7BYLFEEXO09BSmcQzeYlxYsPGN5y72SnQirtAnaTUEjy0k2RhqvZaA/IpP1CfcE41PAZVd2e2Vjjq/igypzyqqYl08CLOQH29VLpNuX+B0ljEU+rvmBvcbl89EjLBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kPNfJxiQu3a4OiAZXCtk3U88dZf+4g/kcPZM0zEb04=;
 b=rY8UrzBIQI541HOrr6DYppZPjsuGfnf5GgqmFNS4tr+qNycLYm2gicYwDe/UZ9mnxglD13dH58A25RvJUHZpbXqAhhqKgzXF6pjMRsiOlqogxjOwb2DU1lCZI8xLLyoTEwrvgWOOZ/0DrrDHV7OTgwgPH46/YWqQMGcJ0UAJ2u4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 19:32:48 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.017; Wed, 1 Apr 2026
 19:32:48 +0000
Message-ID: <f4861fc9-a602-44b9-b5c3-6b9c7f233b15@amd.com>
Date: Wed, 1 Apr 2026 15:32:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Mario Kleiner <mario.kleiner.de@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Aric Cyr <aric.cyr@amd.com>, Anthony Koo <anthony.koo@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1988bee3-ed7a-4786-9f9e-08de902574d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 8V7dqDGH1UO1mgci0jIYxDjuQ7Z1VsSkVboU+6NgRdAAM2uGxN2W1CE0WPVK7ltc5VqRF0l6JiBjbZZHnNAfKAXmWKjb1FN/NLq6VA/h/0igUpEhljgdqrP7p15SzFUrOX6xcoQImHLOYBPfpd173bEdOU1cXeAHlSf9s3YFOfxcTg7RwVx4TIly31+VRbDH/AaJ8Tsr5PHAhGqZYkja8vvpfgQHaP46si+CzsQD3naLy6//rMZn0IvgUMOWOnsFTEC7BkNfN/vy/U0PppbORk1bSBAopKUmE3G342TFeks1hxuf/qGROlNVnNsN+APVEs9m9iXGOnOISsV/6a/Y7y5ZclsP+MguI3M961BlrWDuE1Rj5+TrCwAwQ4jgaSzykAn7XTYJHQtWVZwq7pgo0qshE1YNftgzKQRPZrIo7wuEMedgexGuvWDO1Q8IsYLrQinblsiXct9862hOdgHKuIf1mtm+pof+ZTfvvdKPE+Tu3bwTbJXCKMIQEgwfZLK1fnN4KgZJNbn7DXiY7i/a9dGo7IDzA/FF9C2UDpwOVfOz5iqrQawAjZ2BCrFfjzrkAl8TxXyk30hzlRt3ppTfsMR5/Lk/y+gZrs4kpSQu1mhYIIHyLsVAcgVPlh3mCYHg+JyvhUFF3ymRGLi33Zt9K7oxKKM7pZ4BxKe3YOSSUO9KzlG5NDVYFRbJB3stYFuo8Qt3x4i9upTyCLSYLQ56fuaBb6QNP/Z1x+1khM8uILQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9keXQwRGFQWVoyaUdaVWdNODB3NWZYSTcyY0pYK201Y0RVYU9KLzduTnBU?=
 =?utf-8?B?QWZpSmg3R3hZQ3JPMzVYWGx4UWNXM3pkR0VzZGE3YkdiVWZRZk1EQ2YxY1dE?=
 =?utf-8?B?c0J3cHhrMm93VmIyaG15MXgwSlNyaTNZeTQyc0ZPNG1vWm1CVWZEODhxWlJv?=
 =?utf-8?B?ZVdLVTdlVWpjNVREdDNSbTRvbW0waHd4NitSak1RM2tFRUhYeCtvNk5SV1hF?=
 =?utf-8?B?TERERVkyVFVZcG9rakI1ZERIMUlKR0hLN1FJVlV6Z0FkK0JDb1JsU1V2OVNS?=
 =?utf-8?B?bTdVam5xdWMrMTN1QVgvbEZrMnBIcGhJSDBnakdtaVNYVU5iTVR1TE8wdE1R?=
 =?utf-8?B?eU1maGgrWHlYZVlnVFA3cCtlcWFISTRoZXNZSDVaVjRVSVBnZm9RaEZveERN?=
 =?utf-8?B?cXcrczdIVm0vQ3dmVmlaZjRsWHdqQVNQOFdzWTg2N3BCb2VhaDV6djdNSllw?=
 =?utf-8?B?ZEZKT2o3VGRra1pEWEFQRUg5aGZMVWpvTFV2VHpPSWNUWWxGTGg3WTZjVzIy?=
 =?utf-8?B?Y0ZsSmtSNHNSdmF2bnk5bDl0d0ZseEhiNUQ3azVTMk5Kczg5ZDkvNElPVFA5?=
 =?utf-8?B?Tk1OaW0veXRPejBnNUE0MFBaWlowK0ZlVm10NERYUVkvcjQxa1gxTWx0QU1W?=
 =?utf-8?B?Q3c1RDNHTUFpMEZyRVF3c2ZyNmZkRW5ZcE1Wc1FNZ1JVUGJLZnBoRVE1Qi81?=
 =?utf-8?B?WEN6VzV1bW5aZ0pEanNKNVJia2ptaXNzWUEyWXpsK3pvYi96VDVHSlVBMmtw?=
 =?utf-8?B?Q0VkbVgyeTR5akNodWlkTWUzRmxaTzBXMGEySkxjUVhxd2NRUTJ1TWhSS1lk?=
 =?utf-8?B?ZjJkK0FpS0JrbWJENFgxR29OR1JiSUVIMHI0YkxsM2t6QXNLQytKUkl2ZkNa?=
 =?utf-8?B?WHdzd2RjVS8xVXFEOHVpZFlKMHhmUHdibGVyQklReE54ZW5IOEVndHdaQlRU?=
 =?utf-8?B?TzY5WGZsYW1SMWdqSEFnUWZZL3VOZU5yekN4ZWtaY29MM2xybWlGZFVUcU5N?=
 =?utf-8?B?NU5Gc3Urci95bm41NEV3L21NWmd5dXlLWVdBUDhRUmNqT3NCUUlEV0ZtNmtq?=
 =?utf-8?B?UzdWeXpCTXRGbmhkTVNyTG9LK3RJYUxONk9nR2h1NkFmblFmWFZJc2ZEQ2wv?=
 =?utf-8?B?R2JOQmE3Q2hVT3VnVDIxc0ZJbkx2Tnc1ZEI3ZytHSDNNcUV2VkVMZ1dYbUlj?=
 =?utf-8?B?L01DVHhLbkhXSnVNaEZ3M2VwdXF2ei85M2hjZFVyUTI2UWN3cVZURHUyQjRP?=
 =?utf-8?B?NUJLelBDZDdSVFdxUVhUb250NnBMRnpZQ1YyUGxEYVRlWEhvV0pOb0FiWFNx?=
 =?utf-8?B?Wm1zbmpwVHd5dkIxV3kwNERXZitYcGFMeUluVVFFeXd4Q1Z4dWpPdE81b25n?=
 =?utf-8?B?S050VHlRRFI5clZHR0RaZkpSUld4ekRyVS8wSkNHQzcwY0xmRnZNSXNPNFZI?=
 =?utf-8?B?MWFMaW56ZzgzOTEvTnBpcUNodzVHUVRCVFBFWGtKdytLTWdFV1hUSnVhSjNW?=
 =?utf-8?B?ZUdBa1RGRHpObkIxYjdmZzMwaXNsU1YrV04xNFJxN2R2NFBCdzQwdUR5ZXY1?=
 =?utf-8?B?M0NCWk5Ec1c0WFlBTDV0V3EzWVRLRHFydCsxSHA2RWd5RFBFNHF6M1hEd1JE?=
 =?utf-8?B?ZXY3RWloeEIzdk1OZEhPVGhScXo5QVB6MFdxb2tocVFWaXZQdkRyMkxWdEJF?=
 =?utf-8?B?ZlIzY1hON2dGMHRDVG05cGN2cVl0VmZIdmtnT3NDQ1FnbkhLRVdEdnNOdUJM?=
 =?utf-8?B?M0IxTjJ5VVdXV3RsQVZDZER4T1ZZVVBSY3RmUEg5alAybmlabWlFRjZ6RnJp?=
 =?utf-8?B?Qm4wU3Z3WkJqSy83OCtRVVFzdE9sUnFmUk5FNVJ5QkdaSytvanB0VmtJSnUz?=
 =?utf-8?B?ZTFjZ3N6Zm1nc2V3N0taVGZaSFo1MVRoR0d0aEF5WVExNXJIRFRsTmtDaU8z?=
 =?utf-8?B?dWRhQy9QR0NTSHlSMWRHYVpYeXF3TXNqcSs4dlhLNjFMb1lYd3Q0MkJJZ2hD?=
 =?utf-8?B?MitkUkw4N2h4dTJqOU1jUktKZnhUUHQxNEtMbFg1eXhBajlubVpSM2lpeDZv?=
 =?utf-8?B?VGR1SWNiYy80d1Zoc2lVckplWFRxTnQyK3QwdFpWQlVWWlppbTc5VG5pbVM0?=
 =?utf-8?B?UFBvSldIS1VYb3ArNzFQamJvTG1nd0F5dUswdkpTd29SSUVtRDE1SnFrQ0Ni?=
 =?utf-8?B?dWk4MDBMVTNMQlhxUzBRY2VRQ0JzTUREQmJGYVZCWVhpUjFOclNHOTE5RzVH?=
 =?utf-8?B?WldqUlFaM0poc0RKTm8xUS9VQ2d6TGQ4WnVUSGVKVGQ0ZEJKWmo5dlBtSEdN?=
 =?utf-8?B?QmVKcXFmWWFSWlBvOWNGZFIzVFpnZ0JUZktoYWJuelB3RlE2UzRyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1988bee3-ed7a-4786-9f9e-08de902574d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 19:32:48.3118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sbT8kPKSZzhBnZ0/8mTQ2P+/m5j2qNVqBV9VpoWtrB+OdErfSNPwXRh/l8s+lO7SorBIF4KURvsp7aaoaRHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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



On 2026-03-21 01:20, Mario Kleiner wrote:
> Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
> round") degraded display of 12 bpc color precision output to 10 bpc sinks
> by switching 10 bpc output from dithering to "truncate to 10 bpc".
> 
> I don't find the argumentation in that commit convincing, but the
> consequences highly unfortunate, especially for applications that
> require effective > 10 bpc precision output of > 10 bpc framebuffers.
> 
> The argument wasn't something strong like "there are hardware design
> defects or limitations which require us to work around broken dithering
> to 10 bpc", or "there are some special use cases which do require
> truncation to 10 bpc", but essentially "at some point in the past we
> used truncation in Polaris/Vega times and it looks like it got
> inadvertently changed for Navi, so let's do that again". I couldn't find
> evidence for that in the git commit logs for this. The commit message also
> acknowledges that using dithering "...makes some sense for FP16...
> ...but not for ARGB2101010 surfaces..."
> 
> The problem with this is that it makes fp16 surfaces, and especially
> rgba16 fixed point surfaces, less useful. These are now well
> supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
> OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland,
> and they used to provide more than 10 bpc effective precision at the
> output.
> 
> Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
> e.g., gamma tables, CTM, can be used for color correction and will
> benefit from an effective > 10 bpc output precision via dithering,
> retaining some precision that would get lost on the way through the
> pipeline, e.g., due to non-linear gamma functions.
> 
> Scientific apps rely on this for > 10 bpc display precision. Truncating
> to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
> down to 10 bpc, causes a serious loss of precision. This also creates the
> undesirable and slightly absurd situation that using a cheap monitor
> with only 8 bpc input and display panel will yield roughly 12 bpc
> precision via dithering from 12 -> 8 bpc, whereas investment into a
> more expensive monitor with 10 bpc input and native 10 bpc display will
> only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properly
> set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc out
> precision) would allow effective 12 bpc precision output.
> 
> Therefore this patch proposes reverting that commit and going back to
> dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bpc
> output.
> 
> Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with
> a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer and
> measuring resulting color precision with a photometer. No apparent visual
> artifacts or problems were observed, and effective precision was measured
> to be 12 bpc again, as expected.
> 
> Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to round")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Kruno and I chatted a bit more about this and the best way forward
seems to be to re-enable SPATIAL10 dither and then override that
when needed in our Windows driver.

Patches is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Will pull it in today.

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index c9fbb64d706a..29db5404c4a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
>  			option = DITHER_OPTION_SPATIAL8;
>  			break;
>  		case COLOR_DEPTH_101010:
> -			option = DITHER_OPTION_TRUN10;
> +			option = DITHER_OPTION_SPATIAL10;
>  			break;
>  		default:
>  			option = DITHER_OPTION_DISABLE;

