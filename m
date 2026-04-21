Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACED7F94CA7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FE010E281;
	Tue, 21 Apr 2026 21:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5sGDDLz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9321C10E22A;
 Tue, 21 Apr 2026 21:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJi6WD2Y6XW6WBZxEgI9DOreVIdEo6V5/sAtXvX1xvpgJBZkmiRTEvkjVEJ1Tqlz8jgosahDcZmGVwIk6/9W5YwDXDRI8pUG8AL5Q49svLXXmIc6E3WmQZWAp5S6xXOiWzBokExyeo+tze1tYGTnITtzk+3/UQfAZd1l0va3Z8bvHrukXSVVbnzCfEIifqr2YYrmQBESRGwcudOYL2IgldO6K3MtqRDMUUygMmGYuQrtFfcuBCOACT0+ZuLKn0QF9VBVBstt2lLG7WCmLmtLAHCHj8CDoBQ4cU1SVDfWql4ckDK6zCtthJdd7U+OYKsyUHeo4l48y2+HYaes7kB8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8DnqXcwEOM02uFNUXnqETImKOfarT3dsS422ipSIGw=;
 b=yr2oOhVTeodkxxeekOWCzRFWCCcMywY+G4y4I/eVbzKraEx+pcdcyPNQOjx2lQyWNAQwcm3JWcq5JfueNoZwDul0sCfJM0MZr+xSQLUClCGwP9iWdtj00NmwIgsPopS53fdfAs2vVAAtsPFXct4OXFYZnTpfS2s0hy6N+b3i9KsmSp4uE4BvAGe6BkTB2r0NnYro1E/0ROJplRMvYUtVeJ37NlgIQtht3DkwpaLQmoc9r7EjnTtj7lagJRF3spWQn2hUGGbreNHrDdgX0wXA7Y73fuidEV35QXKBFVtfulL2Xx2ejDoBY/gH1QlToPKBcKWijqfKit43c4M3qLYbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8DnqXcwEOM02uFNUXnqETImKOfarT3dsS422ipSIGw=;
 b=g5sGDDLzGjO2TsDkw94pWBfAdCG2PGGZzst/xzGnsj47R7E320zs/yfedhJwrOZrE8XEvnqmEEqqM4ahuDgGV3ViRcINFYZHvjOLKjEXN2idzS+1yfFwYaOETJ88rMuYDXhZr6eIjzcshAO2q1AwiuDO//VkPihOE0OPP+gCLUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:08:59 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:08:59 +0000
Message-ID: <92964f38-2691-4795-a064-de67301ffc6d@amd.com>
Date: Tue, 21 Apr 2026 15:08:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/9] drm/amd/display: Use GAMCOR for first TF if
 CSC is used
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-8-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-8-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c42f9a-55bb-49b4-8b90-08de9fea34bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: /Geax/9SwWdaQcPEzBobquUtz+9z7HZOhMk97rjm3vS5NhAFgvWjjKMbvjbWIUv5NkGKdb2HeW7Te9JKUx97hjl/j3FVbhKxhtRn2zyQsybMDJnsaLv4TH8Yt/VbVJqdxmacXAuSPKEx20aosYuEW5pAGFgRe2gENPb0+O1F/UVkOCphdN3J7uooWM9XMykXQQDx3zX7dGqXOS7JRxYwqpnvmaFO5Y3YZQmJy3mkq1iWUjrpvgQCVsrZu3Yy7P722V2iYsEP3/k5SZyeGZiH0sPovQkoonp+yg+np6ERQ1r3cm5rXUQPR5T/GoRonHczs5wYpOv9ThjfiaxPJgtuD8GdZsGhb3H4gOX/tmARxVpOZvtSPPdYum9x8Aqd0AICjGACWO3JSTFsdAWwHhymFrg1ewtSKUXwKS9WBTI70Z1oRKwLu9Qdq7ss5Q29qDXPrmfNBMR8VH8B5qE0yvcJthapB5z3wZ0FpP8yPcwOOhR19NDGI8V9VGQnVZiAoeio1Vd8cP0cQHWw4aDLDUQ+7eCD47r+qcVfu79Jyh8T9zHHq9x2ZhtgE3BzGHrBOFE7ueuwRJ4HF4sj0l4KoA+MuGFDV56V3EP0qoBqYVMMSTWtzUcLE0yVuKC4QTLsQ6+ArqtSN1mwzU6o1BLKhlQ80AlGnrO0JwcbouEcXGNDMcUI/asGCrgPEsihNfqdP3BkAaHgDyacANRx+fJrtsIGbez0CvBmMeL9Zy4nxi5e6PM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJ5bFliWkNFUjdVeWRMWGFncWFxMW9rODhjNVBnNTZhb1dZMVcvdE13Qkh5?=
 =?utf-8?B?bDkxazVsQ1VWZG9xYVFxTkhIZ01EMm5KYi9KUlBIL1lJV3IxZk9sQ0lCZURJ?=
 =?utf-8?B?SnVTQW9rWk1lTm9weDlwT2l5V0VyT01WR1UxS2xrZHpUWGJEVldMcDZtZUcw?=
 =?utf-8?B?bUhvZHNkS0dwdnI0Vjl6NmhUMDdaWGJndG9QN05jTmRBMWxQY3RFY3EzeTBM?=
 =?utf-8?B?bFhUTUJRelpPdlNuOWc5ME92WEFxMDYxdGxuVEgzWjJDaHpSa2xkczh0OUJF?=
 =?utf-8?B?QXdlbVk0eURpR3g4cWxIRFJZdTEybC9zMTdvN2lUSEc4M20zWFo5UUZLc295?=
 =?utf-8?B?UFVRbUdiODhpMkxHRVRnTXFvWUJPN1NZeVE1ZXBuVno1aEdZelRmN0RlcldQ?=
 =?utf-8?B?Q0MvQkI2NW9aay9SUHdhb3lBcUxGWEVwcEhYRDlocnBhMkg0SjA2d0FmMkNB?=
 =?utf-8?B?amxZQ1BXR1RhdnZHNVQrQXQ5WU80Z2Fzai9TWlZUbFdTMG5USVVjd1BCTGw3?=
 =?utf-8?B?aTljc1ByKzV1VzljSzJ6NmxUak4rRDkrOVBHY1NSMzl5dmV5bmhKU1FoV21o?=
 =?utf-8?B?WHA0azdtUVRUY0hLZHdpeEFhMG16OEpMWkp2YW1LNDNPWDcvL093WEdSVExY?=
 =?utf-8?B?K3Q3YkhMbWFRWitNTjFMWUNkU1c2NVk1aUZGQWI3TWFQbFZ1WG9HUEs4dnlG?=
 =?utf-8?B?M0N3R1E1WnRqWHdtWE9xRW9ESTYyY1dTWG9sWXc3SUZ6Yms0dHZac3lrS1V0?=
 =?utf-8?B?RzlscjZqYjM3M0lUMjRRREVsaFZzQXoyYmV5L0kzbEJXYkxmMFpSWmYzb3ZK?=
 =?utf-8?B?dThXRDJGNnZ0V1FaVU9UTEFqZmtNaDF3aDJhNVMwOGN4NTU1Z3h3bVg4Nkxu?=
 =?utf-8?B?UnlhK2JwNzJNRHBRQm1SZ3FsMmpYNUxNK2xDWm5VYjhEMHpwdTNsamVCcWEr?=
 =?utf-8?B?MFltbDJxN2EyV3I5L3dmdE9JMWkrbFNwUEhpbnh6bzR3MVozUGpMSWY1eWtC?=
 =?utf-8?B?V2NObDZsVnVNVWNvem9sNmxsaDdNMFFHcVlMWXlqZ3hIaHN6Z1dWZ0MyQTFo?=
 =?utf-8?B?OFZZUTg0SlorZXFGOVRTMUNLWC8wU3IvcTE2cU8yUCtEbGZ5aEhnZGZBZXVR?=
 =?utf-8?B?MmkvS1BkenZWbGlzOU94NXNkK296YllzTzJXQ3g1NmxFbVkyQ1VjNDZyVG0z?=
 =?utf-8?B?SXJNTTdna1VyVFl4N2UwZFdlZndMbTRMNGQ4QmVGSW02L0lqd3FCV2xaY0RC?=
 =?utf-8?B?QlFwNmpicVIxYThBdGFEdE5Lc2xWVDdTNFRvQzJMbzgrUzV2UEhSeEZUWnVX?=
 =?utf-8?B?S2lWMFVwejRHNEJnS3M4aXhIZFlXSW5OaVdKTjlHTVRYcmhzckViUExSV2JE?=
 =?utf-8?B?SmkxNERmWmRRMzFXbU5aRE54YWJ2V2wzZ2cvZWFTd0JYSzNiQTllL2kyQVZx?=
 =?utf-8?B?R3JmbGlRYXR0Q3czdk5mY2ltZDl2Z0ZPaWo3MDJtZWdQdVVrQmFzaXVHSmVC?=
 =?utf-8?B?ZERlUjBWdXdCTzk4MlR0U3BhRTRsN3EwcjJQRzJmSDJEa2hSUUNReG9xWDk2?=
 =?utf-8?B?VlU2MDM0cEpXYUd4cktwYUJuTVYvQ0REMXNkUnduSk0wUGp1bjF4NkNPZ3NL?=
 =?utf-8?B?ZzVIbk5sRkpNWXFQbHZSbzVHZUViM3doUEJnMTlBUGR6T1RQb1RUWVpsNVdH?=
 =?utf-8?B?NEwvMFRONXh5Y2MyNWtPV0pyRDMwUTJabHZDc2R3YmJlZFVLSTRJejhVTmVr?=
 =?utf-8?B?eFgwN3ZrVFBZc005WTBCa3I1aTlRU1Bxdms5SXJxcnhnVERVd2Q3MnR0RHky?=
 =?utf-8?B?dW5vamZFdDRqM2RZcVN3WFJQN3d2a2RxcXBSWVZBU2o4d0s3MUdQTVFSQmpz?=
 =?utf-8?B?cSttSnJnSTFLM0llU3k3SmZWa3dtcHErV3A5WUdaTFQ3eDJkUXBqUzkzckNV?=
 =?utf-8?B?K0w1QUVaTS9Hd0dFUUkzSWhUMTgvYmxpQktNRkRJeWpDbFc5b2RaOGVCazJH?=
 =?utf-8?B?S3h6MklIN1ZjTHNjWGF5dkl1REdPd0o1dUp1WDNPZTRPMDVHWGk0YUpPalBv?=
 =?utf-8?B?R21iS1VGNFV5T2YvWS81MGdVK1dQaTBxTVUxdE1VVnlXYnVwYjVFQzk3cVpN?=
 =?utf-8?B?alVEcFVFTkRKeWVvZGltMk1mNCtMejcweEN6dFpobnZiTXl2d2lVNFhrd3Ba?=
 =?utf-8?B?YjlWZjZtQkxjemhKN2xCSVN1ZVJYMWlUTXhpY3RyU1lKRDd4eGNjYmZTSTcx?=
 =?utf-8?B?SE9TbWh6VU9FN1l5NWRjUytJa3lCL1VkdzVpckd4MmxhVElFbmNjQmV5OVl4?=
 =?utf-8?B?WXdZRG5oS1ZjeUEweXRyMzdBdTA4cmdoaTg5TXhUcGtuaXBZNHVSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c42f9a-55bb-49b4-8b90-08de9fea34bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:08:59.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azjOMMB0QkR2jY/S2QqYsGRzLxtLKxOTIzm2HKHhjk32QXJOI5PhVrS846qQT5z1s1b1eE5UzXzvLM1GfP/YNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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



On 3/30/26 09:34, Harry Wentland wrote:
> For subsampled formats we need to use GAMCOR instead of
> the DEGAM block. The color module can create a LUT for
> that if we set map_user_ramp to true. So do that when
> we have subsampled formats.
> 
> Co-developed by Claude Sonnet 4.5.

This should be updated to "Assisted-by Claude:claude-Sonnet-4.5"

> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 34 ++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index d5b4190e635c..6403dfe4ee10 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1471,6 +1471,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
>   	struct drm_colorop *colorop = colorop_state->colorop;
>   	struct drm_device *drm = colorop->dev;
> +	struct dc_color_caps *color_caps = NULL;
> +	bool is_subsampled_format;
>   
>   	if (colorop->type != DRM_COLOROP_1D_CURVE)
>   		return -EINVAL;
> @@ -1486,9 +1488,39 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   
>   	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
>   
> -	tf->type = TF_TYPE_PREDEFINED;


Setting tf-type is moved to the below if-else branch, but both set 
tf->type = TF_TYPE_PREDEFINED. Is this done intentionally to improve 
readability or for other purposes?

> +	/* Check if format requires post-scale color processing (subsampled formats) */
> +	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
> +				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
> +
>   	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
>   
> +	if (is_subsampled_format) {
> +		/*
> +		 * For subsampled formats (P010, NV12), we need color processing
> +		 * to happen AFTER scaling (to expand UV channels first).
> +		 * Convert predefined TF to PWL so DC will use GAMCOR (post-scale)
> +		 * instead of PRE_DEGAM (pre-scale).
> +		 *
> +		 * IMPORTANT: We must pass map_user_ramp=true to force PWL conversion.
> +		 * Without it, mod_color_calculate_degamma_params() returns early for
> +		 * SRGB/Linear TFs without converting to TF_TYPE_DISTRIBUTED_POINTS.
> +		 */
> +		tf->type = TF_TYPE_PREDEFINED;
> +
> +		if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
> +			color_caps = &dc_plane_state->ctx->dc->caps.color;
> +
> +		if (!mod_color_calculate_degamma_params(color_caps, tf, NULL, true)) {
> +			drm_err(drm, "Failed to calculate degamma params for subsampled format\n");
> +			return -EINVAL;
> +		}
> +
> +		/* mod_color_calculate_degamma_params sets tf->type to TF_TYPE_DISTRIBUTED_POINTS */
> +	} else {
> +		/* For non-subsampled formats (RGB, XR30), use predefined ROM LUT (PRE_DEGAM) */
> +		tf->type = TF_TYPE_PREDEFINED;
> +	}
> +
>   	return 0;
>   }
>   

