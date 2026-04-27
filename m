Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA55FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D063110E5BC;
	Mon, 27 Apr 2026 07:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="B3wGxsVx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E0tk8eQw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mkoxrng5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ko+SkY8A";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D52910E5BC
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:20:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2DFB5BD69;
 Mon, 27 Apr 2026 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777274409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=daZMSAY/9pQ3vP7VgeTX3PmOQp6aIB0U+G72ggcx2JA=;
 b=B3wGxsVx7ZpJ2vyplTLXxv2taJ1zOmpme4dRaHfpqraDer8qK6vDS5vRyfglItid4skVMo
 ATaG676HZIUn3UOgO1E9K4P/3IT6V2yG+/Wn+haNYMyWzkpu+yjnbMWTqpYh+mEfRtfphX
 8LepUZbqajjfHCtqwNaW3T2iLyadh2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777274409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=daZMSAY/9pQ3vP7VgeTX3PmOQp6aIB0U+G72ggcx2JA=;
 b=E0tk8eQwtkw4HPGG214x4AFjPYBHEy6asLfbqflpzE/8/ch9FoLyKlTLcbUhPT9Gsrr31p
 B8g4qF0JBpMIr2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777274408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=daZMSAY/9pQ3vP7VgeTX3PmOQp6aIB0U+G72ggcx2JA=;
 b=mkoxrng5DORYkgJIPUJLjXj/XkSurgEIBWQcXvSLn4w612X50obJtbUxmyburLk+UqqS+6
 vZU+zswsl85auJ/VY64qIIKihOOMjP+tx9aBe5IeuXX+DIdU57PQQysQc3fzleLtUmdNn9
 LTsX34dmdHOCLocHw9UbDnJPF2aSgT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777274408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=daZMSAY/9pQ3vP7VgeTX3PmOQp6aIB0U+G72ggcx2JA=;
 b=Ko+SkY8AqhB/73uYzegWuGoJ7ms5X/1ZwRp3onVFBfjHKD1wv8rW4qgdEWqvRIGQP71mBE
 n6MhpITcuGjtUQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B848593B0;
 Mon, 27 Apr 2026 07:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7hZQGCgO72nWTwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 07:20:08 +0000
Message-ID: <27864583-4211-4553-bdc0-42dadd25d212@suse.de>
Date: Mon, 27 Apr 2026 09:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 2/4] drm/hisilicon/hibmc: fix no
 showing when no connectors connected
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260423063233.1267631-1-shiyongbang@huawei.com>
 <20260423063233.1267631-3-shiyongbang@huawei.com>
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
In-Reply-To: <20260423063233.1267631-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[17];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[bootlin.com:url,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, bootlin.com:url, suse.com:url,
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

sorry for not getting to the review earlier. See my comments below.


Am 23.04.26 um 08:32 schrieb Yongbang Shi:
[...]
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 31316fe1ea8d..dfaeabd05d46 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -55,6 +55,7 @@ struct hibmc_dp {
>   	struct drm_dp_aux aux;
>   	struct hibmc_dp_cbar_cfg cfg;
>   	u32 irq_status;
> +	int phys_state;

I think the correct term is 'status' instead of 'state'.

>   };
>   
>   int hibmc_dp_hw_init(struct hibmc_dp *dp);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 35dff7bfbf76..8fe2eb51a0b3 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -61,27 +61,38 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>   {
>   	struct hibmc_dp *dp = to_hibmc_dp(connector);
>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> -	int ret;
> +	int ret = connector_status_disconnected;
>   
>   	if (dp->irq_status) {
> -		if (dp_dev->hpd_status != HIBMC_HPD_IN)
> -			return connector_status_disconnected;
> +		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
> +			ret = connector_status_disconnected;
> +			goto exit;
> +		}
>   	}
>   
> -	if (!hibmc_dp_get_dpcd(dp_dev))
> -		return connector_status_disconnected;
> +	if (!hibmc_dp_get_dpcd(dp_dev)) {
> +		ret = connector_status_disconnected;
> +		goto exit;
> +	}
>   
> -	if (!dp_dev->is_branch)
> -		return connector_status_connected;
> +	if (!dp_dev->is_branch) {
> +		ret = connector_status_connected;
> +		goto exit;
> +	}
>   
>   	if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
>   	    dp_dev->downstream_ports[0] & DP_DS_PORT_HPD) {
>   		ret = drm_dp_read_sink_count(dp_dev->aux);
> -		if (ret > 0)
> -			return connector_status_connected;
> +		if (ret > 0) {
> +			ret = connector_status_connected;
> +			goto exit;
> +		}
>   	}
>   
> -	return connector_status_disconnected;
> +exit:
> +	dp->phys_state = ret;
> +
> +	return ret;
>   }
>   
>   static int hibmc_dp_mode_valid(struct drm_connector *connector,
> @@ -243,5 +254,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>   
>   	connector->polled = DRM_CONNECTOR_POLL_HPD;
>   
> +	dp->phys_state = connector_status_disconnected;
> +
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 289304500ab0..d409efc34215 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -24,6 +24,7 @@
>   #include <drm/drm_managed.h>
>   #include <drm/drm_module.h>
>   #include <drm/drm_vblank.h>
> +#include <drm/drm_probe_helper.h>
>   
>   #include "hibmc_drm_drv.h"
>   #include "hibmc_drm_regs.h"
> @@ -162,6 +163,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>   	drm_for_each_encoder(encoder, dev)
>   		encoder->possible_clones = clone_mask;
>   
> +	drm_kms_helper_poll_init(dev);

So I think this is too early. This function will periodically poll 
connector, but they may have not been set up fully. Rather call this 
function after drm_mode_config_reset() in hibmc_load().

> +
>   	return 0;
>   }
>   
> @@ -279,6 +282,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
>   
>   static void hibmc_unload(struct drm_device *dev)
>   {
> +	drm_kms_helper_poll_fini(dev);

Init with drmm_kms_helper_poll_init() [1] and avoid this clean-up call 
entirely.  In DRM we generally prefer managed init/cleanup over manual one.

[1] 
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/drm_probe_helper.c#L963

>   	drm_atomic_helper_shutdown(dev);
>   }
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index ca8502e2760c..6abb49b5107b 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -31,6 +31,7 @@ struct hibmc_vdac {
>   	struct drm_connector connector;
>   	struct i2c_adapter adapter;
>   	struct i2c_algo_bit_data bit_data;
> +	int phys_state;

'phys_status' would again be more appropriate.

>   };
>   
>   struct hibmc_drm_private {
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 841e81f47b68..dc40018dbd21 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -25,27 +25,20 @@
>   static int hibmc_connector_get_modes(struct drm_connector *connector)
>   {
>   	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> -	const struct drm_edid *drm_edid;
> -	int count;
> +	int count = 0;
>   
> -	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
> +	if (vdac->phys_state == connector_status_connected)
> +		count = drm_connector_helper_get_modes(connector);
>   
> -	drm_edid_connector_update(connector, drm_edid);
> -
> -	if (drm_edid) {
> -		count = drm_edid_connector_add_modes(connector);
> -		if (count)
> -			goto out;
> -	}
> +	if (count > 0)
> +		return count;

There's a problem with the overall logic here: if the physical status is 
'connected' and the helper could not retrieve any modes, the helper 
should return 0 here. Then the DRM helpers do the right thing with 
setting up a few modes or an EDID override as a fallback. See [2]. For 
example, on my broken test system, I'd be able to provide my display's 
EDID and get the correct output.

[2] 
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/drm_probe_helper.c#L436

Any code below is BMC setup and should run in an else branch, just like 
in ast.


>   
> +	drm_edid_connector_update(connector, NULL);
>   	count = drm_add_modes_noedid(connector,
>   				     connector->dev->mode_config.max_width,
>   				     connector->dev->mode_config.max_height);
>   	drm_set_preferred_mode(connector, 1024, 768);
>   
> -out:
> -	drm_edid_free(drm_edid);
> -
>   	return count;
>   }
>   
> @@ -57,10 +50,32 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>   	drm_connector_cleanup(connector);
>   }
>   
> +static int hibmc_vdac_detect(struct drm_connector *connector,
> +			     struct drm_modeset_acquire_ctx *ctx,
> +			     bool force)
> +{
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
> +	int state = drm_connector_helper_detect_from_ddc(connector, ctx,
> +							 force);

'state' -> 'status'

> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> +
> +	if (priv->dp.phys_state == connector_status_connected)
> +		return vdac->phys_state = state;

Please only one statement per line. First assign, then return.

> +
> +	if (state != vdac->phys_state)
> +		++connector->epoch_counter;
> +	vdac->phys_state = state;
> +
> +	/* If both the DP and VDAC physical states are disconnected,
> +	 * the "connected" status is returned to support KVM display.
> +	 */
> +	return connector_status_connected;

I haven't tried, but I think this should also resolve the problems on my 
test systems. Great, thanks a lot! I might just get default resolutions 
for now, but that's OK.

Best regards
Thomas

> +}
> +
>   static const struct drm_connector_helper_funcs
>   	hibmc_connector_helper_funcs = {
>   	.get_modes = hibmc_connector_get_modes,
> -	.detect_ctx = drm_connector_helper_detect_from_ddc,
> +	.detect_ctx = hibmc_vdac_detect,
>   };
>   
>   static const struct drm_connector_funcs hibmc_connector_funcs = {
> @@ -130,6 +145,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>   
>   	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
>   
> +	vdac->phys_state = connector_status_connected;
> +
>   	return 0;
>   
>   err:

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


