Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD453C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1362510EF50;
	Wed, 15 Jul 2026 08:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="D5eEkzfW";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 15 Jul 2026 08:37:14 UTC
Received: from mail-m12838.netease.com (mail-m12838.netease.com
 [103.209.128.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6A210E13E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:37:14 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4644b288e;
 Wed, 15 Jul 2026 16:32:08 +0800 (GMT+08:00)
Message-ID: <00d3f58e-73bb-41da-a2df-dfeeca644b6f@rock-chips.com>
Date: Wed, 15 Jul 2026 16:32:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory samsung
 DP DT properties
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-4-damon.ding@rock-chips.com>
 <20260707041711.4F7351F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260707041711.4F7351F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f64e79dc103a8kunmb5bc9ffe10ec8e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCShhLVkpIGE5KGkkYQktLSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=D5eEkzfWlQsu8P+ISq0oa6wJ8Fp89x3afKPHLzKZvgX2lw9+6aZwVlxKVWZEnPs8FJw9gB1HyUInUGo5sG6lF8usQP/Cti1YYzJXaqiAg3P+iHzT5vpLiFPZi78Tbf+TYkyKnMW/6neIZfvs9qsVEtaBK6JQyK+xJMcYCB+BA98=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=5k3VLyTE2W0brh6QXzfvnZyb5UNm/t6xk2HiFeq09E0=;
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

On 7/7/2026 12:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Failing probe when deprecated DT properties are missing breaks DT ABI and prevents their deprecation.
> --
> 
> --- Patch [3]: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties ---
> commit b573dba50acc6087122ffa4a65680322f4d004f8
> Author: Damon Ding <damon.ding@rock-chips.com>
> 
> drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
> 
> This commit reverts a change that made the samsung,link-rate and
> samsung,lane-count properties optional for Exynos DP. It adds error checking
> to fail the probe early if these properties are missing, aiming to prevent
> link training failures caused by zero values.
> 
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 8cf6b73bceac0..293d8adfe9856 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> [ ... ]
>> @@ -1258,10 +1259,14 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>>   		 * NOTE: those property parseing code is used for
>>   		 * providing backward compatibility for samsung platform.
>>   		 */
>> -		of_property_read_u32(dp_node, "samsung,link-rate",
>> -				     &video_info->max_link_rate);
>> -		of_property_read_u32(dp_node, "samsung,lane-count",
>> -				     &video_info->max_lane_count);
>> +		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
>> +			return dev_err_probe(dp->dev, -EINVAL,
>> +					     "Failed to get samsung,link-rate\n");
> 
> [Severity: Critical]
> Does failing the probe when this property is missing break the DT ABI?
> 
> Since samsung,link-rate is a deprecated property, a modern schema-compliant
> Device Tree might intentionally omit it. If a system boots with such a DT,
> this check will fail the probe with -EINVAL and disable the display.
> 
> Could the driver instead fall back to hardware maximums or sensible defaults
> when the deprecated property is absent, rather than returning an error?
> 

I'm afraid it's difficult to provide a universal sensible default value 
here.

The samsung,lane-count and samsung,link-rate values vary significantly 
across Exynos DP device trees, so a generic fallback to hardware 
maximums cannot guarantee stable link training.

Even though these two properties are marked deprecated, all existing DTS 
files in our projects have already populated them completely. Moreover, 
the current link training logic relies on these two parameters; omitting 
either will directly cause link training failures at runtime.

Therefore, retaining the mandatory property check in probe is a 
reasonable approach for now.

>> +		video_info->max_link_rate = val;
>> +		if (of_property_read_u32(dp_node, "samsung,lane-count", &val))
>> +			return dev_err_probe(dp->dev, -EINVAL,
>> +					     "Failed to get samsung,lane-count\n");
> 
> [Severity: Critical]
> Does making samsung,lane-count mandatory similarly break backward compatibility
> for valid Device Trees that have intentionally omitted this deprecated property?
> 

I don't think so. Missing either property will inevitably cause link 
training failure, and all functional DTs have these deprecated 
properties filled in already.

>> +		video_info->max_lane_count = val;
>>   		break;
>>   	}
>>
> 

Best regards,
Damon

