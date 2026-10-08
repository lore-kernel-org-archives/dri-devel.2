Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AE1CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746E610FCAB;
	Thu,  8 Oct 2026 07:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S2X1h/As";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6E610FCAB
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:30:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8120643996;
 Thu,  8 Oct 2026 07:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668251F000FF;
 Thu,  8 Oct 2026 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791444628;
 bh=Sk0BYMvKP32BPnXjM0IQ9naXBgWWYSowbYU4+sVLHwU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=S2X1h/As+MqJKT2hziqV/nvOA+EvEda+3aqdc8N+uBIkNWz2ZJ4jZr7LSQoCCyyMZ
 RBPJz3/ADvkZJKQ1j4VnQGEGAjLWFIxtZOTFZx7Jb7ZDqGX1yQ10hIe3sCN4KbDMD4
 C90IGcV6vNsKBLJlPuwIYuxWzEMTbzUetnbQhHvQA3W6K2Nf1CDwvpidJGCMfNu71e
 899pB0JzPZJhkNDvuKACXCluLT9bGC3qNOL+p2/lPdkd16rOsOLaXh/L1xRsuSHxQ2
 ygSLqEPG0Clg6pXwqHVUtk3wQ4A52mVe2D8IFRTPRqOmxpP3TLkXj28RHoZOcjp+YA
 iTRBw+ow0sgzw==
Date: Thu, 8 Oct 2026 08:30:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: Re: [PATCH 3/4] dt-bindings: display: panel: add compatible for
 DCLTek 300248 10.25in panel
Message-ID: <20261008-829b51900061559b07defdef@squawk>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
 <20261007201859.3709656-4-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7OJMX8pyJ95xL7NY"
Content-Disposition: inline
In-Reply-To: <20261007201859.3709656-4-marc-olivier.champagne@savoirfairelinux.com>
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

--7OJMX8pyJ95xL7NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--7OJMX8pyJ95xL7NY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasdGjQAKCRB4tDGHoIJi
0u2rAP95HLnhcmIEBWdEXSqGrHJ4LwcO9JTNJfg8bhgzEV9M7wD+JaK+kOUiDe2U
B0U02bVtgFYAia7GqiYA7G925R/XeQE=
=lJMX
-----END PGP SIGNATURE-----

--7OJMX8pyJ95xL7NY--
