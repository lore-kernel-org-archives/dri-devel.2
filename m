Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2AFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2742D10EB11;
	Mon, 13 Jul 2026 21:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MEtLxz+Q";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2F310EB11;
 Mon, 13 Jul 2026 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xQrScTMErwGvqTbe4/xRXxRntlCADJUSrD0i3fE7pTU=; b=MEtLxz+QaBvAuYqwlzpVK9DTMK
 2vEikTmQdo/d7diC4pmJnjScn04vhjDtET+9wHUXgiQHEmu0BIMMxxhxshP4pVaYWrXatPaYZ9UqU
 mc7YRYAqKwsAHGUmizXgKPSxzM/lR3Gk1SW1YMdgGr1ylDHKsHYyNGACbJzqA8tE7ufKdKb5y0ko8
 BAS0RWViFgPHrjDdIEE4xm0VgTh5XjXn4fV/TRBbRBTN928yOaf1tbGjAI8++zHNBrx68UpXzoWbo
 fKemjPL6WqzUQzwwWLoDWB+nc2P+XC3EtFfudlRWuulA7M+RJqiCW7gImoyIrJRQ0COXpx48MLmcI
 59Z0HZjA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wjNr8-00Eg7T-Rb; Mon, 13 Jul 2026 23:06:27 +0200
Message-ID: <220b89a8-348e-4021-a11a-cfd73610c688@Igalia.com>
Date: Mon, 13 Jul 2026 14:06:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] drm/managed: implement managed versions of
 kzalloc_obj/objs()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
 <20260612-wb-drop-encoder-v6-1-9f3a54f81310@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-1-9f3a54f81310@oss.qualcomm.com>
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

On 6/12/26 11:30, Dmitry Baryshkov wrote:
> The kzalloc_obj() and kzalloc_objs() functions proven to be useful and
> widely used for the reset of the kernel. Implement a drm_device-managed
> versions of those macros to mix the nice interface with the automatic
> freeing of the pointers.
>
> Note: the original macros accept optional GFP_foo arguments. They are
> skipped for now, making all allocations use GFP_KERNEL. If necessary,
> support for overriding the GFP type can be introduced later.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   include/drm/drm_managed.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
> index 72d0d68be226..79049bec277d 100644
> --- a/include/drm/drm_managed.h
> +++ b/include/drm/drm_managed.h
> @@ -105,6 +105,28 @@ static inline void *drmm_kcalloc(struct drm_device *dev,
>   	return drmm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>   }
>   
> +/**
> + * drmm_kzalloc_objs - &drm_device-managed kzalloc_objs()
> + * @dev: DRM device
> + * @p: Variable or type to allocate an array of
> + * @count: How many elements in the array
> + *
> + * Returns: newly allocated pointer to the zeroed array of @P on success, or
There is a mix of p and P going on here. With this made more consistent:
Reviewed-by: John Harrison <John.Harrison@Igalia.com>

> + * NULL on failure.
> + */
> +#define drmm_kzalloc_objs(dev, p, count) \
> +	drmm_kcalloc(dev, count, sizeof(typeof(p)), GFP_KERNEL)
> +
> +/**
> + * drmm_kzalloc_obj - &drm_device-managed kzalloc_obj()
> + * @dev: DRM device
> + * @p: Variable or type to allocate
> + *
> + * Returns: newly allocated pointer to a @p on success, or NULL on failure.
> + */
> +#define drmm_kzalloc_obj(dev, P) \
> +	drmm_kzalloc_objs(dev, P, 1)
> +
>   char *drmm_kstrdup(struct drm_device *dev, const char *s, gfp_t gfp);
>   
>   void drmm_kfree(struct drm_device *dev, void *data);
>

