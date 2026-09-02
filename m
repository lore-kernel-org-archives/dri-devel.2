Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B08C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5576A10F029;
	Wed,  2 Sep 2026 07:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="nluDesBh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NPQESdUP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N5nj9ss3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9fp7Bj8Z";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE1810F029
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:10:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05FE921FAE;
 Wed,  2 Sep 2026 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788333011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gol5+lY+smVbNgCzrToAeToDdozXtcdBQzaLyRBWN7s=;
 b=nluDesBhEHFLD+dnhkIlxmHZX1C7Le17CFCWE6RA2aIvCVBvnNCWdrTek4Ghnptvc/OIoU
 2sXxQVa6zVWuQ11YdwJxfwYhWjRfxaCQRZx4xsEBxnspsMR0g+H88BnlL51KOBjVzlocXk
 9Fdqpn8TAOTkWoSb3dmWrN2ZIeSELY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788333011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gol5+lY+smVbNgCzrToAeToDdozXtcdBQzaLyRBWN7s=;
 b=NPQESdUPTgUbS93yoWee2TbX6W6I2mtYLEEifkYduLwZp+oVf4zF+LlaxYAjsjPXxD7TxT
 4l/Uy4WiSuVV3HCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788333007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gol5+lY+smVbNgCzrToAeToDdozXtcdBQzaLyRBWN7s=;
 b=N5nj9ss3U/TqsG8O0S6z08nC70lkmjl3JCeYezNSU8VzpNI+P9rAEMHXOSrwNAB2omLvnJ
 cyq8J4Dl4s9pFETwiaM7b5/Rh5DpHqrTeK7WC9r1aK4NW2vyWm1wpjfknPvGWkhqaZWCR8
 oEy5BJG0/DroeBEO4A0W8uX/pwPf3ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788333007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gol5+lY+smVbNgCzrToAeToDdozXtcdBQzaLyRBWN7s=;
 b=9fp7Bj8ZO7q1bBMsvDl4i39Vi1IQUtedaXbn4CXALcUoPkvjjXDq9HHkX89pMyj2v0z/3y
 Qda23eVv18BqYDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E65413515;
 Wed,  2 Sep 2026 07:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y4BfJc7Ll2qNVgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 07:10:06 +0000
Message-ID: <a09ac5c8-8f78-4714-bf3c-1dbc6093761f@suse.de>
Date: Wed, 2 Sep 2026 09:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] drm/loongson: Move hardware reset to CRTC
 creation
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
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
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid, suse.com:url, loongson.cn:email]
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



Am 31.08.26 um 17:34 schrieb Maxime Ripard:
> The loongson crtc reset hook performs both atomic state initialization
> using __drm_atomic_helper_crtc_reset() and hardware-level register
> writes to reset the CRTC.
>
> The hardware reset is not related to atomic state initialization, and
> the reset hook is being converted to atomic_create_state which only
> deals with state allocation. Move the hardware reset to the CRTC
> creation path instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Looks good now.

> ---
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: Jianmin Lv <lvjianmin@loongson.cn>
> Cc: Mingcong Bai <jeffbai@aosc.io>
> Cc: Qianhai Wu <wuqianhai@loongson.cn>
> Cc: Xi Ruoyao <xry111@xry111.site>
> ---
>   drivers/gpu/drm/loongson/lsdc_crtc.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
> index 16b8f36a4071..7cca574e3b6a 100644
> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> @@ -388,12 +388,10 @@ static const struct lsdc_crtc_hw_ops ls7a2000_crtc_hw_ops[2] = {
>   	},
>   };
>   
>   static void lsdc_crtc_reset(struct drm_crtc *crtc)
>   {
> -	struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
> -	const struct lsdc_crtc_hw_ops *ops = lcrtc->hw_ops;
>   	struct lsdc_crtc_state *priv_crtc_state;
>   
>   	if (crtc->state)
>   		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
>   
> @@ -401,13 +399,10 @@ static void lsdc_crtc_reset(struct drm_crtc *crtc)
>   
>   	if (!priv_crtc_state)
>   		__drm_atomic_helper_crtc_reset(crtc, NULL);
>   	else
>   		__drm_atomic_helper_crtc_reset(crtc, &priv_crtc_state->base);
> -
> -	/* Reset the CRTC hardware, this is required for S3 support */
> -	ops->reset(lcrtc);
>   }
>   
>   static void lsdc_crtc_atomic_destroy_state(struct drm_crtc *crtc,
>   					   struct drm_crtc_state *state)
>   {
> @@ -935,18 +930,28 @@ static bool lsdc_crtc_get_scanout_position(struct drm_crtc *crtc,
>   		*etime = ktime_get();
>   
>   	return true;
>   }
>   
> +static void lsdc_crtc_hw_reset(struct drm_crtc *crtc)
> +{
> +	struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
> +
> +	/* Reset the CRTC hardware, this is required for S3 support */
> +	if (lcrtc->hw_ops->reset)
> +		lcrtc->hw_ops->reset(lcrtc);
> +}
> +
>   static const struct drm_crtc_helper_funcs lsdc_crtc_helper_funcs = {
>   	.mode_valid = lsdc_crtc_mode_valid,
>   	.mode_set_nofb = lsdc_crtc_mode_set_nofb,
>   	.atomic_enable = lsdc_crtc_atomic_enable,
>   	.atomic_disable = lsdc_crtc_atomic_disable,
>   	.atomic_check = lsdc_crtc_helper_atomic_check,
>   	.atomic_flush = lsdc_crtc_atomic_flush,
>   	.get_scanout_position = lsdc_crtc_get_scanout_position,
> +	.hw_reset = lsdc_crtc_hw_reset,
>   };
>   
>   int ls7a1000_crtc_init(struct drm_device *ddev,
>   		       struct drm_crtc *crtc,
>   		       struct drm_plane *primary,
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


