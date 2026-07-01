Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13C1C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A948F10EEBF;
	Wed,  1 Jul 2026 10:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lEDQ2ZSo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 908D010E370;
 Wed,  1 Jul 2026 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782902472; x=1814438472;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/6GArq0vtUt5qCjo2zXB57Ml/83NG2lnpcjG5frBRcU=;
 b=lEDQ2ZSophJbJC8W6j0lXgL+AXtUTJh585yu0QkX0xqxcY07JIY8LQbd
 YimpiJ5BBS605MPH1ZHUSlw/b/7A8l4JYatxkwNQx+wXGkm1I5VKusPKA
 Il9z4j2m/JJxjCIdDmX0c8t+XLwjChgzvqT9YJf2bUyXid9+o3muCjSem
 CpkFjuiyxr4UFAbCWzIEaR33V0wjtV2J7vU4d+a6THFR6CabahVgjA1Ds
 rXhVIk26U9fKe4lWp28+vb3dVwFxJo9ZqeE401HZmnsISLCZdS47zhAUg
 gE6o/eFtZcFDWjPurLjgr4uPJCdLLQ8npiYt5yf4b4tJhd8fvMzGW96jH A==;
X-CSE-ConnectionGUID: eG/CoNp8R462Ay9RbYioSg==
X-CSE-MsgGUID: xnHiJfocR92wEcLrpNZPAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94282900"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="94282900"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:41:11 -0700
X-CSE-ConnectionGUID: UYKsC5qOTVaAA4wdKjytwQ==
X-CSE-MsgGUID: a+jfEkuyRW6y2OZHD9sGQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="276834942"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.98])
 ([10.245.244.98])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:41:07 -0700
Message-ID: <3bc9d27b-2886-48df-a897-7e73f14a88a2@linux.intel.com>
Date: Wed, 1 Jul 2026 12:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
 behind driver feature
To: Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Daniel Stone
 <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260630084229.529682-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

Hello,

All you have to do is iterate over all planes at runtime until
one is found that has the pipeline property attached, it's not
a performance sensitive area and no locking is required for
testing if plane->color_pipeline_property is NULL.

You can also make drm_plane_create_color_pipeline_property set
the flag in drm_device::driver_features that the cap is supported.

But the cap setting code's not really performance sensitive, it will
be called only a few times during boot at most. Perhaps check whether
the first crtc->primary plane has the cap is also sufficient.

If you want to continue with a special driver cap, then please set
the flag for the xe driver too.

Kind regards,
~Maarten Lankhorst

On 6/30/26 10:42, Robert Mader wrote:
> From the main commit:
> 
> The client cap is currently advertised unconditionally, even for drivers that do
> not support plane color pipelines. If clients supporting the later, like Wayland
> compositors and drm_info, enable the client cap on sich drivers they will be
> left without both color pipeline and the legacy properties COLOR_ENCODING and
> COLOR_RANGE, effectively breaking YUV->RGB conversion support.
> 
> Add a new driver feature and guard the client cap behind it, allowing
> plane color pipeline and legacy YUV->RGB support to co-exist.
> 
> In case of VKMS make the client cap depend on the enable_plane_pipeline.
> 
> The series can be easily tested with drm_info >= v2.10.0 and VKMS. Without the
> enable_plane_pipeline option - currently the default - the legacy flags
> COLOR_ENCODING and COLOR_RANGE should be advertised, just like older drm_info
> versions.
> 
> ---
> 
> Related series actually implementing the color pipeline replacement for the
> legacy flags:
> https://lists.freedesktop.org/archives/dri-devel/2026-June/575655.html
> 
> 
> Robert Mader (4):
>   drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE behind driver feature
>   drm/amdgpu: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
>   drm/i915: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
>   drm/vkms: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  drivers/gpu/drm/drm_ioctl.c             | 2 ++
>  drivers/gpu/drm/i915/i915_driver.c      | 2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c         | 6 +++++-
>  include/drm/drm_drv.h                   | 6 ++++++
>  5 files changed, 15 insertions(+), 3 deletions(-)
> 

