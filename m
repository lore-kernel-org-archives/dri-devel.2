Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCA21090229
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20A810E16E;
	Thu, 19 Mar 2026 13:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YGwlOTbk";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF55510E16E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 13:47:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B61551A2EE5;
 Thu, 19 Mar 2026 13:47:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7B8DF5FDEB;
 Thu, 19 Mar 2026 13:47:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E729104509C4; Thu, 19 Mar 2026 14:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773928074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Cx839nwFg9x1myWgtHWJ12W7NUrDxF+NCqHOKy0Irew=;
 b=YGwlOTbkR50NQYQfNXh2cJGHzaO3fEj40UV2vASwufkxtYNiRS+Tlx0STCBD19Q86PRn4O
 COCxtnDSJ7gfxMrLrx//a2xnO71QErmyLNlgNBkYX1x0ic/zPzemW6N0mUdv86uGBodOXR
 dyT/XSQW1UbGFUEl3ceKvBiXRmw1/snDgl+47+Q3T03+vzdU/B/+Xva5Y4OsyAJ18oUJfO
 PHjHgnM1gKXjGjwbZBct3957MBU2yjN+oyHuXxVaXggPAjA4z/kjlbtrsBBaL8CpKKpHgy
 BfbgET1O8h9dDVWuiOr1/B9d0U/eIdeDSzAI3OjS5nUlGAihybwqXd+hafRHnQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 14:47:47 +0100
Message-Id: <DH6T0NTZHP93.2DWN4BWDPP331@bootlin.com>
Subject: Re: [PATCH v2 0/2] drm: bridge: ti-sn65dsi83: Improve dual-link
 LVDS support
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
To: <tessolveupstream@gmail.com>, "Marek Vasut" <marex@nabladev.com>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <9f694b2d-44bc-46ad-8aa3-b464c2f0da13@nabladev.com>
 <176ed865-11a6-42de-89e0-06951b59a430@gmail.com>
 <DH0X7QW3AH3C.PRNRA8CRSSKA@bootlin.com>
 <49b79a0d-844b-4fee-bccb-706187ed76d1@gmail.com>
 <DH5S3DYT0PJQ.11ABZFGEU6ZPC@bootlin.com>
 <a937f714-d013-4ac2-a52b-2893fc16f225@gmail.com>
In-Reply-To: <a937f714-d013-4ac2-a52b-2893fc16f225@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu Mar 19, 2026 at 10:55 AM CET, tessolveupstream wrote:
>
>
> On 18-03-2026 14:21, Luca Ceresoli wrote:
>> Hello Sudarshan,
>>
>> On Wed Mar 18, 2026 at 6:45 AM CET, tessolveupstream wrote:
>>>>>> You might want to look at recently posted:
>>>>>>
>>>>>> [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dua=
l LVDS output
>>>>>
>>>>> Thanks for pointing this out.
>>>>> I tried applying the patch =E2=80=9C[PATCH 2/3] drm/bridge: ti-sn65ds=
i83: halve horizontal syncs for dual LVDS output=E2=80=9D on top of the cur=
rent tree and
>>>>> removed the changes that I had previously added in the driver.
>>>>> However, with this patch applied, I am currently seeing only the back=
light turning on and no image on the LVDS panel.
>>>>> For reference, the LVDS panel used on our platform is G133HAN01.1 and=
 the
>>>>> DSI-to-dual-link LVDS bridge is SN65DSI84ZXHR.
>>>>
>>>> Thanks for having tried.
>>>>
>>>> Can you please test with both the fixes in the series applied + the te=
st
>>>> pattern feature and report the results you get with and without test
>>>> pattern enabled?
>>>>
>>>> The patches to apply are:
>>>>
>>>>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-a=
nd-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
>>>>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-a=
nd-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
>>>>  - https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-=
and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/
>>>>
>>>
>>> Thanks for the suggestions.
>>>
>>> I tested the three patches together as mentioned, but the LVDS panel
>>> still only shows the backlight and no image. I also tried removing the
>>> test-pattern patch and retesting with only the remaining two fixes, but
>>> the result remained the same =E2=80=94 only the backlight turns on and =
no image
>>> is displayed.
>>
>> Sure, the test pattern patch does not change anything, unless you enable
>> the test pattern.
>>
>>>> The first thing I suggest doing on your side is testing with the 3 pat=
ches
>>>> mentioned above.
>>>>
>>>> If you display works, good! Let us know (you can also add your Tested-=
by /
>>>> Reviewed-by tags to the test_pattern patch too if applicable).
>>>>
>>>> If it doesn't work, compare the individual register values to find the
>>>> differences, try to figure out why the working setting works and how t=
o
>>>> apply that change to the driver in away that keeps other boards
>>>> working. You're welcome to come back here to discuss it in case you ca=
n't
>>>> find out on your own.
>>>>
>>>
>>> I tested the three patches as suggested, but the panel still shows only=
 the
>>> backlight with no visible image. I=E2=80=99m unsure how to translate th=
e working
>>> register values into a generic fix based on display timings. Any guidan=
ce
>>> on the right direction would be helpful.
>>
>> What you should do is:
>>
>>  1. with your patches, and while the display is enabled (and working) do
>>
>>      cat /sys/kernel/debug/regmap/4-002c/registers >regs.working
>>
>>  2. remove your patches, add the 3 I mentioned, and while the display is
>>     enabled (but only backlight is working) do
>>
>>      cat /sys/kernel/debug/regmap/4-002c/registers >regs.broken
>>
>> Then compare regs.working and regs.broken. Which registers differ? Can y=
ou
>> give a reason for the differences?
>>
>> You can come back with these values here so we may discuss them.
>>
>
> I followed your suggestion and captured the register dumps in both cases.

Thanks for getting the values.

> In the working case, several of the timing registers remain at 0,
> while in the broken case they are programmed with non-zero values.

Yes, but read the documentation carefully and you will discover this is
OK. Also you shuld analyze all the differences, some are very interesting.

The differences are:

  reg working broken  what changes
  12:   53      55    CHA_DSI_CLK_RANGE
  18:   6f      0f    HS_NEG_POLARITY, VS_NEG_POLARITY
  19:   00      05    CHB_LVDS_VOD_SWING, CHA_LVDS_VOD_SWING
  24:   00      38    CHA_VERTICAL_DISPLAY_SIZE_LOW (*)
  25:   00      04    CHA_VERTICAL_DISPLAY_SIZE_HIGH (*)
  2c:   10      15    CHA_HSYNC_PULSE_WIDTH_LOW
  34:   28      2c    CHA_HORIZONTAL_BACK_PORCH
  36:   00      0e    CHA_VERTICAL_BACK_PORCH (*)
  38:   00      1d    CHA_HORIZONTAL_FRONT_PORCH (*)
  3a:   00      08    CHA_VERTICAL_FRONT_PORCH (*)

Values with (*) are those you mentioned above (zero in the working case,
nonzero in the "broken" case). The docs for these registers says: "TEST
PATTERN GENERATION PURPOSE ONLY". Those values are irrelevant when not
using the test pattern.

Your timings are all different. That means probably you have them
incorrectly described in device tree or the panel driver, so the
ti-sn65dsi83 driver computes them using a correct formula but based on
incorrect inputs, thus producing incorrect output values into the
registers. What are the timings in your dts or the panel drivers? If you
don't understand the question: what is your panel description in device
tree?

About CHA_DSI_CLK_RANGE: what is your DSI clock?

Finally I don't think the swing values are problematic, so I'd leave them
as the last thing to check.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
