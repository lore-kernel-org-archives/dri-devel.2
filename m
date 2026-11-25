Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BA606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KYzzSwFU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iy8cgTFR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KYzzSwFU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iy8cgTFR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2E910E076;
	Wed, 25 Nov 2026 14:42:12 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C566A10E076
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:42:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C41E1F7A2;
 Wed, 25 Nov 2026 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795617720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OOM+BLbOUCXU/Ap7KVKMeLM1WgGgbgZf0IHUbwapR30=;
 b=KYzzSwFU8LjJgmgu6UJQba/4/7imeJXdUlcygGP8dRw/pk14hCA6QSjWF/eAX9pf4f13Ik
 Q371P1pb3RoH2qeVv+KV6RCaz9APxm1mhAfs2sNJBU5v1GU2f93Djk92D5JKLOvBKdkqTS
 9dLO7i5HqQJPoz10iaxSKzWBmQGyIM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795617720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OOM+BLbOUCXU/Ap7KVKMeLM1WgGgbgZf0IHUbwapR30=;
 b=iy8cgTFRJT1kSCD9Gts9NVC438S/bUbHqJvWfVA4Q8yKE4EyQz/YT9JattKT6fpdPzNV9O
 2Ibfcwu+6qnQzwCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KYzzSwFU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iy8cgTFR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795617720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OOM+BLbOUCXU/Ap7KVKMeLM1WgGgbgZf0IHUbwapR30=;
 b=KYzzSwFU8LjJgmgu6UJQba/4/7imeJXdUlcygGP8dRw/pk14hCA6QSjWF/eAX9pf4f13Ik
 Q371P1pb3RoH2qeVv+KV6RCaz9APxm1mhAfs2sNJBU5v1GU2f93Djk92D5JKLOvBKdkqTS
 9dLO7i5HqQJPoz10iaxSKzWBmQGyIM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795617720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OOM+BLbOUCXU/Ap7KVKMeLM1WgGgbgZf0IHUbwapR30=;
 b=iy8cgTFRJT1kSCD9Gts9NVC438S/bUbHqJvWfVA4Q8yKE4EyQz/YT9JattKT6fpdPzNV9O
 2Ibfcwu+6qnQzwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C0D8134CA;
 Wed, 25 Nov 2026 14:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u0LRFLfzBmsJcwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 25 Nov 2026 14:41:59 +0000
Message-ID: <2f52647b-b557-45a3-a91e-f5b4adcbabd6@suse.de>
Date: Wed, 25 Nov 2026 15:41:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/sti: gdp: set the pixel clock from
 .atomic_update()
To: Minseo Park <hiyoukou@gmail.com>, dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@linaro.org
References: <20261125142330.15298-1-hiyoukou@gmail.com>
 <20261125142330.15298-3-hiyoukou@gmail.com>
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
In-Reply-To: <20261125142330.15298-3-hiyoukou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:url];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[foss.st.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,linaro.org];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 0C41E1F7A2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 25.11.26 um 15:23 schrieb Minseo Park:
> sti_gdp_atomic_check() reparents the GDP pixel clock and calls
> clk_set_rate() on it with the clock of the mode being checked.
>
> .atomic_check() must not touch the hardware.  A commit with
> DRM_MODE_ATOMIC_TEST_ONLY only runs the check hooks, and a commit that
> fails a later check is dropped, so in both cases the clock of a mode
> that was never applied is programmed on a display that is still scanning
> out the previous one.
>
> Move the clock setup to .atomic_update(), where the rest of the plane is
> programmed.  A clk_set_rate() failure can no longer reject the commit,
> so it is logged and the plane is left as it was.
>
> Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
> Signed-off-by: Minseo Park <hiyoukou@gmail.com>
> ---
>   drivers/gpu/drm/sti/sti_gdp.c | 52 +++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index d0c886029c57..09f8d3f936ca 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -623,7 +623,6 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
> -	struct sti_gdp *gdp = to_sti_gdp(plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	struct drm_framebuffer *fb =  new_plane_state->fb;
>   	struct drm_crtc_state *crtc_state;
> @@ -667,32 +666,6 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
>   		return -EINVAL;
>   	}
>   
> -	/* Set gdp clock */
> -	if (mode->clock && gdp->clk_pix) {
> -		struct clk *clkp;
> -		int rate = mode->clock * 1000;
> -		int res;
> -
> -		/*
> -		 * According to the mixer used, the gdp pixel clock
> -		 * should have a different parent clock.
> -		 */
> -		if (mixer->id == STI_MIXER_MAIN)
> -			clkp = gdp->clk_main_parent;
> -		else
> -			clkp = gdp->clk_aux_parent;
> -
> -		if (clkp)
> -			clk_set_parent(gdp->clk_pix, clkp);
> -
> -		res = clk_set_rate(gdp->clk_pix, rate);
> -		if (res < 0) {
> -			DRM_ERROR("Cannot set rate (%dHz) for gdp\n",
> -				  rate);
> -			return -EINVAL;
> -		}
> -	}
> -

Unfortunately, the clk api appears to have no interface for testing a 
rate change without setting it.  Do you have at least a minimal and 
maximum supported pixel clock to test mode->clock against?

>   	DRM_DEBUG_KMS("CRTC:%d (%s) drm plane:%d (%s)\n",
>   		      crtc->base.id, sti_mixer_to_str(mixer),
>   		      drm_plane->base.id, sti_plane_to_str(plane));
> @@ -757,6 +730,31 @@ static void sti_gdp_atomic_update(struct drm_plane *drm_plane,
>   	}
>   
>   	mode = &crtc->mode;
> +
> +	/* Set gdp clock */
> +	if (mode->clock && gdp->clk_pix) {
> +		struct sti_mixer *mixer = to_sti_mixer(crtc);
> +		int rate = mode->clock * 1000;
> +		struct clk *clkp;
> +
> +		/*
> +		 * According to the mixer used, the gdp pixel clock
> +		 * should have a different parent clock.
> +		 */
> +		if (mixer->id == STI_MIXER_MAIN)
> +			clkp = gdp->clk_main_parent;
> +		else
> +			clkp = gdp->clk_aux_parent;
> +
> +		if (clkp)
> +			clk_set_parent(gdp->clk_pix, clkp);
> +
> +		if (clk_set_rate(gdp->clk_pix, rate) < 0) {
> +			DRM_ERROR("Cannot set rate (%dHz) for gdp\n", rate);

This macro needs to become drm_err_once() or drm_dbg().

Best regards
Thomas

> +			return;
> +		}
> +	}
> +
>   	dst_x = newstate->crtc_x;
>   	dst_y = newstate->crtc_y;
>   	dst_w = clamp_val(newstate->crtc_w, 0, mode->hdisplay - dst_x);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


