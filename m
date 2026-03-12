Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81503106ACF0
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF88710E013;
	Thu, 12 Mar 2026 22:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YbkgH+4l";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE9F10E013;
 Thu, 12 Mar 2026 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p7wRoEZgewxf59OVHhQU39V13wfm466Zo/bHBcba/YQ=; b=YbkgH+4lfp3NBSh5sYSzoeTSB2
 2ZQmUol9OgtP3t3DVLwonOTh1D3qzzH7XlQK9W+JoOZUxky8bVr5xANqFiAWl3uSuYIsAj11udE/r
 aVUVwy0+Z0k1YB6K9eQXS2ihWY/Q59LA93xSkZX+UimNPU2urbVYotFX9CCvtP5wrM3mn+c5WVIYQ
 FMv3ErNb2s7FZCsayVy27Bl31Hh/Zssu9uhP+l4a4eGttfLfTRVnOPHrrdnp+srh4w3Ve81y5YtOY
 +Xa5EwopQPnFWelzlGCmfKBOMVkbZqBlWFppa+iBgk6Mh98vP8tY0ML0pGGbBv5SEtz75Uf0+e7oQ
 emV7gPRw==;
Received: from [186.208.68.119] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w0od6-00Enwn-CQ; Thu, 12 Mar 2026 23:35:44 +0100
Message-ID: <6db1bdd6-5f8f-4b8a-a457-c4e0a6a0f9d6@igalia.com>
Date: Thu, 12 Mar 2026 19:35:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix gamma 2.2 colorop TFs
To: Alex Hung <alex.hung@amd.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 daniels@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@kde.org>
References: <20260311211837.2482799-1-alex.hung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260311211837.2482799-1-alex.hung@amd.com>
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



On 11/03/2026 18:18, Alex Hung wrote:
> Use GAMMA22 for degamma/blend and GAMMA22_INV for shaper so
> curves match the color pipeline.
Oh, thanks for this fix!

I had a hard time figuring out that the problem I was facing in the
userspace was that I was trying setting an incorrect value, because
I hadn't paid attention to how it was exposed in the kernel. Unf!

Reviewed-by: Melissa Wen <mwen@igalia.com>

>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5016
> Tested-by: Xaver Hugl <xaver.hugl@kde.org>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index d59ba82d3d7c..aa4658867e55 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -37,19 +37,19 @@ const u64 amdgpu_dm_supported_degam_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
>   
>   const u64 amdgpu_dm_supported_shaper_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
>   
>   const u64 amdgpu_dm_supported_blnd_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
>   
>   #define MAX_COLOR_PIPELINE_OPS 10
>   

