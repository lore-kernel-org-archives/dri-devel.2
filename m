Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71001CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30B310EFAA;
	Wed, 20 May 2026 09:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgZa74D3";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF41510EFA6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:04:59 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso2079028a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779267899; x=1779872699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EtUeRP6UrxzDImfBuIvH2E943h47a6fmSVUaNC6rbY=;
 b=LgZa74D3xjVlOfFG5fIm3qAHKRhi6wjFNDhruqDI7Ke/Defl7PAvIwoQ3X2xJv0k+/
 vkwFIROr3rxawvDyE2SVOMUGaBjNFuPFDmBKvhNlnw5HBQsfedJLPbhKnQFZEle3DneD
 BPBn61M+fa1XTTwVdVzn+uIymoeZsQly8V8uE9zGJcxRzufXE6lm4vZMrnXyEMRSKVe6
 8ChSZBvOkKGvu4cThgDiQP9WwTCHMHXQs+x3uDWEdm8Y/ZdUDh+2YozEy00YwLMHYjGJ
 kfSg08kqG4wD8WEp+C30O3ljWEjm7P014tHmTctILqenOGYYLLzBWmjdDLL0MYtYcvk7
 sqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779267899; x=1779872699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8EtUeRP6UrxzDImfBuIvH2E943h47a6fmSVUaNC6rbY=;
 b=ogtX1AmE3uPDwhUdSPm0H1IGFOXyjEIUhydAdBMET7trG4++HTktgOOIOwL+LFblaG
 vW10glUni757SW3vAfsyAW1Arlf/gfZgvGIbes8k4klVC4Aqp/Qx1v+6nFQAOXZSXyzS
 yYZXT6IEGqns3dY5T56brLhx7zQGKrVrTDZjhkfsZVRwSgyhmwJiaMtSxSrHpgZRWSHB
 LOaq1zIpgr/8RiA8p+f6yO6xx5ud0HXzVGfxN/PFfA2Aq3QNHeQ3XnBC7NsSKHR4Kdil
 V0TukAKlOu2zbea4PeQLS2sEO19IpVdpnX4tgb24Kv/CqrianqP46dY862vkfBj7+h3E
 e+xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lWIyBj+/8l8+REUyWmC//g/hw1igqYMEhQBK09KJcYSwbcO01tgVfJjGI87beKnbQgXFmVfI0Ywc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk/qxdwvBGJdEuUxcnjZ/aCsmuIOv9x4KPqMBYXHtPalPPjnXz
 mVtRav3aM34Ub/WcM+HGT4FrBVX03qhNemxPlSVmGWPNUzGdjY7evXv5
X-Gm-Gg: Acq92OG7LPwqzk6vB8Fv0sW5GtHwjzjjhME7rU+r6ZvbR7wY1sbnkWsux7qRbtT3fHy
 bRUw1EReuX8SFyGJ2XEpLzAVj6ViUUXe0SEVsd2RxjDjXaHwby7bapX7Rjm84wsfpprPI+YBSE+
 lcM7md8Ga7xBGToje1139yt2t1e7F7k7aZnWOFY9F+zLLej7RC6Kpeev5l5+oWsQwIk2LAsgmJD
 FhVLdiwOFljAqIzmxiEVNkBCHwH0zOIwd+zyKhWVwSWlPOYfAYzjqo7NpCvrm5dBwRS1odIkLLO
 hiP0WHiaNw/780yAWXtiv/t0/a3oUkJDxYK3ZJnLwgaEej/LXU1oV+sE7x4AfwAHRUM58clJxnD
 jbZIuXpSJFqckjUW/kRgJbooF0m68WD5apm7EI+Gyf1glvk55UxnKMA6tlUm/NV3HKAiaQptJUh
 NMKdzZ8JiBOL768Kwi6CfkEHRroN32umLuC7F/7oSOI5MKtcA=
X-Received: by 2002:a17:903:2f4c:b0:2bd:3c1a:473e with SMTP id
 d9443c01a7336-2bd7e8a3c71mr273153295ad.14.1779267899117; 
 Wed, 20 May 2026 02:04:59 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11d659sm211023765ad.73.2026.05.20.02.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 02:04:58 -0700 (PDT)
Message-ID: <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
Date: Wed, 20 May 2026 14:34:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 marex@denx.de, valentin@compulab.co.il, philippe.schenker@toradex.com,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
 <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 19-05-2026 17:13, Luca Ceresoli wrote:
> Hello,
> 
> On Tue May 19, 2026 at 10:48 AM CEST, tessolveupstream wrote:
>>
>>
>> On 24-04-2026 13:55, Luca Ceresoli wrote:
>>> Hello,
>>>
>>> On Thu Apr 23, 2026 at 11:16 AM CEST, tessolveupstream wrote:
>>>
>>>>> I had reached out to TI for clarification and any related documentation
>>>>> updates, but I have not received any response so far.Given this, it is
>>>>> uncertain whether we will be able to obtain further details or official
>>>>> confirmation from TI in the near term.
>>>>>
>>>>> I would appreciate your guidance on how you would prefer us to proceed
>>>>> from here.
>>>>
>>>> I followed up with TI, and they pointed us to the relevant sections in the
>>>> SN65DSI83/84/86 datasheets covering DSI video transmission specifications.
>>>
>>> Thanks for keeping on! I'm also trying to get info from TI, I'm keeping you
>>> up to date if that will happen.
>>>
>>>>> https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=1776924088430&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84
>>>>
>>>> As per datasheet Section 7.4.7, the device operates in DSI video mode with
>>>> fixed horizontal timing, where HBP, and HFP are explicitly defined and expected
>>>> to be present as part of the video line structure. The timing description in
>>>> this section assumes standard non‑burst video transmission with all horizontal
>>>> blanking intervals accounted for.
>>>>
>>>> The datasheet does not document support for DSI video burst mode,
>>>
>>> This sentence seems incorrect. Section 7.4.7 starts with this sentence:
>>> "The SN65DSI84 supports burst video mode and non-burst video mode ...".
>>>
>>> Even though asa matter of fact it looks like many users have issues that
>>> get solved by disabling burst mode.
>>>
>>>> nor does it
>>>> mention support for omitting horizontal front or back porch intervals. In
>>>> particular, there is no indication that the device can operate with collapsed
>>>> or suppressed horizontal blanking, as enabled by MIPI_DSI_MODE_VIDEO_BURST,
>>>> MIPI_DSI_MODE_VIDEO_NO_HFP, or MIPI_DSI_MODE_VIDEO_NO_HBP.
>>>
>>> This is correct.
>>>
>>> We can still try to get TI feedback, but it that won't happen in, say, a
>>> few weeks then I think we should apply this patch.
>>>
>>
>> We have not received any further updates from TI regarding this issue, and
>> at this point, we are not sure if we will get additional feedback from them.
>> As you had mentioned earlier that the patch could be considered after
>> waiting for some time, could you please let us know how we can proceed
>> further from here?
> 
> I am getting some feedback from TI, but it is taking some time.
> 
> For the time being I think it is clear that HBP and HFP are required, and
> so removing the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
> in your patch seems to be fully correct, even though this had no effect on
> the panel I tested.
> 
> I'm still trying to get some better info to ensure that switching from
> burst mode to non-burst mode is not expected to have side effects.
> 
> For thi reason, I think it would be great if you could send a new version
> with two separate patches: the first one enabling HFP and HBP and which can
> be applied right away, the second to disable burst mode for which I'd wait
> a bit longer for TI feedback. You can keep the Tested-by lines.
> 

Thanks for the clarification. I just wanted to confirm my understanding 
regarding the patch split you suggested.

From your comments, my understanding is that the first patch would only 
enable HFP and HBP by removing MIPI_DSI_MODE_VIDEO_NO_HFP and 
MIPI_DSI_MODE_VIDEO_NO_HBP, while keeping burst mode enabled, so the mode 
flags would become:

dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | 
          MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;

Then, the second patch would only disable burst mode, resulting in:

dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA | 
          MIPI_DSI_MODE_NO_EOT_PACKET;

Could you please confirm whether my understanding is correct?

Also, from our testing, when using:

dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | 
          MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;

we are not able to get display output. I just wanted to mention this 
observation in case it is relevant to the patch split discussion.

Additionally, regarding the Tested-by tags you mentioned earlier, 
should I carry them forward to both patches, or would you prefer them 
only on the applicable patch?


> I understand this is painful and taking time, but it's important to ensure
> as much as possible that the change won't introduce regressions on existing
> hardware.
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

