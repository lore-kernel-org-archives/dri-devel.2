Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ED8C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB0910E341;
	Wed, 16 Sep 2026 06:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="TZ/zq1Rn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e5N4EcVW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0/M4VYRi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cd3MI51R";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1450410E341
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:50:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38C6A1FDD2;
 Wed, 16 Sep 2026 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789541427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q1Rlto9SnJgRaHJraIYWJFcfagZYqIMFP0BBB/sf7fE=;
 b=TZ/zq1RnlM2xpYQOmH/HwJkp52sY0SEiteMePDhTlwWGfBUZHpTyHScFA59Y81pfwVw/EI
 5TGLA4NaOat3FNyV3fDgwLj5DgPHZr7rgw+ppJSdcOJHfAJBtyvL88dmmBLYnim0IMjT3J
 l77GTDr9t23y9GiGER02VBh3aQh2djA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789541427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q1Rlto9SnJgRaHJraIYWJFcfagZYqIMFP0BBB/sf7fE=;
 b=e5N4EcVW7vOCcAoIIiYm3cIS8BaVJB0Mbo77IPyji6ZoQAZnZQpJ77LI7UNWhAvGBMgMcN
 OKIq7Dtdr70o0IBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0/M4VYRi";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cd3MI51R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789541423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q1Rlto9SnJgRaHJraIYWJFcfagZYqIMFP0BBB/sf7fE=;
 b=0/M4VYRiPlBIQlmFuj1q2+uA1pXiWQ9A2HAy2vIXEEcrush/tlyFGsE7Xq0f+w6oU0y72w
 0BB+Kh+6eRrssN2U3/VBty0LYeYIvQ8RdrPEhWdGbCXCLfb9ZVUT0k8b0oyGu10Xj0CyvH
 0+57HrK3SBPeRoyTFFffmW3EIb0OQ3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789541423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q1Rlto9SnJgRaHJraIYWJFcfagZYqIMFP0BBB/sf7fE=;
 b=cd3MI51RD6FudCt6pZ5qioa6wu2F0gZlMJFOQ3lZ/z2GekKGtjSos20r1Jd3JSxsPv7wIt
 WpdvOtYiAR/zABBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ED2C136D1;
 Wed, 16 Sep 2026 06:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K2fRBy48qmqIYgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Sep 2026 06:50:22 +0000
Message-ID: <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>
Date: Wed, 16 Sep 2026 08:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Marian Cichy <m.cichy@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com>
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
In-Reply-To: <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38C6A1FDD2
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,qualcomm.com:email,suse.de:dkim,suse.de:mid,bootlin.com:url,pengutronix.de:email,i.mx:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[25]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, pengutronix.de:email, i.mx:url,
 suse.com:url, qualcomm.com:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

Am 26.07.26 um 21:42 schrieb Ze Huang:
> Convert i.MX LCDC to explicit primary plane, CRTC and encoder objects.
> Keep no-scaling plane check and GEM framebuffer prepare callback from
> simple-KMS path.
>
> Wire the vblank lifecycle explicitly with CRTC vblank callbacks and
> drm_crtc_vblank_on()/drm_crtc_vblank_off(). Use the old CRTC state in the
> disable path for clock unwinding so the clock reference count remains
> paired with the previous active state.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 264 ++++++++++++++++++++++++++----------
>   1 file changed, 190 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> index 81024f7d9e96..4835f01954f7 100644
> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> @@ -2,6 +2,7 @@
>   // SPDX-FileCopyrightText: 2020 Marian Cichy <M.Cichy@pengutronix.de>
>   
>   #include <drm/clients/drm_client_setup.h>
> +#include <drm/drm_atomic.h>
>   #include <drm/drm_bridge.h>
>   #include <drm/drm_bridge_connector.h>
>   #include <drm/drm_damage_helper.h>
> @@ -14,9 +15,9 @@
>   #include <drm/drm_gem_dma_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_of.h>
> +#include <drm/drm_plane_helper.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_vblank.h>
>   #include <linux/bitfield.h>
>   #include <linux/clk.h>
> @@ -102,7 +103,9 @@
>   
>   struct imx_lcdc {
>   	struct drm_device drm;
> -	struct drm_simple_display_pipe pipe;
> +	struct drm_plane plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
>   	struct drm_connector *connector;
>   	void __iomem *base;
>   
> @@ -135,14 +138,15 @@ static unsigned int imx_lcdc_get_format(unsigned int drm_format)
>   	}
>   }
>   
> -static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
> -					 struct drm_plane_state *old_state,
> +static void imx_lcdc_update_hw_registers(struct drm_crtc *crtc,
> +					 struct drm_crtc_state *old_crtc_state,
> +					 struct drm_crtc_state *new_crtc_state,
> +					 struct drm_plane_state *new_state,
>   					 bool mode_set)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_plane_state *new_state = pipe->plane.state;
> +	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
> +	const struct drm_display_mode *mode = &new_crtc_state->mode;
>   	struct drm_framebuffer *fb = new_state->fb;
> -	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
>   	u32 lpcr, lvcr, lhcr;
>   	u32 framesize;
>   	dma_addr_t addr;
> @@ -155,24 +159,24 @@ static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
>   		return;
>   
>   	/* Disable PER clock to make register write possible */
> -	if (old_state && old_state->crtc && old_state->crtc->enabled)
> +	if (old_crtc_state && old_crtc_state->enable)
>   		clk_disable_unprepare(lcdc->clk_per);
>   
>   	/* Framesize */
> -	framesize = FIELD_PREP(IMX21LCDC_LSR_XMAX, crtc->mode.hdisplay >> 4) |
> -		FIELD_PREP(IMX21LCDC_LSR_YMAX, crtc->mode.vdisplay);
> +	framesize = FIELD_PREP(IMX21LCDC_LSR_XMAX, mode->hdisplay >> 4) |
> +		FIELD_PREP(IMX21LCDC_LSR_YMAX, mode->vdisplay);
>   	writel(framesize, lcdc->base + IMX21LCDC_LSR);
>   
>   	/* HSYNC */
> -	lhcr = FIELD_PREP(IMX21LCDC_LHCR_HFPORCH, crtc->mode.hsync_start - crtc->mode.hdisplay - 1) |
> -		FIELD_PREP(IMX21LCDC_LHCR_HWIDTH, crtc->mode.hsync_end - crtc->mode.hsync_start - 1) |
> -		FIELD_PREP(IMX21LCDC_LHCR_HBPORCH, crtc->mode.htotal - crtc->mode.hsync_end - 3);
> +	lhcr = FIELD_PREP(IMX21LCDC_LHCR_HFPORCH, mode->hsync_start - mode->hdisplay - 1) |
> +		FIELD_PREP(IMX21LCDC_LHCR_HWIDTH, mode->hsync_end - mode->hsync_start - 1) |
> +		FIELD_PREP(IMX21LCDC_LHCR_HBPORCH, mode->htotal - mode->hsync_end - 3);
>   	writel(lhcr, lcdc->base + IMX21LCDC_LHCR);
>   
>   	/* VSYNC */
> -	lvcr = FIELD_PREP(IMX21LCDC_LVCR_VFPORCH, crtc->mode.vsync_start - crtc->mode.vdisplay) |
> -		FIELD_PREP(IMX21LCDC_LVCR_VWIDTH, crtc->mode.vsync_end - crtc->mode.vsync_start) |
> -		FIELD_PREP(IMX21LCDC_LVCR_VBPORCH, crtc->mode.vtotal - crtc->mode.vsync_end);
> +	lvcr = FIELD_PREP(IMX21LCDC_LVCR_VFPORCH, mode->vsync_start - mode->vdisplay) |
> +		FIELD_PREP(IMX21LCDC_LVCR_VWIDTH, mode->vsync_end - mode->vsync_start) |
> +		FIELD_PREP(IMX21LCDC_LVCR_VBPORCH, mode->vtotal - mode->vsync_end);
>   	writel(lvcr, lcdc->base + IMX21LCDC_LVCR);
>   
>   	lpcr = readl(lcdc->base + IMX21LCDC_LPCR);
> @@ -184,19 +188,20 @@ static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
>   	writel(new_state->fb->pitches[0] / 4, lcdc->base + IMX21LCDC_LVPWR);
>   
>   	/* Enable PER clock */
> -	if (new_state->crtc->enabled)
> +	if (new_crtc_state->enable)
>   		clk_prepare_enable(lcdc->clk_per);
>   }
>   
> -static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
> -				 struct drm_crtc_state *crtc_state,
> -				 struct drm_plane_state *plane_state)
> +static void imx_lcdc_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *commit)
>   {
>   	int ret;
>   	int clk_div;
>   	int bpp;
> -	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
> -	struct drm_display_mode *mode = &pipe->crtc.mode;
> +	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
> +	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(commit, crtc);
> +	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, &lcdc->plane);
> +	struct drm_display_mode *mode = &cstate->mode;
>   	struct drm_display_info *disp_info = &lcdc->connector->display_info;
>   	const int hsync_pol = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : 1;
>   	const int vsync_pol = (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : 1;
> @@ -207,7 +212,7 @@ static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
>   
>   	clk_div = DIV_ROUND_CLOSEST_ULL(clk_get_rate(lcdc->clk_per),
>   					mode->clock * 1000);
> -	bpp = imx_lcdc_get_format(plane_state->fb->format->format);
> +	bpp = imx_lcdc_get_format(pstate->fb->format->format);
>   
>   	writel(FIELD_PREP(IMX21LCDC_LPCR_PCD, clk_div - 1) |
>   	       FIELD_PREP(IMX21LCDC_LPCR_LPPOL, hsync_pol) |
> @@ -231,40 +236,46 @@ static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
>   
>   	ret = clk_prepare_enable(lcdc->clk_ipg);
>   	if (ret) {
> -		dev_err(pipe->crtc.dev->dev, "Cannot enable ipg clock: %pe\n", ERR_PTR(ret));
> +		dev_err(crtc->dev->dev, "Cannot enable ipg clock: %pe\n", ERR_PTR(ret));
>   		return;
>   	}
>   	ret = clk_prepare_enable(lcdc->clk_ahb);
>   	if (ret) {
> -		dev_err(pipe->crtc.dev->dev, "Cannot enable ahb clock: %pe\n", ERR_PTR(ret));
> +		dev_err(crtc->dev->dev, "Cannot enable ahb clock: %pe\n", ERR_PTR(ret));
>   
>   		clk_disable_unprepare(lcdc->clk_ipg);
>   
>   		return;
>   	}
>   
> -	imx_lcdc_update_hw_registers(pipe, NULL, true);
> +	imx_lcdc_update_hw_registers(crtc, NULL, cstate, pstate, true);
>   
>   	/* Enable VBLANK Interrupt */
>   	writel(INTR_EOF, lcdc->base + IMX21LCDC_LIER);
> +
> +	drm_crtc_vblank_on(crtc);
>   }
>   
> -static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
> +static void imx_lcdc_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +						struct drm_atomic_commit *commit)
>   {
> -	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
> -	struct drm_crtc *crtc = &lcdc->pipe.crtc;
> +	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(commit, crtc);
> +	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
> +	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
>   	struct drm_pending_vblank_event *event;
>   
> +	drm_crtc_vblank_off(crtc);
> +
>   	clk_disable_unprepare(lcdc->clk_ahb);
>   	clk_disable_unprepare(lcdc->clk_ipg);
>   
> -	if (pipe->crtc.enabled)
> +	if (old_crtc_state->enable)
>   		clk_disable_unprepare(lcdc->clk_per);
>   
>   	spin_lock_irq(&lcdc->drm.event_lock);
> -	event = crtc->state->event;
> +	event = new_crtc_state->event;
>   	if (event) {
> -		crtc->state->event = NULL;
> +		new_crtc_state->event = NULL;
>   		drm_crtc_send_vblank_event(crtc, event);
>   	}
>   	spin_unlock_irq(&lcdc->drm.event_lock);
> @@ -273,66 +284,151 @@ static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
>   	writel(0, lcdc->base + IMX21LCDC_LIER);
>   }
>   
> -static int imx_lcdc_pipe_check(struct drm_simple_display_pipe *pipe,
> -			       struct drm_plane_state *plane_state,
> -			       struct drm_crtc_state *crtc_state)
> +static int imx_lcdc_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *commit)
>   {
> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
> +	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(commit, crtc);
>   	const struct drm_display_mode *mode = &crtc_state->mode;
> -	const struct drm_display_mode *old_mode = &pipe->crtc.state->mode;
> +	const struct drm_display_mode *old_mode = &old_crtc_state->mode;
> +	int ret;
>   
> -	if (mode->hdisplay < LCDC_MIN_XRES || mode->hdisplay > LCDC_MAX_XRES ||
> -	    mode->vdisplay < LCDC_MIN_YRES || mode->vdisplay > LCDC_MAX_YRES ||
> -	    mode->hdisplay % 0x10) { /* must be multiple of 16 */
> -		drm_err(pipe->crtc.dev, "unsupported display mode (%u x %u)\n",
> +	if (crtc_state->enable) {
> +		ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (crtc_state->enable &&
> +	    (mode->hdisplay < LCDC_MIN_XRES || mode->hdisplay > LCDC_MAX_XRES ||
> +	     mode->vdisplay < LCDC_MIN_YRES || mode->vdisplay > LCDC_MAX_YRES ||
> +	     mode->hdisplay % 0x10)) { /* must be multiple of 16 */
> +		drm_err(crtc->dev, "unsupported display mode (%u x %u)\n",
>   			mode->hdisplay, mode->vdisplay);
>   		return -EINVAL;
>   	}
>   
> -	crtc_state->mode_changed =
> -		old_mode->hdisplay != mode->hdisplay ||
> -		old_mode->vdisplay != mode->vdisplay;
> +	if (old_mode->hdisplay != mode->hdisplay ||
> +	    old_mode->vdisplay != mode->vdisplay)
> +		crtc_state->mode_changed = true;
>   
> -	return 0;
> +	return drm_atomic_add_affected_planes(commit, crtc);
>   }
>   
> -static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
> -				 struct drm_plane_state *old_state)
> +static void imx_lcdc_plane_helper_atomic_update(struct drm_plane *plane,
> +						struct drm_atomic_commit *commit)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_pending_vblank_event *event = crtc->state->event;
> -	struct drm_plane_state *new_state = pipe->plane.state;
> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
> +	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(commit, plane);
> +	struct drm_crtc *crtc = new_state->crtc;
> +	struct drm_crtc_state *old_crtc_state = NULL;
> +	struct drm_crtc_state *new_crtc_state;
>   	struct drm_framebuffer *fb = new_state->fb;
>   	struct drm_framebuffer *old_fb = old_state->fb;
>   	struct drm_crtc *old_crtc = old_state->crtc;
>   	bool mode_changed = false;
>   
> +	if (!fb || !crtc)
> +		return;
> +
> +	if (old_crtc)
> +		old_crtc_state = drm_atomic_get_old_crtc_state(commit, old_crtc);
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
> +	if (!new_crtc_state)
> +		return;
> +
>   	if (old_fb && old_fb->format != fb->format)
>   		mode_changed = true;
>   	else if (old_crtc != crtc)
>   		mode_changed = true;
>   
> -	if (!drm_atomic_crtc_needs_modeset(crtc->state))
> -		imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
> +	if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
> +		imx_lcdc_update_hw_registers(crtc, old_crtc_state, new_crtc_state,
> +					     new_state, mode_changed);
> +}
>   
> -	if (event) {
> -		crtc->state->event = NULL;
> +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *plane,
> +					      struct drm_atomic_commit *commit)
> +{
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
> +	struct drm_crtc_state *crtc_state = NULL;
> +
> +	if (plane_state->crtc) {
> +		crtc_state = drm_atomic_get_crtc_state(commit, plane_state->crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +	}
>   
> -		spin_lock_irq(&crtc->dev->event_lock);
> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, false);
> +}
>   
> -		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
> -			drm_crtc_arm_vblank_event(crtc, event);
> -		else
> -			drm_crtc_send_vblank_event(crtc, event);
> +static const struct drm_plane_helper_funcs imx_lcdc_plane_helper_funcs = {
> +	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
> +	.atomic_check	= imx_lcdc_plane_helper_atomic_check,
> +	.atomic_update	= imx_lcdc_plane_helper_atomic_update,
> +};
>   
> -		spin_unlock_irq(&crtc->dev->event_lock);
> -	}
> +static const struct drm_plane_funcs imx_lcdc_plane_funcs = {
> +	.update_plane		= drm_atomic_helper_update_plane,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.destroy		= drm_plane_cleanup,
> +	.reset			= drm_atomic_helper_plane_reset,
> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +};
> +
> +static void imx_lcdc_crtc_helper_atomic_flush(struct drm_crtc *crtc,
> +					      struct drm_atomic_commit *commit)
> +{
> +	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
> +	struct drm_pending_vblank_event *event = new_crtc_state->event;
> +
> +	if (!event)
> +		return;
> +
> +	new_crtc_state->event = NULL;
> +
> +	spin_lock_irq(&crtc->dev->event_lock);
> +	if (new_crtc_state->active && drm_crtc_vblank_get(crtc) == 0)
> +		drm_crtc_arm_vblank_event(crtc, event);
> +	else
> +		drm_crtc_send_vblank_event(crtc, event);
> +	spin_unlock_irq(&crtc->dev->event_lock);
>   }

Please use drm_crtc_vblank_atomic_flush(). [1]

[1] 
https://elixir.bootlin.com/linux/v7.2.5/source/drivers/gpu/drm/drm_vblank_helper.c#L51

Best regards
Thomas

>   
> -static const struct drm_simple_display_pipe_funcs imx_lcdc_pipe_funcs = {
> -	.enable = imx_lcdc_pipe_enable,
> -	.disable = imx_lcdc_pipe_disable,
> -	.check = imx_lcdc_pipe_check,
> -	.update = imx_lcdc_pipe_update,
> +static const struct drm_crtc_helper_funcs imx_lcdc_crtc_helper_funcs = {
> +	.atomic_check	= imx_lcdc_crtc_helper_atomic_check,
> +	.atomic_enable	= imx_lcdc_crtc_helper_atomic_enable,
> +	.atomic_disable	= imx_lcdc_crtc_helper_atomic_disable,
> +	.atomic_flush	= imx_lcdc_crtc_helper_atomic_flush,
> +};
> +
> +static int imx_lcdc_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	return 0;
> +}
> +
> +static void imx_lcdc_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +}
> +
> +static const struct drm_crtc_funcs imx_lcdc_crtc_funcs = {
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +	.enable_vblank		= imx_lcdc_crtc_enable_vblank,
> +	.disable_vblank		= imx_lcdc_crtc_disable_vblank,
> +};
> +
> +static const struct drm_encoder_funcs imx_lcdc_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
>   };
>   
>   static const struct drm_mode_config_funcs imx_lcdc_mode_config_funcs = {
> @@ -370,7 +466,7 @@ MODULE_DEVICE_TABLE(of, imx_lcdc_of_dev_id);
>   static irqreturn_t imx_lcdc_irq_handler(int irq, void *arg)
>   {
>   	struct imx_lcdc *lcdc = arg;
> -	struct drm_crtc *crtc = &lcdc->pipe.crtc;
> +	struct drm_crtc *crtc = &lcdc->crtc;
>   	unsigned int status;
>   
>   	status = readl(lcdc->base + IMX21LCDC_LISR);
> @@ -388,6 +484,9 @@ static int imx_lcdc_probe(struct platform_device *pdev)
>   	struct imx_lcdc *lcdc;
>   	struct drm_device *drm;
>   	struct drm_bridge *bridge;
> +	struct drm_plane *plane;
> +	struct drm_crtc *crtc;
> +	struct drm_encoder *encoder;
>   	int irq;
>   	int ret;
>   	struct device *dev = &pdev->dev;
> @@ -429,23 +528,40 @@ static int imx_lcdc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Cannot initialize mode configuration structure\n");
>   
> -	/* CRTC, Plane, Encoder */
> -	ret = drm_simple_display_pipe_init(drm, &lcdc->pipe,
> -					   &imx_lcdc_pipe_funcs,
> -					   imx_lcdc_formats,
> -					   ARRAY_SIZE(imx_lcdc_formats), NULL, NULL);
> +	plane = &lcdc->plane;
> +	ret = drm_universal_plane_init(drm, plane, 0,
> +				       &imx_lcdc_plane_funcs,
> +				       imx_lcdc_formats,
> +				       ARRAY_SIZE(imx_lcdc_formats),
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(drm->dev, ret, "Cannot initialize primary plane\n");
> +	drm_plane_helper_add(plane, &imx_lcdc_plane_helper_funcs);
> +
> +	crtc = &lcdc->crtc;
> +	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
> +					&imx_lcdc_crtc_funcs, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(drm->dev, ret, "Cannot initialize CRTC\n");
> +	drm_crtc_helper_add(crtc, &imx_lcdc_crtc_helper_funcs);
> +
> +	encoder = &lcdc->encoder;
> +	ret = drm_encoder_init(drm, encoder, &imx_lcdc_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
>   	if (ret < 0)
> -		return dev_err_probe(drm->dev, ret, "Cannot setup simple display pipe\n");
> +		return dev_err_probe(drm->dev, ret, "Cannot initialize encoder\n");
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
>   
>   	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
>   	if (ret < 0)
>   		return dev_err_probe(drm->dev, ret, "Failed to initialize vblank\n");
>   
> -	ret = drm_bridge_attach(&lcdc->pipe.encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>   	if (ret)
>   		return dev_err_probe(drm->dev, ret, "Cannot attach bridge\n");
>   
> -	lcdc->connector = drm_bridge_connector_init(drm, &lcdc->pipe.encoder);
> +	lcdc->connector = drm_bridge_connector_init(drm, encoder);
>   	if (IS_ERR(lcdc->connector))
>   		return dev_err_probe(drm->dev, PTR_ERR(lcdc->connector), "Cannot init bridge connector\n");
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


