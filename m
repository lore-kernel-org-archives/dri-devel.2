Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E1ECD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B4C112690;
	Thu,  4 Jun 2026 06:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="OhVTnpwT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sMOi3rm3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OhVTnpwT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sMOi3rm3";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDCC11268F
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 06:06:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F02067DA0;
 Thu,  4 Jun 2026 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780553183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vSG1oluyWb68Qc72lyluwslRTtXBVMAThZyTYxUHB74=;
 b=OhVTnpwTkNnGqjpfIWeNVOAx+gKH3ncfAxrh9wSakqOORO3ptEYsMXYYEklGxpFNLpdjS6
 NKSVewJWSUhyIt4nACbHN3LdbBeZJU7k6W5oD7x+8NgCVEyPNOJXPh4IFcI13BPw9DrCa8
 TsvxoztOljY6QHOrzc557f3Q5Qg1TW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780553183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vSG1oluyWb68Qc72lyluwslRTtXBVMAThZyTYxUHB74=;
 b=sMOi3rm3586EfVJoC6OGZA2E6roi2/rms/7+zR9AwheIJsdBzHYHBteJCzYBAeUosjS99n
 U9xW7icOKpRbUlCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780553183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vSG1oluyWb68Qc72lyluwslRTtXBVMAThZyTYxUHB74=;
 b=OhVTnpwTkNnGqjpfIWeNVOAx+gKH3ncfAxrh9wSakqOORO3ptEYsMXYYEklGxpFNLpdjS6
 NKSVewJWSUhyIt4nACbHN3LdbBeZJU7k6W5oD7x+8NgCVEyPNOJXPh4IFcI13BPw9DrCa8
 TsvxoztOljY6QHOrzc557f3Q5Qg1TW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780553183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vSG1oluyWb68Qc72lyluwslRTtXBVMAThZyTYxUHB74=;
 b=sMOi3rm3586EfVJoC6OGZA2E6roi2/rms/7+zR9AwheIJsdBzHYHBteJCzYBAeUosjS99n
 U9xW7icOKpRbUlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19ACC779A8;
 Thu,  4 Jun 2026 06:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id veUWBd8VIWrFBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 04 Jun 2026 06:06:23 +0000
Message-ID: <1712a4ee-fc93-481f-bdf8-524cbc089509@suse.de>
Date: Thu, 4 Jun 2026 08:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/dumb-buffer: Drop buffer-size limits for now
To: rajat.gupta@oss.qualcomm.com, jani.nikula@linux.intel.com,
 jani.saarinen@intel.com, simona@ffwll.ch, airlied@gmail.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20260602112842.252279-1-tzimmermann@suse.de>
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
In-Reply-To: <20260602112842.252279-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 URIBL_BLOCKED(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url,qualcomm.com:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, qualcomm.com:email, suse.com:url]
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

Merged into drm-misc-fixes

Am 02.06.26 um 13:24 schrieb Thomas Zimmermann:
> The size limits break some of the CI tests. So drop them for now. Keep
> the other overflow tests from commit 5ab62dd3687b ("drm: prevent integer
> overflows in dumb buffer creation helpers") in place.
>
> There is still a pre-existing overflow check for 32-bit type limits in
> drm_mode_create_dumb() that will catch the really absurd size requests.
> Drivers that still do not use drm_mode_size_dumb() should be updated. The
> helper calculates dumb-buffer geometry with overflow checks.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 5ab62dd3687b ("drm: prevent integer overflows in dumb buffer creation helpers")
> Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
> Closes: https://lore.kernel.org/dri-devel/ddf0233e50044059c85279f928661563ef6a55bf@intel.com/
> Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_dumb_buffers.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> index e60130b2bb0c..8e9ff17538e7 100644
> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> @@ -201,13 +201,6 @@ int drm_mode_create_dumb(struct drm_device *dev,
>   	if (!args->width || !args->height || !args->bpp)
>   		return -EINVAL;
>   
> -	/* Reject unreasonable inputs early.  Dumb buffers are for software
> -	 * rendering; nothing legitimate needs more than 8192x8192 at 32bpp.
> -	 * This prevents overflows in downstream alignment helpers.
> -	 */
> -	if (args->width >= 8192 || args->height >= 8192 || args->bpp > 32)
> -		return -EINVAL;
> -
>   	/* overflow checks for 32bit size calculations */
>   	if (args->bpp > U32_MAX - 8)
>   		return -EINVAL;
>
> base-commit: a980196655477a8f5067112946401fe52e510664

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


