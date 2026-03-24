Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B1F532EC
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB8710E536;
	Tue, 24 Mar 2026 08:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ivirbLHV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EqQu+42W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ivirbLHV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EqQu+42W";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC58F10E536
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:07:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 922CE4D1CE;
 Tue, 24 Mar 2026 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774339625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sp16RUSAfxWKbsfT6ObUWpoRatraWEqxxIyRMJ+tpo8=;
 b=ivirbLHV8MhSleZ2IAhlneKGF8S9xUV/aWGZ8rKNieOZPdpYqburTTkdhvahsCGcfU0GIs
 ekBxSygAfMgnZibEC0CaYzwNOVA7aV4TmmY3UQP/UfhT+jtmtog/gWSVb+UtGxLAYck5se
 r0AfM75iGia4+uhfiM/KkkqhisLdwHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774339625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sp16RUSAfxWKbsfT6ObUWpoRatraWEqxxIyRMJ+tpo8=;
 b=EqQu+42WYXdVWWELq31OfNik2OmM8UDBLdwFycZOg+arQiNFrVKduCgqetjRaAeirWSfpR
 jpyEMUvams+PPiCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774339625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sp16RUSAfxWKbsfT6ObUWpoRatraWEqxxIyRMJ+tpo8=;
 b=ivirbLHV8MhSleZ2IAhlneKGF8S9xUV/aWGZ8rKNieOZPdpYqburTTkdhvahsCGcfU0GIs
 ekBxSygAfMgnZibEC0CaYzwNOVA7aV4TmmY3UQP/UfhT+jtmtog/gWSVb+UtGxLAYck5se
 r0AfM75iGia4+uhfiM/KkkqhisLdwHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774339625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sp16RUSAfxWKbsfT6ObUWpoRatraWEqxxIyRMJ+tpo8=;
 b=EqQu+42WYXdVWWELq31OfNik2OmM8UDBLdwFycZOg+arQiNFrVKduCgqetjRaAeirWSfpR
 jpyEMUvams+PPiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5862743D2C;
 Tue, 24 Mar 2026 08:07:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TwwkFClGwmnpSwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Mar 2026 08:07:05 +0000
Message-ID: <a53e8e43-ba8d-46f6-8b7c-6cca5c561707@suse.de>
Date: Tue, 24 Mar 2026 09:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v3 4/4] drm: verisilicon: fill plane's
 vs_format in atomic_check
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
References: <20260305153817.157841-1-zhengxingda@iscas.ac.cn>
 <20260305153817.157841-5-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260305153817.157841-5-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[iscas.ac.cn:email,suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, iscas.ac.cn:email,
 suse.com:url, suse.de:mid, suse.de:email]
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
> Move the conversion from drm_format to vs_format to atomic_check, which
> is before the point of no return and can properly bail out.
>
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

with a minor comment below.

> ---
> Changes in v3:
> - Move the code filling vs_format to after drm_atomic_helper_check_plane_state()
>    call.
> - Add drm_WARN_ON_ONCE when filling vs_format fails.
> - Add code copying vs_format in vs_plane_duplicate_state (because it no
>    longer memdup's the whole struct vs_plane_state).
>
> Changes in v2:
> - Add non-NULL check for drm_plane_state->fb.
>
>   drivers/gpu/drm/verisilicon/vs_plane.c        |  7 +++-
>   drivers/gpu/drm/verisilicon/vs_plane.h        |  2 ++
>   .../gpu/drm/verisilicon/vs_primary_plane.c    | 35 +++++++++++++------
>   3 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
> index e92b869fb90ca..902c6f66c975f 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.c
> @@ -129,17 +129,22 @@ dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
>   
>   struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)
>   {
> -	struct vs_plane_state *vs_state;
> +	struct vs_plane_state *vs_state, *vs_state_old;
>   
>   	if (drm_WARN_ON(plane->dev, !plane->state))
>   		return NULL;
>   
> +	vs_state_old = to_vs_plane_state(plane->state);
> +
>   	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
>   	if (!vs_state)
>   		return NULL;
>   
>   	__drm_atomic_helper_plane_duplicate_state(plane, &vs_state->base);
>   
> +	memcpy(&vs_state->format, &vs_state_old->format,
> +	       sizeof(struct vs_format));
> +
>   	return &vs_state->base;
>   }
>   
> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
> index 48ed8fc754d18..f18c36ef4cd90 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.h
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.h
> @@ -65,6 +65,8 @@ struct vs_format {
>   
>   struct vs_plane_state {
>   	struct drm_plane_state base;
> +
> +	struct vs_format format;
>   };
>   
>   static inline struct vs_plane_state *to_vs_plane_state(struct drm_plane_state *state)
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index 421d6f9dc547b..3d45101838aeb 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -25,17 +25,31 @@ static int vs_primary_plane_atomic_check(struct drm_plane *plane,
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
> +	struct vs_plane_state *new_vs_plane_state = to_vs_plane_state(new_plane_state);
> +	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *crtc_state = NULL;
> +	int ret;
>   
>   	if (crtc)
>   		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   
> -	return drm_atomic_helper_check_plane_state(new_plane_state,
> -						   crtc_state,
> -						   DRM_PLANE_NO_SCALING,
> -						   DRM_PLANE_NO_SCALING,
> -						   false, true);
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state,
> +						  crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, true);
> +	if (ret)
> +		return ret;

Ideomatic is to do

if (!new_plane_state->visible)
     return 0;

here. And then could drop the !fb branching below.

Best regards
Thomas

> +
> +	if (fb) {
> +		ret = drm_format_to_vs_format(fb->format->format,
> +					      &new_vs_plane_state->format);
> +		if (drm_WARN_ON_ONCE(plane->dev, ret))
> +			return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
> @@ -84,11 +98,11 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
>   {
>   	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
>   								       plane);
> +	struct vs_plane_state *vs_state = to_vs_plane_state(state);
>   	struct drm_framebuffer *fb = state->fb;
>   	struct drm_crtc *crtc = state->crtc;
>   	struct vs_dc *dc;
>   	struct vs_crtc *vcrtc;
> -	struct vs_format fmt;
>   	unsigned int output;
>   	dma_addr_t dma_addr;
>   
> @@ -101,16 +115,15 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
>   	output = vcrtc->id;
>   	dc = vcrtc->dc;
>   
> -	drm_format_to_vs_format(state->fb->format->format, &fmt);
> -
>   	regmap_update_bits(dc->regs, VSDC_FB_CONFIG(output),
>   			   VSDC_FB_CONFIG_FMT_MASK,
> -			   VSDC_FB_CONFIG_FMT(fmt.color));
> +			   VSDC_FB_CONFIG_FMT(vs_state->format.color));
>   	regmap_update_bits(dc->regs, VSDC_FB_CONFIG(output),
>   			   VSDC_FB_CONFIG_SWIZZLE_MASK,
> -			   VSDC_FB_CONFIG_SWIZZLE(fmt.swizzle));
> +			   VSDC_FB_CONFIG_SWIZZLE(vs_state->format.swizzle));
>   	regmap_assign_bits(dc->regs, VSDC_FB_CONFIG(output),
> -			   VSDC_FB_CONFIG_UV_SWIZZLE_EN, fmt.uv_swizzle);
> +			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
> +			   vs_state->format.uv_swizzle);
>   
>   	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


