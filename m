Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78ABC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 20:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EDA10E0F7;
	Fri, 25 Sep 2026 20:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="kjgvy4zl";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A371F10E0F7
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 20:09:16 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925200914euoutp02190211168e9262f27661be7eb6326ac0~YqUJW3dDY2877128771euoutp02d;
 Fri, 25 Sep 2026 20:09:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260925200914euoutp02190211168e9262f27661be7eb6326ac0~YqUJW3dDY2877128771euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790366954;
 bh=R72S8DmRi/X/3ay93ymVYKLFPysF0+EoCRlZHiXClqQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=kjgvy4zlvFmyqpQHEzHq/zWMUA3FgQkqE75j4+LomdrHrNmkJpvcM3ydDGtKc4VXp
 fWZsWjxcsrdkzuWcJLhS1ty46ziDUjRf9WEicSKvI1tcUCxzIfuP5EWFNFERIqLDX4
 zaHyNsRYRimaSmp2xvCGlZcGHHhLniYdd49lPjJI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260925200913eucas1p198ff3fecf4c9d327b4b2d573f4509285~YqUIQc1cW1226912269eucas1p1i;
 Fri, 25 Sep 2026 20:09:13 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260925200911eusmtip12932e01dfb1872e66825c5d6349ffed6~YqUGgNfWN0501005010eusmtip1G;
 Fri, 25 Sep 2026 20:09:11 +0000 (GMT)
Message-ID: <0c29c063-0b09-4710-8bf8-1d9adee4eb53@samsung.com>
Date: Fri, 25 Sep 2026 22:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/20] drm: starfive: jh7110: Enable display subsystem
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Byron Stanoszek
 <gandalf@winds.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Emil
 Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Chaoyi
 Chen <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <cdb63b93c4a8857ac61b17902369086e9a278dd3.camel@iscas.ac.cn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260925200913eucas1p198ff3fecf4c9d327b4b2d573f4509285
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61
X-EPHeader: CA
X-CMS-RootMailID: 20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61
References: <CGME20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <b8b046ee-c574-3e16-6079-2fc415633dae@winds.org>
 <cdb63b93c4a8857ac61b17902369086e9a278dd3.camel@iscas.ac.cn>
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

Hi Bryan and Icenowy,

On 9/20/26 09:35, Icenowy Zheng wrote:
> 在 2026-09-20日的 02:09 -0400，Byron Stanoszek写道：
>> On Tue, 15 Sep 2026, Michal Wilczynski wrote:
>>
>>> This series enables the display subsystem on the StarFive JH7110.
>>
>> Hi Michal,
>>
>> I tested your v4 patch series on my VisionFive2 1.3B with kernel 7.3-
>> rc3 today
>> and it works very well, except for 2 issues. Note, to make the screen
>> refresh
>> properly, I am using the noncoherent cache fixes from
>> https://protect2.fireeye.com/v1/url?k=3d78ed45-62e3d45a-3d79660a-000babdfecba-dbc6e750c3338bb9&q=1&e=d9589fcd-304c-4065-91c9-c5043969df15&u=https%3A%2F%2Fgithub.com%2Fganboing-jh7110%2Flinux%2Fcommits%2Fganboing-jh7110-cache-fix-v1%2F
>> (specifically commits 3683d97, ef93e2c, 277db0b, and 26ce3e6) in
>> addition to
>> your patch.
>>
>> Issue 1: I have a Dell U2711 monitor which has limited HDMI 1.3
>> capability, so
>> I invented my own Xorg mode to get a good frame rate:
>>
>> "2560x1440_40.22"  162.00  2560 2608 2640 2720  1440 1443 1448 1481
>> +hsync -vsync
>>
>> With this mode and your new driver, I started getting rows of black
>> pixels
>> flickering in the upper-left corner of my LCD screen. These weren't
>> there back
>> when I was running the same mode under the Keith Zhao driver from
>> StarFive
>> (drm/verisilicon v5 plus a bunch of patches for dma cache coherency)
>> (
>> https://patchwork.kernel.org/project/dri-devel/cover/20241120061848.196754-1-keith.zhao@starfivetech.com
>> /).
>>
>> The glitches I saw suggested the sync polarity was being set
>> incorrectly; the
>> number of glitched rows was exactly the vsync pulse width plus 1
>> (i.e.
>> "1440 1443 1448 1481" produced 6 bad rows, "1440 1443 1456 1481"
>> produced 14,
>> "1440 1441 1442 1481" produced 2, and so forth).
>>
>> I did a register dump between the two drivers and found that,
>> although the
>> DC8200 HSYNC and VSYNC registers were identical between the two
>> versions, the
>> hsync and vsync bits on the inno hdmi tx were swapped between the
>> two. When I
>> manually set the VIDEO_TIMING_CTL register from 0x09 to 0x05
>> (matching the
>> output of Keith's driver), the glitches went away.
>>
>> Keith Zhao driver:
>>
>> === DC8200 display 0 ===
>> DC   PANEL_CONFIG               0x1418 = 0x00001111
>> DC   HSIZE                      0x1430 = 0x0AA00A00
>> DC   HSYNC                      0x1438 = 0x45280A30
>> DC   VSIZE                      0x1440 = 0x05C905A0
>> DC   VSYNC                      0x1448 = 0xC2D405A3
>> DC   DPI_CONFIG                 0x14B8 = 0x00000005
>> DC   FB_CONFIG                  0x1518 = 0x14000000
>> DC   FB_ADDRESS                 0x1400 = 0x71200000
>> DC   FB_STRIDE                  0x1408 = 0x00002800
>> DC   FB_SIZE                    0x1810 = 0x02D00A00
>> DC   FB_CONFIG_EX               0x1CC0 = 0x00002000
>> DC   PANEL_START                0x1CCC = 0x00000001
>> DC   DP_CONFIG                  0x1CD0 = 0x0000000A
>> DC   FB_WATER_MARK              0x1CE8 = 0x00000000
>> DC   PANEL_CONFIG_EX            0x2518 = 0x00000000
>>
>> === INNO HDMI TX video timing ===
>> HDMI VIDEO_TIMING_CTL           0x08   = 0x05
>> HDMI EXT_HTOTAL_L               0x09   = 0xA0
>> HDMI EXT_HTOTAL_H               0x0A   = 0x0A
>> HDMI EXT_HBLANK_L               0x0B   = 0xA0
>> HDMI EXT_HBLANK_H               0x0C   = 0x00
>> HDMI EXT_HDELAY_L               0x0D   = 0x70
>> HDMI EXT_HDELAY_H               0x0E   = 0x00
>> HDMI EXT_HDURATION_L            0x0F   = 0x20
>> HDMI EXT_HDURATION_H            0x10   = 0x00
>> HDMI EXT_VTOTAL_L               0x11   = 0xC9
>> HDMI EXT_VTOTAL_H               0x12   = 0x05
>> HDMI EXT_VBLANK                 0x13   = 0x29
>> HDMI EXT_VDELAY                 0x14   = 0x26
>> HDMI EXT_VDURATION              0x15   = 0x05
>>
>> Your driver (showing only the changed values):
>>
>> DC   DP_CONFIG                  0x1CD0 = 0x00000000
>> DC   PANEL_CONFIG_EX            0x2518 = 0x00000001
>> HDMI VIDEO_TIMING_CTL           0x08   = 0x09
>>
>> Specifically the bit#s are different between the two drivers:
>>
>> inno_hdmi-starfive.h (Keith Zhao):     inno-hdmi.c (generic):
>>    v_HSYNC_POLARITY_SF(n)  ((n) << 2)     v_HSYNC_POLARITY  bit 3
>>    v_VSYNC_POLARITY_SF(n)  ((n) << 3)     v_VSYNC_POLARITY  bit 2
>>
>> "_SF" suggests this change is specific to StarFive. The correct
>> positions are
>> HSYNC=bit 2 and VSYNC=bit 3 for the JH7110.
> 
> In fact it's not SF specific, [1] pg.13 (full manual page 979) also
> shows the same for RK.
> 
> It could be an error from Rockchip developers since the beginning.

Yeah I agree; Maud Spierings reported similar issue and Dominuque
Belhachemi also figured that v_HSYNC_POLARITY and v_VSYNC_POLARITY are
simply swapped in
inno-hdmi.c.

As Icenowy stated Rockhip TRM also confirms this. I intend to send a fix
as part of this series (as suggested by Maud).

> 
> [1]
> https://protect2.fireeye.com/v1/url?k=ba283351-e5b30a4e-ba29b81e-000babdfecba-1b86e6ec0e74b45d&q=1&e=d9589fcd-304c-4065-91c9-c5043969df15&u=https%3A%2F%2Fgithub.com%2FDeciHD%2Frockchip_docs%2Fblob%2Fmain%2Frk3128%2FTRM-chapter-24-hdmi-tx.pdf
> 
> Thanks,
> Icenowy
> 
>>
>> I'm guessing that your 42-mode test passed because most CEA modes are
>> +hsync
>> +vsync, and this wouldn't show any difference if the two bits were
>> transposed.
>>
>> Once the sync polarity is sorted, I'd be happy to give a Tested-by:
>> on the
>> series.
>>
>>   --
>>
>> Issue 2: This is more a feature request than an issue. Originally, I
>> tried
>> running this Xorg modeline, which worked well under Keith's driver:
>>
>> "2560x1440_49.90"  201.00  2560 2608 2640 2720  1440 1443 1448 1481
>> +hsync -vsync
>>
>> However, your driver would not accept this pixel clock. I then
>> noticed you have
>> a pre-PLL table of fixed clocks. Is there any chance you can change
>> the code to
>> compute the pre-PLL on the fly like how Keith does it, rather than
>> use a table?

I can add the entry, hopefully you can let me know in the v5 whether it
works for you.

inno_hdmi_phy_pre_pll_determine_rate() returns -EINVAL for any rate not
in the table, and .mode_valid is built entirely on that:

rounded = clk_round_rate(ctrl->clks[CLK_PCLK].clk, pixelclk);
if (rounded != pixelclk)
      return MODE_NOCLOCK;

If the PHY computes dividers on demand, clk_round_rate() starts
succeeding for almost every rate .mode_valid stops rejecting anything
and we're back to advertising modes the PHY can't drive  the
blank screen bug patch 11 exists to fix.

To keep the rejection you'd have to replace the table with a real
constraint model.

The fracdiv values doesn't seem to be cleanly derivable and the Rockchip
has the datasheet and still chose a table. 


>>
>> Thanks for all your great work!
>>
>> Best regards,
>>   -Byron
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> https://protect2.fireeye.com/v1/url?k=46fbedc2-1960d4dd-46fa668d-000babdfecba-e6e7fb64f005c1b3&q=1&e=d9589fcd-304c-4065-91c9-c5043969df15&u=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-riscv

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
