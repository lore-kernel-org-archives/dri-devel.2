Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FDCC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4CF10E271;
	Fri, 21 Aug 2026 08:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="c+3teKrS";
	dkim-atps=neutral
Received: from mail-m10147.netease.com (mail-m10147.netease.com
 [154.81.10.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B985310E271
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:09:44 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ad475c48;
 Fri, 21 Aug 2026 16:09:40 +0800 (GMT+08:00)
Message-ID: <c5fba12d-487c-46ee-8ea3-3a844f383555@rock-chips.com>
Date: Fri, 21 Aug 2026 16:09:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260819075238.3007087-1-damon.ding@rock-chips.com>
 <20260819075238.3007087-6-damon.ding@rock-chips.com>
 <178714408666.358642.10737743872246645132.b4-review@b4>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <178714408666.358642.10737743872246645132.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0235e56ad03a8kunme42a00e845a4aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGExNVkxPTExNThlKGR4dTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=c+3teKrSTTlXpJm1/i6LeNry75eFu/LVtK9z45N0HBhWA4yMUOIhkHCeXd+57htAifrv1J37fPpyJ0aEcZKghhEOywnc52hTnD8htVJWy/7LtEe6j3DFnT5GQivXfsJFbEJvm2fX4k2k8i6XbQ5Gl2SbDLTp6S6sR1xc5XEzqCQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wKHl0TpfBtrjUDpLLcVLEklz3HswqlwtK2BO20EwKcs=;
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

On 8/19/2026 8:54 PM, Luca Ceresoli wrote:
> Hello,
> 
>> Parse the optional 'data-lanes' device tree property to support
>> custom physical lane mapping configuration.
>>
>> If no valid configuration is found, fall back to the default
>> lane map (0, 1, 2, 3) automatically and keep the driver running.
>>
>> Lane mapping is mainly used for below scenarios:
>> 1. Correct PCB lane swap and differential line routing crossover
>>     without hardware changes;
>> 2. Adapt mismatched lane pin definitions between SoC and eDP panel;
>> 3. Support multiple panel hardware variants on the same board
>>     by configuring data-lanes in device tree only.
>>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 117448b854db..4aa444858bb6 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1240,6 +1240,59 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
>>   	.detect = analogix_dp_bridge_detect,
>>   };
>>
>> +static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
>> +{
>> +	struct video_info *video_info = &dp->video_info;
>> +	struct device_node *endpoint;
>> +	u32 tmp[LANE_COUNT4];
> 
> The 'tmp' name is not very useful to understand what it's for. Based on the
> code I'd say it stores a lane index, so what about 'lane_idx', unless you
> can propose a better name.

Good idea, will fix in v8.

> 
>> +	u32 map[LANE_COUNT4] = {0, 1, 2, 3};
>> +	bool used[LANE_COUNT4] = {false};
>> +	int num_lanes;
>> +	int ret, i;
>> +
>> +	memcpy(video_info->lane_map, map, sizeof(map));
>> +
>> +	num_lanes = drm_of_get_data_lanes_count_ep(dp->dev->of_node, 1, 0, 1,
>> +						   video_info->max_lane_count);
>> +	if (num_lanes < 0)
>> +		return -EINVAL;
>> +
>> +	endpoint = of_graph_get_endpoint_by_regs(dp->dev->of_node, 1, -1);
> 
> 
>> +	if (!endpoint)
>> +		return -EINVAL;
>> +
>> +	ret = of_property_read_u32_array(endpoint, "data-lanes", tmp, num_lanes);
>> +	of_node_put(endpoint);
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < num_lanes; i++) {
>> +		if (tmp[i] >= LANE_COUNT4) {
>> +			dev_dbg(dp->dev, "data-lanes[%d] = %u is out of range\n", i, tmp[i]);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (used[tmp[i]]) {
>> +			dev_dbg(dp->dev, "data-lanes[%d] = %u is duplicate\n", i, tmp[i]);
>> +			return -EINVAL;
>> +		}
>> +
>> +		used[tmp[i]] = true;
>> +		map[i] = tmp[i];
>> +	}
>> +
>> +	for (i = 0; i < LANE_COUNT4 && num_lanes < LANE_COUNT4; i++) {
>> +		if (!used[i])
>> +			map[num_lanes++] = i;
>> +	}
> 
> This loop is a bit obscure to me. After reading it a few times I _think_ it
> does the following:
> 
>   /*
>    * Fill the unused map[] entries with the unused lane indices <reason?>. E.g.:
>    * used[] values = {0,1,0,1} // Only lanes 1 and 3 are used
>    * map[] before  = {3,1,x,x} // x = unassigned
>    * map[] after   = {3,1,0,2} // filled last 2 entries with the unused lane indices
>    */
> 
> Is my understanding correct? If it is, please fill <reason?> and add the
> above comment (possibly improved) before the loop.
> 
> 

You are right.

The hardware register defaults to 0xE4, which corresponds to map = {0, 
1, 2, 3}. Functionally, writing duplicate mappings for unused lanes 
would not cause issues.

Unused lanes are populated with non‑duplicated physical lane indices to 
support DP HPD scenarios where different devices with varying lane 
counts may be connected, as well as to keep the register content reasonable.

The comment will be added in v8.

Best regards,
Damon

