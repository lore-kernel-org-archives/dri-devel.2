Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4FBF9EDEC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B7F10EA2E;
	Wed, 22 Apr 2026 15:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XdzwLERF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D2F10EA2E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:12:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F88243C2F;
 Wed, 22 Apr 2026 15:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA4EC2BCB2;
 Wed, 22 Apr 2026 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776870740;
 bh=+mxPr67dmi6eGFQEyDC3BhSbmybQ9ZfOoBp7zRL6wIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XdzwLERFkYdJ669m1kPKbBDvvaSbC2lPrz2VXhRFzFnBHNGLDlDZ2ffYtquR6W9G/
 d5Yp4X98uyHhA9SpdwxWdCC/Q8pFrdAi4alhKteYf4zdf1hQ3zZVt06nL41RppUK3r
 kwKnazcflpTTjePKX6CZusiw4DJ1HFUOeV4KrTDtYSnXm9WGvuhEg3hJw0Og7r+JHN
 Aq16VxCuwdW+ILHs3vqgVlD+HhXt8l1J/xglzb6vlFHcm0fp4A6KhI2eQZBT5d3Qrd
 BoUL694meGKIoHoV5K6SwsZLVCroGOp4OM1G6R2iJ2tDKN1IntC9HQpRDtn0mMzfcl
 uGtJ1njG+jZ1w==
Date: Wed, 22 Apr 2026 16:12:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Stephen Boyd <sboyd@kernel.org>
Cc: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Stefan Wahren <wahrenst@gmx.net>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com
Subject: Re: [PATCH v7 1/5] clk: bcm: rpi: Manage clock rate in
 prepare/unprepare callbacks
Message-ID: <18719902-4b4f-4766-ba92-658f3576f68b@sirena.org.uk>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
 <5f0bec08-f458-4fba-8bf3-06817a100c4c@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LHYlK3DZlkasQWhb"
Content-Disposition: inline
In-Reply-To: <5f0bec08-f458-4fba-8bf3-06817a100c4c@sirena.org.uk>
X-Cookie: I don't get no respect.
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


--LHYlK3DZlkasQWhb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 01:49:24PM +0100, Mark Brown wrote:
> On Thu, Mar 12, 2026 at 06:34:23PM -0300, Ma=EDra Canal wrote:

> > On current firmware versions, RPI_FIRMWARE_SET_CLOCK_STATE doesn't
> > actually power off the clock. To achieve meaningful power savings, the
> > clock rate must be set to the minimum before disabling. This might be
> > fixed in future firmware releases.
>=20
> I'm seeing boot regressions in -next with NFS root on Raspberry Pi 3B+
> which bisect to this commit.  We get a likely unrelated oops from the
> firmware interface and the boot grinds to a halt some time later since
> the ethernet never comes up:

This boot regression, which was originally reported against -next
several weeks ago, is now present in mainline.  Ma=EDra quickly provided a
fix:

  https://lore.kernel.org/r/20260401111416.562279-2-mcanal@igalia.com

which I have confirmed works but I've not seen any other response to
either that fix or the original thread.

--LHYlK3DZlkasQWhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmno5UwACgkQJNaLcl1U
h9C8uAf/ZO4wI21Uzl5bCxYBY8Jno+VC7J4vtbL64QxVmWsUJS8BkYFC8/7ag7Xb
3aX+wZAeWYuf+4kqIxij9+BdG+DUMiB2na+K9l42GGjTzNOxGlrrGZbswySitPsr
h1ZXondy/6andS/ka69t4b+iHh0V6QJC/j2vVgrYGU3rg6M+jc39EZ88pwbCKej2
ZCJc/vbmmaR9d/rqkcUFelHQcdTaIdDe7bT9WWbXplaBNKYvvPVyOsNfUtjDr8An
mpRjI+38T2F+ILIjrqcY0PgvIQLKLqOpjYLl3UOsKp6WcuQirHNc0KT1t2GW43FM
4MpOkPYfCgX7zx85X1PKJ1M63CuknA==
=kuy8
-----END PGP SIGNATURE-----

--LHYlK3DZlkasQWhb--
