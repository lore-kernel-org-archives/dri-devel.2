Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53584C79F99
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 21:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4051110E1E5;
	Sun,  6 Sep 2026 21:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="f4AoxTbb";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB1510E1E5
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 21:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
 Reply-To:Content-ID:Content-Description;
 bh=Y9LS7SYHFlkHvaK4ZooIhwRFHr3vUhLavYrz1nuVPqA=; b=f4AoxTbb7TWe9/8DFTs7RutDb7
 L82gmbWW2DODqTgiGpBE+E/m0FCkwVtngj8SNAYQuewyWcdMlGTbsVC2+lwNR6wO2xoq3DR7498yq
 mirf/cmsxLfxhCtGUqUheLnnAbkfCX9gaXuU2mFHeLlZAAYlJNtKMn4nOkQazdx2SK3u2RUlqfOFM
 KWcbkU4Q73N5/5H/UvoLmg1kZBTNJRKz56T6MAydZXl+bJWQ9dQs7uiQsvZqBs6/e5nhDWZB1AItV
 U8MJg2E733lKvHsWsYvc/4PDZ1t2e/Smd1u09n+LeuXOg4Y4OLkmRVpwVyptbunYr32iPGvPB515T
 BJuyiljA==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1x3KDx-00116q-2I
 for dri-devel@lists.freedesktop.org; Sun, 06 Sep 2026 21:16:25 +0000
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso3116894b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 14:16:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwjrnV5JBJJVZqJrFfQk4e1YVq/1PV3rT0gc4VybqtEPk0YRM/HFHiYVhedKIUO5U2TimLrSbqyVPY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXjZKL5cnDrC3scOuR6FyTiF5+k1E+l6Bmn9Q1zLhMI9CsSnF9
 xSJiql37izod6LgisAWvP5VkwjiYXdHEgkjMQqkEU3y2LEf4jEynDjdBxUjkrVp1xXn4VnQ+7ew
 oysKBtJZNSzobhpiT26gbsmaC1c53T8Y=
X-Received: by 2002:a05:6a00:c206:b0:851:d12e:389b with SMTP id
 d2e1a72fcca58-8628622c78fmr14582711b3a.14.1788729379886; Sun, 06 Sep 2026
 14:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
 <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
 <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
 <cb0884b3-c9be-4cfd-ba43-27add3821ddd@murena.io>
 <6a5f8c11a092cef83bae8d9ea0100c2fc133a514.camel@icenowy.me>
In-Reply-To: <6a5f8c11a092cef83bae8d9ea0100c2fc133a514.camel@icenowy.me>
From: Dominique Belhachemi <domibel@debian.org>
Date: Sun, 6 Sep 2026 17:16:08 -0400
X-Gmail-Original-Message-ID: <CAAvaLCxMntrTbTQ9VNu4H_6LA30TRAqi7mCpn+x3hbTG9WqERA@mail.gmail.com>
X-Gm-Features: AcwNN1W3Ei1cx4_W0731mEUNvW6xw1POICbdb9C66iM9zFCtDZzsTbla6YfIM_c
Message-ID: <CAAvaLCxMntrTbTQ9VNu4H_6LA30TRAqi7mCpn+x3hbTG9WqERA@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Maud Spierings <maud_spierings@murena.io>,
 Dominique Belhachemi <domibel@debian.org>, 
 m.wilczynski@samsung.com, Laurent.pinchart@ideasonboard.com, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Debian-User: domibel
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

On Sun, Sep 6, 2026 at 11:19=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2026-09-06=E6=97=A5=E7=9A=84 16:59 +0200=EF=BC=8CMaud Spierings=
=E5=86=99=E9=81=93=EF=BC=9A
> > On 9/6/26 07:39, Dominique Belhachemi wrote:
> > > On Sun, Aug 30, 2026 at 10:17=E2=80=AFAM Maud Spierings
> > > <maud_spierings@murena.io <mailto:maud_spierings@murena.io>> wrote:
> > >
> > >     I was still having some glitching happening on the display, but
> > > I've
> > >     found the way to fix that, the question is what is actually
> > >     happening here.
> > >
> > >         0x29590020 <- 0x00000005
> > >     This one I have no idea, it is 0x00000009 with this patch
> > > series but
> > >     with the vendor kernel I get the value above. When I hook up my
> > >     external
> > >     display (regular 1440p) this becomes 0x0000000D on the vendor
> > > kernel.
> > >
> > >     But I can't find this register being written to anywhere there?
> > >
> > >
> > > Maybe this needs to be swapped?
> > >
> > > drivers/gpu/drm/bridge/inno-hdmi.c
> > >    -#define v_HSYNC_POLARITY(n)          ((n) << 3)
> > >    -#define v_VSYNC_POLARITY(n)          ((n) << 2)
> > >    +#define v_HSYNC_POLARITY(n)          ((n) << 2)
> > >    +#define v_VSYNC_POLARITY(n)          ((n) << 3)
>
> Very weirdly, the original definition here matches current mainline
> inno-hdmi.c, but the changed definition matches JH7110 vendor
> inno_hdmi.h [1].
>

The vendor code is correct and matches the RK3128 TRM.

HDMI_reg08
    Bit  Attr  Reset  Description
    3    RW    0x0    vs_polarity   VSYNC polarity   1'b0: Negative
1'b1: Positive
    2    RW    0x0    hs_polarity   HSYNC polarity   1'b0: Negative
1'b1: Positive

Nobody noticed this so far because in 720p/1080p both polarities are
positive, but Maud's 3:2 panel has differing H/V polarity.

Best
-Dominique
