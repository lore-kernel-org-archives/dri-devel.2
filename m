Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B23210D14AA
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D60F10E0EA;
	Mon, 30 Mar 2026 12:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="n/wPr5EY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A2D10E0EA
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iFQrWsw0KE4Si0ywRfhjli9ncPYhDVwzNbhJm3tTFmM=; b=n/wPr5EYFxJpZvZ21eFsa7V3yq
 QC9fe1aAFlRk/AMtr/uxUU/h+ba4ZOhntvqv5vOE/k7Aokfj/36HsU+iisRq+lGzI/HekFwNXzeHh
 bDOnbHUAs6KP8iyTDs7xHCamzMqrXu1VGAjgxvcH+1ta9yONNVEOkGrjbvy9mhEaijjHaa5qr6TNG
 W9fCELmGMlH/og9TvuX57B3EbO5FD8IRVEDjL6mOIKdkSIm/l8vtv0F8lOZgY5Jq2kG5F0HTTtQVq
 0ds1eZ4MQx1B1EDOFKFr9nyiL8r7G/IOUPLEZURsL6S2R05HvLkgOXjDsmKwW9r8U6BdFexF+WI2F
 EpcWngPw==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7Boc-008yW9-LI; Mon, 30 Mar 2026 14:33:58 +0200
Message-ID: <3aa6e599-b741-4d6c-95d9-43544423bf32@igalia.com>
Date: Mon, 30 Mar 2026 09:33:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/colorop: Mark interpolation properties as immutable
 and atomic
To: Alex Hung <alex.hung@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 contact@emersion.fr, harry.wentland@amd.com, sebastian.wick@redhat.com,
 daniels@collabora.com, chaitanya.kumar.borah@intel.com,
 dri-devel@lists.freedesktop.org, Xaver Hugl <xaver.hugl@gmail.com>
References: <20260327003946.3458610-1-alex.hung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260327003946.3458610-1-alex.hung@amd.com>
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



On 26/03/2026 21:39, Alex Hung wrote:
> LUT1D_INTERPOLATION and LUT3D_INTERPOLATION are read-only properties but
> were missing DRM_MODE_PROP_IMMUTABLE and DRM_MODE_PROP_ATOMIC flags.
+ Xaver

So, I double checked previous conversation about these two interpolation 
properties.
AFAIU, we agreed (?) on not making it immutable because it could become 
mutable if a HW allows it.
- 
https://lore.kernel.org/dri-devel/CAFZQkGyj7=N2UcbBnjv7Az3oHSD2LXaAx5wzccpSt_UEhH3NZw@mail.gmail.com/

So, what's the best approach to inform userspace that they cannot change 
this property?
Perhaps the driver has to reject if in the end the property is immutable (?)

Melissa
>
> Add the correct flags and remove the now-unreachable set_property
> handlers in drm_atomic_colorop_set_property().
>
> Link: https://lore.kernel.org/amd-gfx/dbb27ec4-cdc6-4ead-9daf-664d97e86cd0@intel.com/
> Fixes: 7fa3ee8c0a79 ("drm/colorop: Define LUT_1D interpolation")
> Fixes: db971856bbe0 ("drm/colorop: Add 3D LUT support to color pipeline")
> Suggested-by: Melissa Wen <mwen@igalia.com>
> Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 4 ----
>   drivers/gpu/drm/drm_colorop.c     | 6 ++++--
>   2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 713fa9e81732..e831894d5a51 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -758,8 +758,6 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>   			state->bypass = val;
>   			*replaced = true;
>   		}
> -	} else if (property == colorop->lut1d_interpolation_property) {
> -		colorop->lut1d_interpolation = val;
>   	} else if (property == colorop->curve_1d_type_property) {
>   		if (state->curve_1d_type != val) {
>   			state->curve_1d_type = val;
> @@ -770,8 +768,6 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>   			state->multiplier = val;
>   			*replaced = true;
>   		}
> -	} else if (property == colorop->lut3d_interpolation_property) {
> -		colorop->lut3d_interpolation = val;
>   	} else if (property == colorop->data_property) {
>   		return drm_atomic_color_set_data_property(colorop, state,
>   							  property, val,
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 398cc81ae588..34998f393f2e 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -317,7 +317,8 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
>   	colorop->size = lut_size;
>   
>   	/* interpolation */
> -	prop = drm_property_create_enum(dev, 0, "LUT1D_INTERPOLATION",
> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_IMMUTABLE,
> +					"LUT1D_INTERPOLATION",
>   					drm_colorop_lut1d_interpolation_list,
>   					ARRAY_SIZE(drm_colorop_lut1d_interpolation_list));
>   	if (!prop)
> @@ -413,7 +414,8 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>   	colorop->size = lut_size;
>   
>   	/* interpolation */
> -	prop = drm_property_create_enum(dev, 0, "LUT3D_INTERPOLATION",
> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_IMMUTABLE,
> +					"LUT3D_INTERPOLATION",
>   					drm_colorop_lut3d_interpolation_list,
>   					ARRAY_SIZE(drm_colorop_lut3d_interpolation_list));
>   	if (!prop)

