Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A42EC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B37C10E684;
	Thu,  9 Jul 2026 14:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="QuIowKFl";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A42210E684;
 Thu,  9 Jul 2026 14:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783607587; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=R81IqUKFPqrIBZMO2/z9lXid4HHRTQn+2fEAPU8L6Iw4LKy01WCQMzyH3QfDI91rytiGiQuEXc9zLoMKKWmyZdc6RZCdPNiSpL1xqrO3DvPMzCBEIagmQl4jlZan5IJixAX+dcIXENqkT2j3Zh1cRiRVAfUnGKHAncJwz/HJnJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783607587;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PDEhNohzJHelgz9LBFaxC5+YxUb/saf0XN+vBxQh76k=; 
 b=Cn1UPQrl7nKhAxUIi4us+CkOe7a4CyuHZf0Jase5fK+M/o+f8klNLLTmQWMz4F3HtXSlMqE+wqdEHysmW+lwvDgSk6+lTvmYp9gmMiztlE3uNgyqB61UoTFvgfhFw39nQDxryN7JuOg33xQsZC4ZjfQI/r1tFngezNLPe7ABwK8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783607587; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=PDEhNohzJHelgz9LBFaxC5+YxUb/saf0XN+vBxQh76k=;
 b=QuIowKFljR/gw76clT83ikVdKCxaVA5On+JGnGF9kk1DGYYM95bsM0o7MFLAwamK
 BxCY916Qv9DT5ynJnGkLLczqZkr+JNXUkVrsvQZb5FTyxomJV4100GYaTPJZJaa4Jc9
 bPTeK0zAeVzgEfoudiLVKm7OvEOlIklwyXUbtwVY=
Received: by mx.zohomail.com with SMTPS id 1783607586450305.483764375728;
 Thu, 9 Jul 2026 07:33:06 -0700 (PDT)
Message-ID: <f5cbdbef-d76f-4ffb-983c-5bb22d40a3b2@collabora.com>
Date: Thu, 9 Jul 2026 16:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] YUV conversion colorop with amdgpu and VKMS
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260623164812.81110-1-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
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

in a related discussion in 
https://lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com/ 
Maarten suggested that - given that the new Fixed Matrix colorop 
effectively provides a drop-in replacement for the legacy properties - 
it would be nice to have a helper that automatically provides support 
for the legacy properties for drivers implementing the new color op. 
That'd allow drivers a cleaner switch to the new API, keeping legacy 
support for free.

Harry, WDYT, would that be an option for the two implementations here?

Best regards

On 23.06.26 18:48, Harry Wentland wrote:
> When we merged the drm_plane color pipeline API the major gap
> that existed was the lack of a YUV to RGB conversion colorop.
> We deprecated any legacy drm_plane color properties, which
> means that the COLOR_RANGE and COLOR_ENCODING properties can't
> be used with the COLOR_PIPELINE property on a drm_plane. In
> practice this means that we can't use a COLOR_PIPELINE on
> YCbCr encoded framebuffers.
>
> This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
> and adds limited range variants of the YCbCr to RGB conversions.
>
> His full patchset can be found at
> https://patchwork.freedesktop.org/patch/709860
>
> This code has been tested with IGT and an experimental KWin branch.
>
> IGT branch:
> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop
>
> KWin branch used for testing:
> https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop
>
> The kernel branch containing these changes, based on drm-misc-next
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop
>
> Further background on this work can be found at:
> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>
> v3:
> - base on Chaitanya's updated patch and rename code accordingly
>    to Fixed_Matrix instead of CSC Fixed-Function
>
> v2:
> - use Chaitanya's CSC_FF block for named matrices
>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Robert Mader <robert.mader@collabora.com>
>
> Chaitanya Kumar Borah (1):
>    drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
>
> Harry Wentland (10):
>    drm/colorop: Add limited-range YUV-to-RGB fixed matrix enum values
>    drm/vkms: Add fixed matrix colorop to color pipeline
>    drm/vkms: Add atomic check and matrix handling for fixed matrix
>      colorop
>    drm/amd/display: Add fixed matrix colorop to color pipeline
>    drm/amd/display: Implement fixed matrix colorop color space mapping
>    drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>    drm/amd/display: Check actual state during commit_tail
>    drm/amd/display: Set color_space to plane_infos
>    drm/amd/display: Set COLOR_SPACE_SRGB when fixed matrix colorop is
>      bypassed
>    drm/amd/display: Force GAMCOR for subsampled surfaces with
>      PQ/Gamma22/HLG
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  91 +++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>   .../amd/display/modules/color/color_gamma.c   |   3 +-
>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
>   drivers/gpu/drm/drm_colorop.c                 | 109 +++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++++---
>   drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>   drivers/gpu/drm/vkms/vkms_plane.c             |  68 ++++++++++-
>   include/drm/drm_colorop.h                     | 114 ++++++++++++++++++
>   include/uapi/drm/drm_mode.h                   |  12 ++
>   13 files changed, 487 insertions(+), 32 deletions(-)
>
> --
> 2.54.0
>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

