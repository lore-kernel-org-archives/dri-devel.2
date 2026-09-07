Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0297CC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0946A10E32A;
	Mon,  7 Sep 2026 06:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="PmA/HmG6";
	dkim-atps=neutral
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF3210E3CD
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 06:02:39 +0000 (UTC)
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id B5691721160;
 Mon,  7 Sep 2026 06:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1788760956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAVC7+HWaVQEnnbRSHCcKz7r6ECmUII3NjKcSqgDdqE=;
 b=PmA/HmG6YkWmDztp42L5zdma4jFThIPnKvAqNfbKAdesgHuHViEz/9/BsbLyLPrFlMVsMR
 90PURNCV5f0ejRhPmxHXdYpHnShCWVdp5iL/i21PpFNl/H2uZYZ9c3+WkelnaTWFUrGk5B
 iBSfUKxKxkV64Fa5Y7MRVyL/qoQhpp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1788760956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAVC7+HWaVQEnnbRSHCcKz7r6ECmUII3NjKcSqgDdqE=;
 b=B7cL82PImBfFxeoSczoECpP9wW/1E0dBlifMotXVGSAoewtJC7WP6rAasDziB5y+nt8d9t
 ka/7gR0eTSE8njdmzxtOje2HHaTjLKe6OFXRMXhKUbs66npTNSBI20Odzcy8a+XGIHu3B9
 u6sSUVyaFcRVrbYVNphd1SZ9uMItg/o=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1788760956; a=rsa-sha256; cv=none;
 b=rwRBNY+YtZMISw0XZ4wJRHpzo5Yp5mjZm9wz7veARrU2FXHtXfGXC60RqIcwXWYC5dud+W
 L7dEyuwGnjdl0A8avafm5S5qS1okQ4f9cuM7HuL2m1jEy3RMF9b7rhW97RRaFAfovoOiBa
 OvyG566rnyc+P4JwysSkJgarI/RAlcQ=
Message-ID: <f68d95d0-f918-4dee-9443-38c64247b71a@murena.io>
Date: Mon, 7 Sep 2026 08:02:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: Icenowy Zheng <uwu@icenowy.me>, Dominique Belhachemi <domibel@debian.org>
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
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <057d97bd4b63fa4445dd86548f2ecdcbe9c3b1b6.camel@icenowy.me>
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

Hi Dominique and Icenowy,

On 9/7/26 06:01, Icenowy Zheng wrote:
> 在 2026-09-06日的 17:16 -0400，Dominique Belhachemi写道：
>> On Sun, Sep 6, 2026 at 11:19 AM Icenowy Zheng <uwu@icenowy.me> wrote:
>>>
>>> 在 2026-09-06日的 16:59 +0200，Maud Spierings写道：
>>>> On 9/6/26 07:39, Dominique Belhachemi wrote:
>>>>> On Sun, Aug 30, 2026 at 10:17 AM Maud Spierings
>>>>> <maud_spierings@murena.io <mailto:maud_spierings@murena.io>>
>>>>> wrote:
>>>>>
>>>>>      I was still having some glitching happening on the display,
>>>>> but
>>>>> I've
>>>>>      found the way to fix that, the question is what is actually
>>>>>      happening here.
>>>>>
>>>>>          0x29590020 <- 0x00000005
>>>>>      This one I have no idea, it is 0x00000009 with this patch
>>>>> series but
>>>>>      with the vendor kernel I get the value above. When I hook
>>>>> up my
>>>>>      external
>>>>>      display (regular 1440p) this becomes 0x0000000D on the
>>>>> vendor
>>>>> kernel.
>>>>>
>>>>>      But I can't find this register being written to anywhere
>>>>> there?
>>>>>
>>>>>
>>>>> Maybe this needs to be swapped?
>>>>>
>>>>> drivers/gpu/drm/bridge/inno-hdmi.c
>>>>>     -#define v_HSYNC_POLARITY(n)          ((n) << 3)
>>>>>     -#define v_VSYNC_POLARITY(n)          ((n) << 2)
>>>>>     +#define v_HSYNC_POLARITY(n)          ((n) << 2)
>>>>>     +#define v_VSYNC_POLARITY(n)          ((n) << 3)
>>>
>>> Very weirdly, the original definition here matches current mainline
>>> inno-hdmi.c, but the changed definition matches JH7110 vendor
>>> inno_hdmi.h [1].
>>>
>>
>> The vendor code is correct and matches the RK3128 TRM.
> 
> Thanks for the tips on documentation, and I verified this.
> 
> It seems that Rockchip people made this always wrong, even with their
> pre-DRM display driver... [1]
> 
> BTW I checked the Innosilicon dGPU driver code, and its g3_ne_hdmi.h
> source file also contains the definition of BIT(3) as VSYNC. (It's
> quite weird that most logic of that driver is in some .o_shipped blob,
> but fortunately the g3 logic might be too new to be closed down)
> 
> Thanks,
> Icenowy
> 
> [1]
> https://github.com/rockchip-linux/kernel/blob/release-4.4/drivers/video/rockchip/hdmi/rockchip-hdmiv1/rockchip_hdmiv1_hw.h#L161
> 
>>
>> HDMI_reg08
>>      Bit  Attr  Reset  Description
>>      3    RW    0x0    vs_polarity   VSYNC polarity   1'b0: Negative
>> 1'b1: Positive
>>      2    RW    0x0    hs_polarity   HSYNC polarity   1'b0: Negative
>> 1'b1: Positive
>>
>> Nobody noticed this so far because in 720p/1080p both polarities are
>> positive, but Maud's 3:2 panel has differing H/V polarity.
>>
>> Best
>> -Dominique

This also solves the devmem behaviour I saw, or well, doesn't realy 
explain it but does show what is actually happening. As Icenowy noted 
(maybe that was on telegram only?) the inno-hdmi regs are 8bit instead 
of 32 bit.

What is actually happening is:

devmem 0x29590000 b reads 0x29590000 as expected
but
devmem 0x29590004 b reads 0x29590001
devmem 0x29590008 b reads 0x29590002
....
devmem 0x29590020 b reads 0x29590008

For some reason the addressing is weird?

With this change, the assigned clock change and removing the 
v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS write to HDMI_SYS_CTRL, the display 
comes up from the start as it should!

Kind regards,
Maud
