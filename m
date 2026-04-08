Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA021073CAE
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC91810E64C;
	Wed,  8 Apr 2026 13:02:45 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7C910E64C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:02:44 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56d9ed609d2so1867371e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775653363; x=1776258163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/ehc1JvHivWXa8+tx/BxLqhZP9bLnNS5TsQxkh+zto=;
 b=ebOIplNb3gIvUmseJ4FMohIk1YrmbGXl1sBjiBshHfKuv9rjqxWuxlVSemH4EplLdV
 WUGD26D9pPoA7LADv3WJbIAiu+YQGiIYJ6EtltRQ15eK1a5BkYnvFW9dIhgd12ZF8eQ3
 gMoP3sUwzzwNoPwY79gPZAdzjmv+gJ31O6aWr0bWKGBqdP8Ie+1hu4vWfX9Qv8oRWNar
 ZuT9HD830eGtY3aEGKh7wF7QyiNEkW+POqTw4VHotABn2UOReHr4nauU06PkuFfwWU+A
 P/Fh/sAKLM5rntCvl8fm3KQD7u0Z1s/l3SqGLhlo3P1PeM0kTomTGGBau4CyRCDMkWJO
 L07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3RBziFhkTS8R9Qwxv9MwugJevahMl+naRdAFsysRIySm1kgscPQDlvJRP8yTwQkLNMJCfQBwGy8U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKEqEmNGbE57GsfjqxReStoyiNv5Kw43JKTO5PtusyCib2/NGU
 h4N7Bys6lUffrwQWHbic1BpeYA+uYSDytw93gqKEG2OwxfAOMkyGfRlMPjygEsP2
X-Gm-Gg: AeBDiesgO+WN1E7XQkBTZDbXVmV+Oga7U3AsFsqm0hocdf0jGteddCWtijTsgCm2pWR
 ZC5ivaYt5/WnKXOjuq0mJKPtwr0gtpuG93y0dMpwoUmrj4YRJuiM+ZzY4wyTpsN911f7uq6Fzhb
 Uqe3bwikEFLagZyLixEluun7tgFximrpSSGlT1XkQrM3ow5BgtF/bIQhzX1TWbGQtxiW7y8thUV
 Y1ph5P5d89ZCrb/rHHocG/VBWB8wezWJhzBnTOCy/Cp7SVJ9sIt5hyEJd90nUf/Pko2hSkf89xD
 gWnJB1HP8QHH7UHdfuEUcCHLEnWLf2hILKA0spiK4m1Ypu1J+I8rixvyPNPFEUwfd8veZTcy2/K
 IG74UUD3gIA3C5/b/GOFRYiEapQMhRg7fAxdGjShnbTz5jbTNw2JVC+cq10Uk56JtGS8HnYYOE8
 JH4B/eKQr1sotkyegtfJfEQkCYij14CAZSUvy+hqsZsClne9Mc/0TrES2rvHvl2TXT
X-Received: by 2002:a05:6122:245:b0:56c:ca50:e963 with SMTP id
 71dfb90a1353d-56f1649283cmr2251696e0c.14.1775653308563; 
 Wed, 08 Apr 2026 06:01:48 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com.
 [209.85.221.178]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d9bce02f3sm19848978e0c.14.2026.04.08.06.01.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 06:01:45 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-56a9c5cb48bso1863115e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:01:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZh0Rj8uE9O3dqOy4ZlU4Rez04/CCOiZJr43AdHbl910n5V6dwsvkr8wBAO2dkI5Yr/Jpw+6+Cqk=@lists.freedesktop.org
X-Received: by 2002:a05:6122:a05:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56dab90cf81mr7244283e0c.6.1775653285855; Wed, 08 Apr 2026
 06:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <481fefa0c9f6f0629a663fe3da1fb17e7f4a1a05.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <481fefa0c9f6f0629a663fe3da1fb17e7f4a1a05.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 15:01:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWimH9kaOcwVx1LnujT=Lbm8cE50mj+YFxtBQMZCT0N8w@mail.gmail.com>
X-Gm-Features: AQROBzB38k87n7vfkgAHJ2zbU_998n7zblsjoYLjCSjeXBMYaqe_VAmcFna50bs
Message-ID: <CAMuHMdWimH9kaOcwVx1LnujT=Lbm8cE50mj+YFxtBQMZCT0N8w@mail.gmail.com>
Subject: Re: [PATCH v6 21/21] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 DU0 and DSI support
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, laurent.pinchart@ideasonboard.com, 
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Tommaso,

On Wed, 8 Apr 2026 at 12:40, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Enable DU0, DSI and ADV7535 on RZ/G3E SMARC EVK.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> @@ -33,6 +33,7 @@ aliases {
>                 ethernet0 = &eth0;
>                 ethernet1 = &eth1;
>                 i2c2 = &i2c2;
> +               i2c7 = &i2c7;
>                 mmc0 = &sdhi0;
>                 mmc2 = &sdhi2;
>         };
> @@ -77,12 +78,47 @@ reg_vdd0p8v_others: regulator-vdd0p8v-others {
>                 regulator-always-on;
>         };
>
> +       reg_1p8v_adv: regulator-1p8v-adv {

Please preserve sort order (alphabetical, by node name).

> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-1.8V";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +
> +       reg_3p3v_adv: regulator-3p3v-adv {
> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-3.3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };

Why not reusing the existing reg_1p8v and reg_3p3v?
Note that reg_1p8v driving eMMC and QSPI are also not the same
physical power rail.

> +
> +       osc1: cec-clock {

Please preserve sort order (alphabetical, by node name).

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <12000000>;
> +       };
> +
>         /* 32.768kHz crystal */
>         x3: x3-clock {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <32768>;
>         };
> +
> +       dsi-to-hdmi-out {

hdmi-out?

Please preserve sort order (alphabetical, by node name).

> +               compatible = "hdmi-connector";
> +               type = "d";
> +
> +               port {
> +                       dsi_to_hdmi_out: endpoint {
> +                               remote-endpoint = <&adv7535_out>;
> +                       };
> +               };
> +       };
>  };
>
>  &audio_extal_clk {
> @@ -107,6 +143,37 @@ &eth1 {
>         status = "okay";
>  };
>
> +&dsi {

Please preserve sort-order (alphabetical, by label).

> +       status = "okay";
> +
> +       ports {
> +               port@0 {
> +                       dsi_in0: endpoint {
> +                               remote-endpoint = <&du0_out_dsi>;
> +                       };
> +               };
> +
> +               port@2 {
> +                       dsi_out: endpoint {
> +                               remote-endpoint = <&adv7535_in>;
> +                               data-lanes = <1 2 3 4>;
> +                       };
> +               };
> +       };
> +};
> +
> +&du0 {
> +       status = "okay";
> +
> +       ports {
> +               port@0 {
> +                       du0_out_dsi: endpoint {
> +                               remote-endpoint = <&dsi_in0>;
> +                       };
> +               };
> +       };
> +};
> +
>  &gpu {
>         status = "okay";
>         mali-supply = <&reg_vdd0p8v_others>;
> @@ -132,6 +199,48 @@ raa215300: pmic@12 {
>         };
>  };
>
> +&i2c7 {
> +       pinctrl-0 = <&i2c7_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       adv7535: hdmi@3d {
> +               compatible = "adi,adv7535";
> +               reg = <0x3d>, <0x4d>, <0x2d>, <0x5d>;
> +               reg-names = "main", "edid", "cec", "packet";
> +               clocks = <&osc1>;
> +               clock-names = "cec";
> +               avdd-supply = <&reg_1p8v_adv>;
> +               dvdd-supply = <&reg_1p8v_adv>;
> +               pvdd-supply = <&reg_1p8v_adv>;
> +               a2vdd-supply = <&reg_1p8v_adv>;
> +               v3p3-supply = <&reg_3p3v_adv>;
> +               v1p2-supply = <&reg_1p8v_adv>;
> +               adi,dsi-lanes = <4>;
> +               interrupts-extended = <&pinctrl RZG3E_GPIO(L, 4) IRQ_TYPE_EDGE_FALLING>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               adv7535_in: endpoint {
> +                                       remote-endpoint = <&dsi_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               adv7535_out: endpoint {
> +                                       remote-endpoint = <&dsi_to_hdmi_out>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
>  &i3c {
>         pinctrl-0 = <&i3c_pins>;
>         pinctrl-names = "default";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
