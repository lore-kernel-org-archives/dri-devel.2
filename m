Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2481BCD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3825D10E464;
	Thu, 21 May 2026 07:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="naeCmfL+";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE6710E46F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:57:34 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so3542412f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779350253; x=1779955053; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gZORxaPdJSDOgk8ANxzTl375l5CvuQSqBLkQk79bozY=;
 b=naeCmfL+YEmzWgK2B0CE+wXvFDJDOj3nmctAKniYIUN7cKPbOdHEEVP/MIA/XaQozD
 XdotckIm+veGAiZHcoN7c+yrLDTAPx9t1NegZaHJauRoCJVqfdZ3qzU9Vd6Mhc4fBRyw
 1/B1+M/pTPmljkuEXQrWfB+AGniVXoZ3+kN4LBa82or9XS1hwwSkQRGAtBTV36UIotaX
 7SDzH7egt3e4ZsN6T/wherB6rGvMNcjGQs+pRuOx5g/gAtaoIuRLsUeYFwRVmB/dvj59
 HTo+T9uGaZNp/VL7HijC1KgkQUj8Nl011YRUFr3mg/AqlDK7o7W34w8fjfCU6p6tcwqZ
 8bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350253; x=1779955053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZORxaPdJSDOgk8ANxzTl375l5CvuQSqBLkQk79bozY=;
 b=bnWrfbp7zUsNpZzH9TB64FK2XB/xy2l62nEakCYvvt/PgWP3EXS3uZl3R5jyxv+U4d
 02bv4E8fI+VtHbTpLugH9EAOr5YSTzwnsBEa6Gty3yLg7ju3d8lPXyk6n7hjmeilxSfG
 Yy/0NLpp/6U7NGHQVdsBbAAOEj6FNJ5ZoiQpT1qXj5I46yfRZ0A69dg2rtL+pyGG/MUO
 QyXz5cLzeuCag7OfaPnig+njVtX9HzwP9GEKanDs1/DZoT28kOqDvIFHbVgyOQOjHiaY
 sS3XNKBCtz/lfNBft18DKwjHHYHwf9dEChGznYJry4bhK5HKZ7AnsGcnxEn6WeLIbpvw
 mtDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rqNYn6G9L4zVzbNdSo607e8kXsmzQkqUXgkETku/VSVR/uKaND1YNm1imms5eOBuD1AhYHt7lE7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxwqsj21PKljAvDvzEoz6buU4lrZeWsyJu0cWd+wDGJCQJUQ1OH
 EOxHXrMwf3LZ4lMnNu8qyi8W8H3QsEnMr75bp7QspfCz4aYJLV8wuVld
X-Gm-Gg: Acq92OF5Ngn09OlSDdq8Ox+Nu6NI31gLle2sW00fKdMJMIjHIOINEUGob5g/85M7Yba
 3KP4ZdmpTpeYMJq+tM5KhrPq1Y5zwf8U9kozuhT7Ri60+IaUXD283szombkm71vsqI4Z8bu11PG
 nzBIMhgu3PawEDZrWUg+14cSYrd6k3NTg3EWH9q5JWDPTXJOU4wkHK6zxmGbW32PTfukvM6hitj
 9cyb6E7eS2oiHzM+qHmgM4sMwxHkV380h3P3fphxQ8qfJZk9vqOG4nLS0DWtcdsuBmkGDaFMa2F
 FDLZn9NmTu989xS1ScUQsA6xJwlFOHAt7ocA3Q2SLLcKA/b0FfFfv3Kvh13zaZrNhk67xBm1T2/
 rQ/rO9/65kSxNYZ8FPlHzfXG5Cn1EhSIrwpyJ2vVi+VUCH7eGHVaRv1hS/yEPTAi82jOQJAh2fb
 aLsW5cwbjKmefsUVtiEoQtVNdeAUWMrED8DjmcKq86mT7z5JSfUvBJeoQd4DJsIsuZIYF+Vws99
 VJeeB2d004t8A==
X-Received: by 2002:a05:6000:2583:b0:45d:3cb0:5ab1 with SMTP id
 ffacd0b85a97d-45ea4141e17mr2803411f8f.38.1779350252817; 
 Thu, 21 May 2026 00:57:32 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7dd50asm821152f8f.15.2026.05.21.00.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 00:57:30 -0700 (PDT)
Date: Thu, 21 May 2026 09:57:28 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
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
Subject: Re: [PATCH 4/9] media: vde: Explicitly specify PMC instance to use
Message-ID: <ag66qZ6rLOeUTWV7@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-4-a6de5da7216b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ufnilbb7pbo55sdz"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-4-a6de5da7216b@nvidia.com>
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


--ufnilbb7pbo55sdz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/9] media: vde: Explicitly specify PMC instance to use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:55PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/media/platform/nvidia/tegra-vde/vde.c | 15 +++++++++++----
>  drivers/media/platform/nvidia/tegra-vde/vde.h |  1 +
>  2 files changed, 12 insertions(+), 4 deletions(-)

Hi Mauro,

would you mind providing an Acked-by on this so I can take it through
the Tegra tree? That'd make the dependency handling a bit simpler.

Thanks,
Thierry

--ufnilbb7pbo55sdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOuugACgkQ3SOs138+
s6FbKQ//aRQbgwr4ztzl8XykZ3VwYpBsUA5hzUjDURQkJFNdwnkt6k1kBPuF6tMI
joUObtuboDDZBD6T1W1CWvCKqzBPwDlmD5hdckRGlbau3ug5Z4HYFpTEoO2VPhr8
kW6mO+oE+5Jq2I4kEfCg9WfotOOP15ehuSzn2JRbKZDLC9l8/Fyo/7nglXyjmoJk
qgD47vfx8/zgrE/Fv9M+eGdeJzh0XxvRrqWYxe6wJqlFCETYNH38hb+CBfIWa8HR
Tzoa0rmTS4YRP2+p6yeckAN5IWgSx7ZTbCMLLoJfyjEbCUf9Y3ymi7DNWHey2gi1
SY1ue+l/i2UNavChYqtuBV9YOfSyM0PWRQja4YeSMSIK1M7mLfta20LOo37A112O
BN5tR5zmtwiKW5ZnAReOMcWJFLobWu9+ZlbkiyQ4yiONh1truDHgwBOssPfCK+/Y
ejeJGgdzWnlgonVwEp80tLQsNZN4Nccrmnn5JPaH1maEC+eJBtP1Y6V+io/28QFP
YE+W8gXUwm2BK81TcpIw6qswfWiBu8WdGeCx9j5X+mbo/jNWboIo2l0AQxtbCyGm
LiYJV+w1iEWO3WWQKymgmwRdhT/QfeS4VcUikTrZG/NrcIEpVwuVk4syKobUx9Cx
DuSlIPt97hHCjwAaF6HZwg809a+jTrqXPBq4VlYvkjefZNJAiMA=
=2vYi
-----END PGP SIGNATURE-----

--ufnilbb7pbo55sdz--
