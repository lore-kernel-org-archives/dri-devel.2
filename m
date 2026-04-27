Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB8FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D817C10E5C1;
	Mon, 27 Apr 2026 07:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="IbNRnytb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jr5bnEwm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IbNRnytb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jr5bnEwm";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D857310E5C1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:26:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7F35BD0A;
 Mon, 27 Apr 2026 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777274772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S17iJ1N7Cx0zpeL0ivtha1NSe3KDyPDn4vlrj4J54Q8=;
 b=IbNRnytbG4WmMD3E7byN4m97Jr7shH9mjkUAXZ4zSAB8jUVN9mFzGOZxyDJX3gPmgBnPw1
 R/+5paoUBUaKYG6gfe3xYeDkDu7/S7VL/iM+ZqwXoSBDvjom4q12isUOzaCuzNY75Fw73u
 eE4xslhgzyMs042aaZM2mPDlvqiaVr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777274772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S17iJ1N7Cx0zpeL0ivtha1NSe3KDyPDn4vlrj4J54Q8=;
 b=jr5bnEwmWrN6NaYNaV+QkXy8jHW5LmzvTtqepRxwnHk24aicixlZc6kUQTXqoezFbqxttA
 ds/+Cv2ex/nWleAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IbNRnytb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jr5bnEwm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777274772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S17iJ1N7Cx0zpeL0ivtha1NSe3KDyPDn4vlrj4J54Q8=;
 b=IbNRnytbG4WmMD3E7byN4m97Jr7shH9mjkUAXZ4zSAB8jUVN9mFzGOZxyDJX3gPmgBnPw1
 R/+5paoUBUaKYG6gfe3xYeDkDu7/S7VL/iM+ZqwXoSBDvjom4q12isUOzaCuzNY75Fw73u
 eE4xslhgzyMs042aaZM2mPDlvqiaVr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777274772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S17iJ1N7Cx0zpeL0ivtha1NSe3KDyPDn4vlrj4J54Q8=;
 b=jr5bnEwmWrN6NaYNaV+QkXy8jHW5LmzvTtqepRxwnHk24aicixlZc6kUQTXqoezFbqxttA
 ds/+Cv2ex/nWleAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA17D593B0;
 Mon, 27 Apr 2026 07:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8G6RK5MP72nwVQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 07:26:11 +0000
Message-ID: <e51bb7e2-0d57-42a1-be53-6560cebf2df6@suse.de>
Date: Mon, 27 Apr 2026 09:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 3/4] drm/hisilicon/hibmc: move
 display contrl config to hibmc_probe()
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260423063233.1267631-1-shiyongbang@huawei.com>
 <20260423063233.1267631-4-shiyongbang@huawei.com>
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
In-Reply-To: <20260423063233.1267631-4-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[hisilicon.com:email,suse.de:dkim,suse.de:mid,suse.com:url,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[17];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, huawei.com:email,
 suse.com:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2D7F35BD0A
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

Am 23.04.26 um 08:32 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> If there's no VGA output, this encoder modeset won't be called, which
> will cause displaying data from GPU being cut off. It's actually a
> common display config for DP and VGA, so move the vdac encoder modeset
> to driver load stage.
>
> Fixes: 5294967f4ae4 ("drm/hisilicon/hibmc: Add support for VDAC")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>      be given in public.
>    - add 'drm-misc-fixes' in subject prefix.
> ---
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 14 ++++++++++++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 22 -------------------
>   2 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index d409efc34215..f8ab471f92e7 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -217,6 +217,18 @@ void hibmc_set_current_gate(struct hibmc_drm_private *priv, unsigned int gate)
>   	writel(gate, mmio + gate_reg);
>   }
>   
> +static void hibmc_display_ctrl(struct hibmc_drm_private *priv)
> +{
> +	u32 reg;
> +
> +	reg = readl(priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
> +	reg |= HIBMC_DISPLAY_CONTROL_FPVDDEN(1);
> +	reg |= HIBMC_DISPLAY_CONTROL_PANELDATE(1);
> +	reg |= HIBMC_DISPLAY_CONTROL_FPEN(1);
> +	reg |= HIBMC_DISPLAY_CONTROL_VBIASEN(1);

That might be stupid question: IDK what these bits mean, but the FPVDDEN 
and FPEN sound like they enable something. If you do this 
unconditionally in HW init, does it prevent power saving?  And is the 
system goes through suspend/resume,  does it need to be re-enabled?

My gut feeling would be to put this code into the CRTC.

Best regards
Thomas

> +	writel(reg, priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
> +}
> +
>   static void hibmc_hw_config(struct hibmc_drm_private *priv)
>   {
>   	u32 reg;
> @@ -248,6 +260,8 @@ static void hibmc_hw_config(struct hibmc_drm_private *priv)
>   	reg |= HIBMC_MSCCTL_LOCALMEM_RESET(1);
>   
>   	writel(reg, priv->mmio + HIBMC_MISC_CTRL);
> +
> +	hibmc_display_ctrl(priv);
>   }
>   
>   static int hibmc_hw_map(struct hibmc_drm_private *priv)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index dc40018dbd21..9d924740c110 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -86,26 +86,6 @@ static const struct drm_connector_funcs hibmc_connector_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
> -static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
> -				   struct drm_display_mode *mode,
> -				   struct drm_display_mode *adj_mode)
> -{
> -	u32 reg;
> -	struct drm_device *dev = encoder->dev;
> -	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> -
> -	reg = readl(priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
> -	reg |= HIBMC_DISPLAY_CONTROL_FPVDDEN(1);
> -	reg |= HIBMC_DISPLAY_CONTROL_PANELDATE(1);
> -	reg |= HIBMC_DISPLAY_CONTROL_FPEN(1);
> -	reg |= HIBMC_DISPLAY_CONTROL_VBIASEN(1);
> -	writel(reg, priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
> -}
> -
> -static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
> -	.mode_set = hibmc_encoder_mode_set,
> -};
> -
>   int hibmc_vdac_init(struct hibmc_drm_private *priv)
>   {
>   	struct drm_device *dev = &priv->dev;
> @@ -128,8 +108,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>   		goto err;
>   	}
>   
> -	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
> -
>   	ret = drm_connector_init_with_ddc(dev, connector,
>   					  &hibmc_connector_funcs,
>   					  DRM_MODE_CONNECTOR_VGA,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


