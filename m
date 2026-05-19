Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B8CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B6710E059;
	Tue, 19 May 2026 08:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZuWcgRx";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6559D10E059
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:48:47 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso1854747a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180527; x=1779785327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+nVOhHDA00f0iZbJ+o5TUqj1fifKESVdZYkDcrWTV8Q=;
 b=BZuWcgRxaoLbFjpQ8B+ZObu7iAUDfe7XLbCTs2Jh7Eo6F7HZZ4iIRtGCTDTFlA5TWS
 pb2Pk1uWptL+efI71fcK99S13t8+0NVzaoRaecJvn6VnDWnd2q9Wt+sh6H0LWn6NA49o
 GcTdZRNlOEfNKBy6xCHslCozhKioGa4LQPsmKV2eXVsJJNkk4WT0eXGaKZ8+iIt/h21i
 CR5NFAzU/VeqBnjcrSOvYc9HoB5y6L8fSgee6+xOhwxRahnC5H5E8wMe3JIWbJ6Gap72
 dRNNrG1+btBl2zdkiEIZzgcEZiUJA2heTy04T4Xjx3HfPUV1eqKdE+bTYnhKJNGBICaS
 PS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180527; x=1779785327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nVOhHDA00f0iZbJ+o5TUqj1fifKESVdZYkDcrWTV8Q=;
 b=s/83R2M1SBQeZY6MSgijOaxJZdRqoXx+4OZE8bXtYlevp9+TI0OnwSPen5P17gCEjP
 ksnZECbL48K5gEuMLkm3tu0Vc8oKp02WlZehDVxFL2JFVY3/zHzzuI6qfI6wmrrm707M
 +hOHMVpcQEY51aaLCkzVFg/2zuAHq2rHlg51vM8uzWRJNKsV6MdxbI7VUv0RSUBPpwkX
 +5IVt4sen4y/z5AbnVFu2LCzY78HxZdbCUXlddzH8TdCkZ1IgY/hs/RXsY9vObvlx4Wv
 HdItLzhPhIw6QyVCKOEB1Si5Xx2fgC92zp7HWZkkBY9X1T7ntYrS7hPOhUj0tY/0rIwo
 hGgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rwayOUwlbzDkeI7rF885Si1DAnQrQLdBHO92cLRnOGoTWuyjrEOvK3qbAspcxXsnt2+TF1TN90G0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvFurGVA4o4YkmWVORAP9rgIJAJmKzda1FjMPrrpVdz/LzE/LJ
 4TALR9sZCKHTSufe1ojvVNnbGmgbD7Mi+PD3hPUbLcrCWYv6vtQFtCAB
X-Gm-Gg: Acq92OFVY88EYpk+FR9rqqRdjYu956FUhUX+wViyw/jpkfultehMQ9Lzr+XerCmsgN6
 gVo7vxPMk5zvblbKxs9wQgMdQtac5tYLBMUTmfS/asv4JP5DXWyKUo1gEDGLksV/SMiLvqqUy7+
 Qpti438MByKf2WfY0eeOTRiLkIu/aahoP/8zRGqrutHRsvrE0Vt75g1j3IKeYQ3hzudq9MZPjoc
 geYwxT44H++P+ZNgnGEty13jmxVcR7/6Nqesyu89YAWY90ooIg/8H4VOxqfsSG0J8sCBWLXgEpo
 K7AXSQ/2Qpmq8JzZag0K5M/+Xtll5lCVsZKAQfJlB+d/+PLAY9RsXBHt5lDWSK8p82Hw1QxdfeT
 szFyLwljiaZyhFPzFTEhZWx0t7RgEL/WSoFNLAJimTuklujqAuw2RVZFZg7lvQk2ZHiH+I2WTCL
 TvPOHXxHrpWBcdDNFBN0Cq5FvseOmE/Ies0rLfmz1g47Q8k+3t54lAHcqLGg==
X-Received: by 2002:a17:90b:2d4b:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-369518b20ecmr15266950a91.4.1779180526826; 
 Tue, 19 May 2026 01:48:46 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517d8570sm14173902a91.14.2026.05.19.01.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 01:48:46 -0700 (PDT)
Message-ID: <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
Date: Tue, 19 May 2026 14:18:38 +0530
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
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
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



On 24-04-2026 13:55, Luca Ceresoli wrote:
> Hello,
> 
> On Thu Apr 23, 2026 at 11:16 AM CEST, tessolveupstream wrote:
> 
>>> I had reached out to TI for clarification and any related documentation
>>> updates, but I have not received any response so far.Given this, it is
>>> uncertain whether we will be able to obtain further details or official
>>> confirmation from TI in the near term.
>>>
>>> I would appreciate your guidance on how you would prefer us to proceed
>>> from here.
>>
>> I followed up with TI, and they pointed us to the relevant sections in the
>> SN65DSI83/84/86 datasheets covering DSI video transmission specifications.
> 
> Thanks for keeping on! I'm also trying to get info from TI, I'm keeping you
> up to date if that will happen.
> 
>>> https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=1776924088430&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84
>>
>> As per datasheet Section 7.4.7, the device operates in DSI video mode with
>> fixed horizontal timing, where HBP, and HFP are explicitly defined and expected
>> to be present as part of the video line structure. The timing description in
>> this section assumes standard non‑burst video transmission with all horizontal
>> blanking intervals accounted for.
>>
>> The datasheet does not document support for DSI video burst mode,
> 
> This sentence seems incorrect. Section 7.4.7 starts with this sentence:
> "The SN65DSI84 supports burst video mode and non-burst video mode ...".
> 
> Even though asa matter of fact it looks like many users have issues that
> get solved by disabling burst mode.
> 
>> nor does it
>> mention support for omitting horizontal front or back porch intervals. In
>> particular, there is no indication that the device can operate with collapsed
>> or suppressed horizontal blanking, as enabled by MIPI_DSI_MODE_VIDEO_BURST,
>> MIPI_DSI_MODE_VIDEO_NO_HFP, or MIPI_DSI_MODE_VIDEO_NO_HBP.
> 
> This is correct.
> 
> We can still try to get TI feedback, but it that won't happen in, say, a
> few weeks then I think we should apply this patch.
>

We have not received any further updates from TI regarding this issue, and 
at this point, we are not sure if we will get additional feedback from them.
As you had mentioned earlier that the patch could be considered after 
waiting for some time, could you please let us know how we can proceed 
further from here?
 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

