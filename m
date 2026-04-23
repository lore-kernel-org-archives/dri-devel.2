Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB744F99344
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051CA10E2FE;
	Thu, 23 Apr 2026 09:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYDwJxRI";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D0C10E2FE
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 09:16:37 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso4498004a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776935797; x=1777540597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tJeE1AR9RIjmAJgGIUNU2WJKTNIwQfK4aOUPZv27pow=;
 b=QYDwJxRId1MdhcycFpVd2TUJE+yM7nA796igdUM4NA7tYVv0Q/S4E1tF5H/9aTlSy5
 lVqvP+EY+MyUqQI6uynlNWAD3BYmVdLlVUVjJOBIcypF6rE1NzYryXLCWpGiDIQPkdTk
 0wVMc/LaeiGMW5vA935bN9ErURD8JQdfR6jRtqHC5z09KiHxnFNSfEhhluSWBj+ZCUAf
 7bQwxbsAWOJlOPL6U3fu/zxbTtuU+LnT+XfgIUBmfk3ykC3pyymDvya7v8XqNlMyBx6U
 46FU3+BU8E1hqrLfYQzstgV9sAvyyewafdveceFIovBPBB2vsyUcxQOVHuNmrj+/0DMc
 8wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776935797; x=1777540597;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJeE1AR9RIjmAJgGIUNU2WJKTNIwQfK4aOUPZv27pow=;
 b=srd56LmuyjpA5Pdk8YpaItOyqxJDPPM87m/QJKu8iehWdfXlbHjAy8zPdyegxyVoLj
 0tylkaRJtVS5sDNW3L6ME+0u2dJoe3vnHiba8kvOIJ5X7LukjxKr5aSwIo3S9TkZbrED
 QSXCQerwOEYkXcGeh11xkgSVzAQjLcZo4glGfTNYjgnOdPHl5JNz8SdxgWskq65E4jup
 0djOf47seC9Hsp4Y6It7doY9yoo9kNzp9iT0UdJV3CIUV4H6sx5JgylWBaQJZ5dYuBRe
 GSdXRovbZFFchVCrQJZrDU275Qi+risVM3CfZMkhq6Iipn3F++WvmFm67Ihhk/1kuRC2
 eUMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kTWVlsu2rwn0SuCCHYRYlkYbKAbW5uQc0rYjPwhNIYKdUhiZiiZUpi0Dr/tWAE+hoVwRztKrXBTk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSwOoDlaqA1jcVsBTWCnRnW8bpm7RGnUY4fqEY9Dyh2VH4mii7
 O7L39Cm+0IYHjyynShcwZK6nFXMbARjYaian/UhRhDs4ABbNsJZ6HpZD8eGHWA==
X-Gm-Gg: AeBDieuksoN2OPDfu3zeuQa4cjxV+O2Pw97RVIO38qhz9JlcflSX601Ft6CoFE7pPbh
 hYxfv6WjrxOH6r7R6ia4HXCOBJXND2ArA++q7mJdEeq7Nra/UOoZQog3N/8a2OeQdanaOPZK0kl
 Cqd07rDH+FmiPmPlSFdIy6Qo/BocB9AH/TurLPBtmHHuwiLhbHFfcrIRW6J/WJPGZwc+Vx3H6Gf
 ZXrzlzifn2bH3qQu6XRU9d84ioy3wsl2pkIrvgW1fyUn4bS/SnukiH//t9G8g03hbNH/IyRhFi7
 vQFs7QkuMqonEeYe8E0sDx0flU8kmWqs3b3c4pwhuS55v+rEfKOQcdMypLXDumgpflE64+VPwFB
 ZiShUVtxD+y1gvexIyMr53ZPfeYUe70c9uNaMAr/3dRzD6XDKqji5ZUS3sgN+3oF6QYhJffInhs
 53JI55gL8v/YXXeFwtYuefaOEgO/4qK4n7otSQScfi/ejLfu2QQAUvc47x1A==
X-Received: by 2002:a17:90b:4cc5:b0:35d:a3b4:2f0d with SMTP id
 98e67ed59e1d1-361403ca654mr26577237a91.6.1776935796573; 
 Thu, 23 Apr 2026 02:16:36 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ac1fsm200162235ad.70.2026.04.23.02.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 02:16:34 -0700 (PDT)
Message-ID: <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
Date: Thu, 23 Apr 2026 14:46:26 +0530
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
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
Content-Language: en-US
In-Reply-To: <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
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



On 21-04-2026 11:31, tessolveupstream@gmail.com wrote:
> 
> 
> On 16-04-2026 14:40, tessolveupstream@gmail.com wrote:
>>
>>
>> On 15-04-2026 12:43, Luca Ceresoli wrote:
>>> Hello Sudarshan,
>>>
>>> On Sun Apr 12, 2026 at 7:38 AM CEST, Sudarshan Shetty wrote:
>>>> The current DSI mode configuration enables VIDEO_BURST and disables
>>>> horizontal front porch (HFP) and back porch (HBP) transmission using
>>>> MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.
>>>>
>>>> However, the SN65DSI83/84 bridge relies on receiving full horizontal
>>>> timing information over DSI in order to correctly reconstruct the LVDS
>>>> output timings. When HFP and HBP are not transmitted, the bridge cannot
>>>> recreate the required timing parameters, resulting in unstable or
>>>> missing display output on some panels.
>>>>
>>>> Additionally, while burst mode is supported by the hardware, its use
>>>> depends on continuous clock behavior from the DSI host. In practice,
>>>> burst mode may introduce instability depending on the host controller
>>>> implementation, as the DSI link may transition to low-power state
>>>> between bursts.
>>>>
>>>> In testing, removing burst mode and ensuring full horizontal timing
>>>> transmission results in stable LVDS output across affected panels.
>>>>
>>>> Update the DSI mode flags to:
>>>>   - Drop MIPI_DSI_MODE_VIDEO_BURST
>>>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
>>>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HBP
>>>>
>>>> This aligns with common system configurations where non-burst mode is
>>>> preferred and full timing information is transmitted over DSI.
>>>>
>>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>>
>>> Thanks for having gone into the details and provide a good explanation for
>>> the removal of these three flags.
>>>
>>> It would be still great to have authoritative info from TI, possibly as an
>>> update to the documentation.
>>>
>>> I managed to test on a board with i.MX93, a TI SN65DSI84 and a 1920x1080p60
>>> panel, and:
>>>
>>>  - no image shown with the current mainline driver
>>>  - it works by removing only MIPI_DSI_MODE_VIDEO_BURST (my current setup)
>>>  - it works with this patch applied
>>>
>>> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # imx93 1920x1080p60
>>>
>>
>> Thanks for testing the patch and for the Tested-by tag. 
>> I’ll reach out to TI for clarification on the DSI mode flag behavior and
>> any documentation updates, and will share any feedback I receive, though I
>> cannot guarantee a response.
> 
> I had reached out to TI for clarification and any related documentation 
> updates, but I have not received any response so far.Given this, it is 
> uncertain whether we will be able to obtain further details or official 
> confirmation from TI in the near term.
> 
> I would appreciate your guidance on how you would prefer us to proceed 
> from here.

I followed up with TI, and they pointed us to the relevant sections in the 
SN65DSI83/84/86 datasheets covering DSI video transmission specifications.

https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=1776924088430&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84

As per datasheet Section 7.4.7, the device operates in DSI video mode with 
fixed horizontal timing, where HBP, and HFP are explicitly defined and expected 
to be present as part of the video line structure. The timing description in 
this section assumes standard non‑burst video transmission with all horizontal 
blanking intervals accounted for.
 
The datasheet does not document support for DSI video burst mode, nor does it 
mention support for omitting horizontal front or back porch intervals. In 
particular, there is no indication that the device can operate with collapsed 
or suppressed horizontal blanking, as enabled by MIPI_DSI_MODE_VIDEO_BURST, 
MIPI_DSI_MODE_VIDEO_NO_HFP, or MIPI_DSI_MODE_VIDEO_NO_HBP.

Enabling these modes results in a mismatch between the host‑generated DSI timing 
and the device’s expected fixed timing model described in the datasheet, which 
leads to incorrect display behavior. This is consistent with our observations: 
the display fails when these modes are enabled, and operates correctly when using 
standard non‑burst video mode with explicit HBP/HFP timing.
 
Therefore, removing these flags aligns the driver configuration with the 
datasheet‑defined timing requirements rather than acting as a workaround.
 
They also shared the following E2E FAQ for reference:
https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1382976/faq-sn65dsi8x-programming-tools?tisearch=e2e-sitesearch&keymatch=sn65dsi86

However, they did not provide any additional clarification beyond what is already 
documented and indicated that there are currently no plans to further support or 
update the Linux driver.
 
Given this, it seems unlikely that we will receive more detailed or authoritative 
guidance from TI on the specific mode flag usage.
 
Please let me know how you would prefer us to proceed from here.
>>> Luca
>>>
>>> --
>>> Luca Ceresoli, Bootlin
>>> Embedded Linux and Kernel engineering
>>> https://bootlin.com
>>
> 

