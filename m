Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B123CC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0126210E2EC;
	Thu, 16 Jul 2026 06:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cIYSrIbC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RotCm/dR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cIYSrIbC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RotCm/dR";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAED110E2A1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:59:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CD6C3E2F;
 Thu, 16 Jul 2026 06:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784185180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q1Sttv12LM5ZFZtfZAvp/tl8h/l27/XJeBYQK86qDiI=;
 b=cIYSrIbCUduGY3EjUg90J9G3UC0BYUuCjzVkIcfrWU8iZlvcW5Iu9UHdFKr+KaXkJ4f0bs
 MPfPPpnxDBbWBa1rK9L7VvZ3byu+G/efByfjorVk/sAV2DEyIG3sXQsmLs/nqwcmVRPzWw
 Ku64UflloBaoMkE5pPc/RBAZrSJyrXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784185180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q1Sttv12LM5ZFZtfZAvp/tl8h/l27/XJeBYQK86qDiI=;
 b=RotCm/dRVAuJZXZ1+5A3Y0v0/p/apXcKPfJJfvZwH/7OyTAKd2wgM4iWSbFnB0QXKtEgVD
 wKK1oZYEzEcrBXBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cIYSrIbC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="RotCm/dR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784185180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q1Sttv12LM5ZFZtfZAvp/tl8h/l27/XJeBYQK86qDiI=;
 b=cIYSrIbCUduGY3EjUg90J9G3UC0BYUuCjzVkIcfrWU8iZlvcW5Iu9UHdFKr+KaXkJ4f0bs
 MPfPPpnxDBbWBa1rK9L7VvZ3byu+G/efByfjorVk/sAV2DEyIG3sXQsmLs/nqwcmVRPzWw
 Ku64UflloBaoMkE5pPc/RBAZrSJyrXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784185180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q1Sttv12LM5ZFZtfZAvp/tl8h/l27/XJeBYQK86qDiI=;
 b=RotCm/dRVAuJZXZ1+5A3Y0v0/p/apXcKPfJJfvZwH/7OyTAKd2wgM4iWSbFnB0QXKtEgVD
 wKK1oZYEzEcrBXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1569C779AD;
 Thu, 16 Jul 2026 06:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uuLAA1yBWGoRfQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 16 Jul 2026 06:59:40 +0000
Message-ID: <ba82ad37-5d51-40e6-92cb-56b9a12f5ecd@suse.de>
Date: Thu, 16 Jul 2026 08:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: make panel orientation quirks optional
To: Andrew Zhou <zhoulol888@gmail.com>, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org
References: <20260716065106.150760-1-zhoulol888@gmail.com>
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
In-Reply-To: <20260716065106.150760-1-zhoulol888@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4CD6C3E2F
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

Am 16.07.26 um 08:51 schrieb Andrew Zhou:
> DRM currently selects DRM_PANEL_ORIENTATION_QUIRKS unconditionally,
> forcing all DRM users to compile embedded LCD panel quirk detection.
> This is unnecessary on desktop and server systems with external
> monitors.
>
> Add a static inline stub in drm_utils.h that returns
> DRM_MODE_PANEL_ORIENTATION_UNKNOWN when the option is disabled,
> and make the Kconfig option user-visible with a description.
>
> Compile-tested with CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y and =n.
> Boot-tested in QEMU with TinyCorePure64.

NAK. We also need these quirks on desktops, and disabling error 
workarounds makes little sense IMHO.

Best regards
Thomas

>
> Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
> ---
>   drivers/gpu/drm/Kconfig                        | 14 ++++++++++++--
>   drivers/gpu/drm/drm_panel_orientation_quirks.c |  6 ++++--
>   include/drm/drm_utils.h                        |  8 ++++++++
>   3 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f..da4ac94bbf61 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -8,7 +8,6 @@
>   menuconfig DRM
>   	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
>   	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
> -	select DRM_PANEL_ORIENTATION_QUIRKS
>   	select HDMI
>   	select I2C
>   	select DMA_SHARED_BUFFER
> @@ -369,4 +368,15 @@ endif
>   
>   # Separate option because drm_panel_orientation_quirks.c is shared with fbdev
>   config DRM_PANEL_ORIENTATION_QUIRKS
> -	tristate
> +	tristate "Panel orientation quirks for DMI-based detection"
> +	depends on DRM
> +	help
> +	  Enable DMI-based quirk detection for devices where the
> +	  built-in LCD panel is mounted in a non-standard orientation
> +	  relative to the casing (e.g., handheld PCs, tablets).
> +
> +	  This allows userspace to automatically rotate the display
> +	  to match the physical orientation of the device.
> +
> +	  Desktop and server systems with external monitors do not
> +	  need this. If unsure, say N.
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3a218fb592ce..fb09078a831a 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -14,7 +14,7 @@
>   #include <drm/drm_connector.h>
>   #include <drm/drm_utils.h>
>   
> -#ifdef CONFIG_DMI
> +#if defined(CONFIG_DMI) && defined(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS)
>   
>   /*
>    * Some x86 clamshell design devices use portrait tablet screens and a display
> @@ -589,7 +589,7 @@ EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
>   
>   #else
>   
> -/* There are no quirks for non x86 devices yet */
> +/* Fallback stub when DMI or the entire quirk module is disabled. */
>   int drm_get_panel_orientation_quirk(int width, int height)
>   {
>   	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> @@ -598,5 +598,7 @@ EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
>   
>   #endif
>   
> +#ifdef CONFIG_DRM_PANEL_ORIENTATION_QUIRKS
>   MODULE_DESCRIPTION("Quirks for non-normal panel orientation");
>   MODULE_LICENSE("Dual MIT/GPL");
> +#endif
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 6a46f755daba..947b8e71260e 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -11,10 +11,18 @@
>   #define __DRM_UTILS_H__
>   
>   #include <linux/types.h>
> +#include <drm/drm_connector.h>
>   
>   struct drm_edid;
>   
> +#ifdef CONFIG_DRM_PANEL_ORIENTATION_QUIRKS
>   int drm_get_panel_orientation_quirk(int width, int height);
> +#else
> +static inline int drm_get_panel_orientation_quirk(int width, int height)
> +{
> +	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +}
> +#endif
>   
>   struct drm_panel_backlight_quirk {
>   	u16 min_brightness;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


