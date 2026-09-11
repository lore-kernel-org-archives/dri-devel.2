Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404AFC79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BD010E307;
	Fri, 11 Sep 2026 06:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CrqGhoLK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SAVgbt3N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="geT7RK51";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G3AvYMlT";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33DC410E185
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:41:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8023F21BF9;
 Fri, 11 Sep 2026 06:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789108888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FLnvEMqVHLVo/izCkctcIG3kEzi0YsCcX8UXgC3El4k=;
 b=CrqGhoLK7oOtYFt1SX9AJuw4DyQduDPPsyYIhLxN+R/Ou7kA3Okb57v8nIWXWh8N98+2j4
 jREgPk/WuLZoYqI9mzfGqqLTuX0HewLokgNhIcAqVlPrhvNRmao2se7Z7UR9oyetn4nznU
 btEDkaMkcA0dXrDYgjW2MXGWccRFoU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789108888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FLnvEMqVHLVo/izCkctcIG3kEzi0YsCcX8UXgC3El4k=;
 b=SAVgbt3NRSBzG4NuI2lWxdBG5hgrri++vaLyGnNRxj5Lbj8HEA4raLBjT5mahsLHS+TlGo
 1iJMopWj+sIc4ZCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=geT7RK51;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G3AvYMlT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789108884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FLnvEMqVHLVo/izCkctcIG3kEzi0YsCcX8UXgC3El4k=;
 b=geT7RK515tgdNyLeBhuNzrrhw3oIAIb0lubroYjb6qIwneCd06hw2a39PVTcuExQdbRPQU
 0WV8RWH7VOdkDhoesKe9Fi8G4ecOietQStVp6CJ041XpYO8+xGO2tNWzvVSmsSVAn/DjVv
 /3o6B0j+Q8gGMyYlYKudhdlsTOd1V1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789108884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FLnvEMqVHLVo/izCkctcIG3kEzi0YsCcX8UXgC3El4k=;
 b=G3AvYMlT6B+zdCJiUFEIP+wFwHXQsOF2vEYpsqg0+/Te1cnwyoD4682OUk8Fi98eU+e1Q4
 fiBOWnwIixcS+2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15340132D3;
 Fri, 11 Sep 2026 06:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uUMFO5Oio2pFGQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 06:41:23 +0000
Message-ID: <90cfb3e0-ae5f-40ae-813a-db702837c3d0@suse.de>
Date: Fri, 11 Sep 2026 08:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/pl111: drop alpha formats the hardware cannot scan
 out
To: Roshan Kumar <roshaen09@gmail.com>, linusw@kernel.org,
 dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, pimyn@google.com,
 linux-kernel@vger.kernel.org
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <20260910192526.137057-1-roshaen09@gmail.com>
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
In-Reply-To: <20260910192526.137057-1-roshaen09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8023F21BF9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.freedesktop.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[collabora.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,google.com,vger.kernel.org];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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



Am 10.09.26 um 21:25 schrieb Roshan Kumar:
> The PL110/PL111 controller scans out a single framebuffer and never
> blends its alpha channel with anything. In every pixel-format table
> each alpha-carrying entry (ARGB/ABGR in 8888, 1555 and 4444) maps to
> exactly the same register configuration as its XRGB/XBGR counterpart,
> so the alpha byte was never used by the hardware.
>
> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") added validation that warns when a plane exposes
> alpha formats without a pixel blend mode property, and PL111 does exactly
> that. With panic_on_warn enabled the warning prevents the syzkaller
> vexpress-a15 manager from booting.
>
> Drivers should not report formats they do not support, so remove the
> alpha formats from all variant tables: the generic PL110, PL111 and
> Nomadik tables in pl111_drv.c and the board-specific Integrator, IM-PD1,
> Versatile and RealView/Versatile-Express tables in pl111_versatile.c,
> plus the now dead case labels in the display setup and the Versatile
> syscon connector switch, instead of advertising a blend mode property.
> Behavior is unchanged for userspace that picks an XRGB/XBGR/RGB format;
> alpha-picking clients fall back to the identical X variant.
>
> Link: https://github.com/google/syzkaller/issues/7805
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Roshan Kumar <roshaen09@gmail.com>

The tags always go last, but we can fix this when we merge the patch. 
Thanks for fixing the issue.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

>
> Changes in v2: drop the alpha formats entirely instead of advertising a
> DRM_MODE_BLEND_PIXEL_NONE property, per review feedback from Thomas
> Zimmermann. Leandro's Reviewed-by from v1 is not carried as the
> approach changed.
>
> Changes in v3: v2 missed the board-specific variant tables in
> pl111_versatile.c (Integrator, IM-PD1, Versatile, RealView and
> Versatile Express), which still exposed alpha formats and would fall
> through to the WARN_ONCE default in pl111_display_enable() on those
> boards. Pointed out by the sashiko AI reviewer.
> ---
>   drivers/gpu/drm/pl111/pl111_display.c   |  6 ------
>   drivers/gpu/drm/pl111/pl111_drv.c       | 16 ----------------
>   drivers/gpu/drm/pl111/pl111_versatile.c | 18 ------------------
>   3 files changed, 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index 5d10bc5fdf1f..e1b513d36c27 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -267,14 +267,12 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>   		if (priv->variant->st_bitmux_control)
>   			cntl |= CNTL_ST_LCDBPP24_PACKED;
>   		break;
> -	case DRM_FORMAT_ABGR8888:
>   	case DRM_FORMAT_XBGR8888:
>   		if (priv->variant->st_bitmux_control)
>   			cntl |= CNTL_LCDBPP24 | CNTL_BGR;
>   		else
>   			cntl |= CNTL_LCDBPP24;
>   		break;
> -	case DRM_FORMAT_ARGB8888:
>   	case DRM_FORMAT_XRGB8888:
>   		if (priv->variant->st_bitmux_control)
>   			cntl |= CNTL_LCDBPP24;
> @@ -297,13 +295,11 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>   		else
>   			cntl |= CNTL_LCDBPP16_565 | CNTL_BGR;
>   		break;
> -	case DRM_FORMAT_ABGR1555:
>   	case DRM_FORMAT_XBGR1555:
>   		cntl |= CNTL_LCDBPP16;
>   		if (priv->variant->st_bitmux_control)
>   			cntl |= CNTL_ST_1XBPP_5551 | CNTL_BGR;
>   		break;
> -	case DRM_FORMAT_ARGB1555:
>   	case DRM_FORMAT_XRGB1555:
>   		cntl |= CNTL_LCDBPP16;
>   		if (priv->variant->st_bitmux_control)
> @@ -311,13 +307,11 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>   		else
>   			cntl |= CNTL_BGR;
>   		break;
> -	case DRM_FORMAT_ABGR4444:
>   	case DRM_FORMAT_XBGR4444:
>   		cntl |= CNTL_LCDBPP16_444;
>   		if (priv->variant->st_bitmux_control)
>   			cntl |= CNTL_ST_1XBPP_444 | CNTL_BGR;
>   		break;
> -	case DRM_FORMAT_ARGB4444:
>   	case DRM_FORMAT_XRGB4444:
>   		cntl |= CNTL_LCDBPP16_444;
>   		if (priv->variant->st_bitmux_control)
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index ac7b1d12a0f5..2175ac953795 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -341,13 +341,9 @@ static void pl111_amba_shutdown(struct amba_device *amba_dev)
>    * This early variant lacks the 565 and 444 pixel formats.
>    */
>   static const u32 pl110_pixel_formats[] = {
> -	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ARGB8888,
>   	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_ABGR1555,
>   	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_ARGB1555,
>   	DRM_FORMAT_XRGB1555,
>   };
>   
> @@ -361,19 +357,13 @@ static const struct pl111_variant_data pl110_variant = {
>   
>   /* RealView, Versatile Express etc use this modern variant */
>   static const u32 pl111_pixel_formats[] = {
> -	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ARGB8888,
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_BGR565,
>   	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_ABGR1555,
>   	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_ARGB1555,
>   	DRM_FORMAT_XRGB1555,
> -	DRM_FORMAT_ABGR4444,
>   	DRM_FORMAT_XBGR4444,
> -	DRM_FORMAT_ARGB4444,
>   	DRM_FORMAT_XRGB4444,
>   };
>   
> @@ -387,19 +377,13 @@ static const struct pl111_variant_data pl111_variant = {
>   static const u32 pl110_nomadik_pixel_formats[] = {
>   	DRM_FORMAT_RGB888,
>   	DRM_FORMAT_BGR888,
> -	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ARGB8888,
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_BGR565,
>   	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_ABGR1555,
>   	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_ARGB1555,
>   	DRM_FORMAT_XRGB1555,
> -	DRM_FORMAT_ABGR4444,
>   	DRM_FORMAT_XBGR4444,
> -	DRM_FORMAT_ARGB4444,
>   	DRM_FORMAT_XRGB4444,
>   };
>   
> diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
> index 0d8331a3909f..9a60f10231b1 100644
> --- a/drivers/gpu/drm/pl111/pl111_versatile.c
> +++ b/drivers/gpu/drm/pl111/pl111_versatile.c
> @@ -209,9 +209,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
>   	drm_info(drm, "enable Versatile CLCD connectors\n");
>   
>   	switch (format) {
> -	case DRM_FORMAT_ABGR8888:
>   	case DRM_FORMAT_XBGR8888:
> -	case DRM_FORMAT_ARGB8888:
>   	case DRM_FORMAT_XRGB8888:
>   		val |= SYS_CLCD_MODE_888;
>   		break;
> @@ -221,9 +219,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
>   	case DRM_FORMAT_RGB565:
>   		val |= SYS_CLCD_MODE_565_B_LSB;
>   		break;
> -	case DRM_FORMAT_ABGR1555:
>   	case DRM_FORMAT_XBGR1555:
> -	case DRM_FORMAT_ARGB1555:
>   	case DRM_FORMAT_XRGB1555:
>   		val |= SYS_CLCD_MODE_5551;
>   		break;
> @@ -266,44 +262,30 @@ static void pl111_realview_clcd_enable(struct drm_device *drm, u32 format)
>   
>   /* PL110 pixel formats for Integrator, vanilla PL110 */
>   static const u32 pl110_integrator_pixel_formats[] = {
> -	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ARGB8888,
>   	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_ABGR1555,
>   	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_ARGB1555,
>   	DRM_FORMAT_XRGB1555,
>   };
>   
>   /* Extended PL110 pixel formats for Integrator and Versatile */
>   static const u32 pl110_versatile_pixel_formats[] = {
> -	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ARGB8888,
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_BGR565, /* Uses external PLD */
>   	DRM_FORMAT_RGB565, /* Uses external PLD */
> -	DRM_FORMAT_ABGR1555,
>   	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_ARGB1555,
>   	DRM_FORMAT_XRGB1555,
>   };
>   
>   static const u32 pl111_realview_pixel_formats[] = {
> -	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ARGB8888,
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_BGR565,
>   	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_ABGR1555,
>   	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_ARGB1555,
>   	DRM_FORMAT_XRGB1555,
> -	DRM_FORMAT_ABGR4444,
>   	DRM_FORMAT_XBGR4444,
> -	DRM_FORMAT_ARGB4444,
>   	DRM_FORMAT_XRGB4444,
>   };
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


