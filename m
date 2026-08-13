Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBC5C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1931F10F38F;
	Thu, 13 Aug 2026 15:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lNZ8yr6l";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92E810F38F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=KtKOQIt0m4NPOgD4wYzf6ZB8/ruzhBRsosCHoXqM2DM=; b=lNZ8yr6lxUcj/hNOSPoO+ECEFC
 wMvCx1mYS1qAHtqAjqPchGI/U1KtVc1YiPYotrYm/Vx/LWMDDBUAdY8qL7JtThuyboj+sTTOnFi1q
 Ya6A0mSk4pAjvB4nFvHHroWm4zoXCOkZ8mxSr8uyPBXPe+IplBM+p/rL0QP5+i8EqKq3UWeIVeAQe
 akcCAHUcOQ245Gve5Q+U2I9jNFK9OghTNvUamATkbL+3gLLnnmmdWvUqvr2WfE1n0ybIW64H9FLrU
 FriFahJqmlMykyFlp0V43obY4pCIFKJ7JFT/m2z+XFrdeYKjfkdjpQtLbvLMR+H7UTvJBirw7zz3L
 WKtTgcDw==;
Received: from [31.4.149.66] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuWyi-000t6j-Jk; Thu, 13 Aug 2026 17:04:20 +0200
Message-ID: <9a5ec6db-2f5b-459c-9d21-11e0de993523@igalia.com>
Date: Thu, 13 Aug 2026 17:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
 <20260813144405.EF8031F000E9@smtp.kernel.org>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260813144405.EF8031F000E9@smtp.kernel.org>
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



On 13/08/2026 16:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Calling drm_plane_create_blend_mode_property() without PREMULTI support triggers a kernel warning (WARN_ON) and fails to create the property.
> --
>
> --- Patch [3]: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend mode for DCE generations ---
> commit 44681caffc8bcfc7085bcfe1ec288a0eafc8c992
> Author: Melissa Wen <mwen@igalia.com>
>
> drm/amd/display: advertise PIXEL_NONE as blend mode for DCE generations
>
> This commit changes the blend mode property creation for primary planes on
> DCE generations. It modifies the driver to create the blend mode property
> with PIXEL_NONE only, instead of the DRM default PREMULTI mode.
>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 423e3cd7b9c98..e02cbafc8c5d0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> [ ... ]
>> @@ -2208,14 +2208,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> [ ... ]
>> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>> -	    plane_cap && plane_cap->per_pixel_alpha &&
>> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
>> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
>> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
> [Severity: High]
> Does this trigger a kernel warning and fail to create the property?
>
> Looking at drm_plane_create_blend_mode_property() in drm_blend.c, the DRM
> core explicitly enforces that DRM_MODE_BLEND_PREMULTI must be supported:
>
> int drm_plane_create_blend_mode_property(struct drm_plane *plane,
> 					 unsigned int supported_modes)
> {
> 	...
> 	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
> 		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
> 		return -EINVAL;
> 	...
> }
>
> Since amdgpu_dm_plane_init() now passes only BIT(DRM_MODE_BLEND_PIXEL_NONE),
> this will trigger the WARN_ON and return -EINVAL during device probe,
> meaning the property is not created at all.

No, you are probably looking at an outdated codebase.

Other blend modes are supported since:

9813e158d13d5 ("drm/drm_blend: allow blend mode property without 
PREMULTI") in drm-misc-next.

Melissa

>
>> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>> +		   plane_cap && plane_cap->per_pixel_alpha) {
>>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>>   					  BIT(DRM_MODE_BLEND_COVERAGE);

