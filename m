Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D22ACD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7473210E619;
	Wed, 10 Jun 2026 13:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EzuxKque";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F034E10E8F2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:19:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF9754445F;
 Wed, 10 Jun 2026 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2FC1F00893;
 Wed, 10 Jun 2026 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781097589;
 bh=cinfTbiu6v55Y32ngpM3iariZZQ8hoEgi/S+cPMDwrg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EzuxKquegOqAlN6EOUG9saPDo+l0Nk2v2VaRzUyeWqyc/3bGFd5KQ/OWDRHH783ig
 BzvPpAMrOeKwwFmyGVXDE/ufB7e+iQMC2zUCVGaH8Dsr+qBBC3fIRYy/sWOOoQx3aO
 T/9LdIMLnsDQRZ9PfI0icghPUPl7c1TnluL8+DO6XTW/vCPr+Yia8UhNeTF8ZZmhpl
 23dUt1ns0vzRT6ueohUqYiiNt0vLZhhm7iBU9tv/BAlm3x4RMHtDPYUaz1WcZ0i3L6
 +jtF594DmyO6HDvo+P7+qW/ODaxXvItmpGND9f3UCP9Oq2uECP7uGkJ9NPLvyLHXPD
 0BbVJAObQxteA==
Date: Wed, 10 Jun 2026 15:19:46 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniel@fooishbar.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH] drm/tests: Move test EDID data to separate .c file
Message-ID: <20260610-quantum-glossy-partridge-136d8b@houat>
References: <20260610-test-edid-array-definition-fix-v1-1-4467ba487886@collabora.com>
 <79f42f7e29b7a807c8ca4e622a547183018d65cb@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="s7jucmfkaplj2oii"
Content-Disposition: inline
In-Reply-To: <79f42f7e29b7a807c8ca4e622a547183018d65cb@intel.com>
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


--s7jucmfkaplj2oii
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tests: Move test EDID data to separate .c file
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 03:32:12PM +0300, Jani Nikula wrote:
> On Wed, 10 Jun 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com=
> wrote:
> > Having the test EDID arrays defined in the .h directly will duplicate
> > them across every user of the EDID arrays. This works fine as long as
> > there's only one user, but may produce build warnings/errors when there
> > are multiple users and not all of them use all definitions.
> >
> > Move the array definitions to a new .c file, and mark the declarations
> > in the header as "extern" to avoid the linker throwing a fit, and give
> > them an explicit size (either 128 or 256, depending on EDID) to avoid
> > the compiler inferring that they must be size 1.
> >
> > Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
> > Closes: https://lore.kernel.org/r/04ff70850213ae0f75486b1a27a7edb6fb4e7=
1c3@intel.com/
> > Fixes: ce1d0139adac ("drm/tests: bridge: Add test for HDMI output bus f=
ormats helper")
> > Fixes: 082fbc179c01 ("drm/tests: bridge: Add KUnit tests for bridge cha=
in format selection")
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>=20
> Thanks for doing this.
>=20
> I think I would've also moved the comments with the edid-decode
> results. Matter of taste I guess.
>=20
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Yeah, I agree but since it fixes a compilation warning it can be done as
a subsequent patch.

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--s7jucmfkaplj2oii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCailkcgAKCRAnX84Zoj2+
dpUOAX0ZT741X1BG6eeIGWRQakmoethIuV8d0alHoCIp1zYJ/+yrYFw/swshjX2l
7DvJTkcBfioiwNNXQFyEgpQZtmV+Xqxygapv9Ajz1Mcng+5L4x0gg9z0X0XwFntz
fva131jN9w==
=1FER
-----END PGP SIGNATURE-----

--s7jucmfkaplj2oii--
