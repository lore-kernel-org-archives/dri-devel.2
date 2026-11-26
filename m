Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3046606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ic4H5hye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2410210E060;
	Thu, 26 Nov 2026 03:59:06 +0000 (UTC)
Received: from mail-m9313.xmail.ntesmail.com (mail-m9313.xmail.ntesmail.com
 [103.126.93.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5BB10E060
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:58:58 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 560db9b8b;
 Thu, 26 Nov 2026 11:58:55 +0800 (GMT+08:00)
Message-ID: <7b0fe53d-5bfb-41c1-a163-5bbb14123d86@rock-chips.com>
Date: Thu, 26 Nov 2026 11:58:55 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/20] drm/bridge: analogix_dp: Manage pm runtime and
 IRQ for native HPD pin detection
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
 <20261125112141.1434903-18-damon.ding@rock-chips.com>
 <sashiko-outbox-233271@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <sashiko-outbox-233271@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa21601a37903a8kunm786c9b6c7d5bda
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHktMVkNMGktPQ09OHklCH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5KVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=ic4H5hyeR0/U+v/oyMGC6uPoQxIa74ov6GVyc1Dm+9Y6/RLlIFNAwDjHe0RXqUvZfGIVs6nh4ZLO8LynZkgW3Nm9HORdx3K80mnAs8Mv968WbqQR+ivDtZBf/0hD7cmQluiakQtMa6bdgkM6gHGq0myvNJXgshEAokhCddRKO1o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=uJT5ZJ2aqCKLT9VFawMyFHtg0E9dRYKMg2nTwqyS14Q=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/2026 7:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] drm/bridge: analogix_dp: premature IRQ enable in
>    analogix_dp_resume()
> - [Medium] drm/bridge: analogix_dp: deadlock between
>    analogix_dp_suspend() and IRQ
> --
> 
> commit 2148ea987a79afc2769bfb9bcea363df9810b9e9
> Author: Damon Ding <damon.ding@rock-chips.com>
> 
> drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin detection
> 
> This commit holds a runtime PM reference across bind and unbind on RK3576
> and RK3588 for native hotplug detection, and gates the hotplug IRQ on
> hotplug support and runtime PM transitions.
> 
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 46433ea73d678..cda6e4c5cbc8d 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -42,6 +42,33 @@
>>   
>>   static const bool verify_fast_training;
>>   
>> +/*
>> + * The hotplug events are reported either through the optional GPIO HPD
>> + * pin or through the native controller interrupt, which is confirmed
>> + * to work only on the RK3576 and RK3588 platforms.
>> + */
>> +static bool analogix_dp_supports_hpd(struct analogix_dp_device *dp)
>> +{
>> +	if (dp->force_connected_mode || dp->force_hpd)
>> +		return false;
>> +
>> +	if (dp->hpd_gpiod)
>> +		return true;
>> +
>> +	return dp->plat_data->dev_type == RK3576_EDP || dp->plat_data->dev_type == RK3588_EDP;
>> +}
>> +
>> +/*
>> + * The native HPD interrupt relies on the controller staying powered
>> + * and clocked to report the hotplug events, so a runtime PM reference
>> + * is held for it.  The GPIO HPD mode needs no such reference, as it
>> + * reads the GPIO level directly.
>> + */
>> +static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *dp)
>> +{
>> +	return analogix_dp_supports_hpd(dp) && !dp->hpd_gpiod;
>> +}
>> +
>>   static void analogix_dp_init_dp(struct analogix_dp_device *dp)
>>   {
>>   	analogix_dp_reset(dp);
>> @@ -1547,6 +1574,11 @@ EXPORT_SYMBOL_GPL(analogix_dp_probe);
>>   
>>   int analogix_dp_suspend(struct analogix_dp_device *dp)
>>   {
>> +	if (analogix_dp_require_pm_for_hpd_irq(dp) && dp->hpd_irq_enabled) {
>> +		disable_irq(dp->irq);
>> +		dp->hpd_irq_enabled = false;
>> +	}
>> +
> 
> [Severity: Medium]
> Can calling disable_irq(dp->irq) inside the runtime_suspend callback cause an
> ABBA deadlock with analogix_dp_irq_thread()?
> 
> If dp->dev is runtime-resumed while no persistent runtime PM reference is
> held (for example, during pre-bind AUX transfers in
> analogix_dp_finish_probe(), or after analogix_dp_unbind()),
> analogix_dp_resume() enables dp->irq.  When the autosuspend timer later fires
> and an HPD interrupt arrives at the same time:
> 
> CPU0 (pm_wq)                      CPU1 (irq/analogix-dp)
> ------------                      ----------------------
> rpm_suspend(dp->dev)
>    runtime_status = RPM_SUSPENDING
>    ...
>    analogix_dp_suspend(dp)
>                                    analogix_dp_irq_thread()
>                                      pm_runtime_resume_and_get(dp->dev)
>                                        rpm_resume(dp->dev, RPM_GET_PUT)
>                                        /* waits for RPM_SUSPENDING */
>      disable_irq(dp->irq)
>        synchronize_irq(dp->irq)
>        /* waits for IRQ thread */
> 
>   *** DEADLOCK ***
> 
>>   	phy_power_off(dp->phy);
>>   
>>   	if (dp->plat_data->power_off)
>> @@ -1576,6 +1608,11 @@ int analogix_dp_resume(struct analogix_dp_device *dp)
>>   
>>   	analogix_dp_init_dp(dp);
>>   
>> +	if (analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_irq_enabled) {
>> +		enable_irq(dp->irq);
>> +		dp->hpd_irq_enabled = true;
>> +	}
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(analogix_dp_resume);
> 
> [Severity: High]
> Does enabling dp->irq in analogix_dp_resume() leave the HPD IRQ permanently
> enabled across runtime suspend on RK3576 and RK3588 boards with an eDP panel
> on the DP AUX bus?
> 
> dp->force_connected_mode is not initialized in analogix_dp_probe(); it is set
> later during analogix_dp_bind() -> drm_bridge_attach() ->
> analogix_dp_bridge_attach():
> 
> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bridge_attach() {
> 	...
> 	if (dp->bridge.next_bridge) {
> 		...
> 		dp->force_connected_mode = analogix_dp_bridge_force_connected(dp);
> 	}
> }
> 
> Before analogix_dp_bind() runs, analogix_dp_finish_probe() populates the DP
> AUX bus.  Probing the panel child runtime-resumes dp->dev while
> dp->force_connected_mode is still false, so
> analogix_dp_require_pm_for_hpd_irq(dp) returns true and analogix_dp_resume()
> enables dp->irq.
> 
> Once analogix_dp_bridge_attach() sets dp->force_connected_mode = true,
> analogix_dp_require_pm_for_hpd_irq(dp) becomes false.  When the 100 ms
> autosuspend delay expires, analogix_dp_suspend() skips disable_irq(dp->irq)
> and leaves dp->irq enabled while the PHY, power and clock are turned off.
> 
> In addition, because analogix_dp_resume() does not check whether the bridge
> is bound, any runtime resume during or after analogix_dp_unbind() (such as
> during drm_dp_aux_unregister(&dp->aux)) re-enables dp->irq while unbound,
> allowing analogix_dp_irq_thread() to use a stale dp->drm_dev.
> 

Looking back at the v6 review, I think I got bogged down in this and
made it much more complicated than it needs to be.

I will remove all the IRQ operations from analogix_dp_suspend() and
analogix_dp_resume(), and go back to the clean version where the IRQ
is enabled in bind and disabled in unbind, based on
analogix_dp_supports_hpd():

   analogix_dp_bind():
           if (analogix_dp_supports_hpd(dp))
                   enable_irq(dp->irq);

   analogix_dp_unbind():
           if (analogix_dp_supports_hpd(dp))
                   disable_irq(dp->irq);

So the IRQ lifetime follows the bridge lifetime, and neither the
pre-bind AUX transfers nor the post-unbind path touch dp->irq anymore.
There is also no disable_irq() in the runtime suspend callback, so the
deadlock with the IRQ thread is gone.

The only case left is a HPD edge at the very same moment the system
goes to sleep. I think that window is basically impossible to hit and
acceptable. Also, on Rockchip platforms, the unclocked MMIO access of
the eDP controller returns an invalid value but does not crash.

Best regards,
Damon

