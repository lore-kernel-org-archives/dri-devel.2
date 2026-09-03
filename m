Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AF7C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5B210E0ED;
	Thu,  3 Sep 2026 12:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="hTGjefJu";
	dkim-atps=neutral
X-Greylist: delayed 1019 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 12:25:00 UTC
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com
 [165.173.180.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6A210E0ED
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788437392; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zc6xuJ3xl49VRPhcniB/3ZakchN1aZhf0cfhA9pujCw8BTWIBbuOJNaEZD7FBgBuMmflkIaIj0t/I1Zr5MXrPnXM2ZVpY0kcXn7r1pBHlbdZK9sA3PGFsax4Sg4pYf7q6xx1TV6/7mt0FzHtTziNgdXNZco/t9RBvPg7KKaLJZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788437392;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=udLpqyCAmF5x6NjypD7ZgtL4WKgcLBmXurRxSamaIC8=; 
 b=VX8V98MFSDeLC7wSiSHo3oJo/P3uGJu3G+RCcjOqPG3lTkTQKWcS4997IRLXg5MqrSLEhW1eXMbaSXe+0iCCCRbDi+aJBIckRX9GYBrLTmek3+2RA6Ppo6eLZHtvWTQQCJXs2RSP316zCkNTCtChOYoNduQQdss0ssaYhgd6LX0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788437392; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=udLpqyCAmF5x6NjypD7ZgtL4WKgcLBmXurRxSamaIC8=;
 b=hTGjefJujyRPquMYHt1PxDjFJRQiLBSiwixit7f44eOGk/AkBVY7n+YwleID99bG
 SXjZo446kyxFCFYE5T7XX3whUoRj5fh9RteO+romCHm3gMD/o8HfCe8nhTXDAJ+Ss3G
 Cztc9JEW5MTmjIYsLxV2Jfb86fEKSiIc2LtdvEcMRutiARlEeyhQtcf1UYCVQnTHqn2
 1sJ1Pnq5vW46tfI/a9JqouniyOcZDn98v/P0tU8iz/w/Z4YCtm7E00zcIIdJVuSqzgl
 WY/s/rRSl6bZlTxkrFZYdN2EXPX1fiTpaNizRi1NSLxKNV0zNvZ5aPR7GpFJnokQbU9
 Rb8Jd0Klzg==
Received: by mx.zohomail.com with SMTPS id 1788437390405973.4421037897633;
 Thu, 3 Sep 2026 05:09:50 -0700 (PDT)
Message-ID: <576146d4f2752c3c3f6ec6c42812cb9956406383.camel@icenowy.me>
Subject: Re: [PATCH v2 15/17] riscv: dts: spacemit: k3-pico-itx: enable the
 DisplayPort output
From: Icenowy Zheng <uwu@icenowy.me>
To: codykang.hk@gmail.com, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan	
 <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>, Michael
 Turquette	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney	 <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yao Zi
 <me@ziyao.cc>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <u.kleine-koenig@baylibre.com>, Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org
Date: Thu, 03 Sep 2026 20:09:42 +0800
In-Reply-To: <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
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

=E5=9C=A8 2026-08-09=E6=97=A5=E7=9A=84 21:14 +0800=EF=BC=8CCody Kang via B4=
 Relay=E5=86=99=E9=81=93=EF=BC=9A
> From: Cody Kang <codykang.hk@gmail.com>
>=20
> Pico-ITX brings the second DPU's output to an external DisplayPort
> connector. Enable that DPU and the DisplayPort controller it feeds.

The connector available on the Pico-ITX mainboard isn't a DisplayPort
port -- it's a USB Type-C port instead.

I think you need to model the Type-C port and alt functions of it.

Thanks,
Icenowy

>=20
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
>=20
> ---
> v2:
> - no change
> ---
> =C2=A0arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 11 +++++++++++
> =C2=A0arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi | 11 +++++++++++
> =C2=A02 files changed, 22 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> index b89c1521e6649..6c31460990a75 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -6,6 +6,7 @@
> =C2=A0#include <dt-bindings/gpio/gpio.h>
> =C2=A0
> =C2=A0#include "k3.dtsi"
> +#include "k3-display.dtsi"
> =C2=A0#include "k3-pinctrl.dtsi"
> =C2=A0
> =C2=A0/ {
> @@ -221,3 +222,13 @@ hub@1 {
> =C2=A0&usb2_phy {
> =C2=A0	status =3D "okay";
> =C2=A0};
> +
> +&dpu1_crtc0 {
> +	status =3D "okay";
> +};
> +
> +&dp1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&dp1_1_cfg>;
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> index 3ee1471f37985..2f36eba20f1ee 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> @@ -11,6 +11,17 @@
> =C2=A0#define K3_GPIO(x)	(x / 32) (x % 32)
> =C2=A0
> =C2=A0&pinctrl {
> +	/omit-if-no-ref/
> +	dp1_1_cfg: dp1-1-cfg {
> +		dp1-pins {
> +			pinmux =3D <K3_PADCONF(24, 6)>;	/* dp1 hpd
> */
> +
> +			bias-disable;
> +			drive-strength =3D <25>;
> +			power-source =3D <3300>;
> +		};
> +	};
> +
> =C2=A0	gmac0_rgmii_0_cfg: gmac0-rgmii-0-cfg {
> =C2=A0		gmac0-rgmii-0-pins {
> =C2=A0			pinmux =3D <K3_PADCONF(0, 1)>,	/*
> gmac0_rxdv */
