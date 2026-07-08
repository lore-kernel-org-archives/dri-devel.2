Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1484BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7706110E5C4;
	Wed,  8 Jul 2026 12:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YpQo4bDP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CE110E5C4
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783513550;
 bh=W8v2dINa6Dgjvzp5ci4OC5UR98N/+SgHHDA47TjTizs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YpQo4bDP6QpLzUXt0yiyBhnFDYbzmEeBYK32e5G9/0lDmOH8xeh/OrS4Ac0l2FMgd
 8rKrDA+SG2G0o0XWQrg3FMmFceW1sCemnB+xRNOTuR2N3ccxsD+hc6C31FezJuNRx4
 wzvkt8Pt1p9c3ubjRZU5UpjPqZtRx9XavN9+95QGQnenzfQFzgLloELGOT6MhbEaHI
 wIRVWJpXLOShmLtnOMk1/14oI4ObpGWmAFphlj89H5EiRFF2q5mXFy0HZMtTZKYp4A
 LQGRLNPufkpXn0pvS48+Se26piJX+iMNY9vtH3QCHMeECkVigmlOsMruL/bfuzEUJs
 b1C1ZZHRE5VNw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 95AB817E0564;
 Wed, 08 Jul 2026 14:25:49 +0200 (CEST)
Message-ID: <c4294b5c-7f53-473f-b1db-d21527d6a2ce@collabora.com>
Date: Wed, 8 Jul 2026 14:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
To: Gary Bisson <bisson.gary@gmail.com>, Adam Thiede <me@adamthiede.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <42607fa4-485d-4142-b31c-7bfac71118d2@adamthiede.com> <ajka2220depklK1_@owl5>
 <bac79214-050d-448b-be63-0586d45c807d@adamthiede.com>
 <f0d99b1a-e383-4d14-adb1-4ccab46efddb@leemhuis.info>
 <5baeb90d2c3736df67ad075ede4ac765bfeaed2d.camel@mediatek.com>
 <84233951-ee22-4980-9f17-2af1df51fdbf@leemhuis.info>
 <6fed12a6-0c94-477f-8a2e-466c33ea2e29@collabora.com>
 <dbc251f2-0c67-4970-a101-c19129055082@adamthiede.com> <ak4-0SkPaeU3N2lh@owl5>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ak4-0SkPaeU3N2lh@owl5>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/8/26 14:13, Gary Bisson wrote:
> Hi Adam,
> 
> On Tue, Jul 07, 2026 at 08:25:41PM -0500, Adam Thiede wrote:
>> On 7/7/26 05:38, AngeloGioacchino Del Regno wrote:
>>> On 7/7/26 10:51, Thorsten Leemhuis wrote:
>>>> On 7/7/26 04:20, CK Hu (胡俊光) wrote:
>>>>> On Mon, 2026-07-06 at 12:16 +0200, Thorsten Leemhuis wrote:
>>>>>> On 6/22/26 15:23, Adam Thiede wrote:
>>>>>>> On 6/22/26 06:22, Gary Bisson wrote:
>>>>>>>> On Thu, Jun 18, 2026 at 04:06:28PM -0500, Adam Thiede wrote:
>>>>>>>>> On 1/20/26 05:36, Gary Bisson wrote:
>>>>>>>>>> Some bridges, such as the TI SN65DSI83, require the HS clock to be
>>>>>>>>>> running in order to lock its PLL during its
>>>>>>>>>> own pre-enable function.
>>>>>>>>>>
>>>>>>>>>> Without this change, the bridge gives the following error:
>>>>>>>>>> sn65dsi83 14-002c: failed to lock PLL, ret=-110
>>>>>>>>>> sn65dsi83 14-002c: Unexpected link status 0x01
>>>>>>>>>> sn65dsi83 14-002c: reset the pipe
>>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>> This commit was part of 7.1 and caused a problem for me.
>>>>>>>>> I'm running postmarketOS (basically Alpine Linux) on a Lenovo C330
>>>>>>>>> chromebook with a Mediatek MT8173 processor.
>>>>>>>>> The problem: when the display on my laptop
>>>>>>>>> powers off (via suspend or
>>>>>>>>> idle,
>>>>>>>>> like xset dpms off) the picture does not come back when the display
>>>>>>>>> powers
>>>>>>>>> back on (from resume). The display backlight
>>>>>>>>> comes on and brightness is
>>>>>>>>> adjustable but there is no picture. The only fix is to reboot.
>>>>>>>>>
>>>>>>>>> Reverting this commit and applying it as a patch on top of 7.1
>>>>>>>>> addresses the
>>>>>>>>> issue for me.
>>>>>>>>>
>>>>>>>>> You can view the config I'm using here:
>>>>>>>>> https://urldefense.com/v3/__https://gitlab.postmarketos.org/
>>>>>>>>> postmarketOS/pmaports/-/__;!!CTRNKA9wMg0ARbw! jrsPDtSEUdaINzLlq92Li8gmsEBkTOxZ6WUzNHjvIN6CyOJjHiHkNSOhIRPXFTLPlaYlxU2uvryVkwjUAN9bmax5$
>>>>>>>>> merge_requests/8819
>>>>>>>>>
>>>>>>>>> Is there any sort of testing or other debugging
>>>>>>>>> info I can provide to
>>>>>>>>> help
>>>>>>>>> address this issue?
>>>>>>>>
>>>>>>>> Thanks for reporting the issue, could you share some
>>>>>>>> logs? Is the driver
>>>>>>>> saying anything during resume? Also, what type of
>>>>>>>> panel is used on that
>>>>>>>> chromebook?
>>>>>>>
>>>>>>> The curious thing is that there are no real logs in dmesg or /var/log/
>>>>>>> messages about this. This picture just fails to come
>>>>>>> back. If there are
>>>>>>> some kernel params I can set to get deeper logging, that
>>>>>>> would help, but
>>>>>>> I'm not aware of any.
>>>>>>>
>>>>>>> I think the panel is a "BOE NV116WHM-T00" - I used this command to get
>>>>>>> info: cat /sys/class/drm/card0-eDP-1/edid | edid-decode
>>>>>>>
>>>>>>> Output:
>>>>>>> https://urldefense.com/v3/__https://termbin.com/8nbd__;!!
>>>>>>> CTRNKA9wMg0ARbw! jrsPDtSEUdaINzLlq92Li8gmsEBkTOxZ6WUzNHjvIN6CyOJjHiHkNSOhIRPXFTLPlaYlxU2uvryVkwjUAJooSyqL$
>>>>>>
>>>>>> This looked stalled. If I'm mistaken here, please let me known; but if
>>>>>> no solution is in sight, should we maybe just revert the change until a
>>>>>> proper was found?
>>>>>
>>>>> It's welcome anyone to provide a revert patch,
>>>>> but I would still wait for the fixup patch until 7.2-rc4.
>>>>> If no fixup patch exist, then apply the revert patch.
>>>>   From my understanding of things the position in the devel cycle doesn't
>>>> matter much in a case like this. To quote Linus statements from
>>>> https://www.kernel.org/doc/html/latest/process/handling-
>>>> regressions.html#on-how-quickly-regressions-should-be-fixed
>>>>
>>>> """
>>>>   From 2026-01-22:
>>>>
>>>>    But a user complaining should basically result in an immediate fix -
>>>>    possibly a "revert and rethink".
>>>>
>>>> With a later clarification on 2026-01-28:
>>>>
>>>>    It's also worth noting that "immediate" obviously doesn't mean "right
>>>>    this *second* when the problem has been reported".
>>>>
>>>>    But if it's a regression with a known commit that caused it, I think
>>>>    the rule of thumb should generally be "within a week", preferably
>>>>    before the next rc.
>>>> """
>>>>
>>>> Adam reported the problem about three weeks ago, so we are way past the
>>>> "rule of thumb" timeframe Linus set.
>>>>
>>>> Ciao, Thorsten
>>>
>>> This is a kind of odd situation here. The fix from Adam is actually
>>> correct, as in,
>>> the SN65DSI83 bridge gets broken without...
>>>
>>> ....but then, there's some more oddness going on: I tried to reproduce
>>> this on my
>>> MT8173 Elm device, but there I can resume the system just fine, and the
>>> display is
>>> up and running like normal?
>>>
>>> I'm not sure what to advice here at this point - just adding some info.
>>>
>>> Cheers,
>>> Angelo
>> Angelo, would you mind sharing your config, and the details of what you're
>> running? It might be a configuration difference.
> 
> As a FYI here is the latest branch I tested that patch on:
> https://github.com/gibsson/linux-next/commits/master-mtk/
> 
> As far as I remember suspend/resume was ok. It was tested with a
> Tungsten510 SMARC SOM (MT8370) + sn65dsi83 + tm070jdhg30 display.
> Both the bridge and the display are mainline, you can see that the main
> change is in the defconfig where a bunch of options are changed to be
> built-in (for NFS booting).
> 
> I'll try to repro against latest kernel this week and report back.
> 
> In your case, is the panel upstream as well?
> 
> Regards,
> Gary

Gary, thanks for chiming in.

The machine he's referring to is using a Parade PS8640 DSI to eDP bridge: check
mt8173-elm.dtsi for (slightly) more information.

Cheers,
Angelo
