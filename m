Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4CDCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FA510F663;
	Thu,  1 Oct 2026 13:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cxEv0u3l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BgtnYXwi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SAhyY8M+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ma0duzFG";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF8A10F663
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:58:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BC5A21CEE;
 Thu,  1 Oct 2026 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790863122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JefXXGjGXYBipBajIfXp0RgCgzM+4oFcHKX48E330sk=;
 b=cxEv0u3lAdy8Eoc4xA90MfkwjfvLo6/ZOkVv+wUhxcUq8av86WkVX7ZoWx/GDQjme0HSVt
 4EECUO/5MxQhj28NXTUKs7jjPsrXuOtFh3szfvOJ5J0X8TYS2JBiFJlwci8pJXzqlAGnXW
 zBp8ZeB2vxLu16pfgsMi+LyacYLIR4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790863122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JefXXGjGXYBipBajIfXp0RgCgzM+4oFcHKX48E330sk=;
 b=BgtnYXwiBRoZ02SMK2ABKhNvO378S/ZQy8b+dviuUSeSv9V/4fZcFVSL172tF8gYg73PWi
 ncFa4rWu4zng9BBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SAhyY8M+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ma0duzFG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790863118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JefXXGjGXYBipBajIfXp0RgCgzM+4oFcHKX48E330sk=;
 b=SAhyY8M++a2tQ3w1+2KIhA5HilEMNeKXwF++z+nc62jyyPIfKkwPZNb/kGsKp3dzR1GpjQ
 uADmxxkZ8WB+CAcqxrVZjXBlChXmWZfNISm6Kg9AyzAFN3zAi1PzQqgk0Y9cl7do+uxd88
 yxvq1KadEDZKpVCaKR138kVuKSsKp9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790863118;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JefXXGjGXYBipBajIfXp0RgCgzM+4oFcHKX48E330sk=;
 b=ma0duzFGFH39Ha38EJlGPfRjGUl6TIZOjAVXouXUt0VYv9swDzOSjY/j7Z/SVKuBLfU4H5
 AzPRZkIWy34GH5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D6D134B3;
 Thu,  1 Oct 2026 13:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vn9/Dg5nvmrxUAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 13:58:38 +0000
Message-ID: <74d49d9b-133c-49de-913a-9f526bcfc883@suse.de>
Date: Thu, 1 Oct 2026 15:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct drm_simple_display_pipe
 and helpers
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
 <20261001134714.67EF61F00898@smtp.kernel.org>
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
In-Reply-To: <20261001134714.67EF61F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9BC5A21CEE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.49 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.881]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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



Am 01.10.26 um 15:47 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] drm/kms-helper: build breakage in imx-lcdc due to removed drm_simple_display_pipe

drm-misc-next already contains the fix for this problem.

> - [Low] doc: spelling mistake introduced in fbtft/TODO
> --
>
> commit d4d7a38057f45dc5b1cce9536154c93423caeae1
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Subject: drm/kms-helper: Remove struct drm_simple_display_pipe and helpers
>
> This commit removes the struct drm_simple_display_pipe data type and its
> associated helper functions from the DRM subsystem. It cleans up the
> remaining TODO items related to simple-pipe, under the premise that all
> drivers have been updated to use regular atomic helpers.
>
>>      There are no drivers using struct drm_simple_display_pipe. Remove
>>      the data type and all related helpers.
> [Severity: Low]
> Is this description accurate?
>
> The imx-lcdc driver appears to still use struct drm_simple_display_pipe and
> its helper functions. Compiling with CONFIG_DRM_IMX_LCDC enabled will result
> in a build failure because the driver still relies on this structure in its
> device setup:
>
> drivers/gpu/drm/imx/lcdc/imx-lcdc.c:imx_lcdc() {
> 	...
> 	struct drm_simple_display_pipe pipe;
> 	...
> }
>
> As well as during initialization:
>
> drivers/gpu/drm/imx/lcdc/imx-lcdc.c:imx_lcdc_probe() {
> 	...
> 	ret = drm_simple_display_pipe_init(drm, &lcdc->pipe,
> 					   &imx_lcdc_pipe_funcs,
> 					   imx_lcdc_formats,
> 					   ARRAY_SIZE(imx_lcdc_formats), NULL, NULL);
> 	...
> }
>
>> diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
>> index e72a08bf221cf..72df3ea3a52ce 100644
>> --- a/drivers/staging/fbtft/TODO
>> +++ b/drivers/staging/fbtft/TODO
>> @@ -1,3 +1,3 @@
>> -* convert all these over to drm_simple_display_pipe and submit for inclusion
>> -  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
>> -  drivers anymore.
>> +* convert all these over to DRM and submit thme for inclusion into
>                                                ^^^^
>
> [Severity: Low]
> This isn't a bug, but there is a typo here (thme instead of them).
>
>> +  the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any
>> +  new drivers anymore.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


