Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6DAFF492D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 01:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D715010E09E;
	Mon, 30 Mar 2026 01:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eZpEmZWw";
	dkim-atps=neutral
Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com
 [220.197.31.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C43010E06D
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 01:13:34 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 38bce2746;
 Mon, 30 Mar 2026 09:13:28 +0800 (GMT+08:00)
Message-ID: <4396e94d-7b88-4599-a938-3c1932a2f9cb@rock-chips.com>
Date: Mon, 30 Mar 2026 09:13:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/bridge: dw-hdmi: document the output_port field
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Liu Ying <victor.liu@nxp.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-4-479a04133e70@bootlin.com>
 <050c6532-8122-4ded-9946-3ce1a86d2be0@nxp.com>
 <ea1bf890-c4be-4d66-ad26-a6bdb58a9292@rock-chips.com>
 <DHDIOSVSDG9W.B7BW87297KT3@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DHDIOSVSDG9W.B7BW87297KT3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9d3c4d8ad603a3kunmb6afc6b9975c61
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04eHVZNQh8ZQk9LGRpMGU9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=eZpEmZWwwaSjIoUWR6mYxenV4TR5LI+XqrvotvfyareVQaqofwzjO8DCxa63FCKucjvKG7JGK5gLX37AaRGA6O5Rb6yJ+vuGm55mkxI2CXeGCkW2a+TIrySRAMfp6z5Try+v9TYYmxFfW6CCywhiE/Fixei6bMGmCZmJgV8nz9I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2q+SKMvTSwvw8pBudKi7sI2w6VGkdqOlh8f4io4a83Q=;
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

On 3/27/2026 7:10 PM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On Thu Mar 26, 2026 at 10:15 AM CET, Damon Ding wrote:
>> On 3/26/2026 3:25 PM, Liu Ying wrote:
>>> Hi Luca,
>>>
>>> On Fri, Mar 20, 2026 at 11:46:15AM +0100, Luca Ceresoli wrote:
>>>> The meaning of this flag may not be obvious at first sight.
>>>>
>>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>>> ---
>>>>    include/drm/bridge/dw_hdmi.h | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>
>> First of all, these changes related to the DW HDMI controller work well
>> when tested on RK3399 HDMI.
> 
> Great!
> 
> You'd be welcome to send your Tested-by: tag if you tested the series on
> hardware, that would be useful.
> 
> However at this point I suggest to wait for v2, which I'm sending soon, and
> test that. I added you in Cc for it.
> 
>>>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>>>> index 336f062e1f9d..45f6ba1a8ee1 100644
>>>> --- a/include/drm/bridge/dw_hdmi.h
>>>> +++ b/include/drm/bridge/dw_hdmi.h
>>>> @@ -126,6 +126,11 @@ struct dw_hdmi_phy_ops {
>>>>    struct dw_hdmi_plat_data {
>>>>    	struct regmap *regm;
>>>>
>>>> +	/*
>>>> +	 * The HDMI output port number (which must be 1) if it is described
>>>
>>> I'd rephrase:
>>> The HDMI output port number must be 1 ...
>>>
>>
>> Yes, the output port number should be 1, but I found that the output
>> port number in the Rockchip-side dw-hdmi driver remains 0.
> 
> Really? I checked all the bindings in
> Documentation/devicetree/bindings/display/rockchip/*hdmi* and all mention
> port@1 as the output port number. Can you point to code using port@0 as the
> output port?
> 
> Should it be true, that would be unfortunate because the output_port
> variable does not handle this case. It's used as a sort of bool-or-int
> variable:
> 
>   * as a bool [0] to find out whether the DT is supposed to describe the
>     output port
>   * as an integer to tell the port number to parse in DT [1]
> 
> So saying "please parse port 0" is impossible.
> 
> [0] https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L3310
> [1] https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L3315
> 

Aha, my description might be a little misleading. The 
&dw_hdmi_plat_data.output_port is 0 on the Rockchip side, so the next 
bridge will not be parsed for it.

Then I think the &dw_hdmi_plat_data.output_port should be 1, as this 
helps support the hdmi-connector and other bridge chips.

>> Therefore, it may be better to adapt the dw-hdmi drivers across all
>> platforms to the bridge-connector architecture simultaneously.
>>
>> This would allow removing &dw_hdmi_plat_data.output_port and unify the
>> setting of DRM_BRIDGE_ATTACH_NO_CONNECTOR during the attach stage.
>> (Just as the Analogix DP driver does [0])
>>
>> [0]
>> https://lore.kernel.org/all/20260319071452.1961274-1-damon.ding@rock-chips.com/
> 
> I agree converting all users is a good goal, but I disagree it should be
> done simultaneously. There are various users of dw-hdmi, and converting one
> having the hardware to test it was painful enough for me. Converting all of
> them without testing on hardware would be a hell.
> 
> However I might be wrong. Having a precise list of all users, which ones
> need to be converted, and whether they have any special detail to be taken
> care of would be good to estimate the work to convert all users. Without
> that I'd rather let users convert one by one and hopefully get rid of
> legacy code eventually.
> 

Yes, I've noticed that there are quite a few drivers associated with the 
DW HDMI controller. It would be a better idea to let users handle this 
themselves.

BTW: The Rockchip side dw-hdmi patches for bridge connector support will 
be updated as a follow-up to your patch series. :-)

Best regards,
Damon

