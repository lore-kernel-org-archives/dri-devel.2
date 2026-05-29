Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2195CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF8310FE68;
	Fri, 29 May 2026 12:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWqNqmLt";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C2610FE68
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:30:40 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aa5ce4904eso308577e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780057839; x=1780662639; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RKvGtal20Qw6UoC2q1rlPNZH8iLMvVd+YalFphindlw=;
 b=jWqNqmLt/FsRx64NZ3jRhElW2bHGoZrgdSYtUK+KVaaznDDu/fZCLsCayM8i6Y1O7m
 xHsQZjFF89tFW7g6Mh/3f5rOT0ATHvXVPQh2Fnc5bWpzDETBe51+KAs0v1Iz0ZD29xZx
 beQovfLspPyCKDwrP5Md+jPw3DyJUmiB+nvrHp/QA8IztOeg+1lG8BLV8p/ge98nhq1O
 VBsY/Epz9eQEp5z+jLbTD55bwyGKn5GJjVS3CM2EAVEg+pzejBjiH0gsNfPAPdoEzjWW
 BY8oClDCKgXOgJiiUAO3G9A8TwJW6xhIE6TpS2C7XxfwHpxsTGINPZMWgcaGRAjBStN7
 RBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780057839; x=1780662639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKvGtal20Qw6UoC2q1rlPNZH8iLMvVd+YalFphindlw=;
 b=S0hk27o8yvuloP91yVs9scqCjT1I20qOLCDFIHg9SDK3HAh+w+y/gktreG9Zg2iMSo
 Jr47ZXRJhcQJdUSscyvIeSoRnjLalt8ALKAxtLOx2QJRr7SremwGJULnQ8vbosTNRUBF
 dCFoGLILPNPfJuBDVyPS2iDQjMc/z0Z1An41ZHRm4b5aRqLFa7NkudByFejB8PDtGGsO
 4DBbHoZnZ434CJa9djPt/sjyPfZSzzqZ+J1olhdFj9AU3MBNOYorq4xRqjq8xLnuGGly
 +FmUBXMfjwbrPmVtffpTsMdTnEbtMfyZo5BGK8bXEwwSZvWAnxd0dPRXwic8adjK5gU0
 fTWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+QH5uQ0G2yELglIyQlTXQgQFgXTNAu8UaqapSRPGkOokbysyzj0gFN72D/JbaxiGRS+CvUf6nTk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhlKlvtgZ9ByyG28zoJefEemR+c+yuIj4cAzRpKCd1b5qABZSV
 BYuyi01zRy4LuO2ElCgSzte77fHMUX68HBdfn4y7bqMKDv8/juyOmhQO
X-Gm-Gg: Acq92OHbnlwmfw6nU6Qwyr0B4KV0qonT/edsgvQ7aFTGNDJHnxxY9Qb3YO9iLmC+FEZ
 fVrDpPYgrjQYGMfkJXJccz8C0gEOo7F+pbDxRmdcz07mQYd7pAcjanpr6qt1o9YujTyGsnOPb3K
 WdZbrxX0hq62OeGtVvIDLt/hbyNGQQEJXnkussIMs6DczFe1UMFdm6pXm4djud4J6yzgx4D33Nb
 lqkTqlv3BJLj30tD40UploDeccHEZpWJ5omoRkISrVmmmlifS3+pnpomFRRJBJL56ldFATj/OCT
 RMJbyJtWWuKX3aPPmg9A7y/YcqCBO259/LvFo7fAh+Gi53Dxk+2iP/7nWJAyIIfdi6ZRfPxP431
 Ve/jdDe/qB4KONhI57GbWpRTe2mmbOdjZ8ASoFjLLVcqtpyQQV0A4szNd+dV7P34YWZEbVno6Wh
 QPGoL6Q3EFH5MAsamXQ5uNT15g2Pb6u9s9bcVEks92t8+350huiaSaR+24az99IbndN/PHX9dvr
 e6YQSj362O1JALRUpze/KLA42ZyBDPECyk=
X-Received: by 2002:a05:6512:3407:b0:5a8:847a:decd with SMTP id
 2adb3069b0e04-5aa5942c555mr888849e87.6.1780057838196; 
 Fri, 29 May 2026 05:30:38 -0700 (PDT)
Received: from orome (p200300e41f1bda00f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:da00:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b00a5f4sm260919e87.0.2026.05.29.05.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:30:35 -0700 (PDT)
Date: Fri, 29 May 2026 14:30:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2 RESEND] gpu/drm: tegra: add DSI support for
 Tegra20/Tegra30
Message-ID: <ahmG1x5GtztLg-CP@orome>
References: <20260511074538.24563-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ugsdrugixr4n33iu"
Content-Disposition: inline
In-Reply-To: <20260511074538.24563-1-clamor95@gmail.com>
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


--ugsdrugixr4n33iu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2 RESEND] gpu/drm: tegra: add DSI support for
 Tegra20/Tegra30
MIME-Version: 1.0

On Mon, May 11, 2026 at 10:45:35AM +0300, Svyatoslav Ryhel wrote:
> Tegra20/Tegra30 DSI is quite similar to Tegra114+ apart MIPI calibration
> logic and clocks. With a few minor tweaks, existing tegra DSI driver
> should work on Tegra20/Tegra30 devices just fine. Tested on
> Motorola Atrix 4G (T20) and ASUS VivoTab RT TF600T (T30).
>=20
> This patchset depends on Tegra20/Tegra30 CSI bringup since both share
> MIPI calibration logic. Ideally these patches should be picked after
> CSI bringup but they will not break anything even if picked before
> CSI patches.
>=20
> ---
> Changes in v2:
> - removed all MIPI calibration, it is handled within CSI bringup
> - added per-soc structures into of_match
> - added fix for hang caused by register access with uninited hw
>=20
> Changes in v3:
> - switched from version DSI to boolean flags
> - added comment regarding Tegra30 clock configuration
> - commits were picked:
>   "clk: tegra20: reparent dsi clock to pll_d_out0"
>   "ARM: tegra: adjust DSI nodes for Tegra20/Tegra30"
> - commit adapted to recent DSI changes:
>   "gpu/drm: tegra: dsi: move prepare function at the top of encoder
>     enable" > "gpu/drm: tegra: dsi: re-add clear enable register if
>     DSI was powered by bootloader"
>=20
> Changes in v4:
> - switched to device_get_match_data and added check
> - added comment regarding Tegra124+ quirk
> - adjusted commit titles and message formatting
> ---
>=20
> Svyatoslav Ryhel (2):
>   drm/tegra: dsi: add support for Tegra20/Tegra30
>   drm/tegra: dsi: re-add clear enable register if DSI was powered by
>     bootloader
>=20
>  drivers/gpu/drm/tegra/drm.c |   2 +
>  drivers/gpu/drm/tegra/dsi.c | 126 +++++++++++++++++++++++++++---------
>  drivers/gpu/drm/tegra/dsi.h |  10 +++
>  3 files changed, 107 insertions(+), 31 deletions(-)

Applied, thanks.

Thierry

--ugsdrugixr4n33iu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoZhuUACgkQ3SOs138+
s6ED7A//cJerqjiX8am4Jd3tndfUpExblFmlthrQAelKsGPTaEcB7tFzABRj1vIy
u1EXMrk4xBMmPw/VNY4HG5hK/mnGzmcUD1HO52X/dKCAVWbbSO3NJ5exA2+Qrag/
8qRP+YHS57dJEtO6yb04+rejedAd0QHIr0/Oim3qmthtBFzDb7+f2YqXTNtOhLBL
SFLVvaYTUNTdgaHQCOVkU/GCbpag+ylV6jG5+mSpfgXUirbeqhvgP0y4+zJubUzC
W6mZ8zRGG3nkC9clSNlyqP/4eUfATiwLR1AtCrCkfTcArNynT6Nf2m26MZbnhp6/
3spmOYASeH1YvLX/s0G4wNIpIbmwm5Nql4EgFUOGUIZrCDmTJORAEFcrTyj02fjp
U6U+IhOkMj9185wDPPoQOGCqg6KtdN+ZhQcKeVXJEbHWqrN6Ad7DyzVylwuep3A5
R3KdsdUKHBSeIygIsW1I87Q2Vx32HYUg/9oHk2zbrAWY+OdrSgaxhijD7rTHakTG
ryDYHHuC/mZSY4QGF63m4zKRQjpBecb/zZm8/dAt3A/CTAtWCVJarPcp7gRB974I
Gb1IRoNUPbEZ4/vIJY1YpDGpcalb/vp3hC1pI4zwRHJ+Acpxdhx7sov9sm53/DM/
BaBTswD1Ef7cjSCKYE1h7/QaimAi34oGDw3Jjt/w4GAksFXgYUY=
=ZtnO
-----END PGP SIGNATURE-----

--ugsdrugixr4n33iu--
