Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2145AC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 04:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C6F10E447;
	Mon,  7 Sep 2026 04:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Hn4zdwaH";
	dkim-atps=neutral
X-Greylist: delayed 45773 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 04:01:36 UTC
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com
 [165.173.182.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70E010E447
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 04:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788753687; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GmgJfMtf8nKDYhL/y5mV/4bNYFhWRjAXbiCOMeLj8n/V5CVYE3TJ1oQO588JLThSNoXs8na/h1QQiGlk8/+UkubO+Y3+TagcA/M+XKS5XW7e8UO+EERfGt+CFRN2cgOTfHGaa5y/Hz9HvV/t9Xv3/0qNiVqnzm2F0qso+Rrq5/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788753687;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xZdWr5iB4U0Mel5njbzbHnomGSClIHf9G9kkOjT0NSU=; 
 b=gAyw2KHgApq0A7LXr3MDWUoBoRD3N40pFBbuVqSAkqPwV1VVR9Xr3y+abWyMyCrQhojcvppSuAKn2nCMjObobYLjsZuvyDDAp33Rrz5a9uYDI9iw8go7ImHwUgMVN9VVsUxqVZfyEffdmk+U7q3ECJMMVzlnl1J9fe7yI6m7p1o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788753687; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=xZdWr5iB4U0Mel5njbzbHnomGSClIHf9G9kkOjT0NSU=;
 b=Hn4zdwaHpLWdVp/Ei3bXX/qZRio3cEAZQvfZfTg6B82Ac1UI9c3R+SjyuZhHWm2z
 KjE2ZLockaaqR0Wnk+b9aMVd5YW9a9hYslb4deN4Ix282OVlt8E/hsSV3wOWwd/gm8a
 L6VA92ctg9YQAWWbSTeYTN7GuHu2HGlslRl93ANnPGveRb0S7XEdVXdYkl4SPFtkHFP
 1fLCF3VScGAQ4Y4U1IsnnxD2aofdFAkVyMDRymBcTphtpwQeoSh/9GGrlg9xR2wmYIF
 XBVoHp3k3yRADdslVz22o36V7Taaln1IDrWJLknqDvDj84p4TZKtj9Gydz37ymyiWQ1
 hPPMnogHww==
Received: by mx.zohomail.com with SMTPS id 1788753684704244.47592390011243;
 Sun, 6 Sep 2026 21:01:24 -0700 (PDT)
Message-ID: <057d97bd4b63fa4445dd86548f2ecdcbe9c3b1b6.camel@icenowy.me>
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Dominique Belhachemi <domibel@debian.org>
Cc: Maud Spierings <maud_spierings@murena.io>, m.wilczynski@samsung.com, 
 Laurent.pinchart@ideasonboard.com, airlied@gmail.com, alex@ghiti.fr, 
 andrzej.hajda@intel.com, andy.yan@rock-chips.com, andyshrk@163.com, 
 aou@eecs.berkeley.edu, bmasney@redhat.com, conor+dt@kernel.org,
 conor@kernel.org, 	devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	hal.feng@starfivetech.com,
 heiko@sntech.de, hello@big-grey.co.uk, 	jernej.skrabec@gmail.com,
 jonas@kwiboo.se, kernel@esmil.dk, krzk+dt@kernel.org, 	lee@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 luca.ceresoli@bootlin.com, m.szyprowski@samsung.com, 
 maarten.lankhorst@linux.intel.com, maudspierings@gocontroll.com, 
 mfd@lists.linux.dev, mripard@kernel.org, mturquette@baylibre.com, 
 neil.armstrong@linaro.org, p.zabel@pengutronix.de, palmer@dabbelt.com, 
 pjw@kernel.org, rfoss@kernel.org, robh@kernel.org, sboyd@kernel.org,
 simona@ffwll.ch, 	tzimmermann@suse.de, vkoul@kernel.org
Date: Mon, 07 Sep 2026 12:01:13 +0800
In-Reply-To: <CAAvaLCxMntrTbTQ9VNu4H_6LA30TRAqi7mCpn+x3hbTG9WqERA@mail.gmail.com>
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
 <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
 <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
 <cb0884b3-c9be-4cfd-ba43-27add3821ddd@murena.io>
 <6a5f8c11a092cef83bae8d9ea0100c2fc133a514.camel@icenowy.me>
 <CAAvaLCxMntrTbTQ9VNu4H_6LA30TRAqi7mCpn+x3hbTG9WqERA@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-09-06=E6=97=A5=E7=9A=84 17:16 -0400=EF=BC=8CDominique Belhac=
hemi=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Sep 6, 2026 at 11:19=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wr=
ote:
> >=20
> > =E5=9C=A8 2026-09-06=E6=97=A5=E7=9A=84 16:59 +0200=EF=BC=8CMaud Spierin=
gs=E5=86=99=E9=81=93=EF=BC=9A
> > > On 9/6/26 07:39, Dominique Belhachemi wrote:
> > > > On Sun, Aug 30, 2026 at 10:17=E2=80=AFAM Maud Spierings
> > > > <maud_spierings@murena.io=C2=A0<mailto:maud_spierings@murena.io>>
> > > > wrote:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 I was still having some glitching happening on t=
he display,
> > > > but
> > > > I've
> > > > =C2=A0=C2=A0=C2=A0 found the way to fix that, the question is what =
is actually
> > > > =C2=A0=C2=A0=C2=A0 happening here.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x29590020 <- 0x00000005
> > > > =C2=A0=C2=A0=C2=A0 This one I have no idea, it is 0x00000009 with t=
his patch
> > > > series but
> > > > =C2=A0=C2=A0=C2=A0 with the vendor kernel I get the value above. Wh=
en I hook
> > > > up my
> > > > =C2=A0=C2=A0=C2=A0 external
> > > > =C2=A0=C2=A0=C2=A0 display (regular 1440p) this becomes 0x0000000D =
on the
> > > > vendor
> > > > kernel.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 But I can't find this register being written to =
anywhere
> > > > there?
> > > >=20
> > > >=20
> > > > Maybe this needs to be swapped?
> > > >=20
> > > > drivers/gpu/drm/bridge/inno-hdmi.c
> > > > =C2=A0=C2=A0 -#define v_HSYNC_POLARITY(n)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((n) << 3)
> > > > =C2=A0=C2=A0 -#define v_VSYNC_POLARITY(n)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((n) << 2)
> > > > =C2=A0=C2=A0 +#define v_HSYNC_POLARITY(n)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((n) << 2)
> > > > =C2=A0=C2=A0 +#define v_VSYNC_POLARITY(n)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((n) << 3)
> >=20
> > Very weirdly, the original definition here matches current mainline
> > inno-hdmi.c, but the changed definition matches JH7110 vendor
> > inno_hdmi.h [1].
> >=20
>=20
> The vendor code is correct and matches the RK3128 TRM.

Thanks for the tips on documentation, and I verified this.

It seems that Rockchip people made this always wrong, even with their
pre-DRM display driver... [1]

BTW I checked the Innosilicon dGPU driver code, and its g3_ne_hdmi.h
source file also contains the definition of BIT(3) as VSYNC. (It's
quite weird that most logic of that driver is in some .o_shipped blob,
but fortunately the g3 logic might be too new to be closed down)

Thanks,
Icenowy

[1]
https://github.com/rockchip-linux/kernel/blob/release-4.4/drivers/video/roc=
kchip/hdmi/rockchip-hdmiv1/rockchip_hdmiv1_hw.h#L161

>=20
> HDMI_reg08
> =C2=A0=C2=A0=C2=A0 Bit=C2=A0 Attr=C2=A0 Reset=C2=A0 Description
> =C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0=C2=A0 RW=C2=A0=C2=A0=C2=A0 0x0=C2=A0=C2=
=A0=C2=A0 vs_polarity=C2=A0=C2=A0 VSYNC polarity=C2=A0=C2=A0 1'b0: Negative
> 1'b1: Positive
> =C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0 RW=C2=A0=C2=A0=C2=A0 0x0=C2=A0=C2=
=A0=C2=A0 hs_polarity=C2=A0=C2=A0 HSYNC polarity=C2=A0=C2=A0 1'b0: Negative
> 1'b1: Positive
>=20
> Nobody noticed this so far because in 720p/1080p both polarities are
> positive, but Maud's 3:2 panel has differing H/V polarity.
>=20
> Best
> -Dominique
