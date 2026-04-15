Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C149F8A144
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9A310E842;
	Thu, 16 Apr 2026 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="LJwULHM9";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 663AB10E776
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:35:05 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8d560ede296so868487485a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776296104; cv=none;
 d=google.com; s=arc-20240605;
 b=efeoYllINpUT/rUHB5DYLxcsVv3cpzjiT1aS6VkaL5e8sNSLchEik13TcnJt4JGbGb
 r7GuBupehLTjtDhWMjJaQM7iWgFBBTpsFth/krDqccwesHgynS6Wv+e9kbpjxT1Ju9Ko
 LPFOIqOnl3tpK4x222LPHtA590LZTG0M+othhiwxEn4EoMkv7uVarUa8S35DmXeCVdUu
 XD6bP5QbkrPJicIWwcVFedRIBGKgBnCJVo3GcL0ORHbt37vM/aqtG+FhFH/EnSZx3SU9
 JPH4nTeLBi2M3KRwZ347oCJkITsaZzbDxgya/IyP9Hw6EInDbepy72FjxXwMa/9QSXml
 W07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MkZdmz5ZlEhseQt41KLWBN8TOovPwRLOZ1qkVFMEmMo=;
 fh=YgyS+B/R9PIPZRLyrnrNfAYJwsiaWbtCvWQHt0NT3kY=;
 b=ArjU6CeKZMBCnszAi8I6yfR530OL8BADIaVSGV2aBFflYniF/VEcTmCho8/J6dTbAt
 mIx5BuYpEVXrFclSOUwtnv7vTBhY81YShq1v/19D2MCyAih/Ncx1hPX/k4gxp3rBIUPV
 jJegHhwg/7FIEnkhuHsOPcaykqnJa+7cVVzJHfnnWprToYV6OiJ8TnlWi6wfsUGwPV/j
 4gK9lQEMkaOPTlKSDCv8u0ZimnUjg6YHb9rOs34eF5NLNn9yPUQPJX199/2GHkrCQYbu
 XlBFKCfx4JoheRqjeVaoraWiQT5Hu3yaMyK4U2XISJ+918DPvsNVVeInYo59mE+tss7h
 b/5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1776296104; x=1776900904; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkZdmz5ZlEhseQt41KLWBN8TOovPwRLOZ1qkVFMEmMo=;
 b=LJwULHM9ynO0ofqVNQOe09yGDt16yz+91RcRyLvoG2GFuFXZi7K6ABJFNLI5g6pE/k
 VWkzNm5e6DKoXc4XSqu7oNeWldOxL0+wcrfjs4wSZUO1gAbiDbY/qVdeYfpFuIvxUOxQ
 7zrQbnQjClXOinSbJHLqJdPn2uI7taxgey7n5FQzEmhwlNpefRY8noDOb6vie1X6AflD
 QwJTOrHIGedKSE7fKadM/ta616+nFHsTQgbqDdoZX9VCjxpZZhwlvF+iJzoF3vhNoaZd
 ZLlPpmU5tSgbwG14wjBqaSVkjw1DXb8brmO6vFEnpWtof3ZS3QApcda+2f1GadZ0lPnn
 E3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776296104; x=1776900904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MkZdmz5ZlEhseQt41KLWBN8TOovPwRLOZ1qkVFMEmMo=;
 b=nI4XjJQ52KCKqc0AygebCmymrZtS5yA3cg4hGQi8uf8CtTKPgxqXlGzLCAKOFAJAC6
 AYA93Ds+vxnhrTDAjjtZwol4k43cA47LH00b6LzAfWvyZCLtN4d+xi7M0Lmi48Ucoz03
 zw3042blTJOAd0TuvLxLZNQaHKlHQvFXVHevDD2wHewkoe+kqImYPSdEFTFdnyy9JxsK
 RKGklEbM1VRX6BMt7kQeP4gAvdu2fJ4RARcoNFpjVzYd7+43Ka+rzLhtjJH0oMBbE5mM
 5bHThFUkCslwu42poVe4Pwj2J7t3U+4mXF+oWy7umeG4QuRUk6O/9lnqTtbBY2eLjAS5
 g+3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9Ut5S/HapNbthUqYfjZ+GW15P+vN4fTN+/Elhtx6+ht7VmUdB2MHy65zjmUDlWUoYkw5269j5WYk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqSKOh+XBgoVSHuLMZUD3IzpB3kf57HpRwW7MKr314ZPpKDUu5
 KQe/G5HSatJxjq5o2e6mN4EuafpiuJF5Ttw+Y5t96RdgvooQzko04DevWvSXvmSvb4a8NNBkFYi
 8tU1VSn5A6aU0c2ml/GNv+IcKauD8q11rDHgvuLg0tQ==
X-Gm-Gg: AeBDietzSeFtOf+wVdoLh0UkN7ysrrhIaK/xrCc4/31D5c7xGYUqTIQOMUQXXCht+z/
 qn/I/BG8NMaF+iBmQyystn2HLiHZqqdtzxdFMenkw69xgmC5Rbi6E8PnrjXWde6k1dj+NzZtlvl
 XzdkWM9oyhCZVRM9VdUDPDHMv+AfYhqAUu3ye33CO0TXCtB0gFCSoO4zOzBpK9yPWeOvjWzsSq0
 bBiy3oMKWmGY9wApgQz5zQAG1mQBsw5hFDmiaP+zrTL8Az1DVzUwF3bRewuukuUsdlR4UxP9gmK
 Zvlpgk2PU39j7dvZl58W0HKfTuVSPdJyY5XwZFtgqOSvER35CUzMxTQl/mCA2RPlYZEuCBIFwhc
 zVph2
X-Received: by 2002:a05:620a:2953:b0:8c6:ae78:f750 with SMTP id
 af79cd13be357-8ddcd5ffc39mr3310148285a.14.1776296104123; Wed, 15 Apr 2026
 16:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260414214104.1363987-1-dennis@ausil.us>
 <20260414214104.1363987-7-dennis@ausil.us>
 <CABjd4YxfeCfRUneZfFx31WmQOexO0gcH8yHPQmRY38GKNk=Ztg@mail.gmail.com>
In-Reply-To: <CABjd4YxfeCfRUneZfFx31WmQOexO0gcH8yHPQmRY38GKNk=Ztg@mail.gmail.com>
From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 15 Apr 2026 18:34:49 -0500
X-Gm-Features: AQROBzC4-qs-82YEAPMV9IhAdlFDvkQoD_ROH-jwp19mN9zmg-DXf3GNdyTSWBM
Message-ID: <CAABkxwvKT8p3akUjTpmNh44ZQyuc6Tz-tULm_4bHv6+Q4pQ1Bw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] arm64: dts: rockchip: Add Orange Pi 5 Pro board
 support
To: Alexey Charkov <alchark@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, FUKAUMI Naoki <naoki@radxa.com>, 
 Heiko Stuebner <heiko@sntech.de>, Hsun Lai <i@chainsx.cn>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jimmy Hon <honyuenkwun@gmail.com>, 
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Michael Riesch <michael.riesch@collabora.com>,
 Mykola Kvach <xakep.amatop@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Robert Foss <rfoss@kernel.org>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

Hi Alexey,

On Wed, Apr 15, 2026 at 3:57=E2=80=AFAM Alexey Charkov <alchark@gmail.com> =
wrote:
>
> On Wed, Apr 15, 2026 at 1:41=E2=80=AFAM Dennis Gilmore <dennis@ausil.us> =
wrote:
> >
> > Add device tree for the Xunlong Orange Pi 5 Pro (RK3588S).
> >
> > - eMMC module, you can optionally solder a SPI NOR in place and turn
> >  off the eMMC
> > - PCIe-attached NIC (pcie2x1l1)
> > - PCIe NVMe slot (pcie2x1l2)
>
> Hi Dennis,
>
> Sashiko noticed [1] that the controller names here do not match the
> nodes/comments you have in the patch body - which ones are correct?
>
> [1] https://sashiko.dev/#/patchset/20260414214104.1363987-1-dennis%40ausi=
l.us

The ones in the body are correct. will fix

> > - AP6256 WiFi (BCM43456) via SDIO with mmc-pwrseq
> > - BCM4345C5 Bluetooth
> > - es8388 audio
> > - USB 2.0 and USB 3.0
> > - Two HDMI ports, the second is connected to the SoC's DP controller
> >   driven through a Lontium LT8711UXD bridge.
> >
> > Vendors schematics are available at:
> > https://drive.google.com/file/d/1qs1DratHuh7C6J6MEtQIwUsiSrg8qgTi/view
> >
> > Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 442 ++++++++++++++++++
> >  2 files changed, 443 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro=
.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 4d384f153c13..c99dca2ae9e7 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -214,6 +214,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-nanopi-r6c=
.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-odroid-m2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-orangepi-5.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-orangepi-5b.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-orangepi-5-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-orangepi-cm5-base.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-radxa-cm5-io.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-roc-pc.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts b/=
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
> > new file mode 100644
> > index 000000000000..61462c66753d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
> > @@ -0,0 +1,442 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "rk3588s-orangepi-5.dtsi"
> > +
> > +/ {
> > +       model =3D "Xunlong Orange Pi 5 Pro";
> > +       compatible =3D "xunlong,orangepi-5-pro", "rockchip,rk3588s";
> > +
> > +       aliases {
> > +               mmc0 =3D &sdhci;
> > +               mmc1 =3D &sdmmc;
> > +               mmc2 =3D &sdio;
> > +       };
> > +
> > +       hdmi1-con {
> > +               compatible =3D "hdmi-connector";
> > +               label =3D "HDMI1 OUT";
> > +               type =3D "a";
> > +
> > +               port {
> > +                       hdmi1_con_in: endpoint {
> > +                               remote-endpoint =3D <&lt8711uxd_out>;
> > +                       };
> > +               };
> > +       };
> > +
> > +       lt8711uxd {
>
> Please use a generic node name per DT convention. "hdmi-bridge" perhaps?
>

Will adopt hdmi-bridge

> > +               compatible =3D "lontium,lt8711uxd";
>
> Don't you want to add "vdd-supply =3D <&vcc3v3_dp>;" here? It costs you
> nothing, as it's already in the binding and in the driver, and having
> this dependency listed explicitly will let the kernel order the driver
> probes correctly, and also likely let you drop the boot-on/always-on
> annotation from the regulator node.

I will add the supply and test drop the boot-on/always-on

> > +               ports {
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <0>;
> > +
> > +                       port@0 {
> > +                               reg =3D <0>;
> > +
> > +                               lt8711uxd_in: endpoint {
> > +                                       remote-endpoint =3D <&dp0_out_c=
on>;
> > +                               };
> > +                       };
> > +
> > +                       port@1 {
> > +                               reg =3D <1>;
> > +
> > +                               lt8711uxd_out: endpoint {
> > +                                       remote-endpoint =3D <&hdmi1_con=
_in>;
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +
> > +       analog-sound {
> > +               compatible =3D "simple-audio-card";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&hp_detect>;
> > +               simple-audio-card,format =3D "i2s";
> > +               simple-audio-card,hp-det-gpios =3D <&gpio1 RK_PD5 GPIO_=
ACTIVE_HIGH>;
> > +               simple-audio-card,mclk-fs =3D <256>;
> > +               simple-audio-card,name =3D "rockchip,es8388";
> > +               simple-audio-card,routing =3D
> > +                       "Headphones", "LOUT1",
> > +                       "Headphones", "ROUT1",
> > +                       "LINPUT1", "Microphone Jack",
> > +                       "RINPUT1", "Microphone Jack",
> > +                       "LINPUT2", "Onboard Microphone",
> > +                       "RINPUT2", "Onboard Microphone";
> > +               simple-audio-card,widgets =3D
> > +                       "Microphone", "Microphone Jack",
> > +                       "Microphone", "Onboard Microphone",
> > +                       "Headphone", "Headphones";
> > +
> > +               simple-audio-card,cpu {
> > +                       sound-dai =3D <&i2s2_2ch>;
> > +               };
> > +
> > +               simple-audio-card,codec {
> > +                       sound-dai =3D <&es8388>;
> > +                       system-clock-frequency =3D <12288000>;
> > +               };
> > +       };
> > +
> > +       pwm-leds {
> > +               compatible =3D "pwm-leds";
> > +
> > +               led-0 {
> > +                       color =3D <LED_COLOR_ID_BLUE>;
> > +                       function =3D LED_FUNCTION_STATUS;
> > +                       linux,default-trigger =3D "heartbeat";
> > +                       max-brightness =3D <255>;
> > +                       pwms =3D <&pwm15 0 1000000 0>;
> > +               };
> > +
> > +               led-1 {
> > +                       color =3D <LED_COLOR_ID_GREEN>;
> > +                       function =3D LED_FUNCTION_ACTIVITY;
> > +                       linux,default-trigger =3D "heartbeat";
> > +                       max-brightness =3D <255>;
> > +                       pwms =3D <&pwm3 0 1000000 0>;
> > +               };
> > +       };
> > +
> > +       fan: pwm-fan {
> > +               compatible =3D "pwm-fan";
> > +               #cooling-cells =3D <2>;
> > +               cooling-levels =3D <0 50 100 150 200 255>;
> > +               fan-supply =3D <&vcc5v0_sys>;
> > +               pwms =3D <&pwm2 0 20000000 0>;
> > +       };
> > +
> > +       vcc3v3_dp: regulator-vcc3v3-dp {
> > +               compatible =3D "regulator-fixed";
> > +               enable-active-high;
> > +               gpios =3D <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&dp_bridge_en>;
> > +               regulator-max-microvolt =3D <3300000>;
> > +               regulator-min-microvolt =3D <3300000>;
> > +               regulator-name =3D "vcc3v3_dp";
> > +               regulator-always-on;
> > +               regulator-boot-on;
>
> Please see if you can drop these always-on/boot-on when vdd-supply is
> explicitly listed in the bridge node
>
I have tested removing these with the supply change listed, the HDMI
bridge fails to power on, it does work okay with regulator-always-on
only. It seems necessary to ensure that the bridge is active and that
HPD works. I am open to trying something else to ensure it all works

> > +               vin-supply =3D <&vcc_3v3_s3>;
> > +       };
> > +
> > +       vcc3v3_phy1: regulator-vcc3v3-phy1 {
> > +               compatible =3D "regulator-fixed";
> > +               enable-active-high;
> > +               gpios =3D <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&vcc3v3_phy1_en>;
>
> The board schematics call the pin "Ethernet_EN"

Will rename this

> > +               regulator-max-microvolt =3D <3300000>;
> > +               regulator-min-microvolt =3D <3300000>;
> > +               regulator-name =3D "vcc3v3_phy1";
> > +               startup-delay-us =3D <50000>;
> > +               vin-supply =3D <&vcc_3v3_s3>;
> > +       };
> > +
> > +       vcc5v0_otg: regulator-vcc5v0-otg {
> > +               compatible =3D "regulator-fixed";
> > +               enable-active-high;
> > +               gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&vcc5v0_otg_en>;
> > +               regulator-max-microvolt =3D <5000000>;
> > +               regulator-min-microvolt =3D <5000000>;
> > +               regulator-name =3D "vcc5v0_otg";
> > +               vin-supply =3D <&vcc5v0_sys>;
> > +       };
> > +
> > +       sdio_pwrseq: sdio-pwrseq {
> > +               compatible =3D "mmc-pwrseq-simple";
> > +               clocks =3D <&hym8563>;
> > +               clock-names =3D "ext_clock";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&wifi_enable_h>;
> > +               post-power-on-delay-ms =3D <200>;
> > +               reset-gpios =3D <&gpio0 RK_PD0 GPIO_ACTIVE_LOW>;
> > +       };
> > +
> > +       typea_con: usb-a-connector {
> > +               compatible =3D "usb-a-connector";
> > +               data-role =3D "host";
> > +               label =3D "USB3 Type-A";
> > +               power-role =3D "source";
> > +               vbus-supply =3D <&vcc5v0_otg>;
> > +       };
> > +};
> > +
> > +&dp0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&dp0m0_pins>;
> > +       status =3D "okay";
> > +};
> > +
> > +&dp0_in {
> > +       dp0_in_vp1: endpoint {
> > +               remote-endpoint =3D <&vp1_out_dp0>;
> > +       };
> > +};
> > +
> > +&dp0_out {
> > +       dp0_out_con: endpoint {
> > +               remote-endpoint =3D <&lt8711uxd_in>;
> > +       };
> > +};
> > +
> > +&i2c1 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&i2c1m4_xfer>;
> > +       status =3D "okay";
> > +};
> > +
> > +&i2c3 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&i2c3m0_xfer>;
> > +       status =3D "okay";
> > +
> > +       es8388: audio-codec@11 {
> > +               compatible =3D "everest,es8388", "everest,es8328";
> > +               reg =3D <0x11>;
> > +               #sound-dai-cells =3D <0>;
> > +               AVDD-supply =3D <&vcca_3v3_s0>;
> > +               DVDD-supply =3D <&vcca_1v8_s0>;
> > +               HPVDD-supply =3D <&vcca_3v3_s0>;
> > +               PVDD-supply =3D <&vcca_1v8_s0>;
> > +               assigned-clock-rates =3D <12288000>;
> > +               assigned-clocks =3D <&cru I2S2_2CH_MCLKOUT>;
> > +               clocks =3D <&cru I2S2_2CH_MCLKOUT>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&i2s2m1_mclk>;
> > +       };
> > +};
> > +
> > +&i2c4 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&i2c4m3_xfer>;
> > +       status =3D "okay";
> > +};
> > +
> > +&i2s2_2ch {
> > +       pinctrl-0 =3D <&i2s2m1_lrck &i2s2m1_sclk
> > +                    &i2s2m1_sdi &i2s2m1_sdo>;
> > +       status =3D "okay";
> > +};
> > +
> > +&package_thermal {
> > +       polling-delay =3D <1000>;
> > +
> > +       cooling-maps {
> > +               map0 {
> > +                       trip =3D <&package_fan0>;
> > +                       cooling-device =3D <&fan THERMAL_NO_LIMIT 1>;
> > +               };
> > +
> > +               map1 {
> > +                       trip =3D <&package_fan1>;
> > +                       cooling-device =3D <&fan 2 THERMAL_NO_LIMIT>;
> > +               };
> > +       };
> > +
> > +       trips {
> > +               package_fan0: package-fan0 {
> > +                       hysteresis =3D <2000>;
> > +                       temperature =3D <55000>;
> > +                       type =3D "active";
> > +               };
> > +
> > +               package_fan1: package-fan1 {
> > +                       hysteresis =3D <2000>;
> > +                       temperature =3D <65000>;
> > +                       type =3D "active";
> > +               };
> > +       };
> > +};
> > +
> > +/* NVMe */
> > +&pcie2x1l1 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pcie2x1l1_rst &pcie30x1m1_1_clkreqn &pcie30x1m1=
_1_waken>;
>
> Is there a particular reason to use the GPIO mode for the reset pin,
> rather than the (confusingly named) &pcie30x1m1_1_perstn in line with
> the other two?
There is no particular reason. rk3588-turing-rk1.dtsi is the only
example in the kernel currently doing something similar, and it is
implemented that way there. I agree that the naming is confusing. I
will change it.

> > +       reset-gpios =3D <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> > +       supports-clkreq;
> > +       vpcie3v3-supply =3D <&vcc_3v3_s3>;
> > +       status =3D "okay";
> > +};
> > +
> > +/* NIC */
> > +&pcie2x1l2 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pcie2x1l2_rst>;
>
> Similar to the above - have you tried the dedicated hardware mode for
> this pin, i.e. &pcie20x1m0_perstn? You are not requesting the
> &pcie20x1m0_clkreqn or &pcie20x1m0_waken either, even though they are
> routed on the board - that will probably bite you if you try
> suspending the board.

I have not, I also have not tried to suspend. Will adopt and test.



> > +       reset-gpios =3D <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> > +       vpcie3v3-supply =3D <&vcc3v3_phy1>;
> > +       status =3D "okay";
> > +};
> > +
> > +&pinctrl {
> > +       bluetooth {
> > +               bt_wake_gpio: bt-wake-pin {
> > +                       rockchip,pins =3D <0 RK_PC6 RK_FUNC_GPIO &pcfg_=
pull_none>;
>
> If you care about power consumption of the board it's probably better
> to pull this down to make sure the Bluetooth module is predictably in
> a sleep state when not explicitly requested, not floating randomly.
> There is no dedicated pull-up/pull-down on your board.

Will do

> > +               };
> > +
> > +               bt_wake_host_irq: bt-wake-host-irq {
> > +                       rockchip,pins =3D <0 RK_PC5 RK_FUNC_GPIO &pcfg_=
pull_down>;
> > +               };
> > +       };
> > +
> > +       dp {
> > +               dp_bridge_en: dp-bridge-en {
> > +                       rockchip,pins =3D <3 RK_PC2 RK_FUNC_GPIO &pcfg_=
pull_none>;
>
> This pin doesn't have any dedicated pull-up/pull-down on the board, so
> you might end up in a weird power state for the period of time between
> the probing of the pinctrl subsystem and regulators. Better set it to
> &pcfg_pull_down, which matches the power-on-reset default state of
> this pin.

Will do

> > +               };
> > +       };
> > +
> > +       pcie {
> > +               pcie2x1l1_rst: pcie2x1l1-rst {
> > +                       rockchip,pins =3D <4 RK_PA2 RK_FUNC_GPIO &pcfg_=
pull_none>;
> > +               };
> > +
> > +               pcie2x1l2_rst: pcie2x1l2-rst {
> > +                       rockchip,pins =3D <3 RK_PD1 RK_FUNC_GPIO &pcfg_=
pull_none>;
> > +               };
> > +
> > +               vcc3v3_phy1_en: vcc3v3-phy1-en {
>
> The schematic calls this pin "Ethernet_EN", so perhaps use that in the
> label and node name for easier reference.

Will do

> > +                       rockchip,pins =3D <3 RK_PB7 RK_FUNC_GPIO &pcfg_=
pull_none>;
>
> As above: no dedicated pull resistors on the board, better set to
> &pcfg_pull_down in line with POR default.

Will do

> > +               };
> > +       };
> > +
> > +       usb {
> > +               vcc5v0_otg_en: vcc5v0-otg-en {
> > +                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcfg_=
pull_none>;
>
> As above: no dedicated pull resistors on the board, better set to
> &pcfg_pull_down in line with POR default.


Will do

> > +               };
> > +       };
> > +
> > +       wlan {
> > +               wifi_enable_h: wifi-enable-h {
> > +                       rockchip,pins =3D <0 RK_PD0 RK_FUNC_GPIO &pcfg_=
pull_none>;
>
> As above: no dedicated pull resistors on the board, better set to
> &pcfg_pull_down in line with POR default.

will do

> Best regards,
> Alexey

I appreciate the feedback

Dennis
