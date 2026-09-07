Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E8DC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75BD10E6AC;
	Mon,  7 Sep 2026 08:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="R9o5yi+G";
	dkim-atps=neutral
Received: from mail-m93254.xmail.ntesmail.com (mail-m93254.xmail.ntesmail.com
 [103.126.93.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083EB10E6AC
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:10:33 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ccabc703;
 Mon, 7 Sep 2026 16:10:29 +0800 (GMT+08:00)
Message-ID: <745c232e-d2ff-4d32-b997-55d4d37a39fa@rock-chips.com>
Date: Mon, 7 Sep 2026 16:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: Icenowy Zheng <uwu@icenowy.me>, Maud Spierings
 <maud_spierings@murena.io>, Dominique Belhachemi <domibel@debian.org>
Cc: m.wilczynski@samsung.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, alex@ghiti.fr, andrzej.hajda@intel.com,
 andy.yan@rock-chips.com, andyshrk@163.com, aou@eecs.berkeley.edu,
 bmasney@redhat.com, conor+dt@kernel.org, conor@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hal.feng@starfivetech.com, heiko@sntech.de, hello@big-grey.co.uk,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@esmil.dk,
 krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, luca.ceresoli@bootlin.com,
 m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com,
 maudspierings@gocontroll.com, mfd@lists.linux.dev, mripard@kernel.org,
 mturquette@baylibre.com, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 palmer@dabbelt.com, pjw@kernel.org, rfoss@kernel.org, robh@kernel.org,
 sboyd@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, vkoul@kernel.org
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
 <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
 <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
 <cb0884b3-c9be-4cfd-ba43-27add3821ddd@murena.io>
 <6a5f8c11a092cef83bae8d9ea0100c2fc133a514.camel@icenowy.me>
 <CAAvaLCxMntrTbTQ9VNu4H_6LA30TRAqi7mCpn+x3hbTG9WqERA@mail.gmail.com>
 <057d97bd4b63fa4445dd86548f2ecdcbe9c3b1b6.camel@icenowy.me>
 <f68d95d0-f918-4dee-9443-38c64247b71a@murena.io>
 <72f82ae67eca7b5a594d86852c8b0dafb7d02c4c.camel@icenowy.me>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <72f82ae67eca7b5a594d86852c8b0dafb7d02c4c.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa07aeb328603a7kunma6aa1bc239fa0d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkIdVk9ITEtLGh4eHU5PHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=R9o5yi+G+F8zZyawx3whCVV/olFPrerxkAmSHzyaoP+qbbbFH+YbmhSzuasWco4g2ROixc1HaVg3Nk57qQfVWoyw147x+rkDDlxVI/S0hnMtjX9juxpUqfyv6S//I3qqIuaSa56RUA+YvW7x4fEuPAtkPm8AgKLXPFAQYdGtlmY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=PAs6cpRutX6Xy3xUaS1PXdj4b2ODwk4xwVldcIzzW7w=;
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

Hello Icenowy, Maud, Dominique,

On 9/7/2026 2:55 PM, Icenowy Zheng wrote:
> 在 2026-09-07一的 08:02 +0200，Maud Spierings写道：
>> Hi Dominique and Icenowy,
>>
>> On 9/7/26 06:01, Icenowy Zheng wrote:
>>> 在 2026-09-06日的 17:16 -0400，Dominique Belhachemi写道：
>>>> On Sun, Sep 6, 2026 at 11:19 AM Icenowy Zheng <uwu@icenowy.me>
>>>> wrote:
>>>>>
>>>>> 在 2026-09-06日的 16:59 +0200，Maud Spierings写道：
>>>>>> On 9/6/26 07:39, Dominique Belhachemi wrote:
>>>>>>> On Sun, Aug 30, 2026 at 10:17 AM Maud Spierings
>>>>>>> <
>>>>>>> maud_spierings@murena.io <mailto:maud_spierings@murena.io>>
>>>>>>> wrote:
>>>>>>>
>>>>>>>      I was still having some glitching happening on the
>>>>>>> display,
>>>>>>> but
>>>>>>> I've
>>>>>>>      found the way to fix that, the question is what is
>>>>>>> actually
>>>>>>>      happening here.
>>>>>>>
>>>>>>>          0x29590020 <- 0x00000005
>>>>>>>      This one I have no idea, it is 0x00000009 with this
>>>>>>> patch
>>>>>>> series but
>>>>>>>      with the vendor kernel I get the value above. When I
>>>>>>> hook
>>>>>>> up my
>>>>>>>      external
>>>>>>>      display (regular 1440p) this becomes 0x0000000D on the
>>>>>>> vendor
>>>>>>> kernel.
>>>>>>>
>>>>>>>      But I can't find this register being written to
>>>>>>> anywhere
>>>>>>> there?
>>>>>>>
>>>>>>>
>>>>>>> Maybe this needs to be swapped?
>>>>>>>
>>>>>>> drivers/gpu/drm/bridge/inno-hdmi.c
>>>>>>>     -#define v_HSYNC_POLARITY(n)          ((n) << 3)
>>>>>>>     -#define v_VSYNC_POLARITY(n)          ((n) << 2)
>>>>>>>     +#define v_HSYNC_POLARITY(n)          ((n) << 2)
>>>>>>>     +#define v_VSYNC_POLARITY(n)          ((n) << 3)
>>>>>
>>>>> Very weirdly, the original definition here matches current
>>>>> mainline
>>>>> inno-hdmi.c, but the changed definition matches JH7110 vendor
>>>>> inno_hdmi.h [1].
>>>>>
>>>>
>>>> The vendor code is correct and matches the RK3128 TRM.
>>>
>>> Thanks for the tips on documentation, and I verified this.
>>>
>>> It seems that Rockchip people made this always wrong, even with
>>> their
>>> pre-DRM display driver... [1]
>>>
>>> BTW I checked the Innosilicon dGPU driver code, and its
>>> g3_ne_hdmi.h
>>> source file also contains the definition of BIT(3) as VSYNC. (It's
>>> quite weird that most logic of that driver is in some .o_shipped
>>> blob,
>>> but fortunately the g3 logic might be too new to be closed down)
>>>
>>> Thanks,
>>> Icenowy
>>>
>>> [1]
>>> https://github.com/rockchip-linux/kernel/blob/release-4.4/drivers/video/rockchip/hdmi/rockchip-hdmiv1/rockchip_hdmiv1_hw.h#L161
>>>
>>>>
>>>> HDMI_reg08
>>>>      Bit  Attr  Reset  Description
>>>>      3    RW    0x0    vs_polarity   VSYNC polarity   1'b0:
>>>> Negative
>>>> 1'b1: Positive
>>>>      2    RW    0x0    hs_polarity   HSYNC polarity   1'b0:
>>>> Negative
>>>> 1'b1: Positive
>>>>
>>>> Nobody noticed this so far because in 720p/1080p both polarities
>>>> are
>>>> positive, but Maud's 3:2 panel has differing H/V polarity.
>>>>
>>>> Best
>>>> -Dominique
>>
>> This also solves the devmem behaviour I saw, or well, doesn't realy 
>> explain it but does show what is actually happening. As Icenowy noted
>> (maybe that was on telegram only?) the inno-hdmi regs are 8bit
>> instead 
>> of 32 bit.
>>
>> What is actually happening is:
>>
>> devmem 0x29590000 b reads 0x29590000 as expected
>> but
>> devmem 0x29590004 b reads 0x29590001
>> devmem 0x29590008 b reads 0x29590002
>> ....
>> devmem 0x29590020 b reads 0x29590008
>>
>> For some reason the addressing is weird?
>>
>> With this change, the assigned clock change and removing the 
>> v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS write to HDMI_SYS_CTRL, the
>> display 
>> comes up from the start as it should!
> 
> Well I checked the RK3128 TRM for these two bits, and their field
> descriptions are -- "reserved".
> 
> What can I react...
> 

You can take a look at the TRM of the RK61X[0]. 
I think it contains the register descriptions you're looking for :)

[0]: https://dl.radxa.com/rock/docs/hw/ds/Rockchip%20RK61X%20TRM%20V1.3.1.pdf

-- 
Best, 
Chaoyi

