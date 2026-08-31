Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE69C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EC789CC4;
	Mon, 31 Aug 2026 13:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="L71zR0P9";
	dkim-atps=neutral
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D0589CC4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:40:57 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=nmdxjMt3LU7HFnWXf7LaMBxS/Rfo981g3BAv2WLpTmU=;
 b=L71zR0P9TRUbFW9nAY7EnFbxO0XtyJ6p02J1eYaW4Tt5DIweeOXUWLAt1FtiCa4aepHTBPTBn
 R+x2oCKOJBtvj9zCMFc3faNLH0THGvnFt3fhJBKQtjCMgTxGEJW55Uz7GWyGmOUkBLl7iniVUz3
 IzpeY8SeMvaqiBZSK0qm6+0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hYVG745XNz1T4K9;
 Mon, 31 Aug 2026 21:29:35 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 864E740561;
 Mon, 31 Aug 2026 21:40:54 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 31 Aug 2026 21:40:53 +0800
Message-ID: <c58083c3-ac70-4a67-ac46-632897d58c35@huawei.com>
Date: Mon, 31 Aug 2026 21:40:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "dmitry.baryshkov@oss.qualcomm.com" <dmitry.baryshkov@oss.qualcomm.com>,
 "tiantao (H)" <tiantao6@hisilicon.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "kongxinwei (A)"
 <kong.kongxinwei@hisilicon.com>
CC: "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>, "helin (T)" <helin52@h-partners.com>, "shenjian
 (K)" <shenjian15@huawei.com>, shaojijie <shaojijie@huawei.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 <shiyongbang@huawei.com>, <helin52@h-partners.com>
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
 <20260721124324.1885856-2-shiyongbang@huawei.com>
 <6cb7cbda-172e-4a73-9149-1ed48466d5de@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <6cb7cbda-172e-4a73-9149-1ed48466d5de@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200005.china.huawei.com (7.202.194.71)
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

> Hi,
> 
> you definitely want to go over the Sashiko review for both patches.
> 

Yes, Sashiko has raised several historical issues that we've been analyzing recently. The feedback
via email and the v3 patch will be ready very soon.

Sashiko was recently launched, and I'd like to ask: if we want to reject Sashiko's suggestions,
is it sufficient to simply state the reasons for the rejection in our reply email? How can we
prevent Sashiko from raising the same issues in the next version's patch?


> Am 21.07.26 um 14:43 schrieb Yongbang Shi:
>> From: Lin He <helin52@huawei.com>
>>
>> To more accurately determine whether the current HPD status matches the
>> interrupt status, the polling mechanism in the lower half of the HPD
>> interrupt (via hibmc_dp_check_hpd_status) has been replaced with directly
>> retrieving the interrupt status in the upper half of the interrupt (via
>> hibmc_dp_get_hpd_status).
> 
> The upper half might run a lot if the IRQ is shared with other devices.
> It's usually better to do as little as possible there and keep things in
> the handler thread.
> 

Of course, that's exactly what we did.

Thanks,
Yongbang.

> Best regards
> Thomas
> 
>>
>> * Detection and training are not performed if hpd_status is not HPD_IN.
>>
>> * Set the initial status of hpd_status to HPD_OUT.
>>
>> Fixes: 3906e7a3b26d ("drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq")
>> Signed-off-by: Lin He <helin52@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v1 -> v2:
>>     - More states in HIBMC_DP_HPD_STATUS are added to the
>>       'hibmc_dp_get_hpd_status'.
>> ---
>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 -
>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 32 ++++++++++++-------
>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  4 ++-
>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 29 ++++++++++-------
>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  1 +
>>    5 files changed, 43 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>> index f53dac256ee0..b0e258b9265e 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>> @@ -43,7 +43,6 @@ struct hibmc_dp_dev {
>>    	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
>>    	struct drm_dp_desc desc;
>>    	bool is_branch;
>> -	int hpd_status;
>>    	void __iomem *serdes_base;
>>    };
>>    
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> index d5bd3c45649b..c9a113a1937d 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> @@ -191,6 +191,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>>    	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>>    	/* clock enable */
>>    	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
>> +	/* To latch the HPD interrupt, ensuring that DP can support more modes
>> +	 * within the fbcon framework when connected alone.
>> +	 */
>> +	msleep(100);
>>    
>>    	return 0;
>>    }
>> @@ -322,20 +326,26 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
>>    	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
>>    }
>>    
>> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
>> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp)
>>    {
>> +	int ret = HIBMC_HPD_UNKNOWN;
>>    	u32 status;
>> -	int ret;
>>    
>> -	ret = readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, status,
>> -				 FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) == exp_status,
>> -				 1000, 100000); /* DP spec says 100ms */
>> -	if (ret) {
>> -		drm_dbg_dp(dp->drm_dev, "wait hpd status timeout");
>> -		return false;
>> +	status = FIELD_GET(HIBMC_DP_HPD_CUR_STATE,
>> +			   readl(dp->dp_dev->base + HIBMC_DP_HPD_STATUS));
>> +	switch (status) {
>> +	case 0: /* idle */
>> +	case 3: /* unplug */
>> +	case 4: /* unplug intermediate */
>> +		ret = HIBMC_HPD_OUT;
>> +		break;
>> +	case 1: /* plug */
>> +	case 2: /* plug intermediate */
>> +		ret = HIBMC_HPD_IN;
>> +		break;
>> +	default:
>> +		break;
>>    	}
>>    
>> -	dp->dp_dev->hpd_status = exp_status;
>> -
>> -	return true;
>> +	return ret;
>>    }
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> index 0f3662d8737e..bcd4e9d155c8 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> @@ -15,6 +15,7 @@
>>    struct hibmc_dp_dev;
>>    
>>    enum hibmc_hpd_status {
>> +	HIBMC_HPD_UNKNOWN,
>>    	HIBMC_HPD_OUT,
>>    	HIBMC_HPD_IN,
>>    };
>> @@ -55,6 +56,7 @@ struct hibmc_dp {
>>    	struct drm_dp_aux aux;
>>    	struct hibmc_dp_cbar_cfg cfg;
>>    	u32 irq_status;
>> +	int hpd_status;
>>    	int phys_status;
>>    };
>>    
>> @@ -66,7 +68,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
>>    void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
>>    void hibmc_dp_enable_int(struct hibmc_dp *dp);
>>    void hibmc_dp_disable_int(struct hibmc_dp *dp);
>> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
>> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp);
>>    u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
>>    u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
>>    
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index 2e9403b8bf3c..23716d48149f 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> @@ -63,12 +63,8 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>>    	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
>>    	int ret = connector_status_disconnected;
>>    
>> -	if (dp->irq_status) {
>> -		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
>> -			ret = connector_status_disconnected;
>> -			goto exit;
>> -		}
>> -	}
>> +	if (dp->hpd_status != HIBMC_HPD_IN)
>> +		goto exit;
>>    
>>    	if (!hibmc_dp_get_dpcd(dp_dev)) {
>>    		ret = connector_status_disconnected;
>> @@ -166,6 +162,9 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
>>    	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
>>    	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
>>    
>> +	if (dp->hpd_status != HIBMC_HPD_IN)
>> +		return;
>> +
>>    	if (hibmc_dp_prepare(dp, mode))
>>    		return;
>>    
>> @@ -189,24 +188,31 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>>    {
>>    	struct drm_device *dev = (struct drm_device *)arg;
>>    	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> -	int idx, exp_status;
>> +	int status = priv->dp.hpd_status;
>> +	int idx;
>>    
>>    	if (!drm_dev_enter(dev, &idx))
>>    		return -ENODEV;
>>    
>>    	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
>>    		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
>> +		if (status != HIBMC_HPD_IN) {
>> +			drm_err(&priv->dev, "HPD status (%d) error", status);
>> +			goto exit;
>> +		}
>>    		hibmc_dp_hpd_cfg(&priv->dp);
>> -		exp_status = HIBMC_HPD_IN;
>>    	} else {
>>    		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
>> +		if (status != HIBMC_HPD_OUT) {
>> +			drm_err(&priv->dev, "HPD status (%d) error", status);
>> +			goto exit;
>> +		}
>>    		hibmc_dp_reset_link(&priv->dp);
>> -		exp_status = HIBMC_HPD_OUT;
>>    	}
>>    
>> -	if (hibmc_dp_check_hpd_status(&priv->dp, exp_status))
>> -		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
>> +	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
>>    
>> +exit:
>>    	drm_dev_exit(idx);
>>    
>>    	return IRQ_HANDLED;
>> @@ -223,6 +229,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>>    
>>    	dp->mmio = priv->mmio;
>>    	dp->drm_dev = dev;
>> +	dp->hpd_status = HIBMC_HPD_OUT;
>>    
>>    	ret = hibmc_dp_hw_init(&priv->dp);
>>    	if (ret) {
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 4d85c89f3f88..e5cca7b63b78 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -63,6 +63,7 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
>>    	status = readl(priv->mmio + HIBMC_DP_INTSTAT);
>>    	if (status) {
>>    		priv->dp.irq_status = status;
>> +		priv->dp.hpd_status = hibmc_dp_get_hpd_status(&priv->dp);
>>    		writel(status, priv->mmio + HIBMC_DP_INTCLR);
>>    		return IRQ_WAKE_THREAD;
>>    	}
> 

