Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF23606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bYm01Q5X;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ew8ktLNL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bYm01Q5X;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ew8ktLNL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C0F10E1B8;
	Wed, 25 Nov 2026 14:45:11 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A252710E1B8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:45:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37A6C1F7A2;
 Wed, 25 Nov 2026 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795617899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QcqlWHM0H3AQeEQnMlbHDx7J10nq/e0F+GgiZIgy5Xo=;
 b=bYm01Q5XUf5rwtsI68EjNr7LBR1mdTk6gVnhaICKIoLt5HuT9lPpZ0qr7FPEZXEQiwBnaI
 x77GeNssaWyMUvL+vF8G89FkPNPolBkvy9gLVPBRgEi0BF2G+NUtFbuw28q78huvAmnJI2
 b9YyIXfj26zuLYS1PcJ45LIltWsFQ8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795617899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QcqlWHM0H3AQeEQnMlbHDx7J10nq/e0F+GgiZIgy5Xo=;
 b=Ew8ktLNLyTM7l587FVyNTg0CeQbVEuEXNoY7mVxBL4L0t+CG0wpmmBg2Fcek2nVxPOd8zp
 CHReOeWhCIZywXBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795617899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QcqlWHM0H3AQeEQnMlbHDx7J10nq/e0F+GgiZIgy5Xo=;
 b=bYm01Q5XUf5rwtsI68EjNr7LBR1mdTk6gVnhaICKIoLt5HuT9lPpZ0qr7FPEZXEQiwBnaI
 x77GeNssaWyMUvL+vF8G89FkPNPolBkvy9gLVPBRgEi0BF2G+NUtFbuw28q78huvAmnJI2
 b9YyIXfj26zuLYS1PcJ45LIltWsFQ8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795617899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QcqlWHM0H3AQeEQnMlbHDx7J10nq/e0F+GgiZIgy5Xo=;
 b=Ew8ktLNLyTM7l587FVyNTg0CeQbVEuEXNoY7mVxBL4L0t+CG0wpmmBg2Fcek2nVxPOd8zp
 CHReOeWhCIZywXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC325134CA;
 Wed, 25 Nov 2026 14:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HSleH2r0BmsTdgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 25 Nov 2026 14:44:58 +0000
Message-ID: <0bb655d0-336f-4455-9c9c-e620cf3ce2fd@suse.de>
Date: Wed, 25 Nov 2026 15:44:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/sti: hqvdp: start the XP70 from .atomic_update()
To: Minseo Park <hiyoukou@gmail.com>, dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@linaro.org
References: <20261125142330.15298-1-hiyoukou@gmail.com>
 <20261125142330.15298-4-hiyoukou@gmail.com>
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
In-Reply-To: <20261125142330.15298-4-hiyoukou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[foss.st.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,linaro.org];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Score: -13.29
X-Spam-Level: 
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
> sti_hqvdp_atomic_check() boots the XP70 coprocessor, which loads its
> firmware, then enables the main pixel clock and registers a VTG vsync
> notifier.
>
> .atomic_check() must not touch the hardware.  A commit with
> DRM_MODE_ATOMIC_TEST_ONLY only runs the check hooks, so a client asking
> whether a configuration is possible ends up loading firmware and
> enabling a clock.
>
> Both are one-shot, guarded by hqvdp->xp70_initialized and
> hqvdp->vtg_registered, so nothing leaks, but they belong in the commit
> phase.  Move them to .atomic_update().  As with the GDP, the failure
> paths now log and return instead of rejecting the commit.
>
> Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
> Signed-off-by: Minseo Park <hiyoukou@gmail.com>
> ---
>   drivers/gpu/drm/sti/sti_hqvdp.c | 43 ++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 360d213f2094..66abbe4de864 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -1081,28 +1081,6 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
>   		return -EINVAL;
>   	}
>   
> -	if (!hqvdp->xp70_initialized)
> -		/* Start HQVDP XP70 coprocessor */
> -		sti_hqvdp_start_xp70(hqvdp);
> -
> -	if (!hqvdp->vtg_registered) {
> -		/* Prevent VTG shutdown */
> -		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
> -			DRM_ERROR("Failed to prepare/enable pix main clk\n");
> -			return -EINVAL;
> -		}
> -
> -		/* Register VTG Vsync callback to handle bottom fields */
> -		if (sti_vtg_register_client(hqvdp->vtg,
> -					    &hqvdp->vtg_nb,
> -					    crtc)) {
> -			DRM_ERROR("Cannot register VTG notifier\n");
> -			clk_disable_unprepare(hqvdp->clk_pix_main);
> -			return -EINVAL;
> -		}
> -		hqvdp->vtg_registered = true;
> -	}
> -
>   	DRM_DEBUG_KMS("CRTC:%d (%s) drm plane:%d (%s)\n",
>   		      crtc->base.id, sti_mixer_to_str(to_sti_mixer(crtc)),
>   		      drm_plane->base.id, sti_plane_to_str(plane));
> @@ -1152,6 +1130,27 @@ static void sti_hqvdp_atomic_update(struct drm_plane *drm_plane,
>   	}
>   
>   	mode = &crtc->mode;
> +
> +	if (!hqvdp->xp70_initialized)
> +		/* Start HQVDP XP70 coprocessor */
> +		sti_hqvdp_start_xp70(hqvdp);
> +
> +	if (!hqvdp->vtg_registered) {
> +		/* Prevent VTG shutdown */
> +		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
> +			DRM_ERROR("Failed to prepare/enable pix main clk\n");
> +			return;
> +		}
> +
> +		/* Register VTG Vsync callback to handle bottom fields */
> +		if (sti_vtg_register_client(hqvdp->vtg, &hqvdp->vtg_nb, crtc)) {
> +			DRM_ERROR("Cannot register VTG notifier\n");
> +			clk_disable_unprepare(hqvdp->clk_pix_main);
> +			return;
> +		}
> +		hqvdp->vtg_registered = true;
> +	}
> +

This looks like it belongs int device init instead of plane updates.

Best regards
Thomas

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


