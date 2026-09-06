Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C0C79F9F
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA4E10E3DE;
	Sun,  6 Sep 2026 15:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="jzAEdxks";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B5D10E3DE
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 15:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788707913; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ieCQabN8EQGpXXgECYodCz/ZWBOkqYLbzC0IAYMG8eiFuCymE52MFXM8XcT6yw39sVHBIc2qXnpsaVNw2sn4SSeLTcwBmMpWDsjggGIuvL0BodFvmlMmHh3DI+WnadXCEcpuLwct5OCPKQjaCpLS3L2vKFHX8ILaEEH5q1Uo+Bw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788707913;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=68YKKfbSFTtU2N7wERD+i3nPtQ0y2cRum0iBDFTHv+I=; 
 b=TEEpCx/b1ggvFyy06XzGaMbNMSzL3Ih8lcq69dr3LzhH4NfQtlm+qC/5NnaXvUWQGG8GnayoaudlRlMZFVEHGWH/q6QuAWKVLEzpHRMlAFc7V5nXD+CtW5vK5MJ63hQ+c8dqyh9/JXMwWiDP0NfnLEz1g/88RIYJE0h3d8NLPuw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788707913; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=68YKKfbSFTtU2N7wERD+i3nPtQ0y2cRum0iBDFTHv+I=;
 b=jzAEdxks3X3M2tjU7S5FuCIjaTDUi2qtrtP7DnXmOiMnbT5vFdOwzOCbCPMbWKFd
 AqKsFENq9fN5HGwqjXYuSfHrxGy6MiIXzb3vnOYn3nzwW+fuarkCTIU9wCTTGE6s7dK
 zAaUKxcwqTq4iUaFNNoYTk842WVM7mirHdmg6awrwY8XJ/eB3xIFc0o0enQj9Zl3yM/
 nbcOVOSCgfi8MC0mZIvUnwM80hrNWjqgvIHCUDS52pR0CkaMje0TKgVUzpp2WmiQoW7
 EB/H0s5j/mdyvhAKH+NZhmAd2zA/4zIfyCb7SDaeazKFS5Qg5Rw7hZUamsT52lO1IpZ
 oRuXG8vMBA==
Received: by mx.zohomail.com with SMTPS id 1788707909777230.01672967805905;
 Sun, 6 Sep 2026 08:18:29 -0700 (PDT)
Message-ID: <6a5f8c11a092cef83bae8d9ea0100c2fc133a514.camel@icenowy.me>
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Maud Spierings <maud_spierings@murena.io>, Dominique Belhachemi
 <domibel@debian.org>
Cc: m.wilczynski@samsung.com, Laurent.pinchart@ideasonboard.com, 
 airlied@gmail.com, alex@ghiti.fr, andrzej.hajda@intel.com,
 andy.yan@rock-chips.com, 	andyshrk@163.com, aou@eecs.berkeley.edu,
 bmasney@redhat.com, conor+dt@kernel.org, 	conor@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 hal.feng@starfivetech.com, heiko@sntech.de, hello@big-grey.co.uk, 
 jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@esmil.dk,
 krzk+dt@kernel.org, 	lee@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, 	linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, 	luca.ceresoli@bootlin.com,
 m.szyprowski@samsung.com, 	maarten.lankhorst@linux.intel.com,
 maudspierings@gocontroll.com, 	mfd@lists.linux.dev, mripard@kernel.org,
 mturquette@baylibre.com, 	neil.armstrong@linaro.org,
 p.zabel@pengutronix.de, palmer@dabbelt.com, 	pjw@kernel.org,
 rfoss@kernel.org, robh@kernel.org, sboyd@kernel.org, simona@ffwll.ch, 
 tzimmermann@suse.de, vkoul@kernel.org
Date: Sun, 06 Sep 2026 23:18:11 +0800
In-Reply-To: <cb0884b3-c9be-4cfd-ba43-27add3821ddd@murena.io>
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
 <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
 <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
 <cb0884b3-c9be-4cfd-ba43-27add3821ddd@murena.io>
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

=E5=9C=A8 2026-09-06=E6=97=A5=E7=9A=84 16:59 +0200=EF=BC=8CMaud Spierings=
=E5=86=99=E9=81=93=EF=BC=9A
> On 9/6/26 07:39, Dominique Belhachemi wrote:
> > On Sun, Aug 30, 2026 at 10:17=E2=80=AFAM Maud Spierings=20
> > <maud_spierings@murena.io=C2=A0<mailto:maud_spierings@murena.io>> wrote=
:
> >=20
> > =C2=A0=C2=A0=C2=A0 I was still having some glitching happening on the d=
isplay, but
> > I've
> > =C2=A0=C2=A0=C2=A0 found the way to fix that, the question is what is a=
ctually
> > =C2=A0=C2=A0=C2=A0 happening here.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A00x29590020 <- 0x00000005
> > =C2=A0=C2=A0=C2=A0 This one I have no idea, it is 0x00000009 with this =
patch
> > series but
> > =C2=A0=C2=A0=C2=A0 with the vendor kernel I get the value above. When I=
 hook up my
> > =C2=A0=C2=A0=C2=A0 external
> > =C2=A0=C2=A0=C2=A0 display (regular 1440p) this becomes 0x0000000D on t=
he vendor
> > kernel.
> >=20
> > =C2=A0=C2=A0=C2=A0 But I can't find this register being written to anyw=
here there?
> >=20
> >=20
> > Maybe this needs to be swapped?
> >=20
> > drivers/gpu/drm/bridge/inno-hdmi.c
> > =C2=A0=C2=A0 -#define v_HSYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0((n) << 3)
> > =C2=A0=C2=A0 -#define v_VSYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0((n) << 2)
> > =C2=A0=C2=A0 +#define v_HSYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0((n) << 2)
> > =C2=A0=C2=A0 +#define v_VSYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0((n) << 3)

Very weirdly, the original definition here matches current mainline
inno-hdmi.c, but the changed definition matches JH7110 vendor
inno_hdmi.h [1].

Some weird must happened.

Thanks,
Icenowy


[1]
https://github.com/DC-DeepComputing/fml13v01-linux/blob/97c64fe2832b6826914=
b6da7aa4febcdd4d3d444/drivers/gpu/drm/verisilicon/inno_hdmi.h

> >=20
>=20
> Those seem to only be relevant the 0x08 register:
> =C2=A0> #define HDMI_VIDEO_TIMING_CTL		0x08
>=20
> also in the code:
>=20
> =C2=A0> /* Set detail external video timing polarity and interlace mode *=
/
> =C2=A0> value =3D v_EXTERANL_VIDEO(1);
> =C2=A0> value |=3D mode->flags & DRM_MODE_FLAG_PHSYNC ?
> =C2=A0>=C2=A0	 v_HSYNC_POLARITY(1) : v_HSYNC_POLARITY(0);
> =C2=A0> value |=3D mode->flags & DRM_MODE_FLAG_PVSYNC ?
> =C2=A0>=C2=A0	 v_VSYNC_POLARITY(1) : v_VSYNC_POLARITY(0);
> =C2=A0> value |=3D mode->flags & DRM_MODE_FLAG_INTERLACE ?
> =C2=A0>=C2=A0	 v_INETLACE(1) : v_INETLACE(0);
> =C2=A0> hdmi_writeb(hdmi, HDMI_VIDEO_TIMING_CTL, value);
