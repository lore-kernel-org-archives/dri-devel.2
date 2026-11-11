Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3C606A330
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=orInLMA2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CA510E9D8;
	Wed, 11 Nov 2026 10:50:32 +0000 (UTC)
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com
 [165.173.182.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EE010E9D8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794394220; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DvrtU2o00B0Y2Jj4/kXnw4llxFrSJJMmeFG6gkdPfdM3rU0vM4hti+ddaaby6HYH3Tro/hvlt19vWpUaLhZME9jwOjJgZiL0bWZEnpu/4Ug7hTKkgLbwKnYJBQ+p92b+l0pC+Q3S31J9q0BJsvjJtHCtop8t40oyQblxcagPEyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794394220;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nqwOqzySF41xP+3vbWTy+4PqTdvp+LYNGH4DxM7B10o=; 
 b=FQbLI2IQ6aLuocLskqU8GiwCUZG7E/eg4QpVeyB0pe7vzgXUfXym1GfjaMN6qCpcObn0k/jgabQB72qvjXyZbnBOJrepUqD1bfWpXTI2maXvAD9gs0rZuA+SLmQ2S/3rbwhRAVgVkrpkubSFQEou1KqCV1hilmxCtCMuy28FSUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: a=rsa-sha256;
 b=orInLMA2EkgsgLOrC4la/lkznRmTWyN4xG04Nb3b2qOmWvd1X8XdWpYL38B+BJCim0ILDNBCOcIYVchcJgUtYJJ9VqHZcLFgeLeI6UicTjwdUFiVM5gfxHvbn7/LY4MXJ0J/BNW5Soni89LXTsM4ITYkg6l+8UQQ0xtpI7HSW4VNlmaX+z353jp0r4cHm7Td+1ML0mkysmken5ZrIbpx1FnO6LidHOm4tJiv+E2yk73bFctpEucirZRKzn4p9/CwTefC85PEKlZwmzJzwNfhZ8NfpWWa8umE6/OGCV0al45PyxFILyrGf5d90wRhj6lljdoLDQ7M0BDXOXaroh1H8A==;
 c=relaxed/relaxed; s=zmail2; d=icenowy.me; v=1;
 bh=nqwOqzySF41xP+3vbWTy+4PqTdvp+LYNGH4DxM7B10o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794394218186406.20269284396034; 
 Wed, 11 Nov 2026 02:50:18 -0800 (PST)
Message-ID: <7567f858b5a4e1a5ae59b73385f731180b721747.camel@icenowy.me>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: ilitek, ili9488:
 make the port optional
From: Icenowy Zheng <uwu@icenowy.me>
To: Krzysztof Kozlowski <krzk@kernel.org>, Romain TISSERAND
 <romain.tisserand@gmail.com>
Cc: Igor Reznichenko <igor@reznichenko.net>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, 	dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Date: Wed, 11 Nov 2026 18:50:10 +0800
In-Reply-To: <5398114b-538c-4e7a-9b36-35029f301630@kernel.org>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
 <20261109160706.2272332-2-romain.tisserand@gmail.com>
 <20261110-comical-adder-from-saturn-8c8fbb@quoll>
 <68b5a51d767248a71c050110d5faf6c50c964d50.camel@icenowy.me>
 <5398114b-538c-4e7a-9b36-35029f301630@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-11=E4=B8=89=E7=9A=84 11:28 +0100=EF=BC=8CKrzysztof Kozlow=
ski=E5=86=99=E9=81=93=EF=BC=9A
> On 11/11/2026 11:26, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-11-10=E4=BA=8C=E7=9A=84 13:00 +0100=EF=BC=8CKrzysztof Ko=
zlowski=E5=86=99=E9=81=93=EF=BC=9A
> > > On Mon, Nov 09, 2026 at 05:07:04PM +0100, Romain TISSERAND wrote:
> > > > The panel is a MIPI-DSI peripheral, a child node of its DSI
> > > > host,
> > > > and the
> > > > driver does not use a graph port. A port is only needed when
> > > > the
> > > > host
> > > > links its panel through the graph; other DSI hosts, such as the
> > > > Allwinner
> > > > sun6i-a31-mipi-dsi one, link the child node and have no output
> > > > port
> > > > to
> > > > point at. The PinePhone panel is described that way on the same
> > > > host,
> > > > without a port.
> > > >=20
> > > > Keep the port allowed (panel-common) but no longer required, as
> > > > for
> > > > other
> > > > DSI panels such as ilitek,ili9881c.
> > >=20
> > > ilitek,ili7807s and a few others have the same and it is
> > > confusing.
> > > The
> > > port should be required when this is connected over SPI or I2C,
> > > but
> > > not
> > > for MIPI DSI. I think that for MIPI DSI port is meaningless so
> > > actually
> > > incorrect.
> >=20
> > I found that the dw-mipi-dsi common code (e.g. on Rockchip SoCs
> > with
> > dw_mipi_dsi-rockchip) would expect the panel to be connected via a
> > port
> > even if it's the child node of the DSI controller.
> >=20
> > Such an example is at arch/arm64/boot/dts/rockchip/rk3399-
> > pinephone-
> > pro.dts .
> >=20
>=20
> Yes, the same for Qualcomm. So I actually wonder who needs the change
> here.

I wonder too because I just created a MIPI DSI driver based on the dw-
mipi-dsi common code.

I think the different requirement between sun6i-mipi-dsi and dw-mipi-
dsi is=C2=A0exposing the implementation details of the corresponding
drivers. Maybe this should be eliminated, but this would be some big
work.

Thanks,
Icenowy

>=20
> Best regards,
> Krzysztof
