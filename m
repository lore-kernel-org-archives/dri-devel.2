Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3601ECD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 08:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75CBC10F4F5;
	Fri, 22 May 2026 08:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dAsZPn0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mnQNigEb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZrXLlmUF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZfo7MQ+";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5098010F503
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:16:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE1376B9F2;
 Fri, 22 May 2026 08:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779437767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MCfgmiXJcOGRr2E1QpiDGBBZk2YXnmbM8WQKaKRWHOA=;
 b=dAsZPn0JrNSqiXYhMHN64IlZS9ytXhdLMP+CPNJalJZN4wNf0BEgwhnxyURLbG+05VW80Z
 5F5vRAXxRUb0VlFUaGYp3PcmIDq7AaTDk1hpVQmQnjNGB5wIUJxgQ3LH72/X57W1wiUIkQ
 /jbui9pf2pjhoyNgTSSH7GQX98F3MXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779437767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MCfgmiXJcOGRr2E1QpiDGBBZk2YXnmbM8WQKaKRWHOA=;
 b=mnQNigEbO7EO8YRsAjUMlY/OfOoH9B2/TOw00wFr+HD88UQVnSaACaorFHezDQrTD9+AzV
 k0L0NVhilkBNbIBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779437766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MCfgmiXJcOGRr2E1QpiDGBBZk2YXnmbM8WQKaKRWHOA=;
 b=ZrXLlmUFzXMUTDNVMLKo05EnDfCkuE89fRPhrNBxPvg2R+Ri5Xr32RifmgwzYp6UqH3crY
 2EL6D8KCkAnTkugYjlYtizGRE3bY0Ctta5tOs1/GB2g/76601eCIW8Yhk5hQVIptKyf3HX
 P38vUnn+JtMUb+vtACIICPq9Lb0aUNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779437766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MCfgmiXJcOGRr2E1QpiDGBBZk2YXnmbM8WQKaKRWHOA=;
 b=QZfo7MQ+EFAwpRFBdp500yEKihMb1u7J4dbmcbMaYnZoZIVoD1vwZdEOfovOeZG5UZEg2j
 BU2QMaZcTrxqq6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BCB0593A8;
 Fri, 22 May 2026 08:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M1qUJMYQEGrkegAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 08:16:06 +0000
Message-ID: <041bae47-bb5d-4db7-9435-f6c5d9c2fda1@suse.de>
Date: Fri, 22 May 2026 10:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: reject pixel clocks outside PLL range
To: Berkant Koc <me@berkoc.com>, dri-devel@lists.freedesktop.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <28e476e896dafdd31518dc5360ab7766@berkoc.com>
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
In-Reply-To: <28e476e896dafdd31518dc5360ab7766@berkoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[9]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 checkpatch.pl:url, suse.de:mid]
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

Am 17.05.26 um 15:03 schrieb Berkant Koc:
> Commit 877507bb954e ("drm/mgag200: Provide per-device callbacks for
> PIXPLLC") split the PLL compute code into per-model source files. The
> g200se variant kept the existing permitteddelta sanity check and
> returns -EINVAL when no register combination matches the requested
> pixel clock within tolerance, which lets atomic_check reject the mode.
>
> The matching helpers in g200wb, g200eh, g200er, g200ev, g200eh3 and
> g200ew3 omit that check. When the search loop finds no candidate, m,
> n, p and s stay at their initial zero values and the function still
> returns success. atomic_update then programs those zero values into
> the PIXPLLCM/N/P registers, which yields a corrupted output clock on
> the affected models.
>
> Apply the same permitteddelta test (clock * 5 / 1000, matching the
> g200se reference) in all six helpers so that out-of-range modes are
> rejected during atomic_check instead of producing garbage register
> writes during atomic_update.
>
> Fixes: 877507bb954e ("drm/mgag200: Provide per-device callbacks for PIXPLLC")

The other models never did this check. Why is this now a problem?

Best regards
Thomas

> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Berkant Koc <me@berkoc.com>
> ---
>
> Build-tested with CONFIG_DRM_MGAG200=m, allmodconfig defaults; no new
> warnings. checkpatch.pl --no-tree clean (0 errors, 0 warnings).
>
>   drivers/gpu/drm/mgag200/mgag200_g200eh.c  | 8 +++++++-
>   drivers/gpu/drm/mgag200/mgag200_g200eh3.c | 8 +++++++-
>   drivers/gpu/drm/mgag200/mgag200_g200er.c  | 8 +++++++-
>   drivers/gpu/drm/mgag200/mgag200_g200ev.c  | 8 +++++++-
>   drivers/gpu/drm/mgag200/mgag200_g200ew3.c | 8 +++++++-
>   drivers/gpu/drm/mgag200/mgag200_g200wb.c  | 8 +++++++-
>   6 files changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> index d2aa931f579d..2387ff87550a 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> @@ -51,13 +51,14 @@ static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
>   	long clock = new_crtc_state->mode.clock;
>   	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
> -	unsigned int delta, tmpdelta;
> +	unsigned int delta, tmpdelta, permitteddelta;
>   	unsigned int testp, testm, testn;
>   	unsigned int p, m, n, s;
>   	unsigned int computed;
>   
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
>   
>   	for (testp = 16; testp > 0; testp >>= 1) {
>   		if (clock * testp > vcomax)
> @@ -82,6 +83,11 @@ static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
>   		}
>   	}
>   
> +	if (delta > permitteddelta) {
> +		pr_warn("PLL delta too large\n");
> +		return -EINVAL;
> +	}
> +
>   	pixpllc->m = m;
>   	pixpllc->n = n;
>   	pixpllc->p = p;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> index 7bea7a728f56..322e93982ea2 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> @@ -26,13 +26,14 @@ static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
>   	long clock = new_crtc_state->mode.clock;
>   	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
> -	unsigned int delta, tmpdelta;
> +	unsigned int delta, tmpdelta, permitteddelta;
>   	unsigned int testp, testm, testn;
>   	unsigned int p, m, n, s;
>   	unsigned int computed;
>   
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
>   	testp = 0;
>   
>   	for (testm = 150; testm >= 6; testm--) {
> @@ -59,6 +60,11 @@ static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
>   			break;
>   	}
>   
> +	if (delta > permitteddelta) {
> +		pr_warn("PLL delta too large\n");
> +		return -EINVAL;
> +	}
> +
>   	pixpllc->m = m;
>   	pixpllc->n = n;
>   	pixpllc->p = p;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
> index 8fa8fe943abf..e180db21902b 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
> @@ -69,13 +69,14 @@ static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
>   	long clock = new_crtc_state->mode.clock;
>   	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
> -	unsigned int delta, tmpdelta;
> +	unsigned int delta, tmpdelta, permitteddelta;
>   	int testr, testn, testm, testo;
>   	unsigned int p, m, n, s;
>   	unsigned int computed, vco;
>   
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
>   
>   	for (testr = 0; testr < 4; testr++) {
>   		if (delta == 0)
> @@ -110,6 +111,11 @@ static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
>   		}
>   	}
>   
> +	if (delta > permitteddelta) {
> +		pr_warn("PLL delta too large\n");
> +		return -EINVAL;
> +	}
> +
>   	pixpllc->m = m;
>   	pixpllc->n = n;
>   	pixpllc->p = p;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> index 3fadbeb10af9..0e882872e968 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> @@ -57,13 +57,14 @@ static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
>   	long clock = new_crtc_state->mode.clock;
>   	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
> -	unsigned int delta, tmpdelta;
> +	unsigned int delta, tmpdelta, permitteddelta;
>   	unsigned int testp, testm, testn;
>   	unsigned int p, m, n, s;
>   	unsigned int computed;
>   
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
>   
>   	for (testp = 16; testp > 0; testp--) {
>   		if (clock * testp > vcomax)
> @@ -89,6 +90,11 @@ static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
>   		}
>   	}
>   
> +	if (delta > permitteddelta) {
> +		pr_warn("PLL delta too large\n");
> +		return -EINVAL;
> +	}
> +
>   	pixpllc->m = m;
>   	pixpllc->n = n;
>   	pixpllc->p = p;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> index e387a455eae5..da8f2a66cde3 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> @@ -33,13 +33,14 @@ static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
>   	long clock = new_crtc_state->mode.clock;
>   	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
> -	unsigned int delta, tmpdelta;
> +	unsigned int delta, tmpdelta, permitteddelta;
>   	unsigned int testp, testm, testn, testp2;
>   	unsigned int p, m, n, s;
>   	unsigned int computed;
>   
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
>   
>   	for (testp = 1; testp < 8; testp++) {
>   		for (testp2 = 1; testp2 < 8; testp2++) {
> @@ -68,6 +69,11 @@ static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
>   		}
>   	}
>   
> +	if (delta > permitteddelta) {
> +		pr_warn("PLL delta too large\n");
> +		return -EINVAL;
> +	}
> +
>   	pixpllc->m = m;
>   	pixpllc->n = n;
>   	pixpllc->p = p;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> index d847fa8ded8c..ca4775173ff0 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> @@ -49,13 +49,14 @@ static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
>   	long clock = new_crtc_state->mode.clock;
>   	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
> -	unsigned int delta, tmpdelta;
> +	unsigned int delta, tmpdelta, permitteddelta;
>   	unsigned int testp, testm, testn;
>   	unsigned int p, m, n, s;
>   	unsigned int computed;
>   
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
>   
>   	for (testp = 1; testp < 9; testp++) {
>   		if (clock * testp > vcomax)
> @@ -81,6 +82,11 @@ static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
>   		}
>   	}
>   
> +	if (delta > permitteddelta) {
> +		pr_warn("PLL delta too large\n");
> +		return -EINVAL;
> +	}
> +
>   	pixpllc->m = m;
>   	pixpllc->n = n;
>   	pixpllc->p = p;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


