Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D294C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742AF10E244;
	Thu, 10 Sep 2026 06:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="qq84fnAF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sF6zO0RI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kI4u8I/n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CUYsT65Q";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E940D10E254
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:15:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2887D21A96;
 Thu, 10 Sep 2026 06:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789020950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtZ6KKo0m8q9d/XrPphq/EW6xUtWRsSpn3xh5iY2+i4=;
 b=qq84fnAF/3i3OA/r/RT14SsIpolJYOH1myvzTxFt2oFH8u8U9VncRGd/lfmTy2wNQswdOr
 VbEWl+qqNeWEAAoQ2+sEyyagIy3L4HkMSepmUzWd3ahWzT1Ae2r3/TmsuQvX4aOmForDee
 Kgm4GPsH2wrJTQc6rM/PzfrumFSKoR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789020950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtZ6KKo0m8q9d/XrPphq/EW6xUtWRsSpn3xh5iY2+i4=;
 b=sF6zO0RIi/ea/OvAdi/BPQMSHeO0wjHin9vwAFvlPkXDjyWOXgKvBT7vvgor+32Dv6umPL
 UNZXyjyiuRT7tjBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kI4u8I/n";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CUYsT65Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789020946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtZ6KKo0m8q9d/XrPphq/EW6xUtWRsSpn3xh5iY2+i4=;
 b=kI4u8I/n6LcAfzWvf+t+Q/Q+zj2l4Js+dGSgfgQMTxzLRnAOEmDp5AuSktwjV0eOlzCn+I
 e/jajGpGljcTePjq+mQS9Cli0U/oeN2acVVWiaNXx8XnmEoPVS9/JeFzuC2oRjUlJur1MH
 +l76yZQyhjkmJyX7OEaNfWln9OQKhoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789020946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtZ6KKo0m8q9d/XrPphq/EW6xUtWRsSpn3xh5iY2+i4=;
 b=CUYsT65Qj/scyaPId9g7tNGhSTEDgc2kOTf0uQfBwUC19l8+w5yctWZi4nkaqeNwSnVoun
 3H2TJhzuQHubQ4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9262613185;
 Thu, 10 Sep 2026 06:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HtyWGxFLomp9PgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 06:15:45 +0000
Message-ID: <f938789c-3dd7-4fb1-8adf-2b535989e4c3@suse.de>
Date: Thu, 10 Sep 2026 08:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/pl111: drop alpha formats the hardware cannot scan
 out
To: Roshan Kumar <roshaen09@gmail.com>, linusw@kernel.org,
 dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, pimyn@google.com,
 linux-kernel@vger.kernel.org
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <20260910054503.4155812-1-roshaen09@gmail.com>
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
In-Reply-To: <20260910054503.4155812-1-roshaen09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2887D21A96
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.freedesktop.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[collabora.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,google.com,vger.kernel.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.com:url]
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

Am 10.09.26 um 07:45 schrieb Roshan Kumar:
> The PL110/PL111 controller scans out a single framebuffer and never
> blends its alpha channel with anything. In the pixel-format tables every
> alpha-carrying entry (ARGB/ABGR in 8888, 1555 and 4444) maps to exactly
> the same register configuration as its XRGB/XBGR counterpart, so the
> alpha byte was never used by the hardware.
>
> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") added validation that warns when a plane exposes
> alpha formats without a pixel blend mode property, and PL111 does exactly
> that. With panic_on_warn enabled the warning prevents the syzkaller
> vexpress-a15 manager from booting.
>
> Drivers should not report formats they do not support, so remove the
> alpha formats from the PL110, PL111 and Nomadik PL110 variant tables and
> the now dead case labels in the display setup, instead of advertising a
> blend mode property. Behavior is unchanged for userspace that picks an
> XRGB/XBGR/RGB format; alpha-picking clients fall back to the identical
> X variant.

Please see the comment from the Sashiko bot about additional alpha 
formats. Apart from that that patch looks good.

BTW, do you have this hardware available for testing?

Best regards
Thomas

>
> Link: https://github.com/google/syzkaller/issues/7805
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
> Changes in v2: drop the alpha formats entirely instead of advertising a
> DRM_MODE_BLEND_PIXEL_NONE property, per review feedback from Thomas
> Zimmermann. Leandro's Reviewed-by from v1 is not carried as the
> approach changed.
>
> ---
>   drivers/gpu/drm/pl111/pl111_display.c |  6 ------
>   drivers/gpu/drm/pl111/pl111_drv.c     | 16 ----------------
>   2 files changed, 22 deletions(-)
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

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


