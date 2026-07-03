Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0DDC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF3810E64E;
	Fri,  3 Jul 2026 16:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="P7GJt/29";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F3C10E64E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Cs75p+IM1gwfpKthc4TEByeHqgqGfc4z5ObGktLZjdY=; b=P7GJt/29oVsv5I7SJHYT0CN4RH
 mAFDRwiTLxmI3sztsWqfDq2nvN+eB0y2pLHeQFVUjhkrbecEWh5ASwNITjia1JVtzf8mFnGF0O96H
 FHogpOEvJlg5FgzB3d+9UqaToTkFIa7OHMHnK9p4MRx9IdJWgV09+HseUqdq/xc6mm9ZJcHZDaXH3
 fa3ZYaj59NiM0B2akAbqIdDKr/OaM35cFw6JprEnngN159dzKqk8m+jVy9XVsQSaOrxGL3FgGJDlZ
 Mgjip2xWHT+neyMXruRTp9dqk10Anw8C6lBRjbHZ+LqZg7wCOAmpto0WpRBfEVaXgF9UNFzz4bEla
 /cvslYPw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Diederik de Haas <diederik@cknow-tech.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: display: vop2: Add missing reset
 properties
Date: Fri, 03 Jul 2026 18:37:45 +0200
Message-ID: <8183064.gsGJI6kyIV@diego>
In-Reply-To: <fe8038fe-940a-4c61-a551-082534ef9c51@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <DJC0L3CRJ0WL.IZEYVLPROMM1@cknow-tech.com>
 <fe8038fe-940a-4c61-a551-082534ef9c51@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Donnerstag, 18. Juni 2026, 10:39:14 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Cristian Ciocaltea:
> Hi Diederik,
>=20
> On 6/18/26 10:58 AM, Diederik de Haas wrote:
> > Hi Cristian,
> >=20
> > Thanks for this series :-) Just 1 nit (at the end) ...
> >=20
> > On Wed Jun 17, 2026 at 8:52 PM CEST, Cristian Ciocaltea wrote:
> >> Document the VOP2 resets corresponding to the AXI, AHB and DCLK_VP0..2
> >> clocks, which are common to all supported SoCs, plus DCLK_VP3 which is
> >> provided only on RK3588.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  .../bindings/display/rockchip/rockchip-vop2.yaml   | 42 +++++++++++++=
+++++++++
> >>  1 file changed, 42 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockch=
ip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-=
vop2.yaml
> >> index 93da1fb9adc4..d3bc5380f910 100644
> >> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2=
=2Eyaml
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2=
=2Eyaml
> [...]
>=20
> >> @@ -289,6 +321,16 @@ examples:
> >>                                "dclk_vp0",
> >>                                "dclk_vp1",
> >>                                "dclk_vp2";
> >> +                resets =3D <&cru SRST_A_VOP>,
> >> +                         <&cru SRST_H_VOP>,
> >> +                         <&cru SRST_VOP0>,
> >> +                         <&cru SRST_VOP1>,
> >> +                         <&cru SRST_VOP2>;
> >> +                reset-names =3D "axi",
> >> +                              "ahb",
> >> +                              "dclk_vp0",
> >> +                              "dclk_vp1",
> >> +                              "dclk_vp2";
> >>                  power-domains =3D <&power RK3568_PD_VO>;
> >=20
> > Place reset* props below power-domains (like in patch 9) ?
> > So everyone who copies your example has the correct sorting order.
>=20
> The example doesn't strictly follow that ordering either =E2=80=94 see e.=
g. the iommus
> property =E2=80=94 so I placed the resets right after the clocks, which k=
eeps the
> related properties grouped together.
>=20
> That said, I don't have a strong preference.=20
>=20
> Heiko, is there a convention you'd like the Rockchip bindings to follow h=
ere?
> Happy to reorder if so.

Please just use standard devicetree ordering, as described in the
documentation. We generally don't want to invent new diverging things :-)


Heiko


