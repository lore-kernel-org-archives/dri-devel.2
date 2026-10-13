Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F88CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD1110E97F;
	Tue, 13 Oct 2026 16:59:07 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E938710E87B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791910740;
 bh=0JuHyGtucJF7J9mRhufnkU+88GP5uhF9yvKU27FqKs8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FCx2+XwBELik0r+RNoxSIFBIkx7ohE/ZAy5J8mrZ+mxhFSZ6jTCy/smD+24zb4XlU
 hTup/KmIT+2qyVBUFLWDHoxLcr/0JXP9xm+uwv1TBBojGS2dUXx2mWR0lZuYoy0Rkj
 uoq0yuQDHesUxT3iKtakO6KHtjJfe3uH/Xlt50UNyoC5d5IPFHKQMTHKv4DvWYM+cX
 HbAfQVlwRz9su+5ODPAHW5R9lNrcduxXWZOB5I0upXHXwASdo+bVIX9mJMLgLKB097
 r3PHBqQ8ujQfphZzXlLim4HCwvo+/EF967HH6GhIYzIg84t3SXT50M1jwMXS3/1swJ
 97WZqCCOu9VzA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EED5C17E0099;
 Tue, 13 Oct 2026 18:58:59 +0200 (CEST)
Message-ID: <86109ed5-2c0b-4b1a-8c48-1102bd043fad@collabora.com>
Date: Tue, 13 Oct 2026 19:58:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165
 MHz
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com>
 <20261013-vc4-common-scramb-v2-2-a41d15e131ad@collabora.com>
 <682b6dc0-0b9f-4b2c-afd5-459e3f669130@collabora.com>
 <CAPY8ntBFT_R1HbzzCvdvJ01SV8db0Cz7HcuRE7HaoyJ3-1FATQ@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAPY8ntBFT_R1HbzzCvdvJ01SV8db0Cz7HcuRE7HaoyJ3-1FATQ@mail.gmail.com>
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

Hi Dave,

On 10/13/26 6:59 PM, Dave Stevenson wrote:
> Hi Cristian
> 
> On Tue, 13 Oct 2026 at 01:16, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> Hi Dave,
>>
>> On 10/13/26 1:37 AM, Cristian Ciocaltea wrote:
>>> Historically, the HSM clock for BCM2835 was fixed at 163.7 MHz.  Since
>>> the pixel clock had to be at least 1% below the HSM clock, it was capped
>>> at 162 MHz.
>>>
>>> Since commit cd4cb49dc5bb ("drm/vc4: hdmi: Adjust HSM clock rate
>>> depending on pixel rate"), the HSM clock rate is set to pixel clock *
>>> 101 / 100.  For a 165 MHz pixel clock, this gives an HSM rate of 166.65
>>> MHz, which, per Dave Stevenson, the hardware can handle without issues.
>>>
>>> Increase the max pixel clock to 165 MHz, which matches the maximum TMDS
>>> character rate of HDMI 1.0 through 1.2.
>>
>> It seems this will cause CEC register corruption:
>>
>> https://sashiko.dev/#/patchset/20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com?part=2
>>
>> We can easily address this by clamping the CEC clock divider to its register
>> field width:
>>
>> -       clk_cnt = cec_rate / CEC_CLOCK_FREQ;
>> +       clk_cnt = min_t(unsigned long, cec_rate / CEC_CLOCK_FREQ,
>> +                       VC4_HDMI_CEC_DIV_CLK_CNT_MASK >>
>> +                       VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
>>
>> The consequence is that the CEC clock would run slightly faster than the nominal
>> 40 kHz, i.e. (165000 × 101/100) / (2^12 - 1) = 40.6959 kHz.
>>
>> I think this is still within the CEC bit-timing tolerances and shouldn't cause
>> any issues.  Could you please confirm?
> 
> My reading of the CEC spec agrees.
> 
> All the timings have tolerance of +/- 0.2ms on values up to 4.5ms, so
> that would allow up to a 4.3% tolerance on frequency.
> The error from clipping the clock divider is 1.74%, so fairly
> comfortably within tolerance.
> 
> It's only video modes with clocks in the range 162-165MHz that will
> have any inaccuracy, so pretty limited in scope anyway.

Yep, the clamp would trigger only for pixel clocks above 162.178 MHz.

> Working backwards, achieving a 40kHz output with the max divider works
> out to be a 163.8MHz HSM clock, so that would appear to be why the
> limit was introduced in the first place.

Quite possible, indeed.

So I'll prepare v3, which adds yet another prerequisite patch to clamp the CEC
clock divider.

Thanks,
Cristian
