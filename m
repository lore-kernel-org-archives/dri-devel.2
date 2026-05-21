Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8699CD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB4310F24C;
	Thu, 21 May 2026 07:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jmslYTsB";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1D310F24C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:59:13 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso76341625e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779350352; x=1779955152; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RfHyghQkuGkWqA8eUzVzPKJ2kyI5blFU5Z3V4gExrrw=;
 b=jmslYTsBM1xmGh249NYKz/ezIIDJ9HaWmAj/i95Z7yOvo9h/sl7kKVM3u1Ix+odVG5
 LwGTTP0YNabcinAJluQ3DsSg2vM6Tll3e4fF4kLYOVWqNVSr8Qeclr7ABknyZ9aNSgWi
 MrPOuBAIJZ5YbX4WLe7GVoE79WaUDVZjsG4iCRPrt5xYRAtmFUqKBOnhtPw3mUrGbKm3
 Bv4QQB8eLDuCzas6v3SNrcgHd2OysuMSUlWM1I+lYgEYmNVlXtTrg79L5UWh5w/16s1j
 5ulFQzx3APHCWBKdVquj2W8mbuOeIxwEdkup1w6lZm8up9mUUgW1SjHpLIwUB6V9Wxqa
 XHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350352; x=1779955152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfHyghQkuGkWqA8eUzVzPKJ2kyI5blFU5Z3V4gExrrw=;
 b=sb1CIeg+X7B28N6B+8AZTEj3Fbx4FzG8psr9tHQFQru7GyavbQ2UdJ5j9enGG/rVCg
 t/SLINO2PRHIbhqknRwY1sIzjYpzYs2WqCM4Qft5AVyRzw1daznf0USh4dcsojkKxSER
 Chzm02mf+dHSyrzgc9eoiPpnddHekVQd0+RIaxPXYk6vAU/fU7UDhAwn1DW3PFd8PC2+
 YlWfycN6RyOaN7nIo0/d1c8qa9fOiiD4oOB2jpjyNbxtShrgaxp1505S6aIl+96Zfuex
 Zm/gh343fkJre2ULhsORZ13fULA5HN9CApkT0teSbWRTnytgQzXBBo2izukFoZNjO+C6
 /kOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W2cD5oOApfnbrTF3Sq1svYQMxujeDF7tb+5S6ZjMwk+vgSTX2NHwDJsGBL5n08iDM/fL0RhYVVA0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzP1WLZs/tPfGs5zBryQuOX4K1FEt1cGtREqIiQjjHn/IHiGnfL
 q37EBtKnHS+BAseKzCInhfvFlbWUCbP4cBwONJL7QWB3zx3/Oech4kDk
X-Gm-Gg: Acq92OHM31oE9TSR+dbZev09ALkzBMr401F5ajFh1kLO8QKfPk8PrSDK0Lnmn0JftYh
 57sG10G2VRcLHeC+wehyeHeBRU0GvhAV0NtpCkOUuvg8cPtLH/g13gIbEED32FSd8Hilt6av19p
 /P4eJnTmMw0bkejLla4JFCSS8ky8nonpwRM9X1w5vpcc9PdprTvGL2tzSuwkDMhyTayZFB/0vCp
 nVEId82vXJYiV/vJTJlaEOkwV+uLblhddPUpUYwbeMGaDnNzTRwl7ysWnPtH/8gyiTW6UM7ph3d
 UpLdM8RCrSdLhG8cSWUCQAxvi1+7neGjK5Yt2XtvuZaOyt6uyWA1PwGw+lqOX8hPVuUe+rJBQS4
 3fus05scyvxaDEHzkbxXiIdMkvCO8dkEbzdI6nkQXe94aTx64o9awx3rE/Py0EsJTqvFpGGhP1i
 7s8bTYKACJDaECYUUnK9eQJaGElZZeFQMgXA554ENAXDb68sB9doEmFYqx8yRn8NN+tsEXazDNY
 nWWouZ+mLuGow==
X-Received: by 2002:a05:600c:30d3:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-4903605d86bmr12514805e9.9.1779350351689; 
 Thu, 21 May 2026 00:59:11 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490387d16basm5521255e9.35.2026.05.21.00.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 00:59:09 -0700 (PDT)
Date: Thu, 21 May 2026 09:59:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org,
 linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
Message-ID: <ag67FStKnQcvNOrP@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o4bqtknoba4e2ooc"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>
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


--o4bqtknoba4e2ooc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Mathias, Greg,

can you ack this so I can pick it up into the Tegra tree for simple
dependency resolution?

Thanks,
Thierry

--o4bqtknoba4e2ooc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOu0oACgkQ3SOs138+
s6HRkRAAqo5/UZ1fUVfF67PnLxU9m4v7JcLF4Ytf/Z7v087AEjfB1FXekO/SfEUl
dvex3+uqG9CIaSIQtQ8rxWgfEyOZeFirJloIENzJtaXACdsld465AHpQKBNbI5xU
/euNFiOwGTIgOHGhhxAIurS7F5Ag0WgWOTDN2uBlYGiDeuZShkW3Ek3M1WHSF2ey
Ai6uDC6tf03sgZla9uXS+eOZHkVaTx9pRDE1oxxHHLMtwgfkkl9BEHKxJ4ZqTYk8
6G5Bdz88LVtn4VWK2v/B+E6LiY5FJWuS2bM0PeRI2KpkB3F1jUy0rnC3OjdcMBjE
zyezSJsdMXkgODfA1zpIjGaAWjJ/wkU3ptsQ2EHq2+uTAji5OBUP/fquL+uOI+xH
WIHngd8r7BaBvygQpvVPl3YAC26qyRDmRqptWTXY/uISmcwmRZ6BaQTBsx1WOPmM
mFdZE0rVwRSfMws0GpPu6Atz++gerVHz/2EAFKPrntor6zUjSTbF3B42XCtIwpyO
T1Wmpfdvpt02fe1SjJvhkFCHzCv2sHvUqshC79KoN0gavq9732DOpJdn8aN8YTfe
GK4ekoKpjRZr5MUhTWGmRL0wrDNysBgOur97daSMrtrJNs+s8wlXA+9CP9nyICzs
2bbPfHWWQ78FiSSH8IOW/xAAFxM7aEh2UcHuajcX9pBLFwOnveo=
=ByYw
-----END PGP SIGNATURE-----

--o4bqtknoba4e2ooc--
