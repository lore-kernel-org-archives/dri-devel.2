Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859E10E221;
	Tue, 30 Jun 2026 16:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="VQ4fQe9P";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF61E10E221
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 16:57:28 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4939a809b24so31613495e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782838646; x=1783443446;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uEo+9Zz+UY153YLkrXrSlWNjLycg0uT83eoca1ucsBE=;
 b=VQ4fQe9PHT1N2f1sDWef8jwh3mYCIpBxAxADGBU7UR+P87OTWSBfRyXJ1t8f+Iy+Dp
 nQG0ZrmyInXVB865TOcIkEv0X+lXMZVLdlT3EyyW/D0veR0HO9X6IjW8QZ5aSRZ7nlwL
 ZEekEptBtsJKOdEBLUjfToHSWScnYsrVNaXHoxM//YmS6TJ9Rv2/QJuOhfjrTG0OrHrX
 GlAfmbtqPz9ofFRu88u6en0cd4bU0oNNU4rc7u16Bdn9sAE+/z2uPm5A21BA99uyq6VB
 roaQEgRcAsdUltcNA8E5tMvapSc2X14SyUlvdJvw2jDXHICUPkeUVPW+cykqJUtI2HeL
 /kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782838646; x=1783443446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEo+9Zz+UY153YLkrXrSlWNjLycg0uT83eoca1ucsBE=;
 b=KFIKi7ihZ6OqAt7Q5jew3MkhRULgBVs3InVEslyxWcYcm1WnulAuoHEJRPlIjYBZ6E
 ++gsQm8QeF+lkECTkvq7NK54wN8rBu51LG4QRUoKckQj6fWeOjJZVYOwoppzMNraYHR3
 Tea8TJkfE0VADADbFmxCpa3H5dDQ2sKC70aD94r8Q622q4DRVpJK0a4hhxigBGVEi5n2
 G7NIVVxRt0r94D2dd7aB1DPut+kNt2ptZpkSDDhLbjUfZUGITGF5cy+n3POYAokmxzR4
 q1zZarTdPP21ffYHuC4Miprtms2+YMcTkOVeKrt4gi0F8tS4NBW6BvsyJG5GOomM9tB2
 nP+w==
X-Gm-Message-State: AOJu0Yy5BqN1wvn4PnuEN/ikYm27u6U7rYZ4xiF6iREUh8I/lqlTUoP+
 dAaz2qCeWlX9N/u6rFVwfFF2GtfyyTCjPkUc4LoZNxQc2KKjDbtRRsWUEAF7x1j7d30=
X-Gm-Gg: AfdE7cmNgprvS3FX4g/i5kA8/o43eTgC2wtYcteiW7YVqDQ1kPeCJQfbn8kpQjN8jXn
 8uYVla+gfIIpJg0A75WSOJxa9q2vrDGuKMi0ZR8k4gZnhFWdyG2znytXnuEvVQwQ/R5vvMmFtwo
 uWUCz0iukofvQaWvrCpe0KK9q699+iGzzSj2j/F4W1QzQacDJu6CGtEoAQXc4TSl6nX8JZ6+Kj2
 ie+eguUaXii6eTGeAObPrWqkatM9FxIAo6E6RYk8fsVb6+slhQVBk353dYrVxaDLEqfBbTutGIz
 QNpklNTrvWd4YMoO75ubDyBgO/3D6d/Ud/DGmPBGTILa5zb9cl5Cyps2b6PTFuWoej716N4Qxkq
 TCY5xlupKqIyk7qDTtVZQ3eXCIJOMmby3jm5FXOiSHVMRCgdMTl3YooGfhqitxXIdNnI7z4wYJL
 pvKc9R+SZa2OL7Zl8wJrnZ19npMENy2PXbTMf3dMZ9Ee5IW7HAiShqpNmqVJ5gjJ8Dbn4pTtX6I
 Tdu
X-Received: by 2002:a05:600c:8b72:b0:490:bd1d:4732 with SMTP id
 5b1f17b1804b1-493bda9e99cmr21000895e9.23.1782838646492; 
 Tue, 30 Jun 2026 09:57:26 -0700 (PDT)
Received: from localhost
 (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493be4d2945sm8754325e9.4.2026.06.30.09.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 09:57:25 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:57:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: mohit.dsor@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 boss@oss.qualcomm.com, qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH] drm: bridge: add support for lontium LT9611UXD bridge
Message-ID: <akP09iE5qbwSbUDQ@monoceros>
References: <20260627204125.3334834-1-mohit.dsor@oss.qualcomm.com>
 <20260627204125.3334834-2-mohit.dsor@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5vsqiqdgcn4awnen"
Content-Disposition: inline
In-Reply-To: <20260627204125.3334834-2-mohit.dsor@oss.qualcomm.com>
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


--5vsqiqdgcn4awnen
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] drm: bridge: add support for lontium LT9611UXD bridge
MIME-Version: 1.0

Hello,

On Sun, Jun 28, 2026 at 02:11:16AM +0530, mohit.dsor@oss.qualcomm.com wrote:
> +static const struct i2c_device_id lt9611uxd_id[] = {
> +	{ "lontium,lt9611uxd" },
> +	{ /* sentinel */ }
> +};

Please use a named initializer here, i.e.

	static const struct i2c_device_id lt9611uxd_id[] = {
		{ .name = "lontium,lt9611uxd" },
		{ /* sentinel */ }
	};

See
https://lore.kernel.org/lkml/20260515103150.164887-2-u.kleine-koenig@baylibre.com/
for a rationale.

Best regards
Uwe

--5vsqiqdgcn4awnen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpD9W4ACgkQj4D7WH0S
/k5lVwf/YgUXANMDowgGfUpS5Ztlvcj8jy7P6tDSJ+Ap3AIMSeF/f5KfRXVwKlgq
6YBq+34UTSGNU47BpLezdfQls1Y9dr9ovFhIgAr2P5+BdSzpLJuxXVdon2ivpueg
SmeQu9Rfg9zBJUAgzaPxDhlw8YWWrpPGU667rZuNmf1pmPZso7GOD39aS8hTB+G7
MPiPDheORy25dcDjoMwf/Z7uMZq0H62Sb0KKM8vUlvpEd0SfinOQahgwSM7oZPeR
a3mk90Yi9MeaX1NrJRnRWDHP72/MplhKkbo5xedW70N0sTMFPIKlptDx4dMo2G5i
WOWIRw2t/tstAhMaS9d97lVKtWg+Hg==
=hRGa
-----END PGP SIGNATURE-----

--5vsqiqdgcn4awnen--
