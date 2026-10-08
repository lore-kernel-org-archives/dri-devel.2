Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375C5CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFCC10E797;
	Thu,  8 Oct 2026 09:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Ovbcn+Dp";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC95D10E797
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 09:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791452151; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EFzOhrqF0D6RuIeHK3Z2/DXsEUOj+JrWQ9MnFSNWYDF6l3jaTv9EU9Qn/7mz6oGsaoE0boIw0Rf1qfP8gEHkxBmO43LfWlJOR3Mco5gqPNOc4/J8Ef0IOopWiOnSQ25N5bzl0hj2X9AXim1T7/dbc+yTEA0tW72A9OjfU64yWYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791452151;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4VnOjx2KntnOr3fpM0koQeAVv8fD8ZmjHvdUfitA1NY=; 
 b=l4Rn2lcc0fJA4FJgkZD44+XZEk2j+htHGejMFV/4mRYXYaiM0RLoiLKdICmqwIkJ7srcTkGmEr67tS0DOPqeVxl3s0BAix/8BvFZ/PBU8MWX6y9+EQ//yn8YZOaQzWGS68TfAbuiCpQJM00uSYw2uEEdy6QF3WuqWVXTtIo8/EM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791452151; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4VnOjx2KntnOr3fpM0koQeAVv8fD8ZmjHvdUfitA1NY=;
 b=Ovbcn+DpQthlnuB5owvSuEw90A3H4zHhemwX43JTiNpXACYToaLlzcX+yQuYgak/
 9b/s89n4kXQNwAeBUMAKauSWUuaUkQgPD6RfreQusEHcWhzdK2Ou5Z0iz6pczO36p95
 OtKJFGov53ROX8QGw0vMghIID2zmafUpuahri99g=
Received: by smtp.zohomail.com with SMTPS id 1791452150818849.5609116892517;
 Thu, 8 Oct 2026 02:35:50 -0700 (PDT)
Message-ID: <dae2c4c1-0b60-4975-83d6-924d5255db94@collabora.com>
Date: Thu, 8 Oct 2026 12:35:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to
 cursor plane"
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
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

On 10/8/26 01:22, Dmitry Osipenko wrote:
> The cursor blending mode was added twice because the same change was
> applied by accident from different patches. Revert the second patch.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com/
> Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor plane")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index b422eba42a5f..640815af4098 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -589,7 +589,6 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  	struct drm_plane *plane;
>  	const uint32_t *formats;
>  	int nformats;
> -	int ret;
>  
>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>  		formats = virtio_gpu_cursor_formats;
> @@ -615,17 +614,5 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  		drm_plane_create_blend_mode_property(plane,
>  						     BIT(DRM_MODE_BLEND_PREMULTI));
>  
> -	if (type == DRM_PLANE_TYPE_CURSOR) {
> -		/*
> -		 * The cursor plane exposes a format with an alpha channel,
> -		 * which requires a blend mode property. The host blends
> -		 * premultiplied alpha, matching the property's default.
> -		 */
> -		ret = drm_plane_create_blend_mode_property(plane,
> -							   BIT(DRM_MODE_BLEND_PREMULTI));
> -		if (ret)
> -			return ERR_PTR(ret);
> -	}
> -
>  	return plane;
>  }

Marek, could you please give your r-b?

-- 
Best regards,
Dmitry
