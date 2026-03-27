Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B120610BA431
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 07:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08ACD10E32D;
	Fri, 27 Mar 2026 07:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cYWva3L+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="96JpD6dO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cYWva3L+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="96JpD6dO";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BDA10E32D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 07:29:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F16F24D30D;
 Fri, 27 Mar 2026 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774596547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fZx2/59yZaAnf4jQa6rQIqnG6oMaI4fXGjVxcBy4D+I=;
 b=cYWva3L+e2ez2hGt8/h+9fXBxac52NiDgTQhYZDDA6FZ0H5/1VHFmV/fhHYKHMkboujK2t
 aKRjNyX9IJHskdJ9MVMn35iKxWkwzTN30KPNB9OBQIEW2nZfNUF2sp7U2wnkP+r4eSpmRV
 aaRWT5Ix0tRLGorI779hI+gxxTbGr78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774596547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fZx2/59yZaAnf4jQa6rQIqnG6oMaI4fXGjVxcBy4D+I=;
 b=96JpD6dO866BA7qnmcMZVKA7//WIoJmaBtwU+0kaAunqqfvCiBnUiH8PSDyZX3gSrxKVwZ
 P8BrwHINuxsZoWBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774596547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fZx2/59yZaAnf4jQa6rQIqnG6oMaI4fXGjVxcBy4D+I=;
 b=cYWva3L+e2ez2hGt8/h+9fXBxac52NiDgTQhYZDDA6FZ0H5/1VHFmV/fhHYKHMkboujK2t
 aKRjNyX9IJHskdJ9MVMn35iKxWkwzTN30KPNB9OBQIEW2nZfNUF2sp7U2wnkP+r4eSpmRV
 aaRWT5Ix0tRLGorI779hI+gxxTbGr78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774596547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fZx2/59yZaAnf4jQa6rQIqnG6oMaI4fXGjVxcBy4D+I=;
 b=96JpD6dO866BA7qnmcMZVKA7//WIoJmaBtwU+0kaAunqqfvCiBnUiH8PSDyZX3gSrxKVwZ
 P8BrwHINuxsZoWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CC504A0A2;
 Fri, 27 Mar 2026 07:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id te1lDcIxxmm1IgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 07:29:06 +0000
Message-ID: <746c1be0-7c03-451b-a813-6c9325c39ee6@suse.de>
Date: Fri, 27 Mar 2026 08:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag
To: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20260326100248.1171828-1-wenst@chromium.org>
 <20260326100248.1171828-4-wenst@chromium.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260326100248.1171828-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TAGGED_RCPT(0.00)[renesas]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[28];
 FREEMAIL_TO(0.00)[chromium.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,lists.freedesktop.org,vger.kernel.org,lists.infradead.org,gmail.com,jannau.net,arm.com,sys-base.io,linaro.org,ideasonboard.com,bp.renesas.com,foss.st.com,raspberrypi.com,igalia.com,iscas.ac.cn];
 R_RATELIMIT(0.00)[to_ip_from(RLe847sq1wc67kb8i1ezagym5k)];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email, suse.de:mid,
 chromium.org:email, imap1.dmz-prg2.suse.org:helo, suse.com:url]
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

Hi

Am 26.03.26 um 11:01 schrieb Chen-Yu Tsai:
> From: Rob Herring <robh@kernel.org>
>
> Add support in DMA helpers to handle callers specifying
> DRM_MODE_DUMB_KERNEL_MAP flag. Existing behavior is maintained with this
> change. drm_gem_dma_dumb_create() always creates a kernel mapping as
> before. drm_gem_dma_dumb_create_internal() lets the caller set the flags
> as desired.
>
> drm_gem_dma_dumb_create_internal() users have DRM_MODE_DUMB_KERNEL_MAP
> added to preserve existing behavior.
>
> A dumb buffer allocated from these devices can be shared (exported) to
> another device. The consuming device may require the kernel mapping to
> scan out the buffer to its own display. Such devices include DisplayLink
> and various MIPI DBI based displays. Therefore altering the behavior
> should be given much consideration.

NAK on this whole thing. Please do not clutter the sources with these 
flags and tests. If drivers cannot use the gem-cma helpers, they should 
not do so. Maybe these drivers _are_ different. Then give them different 
interfaces or even a different memory manager, if necessary.

>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [wenst@chromium.org: Rebase onto renamed GEM DMA helpers]
> [wenst@chromium.org: show "vaddr=(no mapping)" in drm_gem_dma_print_info()]
> [wenst@chromium.org: Add DRM_MODE_DUMB_KERNEL_MAP to new drivers]
> [wenst@chromium.org: Add flags field to drm_gem_dma_create_with_handle()
> 		     kerneldoc]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Added back DRM_MODE_DUMB_KERNEL_MAP flag to all drivers calling
>    drm_gem_dma_dumb_create_internal()
> - Expanded commit message to cover display drivers needing the kernel
>    mapping to do scan out
>
> Changes since v1:
> - Rebased onto renamed GEM DMA helpers
> - Added check in drm_fb_dma_get_scanout_buffer() and drm_gem_dma_vmap().
> - Made drm_gem_dma_print_info() show "vaddr=(no mapping)" for objects
>    allocated without kernel mapping
> - Dropped existing DRM_MODE_DUMB_KERNEL_MAP flag addition in various
>    drivers
> - Added DRM_MODE_DUMB_KERNEL_MAP flag to adp_drm_gem_dumb_create()
> - Added flags field kerneldoc for drm_gem_dma_create_with_handle()
>
> Cc: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Cc: Janne Grunau <j@jannau.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Paul Kocialkowski <paulk@sys-base.io>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: "Maíra Canal" <mcanal@igalia.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/gpu/drm/adp/adp_drv.c                 |  1 +
>   .../gpu/drm/arm/display/komeda/komeda_kms.c   |  1 +
>   drivers/gpu/drm/arm/malidp_drv.c              |  1 +
>   drivers/gpu/drm/drm_fb_dma_helper.c           |  4 ++
>   drivers/gpu/drm/drm_gem_dma_helper.c          | 67 ++++++++++++-------
>   drivers/gpu/drm/logicvc/logicvc_drm.c         |  1 +
>   drivers/gpu/drm/meson/meson_drv.c             |  1 +
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  2 +
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  1 +
>   drivers/gpu/drm/stm/drv.c                     |  3 +-
>   drivers/gpu/drm/sun4i/sun4i_drv.c             |  1 +
>   drivers/gpu/drm/vc4/vc4_drv.c                 |  2 +
>   drivers/gpu/drm/verisilicon/vs_drm.c          |  2 +
>   drivers/gpu/drm/xlnx/zynqmp_kms.c             |  2 +
>   14 files changed, 63 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
> index 4554cf75565e..c549b44b3814 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -95,6 +95,7 @@ static int adp_drm_gem_dumb_create(struct drm_file *file_priv,
>   {
>   	args->height = ALIGN(args->height, 64);
>   	args->size = args->pitch * args->height;
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   
>   	return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
>   }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 6ed504099188..2c096ebaea33 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -29,6 +29,7 @@ static int komeda_gem_dma_dumb_create(struct drm_file *file,
>   	struct komeda_dev *mdev = dev->dev_private;
>   	u32 pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	args->pitch = ALIGN(pitch, mdev->chip.bus_width);
>   
>   	return drm_gem_dma_dumb_create_internal(file, dev, args);
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index b765f6c9eea4..5519f48a27c0 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -464,6 +464,7 @@ static int malidp_dumb_create(struct drm_file *file_priv,
>   	/* allocate for the worst case scenario, i.e. rotated buffers */
>   	u8 alignment = malidp_hw_get_pitch_align(malidp->dev, 1);
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), alignment);
>   
>   	return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
> index fd71969d2fb1..12a44accc48c 100644
> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> @@ -187,6 +187,10 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *plane,
>   	if (!dma_obj->vaddr)
>   		return -ENODEV;
>   
> +	/* Buffer was allocated with NO_KERNEL_MAPPING */
> +	if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> +		return -ENODEV;

This is a good example of what I'm talking about. A driver that cannot 
provide a scanout buffer should not set the callback in the first place.

Best regards
Thomas

> +
>   	iosys_map_set_vaddr(&sb->map[0], dma_obj->vaddr);
>   	sb->format = fb->format;
>   	sb->height = fb->height;
> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
> index 9722c9fc86f3..281fb563f061 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> @@ -116,26 +116,8 @@ __drm_gem_dma_create(struct drm_device *drm, size_t size, bool private)
>   	return ERR_PTR(ret);
>   }
>   
> -/**
> - * drm_gem_dma_create - allocate an object with the given size
> - * @drm: DRM device
> - * @size: size of the object to allocate
> - *
> - * This function creates a DMA GEM object and allocates memory as backing store.
> - * The allocated memory will occupy a contiguous chunk of bus address space.
> - *
> - * For devices that are directly connected to the memory bus then the allocated
> - * memory will be physically contiguous. For devices that access through an
> - * IOMMU, then the allocated memory is not expected to be physically contiguous
> - * because having contiguous IOVAs is sufficient to meet a devices DMA
> - * requirements.
> - *
> - * Returns:
> - * A struct drm_gem_dma_object * on success or an ERR_PTR()-encoded negative
> - * error code on failure.
> - */
> -struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
> -					      size_t size)
> +static struct drm_gem_dma_object *
> +drm_gem_dma_create_flags(struct drm_device *drm, size_t size, u32 flags)
>   {
>   	struct drm_gem_dma_object *dma_obj;
>   	int ret;
> @@ -146,6 +128,9 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
>   	if (IS_ERR(dma_obj))
>   		return dma_obj;
>   
> +	if (!(flags & DRM_MODE_DUMB_KERNEL_MAP))
> +		dma_obj->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
> +
>   	if (dma_obj->map_noncoherent) {
>   		dma_obj->vaddr = dma_alloc_noncoherent(drm_dev_dma_dev(drm),
>   						       size,
> @@ -171,6 +156,30 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
>   	drm_gem_object_put(&dma_obj->base);
>   	return ERR_PTR(ret);
>   }
> +
> +/**
> + * drm_gem_dma_create - allocate an object with the given size
> + * @drm: DRM device
> + * @size: size of the object to allocate
> + *
> + * This function creates a DMA GEM object and allocates memory as backing store.
> + * The allocated memory will occupy a contiguous chunk of bus address space.
> + *
> + * For devices that are directly connected to the memory bus then the allocated
> + * memory will be physically contiguous. For devices that access through an
> + * IOMMU, then the allocated memory is not expected to be physically contiguous
> + * because having contiguous IOVAs is sufficient to meet a devices DMA
> + * requirements.
> + *
> + * Returns:
> + * A struct drm_gem_dma_object * on success or an ERR_PTR()-encoded negative
> + * error code on failure.
> + */
> +struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
> +					      size_t size)
> +{
> +	return drm_gem_dma_create_flags(drm, size, DRM_MODE_DUMB_KERNEL_MAP);
> +}
>   EXPORT_SYMBOL_GPL(drm_gem_dma_create);
>   
>   /**
> @@ -179,6 +188,7 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_create);
>    * @file_priv: DRM file-private structure to register the handle for
>    * @drm: DRM device
>    * @size: size of the object to allocate
> + * @flags: DRM_MODE_DUMB_* flags if any
>    * @handle: return location for the GEM handle
>    *
>    * This function creates a DMA GEM object, allocating a chunk of memory as
> @@ -194,14 +204,14 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_create);
>    */
>   static struct drm_gem_dma_object *
>   drm_gem_dma_create_with_handle(struct drm_file *file_priv,
> -			       struct drm_device *drm, size_t size,
> +			       struct drm_device *drm, size_t size, u32 flags,
>   			       uint32_t *handle)
>   {
>   	struct drm_gem_dma_object *dma_obj;
>   	struct drm_gem_object *gem_obj;
>   	int ret;
>   
> -	dma_obj = drm_gem_dma_create(drm, size);
> +	dma_obj = drm_gem_dma_create_flags(drm, size, DRM_MODE_DUMB_KERNEL_MAP);
>   	if (IS_ERR(dma_obj))
>   		return dma_obj;
>   
> @@ -283,7 +293,7 @@ int drm_gem_dma_dumb_create_internal(struct drm_file *file_priv,
>   		args->size = args->pitch * args->height;
>   
>   	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
> -						 &args->handle);
> +						 args->flags, &args->handle);
>   	return PTR_ERR_OR_ZERO(dma_obj);
>   }
>   EXPORT_SYMBOL_GPL(drm_gem_dma_dumb_create_internal);
> @@ -313,12 +323,13 @@ int drm_gem_dma_dumb_create(struct drm_file *file_priv,
>   	struct drm_gem_dma_object *dma_obj;
>   	int ret;
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	ret = drm_mode_size_dumb(drm, args, 0, 0);
>   	if (ret)
>   		return ret;
>   
>   	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
> -						 &args->handle);
> +						 args->flags, &args->handle);
>   	return PTR_ERR_OR_ZERO(dma_obj);
>   }
>   EXPORT_SYMBOL_GPL(drm_gem_dma_dumb_create);
> @@ -412,7 +423,10 @@ void drm_gem_dma_print_info(const struct drm_gem_dma_object *dma_obj,
>   			    struct drm_printer *p, unsigned int indent)
>   {
>   	drm_printf_indent(p, indent, "dma_addr=%pad\n", &dma_obj->dma_addr);
> -	drm_printf_indent(p, indent, "vaddr=%p\n", dma_obj->vaddr);
> +	if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> +		drm_printf_indent(p, indent, "vaddr=(no mapping)\n");
> +	else
> +		drm_printf_indent(p, indent, "vaddr=%p\n", dma_obj->vaddr);
>   }
>   EXPORT_SYMBOL(drm_gem_dma_print_info);
>   
> @@ -511,6 +525,9 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_prime_import_sg_table);
>   int drm_gem_dma_vmap(struct drm_gem_dma_object *dma_obj,
>   		     struct iosys_map *map)
>   {
> +	if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> +		return -ENOMEM;
> +
>   	iosys_map_set_vaddr(map, dma_obj->vaddr);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
> index bbebf4fc7f51..595a71163cb5 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> @@ -39,6 +39,7 @@ static int logicvc_drm_gem_dma_dumb_create(struct drm_file *file_priv,
>   {
>   	struct logicvc_drm *logicvc = logicvc_drm(drm_dev);
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	/* Stride is always fixed to its configuration value. */
>   	args->pitch = logicvc->config.row_stride * DIV_ROUND_UP(args->bpp, 8);
>   
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 49ff9f1f16d3..9fa339d6e273 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -83,6 +83,7 @@ static irqreturn_t meson_irq(int irq, void *arg)
>   static int meson_dumb_create(struct drm_file *file, struct drm_device *dev,
>   			     struct drm_mode_create_dumb *args)
>   {
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	/*
>   	 * We need 64bytes aligned stride, and PAGE aligned size
>   	 */
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> index 60e6f43b8ab2..611fe3d4a4d8 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> @@ -424,6 +424,8 @@ int rcar_du_dumb_create(struct drm_file *file, struct drm_device *dev,
>   	if (ret)
>   		return ret;
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
> +
>   	return drm_gem_dma_dumb_create_internal(file, dev, args);
>   }
>   
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> index 87f171145a23..359f85bd84eb 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> @@ -184,6 +184,7 @@ int rzg2l_du_dumb_create(struct drm_file *file, struct drm_device *dev,
>   	unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>   	unsigned int align = 16 * args->bpp / 8;
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	args->pitch = roundup(min_pitch, align);
>   
>   	return drm_gem_dma_dumb_create_internal(file, dev, args);
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 56d53ac3082d..a0bc2e215adb 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -51,8 +51,9 @@ static int stm_gem_dma_dumb_create(struct drm_file *file,
>   	 * in order to optimize data transfer, pitch is aligned on
>   	 * 128 bytes, height is aligned on 4 bytes
>   	 */
> -	args->pitch = roundup(min_pitch, 128);
>   	args->height = roundup(args->height, 4);
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
> +	args->pitch = roundup(min_pitch, 128);
>   
>   	return drm_gem_dma_dumb_create_internal(file, dev, args);
>   }
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 8a409eee1dca..d3ff53ce2450 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -36,6 +36,7 @@ static int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
>   				     struct drm_device *drm,
>   				     struct drm_mode_create_dumb *args)
>   {
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	/* The hardware only allows even pitches for YUV buffers. */
>   	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), 2);
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index a14ecb769461..7a04cf52f511 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -87,6 +87,8 @@ static int vc5_dumb_create(struct drm_file *file_priv,
>   	if (ret)
>   		return ret;
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
> +
>   	return drm_gem_dma_dumb_create_internal(file_priv, dev, args);
>   }
>   
> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c b/drivers/gpu/drm/verisilicon/vs_drm.c
> index fd259d53f49f..fe3591244d02 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drm.c
> +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
> @@ -44,6 +44,8 @@ static int vs_gem_dumb_create(struct drm_file *file_priv,
>   	if (ret)
>   		return ret;
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
> +
>   	return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
>   }
>   
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index 02f3a7d78cf8..aa3822b3cb08 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -371,6 +371,8 @@ static int zynqmp_dpsub_dumb_create(struct drm_file *file_priv,
>   	if (ret)
>   		return ret;
>   
> +	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
> +
>   	return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
>   }
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


