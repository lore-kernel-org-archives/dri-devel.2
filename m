Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC91E99055
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1B710E1A3;
	Fri, 10 Apr 2026 08:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BQ38IIbx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D50E10E1A3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775809588; x=1807345588;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=8kRo8MXuKY/zmBGIVOLxuWz6Zzud3qU8UUUWC06v3j0=;
 b=BQ38IIbxpsxDe7iIa/VaI/DNpQuRbRj8rZ/nl74ocvGz+2vZYafrVNi7
 4wR+DddEXxif4edkJvZp92deEz2Ils/LAWrseymp5LIA5vec3e/vnsrDf
 nTIhT28P944ZrHKVj8NwsQ2dS88pxIEH7yYzbGbK//pydIXeGLW16BCJI
 jmQ2Uc5Q6WpuVu9hBvpZ3V1TyDDtRtpH1g+pwYtWGPIEpv+ldHKX69VID
 vAVx/PQj8EhRDhp5X/K/tcadZVgH7Y7iL9Kxji4LGH/OGkxEtmvDJTYrX
 y5dHJVXmbACUTm+mgAc7crBiVtFwFcCakl1iyC0waC+qfFSv5HyC1dt/B w==;
X-CSE-ConnectionGUID: VWhe0KNTRGi9FU0R46md9g==
X-CSE-MsgGUID: xATLdX68Rzi4Hl/v5HtwKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76542162"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76542162"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 01:26:28 -0700
X-CSE-ConnectionGUID: FXL2t3nFS1S5SzryN7SNJw==
X-CSE-MsgGUID: QKc0HBnJSfaESgF3nj3rBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="228018475"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.110])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 01:26:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ashutosh
 Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/gem: Fix inconsistent plane dimension calculation
 in drm_gem_fb_init_with_funcs()
In-Reply-To: <20260409164156.2235189-1-ashutoshdesai993@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260409164156.2235189-1-ashutoshdesai993@gmail.com>
Date: Fri, 10 Apr 2026 11:26:21 +0300
Message-ID: <a4f659636fbf9558252197ec3b89ee0dab8290c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 09 Apr 2026, Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:
> drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions
> using plain integer division:
>
>   unsigned int width  = mode_cmd->width  / (i ? info->hsub : 1);
>   unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
>
> However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses
> drm_format_info_plane_width/height() which round up dimensions via
> DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object
> size check for certain pixel format and dimension combinations.
>
> For example, with NV12 (vsub=2) and a 1-pixel-tall framebuffer the
> GEM size validation path sees height=0 instead of height=1. The
> expression (height - 1) then wraps to UINT_MAX as an unsigned int,
> causing min_size to overflow and wrap back to a small value. A tiny
> GEM object therefore passes the size guard, yet when the GPU accesses
> the chroma plane it will read or write memory beyond the object's
> bounds.
>
> Fix by replacing the open-coded divisions with drm_format_info_plane_width()
> and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match
> the calculation already used in framebuffer_check().
>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>

Hello Ashutosh -

Receiving a handful of highly polished patches in quick succession on
various parts of the drm subsystem from someone who has no commits in
the kernel and has no previous interactions on the mailing lists is
virtually unheard of.

I have to ask, did you use AI coding assistants? Please read the kernel
documentation on AI coding assistants and attribution [1].


BR,
Jani.


[1] https://docs.kernel.org/process/coding-assistants.html


> ---
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> index 9166c353f..88808e972 100644
> --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> @@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
>  	}
>  
>  	for (i = 0; i < info->num_planes; i++) {
> -		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
> -		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
> +		unsigned int width = drm_format_info_plane_width(info, mode_cmd->width, i);
> +		unsigned int height = drm_format_info_plane_height(info, mode_cmd->height, i);
>  		unsigned int min_size;
>  
>  		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);

-- 
Jani Nikula, Intel
