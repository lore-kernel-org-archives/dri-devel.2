Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2612C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA23D10E9D8;
	Mon, 13 Jul 2026 14:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="PB2D7BXR";
	dkim-atps=neutral
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558B410E9D8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:04:07 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-737de525d2eso3293848137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1783951446; x=1784556246;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eBW10Cfwapwvr0gihXMdckLTW8yiKSYBxKONjhqXCr8=;
 b=PB2D7BXRJT3ldCUq6D5Kv/1MFUr/JfmVttplMJIYuXE4U7bFUVHOVGqi0F1YYyQGCp
 rJRhOcYHmAc6xdRQOhStCXlavasouSjVBxVPaWgEJP0PLPLD52W9qYqZ6FEJrjv5sprY
 N4AlfYAXfft7gqot3mREvpcvZEbnXMtbeav18+OwSj7YMc8mrlkdtOAJwFn8PahbZE2S
 VIkanY3AkHK0A+O74PbqaK6oSQTJ9J1Ns6BAgSFLeXLzoi4Zu6KYIW5QFgl2gah9JOC3
 JhFGM33w+mdmWOokA4B97hGZ/sYPTAc0v7Cd8Gpdr8OWbr3GMyKOFV0HmxPLIGBjlbm5
 fOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951446; x=1784556246;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eBW10Cfwapwvr0gihXMdckLTW8yiKSYBxKONjhqXCr8=;
 b=LPOPFTkboDT/IZ60qDpoYK94aRFoDVsbR50Xfwkq6wNQ7A1VLrVnMo4qR4qWdKJvr0
 2XzVoPHjL5j+gai3GNn+YzlXRIcqE+JVb8z3B5y5Hawwg9IJlqzIX73w1UJyA3nlryC0
 cH1xeYUr8h4vhsdVmRm+FXqglLiWZ4jnQEv/6yuz0SgE9v/bRXm8fq4sU8QeMC+Xt10d
 +rtLbAQIbptrR9lg++MExpJ2UlywwiwIJiNIj5jfffMHwgt3wm4JMNqNZJfHQAUQoJt1
 bjcHyg7zxHE7LmM6ygGItw3PuR0W+8prekYQpxn5gTD0hC/Sd5Aanummlvw4Pbr/KBZ8
 TQSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDWrwcA47W3j4K0m96AEJZY/Z2gzR5Ar1+YoSvlk0RIdTSUvDV30E3n6VvPmW5gQMEe8tvL1o383E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9RroBegDT7KG6PB+xgXRLEZXuzAXs+IbipcOs6zYInimlX+Cj
 W0HLbcuYfLeUIDwNTXkV60AHmr16YvJd8q1+KwLbw5FghMn3D3R1i79pfUVOqbeF1+F6jyrU4to
 IZYX5lik=
X-Gm-Gg: AfdE7cmG9xXDez1NUQnl26OnLHcn0jBqg+dv5xwInTROEl5CS0oAuOILxCupx1KMX/E
 cZdiWYOu50x5EHchRnDTcvEeVdQto7QsWUBN/KHS20BFnTgs9p1jV4VVm/8Hilws3/yqF4WbIj+
 bkKskmK2TnmZmkSnQ4+HJbv+/aD+Auq1q4y/F+p1LA/01pBGRDFU8Owboiu/Nr5risxD0kgAuHR
 fO1ZZJ6r2OaT8BAp3c/NImXNEWiMuwY6UoWSVL7YUaelBo4C+Sw+AN51MlKuX8stDRhV+0dzvlU
 5x1ochnwQVzWU+TlAtlCdnwib7POj9P1gXEbOHrOhhr2d9x/BU6C/YhrHToe3G5MtZWQJ1pDU/T
 iijLh8N7Q4N9eWhG5XraqwQSytFTNhsv7rGLT03ymLHKtIrgWSui3UKffWizCpzUHKBDdfeL3z/
 aT85ZUsj8Bva/QmokT1Q==
X-Received: by 2002:a05:6102:8026:b0:737:2ce5:7b2d with SMTP id
 ada2fe7eead31-74533bf2bccmr6755210137.9.1783951445952; 
 Mon, 13 Jul 2026 07:04:05 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::c41? ([2606:6d00:15:e06b::c41])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-744d6a3eb8esm8744432137.3.2026.07.13.07.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:04:04 -0700 (PDT)
Message-ID: <5224ab5bffdee0777ecef73a3b96c88e8eed38e8.camel@ndufresne.ca>
Subject: Re: [PATCH v7 19/19] gpu: drm: meson: Fix DMA segment size limits
 and maximize allocation boundaries
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Anand Moon <linux.amoon@gmail.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl	
 <martin.blumenstingl@googlemail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:DRM DRIVERS FOR AMLOGIC SOCS"	
 <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVERS FOR AMLOGIC SOCS"
 <linux-amlogic@lists.infradead.org>, "moderated list:ARM/Amlogic Meson SoC
 support" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:MESON VIDEO DECODER DRIVER FOR
 AMLOGIC SOCS"	 <linux-media@vger.kernel.org>, "open list:STAGING SUBSYSTEM"
 <linux-staging@lists.linux.dev>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 10:04:02 -0400
In-Reply-To: <20260713120840.17427-20-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-20-linux.amoon@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-K7ZLBpNLX5/kwXKFKQKp"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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


--=-K7ZLBpNLX5/kwXKFKQKp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 13 juillet 2026 =C3=A0 17:37 +0530, Anand Moon a =C3=A9crit=C2=A0:
> When importing DMABUFs exported by the Amlogic video decoder driver
> (meson_vdec) for hardware-accelerated rendering paths, the DMA core
> subsystem throws constraint validation warnings. This occurs because the
> display controller master device lacks explicit DMA layout configuration,
> causing it to fall back to a default 64KB maximum segment size limit.
>=20
> Address these architectural constraints during the master bind sequence:
>=20
> 1. Initialize and validate a 32-bit coherent DMA allocation window by
> =C2=A0=C2=A0 invoking dma_set_mask_and_coherent() with a DMA_BIT_MASK(32)=
 argument.
> 2. Maximize the contiguous scatter-gather allocation segment boundary
> =C2=A0=C2=A0 check constraint to UINT_MAX using the dma_set_max_seg_size(=
) helper.
>=20
> This guarantees that large video bitstream frame buffers can be imported
> and scanned out across sub-driver domains without triggering allocation
> warnings or page boundary splits.
>=20
> Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Acked-by: Nicolas Dufresne <nicolas@ndufresne.ca>

> ---
> =C2=A0drivers/gpu/drm/meson/meson_drv.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index 49ff9f1f16d32..899e70bca4ce2 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -202,6 +202,12 @@ static int meson_drv_bind_master(struct device *dev,=
 bool has_components)
> =C2=A0	if (IS_ERR(drm))
> =C2=A0		return PTR_ERR(drm);
> =C2=A0
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		goto free_drm;
> +
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
> =C2=A0	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> =C2=A0	if (!priv) {
> =C2=A0		ret =3D -ENOMEM;

--=-K7ZLBpNLX5/kwXKFKQKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalTwUgAKCRDZQZRRKWBy
9NNdAQDmsQSLx7lRRr/0dmnss88GGZZ8T5JiUJHYnp57V3Vo9gEA5tSuLIwnYukh
D1WBuDEOFQqGktSq40CeUMEDMi1jCgg=
=9ZVW
-----END PGP SIGNATURE-----

--=-K7ZLBpNLX5/kwXKFKQKp--
