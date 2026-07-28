Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADF5C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119A710E84E;
	Tue, 28 Jul 2026 16:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="f8K+5EF4";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FB010E6E9;
 Tue, 28 Jul 2026 16:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785254484; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=P9BMu8VpsjJ1cj2mqv6C5N7ClN+3XTzhnbL+hDpdJ3JtQm07/NOZXFo2X6rq6UfBXu1902F//6knymQu1qEUY7kTW+w91VxWofzJ4ROuqFwp3lsp400i44DLadFrqhoBTVftm3aHYJAE8HOPM0E2G5nMTdy3jihvQFcgfrJJVh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785254484;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6hKUTDz/whvpLphi5lGuQoWIThyDQyNuSzuiS3snFU0=; 
 b=IleG0Teg2c4zXOXynjsn/NiO9DQ0Oy67Mdg5bcLQdgZKfSy79JZaG0teRWVsxzpOFVcG1PN9VbZEiVrbQSuXsSx/ckNGCsIl9nakvZKLrGfMocCca2atJ/r70u2C3LqP3aPUZOB9ansdfGYz0LeUZ1aPYHvMtH9Eojy54CFDEW8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785254484; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6hKUTDz/whvpLphi5lGuQoWIThyDQyNuSzuiS3snFU0=;
 b=f8K+5EF4DBaRp0LOPDvq2tIjhAWTf7KGYRAP6sqMTvXy4pf/efTvut7xnbP0xJoW
 fabVsElY/JMP6C/gujrDFHuxFsC0WmjE0QImkDJPvPNXpWvBgDVGZIL2Sw2be8MajBp
 jjVOZpyvXCMjPo3WZIMJnGW3KvMMgnbmPYcFAjV0=
Received: by mx.zohomail.com with SMTPS id 1785254483564892.3259683335059;
 Tue, 28 Jul 2026 09:01:23 -0700 (PDT)
Message-ID: <f481c73b-9188-44d3-9e1d-671cb5f681a4@collabora.com>
Date: Tue, 28 Jul 2026 18:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/amd/display: Implement fixed matrix colorop
 color space mapping
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-8-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-8-harry.wentland@amd.com>
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

Hi, as per my previous comment:

Tested-by: Robert Mader <robert.mader@collabora.com>

On 22.07.26 15:46, Harry Wentland wrote:
> Add __set_dm_plane_colorop_fixed_matrix() which maps the fixed matrix
> type enum to the appropriate dc_color_space for DC programming:
>
>    YCBCR601_FULL_RGB     -> COLOR_SPACE_YCBCR601
>    YCBCR601_LIMITED_RGB  -> COLOR_SPACE_YCBCR601_LIMITED
>    YCBCR709_FULL_RGB     -> COLOR_SPACE_YCBCR709
>    YCBCR709_LIMITED_RGB  -> COLOR_SPACE_YCBCR709_LIMITED
>    YCBCR2020_FULL_RGB_NC -> COLOR_SPACE_2020_YCBCR_FULL
>    YCBCR2020_LIMITED_RGB_NC -> COLOR_SPACE_2020_YCBCR_LIMITED
>
> When the fixed matrix is bypassed, color_space is set to
> COLOR_SPACE_UNKNOWN.
>
> Update amdgpu_dm_plane_set_colorop_properties() to process the
> fixed matrix colorop first (before DEGAM), matching the new pipeline
> order.
>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 68 ++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 357c7c5c85cf..62791077ceef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1545,6 +1545,61 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   }
>   EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
>   
> +static int
> +__set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
> +				    struct dc_plane_state *dc_plane_state,
> +				    struct drm_colorop *colorop)
> +{
> +	struct drm_colorop *old_colorop;
> +	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_atomic_commit *state = plane_state->state;
> +	int i = 0;
> +
> +	old_colorop = colorop;
> +
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> +		if (new_colorop_state->colorop == old_colorop) {
> +			colorop_state = new_colorop_state;
> +			break;
> +		}
> +	}
> +
> +	if (!colorop_state)
> +		return -EINVAL;
> +
> +	if (colorop_state->bypass) {
> +		dc_plane_state->color_space = COLOR_SPACE_SRGB;
> +		return 0;
> +	}
> +
> +	switch (colorop_state->fixed_matrix_type) {
> +	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR601;
> +		break;
> +	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR601_LIMITED;
> +		break;
> +	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR709;
> +		break;
> +	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR709_LIMITED;
> +		break;
> +	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_FULL;
> +		break;
> +	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
> +		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dc_plane_state->update_bits.full_update = 1;
> +
> +	return 0;
> +}
> +
>   static int
>   __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
>   			       struct dc_plane_state *dc_plane_state,
> @@ -1946,10 +2001,21 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
>   	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
>   	int ret;
>   
> -	/* 1D Curve - DEGAM TF */
> +	/* Fixed Matrix (YUV to RGB) */
>   	if (!colorop)
>   		return -EINVAL;
>   
> +	ret = __set_dm_plane_colorop_fixed_matrix(plane_state, dc_plane_state, colorop);
> +	if (ret)
> +		return ret;
> +
> +	/* 1D Curve - DEGAM TF */
> +	colorop = colorop->next;
> +	if (!colorop) {
> +		drm_dbg(dev, "no degamma colorop found\n");
> +		return -EINVAL;
> +	}
> +
>   	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
>   	if (ret)
>   		return ret;

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

