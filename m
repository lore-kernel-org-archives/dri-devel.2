Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C6606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CUuzaIcn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4EF10E6F5;
	Wed, 18 Nov 2026 07:48:33 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418F410E711
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:48:27 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so4642165e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794988105; x=1795592905;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rfa2Ndd+oOG8KQIoHfUwwZJYDQDCRfNRCZHUN7HT2WM=;
 b=CUuzaIcn1NuS0HLek72VWgiQ9xCoYMFndBcqDbQ82f7URKx8of3M08lO4xvB3gbxET
 tvQvuCAAB9mRQ2ybexZdqNkihcdRoJzIuAUjEv0HfFyE7UX53jzPWPZCzTkXsFAkzzYw
 D1vvYleFTj2ZtE8rQrzeYAYwwTHMc0d74r6xnwkIOzeSLUFDILPL6VW3Eqhr7F3cJ/Gl
 WpUnIDWNNZZuRHi55svDs6oeQb2hXvN1Gj8r38FKL/ndxNLx3lQ9uFSMzIvZWaLA9H5L
 FHX9XFoeVbH7jf6Phi6XUzUQ8elfgVBNCB25GZ7L+Y7Vh9fD+Skv9gQVlywTWY7ZvozT
 XR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794988105; x=1795592905;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rfa2Ndd+oOG8KQIoHfUwwZJYDQDCRfNRCZHUN7HT2WM=;
 b=MkU9TIw+odOW8szaqqRFXovghrB4vOXh0R4/DgDYNyXtQ2pBQgl3wB3sR+eve2Ev6x
 Cn7zIP9IRoLhf43FcFaJvrxjGPgmF3PwqqjOm6vHkyueUDDPpOwJGhJJLG2EHGITM+XN
 oeQg2s91Ofc6kRBm23LFdevexHJZoLens/Iqb9zIsX1/FRIm9jkxW8dxIeBe28z4+Ofg
 8yQ9UAwjWbc7Q2ptuP0+rizP+lQxGsikksUySQAAEqgaNvKZkZTBbSBqSk4lbPxo9eua
 XIFtS+z+0+mYy2j1Tvo/eysbDUu6Lhb0Lgsjy6xtFQApDK7VKlvm4IrM0eNCo1tkVwzw
 EGjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGEyVsx0mtauNuik+lYqHJ80eK9IZBy1NTNs6ALhEHgwAWI6I/IBGjBb2kF8oKrx53MkQKEGel5DFA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gY6LMcvRm5ytA/HlK3X9P82dcR8gxlmuiBCtUhiLf8ynTBMFO
 e65Fnc/Sph2YKvnkUxp62LoqI4xm4sLvLYpsZFowYvwyVgUYFA0YiT6bmZ2mlrKaHb0=
X-Gm-Gg: AYBFou2LbPz2yBoVTtB2cuYDylg+QXAUuG/P1gjwbkCsRAQiTYxFLpQxTsQi6ob07p/
 U4+2D3CVf7jscChPrafBwhvz12oUFg1/Lixd6oq/ZJJUETjCbleqQ2Rxz8wrXE18o77SQo/YZuj
 4mj78XLttRju5gWpMNQe3Q9/mzo+M/YT6NGAaGQU01D3tskjrI65UdXKAk6Sr3mWKG34roTXcz+
 gx/xU7edvUt61kBak+hZzQ/N6Zt4jWV99BCpJwRClpd/yEv/q60e7VT2Hxjys2DbS1C/kRTHw7O
 yIWcuPKwcuM2+XhLJOYZ1a2XSU9bmlSt3kwKAts3cDZXlDKb6ViaNHbx1N6xuH4xlJoTPp5jga5
 IX4a1C40EZnTEM10T0eblZBTiciNXRm19qbnI+LLD/2HO9PLE7c/b4E3GGr3526yt3jhuJYe5Ex
 0rIf0dVFkF+lqXW69E9OZHkCAfBoV6ZmavgB1kBFRbHkm2sruXAZ/s1Oo6c9MrbUO4pkrs9EMC6
 LJRrEp3oJTmLnGSWW8X2jLySuV0ZL833uemPeApt5Tz9OJAfI1Sp3QfO3zqt1eeNsUw/K3PshvX
 qZty668t3WOhMNpVz5HkB+/YOm4m8YDSsnc2lrXtrVBeU3T/bmyewWNVAmvhABFze5Nk7vezBzH
 E7Rp0d65+Jus+mGE3ITCcCb4Dh55hMjnEtycc
X-Received: by 2002:a05:600c:501f:b0:4bb:6f67:ca0b with SMTP id
 5b1f17b1804b1-4bb7da462b2mr31427555e9.29.1794988105583; 
 Tue, 17 Nov 2026 23:48:25 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb7d001a64sm47962885e9.0.2026.11.17.23.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 23:48:24 -0800 (PST)
Date: Wed, 18 Nov 2026 08:48:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Adil =?utf-8?Q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: add Novatek NT36525 panel driver
Message-ID: <av1XyXE9VsmDQuyo@monoceros>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261117173319.1852638-1-tadilhusrev@gmail.com>
 <20261117173319.1852638-3-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a4po6jazqfpixeh4"
Content-Disposition: inline
In-Reply-To: <20261117173319.1852638-3-tadilhusrev@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--a4po6jazqfpixeh4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] drm/panel: add Novatek NT36525 panel driver
MIME-Version: 1.0

Hello,

On Tue, Nov 17, 2026 at 08:33:19PM +0300, Adil H=FCsrev Tepe wrote:
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>

<linux/mod_devicetable.h> doens't only give you a definition of
of_device_id, but also pulls in a lot of unneeded stuff and thus
introduces useless build dependencies.

<drm/drm_mipi_dsi.h> already provides of_device_id, so just drop
<linux/mod_devicetable.h>.


--a4po6jazqfpixeh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr9WEQACgkQj4D7WH0S
/k40FAf/TncjaPwzM6TMWHC0aVkQVFbPwvWHgOtKsJALddK9tvV9iUEX/t3z4OYC
2Pw0xd4BFpl2wkMQ75SUIuvye7326vcAZeDzEtQlPBth9JhC33iVimAMK0FpSsvE
0/AXXkTDUE/GAKaEvDsQ3bZNimMNNhB5LADAei5yAPmVh4TbBc4QHOP1cH+EtYXq
8q8BiItYRchUZoLNDWHmjHW4oTYTDLFfPMMmp7hTATYVDcwtjD1RLvwMLpIHqlQY
NJ50k0zz0HuXn8C//vtaTKTnNgur9aBJzePKuKDs4u6cYqMHewZS7a7MYuj9wTJk
uitb980Rg5LMsiRY96UDrtZKYIYheg==
=WQ9s
-----END PGP SIGNATURE-----

--a4po6jazqfpixeh4--
