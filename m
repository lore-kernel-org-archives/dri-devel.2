Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6411606A68F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Dvjtq42j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E94210FCA9;
	Wed, 25 Nov 2026 14:56:03 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D5F10FCB4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:55:57 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BE682E0;
 Wed, 25 Nov 2026 15:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795618401;
 bh=l0UwhknkvZM1tME4XXDdjSPtGcqJRDwjN1FNy8DVAd8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Dvjtq42jnZXnU4zNdi9Y1iAJ+jLakzDn7sHclccQLTTg2NVsdLVsVuUZuJyuXtZ5i
 qWoXpjaq5++180usbztyMc3qY+cLIsssWI5YDSXxPU9imse6ETldAUzuyyQgkMtE3b
 DBNJiCG9eztx6ItEDnjvOyXmW9igRV7KDwQmUem4=
Message-ID: <4d93a4af-9e57-4394-913f-4f861e3e7954@ideasonboard.com>
Date: Wed, 25 Nov 2026 16:55:51 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
To: Maxime Ripard <mripard@kernel.org>
Cc: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
 <awazkzDVZtpUsdQb@houat>
 <d9a10f1f-7550-49ee-9085-6ad4c662080d@ideasonboard.com>
 <awbOkmmNIp2ng97n@houat>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <awbOkmmNIp2ng97n@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 25/11/2026 14:21, Maxime Ripard wrote:
> On Wed, Nov 25, 2026 at 01:43:55PM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 25/11/2026 12:11, Maxime Ripard wrote:
>>> On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
>>>> Hi,
>>>>
>>>> On 24/11/2026 16:11, Màxim Pedraza Padilla wrote:
>>>>> On Wed, Nov 18, 2026 at 10:21:14PM +0100, Màxim Pedraza Padilla wrote:
>>>>>> Makes sense, I'll use the same approach in tilcdc, and see if it can be
>>>>>> turned into a common helper along the way.
>>>>>
>>>>> A follow-up on this one, now that I've rebased on v9. I ended up doing
>>>>> it differently, so I'd rather explain why before sending the next
>>>>> version.
>>>>>
>>>>> The tidss approach rounds the clock to the closest standard refresh rate.
>>>>> Panels driven by tilcdc often don't use one: with the timings from its
>>>>> datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which would
>>>>> be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
>>>>> match the panel mode, even with U-Boot programming exactly the same one.
>>>>
>>>> I felt that approach was a bit odd (and if I recall right, failed with my
>>>> OLDI panel), and in my tidss version I just used the clock rate directly
>>>> from the clk_get_rate() (see dispc_vp_readout_mode):
>>>
>>> The problem is that you're losing information when setting the clock.
>>> Especially for panels where you don't really have an established set of
>>> pixel clocks, the clock is very likely to not be able to give the exact
>>> frequency you asked for.
>>>
>>> So when you're reading the clock frequency, the mode you're reading and
>>> the one you'd set at first modeset will not necessarily match, so you
>>> need to take that difference into account and try to get back on your
>>> feet.
>>
>> If I understand correctly, your code in tidss is trying to guess the pclk
>> rate in (say) the simple-panel driver via assuming the refresh rate is one
>> of the standard ones?
> 
> Yes, and I have yet to see a panel that would have a refresh rate that
> isn't one of the standard ones.

They often have quite wide ranges, and don't define clear nominal 
timings and refresh rate. But I agree, almost always one can have a 60Hz 
timing with them.

That doesn't mean our panel/bridge drivers would define such neat 
clocks. In my experience, the panel's timings are often based on X, 
which probably is something that happened to work on one platform, and 
was good enough. Those can be fixed to result timings close to the 60 
Hz, but then we risk breaking the panel for some platforms.

Bridge drivers can also adjust the adjusted_mode's clock when they have 
special needs (DSI).

>> I don't think that works... Even if the target refresh rate in the panel
>> driver is close to (or exactly) those standard ones, it won't be the same
>> clock rate except by luck. And u-boot may have a different PLL calculation,
>> or different pclk in its dtso.
>>
>> I think the u-boot part should be fixed just by "fix your bootloader": if
>> you want SRO to work, make your bootloader use the same videomode (including
>> pclk) as the kernel.
>>
>> But even then it won't work. If the simple panel states pclk as 150.274 MHz,
>> it will cause the HW to set 150.0 MHz, and the SRO in this series will
>> calculate 150.124675 MHz. This will cause a full modeset, and also the SRO
>> check will given an error.
> 
> Not really, because it will try to match the closest, and then try to
> keep that within a defined tolerance. So, in your example, if the
> expected pclk is 150.274MHz, and what's programmed in hardware is 150MHz
> (which also is the closest pick we can find), then it will be happy with
> 150MHz.

What will be happy?

*ERROR* crtc-0 configuration mismatch in mode expected "1920x1200": 60 
150274 1920 1952 2004 2028 1200 1224 1232 1235 0x48 0x0, got 
"1920x1200": 60 150124 1920 1952 2004 2028 1200 1224 1232 1235 0x40 0x5

> And let's turn this around: what happens if your expected pclk is
> 150.274MHz, and the actual rate programmed by u-boot is, say, 124MHz?
> 
> Should we do a modeset then?

If clk_set_rate(150274000) results in pclk of 124MHz, then it's the 
correct mode, no modeset needed. There are cases like that, but I'm fine 
with not targeting them at least initially.

> It's also a matter of consistency within the framework. The framework
> expects the "ideal" mode everywhere. How is the pclk actually programmed
> isn't tracked anywhere. So, if you have a regular modeset, we'd have
> mode and adjusted_mode have the "ideal" pclk, but in the case of SRO
> we'd have the actual one, possibly forever?

With regular modeset, we'd have the ideal pclk in mode, and the real 
pclk in adjusted_mode, right?

My worry is that we'll not be able to guess the ideal pclk very well. 
Maybe that can be solved with fixing the panel drivers when we encounter 
non-ideal timings, and having a clear rule that the provided timings 
have to result in a "normal" refresh rate, even if the platform has to 
adjust them when applying.

>> So... First, I think at least in the adjusted_mode we should have the real
>> pclk.
> 
> You can't have that. The closest you'd have would be calling
> clk_round_rate() at atomic_check, but you have no guarantee that it's
> actually going to be the same rate by the time you call clk_set_rate().

Why is that? Can't we do the clk_round_rate in SRO? The SRO state has 
the adjusted timings, doesn't it?

Yes, I guess clk_round_rate() there and clk_set_rate() later might 
result in different rates in theory, but can that happen in practice? If 
the clock is being kept on, it's unlikely that its parent clocks would 
change. So it's not immediately clear to me when this could happen.

> Either way, assuming we would do that, it would give you adjusted_mode.
> You'd still need mode, and mode is what is shown to userspace.

Yes.

>> The SRO check should pass only an equals check there. For mode's pclk,
>> I think setting the actual pclk makes sense, at least more than guessing it.
>> Or could we, at that stage, see what modes the connector advertises, and
>> pick a clock from there?
> 
> It's difficult, because then you assume that A) the bootloader will have
> used a mode reported by the monitor and B) crtcs need to be readout
> before connectors.

Isn't A) needed anyway for fully working SRO and smooth transition to 
the userspace app's display? The userspace's modeset will most likely 
use the preferred mode from the display, and if that's different than 
the bootloader's it will then cause a full modeset.

Or how do apps usually work? Do they try to get the current mode from 
the crtc, and use that, even if it's not the connector's advertised 
default mode?

>> If we can't get the pclks from the connector, the mode->clock won't match,
>> and we should either skip checking that in the SRO checks, or have plenty of
>> tolerance.
> 
> tidss has 5% of tolerance when most of the drivers have .5%. How much do
> you need?

I was referring to the SRO code, which currently gives errors if the 
modes don't match exactly.

>> I think it still leads to a full modeset, but can the driver check if
>> setting the mode->clock would results in the current pclk, and somehow
>> abort the full modeset?
> 
> I'd rather discuss an actual bug here. Do you have a case you can share
> where the logic we currently have doesn't work and is not an instance of
> poor panel timings?
It's the case with the OLDI panel. You should be able to test it with 
AM62-SK even without an actual panel, just load the 
k3-am625-sk-microtips-mf101hie-panel.dtbo. Ah, actually, there's the 
touchscreen in the dtbo, so you may need to disable that in the dtso. 
Although I guess even if it's enabled, you'll just possibly see an error 
from the touch driver, and it doesn't affect the display.

So even if you don't have bootloader that enabled the OLDI panel, you 
should see the configuration mismatch errors.

  Tomi

