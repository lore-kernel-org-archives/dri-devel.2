Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C0FC5DF9D
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E8A10E3C4;
	Thu, 27 Aug 2026 08:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uL/svT08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OqJ1O1Qr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xbLSUPSx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RFfKFCPY";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B8110E05D
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:16:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1ACB92128D;
 Thu, 27 Aug 2026 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d7w/ZQfn4h8wekBeh6qjvnu3PdBd/4euBu/Z2mQ1Tjk=;
 b=uL/svT08ZZlsc85ZyEiEwLLI+woJrFa0sghKrkmaloLFlJGPqrklqWpAsO2M7D726jnCK6
 kr4t/Vd0N3UFbsmXxari9Liz3lXv/9JcNUNS7yT1mMOit5U3l3s5UW87y1ch68FzbM8t76
 rfdwLuRYepFYdvbdymmbFe9T2gfJhRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d7w/ZQfn4h8wekBeh6qjvnu3PdBd/4euBu/Z2mQ1Tjk=;
 b=OqJ1O1QrOrU2qRi6FpL/89npuNvky56BFaXGVOK3zj6j828t2rbgM92g+WMcEbyjgM2I67
 VXUciN5frtxsVpDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d7w/ZQfn4h8wekBeh6qjvnu3PdBd/4euBu/Z2mQ1Tjk=;
 b=xbLSUPSxOhp1BDjsCFbf8A8W7Rh1RRQZZKQLSBTOGaP1imOgZqbzapbtiqtoetJdOk3pOL
 H1s81CaFzJP3d4D09rElY4lev9nzRrrboES63zzZ7yC4XnaU6jGBVAuQkMVQh4YjlGwi7Y
 i8p8IEvivpafaI4wqEWeOOWIcmwTFxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d7w/ZQfn4h8wekBeh6qjvnu3PdBd/4euBu/Z2mQ1Tjk=;
 b=RFfKFCPYh+Oq+hSsJPO/i0v5eeS7CRDCUiNGXpqshu80EBWx/4gFdimEhc+DO4RLytD1th
 CShISJ0+VqwNT0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AADD91352C;
 Thu, 27 Aug 2026 08:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wo+XKE/yj2ovMAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 08:16:15 +0000
Message-ID: <6cb7cbda-172e-4a73-9149-1ed48466d5de@suse.de>
Date: Thu, 27 Aug 2026 10:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
 <20260721124324.1885856-2-shiyongbang@huawei.com>
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
In-Reply-To: <20260721124324.1885856-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 huawei.com:email, suse.de:mid]
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

you definitely want to go over the Sashiko review for both patches.

Am 21.07.26 um 14:43 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> To more accurately determine whether the current HPD status matches the
> interrupt status, the polling mechanism in the lower half of the HPD
> interrupt (via hibmc_dp_check_hpd_status) has been replaced with directly
> retrieving the interrupt status in the upper half of the interrupt (via
> hibmc_dp_get_hpd_status).

The upper half might run a lot if the IRQ is shared with other devices. 
It's usually better to do as little as possible there and keep things in 
the handler thread.

Best regards
Thomas

>
> * Detection and training are not performed if hpd_status is not HPD_IN.
>
> * Set the initial status of hpd_status to HPD_OUT.
>
> Fixes: 3906e7a3b26d ("drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>    - More states in HIBMC_DP_HPD_STATUS are added to the
>      'hibmc_dp_get_hpd_status'.
> ---
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 -
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 32 ++++++++++++-------
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  4 ++-
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 29 ++++++++++-------
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  1 +
>   5 files changed, 43 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index f53dac256ee0..b0e258b9265e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -43,7 +43,6 @@ struct hibmc_dp_dev {
>   	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
>   	struct drm_dp_desc desc;
>   	bool is_branch;
> -	int hpd_status;
>   	void __iomem *serdes_base;
>   };
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index d5bd3c45649b..c9a113a1937d 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -191,6 +191,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>   	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>   	/* clock enable */
>   	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
> +	/* To latch the HPD interrupt, ensuring that DP can support more modes
> +	 * within the fbcon framework when connected alone.
> +	 */
> +	msleep(100);
>   
>   	return 0;
>   }
> @@ -322,20 +326,26 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
>   	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
>   }
>   
> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp)
>   {
> +	int ret = HIBMC_HPD_UNKNOWN;
>   	u32 status;
> -	int ret;
>   
> -	ret = readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, status,
> -				 FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) == exp_status,
> -				 1000, 100000); /* DP spec says 100ms */
> -	if (ret) {
> -		drm_dbg_dp(dp->drm_dev, "wait hpd status timeout");
> -		return false;
> +	status = FIELD_GET(HIBMC_DP_HPD_CUR_STATE,
> +			   readl(dp->dp_dev->base + HIBMC_DP_HPD_STATUS));
> +	switch (status) {
> +	case 0: /* idle */
> +	case 3: /* unplug */
> +	case 4: /* unplug intermediate */
> +		ret = HIBMC_HPD_OUT;
> +		break;
> +	case 1: /* plug */
> +	case 2: /* plug intermediate */
> +		ret = HIBMC_HPD_IN;
> +		break;
> +	default:
> +		break;
>   	}
>   
> -	dp->dp_dev->hpd_status = exp_status;
> -
> -	return true;
> +	return ret;
>   }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 0f3662d8737e..bcd4e9d155c8 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -15,6 +15,7 @@
>   struct hibmc_dp_dev;
>   
>   enum hibmc_hpd_status {
> +	HIBMC_HPD_UNKNOWN,
>   	HIBMC_HPD_OUT,
>   	HIBMC_HPD_IN,
>   };
> @@ -55,6 +56,7 @@ struct hibmc_dp {
>   	struct drm_dp_aux aux;
>   	struct hibmc_dp_cbar_cfg cfg;
>   	u32 irq_status;
> +	int hpd_status;
>   	int phys_status;
>   };
>   
> @@ -66,7 +68,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
>   void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
>   void hibmc_dp_enable_int(struct hibmc_dp *dp);
>   void hibmc_dp_disable_int(struct hibmc_dp *dp);
> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp);
>   u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
>   u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 2e9403b8bf3c..23716d48149f 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -63,12 +63,8 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
>   	int ret = connector_status_disconnected;
>   
> -	if (dp->irq_status) {
> -		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
> -			ret = connector_status_disconnected;
> -			goto exit;
> -		}
> -	}
> +	if (dp->hpd_status != HIBMC_HPD_IN)
> +		goto exit;
>   
>   	if (!hibmc_dp_get_dpcd(dp_dev)) {
>   		ret = connector_status_disconnected;
> @@ -166,6 +162,9 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
>   	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
>   	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
>   
> +	if (dp->hpd_status != HIBMC_HPD_IN)
> +		return;
> +
>   	if (hibmc_dp_prepare(dp, mode))
>   		return;
>   
> @@ -189,24 +188,31 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>   {
>   	struct drm_device *dev = (struct drm_device *)arg;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> -	int idx, exp_status;
> +	int status = priv->dp.hpd_status;
> +	int idx;
>   
>   	if (!drm_dev_enter(dev, &idx))
>   		return -ENODEV;
>   
>   	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
>   		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
> +		if (status != HIBMC_HPD_IN) {
> +			drm_err(&priv->dev, "HPD status (%d) error", status);
> +			goto exit;
> +		}
>   		hibmc_dp_hpd_cfg(&priv->dp);
> -		exp_status = HIBMC_HPD_IN;
>   	} else {
>   		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> +		if (status != HIBMC_HPD_OUT) {
> +			drm_err(&priv->dev, "HPD status (%d) error", status);
> +			goto exit;
> +		}
>   		hibmc_dp_reset_link(&priv->dp);
> -		exp_status = HIBMC_HPD_OUT;
>   	}
>   
> -	if (hibmc_dp_check_hpd_status(&priv->dp, exp_status))
> -		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> +	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
>   
> +exit:
>   	drm_dev_exit(idx);
>   
>   	return IRQ_HANDLED;
> @@ -223,6 +229,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>   
>   	dp->mmio = priv->mmio;
>   	dp->drm_dev = dev;
> +	dp->hpd_status = HIBMC_HPD_OUT;
>   
>   	ret = hibmc_dp_hw_init(&priv->dp);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 4d85c89f3f88..e5cca7b63b78 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -63,6 +63,7 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
>   	status = readl(priv->mmio + HIBMC_DP_INTSTAT);
>   	if (status) {
>   		priv->dp.irq_status = status;
> +		priv->dp.hpd_status = hibmc_dp_get_hpd_status(&priv->dp);
>   		writel(status, priv->mmio + HIBMC_DP_INTCLR);
>   		return IRQ_WAKE_THREAD;
>   	}

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


