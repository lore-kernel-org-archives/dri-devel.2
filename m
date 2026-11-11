Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98260A2607
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=e6GlG5TO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pz6+SvTe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=e6GlG5TO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pz6+SvTe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5DE10E03A;
	Wed, 11 Nov 2026 08:48:47 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367F410F98F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:48:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8975321D9B;
 Wed, 11 Nov 2026 08:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794386914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QgoDMIFKi2tNr/3v23RGwhfeA7KQRN4J36T+PlHbRqY=;
 b=e6GlG5TOKRAzZovD2QKdoASLxw1J+FFJ1pTDyh2EYO5mVXtqabZedyO0pJm6RYMnqkH00V
 95cWn52LuV0nQHjq9BJ3LznpRLfQijloJfjJ7UaSJMML7LBWtVIXNi26IIme5odVia2dfU
 0lCxNbcHV1qTUwwRptvCgByTtJKLWX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794386914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QgoDMIFKi2tNr/3v23RGwhfeA7KQRN4J36T+PlHbRqY=;
 b=pz6+SvTeWWrY4+Gw3pVy1I235ejePnS09tnwZjC0xKtBQYJTQbQGE3JWrNPguu18TVM223
 94x7LHI1jEMG1MCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e6GlG5TO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pz6+SvTe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794386914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QgoDMIFKi2tNr/3v23RGwhfeA7KQRN4J36T+PlHbRqY=;
 b=e6GlG5TOKRAzZovD2QKdoASLxw1J+FFJ1pTDyh2EYO5mVXtqabZedyO0pJm6RYMnqkH00V
 95cWn52LuV0nQHjq9BJ3LznpRLfQijloJfjJ7UaSJMML7LBWtVIXNi26IIme5odVia2dfU
 0lCxNbcHV1qTUwwRptvCgByTtJKLWX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794386914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QgoDMIFKi2tNr/3v23RGwhfeA7KQRN4J36T+PlHbRqY=;
 b=pz6+SvTeWWrY4+Gw3pVy1I235ejePnS09tnwZjC0xKtBQYJTQbQGE3JWrNPguu18TVM223
 94x7LHI1jEMG1MCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D149134E5;
 Wed, 11 Nov 2026 08:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LcxxO+Er9GqbKgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 11 Nov 2026 08:48:34 +0000
Message-ID: <215852e9-aafb-4ad2-93e8-afbadfd91fed@suse.de>
Date: Wed, 11 Nov 2026 09:48:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/sysfb: Copy damage outside the DIRTYFB ioctl
To: Joseph Telaak <joseph@telaak.dev>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261110-sysfb-dirtyfb-v1-1-8571d455ccbe@telaak.dev>
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
In-Reply-To: <20261110-sysfb-dirtyfb-v1-1-8571d455ccbe@telaak.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8975321D9B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, telaak.dev:email, suse.com:url]
X-Spam-Score: -13.50
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 11.11.26 um 02:37 schrieb Joseph Telaak:
> The sysfb drivers implement DIRTYFB with drm_atomic_helper_dirtyfb(),
> which runs a blocking commit. The commit waits for the framebuffer's
> fences, so the ioctl doesn't return until the GPU has finished
> rendering into the framebuffer.

Yes, that's a requirement.

>
> Xorg's modesetting driver calls DIRTYFB from its main thread after
> every frame. When a separate GPU renders for a sysfb display, X then
> blocks for as long as the GPU takes to render the client's frame. With
> a game running, X took a median of 1.85 s to answer a pointer query.
>
> Queue the damage instead and copy it from a worker. The worker still
> waits for the fences, so nothing unfinished reaches the screen, and
> damage that arrives while a copy is pending is merged into it.

Pushing out work from the display update into a worker breaks feedback 
from driver back to compositors. Your compositor/Xorg/whatever needs to 
adapt to and deal with slow framerates.

>
> With this change, X answers in a median of 23 ms and the game's frame
> rate is unchanged.

Fix X if you really care.

Best regards
Thomas

>
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
> This is an RFC because I'm not sure DIRTYFB may return before the copy
> is done. The fbdev emulation already defers its damage to a worker,
> but userspace might rely on DIRTYFB being synchronous. If the approach
> is fine, would you rather have it as a nonblocking mode of
> drm_atomic_helper_dirtyfb() for all drivers instead of in sysfb?
>
> I hit this on an Intel Atom CE5300 board, where simpledrm drives the
> display and the SoC's PowerVR SGX545 GPU renders with a driver I'm
> writing (not upstream yet). I haven't reproduced it with an upstream
> GPU driver, but nothing in the stall is specific to the GPU.
> ---
>   drivers/gpu/drm/sysfb/corebootdrm.c       |   3 +
>   drivers/gpu/drm/sysfb/drm_sysfb_helper.h  |  15 ++-
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 154 ++++++++++++++++++++++++++++++
>   drivers/gpu/drm/sysfb/efidrm.c            |   3 +
>   drivers/gpu/drm/sysfb/ofdrm.c             |   3 +
>   drivers/gpu/drm/sysfb/simpledrm.c         |   3 +
>   drivers/gpu/drm/sysfb/vesadrm.c           |   3 +
>   7 files changed, 183 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sysfb/corebootdrm.c b/drivers/gpu/drm/sysfb/corebootdrm.c
> index 853da9a..4ca359b 100644
> --- a/drivers/gpu/drm/sysfb/corebootdrm.c
> +++ b/drivers/gpu/drm/sysfb/corebootdrm.c
> @@ -206,6 +206,9 @@ static int corebootdrm_mode_config_init(struct corebootdrm_device *cdev,
>   	int ret;
>   
>   	ret = drmm_mode_config_init(dev);
> +	if (ret)
> +		return ret;
> +	ret = drm_sysfb_damage_init(sysfb);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> index 6dab27b..59c4064 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> @@ -5,6 +5,8 @@
>   
>   #include <linux/container_of.h>
>   #include <linux/iosys-map.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
>   
>   #include <video/pixel_format.h>
>   
> @@ -81,6 +83,12 @@ struct drm_sysfb_device {
>   
>   	/* hardware-framebuffer kernel address */
>   	struct iosys_map fb_addr;
> +
> +	/* damage from DIRTYFB, copied to the hardware framebuffer by damage_work */
> +	spinlock_t damage_lock;
> +	struct drm_framebuffer *damage_fb;
> +	struct drm_rect damage;
> +	struct work_struct damage_work;
>   };
>   
>   static inline struct drm_sysfb_device *to_drm_sysfb_device(struct drm_device *dev)
> @@ -203,8 +211,13 @@ int drm_sysfb_connector_helper_get_modes(struct drm_connector *connector);
>    * Mode config
>    */
>   
> +int drm_sysfb_damage_init(struct drm_sysfb_device *sysfb);
> +struct drm_framebuffer *drm_sysfb_fb_create(struct drm_device *dev, struct drm_file *file,
> +					    const struct drm_format_info *info,
> +					    const struct drm_mode_fb_cmd2 *mode_cmd);
> +
>   #define DRM_SYSFB_MODE_CONFIG_FUNCS \
> -	.fb_create = drm_gem_fb_create_with_dirty, \
> +	.fb_create = drm_sysfb_fb_create, \
>   	.atomic_check = drm_atomic_helper_check, \
>   	.atomic_commit = drm_atomic_helper_commit
>   
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> index 13df092..e77f0c0 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -12,6 +12,7 @@
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_managed.h>
>   #include <drm/drm_panic.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> @@ -612,3 +613,156 @@ int drm_sysfb_connector_helper_get_modes(struct drm_connector *connector)
>   	return drm_connector_helper_get_modes_fixed(connector, &sysfb->fb_mode);
>   }
>   EXPORT_SYMBOL(drm_sysfb_connector_helper_get_modes);
> +
> +/*
> + * Damage
> + *
> + * DIRTYFB returns at once: the damage is merged into one pending rectangle,
> + * and a worker hands it to drm_atomic_helper_dirtyfb(). That commit waits for
> + * the framebuffer's fences, the GPU work that last rendered into it, before
> + * the CPU copies it to the hardware framebuffer. Done in the ioctl, the wait
> + * blocks the compositor for as long as that rendering takes. Damage that
> + * arrives while the worker runs is merged and copied by the next run, so none
> + * is dropped.
> + */
> +
> +static void drm_sysfb_damage_work(struct work_struct *work)
> +{
> +	struct drm_sysfb_device *sysfb = container_of(work, struct drm_sysfb_device,
> +						      damage_work);
> +	struct drm_framebuffer *fb;
> +	struct drm_clip_rect clip;
> +	int idx, ret;
> +
> +	spin_lock(&sysfb->damage_lock);
> +	fb = sysfb->damage_fb;
> +	sysfb->damage_fb = NULL;
> +	clip.x1 = sysfb->damage.x1;
> +	clip.y1 = sysfb->damage.y1;
> +	clip.x2 = sysfb->damage.x2;
> +	clip.y2 = sysfb->damage.y2;
> +	spin_unlock(&sysfb->damage_lock);
> +	if (!fb)
> +		return;
> +
> +	if (drm_dev_enter(&sysfb->dev, &idx)) {
> +		ret = drm_atomic_helper_dirtyfb(fb, NULL, 0, 0, &clip, 1);
> +		if (ret)
> +			drm_err_ratelimited(&sysfb->dev, "damage update failed: %d\n", ret);
> +		drm_dev_exit(idx);
> +	}
> +	drm_framebuffer_put(fb);
> +}
> +
> +static void drm_sysfb_damage_fini(struct drm_device *dev, void *arg)
> +{
> +	struct drm_sysfb_device *sysfb = arg;
> +
> +	cancel_work_sync(&sysfb->damage_work);
> +	if (sysfb->damage_fb)
> +		drm_framebuffer_put(sysfb->damage_fb);
> +	sysfb->damage_fb = NULL;
> +}
> +
> +/**
> + * drm_sysfb_damage_init - Set up deferred damage for a sysfb device
> + * @sysfb: the device
> + *
> + * Call after drmm_mode_config_init(). Framebuffers from drm_sysfb_fb_create()
> + * then copy their damage outside the DIRTYFB ioctl.
> + *
> + * Returns: 0 on success, or a negative errno.
> + */
> +int drm_sysfb_damage_init(struct drm_sysfb_device *sysfb)
> +{
> +	spin_lock_init(&sysfb->damage_lock);
> +	INIT_WORK(&sysfb->damage_work, drm_sysfb_damage_work);
> +
> +	return drmm_add_action_or_reset(&sysfb->dev, drm_sysfb_damage_fini, sysfb);
> +}
> +EXPORT_SYMBOL(drm_sysfb_damage_init);
> +
> +static void drm_sysfb_damage_bounds(struct drm_framebuffer *fb, unsigned int flags,
> +				    const struct drm_clip_rect *clips, unsigned int num_clips,
> +				    struct drm_rect *r)
> +{
> +	unsigned int inc = 1;
> +
> +	if (!clips || !num_clips) {
> +		drm_rect_init(r, 0, 0, fb->width, fb->height);
> +		return;
> +	}
> +	if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY) {
> +		inc = 2;
> +		num_clips /= 2;
> +	}
> +	drm_rect_init(r, clips->x1, clips->y1, clips->x2 - clips->x1, clips->y2 - clips->y1);
> +	for (unsigned int i = 1; i < num_clips; i++) {
> +		clips += inc;
> +		r->x1 = min_t(int, r->x1, clips->x1);
> +		r->y1 = min_t(int, r->y1, clips->y1);
> +		r->x2 = max_t(int, r->x2, clips->x2);
> +		r->y2 = max_t(int, r->y2, clips->y2);
> +	}
> +}
> +
> +static int drm_sysfb_fb_dirty(struct drm_framebuffer *fb, struct drm_file *file,
> +			      unsigned int flags, unsigned int color,
> +			      struct drm_clip_rect *clips, unsigned int num_clips)
> +{
> +	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(fb->dev);
> +	struct drm_rect r;
> +	bool queue = false;
> +
> +	drm_sysfb_damage_bounds(fb, flags, clips, num_clips, &r);
> +
> +	spin_lock(&sysfb->damage_lock);
> +	/* Pending damage of another framebuffer is copied first. */
> +	while (sysfb->damage_fb && sysfb->damage_fb != fb) {
> +		spin_unlock(&sysfb->damage_lock);
> +		flush_work(&sysfb->damage_work);
> +		spin_lock(&sysfb->damage_lock);
> +	}
> +	if (!sysfb->damage_fb) {
> +		drm_framebuffer_get(fb);
> +		sysfb->damage_fb = fb;
> +		sysfb->damage = r;
> +		queue = true;
> +	} else {
> +		sysfb->damage.x1 = min(sysfb->damage.x1, r.x1);
> +		sysfb->damage.y1 = min(sysfb->damage.y1, r.y1);
> +		sysfb->damage.x2 = max(sysfb->damage.x2, r.x2);
> +		sysfb->damage.y2 = max(sysfb->damage.y2, r.y2);
> +	}
> +	spin_unlock(&sysfb->damage_lock);
> +
> +	if (queue)
> +		queue_work(system_dfl_wq, &sysfb->damage_work);
> +	return 0;
> +}
> +
> +static const struct drm_framebuffer_funcs drm_sysfb_fb_funcs = {
> +	.destroy = drm_gem_fb_destroy,
> +	.create_handle = drm_gem_fb_create_handle,
> +	.dirty = drm_sysfb_fb_dirty,
> +};
> +
> +/**
> + * drm_sysfb_fb_create - &drm_mode_config_funcs.fb_create for sysfb devices
> + * @dev: the device
> + * @file: the DRM file of the caller
> + * @info: the pixel format
> + * @mode_cmd: the framebuffer from userspace
> + *
> + * Like drm_gem_fb_create_with_dirty(), but the framebuffer's damage is copied
> + * outside the DIRTYFB ioctl (drm_sysfb_damage_init()).
> + *
> + * Returns: the framebuffer, or an ERR_PTR() on failure.
> + */
> +struct drm_framebuffer *drm_sysfb_fb_create(struct drm_device *dev, struct drm_file *file,
> +					    const struct drm_format_info *info,
> +					    const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	return drm_gem_fb_create_with_funcs(dev, file, info, mode_cmd, &drm_sysfb_fb_funcs);
> +}
> +EXPORT_SYMBOL(drm_sysfb_fb_create);
> diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
> index 8b19f43..0ef093a 100644
> --- a/drivers/gpu/drm/sysfb/efidrm.c
> +++ b/drivers/gpu/drm/sysfb/efidrm.c
> @@ -299,6 +299,9 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
>   	 */
>   
>   	ret = drmm_mode_config_init(dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	ret = drm_sysfb_damage_init(sysfb);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
> index c412555..4d31bb6 100644
> --- a/drivers/gpu/drm/sysfb/ofdrm.c
> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> @@ -1021,6 +1021,9 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
>   	 */
>   
>   	ret = drmm_mode_config_init(dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	ret = drm_sysfb_damage_init(sysfb);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
> index deaeb7d..c40a6c5 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -813,6 +813,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>   	 */
>   
>   	ret = drmm_mode_config_init(dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	ret = drm_sysfb_damage_init(sysfb);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
> index 1668aab..812db4a 100644
> --- a/drivers/gpu/drm/sysfb/vesadrm.c
> +++ b/drivers/gpu/drm/sysfb/vesadrm.c
> @@ -539,6 +539,9 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
>   	 */
>   
>   	ret = drmm_mode_config_init(dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	ret = drm_sysfb_damage_init(sysfb);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
>
> ---
> base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
> change-id: 20261110-sysfb-dirtyfb-beda10fab602
>
> Best regards,
> --
> Joseph Telaak <joseph@telaak.dev>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


