Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354CBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ADA10E3E5;
	Fri, 26 Jun 2026 15:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JHfyli1n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71A810E3E5;
 Fri, 26 Jun 2026 15:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34E60600C8;
 Fri, 26 Jun 2026 15:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8E71F000E9;
 Fri, 26 Jun 2026 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782488086;
 bh=4raHx6k80d9t62uDEOhrRCyJH4QyHo1rHRJ5kcCorvE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JHfyli1nhTiFFZFS3IiUukQdztwkbdyp+HJkPf5kYWilHCjz0X/6UY0aeY7rbblUn
 F9hNj4grEhqZ/vndrjbKIju0wMUsb4ZIwFj7mpdmAjwEAB0ZlA1fxvqSQ9y+3UcPL9
 plAQg2c5a36xB7My3M1AKEdILFpB1i3JskJxXve6k2uExcbmll3viwJ29W1w1uZvsz
 qJWOPyF4DDhyFzKhQU9ZB0LOArv69AOkoGKkhX57EOsgLoEfGeJ+VpEwj5suy7CFkq
 +KdPKvhbjia/fCRcdV7tl+KnYQNzUjMk61pTcrLPy8OaCFLTGwON0P6IVMJdeLNfeS
 Ruz4r6p3pQG5g==
Date: Fri, 26 Jun 2026 16:34:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: imagination@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: gpu: img,powervr-*: Add maintainer
 entries
Message-ID: <20260626-reprimand-skinny-89ccde1df769@spud>
References: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
 <20260626-maintainer-updates-v2-3-e1b3f246c44c@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kKRn2xEvYAQ2l8+M"
Content-Disposition: inline
In-Reply-To: <20260626-maintainer-updates-v2-3-e1b3f246c44c@imgtec.com>
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


--kKRn2xEvYAQ2l8+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=02

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kKRn2xEvYAQ2l8+M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6cEgAKCRB4tDGHoIJi
0sOEAQCbVD9tmnP5JwHMkNN7V4GKLSyTJ34yY0KjkCoyG6oW9gD9GFvmn+/jYnUx
2s3jq/2yWmaoNEJJ3CjzliJu89pp/AY=
=VR4C
-----END PGP SIGNATURE-----

--kKRn2xEvYAQ2l8+M--
