Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06067CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5922610E7D8;
	Mon, 19 Oct 2026 06:58:02 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBD810E7D9
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:57:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso18246225e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792393075; x=1792997875;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JxfSK5IZ5O0IFCRPnkbx2AQWRlFboHtFQ8aMJNkMXv0=;
 b=TPoi9k5DaIKIOFUDmOxmAdQUlLAyFvzM4jOQyEYFyop4DnC/BIFQckdhYZkaURh6X9
 BvoR4dg4NbOKufX4wVLj9MxqLbBaKNeHEy1RsepRPnONvbPvlCc3vW2ZW82OZtzuODb7
 fupOg0DCzUdy82K1PrX2qeG6Gl6kKu92ckTNImC4bQm35CMyMBFj/wSfIlQeRRnEq5Xh
 CnnOHk76FLjujXFvMcWvyBT69oyWvb0PmdpOd4Ng98N/KsNL47twQuTWZy2WMzNBjPZT
 h4JvY/9y0CGkNPjF8h9qZ0oK56RL/ct5Wnkb+9mnYHAjXqKnspzsb4cKLFRuPGPobKls
 lpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792393075; x=1792997875;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JxfSK5IZ5O0IFCRPnkbx2AQWRlFboHtFQ8aMJNkMXv0=;
 b=NPAF2X6xM1oaZlLM0u2BTI6aF9V5KR1BKRMpyf4aPdov5W/F3y2fzZj66hqKeNufQ/
 I67AiHbfaPuQvRpag1bGkW3jKp5NuPuWxf8eUCCBkoCB7cs5ycnTF9kcGsFtCP9EJnmA
 CR3g3SNuWJJAcK/hTKUzkwF2MMPe0RSzr1Ez66OXmQz05qB/z8x80oOiGEToK9jm3aME
 65WkKbJpjjTensWAdGV1f0MSgLLDFy3Ge61oHgeGw6XYjEAAH4gxh1+qQWxmKiBpJd8X
 uL8cDA+xWm9c5ifpdrhc0nE++ynwxIOCHeYzyjC1+i9oqG9wXJM4IwIJWUY/gOmbxX4G
 gECw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/rArsXI8cil9Gsjvh8oGXsRf7dkI00BlAjWFgx8o0nnswk6C0Vypjb4b2viQ9KxDBMfc+sRZ6pZA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJw18t8kOEfl5krDok+R2cHdDtDfGtUqcNZ6wZPz3F/kHGZnDbu
 WKNdO6B5TE3JUH4ZXYM98PZC6SYAbV8K6AhorkVVKDGFa6x8mF6a4l3ZEykYKeqHZAc=
X-Gm-Gg: AYBFou2w7N6HkTjsSQ/JRJHBDVqfm1IAjJy912kXLKOhbGp0wi+/ZfhKzoiD80VOtuE
 7mivSuGJpM+YU3HBwUrhCJRUIkaTrRSCirRFmA+cJmpKnlIooTEMC/upU8jhzsxG/7Nrt5iU7Gd
 z14h86rphwSduJDbfBKGlSflVrzI16hj4KfEA9Kbpi1NCeszyFHm2MWWWB0s4oGQVs5BRly0rHA
 2qUb4Dqu6pl25oBZUg0OCPf/nDNNL4vySydQpT3dz9Yn6dkSyqTgzwbTtKCOXIhowZlkvvx38uZ
 g1o3H2SH+OnVPxOkRLlNbhz2yfCAjGg5u+r7vhEnmoG8Kb0CMgFEmsdKxYwauxNUljjv+U8cOTW
 3NCJi6S3atzVIMImq9bswuZCBe2YDFhI19rnJV3xhVSqax7nyOSlCnnEHbVyOuF+Naah9FtN8nK
 WI4rkm+y1aZOh0LeEolnXqWdcIKHV4wXLGNwCCrUjwji2AiajktM18+jUS5pmeGj8xxQ6tBN2KR
 SB/OCL/Wg+yE7z5g9Rd1G4wREBT7x67amLNi7GzDyCvKx6HXrCCYwuPCb79Og==
X-Received: by 2002:a05:600c:6992:b0:4a1:d7c3:d3d with SMTP id
 5b1f17b1804b1-4a1d7c30dd2mr130711935e9.10.1792393074742; 
 Sun, 18 Oct 2026 23:57:54 -0700 (PDT)
Received: from localhost
 (p200300f65f19a9041674bacf58593a35.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:1674:bacf:5859:3a35])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm172374155e9.4.2026.10.18.23.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:57:53 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:57:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Luka Panio <lukapanio@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722
 support
Message-ID: <atW_DkB9H0oV6U8v@monoceros>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-7-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6wnpoaklsckkwk77"
Content-Disposition: inline
In-Reply-To: <20261017140827.290666-7-lukapanio@gmail.com>
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


--6wnpoaklsckkwk77
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722
 support
MIME-Version: 1.0

Hello,

On Sat, Oct 17, 2026 at 04:07:54PM +0200, Luka Panio wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/spi/spi.h>

<linux/spi/spi.h> already provides both of_device_id and spi_device_id.
So please drop <linux/mod_devicetable.h> which pulls in a lot of
unneeded dependencies.

> [...]
> +static const struct spi_device_id edt_ft5x06_spi_ids[] = {
> +	{ "ft8722-ts", (kernel_ulong_t)&edt_ft8722_data },

Please use a named initializer here.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, edt_ft5x06_spi_ids);

Best regards
Uwe

--6wnpoaklsckkwk77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrVv2wACgkQj4D7WH0S
/k7AvAf7BT3eOJwLMHu3yGXN3CuhrApIng3UUqEXnJLyTpbAVT3F/gG90raumnhq
UGl7PXQ3EXG3LCgRIkwqNQfJTBdwdqDdWo3Lv66bmIy10YRgTHNn3eSn7k/D7lXO
xyJhy7u785DrUyBAk7c9VgnpQ6haEx90dQDrvf61edI7+BOKLs+oAkHXwEtgtmkd
NV1e9kIbW6JTHGAlsYSW7YIQKDy38zhlkXyu/L/A+oBVUHzUss5JOvOuekGxzdQb
R4iPyPcrOU1VRxmAckvzHVP8imXWy7kP1HTL+oPtjkyKR7w8eAY0Vow8hdLsbYvp
TyIOSLT9Njcket/gjkcISbC+l1pDkQ==
=k8s7
-----END PGP SIGNATURE-----

--6wnpoaklsckkwk77--
