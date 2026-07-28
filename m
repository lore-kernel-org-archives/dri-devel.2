Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E02DC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CD910E951;
	Tue, 28 Jul 2026 15:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="O3dDRqZu";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52E110E5AB;
 Tue, 28 Jul 2026 15:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785253404; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HVTUjRIRgLqsAx/dzVAchOo9Xk29LDCXM3sJc4WRD6frLaTBHrTEMC5Ez46q8ZHqGFiurYodDAEaTkCNt2Eb4R9eAHCGT31z/cwmHuCQNx4ATtBiSEFQ5UKWF4PG9W92Q2dnJKHHnmcoXuhdXBbutnMFo0LUZw44G086MtS36rM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785253404;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=72vhiB75dtSSEYnY+N+m98v6v93SiwbnTyn4KxFrTi0=; 
 b=hHVNmSNOOek1dm3AorfJW2fCrPP57XCVthWc1wpSPXB+opzrzEclDO8Djy/IIxDgzputgudkCreWiVQxQaAkYX1gENwkfBq8dcndQ+v4Wf/6Pgj9djYW1N4ImdSMyunAsmlLFgVZOikHCnjl62Ld0PAiGqxcuo02fob81W0t+Jk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785253404; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=72vhiB75dtSSEYnY+N+m98v6v93SiwbnTyn4KxFrTi0=;
 b=O3dDRqZuwcJUaUmklTYE+zJKyTI554o11s4IuHx9Ijd5aOHmkfXAfJ7PIhwcjzPQ
 H9S9vIWdLA1nVGD0QFyE3hO6EpYvm5PXH3d7loSw97+7jTvyzFT4/lOtOVUGO33KIC1
 ddyuv61Bh1jq9UofRWI/mUynsFzQwb5IRCrP/lxg=
Received: by mx.zohomail.com with SMTPS id 1785253402997922.333191260817;
 Tue, 28 Jul 2026 08:43:22 -0700 (PDT)
Message-ID: <19aeee36-e14e-44ca-95cf-f6617b31af48@collabora.com>
Date: Tue, 28 Jul 2026 17:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/20] drm/drm_colorop: add post-blend colorop
 support to AMD display driver
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260716160556.227556-1-mwen@igalia.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
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

Hi Melissa,

thanks a lot for this series!

On 16.07.26 18:02, Melissa Wen wrote:
> Hey,
>
> I have been working on gamescope migration from AMD driver-specific
> color props to KMS colorop API [1] and, with the fixed-matrix
> replacement for COLOR_ENCODING and COLOR_RANGE[2], the only missing
> color prop was the CRTC AMD REGAMMA TF (the 1D Curve). So I worked on top
> of Ariel&Nícolas proposal for post-blend colorop API [3], discarded
> patches for DRM_CAP_CRTC_COLOR_PIPELINE driver cap flag (as commented in
> this year Linux Display Hackfest), fixed some issues based on plane
> colorop recent changes and exposed AMD post-blend colorop pipeline with
> CTM -> 1D Curve -> 1D LUT, since post-blend Degamma is not actually
> supported by AMD (even though there is a workaround for enable it in
> CRTC color mgmt properties).
>
> I have a gamescope implementation that fully migrates its color pipeline
> from AMD private plane/CRTC color props to pre- and post-blend colorops
> running on a custom kernel with the required colorop support for AMD.
>
> - Gamescope draft:
> https://github.com/ValveSoftware/gamescope/pull/2113/commits
>
> - Kernel branch with all necessary patches:
> https://gitlab.freedesktop.org/mwen/drm-misc/-/commits/gamescope_pipeline_w_colorop

I used your branch as base for my own one [1] to create an experimental 
Weston MR [2] testing a typical proper YCbCr color pipeline, using fixed 
matrix, gamma 2.4 pre-blend (not quite correct for bt1886, I know...) 
and gamma 2.2 for post-blend - focused on VKMS.

API-wise I'd say it works great and think we should go forward with it. 
I'll add some more comments regarding the implementation, however 
overall I hope we can land this in the near future.

Best regards,

Robert

1: https://gitlab.com/rmader/linux/-/commits/gamescope_pipeline_w_colorop-2026-07-28

2: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2157

>
> This series doesn't take into account the inactive color pipeline work
> I've been doing for plane color pipeline. My plan is to apply a similar
> approach post-blend when we agree that the plane series is correct.
>
> - Patch 1-13 are essentially Ariel&Nicolas work for DRM post-blend
>    colorop support where I added patch 10 for tracking plane vs CRTC
>    colorop changes.
> - Patch 14 completes deprecation of CRTC color mgmt properties if
>    post-blend color pipeline is enabled by hiding them;
> - Patch 15 applies the same bug fix logic as Robert did to guard plane
>    client cap[4];
> - Patch 16-20 add support to post-blend colorop API on AMD driver based
>    on plane colorop work.
>
> This is one example of `drm_info` output on Steam Deck with
> SteamOS/gamescope implementation and this kernel work:
>
> ├───CRTCs
> │   ├───CRTC 0
> │   │   ├───Object ID: 399
> [...]
> │   │       └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 400} = Color Pipeline 400
> │   │           ├───Bypass
> │   │           └───Color Pipeline 400
> │   │               ├───Color Operation 400
> │   │               │   └───Properties
> │   │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3x4 Matrix
> │   │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
> │   │               │       ├───"NEXT" (atomic, immutable): object colorop = 405
> │   │               │       └───"DATA" (atomic): blob = 0
> │   │               ├───Color Operation 405
> │   │               │   └───Properties
> │   │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
> │   │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
> │   │               │       ├───"NEXT" (atomic, immutable): object colorop = 410
> │   │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB Inverse EOTF, PQ 125 Inverse EOTF, BT.2020 OETF, Gamma 2.2 Inverse, Gamma 2.4 Inverse, Gamma 2.6 Inverse} = PQ 125 Inverse EOTF
> │   │               └───Color Operation 410
> │   │                   └───Properties
> │   │                       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
> │   │                       ├───"BYPASS" (atomic): range [0, 1] = 1
> │   │                       ├───"NEXT" (atomic, immutable): object colorop = 0
> │   │                       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
> │   │                       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
> │   │                       └───"DATA" (atomic): blob = 0
>
> [...]
>
>      ├───Plane 3
>      │   ├───Object ID: 218
> [...]
>      │   └───Properties
>      │       ├───"type" (immutable): enum {Overlay, Primary, Cursor} = Primary
>      │       ├───"FB_ID" (atomic): object framebuffer = 513
>      │       │   ├───Object ID: 513
> [...]
>      │       └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 224} = Color Pipeline 224
>      │           ├───Bypass
>      │           └───Color Pipeline 224
>      │               ├───Color Operation 224
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 229
>      │               │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB
>      │               ├───Color Operation 229
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 234
>      │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, PQ 125 EOTF, BT.2020 Inverse OETF, Gamma 2.2, Gamma 2.4, Gamma 2.6} = sRGB EOTF
>      │               ├───Color Operation 234
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Multiplier
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 239
>      │               │       └───"MULTIPLIER" (atomic): range [0, UINT64_MAX] = 4294967296
>      │               ├───Color Operation 239
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3x4 Matrix
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 1
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 244
>      │               │       └───"DATA" (atomic): blob = 0
>      │               ├───Color Operation 244
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 249
>      │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB Inverse EOTF, PQ 125 Inverse EOTF, BT.2020 OETF, Gamma 2.2 Inverse, Gamma 2.4 Inverse, Gamma 2.6 Inverse} = sRGB Inverse EOTF
>      │               ├───Color Operation 249
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 256
>      │               │       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
>      │               │       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
>      │               │       └───"DATA" (atomic): blob = 528
>      │               ├───Color Operation 256
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 3D LUT
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 263
>      │               │       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 17
>      │               │       ├───"LUT3D_INTERPOLATION": enum {Tetrahedral} = Tetrahedral
>      │               │       └───"DATA" (atomic): blob = 529
>      │               ├───Color Operation 263
>      │               │   └───Properties
>      │               │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>      │               │       ├───"BYPASS" (atomic): range [0, 1] = 0
>      │               │       ├───"NEXT" (atomic, immutable): object colorop = 268
>      │               │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, PQ 125 EOTF, BT.2020 Inverse OETF, Gamma 2.2, Gamma 2.4, Gamma 2.6} = PQ 125 EOTF
>      │               └───Color Operation 268
>      │                   └───Properties
>      │                       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D LUT
>      │                       ├───"BYPASS" (atomic): range [0, 1] = 1
>      │                       ├───"NEXT" (atomic, immutable): object colorop = 0
>      │                       ├───"SIZE" (atomic, immutable): range [0, UINT32_MAX] = 4096
>      │                       ├───"LUT1D_INTERPOLATION": enum {Linear} = Linear
>      │                       └───"DATA" (atomic): blob = 0
>
> FWIW, here is the `drm_info` diff:
>
> diff --git a/drm_info.h b/drm_info.h
> index e61fda7..f7f2017 100644
> --- a/drm_info.h
> +++ b/drm_info.h
> @@ -21,5 +21,6 @@ enum {
>   /* Remove after updating libdrm */
>   #define DRM_MODE_OBJECT_COLOROP 0xfafafafa
>   #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE    7
> +#define DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE     8
>   
>   #endif
> diff --git a/json.c b/json.c
> index c9f8c72..b2c306b 100644
> --- a/json.c
> +++ b/json.c
> @@ -29,6 +29,7 @@ static const struct {
>          { "WRITEBACK_CONNECTORS", DRM_CLIENT_CAP_WRITEBACK_CONNECTORS },
>          { "CURSOR_PLANE_HOTSPOT", DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT },
>          { "PLANE_COLOR_PIPELINE", DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE },
> +       { "CRTC_COLOR_PIPELINE", DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE },
>   };
>
>
> [1] https://github.com/ValveSoftware/gamescope/pull/2113
> [2] https://lore.kernel.org/dri-devel/20260623164812.81110-2-harry.wentland@amd.com/
> [3] https://lore.kernel.org/dri-devel/20251223-mtk-post-blend-color-pipeline-v3-0-7d969f9a37a0@collabora.com/
> [4] https://lore.kernel.org/dri-devel/20260703073230.19982-1-robert.mader@collabora.com/
>
> Let me know your thoughts!
>
> Melissa
>
> Ariel D'Alessandro (2):
>    drm: Add helper to extract a 3x4 matrix from any CTM matrix dimensions
>    drm: Add helper to extract a LUT entry from either 16-bit or 32-bit
>      LUT
>
> Melissa Wen (8):
>    drm/colorop: distinguish whether a colorop belongs to a plane or a
>      CRTC
>    drm/drm_mode_object: hide deprecated CRTC color mgmt props if colorop
>      is set
>    drm/drm_ioctl: guard DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
>    drm/amd/display: add support to post-blend CTM colorop
>    drm/amd/display: add support to post-blend 1D-Curve colorop
>    drm/amd/display: add support to post-blend 1D-LUT colorop
>    drm/amd/display: move CRTC CTM color mgmt prop to check helper
>    drm/amd/display: enable post-blend colorop properties
>
> Nícolas F. R. A. Prado (10):
>    drm/crtc: Add color pipeline to CRTC state
>    drm/colorop: Allow parenting colorop to CRTC
>    drm: Factor out common color_pipeline property initialization code
>    drm/crtc: Add COLOR_PIPELINE property
>    drm: Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
>    drm/atomic: Pass crtc_color_pipeline client cap to atomic check
>    drm/atomic: Print the color pipeline as part of the CRTC state print
>    drm/colorop: Factor out common paths from colorops helpers
>    drm/colorop: Introduce colorop helpers for crtc
>    drm/crtc: Track crtc color pipeline client cap in drm_crtc_state
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 250 +++++++++++++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  76 +++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  42 +++
>   drivers/gpu/drm/drm_atomic.c                  |   9 +-
>   drivers/gpu/drm/drm_atomic_uapi.c             |  97 +++++-
>   drivers/gpu/drm/drm_colorop.c                 | 282 ++++++++++++++----
>   drivers/gpu/drm/drm_connector.c               |   1 +
>   drivers/gpu/drm/drm_crtc.c                    |  31 ++
>   drivers/gpu/drm/drm_crtc_internal.h           |   1 +
>   drivers/gpu/drm/drm_ioctl.c                   |  20 ++
>   drivers/gpu/drm/drm_mode_object.c             |  18 ++
>   drivers/gpu/drm/drm_plane.c                   |  34 +--
>   drivers/gpu/drm/drm_property.c                |  44 +++
>   include/drm/drm_atomic.h                      |  20 ++
>   include/drm/drm_atomic_uapi.h                 |   2 +
>   include/drm/drm_color_mgmt.h                  |  61 ++++
>   include/drm/drm_colorop.h                     |  32 +-
>   include/drm/drm_crtc.h                        |  27 ++
>   include/drm/drm_file.h                        |   7 +
>   include/drm/drm_property.h                    |   5 +
>   include/uapi/drm/drm.h                        |  19 ++
>   23 files changed, 939 insertions(+), 144 deletions(-)
>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

