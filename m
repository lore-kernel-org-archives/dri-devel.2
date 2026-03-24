Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54F6F532E5
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2011410E5F8;
	Tue, 24 Mar 2026 07:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="W4e/F3ws";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CZKt/lsr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W4e/F3ws";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CZKt/lsr";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3D710E5F8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 07:53:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41DFE5BCE6;
 Tue, 24 Mar 2026 07:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774338795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dNAa0pZkp4ZrEv3/+johTXFMzLOdcv+NE2w+/OIwTts=;
 b=W4e/F3wsfluD5WgKMiNPDAqMyQNAl+SC0aqC5HVHjSFNzFDAO8iEI1zE0iDm03Eh2i1lZv
 D5H691NsGfSDtjuALNcvrOQJ9cUrBRcvd3WHKE7RhF2vY9bMe6p2MoIRlg41O7wdQeMhhm
 5kFLsKwVSEM/MDOKv1l2YWS/mDwoM58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774338795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dNAa0pZkp4ZrEv3/+johTXFMzLOdcv+NE2w+/OIwTts=;
 b=CZKt/lsrHd0/ppkajY+tMq4Sb5BRiz94hURfMXkDAzqgJiA12+O/CSssQhQzG4yuQP1Bvs
 vKDSl04uljUbxLBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="W4e/F3ws";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="CZKt/lsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774338795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dNAa0pZkp4ZrEv3/+johTXFMzLOdcv+NE2w+/OIwTts=;
 b=W4e/F3wsfluD5WgKMiNPDAqMyQNAl+SC0aqC5HVHjSFNzFDAO8iEI1zE0iDm03Eh2i1lZv
 D5H691NsGfSDtjuALNcvrOQJ9cUrBRcvd3WHKE7RhF2vY9bMe6p2MoIRlg41O7wdQeMhhm
 5kFLsKwVSEM/MDOKv1l2YWS/mDwoM58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774338795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dNAa0pZkp4ZrEv3/+johTXFMzLOdcv+NE2w+/OIwTts=;
 b=CZKt/lsrHd0/ppkajY+tMq4Sb5BRiz94hURfMXkDAzqgJiA12+O/CSssQhQzG4yuQP1Bvs
 vKDSl04uljUbxLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 033B643D1F;
 Tue, 24 Mar 2026 07:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BPi/OupCwmk7PQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Mar 2026 07:53:14 +0000
Message-ID: <01b16e9b-8fcb-410e-934a-61914b783848@suse.de>
Date: Tue, 24 Mar 2026 08:53:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v3 2/4] drm: verisilicon: subclass
 drm_plane_state
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
References: <20260305153817.157841-1-zhengxingda@iscas.ac.cn>
 <20260305153817.157841-3-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260305153817.157841-3-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[iscas.ac.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid, suse.de:dkim,
 suse.de:email, iscas.ac.cn:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 41DFE5BCE6
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

Am 05.03.26 um 16:38 schrieb Icenowy Zheng:
> Create a subclass of drm_plane_state to store hardware-specific state
> information (e.g. hardware plane format settings) in the future.
>
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

with a minor comment below.

> ---
> Changes in v3:
> - Switch to drm_WARN_ON().
> - Stop to memdup the state.
> - Move the code freeing the existing plane state to the branch checking
>    whether it's not NULL.
> - Rename the typecast function to `to_vs_plane_state()`.
>
> Changes in v2:
> - Add the #include clause for atomic state helpers, which was wrongly
>    placed in the previous patch in v1.
> - Switch to kzalloc_obj helper for allocating the state.
>
>   drivers/gpu/drm/verisilicon/vs_plane.c        | 42 +++++++++++++++++++
>   drivers/gpu/drm/verisilicon/vs_plane.h        | 14 +++++++
>   .../gpu/drm/verisilicon/vs_primary_plane.c    |  6 +--
>   3 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
> index fa88ed14e41d7..e92b869fb90ca 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.c
> @@ -6,9 +6,11 @@
>   #include <linux/errno.h>
>   #include <linux/printk.h>
>   
> +#include <drm/drm_atomic_state_helper.h>
>   #include <drm/drm_fb_dma_helper.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_print.h>
>   
>   #include "vs_plane.h"
>   
> @@ -124,3 +126,43 @@ dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
>   
>   	return dma_addr;
>   }
> +
> +struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)
> +{
> +	struct vs_plane_state *vs_state;
> +
> +	if (drm_WARN_ON(plane->dev, !plane->state))
> +		return NULL;
> +
> +	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
> +	if (!vs_state)
> +		return NULL;
> +
> +	__drm_atomic_helper_plane_duplicate_state(plane, &vs_state->base);
> +
> +	return &vs_state->base;
> +}
> +
> +void vs_plane_destroy_state(struct drm_plane *plane,
> +			    struct drm_plane_state *state)
> +{
> +	__drm_atomic_helper_plane_destroy_state(state);
> +	kfree(state);
> +}
> +
> +/* Called during init to allocate the plane's atomic state. */
> +void vs_plane_reset(struct drm_plane *plane)
> +{
> +	struct vs_plane_state *vs_state;
> +
> +	if (plane->state) {
> +		__drm_atomic_helper_plane_destroy_state(plane->state);
> +		kfree(plane->state);

You could clear plane->state to NULL here.  If the kzalloc_obj() fails, 
you'd at least not leave a dangling pointer.  Since reset runs during 
init, there should not be a plane state. But that might change at some 
point.

Best regards
Thomas

> +	}
> +
> +	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
> +	if (!vs_state)
> +		return;
> +
> +	__drm_atomic_helper_plane_reset(plane, &vs_state->base);
> +}
> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
> index a88cc19f2202e..48ed8fc754d18 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.h
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.h
> @@ -63,10 +63,24 @@ struct vs_format {
>   	bool uv_swizzle;
>   };
>   
> +struct vs_plane_state {
> +	struct drm_plane_state base;
> +};
> +
> +static inline struct vs_plane_state *to_vs_plane_state(struct drm_plane_state *state)
> +{
> +	return container_of(state, struct vs_plane_state, base);
> +}
> +
>   int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format);
>   dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
>   			      const struct drm_rect *src_rect);
>   
> +struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane);
> +void vs_plane_destroy_state(struct drm_plane *plane,
> +			    struct drm_plane_state *state);
> +void vs_plane_reset(struct drm_plane *plane);
> +
>   struct drm_plane *vs_primary_plane_init(struct drm_device *dev, struct vs_dc *dc);
>   
>   #endif /* _VS_PLANE_H_ */
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index e8fcb5958615c..bad0bc5e3242d 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -145,10 +145,10 @@ static const struct drm_plane_helper_funcs vs_primary_plane_helper_funcs = {
>   };
>   
>   static const struct drm_plane_funcs vs_primary_plane_funcs = {
> -	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> -	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state	= vs_plane_destroy_state,
> +	.atomic_duplicate_state	= vs_plane_duplicate_state,
>   	.disable_plane		= drm_atomic_helper_disable_plane,
> -	.reset			= drm_atomic_helper_plane_reset,
> +	.reset			= vs_plane_reset,
>   	.update_plane		= drm_atomic_helper_update_plane,
>   };
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


