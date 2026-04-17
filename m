Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE73F8E4BC
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E11C10E07D;
	Fri, 17 Apr 2026 07:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Gtk/tTYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="913YzevT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KkTj4Owh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="njvlYx5p";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6086610E07D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:55:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E860D6A992;
 Fri, 17 Apr 2026 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776412499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rMJ89j4lZ3N+QyxWsfXEJr/ZM+8yzljB3OTk7alDZag=;
 b=Gtk/tTYpG6ESgdSghRgTvt1HYEXd36x/2RDcmzVg1DCTJaKk4xkj2Pyk9V6Y3NRmfw4a+3
 jRaoye/tt3QQx1FZFYMyxy20lNYULi2tJl17s82Pi3TWCr8Ywm35XRnS+YJB8h9I4jJKBZ
 x65LBUhsgQ4hG2ssDCFYvdsc/NjIAlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776412499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rMJ89j4lZ3N+QyxWsfXEJr/ZM+8yzljB3OTk7alDZag=;
 b=913YzevTdIBVVHjYMZkn/LqpK8PXq6RuhQEx9IM999uvxtej6Rls4KRZCq5MaJxWqRBC+a
 xH9FdRMMu/QauEDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KkTj4Owh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=njvlYx5p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776412498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rMJ89j4lZ3N+QyxWsfXEJr/ZM+8yzljB3OTk7alDZag=;
 b=KkTj4OwhCY8vZFAgOHDQ3AY87jBtYYDQlZAWjzVbAhUNTouPVvsEkYZOwEAGNnG0mrAIHA
 FnP+XkU5+DoX3Xd0zUNvhY0ZQkSczPNddAgDA6Zw4xLS7N2qgKw3vTt1nTSC+DZ0gEH74d
 3wO4EaX2EI+PEGRG2gr0FIvOnWE4ZBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776412498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rMJ89j4lZ3N+QyxWsfXEJr/ZM+8yzljB3OTk7alDZag=;
 b=njvlYx5pTtlxpw4ul24tjPFNHTKf36Kccmqgv333iaz4FHZrN/PJc2DnsXsnVysQ/6YHIl
 B6+N4VZygK0yUpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72B35593AE;
 Fri, 17 Apr 2026 07:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N9OyGlLn4WkeHAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 17 Apr 2026 07:54:58 +0000
Message-ID: <cb1f80ec-20af-4e59-a32e-b1e61e66af0d@suse.de>
Date: Fri, 17 Apr 2026 09:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v4 2/4] drm/hisilicon/hibmc: fix no
 showing when no connectors connected
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260416092455.1990632-1-shiyongbang@huawei.com>
 <20260416092455.1990632-3-shiyongbang@huawei.com>
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
In-Reply-To: <20260416092455.1990632-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[17];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 huawei.com:email, suse.com:url]
X-Rspamd-Queue-Id: E860D6A992
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

Am 16.04.26 um 11:24 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> Our chip support KVM over IP feature, so hibmc driver need to support
> displaying without any connectors plugged in. If no connectors are
> connected, the vdac connector status should be set to 'connected' to
> ensure proper KVM display functionality. Additionally, for
> previous-generation products that may lack hardware link support and
> thus cannot detect the monitor, the same approach should be applied
> to ensure VGA display functionality. Add phys_state in the struct of
> dp and vdac to check all physical outputs.
>
> For get_modes: using BMC modes for connector if no display is attached to
> phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes,
> because KVM doesn't provide EDID reads.
>
> Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Closes: https://lore.kernel.org/all/0eb5c509-2724-4c57-87ad-74e4270d5a5a@suse.de/

The bug I reported is that the DDC does not return an EDID at all. 
Therefore hibmc fails to detect the connected VGA monitor. AFAIU that's 
not what is being fixed in this patch.

> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
[...]
> +static int hibmc_vdac_detect(struct drm_connector *connector,
> +			     struct drm_modeset_acquire_ctx *ctx,
> +			     bool force)
> +{
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> +
> +	vdac->phys_state = drm_connector_helper_detect_from_ddc(connector,
> +								ctx, force);
> +
> +	/* If the DP connectors are disconnected, the hibmc_vdac_detect function
> +	 * must return a connected state to ensure KVM display functionality.
> +	 * Additionally, for previous-generation products that may lack hardware
> +	 * link support and thus cannot detect the monitor, hibmc_vdac_detect
> +	 * should also return a connected state.
> +	 */
> +	if (priv->dp.phys_state != connector_status_connected)
> +		return connector_status_connected;
> +
> +	return vdac->phys_state;

This will break user-space compositors if DP and VGA are connected at 
the same time. I know, because we had such logic in ast and mgag200.

Today's compositors expect a single encoder-connector pair on each CRTC. 
That's what most contemporary hardware provides.  But the server 
chipsets usually come with one a single CRTC and multiple connectors 
attached to it.  Compositors fail to configure that. When we had this in 
ast and mgag200, Gnome would display garbage to the screen and 
mode-setting would fail. The bug report is at [1].

In ast and mgag200, only one connector would be installed on a single 
system. So we could avoid the problem. It looks like that this is not an 
option with hibmc. VGA always seems to be present and DP seems optional. 
I would advice to only report one of the connectors as 'connected' if 
both are installed on a system.

You also need to increment the connector's epoch_counter if the physical 
status changed. Doing this will trigger DRM clients to re-read the 
connector state and reconfigure display.

Something like that

dp_detect()
{
     dp.phys_state = detect_from_hw()

     if (dp.phys_state changed)
         ++epoch_counter
     return connected
}

vdac_detect()
{
     if (dp.phys_state == connected)
         return disconnected

     vdac.phys_state = detect_from_hw()

     if (vdac.phys_state changed)
         ++epoch_counter
     return connected
}

This handles the KVM in each connector's helper. The ast driver is 
probably the best reference for the current logic. See [2].

[1] https://gitlab.gnome.org/GNOME/mutter/-/issues/3858
[2] 
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/ast/ast_vga.c#L47

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


