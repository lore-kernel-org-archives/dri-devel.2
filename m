Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3BFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 09:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E9A10E3E5;
	Mon,  4 May 2026 09:25:10 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D417410E3E5
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 09:25:08 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5673804da95so1272031e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 02:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777886708; x=1778491508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XiyjHCJDl/rogPwAqEoOmuI7BlhASDQQxZixIp7ihY8=;
 b=WaVtEofOjO6KIx0BwWVVi1cyWMe+rDkSb73k8KhdCMjL1pcGtVoe9cfeC6af8VVDq/
 WXKrlPky6K1iHI/xfiutHFHFJKnOJMz6nq3BhOjLtYUHMIdJfUiAQQzu82EWvf8wwEBm
 TLQCC5sQ0rqSxzEitgltyCcIP+U+SGzNOEbeXZ+4V8r3k6bJWPfgl6HqtdUfG010G/Tq
 +Lx/uhiX7dI0NpKfLXc1RSyp7sB5a1nOuZVlzbM7CcN6Xirk9S225D62iPD4jlryq2yF
 xp2jzeu1V2fR7DhbMYOWnKXZASQ08o1hjqalj3N/CffJM9XG+A8gxDAqfUvyQ8xNRJf1
 9CQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xMzVnCy9Dbitu4uOz9iU5WCQuIkmJNmZtiXZNQHjUkD49gfYmVUStAtAa09/ANNd6ClDbMGkWTDw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyixVwba2peQnKY5+tg6vtT0TKY78UuS4ojbzxsgMY0hVrQja4H
 GCIEEypIXVhNvbUIuM3/DWm3MIxlXv3FSknVpfv0ug1r983ls98rA/EwcWZK9Zi9
X-Gm-Gg: AeBDiesKnaH/P/CJDNhxDvwP8V82eJ2vmPH0cX5XbgeZ33FlhS6guDtkLqEpDrXX5Au
 sASSkoETyDTqfk9fU2/FgKjPOPNcDao9z/up1iyAloVOqmQXG8JPte9YzGIGSrq32fCUsk5pF/H
 CaaD7BQBlRNLgzd3xjox/+v91Pss0U5UNUNb+QePlOReVOsFKid8ghFTXkn0+qDsTQfGMpOEiMh
 yYinFvCOlHqlW7jxxdhQwKQJ2skeEWudOKOvUHoCUMcHKVXiSe5dpFJRxG9lsMx0b7uKYT5Vtdc
 4ZfQncwSUu6fwQn4t8z0TT9AwZjZqYu2VB1xyV/AQoo5FZUYSrQx2kGdv6gwNiTwOx+AMaSG/1e
 g26NIxEqbK7YQMzCpTJymA5hGrIsZb9Wn+SfwldHJZAL3uie4gaGyqzT68vPZi30yPglx0Z74LI
 6d6mjMcqmtzoTEFWARmF2SN2ROprtWQ5lCvUCoTQRA0ksOgRQo68KAbr0lI+dU2QIiuRBY26SMr
 VI=
X-Received: by 2002:a05:6122:80d4:b0:575:24b5:88e7 with SMTP id
 71dfb90a1353d-57524b59d5emr778882e0c.11.1777886707582; 
 Mon, 04 May 2026 02:25:07 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com.
 [209.85.221.181]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-574a6c6c582sm5857498e0c.9.2026.05.04.02.25.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 02:25:06 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5674d8be45eso997733e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 02:25:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9PEKURQNJ/l2/D58lKNSHwyfDwvO/BxCpyTEWx+qdnHHpPtVXnir8dwyYYydo70Hdf3tIoiv8l4zU=@lists.freedesktop.org
X-Received: by 2002:a05:6122:2884:b0:56d:b639:5c0d with SMTP id
 71dfb90a1353d-5750ca1f022mr3391522e0c.13.1777886706296; Mon, 04 May 2026
 02:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-8-marek.vasut+renesas@mailbox.org>
 <CAMuHMdX17D3n_5vxsvmaSmionjOqrEdPygjPdYuu6a0DR7b83w@mail.gmail.com>
 <0875e4a1-f112-4619-a229-2f6f9197f21c@mailbox.org>
In-Reply-To: <0875e4a1-f112-4619-a229-2f6f9197f21c@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2026 11:24:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJvrsXitGagqZJ_STdTTh_s1cBAKf6+esihaVWjfn40g@mail.gmail.com>
X-Gm-Features: AVHnY4LakVD8SFWNnLvI5N41V0dwMs_sPKYjvoWQU3neqkGpISJJCy9fOpu_jcA
Message-ID: <CAMuHMdXJvrsXitGagqZJ_STdTTh_s1cBAKf6+esihaVWjfn40g@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: renesas: r8a779md: Add support for R-Car
 M3Le R8A779MD Geist
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

Hi Marek,

On Sun, 3 May 2026 at 04:50, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 4/29/26 3:59 PM, Geert Uytterhoeven wrote:
> >> +&avb {
> >> +       pinctrl-0 =3D <&avb_pins>;
> >> +       pinctrl-names =3D "default";
> >> +       phy-handle =3D <&phy0>;
> >> +       tx-internal-delay-ps =3D <2000>;
> >> +       status =3D "okay";
> >> +
> >> +       phy0: ethernet-phy@0 {
> >
> > compatible =3D "ethernet-phy-id0022.1622";
> >
> >> +               rxc-skew-ps =3D <1500>;
> >> +               reg =3D <0>;
> >> +               interrupt-parent =3D <&gpio2>;
> >> +               interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> >
> > interrupts-extended =3D <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
> >
> >> +               reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
> >> +               reset-assert-us =3D <100>;
> >> +               reset-deassert-us =3D <100>;
> >
> > Do we need these two? We don't have them in e.g.
> > arch/arm64/boot/dts/renesas/salvator-common.dtsi
>
> I believe we should add them, the KSZ9031 PHY does require 100us delay
> after reset is deasserted and before MDIO access is possible:
>
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/DataSheets/KSZ9031RNX-Data-Sheet-DS00002117.pdf
>
> FIGURE 7-5: POWER-UP/POWER-DOWN/RESET TIMING
>
> "
> Note 2: After the de-assertion of reset, wait a minimum of 100 =C2=B5s be=
fore
> starting programming on the MIIM (MDC/MDIO)
> interface
> "

OK. So please add it to the other boards, too.

> [...]
>
> >> +       pwm2_pins: pwm2 {
> >> +               groups =3D "pwm2_a";
> >> +               function =3D "pwm2";
> >> +       };
> >
> > What is pwm2 used for?
>
> The signal is accessible on the EXIO connector D (LBSC) .
> It is up to user to use the pin for their purposes.

Usually we do not enable support for random user wirings on EXIO connectors=
.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
