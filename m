Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16E8CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D7F10E1D9;
	Thu,  1 Oct 2026 17:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OS3trrN5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A713F10E1D9
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 17:03:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3963E40127;
 Thu,  1 Oct 2026 17:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957F21F00898;
 Thu,  1 Oct 2026 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790874197;
 bh=EX9W5RH7bDkLX7Yf39fu1DvtbQ2nox1FjQReRMWn7TU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OS3trrN5b8W9fLou1Z12+BrRokT3+5lHTvluXexWclVL7xq2EcnSBAPW32lYJeQdO
 zghxHKTCh/sDQIDqYKZDwhOWD3y9DaYG2sYqxTYBgRLRASEpGfQsJXocSa8t2hsWyy
 G+p1PUH8k95nCe3AtV5co1nCAqR8B0EdZQmc/azcwbFJuWIW3FIRW5amhVP9TwmmS+
 iPFv+bmaeTfkG7xjr6sGD57gRTB2fGyt7l8Xw2+AUPmJn+8nQQXRzlP5ED8SKJAKT5
 KwhTlWo/W3qc06kx8DaYNFt1SMW5ZG+Dp0T4aw4ND2VuohGzUh7gcnf+P5759FkQPz
 M4XhExyAsOeQw==
Date: Thu, 1 Oct 2026 19:03:13 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <ar6RSRd99jbTdYOR@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org>
 <artpBMeM13Dd0lLy@houat>
 <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ddbx65bfv53pj3da"
Content-Disposition: inline
In-Reply-To: <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
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


--ddbx65bfv53pj3da
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

Hi Neil,

Stripping the rest of the discussion that hasn't been great...

On Wed, Sep 30, 2026 at 03:36:36PM +0200, Neil Armstrong wrote:
> But I'm open to discussion, and I'll talk about display Panel in
> XDC today, Plumbers and ELC next week so I hope we'll find time to
> discuss about this in person!

First off, I'm sorry things got that heated, and for turning the heat
up. I definitely overreacted there, and for that I apologize as well.

I really like working with you in general, our relationship goes back
quite a while, and it deserved better. So let's indeed meet at Plumbers
to clear the air, and hopefully patch things up.

And maybe discuss these patches, but that part can wait.

Maxime

--ddbx65bfv53pj3da
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar6STQAKCRAnX84Zoj2+
dspTAXwMWHCEjivmSoqKAtnrOVOnY++dhvP2+IzSZvOQ+QVbR38foJ0sc702HamI
EP4rCl8BgKU1nXSjeAmaqM/chc9mDBRhTiWgmCSdnMOcoBacQUClBAXumDOiQitP
K30m9foI+A==
=fjZs
-----END PGP SIGNATURE-----

--ddbx65bfv53pj3da--
