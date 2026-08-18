Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE8EC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2564010E4DD;
	Tue, 18 Aug 2026 15:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ja6mfc4e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4780B10E4DD;
 Tue, 18 Aug 2026 15:42:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30B894383F;
 Tue, 18 Aug 2026 15:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378E71F000E9;
 Tue, 18 Aug 2026 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787067777;
 bh=fA0R5j0Us6MV/0tS8iE/q5eXCYL7MfVEZguiEhpCiAQ=;
 h=Date:From:To:Cc:Subject;
 b=Ja6mfc4e69jVjWE0YdBjlnWh5f5CHbqXDIxaGySOJvrCJnfqIro73FMBlIGWtcdp1
 X3GiKsbmBiiEv5k1UStpABa/NUTdWMF7ippP088Tg7oxvSHUssQGK2l7Qv4CaKvJPk
 ll9npF8Znd1Ivz3//3ExaJSXW49rG9Y6J7TwJR44UbQx/lJaiTdoKPVGb1kcxoijCL
 +ZWCHYfdz4IJ3+xbfpZSDQsaczfHFuMnDnTQqBdqHy/+xm01DM7EkfJJNqt8GCC5PH
 nkesI4TAOEruTUfnvs84oaEzx5UNzhBg/hjh0Bf3UWcsHQoD8YqsOsuXyXl7UYNV2A
 E/73m68z7BGpA==
Date: Tue, 18 Aug 2026 16:42:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Unexpected files in the drm-intel tree
Message-ID: <aoR9fNYRhmWDNJtz@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="274Teg7tbCdQCE+R"
Content-Disposition: inline
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


--274Teg7tbCdQCE+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  ac3baea883dab ("drm/panel: find_panel_by_fwnode() return a counted reference")

added this unexpected file:

 drivers/gpu/drm/drm_panel.c.orig


--274Teg7tbCdQCE+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEfXsACgkQJNaLcl1U
h9C1Qgf/fEu8OtJG7s3ubqqM42ynvN5XqaAkk2ymjz4J3c+ufhuvlLSYwr0hN+mo
T8Atl5H9c5cUmsnlwq8eEFLM1XPAHbpcwt4HpvN6IkOc+Kh17+IVxYnwzmQR58yu
7/FSu40bQ/JxaI+j5vWYFv28IGomfxOV/myrg24HhOVoQXVOnPktX74fx2DrD3Rq
bs8C0gMflG3poHG0DXLC/HHaw2PDWPEoCnqHm4k75cBw/LCAhC7BI3QWI0yDK7t5
5vKAoUiQw6Obb87XNwaZ0G5nYWwr22RMyqqkZNZnA3EveI7GxjmMdm+BNTy7uuNF
Wvm56nFwLTGVzh5dQXqO8VkxqtfAvw==
=MYZJ
-----END PGP SIGNATURE-----

--274Teg7tbCdQCE+R--
