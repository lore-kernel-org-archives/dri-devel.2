Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E2606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=QpOOdE6D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFE010EA9F;
	Wed, 11 Nov 2026 15:57:02 +0000 (UTC)
Received: from sender5-pp-e106.zoho.com (sender5-pp-e106.zoho.com
 [165.173.182.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533F310FBF3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794412614; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DpqVUxcyN1oKz/4Wlh8tsoVR0bAE6bReI9Jai+qNkbUnnEsMyKovKk/xar2GGx0MH550F5mSARW2iYju0iJsE+vQ1beT/SVjqNC5lvHDmFAOZXXxz/g+utHNMbptAgC528xT7bbvE/tW4VsMYZd8q9uUYFDsP6BWjgd8GFowm1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794412614;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xDRi6AptpCzfUFXVJSMOxBZIzihFxm0gmUYR69jcYuo=; 
 b=IIL0iAVpgiBnabj1P6b2jm4yNcUq8aOBb3gP6YV7oHDHP/x0OFsunVqa7MPL7hoq+7laPpeEbIOyzN0akkqkFnU4CJSm4qJcHkdL/4tCAQHXseCPPsXAC4SXYebJD26+SkFdMABPfo5CnIBpzssVtOZVPjJb2QxSqL3bvLJ0CDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: a=rsa-sha256;
 b=QpOOdE6DzjcGGF0K/MH11GxBJTVqdcFSiLtp4w3KfVvfaK9NXjKLLwDKFn4pQ91LxGHxxYSfFk0f1jaXMirT86zbEklY9obLVYVMDYXQEnu9IgnY7QKZw/dsustnv6bsL70POsKeCY2hhL2LU4kCiwTsq5XmAUMKcemF4CsZQ1vMI+A8wfsNJV+LPL0ecMCEe2SMnSLZs47WK4+YfFUj6udB0BcHyZKH1uengeqFqF/y6PXn9FJkwVjIW+TqdbvyEdoqivvRZmTydJEOaO4RbRXP9bDgSmpjC0xflgB2Ns7JqJmNZYfJg6TZGnw9gyD9f6nS0VHf1mBXVWP4Yvzdzw==;
 c=relaxed/relaxed; s=zmail2; d=icenowy.me; v=1;
 bh=xDRi6AptpCzfUFXVJSMOxBZIzihFxm0gmUYR69jcYuo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794412612231901.0262834416521;
 Wed, 11 Nov 2026 07:56:52 -0800 (PST)
Message-ID: <968c395a22016056a29255d3a123eea8bd5c5c13.camel@icenowy.me>
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
From: Icenowy Zheng <uwu@icenowy.me>
To: Maxime Ripard <mripard@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Joel Selvaraj
 <jo@jsfamily.in>, Jagan Teki	 <jagan@amarulasolutions.com>, Ondrej Jirman
 <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, Michael
 Trimarchi <michael@amarulasolutions.com>, Michael Tretter	
 <m.tretter@pengutronix.de>, Cristian Cozzolino
 <cristian_ci@protonmail.com>,  Sumit Semwal <sumit.semwal@linaro.org>, Ryan
 Brue <ryanbrue.dev@gmail.com>, Nickolay Goppen	 <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>, Alexander Koskovich
 <akoskovich@pm.me>, Marijn Suijten <marijn.suijten@somainline.org>, Geert
 Uytterhoeven	 <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Chris Morgan	 <macromorgan@hotmail.com>, Barnabas
 Czeman <barnabas.czeman@mainlining.org>,  Heiko Stuebner	
 <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>, Arpit Saini	
 <arpit.saini@oss.qualcomm.com>, Michael Walle <mwalle@kernel.org>, Ritesh
 Kumar	 <quic_riteshk@quicinc.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>,  Konrad Dybcio <konradybcio@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Danila Tikhonov	
 <danila@mainlining.org>, Jens Reidel <adrian@travitia.xyz>, Michael Srba	
 <Michael.Srba@seznam.cz>, Shawn Guo <shawn.guo@linaro.org>, Alexandre
 Mergnat	 <amergnat@baylibre.com>, Alexander Baransky
 <sanyapilot496@gmail.com>,  Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Romain
 TISSERAND <romain.tisserand@gmail.com>
Date: Wed, 11 Nov 2026 23:55:54 +0800
In-Reply-To: <avRM_GhtR8vMdTO4@houat>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
 <avRM_GhtR8vMdTO4@houat>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-11=E4=B8=89=E7=9A=84 12:13 +0100=EF=BC=8CMaxime Ripard=E5=
=86=99=E9=81=93=EF=BC=9A
> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
> > DSI panels can be placed under DSI bus directly and many Linux DRM
> > drivers will work fine with it: mipi_dsi_host_register() adds
> > device for
> > such panel and DRM driver does not use OF graph to configure lanes.
>=20
> That's not true. We do use the endpoints to configure the lanes
> through
> the data-lanes property. See drm_of_get_data_lanes*
>=20
> > The affected here Linux panel drivers do not use OF graph, either.
> >=20
> > Requiring graph port for such panels is tying the binding to one
> > specific implementation of Linux DRM drivers, e.g. Qualcomm DRM
> > which
> > requires the port.=C2=A0 The port is not needed for the hardware to
> > operate
> > and for some of the Linux drivers, so it should be optional.
> >=20
> > Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
> > Signed-off-by: Krzysztof Kozlowski
> > <krzysztof.kozlowski@oss.qualcomm.com>
>=20
> DSI busses can handle multiple devices, and multiple data types. If
> we
> were to drop the port node, how does the upstream video device know
> which device it should send its video output to?

BTW I checked sun6i-mipi-dsi (which is the driver cared in the other
thread), and it assumes the first DSI device attached is the panel.

Maybe this is some kind of overfit, assuming a 1-to-1 connection?

(And I wonder if anyone attached a bridge instead of a panel to a sunXi
device.)

Thanks,
Icenowy

>=20
> Maxime
