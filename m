Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FC4C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B3310F90C;
	Fri, 10 Jul 2026 13:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vPVHMb6h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7N2wDKgc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ctrG4FY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YPjMLEWo";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EFF10F909
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:57:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 690C4764D9;
 Fri, 10 Jul 2026 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783691837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZoaLlc5L2AtThj+5ATpCKat2gJZiHa8ev3JZeI5H2Do=;
 b=vPVHMb6h2Zp8C6LFDacHsVcWAsrnZWtLDIjLcoZaJ2kZ/2xKA5wTK5xXRIWRWORXjYw4NF
 kWuXoJgPL9KagI0tvCJgbNnLGUdoa2ocHVLhEux7Yrlb3I1IPgG/yxv/aPPsWZI01AY6G2
 UHqAUD/bIKIR0eVOB9p+YTa+3WsQ9gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783691837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZoaLlc5L2AtThj+5ATpCKat2gJZiHa8ev3JZeI5H2Do=;
 b=7N2wDKgcgXociidi3PrXwbuXiv8d+ZEZB1VVflVxJDKX0jt12ePsXPed8oKCmmFN7E6kqX
 Yj4XY5fHcqCKiEAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1ctrG4FY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YPjMLEWo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783691836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZoaLlc5L2AtThj+5ATpCKat2gJZiHa8ev3JZeI5H2Do=;
 b=1ctrG4FYvpvbKICNWe7y8fh/5YL1T5w4SqNB+96cf7mLNhxpkiCfO8sXrqUKE9Aw4vOWwn
 FEwn2Tz7NfKeEQ3LR16FEKixOZxbDcBClE13AxwrCCZIcK6qj0HBt4lsZyDgVRZIHGKqqr
 tAIHuZh3TS0QcosC36VHkhx6UZQxd0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783691836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZoaLlc5L2AtThj+5ATpCKat2gJZiHa8ev3JZeI5H2Do=;
 b=YPjMLEWosbhvnYO5/V6TQ9/65j6x1NEjFEJOQ504AIRSsHYe7nL5ZRNIyQbPyjzosAqkTN
 bWxkHjjoy80gAOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B658779BD;
 Fri, 10 Jul 2026 13:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nZdcCTz6UGrAJwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 13:57:16 +0000
Message-ID: <483982be-d9b5-4202-82fa-7700a1e45e1a@suse.de>
Date: Fri, 10 Jul 2026 15:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gma500: Remove dependency on DRM simple helpers
To: Diogo Silva <diogompaissilva@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260623-gma-drm-simple-v1-1-c404a5e62aab@gmail.com>
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
In-Reply-To: <20260623-gma-drm-simple-v1-1-c404a5e62aab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 690C4764D9
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email, suse.de:mid,
 suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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



Am 23.06.26 um 21:38 schrieb Diogo Silva:
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the dependency on drm simple helpers from gma500
> DRM drivers.

Looks all good.

>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/gma500/cdv_intel_crt.c  |  9 +++++++--
>   drivers/gpu/drm/gma500/cdv_intel_dp.c   |  9 +++++++--
>   drivers/gpu/drm/gma500/cdv_intel_hdmi.c | 10 +++++++---
>   drivers/gpu/drm/gma500/cdv_intel_lvds.c |  9 +++++++--
>   drivers/gpu/drm/gma500/oaktrail_hdmi.c  |  9 +++++++--
>   drivers/gpu/drm/gma500/oaktrail_lvds.c  |  9 +++++++--
>   drivers/gpu/drm/gma500/psb_intel_lvds.c |  9 +++++++--
>   7 files changed, 49 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
> index 342a57c82846..e51a965ddeb8 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
> @@ -29,8 +29,8 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "cdv_device.h"
>   #include "intel_bios.h"
> @@ -217,6 +217,10 @@ static int cdv_intel_crt_set_property(struct drm_connector *connector,
>    * Routines for controlling stuff on the analog port
>    */
>   
> +static const struct drm_encoder_funcs cdv_intel_crt_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs cdv_intel_crt_helper_funcs = {
>   	.dpms = cdv_intel_crt_dpms,
>   	.prepare = gma_encoder_prepare,
> @@ -275,7 +279,8 @@ void cdv_intel_crt_init(struct drm_device *dev,
>   		goto err_ddc_destroy;
>   
>   	encoder = &gma_encoder->base;
> -	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
> +	ret = drm_encoder_init(dev, encoder, &cdv_intel_crt_funcs,
> +			       DRM_MODE_ENCODER_DAC, NULL);
>   	if (ret)
>   		goto err_connector_cleanup;
>   
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index fbed35cf7603..5bcbb2d2b837 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -33,9 +33,9 @@
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "gma_display.h"
>   #include "psb_drv.h"
> @@ -1872,6 +1872,10 @@ cdv_intel_dp_destroy(struct drm_connector *connector)
>   	kfree(gma_connector);
>   }
>   
> +static const struct drm_encoder_funcs cdv_intel_dp_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs cdv_intel_dp_helper_funcs = {
>   	.dpms = cdv_intel_dp_dpms,
>   	.mode_fixup = cdv_intel_dp_mode_fixup,
> @@ -1970,7 +1974,8 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   	encoder = &gma_encoder->base;
>   
>   	drm_connector_init(dev, connector, &cdv_intel_dp_connector_funcs, type);
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(dev, encoder, &cdv_intel_dp_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);
>   
>   	gma_connector_attach_encoder(gma_connector, gma_encoder);
>   
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
> index ce7850647778..757ff9408250 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
> @@ -30,9 +30,9 @@
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "cdv_device.h"
>   #include "psb_drv.h"
> @@ -251,6 +251,10 @@ static void cdv_hdmi_destroy(struct drm_connector *connector)
>   	kfree(gma_connector);
>   }
>   
> +static const struct drm_encoder_funcs cdv_hdmi_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs cdv_hdmi_helper_funcs = {
>   	.dpms = cdv_hdmi_dpms,
>   	.prepare = gma_encoder_prepare,
> @@ -329,8 +333,8 @@ void cdv_hdmi_init(struct drm_device *dev,
>   	if (ret)
>   		goto err_ddc_destroy;
>   
> -	ret = drm_simple_encoder_init(dev, &gma_encoder->base,
> -				      DRM_MODE_ENCODER_TMDS);
> +	ret = drm_encoder_init(dev, &gma_encoder->base, &cdv_hdmi_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
>   	if (ret)
>   		goto err_connector_cleanup;
>   
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> index d7fd9a783cde..336ab411d699 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> @@ -13,9 +13,9 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "cdv_device.h"
>   #include "intel_bios.h"
> @@ -394,6 +394,10 @@ static int cdv_intel_lvds_set_property(struct drm_connector *connector,
>   	return 0;
>   }
>   
> +static const struct drm_encoder_funcs cdv_intel_lvds_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs
>   					cdv_intel_lvds_helper_funcs = {
>   	.dpms = cdv_intel_lvds_encoder_dpms,
> @@ -535,7 +539,8 @@ void cdv_intel_lvds_init(struct drm_device *dev,
>   	if (ret)
>   		goto err_destroy_ddc;
>   
> -	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
> +	ret = drm_encoder_init(dev, encoder, &cdv_intel_lvds_funcs,
> +			       DRM_MODE_ENCODER_LVDS, NULL);
>   	if (ret)
>   		goto err_connector_cleanup;
>   
> diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> index 403d21cbb3a2..5a6132176086 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> @@ -29,9 +29,9 @@
>   #include <drm/drm.h>
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "psb_drv.h"
>   #include "psb_intel_drv.h"
> @@ -605,6 +605,10 @@ static void oaktrail_hdmi_destroy(struct drm_connector *connector)
>   	return;
>   }
>   
> +static const struct drm_encoder_funcs oaktrail_hdmi_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs oaktrail_hdmi_helper_funcs = {
>   	.dpms = oaktrail_hdmi_dpms,
>   	.prepare = gma_encoder_prepare,
> @@ -648,7 +652,8 @@ void oaktrail_hdmi_init(struct drm_device *dev,
>   			   &oaktrail_hdmi_connector_funcs,
>   			   DRM_MODE_CONNECTOR_DVID);
>   
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(dev, encoder, &oaktrail_hdmi_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);
>   
>   	gma_connector_attach_encoder(gma_connector, gma_encoder);
>   
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> index e194d0cce067..425796d8d6c3 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> @@ -12,9 +12,9 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "intel_bios.h"
>   #include "power.h"
> @@ -202,6 +202,10 @@ static void oaktrail_lvds_commit(struct drm_encoder *encoder)
>   	oaktrail_lvds_set_power(dev, gma_encoder, true);
>   }
>   
> +static const struct drm_encoder_funcs oaktrail_lvds_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs oaktrail_lvds_helper_funcs = {
>   	.dpms = oaktrail_lvds_dpms,
>   	.mode_fixup = psb_intel_lvds_mode_fixup,
> @@ -319,7 +323,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
>   	if (ret)
>   		goto err_free_connector;
>   
> -	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
> +	ret = drm_encoder_init(dev, encoder, &oaktrail_lvds_funcs,
> +			       DRM_MODE_ENCODER_LVDS, NULL);
>   	if (ret)
>   		goto err_connector_cleanup;
>   
> diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
> index 2ca164b21293..cd882786d946 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
> @@ -12,9 +12,9 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "intel_bios.h"
>   #include "power.h"
> @@ -593,6 +593,10 @@ int psb_intel_lvds_set_property(struct drm_connector *connector,
>   	return -1;
>   }
>   
> +static const struct drm_encoder_funcs psb_intel_lvds_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs psb_intel_lvds_helper_funcs = {
>   	.dpms = psb_intel_lvds_encoder_dpms,
>   	.mode_fixup = psb_intel_lvds_mode_fixup,
> @@ -679,7 +683,8 @@ void psb_intel_lvds_init(struct drm_device *dev,
>   	if (ret)
>   		goto err_ddc_destroy;
>   
> -	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
> +	ret = drm_encoder_init(dev, encoder, &psb_intel_lvds_funcs,
> +			       DRM_MODE_ENCODER_LVDS, NULL);
>   	if (ret)
>   		goto err_connector_cleanup;
>   
>
> ---
> base-commit: 60326b17f877e12846167bf8ef83680b9875218a
> change-id: 20260623-gma-drm-simple-c5e63f74b160
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


