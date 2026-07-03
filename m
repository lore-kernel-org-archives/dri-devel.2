Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFECC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDEB10F7AE;
	Fri,  3 Jul 2026 11:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CtOD0Ip6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C730310F7A9;
 Fri,  3 Jul 2026 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mWhG/3B5p+cytMrHUS2CX7qSff04CYcetqlRRCHBSkM=; b=CtOD0Ip6idv4wU06MB+2dM9hlw
 NbGjwIzxWDu38Tobx0NODliiarFl4/RPYplorwMzX2H/74cz/KjPLkmout/na1tN/MYu7705Gy15G
 VM9L6pQ5Ul1BP9T9QKgf3U44ZhAX2rPdJ20unt9qNX5RFepy6wnXvbHE5LgP/XWU7cM81DGSjvJR6
 OYhk3lOhpYYiSKEm6wDv6TPsxUs23F2kJZiYGc12Fr8nc6/3nEIUZbgkm+8vJq/UD6plAsRcYT4eK
 F+iykSo6oiJ2zSXhenUZcD9okNUebF10f0ALRBBBsLnbhPz04vVFhXnLh2XhED6PdpBxzWtw8vnGM
 VCLiXZRQ==;
Received: from [178.139.163.86] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wfbnx-008STX-6Y; Fri, 03 Jul 2026 13:11:33 +0200
Message-ID: <a4d0034a-4aec-4880-86a7-699390e21a06@igalia.com>
Date: Fri, 3 Jul 2026 13:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260703073230.19982-1-robert.mader@collabora.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260703073230.19982-1-robert.mader@collabora.com>
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



On 03/07/2026 09:32, Robert Mader wrote:
> The client cap is currently advertised unconditionally, even for drivers
> that do not support plane color pipelines. If clients supporting the later,
> like Wayland compositors or tools like drm_info, enable the client cap on
> such drivers they will be left without both color pipeline and the legacy
> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
> conversion support.
>
> Prevent that by only marking the cap supported if there are actually planes
> with color pipelines.

Hi Robert,

I think Maarten probably wants to take one last look.

But just to add that this approach looks good to me. Thanks for working 
on it.

Reviewed-by: Melissa Wen <mwen@igalia.com>

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
>   - Move the new check behind the existing EINVAL ones
>   - Rebase on latest drm-misc-next
>
> Changes in v2:
>   - Replace the driver feature with a simple check (suggested by Maarten
>     Lankhorst <maarten.lankhorst@linux.intel.com>)
>   - Expand the commit message slightly and change the title
> ---
>   drivers/gpu/drm/drm_ioctl.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e2df4becce62..9039a39c4324 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -373,13 +373,25 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>   			return -EINVAL;
>   		file_priv->supports_virtualized_cursor_plane = req->value;
>   		break;
> -	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
> +	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE: {
> +		struct drm_plane *plane;
> +		bool has_plane_with_color_pipeline = false;
> +
>   		if (!file_priv->atomic)
>   			return -EINVAL;
>   		if (req->value > 1)
>   			return -EINVAL;
> +		drm_for_each_plane(plane, dev) {
> +			if (plane->color_pipeline_property) {
> +				has_plane_with_color_pipeline = true;
> +				break;
> +			}
> +		}
> +		if (!has_plane_with_color_pipeline)
> +			return -EOPNOTSUPP;
>   		file_priv->plane_color_pipeline = req->value;
>   		break;
> +	}
>   	default:
>   		return -EINVAL;
>   	}

