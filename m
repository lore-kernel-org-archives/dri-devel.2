Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF7CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9B010E778;
	Thu,  8 Oct 2026 07:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fZnRqUxi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5D310E778
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:37:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C24B601DB;
 Thu,  8 Oct 2026 07:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E3C1F00893;
 Thu,  8 Oct 2026 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791445024;
 bh=csl9aH8ZXZ5BYezS42LmJ10c8AfGOfHTWUVgmtvM5/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fZnRqUxi+XAqRFKJXx+iNt27RqfgWj92PWOL37n/WlKFp/bnveXSngEg0xTGhOCzM
 hpKk3HXRy9ak3MNrPJqSB8UtDLedeSi5cxeBRhq2XnpiBulrjBPYO/ZSVIcOT2Qf9R
 aXHVM9jjx3cLoXPtyLPMM45aiziZG257eb6O6B4aOvScdNnCtBUDbqcIVvEgpUTCsU
 0x1/Ub/z/3f1j2aepYxLooFK9+SPClI8cvsHz4Ug1eeMZS9Gx0FZ6m6qVdkxu3rtVt
 9K8/0WYoha/qZRYlzZnw8elTaCk3nw0ICPP4oMRZPg1r5kTt2gEYoausYl92ljg27z
 6laVBCEtCcN9Q==
Date: Thu, 8 Oct 2026 08:36:57 +0100
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
Message-ID: <20261008-72e93f89527109ce066c1c23@squawk>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
 <20261007201859.3709656-4-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xR0NGw1ZjiPT2BJX"
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

--xR0NGw1ZjiPT2BJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--xR0NGw1ZjiPT2BJX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasdIGQAKCRB4tDGHoIJi
0u9nAQCVz6tUjFksWSbcB7eXoeE3A5h+4UJKvLJME0KldfXzTgEA0xUu6MY2QMdg
9IwrJ1tKPW/a/YqR1LaXmnRTllbDagE=
=31Nh
-----END PGP SIGNATURE-----

--xR0NGw1ZjiPT2BJX--
