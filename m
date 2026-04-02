Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00111CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 06:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC1C10EF93;
	Thu,  2 Apr 2026 06:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="MqxuzMVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tcZe5L9w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MqxuzMVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tcZe5L9w";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B1110EF93
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 06:20:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2788D5BD0E;
 Thu,  2 Apr 2026 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775110828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ptKu7kVrMqEBeCi9D2GQqA7PFMeYCVbidj+6rbCgqG4=;
 b=MqxuzMVtbnSqJbHHvnmGZJ8i/Jb+pCaWJVLXupfxLaEZ+KeA68BYEgmwp/m63uWNoGp/u9
 ergBV00cC/nSLLsg3p+MPZZZHgDULnmnmN1DtcCgDup44W8vHg+Q8zVVzYA4dejGl0JVvS
 WS3BKTL8sAys4OjgRHSlJlcDtplfSaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775110828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ptKu7kVrMqEBeCi9D2GQqA7PFMeYCVbidj+6rbCgqG4=;
 b=tcZe5L9w9EsnSHD85IJl1wKJSYvaCtkGpFJywo25MZMDRwO+bS+ASXHnq1EvZ6mdjG0jNO
 o/Ajd0G/HtWB62Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MqxuzMVt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tcZe5L9w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775110828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ptKu7kVrMqEBeCi9D2GQqA7PFMeYCVbidj+6rbCgqG4=;
 b=MqxuzMVtbnSqJbHHvnmGZJ8i/Jb+pCaWJVLXupfxLaEZ+KeA68BYEgmwp/m63uWNoGp/u9
 ergBV00cC/nSLLsg3p+MPZZZHgDULnmnmN1DtcCgDup44W8vHg+Q8zVVzYA4dejGl0JVvS
 WS3BKTL8sAys4OjgRHSlJlcDtplfSaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775110828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ptKu7kVrMqEBeCi9D2GQqA7PFMeYCVbidj+6rbCgqG4=;
 b=tcZe5L9w9EsnSHD85IJl1wKJSYvaCtkGpFJywo25MZMDRwO+bS+ASXHnq1EvZ6mdjG0jNO
 o/Ajd0G/HtWB62Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8B3F4A0B0;
 Thu,  2 Apr 2026 06:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EhcAM6sKzmn3KQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 06:20:27 +0000
Message-ID: <3f43bc40-58a9-43b2-b21d-7487fb180b57@suse.de>
Date: Thu, 2 Apr 2026 08:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ioc32: stop speculation on the drm_compat_ioctl path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, stable <stable@kernel.org>
References: <2026032451-playing-rummage-8fa2@gregkh>
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
In-Reply-To: <2026032451-playing-rummage-8fa2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email,
 intel.com:email, linuxfoundation.org:email, suse.com:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2788D5BD0E
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



Am 24.03.26 um 17:42 schrieb Greg Kroah-Hartman:
> The drm compat ioctl path takes a user controlled pointer, and then
> dereferences it into a table of function pointers, the signature method
> of spectre problems.  Fix this up by calling array_index_nospec() on the
> index to the function pointer list.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Also acked by Sima and Maxime via IRC

https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-04-01&show_html=true

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Simona Vetter <simona@ffwll.ch>

> ---
> My scripts caught this codepath as not being "protected" for the
> old-school spectre attack.  I don't know how realistic it is, but it
> seems like this is the correct thing to be doing for a 32bit ioctl on
> the drm path, as "local" users can make these.
>
>   drivers/gpu/drm/drm_ioc32.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
> index e6b5b06de148..f3e40d1e6098 100644
> --- a/drivers/gpu/drm/drm_ioc32.c
> +++ b/drivers/gpu/drm/drm_ioc32.c
> @@ -28,6 +28,7 @@
>    * IN THE SOFTWARE.
>    */
>   #include <linux/compat.h>
> +#include <linux/nospec.h>
>   #include <linux/ratelimit.h>
>   #include <linux/export.h>
>   
> @@ -374,6 +375,7 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	if (nr >= ARRAY_SIZE(drm_compat_ioctls))
>   		return drm_ioctl(filp, cmd, arg);
>   
> +	nr = array_index_nospec(nr, ARRAY_SIZE(drm_compat_ioctls));
>   	fn = drm_compat_ioctls[nr].fn;
>   	if (!fn)
>   		return drm_ioctl(filp, cmd, arg);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


