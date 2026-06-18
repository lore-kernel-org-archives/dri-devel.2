Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CABCD98E2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C64C10ED1A;
	Thu, 18 Jun 2026 08:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bTDkHccx";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF2510ED1A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 08:49:14 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B0D2397F;
 Thu, 18 Jun 2026 10:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781772518;
 bh=PP8uNh2cYni72qFdKH5mTFFR+haPMhWikit/EYxn718=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bTDkHccxCm723Z6OK9mnOZWhRHUoG6dol9PNHCt1N4rFh0lCc8MFLBz+FPMJu3WiI
 6/DOIguj/o3eQWG8Zo3v+SMYVRHZwlZ+KRxcmNZk/oLSF7uZ+dnno2zvvg9yy8l222
 aovnMtvgk/MHev6NuEnwkJsx3Hrm8mMDSw2qvDTc=
Message-ID: <3dbf5a77-c314-4511-ab63-1b1ecd2e16c1@ideasonboard.com>
Date: Thu, 18 Jun 2026 11:49:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: Abhash Kumar Jha <a-kumar2@ti.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, s-jain1@ti.com, y-d@ti.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 devarsht@ti.com, u-kumar1@ti.com, sjakhade@cadence.com
References: <20260601095041.3042950-1-a-kumar2@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260601095041.3042950-1-a-kumar2@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 01/06/2026 12:50, Abhash Kumar Jha wrote:
> Add system suspend and resume hooks to the cdns-mhdp8546 bridge driver.
> 
> While resuming we either load the firmware or activate it. Firmware
> is loaded only when resuming from a successful suspend-resume cycle.

It's not clear from the patch if this is a fix or improvement. It sounds 
a bit like a fix, but it doesn't mention any kind of issue in the 
driver. So, why is this patch needed?

> If resuming due to an aborted suspend, loading the firmware is not
> possible because the uCPU's IMEM is only accessible after a reset and the
> bridge has not gone through a reset in this case. Hence, Activate the
> firmware that is already loaded.
> 
> Use genpd_notifier to get the power domain status of the bridge and
> accordingly load the firmware.
> 
> Additionally, introduce phy_power_off/on to control the power to the phy.

If you write "also" or "additionally" or such in a commit desc, you 
should stop and think if that part should actually be a separate patch. 
Also, why is that change needed?

Overall, this sounds fragile/hacky to me.

The first thing is that usually you shouldn't use system suspend/resume 
in a bridge driver. When a system suspend happend, the display pipeline 
will be disabled, so this driver will get an atomic_disable() call, and 
enable when resuming. You can use runtime PM hooks if you need 
resume/suspend hooks.

The second thing is the PD notifier. Is there really no way we can see 
the state from the MDHP IP registers?

  Tomi

> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> ---
> Hi,
> 
> Changes in v3:
> - Register genpd_notifier callback only when genpd is available.
> - Mark mhdp->powered_off = false after resume is successful.
> - Use SIMPLE_DEV_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
> - Set mhdp->hw_state appropriately in error paths.
> - Link to v2: https://lore.kernel.org/all/20260205085233.81678-1-a-kumar2@ti.com/
> 
> Changes in v2:
> - Fixed defined but not used [-Wunused-function] warning for suspend and resume calls.
> - Link to v1: https://lore.kernel.org/all/20260129112016.2448037-1-a-kumar2@ti.com/
> 
> Thanks and Regards,
> Abhash
> 
>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 138 +++++++++++++++++-
>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   4 +
>   2 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 99888f8d55736..90d8c037a2220 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -32,6 +32,7 @@
>   #include <linux/phy/phy.h>
>   #include <linux/phy/phy-dp.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>   #include <linux/slab.h>
>   #include <linux/wait.h>
>   
> @@ -2287,6 +2288,121 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
>   	drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
>   }
>   
> +static int cdns_mhdp_resume(struct device *dev)
> +{
> +	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
> +	unsigned long rate;
> +	int ret;
> +
> +	ret = clk_prepare_enable(mhdp->clk);
> +	if (ret)
> +		return ret;
> +
> +	rate = clk_get_rate(mhdp->clk);
> +	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
> +	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
> +	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
> +
> +	ret = phy_init(mhdp->phy);
> +	if (ret) {
> +		dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
> +		goto disable_clk;
> +	}
> +	ret = phy_power_on(mhdp->phy);
> +	if (ret < 0) {
> +		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
> +		goto error;
> +	}
> +
> +	if (mhdp->powered_off) {
> +		ret = cdns_mhdp_load_firmware(mhdp);
> +		if (ret)
> +			goto phy_off;
> +
> +		ret = wait_event_timeout(mhdp->fw_load_wq,
> +					mhdp->hw_state == MHDP_HW_READY,
> +					msecs_to_jiffies(1000));
> +		if (ret == 0) {
> +			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
> +				__func__);
> +			ret = -ETIMEDOUT;
> +			goto phy_off;
> +		}
> +	} else {
> +		ret = cdns_mhdp_set_firmware_active(mhdp, true);
> +		if (ret) {
> +			dev_err(mhdp->dev, "Failed to activate firmware (%pe)\n", ERR_PTR(ret));
> +			goto phy_off;
> +		}
> +	}
> +
> +	mhdp->powered_off = false;
> +	return 0;
> +
> +phy_off:
> +	phy_power_off(mhdp->phy);
> +error:
> +	phy_exit(mhdp->phy);
> +disable_clk:
> +	clk_disable_unprepare(mhdp->clk);
> +
> +	return ret;
> +}
> +
> +static int cdns_mhdp_suspend(struct device *dev)
> +{
> +	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
> +	unsigned long timeout = msecs_to_jiffies(100);
> +	int ret = 0;
> +
> +	cancel_work_sync(&mhdp->hpd_work);
> +	ret = wait_event_timeout(mhdp->fw_load_wq,
> +				 mhdp->hw_state == MHDP_HW_READY,
> +				 timeout);
> +
> +	spin_lock(&mhdp->start_lock);
> +	if (mhdp->hw_state != MHDP_HW_READY) {
> +		spin_unlock(&mhdp->start_lock);
> +		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +	mhdp->hw_state = MHDP_HW_STOPPED;
> +	spin_unlock(&mhdp->start_lock);
> +
> +	ret = cdns_mhdp_set_firmware_active(mhdp, false);
> +	if (ret) {
> +		dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", ERR_PTR(ret));
> +		spin_lock(&mhdp->start_lock);
> +		mhdp->hw_state = MHDP_HW_READY;
> +		spin_unlock(&mhdp->start_lock);
> +		goto error;
> +	}
> +
> +	phy_power_off(mhdp->phy);
> +	phy_exit(mhdp->phy);
> +	clk_disable_unprepare(mhdp->clk);
> +
> +	/* if no power domain available, always reload firmware on resume */
> +	if (!mhdp->dev->pm_domain)
> +		mhdp->powered_off = true;
> +
> +error:
> +	return ret;
> +}
> +
> +static int mhdp_pd_notifier_cb(struct notifier_block *nb,
> +			unsigned long action, void *data)
> +{
> +	struct cdns_mhdp_device *mhdp = container_of(nb, struct cdns_mhdp_device, pd_nb);
> +
> +	if (action == GENPD_NOTIFY_OFF)
> +		mhdp->powered_off = true;
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(cdns_mhdp_pm_ops, cdns_mhdp_suspend, cdns_mhdp_resume);
> +
>   static int cdns_mhdp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -2401,6 +2517,11 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>   		dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
>   		goto plat_fini;
>   	}
> +	ret = phy_power_on(mhdp->phy);
> +	if (ret < 0) {
> +		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
> +		goto phy_exit;
> +	}
>   
>   	/* Initialize the work for modeset in case of link train failure */
>   	INIT_WORK(&mhdp->modeset_retry_work, cdns_mhdp_modeset_retry_fn);
> @@ -2411,15 +2532,26 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>   
>   	ret = cdns_mhdp_load_firmware(mhdp);
>   	if (ret)
> -		goto phy_exit;
> +		goto power_off;
>   
>   	if (mhdp->hdcp_supported)
>   		cdns_mhdp_hdcp_init(mhdp);
>   
> -	drm_bridge_add(&mhdp->bridge);
> +	mhdp->powered_off = false;
> +	if (mhdp->dev->pm_domain) {
> +		mhdp->pd_nb.notifier_call = mhdp_pd_notifier_cb;
> +		ret = dev_pm_genpd_add_notifier(mhdp->dev, &mhdp->pd_nb);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "failed to add power domain notifier\n");
> +			goto power_off;
> +		}
> +	}
>   
> +	drm_bridge_add(&mhdp->bridge);
>   	return 0;
>   
> +power_off:
> +	phy_power_off(mhdp->phy);
>   phy_exit:
>   	phy_exit(mhdp->phy);
>   plat_fini:
> @@ -2457,6 +2589,7 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
>   				ERR_PTR(ret));
>   	}
>   
> +	phy_power_off(mhdp->phy);
>   	phy_exit(mhdp->phy);
>   
>   	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
> @@ -2488,6 +2621,7 @@ static struct platform_driver mhdp_driver = {
>   	.driver	= {
>   		.name		= "cdns-mhdp8546",
>   		.of_match_table	= mhdp_ids,
> +		.pm = pm_sleep_ptr(&cdns_mhdp_pm_ops),
>   	},
>   	.probe	= cdns_mhdp_probe,
>   	.remove = cdns_mhdp_remove,
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> index 2041ffbc019a5..31dbeaf33ccb6 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> @@ -413,6 +413,10 @@ struct cdns_mhdp_device {
>   
>   	struct cdns_mhdp_hdcp hdcp;
>   	bool hdcp_supported;
> +
> +	/* Power domain status notifier */
> +	struct notifier_block pd_nb;
> +	bool powered_off;
>   };
>   
>   #define connector_to_mhdp(x) container_of(x, struct cdns_mhdp_device, connector)

