Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9E5C61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44C710E11F;
	Sat, 29 Aug 2026 19:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="nkuOAMzB";
	dkim-atps=neutral
X-Greylist: delayed 535 seconds by postgrey-1.36 at gabe;
 Sat, 29 Aug 2026 19:03:04 UTC
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AEA10E11F
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 19:03:04 +0000 (UTC)
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail3.ecloud.global (Postfix) with ESMTPSA id 9E0E9883DCA;
 Sat, 29 Aug 2026 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
 t=1788029646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehcjoluw1ltFHOACxESvJjxgUUGWa+g0poTQdMIRy1U=;
 b=nkuOAMzBmGj+QW/LFVmCluA3XLtxasCrezDA5Gp8iboVAS5YbdiSaS4tPc2rRzEKDjCYkc
 OSR5IyCbOTx5S9CuiWjcb9S2khgdusyJZQcyxiaFh2LVNDVnRNcG4AowmJimuO9OCmGUhM
 E8ltcGFsoumAKU8e9XDn5NFnMzowtmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail3; t=1788029646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehcjoluw1ltFHOACxESvJjxgUUGWa+g0poTQdMIRy1U=;
 b=SUQju1a5AyeEzsWtU11p1zJQg4cmekzyHbQn978fM7Z94OJlpQkUWJ1Kf5ziFCMASSAE+q
 g/465/MYThLZ7f2m9lYFLAPJJodxWKBQD4qtbleprFGCuTMdrW6whmVQqu6bSatvl+Om8B
 XOOSzbyrTeaRUnxvI88HOy9celngZRo=
ARC-Seal: i=1; s=mail3; d=murena.io; t=1788029646; a=rsa-sha256; cv=none;
 b=4u//Z/BtuPsOYlapubZ5m21WKQAJm/nJb66dH3KaNyha5i+ennk/ENAKtj8HINSK53tyn4
 5JPH3HWfg734eML0ysqPRxleYyjhd60c8M3yyDQ2xXlkyHVdWJdM/relDgP30qvuYkmy/5
 E+ouPdROr+TNqlt/XVODzbVbfkCftOc=
ARC-Authentication-Results: i=1; mail3.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
Message-ID: <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
Date: Sat, 29 Aug 2026 20:54:03 +0200
MIME-Version: 1.0
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
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Michal,

Small request for an eventual v3

> Add the HDMI PHY driver for the StarFive JH7110.
> 
> This driver binds to the starfive,jh7110-inno-hdmi-phy node and
> gets its regmap from the parent. It has no dependencies on voutcrg, only
> on its refoclk (xin24m), which breaks the probe-time circular
> dependency.
> 
> This driver provides two main functions:
>  - Clock Provider: It registers clk_ops to provide the variable pixel
>    clock (hdmi_pclk). The .set_rate operation configures the Pre-PLL
>    registers (0x1a0+) based on the requested rate.
> 
>  - PHY Provider: It registers phy_ops for the controller. The .power_on
>    op configures and enables the Post-PLL and other analog blocks (BIAS,
>    LDO, Serializer, etc.).
> 
> The JH7110 instantiates the same Innosilicon IP as the Rockchip RK3328,
> with the PHY register block shifted by 0x100 because it sits behind the
> HDMI controller in the shared register space. The pre-PLL programming
> therefore comes from the common Innosilicon helpers; this driver adds
> the JH7110 pixel clock table, the post-PLL and the analog configuration.
> 
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/phy/starfive/Kconfig                |  20 +
>  drivers/phy/starfive/Makefile               |   1 +
>  drivers/phy/starfive/phy-jh7110-inno-hdmi.c | 567 ++++++++++++++++++++++++++++
>  3 files changed, 588 insertions(+)
> 

[snip]

> +
> +static const struct inno_hdmi_phy_pre_pll_config pre_pll_cfg_table[] = {
> +	{ 25175000, 25175000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0xF55555 },
> +	{ 25200000, 25200000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0 },
> +	{ 27000000, 27000000, 1, 90, 3, 2, 2, 10, 3, 3, 4, 0, 0 },
> +	{ 27027000, 27027000, 1, 90, 3, 2, 2, 10, 3, 3, 4, 0, 0x170A3D },
> +	{ 28320000, 28320000, 1, 28, 2, 1, 1, 3, 0, 3, 4, 0, 0x51EB85 },
> +	{ 30240000, 30240000, 1, 30, 2, 1, 1, 3, 0, 3, 4, 0, 0x3D70A3 },
> +	{ 31500000, 31500000, 1, 31, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 33750000, 33750000, 1, 33, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
> +	{ 36000000, 36000000, 1, 36, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 40000000, 40000000, 1, 80, 2, 2, 2, 12, 2, 2, 2, 0, 0 },
> +	{ 46970000, 46970000, 1, 46, 2, 1, 1, 3, 0, 3, 4, 0, 0xF851EB },
> +	{ 49500000, 49500000, 1, 49, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 49000000, 49000000, 1, 49, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 50000000, 50000000, 1, 50, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 54000000, 54000000, 1, 54, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 54054000, 54054000, 1, 54, 2, 1, 1, 3, 0, 3, 4, 0, 0x0DD2F1 },
> +	{ 57284000, 57284000, 1, 57, 2, 1, 1, 3, 0, 3, 4, 0, 0x48B439 },
> +	{ 58230000, 58230000, 1, 58, 2, 1, 1, 3, 0, 3, 4, 0, 0x3AE147 },
> +	{ 59341000, 59341000, 1, 59, 2, 1, 1, 3, 0, 3, 4, 0, 0x574BC6 },
> +	{ 59400000, 59400000, 1, 99, 3, 1, 1, 1, 3, 3, 4, 0, 0 },
> +	{ 65000000, 65000000, 1, 130, 2, 2, 2, 12, 0, 2, 2, 0, 0 },
> +	{ 68250000, 68250000, 1, 68, 2, 1, 1, 3, 0, 3, 4, 0, 0x3FFFFF },
> +	{ 71000000, 71000000, 1, 71, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 74176000, 74176000, 1, 98, 1, 2, 2, 1, 2, 3, 4, 0, 0xE6AE6B },
> +	{ 74250000, 74250000, 1, 99, 1, 2, 2, 1, 2, 3, 4, 0, 0 },
> +	{ 75000000, 75000000, 1, 75, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 78750000, 78750000, 1, 78, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
> +	{ 79500000, 79500000, 1, 79, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 83500000, 83500000, 2, 167, 2, 1, 1, 1, 0, 0, 6, 0, 0 },
> +	{ 83500000, 104375000, 1, 104, 2, 1, 1, 1, 1, 0, 5, 0, 0x600000 },
> +	{ 85500000, 85500000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 85750000, 85750000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
> +	{ 85800000, 85800000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0xCCCCCC },
> +	{ 88750000, 88750000, 1, 88, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
> +	{ 89910000, 89910000, 1, 89, 2, 1, 1, 3, 0, 3, 4, 0, 0xE8F5C1 },
> +	{ 90000000, 90000000, 1, 90, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 101000000, 101000000, 1, 101, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 102250000, 102250000, 1, 102, 2, 1, 1, 3, 0, 3, 4, 0, 0x3FFFFF },
> +	{ 106500000, 106500000, 1, 106, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 108000000, 108000000, 1, 90, 3, 0, 0, 5, 0, 2, 2, 0, 0 },
> +	{ 119000000, 119000000, 1, 119, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 131481000, 131481000, 1, 131, 2, 1, 1, 3, 0, 3, 4, 0, 0x7B22D1 },
> +	{ 135000000, 135000000, 1, 135, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 136750000, 136750000, 1, 136, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
> +	{ 147180000, 147180000, 1, 147, 2, 1, 1, 3, 0, 3, 4, 0, 0x2E147A },
> +	{ 148352000, 148352000, 1, 98, 1, 1, 1, 1, 2, 2, 2, 0, 0xE6AE6B },
> +	{ 148500000, 148500000, 1, 99, 1, 1, 1, 1, 2, 2, 2, 0, 0 },
> +	{ 154000000, 154000000, 1, 154, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 156000000, 156000000, 1, 156, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 157000000, 157000000, 1, 157, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 162000000, 162000000, 1, 162, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
> +	{ 174250000, 174250000, 1, 145, 3, 0, 0, 5, 0, 2, 2, 0, 0x355555 },
> +	{ 174500000, 174500000, 1, 174, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 174570000, 174570000, 1, 174, 2, 1, 1, 3, 0, 3, 4, 0, 0x91EB84 },
> +	{ 175500000, 175500000, 1, 175, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 185590000, 185590000, 1, 185, 2, 1, 1, 3, 0, 3, 4, 0, 0x970A3C },
> +	{ 187000000, 187000000, 1, 187, 2, 1, 1, 3, 0, 3, 4, 0, 0 },

add:
{ 235690000, 235690000, 1, 235, 2, 1, 1, 3, 0, 3, 4, 0, 0xB0A3D6},

This matches one of the framework 13 displays (fml13v01 board)

source: [1]

edid:

edid-decode (hex):

00 ff ff ff ff ff ff 00 09 e5 5f 09 00 00 00 00
17 1d 01 03 80 1c 13 78 02 de 50 a3 54 4c 99 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 11 5c d0 18 81 e0 2d 50 30 20
36 00 1d be 10 00 00 1a a7 49 d0 18 81 e0 2d 50
30 20 36 00 1d be 10 00 00 1a 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 45 31 33 35 46 42 4d 2d 4e 34 31 0a 01 21

02 03 19 c1 44 83 10 02 01 23 09 07 07 83 01 00
00 67 03 0c 00 10 00 00 44 11 5c d0 18 81 e0 2d
50 30 20 36 00 1d be 10 00 00 1a 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01

----------------

Block 0, Base EDID:
   EDID Structure Version & Revision: 1.3
   Vendor & Product Identification:
     Manufacturer: BOE
     Model: 2399
     Made in: week 23 of 2019
   Basic Display Parameters & Features:
     Digital display
     Maximum image size: 28 cm x 19 cm
     Gamma: 2.20
     Monochrome or grayscale display
     First detailed timing is the preferred timing
   Color Characteristics:
     Red  : 0.6396, 0.3291
     Green: 0.2998, 0.5996
     Blue : 0.1494, 0.0595
     White: 0.3125, 0.3281
   Established Timings I & II: none
   Standard Timings: none
   Detailed Timing Descriptors:
     DTD 1:  2256x1504   59.998513 Hz   3:2     92.938 kHz    235.690000 
MHz (285 mm x 190 mm)
                  Hfront   48 Hsync  32 Hback  200 Hpol P
                  Vfront    3 Vsync   6 Vback   36 Vpol N
     DTD 2:  2256x1504   47.998302 Hz   3:2     74.349 kHz    188.550000 
MHz (285 mm x 190 mm)
                  Hfront   48 Hsync  32 Hback  200 Hpol P
                  Vfront    3 Vsync   6 Vback   36 Vpol N
     Alphanumeric Data String: 'BOE CQ'
     Alphanumeric Data String: 'NE135FBM-N41'
   Extension blocks: 1
Checksum: 0x21

----------------

Block 1, CTA-861 Extension Block:
   Revision: 3
   Underscans IT Video Formats by default
   Basic audio support
   Native detailed modes: 1
   Video Data Block:
     VIC   3:   720x480    59.940060 Hz  16:9     31.469 kHz 
27.000000 MHz (native)
     VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz 
148.500000 MHz
     VIC   2:   720x480    59.940060 Hz   4:3     31.469 kHz 
27.000000 MHz
     VIC   1:   640x480    59.940476 Hz   4:3     31.469 kHz 
25.175000 MHz
   Audio Data Block:
     Linear PCM:
       Max channels: 2
       Supported sample rates (kHz): 48 44.1 32
       Supported sample sizes (bits): 24 20 16
   Speaker Allocation Data Block:
     FL/FR - Front Left/Right
   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
     Source physical address: 1.0.0.0
     Maximum TMDS clock: 340 MHz
   Detailed Timing Descriptors:
     DTD 3:  2256x1504   59.998513 Hz   3:2     92.938 kHz    235.690000 
MHz (285 mm x 190 mm)
                  Hfront   48 Hsync  32 Hback  200 Hpol P
                  Vfront    3 Vsync   6 Vback   36 Vpol N
Checksum: 0x01  Unused space in Extension Block: 84 bytes


> +	{ 241500000, 241500000, 1, 161, 1, 1, 1, 4, 0, 2, 2, 0, 0 },
> +	{ 241700000, 241700000, 1, 241, 2, 1, 1, 3, 0, 3, 4, 0, 0xB33332 },
> +	{ 262750000, 262750000, 1, 262, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
> +	{ 296500000, 296500000, 1, 296, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
> +	{ 296703000, 296703000, 1, 98, 0, 1, 1, 1, 0, 2, 2, 0, 0xE6AE6B },
> +	{ 297000000, 297000000, 1, 99, 0, 1, 1, 1, 0, 2, 2, 0, 0 },
> +	{ 594000000, 594000000, 1, 99, 0, 2, 0, 1, 0, 1, 1, 0, 0 },
> +	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> +};
> +

kind regards,
Maud

[1]: 
https://github.com/DC-DeepComputing/fml13v01-linux/blob/97c64fe2832b6826914b6da7aa4febcdd4d3d444/drivers/gpu/drm/verisilicon/inno_hdmi.c#L112
