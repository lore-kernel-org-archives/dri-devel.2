Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF96606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=J9OSvhXi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C2210E194;
	Wed, 11 Nov 2026 10:42:16 +0000 (UTC)
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com
 [165.173.182.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF4710E194
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794392820; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X/HX67F92GhFRj7qyinZmwx/H96yrqVKh3qzZ20sgUcU7Bq1EzlL4LwKbanj16DaHIeAsfl1B+qcOUKXcizeVDto7mVnyPeb9dgTMese2SySaXW1ka1t9lhlN5Y+3CSRxekdfQgYz+oHyMlLSu0jRqR//hXS8AZbXWHAvWjoI0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794392820;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=izBfG5NYxgsrXHkibSx3HWmcn07W3wT6ndQmqom6GNQ=; 
 b=fwDqvphywJ3uYhLeRoF5hlcNDhVwtmYKj+nvlJei0yPlkZDg9A4tiAZKXH69aS5hneBpcZfV9cMpkqr9nOp23zSTyrLLRrN8YEby+YjzvNa3APgIz0pqTH/UC1hjuQV87+GimXIrKW594bKrR5Vbi3pkoloHftpi0cIplmKMhfc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: a=rsa-sha256;
 b=J9OSvhXiOr8lL3EQgkc/e/NNi3TnxQ3XlcIW5iQ8G8O4YIpzmpfsofd64NZF96sK6sewXhziyjoWP4mrKydKsJxgtjUpg2plbX4qatreUxLCiOELTmxBkVvc01H9QyYa6GM54yi/P/dU+zcWbFQIIN633UnCFgJ4GRxBmIgIc3mpxEXXdNxdsf74Nvk+CH7nUy6EL5EwtTsi9ih7WxFgsjBDvLUaN3jnfb+Vxy/NmmLDgKgqeJEk11+N8VYRGRJRlQMUh/809aREBoWNb3QBbvydxClqopz9L0FHDHbTFBwP/IGHUIFYf/LnxVdk2xdAxDAeih67xe8Q+Pa5XczMgw==;
 c=relaxed/relaxed; s=zmail2; d=icenowy.me; v=1;
 bh=izBfG5NYxgsrXHkibSx3HWmcn07W3wT6ndQmqom6GNQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794392818762580.4241612026577;
 Wed, 11 Nov 2026 02:26:58 -0800 (PST)
Message-ID: <68b5a51d767248a71c050110d5faf6c50c964d50.camel@icenowy.me>
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
Date: Wed, 11 Nov 2026 18:26:51 +0800
In-Reply-To: <20261110-comical-adder-from-saturn-8c8fbb@quoll>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
 <20261109160706.2272332-2-romain.tisserand@gmail.com>
 <20261110-comical-adder-from-saturn-8c8fbb@quoll>
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-10=E4=BA=8C=E7=9A=84 13:00 +0100=EF=BC=8CKrzysztof Kozlow=
ski=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Nov 09, 2026 at 05:07:04PM +0100, Romain TISSERAND wrote:
> > The panel is a MIPI-DSI peripheral, a child node of its DSI host,
> > and the
> > driver does not use a graph port. A port is only needed when the
> > host
> > links its panel through the graph; other DSI hosts, such as the
> > Allwinner
> > sun6i-a31-mipi-dsi one, link the child node and have no output port
> > to
> > point at. The PinePhone panel is described that way on the same
> > host,
> > without a port.
> >=20
> > Keep the port allowed (panel-common) but no longer required, as for
> > other
> > DSI panels such as ilitek,ili9881c.
>=20
> ilitek,ili7807s and a few others have the same and it is confusing.
> The
> port should be required when this is connected over SPI or I2C, but
> not
> for MIPI DSI. I think that for MIPI DSI port is meaningless so
> actually
> incorrect.

I found that the dw-mipi-dsi common code (e.g. on Rockchip SoCs with
dw_mipi_dsi-rockchip) would expect the panel to be connected via a port
even if it's the child node of the DSI controller.

Such an example is at arch/arm64/boot/dts/rockchip/rk3399-pinephone-
pro.dts .

Thanks,
Icenowy

>=20
> Why was it added in the first place?
>=20
> >=20
> > Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
> > Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
> > ---
> > =C2=A0.../devicetree/bindings/display/panel/ilitek,ili9488.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > 1 -
> > =C2=A01 file changed, 1 deletion(-)
>=20
> Reviewed-by: Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com>
>=20
> Best regards,
> Krzysztof
