Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFDACD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 07:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950BB10E984;
	Tue, 12 May 2026 07:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dRBRcXRl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pk8xUQxW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dRBRcXRl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pk8xUQxW";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CBD10E312
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:29:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78ED16BF65;
 Tue, 12 May 2026 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778570972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A5+OvHhAddu947SeepguoYlkifQbnyK/yfFGM0g/EA0=;
 b=dRBRcXRlOQIsTOQfIB0Ith4JNIjjL/HOnoO/GeYePelL9hdtLjNX53LA8iG6j9Nrehw4p9
 DLcDdbjG2LMgmtUHuaOz+UwsX1ND05Hy3YB0zswmj2MfPumDMQdDD93pWTrY8nbVJrMmn7
 a3vo+Ktol4Ls31peiP3qS8d4qnnO8Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778570972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A5+OvHhAddu947SeepguoYlkifQbnyK/yfFGM0g/EA0=;
 b=pk8xUQxWouOfBapPNsYBWB7FCdaGVhUT40W8e7nYjkzn7gY7rj2cusItEXEQcVI2F3Cqnd
 43SiI39dfqQKhbDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778570972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A5+OvHhAddu947SeepguoYlkifQbnyK/yfFGM0g/EA0=;
 b=dRBRcXRlOQIsTOQfIB0Ith4JNIjjL/HOnoO/GeYePelL9hdtLjNX53LA8iG6j9Nrehw4p9
 DLcDdbjG2LMgmtUHuaOz+UwsX1ND05Hy3YB0zswmj2MfPumDMQdDD93pWTrY8nbVJrMmn7
 a3vo+Ktol4Ls31peiP3qS8d4qnnO8Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778570972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A5+OvHhAddu947SeepguoYlkifQbnyK/yfFGM0g/EA0=;
 b=pk8xUQxWouOfBapPNsYBWB7FCdaGVhUT40W8e7nYjkzn7gY7rj2cusItEXEQcVI2F3Cqnd
 43SiI39dfqQKhbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09A4A593A9;
 Tue, 12 May 2026 07:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s+IcAdzWAmpjQAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 12 May 2026 07:29:32 +0000
Message-ID: <ac105cc6-8628-4f7c-8ac8-e3b8df4d206a@suse.de>
Date: Tue, 12 May 2026 09:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v6 1/4] drm/hisilicon/hibmc: add
 updating link cap in DP detect()
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260509032302.2057227-1-shiyongbang@huawei.com>
 <20260509032302.2057227-2-shiyongbang@huawei.com>
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
In-Reply-To: <20260509032302.2057227-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[17];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, suse.com:url,
 imap1.dmz-prg2.suse.org:helo, huawei.com:email]
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



Am 09.05.26 um 05:22 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> In the past, the link cap is updated in link training at encoder enable
> stage, but the hibmc_dp_mode_valid() is called before it, which will use
> DP link's rate and lanes. So add the hibmc_dp_update_caps() in
> hibmc_dp_update_caps() to avoid some potential risks.
>
> Fixes: 607805abfb74 ("drm/hisilicon/hibmc: add dp mode valid check")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> ChangeLog:
> v1 -> v2:
>    - fix the checkpatch.pl warning "Unknown commit ID 'e6c7c59da494'".
>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>      be given in public.
>    - add 'drm-misc-fixes' in subject prefix.
> ---
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h   | 1 +
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c   | 2 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c | 2 ++
>   3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index f9ee7ebfec55..f53dac256ee0 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -69,5 +69,6 @@ int hibmc_dp_link_training(struct hibmc_dp_dev *dp);
>   int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp);
>   int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp);
>   int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX]);
> +void hibmc_dp_update_caps(struct hibmc_dp_dev *dp);
>   
>   #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> index 0726cb5b736e..8c53f16db516 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> @@ -325,7 +325,7 @@ static int hibmc_dp_link_downgrade_training_eq(struct hibmc_dp_dev *dp)
>   	return hibmc_dp_link_reduce_rate(dp);
>   }
>   
> -static void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
> +void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
>   {
>   	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
>   	if (dp->link.cap.link_rate > DP_LINK_BW_8_1 || !dp->link.cap.link_rate)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 616821e3c933..35dff7bfbf76 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -41,6 +41,8 @@ static bool hibmc_dp_get_dpcd(struct hibmc_dp_dev *dp_dev)
>   	if (ret)
>   		return false;
>   
> +	hibmc_dp_update_caps(dp_dev);
> +
>   	dp_dev->is_branch = drm_dp_is_branch(dp_dev->dpcd);
>   
>   	ret = drm_dp_read_desc(dp_dev->aux, &dp_dev->desc, dp_dev->is_branch);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


