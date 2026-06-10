Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217B8CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA0F10E50A;
	Wed, 10 Jun 2026 17:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="op9L4zer";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BD810E50A
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:15:29 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so5284161f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781111727; x=1781716527;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy2QNS57UCD2GYWcmkCdghK/35X06/sNE/jHUTsf+Qw=;
 b=op9L4zer7eDSWd1mssfWTffzJhvb/4fv746Ow/jauSDKwCjC603Sq8Wb9kCElpkdXb
 mB6tGHnqkqQjxKKOVsdzK5O2w0kPaBAn/yvF4AZccdk/qd7tQe5TIU6C+1Yg2/R+0UIZ
 DSoqeKBllAo9TzNHNMbzjs9Qs88nDE4Ti4ThEp183FN669SIZ/0kK/E0KtMOHqKhe0gR
 iivP1Bbu01oUw9MBqcmpVlOF3gY+6RA2SOo04V/wpopjjMJUrFxTtInUobLMXmh/fXVW
 H6Vghm3vxRPPrTr4TTaYDuVkcXfFJk+MOplt9BmskWyB/VdXDxi9SymNW1lK0cpIXkkK
 T63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111727; x=1781716527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iy2QNS57UCD2GYWcmkCdghK/35X06/sNE/jHUTsf+Qw=;
 b=lZ5RuKLtmi3NJS0a5VkK4cQROiQK3iCvJX2ipxHOebbBZLmCw6hYw50hZZ1K7d4o83
 29N2r7v7u0xu8eHkY5WMgBi+F2ZE9CDJsOYvf/CldfOkpOooilztvhlCiNKpZG8/XFkA
 vFYyAl7yRP8s6Z8V6KxY74htUr1TYE9qehSJDD1YhpuDp7VaO2Z4IE+FoCSyb6Wx2vjc
 VxA3WekEW8aY7SRvX28ZDUU8KFha3/w7PuMgjyTCyB7lHrNRAkmM3bbtfQ8qJDgkBgBD
 Ga18UFKw33/KqyEs6eZ7Dt5cjIO1m1UeciXZqstqBcI5d/Se/Qa3nihslHh8/hRygnEW
 Ge0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mZjQvz6hWLUsGIoD/CRzZ+DKf+IxUDWPrvudzKE7m5HfMh2TQb2dah9FKA1k2+Rz8xs/vAlp111I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw90qhaYUY+bTCwcR3Cs204mJhzLQiZb2HfPPabJzQZBwEvIDLz
 IYRRuEIFaL+y1U9VdRIidNYGWijPBJonOzqCNH1VcyMHlqBHzaMfsxRGmzBjv2Rp+1Y=
X-Gm-Gg: Acq92OHc2iwmwXocYJiFNTPG6nONSjpp75pce8WcIFofQtdke16FcVgaUxHCITaFXTr
 d85VhgdWY1fBnQYoRGv+hLcWMcee4eP3Zcj4XIDHyrkGi/tvIc3BKzXvO5BFNecU5QKWIvoBld0
 tY7B6T09IaCyFsaw6AUuuPpAF+ig6OX/E+zK8sTyovMxvxv2QqJQhtubQVvyWFDJRkDb5tC7grz
 TOPwNrZMDM1vgR93IoNbi48G6pcadyrBdimoStHub4RzmTuTRcWQVvHZgTmOEQx594i+v+GpHi1
 vTqjK6w46RzVamblFtjjtA5li05YsXBUhnjwKZAsgmq7xuf70rfEGCVu3YQG5lGlv2cY4ryLFaf
 khtrVCJcm4KUi3++0s9/8+mHTYRAz+PwhEbHIu8N/IQafZ+lNTD4hkR/QHB8V1atAEowIJ+ks7O
 5Ln7FT1N4HIVuPJJDekD6rSfTHSNgOxyzro0kITq686/wI0q6j5v3GaFreu62PyIh8GbBBO8VP6
 hPAUIukZR067V+fqYVDCXnHEg==
X-Received: by 2002:a5d:4252:0:b0:45e:f684:7347 with SMTP id
 ffacd0b85a97d-460302e711fmr29192231f8f.12.1781111727249; 
 Wed, 10 Jun 2026 10:15:27 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f351d69sm129389556f8f.29.2026.06.10.10.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:15:25 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:15:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jagan Teki <jagan@amarulasolutions.com>, 
 Liu Ying <victor.liu@nxp.com>, Adrien Grassein <adrien.grassein@gmail.com>, 
 Peter Senna Tschudin <peter.senna@gmail.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Russell King <linux@armlinux.org.uk>, Douglas Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Xin Ji <xji@analogixsemi.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Fei Shao <fshao@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <kees@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Message-ID: <aimbWuKkPZdKuO5f@monoceros>
References: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="syrxtefw3w6ze7qy"
Content-Disposition: inline
In-Reply-To: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
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


--syrxtefw3w6ze7qy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
MIME-Version: 1.0

Hello,

On Mon, May 18, 2026 at 12:04:01PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>=20
> While touching all these arrays, unify usage of whitespace in the list
> terminator and drop trailing commas there.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

who feels responsible to pick up this patch?


> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
> prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
> prerequisite-patch-id: 1fd68e883664147052540eea19769ea9e92d0138
> prerequisite-patch-id: fff07090df18a39a361bbb091a3f17223b4606b4
> prerequisite-patch-id: a935aab66aa9896437ab9d757ef9fdc859d22495
> prerequisite-patch-id: d0d54f7acecd560cdeb6ea0c0e5ae77a50695d68
> prerequisite-patch-id: d7876560b3bb9b05ac462d0a9b09b50efeb9b5e1
> prerequisite-patch-id: 65531f0504ac1885c6c4ed6be0e6a206a9795d5b
> prerequisite-patch-id: ec83e7e18d66da9ca677b5c8180a22bf3717c8fb
> prerequisite-patch-id: e33193d1a91f5819128db924c080caf1c5198667
> prerequisite-patch-id: c8862be402a445f30b9f5c91b07afdc840e7e21f
> prerequisite-patch-id: 33c001d1b8ecaf57ebe53c321d82d671bc82b647
> prerequisite-patch-id: a59a578f49eb5147623aab9fdcacba405b9c8353
> prerequisite-patch-id: 5eef512b8a5a1ec1848a939928168dbb719ca72e
> prerequisite-patch-id: 04746bfdfe146af71d0c41e225978fb42ce977f5
> prerequisite-patch-id: f8aeb0b768ae718aa0dab188fbad671aa4c76501
> prerequisite-patch-id: 8e0b48a5d5f8bb91933d440eda8f065590e5ca97
> prerequisite-patch-id: 5ca261e980415013434edc099b6f741b7a96c7a8
> prerequisite-patch-id: 912c3a7f7fa847c59d499e004965b805a63c8836
> prerequisite-patch-id: acf784c7c03d3cd14a8a19610a6d8995e2b5da6d
> prerequisite-patch-id: 09a95efff7875781ceed199c60204a2603960f4f
> prerequisite-patch-id: 8051fbf0a60e5e9d34f5e7623a5159d32fbc511d
> prerequisite-patch-id: c4897ca0762d01cd5e8cb6e761e5ad95eb9de918
> prerequisite-patch-id: eb0120090b9fd1e1f668919cf1d81cdf1b684b20
> prerequisite-patch-id: 239c0e25dae78755bb553eb9049190f6ed6c056a
> prerequisite-patch-id: d988f27ca0fac3a2b06cc8e465aef5e0a4f09bd3
> prerequisite-patch-id: 8fceffb98fa11bf1e709a51022afa05eb12236bc
> prerequisite-patch-id: 3575869dc475ff7191d314632d496cc67aabed53
> prerequisite-patch-id: 8916058071bcbde1a4d06c6a8981c443132168f7
> prerequisite-patch-id: 7f29acd91e1c8b8d4f21152cbcb8a8b0bdb6f963
> prerequisite-patch-id: 65cf39c97cc086b6a89965079cccb896f089a0cb
> prerequisite-patch-id: 915b7a2276c5a38944107c84bb282271d0bf28f4
> prerequisite-patch-id: 76d499a624150588f7ef07dc087e70eca6f33419

FTR: These are bogous, there are no dependencies, I just wasn't
attentive enough to drop these lines.

Best regards
Uwe

--syrxtefw3w6ze7qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopm6kACgkQj4D7WH0S
/k64IAf/bZ4o+TIFIOWyuTVAdkHqAJkFGW6kNqTKAFMqC3TZbmVRyyZwNTDTpsk0
UdAe5MrsNhDs+DykrkP9EwzgLbmwcm2kCjfT5NruyBaQv3EDbtzj6iUeT2G6QJTK
uwp8RjuEHX4YbrisgPnOvJCGXCGHNlV88/vl/+xdD8zuMGUy30vQRjUTWgkpmaWD
gvHWpF3hZH8tjCyxln877iFtgO3Zv5iVBHnfcQiILsApXG3zNtzjn3hI5vz8xDKX
sJ2mkRhDuyQWE1wmFNXahNn8fjsCUnrIBpJZHNbAZ3pZwpRvYfYvj9hnMPu0Phd2
wc5r8vL9Unrms0KBeU9RKF1lbK6OXA==
=5xFh
-----END PGP SIGNATURE-----

--syrxtefw3w6ze7qy--
