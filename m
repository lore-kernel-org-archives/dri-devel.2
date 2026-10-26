Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645B606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WzS7+lSd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE53A10E08B;
	Mon, 26 Oct 2026 06:01:57 +0000 (UTC)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0034210E9A2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:01:50 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YUsDrIsQFf7u2M6+ouvMSrkdV5qNOI7EBxDvQmWtcPI=;
 b=WzS7+lSdNs/Le1nqYRxq3LDikGcIa/iJ8ZNyTvToliOUUzWG/Ry1gBPWL+CgDD9xavRzoroZC
 cAapjIH4FJsS13eQTMOVQFQabApqua4MsV5Jv9nU/sd40LolGmaQU4GbuhMPSjB+ZNjHnKSdHsw
 pWLuYpah+joWIEgNsLTG27g=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jCjgV4NVTzLlSk;
 Mon, 26 Oct 2026 14:01:42 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BA1634057C;
 Mon, 26 Oct 2026 14:01:47 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 26 Oct 2026 14:01:47 +0800
Message-ID: <96b30d87-2519-495f-b126-82aa29671683@huawei.com>
Date: Mon, 26 Oct 2026 14:01:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v3 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 <shuliubin@huawei.com>, "fengsheng (A)" <fengsheng5@huawei.com>, "helin (T)"
 <helin52@h-partners.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 <shiyongbang@huawei.com>
References: <20260924080609.3681795-1-shiyongbang@huawei.com>
 <20260924080609.3681795-2-shiyongbang@huawei.com>
 <20260924083002.24F441F000FF@smtp.kernel.org>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260924083002.24F441F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200005.china.huawei.com (7.202.194.71)
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] drm/hisilicon: Hardcoded initial HPD_OUT state breaks boot display detection
> - [High] drm/hisilicon: Removal of HPD debounce causes DPCD read failures on hotplug
> - [Medium] drm/hisilicon: Early exit in encoder_enable breaks KMS forced modesets
> - [Low] drm/hisilicon: Data race on dp->hpd_status between hardirq and process contexts
> --
> 
> commit 19dc442443127128a0c2f9bcb0ceca722bb81f14
> Author: Lin He <helin52@huawei.com>
> 
> drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status
> 
> This commit replaces the polling mechanism in the lower half of the HPD
> interrupt with a direct read of the interrupt status in the upper half.
> It also skips detection and training if the status is not HPD_IN, and
> initializes the state to HPD_OUT.
> 
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> index d5bd3c45649b2..a4cd4cd8cc75e 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> [ ... ]
>> @@ -322,20 +326,26 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
>>   	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
>>   }
>>   
>> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
>> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp)
>>   {
>> +	int hpd_status = HIBMC_HPD_UNKNOWN;
>>   	u32 status;
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
>> +		hpd_status = HIBMC_HPD_OUT;
>> +		break;
>> +	case 1: /* plug */
>> +	case 2: /* plug intermediate */
>> +		hpd_status = HIBMC_HPD_IN;
> 
> [Severity: High]
> Does mapping the 'plug intermediate' state (value 2) directly to HIBMC_HPD_IN
> without the previous 100ms debounce loop cause DPCD read failures?
> 
> When the link is physically bouncing during a hotplug event, returning
> HIBMC_HPD_IN immediately schedules hibmc_dp_detect(). The immediate AUX
> transaction in hibmc_dp_get_dpcd() can then fail because the connection has
> not stabilized, causing the hotplug event to be dropped.
> 

As answered in [1]: debouncing is implemented on-chip. The driver
reads the debounced HPD state-machine output (HIBMC_DP_HPD_CUR_STATE
in HIBMC_DP_HPD_STATUS), never the raw HPD pin, so mechanical contact
bounce is filtered by hardware before software can observe it.

Regarding 'plug intermediate' (state 2): despite the name, this is
not an unstable plug. The state machine enters state 2 only from
the stable plug state, to debounce a possible unplug; the sink
remains connected throughout. So mapping it to HIBMC_HPD_IN is
consistent with the plug interrupt that fired.

Note also that the removed loop was not a debounce: our hardware
already implements the debouncing, so the software 100 ms loop
served no purpose.

>> +		break;
>> +	default:
>> +		break;
>>   	}
>>   
>> -	dp->dp_dev->hpd_status = exp_status;
>> -
>> -	return true;
>>   }
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index 2e9403b8bf3c8..1f8ea0b092537 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> [ ... ]
>> @@ -63,11 +61,10 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
>>   	int ret = connector_status_disconnected;
>>   
>> -	if (dp->irq_status) {
>> -		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
>> -			ret = connector_status_disconnected;
>> -			goto exit;
>> -		}
>> +	if (dp->hpd_status != HIBMC_HPD_IN) {
> 
> [Severity: Low]
> Is there a theoretical data race here when reading dp->hpd_status?
> 
> It appears to be modified in hardirq context by hibmc_dp_interrupt() and read
> here in process context without WRITE_ONCE()/READ_ONCE() annotations or
> locking.
> 

Okay, I'll change it to use READ_ONCE and WRITE_ONCE; they are indeed more secure.

>> +		drm_dbg_dp(dp->drm_dev, "dp detect skipped, hpd (%d)\n",
>> +			   dp->hpd_status);
>> +		goto exit;
>>   	}
>>   
>>   	if (!hibmc_dp_get_dpcd(dp_dev)) {
> [ ... ]
>> @@ -166,6 +163,12 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
>>   	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
>>   	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
>>   
>> +	if (dp->hpd_status != HIBMC_HPD_IN) {
> 
> [Severity: Medium]
> Does this early exit break KMS forced modesets?
> 
> If a user overrides the connector to 'connected' (e.g., via sysfs or kernel
> command line) and the DRM core attempts an atomic commit, this check will
> refuse to program the hardware. This would desynchronize the KMS software
> state from the actual hardware state.
> 

Okay, the original purpose of this interceptor was to reduce the number of
exception logs when HPD_OUT; it serves no other purpose. I will remove it in v4.

>> +		drm_dbg_dp(dp->drm_dev, "dp encoder enable skipped, hpd (%d)\n",
>> +			   dp->hpd_status);
>> +		return;
>> +	}
>> +
>>   	if (hibmc_dp_prepare(dp, mode))
>>   		return;
> [ ... ]
>> @@ -223,6 +228,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>>   
>>   	dp->mmio = priv->mmio;
>>   	dp->drm_dev = dev;
>> +	dp->hpd_status = HIBMC_HPD_OUT;
> 
> [Severity: High]
> Will hardcoding the initial state to HIBMC_HPD_OUT break display detection
> at boot?
> 
> During boot, drm_client_setup() runs detect() before or immediately after
> interrupts are enabled in late_register(). Because detect() no longer queries
> the live hardware register and relies only on this cached value, it will read
> HPD_OUT and silently force a disconnected state even if a monitor is already
> connected.
> 
As explained in [1], a monitor connected before boot does trigger an
HPD interrupt: the event is latched by hardware while DP interrupts
are still masked. hibmc_dp_hw_init() ends with a 100 ms delay, which
gives the hardware time to complete the debouncing and latch the
interrupt; this already detects the plug-in in the vast majority of
cases.

Moreover, even if a transient or sporadic hardware issue prevents
the plug-in from being recognized within the 100 ms window, or even
by the time drm_client_setup() runs, hibmc_dp_hpd_isr(), the
threaded bottom half of the HPD interrupt, re-triggers the hotplug
flow via drm_connector_helper_hpd_irq_event(), so the DP plug-in
event is never lost.

[1] https://lore.kernel.org/all/8026563b-d04a-4f8d-9c9c-c30f5520b3b9@huawei.com/

Thanks,
Yongbang.
