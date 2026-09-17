Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AE3C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0591810E725;
	Thu, 17 Sep 2026 14:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zgqvCEvE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bOuZ6c5H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fs/vDgGP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="phSgg1mD";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB0110E725
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:46:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7780C21B61;
 Thu, 17 Sep 2026 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789656380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2n7DY6XnOh/9/yzfyxj+vuofRAkKf1V4BpsprSdTjQ=;
 b=zgqvCEvE54UNbOHk77HR9Fe7nD1hFk9Twcbhlf4/vA8KnwiX/y6NmdmnivfsFzJP7QGBZ/
 WtaC9GwWV2VDbwsfn4EyhlOkZOKsjiVIo00+KCAF69aNImKSY1d1M6nsgvhA5HOGqHssih
 NQKjZyS4SOPrivsPGoeyBN0TYX20tQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789656380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2n7DY6XnOh/9/yzfyxj+vuofRAkKf1V4BpsprSdTjQ=;
 b=bOuZ6c5HyitQX9ZQiJU0Wd250dfqjUSxmqPCf/y16p6n3ZoNSCiQHyT5i0cYwTHhvzIqxn
 vDm+D6NxQiHMlDCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789656376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2n7DY6XnOh/9/yzfyxj+vuofRAkKf1V4BpsprSdTjQ=;
 b=Fs/vDgGPOwhq/xlKsI9OrdS43pwLXslxpcyXQw4J0WzPzTg+/vEvACtjaNJf1pxDA0VmBC
 jyeyQEkCkYLhv99LNpb6bXIkCHiLGq0opMjGkO3diGIrOXmimsnvUJoMm+UqTHxwuTIOhv
 SKUC2T2DE9CHTDck8+6fYN08H4SPCaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789656376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2n7DY6XnOh/9/yzfyxj+vuofRAkKf1V4BpsprSdTjQ=;
 b=phSgg1mDWilFIHxisYzClv63vbI9UzIN7w29R07vYoFLDuLmk8daAqTCwnnN0DQ2WKsdnA
 vuOAB6AKMW6e6/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18EDF1374A;
 Thu, 17 Sep 2026 14:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FCdUKzf9q2pJFwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 14:46:15 +0000
Message-ID: <bc583273-5ed1-423f-b9d5-14f0dbf2eca9@suse.de>
Date: Thu, 17 Sep 2026 16:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: fix restore of partially initialized client
To: shechenglong <shechenglong@xfusion.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stone.xulei@xfusion.com, chenjialong@xfusion.com
References: <20260907035147.1339-1-shechenglong@xfusion.com>
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
In-Reply-To: <20260907035147.1339-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[xfusion.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:mid, suse.de:email, xfusion.com:email]
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



Am 07.09.26 um 05:51 schrieb shechenglong:
> I got a null-ptr-deref report when closing a DRM file descriptor:
>
> WARNING: drivers/gpu/drm/drm_atomic.c:2031 at
> __drm_atomic_helper_set_config+0x18e/0x1b0 [drm]
>
> Call Trace:
> drm_client_modeset_commit_atomic+0x16b/0x220 [drm]
> drm_client_modeset_commit_locked+0x56/0x160 [drm]
> drm_client_modeset_commit+0x21/0x40 [drm]
> __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x7b/0x80
> drm_fbdev_client_restore+0xe/0x20 [drm_client_lib]
> drm_client_dev_restore+0x9f/0xc0 [drm]
> drm_release+0xc5/0xe0 [drm]
>
> The warning is followed by a NULL pointer dereference:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
>
> RIP:
> __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x41/0x80
> [drm_kms_helper]
>
> Call Trace:
> drm_fbdev_client_restore+0xe/0x20 [drm_client_lib]
> drm_client_dev_restore+0x9f/0xc0 [drm]
> drm_release+0xc5/0xe0 [drm]
> __fput+0xdc/0x2b0
> __x64_sys_close+0x39/0x80
> do_syscall_64+0x8d/0x460
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> drm_client_register() adds the DRM client to the device client list
> before invoking the initial hotplug callback. If the hotplug callback
> fails, the client remains registered.
>
> For the fbdev client, a failure during drm_fb_helper_initial_config()
> causes the partially initialized fbdev helper to be cleaned up.
> drm_fb_helper_fini() releases fb_helper->info and leaves it NULL.
>
> The fbdev client therefore remains registered even though there is no
> fully initialized framebuffer device.
>
> Later, when userspace closes the DRM file descriptor, drm_release()
> can invoke the restore callbacks of registered DRM clients:
>
> drm_release()
> drm_client_dev_restore()
> drm_fbdev_client_restore()
> drm_fb_helper_restore_fbdev_mode_unlocked()
>
> drm_fbdev_client_restore() currently restores the fbdev state
> unconditionally. For a partially initialized fbdev client this can
> submit an incomplete modeset state and subsequently access fbdev
> state which has not been initialized, resulting in the warning and
> NULL pointer dereference above.
>
> drm_fbdev_client_unregister() already uses fb_helper->info to
> distinguish a fully probed framebuffer device from a partially
> initialized client.
>
> Use the same condition in drm_fbdev_client_restore() and skip restore
> if no framebuffer device has been successfully initialized.
>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for fixing this bug.

Fixes: 5d08c44e47b9 ("drm/fbdev: Add memory-agnostic fbdev client")
Cc: <stable@vger.kernel.org> # v6.13+


> ---
>   drivers/gpu/drm/clients/drm_fbdev_client.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
> index 91d196a397cf..1c16bc1084c4 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_client.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
> @@ -42,6 +42,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
>   {
>   	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
>   
> +	/*
> +	 * The client is registered before the initial fbdev probe.
> +	 * If probing failed, the client remains registered but there
> +	 * is no valid fbdev framebuffer to restore.
> +	 */
> +	if (!fb_helper->info || !fb_helper->fb)
> +		return 0;
> +
>   	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
>   
>   	return 0;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


