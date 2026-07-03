Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40AFC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C2A10F758;
	Fri,  3 Jul 2026 10:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="hxD7CtN0";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A590C10E108;
 Fri,  3 Jul 2026 10:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783073746; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PFd+ZcJDRmA7MyKt/mcuc53dGEnBrjeE9da1qKrLYVPkdyp8rIbsU/2g9t0BqWxTZpuXba7PW80IcfvqWgxhChtTAaJEtOIty+b1RTv8euYR39NhA1e+4boANZlfudVajwjYFU+1C1lGA0vB7y8CFFj/A3PQ+fUE+NoMyFl2iRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783073746;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=25BbhWpiZ/sGaLXWDgbOghNeZUCTG/8RaXJnV8Z1cOM=; 
 b=cx75bTwjUd8G+LmWoqanYpkK3AJkf1azEOxLfRHqk1w3o5Yb/khDIzN3TV/yMgNL9EvFvZJF6VuChpFKhPEvO79zYa1w+me/P7Xevpuco42EsAP+KOLGXG+HRfPccpLYEnrnw8WsdXbbWHU3ohttiS1pVXrQE4KgUFaLWrGWiks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783073746; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=25BbhWpiZ/sGaLXWDgbOghNeZUCTG/8RaXJnV8Z1cOM=;
 b=hxD7CtN0NRJ8PfBP+udrm9pn28iQiq6Y0urLHEiUoEYIdEN+Sro2khyUjU94QBqK
 I9TOP0l+lgd5DgbIX7aeimPL6L2J4qRuQxSQCKZIFkHu9sxkBYi2OCjhkAEZPgHJBH0
 gZ5IiSxjpqkEEBlhqqr6eNiohxeR4nIV640+fojQ=
Received: by mx.zohomail.com with SMTPS id 178307374474175.29703126604352;
 Fri, 3 Jul 2026 03:15:44 -0700 (PDT)
Message-ID: <f7071433-0bb6-4a1e-baa9-3ec16a3ab0f4@collabora.com>
Date: Fri, 3 Jul 2026 12:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Melissa Wen <mwen@igalia.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-2-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260623164812.81110-2-harry.wentland@amd.com>
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

Hi Harry,

On 23.06.26 18:48, Harry Wentland wrote:
> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>
> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
> hardware that performs a fixed matrix operation.
>
> Unlike CTM-based colorops, this block does not expose programmable
> coefficients. Instead, userspace selects one of the predefined
> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
> include common YCbCr->RGB and RGB709->RGB2020 conversions.
>
> v2:
>   - Naming changes (Pekka)
>
> v3:
>   - Fix NC matrix enum name and string (Melissa)
>   - Rebase
>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/drm_atomic.c      |   4 ++
>   drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
>   drivers/gpu/drm/drm_colorop.c     | 106 ++++++++++++++++++++++++++++++
>   include/drm/drm_colorop.h         |  84 +++++++++++++++++++++++
>   include/uapi/drm/drm_mode.h       |  12 ++++
>   5 files changed, 210 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3af1b9cc9a06..ced591c4a0bd 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   				  drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
>   		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
>   		break;
> +	case DRM_COLOROP_FIXED_MATRIX:
> +		drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
> +				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index c7f80d90794c..cee4550ffdbd 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -761,6 +761,8 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>   	} else if (property == colorop->data_property) {
>   		return drm_atomic_color_set_data_property(colorop, state,
>   							  property, val);
> +	} else if (property == colorop->fixed_matrix_type_property) {
> +		state->fixed_matrix_type = val;
>   	} else {
>   		drm_dbg_atomic(colorop->dev,
>   			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
> @@ -793,6 +795,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
>   		*val = colorop->lut3d_interpolation;
>   	else if (property == colorop->data_property)
>   		*val = (state->data) ? state->data->base.id : 0;
> +	else if (property == colorop->fixed_matrix_type_property)
> +		*val = state->fixed_matrix_type;
>   	else
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index c0eecde8c176..c11c3012fcc5 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
>   	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>   	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
>   	{ DRM_COLOROP_3D_LUT, "3D LUT"},
> +	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>   };
>   
>   static const char * const colorop_curve_1d_type_names[] = {
> @@ -90,6 +91,14 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>   	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>   };
>   
> +static const char * const colorop_fixed_matrix_type_names[] = {
> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
> +	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",

The last two ops do not get implemented in the series, even though they 
were the original ones mentioned in the commit message. I'd suggest to 
drop them - they can get re-added once there's a testable 
implementation. Instead I'd include the limited-range ones from the 
following commit, making the series cleaner.

Just suggestions, though. So either way:

Reviewed-by: Robert Mader <robert.mader@collabora.com>

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

