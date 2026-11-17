Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02589606A8A3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KRtMxwYJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aGbYyFCe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KRtMxwYJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aGbYyFCe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6368610E09C;
	Tue, 17 Nov 2026 14:12:33 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28DC10EA4A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:12:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A1EA22332;
 Tue, 17 Nov 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E1rpCg/mdCPU4ibpgl6ymngQ0xz55vtdC2LIFM0C9o0=;
 b=KRtMxwYJ27tr4UJPkx/ebO04RhPYlhsN17dfk9Tql+fwIw6rXPlyo8I7hIWtLxs6rALZP4
 QnPTmBXjAuzwH+mI70N2FLK0wA06QROf7Yz73T1hbGwcN+4yMANJmuHA3bBfTOWmA4bdW7
 GTuSN0gDXmJaJlXOlccQUoHVn8sH8cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E1rpCg/mdCPU4ibpgl6ymngQ0xz55vtdC2LIFM0C9o0=;
 b=aGbYyFCewDa/pzJS5vAXP/lHFcilOMhHpUdFpojELE9Uq0ZkifmoYR3iChlB5+YYB3zylm
 5440qcUt8osAeHBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KRtMxwYJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aGbYyFCe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E1rpCg/mdCPU4ibpgl6ymngQ0xz55vtdC2LIFM0C9o0=;
 b=KRtMxwYJ27tr4UJPkx/ebO04RhPYlhsN17dfk9Tql+fwIw6rXPlyo8I7hIWtLxs6rALZP4
 QnPTmBXjAuzwH+mI70N2FLK0wA06QROf7Yz73T1hbGwcN+4yMANJmuHA3bBfTOWmA4bdW7
 GTuSN0gDXmJaJlXOlccQUoHVn8sH8cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E1rpCg/mdCPU4ibpgl6ymngQ0xz55vtdC2LIFM0C9o0=;
 b=aGbYyFCewDa/pzJS5vAXP/lHFcilOMhHpUdFpojELE9Uq0ZkifmoYR3iChlB5+YYB3zylm
 5440qcUt8osAeHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8749C13302;
 Tue, 17 Nov 2026 14:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F9FyDcNg/Gp9KgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 14:12:19 +0000
Message-ID: <273ce275-4e40-48e8-8788-86d590081420@suse.de>
Date: Tue, 17 Nov 2026 15:12:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, shuliubin@huawei.com, chenjianmin@huawei.com,
 fengsheng5@huawei.com, helin52@h-partners.com, shenjian15@huawei.com,
 shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261117130056.272609-1-shiyongbang@huawei.com>
 <20261117130056.272609-2-shiyongbang@huawei.com>
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
In-Reply-To: <20261117130056.272609-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[17];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim,huawei.com:email];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:url, bootlin.com:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 2A1EA22332
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 17.11.26 um 14:00 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> To more accurately determine whether the current HPD status matches the
> interrupt status, the polling mechanism in the lower half of the HPD
> interrupt (via hibmc_dp_check_hpd_status) has been replaced with directly
> retrieving the interrupt status in the upper half of the interrupt (via
> hibmc_dp_get_hpd_status).
>
> * Connector detection is skipped when hpd_status is not HPD_IN.
>
> * Set the initial status of hpd_status to HPD_OUT.
>
> * Wait 100 ms after enabling the DP block, so a sink that is already
>    connected can latch its HPD interrupt before the first detect.
>
> * Invalidate the link as soon as an unplug is sampled in the hardirq,
>    so an unplug that is followed by a plug before the threaded handler
>    runs is not lost.
>
> Fixes: 3906e7a3b26d ("drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq")
> Fixes: b11bc1ae4658 ("drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v4 -> v5:
>    - Invalidate the link in the hardirq when an unplug is sampled, and
>      stop clearing the latched HPD status in hibmc_dp_hpd_cfg().
>      (sashiko-bot)
>    - Serialize a whole AUX transfer with hibmc_dp_hpd_cfg().
>      (sashiko-bot)
>    - Append HIBMC_HPD_UNKNOWN to the enum instead of prepending it, so
>      the existing HIBMC_HPD_OUT/HIBMC_HPD_IN values do not change.
> v3 -> v4:
>    - Fix the data race on hpd_status between hardirq and process
>      contexts with WRITE_ONCE()/READ_ONCE(). (sashiko-bot)
>    - Delete the HPD_IN early return in encoder_enable that breaks KMS
>      forced modesets. (sashiko-bot)
> v2 -> v3:
>    - Delete irq_status and use hpd_status directly for hotplug
>      detection. (sashiko-bot)
>    - Add debug logs when hpd_status is not HPD_IN in detect and
>      encoder_enable.
> v1 -> v2:
>    - More states in HIBMC_DP_HPD_STATUS are added to the
>      'hibmc_dp_get_hpd_status'.
> ---
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   | 11 ++++-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  2 +-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 40 ++++++++++++-------
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  5 ++-
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 31 +++++++-------
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  9 ++++-
>   6 files changed, 63 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> index 8732cd1d8cb6..ef068cc52641 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> @@ -131,6 +131,8 @@ static ssize_t hibmc_dp_aux_xfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *
>   	int ret;
>   	u32 val; /* val will be assigned at the beginning of readl_poll_timeout function */
>   
> +	mutex_lock(&dp->aux_lock);

I would recommend using a lock guard here an below. See [1]

[1] 
https://elixir.bootlin.com/linux/v7.3.1/source/include/linux/cleanup.h#L10

Best regards
Thomas

> +
>   	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA0);
>   	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA1);
>   	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA2);
> @@ -147,10 +149,15 @@ static ssize_t hibmc_dp_aux_xfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *
>   				 !(val & HIBMC_DP_CFG_AUX_REQ), 50, 5000);
>   	if (ret) {
>   		hibmc_dp_aux_reset(dp);
> -		return ret;
> +		goto out_unlock;
>   	}
>   
> -	return hibmc_dp_aux_parse_xfer(dp, msg);
> +	ret = hibmc_dp_aux_parse_xfer(dp, msg);
> +
> +out_unlock:
> +	mutex_unlock(&dp->aux_lock);
> +
> +	return ret;
>   }
>   
>   void hibmc_dp_aux_init(struct hibmc_dp *dp)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index f53dac256ee0..e56bfca886cb 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -38,12 +38,12 @@ struct hibmc_dp_dev {
>   	struct drm_device *dev;
>   	void __iomem *base;
>   	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
> +	struct mutex aux_lock; /* serializes AUX transfers with hpd_cfg() */
>   	struct hibmc_dp_link link;
>   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>   	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
>   	struct drm_dp_desc desc;
>   	bool is_branch;
> -	int hpd_status;
>   	void __iomem *serdes_base;
>   };
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index d5bd3c45649b..8922a4f5b4ec 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -162,6 +162,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>   		return -ENOMEM;
>   
>   	mutex_init(&dp_dev->lock);
> +	mutex_init(&dp_dev->aux_lock);
>   
>   	dp->dp_dev = dp_dev;
>   
> @@ -191,6 +192,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
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
> @@ -214,15 +219,16 @@ void hibmc_dp_hpd_cfg(struct hibmc_dp *dp)
>   {
>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
>   
> +	mutex_lock(&dp_dev->aux_lock);
> +
>   	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
>   	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
>   	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MIN_PULSE_NUM, 0x9);
>   	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
> -	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
> -	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
> -	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
>   	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
>   	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
> +
> +	mutex_unlock(&dp_dev->aux_lock);
>   }
>   
>   void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable)
> @@ -322,20 +328,26 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
>   	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
>   }
>   
> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp)
>   {
> +	int hpd_status = HIBMC_HPD_UNKNOWN;
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
> +		hpd_status = HIBMC_HPD_OUT;
> +		break;
> +	case 1: /* plug */
> +	case 2: /* plug intermediate */
> +		hpd_status = HIBMC_HPD_IN;
> +		break;
> +	default:
> +		break;
>   	}
>   
> -	dp->dp_dev->hpd_status = exp_status;
> -
> -	return true;
> +	return hpd_status;
>   }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 0f3662d8737e..84faa1a7439d 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -17,6 +17,7 @@ struct hibmc_dp_dev;
>   enum hibmc_hpd_status {
>   	HIBMC_HPD_OUT,
>   	HIBMC_HPD_IN,
> +	HIBMC_HPD_UNKNOWN,
>   };
>   
>   enum hibmc_dp_cbar_pattern {
> @@ -54,7 +55,7 @@ struct hibmc_dp {
>   	void __iomem *mmio;
>   	struct drm_dp_aux aux;
>   	struct hibmc_dp_cbar_cfg cfg;
> -	u32 irq_status;
> +	int hpd_status;
>   	int phys_status;
>   };
>   
> @@ -66,7 +67,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
>   void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
>   void hibmc_dp_enable_int(struct hibmc_dp *dp);
>   void hibmc_dp_disable_int(struct hibmc_dp *dp);
> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp);
>   u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
>   u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 2e9403b8bf3c..6ea70c31d1a9 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -15,8 +15,6 @@
>   #include "dp/dp_comm.h"
>   #include "dp/dp_config.h"
>   
> -#define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
> -
>   static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>   {
>   	const struct drm_edid *drm_edid;
> @@ -61,13 +59,13 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>   {
>   	struct hibmc_dp *dp = to_hibmc_dp(connector);
>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +	int hpd_status = READ_ONCE(dp->hpd_status);
>   	int ret = connector_status_disconnected;
>   
> -	if (dp->irq_status) {
> -		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
> -			ret = connector_status_disconnected;
> -			goto exit;
> -		}
> +	if (hpd_status != HIBMC_HPD_IN) {
> +		drm_dbg_dp(dp->drm_dev, "dp detect skipped, hpd (%d)\n",
> +			   hpd_status);
> +		goto exit;
>   	}
>   
>   	if (!hibmc_dp_get_dpcd(dp_dev)) {
> @@ -189,24 +187,26 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>   {
>   	struct drm_device *dev = (struct drm_device *)arg;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> -	int idx, exp_status;
> +	int status = READ_ONCE(priv->dp.hpd_status);
> +	int idx;
>   
>   	if (!drm_dev_enter(dev, &idx))
>   		return -ENODEV;
>   
> -	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
> +	if (status == HIBMC_HPD_IN) {
> +		/* Plug takes aux_lock, so it must run in the thread. */
>   		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
>   		hibmc_dp_hpd_cfg(&priv->dp);
> -		exp_status = HIBMC_HPD_IN;
> -	} else {
> +	} else if (status == HIBMC_HPD_OUT) {
>   		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> -		hibmc_dp_reset_link(&priv->dp);
> -		exp_status = HIBMC_HPD_OUT;
> +	} else {
> +		drm_err(&priv->dev, "HPD status (%d) error\n", status);
> +		goto exit;
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
> @@ -223,6 +223,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>   
>   	dp->mmio = priv->mmio;
>   	dp->drm_dev = dev;
> +	dp->hpd_status = HIBMC_HPD_OUT;
>   
>   	ret = hibmc_dp_hw_init(&priv->dp);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 4d85c89f3f88..7920f03895fe 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -58,11 +58,18 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
>   {
>   	struct drm_device *dev = (struct drm_device *)arg;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> +	int hpd_status;
>   	u32 status;
>   
>   	status = readl(priv->mmio + HIBMC_DP_INTSTAT);
>   	if (status) {
> -		priv->dp.irq_status = status;
> +		hpd_status = hibmc_dp_get_hpd_status(&priv->dp);
> +		WRITE_ONCE(priv->dp.hpd_status, hpd_status);
> +
> +		/* Reset here so a later plug cannot hide this unplug. */
> +		if (hpd_status == HIBMC_HPD_OUT)
> +			hibmc_dp_reset_link(&priv->dp);
> +
>   		writel(status, priv->mmio + HIBMC_DP_INTCLR);
>   		return IRQ_WAKE_THREAD;
>   	}

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


