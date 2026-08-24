Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C3AC61CE3
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A6610E739;
	Mon, 24 Aug 2026 11:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="HOPzs2wP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ct8gV3V3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vRBNbpcY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1roJwesK";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDAC10E739
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:20:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8FE386861;
 Mon, 24 Aug 2026 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787570434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yGiZs3K3jJ9ivKDdzu11UQ37QvXP9MZ5HQrxUb9Dwx8=;
 b=HOPzs2wPL0g5TiA4nXXBND2fG6h/jZtAVn1ZzXrv8ZiDCR4k9OiGyMpcYyp3BY7BMywyVk
 ZS/TwK7hGfYcPkfk9UKoAQJ+/zmjyI/8MZy3Ct/mqzCza8+uY8QQEwX225/HbNSa3xl7Ub
 ZTednH54aBChOgZ0BYPXWM6W/N9+Wi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787570434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yGiZs3K3jJ9ivKDdzu11UQ37QvXP9MZ5HQrxUb9Dwx8=;
 b=Ct8gV3V3lRfu8TVy5EvcBnmeLB3mPfzsh5QEiXfh88pKu/ci7dJaY25y7bBys6x/6X6UgO
 UYyYnCGHrr2obSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787570429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yGiZs3K3jJ9ivKDdzu11UQ37QvXP9MZ5HQrxUb9Dwx8=;
 b=vRBNbpcYsReSvnCGOvkrebQyyWdDX7N7S0S1FyzCisuZ0hmkg5TJB3t3XIDo4k8ksPBXuZ
 8nort/s8j3iUX56mwbwEjlShfTP+oy4j43tqGXh6IDt6lXRT6d/yt0kQCQo3Cqz13FzEIX
 +UDVQr0m8INU0C0JRfGBRtHvIBtVhEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787570429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yGiZs3K3jJ9ivKDdzu11UQ37QvXP9MZ5HQrxUb9Dwx8=;
 b=1roJwesKvdjPoRF4fS1qvwyL9UukelWUZojk3prw447UYPhHrwnu6h2jz0N6RKO6ASgN4t
 d9AKSxlB+BiK97Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A80E713331;
 Mon, 24 Aug 2026 11:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dcXIJ/0ojGqDWAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 24 Aug 2026 11:20:29 +0000
Message-ID: <c795c9f8-65da-49c5-8384-9e29ea015665@suse.de>
Date: Mon, 24 Aug 2026 13:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/70] drm/loongsoon: Move hardware reset to CRTC creation
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-50-fb793475c05a@kernel.org>
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
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-50-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, bootlin.com:url, loongson.cn:email,
 xry111.site:email, iscas.ac.cn:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, aosc.io:email]
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

Am 21.08.26 um 16:39 schrieb Maxime Ripard:
> The loongsoon crtc reset hook performs both atomic state initialization
> using __drm_atomic_helper_crtc_reset() and hardware-level register
> writes to reset the CRTC.
>
> The hardware reset is not related to atomic state initialization, and
> the reset hook is being converted to atomic_create_state which only
> deals with state allocation. Move the hardware reset to the CRTC
> creation path instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: Jianmin Lv <lvjianmin@loongson.cn>
> Cc: Mingcong Bai <jeffbai@aosc.io>
> Cc: Qianhai Wu <wuqianhai@loongson.cn>
> Cc: Xi Ruoyao <xry111@xry111.site>
> ---
>   drivers/gpu/drm/loongson/lsdc_crtc.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
> index 16b8f36a4071..97a3443739e1 100644
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

As the Sashiko bot noted, removing this here will likely break S3 
resume. IIUC you could instead add it before resuming DRM state at [1]

[1] 
https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/loongson/lsdc_drv.c#L390

Best regards
Thomas

>   }
>   
>   static void lsdc_crtc_atomic_destroy_state(struct drm_crtc *crtc,
>   					   struct drm_crtc_state *state)
>   {
> @@ -981,10 +976,13 @@ int ls7a1000_crtc_init(struct drm_device *ddev,
>   	if (ret)
>   		return ret;
>   
>   	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
>   
> +	/* Reset the CRTC hardware, this is required for S3 support */
> +	lcrtc->hw_ops->reset(lcrtc);
> +
>   	return 0;
>   }
>   
>   int ls7a2000_crtc_init(struct drm_device *ddev,
>   		       struct drm_crtc *crtc,
> @@ -1020,7 +1018,10 @@ int ls7a2000_crtc_init(struct drm_device *ddev,
>   	if (ret)
>   		return ret;
>   
>   	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
>   
> +	/* Reset the CRTC hardware, this is required for S3 support */
> +	lcrtc->hw_ops->reset(lcrtc);
> +
>   	return 0;
>   }
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


