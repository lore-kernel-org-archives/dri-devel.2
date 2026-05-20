Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829C7CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE6F10E2DE;
	Wed, 20 May 2026 12:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNnDqbeG";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D501E10E2DE
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:29:46 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8354461da74so2069294b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779280186; x=1779884986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzkBBcKTZRRo6KZ9+PtPdstmmuTGEEEzr/9FfRz/BDQ=;
 b=gNnDqbeGWr/5wTIIsP77znNLr7Vve1t93Lkapx6m2tH5UkUTu8yrTWpDQ1fHSVje33
 pjNNFNxD6O3YNNprFz7jugRTosmhFJi08xehP2wgiFnmCZWfwbjacsb1PLh6dZLh32oh
 Cin9QLKBZ4n1BPwAaIXiQ81t4ZTvjReU5/e+IKjVgmm0wIoKgR20ery5xZWIDXiARnpN
 OHtCiJMiS5Ned5DrNtB3ZVhSi5YZtFQRHlY3gZpyVVMVqrkppH/vl/ynYBFZdm4a5XYE
 rafdy7AijfsMn0GlCdmuOc8XZusgLBbQoEII+AdXL5CLpIcI0y+fFWXl//kPX2KGd81x
 86mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280186; x=1779884986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzkBBcKTZRRo6KZ9+PtPdstmmuTGEEEzr/9FfRz/BDQ=;
 b=dvvkvbAedk4QhtCi3subbU+ubgUXjo3UZFNP5UR7lPoo1MXx2RLKcUlN9+tMSEc2Vy
 CcPiYkOk1MTPvOi20YSbt9COzn6P79CmKMxwtihoIuo6V+CkGbYkreth+UyR/cFpmQcX
 RmmcQ7C3hvZzSehnmfi604fYbquo6AMck6mLuH9joOkOODrLofw2GG9MU7QVd7CMJ5mI
 0Ho1jueRhdQhG+gslgVqtkt/2H9t/S0sS5kiWFG2CRTPvZ0QDmmKlAIiqE+YU9AKJFHS
 rhPZS6I9TZWXA5T8NykUPk4mcsir04H0i/w3RbMxdQJTmHDbw5af87Lg/J5oXVvmAWUt
 EDLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JTcBydjw0imzGwerxt2bXHhIzCP49rurfEs4OPEsFGnF8nMtV2xvXrD6KuzOsfEhg0AkcgfwNnGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFgunDumu4/L5b8Kp8MBl0ruaqoFoEhBnwTmJTub7ihSGHtyd8
 E55I6tD/PtDWjDAEhuoLUBHnCHDAoUThMfPkb3RQmKsFiWRwZRsxJIWh
X-Gm-Gg: Acq92OF0Mpb56fCapIazDzyQBFY/dKgXjwLdNEw3eRNb4ewBL2u/aIFsrr8vAO4hu8u
 aI9DkYMXY5oC4bVCmq6FO41eX1lScLsCVlWkulkKZyTHpZVcu1rV2MBOkS55jYKfTOMMWu5O1BH
 chi14cjEylOFgjhmAJoN9C1MreBogRPMly2y/ISJBIrf8I1/L5k4WFhr8fLKMPFTVAq+W0Cr/yW
 eEEb8HQ2IKLjm9dc8mX2rfbCrXPdKJqM4io0hLH3VzClMIrkjs5Et0UpAt+jFxKIUE9jj24viiT
 w5NT/cC/e2fb/D6Hf2J1ek/QH5/USEYawdMPRYiXP0SC7oe86aviiKAXVHHt9HDUWQNZ7H2GXOV
 QQv9tOBUpQI2nDLhIpDEYIMXZ2D5wr4AIbzao3O93uQErZZnBQplfR0mACmYYgmJrIM/JAJmpOg
 KeNukq7HdghMjunlPuevfcvP3gtnLDZtQ35H+QUxk/dOr0cPA=
X-Received: by 2002:a05:6a00:3312:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-83f33dee670mr23125528b3a.49.1779280186126; 
 Wed, 20 May 2026 05:29:46 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664a59sm21418134b3a.1.2026.05.20.05.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:29:45 -0700 (PDT)
Message-ID: <8a78aab6-918a-4bed-a913-05ecb559da4f@gmail.com>
Date: Wed, 20 May 2026 17:59:37 +0530
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
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
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



On 20-05-2026 17:08, Luca Ceresoli wrote:
> Hello,
> 
> On Wed May 20, 2026 at 11:04 AM CEST, tessolveupstream wrote:
> 
> [...]
> 
>>>> We have not received any further updates from TI regarding this issue, and
>>>> at this point, we are not sure if we will get additional feedback from them.
>>>> As you had mentioned earlier that the patch could be considered after
>>>> waiting for some time, could you please let us know how we can proceed
>>>> further from here?
>>>
>>> I am getting some feedback from TI, but it is taking some time.
>>>
>>> For the time being I think it is clear that HBP and HFP are required, and
>>> so removing the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
>>> in your patch seems to be fully correct, even though this had no effect on
>>> the panel I tested.
>>>
>>> I'm still trying to get some better info to ensure that switching from
>>> burst mode to non-burst mode is not expected to have side effects.
>>>
>>> For thi reason, I think it would be great if you could send a new version
>>> with two separate patches: the first one enabling HFP and HBP and which can
>>> be applied right away, the second to disable burst mode for which I'd wait
>>> a bit longer for TI feedback. You can keep the Tested-by lines.
>>>
>>
>> Thanks for the clarification. I just wanted to confirm my understanding
>> regarding the patch split you suggested.
>>
>> From your comments, my understanding is that the first patch would only
>> enable HFP and HBP by removing MIPI_DSI_MODE_VIDEO_NO_HFP and
>> MIPI_DSI_MODE_VIDEO_NO_HBP, while keeping burst mode enabled, so the mode
>> flags would become:
>>
>> dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>>           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>>
>> Then, the second patch would only disable burst mode, resulting in:
>>
>> dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
>>           MIPI_DSI_MODE_NO_EOT_PACKET;
>>
>> Could you please confirm whether my understanding is correct?
> 
> Yes, correct.
>

Thank you for the clarification. 
>> Also, from our testing, when using:
>>
>> dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>>           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>>
>> we are not able to get display output.
> 
> This is the case for the panel I worked on as well. In the practice we both
> observe that non-burst mode is what fixes the panel, but there is no clear
> explanation of the reason in the docs (that's what I hope to discover from
> TI).
> 
> On the other hand the HBP and HFP are clearly required by the docs, so it
> should be fine to enable those without waiting for further info from
> TI. This is not fixing your and my panel, but it's a fix, no doubt.
> 
>> I just wanted to mention this
>> observation in case it is relevant to the patch split discussion.
>>
>> Additionally, regarding the Tested-by tags you mentioned earlier,
>> should I carry them forward to both patches, or would you prefer them
>> only on the applicable patch?
> 
> I'd say yes. People who sent these tags have tested a patch that is the sum
> of the two future patches, so I'd say it's OK to keep the R-by on both
> patches.
> 

Okay, I just wanted to confirm one point — when you mentioned R-by, are you 
referring to the Reviewed-by tag? I wanted to make sure I understood it 
correctly before carrying the tags forward in the next version. 🙂> Thanks for your patience. We'll get to the bottom of this issue! :)
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

