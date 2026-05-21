Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085CBCD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A7910F24F;
	Thu, 21 May 2026 08:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwRP5ujj";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC3A10F24F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:14 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so2552928f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779350473; x=1779955273; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CAGm6nF0wdUN0d2423OYPWZUGqBbg4/Jc7nYqxEaHM8=;
 b=BwRP5ujjd79n0fkTQAkcReLXLRzMTHZ1MZIpAJiJnbtjPpsAe2MW6Kr9TQ2aEu/Lv7
 5RbUl+chVm8F8OUip/4bkiZwlLAdSTiobdE4VHnh0bZy+CuzRGlS4MuzwUxcKBL1fQZ5
 LlXIDvWi/UWTJ/2TasAaIvnQ7FtKRMhRREonNEhAjrh8hjX6hoc0K1MOywy+SBALGsON
 TesyoyKQ3cRO+QKhulI6QGE8yqbDcnBxJQGKQqKFQFNyEinVaLcRZLKFFvaYt4LIaXRn
 jqdnb1JAYP/F+2Lgdp5qal+OZt9fLZziUYAOkz2JaIN1ALuF4RGDnNCYb93xHsKht7Ks
 hxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350473; x=1779955273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAGm6nF0wdUN0d2423OYPWZUGqBbg4/Jc7nYqxEaHM8=;
 b=oUYSyIdhBETLGJHC0pEymGZSZItTvaYN4KwmBWR+k/8FEDjOrW6f9jUrw65Wn7JJPI
 oEaYgnuMDGdcN7MFqT+MBYOusPrKiJvNEqUybjeZP6zvdy1uL01NTjytM6+8ZnLmPBcH
 u7YBBSbQMtxjM83h34BtYpicPkM//pMSGWJPhAj2yyINVLPmjgY+v3eQvrGi2UfnTsPL
 j89E2ZQzLts49rrTfS10DrjzlwN+1k7k1eN3UBisHiMLW6G+yO2xumV+3oZl8yp5pO8M
 H9xvhd9JeUx01jIyr3JvD4PyQTgY4bjLqno+9mKkBrO+nXkInfWcmXiDI0VomcrKoHJC
 J3hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Zi13xOfAbnxc0FAdwnzGhxZaI+gGu0gfZfQD/v3gDU9W+Uwg2Fo09sWYyCxNctiKhZGyDrpHuRkI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxP4eM43Z6ehK3aEBqJpOGzgxCXLo0Nn92Foc2V4vhHrJE23lEz
 mYXPxTYbwwqFGP7kgTRqyKuNRvPPunRdKD8XPgtpvyG2I8F29F+BqjKI
X-Gm-Gg: Acq92OFnDN6H8xmz4QoJ0oiFn3TMUxlIdNokOVglignDvlazINV5Ly+ZhCgotiN031E
 GgiZE/HoKK8aQvSV0oXRekKyOmlDZj0eH/wCfLvEd3ndyLtexWOxM6JKr92AQuFuSclU8BNuEnV
 ZKVAUl3gdqPoeDEWMSUDIQVuj6JrC3LkIeTO8SS8mttJxaqHLhOLRn6J8gJk614Pd1hYSd9GTtN
 W9u78pvZ7HYoKxsj5sy7j/il31ljoGCyFUA93yqkcM4OGJ1J5UQmHWMHSD62pt4SiBj7YPZegPm
 VAxLvj+5Jn4pGQ4BvAQtEkOxXg947I+ihWTyq7o/q4TFKAnQNDw2hlR7YDG7So97g6jo5SYFXJb
 GvSK5JpL+W2UIe4gOtJHkLmyuh8cor0tvNtt3V3IU9UIgNfjGi2h9uglgiRCSwzzGxlF6fMdE8A
 PtZk0fIGbivjXrI90QhzFWUefjvdv255EN0K2F/J4qlhAkwabEobUg5YSBTQcaFjE++5uAqQTG2
 W0qvvfjai24SnVUlKO26F2e
X-Received: by 2002:a05:6000:4027:b0:45e:a0ab:8bc9 with SMTP id
 ffacd0b85a97d-45ea3dead2amr2513624f8f.41.1779350445635; 
 Thu, 21 May 2026 01:00:45 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7dd9e6sm857662f8f.16.2026.05.21.01.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:00:44 -0700 (PDT)
Date: Thu, 21 May 2026 10:00:41 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Mikko Perttunen <mperttunen@nvidia.com>, 
 Dmitry Osipenko <digetx@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
Message-ID: <ag67dmFtSDBC6aPK@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5oal4jl4ykfwr5c4"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
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


--5oal4jl4ykfwr5c4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:53PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h  | 2 ++
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Danilo, Lyude, Maarten,

would any of you mind giving an Acked-by so I can pick this up into the
Tegra tree with the rest of the series?

Thanks,
Thierry

--5oal4jl4ykfwr5c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOu6kACgkQ3SOs138+
s6FK8BAAgs0A7wFYJOVZxTTW6MNa4zXSjm64uXobpTYaWzKll6wOHDvn6C9dcp/v
MLtSLfP1p1SW/dO74lgYcFcwNaDIZdDsJZmNba+3Jf6PpFLkFdvor5IxklQDCq7p
CTff6BCXl8nTZkHm57wdzn9MMiduUUlKEc1foNpP34dKfb148QjLYdxi/2hFY/ap
VNo3Lr54eMkr3RXicgdgDHq5TXk2gKfSdy+Tve1QiUcemkc36olxR3tcgVSLxPJC
Q66EiKj9g3bjK+fEzB7hA/GeAQOfpuUIObaCdcASbPeCBTyZJY23WbYAF5XMMRDs
LjCs2r/E0EtZLwKY0NGBEZjwzWxF8PddUoqi3TngTTfv/EJ4qx3QzqvAf2DIVKsA
xJgxWd1rDD2HclOQ4GojKyO7CYLt4Xa8hWXPt4V7ajU03l8bOCvKOBNmg6hRD5jp
vHxVRmM/KOteKe7c9VJCMmxmo1oi9lE3e6BCB/VAGm7tzXHK9/43ug3tlh4A4Yk/
ad3eKm3kJxNa4FvJor3dadP6+6C0HUwZkk40TGgkYubsdPfR2kyGI3YZlr1J7cBI
jdRqcYoo/S+HmsreQgBpPXcTUhKqLsTU9/eqQ7V+9SItN6mvX8pPWmUaf+UexFht
1fkm9VtVD/H5bQ0QeOiRpJMXOe/ozNGH0hUKOEywfy7W8syQACc=
=YTdM
-----END PGP SIGNATURE-----

--5oal4jl4ykfwr5c4--
