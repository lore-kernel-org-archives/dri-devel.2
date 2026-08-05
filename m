Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DCDC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D73F10EDFE;
	Wed,  5 Aug 2026 11:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OKvEL+4X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD1A10EDFE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:34:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37DB94592C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C621F000E9;
 Wed,  5 Aug 2026 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785929659;
 bh=pzKmbKKpLzZjZsL5dsVQmg5obOxaCrpK42UIRGN4uWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OKvEL+4XzXVxXAjYmF9kLgAimbQN1nnQpUAV3+BW9F20NyYD8x4NpQKpMO7kXzImE
 1kHEc/aOCthwugZYEjQZ2/bY6f0nFLgwwZaP4s1PjhOJbnwzuKGkvXBr3KfQmveY46
 bWsUAaVTr5nFMStEh2DIQI2cTixr0rQWTVtI0EnODzJhd5Qb8Kg8U8qJtCOfGFLrNi
 PrUzIxE3UaSBEZFdVyVw6/a6SAVJlUIowfTpPERIdrSRuxr2DwwB37TJ5XnKkEmGmW
 2yOaZwiUyGCtGLx5ceK6J2a31lHH8tu2VIs1X+a7mpvA+4soqXmVL3nS1K96j2MZQ7
 1afhYsyXjV2oQ==
Date: Wed, 5 Aug 2026 13:34:17 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
Message-ID: <anMeD_frp7Md3M4g@orome>
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
 <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
 <20260721124005.E00041F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b5iwkiooqcu3uuxn"
Content-Disposition: inline
In-Reply-To: <20260721124005.E00041F00A3A@smtp.kernel.org>
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


--b5iwkiooqcu3uuxn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
MIME-Version: 1.0

On Tue, Jul 21, 2026 at 12:40:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] A race condition between SMEM probing and `qcom_ubwc_config_get_=
data()` can cause the driver to bypass probe deferral, incorrectly fall bac=
k to default UBWC data, and return mismatched configurations to concurrent =
callers.
> - [Low] Missing Kconfig dependency on QCOM_SMEM causes linker errors when=
 QCOM_UBWC_CONFIG is selected but QCOM_SMEM is disabled or built as a modul=
e.
> --
>=20
> --- Patch [2]: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM ---
> commit e0bf0c57e180329e2b45423901bc2dc1b3492f77
> Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>=20
> soc: qcom: ubwc: Get HBB from SMEM
>=20
> This commit updates the UBWC configuration driver to dynamically retrieve
> the Highest Bank Bit (HBB) from SMEM. If SMEM is not yet available, it
> returns -EPROBE_DEFER. Once available, it allocates and updates a copy of
> the UBWC configuration data with the retrieved HBB value.
>=20
> > diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_con=
fig.c
> > index 0209a02c390f0..23901a4c51f73 100644
> > --- a/drivers/soc/qcom/ubwc_config.c
> > +++ b/drivers/soc/qcom/ubwc_config.c
> [ ... ]
> > @@ -168,9 +169,25 @@ static const struct of_device_id qcom_ubwc_configs=
[] __maybe_unused =3D {
> >  	{ }
> >  };
> > =20
> > +static struct qcom_ubwc_cfg_data *cfg;
> > +static DEFINE_MUTEX(cfg_mutex);
> > +/**
> > + * qcom_ubwc_config_get_data() - Retrieve UBWC data for the platform.
> > + *
> > + * Return: Pointer to valid struct qcom_ubwc_cfg_data on success, nega=
tive
> > + * errno on failure. Note that this may return EPROBE_DEFER.
> > + */
> >  const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> >  {
> >  	const struct qcom_ubwc_cfg_data *data;
> > +	int hbb;
> > +
> > +	guard(mutex)(&cfg_mutex);
> > +	if (cfg)
> > +		return cfg;
> > +
> > +	if (!qcom_smem_is_available())
> > +		return ERR_PTR(-EPROBE_DEFER);
>=20
> [Severity: Low]
> Will this cause linker errors if the kernel is configured with
> CONFIG_QCOM_UBWC_CONFIG=3Dy but CONFIG_QCOM_SMEM=3Dm or CONFIG_QCOM_SMEM=
=3Dn?
>=20
> Since these SMEM functions are called unconditionally without stub
> implementations provided for when SMEM is disabled, it seems dependent dr=
ivers
> selecting QCOM_UBWC_CONFIG might trigger undefined reference errors during
> the build.

I've been seeing exactly these linker errors now since next-20270731.
This is the DRM MSM driver selecting QCOM_UBWC_CONFIG without anything
else selecting QCOM_SMEM. This should be addressed somehow. Locally I
did select QCOM_SMEM from QCOM_UBWC_CONFIG but that's a bit risky since
QCOM_SMEM is user-visible and shouldn't be selected. A depends doesn't
work here because it gives an unmet direct dependency (nothing selects
QCOM_SMEM while QCOM_UBWC_CONFIG is selected by DRM_MSM).

Thierry

--b5iwkiooqcu3uuxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpzH7QACgkQ3SOs138+
s6HL3g/8DsCDJKW3az6Y1zCrYg3PF6b5QtbMxLu9cgGmRPa5nAD1Y3Mu9Mr4uH6D
22PVKRatHh6eVYatcdwO04HfYXuWK8tOdPkbpdpuJZN5gxIklVRaNyZ0g1xl4tp+
GloMZ/mfrtNVr2Mrt8GWCHci0wCimeriluEzus2RGm8MFXd0m39O8Xj4OAUF7GuQ
unPgYmfUk/W043t2Zz/JkuwUO3tHSJ8gtXmj+SmVGb1OqPwuw9G0bvNtfBHYltQB
aztfsVFsYtub9fKULKz+R/um31jdpAdd1zNRRjfbtcckKBmLxX7O78SYUo0h37W5
F+A2Navk1a0S23VftfXWvoIoyJcPC9Uix9yORaAN18yveezxcVGMuk0znDA4DHoM
XPD9E9oDLgrOAdGEQu7kHAUK7STd0y7XiPXdxaJxs+Kf15V1p7uccaqEXVuhnv/0
gOcw/VaS5nSdaqLdrveuoZsh9/BF68smBIKRgvxtQFzjQ827vXM29S/s+WVj9eHz
hX2L14FAzpRLUkgN2VWexLJPfpBT9BuLWaU1LP79QNIL5GkbkVnGuGvLZ0EPvn4j
ZPnv0ZjcS/ewQp+FBjUGc0A2NoQ5EisLF0zl0kSpC6lhfoxXXBjrI6CqUSzFCZuy
tzmbQjLlrzuMusaNLWsY5Gk0enbKSMlbn83tHdHODYG/wWGssLc=
=U87s
-----END PGP SIGNATURE-----

--b5iwkiooqcu3uuxn--
