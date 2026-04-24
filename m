Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A930FED3D9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD0910F5EA;
	Fri, 24 Apr 2026 14:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="F/E+6uqc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A08410F5E4;
 Fri, 24 Apr 2026 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0jKpBDpmzKq8kjiqbw3Z3ba1caxadP+koz8SDo0MCBg=; b=F/E+6uqcVVCo9My+Z1sa5ZyDnL
 K+VhYZRp9YMMV56i3cnNOv5tZXGLMMawasQ2LoMUEMqvFxCEZQMcDC8cGkupDYuRNZ8KkJENurwCx
 m3LHtpuQ48CH26Ax0Zirz7xFAs84gIBNNfldrfg1NykAgAPU8+MAQ17Jp2zTMLlH8tEaDujMjW+xS
 hxqrEOokp4gY6/ECOW3F7k9EEY3eDHFPNVGrPii4ndNH6UesmGLQ4H7MJ+UZS7uddaUP3D7sLbhtR
 HjCG6XiYpqG/vQ72k4IDA/lvpwH6Q1JgXwXyOn7e0rOlXHhEebYtNvb8rBMI4mlsYsC7O2P3GonGh
 k72C/PhQ==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wGHpB-001dee-Sh; Fri, 24 Apr 2026 16:48:09 +0200
Message-ID: <ccf3e322-154e-4ad1-8470-dea9446e2092@igalia.com>
Date: Fri, 24 Apr 2026 11:48:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/9] drm/amd/display: Use GAMCOR for first TF if
 CSC is used
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-8-harry.wentland@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330153451.99472-8-harry.wentland@amd.com>
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



On 30/03/2026 12:34, Harry Wentland wrote:
> For subsampled formats we need to use GAMCOR instead of
> the DEGAM block. The color module can create a LUT for
> that if we set map_user_ramp to true. So do that when
> we have subsampled formats.
>
> Co-developed by Claude Sonnet 4.5.
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
> +	/* Check if format requires post-scale color processing (subsampled formats) */
> +	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
> +				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
> +
>   	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
>   
> +	if (is_subsampled_format) {
Hi,

I'm checking this fix and I think current __set_dm_plane_degamma() with 
AMD driver-specific properties also needs it, right?
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

I understand we don't need to check DPP color caps here because colorop 
is currently only supported by DCN3 and newer, and I guess they all 
support full range of predefined ROM LUT, right?
But checking `dc_caps->dpp.dgam_rom_caps` as 
mod_color_calculate_degamma_params() does before fallback to GAM_COR 
looks more robust to me.

Melissa

> +	}
> +
>   	return 0;
>   }
>   

