Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7930FC79F99
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 05:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793AB10E149;
	Sun,  6 Sep 2026 05:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="dMPDE9go";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA5910E149
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 05:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XNrHx4Upf3LGVb4PTN5XMtiFQEIxpVoq70soYt51daM=; b=dMPDE9gogc6/lvmQn4aEfWRsi2
 YE//n1WzhsvzE4NGNt8gEq4PsndXi8BT4NPyyjpw4J7Swljx0MAWda/Ry6a3TnROeYhFGaKB8JEOq
 13CJYPc1T5fy5x56XNFR/gGKzm+SlzulYbKTtI2B4ZEY99au5F6qJTm6L78q2dfG+eAjVdZ918m0c
 DoWX8Z40zfnI1rzYZCpSXr1j4VHEKr/kwx8H4R0f+3C4N2kpdM/gJmT6ALr9EWiickvtK/S1a/3UL
 DjcYVAtxrGDSJYC4eu9cuCHRQERCSfe1PBHFyai+rubBbqGKB9Ig5oLIARdz6xXqVRaKVSdDfGS9+
 4OMm09sg==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1x35bW-000W4w-1k
 for dri-devel@lists.freedesktop.org; Sun, 06 Sep 2026 05:39:46 +0000
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-85c9a79590aso2339422b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 22:39:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBx90aD/JR9qe/b7DRkKUtYB77MjfwjMO1PBBr8S5VU91T/pwtB70WrL4pF6/jzQTP96KTaeEFbQya0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m61io3h327C+K3vEdkL8o432abYsktPk5y27Afpg4tcb8595p2
 OArmc2i1yeVoe5QZEm7HoCI6SnaKD8CQ9Ou3x2pVh7gpkbzxzGIpcfWuHR0EDnjW5bNx6XqjFyd
 8WKQ4vvb7itbFlf+b/ElQS46ZSxzcA/U=
X-Received: by 2002:a05:6a00:1709:b0:853:6571:9567 with SMTP id
 d2e1a72fcca58-861677b29a7mr20351433b3a.4.1788673180168; Sat, 05 Sep 2026
 22:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
 <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
In-Reply-To: <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
From: Dominique Belhachemi <domibel@debian.org>
Date: Sun, 6 Sep 2026 01:39:28 -0400
X-Gmail-Original-Message-ID: <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
X-Gm-Features: AcwNN1XU5dZr4B1cOkPHnMBeZ1V1PqcFfCYm5xFvZBoKWraKXGGHEE6uL-rzD08
Message-ID: <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: Maud Spierings <maud_spierings@murena.io>
Cc: m.wilczynski@samsung.com, Laurent.pinchart@ideasonboard.com, 
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
 sboyd@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, uwu@icenowy.me, 
 vkoul@kernel.org
Content-Type: multipart/alternative; boundary="00000000000085f52d065ac9eda4"
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

--00000000000085f52d065ac9eda4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 10:17=E2=80=AFAM Maud Spierings <maud_spierings@mur=
ena.io>
wrote:

> I was still having some glitching happening on the display, but I've
> found the way to fix that, the question is what is actually happening her=
e.
>
>    0x29590020 <- 0x00000005
> This one I have no idea, it is 0x00000009 with this patch series but
> with the vendor kernel I get the value above. When I hook up my external
> display (regular 1440p) this becomes 0x0000000D on the vendor kernel.
>
> But I can't find this register being written to anywhere there?
>
>
Maybe this needs to be swapped?

drivers/gpu/drm/bridge/inno-hdmi.c
  -#define v_HSYNC_POLARITY(n)          ((n) << 3)
  -#define v_VSYNC_POLARITY(n)          ((n) << 2)
  +#define v_HSYNC_POLARITY(n)          ((n) << 2)
  +#define v_VSYNC_POLARITY(n)          ((n) << 3)

--00000000000085f52d065ac9eda4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Sun, Aug 30, 2026 at 10:17=E2=80=AFAM Maud Spierings &lt;<a href=3D"=
mailto:maud_spierings@murena.io">maud_spierings@murena.io</a>&gt; wrote:</s=
pan></div><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">I was still having some glitching happeni=
ng on the display, but I&#39;ve <br>
found the way to fix that, the question is what is actually happening here.=
<br><br>
=C2=A0 =C2=A00x29590020 &lt;- 0x00000005<br>
This one I have no idea, it is 0x00000009 with this patch series but <br>
with the vendor kernel I get the value above. When I hook up my external <b=
r>
display (regular 1440p) this becomes 0x0000000D on the vendor kernel.<br>
<br>
But I can&#39;t find this register being written to anywhere there?<br>
<br></blockquote><div><br></div><div>Maybe this needs to be swapped?</div><=
br>drivers/gpu/drm/bridge/inno-hdmi.c<br>=C2=A0 -#define v_HSYNC_POLARITY(n=
) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((n) &lt;&lt; 3)<br>=C2=A0 -#define v_V=
SYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((n) &lt;&lt; 2)<br>=C2=
=A0 +#define v_HSYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((n) &lt=
;&lt; 2)<br>=C2=A0 +#define v_VSYNC_POLARITY(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0((n) &lt;&lt; 3)<br><div><br></div></div></div>

--00000000000085f52d065ac9eda4--
