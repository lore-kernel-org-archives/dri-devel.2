Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F83CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F61310E5CF;
	Tue, 19 May 2026 15:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aIM7oERC";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DC210E5CF
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779204619;
 bh=UysSrWx2IaBnmq7p+RKc3cNjOUxboHqJt85KySMdL0U=;
 b=aIM7oERCarIdwvrQ+3pvSP3goxBlXAdBKo/8Ar8wRRnvT4B2rN/BGRKPeQmdjQOwkxhulXbf+
 Ah7y2A9a7mgZgm2DkM8tU/o4gvSxldaS+eoutPBGXG2vOc2QE/K86iFPFdh9bMbp1MsXQt704hz
 MkMtUS7KeDHY7GmJGFAdBPVEcBmGMRI5LX8GPPiH8H5rxRRn819E8/d2VeRRPBoSJAFwnRlOADq
 N3E3v0hPj5qKlDqNi9TkXJC2FcM1aEUdRdh3SuxjJX1pUYFK6OhPut4MzcXPRBKNSWpbyqpt/0C
 Go2Q4lNydZ7OR9ysnaJ5LqCgBe9HDyN6dq2MK8P0EB4g==
X-Forward-Email-ID: 6a0c7f56b6cbacb3a8d0c696
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e90eddfc-2f57-418a-ae05-43a411d72b99@kwiboo.se>
Date: Tue, 19 May 2026 17:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/23] drm: bridge: dw_hdmi: Hold bridge ref until
 connector cleanup
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Liu Ying <victor.liu@nxp.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Chen-Yu Tsai <wens@kernel.org>, Christian Hewitt
 <christianshewitt@gmail.com>, Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260518180206.2480119-1-jonas@kwiboo.se>
 <20260518180206.2480119-5-jonas@kwiboo.se>
 <177919241969.545972.18169905222569864569.b4-review@b4>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <177919241969.545972.18169905222569864569.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
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

Hello Luca,

On 5/19/2026 2:06 PM, Luca Ceresoli wrote:
> On Mon, 18 May 2026 18:01:40 +0000, Jonas Karlman <jonas@kwiboo.se> wrote:
> 
> Hello Jonas,
> 
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index b7bfc0e9a6b2..9d795c550f8a 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2600,10 +2609,14 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
>>  
>>  	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_funcs);
>>  
>> -	drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
>> -				    &dw_hdmi_connector_funcs,
>> -				    DRM_MODE_CONNECTOR_HDMIA,
>> -				    hdmi->ddc);
>> +	ret = drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
>> +					  &dw_hdmi_connector_funcs,
>> +					  DRM_MODE_CONNECTOR_HDMIA,
>> +					  hdmi->ddc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	drm_bridge_get(&hdmi->bridge);
> 
> I'm not fully following the code paths, but both the report and the fix
> make sense to me. Only I'd move the drm_bridge_get() before
> drm_connector_init_with_ddc(), to avoid a short window where no reference
> is held and the bridge might be destroyed before drm_bridge_get() is
> called. I'm not sure this can happen, but it's better to write the code in
> a way that clearly makes it impossible.

dw_hdmi_connector_create() is only called from dw_hdmi_bridge_attach()
so the bridge should already have a ref for the lifetime of this call.

I explicitly chose the placement after drm_connector_init_with_ddc()
to ensure ref count is correctly balanced without having to add a
drm_bridge_put() call in any error path. I.e. connector destroy() is
only called when drm_connector_init_with_ddc() succeeds.

This code/call is also planned to be removed in a future series, so I do
not think moving drm_bridge_get() is necessary unless you think we need
to protect against possible bad behavior from DRM core?

Regards,
Jonas

> 
> Otherwise looks good.
> 
> Luca
> 

