Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CC606E465
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vuu3b3LC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776A610F6BB;
	Tue, 10 Nov 2026 13:05:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A5210F6B0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C47FE6391D;
 Tue, 10 Nov 2026 13:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027DF1F0089F;
 Tue, 10 Nov 2026 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794315916;
 bh=MBoMybViYwhw6nSYk7WOZTfocy/4HWn5nwGt1dyl8yY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Vuu3b3LCWUv0/eF3lz7jUcEZVs9jqVhBsDLONVZGlavb/6XHlC5bjur5b5gMphmuf
 KEBt/T3I7FmSCjgryFiCneLA3aeYVdBQqaDTcSTgJZ+7lIqqSW732cn3+1jK7wZagT
 x/QC/ajdeZ7tQsAN9MVf3ZFvTcAIbk/+GKpCx2qeSZWJWAeCOr10meax0f7ucCrwih
 /C30xxGahUS1/4rq9SCtlIX1qXGSxgr6g08yb2SKm0pTDLYXKQ2ev+z5jnHcTVmjTU
 vFQm/jRWPHmKJDvxnWldoWZpmKNOu+hV8L9BzRzUm/DCoWmwKcUv+CdOyS2zGZK48d
 KCOTiaXJyioCw==
Date: Tue, 10 Nov 2026 14:05:13 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 00/14] Add DRM driver for Solomon SSD16xx e-paper
 display controllers
Message-ID: <avMWcdpHuf8CX41p@houat>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <xlv1o6bweu88.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="klwijyhaeml73kht"
Content-Disposition: inline
In-Reply-To: <xlv1o6bweu88.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--klwijyhaeml73kht
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/14] Add DRM driver for Solomon SSD16xx e-paper
 display controllers
MIME-Version: 1.0

On Tue, Nov 10, 2026 at 01:39:19PM +0100, Javier Martinez Canillas wrote:
> Devarsh Thakkar <devarsht@ti.com> writes:
>=20
> Hello Devarsh,
>=20
> > This series adds a DRM driver for the Solomon Systech SSD16xx family of
> > e-paper display controllers (SSD1673, SSD1680, SSD1681, SSD1683), start=
ing
> > with support for the Gooddisplay GDEY042T81, a 4.2" 400=D7300 black-and=
-white
> > e-paper panel driven by the SSD1683 controller.
> >
> > The driver is designed and architected keeping the bi-stable nature
> > and low-power requirements of epaper display based systems in mind
> > along with having adequate flexibility to support varying use-case
> > requirements for the e-paper display use-cases.
> >
>=20
> [...]
>=20
> >   drm/solomon: ssd16xx: Expose refresh mode as plane property
> >   drm/solomon: ssd16xx: Expose color mode as plane property
> >   drm/solomon: ssd16xx: Expose session management as plane properties
>=20
> There is a fundmental issue with these 3 patches. They are adding custom
> device-specific plane properties, but the KMS/DRM subsystem requires all
> KMS properties to be generic and standardized:
>=20
> https://docs.kernel.org/gpu/drm-kms.html#requirements

And with an established open-source project using it.

Maxime

--klwijyhaeml73kht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCavMWiAAKCRAnX84Zoj2+
dkIwAYC0DtJkAVBm+J23hxDPYN3LOErIFEidODLDtg7h0aQi3Z2BFQwO+PCQIoXo
gjP2Z0UBgJVG3tdXOtdyDLFW8PcuEpwqiWW8o07FpgWwqLlSGNUwqc4yhb5dSKLk
/nOenbrRCg==
=ZC+S
-----END PGP SIGNATURE-----

--klwijyhaeml73kht--
