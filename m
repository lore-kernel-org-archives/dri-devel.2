Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E25CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF02C10E3FB;
	Thu,  4 Jun 2026 08:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="llp+UoEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vtVSP1Xb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="llp+UoEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vtVSP1Xb";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7A510E3FB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:08:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 082D46AA05;
 Thu,  4 Jun 2026 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780560479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VaBdL2Fy7/CPaHKxOE5wyZtjErfmhH5HjVclT68IAH0=;
 b=llp+UoErxzuI3YhfX2nq61JBO3AeQtzLI3+NkYV4LW9F4FXOT7axdhFKP0Oe49rsj0nWJY
 M+uBUT4r8SM45b5il7uzc6YoSnsXdcBn8ZpxAIBj9m8pqT0Thy4bpFDOmavHk+1vUPkiX4
 5Ut2qTJaMuBCvWskbySgzGRduMvCOCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780560479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VaBdL2Fy7/CPaHKxOE5wyZtjErfmhH5HjVclT68IAH0=;
 b=vtVSP1XbOk9ZFhaznQJolTlHTuw53WpFEY171joaE6mMo8X6g53TIQW1vNgXN3AC9EZ9MK
 uv5854L182xwIjDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=llp+UoEr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vtVSP1Xb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780560479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VaBdL2Fy7/CPaHKxOE5wyZtjErfmhH5HjVclT68IAH0=;
 b=llp+UoErxzuI3YhfX2nq61JBO3AeQtzLI3+NkYV4LW9F4FXOT7axdhFKP0Oe49rsj0nWJY
 M+uBUT4r8SM45b5il7uzc6YoSnsXdcBn8ZpxAIBj9m8pqT0Thy4bpFDOmavHk+1vUPkiX4
 5Ut2qTJaMuBCvWskbySgzGRduMvCOCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780560479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VaBdL2Fy7/CPaHKxOE5wyZtjErfmhH5HjVclT68IAH0=;
 b=vtVSP1XbOk9ZFhaznQJolTlHTuw53WpFEY171joaE6mMo8X6g53TIQW1vNgXN3AC9EZ9MK
 uv5854L182xwIjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD26D779A8;
 Thu,  4 Jun 2026 08:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id plHiKF4yIWqsdwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 04 Jun 2026 08:07:58 +0000
Message-ID: <4b06014c-ec11-4526-9d50-0a1cb52848d5@suse.de>
Date: Thu, 4 Jun 2026 10:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mgag200: validate pixel clock against PLL range in
 mode_valid
To: Berkant Koc <me@berkoc.com>, airlied@redhat.com
Cc: jfalempe@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1780402238.22b24b6f590c@berkoc.com>
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
In-Reply-To: <1780402238.22b24b6f590c@berkoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[berkoc.com:email,checkpatch.pl:url,suse.de:email,suse.de:dkim,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:url, suse.de:email, suse.de:dkim,
 suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 082D46AA05
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



Am 02.06.26 um 14:10 schrieb Berkant Koc:
> The per-model pixpllc_atomic_check helpers for G200WB, G200EH, G200ER,
> G200EV, G200EH3 and G200EW3 initialise m, n, p and s to zero and only
> update them when the inner search loop finds a candidate whose delta
> to the requested clock improves on the previous best. They return 0
> unconditionally afterwards. If the requested pixel clock falls outside
> the model's VCO window so that the outer guard skips every iteration,
> no candidate is recorded and atomic_update later programs pixpllc->m - 1
> (unsigned underflow) into PIXPLLCM/N/P. The result is a corrupted
> output clock on those models.
>
> Following Thomas Zimmermann's suggestion, reject such modes earlier in
> the pipeline rather than inside atomic_check. Add an optional
> pixpllc_mode_valid callback to struct mgag200_device_funcs and dispatch
> it from the shared mgag200_crtc_helper_mode_valid. Each affected helper
> provides an implementation that walks the same divider space as its
> atomic_check counterpart and returns MODE_CLOCK_RANGE when no candidate
> falls within the same 0.5% (5/1000) tolerance that g200se has always
> enforced. Models without the callback (G200, G200SE, G200EH5) keep
> their current behaviour.
>
> Filtering at mode_valid time means the userspace mode list never
> contains modes the PLL cannot synthesise, so atomic_check no longer has
> to defend against an empty search loop and atomic_update is never
> reached with zeroed pixpllc values.
>
> Tested with static analysis against the linux-7.1-rc4 tree; runtime
> confirmation on physical Matrox hardware welcome. checkpatch.pl --strict
> clean.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Berkant Koc <me@berkoc.com>
> Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline

I don't have time for this nonsense. If you want to help then get one of 
these devices and do actual software engineering. Fixing hypothetical 
bugs with bad patches isn't that.

> ---
>   drivers/gpu/drm/mgag200/mgag200_drv.h     |  8 ++++
>   drivers/gpu/drm/mgag200/mgag200_g200eh.c  | 41 +++++++++++++++++++
>   drivers/gpu/drm/mgag200/mgag200_g200eh3.c | 38 +++++++++++++++++
>   drivers/gpu/drm/mgag200/mgag200_g200er.c  | 50 +++++++++++++++++++++++
>   drivers/gpu/drm/mgag200/mgag200_g200ev.c  | 42 +++++++++++++++++++
>   drivers/gpu/drm/mgag200/mgag200_g200ew3.c | 45 ++++++++++++++++++++
>   drivers/gpu/drm/mgag200/mgag200_g200wb.c  | 41 +++++++++++++++++++
>   drivers/gpu/drm/mgag200/mgag200_mode.c    | 13 ++++++
>   8 files changed, 278 insertions(+)
>
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
> index a875c4bf8c..3eae8756cc 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
> @@ -248,6 +248,14 @@ struct mgag200_device_info {
>   	}
>   
>   struct mgag200_device_funcs {
> +	/*
> +	 * Optional. Validate that @mode's pixel clock falls within the
> +	 * model's PIXPLLC window. Called from mgag200_crtc_helper_mode_valid
> +	 * so that out-of-range modes are filtered before atomic_check.
> +	 */
> +	enum drm_mode_status (*pixpllc_mode_valid)(struct drm_crtc *crtc,
> +						   const struct drm_display_mode *mode);
> +
>   	/*
>   	 * Validate that the given state can be programmed into PIXPLLC. On
>   	 * success, the calculated parameters should be stored in the CRTC's
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> index d2aa931f57..189bb1671e 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> @@ -40,6 +40,46 @@ void mgag200_g200eh_init_registers(struct mga_device *mdev)
>    * PIXPLLC
>    */
>   
> +static enum drm_mode_status mgag200_g200eh_pixpllc_mode_valid(struct drm_crtc *crtc,
> +							      const struct drm_display_mode *mode)
> +{
> +	static const unsigned int vcomax = 800000;
> +	static const unsigned int vcomin = 400000;
> +	static const unsigned int pllreffreq = 33333;
> +
> +	long clock = mode->clock;
> +	unsigned int delta, tmpdelta, permitteddelta;
> +	unsigned int testp, testm, testn;
> +	unsigned int computed;
> +
> +	if (clock <= 0)
> +		return MODE_CLOCK_LOW;
> +
> +	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
> +
> +	for (testp = 16; testp > 0; testp >>= 1) {
> +		if (clock * testp > vcomax)
> +			continue;
> +		if (clock * testp < vcomin)
> +			continue;
> +
> +		for (testm = 1; testm < 33; testm++) {
> +			for (testn = 17; testn < 257; testn++) {
> +				computed = (pllreffreq * testn) / (testm * testp);
> +				if (computed > clock)
> +					tmpdelta = computed - clock;
> +				else
> +					tmpdelta = clock - computed;
> +				if (tmpdelta < delta)
> +					delta = tmpdelta;
> +			}
> +		}
> +	}
> +
> +	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
> +}
> +
>   static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
>   					       struct drm_atomic_state *new_state)
>   {
> @@ -230,6 +270,7 @@ static const struct mgag200_device_info mgag200_g200eh_device_info =
>   	MGAG200_DEVICE_INFO_INIT(2048, 2048, 37500, false, 1, 0, false);
>   
>   static const struct mgag200_device_funcs mgag200_g200eh_device_funcs = {
> +	.pixpllc_mode_valid = mgag200_g200eh_pixpllc_mode_valid,
>   	.pixpllc_atomic_check = mgag200_g200eh_pixpllc_atomic_check,
>   	.pixpllc_atomic_update = mgag200_g200eh_pixpllc_atomic_update,
>   };
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> index 7bea7a728f..621e4efb47 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> @@ -15,6 +15,43 @@
>    * PIXPLLC
>    */
>   
> +static enum drm_mode_status mgag200_g200eh3_pixpllc_mode_valid(struct drm_crtc *crtc,
> +							       const struct drm_display_mode *mode)
> +{
> +	static const unsigned int vcomax = 3000000;
> +	static const unsigned int vcomin = 1500000;
> +	static const unsigned int pllreffreq = 25000;
> +
> +	long clock = mode->clock;
> +	unsigned int delta, tmpdelta, permitteddelta;
> +	unsigned int testm, testn;
> +	unsigned int computed;
> +
> +	if (clock <= 0)
> +		return MODE_CLOCK_LOW;
> +
> +	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
> +
> +	for (testm = 150; testm >= 6; testm--) {
> +		if (clock * testm > vcomax)
> +			continue;
> +		if (clock * testm < vcomin)
> +			continue;
> +		for (testn = 120; testn >= 60; testn--) {
> +			computed = (pllreffreq * testn) / testm;
> +			if (computed > clock)
> +				tmpdelta = computed - clock;
> +			else
> +				tmpdelta = clock - computed;
> +			if (tmpdelta < delta)
> +				delta = tmpdelta;
> +		}
> +	}
> +
> +	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
> +}
> +
>   static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
>   						struct drm_atomic_state *new_state)
>   {
> @@ -134,6 +171,7 @@ static const struct mgag200_device_info mgag200_g200eh3_device_info =
>   	MGAG200_DEVICE_INFO_INIT(2048, 2048, 0, false, 1, 0, false);
>   
>   static const struct mgag200_device_funcs mgag200_g200eh3_device_funcs = {
> +	.pixpllc_mode_valid = mgag200_g200eh3_pixpllc_mode_valid,
>   	.pixpllc_atomic_check = mgag200_g200eh3_pixpllc_atomic_check,
>   	.pixpllc_atomic_update = mgag200_g200eh_pixpllc_atomic_update, // same as G200EH
>   };
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
> index 8fa8fe943a..d030094ae4 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
> @@ -57,6 +57,55 @@ static void mgag200_g200er_reset_tagfifo(struct mga_device *mdev)
>    * PIXPLLC
>    */
>   
> +static enum drm_mode_status mgag200_g200er_pixpllc_mode_valid(struct drm_crtc *crtc,
> +							      const struct drm_display_mode *mode)
> +{
> +	static const unsigned int vcomax = 1488000;
> +	static const unsigned int vcomin = 1056000;
> +	static const unsigned int pllreffreq = 48000;
> +	static const unsigned int m_div_val[] = { 1, 2, 4, 8 };
> +
> +	long clock = mode->clock;
> +	unsigned int delta, tmpdelta, permitteddelta;
> +	int testr, testn, testm, testo;
> +	unsigned int computed, vco;
> +
> +	if (clock <= 0)
> +		return MODE_CLOCK_LOW;
> +
> +	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
> +
> +	for (testr = 0; testr < 4; testr++) {
> +		if (delta == 0)
> +			break;
> +		for (testn = 5; testn < 129; testn++) {
> +			if (delta == 0)
> +				break;
> +			for (testm = 3; testm >= 0; testm--) {
> +				if (delta == 0)
> +					break;
> +				for (testo = 5; testo < 33; testo++) {
> +					vco = pllreffreq * (testn + 1) / (testr + 1);
> +					if (vco < vcomin)
> +						continue;
> +					if (vco > vcomax)
> +						continue;
> +					computed = vco / (m_div_val[testm] * (testo + 1));
> +					if (computed > clock)
> +						tmpdelta = computed - clock;
> +					else
> +						tmpdelta = clock - computed;
> +					if (tmpdelta < delta)
> +						delta = tmpdelta;
> +				}
> +			}
> +		}
> +	}
> +
> +	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
> +}
> +
>   static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
>   					       struct drm_atomic_state *new_state)
>   {
> @@ -267,6 +316,7 @@ static const struct mgag200_device_info mgag200_g200er_device_info =
>   	MGAG200_DEVICE_INFO_INIT(2048, 2048, 55000, false, 1, 0, false);
>   
>   static const struct mgag200_device_funcs mgag200_g200er_device_funcs = {
> +	.pixpllc_mode_valid = mgag200_g200er_pixpllc_mode_valid,
>   	.pixpllc_atomic_check = mgag200_g200er_pixpllc_atomic_check,
>   	.pixpllc_atomic_update = mgag200_g200er_pixpllc_atomic_update,
>   };
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> index 3fadbeb10a..8286e4d6ad 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> @@ -46,6 +46,47 @@ static void mgag200_g200ev_set_hiprilvl(struct mga_device *mdev)
>    * PIXPLLC
>    */
>   
> +static enum drm_mode_status mgag200_g200ev_pixpllc_mode_valid(struct drm_crtc *crtc,
> +							      const struct drm_display_mode *mode)
> +{
> +	static const unsigned int vcomax = 550000;
> +	static const unsigned int vcomin = 150000;
> +	static const unsigned int pllreffreq = 50000;
> +
> +	long clock = mode->clock;
> +	unsigned int delta, tmpdelta, permitteddelta;
> +	unsigned int testp, testm, testn;
> +	unsigned int computed;
> +
> +	if (clock <= 0)
> +		return MODE_CLOCK_LOW;
> +
> +	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
> +
> +	for (testp = 16; testp > 0; testp--) {
> +		if (clock * testp > vcomax)
> +			continue;
> +		if (clock * testp < vcomin)
> +			continue;
> +
> +		for (testn = 1; testn < 257; testn++) {
> +			for (testm = 1; testm < 17; testm++) {
> +				computed = (pllreffreq * testn) /
> +					(testm * testp);
> +				if (computed > clock)
> +					tmpdelta = computed - clock;
> +				else
> +					tmpdelta = clock - computed;
> +				if (tmpdelta < delta)
> +					delta = tmpdelta;
> +			}
> +		}
> +	}
> +
> +	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
> +}
> +
>   static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
>   					       struct drm_atomic_state *new_state)
>   {
> @@ -268,6 +309,7 @@ static const struct mgag200_device_info mgag200_g200ev_device_info =
>   	MGAG200_DEVICE_INFO_INIT(2048, 2048, 32700, false, 0, 1, false);
>   
>   static const struct mgag200_device_funcs mgag200_g200ev_device_funcs = {
> +	.pixpllc_mode_valid = mgag200_g200ev_pixpllc_mode_valid,
>   	.pixpllc_atomic_check = mgag200_g200ev_pixpllc_atomic_check,
>   	.pixpllc_atomic_update = mgag200_g200ev_pixpllc_atomic_update,
>   };
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> index e387a455ea..8db95f4d13 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> @@ -22,6 +22,50 @@ static void mgag200_g200ew3_init_registers(struct mga_device *mdev)
>    * PIXPLLC
>    */
>   
> +static enum drm_mode_status mgag200_g200ew3_pixpllc_mode_valid(struct drm_crtc *crtc,
> +							       const struct drm_display_mode *mode)
> +{
> +	static const unsigned int vcomax = 800000;
> +	static const unsigned int vcomin = 400000;
> +	static const unsigned int pllreffreq = 25000;
> +
> +	long clock = mode->clock;
> +	unsigned int delta, tmpdelta, permitteddelta;
> +	unsigned int testp, testm, testn, testp2;
> +	unsigned int computed;
> +
> +	if (clock <= 0)
> +		return MODE_CLOCK_LOW;
> +
> +	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
> +
> +	for (testp = 1; testp < 8; testp++) {
> +		for (testp2 = 1; testp2 < 8; testp2++) {
> +			if (testp < testp2)
> +				continue;
> +			if ((clock * testp * testp2) > vcomax)
> +				continue;
> +			if ((clock * testp * testp2) < vcomin)
> +				continue;
> +			for (testm = 1; testm < 26; testm++) {
> +				for (testn = 32; testn < 2048; testn++) {
> +					computed = (pllreffreq * testn) /
> +						(testm * testp * testp2);
> +					if (computed > clock)
> +						tmpdelta = computed - clock;
> +					else
> +						tmpdelta = clock - computed;
> +					if (tmpdelta < delta)
> +						delta = tmpdelta;
> +				}
> +			}
> +		}
> +	}
> +
> +	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
> +}
> +
>   static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
>   						struct drm_atomic_state *new_state)
>   {
> @@ -143,6 +187,7 @@ static const struct mgag200_device_info mgag200_g200ew3_device_info =
>   	MGAG200_DEVICE_INFO_INIT(2048, 2048, 0, true, 0, 1, false);
>   
>   static const struct mgag200_device_funcs mgag200_g200ew3_device_funcs = {
> +	.pixpllc_mode_valid = mgag200_g200ew3_pixpllc_mode_valid,
>   	.pixpllc_atomic_check = mgag200_g200ew3_pixpllc_atomic_check,
>   	.pixpllc_atomic_update = mgag200_g200wb_pixpllc_atomic_update, // same as G200WB
>   };
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> index d847fa8ded..63f9909a99 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> @@ -38,6 +38,46 @@ void mgag200_g200wb_init_registers(struct mga_device *mdev)
>    * PIXPLLC
>    */
>   
> +static enum drm_mode_status mgag200_g200wb_pixpllc_mode_valid(struct drm_crtc *crtc,
> +							      const struct drm_display_mode *mode)
> +{
> +	static const unsigned int vcomax = 550000;
> +	static const unsigned int vcomin = 150000;
> +	static const unsigned int pllreffreq = 48000;
> +
> +	long clock = mode->clock;
> +	unsigned int delta, tmpdelta, permitteddelta;
> +	unsigned int testp, testm, testn;
> +	unsigned int computed;
> +
> +	if (clock <= 0)
> +		return MODE_CLOCK_LOW;
> +
> +	delta = 0xffffffff;
> +	permitteddelta = clock * 5 / 1000;
> +
> +	for (testp = 1; testp < 9; testp++) {
> +		if (clock * testp > vcomax)
> +			continue;
> +		if (clock * testp < vcomin)
> +			continue;
> +
> +		for (testm = 1; testm < 17; testm++) {
> +			for (testn = 1; testn < 151; testn++) {
> +				computed = (pllreffreq * testn) / (testm * testp);
> +				if (computed > clock)
> +					tmpdelta = computed - clock;
> +				else
> +					tmpdelta = clock - computed;
> +				if (tmpdelta < delta)
> +					delta = tmpdelta;
> +			}
> +		}
> +	}
> +
> +	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
> +}
> +
>   static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
>   					       struct drm_atomic_state *new_state)
>   {
> @@ -277,6 +317,7 @@ static const struct mgag200_device_info mgag200_g200wb_device_info =
>   	MGAG200_DEVICE_INFO_INIT(1280, 1024, 31877, true, 0, 1, false);
>   
>   static const struct mgag200_device_funcs mgag200_g200wb_device_funcs = {
> +	.pixpllc_mode_valid = mgag200_g200wb_pixpllc_mode_valid,
>   	.pixpllc_atomic_check = mgag200_g200wb_pixpllc_atomic_check,
>   	.pixpllc_atomic_update = mgag200_g200wb_pixpllc_atomic_update,
>   };
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 8894a063b1..ed82171a84 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -583,6 +583,8 @@ enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
>   {
>   	struct mga_device *mdev = to_mga_device(crtc->dev);
>   	const struct mgag200_device_info *info = mdev->info;
> +	const struct mgag200_device_funcs *funcs = mdev->funcs;
> +	enum drm_mode_status status;
>   
>   	/*
>   	 * Some devices have additional limits on the size of the
> @@ -605,6 +607,17 @@ enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
>   		return MODE_BAD;
>   	}
>   
> +	/*
> +	 * Reject modes whose pixel clock falls outside the per-model PIXPLLC
> +	 * window. Without this filter, pixpllc_atomic_check can return success
> +	 * with zeroed PLL parameters and atomic_update would underflow.
> +	 */
> +	if (funcs->pixpllc_mode_valid) {
> +		status = funcs->pixpllc_mode_valid(crtc, mode);
> +		if (status != MODE_OK)
> +			return status;
> +	}
> +
>   	return MODE_OK;
>   }
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


