Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81400606B08F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0jW3mJhs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z/IQjX1l;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0jW3mJhs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z/IQjX1l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE57F10F22F;
	Tue, 17 Nov 2026 14:15:33 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7707410F22F
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:15:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E190F223FB;
 Tue, 17 Nov 2026 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/yRfYIBskde5gwPoew+i34JoQMqQKRpQXabN5yrleCQ=;
 b=0jW3mJhsZonTHow49PXrw/7X8xegWzg8hyvNe5jB8I5Qz76CE90xltQwj/qXkapOUzbseC
 mv1BU69E0GMbcbBLVzAjOe1tIi2PZ+uMDwohSXt3Dx6SpQitxCi4G0hXDBYF9VBC8FcnwV
 P5X9G3fZeq8W/OBGRPHnZ5QYAOc+z6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/yRfYIBskde5gwPoew+i34JoQMqQKRpQXabN5yrleCQ=;
 b=Z/IQjX1l+elYc06SHHARaWBvoGDRz6mdgG4jUI5W4emYodV1O/kkB9JNTRaqRgx+47W0rV
 ElfVxw1tcrkvWcAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/yRfYIBskde5gwPoew+i34JoQMqQKRpQXabN5yrleCQ=;
 b=0jW3mJhsZonTHow49PXrw/7X8xegWzg8hyvNe5jB8I5Qz76CE90xltQwj/qXkapOUzbseC
 mv1BU69E0GMbcbBLVzAjOe1tIi2PZ+uMDwohSXt3Dx6SpQitxCi4G0hXDBYF9VBC8FcnwV
 P5X9G3fZeq8W/OBGRPHnZ5QYAOc+z6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/yRfYIBskde5gwPoew+i34JoQMqQKRpQXabN5yrleCQ=;
 b=Z/IQjX1l+elYc06SHHARaWBvoGDRz6mdgG4jUI5W4emYodV1O/kkB9JNTRaqRgx+47W0rV
 ElfVxw1tcrkvWcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4772E13302;
 Tue, 17 Nov 2026 14:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 15e3NHdh/GqxLQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 14:15:20 +0000
Message-ID: <e113b27d-3065-43a2-a60f-aca3552f2002@suse.de>
Date: Tue, 17 Nov 2026 15:15:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 2/2] drm/hisilicon/hibmc: Add a flag
 to indicate whether the OS-side driver has been loaded
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, shuliubin@huawei.com, chenjianmin@huawei.com,
 fengsheng5@huawei.com, helin52@h-partners.com, shenjian15@huawei.com,
 shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261117130056.272609-1-shiyongbang@huawei.com>
 <20261117130056.272609-3-shiyongbang@huawei.com>
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
In-Reply-To: <20261117130056.272609-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:url,huawei.com:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Score: -13.29
X-Spam-Level: 
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
> Add a flag to indicate whether the OS-side driver has been loaded to
> prevent the BMC from enabling DP if the driver is not loaded, which could
> lead to system failure in handling interrupts and generate error messages
> like:
>
> irq xx: nobody cared (try booting with the "irqpoll" option)
> ...
> Call Trace:
> <TRQ>
> ...
>
> The flag is set only after hibmc_dp_init() succeeded, so it also means
> that the DP block is ready.  If DP initialization fails, only the vblank
> MSI vector is requested, so the DP interrupt is not registered at all.
>
> Fixes: 0ab6ea261c1f ("drm/hisilicon/hibmc: add dp module in hibmc")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v4 -> v5:
>    - Only set the enable flag when DP was initialized, clear it only when
>      it was set, and do not request the DP interrupt if DP initialization
>      failed. (sashiko-bot)
> v2 -> v3:
>    - Move hibmc_set_enable_flag() before drm_dev_register() and
>      hibmc_set_disable_flag() after drm_dev_unregister() to narrow the
>      race window. (sashiko-bot)
>    - Add spinlock_t gpio_lock to hibmc_drm_private to protect all
>      operations on 0x0802A4. (sashiko-bot)
> v1 -> v2:
>    - The call to `hibmc_set_enable_flag()` has been moved before
>      `drm_client_setup()`, specifically before the connector detection
>      triggers the I2C bit operation. (sashiko-bot)
>    - A read-modify-write operation has been implemented instead of directly
>      writing to prevent clearing the I2C mask bits. (sashiko-bot)
> ---
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  1 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 45 ++++++++++++++++++-
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 19 ++++++--
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  |  3 ++
>   6 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 84faa1a7439d..10772cddcfc8 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -57,6 +57,7 @@ struct hibmc_dp {
>   	struct hibmc_dp_cbar_cfg cfg;
>   	int hpd_status;
>   	int phys_status;
> +	bool initialized;
>   };
>   
>   int hibmc_dp_hw_init(struct hibmc_dp *dp);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 6ea70c31d1a9..9fa49a2ba093 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -256,6 +256,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>   	connector->polled = DRM_CONNECTOR_POLL_HPD;
>   
>   	dp->phys_status = connector_status_disconnected;
> +	dp->initialized = true;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 7920f03895fe..7ea050e89005 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -174,6 +174,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>   	if (ret)
>   		return ret;
>   
> +	spin_lock_init(&priv->gpio_lock);
> +
>   	dev->mode_config.min_width = 0;
>   	dev->mode_config.min_height = 0;
>   	dev->mode_config.max_width = 1920;
> @@ -346,12 +348,17 @@ static void hibmc_unload(struct drm_device *dev)
>   static int hibmc_msi_init(struct drm_device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> +	int max_vectors = HIBMC_MIN_VECTORS;
>   	int valid_irq_num;
>   	int irq;
>   	int ret;
>   
> -	ret = pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS,
> -				    HIBMC_MAX_VECTORS, PCI_IRQ_MSI);
> +	if (priv->dp.initialized)
> +		max_vectors = HIBMC_MAX_VECTORS;
> +
> +	ret = pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS, max_vectors,
> +				    PCI_IRQ_MSI);
>   	if (ret < 0) {
>   		drm_err(dev, "enabling MSI failed: %d\n", ret);
>   		return ret;
> @@ -430,6 +437,36 @@ static int hibmc_load(struct drm_device *dev)
>   	return ret;
>   }
>   
> +static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
> +{
> +	unsigned long flags;
> +	u32 value;
> +
> +	if (!priv->dp.initialized)
> +		return;
> +
> +	spin_lock_irqsave(&priv->gpio_lock, flags);

This is again a good place for a lock guard.

Best regards
Thomas

> +	value = readl(priv->mmio + HIBMC_ENABLE_FLAG);
> +	value |= HIBMC_ENABLE_STATE;
> +	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
> +	spin_unlock_irqrestore(&priv->gpio_lock, flags);
> +}
> +
> +static inline void hibmc_set_disable_flag(struct hibmc_drm_private *priv)
> +{
> +	unsigned long flags;
> +	u32 value;
> +
> +	if (!priv->dp.initialized)
> +		return;
> +
> +	spin_lock_irqsave(&priv->gpio_lock, flags);
> +	value = readl(priv->mmio + HIBMC_ENABLE_FLAG);
> +	value &= ~HIBMC_ENABLE_STATE;
> +	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
> +	spin_unlock_irqrestore(&priv->gpio_lock, flags);
> +}
> +
>   static int hibmc_pci_probe(struct pci_dev *pdev,
>   			   const struct pci_device_id *ent)
>   {
> @@ -465,6 +502,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>   		goto err_return;
>   	}
>   
> +	hibmc_set_enable_flag(priv);
> +
>   	ret = drm_dev_register(dev, 0);
>   	if (ret) {
>   		drm_err(dev, "failed to register drv for userspace access: %d\n",
> @@ -477,6 +516,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>   	return 0;
>   
>   err_unload:
> +	hibmc_set_disable_flag(priv);
>   	hibmc_unload(dev);
>   err_return:
>   	return ret;
> @@ -487,6 +527,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
>   	struct drm_device *dev = pci_get_drvdata(pdev);
>   
>   	drm_dev_unregister(dev);
> +	hibmc_set_disable_flag(to_hibmc_drm_private(dev));
>   	hibmc_unload(dev);
>   }
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index dce8572bf63e..c2a82000ea7f 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -49,6 +49,8 @@ struct hibmc_drm_private {
>   	struct drm_crtc crtc;
>   	struct hibmc_vdac vdac;
>   	struct hibmc_dp dp;
> +
> +	spinlock_t gpio_lock; /* protects RMW on I2C/ENABLE_FLAG (0x0802A4) */
>   };
>   
>   static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> index 44860011855e..4ceb87efec05 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> @@ -27,7 +27,11 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
>   {
>   	struct hibmc_vdac *vdac = data;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
> -	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
> +	unsigned long flags;
> +	u32 tmp_dir;
> +
> +	spin_lock_irqsave(&priv->gpio_lock, flags);
> +	tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
>   
>   	if (value) {
>   		tmp_dir &= ~mask;
> @@ -41,20 +45,29 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
>   		tmp_dir |= mask;
>   		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
>   	}
> +	spin_unlock_irqrestore(&priv->gpio_lock, flags);
>   }
>   
>   static int hibmc_get_i2c_signal(void *data, u32 mask)
>   {
>   	struct hibmc_vdac *vdac = data;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
> -	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
> +	unsigned long flags;
> +	u32 tmp_dir;
> +	int ret;
> +
> +	spin_lock_irqsave(&priv->gpio_lock, flags);
> +	tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
>   
>   	if ((tmp_dir & mask) != mask) {
>   		tmp_dir &= ~mask;
>   		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
>   	}
>   
> -	return (readl(priv->mmio + GPIO_DATA) & mask) ? 1 : 0;
> +	ret = (readl(priv->mmio + GPIO_DATA) & mask) ? 1 : 0;
> +	spin_unlock_irqrestore(&priv->gpio_lock, flags);
> +
> +	return ret;
>   }
>   
>   static void hibmc_ddc_setsda(void *data, int state)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
> index 17b30c393b10..b95add5b253c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
> @@ -200,5 +200,8 @@
>   
>   #define HIBMC_CRT_PALETTE                       0x80C00
>   
> +#define HIBMC_ENABLE_FLAG			0x802A4
> +#define HIBMC_ENABLE_STATE			BIT(2)
> +
>   #define HIBMC_FIELD(field, value) (field(value) & field##_MASK)
>   #endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


