Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43100C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1088113945;
	Tue,  2 Jun 2026 08:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QfBoCmyE";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 08:36:07 UTC
Received: from mail-m60122.netease.com (mail-m60122.netease.com
 [210.79.60.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F502113945
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:36:06 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40bc4550f;
 Tue, 2 Jun 2026 16:31:00 +0800 (GMT+08:00)
Message-ID: <4f4ff085-80ae-4144-b040-be9b136574ee@rock-chips.com>
Date: Tue, 2 Jun 2026 16:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
 <20260501-synopsys-dw-dp-improvements-v2-7-d7e7f6bac77f@collabora.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-7-d7e7f6bac77f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e87751e4e03a7kunm8e11791c2d3216
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQklJVkseS0pITE9KTUtOSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=QfBoCmyEgpoenhswOoF/yKeUbTuxC9EVhGvEaAxRGsfG65iwiUWilCqWRkQMXBJJJRpVEwrSs1M1osaREHDbW7weEXveiQmAc1431woQ92hbOWFgBun80jvoxHNSm4sVE50IyzGNKvhAwX5f3PfPxGXAK/ouRy8shvw1IMoYgS4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=JAIbtg6t1nkmAMDBYVOgCCRD8NVdgH1lo/7QZXXpTgs=;
 h=date:mime-version:subject:message-id:from;
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

Hi Sebastian,

On 5/1/2026 6:20 AM, Sebastian Reichel wrote:
> Implement out-of-band hotplug handling, which will be used to receive
> external hotplug information from the USB-C state machine. This is
> currently handled by the USBDP PHY, which brings quite some trouble
> as the register being accessed requires the power-domain from the DP
> controller and also requires custom TypeC HPD info parsing in the
> USBDP PHY driver.
> 
> In contrast to the USBDP PHY this does not just enable the hotplug
> signal when a DP AltMode capable adapter is plugged in, but instead
> properly detects if a cable is plugged in for things like USB-C to
> HDMI adapters.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

[...]

> +static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
> +{
> +	struct rockchip_dw_dp *dp = data;
> +	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
> +
> +	dev_dbg(dp->dev, "Force HPD connected=%s\n", str_yes_no(hpd));
> +
> +	dp->hpd_cfg = hpd;
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));

FIELD_PREP_WM16() should be used here because "dp->hpd_cfg" is not a
constant expression.

Other patches in this series have similar issues. Doesn't your compiler
warn you about this? Thanks.

-- 
Best, 
Chaoyi
