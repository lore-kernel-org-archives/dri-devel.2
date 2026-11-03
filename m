Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A514606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DaRWNgj2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EC110F770;
	Tue,  3 Nov 2026 22:45:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6119210F770;
 Tue,  3 Nov 2026 22:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793745939; x=1825281939;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tguGqK55T7QkMSbnRYGgHUvn2YurTeZ21qHoJIq4SxI=;
 b=DaRWNgj2LwUuJ/lvjImS4gcgFSH/6YjxGqk1YEjIBUBNV3UkosNNmIl1
 W8OHsQ9oT3BdhTzRvw43ZXAMqoVoW0Vbdi4VxRc2gD/belvoW/Q980yeH
 Qi08p964Hi6Q4uM4HuAfh5on5P7Fx5Zg9R5wBgELjtk+4yHTm45GQUEk7
 rGI904eRvMo5uU83qJsUFjbj9jKVnb92h3mL0Mgq5k7eM1PX6aynfrjFG
 fW3VfMkQJXXqX9qE5vZrLT4xqP5h59l5BIk80JZ2J1yh8lzitOsKqjdK6
 GeaXHtYKey1ECpsCSGReoXcGqqwLg1xqVUTeTYPf9oVucKFPeI7yLuEoO A==;
X-CSE-ConnectionGUID: HbaDCY29T1eLZITaw1lDcw==
X-CSE-MsgGUID: pb24XFVURnS+gP257L0dog==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2590946"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2590946"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:45:39 -0800
X-CSE-ConnectionGUID: IHSyI80jTJKB2E6wXqfTrQ==
X-CSE-MsgGUID: bD2dK3BhQiGaziEME0rwRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6552864"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.193])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:45:37 -0800
Date: Wed, 4 Nov 2026 00:45:34 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>, Autumn Ashton <misyl@froggi.es>,
 Xaver Hugl <xaver.hugl@gmail.com>
Subject: Re: [PATCH v1 00/13] Add DRM_COLOROP_3D_LUT_DMA for fast-loading 3D
 LUT
Message-ID: <aupkDmY1HUlS27HT@intel.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 04:37:43PM -0500, Harry Wentland wrote:
> Loading a DRM_COLOROP_3D_LUT on AMD HW takes a long time because the
> driver has to load the entire 3D LUT via register writes.
> 
> Starting with DCN 4 the HW has the ability to load a 3D LUT via DMA,
> which only requires an address update for programming the 3D LUT.
> 
> I propose exposing a new DRM_COLOROP_3D_LUT_DMA type to support this DMA
> 3D LUT loading mechanism. Users of the DRM_COLOROP_3D_LUT_DMA will parse
> the supported formats via the LUT_3D_FORMATS blob property, select the
> desired format via LUT_3D_FORMAT property, and pass the 3D LUT buffer as
> a drm_framebuffer via FB_ID on the colorop.

A framebuffer? That sounds like a very weird thing to use
for non-pixel data.

Why don't you just copy the LUT from the blob into a BO in the kernel
and DMA it from there? That's kinda how everything now works on Intel
hardware. Sure, it's not 100% optimal because of the extra copy, but
at least it avoids userspace having to care about it so much.

> 
> For details see the patches and/or posted branches.
> 
> In addition to the patches posted here the 3d-fl-fixes kernel branch
> contains a number of fixes that will be merged via the usual amdgpu
> display process. It also contains a patch to enable support on Navi 4
> (DCN 4.0.1), which won't be upstreamed since that generation requires a
> userspace workaround. The 3d-fl-workaround IGT branch exists solely for
> that purpose. Nonetheless, Navi 4 can serve as an enablement vehicle for
> anyone who wants to see the new interface working.
> 
> The kwin branch makes use of a pipeline with DRM_COLOROP_3D_LUT_DMA if
> such a pipeline is discovered before a pipeline with a
> DRM_COLOROP_3D_LUT.
> 
> ### Branches
> 
> kernel: https://gitlab.freedesktop.org/hwentland/linux/-/commits/3d-fl
> kernel w/ fixes: https://gitlab.freedesktop.org/hwentland/linux/-/commits/3d-fl-fixes
> IGT: https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/3d-fl
> IGT Navi 4 w/a: https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/3d-fl-workaround
> kwin: https://invent.kde.org/hwentlan/kwin/-/commits/3d-fl
> 
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Autumn Ashton <misyl@froggi.es>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> 
> Harry Wentland (13):
>   drm/colorop: Add DRM_COLOROP_3D_LUT_DMA
>   drm/colorop: add DRM_COLOROP_3D_LUT_DMA object and state
>   drm/atomic: wire up DMA 3D LUT colorop properties
>   drm/atomic: validate DMA 3D LUT colorop framebuffer
>   drm/atomic: add colorop prepare_fb and cleanup_fb helper hooks
>   drm/tests: test colorop prepare_fb and cleanup_fb helpers
>   drm/amd/display: advertise a DMA 3D LUT color pipeline
>   drm/amd/display: pin the DMA 3D LUT framebuffer
>   drm/amd/display: program the DMA 3D LUT colorop
>   drm/amd/display: add 3D LUT DMA pitch alignment cap
>   drm/amd/display: derive the DMA 3D LUT pitch from DC caps
>   drm/amd/display: reject direct 3D LUT loading mode changes
>   drm/amd/display: add KUnit tests for the DMA 3D LUT colorop
> 
>  drivers/gpu/drm/amd/display/Kconfig           |  13 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  68 ++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 131 +++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   8 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  71 +++-
>  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 286 ++++++++++++-
>  .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  65 +++
>  drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
>  .../dc/resource/dcn42/dcn42_resource.c        |   2 +
>  .../dc/resource/dcn42b/dcn42b_resource.c      |   2 +
>  drivers/gpu/drm/drm_atomic.c                  |  66 +++
>  drivers/gpu/drm/drm_atomic_helper.c           |  93 ++++
>  drivers/gpu/drm/drm_atomic_uapi.c             |  28 ++
>  drivers/gpu/drm/drm_colorop.c                 |  96 +++++
>  drivers/gpu/drm/drm_framebuffer.c             |  45 +-
>  drivers/gpu/drm/drm_gem_atomic_helper.c       |  81 ++++
>  drivers/gpu/drm/tests/Makefile                |   1 +
>  .../gpu/drm/tests/drm_colorop_helper_test.c   | 397 ++++++++++++++++++
>  include/drm/drm_atomic.h                      |  20 +
>  include/drm/drm_colorop.h                     |  71 ++++
>  include/drm/drm_gem_atomic_helper.h           |  11 +
>  include/drm/drm_modeset_helper_vtables.h      |  62 +++
>  include/uapi/drm/drm.h                        |   7 +-
>  include/uapi/drm/drm_mode.h                   |  79 ++++
>  24 files changed, 1672 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/gpu/drm/tests/drm_colorop_helper_test.c
> 
> --
> 2.56.0

-- 
Ville Syrjälä
Intel
