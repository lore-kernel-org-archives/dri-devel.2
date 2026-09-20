Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF5CC982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 18:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298B210E227;
	Sun, 20 Sep 2026 18:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="SAe+UfBd";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7452A10E227
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 18:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789928485; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lUlkXpHTZK71fC6adAoRybM+BBoS5eyU0r701RO/ZUIO1WqaJbgWoHU2VOO08JNp/qFJtpsdRFOoWdjI5LpRHGaSrZTsY/mRdfzxWpkpZGhqY2zAdGmGgDhwv7aID1odWeEO58yjr0777cOmLnXoihdmKT/IOdIJEa8kNi7Xk1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789928485;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GQB4tEOzvmCfe1Lypm5ywpmGud1PivSR7o+w6DKvYRM=; 
 b=Mz/l12B8XN3FFQ4DJ/5vDwTVKv2RRM2UNtbb+j9rE0ITeYl9wSqQwUaxDJ4qd/aZ3cMU+S2eirYymFzrU2CrXNQ4i6YfrwK+cDQK4trftF5ccfAsjcHIVR32xLExMTu5xMu3sZiA3X4fAa+hoAeKJW1HD6KA+/jNhugbzLzu8Ng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789928485; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=GQB4tEOzvmCfe1Lypm5ywpmGud1PivSR7o+w6DKvYRM=;
 b=SAe+UfBdfx8Ll80vIkWF3o3tKMYg14p/mlMs4mhIX+VQrPcTLjqMEDbhcwJrm2RL
 OEL7BPIPVB2sraLUlD5YVfEp9Ifzky7iNvpKr5g0LW4lzLLxsfmHgBuvDDQemSn/UvO
 UDPL+ze9m2INmxE+QrEudyCi2A9to2eiwDVrYeCY=
Received: by smtp.zohomail.com with SMTPS id 1789928483182297.9289853779717;
 Sun, 20 Sep 2026 11:21:23 -0700 (PDT)
Message-ID: <c627ced6-1bdb-4508-b010-46df53eab2b3@collabora.com>
Date: Sun, 20 Sep 2026 21:21:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Add pixel blend mode property to cursor plane
To: oushixiong1025@163.com, David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>, Ye Liu <liuye@kylinos.cn>
References: <20260828090123.784944-1-oushixiong1025@163.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260828090123.784944-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 8/28/26 12:01, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> The cursor plane exposes a format with an alpha channel
> (DRM_FORMAT_ARGB8888) without a pixel blend mode property. Since
> commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed") this triggers a warning during
> drm_mode_config_validate():
> 
> [    0.649020] ------------[ cut here ]------------
> [    0.649040] [PLANE:36:plane-1] pixel format with alpha exposed but blend mode not setup
> [    0.649081] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
> ......
> [    0.649761] Call trace:
> [    0.649764]  drm_mode_config_validate+0x398/0x558 [drm] (P)
> [    0.649912]  drm_dev_register+0x1cc/0x2a0 [drm]
> [    0.650058]  virtio_gpu_probe+0xd4/0x1c0 [virtio_gpu]
> [    0.650088]  virtio_dev_probe+0x1c8/0x310
> ......
> [    0.650261] ---[ end trace 0000000000000000 ]---
> 
> 
> Create the property with the only supported blend mode,
> DRM_MODE_BLEND_PREMULTI, which is also the property's default and
> matches what userspace had to assume before the property existed.
> 
> Reported-by: Ye Liu <liuye@kylinos.cn>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 1d1b27ece62a..11771c943ea6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -24,6 +24,7 @@
>   */
>  
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_atomic_helper.h>
> @@ -588,6 +589,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  	struct drm_plane *plane;
>  	const uint32_t *formats;
>  	int nformats;
> +	int ret;
>  
>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>  		formats = virtio_gpu_cursor_formats;
> @@ -610,5 +612,17 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  	if (type == DRM_PLANE_TYPE_PRIMARY)
>  		drm_plane_enable_fb_damage_clips(plane);
>  
> +	if (type == DRM_PLANE_TYPE_CURSOR) {
> +		/*
> +		 * The cursor plane exposes a format with an alpha channel,
> +		 * which requires a blend mode property. The host blends
> +		 * premultiplied alpha, matching the property's default.
> +		 */
> +		ret = drm_plane_create_blend_mode_property(plane,
> +							   BIT(DRM_MODE_BLEND_PREMULTI));
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
>  	return plane;
>  }

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
