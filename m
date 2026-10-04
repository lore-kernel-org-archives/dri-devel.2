Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A62ECA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 13:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC31710E0EC;
	Sun,  4 Oct 2026 13:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="qpQ6O1f6";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Sun, 04 Oct 2026 13:38:59 UTC
Received: from mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822F610E0EC
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 13:38:59 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=1+k00O3LND89cQEhluXVGIxTtZ/cWD8RGcLFGETy+k0=; 
 c=simple/simple; d=rosenzweig.io;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791121137; v=1; x=1791725937;
 b=qpQ6O1f6muNtfJfXHl4FFaSKX5Fp/88FN7Ecu/KHd5it3t8rWGmmVFW7In53LrJ2zJgxcTw3
 24o66EajxhouF7Y7GSYE9kR+4U4vMK8oLoHNbN+sJnWTCh/+w0EKy0zsv7LNryhRMOhCMhB0LBK
 9qrEc0Qr2y71O17Igf9K6DSpidIZ6ksLfNx5sJ07rmo4hgFMn9OFxpUQ0QeQrycjAoZvWE7p0H2
 czH4SLw5E4T/YuDjULrhz0tH9gG0cX24n98vvbDE0Lz+odmrNh2DhS5ZFNQxUGb7AHrIi/x36fU
 UMLAowDAANoC3zwYOAZdknIr1PQqJWh8Y5pD0vHO+CLdQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 293fd97adc88c8a6;
 Sun, 04 Oct 2026 13:32:52 +0000
X-Mizu-Trace-ID: 293fd97adc88c8a6
X-Migadu-Flow: FLOW_OUT
Date: Sun, 4 Oct 2026 09:32:48 -0400
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Oliver Bestmann <oliver.bestmann@googlemail.com>,
 sofus <sofus.c@icloud.com>, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2] drm/fourcc: Add Apple Interchange layout format
 modifier
Message-ID: <asJVgFVWYzG0frrM@fedora>
References: <20261004-apple-interchange-modifier-v2-1-410a3d0541f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261004-apple-interchange-modifier-v2-1-410a3d0541f6@gmail.com>
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

The one big missing piece here is how strides are defined. I assume from
context it's the same convention as GPU_TILED_COMPRESSED but this should
probably be spelled out.

Just adding a sentence "Strides follow the same convention
as DRM_FORMAT_MOD_APPLE_GPU_TILED." should be enough to define the uAPI
unambiguously here. With that it will be

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenz.ca>

Le Sun, Oct 04, 2026 at 10:42:29PM +1000, James Calligeros a écrit :
> Apple Interchange is a tiled and compressed image layout used
> for buffer exchange between Apple hardware blocks. It is
> similar to the already-supported GPU_TILED_COMPRESSED layout.
> 
> Add a format modifier for Apple Interchange so that it can be
> used for buffer exchange.
> 
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
> Changes in v2:
> - Fix typo
> - Link to v1: https://patch.msgid.link/20260831-apple-interchange-modifier-v1-1-5d6e27f9f308@gmail.com
> 
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/uapi/drm/drm_fourcc.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index a103fdc0b3a3..d304ee5c614c 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1626,6 +1626,26 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  #define DRM_FORMAT_MOD_APPLE_GPU_TILED fourcc_mod_code(APPLE, 1)
>  #define DRM_FORMAT_MOD_APPLE_GPU_TILED_COMPRESSED fourcc_mod_code(APPLE, 2)
>  
> +/*
> + * Apple Interchange layout
> + *
> + * Apple Interchange is a compressed framebuffer format used exclusively for
> + * sharing buffers between hardware blocks (GPU, display controller, video
> + * codecs) on Apple platforms. It is similar to and uses the same compression
> + * scheme as GPU_TILED_COMPRESSED. There is no known uncompressed variant
> + * of Apple Interchange.
> + *
> + * Unlike the GPU layouts, tile size is not dependent on bit depth. RGB
> + * images and the chroma components of YUV images use 16x16 tiles. The
> + * luma component of YUV images uses 32x32 tiles. Compression tiles
> + * are once again 16x16 with 8 bytes of metadata per compression subtile.
> + *
> + * AGX has limited support for Apple Interchange. It cannot be used for Z/S
> + * buffers or array images, for example. It is intended for scanout buffer
> + * sharing only.
> + */
> +#define DRM_FORMAT_MOD_APPLE_INTERCHANGE fourcc_mod_code(APPLE, 3)
> +
>  /*
>   * AMD modifiers
>   *
> 
> ---
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> change-id: 20260830-apple-interchange-modifier-cbcc311c835d
> 
> Best regards,
> --  
> James Calligeros <jcalligeros99@gmail.com>
> 
