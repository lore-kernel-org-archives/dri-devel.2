Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8B1F327A8
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B13110E179;
	Tue, 21 Apr 2026 06:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kp8E0a9O";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A775010E179
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 06:02:06 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so1136778b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776751326; x=1777356126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nvIFWCMpJRTZEjNf9Rp+wYRSeHm11nYugntoYELzauw=;
 b=Kp8E0a9O19WhH/a19QNM6jdyfuznop7WqX6+H0v3XxCAz3kC4WTGCpH5S11HsOVJa2
 989l0gD+dIj/YdTZAabJKsZtlm+t74+hsWpbbqoK3Ek3LXDegUSwrr8HA7JMSQQ84sqH
 I6vZY1e3FH6Rol5BRmBwEijXUTQgAfLgdpatSpIx/U7DaXaVUtJReXjruzfNzMGlgh0c
 tocC/qFk7kzx3rAT7PoQwj+b6p3Y5nB4qASWN5sIuLTWRVBeYSmsdzCGIjQ5knW+uIXX
 FGlf69D+XXXxj2S1MoNT2jYSedZBBBwdotf/jSTMyyLk1jhLQ17AoPvzlUXnSj1P/RDv
 mvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776751326; x=1777356126;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nvIFWCMpJRTZEjNf9Rp+wYRSeHm11nYugntoYELzauw=;
 b=ADifxYKDhDGmsyk3BJA33tx4g9INfOQpE4PfYPT1LQWXj1TKPPoWx8EF/9lX5LpNKY
 kugFVV2C2ektTnBIBixzmBJVEoACdgrPbkBey561uR2cs/ORJqamw4Tp/SxL4VyIdgrC
 S9PowFTwfHVIQjiOCU8Op7EW+1uYn+e20GQBr8mLo8uXtgT1KaZrJb3V2z26xPGM/1dZ
 Bj96qN90qZ8wuZs/x6m4iZb4QEfUiXyEik+Ss/jsu6aKQV0kcPmzKJTRUHT2HUNoht5S
 hu73h6A7Qe8jEU9MMj34s8p2iathAP8WlDSaVQZMdl8Ue5Vw0KwZSMx4CIZFdTUrKdtn
 ahpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++E0MGJJ8GXp+Es5K/jMzpH/bSPR349hJAq+Zis7CBrq5SgydcQpXisIjAFmYxdr/NMNpKXswdOB4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMCmFd8rdS6Fp8MUKGIjZ/DyZMCgbXF528A5hPfEc5TNz6Kop4
 ps6VNkEnVlQIV3hO1sDuCx1ezNfCFRAEJ7/uAMCVFIfVEnZo6zfSjC/e
X-Gm-Gg: AeBDietQ6L532gGT71C5rkiV9acDNsOXJExtttVMLSwK5J8//5o+PsocL7OrNMS2usd
 WMTZ0zmV4AqwiWhFAONp3FVz4nCoqiQ4QgUZo3i6aacqp9oYK9qgGr+SEWV7xkWtZ81oqwfjqGP
 ydgIwbVOpGnp0uPQbl4bKFR5yJgq2p7q0Nj437Qd5IAA7c2TkNhd+WLDPR/LPNM7wgCWpP4Eiov
 VFG8aBNVwe8UOFRka1cqV/HqpMEiUIcg6DuyXwSNjp5QsDyNbu66NFNNtKW/Qi1mqkcE8IYmSyi
 w7qg8GPr4sJdzzscGJ7MQpRw4i6AIL4s9hju6Qp3gE4nd4EQZWMgbravU+zgGt8syWiOhzAUvhk
 /c5dUzMzB1j4VLFayKk62bf+225TdZhwj9BiRAebOS6s9xbfdfJBZrielzxDgmUGh1eouFMwtoi
 ClmtliQbOZGPP5p1RbGlfRG7NOIVOVANtcx5VwFQJQ6KctORD0XjvedmEOBA==
X-Received: by 2002:a05:6a00:1f09:b0:82f:b5:8044 with SMTP id
 d2e1a72fcca58-82f8c7dec94mr16543565b3a.6.1776751326010; 
 Mon, 20 Apr 2026 23:02:06 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9fbb85sm14768763b3a.22.2026.04.20.23.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 23:02:05 -0700 (PDT)
Message-ID: <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
Date: Tue, 21 Apr 2026 11:31:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
From: tessolveupstream@gmail.com
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
Content-Language: en-US
In-Reply-To: <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
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



On 16-04-2026 14:40, tessolveupstream@gmail.com wrote:
> 
> 
> On 15-04-2026 12:43, Luca Ceresoli wrote:
>> Hello Sudarshan,
>>
>> On Sun Apr 12, 2026 at 7:38 AM CEST, Sudarshan Shetty wrote:
>>> The current DSI mode configuration enables VIDEO_BURST and disables
>>> horizontal front porch (HFP) and back porch (HBP) transmission using
>>> MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.
>>>
>>> However, the SN65DSI83/84 bridge relies on receiving full horizontal
>>> timing information over DSI in order to correctly reconstruct the LVDS
>>> output timings. When HFP and HBP are not transmitted, the bridge cannot
>>> recreate the required timing parameters, resulting in unstable or
>>> missing display output on some panels.
>>>
>>> Additionally, while burst mode is supported by the hardware, its use
>>> depends on continuous clock behavior from the DSI host. In practice,
>>> burst mode may introduce instability depending on the host controller
>>> implementation, as the DSI link may transition to low-power state
>>> between bursts.
>>>
>>> In testing, removing burst mode and ensuring full horizontal timing
>>> transmission results in stable LVDS output across affected panels.
>>>
>>> Update the DSI mode flags to:
>>>   - Drop MIPI_DSI_MODE_VIDEO_BURST
>>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
>>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HBP
>>>
>>> This aligns with common system configurations where non-burst mode is
>>> preferred and full timing information is transmitted over DSI.
>>>
>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>
>> Thanks for having gone into the details and provide a good explanation for
>> the removal of these three flags.
>>
>> It would be still great to have authoritative info from TI, possibly as an
>> update to the documentation.
>>
>> I managed to test on a board with i.MX93, a TI SN65DSI84 and a 1920x1080p60
>> panel, and:
>>
>>  - no image shown with the current mainline driver
>>  - it works by removing only MIPI_DSI_MODE_VIDEO_BURST (my current setup)
>>  - it works with this patch applied
>>
>> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # imx93 1920x1080p60
>>
> 
> Thanks for testing the patch and for the Tested-by tag. 
> I’ll reach out to TI for clarification on the DSI mode flag behavior and
> any documentation updates, and will share any feedback I receive, though I
> cannot guarantee a response.

I had reached out to TI for clarification and any related documentation 
updates, but I have not received any response so far.Given this, it is 
uncertain whether we will be able to obtain further details or official 
confirmation from TI in the near term.

I would appreciate your guidance on how you would prefer us to proceed 
from here.
>> Luca
>>
>> --
>> Luca Ceresoli, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
> 

