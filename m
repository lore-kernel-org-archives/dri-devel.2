Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CD8C61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 14:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59ED410E1BD;
	Sun, 30 Aug 2026 14:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="JUcM+mbm";
	dkim-atps=neutral
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C33410E1BD
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 14:17:21 +0000 (UTC)
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id DE3A9720B0D;
 Sun, 30 Aug 2026 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1788099439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mK8lh0Y0gkTG7cyzXErZ1tFBC5ib3dhnp0kbqokxsD4=;
 b=JUcM+mbmj9P3xVWeKNPmyF9z46+gdIhLA5k8zYF+eY5SM0U5PZHwtV/PaYfqlh5ExKUJzd
 ucR091UQHn8DrBvjmBMvIUNv9x4DmoeyYzuqZVp2fApFrTDQ/8fKk2BuYyQxITPpuKuq3l
 aem58g7yguytMOudai8nhwXJz8V7IQ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1788099439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mK8lh0Y0gkTG7cyzXErZ1tFBC5ib3dhnp0kbqokxsD4=;
 b=F35/nMdya4CidtmSVHlA2Ja4/UvzKQGvV5AONYnZVWcom2VJprbIWYtFOKd5kkusOjomqh
 LcyX6meOgJ6APp+yy9qZ/KZamfxVP7aPmac9FCsZ9HmyK+HIr+1nNSqNevIelAbZsUF7t5
 /S7x9fIweT+E4hMfuTZAEdAayAgBt60=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1788099439; a=rsa-sha256; cv=none;
 b=A8lcC8NI4rnAykOHFTGPCpuQ2YRvvYfUdfInx2tbQIrQCrR+g6LHLiCnahOflpl7fWbJzc
 4zFQl5Ey7g3K/qG9h5/aSTKgu9xPtKLUpvA/rEu4Kvz8pLHvr1ISKLYwZWv+Z+me6OiK4K
 j1ippoLoUUnmngIeM/LajMWlALXtCMI=
Message-ID: <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
Date: Sun, 30 Aug 2026 16:17:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
From: Maud Spierings <maud_spierings@murena.io>
To: m.wilczynski@samsung.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, alex@ghiti.fr,
 andrzej.hajda@intel.com, andy.yan@rock-chips.com, andyshrk@163.com,
 aou@eecs.berkeley.edu, bmasney@redhat.com, conor+dt@kernel.org,
 conor@kernel.org, db@domibel.de, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, hal.feng@starfivetech.com, heiko@sntech.de,
 hello@big-grey.co.uk, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 kernel@esmil.dk, krzk+dt@kernel.org, lee@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
 luca.ceresoli@bootlin.com, m.szyprowski@samsung.com,
 maarten.lankhorst@linux.intel.com, maudspierings@gocontroll.com,
 mfd@lists.linux.dev, mripard@kernel.org, mturquette@baylibre.com,
 neil.armstrong@linaro.org, p.zabel@pengutronix.de, palmer@dabbelt.com,
 pjw@kernel.org, rfoss@kernel.org, robh@kernel.org, sboyd@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de, uwu@icenowy.me, vkoul@kernel.org
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
Content-Language: en-US
In-Reply-To: <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
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

I was still having some glitching happening on the display, but I've 
found the way to fix that, the question is what is actually happening here.

With just the changes mentioned in my previous email the screen flickers 
and is very unpleasant. After doing 2 reg writes it behaves as expected:
   0x29590000 <- 0x00000061
is 0x00000075 before, difference is v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS 
in drivers/gpu/drm/bridge/inno-hdmi.c, these bits always get set but 
that seems to break this display so there must be some way to detect 
that these should not be set: v_VCLK_NOT_INV | v_REG_CLK_SOURCE_TMDS

   0x29590020 <- 0x00000005
This one I have no idea, it is 0x00000009 with this patch series but 
with the vendor kernel I get the value above. When I hook up my external 
display (regular 1440p) this becomes 0x0000000D on the vendor kernel.

But I can't find this register being written to anywhere there?

Andy, you are credited on the inno-hdmi driver, do you have a datasheet 
that gives some further info?

kind regards,
Maud

On 8/29/26 20:54, Maud Spierings wrote:
> Hi Michal,
> 
> Small request for an eventual v3
> 
>> Add the HDMI PHY driver for the StarFive JH7110.
>>
>> This driver binds to the starfive,jh7110-inno-hdmi-phy node and
>> gets its regmap from the parent. It has no dependencies on voutcrg, only
>> on its refoclk (xin24m), which breaks the probe-time circular
>> dependency.
>>
>> This driver provides two main functions:
>>  - Clock Provider: It registers clk_ops to provide the variable pixel
>>    clock (hdmi_pclk). The .set_rate operation configures the Pre-PLL
>>    registers (0x1a0+) based on the requested rate.
>>
>>  - PHY Provider: It registers phy_ops for the controller. The .power_on
>>    op configures and enables the Post-PLL and other analog blocks (BIAS,
>>    LDO, Serializer, etc.).
>>
>> The JH7110 instantiates the same Innosilicon IP as the Rockchip RK3328,
>> with the PHY register block shifted by 0x100 because it sits behind the
>> HDMI controller in the shared register space. The pre-PLL programming
>> therefore comes from the common Innosilicon helpers; this driver adds
>> the JH7110 pixel clock table, the post-PLL and the analog configuration.
>>
>> Co-developed-by: Dominique Belhachemi <db@domibel.de>
>> Signed-off-by: Dominique Belhachemi <db@domibel.de>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/phy/starfive/Kconfig                |  20 +
>>  drivers/phy/starfive/Makefile               |   1 +
>>  drivers/phy/starfive/phy-jh7110-inno-hdmi.c | 567 +++++++++++++++++++ 
>> +++++++++
>>  3 files changed, 588 insertions(+)
>>
> 
> [snip]
> 
>> +
>> +static const struct inno_hdmi_phy_pre_pll_config pre_pll_cfg_table[] = {
>> +    { 25175000, 25175000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0xF55555 },
>> +    { 25200000, 25200000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0 },
>> +    { 27000000, 27000000, 1, 90, 3, 2, 2, 10, 3, 3, 4, 0, 0 },
>> +    { 27027000, 27027000, 1, 90, 3, 2, 2, 10, 3, 3, 4, 0, 0x170A3D },
>> +    { 28320000, 28320000, 1, 28, 2, 1, 1, 3, 0, 3, 4, 0, 0x51EB85 },
>> +    { 30240000, 30240000, 1, 30, 2, 1, 1, 3, 0, 3, 4, 0, 0x3D70A3 },
>> +    { 31500000, 31500000, 1, 31, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 33750000, 33750000, 1, 33, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
>> +    { 36000000, 36000000, 1, 36, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 40000000, 40000000, 1, 80, 2, 2, 2, 12, 2, 2, 2, 0, 0 },
>> +    { 46970000, 46970000, 1, 46, 2, 1, 1, 3, 0, 3, 4, 0, 0xF851EB },
>> +    { 49500000, 49500000, 1, 49, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 49000000, 49000000, 1, 49, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 50000000, 50000000, 1, 50, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 54000000, 54000000, 1, 54, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 54054000, 54054000, 1, 54, 2, 1, 1, 3, 0, 3, 4, 0, 0x0DD2F1 },
>> +    { 57284000, 57284000, 1, 57, 2, 1, 1, 3, 0, 3, 4, 0, 0x48B439 },
>> +    { 58230000, 58230000, 1, 58, 2, 1, 1, 3, 0, 3, 4, 0, 0x3AE147 },
>> +    { 59341000, 59341000, 1, 59, 2, 1, 1, 3, 0, 3, 4, 0, 0x574BC6 },
>> +    { 59400000, 59400000, 1, 99, 3, 1, 1, 1, 3, 3, 4, 0, 0 },
>> +    { 65000000, 65000000, 1, 130, 2, 2, 2, 12, 0, 2, 2, 0, 0 },
>> +    { 68250000, 68250000, 1, 68, 2, 1, 1, 3, 0, 3, 4, 0, 0x3FFFFF },
>> +    { 71000000, 71000000, 1, 71, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 74176000, 74176000, 1, 98, 1, 2, 2, 1, 2, 3, 4, 0, 0xE6AE6B },
>> +    { 74250000, 74250000, 1, 99, 1, 2, 2, 1, 2, 3, 4, 0, 0 },
>> +    { 75000000, 75000000, 1, 75, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 78750000, 78750000, 1, 78, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
>> +    { 79500000, 79500000, 1, 79, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 83500000, 83500000, 2, 167, 2, 1, 1, 1, 0, 0, 6, 0, 0 },
>> +    { 83500000, 104375000, 1, 104, 2, 1, 1, 1, 1, 0, 5, 0, 0x600000 },
>> +    { 85500000, 85500000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 85750000, 85750000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
>> +    { 85800000, 85800000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0xCCCCCC },
>> +    { 88750000, 88750000, 1, 88, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
>> +    { 89910000, 89910000, 1, 89, 2, 1, 1, 3, 0, 3, 4, 0, 0xE8F5C1 },
>> +    { 90000000, 90000000, 1, 90, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 101000000, 101000000, 1, 101, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 102250000, 102250000, 1, 102, 2, 1, 1, 3, 0, 3, 4, 0, 0x3FFFFF },
>> +    { 106500000, 106500000, 1, 106, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 108000000, 108000000, 1, 90, 3, 0, 0, 5, 0, 2, 2, 0, 0 },
>> +    { 119000000, 119000000, 1, 119, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 131481000, 131481000, 1, 131, 2, 1, 1, 3, 0, 3, 4, 0, 0x7B22D1 },
>> +    { 135000000, 135000000, 1, 135, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 136750000, 136750000, 1, 136, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
>> +    { 147180000, 147180000, 1, 147, 2, 1, 1, 3, 0, 3, 4, 0, 0x2E147A },
>> +    { 148352000, 148352000, 1, 98, 1, 1, 1, 1, 2, 2, 2, 0, 0xE6AE6B },
>> +    { 148500000, 148500000, 1, 99, 1, 1, 1, 1, 2, 2, 2, 0, 0 },
>> +    { 154000000, 154000000, 1, 154, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 156000000, 156000000, 1, 156, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 157000000, 157000000, 1, 157, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 162000000, 162000000, 1, 162, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
>> +    { 174250000, 174250000, 1, 145, 3, 0, 0, 5, 0, 2, 2, 0, 0x355555 },
>> +    { 174500000, 174500000, 1, 174, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 174570000, 174570000, 1, 174, 2, 1, 1, 3, 0, 3, 4, 0, 0x91EB84 },
>> +    { 175500000, 175500000, 1, 175, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 185590000, 185590000, 1, 185, 2, 1, 1, 3, 0, 3, 4, 0, 0x970A3C },
>> +    { 187000000, 187000000, 1, 187, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> 
> add:
> { 235690000, 235690000, 1, 235, 2, 1, 1, 3, 0, 3, 4, 0, 0xB0A3D6},
> 
> This matches one of the framework 13 displays (fml13v01 board)
> 
> source: [1]
> 
> edid:
> 
> edid-decode (hex):
> 
> 00 ff ff ff ff ff ff 00 09 e5 5f 09 00 00 00 00
> 17 1d 01 03 80 1c 13 78 02 de 50 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 11 5c d0 18 81 e0 2d 50 30 20
> 36 00 1d be 10 00 00 1a a7 49 d0 18 81 e0 2d 50
> 30 20 36 00 1d be 10 00 00 1a 00 00 00 fe 00 42
> 4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 45 31 33 35 46 42 4d 2d 4e 34 31 0a 01 21
> 
> 02 03 19 c1 44 83 10 02 01 23 09 07 07 83 01 00
> 00 67 03 0c 00 10 00 00 44 11 5c d0 18 81 e0 2d
> 50 30 20 36 00 1d be 10 00 00 1a 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
> 
> ----------------
> 
> Block 0, Base EDID:
>    EDID Structure Version & Revision: 1.3
>    Vendor & Product Identification:
>      Manufacturer: BOE
>      Model: 2399
>      Made in: week 23 of 2019
>    Basic Display Parameters & Features:
>      Digital display
>      Maximum image size: 28 cm x 19 cm
>      Gamma: 2.20
>      Monochrome or grayscale display
>      First detailed timing is the preferred timing
>    Color Characteristics:
>      Red  : 0.6396, 0.3291
>      Green: 0.2998, 0.5996
>      Blue : 0.1494, 0.0595
>      White: 0.3125, 0.3281
>    Established Timings I & II: none
>    Standard Timings: none
>    Detailed Timing Descriptors:
>      DTD 1:  2256x1504   59.998513 Hz   3:2     92.938 kHz    235.690000 
> MHz (285 mm x 190 mm)
>                   Hfront   48 Hsync  32 Hback  200 Hpol P
>                   Vfront    3 Vsync   6 Vback   36 Vpol N
>      DTD 2:  2256x1504   47.998302 Hz   3:2     74.349 kHz    188.550000 
> MHz (285 mm x 190 mm)
>                   Hfront   48 Hsync  32 Hback  200 Hpol P
>                   Vfront    3 Vsync   6 Vback   36 Vpol N
>      Alphanumeric Data String: 'BOE CQ'
>      Alphanumeric Data String: 'NE135FBM-N41'
>    Extension blocks: 1
> Checksum: 0x21
> 
> ----------------
> 
> Block 1, CTA-861 Extension Block:
>    Revision: 3
>    Underscans IT Video Formats by default
>    Basic audio support
>    Native detailed modes: 1
>    Video Data Block:
>      VIC   3:   720x480    59.940060 Hz  16:9     31.469 kHz 27.000000 
> MHz (native)
>      VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz 148.500000 MHz
>      VIC   2:   720x480    59.940060 Hz   4:3     31.469 kHz 27.000000 MHz
>      VIC   1:   640x480    59.940476 Hz   4:3     31.469 kHz 25.175000 MHz
>    Audio Data Block:
>      Linear PCM:
>        Max channels: 2
>        Supported sample rates (kHz): 48 44.1 32
>        Supported sample sizes (bits): 24 20 16
>    Speaker Allocation Data Block:
>      FL/FR - Front Left/Right
>    Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
>      Source physical address: 1.0.0.0
>      Maximum TMDS clock: 340 MHz
>    Detailed Timing Descriptors:
>      DTD 3:  2256x1504   59.998513 Hz   3:2     92.938 kHz    235.690000 
> MHz (285 mm x 190 mm)
>                   Hfront   48 Hsync  32 Hback  200 Hpol P
>                   Vfront    3 Vsync   6 Vback   36 Vpol N
> Checksum: 0x01  Unused space in Extension Block: 84 bytes
> 
> 
>> +    { 241500000, 241500000, 1, 161, 1, 1, 1, 4, 0, 2, 2, 0, 0 },
>> +    { 241700000, 241700000, 1, 241, 2, 1, 1, 3, 0, 3, 4, 0, 0xB33332 },
>> +    { 262750000, 262750000, 1, 262, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
>> +    { 296500000, 296500000, 1, 296, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
>> +    { 296703000, 296703000, 1, 98, 0, 1, 1, 1, 0, 2, 2, 0, 0xE6AE6B },
>> +    { 297000000, 297000000, 1, 99, 0, 1, 1, 1, 0, 2, 2, 0, 0 },
>> +    { 594000000, 594000000, 1, 99, 0, 2, 0, 1, 0, 1, 1, 0, 0 },
>> +    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
>> +};
>> +
> 
> kind regards,
> Maud
> 
> [1]: https://github.com/DC-DeepComputing/fml13v01-linux/ 
> blob/97c64fe2832b6826914b6da7aa4febcdd4d3d444/drivers/gpu/drm/ 
> verisilicon/inno_hdmi.c#L112

