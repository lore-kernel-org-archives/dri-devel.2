Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA1DCD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7760610F333;
	Thu, 18 Jun 2026 15:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VlfDGryh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E0A10EDDE
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:41:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 322A2417E5;
 Thu, 18 Jun 2026 15:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9159A1F000E9;
 Thu, 18 Jun 2026 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781797272;
 bh=dUuOoNdViV8CjmdUDID6eYV3c2vjKIIMX7TRtsbA2VM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VlfDGryhrVTHfKXvf+xQEyK0Ymu/PFyHBn7sXOOJzsEdvNITerXq1MOQjiPzwYvPa
 7AZlfjlM1X5PtuVMwF7rHOfHM9LBJip48uIIFaxjt47eV3LvId88F2t9PAJo4RtCtJ
 GygFoODdogp/7ZxMAiTxi+g39Q7qYLQ/YfL54tDN64mJ9wYgfsvQ8mFVt2XVMTPT59
 P3d5dGA/ExUbUF866Mg84r3RwFR/32308S72pK7Kte+UnMBphqZ3uEDZiImuSRmFxc
 I5nys/6SqBCsxKv27N0jSQvxy3xCqsqOStGTFM6WtHRuukjlToD3VSiT5wdovkFk8y
 pUnhnreyilHgQ==
Date: Thu, 18 Jun 2026 17:41:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
Message-ID: <20260618-godlike-solid-booby-39ecd5@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260609-orthodox-cocky-bull-5ddef8@houat>
 <14be0bdb-982d-4cad-8624-944c69937de4@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="srthbwwmhb5ccsxh"
Content-Disposition: inline
In-Reply-To: <14be0bdb-982d-4cad-8624-944c69937de4@mailbox.org>
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


--srthbwwmhb5ccsxh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 09:45:54AM +0200, Michel D=E4nzer wrote:
> On 6/9/26 14:51, Maxime Ripard wrote:
> > On Mon, Jun 08, 2026 at 01:19:06PM +0200, Nicolas Frattaroli wrote:
> >> With the "max bpc" KMS connector property, userspace can arbitrarily
> >> restrict the upper end of the bits-per-component range. This is fine a=
nd
> >> good, except the HDMI state helpers never considered that max_bpc could
> >> be influenced by a userspace setting, so assumed it'll always be an ev=
en
> >> value from the HDMI standards.
> >>
> >> This, unfortunately, is not the world we live in anymore. Patch 1
> >> corrects sink_supports_format_bpc to return false on BPCs outside of
> >> what HDMI allows. Patch 2 then corrects handling of odd-numbered max
> >> bpcs by rounding the loop start value down to an even number instead. =
It
> >> also adds a KUnit test to make sure nobody breaks this again in the
> >> future.
> >>
> >> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >=20
> > Do you have a bit more details on the world you live in? :)
> >=20
> > In particular, why would erroring out on setting an odd value in
> > atomic_set_property not work?
>=20
> That doesn't make sense, since the "max bpc" property purely defines
> an upper limit. Setting an odd value for it doesn't mean the kernel
> has to use an odd effective bpc value, it can use any valid bpc <=3D the
> "max bpc" property value.

Ah, yes, of course. Thanks!
Maxime

--srthbwwmhb5ccsxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajQRjgAKCRAnX84Zoj2+
dnGjAYD9lrunuF+Emh1P1Wzag9p3dTmNRfHGQPldEGp/knXjTIfsSoW2p436g0VG
dkgIGYsBgPdVytTXTogTRZu/VOwcaov5xT18vXKWsrEsTgtCojNKZ4z70zNcWiOl
nRd+MrCGDw==
=WYNm
-----END PGP SIGNATURE-----

--srthbwwmhb5ccsxh--
