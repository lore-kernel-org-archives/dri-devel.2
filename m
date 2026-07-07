Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A32710EBE9;
	Tue,  7 Jul 2026 08:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B85MVT2a";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B7B10EBFC;
 Tue,  7 Jul 2026 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783412777; x=1814948777;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EHF2oSbGSPPkpOykLgyw6jvocrRYRW4CAx4KAQFdmno=;
 b=B85MVT2a1Mq1c6O5VsXIu3WsOonjZEKfyPloUZFZuoMK2LuVoiR2tVMz
 fRJlzVNMrENhXadLq8qiCXcRTn6tCXicCETnyaZ+m9bDCjcGIIpQL2AxR
 pxAKgb/UbjiITmcgZtJXKrH1pLBwfjlLqtMtgYjO8XcaqBbHBUZhsGquH
 GI5j4kIH3tMwTvPacjgWd3CUFr/iPA3zg2D8KmrdgMQBo1LNanVAmI9a9
 0raxL5ARuDa7nJ7QCYQIgtfPfuDJVkPECUbSWg2XnQRNAka4FXQe0z4ad
 JGZISz4H6KIYwzOKncKMoQQhu8lBhtTXJSI3GgKy+4gNP6CViqfgpSzn9 g==;
X-CSE-ConnectionGUID: ropWseXXSd66mJwT/khr0A==
X-CSE-MsgGUID: qAIRAPPKQ+em93EY4ph8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94658483"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="94658483"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 01:26:17 -0700
X-CSE-ConnectionGUID: 5nBjQhTMS3WwD8M1Xo+umg==
X-CSE-MsgGUID: Bj6oZUU0R36maRYnFp6VVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="253468518"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.223])
 ([10.245.244.223])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 01:26:12 -0700
Message-ID: <a346493c-047f-4b3b-b344-39b0266348ad@linux.intel.com>
Date: Tue, 7 Jul 2026 10:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
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
References: <20260703073230.19982-1-robert.mader@collabora.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260703073230.19982-1-robert.mader@collabora.com>
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

Hey,

This probably would be useful to backport to stable, can I add those tags and merge it?

Fixes: 179ab8e7d7b3 ("drm/colorop: Introduce DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE")
Cc: <stable@vger.kernel.org> # v6.19+

Kind regards,
~Maarten Lankhorst

On 7/3/26 09:32, Robert Mader wrote:
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
> Changes in v3:
>  - Move the new check behind the existing EINVAL ones
>  - Rebase on latest drm-misc-next
> 
> Changes in v2:
>  - Replace the driver feature with a simple check (suggested by Maarten
>    Lankhorst <maarten.lankhorst@linux.intel.com>)
>  - Expand the commit message slightly and change the title
> ---
>  drivers/gpu/drm/drm_ioctl.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e2df4becce62..9039a39c4324 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -373,13 +373,25 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  			return -EINVAL;
>  		file_priv->supports_virtualized_cursor_plane = req->value;
>  		break;
> -	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
> +	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE: {
> +		struct drm_plane *plane;
> +		bool has_plane_with_color_pipeline = false;
> +
>  		if (!file_priv->atomic)
>  			return -EINVAL;
>  		if (req->value > 1)
>  			return -EINVAL;
> +		drm_for_each_plane(plane, dev) {
> +			if (plane->color_pipeline_property) {
> +				has_plane_with_color_pipeline = true;
> +				break;
> +			}
> +		}
> +		if (!has_plane_with_color_pipeline)
> +			return -EOPNOTSUPP;
>  		file_priv->plane_color_pipeline = req->value;
>  		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}

