Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=IFaBwVeV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A4110FBBB;
	Wed, 25 Nov 2026 11:44:06 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DC010FBCB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:44:00 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C34282E0;
 Wed, 25 Nov 2026 12:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795606885;
 bh=ocFPnV6tUBRjjstHlDwr8kukBG0+BHkvq63/lbQfLds=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IFaBwVeVO35SFZjb1/WwOdAHgpsMjU214L+OEukkT+DkcoGTVvfcg/E5HKmXiQab9
 IfplW8mW4eyhQAHBDx8Bv/JhUyrtrtCyHkNkjSgmKviXBR+daGdRLPnASiY2qRHqZO
 d6rogQK985Eh1JCpRYy6jFld0ggnZgsFYiPuQ/fE=
Message-ID: <d9a10f1f-7550-49ee-9085-6ad4c662080d@ideasonboard.com>
Date: Wed, 25 Nov 2026 13:43:55 +0200
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
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <awazkzDVZtpUsdQb@houat>
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

On 25/11/2026 12:11, Maxime Ripard wrote:
> On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 24/11/2026 16:11, Màxim Pedraza Padilla wrote:
>>> On Wed, Nov 18, 2026 at 10:21:14PM +0100, Màxim Pedraza Padilla wrote:
>>>> Makes sense, I'll use the same approach in tilcdc, and see if it can be
>>>> turned into a common helper along the way.
>>>
>>> A follow-up on this one, now that I've rebased on v9. I ended up doing
>>> it differently, so I'd rather explain why before sending the next
>>> version.
>>>
>>> The tidss approach rounds the clock to the closest standard refresh rate.
>>> Panels driven by tilcdc often don't use one: with the timings from its
>>> datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which would
>>> be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
>>> match the panel mode, even with U-Boot programming exactly the same one.
>>
>> I felt that approach was a bit odd (and if I recall right, failed with my
>> OLDI panel), and in my tidss version I just used the clock rate directly
>> from the clk_get_rate() (see dispc_vp_readout_mode):
> 
> The problem is that you're losing information when setting the clock.
> Especially for panels where you don't really have an established set of
> pixel clocks, the clock is very likely to not be able to give the exact
> frequency you asked for.
> 
> So when you're reading the clock frequency, the mode you're reading and
> the one you'd set at first modeset will not necessarily match, so you
> need to take that difference into account and try to get back on your
> feet.
If I understand correctly, your code in tidss is trying to guess the 
pclk rate in (say) the simple-panel driver via assuming the refresh rate 
is one of the standard ones?

I don't think that works... Even if the target refresh rate in the panel 
driver is close to (or exactly) those standard ones, it won't be the 
same clock rate except by luck. And u-boot may have a different PLL 
calculation, or different pclk in its dtso.

I think the u-boot part should be fixed just by "fix your bootloader": 
if you want SRO to work, make your bootloader use the same videomode 
(including pclk) as the kernel.

But even then it won't work. If the simple panel states pclk as 150.274 
MHz, it will cause the HW to set 150.0 MHz, and the SRO in this series 
will calculate 150.124675 MHz. This will cause a full modeset, and also 
the SRO check will given an error.

So... First, I think at least in the adjusted_mode we should have the 
real pclk. The SRO check should pass only an equals check there. For 
mode's pclk, I think setting the actual pclk makes sense, at least more 
than guessing it. Or could we, at that stage, see what modes the 
connector advertises, and pick a clock from there?

If we can't get the pclks from the connector, the mode->clock won't 
match, and we should either skip checking that in the SRO checks, or 
have plenty of tolerance. I think it still leads to a full modeset, but 
can the driver check if setting the mode->clock would results in the 
current pclk, and somehow abort the full modeset?

  Tomi

