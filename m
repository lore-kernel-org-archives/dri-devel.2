Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E15CC6B33
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5F110E33A;
	Thu,  2 Apr 2026 09:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="V7uC7gz5";
	dkim-atps=neutral
Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com
 [220.197.31.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F420610E33A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:05:12 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 394c16600;
 Thu, 2 Apr 2026 17:05:03 +0800 (GMT+08:00)
Message-ID: <571cc85a-3310-4b56-a3ef-3aab698192f6@rock-chips.com>
Date: Thu, 2 Apr 2026 17:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] drm/bridge: dw-hdmi: document the output_port
 field
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-5-c7f2af536a24@bootlin.com>
 <cd0acf08-de24-4fec-a4de-0cd5b1eeeb28@rock-chips.com>
 <DHII3VS5NVEC.179WKXX8C8SOO@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DHII3VS5NVEC.179WKXX8C8SOO@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9d4d705f9803a3kunm9716d1d893077
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwdTFYaQxgYSRgYTE4fGUhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
 pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=V7uC7gz5vuVdP8g6TaJjdkO1IMcNDZzxPxF5ZB9843pwJZFzjHlo989JUzBxE48S8cBkykbaMpElWfSZ4w0Z75NrpDPGLCY2530ZMDwiMr7NFEcRXXbBqhmoJ8MSxQIhmOxYwmJk+bYA+fEPPpeM7coiYumKjpFHrZIqrDJkBsU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=3r+EdcEZhhq3RLdMIkHrVztelasB3cEPklRvu3iRcJY=;
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

Hi Luca,

On 4/2/2026 3:46 PM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On Tue Mar 31, 2026 at 9:21 AM CEST, Damon Ding wrote:
>> On 3/31/2026 3:25 AM, Luca Ceresoli wrote:
>>> The meaning of this flag may not be obvious at first sight.
>>>
>>> Reviewed-by: Liu Ying <victor.liu@nxp.com>
>>> Tested-by: Martyn Welch <martyn.welch@collabora.com>
>>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> Thanks for looking at this series!
> 
>>> @@ -126,6 +126,12 @@ struct dw_hdmi_phy_ops {
>>>    struct dw_hdmi_plat_data {
>>>    	struct regmap *regm;
>>>
>>> +	/*
>>> +	 * The HDMI output port number must be 1 if the port is described
>>> +	 * in the device tree. 0 if the device tree does not describe the
>>> +	 * next component (legacy mode, i.e. without
>>> +	 * DRM_BRIDGE_ATTACH_NO_CONNECTOR flag when attaching bridge).
>>> +	 */
>>>    	unsigned int output_port;
>>>
>>>    	unsigned long input_bus_encoding;
>>>
>>
>> Tested-by: Damon Ding <damon.ding@rock-chips.com> (on rk3399)
> 
> Uhm, I'm not sure what can be tested in a patch only adding a comment. Did
> you mean 'Reviewed-by' maybe?
> 
> Also, I _think_ the best syntax for a comment would be using a '#', not
> parentheses, so that would be
> 
> | Tested-by: Damon Ding <damon.ding@rock-chips.com> # on rk3399
> 
> This is the recommended syntax for the 'Cc: stable' lines [0], at
> least. Additionally b4 keeps comments with the '#' as those in [1], while
> is discards the ones in parentheses.
> 
> [0] https://docs.kernel.org/process/stable-kernel-rules.html
> [1] https://lore.kernel.org/all/2948177.mvXUDI8C0e@steina-w/
> 

Indeed, '#' is much better.

I think we still need to further discuss the various cases around 
DRM_BRIDGE_ATTACH_NO_CONNECTOR in [PATCH v2 06/10].

Best regards,
Damon

