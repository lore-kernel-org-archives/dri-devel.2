Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D54C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22D110E593;
	Tue, 28 Jul 2026 14:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="T4YEBMAo";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2489110E370;
 Tue, 28 Jul 2026 14:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785250722; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HyPjuzjOGdwZAvh4eIZk/JNxVJnJY4Ya+VzNWWtLVVXd6FuMqIOTf71+3VppKVcY75W5e1U2s8tvHLoEGrRQW+O4xBL9m8GepBkhIJl0JUJOahihl9emejDDOnMIHcCIJX+vtoq7WIPIJdBhNv+pMs/NddTZBer5WscLu73BzZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785250722;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gC4i7X4CmHIIuftNwOx9ifBAd2gEOQsI+nmDy/9AcC4=; 
 b=IOfKCph1cpiT94spwQ1N9PTdmUl11/xERrKkttx2Aofj2XsWBTy984emaLT4N7Gh8hBJeuuWNaKNKWTd3DcTV8cRahiJ8/NRiHv0U7q/LQQIxOUeVyfmRV/m6K/gCjtfBBctGv2bj8o2lDhgo82vba0G9tYEQw/sV5gkJjD++aY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785250722; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=gC4i7X4CmHIIuftNwOx9ifBAd2gEOQsI+nmDy/9AcC4=;
 b=T4YEBMAoCktUMewUigaHEmVVRPFcirus0NicsQWva35oDEZiOuOV3mfV7N8V8Xj5
 A6TWzykicby3vHovegBT8wHuwMd2P0o4B/+1eUV9u+Isd3RCwFaGcusF2X537PG+o4g
 wiZfsmtAXjAJWLUv5dILc1qasGRb2FzdBHZXWMog=
Received: by mx.zohomail.com with SMTPS id 1785250721359723.288310307518;
 Tue, 28 Jul 2026 07:58:41 -0700 (PDT)
Message-ID: <1aba7601-ba07-407d-8bc8-5a28a49b78f0@collabora.com>
Date: Tue, 28 Jul 2026 16:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] YUV conversion colorop with amdgpu and VKMS
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260722134607.136293-1-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
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

thanks a lot for the series. I have a experimental Weston MR which tests 
the new color-op with VKMS at [1] - both as pure replacement for the 
legacy properties as well as in combination with a complete 
color-pipelines for pre- and post-blending (using a kernel branch [2] 
based on Melissas branch [3] for AMD post-blending). From all I tried it 
seems to work great - the API is works beautifully and the test checks 
for visual compatibility with the legacy properties, the Weston internal 
shaders as well as Mesas shaders. In conclusion I'd love to see the 
series land (soon).

Best regards,

Robert


1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2157

2: 
https://gitlab.com/rmader/linux/-/commits/gamescope_pipeline_w_colorop-2026-07-28

3: 
https://gitlab.freedesktop.org/mwen/drm-misc/-/commits/gamescope_pipeline_w_colorop

On 22.07.26 15:45, Harry Wentland wrote:
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
> v4:
>   - Specify matrix entries in docs (Pekka)
>   - Squash limited-range enums into "Add FM" patch (Robert)
>   - Don't reject RGB planes with fixed matrix in VKMS as
>     we don't want or need to make a colorop dependent on
>     the framebuffer's pixel format. (Robert)
>   - Fix conversion matrices in VKMS and implement kunit
>     tests (discovered while documenting the matrices)
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
>    drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
>    drm/vkms: Add KUnit test for YCbCr to RGB conversion matrices
>    drm/vkms: Add fixed matrix colorop to color pipeline
>    drm/vkms: Add atomic check and matrix handling for fixed matrix
>      colorop
>    drm/amd/display: Add fixed matrix colorop to color pipeline
>    drm/amd/display: Implement fixed matrix colorop color space mapping
>    drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>    drm/amd/display: Check actual state during commit_tail
>    drm/amd/display: Set color_space to plane_infos
>    drm/amd/display: Force GAMCOR for subsampled surfaces with
>      PQ/Gamma22/HLG
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>   .../amd/display/modules/color/color_gamma.c   |   3 +-
>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>   drivers/gpu/drm/drm_colorop.c                 | 109 ++++++++++++
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 160 +++++++++++++++---
>   drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++---
>   drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>   drivers/gpu/drm/vkms/vkms_formats.c           |  64 +++++--
>   drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
>   drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++-
>   include/drm/drm_colorop.h                     | 159 +++++++++++++++++
>   include/uapi/drm/drm_mode.h                   |  12 ++
>   16 files changed, 706 insertions(+), 68 deletions(-)
>
> --
> 2.55.0
>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

