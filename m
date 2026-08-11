Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BFC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612FD10E2BF;
	Tue, 11 Aug 2026 07:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="F7pj/nhg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q1MYPfiA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ChZFwsCs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vnBQfVUf";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49C510E2BF;
 Tue, 11 Aug 2026 07:59:20 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19DE03DF6;
 Tue, 11 Aug 2026 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786435147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mEb+iFVnsjF8sWnvUeIiIZLGSrKk7a/zXl6CXhr7ddA=;
 b=F7pj/nhg4OrBsuuN3sF6gkB5SOa+ub4F5TMRS00XFyGqkjLRfYepSQ2zyLT5RzJ3ycw4Wa
 u6cCNLABe37M3Y5NIUm9Vv9+OMda3ylInNkSxajXk7wEKgNQP5kugPA4upISBQXMIiww9f
 XB++b1znrIfVv0CJQd8OBT9Y01h2EHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786435147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mEb+iFVnsjF8sWnvUeIiIZLGSrKk7a/zXl6CXhr7ddA=;
 b=Q1MYPfiAO/sJkiTgetv99j6Gqm6jse/osv//p/dHm4pk+6GQ2Ur5sWJEYAVtWShtpm+y80
 LN3mL9ZQFm+ZAYDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786435143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mEb+iFVnsjF8sWnvUeIiIZLGSrKk7a/zXl6CXhr7ddA=;
 b=ChZFwsCskUHR6N5QkSEA11Cvvv0XhdRKd0Vltx+tMzZL00SkD1UJZoFoDQBmb91IT0OOd1
 vu9tncT7ffPsmeI3I82yTE62UdOTq/nibhhFEm91HQ+nGla9vahJHjGEvYXIPGB5VorM3H
 p6nzQkPh0R063oFY47lasweIjkP/ykU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786435143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mEb+iFVnsjF8sWnvUeIiIZLGSrKk7a/zXl6CXhr7ddA=;
 b=vnBQfVUf+vBm9sJMsNomwC+My0J1s6WKSuW7gyYmSV9wvUSfBoYMzj3zhtmAs9LSkOSYJF
 9pePizGkRX9IVrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEB14779B2;
 Tue, 11 Aug 2026 07:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tkI3LUbWemrGJAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 11 Aug 2026 07:59:02 +0000
Message-ID: <df01989a-04fc-4f1d-8942-51f937fc8d97@suse.de>
Date: Tue, 11 Aug 2026 09:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
To: ville.syrjala@intel.com, rodrigo.vivi@intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Javier Martinez Canillas <javierm@redhat.com>
References: <20260721095454.404298-1-tzimmermann@suse.de>
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
In-Reply-To: <20260721095454.404298-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[intel.com,linux.intel.com,ursulin.net,gmail.com,ffwll.ch];
 RCPT_COUNT_TWELVE(0.00)[12]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, suse.com:url,
 imap1.dmz-prg2.suse.org:helo]
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

gentle ping to review this change

Am 21.07.26 um 11:54 schrieb Thomas Zimmermann:
> Call drm_atomic_helper_check_plane_damage() in plane_atomic_check()
> before copying the damage information to guarantees that ignore_damage_clips
> from struct drm_plane_state has the correct value. Although i915 does not
> directly modify or use the flag, DRM's damage iterator will soon rely on
> it.
>
> As a side effect, if the CRTC has been marked for a full modeset before
> the call to drm_atomic_helper_check_plane_damage() happens, the plane now
> ignores all damage clips and does a full update.
>
> Git commit 35ed38d58257 ("drm: Allow drivers to indicate the damage
> helpers to ignore damage clips") introduced ignore_damage_clips to
> selectively ignore damage clipping for certain framebuffer changes. The
> mode-setting pipeline can disabled damage clippings for an atomic commit
> by setting ignore_damage_clips in struct drm_plane_state. The atomic
> commit will then do a full display update.
>
> Future directions: there's currently a multitude of options that affect
> damage clipping; with different places seeing different state. In order
> to unify this, drm_atomic_helper_check_plane_state() will soon evaluate
> all options in a single place and set ignore_damage_clips accordingly. All
> later stages of the mode-setting pipeline will only look at this field.
>
> v3:
> - fix the call to drm_atomic_helper_check_plane_state()
> - use primary-CRTC's plane state (Sashiko)
> - note full-plane updates in commit description
> v2:
> - move _check_plane_damage() before reading damage first time (Sashiko)
> - expand commit description
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> Taken with updates from the series at
>
>    https://lore.kernel.org/dri-devel/20260610152505.260172-1-tzimmermann@suse.de/
> ---
>   drivers/gpu/drm/i915/display/intel_plane.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
> index a440f92ff00c..d64f151ce410 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
> @@ -850,7 +850,7 @@ static int plane_atomic_check(struct intel_atomic_state *state,
>   		intel_atomic_get_new_plane_state(state, plane);
>   	const struct intel_plane_state *old_plane_state =
>   		intel_atomic_get_old_plane_state(state, plane);
> -	const struct intel_plane_state *new_primary_crtc_plane_state;
> +	struct intel_plane_state *new_primary_crtc_plane_state;
>   	const struct intel_plane_state *old_primary_crtc_plane_state;
>   	struct intel_crtc *crtc = intel_crtc_for_pipe(display, plane->pipe);
>   	const struct intel_crtc_state *old_crtc_state =
> @@ -873,6 +873,14 @@ static int plane_atomic_check(struct intel_atomic_state *state,
>   		old_primary_crtc_plane_state = old_plane_state;
>   	}
>   
> +	/*
> +	 * Prepare plane-damage state before using it; do this on all
> +	 * display versions to keep the underlying DRM plane state in
> +	 * good shape.
> +	 */
> +	drm_atomic_helper_check_plane_damage(&state->base,
> +					     &new_primary_crtc_plane_state->uapi);
> +
>   	intel_plane_copy_uapi_plane_damage(new_plane_state,
>   					   old_primary_crtc_plane_state,
>   					   new_primary_crtc_plane_state);
>
> base-commit: fcaba3bc017906059b910ece3f83185e93010581
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
> prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
> prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


