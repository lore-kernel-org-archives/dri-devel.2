Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C3606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=dxdnf1tU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65FA10E98D;
	Wed, 11 Nov 2026 15:36:58 +0000 (UTC)
X-Greylist: delayed 18585 seconds by postgrey-1.36 at gabe;
 Wed, 11 Nov 2026 15:36:52 UTC
Received: from sender6-pp-e106.zoho.com (sender6-pp-e106.zoho.com
 [165.173.180.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3E510F136
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794411407; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DX/IsIaBVZXylZ/Jwnp0NZE8RSGRsJlESrHEhffSHS/5GENMZ6v/5mjFgTKIufzEMOUK0PB0w8oJmQLIy21JMhwIDtufnKqQd1a9WHi/NuZbrubZgaF/fCWv3bgLFB84zvtVjQRC7yBBIFy4G8rFzMD/equE7zwJrnkpS+wEbK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794411407;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cXcdL4RZkRanD7v6ytYiFI+7QElAQaeTLZZui243kdY=; 
 b=kWvTSObDt0NBbPPIV3TcQjYHSpoTlrfiRVZoCP+loOw6kU0oeUCcQdj+402hsas8i4KrP4lL/nm/TKTHOInPLj8BmzOVcAbQhPXSXZcJJGvIQttCgAJSY5N6egvV1zV1MgQRlFKmp+v31Qco9voXY1ULjm1htgx4Ag00o23Kfs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: a=rsa-sha256;
 b=dxdnf1tUvtmfd8NCGQ4jY2u8KeigYZZdannJxSknt4wTNUENqBjXFcImw/bT4G5G1sK2PJCHaTHWjHVGbKa2tIb0wcH5ILoWbElbiZvAsHEEORtxM8uLwKOQKulRnPDa8Ov1dX7ppVnHxrshnbwPB03LVhVfZ4XOoAlzNkUtJl+8msLAeXCM6mRVEgJEcL8i5syHaBm75z5m0rjpjPZh1xgjhU6RRhHLrGTEt8AGSQ07FD+8UPB8AnlAS6uFYQPgO4/y8yA4mpmi6pweK4oK+hnV7W+bbdctHhqo/6nDCzqUlrjJ2nLHFCSSZhtyGHqFKM3XjF7qnrVEQolZmzo5Cg==;
 c=relaxed/relaxed; s=zmail2; d=icenowy.me; v=1;
 bh=cXcdL4RZkRanD7v6ytYiFI+7QElAQaeTLZZui243kdY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794411405388314.12732903469475; 
 Wed, 11 Nov 2026 07:36:45 -0800 (PST)
Message-ID: <fe657d0fb030632683705b7a9637d50782dd8acb.camel@icenowy.me>
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
Date: Wed, 11 Nov 2026 23:36:37 +0800
In-Reply-To: <aac5e0a0-754a-4323-9417-cc17d7d42930@kernel.org>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
 <20261109160706.2272332-2-romain.tisserand@gmail.com>
 <20261110-comical-adder-from-saturn-8c8fbb@quoll>
 <aac5e0a0-754a-4323-9417-cc17d7d42930@kernel.org>
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

=E5=9C=A8 2026-11-10=E4=BA=8C=E7=9A=84 13:48 +0100=EF=BC=8CKrzysztof Kozlow=
ski=E5=86=99=E9=81=93=EF=BC=9A
> On 10/11/2026 13:00, Krzysztof Kozlowski wrote:
> > On Mon, Nov 09, 2026 at 05:07:04PM +0100, Romain TISSERAND wrote:
> > > The panel is a MIPI-DSI peripheral, a child node of its DSI host,
> > > and the
> > > driver does not use a graph port. A port is only needed when the
> > > host
> > > links its panel through the graph; other DSI hosts, such as the
> > > Allwinner
> > > sun6i-a31-mipi-dsi one, link the child node and have no output
> > > port to
> > > point at. The PinePhone panel is described that way on the same
> > > host,
> > > without a port.
> > >=20
> > > Keep the port allowed (panel-common) but no longer required, as
> > > for other
> > > DSI panels such as ilitek,ili9881c.
> >=20
> > ilitek,ili7807s and a few others have the same and it is confusing.
> > The
> > port should be required when this is connected over SPI or I2C, but
> > not
> > for MIPI DSI. I think that for MIPI DSI port is meaningless so
> > actually
> > incorrect.
> >=20
> > Why was it added in the first place?
> >=20
>=20
> However won't all DRM drivers actually require panel? see
> b089c0a9b14c
> and 169466d4e59c which removed fallback to the child node.

The sun6i-mipi-dsi driver just tries to acquire a panel with the MIPI
DSI downstream device OF node using of_drm_find_panel().

Well I start to doubt whether a bridge would work in this case now.

Thanks,
Icenowy

>=20
> Best regards,
> Krzysztof
