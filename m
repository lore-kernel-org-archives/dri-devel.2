Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B25C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DF210E290;
	Fri, 25 Sep 2026 17:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YSYzEVtw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236C110E097;
 Fri, 25 Sep 2026 17:03:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A45260136;
 Fri, 25 Sep 2026 17:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9CF1F000FF;
 Fri, 25 Sep 2026 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790355809;
 bh=Wn6Y6cSUdLvpo1EPooCk54mfkZUlgcXDZxuV9DQNq7A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YSYzEVtw7+SjOr4/uI2NDDPAu/9rmx+Jo3fPCc9YOhs93GEQi3ZF+w4WtWffeQdeQ
 a8FqdkwF1UmW4FwZV/glQ5NmFYsJudEnpscWY141Y9h9EKy7YasKwlgHAZLHJvxDao
 TBNQGqefC5EHZwI6tQUq8exjEZjIghM9btx89KP+JRLJgRq9cRjrlOEIxCiEzQcU8C
 nEJYNrTnuJEIHqgaboYsbjg0tjq/d4+HUPmFDEo5LNG9ZGAWO+3oDvum0DX8xtm4OE
 bJKoPVXA24kDdRAULL37mkl3TiIyDl4ujOddVpfJkX06n30FKB4/LMb308Uc5xTpms
 mPzTNFcKtSW7g==
Date: Fri, 25 Sep 2026 18:03:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <2eaa0128-4cda-4f26-b9de-311add98a1fa@sirena.org.uk>
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
 <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
 <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GxpsZ276BoiWneJS"
Content-Disposition: inline
In-Reply-To: <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
X-Cookie: Love America -- or give it back.
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


--GxpsZ276BoiWneJS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 01:01:15PM -0400, Alex Deucher wrote:
> On Thu, Sep 24, 2026 at 12:54=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > I'm still seeing at least:

> Does this patch fix it?
> https://patchwork.freedesktop.org/patch/755883/?series=3D174861&rev=3D1

It seems everything built fine today, I'll try dropping the workaround
commits for Monday.  The drm and drm-misc trees are still failing due to
the original issue.  Thanks for getting things sorted.

--GxpsZ276BoiWneJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2qVgACgkQJNaLcl1U
h9Aa+AgAhHmM8xTge2kD5uwbL6bDW0YNx686WZcCIl9gaLuRhbI9qjUGNN0xuMTr
PwhEuasQLDFKAObcrOSB0/FPaHo2b7ftMUU4T/kJSf6aTBEdrjiQ5WjNfjrWHEfx
PmMgQuSQd8j6XaPfx208fmwCoJqHkZpA8kiuzY6WyhsV0g+yMCx4xmtyRyQCZXbf
kxaPBrGh2JktPuwkfKf7jtIgKA0PgLoP5bV+nudprdddKuocUeVG/x5FLJh9A9RH
SOAuDI9oinPUu7psXTbVrlLZGT5lXb5ScB82n9uw57YV3R5BEw9bs+jZeMPgxOOc
Sg8JLBV08DhzBzXIRbxfMCnkVGE1hg==
=dX1B
-----END PGP SIGNATURE-----

--GxpsZ276BoiWneJS--
