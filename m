Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B2C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113E610F066;
	Wed,  2 Sep 2026 09:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="p3vYHPLq";
	dkim-atps=neutral
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5992E10F066
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:38:23 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=NiUWqYVIHsfW5obu+s37YNNG8I40SXViAeaBO6IKYiM=;
 b=p3vYHPLqJpjKa3oMP4vOS8WT1zHtbWZla3c01MCJYGcZyTmwdxeqP/gNq7dX2t71TX1M6C6uW
 N5wmtN0hHOQkRRaRUCVXy+IF8xglRluaTMlFGV6PufGH/xZZEvgdnY4kcJJrpXgH+nZeR0wca2O
 GJ2bklxjIVGFbIR9UyUzrbg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hZcnL5KFSz12LF7;
 Wed,  2 Sep 2026 17:27:02 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0FDB740561;
 Wed,  2 Sep 2026 17:38:19 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 2 Sep 2026 17:38:18 +0800
Message-ID: <8026563b-d04a-4f8d-9c9c-c30f5520b3b9@huawei.com>
Date: Wed, 2 Sep 2026 17:38:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
To: <sashiko-reviews@lists.linux.dev>, Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, "dmitry.baryshkov@oss.qualcomm.com"
 <dmitry.baryshkov@oss.qualcomm.com>, "tiantao (H)" <tiantao6@hisilicon.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
 "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>, <shiyongbang@huawei.com>,
 "Liangjian(Jim, Kunpeng Solution Development Dept)" <liangjian010@huawei.com>, 
 Chenjianmin <chenjianmin@huawei.com>
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
 <20260721124324.1885856-2-shiyongbang@huawei.com>
 <20260721130644.893D31F000E9@smtp.kernel.org>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260721130644.893D31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Hardcoded initial HPD status breaks display detection for pre-connected monitors and ignores `force` probes.
> - [High] Silently aborting `encoder_enable` when HPD is not IN breaks DRM atomic state guarantees.
> - [High] State overwriting and TOCTOU races between hardirq and threaded handlers drop legitimate HPD events.
> - [Medium] Instantaneous hardware read replaces 100ms debouncing loop, causing hotplug events to be dropped on contact bounce.
> 
> Pre-existing issues:
> - [High] Unconditional NULL pointer dereference in the hard IRQ handler if DP initialization is skipped or fails.
> --
> 
> --- Patch [1]: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status ---
> commit 9a953a788498e9cd1859698ff0b7eabd2a8009b2
> Author: Lin He <helin52@huawei.com>
> 
> drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status
> 
> To more accurately determine whether the current HPD status matches the
> interrupt status, the polling mechanism in the lower half of the HPD
> interrupt has been replaced with directly retrieving the interrupt
> status in the upper half of the interrupt.
> 
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> index d5bd3c45649b2..c9a113a1937d3 100644
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
>> +	int ret = HIBMC_HPD_UNKNOWN;
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
> 
> [Severity: High]
> This is a pre-existing issue, but does this code dereference a potentially
> NULL pointer?
> 
> If DP initialization is skipped or fails, dp->dp_dev remains NULL. However,
> hibmc_msi_init() unconditionally requests the DP interrupt. If the unclocked
> DP hardware returns 0xFFFFFFFF when HIBMC_DP_INTSTAT is read, the hardirq
> handler unconditionally calls hibmc_dp_get_hpd_status(), which dereferences
> dp->dp_dev->base, potentially causing a panic.
> 

Thank you for your review. Regarding this point, I think it's almost
impossible for that to happen. Here are the two possible failure cases
and why they do not lead to NULL dereference:

1. When DP init is skipped (serdes register reads 0):
    The hardware only supports 1 MSI vector, so hibmc_msi_init() only
    registers the vblank handler, not the DP handler. Therefore
    hibmc_dp_get_hpd_status() is never called and no NULL dereference
    can occur.

2. When DP init fails:
    dp->dp_dev is allocated via devm_kzalloc(), which is only freed by
    devres on driver unbind. If devm_kzalloc() fails, hibmc_dp_hw_init()
    returns -ENOMEM before DP interrupts are enabled. If devm_kzalloc()
    succeeds but a later init step fails, dp->dp_dev is already assigned
    (non-NULL), so no NULL dereference occurs.

Please let me know if you see any other potential race condition.

> [Severity: Medium]
> Does replacing the 100ms debouncing loop with a single instantaneous read
> cause hotplug events to be dropped due to contact bounce?
> 
> The DP specification mandates debouncing because physical hotplugs suffer from
> mechanical bouncing. By removing the poll and taking a single instantaneous
> read in the hardirq handler, the hardware read may capture an intermediate
> state. The threaded ISR then compares irq_status against this incorrectly
> sampled state and drops the event entirely if they do not match.
> 

Debouncing is implemented on-chip. The driver reads the
post-debounced state machine output, not the raw HPD pin
signal, so a single instantaneous read is sufficient and no
software debouncing loop is needed.

>> +	switch (status) {
>> +	case 0: /* idle */
> [ ... ]
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index 2e9403b8bf3c8..23716d48149f2 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> @@ -63,12 +63,8 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
>>   	int ret = connector_status_disconnected;
>>   
>> -	if (dp->irq_status) {
>> -		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
>> -			ret = connector_status_disconnected;
>> -			goto exit;
>> -		}
>> -	}
>> +	if (dp->hpd_status != HIBMC_HPD_IN)
>> +		goto exit;
> 
> [Severity: High]
> Does this hardcoded check ignore force probes and pre-connected monitors?
> 
> Because dp->hpd_status is initialized to HIBMC_HPD_OUT and relies entirely on
> edge-triggered interrupts to update it, a monitor connected prior to boot
> will not trigger an edge interrupt. This causes hibmc_dp_detect() to
> unconditionally return connector_status_disconnected, ignoring the actual
> hardware state.
> 

A monitor connected before boot does trigger an edge interrupt — it is
latched by hardware. This patch includes a 100ms sleep with an explicit
comment: "To latch the HPD interrupt, ensuring that DP can support more
modes within the fbcon framework when connected alone."

The sequence is: `hw_init` (latch window) -> `late_register` during
`drm_dev_register()` (enable interrupts, before userspace access) ->
latched HPD event fires and updates `hpd_status` in hardirq context. By
the time userspace can query the connector, `hpd_status` is already
correct.


>>   
>>   	if (!hibmc_dp_get_dpcd(dp_dev)) {
>>   		ret = connector_status_disconnected;
> [ ... ]
>> @@ -166,6 +162,9 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
>>   	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
>>   	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
>>   
>> +	if (dp->hpd_status != HIBMC_HPD_IN)
>> +		return;
>> +
> 
> [Severity: High]
> Does silently aborting hardware enablement here break DRM atomic state
> guarantees?
> 
> If userspace explicitly forces a disconnected connector to ON (e.g. via
> xrandr), the DRM framework commits the atomic state and expects the driver to
> enable the hardware pipeline. Silently returning from
> hibmc_dp_encoder_enable() leaves the hardware disabled while the software
> state tracks it as enabled, which can cause subsequent operations to fail
> or time out.
> 

I understand the concern. However, there are two key points:

1. When the hardware is not ready (`dp->hpd_status != HIBMC_HPD_IN`,
    i.e. no monitor connected), the driver should return early and not
    proceed with hardware enablement.

2. The `atomic_enable` callback has a `void` return type — the driver
    cannot propagate any failure back to the DRM framework, so silent
    return is the only option.


>>   	if (hibmc_dp_prepare(dp, mode))
>>   		return;
>>   
>> @@ -189,24 +188,31 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>>   {
>>   	struct drm_device *dev = (struct drm_device *)arg;
>>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> -	int idx, exp_status;
>> +	int status = priv->dp.hpd_status;
>> +	int idx;
>>   
>>   	if (!drm_dev_enter(dev, &idx))
>>   		return -ENODEV;
>>   
>>   	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
> 
> [Severity: High]
> Can a race condition between the hardirq handler and this threaded handler
> cause legitimate HPD events to be permanently lost?
> 
> The threaded handler first reads a snapshot of priv->dp.hpd_status into the
> status variable, then checks priv->dp.irq_status. If a new interrupt preempts
> the threaded handler between these two reads, the hardirq handler updates
> priv->dp.irq_status and priv->dp.hpd_status using direct assignments instead
> of bitwise accumulation. This mismatch causes the threaded handler to fail
> its state consistency check and completely drop the hotplug event.
> 

You are right, this is a valid race condition.

To fix it, I will use the local `status` variable directly for the
consistency check in the threaded handler, instead of re-reading
`priv->dp.irq_status`.

Since `status` is captured as a snapshot before the check, concurrent
updates from the hardirq handler cannot interleave and cause a
mismatch. This eliminates the race without requiring additional
locking.

I will send the v3 patch shortly. Please let me know if you have any
other concerns.

Thanks,
Yongbang.

>>   		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
>> +		if (status != HIBMC_HPD_IN) {
>> +			drm_err(&priv->dev, "HPD status (%d) error", status);
>> +			goto exit;
>> +		}
>>   		hibmc_dp_hpd_cfg(&priv->dp);
> 

