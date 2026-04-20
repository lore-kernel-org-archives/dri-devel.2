Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE5DF588C6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1E610E611;
	Mon, 20 Apr 2026 13:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dm+v+Sp3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RsjILMCK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dm+v+Sp3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RsjILMCK";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FBA10E611
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:47:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26E0E6A8A5;
 Mon, 20 Apr 2026 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776692841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MSajuya0tcZu5hv18eFK1K1Xnm0IMWJmSiIfSS9wd2c=;
 b=dm+v+Sp3W1V84veKQVhVDBLibDmxo8anzfONP5XsRTcQG/+1Y4RvObDc7JfxB5AvMqELqc
 oC/dC4Ll+80JNTBknDeliRwXvSEsnK5frOVDs3zjr2LS7R/edV0SIx1l1rfTVPOn7MJ0Jy
 DMz4kgfhpCpeZ7d45ugFnHt5AdFG68M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776692841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MSajuya0tcZu5hv18eFK1K1Xnm0IMWJmSiIfSS9wd2c=;
 b=RsjILMCKWK4B6mtjltkhjyqxVrNmYKFGUdKw7FDcThOwE3GaTCVJ7xQqKaberjMcwoYEfq
 IAXabBRj2UpK6nCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776692841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MSajuya0tcZu5hv18eFK1K1Xnm0IMWJmSiIfSS9wd2c=;
 b=dm+v+Sp3W1V84veKQVhVDBLibDmxo8anzfONP5XsRTcQG/+1Y4RvObDc7JfxB5AvMqELqc
 oC/dC4Ll+80JNTBknDeliRwXvSEsnK5frOVDs3zjr2LS7R/edV0SIx1l1rfTVPOn7MJ0Jy
 DMz4kgfhpCpeZ7d45ugFnHt5AdFG68M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776692841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MSajuya0tcZu5hv18eFK1K1Xnm0IMWJmSiIfSS9wd2c=;
 b=RsjILMCKWK4B6mtjltkhjyqxVrNmYKFGUdKw7FDcThOwE3GaTCVJ7xQqKaberjMcwoYEfq
 IAXabBRj2UpK6nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D002B593AE;
 Mon, 20 Apr 2026 13:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MR5XMWgu5mniQQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 13:47:20 +0000
Message-ID: <ba0e372b-8ad0-442a-a91e-d90e80114403@suse.de>
Date: Mon, 20 Apr 2026 15:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/appletbdrm: Use kvzalloc for big allocations
To: Sasha Finkelstein <k@chaosmail.tech>, Aun-Ali Zaidi <admin@kodeit.net>,
 Aditya Garg <gargaditya08@live.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 soopyc <cassie@soopy.moe>
References: <20260420-x86-tb-vmalloc-v1-1-7757ff657223@chaosmail.tech>
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
In-Reply-To: <20260420-x86-tb-vmalloc-v1-1-7757ff657223@chaosmail.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SEM_URIBL_FRESH15(3.00)[chaosmail.tech:email];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[chaosmail.tech,kodeit.net,live.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,chaosmail.tech:email,suse.de:mid,suse.com:url,soopy.moe:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 chaosmail.tech:email, suse.de:mid, suse.com:url, soopy.moe:email]
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



Am 20.04.26 um 14:17 schrieb Sasha Finkelstein:
> This driver is attached to a ~2000x80 screen, which is a lot more than
> a single page. This causes out of memory errors in some rare cases.
>
> Reported-by: soopyc <cassie@soopy.moe>
> Closes: https://github.com/t2linux/fedora/issues/51
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>

Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 
Macs")
Cc: <stable@vger.kernel.org> # v6.15+


> ---
>   drivers/gpu/drm/tiny/appletbdrm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
> index 3bae91d7eefe..278bb23fe4c8 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -353,7 +353,7 @@ static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   		       frames_size +
>   		       sizeof(struct appletbdrm_fb_request_footer), 16);
>   
> -	appletbdrm_state->request = kzalloc(request_size, GFP_KERNEL);
> +	appletbdrm_state->request = kvzalloc(request_size, GFP_KERNEL);
>   
>   	if (!appletbdrm_state->request)
>   		return -ENOMEM;
> @@ -543,7 +543,7 @@ static void appletbdrm_primary_plane_destroy_state(struct drm_plane *plane,
>   {
>   	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(state);
>   
> -	kfree(appletbdrm_state->request);
> +	kvfree(appletbdrm_state->request);
>   	kfree(appletbdrm_state->response);
>   
>   	__drm_gem_destroy_shadow_plane_state(&appletbdrm_state->base);
>
> ---
> base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
> change-id: 20260420-x86-tb-vmalloc-4c94d5eaeeae
>
> Best regards,
> --
> Sasha Finkelstein <k@chaosmail.tech>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


