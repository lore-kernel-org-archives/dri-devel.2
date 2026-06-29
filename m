Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D8210E074;
	Mon, 29 Jun 2026 12:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zXLm0XlT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xqpjUWqw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Diy9TOiq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ODsecyd1";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1304110E074
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:45:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75971730A7;
 Mon, 29 Jun 2026 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782737099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yg1MHm8zg4PWxYaWnjlgZJ2LL9g5gaSccr1pJ1ZtzBA=;
 b=zXLm0XlTCWs0LrQu3+Is6aCR4s7zcg/6Lr7MVjFKoAApWsWuxqgZZbSF3T81Z7iuxjUqgH
 K4XyYohfmgy61nMsqCNl2vnRqCn5uCkYEl+AqCzruDfyuLjry0gvQ9CPg4WZqTDOXJa8QR
 /dmHKLTbngEXoQhUnaCRWwfd1QXKs2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782737099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yg1MHm8zg4PWxYaWnjlgZJ2LL9g5gaSccr1pJ1ZtzBA=;
 b=xqpjUWqwsn7TLOoizyfE7Kzg9+xj1Tyv806NiIYhSpUX+vmEJjroSoPQyB0KzhC+DLSkP5
 PomtXmVbYrwKnhCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782737098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yg1MHm8zg4PWxYaWnjlgZJ2LL9g5gaSccr1pJ1ZtzBA=;
 b=Diy9TOiqMy16SoxLlQONpMdAgCcExNrK7PIUkRNNcGFdam+XmmRuQhWK3KsDD0D74oONQR
 T6tcZdXc+g4ZVOYNgl9s/3gvfnqK3SLhTQxsDvflP7v1AWZhA6Hjfci+ZgSFA8EpQHll9o
 alHR9LXO8ZIWrdmX6i2CpJp/EQ7xK80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782737098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yg1MHm8zg4PWxYaWnjlgZJ2LL9g5gaSccr1pJ1ZtzBA=;
 b=ODsecyd1aBVIMTVsWxyroSbRcGbulY6jHcWWfqNY4QlP2pXVx5kKajbJje0IVCLYT7LXk3
 HY7eeoqCa2SzMBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A4E7779A8;
 Mon, 29 Jun 2026 12:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vz2uBMpoQmrYJQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 29 Jun 2026 12:44:58 +0000
Message-ID: <439dcefd-87dd-46b2-9501-486e136c1b7b@suse.de>
Date: Mon, 29 Jun 2026 14:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
To: Thierry Reding <treding@nvidia.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, jesszhan0024@gmail.com, rayyan@ansari.sh,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-7-tzimmermann@suse.de> <akJg5_5UeNJQi8Zn@orome>
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
In-Reply-To: <akJg5_5UeNJQi8Zn@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linaro.org,ansari.sh,lists.freedesktop.org,lists.linux.dev];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid, suse.com:url, nvidia.com:email]
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

Am 29.06.26 um 14:27 schrieb Thierry Reding:
> On Thu, Jun 25, 2026 at 11:39:38AM +0200, Thomas Zimmermann wrote:
>> Implement drm_of_get_panel_orientation() to retrieve a panel's
>> rotation property as enum drm_panel_orientation. The code has
>> been taken from of_drm_get_panel_orientation(), so convert that
>> helper over. Callers of the old helper can be converted as well.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/drm_of.c    | 44 +++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_panel.c | 26 ++--------------------
>>   include/drm/drm_of.h        | 11 ++++++++++
>>   3 files changed, 57 insertions(+), 24 deletions(-)
> So you're effectively renaming of_drm_get_panel_orientation() to
> drm_of_get_panel_orientation(), while moving it to drm_of.c,  and then
> you keep of_drm_get_panel_orientation() as an alias.
>
> I don't understand the use of this. Maybe if we really need to move this
> out of drm_panel.c to make it more widely available, fine. Maybe we also
> want the drm_of_ prefix instead of of_drm_, also fine, I suppose. But in
> that case we should just go ahead and update all callers of the old
> helper and get rid of it while we're at it. No use in keeping around
> aliases/duplicates.

I'm all for it. i though this would be a different issue.

>
> I've attached a patch to do just that. Feel free to integrate it into
> the series, or we can apply after your series is merged.

Thanks.

Let me split of the  first 5 patches in series and merge them. They are 
the fixes and hardening patches and seem ready to be merged. I'll 
prepare a separate series for the panel orientation with your changes 
and it can go in separately. If we touch all the panel drivers, we 
should make sure that the panel maintainers get another chance of 
looking over it.

Best regards
Thomas

>
> Thierry
>
>  From 2aabb20fd3c8666fd9a8635e28cf6e398de7e717 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Mon, 29 Jun 2026 14:23:27 +0200
> Subject: [PATCH] drm/panel: Use drm_of_get_panel_orientation()
>
> The old of_drm_get_panel_orientation() function was replaced by the
> drm_of_get_panel_orientation() in the core DRM OF helpers. Replace all
> uses of the old helper and remove it.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/gpu/drm/drm_panel.c                   | 20 -------------------
>   .../drm/panel/panel-boe-th101mb31ig002-28a.c  |  2 +-
>   .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  2 +-
>   .../gpu/drm/panel/panel-chipwealth-ch13726a.c |  2 +-
>   drivers/gpu/drm/panel/panel-edp.c             |  2 +-
>   drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  2 +-
>   .../gpu/drm/panel/panel-focaltech-ota7290b.c  |  2 +-
>   drivers/gpu/drm/panel/panel-himax-hx83102.c   |  2 +-
>   drivers/gpu/drm/panel/panel-himax-hx8394.c    |  2 +-
>   .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c |  2 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  2 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  2 +-
>   .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  2 +-
>   drivers/gpu/drm/panel/panel-lvds.c            |  2 +-
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c |  2 +-
>   drivers/gpu/drm/panel/panel-simple.c          |  2 +-
>   drivers/gpu/drm/panel/panel-sitronix-st7701.c |  2 +-
>   drivers/gpu/drm/panel/panel-sitronix-st7703.c |  2 +-
>   .../gpu/drm/panel/panel-sitronix-st7789v.c    |  2 +-
>   include/drm/drm_panel.h                       |  8 --------
>   20 files changed, 18 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index eddd13a34c03..d7c6f4824b2d 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -492,26 +492,6 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
>   	return ERR_PTR(-EPROBE_DEFER);
>   }
>   EXPORT_SYMBOL(of_drm_find_panel);
> -
> -/**
> - * of_drm_get_panel_orientation - look up the orientation of the panel through
> - * the "rotation" binding from a device tree node
> - * @np: device tree node of the panel
> - * @orientation: orientation enum to be filled in
> - *
> - * Looks up the rotation of a panel in the device tree. The orientation of the
> - * panel is expressed as a property name "rotation" in the device tree. The
> - * rotation in the device tree is counter clockwise.
> - *
> - * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> - * rotation property doesn't exist. Return a negative error code on failure.
> - */
> -int of_drm_get_panel_orientation(const struct device_node *np,
> -				 enum drm_panel_orientation *orientation)
> -{
> -	return drm_of_get_panel_orientation(np, orientation);
> -}
> -EXPORT_SYMBOL(of_drm_get_panel_orientation);
>   #endif
>   
>   /* Find panel by fwnode. This should be identical to of_drm_find_panel(). */
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index 01b4458e55ad..6a77c2256fd5 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -380,7 +380,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
>   				     "Failed to get reset GPIO\n");
>   
> -	ret = of_drm_get_panel_orientation(dsi->dev.of_node,
> +	ret = drm_of_get_panel_orientation(dsi->dev.of_node,
>   					   &ctx->orientation);
>   	if (ret)
>   		return dev_err_probe(&dsi->dev, ret,
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 658ce64c71eb..8f2de17b8b2b 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1722,7 +1722,7 @@ static int boe_panel_add(struct boe_panel *boe)
>   
>   	boe->base.prepare_prev_first = true;
>   
> -	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
> +	err = drm_of_get_panel_orientation(dev->of_node, &boe->orientation);
>   	if (err < 0) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
>   		return err;
> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> index be76bc825c3f..437ee2294a9a 100644
> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> @@ -268,7 +268,7 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>   				     "Failed to get reset-gpios\n");
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
>   	if (ret < 0) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
>   		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index aa27d6cd932e..9af908811cf7 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -865,7 +865,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
>   		return dev_err_probe(dev, PTR_ERR(panel->enable_gpio),
>   				     "failed to request GPIO\n");
>   
> -	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
> +	err = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
>   	if (err) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
>   		return err;
> diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> index 1f177834d629..5565f7a63fd5 100644
> --- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> +++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> @@ -233,7 +233,7 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
>   		return ret;
>   	}
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
>   	if (ret < 0) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
>   		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> index ed02a8daf96f..b6c5bf3977ee 100644
> --- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> +++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> @@ -181,7 +181,7 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vdd),
>   					"Couldn't get our VDD supply\n");
>   
> -	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
>   	if (ret) {
>   		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
>   			dsi->dev.of_node, ret);
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> index d7e5664a5838..d61d68c1a2e7 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -1264,7 +1264,7 @@ static int hx83102_panel_add(struct hx83102 *ctx)
>   
>   	ctx->base.prepare_prev_first = true;
>   
> -	err = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	err = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
>   	if (err < 0)
>   		return dev_err_probe(dev, err, "failed to get orientation\n");
>   
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
> index bf80354567df..8c830f929d73 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
> @@ -992,7 +992,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>   				     "Failed to get reset gpio\n");
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
>   	if (ret < 0) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
>   		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
> index ecdbed8d4a3a..c9241796e1a3 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
> @@ -132,7 +132,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = ctx->desc->format;
>   	dsi->lanes = ctx->desc->lanes;
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get orientation\n");
>   
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index 0652cdb57d11..a13fe1bb3e46 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2571,7 +2571,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
>   				     "Couldn't get our reset GPIO\n");
>   
> -	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
>   	if (ret) {
>   		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
>   			dsi->dev.of_node, ret);
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> index 5f4e0d82ee67..613ecd1fbdd6 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -795,7 +795,7 @@ static int ili9882t_add(struct ili9882t *ili)
>   
>   	gpiod_set_value_cansleep(ili->enable_gpio, 0);
>   
> -	err = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
> +	err = drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
>   	if (err < 0) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
>   		return err;
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index f6b04de1182e..67ef9e0fea03 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -2992,7 +2992,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(jadard->vccio),
>   				"failed to get vccio regulator\n");
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &jadard->orientation);
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "failed to get orientation\n");
>   
> diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
> index 46b07f38559f..37f7498449ec 100644
> --- a/drivers/gpu/drm/panel/panel-lvds.c
> +++ b/drivers/gpu/drm/panel/panel-lvds.c
> @@ -126,7 +126,7 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
>   	struct device_node *np = lvds->dev->of_node;
>   	int ret;
>   
> -	ret = of_drm_get_panel_orientation(np, &lvds->orientation);
> +	ret = drm_of_get_panel_orientation(np, &lvds->orientation);
>   	if (ret < 0) {
>   		dev_err(lvds->dev, "%pOF: failed to get orientation %d\n", np, ret);
>   		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> index 226d91daf8c7..100816b04c13 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> @@ -1206,7 +1206,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
>   	pinfo->dsi[0] = dsi;
>   	mipi_dsi_set_drvdata(dsi, pinfo);
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
>   	if (ret < 0) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
>   		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c09bf3db5e78..5c169fdf265c 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -693,7 +693,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
>   		return dev_err_cast_probe(dev, panel->enable_gpio,
>   					  "failed to request GPIO\n");
>   
> -	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
> +	err = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
>   	if (err) {
>   		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
>   		return ERR_PTR(err);
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> index 2f79ec4a2063..11c757752cfb 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> @@ -1296,7 +1296,7 @@ static int st7701_probe(struct device *dev, int connector_type)
>   		return PTR_ERR(st7701->reset);
>   	}
>   
> -	ret = of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
> +	ret = drm_of_get_panel_orientation(dev->of_node, &st7701->orientation);
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "Failed to get orientation\n");
>   
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 6c348fe28955..40df2e5b14b2 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -874,7 +874,7 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
>   				     "Failed to request iovcc regulator\n");
>   
> -	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
>   	if (ret < 0)
>   		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
>   
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index d5f821d6b23c..0502df34746b 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -646,7 +646,7 @@ static int st7789v_probe(struct spi_device *spi)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   
> -	ret = of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
> +	ret = drm_of_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
>   	if (ret)
>   		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
>   
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 86b3f9c65c92..b87323443f49 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -337,19 +337,11 @@ int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector
>   
>   #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
>   struct drm_panel *of_drm_find_panel(const struct device_node *np);
> -int of_drm_get_panel_orientation(const struct device_node *np,
> -				 enum drm_panel_orientation *orientation);
>   #else
>   static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
>   {
>   	return ERR_PTR(-ENODEV);
>   }
> -
> -static inline int of_drm_get_panel_orientation(const struct device_node *np,
> -					       enum drm_panel_orientation *orientation)
> -{
> -	return -ENODEV;
> -}
>   #endif
>   
>   #if defined(CONFIG_DRM_PANEL)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


