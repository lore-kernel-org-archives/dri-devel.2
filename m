Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A84C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC9410E7CC;
	Mon, 28 Sep 2026 07:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="mju5IAb9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cnn/eMIW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CK7jT4x1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OpYPUq9i";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E5D10E7CC
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:43:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 948431F824;
 Mon, 28 Sep 2026 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790581403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tHqYbORlCUAYHb0msteSAJSvR2Ziv62Ff5ZD/sKAEQs=;
 b=mju5IAb9wtDuGmfGrc8ESOnKfxbpMr6gX0BVAxLU7jbgPJtGcMsE+4dhH3LKWYWMhlmcbh
 fag9/cOzOfhG2wdRRiJQIAqbm6y2M5wqCuyCA9w2AOHJW2y1MdGQvmzj6/KiVFRbfH0WrS
 V0kppzK9NypBB/Q+HEmamg9QOjBULY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790581403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tHqYbORlCUAYHb0msteSAJSvR2Ziv62Ff5ZD/sKAEQs=;
 b=cnn/eMIW4DDlWzlaGKBCx7KxZYi85FKSgI4UYqsI9c9X4Ryz+W8Q+G1CWoT9tuFRbiIJai
 NRM499N1UsDOgwAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790581399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tHqYbORlCUAYHb0msteSAJSvR2Ziv62Ff5ZD/sKAEQs=;
 b=CK7jT4x1eLZIdcZ+M3Xvpum0onH9ph1ItZIxI1sYIUc6Zam+fBYRtxzbL8etVeQo8HCIwL
 WjwEOQZJPFcuQJdan0OmkYAoSZPo7wM15ITVAm3zAUJt7dtYI7oTqSXmdT6S/8Naq/jh0G
 cR3tS4SeSzBhkgSp6WkUmaUV8d1jTGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790581399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tHqYbORlCUAYHb0msteSAJSvR2Ziv62Ff5ZD/sKAEQs=;
 b=OpYPUq9iIE1vISu+W5bweWFR648zMVjDHBBCeSK4IFBVSd23z6OjucxKZG4IF4EeS2Vfqi
 gkAkcfl9Qcqe5NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 299D31340F;
 Mon, 28 Sep 2026 07:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s8hiL5YaumrDSwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 07:43:18 +0000
Message-ID: <349a5c40-5cc4-4e24-8e24-4e05fc8a7bca@suse.de>
Date: Mon, 28 Sep 2026 09:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: Leander Kieweg <kieweg.leander@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
 <20260920193944.110983-3-kieweg.leander@gmail.com>
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
In-Reply-To: <20260920193944.110983-3-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[dt]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,vger.kernel.org];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org,baylibre.com]; 
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Hi,

this looks like it's ready for merging.

One remark on future updates: I assume that you want to further update 
or extend the HW design. One thing you should certainly add is a 
version/feature identifier, so that the driver can distinguish among 
different hardware generations. We also cannot merge support for 
everyone's hobbyist hardware and you got the benefit of being the 
first.  So for future submitters of similar drivers, it might be better 
for them to build upon your work instead of coming up within something 
entirely new. A distinct identifier will be helpful with that.


Am 20.09.26 um 21:39 schrieb Leander Kieweg:
> Introduce the core DRM/KMS driver for GlandaGPU. This driver
> supports basic modesetting, atomic updates via shadow plane helpers,
> and optional QEMU PCI probing alongside the platform driver.
>
> Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

with a question below.


> ---
>   MAINTAINERS                      |   6 +
>   drivers/gpu/drm/tiny/Kconfig     |  11 +
>   drivers/gpu/drm/tiny/Makefile    |   1 +
>   drivers/gpu/drm/tiny/glandagpu.c | 655 +++++++++++++++++++++++++++++++
>   4 files changed, 673 insertions(+)
>   create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
>
[...]
> +
> +static void glanda_crtc_atomic_flush(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_pending_vblank_event *event;
> +
> +	if (new_state->event) {
> +		event = new_state->event;
> +		new_state->event = NULL;
> +
> +		spin_lock_irq(&crtc->dev->event_lock);
> +
> +		if (drm_crtc_vblank_get(crtc) == 0)
> +			drm_crtc_arm_vblank_event(crtc, event);
> +		else
> +			drm_crtc_send_vblank_event(crtc, event);
> +
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +	}
> +}

Is there a reason to no use drm_crtc_vblank_atomic_flush() ? It's the 
same code.

Best regards
Thomas

> +
> +static const struct drm_crtc_funcs glanda_crtc_funcs = {
> +	.destroy = drm_crtc_cleanup,
> +	.set_config = drm_atomic_helper_set_config,
> +	.page_flip = drm_atomic_helper_page_flip,
> +	.reset = drm_atomic_helper_crtc_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +	.enable_vblank = glanda_crtc_enable_vblank,
> +	.disable_vblank = glanda_crtc_disable_vblank,
> +};
> +
> +static const struct drm_crtc_helper_funcs glanda_crtc_helper_funcs = {
> +	.atomic_enable = drm_crtc_vblank_atomic_enable,
> +	.atomic_disable = drm_crtc_vblank_atomic_disable,
> +	.atomic_flush = glanda_crtc_atomic_flush,
> +};
> +
> +static const struct drm_connector_helper_funcs glanda_connector_helper_funcs = {
> +	.get_modes = glanda_connector_get_modes,
> +};
> +
> +static const struct drm_encoder_funcs glanda_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
> +static const struct drm_connector_funcs glanda_connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_mode_config_funcs glanda_mode_config_funcs = {
> +	.fb_create = drm_gem_fb_create_with_dirty,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
> +
> +DEFINE_DRM_GEM_FOPS(glanda_drm_fops);
> +
> +static const struct drm_driver glanda_drm_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.name = "glandagpu",
> +	.desc = "GlandaGPU DRM Driver",
> +	.major = 1,
> +	.minor = 0,
> +	.fops = &glanda_drm_fops,
> +	.dumb_create = drm_gem_shmem_dumb_create,
> +};
> +
> +static irqreturn_t glanda_irq_handler(int irq, void *dev_id)
> +{
> +	struct glanda_device *gdev = dev_id;
> +	u32 isr, ier;
> +
> +	if (!gdev || !gdev->mmio_base)
> +		return IRQ_NONE;
> +
> +	isr = readl(gdev->mmio_base + REG_ISR);
> +	if (unlikely(isr == 0xFFFFFFFF))
> +		return IRQ_NONE;
> +
> +	ier = readl(gdev->mmio_base + REG_IER);
> +
> +	if (!(isr & ier))
> +		return IRQ_NONE;
> +
> +	if (isr & INT_VSYNC)
> +		drm_crtc_handle_vblank(&gdev->crtc);
> +
> +	/* Clear interrupt(W1C) */
> +	writel(isr, gdev->mmio_base + REG_ISR);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Common DRM setup once MMIO/VRAM/IRQ are known(used by both probe paths) */
> +static int glanda_drm_init(struct glanda_device *gdev, int irq)
> +{
> +	int ret;
> +
> +	writel(0, gdev->mmio_base + REG_IER);
> +	writel(0xFFFFFFFF, gdev->mmio_base + REG_ISR);	/* clear flags */
> +
> +	/* DRM mode config */
> +	ret = drmm_mode_config_init(&gdev->drm);
> +	if (ret)
> +		return ret;
> +
> +	gdev->drm.mode_config.min_width = 640;
> +	gdev->drm.mode_config.min_height = 480;
> +	gdev->drm.mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
> +	gdev->drm.mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
> +	gdev->drm.mode_config.funcs = &glanda_mode_config_funcs;
> +
> +	ret = drm_universal_plane_init(&gdev->drm, &gdev->primary_plane, 1 << 0,
> +				       &glanda_plane_funcs,
> +				       glanda_plane_formats,
> +				       ARRAY_SIZE(glanda_plane_formats), NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize primary plane\n");
> +		return ret;
> +	}
> +	drm_plane_helper_add(&gdev->primary_plane, &glanda_plane_helper_funcs);
> +
> +	drm_plane_enable_fb_damage_clips(&gdev->primary_plane);
> +
> +	/* CRTC init */
> +	ret = drm_crtc_init_with_planes(&gdev->drm, &gdev->crtc,
> +					&gdev->primary_plane, NULL,
> +					&glanda_crtc_funcs, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize CRTC with planes\n");
> +		return ret;
> +	}
> +	drm_crtc_helper_add(&gdev->crtc, &glanda_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(&gdev->drm, &gdev->encoder, &glanda_encoder_funcs,
> +			       DRM_MODE_ENCODER_DAC, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize encoder\n");
> +		return ret;
> +	}
> +	gdev->encoder.possible_crtcs = 1;
> +
> +	ret = drm_connector_init(&gdev->drm, &gdev->connector,
> +				 &glanda_connector_funcs, DRM_MODE_CONNECTOR_VGA);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize connector\n");
> +		return ret;
> +	}
> +	drm_connector_helper_add(&gdev->connector, &glanda_connector_helper_funcs);
> +
> +	drm_connector_attach_encoder(&gdev->connector, &gdev->encoder);
> +
> +	/* VBlank init */
> +	ret = drm_vblank_init(&gdev->drm, 1);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize vblank\n");
> +		return ret;
> +	}
> +
> +	drm_mode_config_reset(&gdev->drm);
> +
> +	gdev->irq = irq;
> +	ret = devm_request_irq(gdev->drm.dev, gdev->irq, glanda_irq_handler,
> +			       IRQF_SHARED, "glandagpu", gdev);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to request IRQ %d\n",
> +			gdev->irq);
> +		return ret;
> +	}
> +
> +	ret = drm_dev_register(&gdev->drm, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Shared teardown, mirrors glanda_drm_init() */
> +static void glanda_drm_fini(struct glanda_device *gdev)
> +{
> +	drm_dev_unplug(&gdev->drm);
> +	drm_atomic_helper_shutdown(&gdev->drm);
> +}
> +
> +static int glandagpu_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct glanda_device *gdev;
> +	int irq;
> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	platform_set_drvdata(pdev, gdev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	if (resource_size(res) < GLANDA_MMIO_OFFSET + GLANDA_MMIO_SIZE) {
> +		dev_err(&pdev->dev, "MMIO region too small: %llu bytes, need at least %u\n",
> +			(unsigned long long)resource_size(res),
> +			GLANDA_MMIO_OFFSET + GLANDA_MMIO_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	gdev->vram_phys = res->start;
> +	gdev->vram_base = devm_ioremap_wc(&pdev->dev, res->start, GLANDA_VRAM_SIZE);
> +	gdev->mmio_base = devm_ioremap(&pdev->dev, res->start + GLANDA_MMIO_OFFSET,
> +				       GLANDA_MMIO_SIZE);
> +	if (!gdev->vram_base || !gdev->mmio_base) {
> +		drm_err(&gdev->drm, "failed to ioremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	return glanda_drm_init(gdev, irq);
> +}
> +
> +static void glandagpu_remove(struct platform_device *pdev)
> +{
> +	glanda_drm_fini(platform_get_drvdata(pdev));
> +}
> +
> +static void glandagpu_shutdown(struct platform_device *pdev)
> +{
> +	struct glanda_device *gdev = platform_get_drvdata(pdev);
> +
> +	drm_atomic_helper_shutdown(&gdev->drm);
> +}
> +
> +/* Device Tree match table. */
> +static const struct of_device_id glanda_of_match[] = {
> +	{ .compatible = "kieweg,gpu-1.0" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, glanda_of_match);
> +
> +static struct platform_driver glandagpu_driver = {
> +	.driver = {
> +		.name = "glandagpu",
> +		.of_match_table = glanda_of_match,
> +	},
> +	.probe = glandagpu_probe,
> +	.remove = glandagpu_remove,
> +	.shutdown = glandagpu_shutdown,
> +};
> +
> +/* PCI probe path for the QEMU test device, real hardware uses platform_driver */
> +#ifdef CONFIG_PCI
> +static int glandagpu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct glanda_device *gdev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +	pci_set_master(pdev);
> +
> +	if (pci_resource_len(pdev, 0) < GLANDA_MMIO_SIZE ||
> +	    pci_resource_len(pdev, 1) < GLANDA_VRAM_SIZE) {
> +		dev_err(&pdev->dev, "BAR too small: BAR0=%llu (need %u), BAR1=%llu (need %u)\n",
> +			(unsigned long long)pci_resource_len(pdev, 0), GLANDA_MMIO_SIZE,
> +			(unsigned long long)pci_resource_len(pdev, 1), GLANDA_VRAM_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0), "glandagpu");
> +	if (ret)
> +		return ret;
> +
> +	ret = pcim_request_region(pdev, 1, "glandagpu");
> +	if (ret)
> +		return ret;
> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	pci_set_drvdata(pdev, gdev);
> +
> +	gdev->mmio_base = pcim_iomap_table(pdev)[0];
> +	gdev->vram_phys = pci_resource_start(pdev, 1);
> +
> +	gdev->vram_base = devm_ioremap_wc(&pdev->dev, gdev->vram_phys, GLANDA_VRAM_SIZE);
> +	if (!gdev->vram_base)
> +		return -ENOMEM;
> +
> +	return glanda_drm_init(gdev, pdev->irq);
> +}
> +
> +static void glandagpu_pci_remove(struct pci_dev *pdev)
> +{
> +	glanda_drm_fini(pci_get_drvdata(pdev));
> +}
> +
> +static void glandagpu_pci_shutdown(struct pci_dev *pdev)
> +{
> +	struct glanda_device *gdev = pci_get_drvdata(pdev);
> +
> +	drm_atomic_helper_shutdown(&gdev->drm);
> +}
> +
> +static const struct pci_device_id glanda_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_DEVICE_ID_GLANDA_GPU) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, glanda_pci_ids);
> +
> +static struct pci_driver glandagpu_pci_driver = {
> +	.name = "glandagpu-pci",
> +	.id_table = glanda_pci_ids,
> +	.probe = glandagpu_pci_probe,
> +	.remove = glandagpu_pci_remove,
> +	.shutdown = glandagpu_pci_shutdown,
> +};
> +#endif /* CONFIG_PCI */
> +
> +static int __init glandagpu_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&glandagpu_driver);
> +	if (ret) {
> +		pr_err("GlandaGPU: Failed to register platform driver\n");
> +		return ret;
> +	}
> +
> +#ifdef CONFIG_PCI
> +	ret = pci_register_driver(&glandagpu_pci_driver);
> +	if (ret) {
> +		pr_err("GlandaGPU: Failed to register PCI driver\n");
> +		platform_driver_unregister(&glandagpu_driver);
> +		return ret;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +static void __exit glandagpu_exit(void)
> +{
> +#ifdef CONFIG_PCI
> +	pci_unregister_driver(&glandagpu_pci_driver);
> +#endif
> +	platform_driver_unregister(&glandagpu_driver);
> +}
> +
> +module_init(glandagpu_init);
> +module_exit(glandagpu_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Leander Kieweg <kieweg.leander@gmail.com>");
> +MODULE_DESCRIPTION("DRM driver for GlandaGPU, an FPGA-based 2D GPU with VGA output");

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


