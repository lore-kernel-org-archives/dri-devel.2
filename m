Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFD3109B46F
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C785710E140;
	Tue, 31 Mar 2026 14:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rj6yay0F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9509110E140
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:44:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F4566024D;
 Tue, 31 Mar 2026 14:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D34BC19423;
 Tue, 31 Mar 2026 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774968278;
 bh=3Jhe3TYvRFJkGv7Zr9SSw2NSWBUOqC4UfBtpEzkNAq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rj6yay0F8xnQmb2P+v/FnkDjrmuTOcOJYfOxuiibrcXSN9gjxUZ4lLxVRJbEbUYcS
 JN7r1VaXkvKla+H4EMfP13kjj5KfmKUrTosQUkMKLfJkQYOVXJwf1rs9/Qh5DQQJry
 ymJfWPTgj8DhkiErhAymB7y3E3e5qJLlgB66V/NM86KxvwDSkxvRgERA4O2T8AFwOU
 RDyfZ4Rs4dxSJOF36eVqZyClMR5Z1okIXEgkQ4hAts6VxccPH8hoCBK2CcfORUMbem
 q97xkpxD0/oWeQnKHq+ajwsKw9BWSA0PVbpuTEzR0lhadJ75DkuojegAu/+PCiYayh
 5u3BksmTnqH8g==
Date: Tue, 31 Mar 2026 15:44:32 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <8a3c104f-9259-46a9-a6d2-a907d699e49c@sirena.org.uk>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
 <5f0bec08-f458-4fba-8bf3-06817a100c4c@sirena.org.uk>
 <d251c380-f2f5-4daf-9661-bbb6dc6c959e@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mw1gwsm7ZbtolsXc"
Content-Disposition: inline
In-Reply-To: <d251c380-f2f5-4daf-9661-bbb6dc6c959e@igalia.com>
X-Cookie: I just had a NOSE JOB!!
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


--mw1gwsm7ZbtolsXc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:32:07AM -0300, Ma=EDra Canal wrote:
> On 31/03/26 09:49, Mark Brown wrote:
> > On Thu, Mar 12, 2026 at 06:34:23PM -0300, Ma=EDra Canal wrote:

> > > Rather than pushing rate management to clock consumers, handle it
> > > directly in the clock framework's prepare/unprepare callbacks. In
> > > unprepare, set the rate to the minimum before disabling the clock.
> > > In prepare, for clocks marked with `maximize` (currently v3d),
> > > restore the rate to the maximum after enabling.

> > I'm seeing boot regressions in -next with NFS root on Raspberry Pi 3B+
> > which bisect to this commit.  We get a likely unrelated oops from the
> > firmware interface and the boot grinds to a halt some time later since
> > the ethernet never comes up:

> I've managed to address this issue locally with the following diff:

> diff --git a/drivers/clk/bcm/clk-raspberrypi.c
> b/drivers/clk/bcm/clk-raspberrypi.c
> index df2d246eb6ef..ef5ae3b4adca 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -160,6 +160,7 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] =3D=
 {
>         [RPI_FIRMWARE_VEC_CLK_ID] =3D {
>                 .export =3D true,
>                 .minimize =3D true,
> +               .flags =3D CLK_IGNORE_UNUSED,
>         },
>         [RPI_FIRMWARE_DISP_CLK_ID] =3D {
>                 .export =3D true,

> It looks like the VEC_CLK can't be disabled at boot time. Otherwise, a
> bus lookup will happen (similar what happens to other RPi firmware
> clocks).

> Is it possible for me to test this change in LAVA CI before sending it
> to the list? Just to double check that this patch indeed fixes the
> issue on your side as well.

I can give you access to submit jobs easily enough, if you're already
familiar with LAVA and have somewhere to host the binaries that'd work.
It might be more straightforward for me to just test it.

--mw1gwsm7ZbtolsXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnL3c8ACgkQJNaLcl1U
h9DMywf/c7JBjgSLiPt0az2ROBbBsrilMJsPqSNTsDXA7X5NknfUFp72tFaotahG
8vusN+z69oaPzUBfSXNsdkuURtbFw+lfZvxE4POlhNUeCVHgMtV2d3ZMkOp08tXW
gsRgIsUPBRLUmJ1tbBJ2gLJefotLzW2GMgl9p2jn/fX9K7JGzb3WEE0mlGz+cEi5
hhbYGyU5uEgI4inXmDrG5zb68H+yhuYSAFcmKVhGjPs+8C0UNLX8cD8sOYo64KR0
6dYyMlGKUGrQyleLJ9kvD/k+enQTS043Vz81Iu0dGsn+RUM9J114a4jOg0R+0V4I
JdWePwdWTSYwrYz1SOACpRqaYrMVEQ==
=AW0Y
-----END PGP SIGNATURE-----

--mw1gwsm7ZbtolsXc--
