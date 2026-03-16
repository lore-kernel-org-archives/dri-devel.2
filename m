Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7074F506C6
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071A510E3B6;
	Mon, 16 Mar 2026 13:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kG6IivDu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228FC10E3B6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnfCoF6kk9UFd+P1uT4CSmsZmO1aUl3BcQJpTAMbKF+uTc0hJpmHtGqU4NfimOhKEO6SdkFFfFLcYz8fQIfOOOCarK0bWXgI2wa5lvbE3BrJn/ie6wM75X/++q1KstYlUGuWwS1WBSQlwy8CD3qapE4DNVDAw4ntfwHz0oMCPSGI273JUshWkQYSCep2JNwLy2phEesLYkPqO/Xztttcd98dR6lM3Nd0nfkqaWLKVHTT9YGg1SQUHy3Jrsb9egqTbgkeO1cd8lN6OdTClMeVirY0iztjk3LUAQe+L75vhejg4yUhBZkLEnApO+GRhaA8c1VlMSFs0jLikrNeCSdjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO9xWJiJgsMku5wtAL0nxK5xrPTRaF/n25cGSGRza44=;
 b=Ut6ptnhzbAkump45+fFLvgKoYV2BHBnVHABD/TSlqIBgLPQhZBV6Bxwx2wadG0Z6TI2PC5f6JvSQ24tDb99dcNFCr2iFaaQqJGC2h/Qf19vGy22/s7OavonbmU6adBQUWWOwex8VkG4I5F0ZbljlfzseUqq12NGl0onNonOOLLr3uIw9V/XSNWQDqxM4JusjK1LwIwxwiPQWLXTSoIzaDRsVKz2WJsax+gnbHIIoYx5JEYzWTwAE/NVWueIy4pfsqq9BxnZdH7518pWA6P0xM839rZuDBHy4AsAibMcmEF+5dI3g8PtLMQtzAwBrRF6FmvSk6y2vi+07tlo4IWYptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO9xWJiJgsMku5wtAL0nxK5xrPTRaF/n25cGSGRza44=;
 b=kG6IivDueHFIMGQcH0rI6e9q7o+sP3IojpGbtFdJdGCtmPRruIL+7wFC5EJ96uZwoC8W9tqo8XhehC7zJLm1rsPiG/zCOblbhED/BnGW9gmqZ6XUdWf1a9UGinP/CZi1sGVTX5D8+xzyDU7I3nqvhiIfJt88Twctx6+P6r5eG9A=
Received: from SJ0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:a03:3a0::17)
 by LV8PR10MB7920.namprd10.prod.outlook.com (2603:10b6:408:1fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 13:00:47 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::d5) by SJ0PR03CA0252.outlook.office365.com
 (2603:10b6:a03:3a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 13:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 13:00:46 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 08:00:46 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 08:00:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 08:00:45 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com
 [172.24.233.62])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62GD0e0A842175;
 Mon, 16 Mar 2026 08:00:41 -0500
Message-ID: <b267202b-3971-43c0-927f-6320517161d6@ti.com>
Date: Mon, 16 Mar 2026 18:30:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: Abhash Kumar Jha <a-kumar2@ti.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <u-kumar1@ti.com>, <sjakhade@cadence.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <p-mantena@ti.com>,
 <tomi.valkeinen@ideasonboard.com>
References: <20260205085233.81678-1-a-kumar2@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260205085233.81678-1-a-kumar2@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|LV8PR10MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 724de2f3-bc99-441a-30bd-08de835c0a6d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5lqKI2ST2HStBBv2BhxzE45qLI3GgkDOJl9Q4FbkNCFdg58ONZ6Po+XGc4E3F/UhTLMPL2iUWy8H4O8yQOm4SZVGwee75KVdhhBjXGvRPC2Fp8o1Wp8DQl6xUK7dFu8HX8Xfc5flivqqsyjPFe1REE4aTl4I7+YLwyHZUpwAAyM9Q9D/9KH+6R90y8Uq29ONqN8KBhayCXkVpjqoLib3B1lZ1AvK8ENYbOjtrDrkBk2AjlqMWBlVs4zm9jgIfqVN9mlFw00n2L86O7NVPfVXCpMZVytHlBLQwOeR2dNA7lpsdlLLlJviM7VRVJXS40J68Mh6xmqttD8F3Na9+KJPnmQ3YmD7hCPF4ssl4Au4kwDcV8Q47EkwK9ALRfpauoHh3chzgfWAK/I4nfaMmdzdW42/D9e++d7vEgkOD4FnByIunBx5WjletdsPd/ebhjXp6RZaAD+ymp6S0OgHLIqv/PbNK465zYpYYWetUtrPmsPcqzY5EWU8imP0InPV5NKs1tk9jBX06bS1IGY3pf4GIkzkktUztGjYYfTS9sTlqMIuUZbdqZqkCT1iK6/j9Fn5MgJgtUsTqxpjI3LsxNitgzTCGpvvJZOYxnf4IUBPYl/vYV956Id1x+X7cV63BqZdK0r8eewm+28TSHy1PcZD2YJNdiXu0T2MVnrizzAsBKWk6DLyQ8ZpAylsbTg1wUPIdeeXg0An4v3EX0JsoYT9OrENpAfRBlws9IhdXEjD00RnfVLJDT3GXnJ/a8Pzb63AOZJI8CGY/UZ49ZMUylauyNQAqx3onRSMFFPNlCSnBwWUiSMZCOIwkUUrQnm2Fhap
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a3FvAkNqscDEf6bd65u3YhTLjBl+XcOmiUuLXpcqD12nADtnoE5HDn9JpNgTyoT+gaTDih1vKRN30ALNFyV/4U1PAMhOT4EYCwnm67qSsw7v/haz2l9iCx4WklqDNJ9C272WziXDdQveHf3crRvAczVXdr0zkWHiSVfhChMiMNLUgHsb4VSYw1qg9VQ1ZQ71f18kW616LNShVkqT43HDd8v0BqqYvXEQcQMY7SuV6x2+hSN60qza76hgiMmVg63J3dSl8ZHbvg4qG1Bc1eaWzJdy0Zag7DKskTf247jNOg9GYrit/wK7tvneZudfAAhqSwcB2bO57/joLplDZgmDMu45VNfoNl0TZqFi6eWoPw57rFKSK2/4jYt0IsA3lxHRoLTxJT7OZfJF7DqA9WWazmt3a6zRmqH9jzbPqSpk7GqU3EA+ABAMMojHXOnLdbrg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:00:46.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724de2f3-bc99-441a-30bd-08de835c0a6d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7920
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

Hi Abhash,

Thanks for the patch.

On 05/02/26 14:22, Abhash Kumar Jha wrote:
> Add system suspend and resume hooks to the cdns-mhdp8546 bridge driver.
> 
> While resuming we either load the firmware or activate it. Firmware
> is loaded only when resuming from a successful suspend-resume cycle.
> 
> If resuming due to an aborted suspend, loading the firmware is not
> possible because the uCPU's IMEM is only accessible after a reset and the
> bridge has not gone through a reset in this case. Hence, Activate the
> firmware that is already loaded.
> 
> Use GENPD_NOTIFY_OFF genpd_notifier to get the power domain status of
> the bridge and accordingly load the firmware.
> 
> Additionally, introduce phy_power_off/on to control the power to the phy.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> ---
> Changes in v2:
> - Fixed defined but not used [-Wunused-function] warning for suspend and resume calls.
> - Link to v1: https://lore.kernel.org/all/20260129112016.2448037-1-a-kumar2@ti.com/
> 
>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 136 +++++++++++++++++-
>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   4 +
>   2 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 38726ae1bf150..818eef1a57ffb 100644
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
> @@ -2383,6 +2384,120 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
>   	}
>   }
>   
> +static int __maybe_unused cdns_mhdp_resume(struct device *dev)
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

mhdp->powered_off = false ??

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
> +static int __maybe_unused cdns_mhdp_suspend(struct device *dev)
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
> +		return -EINVAL;

return -ETIMEDOUT?

> +	}
> +	mhdp->hw_state = MHDP_HW_STOPPED;

Above should be inside if block i..e if hw state was not ready.

> +	spin_unlock(&mhdp->start_lock);
> +
> +	if (ret == 0) {
> +		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", __func__);
> +		ret = -ETIMEDOUT;
> +		goto error;
> +	} else {
> +		ret = cdns_mhdp_set_firmware_active(mhdp, false);
> +		if (ret) {
> +			dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", ERR_PTR(ret));

At this point don;t you need to
phy_power_off/phy_exit/clk_disable_unprepare, and restore hw_state to 
MHDP_HW_READY ?
> +			goto error;
> +		}
> +	}
> +
> +	phy_power_off(mhdp->phy);
> +	phy_exit(mhdp->phy);
> +	clk_disable_unprepare(mhdp->clk);
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

Should we reset powered_off flag for GENPD_NOTIFY_ON?
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cdns_mhdp_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cdns_mhdp_suspend, cdns_mhdp_resume)
> +};

Have you considered using below ?
   static DEFINE_SIMPLE_DEV_PM_OPS(cdns_mhdp_pm_ops, 
  

                                    cdns_mhdp_suspend, cdns_mhdp_resume);
> +
>   static int cdns_mhdp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -2494,6 +2609,11 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
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
> @@ -2504,21 +2624,33 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>   
>   	ret = cdns_mhdp_load_firmware(mhdp);
>   	if (ret)
> -		goto phy_exit;
> +		goto power_off;
>   
>   	if (mhdp->hdcp_supported)
>   		cdns_mhdp_hdcp_init(mhdp);
>   
>   	drm_bridge_add(&mhdp->bridge);

I think good to add bridge only after pm notifier is successfully added, 
otherwise you have to remove the bridge before adding.
>   
> +	mhdp->powered_off = false;
> +	mhdp->pd_nb.notifier_call = mhdp_pd_notifier_cb;
> +	ret = dev_pm_genpd_add_notifier(mhdp->dev, &mhdp->pd_nb);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to add power domain notifier\n");
> +		dev_pm_genpd_remove_notifier(mhdp->dev);

If add_notifier failed already why need to do above remove ?

> +		goto power_off;
> +	}

Also for non-gen-pd platforms this would pretty much restrict usage of 
this driver, is that expected/desired behaviour ?
> +
>   	return 0;
>   
> +power_off:
> +	phy_power_off(mhdp->phy);
>   phy_exit:
>   	phy_exit(mhdp->phy);
>   plat_fini:
>   	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
>   		mhdp->info->ops->exit(mhdp);
>   runtime_put:
> +	mhdp->powered_off = true;

probe is anyway failing so why need to set above flag given it would be 
reset on driver probe again ?

Regards
Devarsh

>   	pm_runtime_put_sync(dev);
>   	pm_runtime_disable(dev);
>   
> @@ -2550,6 +2682,7 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
>   				ERR_PTR(ret));
>   	}
>   
> +	phy_power_off(mhdp->phy);
>   	phy_exit(mhdp->phy);
>   
>   	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
> @@ -2581,6 +2714,7 @@ static struct platform_driver mhdp_driver = {
>   	.driver	= {
>   		.name		= "cdns-mhdp8546",
>   		.of_match_table	= mhdp_ids,
> +		.pm = &cdns_mhdp_pm_ops,
>   	},
>   	.probe	= cdns_mhdp_probe,
>   	.remove = cdns_mhdp_remove,
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> index bad2fc0c73066..b06dd5e44aafd 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> @@ -412,6 +412,10 @@ struct cdns_mhdp_device {
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

