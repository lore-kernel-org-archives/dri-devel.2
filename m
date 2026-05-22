Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A890CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A3910F53F;
	Fri, 22 May 2026 10:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GLBrR/TX";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D23F10F540
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:15:37 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4903cbfad68so10474925e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779444936; x=1780049736; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
 b=GLBrR/TXb2/KUKzSLXdsQji15DkWmnBk75AusilyOQl5pyj9iO/TbWWSIV+6+kXi5s
 35EW+iWNbMDsif6rxLPIbeEj0uLYoqeSPDI4VebryhOx9d9Qe5YWs1TBIuUYbytIhzSj
 liBZ2LJWmjh0tjFMICLYf7p41g8g9ENf32eG94Pp4KwLeQXHCcSp9L90tvbQ+M5UdXHO
 5ag6IFUr3BJuY4pkwmtpUHny+orQt4AKgdc7jQT1u1j8mz9B5gD8k01zBAYaEvupoKti
 jMUj3ywTmspdcKmGUyNIxtwL+wd52QR5J5hJ15pIRHNldzw4I7AASYuGBercORLsX0R+
 27QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444936; x=1780049736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
 b=PIpa+1QsEpp6RUrpF3wxHGdnYkm6ldLFefWd+lwc60OKJTRskXJcbEcqkOmsZy0mzw
 PtRIDF3dlby9lil1hZHhz0ksC9laIoEK8YOjofkJLD/TXTyWbKi/iPRAcKdmCyAidRQu
 uENScXikPgPK5+p+OvmH3t5EjnFQle/T0aJZ+YctMI5/+yEh8V5ahPdYsyOds6I16dda
 AAc71gC8CJqg6Hc8+QIMHi3fQwZfPS7MNn2ruZv9tu5pYALTus7rCwWiJreyCeu7xFsa
 8x1cvDX2u/lPvfDrpybCBqk7LbWxjHOl3D9t/EheAk4HZQo21csVoOhxAd97QZSFz6bF
 +4pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qinbxuJiaJ+NN8sYTvE/go6+WZ27Q2wxXcORlMJW7FEp17smvrufUXGTVVShrX+TqUhk/oygR+B8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUad9XAJw8YEhOeQibUkMpA9MvJvAHK7SbhPV2bRLW69H+IDyV
 9qNJw5M4QsR9/EECxgA2vpX6bNrY6Gw5sFz+IhLczIb/Cwzx5J1ITdyc
X-Gm-Gg: Acq92OEX8V/d5yqi2TiVACbRnwPTPVgnFgt+S0/bM6u0f/MmMqN4e8FmlroPnQq7o9g
 bfoqz1m8aOEJ7k6BIcBt3ONr2gDJPWoZKI2ovNXXbVm/vcpw2iqRpwxAJHlHV4Wx/kLvKncE1ig
 N1VLbpjiq4OSOQYM7h9xakojVyhZaK7uO+FQLZ7DB1oqrTkV43G5HXeS3lkzr4tFc0St03W5Yn/
 d3PO9vefeeA7UkiK/wInKAt0aN2amuw8CaVo1k4TGn8m0cScNWhDUAix7MezXKNSXPAwRIDog92
 uf651LkxLT6r4xo8JUQdYT4zcg/yBdFbfQaaM+WTQPYqfpJWtnK1iHurGVRBs2NWH997BhraMkU
 hnBNPRh1qOmWLclYqJaygZwA8feiXvqTWq/01XAQMvdIuY0kdX3akZaYOdLx+A8zCc+zysSle6d
 T8AIWdOmy0J+gyDywD0F3T//++eGVQaOrHu9GvbecV8A6YzZqts5yzjYtjnQNYGmOHMv9ruxuMX
 GPJbh9LjlE6P/DFDK3d5m7J
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490426b0c92mr24655565e9.16.1779444935807; 
 Fri, 22 May 2026 03:15:35 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm30624875e9.6.2026.05.22.03.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:15:29 -0700 (PDT)
Date: Fri, 22 May 2026 12:15:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org,
 linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
Message-ID: <ahAst802sjuJr7-l@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
 <ag67dmFtSDBC6aPK@orome>
 <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qtz3f4pwlb7uchwq"
Content-Disposition: inline
In-Reply-To: <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>
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


--qtz3f4pwlb7uchwq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
MIME-Version: 1.0

On Thu, May 21, 2026 at 04:04:28PM +0200, Danilo Krummrich wrote:
> On 5/21/26 10:00 AM, Thierry Reding wrote:
> > would any of you mind giving an Acked-by so I can pick this up into the
> > Tegra tree with the rest of the series?
> Sorry, I thought I already replied to this.
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks!

Thierry

--qtz3f4pwlb7uchwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQLL0ACgkQ3SOs138+
s6G6mg//ZTSVOV0O5XnlSqUo1fdyiV44Qxo3ysbWUv2+O3w+r5WwMjgdyUM9yAbS
cdsRz3LHOAYcXBxYZhtdkLh5KhhvjdkUk4e1fdo/5QSGjRPARHPS3bQAZbnpZy46
tWvdiKwj2fM2rZ5JQHvYEjGCSQ9hGa/9Ri3OnGti51rcUbCJhJS/J1KgyJ/UOmyn
ZKLr/2FfTbmC8w0Ukki+CV3d4JV/pxY1UNjyt7x568o6JlebDPK6M7PKMI/IM6GW
fHt0U+f335ljan2LD8HZfSia4sa2nZJnbJDtIEj1ov6suhrowY9Mne4JQTEwjuLX
db6abSI9ox3O3vkx7Zd1G795TZUWTXKlw2SHr5vMyOBXhJHtipm7y0bAwj4ZJiAp
5ghmBQzl9HdBVy8x8x8SjmVCygxrt2rOVocYDG1/Uc5DSZWa8aa3VQJMK6WZy9gB
9G47X1VZPs9B/KeqE5TWRwB05OHuLeCIVQz8Nd06DjN0IEUStecgDWXm0bs4UNWZ
zMwz/HPgK4zp59HRlVqgoYRNrIRXCd5wmz5t+JdqDwbytna2YVTV7u/3FOGgn/rD
HgxwYqtJsO3KosQ3UN/HKPoEk67noCBWMrSzZbwFhw/DziZwEn4mr+slHKizUvrF
40Ir94vEC6DhMDCNJClxmU6S9zhRoKUOqW3FLyPgC1Ghfp5RQrQ=
=MZIt
-----END PGP SIGNATURE-----

--qtz3f4pwlb7uchwq--
