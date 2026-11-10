Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACE606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CLS4xbqd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2B010EFB1;
	Tue, 10 Nov 2026 10:37:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 088E210EFAF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:36:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835441E7D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:36:51 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 588243F85F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794307014; bh=AqF58HrT3bhON+KbWlWZ11YZ8tIs9dlGm5SmVttprrQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CLS4xbqdYm2USKSDGwgAUngGw8UOPZmQfQiuyDA0qqQ61CUtXRaNUx6KIQ6Y1TdO4
 bHTAePHgR/0fQyUXFJ8uyonTTRocn0Nx6+Nony1BWFp7Tx5n+3CzxTfXlp9ZkphUaE
 zu+QAYdUAOLY4iwSdWgdi3qXHomMjjEd+XM55IyM=
Date: Tue, 10 Nov 2026 10:36:43 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: aiyengar1990@gmail.com
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] drm/panthor: Do not change the GPU clock rate while
 suspended
Message-ID: <avLzu40gKwgJJiNK@e142607>
References: <20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:15:00AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> From the start of panthor_device_suspend() until panthor_device_resume()
> has enabled the clocks again, the GPU clocks are off or about to be, and
> the GPU power domain may be down. devfreq can still call ->target() in
> that window: a write to min_freq or max_freq in sysfs, a thermal cooling
> state change or a PM QoS request all end up in update_devfreq() whatever
> the device state.
> 
> With the RK3588 GPU core clock switched to the firmware-managed
> SCMI_CLK_GPU (needed to reach the PVTPLL rates of the upper OPPs), such
> a call is fatal. To set a PVTPLL rate TF-A programs registers in the GPU
> GRF, which sit in the GPU power domain, and with the domain off that
> access ends in an asynchronous SError and a kernel panic, for example
> after
> 
>   echo 1000000000 > /sys/class/devfreq/fb000000.gpu/min_freq
> 
> while the GPU is runtime suspended.

Maybe what needs to be done is to disable the clock when the power domain
goes down.

> 
> Only apply a rate to the hardware while the device is resuming or
> active, plus the suspend frequency that devfreq_suspend_device() applies
> from the suspend path while the GPU is still powered. Other requests are
> still accepted and recorded by devfreq, which applies them on resume or
> at the next governor update.
> 
> The RFC this is based on (Jonas Karlman's panthor SCMI clock change,
> carried in Armbian's linux-rockchip pull request 380) checked the
> runtime PM status instead. That
> status is still RPM_SUSPENDING after panthor_devfreq_suspend() has run,
> which leaves a window where the rate can be raised again right before
> the power domain goes down. The devfreq suspend count cannot be used
> either: panthor's first runtime resume calls devfreq_resume_device()
> without a matching suspend, so the count is -1 while the GPU is active
> and 0 while it is suspended.
> 
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Tested on an Orange Pi 5 (RK3588S) with the GPU core clock switched to
> SCMI_CLK_GPU and a 200 MHz opp-suspend (the configuration from the RFC,
> not yet in mainline): writing min_freq while the GPU was runtime
> suspended no longer ends in an SError, the request takes effect at the
> next job (1 GHz measured), max_freq likewise; 200 suspend/resume cycles
> with short GPU jobs and a 3 minute sustained load ran without faults.
> With the mainline device tree (CRU clock, no suspend OPP) the SError is
> not reachable and the guard only skips rate changes while the GPU is
> powered down.
> 
> This patch was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit message, and I reviewed and tested it
> as described above.
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 42 ++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4af..cab86e9c9d46 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -60,20 +60,56 @@ static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
>  	pdevfreq->time_last_update = now;
>  }
>  
> +/*
> + * Whether a new rate can be applied to the hardware now.
> + *
> + * From the start of panthor_device_suspend() until panthor_device_resume()
> + * has enabled the clocks again, the GPU clocks are about to be disabled
> + * or are off, and the GPU power domain may be down. devfreq can still
> + * call ->target() in that window: sysfs
> + * min_freq/max_freq writes, thermal cooling and PM QoS requests all end
> + * up in update_devfreq() whatever the device state.
> + *
> + * Changing the rate then is pointless, and harmful where the core clock
> + * is managed by firmware: on RK3588, setting SCMI_CLK_GPU to a PVTPLL
> + * rate with the GPU power domain off makes TF-A access the powered-down
> + * GPU GRF, which ends in an asynchronous SError. So while the device is
> + * suspending only the suspend frequency, applied by
> + * devfreq_suspend_device(), reaches the hardware, and nothing does
> + * while it is suspended. devfreq records the other requests: they are
> + * applied on resume or at the next governor update.

Can this comment be rewritten to be less verbose?

> + */
> +static bool panthor_devfreq_can_set_rate(struct panthor_device *ptdev,
> +					 unsigned long freq)
> +{
> +	struct devfreq *devfreq = ptdev->devfreq ? ptdev->devfreq->devfreq : NULL;
> +
> +	switch (atomic_read(&ptdev->pm.state)) {
> +	case PANTHOR_DEVICE_PM_STATE_SUSPENDED:
> +		return false;
> +	case PANTHOR_DEVICE_PM_STATE_SUSPENDING:
> +		return devfreq && devfreq->suspend_freq &&
> +		       freq == devfreq->suspend_freq;
> +	default:
> +		return true;
> +	}
> +}
> +
>  static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
>  				  u32 flags)
>  {
> +	struct panthor_device *ptdev = dev_get_drvdata(dev);
>  	struct dev_pm_opp *opp;
> -	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  	dev_pm_opp_put(opp);
>  
> -	err = dev_pm_opp_set_rate(dev, *freq);
> +	if (!panthor_devfreq_can_set_rate(ptdev, *freq))
> +		return 0;

Hmm, why not return an error here? -EINVAL?

>  
> -	return err;
> +	return dev_pm_opp_set_rate(dev, *freq);
>  }
>  
>  static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)
> 
> ---
> base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
> change-id: 20261110-panthor-suspend-clk-11d5604fe5be
> 
> Best regards,
> --  
> Arun Iyengar <aiyengar1990@gmail.com>
> 
> 

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
