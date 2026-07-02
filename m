Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E431C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9013D10F23B;
	Thu,  2 Jul 2026 08:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QHXXAeqq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C22310F230;
 Thu,  2 Jul 2026 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782981264; x=1814517264;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=k7eA92s159Ngu+QIltfO74+zhMPwS9Ty8QA1lb2JpIs=;
 b=QHXXAeqqsSH0X83QpyzY67b7YGKN5bHK42TQzGGqQwXNvfD+0Vae4Lyl
 d+uuthhd14FfLK05V4Ih57TV+fJWalMX0krq03ycB+o3bRApxciprAQMd
 YvKzvACN83cUiTY23FjfhJ58c/Jd0BVz2dFA/9hFy89HlaI932eoRbEXw
 J/otb/MMA2+PSjZo39XPE7EpKQplP4yKB1kpn5+EnsUlQ9N+4yJZ34XM3
 APvyeCGkMyqnHWQycFl7oxQDXFxYNs48GseZ9+cL4qeZY/3i2yj5puMPX
 VfnXJgAVTxrr+iuIfsyA4pcZ09QuCeOsryVOqnqEkD3g6YhL2TTfyYX5G A==;
X-CSE-ConnectionGUID: MGk6NZmtRxS/hx9ZXWe7Uw==
X-CSE-MsgGUID: Ao28F5LMTMe4wmPJUaK7WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83757837"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="83757837"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 01:34:21 -0700
X-CSE-ConnectionGUID: 1E70bXLBSEaWsOtGDbizPw==
X-CSE-MsgGUID: Cug6YpbtRD21DUPbY/VThg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="254739884"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.210])
 ([10.245.244.210])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 01:34:17 -0700
Message-ID: <83f324a2-abe1-4b32-8782-439569f651d2@linux.intel.com>
Date: Thu, 2 Jul 2026 10:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
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
References: <20260702081641.22990-1-robert.mader@collabora.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260702081641.22990-1-robert.mader@collabora.com>
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

On 7/2/26 10:16, Robert Mader wrote:
> The client cap is currently advertised unconditionally, even for drivers
> that do not support plane color pipelines. If clients supporting the later,
> like Wayland compositors or tools like drm_info, enable the client cap on
> such drivers they will be left without both color pipeline and the legacy
> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
> conversion support.
> 
> Prevent that by only marking the cap supported if there are actually planes
> with color pipelines.
> 
> Note: while the color pipeline replacement for the legacy properties is
> still under review (1), we can assume that it will work as a drop-in
> replacement. That means any plane on any hardware currently supporting
> the legacy properties will be able to offer a functionally equal color
> pipeline and there will be no technical reason keep using the legacy
> properties if both the driver and the client support the new API.
> 
> 1: https://lore.kernel.org/dri-devel/20260623164812.81110-1-harry.wentland@amd.com/
> 
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> 
> ---
> 
> Changes in v2:
>  - Replace the driver feature with a simple check (suggested by Maarten
>    Lankhorst <maarten.lankhorst@linux.intel.com>)
>  - Expand the commit message slightly and change the title
> ---
>  drivers/gpu/drm/drm_ioctl.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e2df4becce62..b2c0234eaf14 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -373,13 +373,26 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  			return -EINVAL;
>  		file_priv->supports_virtualized_cursor_plane = req->value;
>  		break;
> -	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
> +	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE: {
> +		struct drm_plane *plane;
> +		bool has_plane_with_color_pipeline = false;
> +
> +		drm_for_each_plane(plane, dev) {
> +			if (plane->color_pipeline_property) {
> +				has_plane_with_color_pipeline = true;
> +				break;
> +			}
> +		}
> +		if (!has_plane_with_color_pipeline)
> +			return -EOPNOTSUPP;
> +
>  		if (!file_priv->atomic)
>  			return -EINVAL;
>  		if (req->value > 1)
>  			return -EINVAL;
>  		file_priv->plane_color_pipeline = req->value;
>  		break;
> +	}

Perhaps put the most specific check (is there a plane with color pipeline?)
last, and return -EINVAL, as that is the default before
DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE was added.

Kind regards,
~Maarten Lankhorst

