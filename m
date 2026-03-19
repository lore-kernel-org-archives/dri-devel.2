Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B843C1090236
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2852A10E8F8;
	Thu, 19 Mar 2026 14:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="He9HGVTT";
	dkim-atps=neutral
X-Greylist: delayed 563 seconds by postgrey-1.36 at gabe;
 Thu, 19 Mar 2026 14:54:07 UTC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7869E10E8F8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:54:07 +0000 (UTC)
Received: from localhost (unknown [10.10.165.2])
 by mail.ispras.ru (Postfix) with ESMTPSA id EA5E945A1D02;
 Thu, 19 Mar 2026 14:44:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EA5E945A1D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1773931482;
 bh=7b/LGFDXg+j68TrLQFXnJns3llFisKP+XNy2jsFQaCc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=He9HGVTT1ZWDaTkmrTzFYTbuRku0gpkpxPUmRZ+TQ5ulle1X6mf559NiILmXTlV2+
 Y+Wl8/cItzX3y8EtvGJTA76LvSPEveYz+ny6BGjDfbr02In/otkI/CBZ5+VvF4uTMB
 IMdkeMVOwe89bn2TPTj7bBhy+Xa7C1aJespxh5IE=
Date: Thu, 19 Mar 2026 17:44:41 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>, 
 Brian Starkey <brian.starkey@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Simona Vetter <simona@ffwll.ch>, 
 lvc-project@linuxtesting.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/komeda: fix integer overflow in AFBC framebuffer
 size check
Message-ID: <20260319172236-9176589372e778e808f4b753-pchelkin@ispras>
References: <20260203134907.1587067-1-Alexander.Konyukhov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203134907.1587067-1-Alexander.Konyukhov@kaspersky.com>
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

On Tue, 03. Feb 16:48, Alexander Konyukhov wrote:
> The AFBC framebuffer size validation calculates the minimum required
> buffer size by adding the AFBC payload size to the framebuffer offset.
> This addition is performed without checking for integer overflow.
> 
> If the addition oveflows, the size check may incorrectly succed and
> allow userspace to provide an undersized drm_gem_object, potentially
> leading to out-of-bounds memory access.
> 
> Add usage of check_add_overflow() to safely compute the minimum
> required size and reject the framebuffer if an overflow is detected.
> This makes the AFBC size validation more robust against malformed.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 65ad2392dd6d ("drm/komeda: Added AFBC support for komeda driver")
> Signed-off-by: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index 3ca461eb0a24..3cb34d03f7f8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -4,6 +4,8 @@
>   * Author: James.Qian.Wang <james.qian.wang@arm.com>
>   *
>   */
> +#include <linux/overflow.h>
> +
>  #include <drm/drm_device.h>
>  #include <drm/drm_fb_dma_helper.h>
>  #include <drm/drm_gem.h>
> @@ -93,7 +95,9 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
>  	kfb->afbc_size = kfb->offset_payload + n_blocks *
>  			 ALIGN(bpp * AFBC_SUPERBLK_PIXELS / 8,
>  			       AFBC_SUPERBLK_ALIGNMENT);
> -	min_size = kfb->afbc_size + fb->offsets[0];
> +	if (check_add_overflow(kfb->afbc_size, fb->offsets[0], &min_size)) {
> +		goto check_failed;
> +	}

nit: extra braces around single-statement if-block are not needed per
kernel's coding style.

Another option is to cast one of the operands to u64 type and so perform
the addition in u64 and then proceed to the `min_size > obj->size` check
below.  Otherwise with the current patch it's pointless to declare
min_size as u64 - why u64 if its value is only allowed to be in u32 range
with the new check?

I think casting would probably be more appropriate here though it's up
to you to decide, thanks.

--
Fedor

>  	if (min_size > obj->size) {
>  		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%zx. min_size 0x%llx.\n",
>  			      obj->size, min_size);
> -- 
> 2.43.0
