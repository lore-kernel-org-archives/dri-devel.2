Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8203C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCAD410F05C;
	Wed,  2 Sep 2026 08:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Gp+fDWmb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zqirUV2b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rd4DbDJ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o/xYyXWn";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BFD10F05D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:02:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0534221959;
 Wed,  2 Sep 2026 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788336134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iR0O11u2q476GA0Rd7futNHjAw/Va0GzNiewis4aiyA=;
 b=Gp+fDWmbKGyjQAQrILvnxKEwzpSjnA4KtJeihsCsrIPapoOerr2u5kDR1VAkkZ695dKS6o
 wsGqNhW/EtR2stWI/mrPnVSggQEyuqNIX/BZXuAtykqd/0an9Gysch1Lh+OjKJFLxunExm
 3VSSEc9x3g/wXFG5DlFjRA+hzfvNuiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788336134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iR0O11u2q476GA0Rd7futNHjAw/Va0GzNiewis4aiyA=;
 b=zqirUV2bDDjJ54Mwvh/bGa0XANOwCd6MoeW5CRrO3ly03soc8LzrcNEw/Os5aQ7eES8hxL
 kSni4/IXbyUDb7AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rd4DbDJ+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="o/xYyXWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788336129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iR0O11u2q476GA0Rd7futNHjAw/Va0GzNiewis4aiyA=;
 b=rd4DbDJ+2HZSH6tPFa9GShKO1eMK+ct/zleOR1SlSUFOrVh0OT1v9OPk4ed68tbrlinC9E
 rP/6q0icYJkrN1PT7hlUKno6JItrq/nz8cq9XQbiBbb+tH1d/nmlYneX53xgpvMh/KBjAt
 /pAU5HZ7AaSSrHc9TImw/TkoHikeYFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788336129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iR0O11u2q476GA0Rd7futNHjAw/Va0GzNiewis4aiyA=;
 b=o/xYyXWnG1KRhoUiid9yGYDNqSX+wnZr8Dk5vuhneiK83ESUaPnbyQSypuaQO/FCoaVTlL
 TCCr+za7iyDLvnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8466713736;
 Wed,  2 Sep 2026 08:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 02W+HgDYl2oPCwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 08:02:08 +0000
Message-ID: <85292368-03d6-49ce-b6df-3bf659347c0f@suse.de>
Date: Wed, 2 Sep 2026 10:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] drm: Fix NULL pointer dereference in
 drm_minor_alloc() on error path
To: shechenglong <shechenglong@xfusion.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stone.xulei@xfusion.com, chenjialong@xfusion.com
References: <20260810120509.784-1-shechenglong@xfusion.com>
 <20260825084410.1306-1-shechenglong@xfusion.com>
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
In-Reply-To: <20260825084410.1306-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0534221959
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[xfusion.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

Hi

Am 25.08.26 um 10:44 schrieb shechenglong:
> When drm_sysfs_minor_alloc() fails (e.g., due to -ENOMEM), the
> following Oops occurs because an ERR_PTR is passed to put_device():
>
>    BUG: kernel NULL pointer dereference, address: 0000000000000030
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    RIP: 0010:kobject_put+0xd/0x60
>    Call Trace:
>     drm_minor_alloc_release+0x1c/0x50 [drm]
>     drm_managed_release+0x96/0x160 [drm]
>     drm_dev_init+0x269/0x330 [drm]
>     drm_dev_alloc+0x3f/0x80 [drm]
>     virtio_gpu_probe+0x40/0x180 [virtio_gpu]
>     virtio_dev_probe+0x1fd/0x360
>     ...
>     do_syscall_64+0xaf/0x500
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The call path that leads to this crash is:
>
>    virtio_gpu_probe()
>      drm_dev_alloc()
>        drm_dev_init()
>          drm_minor_alloc()              // allocates minor
>            drm_sysfs_minor_alloc()      // returns ERR_PTR(-ENOMEM)
>            minor->kdev = ERR_PTR(-ENOMEM)  // stored directly
>            return -ENOMEM
>          // drm_dev_init() fails, triggers cleanup:
>          drm_managed_release()
>            drm_minor_alloc_release(dev, minor)
>              put_device(minor->kdev)     // ERR_PTR(-ENOMEM) dereferenced
>                kobject_put()             // crashes at address 0x30
>
> drm_minor_alloc() assigns the return value of drm_sysfs_minor_alloc()
> directly to minor->kdev, even when it is an error pointer.  The
> subsequent cleanup unconditionally calls put_device(minor->kdev),
> which dereferences the error pointer and causes a NULL-pointer
> dereference (offset 0x30 into a non-page-mapped area).
>
> Fix this by using a temporary variable to hold the result of
> drm_sysfs_minor_alloc().  If the allocation fails, we return the error
> immediately, leaving minor->kdev as NULL (the whole minor structure is
> zero-allocated).  put_device(NULL) is explicitly allowed and safe.
>
> Fixes: f96306f9892b ("drm: manage drm_minor cleanup with drmm_")
>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for the fix.

Best regards
Thomas

> ---
>   drivers/gpu/drm/drm_drv.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 675675480..2348fbb21 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -143,6 +143,7 @@ static void drm_minor_alloc_release(struct drm_device *dev, void *data)
>   static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
>   {
>   	struct drm_minor *minor;
> +	struct device *kdev;
>   	int r;
>   
>   	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
> @@ -164,9 +165,11 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
>   	if (r)
>   		return r;
>   
> -	minor->kdev = drm_sysfs_minor_alloc(minor);
> -	if (IS_ERR(minor->kdev))
> -		return PTR_ERR(minor->kdev);
> +	kdev = drm_sysfs_minor_alloc(minor);
> +	if (IS_ERR(kdev))
> +		return PTR_ERR(kdev);
> +
> +	minor->kdev = kdev;
>   
>   	*drm_minor_get_slot(dev, type) = minor;
>   	return 0;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


