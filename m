Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A44CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6DE10E27F;
	Thu,  7 May 2026 15:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IiYPc+6m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2530A10E27F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:25:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 84EFD60583
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BC7C2BCC9
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778167554;
 bh=wWbaNgLjvgEK60SoLK00HREVJw2pjszb4CF+qYI0K7w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IiYPc+6mLChtKGBenijU6gMwDozISCBsh5s0UVIU39zm0Ba+5cMfNhtyej2cT3POg
 8ooc59U+xSIwocabHngDh5KPtmqO78vRzCmxy/h2YsjWFtL/0rBmWevWbRcUsMtE+A
 rP5EIo5kx3kWPBEis8SbD9jWDTpmkV4Ni4me8YzqYRLDqJE6Nn8ZF/1sl7DWf3+KGn
 Sna6brPjZFimyNKAHYWhvMq8rpo5jCfK8anLeBC3AZiThqFAhu/wcRuXjhUufDxUTZ
 4zhI6VvgWLOKHK4JBtHrX2sSY3eRmi2w+/fnhYQKfne/Y1Wl+DLGzr+aH0vJwXIkiW
 dWDE+K/b0JHlg==
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-678a16429c6so1460129a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:25:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/CVpy3KeELPHi7YQEWIjAE2P5g/mGqZ3X4kHirR20bkfntW+P917s510dAAOnO6+UvOU9/NiVpcN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhFBAYxpdjuAwH+TlkU7JPEwKiMX8cpPO1l1GKj8RqjaQ33hY4
 PLX4lclut+qzvqll+yAJg6HXEzeIkPx5T2NjhOf90mFzp8Dx7GX/LZlHncCuMCbXYGkxeVBfefR
 j07IWN6v7O07cmeJJuk+L5xUwsKESAQ==
X-Received: by 2002:a05:6402:5344:20b0:67d:98bd:e44e with SMTP id
 4fb4d7f45d1cf-67e0efb390emr1326327a12.17.1778167552504; Thu, 07 May 2026
 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-v7-1-topic-ldb-fixes-v1-0-0125d937ff7f@pengutronix.de>
 <20260504-v7-1-topic-ldb-fixes-v1-2-0125d937ff7f@pengutronix.de>
 <20260505141538.GA2547282-robh@kernel.org>
 <2bl2mwpk57xgkuye2gydliymjkzikiovnb7ovnb73olwtfkjwn@byn3732grvnh>
 <CAL_JsqLYS1sgU680KNR60+OvtNwEVKWovht7K2APO3sqeJe6Nw@mail.gmail.com>
 <zbbez4lpme7szgnsd7fqufbuhmvcftw4sqrmwwwzyxu64i2ppb@fh2fgdkc6tat>
In-Reply-To: <zbbez4lpme7szgnsd7fqufbuhmvcftw4sqrmwwwzyxu64i2ppb@fh2fgdkc6tat>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 May 2026 10:25:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJWyRPh_hmJW8p7+VvtcqpS0a_azjMO-PyQgkqQUfLAGA@mail.gmail.com>
X-Gm-Features: AVHnY4K59HFC-Lj0a6_OWOrJwlVTiPxlkDo7ivtKaVL4QyHlHtRcFSTM5LnBqeE
Message-ID: <CAL_JsqJWyRPh_hmJW8p7+VvtcqpS0a_azjMO-PyQgkqQUfLAGA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Revert "dt-bindings: display: bridge: ldb: Fill in
 reg property"
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, laurentiu.palcu@oss.nxp.com, 
 victor.liu@nxp.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
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

On Thu, May 7, 2026 at 6:55=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.d=
e> wrote:
>
> On 26-05-06, Rob Herring wrote:
> > On Tue, May 5, 2026 at 10:46=E2=80=AFAM Marco Felsch <m.felsch@pengutro=
nix.de> wrote:
> > >
> > > On 26-05-05, Rob Herring wrote:
> > > > On Mon, May 04, 2026 at 10:21:42PM +0200, Marco Felsch wrote:
> > > > > This reverts commit 16c8d76abe83d75b578d72ee22d25a52c764e14a.
> > > > >
> > > > > Remove the 'reg' and 'reg-names' property from the LDB.
> > > > >
> > > > > The LDB is either part of the IOMUX_GPR (i.MX6SX) or the BLKCTRL
> > > > > (i.MX8MP, i.MX93) register space. Both IOMUX_GPR and BLKCTRL are
> > > > > register ranges with loose register definitions. E.g.
> > > > >
> > > > >   - On the i.MX8MP there is one register which controls the AXI
> > > > >     threshold for two different IPs (BIT(31:16) - IP1, BIT(15:0) =
- IP2).
> > > > >   - On the i.MX6SX IOMUXC_GPR5 controlls: CSI2 mux, WDOG3 setting=
s, PXP
> > > > >     handshake, ...
> > > > >
> > > > > In conclusion: it can't be ensured that one register belongs to o=
ne
> > > > > dedicated IP and the LDB is rather an exception than the rule.
> > > >
> > > > It is fine if there's a child node for LDB if the LDB registers are
> > > > consistent, but the other misc things are represented by the parent
> > > > node. It is certainly not a requirement that either everything be i=
n
> > > > child nodes or nothing be in child nodes.
> > > >
> > > > What I don't see in this series is what problem does this fix? If y=
ou
> > > > are going to break compatibility, then there had better be a good
> > > > reason.
> > >
> > > Hi Rob,
> > >
> > > with the upcoming i.MX9x SoCs the parent syscon (BLKCTRL) controlls
> > > multiple other IPs, e.g. a DPI mux added by commit 3feaa4342637
> > > ("dt-bindings: soc: imx93-media-blk-ctrl: Add PDFC subnode to schema =
and
> > > example").
> > >
> > > During the discussion of the above commit we agreed that the sub-devi=
ces
> > > of the syscon shall not use the reg property due to the fact that one
> > > register serves multiple purposes. In the above case the same registe=
r
> > > controlling the dpi-mux also controlls MIPI-DSI bits. The MIPI-DSI bi=
ts
> > > can be abstracted as drm-bridge as well. Two sub-devs using the same
> > > 'reg' property below the same parent seems odd and I don't know if th=
is
> > > allowed either.
> >
> > It's not generally. There are some exceptions to define things at the
> > bit-offset level rather than byte level.
>
> Thanks for the clarification.
>
> > > Now the LDB is also part of this BLKCTRL syscon device but requires t=
he
> > > reg property. TBH, I don't know why the reg property was added in the
> > > first place, due to the above fact (multiple sub-devs - same register=
).
> >
> > Probably because we asked for it, but we don't always get a complete
> > picture of all the h/w functions (though we ask for that too).
>
> I get your point completely and I don't blame anyone.
>
> > But nowhere have you said the LDB registers are mixed with other
> > functions. If they aren't, then there is absolutely nothing to change
> > in the binding. If they are, then yes, we shouldn't have 'reg'.
>
> No they aren't mixed with other functions (for now).

For now? Is the h/w going to change or is the binding *still* incomplete.

> Can you please
> confirm that mixing 'reg' based sub-device nodes with non 'reg' based
> sub-device nodes  is allowed? E.g. if the below example is allowed?
>
>         system-controller@4ac10000 {
>                 compatible =3D "fsl,imx93-media-blk-ctrl", "syscon";
>                 reg =3D <0x4ac10000 0x10000>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>
>                 ...
>
>                 bridge@5c {
>                         compatible =3D "fsl,imx8mp-ldb";
>                         reg =3D <0x5c 0x4>, <0x128 0x4>;
>                         reg-names =3D "ldb", "lvds";
>
>                         ...
>                 };
>
>                 dpi-bridge {
>                         compatible =3D "nxp,imx93-pdfc";
>
>                         ...

Depends what is in "...". If only a compatible, then no. If there are
actual resources defined, then yes.

>                 };
>         };
>
> Furthermore I thought that for the MMIO bridge@5c device, the 'reg'
> porperty would either require the full register address, e.g. 0x4ac1005c
> or there needs to be a ranges property.

There should be a ranges property no matter what.

Rob
