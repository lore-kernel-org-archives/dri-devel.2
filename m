Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8512C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF5610E3DB;
	Mon, 17 Aug 2026 07:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="jRMkhm9J";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4581C10E33A;
 Mon, 17 Aug 2026 07:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786953106; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cmpvimoyKdw0quuF10WfKz8an/HvUbRn/bAu0ZLpBJNF5tBM8ECFoeYu58AhcS2o0gIGIo4dD2Y6j9+LrpHothuLo8uOUugu2BSFBmDBrA4cdaDao9moMqy+IrFMoRc9ybS+XJWZHk7XJDVTspuKf26YWwloxkvqliqy6lZHiyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786953106;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Iw2aC94vSPrMousY4cikxQwgSo2Xe6DUtMC2fgKE8Q4=; 
 b=H5XzUeI4WI9psxf5f6bYH1spVDyJS1o/rbYaFLb34WRV/YVexZAtfcJ91Jv4TdUEX9p8bV6H0Fje305p1wukY5CDvlAuBasJ60YXjHUrvLFQkImIASEgflT7QCZO31dFBOH83HPfhpP3asxHoeszl6tpdJFx6oaJQgnkCRKBYYY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786953106; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Iw2aC94vSPrMousY4cikxQwgSo2Xe6DUtMC2fgKE8Q4=;
 b=jRMkhm9Jw3JoB13sFdqvRQVf7mC/xvzBNmuObFWieIOyrQ/PLQ7Hjm65qS0Z/51l
 OI2CoTcCnrBvuF0lCCwbLwHDdpvdKpaUFSKdFzFSKQ3UQFdF7bybi++9nrv4458vriP
 kuEaQQWZZUpu07VJjLXvJkhigcmK4xUrQ6tIp7ZY=
Received: by mx.zohomail.com with SMTPS id 1786953105068477.0091982509358;
 Mon, 17 Aug 2026 00:51:45 -0700 (PDT)
Message-ID: <c0d5a2bd-eb17-4ec0-aeb7-1fa9debb8154@collabora.com>
Date: Mon, 17 Aug 2026 09:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] YUV conversion colorop with amdgpu and VKMS
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
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

Hi Harry, thanks!

I retested the series with the Weston branch[1], both on an AMD device 
as well as the CI tests [2] with VKMS, and it looks all good to me. 
Naveen Kumar also confirmed that the corresponding Intel series works 
with the same Weston branch [3].

So I think we're all set, assuming we defer the discussed legacy 
properties helper[4] to after the uapi changes and first implementations 
have landed.

Who's reviews/acks do we still need to get the series landed? I suppose 
one from Louis for the VKMS changes - and one for the uapi changes from 
a maintainer?

Best regards,

Robert


1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133

2: this also needs 
https://lore.kernel.org/dri-devel/20260709115855.53725-1-robert.mader@collabora.com/, 
but that's unrelated to this series

3: 
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133#note_3615800

4: 
https://lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com/

On 14.08.26 23:18, Harry Wentland wrote:
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
> All patches are now reviewed and tested. We have a Weston and
> KWin implementation. IGT patches are missing one review. I
> deem these patches ready to merge once the last IGT patch review
> comes in.
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
> v6:
>   - Fix fill_plane_color_attributes build failure in Patch 8 when
>     building with KUNIT (Robert)
>
> v5:
>   - Drop new VKMS kunit tests for conversion matrices
>   - Added script to show how VKMS kunit test values are computed (Pekka)
>   - Removed fixed-matrix enums for "YCbCr limtied to full" and
>     "RGB709 to RGB2020" as they're currently unused by userspace (Robert)
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
> Harry Wentland (9):
>    drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
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
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  16 +--
>   .../amd/display/modules/color/color_gamma.c   |   3 +-
>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>   drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
>   .../gpu/drm/vkms/tests/gen_yuv_conversion.py  |  87 ++++++++++++
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c |  40 +++---
>   drivers/gpu/drm/vkms/vkms_colorop.c           |  66 ++++++---
>   drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>   drivers/gpu/drm/vkms/vkms_formats.c           |  64 ++++++---
>   drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
>   drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++++-
>   include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
>   include/uapi/drm/drm_mode.h                   |  12 ++
>   19 files changed, 651 insertions(+), 79 deletions(-)
>   create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
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

