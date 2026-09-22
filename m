Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F32C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A2A10EBFD;
	Tue, 22 Sep 2026 08:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VUMZwH3Z";
	dkim-atps=neutral
Received: from mail-m9326.xmail.ntesmail.com (mail-m9326.xmail.ntesmail.com
 [103.126.93.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C046A10EB4B;
 Tue, 22 Sep 2026 08:54:10 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4eb501a7b;
 Tue, 22 Sep 2026 16:54:04 +0800 (GMT+08:00)
Message-ID: <5a411d61-18f4-4d12-9acf-78320ab97d6b@rock-chips.com>
Date: Tue, 22 Sep 2026 16:54:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] drm/bridge: analogix_dp: don't create a
 panel_bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa
 <asrivats@redhat.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-19-83afb4f1a707@bootlin.com>
 <975a4d45-9a61-4858-b498-8bc0a1e44746@rock-chips.com>
 <96882735-091f-49c6-a47b-5da8be711818@rock-chips.com>
 <DLLOW2ROGP6L.3GTVT76VYPGAU@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DLLOW2ROGP6L.3GTVT76VYPGAU@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c8527e9a03a8kunm0c11385e8262e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQk8YVh5KTU4fTBpIHUJPSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=VUMZwH3ZKyjnCH60Goi5U3Vl4nFl+MAx1A1qjQ4sQPJsJELH/axOKlZpuWVXdpUvCCP00441WDmikcC3zP82z6IUPyTAT3cyO6aUOORiTTynOxObIcFhdpn7WhshuvAgZWqwqWeg91ArKUw1BugGOb8+J2UJCAexwN2J2SQ4UZo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nxecp8OUY0Lx57p1dANxfv0uvDW3w9nGB0PrL1gdmKA=;
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

On 9/22/2026 4:07 PM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On Mon Sep 21, 2026 at 8:34 AM CEST, Damon Ding wrote:
>> On 9/21/2026 11:07 AM, Damon Ding wrote:
>>> Hi Luca,
>>>
>>> On 9/16/2026 9:45 PM, Luca Ceresoli wrote:
>>>> Now a panel_bridge is automatically created for every drm_panel and the
>>>> panel-bridge API is just a deprecated wrapper to access it.
>>>>
>>>> Update and simplify the code by just getting a reference to the
>>>> already-existing bridge using of_drm_get_bridge_by_endpoint().
>>>>
>>>> As of_drm_get_bridge_by_endpoint() returns a refcounted bridge, take care
>>>> of putting the bridge reference. This is not easily done in the remove
>>>> path
>>>> due to the different probe paths of the user drivers, so add a devm
>>>> action
>>>> to ensure the reference is put only when it was taken.
>>>>
>>>> Assisted-by: opencode:deepseek-v4-flash-0731
>>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>>> ---
>>>>    drivers/gpu/drm/bridge/analogix/Kconfig            |  1 -
>>>>    drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 40 ++++++++++++
>>>> +---------
>>>>    drivers/gpu/drm/exynos/exynos_dp.c                 | 36 +
>>>> +-----------------
>>>>    drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  9 -----
>>>>    include/drm/bridge/analogix_dp.h                   |  1 -
>>>>    5 files changed, 25 insertions(+), 62 deletions(-)
>>>>
>>
>> [snip]
>>
>>>> @@ -488,14 +487,6 @@ static void rockchip_dp_remove(struct
>>>> platform_device *pdev)
>>>>    {
>>>>        struct rockchip_dp_device *dp = platform_get_drvdata(pdev);
>>
>> The above unused &rockchip_dp_device could be also remved.
> 
> Ah, indeed!
> 
> I guess I can keep your review tags if applying this patch with only this
> line removed. Correct?
> 

Yeah, sure!

Best regards,
Damon

