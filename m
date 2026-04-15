Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40C2FA0C43
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 08:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC5410E6A3;
	Wed, 15 Apr 2026 08:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AGoEFH75";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6689810E6A3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 08:02:25 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso62140531cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 01:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776240144; cv=none;
 d=google.com; s=arc-20240605;
 b=aXNvGP5994CUahgbbbqwCqoFanF/+gUEI88D+Cu/sRi+QD88dH9bSizNGipX8bQnKn
 wGwfhB7h5xZYKuta8miIhnTfAKgFw6AlC4yshdrGtAED34iM+W/byFdoiVxeBiYO7dfA
 CmPqi9pcJYU+ECVw5gsRzasb7/h0sO3+90uXSrp3ki+H0t3GkFzqAvBaDPQLO1G29dkc
 CiiOz/czKcypIIIo2ysTDuUWQxKtZpb50Aey1u4h/uz+CAfmqIDG1uYJ1OocJs7tloh/
 JTlOJgSj4bp1rVw1LN+kdw5xWpKdaFOzo5tbscs0c+qw9fZa/D24oD1rxaV04QsaHaEa
 Jb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rbxvJOa/JYW1hnfdEB5jM3Immknkau71T9SFVcN6XMA=;
 fh=jMyghuVsOREAO0QolvkqDw39v7cExmZtDj0tzgQDq9E=;
 b=en/NCbRvwI9+k+pBtIlzeBuvtqLabIjMM2P9l0lrLqttdcWfuKiFMD0NiTs9y9Dvf6
 eGoknlxd/FSg4sy0mAZFalc13R+KWEqsgVL836vizDn4FEx7rc7K0nMcF3INqrh5z6LB
 xdiU3RCZchUD0HT28Bhb9o0W8QaXvZX264eKktdnJg58vrFQesPVflh7MfV4BGHeOcwn
 6SyT5gVkZJQMwR7G0ATsVsyHFJSBqYMoXo1C3IQWueTcKMVglFJQUbKPhkXNBtRa59Sx
 HuGi7qCFcCV49zzTyQdJ1XxYdM3+/sHjQ/j64eaXYiPL6F9XId8x4URLFFsqiqzqnhgJ
 3N9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776240144; x=1776844944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbxvJOa/JYW1hnfdEB5jM3Immknkau71T9SFVcN6XMA=;
 b=AGoEFH75KanEvbRtHnavmADAw/6uEt8MwGLFJygYPjkXHfbMVoHP7xFGOwzzWrskUU
 +8TAzCKLSBcDyMhIRi6ifVMmyZ+GdAV2PsvkMbpWXwGKWnqCR9N/ZJtqdrK71U1rwbh6
 vPJxReCEZ/562PL3Nkcj6XzFMg2+KSxDpmdFLSliijspQN/i5vAO/7pWpfT8aLbzMSdp
 Mqjs6LoHp4AYBx4wlJtxSzWSt0kZrvgXNzU8Mj6IQAY46RUeNb5xMAJpZaxbWwrHxV4R
 kRYuT6OVr11439uFyVgz/ebugJMHIbVsXyzpnFS1LPGSJHiSaFrFFy96NFpmeTvZcROY
 dJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776240144; x=1776844944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rbxvJOa/JYW1hnfdEB5jM3Immknkau71T9SFVcN6XMA=;
 b=i/wkx67fdXfIbF55425UyuBmL9k3TLZgUg4p6ngUqCfmzZ/eTmyEbNCsdvfz7zwj5F
 PGGT35qnL94NHOJTXcAU15op0IaG0mS9yJ9RQNbyujmfrtUt3h5hRr+608FMbMzoVcoY
 XPxkmPRBJlAhCQmjq5nkk0i6pvLfUg1QzioOYorFIqgXfdmdjFn5PyeFKK31R5dVVAJD
 2k15L6KRxBG3XLVj8KGZZcfudSREquTFEHxpZm3RUZ+0MWYu20rCKjf8h6N9QyazudIk
 tWDK03IZBNYH83HZJ7xxydWlsvNgpD/LXswpMgQEMWv76AVuNBeCfKmnz8U4KiLP3ZxC
 NxIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QUEvmYiMXmeqIb6icrpoQGOiABaB8A6GGXgEt3fml/vR63XARk+FPNfoNT7TUnExESd+FLo3b12I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+tG8LmKw06f0RXPRALwjLaWKzBJJ03FnzGOCis3uIZ2PJJXBd
 jROkWaeQsQ+OnknZz9yxsaW3j3Vc1yl/ychKowLArHfBCOoKoi7g4nAl/Wq6+bApWTDjL5nxRYR
 TKY2fNPCIsm5MrBSk1JiaJ+eoSyXtdSU=
X-Gm-Gg: AeBDiet6wIjr6qEj8URjzAH5FyhMqA0m3BHDC905dL3guQRQy8gSzxdlykwdD+/GntS
 U1+yq/dUYP3gaQeNcXGZwEam1bPC4MKi3j2GUm3fhoqc5zttCyhrch5dprreyDTFEtxOmNMtWEB
 dtfO3NkT6Wo4IIyNmx8qdFplqK0wy8DxBcEloyZI+TF4c/WatM1vSlXLOjaQ3xKcPSACCIG52ki
 9pDMyNFqdEPxRaa3wIHMoAtdASl/NJIKcZlamXDpOoIA56RraKDs1GNcXSmZrTkjbIwmQ9h21Oi
 cNZ70ag=
X-Received: by 2002:a05:622a:5592:b0:509:20aa:49ea with SMTP id
 d75a77b69052e-50dd6b7ab10mr259839571cf.18.1776240144181; Wed, 15 Apr 2026
 01:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260414214104.1363987-1-dennis@ausil.us>
 <20260414214104.1363987-6-dennis@ausil.us>
In-Reply-To: <20260414214104.1363987-6-dennis@ausil.us>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 15 Apr 2026 12:02:09 +0400
X-Gm-Features: AQROBzBxinnSm0ZUpMUnsQeJ0Cy2sLYN8DnKCbBE6CuxbhvJuI91PMGKe2ZVeXI
Message-ID: <CABjd4Yy29f7g7wyZZJj0aZfoREaUANjo+Lj=p1gk5Q=NU7mODA@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] arm64: dts: rockchip: refactor items from Orange
 Pi 5/b to prep for Pro
To: Dennis Gilmore <dennis@ausil.us>
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

On Wed, Apr 15, 2026 at 1:41=E2=80=AFAM Dennis Gilmore <dennis@ausil.us> wr=
ote:
>
> The Orange Pi 5 Pro uses the same SoC and base as the Orange Pi 5 and
> Orange Pi 5B but has had sound, USB, and leds wired up differently. The
> 5 and 5B boards use gmac for ethernet where the Pro has a PCIe attached
> NIC.
>
> Move the 5/5B-specific bits (analog-sound/es8388, FUSB302 Type-C,
> gmac1, pwm-leds, i2s1_8ch routing, USB role-switch plumbing) out of
> rk3588s-orangepi-5.dtsi into a new rk3588s-orangepi-5-5b.dtsi that is
> included by both 5 and 5B.
>
> The RK806 PLDO1 and PLDO2 outputs are wired differently between the
> 5/5B and the Pro (PLDO1/PLDO2 are swapped), so label the PMIC node
> rk806_single in the base dtsi, drop pldo-reg1/pldo-reg2 from it, and
> define them via a &rk806_single regulators augmentation in
> rk3588s-orangepi-5-5b.dtsi. The Pro will supply its own mapping.
>
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  .../dts/rockchip/rk3588s-orangepi-5-5b.dtsi   | 222 +++++++++++++++++
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |   6 +-
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi | 225 +-----------------
>  .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |   2 +-
>  4 files changed, 240 insertions(+), 215 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-5b.dt=
si

Hi Dennis,

Sashiko makes a good point [1] about also moving the vbus_typec to the
*-5-5b.dtsi, given that it's not used on the Pro. Same with mdio1
which only makes sense together with its respective GMAC. Other than
that, this looks good to me - feel free to include:

Reviewed-by: Alexey Charkov <alchark@gmail.com

Best regards,
Alexey

[1] https://sashiko.dev/#/patchset/20260414214104.1363987-1-dennis%40ausil.=
us

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-5b.dtsi b/ar=
ch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-5b.dtsi
> new file mode 100644
> index 000000000000..9e987ffa6241
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-5b.dtsi
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device tree definitions shared by the Orange Pi 5 and Orange Pi 5B
> + * but not the Orange Pi 5 Pro.
> + */
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "rk3588s-orangepi-5.dtsi"
> +
> +/ {
> +       aliases {
> +               ethernet0 =3D &gmac1;
> +       };
> +
> +       analog-sound {
> +               compatible =3D "simple-audio-card";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&hp_detect>;
> +               simple-audio-card,name =3D "rockchip,es8388";
> +               simple-audio-card,bitclock-master =3D <&masterdai>;
> +               simple-audio-card,format =3D "i2s";
> +               simple-audio-card,frame-master =3D <&masterdai>;
> +               simple-audio-card,hp-det-gpios =3D <&gpio1 RK_PD5 GPIO_AC=
TIVE_HIGH>;
> +               simple-audio-card,mclk-fs =3D <256>;
> +               simple-audio-card,routing =3D
> +                       "Headphones", "LOUT1",
> +                       "Headphones", "ROUT1",
> +                       "LINPUT1", "Microphone Jack",
> +                       "RINPUT1", "Microphone Jack",
> +                       "LINPUT2", "Onboard Microphone",
> +                       "RINPUT2", "Onboard Microphone";
> +               simple-audio-card,widgets =3D
> +                       "Microphone", "Microphone Jack",
> +                       "Microphone", "Onboard Microphone",
> +                       "Headphone", "Headphones";
> +
> +               simple-audio-card,cpu {
> +                       sound-dai =3D <&i2s1_8ch>;
> +               };
> +
> +               masterdai: simple-audio-card,codec {
> +                       sound-dai =3D <&es8388>;
> +                       system-clock-frequency =3D <12288000>;
> +               };
> +       };
> +
> +       pwm-leds {
> +               compatible =3D "pwm-leds";
> +
> +               led {
> +                       color =3D <LED_COLOR_ID_GREEN>;
> +                       function =3D LED_FUNCTION_STATUS;
> +                       linux,default-trigger =3D "heartbeat";
> +                       max-brightness =3D <255>;
> +                       pwms =3D <&pwm0 0 25000 0>;
> +               };
> +       };
> +};
> +
> +&gmac1 {
> +       clock_in_out =3D "output";
> +       phy-handle =3D <&rgmii_phy1>;
> +       phy-mode =3D "rgmii-rxid";
> +       pinctrl-0 =3D <&gmac1_miim
> +                       &gmac1_tx_bus2
> +                       &gmac1_rx_bus2
> +                       &gmac1_rgmii_clk
> +                       &gmac1_rgmii_bus>;
> +       pinctrl-names =3D "default";
> +       tx_delay =3D <0x42>;
> +       status =3D "okay";
> +};
> +
> +&i2c6 {
> +       es8388: audio-codec@10 {
> +               compatible =3D "everest,es8388", "everest,es8328";
> +               reg =3D <0x10>;
> +               clocks =3D <&cru I2S1_8CH_MCLKOUT>;
> +               AVDD-supply =3D <&vcca_3v3_s0>;
> +               DVDD-supply =3D <&vcca_1v8_s0>;
> +               HPVDD-supply =3D <&vcca_3v3_s0>;
> +               PVDD-supply =3D <&vcca_3v3_s0>;
> +               assigned-clocks =3D <&cru I2S1_8CH_MCLKOUT>;
> +               assigned-clock-rates =3D <12288000>;
> +               #sound-dai-cells =3D <0>;
> +       };
> +
> +       usbc0: usb-typec@22 {
> +               compatible =3D "fcs,fusb302";
> +               reg =3D <0x22>;
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&usbc0_int>;
> +               vbus-supply =3D <&vbus_typec>;
> +               status =3D "okay";
> +
> +               usb_con: connector {
> +                       compatible =3D "usb-c-connector";
> +                       label =3D "USB-C";
> +                       data-role =3D "dual";
> +                       op-sink-microwatt =3D <1000000>;
> +                       power-role =3D "dual";
> +                       sink-pdos =3D
> +                               <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM=
)>;
> +                       source-pdos =3D
> +                               <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM=
)>;
> +                       try-power-role =3D "source";
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       usbc0_hs: endpoint {
> +                                               remote-endpoint =3D <&usb=
_host0_xhci_drd_sw>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       usbc0_ss: endpoint {
> +                                               remote-endpoint =3D <&usb=
dp_phy0_typec_ss>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg =3D <2>;
> +                                       usbc0_sbu: endpoint {
> +                                               remote-endpoint =3D <&usb=
dp_phy0_typec_sbu>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&i2s1_8ch {
> +       rockchip,i2s-tx-route =3D <3 2 1 0>;
> +       rockchip,i2s-rx-route =3D <1 3 2 0>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2s1m0_sclk
> +                          &i2s1m0_mclk
> +                          &i2s1m0_lrck
> +                          &i2s1m0_sdi1
> +                          &i2s1m0_sdo3>;
> +       status =3D "okay";
> +};
> +
> +&pwm0 {
> +       pinctrl-0 =3D <&pwm0m2_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +&rk806_single {
> +       regulators {
> +               vcc_1v8_s0: pldo-reg1 {
> +                       regulator-name =3D "vcc_1v8_s0";
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +
> +                       regulator-state-mem {
> +                               regulator-off-in-suspend;
> +                       };
> +               };
> +
> +               vcca_1v8_s0: pldo-reg2 {
> +                       regulator-name =3D "vcca_1v8_s0";
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +
> +                       regulator-state-mem {
> +                               regulator-off-in-suspend;
> +                               regulator-suspend-microvolt =3D <1800000>=
;
> +                       };
> +               };
> +       };
> +};
> +
> +
> +&usb_host0_xhci {
> +       dr_mode =3D "otg";
> +       usb-role-switch;
> +
> +       port {
> +               usb_host0_xhci_drd_sw: endpoint {
> +                       remote-endpoint =3D <&usbc0_hs>;
> +               };
> +       };
> +};
> +
> +&usb_host2_xhci {
> +       status =3D "okay";
> +};
> +
> +&usbdp_phy0 {
> +       mode-switch;
> +       orientation-switch;
> +       sbu1-dc-gpios =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +       sbu2-dc-gpios =3D <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
> +
> +       port {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               usbdp_phy0_typec_ss: endpoint@0 {
> +                       reg =3D <0>;
> +                       remote-endpoint =3D <&usbc0_ss>;
> +               };
> +
> +               usbdp_phy0_typec_sbu: endpoint@1 {
> +                       reg =3D <1>;
> +                       remote-endpoint =3D <&usbc0_sbu>;
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/a=
rm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> index 83b9b6645a1e..d76bdf1b5e90 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> @@ -2,12 +2,16 @@
>
>  /dts-v1/;
>
> -#include "rk3588s-orangepi-5.dtsi"
> +#include "rk3588s-orangepi-5-5b.dtsi"
>
>  / {
>         model =3D "Xunlong Orange Pi 5";
>         compatible =3D "xunlong,orangepi-5", "rockchip,rk3588s";
>
> +       aliases {
> +               mmc0 =3D &sdmmc;
> +       };
> +
>         vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
>                 compatible =3D "regulator-fixed";
>                 enable-active-high;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi b/arch/=
arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> index fd5c6a025cd1..2b605e5fc35a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
> @@ -3,19 +3,13 @@
>  /dts-v1/;
>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/soc/rockchip,vop2.h>
> -#include <dt-bindings/usb/pd.h>
>  #include "rk3588s.dtsi"
>
>  / {
> -       aliases {
> -               ethernet0 =3D &gmac1;
> -               mmc0 =3D &sdmmc;
> -       };
> -
>         chosen {
>                 stdout-path =3D "serial2:1500000n8";
>         };
> @@ -34,38 +28,6 @@ button-recovery {
>                 };
>         };
>
> -       analog-sound {
> -               compatible =3D "simple-audio-card";
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&hp_detect>;
> -               simple-audio-card,name =3D "rockchip,es8388";
> -               simple-audio-card,bitclock-master =3D <&masterdai>;
> -               simple-audio-card,format =3D "i2s";
> -               simple-audio-card,frame-master =3D <&masterdai>;
> -               simple-audio-card,hp-det-gpios =3D <&gpio1 RK_PD5 GPIO_AC=
TIVE_HIGH>;
> -               simple-audio-card,mclk-fs =3D <256>;
> -               simple-audio-card,routing =3D
> -                       "Headphones", "LOUT1",
> -                       "Headphones", "ROUT1",
> -                       "LINPUT1", "Microphone Jack",
> -                       "RINPUT1", "Microphone Jack",
> -                       "LINPUT2", "Onboard Microphone",
> -                       "RINPUT2", "Onboard Microphone";
> -               simple-audio-card,widgets =3D
> -                       "Microphone", "Microphone Jack",
> -                       "Microphone", "Onboard Microphone",
> -                       "Headphone", "Headphones";
> -
> -               simple-audio-card,cpu {
> -                       sound-dai =3D <&i2s1_8ch>;
> -               };
> -
> -               masterdai: simple-audio-card,codec {
> -                       sound-dai =3D <&es8388>;
> -                       system-clock-frequency =3D <12288000>;
> -               };
> -       };
> -
>         hdmi0-con {
>                 compatible =3D "hdmi-connector";
>                 type =3D "a";
> @@ -77,18 +39,6 @@ hdmi0_con_in: endpoint {
>                 };
>         };
>
> -       pwm-leds {
> -               compatible =3D "pwm-leds";
> -
> -               led {
> -                       color =3D <LED_COLOR_ID_GREEN>;
> -                       function =3D LED_FUNCTION_STATUS;
> -                       linux,default-trigger =3D "heartbeat";
> -                       max-brightness =3D <255>;
> -                       pwms =3D <&pwm0 0 25000 0>;
> -               };
> -       };
> -
>         vbus_typec: regulator-vbus-typec {
>                 compatible =3D "regulator-fixed";
>                 enable-active-high;
> @@ -101,15 +51,6 @@ vbus_typec: regulator-vbus-typec {
>                 vin-supply =3D <&vcc5v0_sys>;
>         };
>
> -       vcc5v0_sys: regulator-vcc5v0-sys {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "vcc5v0_sys";
> -               regulator-always-on;
> -               regulator-boot-on;
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -       };
> -
>         vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
>                 compatible =3D "regulator-fixed";
>                 gpios =3D <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
> @@ -119,6 +60,15 @@ vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
>                 regulator-max-microvolt =3D <3300000>;
>                 vin-supply =3D <&vcc_3v3_s3>;
>         };
> +
> +       vcc5v0_sys: regulator-vcc5v0-sys {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +       };
>  };
>
>  &combphy0_ps {
> @@ -161,20 +111,6 @@ &cpu_l3 {
>         cpu-supply =3D <&vdd_cpu_lit_s0>;
>  };
>
> -&gmac1 {
> -       clock_in_out =3D "output";
> -       phy-handle =3D <&rgmii_phy1>;
> -       phy-mode =3D "rgmii-rxid";
> -       pinctrl-0 =3D <&gmac1_miim
> -                    &gmac1_tx_bus2
> -                    &gmac1_rx_bus2
> -                    &gmac1_rgmii_clk
> -                    &gmac1_rgmii_bus>;
> -       pinctrl-names =3D "default";
> -       tx_delay =3D <0x42>;
> -       status =3D "okay";
> -};
> -
>  &gpu {
>         mali-supply =3D <&vdd_gpu_s0>;
>         status =3D "okay";
> @@ -270,69 +206,6 @@ &i2c6 {
>         pinctrl-0 =3D <&i2c6m3_xfer>;
>         status =3D "okay";
>
> -       es8388: audio-codec@10 {
> -               compatible =3D "everest,es8388", "everest,es8328";
> -               reg =3D <0x10>;
> -               clocks =3D <&cru I2S1_8CH_MCLKOUT>;
> -               AVDD-supply =3D <&vcca_3v3_s0>;
> -               DVDD-supply =3D <&vcca_1v8_s0>;
> -               HPVDD-supply =3D <&vcca_3v3_s0>;
> -               PVDD-supply =3D <&vcca_3v3_s0>;
> -               assigned-clocks =3D <&cru I2S1_8CH_MCLKOUT>;
> -               assigned-clock-rates =3D <12288000>;
> -               #sound-dai-cells =3D <0>;
> -       };
> -
> -       usbc0: usb-typec@22 {
> -               compatible =3D "fcs,fusb302";
> -               reg =3D <0x22>;
> -               interrupt-parent =3D <&gpio0>;
> -               interrupts =3D <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&usbc0_int>;
> -               vbus-supply =3D <&vbus_typec>;
> -               status =3D "okay";
> -
> -               usb_con: connector {
> -                       compatible =3D "usb-c-connector";
> -                       label =3D "USB-C";
> -                       data-role =3D "dual";
> -                       op-sink-microwatt =3D <1000000>;
> -                       power-role =3D "dual";
> -                       sink-pdos =3D
> -                               <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM=
)>;
> -                       source-pdos =3D
> -                               <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM=
)>;
> -                       try-power-role =3D "source";
> -
> -                       ports {
> -                               #address-cells =3D <1>;
> -                               #size-cells =3D <0>;
> -
> -                               port@0 {
> -                                       reg =3D <0>;
> -                                       usbc0_hs: endpoint {
> -                                               remote-endpoint =3D <&usb=
_host0_xhci_drd_sw>;
> -                                       };
> -                               };
> -
> -                               port@1 {
> -                                       reg =3D <1>;
> -                                       usbc0_ss: endpoint {
> -                                               remote-endpoint =3D <&usb=
dp_phy0_typec_ss>;
> -                                       };
> -                               };
> -
> -                               port@2 {
> -                                       reg =3D <2>;
> -                                       usbc0_sbu: endpoint {
> -                                               remote-endpoint =3D <&usb=
dp_phy0_typec_sbu>;
> -                                       };
> -                               };
> -                       };
> -               };
> -       };
> -
>         hym8563: rtc@51 {
>                 compatible =3D "haoyu,hym8563";
>                 reg =3D <0x51>;
> @@ -346,18 +219,6 @@ hym8563: rtc@51 {
>         };
>  };
>
> -&i2s1_8ch {
> -       rockchip,i2s-tx-route =3D <3 2 1 0>;
> -       rockchip,i2s-rx-route =3D <1 3 2 0>;
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2s1m0_sclk
> -                    &i2s1m0_mclk
> -                    &i2s1m0_lrck
> -                    &i2s1m0_sdi1
> -                    &i2s1m0_sdo3>;
> -       status =3D "okay";
> -};
> -
>  &i2s5_8ch {
>         status =3D "okay";
>  };
> @@ -404,12 +265,6 @@ typec5v_pwren: typec5v-pwren {
>         };
>  };
>
> -&pwm0 {
> -       pinctrl-0 =3D <&pwm0m2_pins>;
> -       pinctrl-names =3D "default";
> -       status =3D "okay";
> -};
> -
>  &rknn_core_0 {
>         npu-supply =3D <&vdd_npu_s0>;
>         sram-supply =3D <&vdd_npu_s0>;
> @@ -491,7 +346,7 @@ &spi2 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&spi2m2_cs0 &spi2m2_pins>;
>
> -       pmic@0 {
> +       rk806_single: pmic@0 {
>                 compatible =3D "rockchip,rk806";
>                 reg =3D <0x0>;
>                 interrupt-parent =3D <&gpio0>;
> @@ -666,31 +521,6 @@ regulator-state-mem {
>                                 };
>                         };
>
> -                       vcc_1v8_s0: pldo-reg1 {
> -                               regulator-name =3D "vcc_1v8_s0";
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -
> -                               regulator-state-mem {
> -                                       regulator-off-in-suspend;
> -                               };
> -                       };
> -
> -                       vcca_1v8_s0: pldo-reg2 {
> -                               regulator-name =3D "vcca_1v8_s0";
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -
> -                               regulator-state-mem {
> -                                       regulator-off-in-suspend;
> -                                       regulator-suspend-microvolt =3D <=
1800000>;
> -                               };
> -                       };
> -
>                         vdda_1v2_s0: pldo-reg3 {
>                                 regulator-name =3D "vdda_1v2_s0";
>                                 regulator-always-on;
> @@ -841,26 +671,7 @@ &uart2 {
>  };
>
>  &usbdp_phy0 {
> -       mode-switch;
> -       orientation-switch;
> -       sbu1-dc-gpios =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> -       sbu2-dc-gpios =3D <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
>         status =3D "okay";
> -
> -       port {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               usbdp_phy0_typec_ss: endpoint@0 {
> -                       reg =3D <0>;
> -                       remote-endpoint =3D <&usbc0_ss>;
> -               };
> -
> -               usbdp_phy0_typec_sbu: endpoint@1 {
> -                       reg =3D <1>;
> -                       remote-endpoint =3D <&usbc0_sbu>;
> -               };
> -       };
>  };
>
>  &usb_host0_ehci {
> @@ -872,15 +683,7 @@ &usb_host0_ohci {
>  };
>
>  &usb_host0_xhci {
> -       dr_mode =3D "otg";
> -       usb-role-switch;
>         status =3D "okay";
> -
> -       port {
> -               usb_host0_xhci_drd_sw: endpoint {
> -                       remote-endpoint =3D <&usbc0_hs>;
> -               };
> -       };
>  };
>
>  &usb_host1_ehci {
> @@ -891,7 +694,7 @@ &usb_host1_ohci {
>         status =3D "okay";
>  };
>
> -&usb_host2_xhci {
> +&vop {
>         status =3D "okay";
>  };
>
> @@ -899,10 +702,6 @@ &vop_mmu {
>         status =3D "okay";
>  };
>
> -&vop {
> -       status =3D "okay";
> -};
> -
>  &vp0 {
>         vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>                 reg =3D <ROCKCHIP_VOP2_EP_HDMI0>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/=
arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> index d21ec320d295..8af174777809 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> @@ -2,7 +2,7 @@
>
>  /dts-v1/;
>
> -#include "rk3588s-orangepi-5.dtsi"
> +#include "rk3588s-orangepi-5-5b.dtsi"
>
>  / {
>         model =3D "Xunlong Orange Pi 5B";
> --
> 2.53.0
>
