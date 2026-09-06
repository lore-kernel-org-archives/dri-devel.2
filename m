Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AC7C79F8B
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 03:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838FF10E2EE;
	Sun,  6 Sep 2026 03:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="PLdFdeRV";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5299C10E2EE
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 03:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=33/cz7U9W/HIwJHrk6unVB9Y9CrPF1+WoexolykuOCU=; b=PLdFdeRVFiFG6blot5ZjdNfIYI
 PMNRloC5ncsjvyFuhFZ4n9aCrbhRHFfHfE5fcG+ei2y45x4/gdOqz4eXvZI2SuogGT26S9v0I1O7w
 +x5pGtnWRFNgcfoVCYcOxBbKaxIttfKQdu7eyGPn8k63hdqPVXjJydMlVLPqrSZXT2fA1fJDuVw4o
 dM80MMEUVVMILJCBgb5qyVxN5+qO0EHxTfBFzW2M90V9Glo75v7QIY1nbc0YWd7AiVIPlfPAkHUFw
 RjsOO0dVsSXuFl2ft1YwMqigTlOsA45CnKj4a9bT/B6w4p58n4ivquvD3bBz7K0yw7HwxBdNJSDLp
 h/SuKSug==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1x33zD-000Sfk-0J
 for dri-devel@lists.freedesktop.org; Sun, 06 Sep 2026 03:56:07 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-863c229c3adso471347b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 20:56:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwjsKDaSfjwAYQLw3hKXKbFYymS2ByzxaPEYzmogUvu5ZsluJEPPB5ay3bNy0Zqanl4pakGLf98shY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQRcD/PeKn2voEyPW0FRBKjbuoloSeO/5s9hf+zML79cJ8c/Jo
 Kp+ZEwOSFhjosj6AdSBdnveGX0hAZ66QvkcT6HHTrJGspN5+uNjkzN1GfUCA0CjcTtM+kOyIgPh
 NJSymHhzlXAtTcmhg8ExRDYAJdzdaE3Y=
X-Received: by 2002:a05:6a00:950c:b0:855:74f7:40c2 with SMTP id
 d2e1a72fcca58-8616a36d628mr24011152b3a.14.1788666960527; Sat, 05 Sep 2026
 20:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20260904132708eucas1p1adfa26ef0fe5109eca63a3aeadf74915@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <ea529e06-2eab-4e3b-92af-ba17de44091c@murena.io>
In-Reply-To: <ea529e06-2eab-4e3b-92af-ba17de44091c@murena.io>
From: Dominique Belhachemi <domibel@debian.org>
Date: Sat, 5 Sep 2026 23:55:48 -0400
X-Gmail-Original-Message-ID: <CAAvaLCzU_-JdPHSSQS2HxGnrkRk+u_QOZ91SmxcC+nouubCtXA@mail.gmail.com>
X-Gm-Features: AcwNN1UM7ZJ6sXGcxz8w1ecwwmdIgyw_k45E71X-H4TbhmV6-v-9-GBgb5ExnVk
Message-ID: <CAAvaLCzU_-JdPHSSQS2HxGnrkRk+u_QOZ91SmxcC+nouubCtXA@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] drm: starfive: jh7110: Enable display subsystem
To: Maud Spierings <maud_spierings@murena.io>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Graham Markall <hello@big-grey.co.uk>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Content-Type: multipart/alternative; boundary="000000000000cdc96b065ac87a91"
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

--000000000000cdc96b065ac87a91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 1:21=E2=80=AFAM Maud Spierings <maud_spierings@muren=
a.io>
wrote:

> Hello Michal,
>
> This new version added some more issues on my fml13v01 board, this time
> 2 registers in the VOUT_CRG are misconfigured that were correct in v2,
> namely:
>
> 0x295c0004 was 0x00000004 on the previous version but is now 0x00000006
> 0x295c001c was 0x81000000 on the previous version but is now 0x80000000
>
> xx04 sets a slightly different clock divider, but it doesn't seem to
> matter, display also works with this changed value.
>
> xx1c seems to select the wrong clock mux?
>
> After correcting 0x295c001c (and the ones that I mentioned before in the
> hdmitx block), the display comes to life again.
>
> Not sure why these are changed.
>
> Same here on a VisionFive 2. The dc8200_pix0 mux register (0x295c001c)
comes up 0x80000000 instead of 0x81000000 (which selects hdmitx0_pixelclk
from the PHY).

v3 added CLK_SET_RATE_NO_REPARENT to stop clk_set_rate() from silently
switching which clock feeds the display, but nothing then assigns the
parent,
so it is left on whatever the bootloader selected.

You could pin the two pixel-clock muxes to the HDMI PHY, is that acceptable=
?

dc8200: display@29400000 {
  +                             assigned-clocks =3D <&voutcrg
JH7110_VOUTCLK_DC8200_PIX0>,
  +                                               <&voutcrg
JH7110_VOUTCLK_DC8200_PIX1>;
  +                             assigned-clock-parents =3D <&hdmi_phy>,
<&hdmi_phy>;
};

I tested this on the vf2.

Best
-Dominique

--000000000000cdc96b065ac87a91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Sat, Sep 5, 2026 at 1:21=E2=80=AFAM Maud Spierings &lt;<a href=3D"ma=
ilto:maud_spierings@murena.io">maud_spierings@murena.io</a>&gt; wrote:</spa=
n></div><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hello Michal,<br>
<br>
This new version added some more issues on my fml13v01 board, this time <br=
>
2 registers in the VOUT_CRG are misconfigured that were correct in v2, <br>
namely:<br>
<br>
0x295c0004 was 0x00000004 on the previous version but is now 0x00000006<br>
0x295c001c was 0x81000000 on the previous version but is now 0x80000000<br>
<br>
xx04 sets a slightly different clock divider, but it doesn&#39;t seem to <b=
r>
matter, display also works with this changed value.<br>
<br>
xx1c seems to select the wrong clock mux?<br>
<br>
After correcting 0x295c001c (and the ones that I mentioned before in the <b=
r>
hdmitx block), the display comes to life again.<br>
<br>
Not sure why these are changed.<br><br></blockquote><div><span style=3D"bac=
kground-color:transparent">Same here on a VisionFive 2. The=C2=A0</span><sp=
an style=3D"background-color:transparent">dc8200_pix0 mux register (0x295c0=
01c)</span></div><div><span style=3D"background-color:transparent">comes up=
 </span><span style=3D"background-color:transparent">0x80000000=C2=A0</span=
><span style=3D"background-color:transparent">instead of 0x81000000 (which =
selects=C2=A0</span>hdmitx0_pixelclk from the PHY<span style=3D"background-=
color:transparent">).</span></div><div><br></div><div>v3 added CLK_SET_RATE=
_NO_REPARENT to stop clk_set_rate() from silently</div><div>switching=C2=A0=
<span style=3D"background-color:transparent">which clock feeds the display,=
=C2=A0</span><span style=3D"background-color:transparent">but nothing then =
assigns the parent,</span></div><div><span style=3D"background-color:transp=
arent">so it is left on whatever the bootloader selected.</span></div><div>=
<br></div><div>You could pin the two pixel-clock muxes to the HDMI PHY, is =
that acceptable?</div><div><br>dc8200: display@29400000 {<br>=C2=A0 + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 assigned-clocks =3D &lt;&amp;voutcrg JH7110_VOUTCLK_DC=
8200_PIX0&gt;,<br>=C2=A0 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;&amp;voutcrg JH7110_VOUTCLK_DC82=
00_PIX1&gt;;<br>=C2=A0 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assigned-clock-parents =3D=
 &lt;&amp;hdmi_phy&gt;, &lt;&amp;hdmi_phy&gt;;<br>};</div><div><br></div><d=
iv>I tested this=C2=A0on the vf2.</div><div><br></div><div>Best</div><div>-=
Dominique</div><div><br></div></div></div>

--000000000000cdc96b065ac87a91--
