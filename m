Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA91C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20FE10F2ED;
	Thu, 10 Sep 2026 06:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CgHcyNUR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tyHtC28Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NOZAtdIQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ox5PGyH6";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2C410F2ED
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:57:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 323B521CCC;
 Thu, 10 Sep 2026 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789023434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWvRHNUUCu2EGEkdZaoqEcdrIR0ju1Y4jhFsxrdmvxE=;
 b=CgHcyNURzmgNStpOgq2DsLxwa50DfLw/jz7aP7hIwwkcV9kwq81/7TBZHTqq3F6Xv2LF3f
 FpmNpWwO8v/a8gfqjejYZJ6lPK56llAobG+slk0KNjbvjPEqzzje4hsWe9a0xy05E/2vxw
 vSAoZkYe9V2bqG/Yo7FhFdL2eAdcpxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789023434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWvRHNUUCu2EGEkdZaoqEcdrIR0ju1Y4jhFsxrdmvxE=;
 b=tyHtC28Z9gDTUkyXfdD7PUqVzw6eD1BAGQWvPERbD/+h/DHHpm59TS9x/P4NDo2fokeayJ
 iqsjw5TlmXcCVBBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NOZAtdIQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ox5PGyH6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789023430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWvRHNUUCu2EGEkdZaoqEcdrIR0ju1Y4jhFsxrdmvxE=;
 b=NOZAtdIQFPiTCiyrMXSV6oOeiStsxribPZlj3o8yQ3UYTlhp+5QPpFn29BLM9PJWpwEXlM
 mugZ9kpAlvDfKk/jaCLEPJf9XJr6F8hvyAqIifFzoSTpfI6K1S4yXavzhq/isBke7fmS3b
 TQ2tek/MoZK7MTysDd+TpR1xMtuky8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789023430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWvRHNUUCu2EGEkdZaoqEcdrIR0ju1Y4jhFsxrdmvxE=;
 b=Ox5PGyH6bPGcwpvKSBpgal9d3cGy9AXsVSwAlaj2k8MHSb5gq8LZadETdcyXAmTVNJcHFI
 IZtc6YJAUC6uK2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF38913185;
 Thu, 10 Sep 2026 06:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AvvJI8VUomosGwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 06:57:09 +0000
Message-ID: <9cc8f3f0-218c-49de-88eb-90907a176ff5@suse.de>
Date: Thu, 10 Sep 2026 08:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 35/41] drm/rcar-du: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, geert+renesas@glider.be,
 kieran.bingham+renesas@ideasonboard.com,
 laurent.pinchart+renesas@ideasonboard.com,
 linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com,
 tomi.valkeinen+renesas@ideasonboard.com
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
 <20260908-drm-no-more-plane-reset-v4-35-a31b3fcfc989@kernel.org>
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
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-35-a31b3fcfc989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 323B521CCC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,glider.be,ideasonboard.com,vger.kernel.org,gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[renesas];
 RCPT_COUNT_SEVEN(0.00)[11]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, glider.be:email, suse.com:url, suse.de:dkim,
 suse.de:mid, ideasonboard.com:email]
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



Am 08.09.26 um 16:47 schrieb Maxime Ripard:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
>
> The conversion was done using the following Coccinelle semantic patch:
>
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
>
> struct drm_plane_funcs funcs = {
>    ...,
> - .reset = drm_atomic_helper_plane_reset,
> + .atomic_create_state = drm_atomic_helper_plane_create_state,
>    ...,
> };
>
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs = {
>      ...,
>      .reset = reset_func,
>      ...,
> };
>
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
>
>   void reset_func(...)
>   {
>   	<+...
> (
>   	__drm_atomic_helper_plane_reset(...);
> |
> 	__drm_gem_reset_shadow_plane(...);
> )
>   	...+>
>   }
>
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs = {
>      ...,
>      .atomic_destroy_state = destroy_func,
>      ...,
> };
>
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
>      coccinelle.new_name = old_name.replace("_reset", "_create_state")
> else:
>      coccinelle.new_name = old_name
>
> @update_struct depends on match_struct_reset && reset_uses_helpers@
> identifier match_struct_reset.funcs, match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> @@
> struct drm_plane_funcs funcs = {
>      ...,
> -   .reset = reset_func,
> +   .atomic_create_state = new_name,
>      ...,
> };
>
> @drop_destroy depends on update_struct && match_struct_destroy@
> identifier match_struct_reset.reset_func;
> identifier match_struct_destroy.destroy_func;
> identifier container_func;
> identifier P;
> symbol drm_atomic_helper_plane_destroy_state;
> symbol __drm_atomic_helper_plane_destroy_state;
> @@
>
>   void reset_func(struct drm_plane *P)
>   {
>   	...
> (
> -	if (P->state) {
> - 		<+...
> (
> -		drm_atomic_helper_plane_destroy_state(P, P->state);
> |
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> |
> -		P->funcs->atomic_destroy_state(P, P->state);
> |
> -		destroy_func(P, P->state);
> )
> - 		...+>
> - 	}
> |
> -	drm_WARN_ON_ONCE(P->dev, P->state);
> |
> -	WARN_ON(P->state);
> )
>   	...
> (
> -	kfree(P->state);
> |
> -	kfree(container_func(P->state));
> |
>   	// kfree is optional
> )
> (
> -	P->state = NULL;
> |
>   	// plane->state clearing is optional
> )
>   	...
>   }
>
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
>
>   void mtk_plane_reset(struct drm_plane *P)
>   {
>   	...
> -	if (P->state) {
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> -		...
> -	} else {
>   		...
> -	}
>   	...
>   }
>
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
>
>   void nv50_wndw_reset(...)
>   {
>   	...
> -	if (WARN_ON(!(S = kzalloc_obj(*S))))
> +	S = kzalloc_obj(*S);
> +	if (WARN_ON(!S))
>   		return;
>   	...
>   }
>
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
>
>   void reset_func(struct drm_plane *P)
>   {
>   	<...
>   	S = kzalloc_obj(*S);
> (
> -	if (S)
> -	{
> -		STL
> -	}
> +	if (!S) return;
> +
> +	STL
> |
> -	if (S) ST
> +	if (!S) return;
> +
> +	ST
> )
> 	...>
>   }
>
> @transform_body depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier S, P;
> expression PS;
> @@
> - void reset_func(struct drm_plane *P)
> + struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>   	S = kzalloc_obj(*S);
> 	...
> (
>   	if (!S) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>   	}
> |
>   	if (WARN_ON(!S)) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>   	}
> |
>   	if (S == NULL) {
>   		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>   	}
> )
> 	...
> (
> -	__drm_atomic_helper_plane_reset(P, PS);
> +	__drm_atomic_helper_plane_state_init(PS, P);
> |
> -	__drm_gem_reset_shadow_plane(P, PS);
> +	__drm_gem_shadow_plane_state_init(P, PS);
> )
> 	...
> }
>
> @update_early_return depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>   struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	<+...
> -	return;
> +	return ERR_PTR(-EINVAL);
> 	...+>
> }
>
> @update_return_plane depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>   struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>   	__drm_atomic_helper_plane_state_init(PS, P);
> 	...
> +
> +	return PS;
> }
>
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>   struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>   	__drm_gem_shadow_plane_state_init(P, PS);
> 	...
> +
> +	return &PS->base;
> }
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: geert+renesas@glider.be
> Cc: kieran.bingham+renesas@ideasonboard.com
> Cc: laurent.pinchart+renesas@ideasonboard.com
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: magnus.damm@gmail.com
> Cc: tomi.valkeinen+renesas@ideasonboard.com
> ---
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c | 15 ++++++---------
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c   | 15 ++++++---------
>   2 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> index 8870766b9e54..da2dff9bb317 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> @@ -710,28 +710,25 @@ static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
>   {
>   	__drm_atomic_helper_plane_destroy_state(state);
>   	kfree(to_rcar_plane_state(state));
>   }
>   
> -static void rcar_du_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *rcar_du_plane_create_state(struct drm_plane *plane)
>   {
>   	struct rcar_du_plane_state *state;
>   
> -	if (plane->state) {
> -		rcar_du_plane_atomic_destroy_state(plane, plane->state);
> -		plane->state = NULL;
> -	}
> -
>   	state = kzalloc_obj(*state);
>   	if (state == NULL)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>   
> -	__drm_atomic_helper_plane_reset(plane, &state->state);
> +	__drm_atomic_helper_plane_state_init(&state->state, plane);
>   
>   	state->hwindex = -1;
>   	state->source = RCAR_DU_PLANE_MEMORY;
>   	state->colorkey = RCAR_DU_COLORKEY_NONE;
> +
> +	return &state->state;
>   }
>   
>   static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
>   					     struct drm_plane_state *state,
>   					     struct drm_property *property,
> @@ -765,11 +762,11 @@ static int rcar_du_plane_atomic_get_property(struct drm_plane *plane,
>   }
>   
>   static const struct drm_plane_funcs rcar_du_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
> -	.reset = rcar_du_plane_reset,
> +	.atomic_create_state = rcar_du_plane_create_state,
>   	.destroy = drm_plane_cleanup,
>   	.atomic_duplicate_state = rcar_du_plane_atomic_duplicate_state,
>   	.atomic_destroy_state = rcar_du_plane_atomic_destroy_state,
>   	.atomic_set_property = rcar_du_plane_atomic_set_property,
>   	.atomic_get_property = rcar_du_plane_atomic_get_property,
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> index ae9f381b03c8..4293e792afdb 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> @@ -419,30 +419,27 @@ static void rcar_du_vsp_plane_atomic_destroy_state(struct drm_plane *plane,
>   {
>   	__drm_atomic_helper_plane_destroy_state(state);
>   	kfree(to_rcar_vsp_plane_state(state));
>   }
>   
> -static void rcar_du_vsp_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *rcar_du_vsp_plane_create_state(struct drm_plane *plane)
>   {
>   	struct rcar_du_vsp_plane_state *state;
>   
> -	if (plane->state) {
> -		rcar_du_vsp_plane_atomic_destroy_state(plane, plane->state);
> -		plane->state = NULL;
> -	}
> -
>   	state = kzalloc_obj(*state);
>   	if (state == NULL)

Since we're here, please fix the coding style to !state.


> -		return;
> +		return ERR_PTR(-ENOMEM);
>   
> -	__drm_atomic_helper_plane_reset(plane, &state->state);
> +	__drm_atomic_helper_plane_state_init(&state->state, plane);
> +
> +	return &state->state;
>   }
>   
>   static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
> -	.reset = rcar_du_vsp_plane_reset,
> +	.atomic_create_state = rcar_du_vsp_plane_create_state,
>   	.destroy = drm_plane_cleanup,
>   	.atomic_duplicate_state = rcar_du_vsp_plane_atomic_duplicate_state,
>   	.atomic_destroy_state = rcar_du_vsp_plane_atomic_destroy_state,
>   };
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


