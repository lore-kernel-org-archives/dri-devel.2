Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6BDC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7C910F020;
	Wed,  2 Sep 2026 07:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Rpe+Fhcf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OchFqi2Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXn7Oy8n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5LC7isgA";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA79A10EFFC
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:05:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 286051FB1B;
 Wed,  2 Sep 2026 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788332717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hBC3OzVVGPPsGzCNMnp/X1WDtjDVI9LuEYcUAX6/ISI=;
 b=Rpe+FhcfngDN2sjqa4/ddiYOZ3+JF8N7DavmtgvLeLS7J228wFsFG3SulaFvMcgQl5s3hv
 +S0FlebC1Y5gnc+MWIPOvETzKeL8Ks8294/T6e+6LjOzYPc1QJekbLgdrjG/lo8BM7ovp8
 A0r8q9CGGRvGDxkIYpbDK2TlLi8ZQ9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788332717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hBC3OzVVGPPsGzCNMnp/X1WDtjDVI9LuEYcUAX6/ISI=;
 b=OchFqi2ZNx2TBJKP5jI9mMX6q6f43f2oLo9T0zgWMDhvKgDBFk9FtDhGHMPvq+RqGldifD
 3ZWRJmG7nwzuG+CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rXn7Oy8n;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5LC7isgA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788332713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hBC3OzVVGPPsGzCNMnp/X1WDtjDVI9LuEYcUAX6/ISI=;
 b=rXn7Oy8nOkHKwZ1dr1Go/qxu0+btxHyVp4aCuHLQl2ZTv7Q72op9rGP/IkziW9Mp3u75Jy
 SplP1rI1fzFdmeTnqFh39RLExoZjuK77u6ij8be2Sljh8HD4sAfT6f1iCwbV6Lqg8+IPTi
 zqk0+DCVqyPIdPg+uMB+6nnnSH03Ru4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788332713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hBC3OzVVGPPsGzCNMnp/X1WDtjDVI9LuEYcUAX6/ISI=;
 b=5LC7isgA+WnDKJHKeIPSChLYSeJ3GrKEJuJrSl/y9R/9T0YofdjAwskv5c2XCquzpeSUbA
 ByFdiCY2Fe7TCmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE86A13515;
 Wed,  2 Sep 2026 07:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ne/2NKjKl2qvUQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 07:05:12 +0000
Message-ID: <09f547df-576a-4445-830c-e4dac6a309a8@suse.de>
Date: Wed, 2 Sep 2026 09:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] drm/crtc: Introduce hw_reset helper hook
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-1-4500d49a337f@kernel.org>
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
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-1-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 286051FB1B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url];
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

Hi Maxime

Am 31.08.26 um 17:34 schrieb Maxime Ripard:
> The CRTC reset hook conflates initial software state allocation with
> hardware reset. The atomic_create_state hook addresses the software
> state side, but drivers may still need to reset hardware to a known good
> state during drm_mode_config_reset(), for example during suspend/resume.
>
> Separating hardware reset from state allocation is also useful for the
> pending atomic state readout and userspace atomic reset flag series,
> which need to create pristine software state without affecting the
> hardware.
>
> Introduce a hw_reset hook in struct drm_crtc_helper_funcs that only
> resets the hardware, without touching the software state at all. Call it
> from drm_mode_config_crtc_reset_with_create_state() after the state has
> been successfully created.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

with comments below.

> ---
>   drivers/gpu/drm/drm_mode_config.c        | 13 ++++++++++++-
>   include/drm/drm_modeset_helper_vtables.h | 14 ++++++++++++++
>   2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 366f6d821242..bb2efc274323 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -28,10 +28,11 @@
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_mode_config.h>
> +#include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_colorop.h>
>   #include <linux/dma-resv.h>
>   
>   #include "drm_crtc_internal.h"
> @@ -228,16 +229,26 @@ static int drm_mode_config_crtc_create_state(struct drm_crtc *crtc)
>   	return 0;
>   }
>   
>   static int drm_mode_config_crtc_reset_with_create_state(struct drm_crtc *crtc)
>   {
> +	const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;

Please see the Sahsiko comment about this being NULL. And I suggest to 
call the variable 'helpers' because 'funcs' sounds like regular 
drm_crtc_funcs. But that's really just nitpicking.

Best regards
Thomas

> +	int ret;
> +
>   	if (crtc->state) {
>   		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
>   		crtc->state = NULL;
>   	}
>   
> -	return drm_mode_config_crtc_create_state(crtc);
> +	ret = drm_mode_config_crtc_create_state(crtc);
> +	if (ret)
> +		return ret;
> +
> +	if (crtc_funcs->hw_reset)
> +		crtc_funcs->hw_reset(crtc);
> +
> +	return 0;
>   }
>   
>   static int drm_mode_config_connector_create_state(struct drm_connector *connector)
>   {
>   	struct drm_connector_state *conn_state;
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index ca6268945c28..4965356a6314 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -279,10 +279,24 @@ struct drm_crtc_helper_funcs {
>   	 * drivers still using legacy CRTC helpers, which is different from the
>   	 * rules under atomic.
>   	 */
>   	void (*disable)(struct drm_crtc *crtc);
>   
> +	/**
> +	 * @hw_reset:
> +	 *
> +	 * Optional hook for CRTC hardware reset.
> +	 *
> +	 * Unlike @drm_crtc_funcs.reset, which both resets hardware and
> +	 * creates new software state, this hook only resets the
> +	 * hardware to a known good state without touching the software
> +	 * state at all.
> +	 *
> +	 * This hook is called by drm_mode_config_reset().
> +	 */
> +	void (*hw_reset)(struct drm_crtc *crtc);
> +
>   	/**
>   	 * @atomic_check:
>   	 *
>   	 * Drivers should check plane-update related CRTC constraints in this
>   	 * hook. They can also check mode related limitations but need to be
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


