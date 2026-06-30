Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFCBC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F0910E9B4;
	Tue, 30 Jun 2026 15:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZawjOD7C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5E710E21B;
 Tue, 30 Jun 2026 15:28:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C73BE43D05;
 Tue, 30 Jun 2026 15:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F61F000E9;
 Tue, 30 Jun 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782833338;
 bh=eNRcZHEi+sWqrXaKp2YiEZpqdRAdOI0YpmVUfOV8GSo=;
 h=Date:From:To:Cc:Subject;
 b=ZawjOD7CoeB1Iepwoghw9ZxRQZouq+Nph6w8mM+Y5ujCrrefwfYz3gBegx+8q7u4P
 CUWG7fwPcRPo8Z36zuZ6Feyvs6CJHZXl/o5hYjJ6AFJSJP7Vd5nHTL7ElD772kbncm
 s8OqmYDdq/B7pkN+lK7e+/4LXI/H+1hk1P7G4gBOXTlByTul2L1FMzJHNXuX1fEmQX
 rCxK6jAULnkGheVOwWJWxsQIP84nUKzm3N4N9SXQH4qU6qFEB4carE1Q0Ntd1A5o/Y
 r+EeBOIKmzGR1oxQcsfNPquqgCvuDUMlxyfhz8pYa1209Pug11HKmVcBrtR7nFfBk2
 MLFwciH3eHwBQ==
Date: Tue, 30 Jun 2026 16:28:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the drm-intel tree
Message-ID: <akPgtvG9EP6wBnBt@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zp3p2AqqPMtFQbFK"
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


--Zp3p2AqqPMtFQbFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  3f9de66f8acbf (drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable)

--Zp3p2AqqPMtFQbFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpD4LUACgkQJNaLcl1U
h9AuWgf/dK31r/B4goGnc8moZhRjkkDDyiStkkmSu2MhHOycRrqbAiAB3uhULmbA
IglqFpNkrko4Rb3kr9z3hNJq55Z9/LCjQeXbYSq8/utC/cBkv1AlV4vygM9h7QvY
N05rdGFsp9NBvEkKCtbgbMwdRIfip/WbIwvpHXSOTSio9P/p1FhFEEwQdXAo3C5l
vK1KxIRoaRmS1GN7yRf9wIhfH/g3ncvvPIbOQ05ZnaDbN1/O1VSxajk/eT47rl15
pmFiAKaOKwrLmEloq1C3W1IbzO+7ifJPlJYkL3D8t83wR33hIOKrYCSOctzu6lB+
PTWgC+K3G0vLtL522Lr05noZz/MR0Q==
=6/WV
-----END PGP SIGNATURE-----

--Zp3p2AqqPMtFQbFK--
