Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11D8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2FF10F792;
	Fri,  3 Jul 2026 10:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="iypzNA0P";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBB910F78F;
 Fri,  3 Jul 2026 10:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783074741; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FoCjGnPKemCAZIRwC78MHUAvRAuBaxExkuLCvLKfhu9NvffzXgqTI8JDGIgM0MqfuwmdYkTbxkakxglAy8WEGdOBOCxmeK4HTHbzxm7hTRlGnkVRN4aAcgdbUqmbyRZGcJ3hwfXQ7lJ4NMNLZSQjD8GHOBMPczY2bC8b2hFKQAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783074741;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IuAGPDANfrWjwlZR69ctiaux44/R0LvyIArgBf6aOpE=; 
 b=LCBk2IBrEQ5xghYDPWJlVyK2MhlQXiu8+UaJu+EsA15DwFs5U19+++wlhwZNgOXlkSqD7/Ies/rE+fkFfUTDZdc/maZSSIZEK2uiiRXUZkTSF4RraHW75kDW26R8nEyvs/mFGzgG+7hlG7fLvSqi7kYXbGttDWYaWwQp2vVlea0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783074741; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=IuAGPDANfrWjwlZR69ctiaux44/R0LvyIArgBf6aOpE=;
 b=iypzNA0PMBkYqqh03aBqdgW6MdrapbQQipUM35sRRC37a2cjhH8iGse3P9663nqu
 c8oatLy38nYBdNKd9C0JJYHaWajSj6sGkUWm7OV86XvQ+9ChVLUaaDgVig7UuNd+uZ3
 VsygJfYdll5jFLwX2rFHivCBrM2UH10KsCoM3vbE=
Received: by mx.zohomail.com with SMTPS id 1783074740228974.3397416169324;
 Fri, 3 Jul 2026 03:32:20 -0700 (PDT)
Message-ID: <7e5a77ea-195f-48d2-8e96-4f09b6165444@collabora.com>
Date: Fri, 3 Jul 2026 12:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] drm/vkms: Add atomic check and matrix handling
 for fixed matrix colorop
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-5-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260623164812.81110-5-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 23.06.26 18:48, Harry Wentland wrote:
> In vkms_plane_atomic_check(), validate that when a color pipeline
> is active and the framebuffer format is YUV:
>    - The first colorop must be DRM_COLOROP_FIXED_MATRIX
>    - The fixed matrix colorop must not be bypassed
>
> In vkms_plane_atomic_update(), when a color pipeline is active,
> read the fixed_matrix_type from the first colorop state and map
> it to the appropriate (color_encoding, color_range) pair for the
> existing get_conversion_matrix_to_argb_u16() function.
>
> In apply_colorop(), add a no-op case for DRM_COLOROP_FIXED_MATRIX
> since the actual YUV-to-RGB conversion is already performed at
> format read time via the conversion matrix.
>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/vkms/vkms_composer.c |  6 +++
>   drivers/gpu/drm/vkms/vkms_plane.c    | 68 +++++++++++++++++++++++++++-
>   2 files changed, 72 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 83d217085ad0..899120cd07ac 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -187,6 +187,12 @@ static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop *colo
>   		if (colorop_state->data)
>   			apply_3x4_matrix(pixel,
>   					 (struct drm_color_ctm_3x4 *)colorop_state->data->data);
> +	} else if (colorop->type == DRM_COLOROP_FIXED_MATRIX) {
> +		/*
> +		 * Fixed Matrix is a no-op here. YUV-to-RGB conversion
> +		 * is handled at format read time via the
> +		 * conversion_matrix set in vkms_plane_atomic_update().
> +		 */
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 68cb2a3335e6..4ef4cebe718b 100644
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
> @@ -148,8 +149,56 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
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
> +		colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> +
> +		if (colorop_state && !colorop_state->bypass) {
> +			enum drm_color_encoding encoding;
> +			enum drm_color_range range;
> +
> +			switch (colorop_state->fixed_matrix_type) {
> +			case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +				encoding = DRM_COLOR_YCBCR_BT601;
> +				range = DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
> +			case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
> +				encoding = DRM_COLOR_YCBCR_BT601;
> +				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
> +				break;
> +			case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +				encoding = DRM_COLOR_YCBCR_BT709;
> +				range = DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
> +			case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
> +				encoding = DRM_COLOR_YCBCR_BT709;
> +				range = DRM_COLOR_YCBCR_LIMITED_RANGE;
> +				break;
> +			case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +				encoding = DRM_COLOR_YCBCR_BT2020;
> +				range = DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
> +			case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
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
> @@ -175,6 +224,21 @@ static int vkms_plane_atomic_check(struct drm_plane *plane,
>   	if (ret != 0)
>   		return ret;
>   
> +	if (new_plane_state->color_pipeline && new_plane_state->fb->format->is_yuv) {
> +		struct drm_colorop *colorop = new_plane_state->color_pipeline;
> +		struct drm_colorop_state *colorop_state;
> +		if (colorop->type != DRM_COLOROP_FIXED_MATRIX)
> +
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

This simple implementation makes sense to me and looks correct.

Reviewed-by: Robert Mader <robert.mader@collabora.com>

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

