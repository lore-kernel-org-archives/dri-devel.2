Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA5FA1FFF
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E32F10E123;
	Wed, 22 Apr 2026 21:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ADWi+F/M";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810A510E120;
 Wed, 22 Apr 2026 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hd3GHZV/JTz23DLNFp/e0DJhmMt5LNGysx1hQfDCPe0=; b=ADWi+F/Mv4J63+3yowxGFf4sPj
 MIkYypjBSHnNFWJnxRqtJiT58OBwXy8p141IL+8Q+8kpNL4ZF6B6cD3PNfaitppkm4blRnGMglRUd
 1Rj5+kN0w0iA98HdIu0aU6QfAzHYLm586Bam13hv9VTjbclZn896GKFnIitQ0OjPWZ/XhfSJbKJgI
 32nsKebg4MuDpwwCPXOBjnWn2dySEOS03La8gjZJdWyVf7yXiSIxrx/fLJv2VjEiL8w4ahBeEkYu3
 NXT8rzvMVbWhR9aOI66QYLjlmMZ+unNZZUTi0t5QdV8KfY9tu8LuCwHOJxkrcCMvYGOa1hVvtNL9v
 eXt1p+zA==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wFfJU-000SNM-Jp; Wed, 22 Apr 2026 23:40:52 +0200
Message-ID: <7373f292-f8d7-4d15-b835-78c4c7a759ab@igalia.com>
Date: Wed, 22 Apr 2026 18:40:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] YUV conversion colorop with amdgpu and VKMS
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Simon Ser <contact@emersion.fr>
References: <20260330153451.99472-1-harry.wentland@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> When we merged the drm_plane color pipeline API the major gap
> that existed was the lack of a YUV to RGB conversion colorop.
> We deprecated any legacy drm_plane color properties, which
> means that the COLOR_RANGE and COLOR_ENCODING properties can't
> be used with the COLOR_PIPELINE property on a drm_plane. In
> practice this means that we can't use a COLOR_PIPELINE on
> YCbCr encoded framebuffers.
>
> This patchset expands on the CSC_FF colorop proposed by Chaitanya
> and adds limited range variants of the YCbCr to RGB conversions.
>
> His full patchset can be found at
> https://patchwork.freedesktop.org/patch/709860
>
> This code has been tested with IGT and an experimental KWin branch.
>
> IGT branch:
> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-ff-colorop
>
> KWin branch:
> https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut
>
> The kernel branch containing these changes, based on drm-misc-next
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-ff-colorop
>
> In order to successfully use this branch you might need a few
> bugfixes. The kernel tree containing those fixes plus these patches
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-ff-colorop-all
>
> Further background on this work can be found at:
> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>
> v2:
> - use Chaitanya's CSC_FF block for named matrices
Hi,

I just renamed CSC_FF to Fixed Matrix [1] and verified with 
gamescope/SteamDeck [2] and it works as expected.
FWIW here is the drm_info output for the subsampled case (primary plane):

     │       └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 
225} = Color Pipeline 225
     │           ├───Bypass
     │           └───Color Pipeline 225
     │               ├───Color Operation 225
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 230
     │               │       └───"FIXED_MATRIX_TYPE" (atomic): enum 
{YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, 
YCbCr 709 Limited to RGB, YCbCr 2020 Full to RGB NC, YCbCr 2020 Limited 
to RGB NC} = YCbCr 601 Limited to RGB
     │               ├───Color Operation 230
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 235
     │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB 
EOTF, PQ 125 EOTF, BT.2020 Inverse OETF, Gamma 2.2} = BT.2020 Inverse OETF
     │               ├───Color Operation 235
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Multiplier
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 240
     │               │       └───"MULTIPLIER" (atomic): range [0, 
UINT64_MAX] = 4294967296
     │               ├───Color Operation 240
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3x4 Matrix
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 245
     │               │       └───"DATA" (atomic): blob = 0
     │               ├───Color Operation 245
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 250
     │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB 
Inverse EOTF, PQ 125 Inverse EOTF, BT.2020 OETF, Gamma 2.2 Inverse} = 
BT.2020 OETF
     │               ├───Color Operation 250
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 257
     │               │       ├───"SIZE" (atomic, immutable): range [0, 
UINT32_MAX] = 4096
     │               │       ├───"LUT1D_INTERPOLATION": enum {Linear} = 
Linear
     │               │       └───"DATA" (atomic): blob = 455
     │               ├───Color Operation 257
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3D LUT
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 264
     │               │       ├───"SIZE" (atomic, immutable): range [0, 
UINT32_MAX] = 17
     │               │       ├───"LUT3D_INTERPOLATION": enum 
{Tetrahedral} = Tetrahedral
     │               │       └───"DATA" (atomic): blob = 456
     │               ├───Color Operation 264
     │               │   └───Properties
     │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
     │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
     │               │       ├───"NEXT" (atomic, immutable): object 
colorop = 269
     │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB 
EOTF, PQ 125 EOTF, BT.2020 Inverse OETF, Gamma 2.2} = PQ 125 EOTF
     │               └───Color Operation 269
     │                   └───Properties
     │                       ├───"TYPE" (immutable): enum {1D Curve, 1D 
LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
     │                       ├───"BYPASS" (atomic): range [0, 1] = 1
     │                       ├───"NEXT" (atomic, immutable): object 
colorop = 0
     │                       ├───"SIZE" (atomic, immutable): range [0, 
UINT32_MAX] = 4096
     │                       ├───"LUT1D_INTERPOLATION": enum {Linear} = 
Linear
     │                       └───"DATA" (atomic): blob = 0

[1] https://gitlab.freedesktop.org/mwen/drm-misc/-/commits/amd_fm_colorop
[2] 
https://github.com/melissawen/gamescope/commit/c49e8b78e28a144b8a9f908e20430b3b7b832179

I didn't review the VKMS patches. After renaming, AMD part LGTM.

Melissa
>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
>
> Chaitanya Kumar Borah (1):
>    drm/colorop: Add DRM_COLOROP_CSC_FF
>
> Harry Wentland (8):
>    drm/colorop: Add limited-range YUV-to-RGB CSC FF enum values
>    drm/vkms: Add CSC FF colorop to color pipeline
>    drm/vkms: Add atomic check and matrix handling for CSC FF colorop
>    drm/amd/display: Add CSC FF colorop to color pipeline
>    drm/amd/display: Implement CSC FF colorop color space mapping
>    drm/amd/display: Use GAMCOR for first TF if CSC is used
>    drm/amd/display: Check actual state during commit_tail
>    drm/amd/display: Set color_space to plane_infos
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 102 ++++++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
>   drivers/gpu/drm/drm_colorop.c                 | 108 ++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++++----
>   drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>   drivers/gpu/drm/vkms/vkms_plane.c             |  70 +++++++++++-
>   include/drm/drm_colorop.h                     | 102 +++++++++++++++++
>   include/uapi/drm/drm_mode.h                   |  13 +++
>   12 files changed, 487 insertions(+), 30 deletions(-)
>
> --
> 2.53.0
>

