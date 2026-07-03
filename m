Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92AFC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B1210F781;
	Fri,  3 Jul 2026 10:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="KiqAVMF9";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC1010F781;
 Fri,  3 Jul 2026 10:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783074284; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MfsIRhwnhrm54asCSnF5t1iqWUY8VK1heUHP5NWAqZL2URHoatXswe2DSt08iMn/hrr4S3bAP7LTPw01iLhxkJjsIzNR2ezz4HsvgUTfyQ6OwwI/x2hQ6cVsPkiP3XwbLEZ0UokJ0PalVtJkEvMenbBlSRL6G/MlA/jANUmrxB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783074284;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=swOGO7PCaEub/Lbtsrzxaux6bZHWTZvw9u3yGMn6dMw=; 
 b=ieGQQADyhMUK9g4S8Vm70N/uczhqmRkOIEK+O3kB7QDjt3BW7D267g9fvAp7ywv/y0Wmag3b3tadU8XuDtk5OnEaFHfr8Z03A17sgVekbJ0oxtBiOXsoQ4g7Cu8KjGxvwS8i7Nu4N+BGvadCC+YiODF5LSRegPGrTlAla/XDjoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783074284; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=swOGO7PCaEub/Lbtsrzxaux6bZHWTZvw9u3yGMn6dMw=;
 b=KiqAVMF95l1FSieB4sECEond166GQ5T6Z2hhHw+2y2omMg3Rz3TZNlNrYpbdHkTc
 V3yZqugSypNR0SgNXvrHqJiTRD2q4l76EFT4TMXADw2D/Ag0YX9wi6SWkIe+IRfR82U
 +j46eexKhwkDrzBgDk6XFmAnw7KZTls/phrduJSk=
Received: by mx.zohomail.com with SMTPS id 1783074283065948.6330683029324;
 Fri, 3 Jul 2026 03:24:43 -0700 (PDT)
Message-ID: <32c130ee-721c-4333-a63d-450c72fd88d7@collabora.com>
Date: Fri, 3 Jul 2026 12:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] drm/vkms: Add fixed matrix colorop to color
 pipeline
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-4-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260623164812.81110-4-harry.wentland@amd.com>
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
> Insert a fixed matrix colorop as the first operation in the
> VKMS color pipeline, before the existing 1D curve. This allows
> userspace to select YUV-to-RGB conversion via the color pipeline
> for YCbCr framebuffers.
>
> The CSC Fixed Matrix colorop advertises support for all six
> YUV-to-RGB conversion presets:
>    - YUV601/709/2020 full-range to RGB
>    - YUV601/709/2020 limited-range to RGB
>
> Bump MAX_COLOR_PIPELINE_OPS from 4 to 5 to accommodate the new op.
>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/vkms/vkms_colorop.c | 66 ++++++++++++++++++++---------
>   1 file changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
> index 071f3a8d2e7c..9424b1994239 100644
> --- a/drivers/gpu/drm/vkms/vkms_colorop.c
> +++ b/drivers/gpu/drm/vkms/vkms_colorop.c
> @@ -12,11 +12,19 @@ static const u64 supported_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF);
>   
> +static const u64 supported_fm =
> +	BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
> +
>   static const struct drm_colorop_funcs vkms_colorop_funcs = {
>   	.destroy = drm_colorop_destroy,
>   };
>   
> -#define MAX_COLOR_PIPELINE_OPS 4
> +#define MAX_COLOR_PIPELINE_OPS 5
>   
>   static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
>   {
> @@ -27,7 +35,25 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	memset(ops, 0, sizeof(ops));
>   
> -	/* 1st op: 1d curve */
> +	/* 1st op: Fixed Matrix (YUV to RGB) */
> +	ops[i] = kzalloc_obj(*ops[i]);
> +	if (!ops[i]) {
> +		drm_err(dev, "KMS: Failed to allocate colorop\n");
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &vkms_colorop_funcs,
> +						  supported_fm,
> +						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type = ops[i]->base.id;
> +
> +	i++;
> +
> +	/* 2nd op: 1d curve */
>   	ops[i] = kzalloc_obj(*ops[i]);
>   	if (!ops[i]) {
>   		drm_err(dev, "KMS: Failed to allocate colorop\n");
> @@ -41,23 +67,6 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   	if (ret)
>   		goto cleanup;
>   
> -	list->type = ops[i]->base.id;
> -
> -	i++;
> -
> -	/* 2nd op: 3x4 matrix */
> -	ops[i] = kzalloc_obj(*ops[i]);
> -	if (!ops[i]) {
> -		drm_err(dev, "KMS: Failed to allocate colorop\n");
> -		ret = -ENOMEM;
> -		goto cleanup;
> -	}
> -
> -	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
> -					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> -	if (ret)
> -		goto cleanup;
> -
>   	drm_colorop_set_next_property(ops[i - 1], ops[i]);
>   
>   	i++;
> @@ -79,7 +88,24 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	i++;
>   
> -	/* 4th op: 1d curve */
> +	/* 4th op: 3x4 matrix */
> +	ops[i] = kzalloc_obj(*ops[i]);
> +	if (!ops[i]) {
> +		drm_err(dev, "KMS: Failed to allocate colorop\n");
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
> +					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +
> +	i++;
> +
> +	/* 5th op: 1d curve */
>   	ops[i] = kzalloc_obj(*ops[i]);
>   	if (!ops[i]) {
>   		drm_err(dev, "KMS: Failed to allocate colorop\n");

LGTM.

Reviewed-by: Robert Mader <robert.mader@collabora.com>

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

