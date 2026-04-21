Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30093F94CB0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7759410EDC0;
	Tue, 21 Apr 2026 21:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKvSZcXp";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA7B10E15A;
 Tue, 21 Apr 2026 21:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHFlKFA8v/XmIg6iqnYEt2EBiNt/ICo6eD4GSovyk1e8PERtyCnjx5re4P/uP99Hkhnsn2U2KBKuvRwN1ADqhS0UXQxfYpvUvFzOyTbQHjmdH95o8klOIphSQ1+C+jdznofzUMOPh8ahedVqulC9D1UYCHkP+cLXjh2HO0n9JgTXBl/PgiXuD1kmPNQJ4GasYVN1fAh1SgJQvpnUeiwONhE6zu757E+wYDYNnGBCGhDj+xqmPcAPedM1urkC9/NkKeti/81zheKUpZYgKNBXovQX9iVMWcxVxCFp1wrLsRrYA8en5Zy/1fyJSTnufHDsUXfvSYgVGcF11mPXemCW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DXnAMu6qyaOS+5fRN+e3sJffd7ZySrySg2njfEBwsw=;
 b=ngZdibpLOgBEosJ2d25Ztkrh2RBcMZYvLt2l7mjA1AJgTrGpITjs/6wKI07wSQ57kQovgOdG6+oV/hjZAVLKDo/rM0ykUpJxVA1kM18ollDaWTJXWZMSjVU6g3jm4ctyO1cNDKloyKKBFzfOBhj6XqLe22BboBOlguwoqy5W1a2UysQxhWraXXygHipD7Aw9uL64izZSGMNPMQ6hBgbGxSaysVH0U3LK7v6qu7rqEvfhQjA+GbE40EyXE9wCeR1UXvniZhCVAty8pcnU/vwrIKvRhvvgoKzQM7T2exJIsN7kJmeO2Zf/wUoxs0ne2wohUs4Bb1Gtk8cQ4zf6ZCWpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DXnAMu6qyaOS+5fRN+e3sJffd7ZySrySg2njfEBwsw=;
 b=fKvSZcXp6fONTKmnkPX3lJvVor5i2r/vJ5pLhOUI9G/HBW8Ahejqz/HmwiDD4GHwdM0Ljm8qsgSPsDfaKBjhVAd1+qsL7Jvmine2hYyoihqj3YYqQUfbd1ZMcol2mPWZiSliF4pqSeTgDA09KiHc0yy1gsPj1iAehoRmTEG0i9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:20:30 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:20:30 +0000
Message-ID: <fd972f77-7472-4459-acbb-eb545c3a919d@amd.com>
Date: Tue, 21 Apr 2026 15:20:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/9] drm/vkms: Add atomic check and matrix handling
 for CSC FF colorop
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-5-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-5-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 51da0351-a42d-43a3-84b2-08de9febd0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: U8sCClljwR4luWVroEplNYFyO1B1qGyBQhIGyfbPnVaL+/Yy6P6W1PUTuJ9uG1VIbGaK0FYmHFLcIdLlO7eMt2w4nfUvFjcVqp+cfVaFUDHELStCopJd1VGWJQHVU1sX5qmWMd0o8PlwYGfENgiFnbxiliriXjT3ZAGNOY8vzN38Tg7GyuFTPjCj1SuvC0jbJ329KfFAeJJVudwCvO9r0ZQINLqX2oPcLsjUaKt7aQlZd0l5ddJaXjbDO4F+0qi/K7abv2jHmHw7zXuXaeX4m38AjpnUdv+/SVPsc+VqKkGFj/6rVvXWUte7q6LjhycYZS7YmeGe2KmpWE25Cp3ceMYkZpbrjpQY1xzTF/fHryjChmNvCYQFUybcNpe7K+F2w0S86Ae/M8hJTV3gtmRBcYLuSvXsbGBhM0xW6NHE+HUyEoMS8a8eSJsH028i/adlm66cs3vrVEIp9nFA1wHzrzbQe7Yc9PEiM6cpG1oS/U1nG1sqZg5AwWAT+dHXPHG512VqDNO0W9lv4vEjfZm9bp6rCraG93Yczr/eZRepH2+7dQ1UVHEbwyr/Gxc8gDq/vo/1qSgbfhr6uXF6M1Le67rkNG7tGxhCnQhA3dXDYNK07chmSCXSEoC/LsFi6sz347k+PMSDK+QJWfgUbn4a5az6yRFtUo3QZnpHqvomTHGkSEKrYQ3KwAqKJYP0Rki7QjcbxURLK2+ISrc/++muzk7WJx6c/b0W6cs7Dv/33q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElmbmdkVVU1cE50RTNJNXNCRko3dDBjOU12NUIrVm1IdDB5bGpKdlJMMWlm?=
 =?utf-8?B?N0dRVnFjLzRCaXhhQm9DVEZGKzJIaVljVlZGcVgxcnZlN1d2UDk3aHQ0K1Qx?=
 =?utf-8?B?WVdCNFZRdmowVS9EeDIvNE9kbWV3VG5jeSttZ3dneFVDS2pCTG5VcDI4R3hh?=
 =?utf-8?B?V0dyQ1VhVWJxdUQwcGFSYzdJODR3QllpbW9kQlFtWU9oTVFHcEw4cStCdmd0?=
 =?utf-8?B?Nk96UHNqeEZjT2FITWhvS0dndW9YN1FWazZqaTZmcVp4VThIdHFrOCtYSXhB?=
 =?utf-8?B?TC91dU43aXFIU0dvWFNqaXRSNE1RZU44WXBPMm1sUUdpU1VWQUhWUUJieFp4?=
 =?utf-8?B?YUd2dzlqTXBQajY3WC80NCsxcnpCSmF5NEx2R3VMNkFJZllWbnFhY2NrQlU3?=
 =?utf-8?B?b1I0UGZiM2Zjd1oySGgzYW9uQXowSG9GZ2JLNnFqeWcyaFZMcVRuSXh2T2pR?=
 =?utf-8?B?dTFWQjFWTjJ4MWRGSlpBVWdZcUQ0TjNmSWVNUXBQVi9sVk1ZTFovZU9uNUVL?=
 =?utf-8?B?T2xudVVuNXIraUM4UnZLeERHZlVWTVFZNWd2SWpTQ3BwK3VZaG5kMm1yZy9r?=
 =?utf-8?B?S3VkZHJmVDVlWk9nSzErS0ZxRzkxaUZVNHVEVngwT1U4S2pROTdLMEpQdjBQ?=
 =?utf-8?B?amE3TjduMFdIUS8xWWJ1VFdtRGdYV3hpcHArQzBES3R3N0R0bXMvcEhFQTFq?=
 =?utf-8?B?bERoSk00VGRaZ1dldVh0YjZVK1ZCKzQwUnJHS0kzbzBETHNsRFFTbHlOanFt?=
 =?utf-8?B?RlBEcWllVUNLcldCdlp2cWM0OWZ3UWZnazkvVFliTFQ4eEVWVERvVnFaeGYz?=
 =?utf-8?B?N2lJS0N1NGpRNTAxdVFjU3BjNlUvaWN2c1VpdEcrZEluNHpkSWU0enhKS1dP?=
 =?utf-8?B?VmQrY25ZQ1luMUQrNXAvUkcwbUl0Y2ZOeEZ5QW93L3FNaWFHd1VhZFV0eWdj?=
 =?utf-8?B?c0tiR1ovM2xMU2FFY0NIdFpTR1dVVXZaclF3VXdiMmVmQklUSHM4dU9zV2Z2?=
 =?utf-8?B?NjREQ0lCYjhrZnZ6bW1TbExjQzlYZytyMGY3WkJZRzlmd1lFeFZNaFM3Wk5x?=
 =?utf-8?B?QUxESTJGTjBBSkRLa3pKTlR0RDRNOEZaQnhaYkM1c0FSUHIwY2hGM0VNSjky?=
 =?utf-8?B?WURHSC9CejJ4ZUNZaVBLQnpSNjFDVUZGZHQ3ZENSVHgyY0ZCeGFKOTg4WXRQ?=
 =?utf-8?B?Wk5kelZxanhkSFdGczVHQlFncjJPYlBoWHhEbUtGRFBXVW5XRVcwMEdsNkUz?=
 =?utf-8?B?K1RGeEdGdXozaFZOT3NsQWhjVGU1bEFIVGF1YWovd2ZUaDRjQ0hReFR4Qld3?=
 =?utf-8?B?aEtySEVQZHVrU2JnbnBnaVRJUVJFZUVENnkwRkVlOXE4cVJLSG4zSndsVmda?=
 =?utf-8?B?dlllYzVsNE5TSFAyNUVVQ2IxSTJYLzlnb0p1bnNhUjdld2FLQ09FMWlnVVpE?=
 =?utf-8?B?bFpSZVBHbnljY25ORkxqK09lNm9rNmdkaDBTamh5dlkzTXJtd2JLcmdDa0wr?=
 =?utf-8?B?ck5nRzFlV21QWWc5SXNBeEo0MEJKRlorNHdjRGdYV0lEQytBczdJaWd2cmxU?=
 =?utf-8?B?WWtoaDdrbFJmdDRJbS96Nzc1ZzBRMVZmeWdqVWUrVTRjUmhLZzdmMStnWWc0?=
 =?utf-8?B?elZZQlNrUERiTnF0RTRMeXV2NHpqRjdmT21mZUdZNUowWGpYc3VyNno3cjJK?=
 =?utf-8?B?eFRKRzd3UWtjaFllWUQwUWlNdzVEOGhrK042R2JlMUI0R3hua2xRakR0dUdJ?=
 =?utf-8?B?T3p2cVJlaGZyTm1EeFFUN1VBSTJ3M1MydTZ0cVp6ZmhyK2lZdWxwdkZMRGhV?=
 =?utf-8?B?bm5FUXRTK3NYR0g2Mml3dW5GdkpCK0UvUGlyaUl1cGVZWTJkSHNEcGp1SUJD?=
 =?utf-8?B?aytzbFBtZ3BaNm5kVzhqclpzUC9HcGhOcEZVZkg4Q0VCa3VEQ3dRRUg4elFv?=
 =?utf-8?B?WWo4MjdsNnpHcTFIMktubG1UQ2hFRnNSenFuRXJ4UzZWZjFneTFmcG54SnJU?=
 =?utf-8?B?MzlFcjZPbzEvcGZYbWduNUVlczVSRHNTdk55Rm9OYndEZzh6VUxodjJnZVFj?=
 =?utf-8?B?WUt0a0ZocXIzTktuYUtNSUYvUmFrem1zcS9YZ2MvWHF0cmhHaG40OCtoaTNa?=
 =?utf-8?B?UTQ4eDZCdExZOWZEZ09xTVVsaStMbTM5OFlxQy9Cd1BKVS8vZG9XeXJtTm9o?=
 =?utf-8?B?ODduT0l0R2xqMkVCZzNGdEY2QzNrVk8xZDJVNEtLNUZtbThCenViSktvUTdF?=
 =?utf-8?B?bXUxMDZGRmZhdDV2QVJ2RXBmMHM1NEJsUzlFR0ZSR3FtclBFRVg2VXRYVkEx?=
 =?utf-8?B?cTl4V292aHluWjVSbURqdWNtQW1nRVY0TFdiQUx3cmZaazVTb3hJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51da0351-a42d-43a3-84b2-08de9febd0d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:20:30.3825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uEezsa5+OCkz1EQcSQ+oja1PGl2FUOEgDtG0wdVIO7V2JgjHN2ALaZdE+pEySziiZqtSkDOaLYk0uGUfi0XAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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
> In vkms_plane_atomic_check(), validate that when a color pipeline
> is active and the framebuffer format is YUV:
>    - The first colorop must be DRM_COLOROP_CSC_FF
>    - The CSC FF colorop must not be bypassed
> 
> In vkms_plane_atomic_update(), when a color pipeline is active,
> read the csc_ff_type from the first colorop state and map it to
> the appropriate (color_encoding, color_range) pair for the existing
> get_conversion_matrix_to_argb_u16() function.
> 
> In apply_colorop(), add a no-op case for DRM_COLOROP_CSC_FF since
> the actual YUV-to-RGB conversion is already performed at format
> read time via the conversion matrix.
> 
> Assisted-by Claude:claude-opus-4.6
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/vkms/vkms_composer.c |  6 +++
>   drivers/gpu/drm/vkms/vkms_plane.c    | 70 +++++++++++++++++++++++++++-
>   2 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 83d217085ad0..e29376f1cbd7 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -187,6 +187,12 @@ static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop *colo
>   		if (colorop_state->data)
>   			apply_3x4_matrix(pixel,
>   					 (struct drm_color_ctm_3x4 *)colorop_state->data->data);
> +	} else if (colorop->type == DRM_COLOROP_CSC_FF) {
> +		/*
> +		 * CSC FF is a no-op here. YUV-to-RGB conversion is handled
> +		 * at format read time via the conversion_matrix set in
> +		 * vkms_plane_atomic_update().
> +		 */
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index ca7aee101a95..0f1ebdd9e391 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -6,6 +6,7 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_blend.h>
> +#include <drm/drm_colorop.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
> @@ -148,8 +149,58 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   	frame_info->rotation = new_state->rotation;
>   
>   	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
> -	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_state->color_range,
> -					  &vkms_plane_state->conversion_matrix);
> +
> +	if (new_state->color_pipeline) {
> +		struct drm_colorop *colorop = new_state->color_pipeline;
> +		struct drm_colorop_state *colorop_state;
> +
> +		drm_WARN_ON(plane->dev, colorop->type != DRM_COLOROP_CSC_FF);
Is this drm_WARN_ON necessary? How about a drm_dbg?

Either way, this patch is
Reviewed-by: Alex Hung <alex.hung@amd.com>
> +
> +		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> +
> +		if (colorop_state && !colorop_state->bypass) {
> +			enum drm_color_encoding encoding;
> +			enum drm_color_range range;
> +
> +			switch (colorop_state->csc_ff_type) {
> +			case DRM_COLOROP_CSC_FF_YUV601_RGB601:
> +				encoding = DRM_COLOR_YCBCR_BT601;
> +				range = DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
> +			case DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
> +				encoding = DRM_COLOR_YCBCR_BT601;
> +				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
> +				break;
> +			case DRM_COLOROP_CSC_FF_YUV709_RGB709:
> +				encoding = DRM_COLOR_YCBCR_BT709;
> +				range = DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
> +			case DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
> +				encoding = DRM_COLOR_YCBCR_BT709;
> +				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
> +				break;
> +			case DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
> +				encoding = DRM_COLOR_YCBCR_BT2020;
> +				range = DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
> +			case DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
> +				encoding = DRM_COLOR_YCBCR_BT2020;
> +				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
> +				break;
> +			default:
> +				encoding = DRM_COLOR_YCBCR_BT709;
> +				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
> +				break;
> +			}
> +
> +			get_conversion_matrix_to_argb_u16(fmt, encoding, range,
> +							  &vkms_plane_state->conversion_matrix);
> +		}
> +	} else {
> +		get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding,
> +						  new_state->color_range,
> +						  &vkms_plane_state->conversion_matrix);
> +	}
>   }
>   
>   static int vkms_plane_atomic_check(struct drm_plane *plane,
> @@ -175,6 +226,21 @@ static int vkms_plane_atomic_check(struct drm_plane *plane,
>   	if (ret != 0)
>   		return ret;
>   
> +	if (new_plane_state->color_pipeline && new_plane_state->fb->format->is_yuv) {
> +		struct drm_colorop *colorop = new_plane_state->color_pipeline;
> +		struct drm_colorop_state *colorop_state;
> +
> +		if (colorop->type != DRM_COLOROP_CSC_FF)
> +			return -EINVAL;
> +
> +		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> +		if (!colorop_state)
> +			return -EINVAL;
> +
> +		if (colorop_state->bypass)
> +			return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   

