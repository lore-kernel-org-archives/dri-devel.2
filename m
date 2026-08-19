Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA37C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76A510E0ED;
	Wed, 19 Aug 2026 08:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bGWaL0kF";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Wed, 19 Aug 2026 08:59:01 UTC
Received: from mail-m81146.xmail.ntesmail.com (mail-m81146.xmail.ntesmail.com
 [156.224.81.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD3E10E0ED
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:59:01 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4a8bd8e40;
 Wed, 19 Aug 2026 16:53:54 +0800 (GMT+08:00)
Message-ID: <f0151ee4-f660-43d2-a49d-13ab2ad12dbc@rock-chips.com>
Date: Wed, 19 Aug 2026 16:53:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20260819075238.3007087-1-damon.ding@rock-chips.com>
 <20260819075238.3007087-6-damon.ding@rock-chips.com>
 <20260819080422.816771F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260819080422.816771F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0193a1e7403a8kunmaa6dc6ec3320d4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxodVhgaGUxNHh9MSUkYHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=bGWaL0kFdv2F1aJCSHo5LblQ8BYGWkRXUq0Xgx+AOA6nhCbje5jnq6LtjPtvynfZaO0GaFjUP9Bj7lj3/rdF0FpeHYSA4224tQmSChQ4ymGoLKlU8Fc2NYHGdDsDT2FBrTMpDz0S5EnWW9IKYOSasuZthQr+u+khrJw7hl2Uq10=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=g/T2s+HEEMdqXQKh9/wTekMXVfvnMcbFNHDnmwWBfis=;
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

On 8/19/2026 4:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Logic error in hardware lane mapping configuration causes inverted assignments for non-symmetric maps.
> - [Low] Device Tree endpoint lookup inconsistency when querying lane counts versus reading properties.
> --
> 
> --- Patch [5]: [PATCH v7 5/5] drm/bridge: analogix_dp: Add support for optional data-lanes mapping ---
> commit 1c15eb6132eedc3d606168644e5f97918c8e3651
> Author: Damon Ding <damon.ding@rock-chips.com>
> 
> drm/bridge: analogix_dp: Add support for optional data-lanes mapping
> 
> Parse the optional 'data-lanes' device tree property to support
> custom physical lane mapping configuration. If no valid configuration
> is found, fall back to the default lane map automatically.
> 
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 039e076d2b8ab..cb06347196cef 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> [ ... ]
>> @@ -1240,6 +1240,59 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
>>   	.detect = analogix_dp_bridge_detect,
>>   };
>>   
>> +static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
>> +{
> [ ... ]
>> +	num_lanes = drm_of_get_data_lanes_count_ep(dp->dev->of_node, 1, 0, 1,
>> +						   video_info->max_lane_count);
>> +	if (num_lanes < 0)
>> +		return -EINVAL;
>> +
>> +	endpoint = of_graph_get_endpoint_by_regs(dp->dev->of_node, 1, -1);
> 

Hi Luca,

Thanks for taking a look at previous v6 patch series. This Sashiko 
warning was also present in v6. Sorry for CC'ing you out‑of‑the‑blue 
without prior heads‑up.

> [Severity: Low]
> Does passing -1 here potentially retrieve a different endpoint from the one
> validated with reg=0 above?
> 
> If multiple endpoints exist on the DP port and the target endpoint is not
> positionally first, could this mismatch result in reading the data-lanes
> property from the wrong endpoint?
> 

For Analogix DP, port@1 will only ever have a single endpoint. 
Multi‑output configurations are not supported by the hardware, so 
passing -1 cannot select a mismatched endpoint. There is no risk of 
retrieving the 'data‑lanes' property from an unintended endpoint.

>> +	if (!endpoint)
>> +		return -EINVAL;
>> +
>> +	ret = of_property_read_u32_array(endpoint, "data-lanes", tmp, num_lanes);
>> +	of_node_put(endpoint);
> [ ... ]
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> index ea8401293a23a..c1344a3f013ab 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> [ ... ]
>> @@ -48,16 +48,15 @@ void analogix_dp_stop_video(struct analogix_dp_device *dp)
>>   	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
>>   }
>>   
>> -void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
>> +void analogix_dp_lane_mapping(struct analogix_dp_device *dp)
>>   {
>> +	u32 *lane_map = dp->video_info.lane_map;
>>   	u32 reg;
>>   
>> -	if (enable)
>> -		reg = LANE3_MAP_LOGIC_LANE_0 | LANE2_MAP_LOGIC_LANE_1 |
>> -		      LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
>> -	else
>> -		reg = LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
>> -		      LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
>> +	reg = lane_map[0] << LANE0_MAP_SHIFT;
>> +	reg |= lane_map[1] << LANE1_MAP_SHIFT;
>> +	reg |= lane_map[2] << LANE2_MAP_SHIFT;
>> +	reg |= lane_map[3] << LANE3_MAP_SHIFT;
> 
> [Severity: High]
> Does this logic incorrectly assign the physical lane value to the logical
> lane's field?
> 
> By shifting the physical lane index (lane_map[i]) into the register field
> assigned to the logical lane index (LANE<i>_MAP_SHIFT), it appears this
> inherently applies the inverse of the requested mapping.
> 
> While this silently succeeds for symmetric maps (e.g., swapping 0<->3, 1<->2),
> will it fail for any non-symmetric map (e.g., <1 2 3 0>) by causing physical
> lanes to carry the wrong logical lanes?
> 
> Should the bitwise construction instead be reg |= i << (lane_map[i] * 2)?
> 
>>   
>>   	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
>>   }
> 

lane_map[] uses index as physical lane, value as logical lane.

This matches training_lane[] / cr_loop[] in struct link_train, whose 
indexes are physical lanes for DPCD access during link training.

LANE<i>_MAP_SHIFT configures which logical lane is routed onto physical 
lane i, so current register logic is correct.

Best regards,
Damon

