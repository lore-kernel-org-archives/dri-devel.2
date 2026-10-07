Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6127CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C1D10E554;
	Wed,  7 Oct 2026 10:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZiRJmEL7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7715710E554
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:00:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 313404033B;
 Wed,  7 Oct 2026 10:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21821F0089B;
 Wed,  7 Oct 2026 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791367234;
 bh=V7saYIf53GZ5gauKLoNnYgicR8tC4J5BgHg+EtXkBGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZiRJmEL7MRgFwY0QwqJIl8MYHjmtk92fHO3nxQ5MR6p7XsWXV2Ga1Yy4pkILZlaRY
 Z8hoLhlotceRRGB4opMYvDSuDw13EeXZOt+HYc2A5+MD7/13eRrRj/g8KyY9/fVdcG
 jpbOUVVAlwlq2937U+FvKN2VEKhXpamFsr63S/f403nZdUhJ4uxtbg/jL0rx7GWjkH
 Bz8Q9llhjv+5iybj99BsR+i+OC0Bjd1bJGURYwh+TGspF63j7FGdPNfVP6urNyvCKM
 DcR5INOaG8CffLd3zXqU9M/YOJKSJFvRmvyPE45yuftmsbmbDSz0WIv1NeLmHX4/9Q
 y+HKnubvj9u0g==
Date: Wed, 7 Oct 2026 11:00:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
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
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add compatible for
 DCLTek 300249 5.5in panel
Message-ID: <20261007-243ca36059610c8a223cf9d5@squawk>
References: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
 <20261006183455.2350966-2-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/b8kM83l+jTLXcsu"
Content-Disposition: inline
In-Reply-To: <20261006183455.2350966-2-marc-olivier.champagne@savoirfairelinux.com>
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

--/b8kM83l+jTLXcsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--/b8kM83l+jTLXcsu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYYOwAKCRB4tDGHoIJi
0vELAQDITQy4L4y0dXJQpFnhHmZ6EUpsXq7WWSLWQLz9I7RiBgD/bkEXOVTeVac7
mUJIccxMAnM2ERDXXK9PpwZ/ZBE0kQw=
=fR0K
-----END PGP SIGNATURE-----

--/b8kM83l+jTLXcsu--
