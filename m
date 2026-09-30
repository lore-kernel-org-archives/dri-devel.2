Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9080ACA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18E310E23E;
	Wed, 30 Sep 2026 09:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e5djgav/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE7F10E23E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:22:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A62C740327;
 Wed, 30 Sep 2026 09:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AC81F000FF;
 Wed, 30 Sep 2026 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790760177;
 bh=X/x70JWMsn0GwooOf5u0/FT6WEHaSv2RtNgAbg9eDUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=e5djgav/nnv67NRjmVWS/jXi8pwQvITvBXT+Ib3W1g2p963qYfms2yoj5bprChMF/
 5m+KvMfJCC6+Juk08nbuBXptLKDUdb8Z3OnnB2Kg/5wX+GfnUaNMgPcDJfwkwlCl7H
 nJxHZ17t93KISpE7QLxl4r8w0f+Hf/HHRSFPhY78uynCHL38WhdunTvzqNMC3vr/3h
 krTAm9jMbPoEcjd5rx2Mt9tDILz7gqu7O400AjNex57XauSlP3WqyRcfQlH3sjBrCG
 a2kwHr80Avvgg/Zcr2n5kt1HSvqsjatra6a8lzTOFbLsNnsz+kuwDhrw81+iilW0rc
 6ZXBCCEFFgPZg==
Date: Wed, 30 Sep 2026 11:22:55 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dsi: Unconditionally manage reset line
Message-ID: <arzQe5nbSXd9TuJ7@orome>
References: <20260930-dalmore-fixes-dsi-reset-v1-1-58c9d12f5ebd@nvidia.com>
 <ary71zC1e-bySLFW@orome> <arzDId4Mxryrfa7m@orome>
 <8pr0OOFrTHeQTZiJatWz_Q@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tm4xvg5k43shc5ai"
Content-Disposition: inline
In-Reply-To: <8pr0OOFrTHeQTZiJatWz_Q@nvidia.com>
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


--tm4xvg5k43shc5ai
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: dsi: Unconditionally manage reset line
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 05:46:01PM +0900, Mikko Perttunen wrote:
> On Wednesday, September 30, 2026 5:29=E2=80=AFPM Thierry Reding wrote:
> > On Wed, Sep 30, 2026 at 09:40:51AM +0200, Thierry Reding wrote:
> > > On Wed, Sep 30, 2026 at 01:54:55PM +0900, Mikko Perttunen wrote:
> > > > The DSI driver ignores the reset line if a power domain is configur=
ed.
> > > > This was originally added to support Tegra210, where the power doma=
in
> > > > provider has to control the reset line -- at that time, older SoCs
> > > > didn't have a power domain for DSI. Now, however, they do with the =
core
> > > > power domain.
> > > >=20
> > > > This happens to work on most systems due to DSI already being out of
> > > > reset when booting the kernel, but on Tegra114 Dalmore, this is not=
 the
> > > > case and causes the system to hang during boot.
> > > >=20
> > > > Ownership of the reset line is no longer a problem with reset
> > > > acquire/release semantics, so control the DSI reset unconditionally
> > > > from the DSI driver (possibly in addition to the power domain drive=
r).
> > > > The device tree bindings already require the reset and it is present
> > > > on all platforms, so this is safe to do.
> > >=20
> > > That seems backwards to me. The whole point of doing this via power
> > > domains was because it's explicitly not safe to toggle that reset line
> > > outside of the powergate switching sequence.
>=20
> If you're referring to the MBIST workaround, unless I misremember, it=20
> doesn't mean the reset cannot be used outside the powergate sequence,=20
> just that it has to be used within in.

It's not just the MBIST workaround, but the officially recommended way
to powergate/ungate devices. Sure you could do whatever you want with
the reset outside of that sequence, but that doesn't mean it's a great
idea to do so. With runtime PM we can be reasonably sure that we're in
a known-good state at this point, which is the only reason we could get
away with doing this. That doesn't make it right, though.

> > >=20
> > > Also, the power domain code paths are supposed to work regardless of
> > > whether the DSI was already out of reset or not. If that's not working
> > > right now, I think that would qualify as a bug in the power domain co=
de
> > > rather than the DSI driver.
> > >=20
> > > Shouldn't this be fixed at the powergate level? My recollection is th=
at
> > > DSI is tightly coupled to the display powergates, though it's been a
> > > long time. Do we maybe need to reflect that in DT? There's a TODO in
> > > tegra114.dtsi that seems to indicate that we're missing DIS and DISB
> > > powergate implementations, so maybe that's where we should start to t=
ry
> > > and resolve this.
> >=20
> > Looking at this a bit more, pd_core doesn't seem to make sense for DSI.
> > Basically what that does, semantically, is claim that there's a power
> > domain responsible for powering up and down the device, but in reality
> > it doesn't to squat.
>=20
> Doesn't that reasoning apply for every device?

Not necessarily. There might be devices that are truly only powered by
the core domain.

>                                                Technically, pd_core=20
> corresponds to the core power rail.

That only means it needs to be the top-level power domain, but it
doesn't imply that it is the only power domain involved to make any
particular device work.

>                                     DSI is powered from it.. we=20
> certainly haven't always had an expectation that the power domain=20
> provider handles resets for the device.

Well, as evidenced by the issue you are observing, that expectation is
indeed very much baked in. DSI is part of the DIS partition, which might
be powered by the core partition, but the DIS partition also needs to
control a bunch of clocks and resets associated with devices that are
part of it. If you omit that DIS partition, then, yes, things are
expected to not work because the clocks and resets are not handled at
all.

> On Tegra114 it looks like DSI indeed is in the DIS domain so that would=
=20
> handle it, but on Tegra20/Tegra30 that isn't the case (even if those=20
> device seem to be working right now anyway).

Tegra20 and Tegra30 also seem to be wrong, to be honest. If they work,
then they probably only do by some happy accident. Evidently I wasn't
paying enough attention at the time and was convinced it was all correct
because of the Tested-bys.

I'm now wondering how much testing was actually done for these. Once the
display is turned off and back on (via framebuffer blank or DPMS), it
shouldn't come up properly again. Well, except maybe if the disable and
enable sequences are good enough to not need the reset in the middle.

> > Does the hang you observe go away if you remove the power-domains
> > property for DSI? pd_core should probably be removed for both display
> > controllers and HDMI as well. Probably also TSEC, though the TRM isn't
> > clear about what power partition that's in (probably DISB because it's
> > used primary for HDMI, which is in DISB as well).
>=20
> I'd expect it would go away since the reset code in the driver would=20
> activate then.

Good, and that's the right thing in that case. Again, the power domains
were introduced to specifically address the (clock/)reset/powergate
sequence requirements. That's why the code uses the power domain code
paths in a mutually exclusive way with the resets. Either the power
domains take care of the entire power sequencing as recommended by the
TRM, or it doesn't (in which case we fall back to the more brittle
manual sequencing that we do).

So I stand by what I said earlier: if there's no power domain handling
the entirety of the DSI controller power sequencing, then the DT should
not have a power-domains property for the DSI controllers.

Thierry

--tm4xvg5k43shc5ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq81OsACgkQ3SOs138+
s6Fz+hAAiFJg0ZORWTVgyUjtIBlJWeOfzwpj14859ouOTgk1eCUMX5ZmzjD15Gis
6nshbTe0UXeghL+PsByr647SXbkmrCAhhBjVyGeJ8kvng7n3soTEuCgUrgI4+Noh
yxUZ60Md5C4t//oXPSooLiqd+CTmf+SwQNzyUBUgzGqdMAj7WnAtHrhpPXIgn86w
Af53b4rCBf1xmMU/T5RumD+TXPeAkkcQjapsBWtwSAfRAa4CsXyHHOIo5UNzElIm
NTuIYoLaNh8m0MxFeh4Amv9+KepKGcgO1mlo5jnIuaRhD3xWkbgu+LmVkEWQEtSC
9LgBisdErLXeydLna0LzzzHPsH9NEgBKrICOTYCgwtt57IQGuSSBIymowlkY7HUI
RNmPIvkxpxh4ZMFCFYV/bIt02rLlqLPQc+9Vp/l/ruN44dD5C0M+Z6GHW2IEk+EA
AyjGXycMxyY6jRIcgPEeErjpSL9Cyru0KyVdVrczLTVzRO3iFnWb4x+sUPq7uqIL
kf4lV+cgJmFc88qS4diK9jMAS6vLxwTittOwA8DysSpyzRBZgAX3HgsBeggblKGL
bWWtyEMbianZrNWXBeGQROrNKmOaleecCHH1u8RgkFeNRNmx9zDpKvmvNKcczQrw
Kre6eF5A7Dg+OcL+dYOWkKuV2sOSdn1Nom24AJuTwEg7KbaOdNY=
=qNqj
-----END PGP SIGNATURE-----

--tm4xvg5k43shc5ai--
