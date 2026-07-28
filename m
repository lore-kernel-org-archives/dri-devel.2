Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B97C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB9710E957;
	Tue, 28 Jul 2026 16:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="Ms3cwcj9";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FE610E94E;
 Tue, 28 Jul 2026 16:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785254504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gSmMXg+UmxjYBktFZ0lD8O3IoHgRJ6s/ltEiynZr9pspMeDdKB97VsS93JKKIRQE8RZE79s1uR2FcjjS7Nnz3ekn3eONrVMqyQfKSIVqNiDeNR9rRSLmnNmQxTz8yXRSFXWGgLcT8U3QxlChI9UInsxpqlclC03ptdoZDG38Qls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785254504;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=Cxn+mOcyzlFrRmfU0UiqCeiHpUP27pgemV8hREHAPQI=; 
 b=WcbfyJSQYEpHTardZpe7OAgP/6MXFaQ8+bffUTAYgFEELM48DD9d+5479FH+ImmpjkMo1D4KPMtXavlP/IHR9RP3HRaxaUtQUOnMGt2bmCRusJs9bw+tonZqzPcwqIx8My7RXW3Ga9ZlTwu4cU4jrw/3gIOCsMOq/VPzpGU8U8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785254504; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=Cxn+mOcyzlFrRmfU0UiqCeiHpUP27pgemV8hREHAPQI=;
 b=Ms3cwcj9CAL/HyDHe9KQgXhPrVk+3xg8i5nQrcc0sZ8VBcJ9y6N7NErU22KnEiaS
 M2eu1cWgN1dKZeVXA3uWDxdqIu8Ir2nWcTbo6rTczF2y62F3c608Jwnc4GSqd/T46AU
 Q3jhFbg5xCP6zW81XTTLlAtqdSj+GR7iaFY303HY=
Received: by mx.zohomail.com with SMTPS id 1785254502694328.57155294987615;
 Tue, 28 Jul 2026 09:01:42 -0700 (PDT)
Message-ID: <04192c5c-1c1e-42f6-883f-e8d15f3d9309@collabora.com>
Date: Tue, 28 Jul 2026 18:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] drm/amd/display: Use GAMCOR for first TF if YUV
 conversion is needed
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-9-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-9-harry.wentland@amd.com>
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
> For subsampled formats we need to use GAMCOR instead of
> the DEGAM block. The color module can create a LUT for
> that if we set map_user_ramp to true. So do that when
> we have subsampled formats.
>
> Assisted-by: Claude:claude-sonnet-4.5
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 62791077ceef..8913bc9f0f06 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1524,6 +1524,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
>   	struct drm_colorop *colorop = colorop_state->colorop;
>   	struct drm_device *drm = colorop->dev;
> +	struct dc_color_caps *color_caps = NULL;
> +	bool is_subsampled_format;
>   
>   	if (colorop->type != DRM_COLOROP_1D_CURVE)
>   		return -EINVAL;
> @@ -1537,10 +1539,23 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   	}
>   
>   	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
> -
>   	tf->type = TF_TYPE_PREDEFINED;
> +
> +	/* Check if format requires post-scale color processing (subsampled formats) */
> +	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
> +				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
> +
>   	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
>   
> +	if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
> +		color_caps = &dc_plane_state->ctx->dc->caps.color;
> +
> +	if (!mod_color_calculate_degamma_params(color_caps, tf, NULL,
> +						is_subsampled_format)) {
> +		drm_err(drm, "Failed to calculate degamma params\n");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

