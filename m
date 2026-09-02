Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9BAC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64D510E449;
	Wed,  2 Sep 2026 11:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yxdf0k4E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+hwy4A9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LYU7pnBX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iAqGozvW";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95CA10E449
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 11:21:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80D9F1F7D2;
 Wed,  2 Sep 2026 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788348083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FiOoqi3h+kzn4yK1DrCKxTcA9jp6Dg8SuIx5oIlI9wI=;
 b=yxdf0k4ETcg5uEU9MgcDus3/Yddtwl642QYrT6KhWaIUmcz52FaeB9qeoU0BKwzhp8MVlC
 oLKHH61SQBsq+oJkIUfEqSA0OlgRk5a1z5j3NEP/4BXGHv+02PrdrehIRY7Jz9cuR4Ejqv
 c826hiljFLg6iUdDS3OoKnUnmhbdOno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788348083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FiOoqi3h+kzn4yK1DrCKxTcA9jp6Dg8SuIx5oIlI9wI=;
 b=E+hwy4A9emRERlFd0Vis16Vyk5QpyI3GS0/OEwP4PSeeDWd4IqLLxO4xppFS3ZVKgemSS1
 3F1EAdlXw64vSTBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LYU7pnBX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iAqGozvW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788348079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FiOoqi3h+kzn4yK1DrCKxTcA9jp6Dg8SuIx5oIlI9wI=;
 b=LYU7pnBXPfzy2xLfME0cn6ShonYAHvOh8p/Lq3ZWfYSP4C2Ki1yjnLklQZHOPI26L0MnJc
 JQQbvaETm/JLQENzt9kA3PR5pNYPMNIns3NfOTAX03ueTjIYK5lZMpyMA2ohn1xGiV+nDa
 shjPyGBb0X4n70ZS7Gsx74la+Aabc+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788348079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FiOoqi3h+kzn4yK1DrCKxTcA9jp6Dg8SuIx5oIlI9wI=;
 b=iAqGozvWDiZVXEmsDtfrcX2oQfokmDkcWrmLXedRuI+c6dgXRiuOs8pcaBywnbFPG7GMgr
 GCxz/wmTDs4cV7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E00513736;
 Wed,  2 Sep 2026 11:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KybyCa8GmGp5VAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 11:21:19 +0000
Message-ID: <8de34f05-cef3-47df-8aef-c50af58b5f0d@suse.de>
Date: Wed, 2 Sep 2026 13:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gma500: Create the primary plane in the driver
To: oushixiong1025@163.com, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20260902100427.622166-1-oushixiong1025@163.com>
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
In-Reply-To: <20260902100427.622166-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80D9F1F7D2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[163.com,gmail.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,kylinos.cn];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, kylinos.cn:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.de:dkim,
 suse.de:mid]
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

Hi,

thanks for the follow-up patch.

Am 02.09.26 um 12:04 schrieb oushixiong1025@163.com:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> drm_crtc_init() creates the primary plane from a fixed format list
> that includes ARGB8888. The display engine programs the primary plane
> with DISPPLANE_32BPP_NO_ALPHA, so it does not support per-pixel alpha
> and must not advertise alpha formats. Since commit 860e748bddcc
> ("drm: ensure blend mode supported if pixel format with alpha exposed"),
> drm_mode_config_validate() warns about this at probe time.
>
> Replace drm_crtc_init() with a driver-owned primary plane that
> advertises only XRGB8888.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/gma500/psb_intel_display.c | 38 +++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> index 0df75a4a7739..336943cfeb68 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> @@ -9,8 +9,11 @@
>   #include <linux/delay.h>
>   #include <linux/i2c.h>
>   
> +#include <drm/drm_fourcc.h>
>   #include <drm/drm_modeset_helper.h>
>   #include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_plane_helper.h>
>   #include <drm/drm_print.h>
>   
>   #include "framebuffer.h"
> @@ -471,11 +474,24 @@ static void psb_intel_cursor_init(struct drm_device *dev,
>   	REG_WRITE(base[gma_crtc->pipe], 0);
>   }
>   
> +static const uint32_t gma_primary_formats[] = {
> +	/*
> +	 * The display engine programs the primary plane with
> +	 * DISPPLANE_32BPP_NO_ALPHA, so no formats with alpha.
> +	 */

That comment applies to the complete array, so it should go first.

> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static const struct drm_plane_funcs gma_primary_plane_funcs = {
> +	DRM_PLANE_NON_ATOMIC_FUNCS,

I think you should open-code the initializer macro.  Because the 
non-atomic modesetting is deprecated, open-coding the macro now might 
help if we ever want to convert the gma500 driver to atomic mode setting.


> +};
> +
>   void psb_intel_crtc_init(struct drm_device *dev, int pipe,
>   		     struct psb_intel_mode_device *mode_dev)
>   {
>   	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
>   	struct gma_crtc *gma_crtc;
> +	struct drm_plane *primary;
>   	int i;
>   
>   	/* We allocate a extra array of drm_connector pointers
> @@ -494,7 +510,27 @@ void psb_intel_crtc_init(struct drm_device *dev, int pipe,
>   		return;
>   	}
>   
> -	drm_crtc_init(dev, &gma_crtc->base, &gma_crtc_funcs);
> +	primary = __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
> +					      &gma_primary_plane_funcs,
> +					      gma_primary_formats,
> +					      ARRAY_SIZE(gma_primary_formats),
> +					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);

Please call drmm_universal_plane_alloc() instead. It will handle cleanup 
for you.

Best regards
Thomas

> +	if (IS_ERR(primary)) {
> +		dev_err(dev->dev, "Failed to allocate primary plane: %pe\n",
> +			primary);
> +		kfree(gma_crtc->crtc_state);
> +		kfree(gma_crtc);
> +		return;
> +	}
> +
> +	if (drm_crtc_init_with_planes(dev, &gma_crtc->base, primary, NULL,
> +				      &gma_crtc_funcs, NULL)) {
> +		dev_err(dev->dev, "Failed to init CRTC %d\n", pipe);
> +		drm_plane_cleanup(primary);
> +		kfree(primary);
> +		kfree(gma_crtc->crtc_state);
> +		return;
> +	}
>   
>   	/* Set the CRTC clock functions from chip specific data */
>   	gma_crtc->clock_funcs = dev_priv->ops->clock_funcs;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


