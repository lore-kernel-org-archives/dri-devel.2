Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B03C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2295510EBC9;
	Wed, 29 Jul 2026 12:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GKRJPYeR";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938CB10EBC9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:36:35 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so9322035e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785328593; x=1785933393;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xGyW1zCh+rLKiJ62hDLL4FkHUX+Lqecc47aUXSHCSkw=;
 b=GKRJPYeRUvZfqEEGdVZtsX0fMMuNOTeqGfbpyW8SseUjZbqjHqMpm+jax0CjiJM9dU
 KZ8lVaP5apK5ZIA6yOt6i8/JrRmbXW8iw3qs9h+wVjs+G9CS+EHAW5fFVcykrZ8R/yPp
 oH8vmMupGDTTrzOpmMym96OGQDYwKeMKD+XRorYJSXp9hMOgowi6ImRmwzOT6WcPPIiX
 izLPB7X6iVW9K4EQrxDvqTej/zg0EQRYhDdrs0pLP630aMLFfxsH4Pob87+8J8J//PXX
 HJl/Gs47fFOZS+wqEjF2JssMV+VKUGWiIHDVjDT1tF0Xoah/Nzcn6p9UdFCey2VjkCWk
 hLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785328593; x=1785933393;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xGyW1zCh+rLKiJ62hDLL4FkHUX+Lqecc47aUXSHCSkw=;
 b=CoRlR2vABLie4ppfjee/52jpZDnBwzRiXpEUX0cQauBBzb+bQT7ApUnlvwiwMidwA/
 kPs55rmO/fFAKnU2wiyoW8vZ5lUmlyKApsXnFvZNH81sQI3nYzD5LGdwBFTeYeQHlQII
 NQwUbe7ChadVtCi63dC2uop2+HSt/e9Jwy/lj/auG51anD7es7dWqNw0aEh6GLTm95tx
 BSyUO38mpj+SAUOMYboq1mUb7jIqcseukol0CgfyIPqMgkOkqSEBYbz2Fu7joGd2CYR8
 1N0f9G0h/V/d7xKMkMCnXGtkPwjlNy1OerzLb1wjQfi8AyME0k5Kmm+Ha7egD1UooHst
 OyIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+fO7aTAsAHzrADVOVrwxKpN/0odyyxRSxUMsc1vR+is/PP002pjduOiR65NxKm2fuRytmeRAFZFU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzI/irRYw7T+1zXby374X/b7KpNafq0iv2ux8zU7ITc/OucVLd8
 +QI1gmtgmWorrVTwZHiwj1QALfvlfI95KKap11dzWXUfABlhkK9c7elPi1LDW9s0/vI=
X-Gm-Gg: AR+sD12U/GpDEIim+CGqkqzYnraNX3C3zNKxRaVQaWTvYi29of2UPUyYXcl+5wZGvdR
 Rd6jGXKfB5JkcQrO/A/fCElvbjqgX6ilZ3wdS0O6QqxewOniVVXzaAbEJXJagvnWc+wsGQepgMH
 /K6FhVXlZbkCDYDvigLkLF8q7+HkhlL3XWpL1102+0dnqAewbfyH004P9hQXSjk7jKIURYfxxg5
 r5siDUlNPiqGR42MMWPA4NK+kA9yc1S0UDX+aAJxXLqQ5E+xZyoMBDtXG1wXuUEofBJTKBOSwzU
 Ba4p5BtAxQBS8+AZkcbN4Mimg1MvGelX6XuI9h/NdSfiiSNvu2XWfU1Er4xWYr7GTkLW5bQ9Yjb
 9S3obBMav+g93e6qSJQOHN8I9g4MWjneruVM7qgwYPdeK7z4RwETzamridHOd84016A8NdoVxku
 UaqfrGbrO+sbV5FPPdW9Rh4l2odDsMUG/w8p95P6hkgFhlljp3oq6zIqw+MfJ8pBPg2VWIr1pom
 Y88DYtZDvrYAmcwjPD7+0u0/t9MwT7k8rOi97e4jBRdcNyB6aE=
X-Received: by 2002:a05:600c:3153:b0:495:573e:1c54 with SMTP id
 5b1f17b1804b1-496c6428a29mr80996735e9.9.1785328593413; 
 Wed, 29 Jul 2026 05:36:33 -0700 (PDT)
Received: from localhost
 (p200300f65f47db0401da7fd03a16a046.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:1da:7fd0:3a16:a046])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-496c45b1c76sm146982725e9.6.2026.07.29.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:36:32 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:36:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: codykang.hk@gmail.com
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 05/17] phy: spacemit: add Innosilicon DP TX PHY
 driver
Message-ID: <amnzTxDYtSBojHdY@monoceros>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-5-6de34d80e86c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="db2zigiccrbrx7pn"
Content-Disposition: inline
In-Reply-To: <20260725-k3-display-v1-5-6de34d80e86c@gmail.com>
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


--db2zigiccrbrx7pn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RESEND 05/17] phy: spacemit: add Innosilicon DP TX PHY
 driver
MIME-Version: 1.0

Hello,

On Sat, Jul 25, 2026 at 12:51:14AM -0400, Cody Kang via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

<linux/platform_device.h> already makes sure that of_device_id
is available and <linux/mod_devicetable.h> will go away soon.

So please drop the latter #include.

Best regards
Uwe


--db2zigiccrbrx7pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp88sACgkQj4D7WH0S
/k6T8gf8DMOwEtZaYC8vvvJqKWATzitxIn2z2YqgDVlNFzaZEYTG61pFLh/KTds+
sl2cVZmTi8idTg/Of+KXRfO2hxAkSW3C5UbNd60pd0VY+mQSfW0RGGroYO+tusRx
A6NwUHW15ZrpIuAsbkKepIhd0YmoiVA9SimCLHX85RxW8RuuPoKWsaur8Jv/j+Pz
dp+m3Lfaj8gG8J21Rdy8YTgKJ8GMpjOVpViSpsqQIROd5gqkOUepPpTGc8Cc+Pr9
haGqNLM86F9sZOA5aL8HEpYGHDo3Q6hGRmDiUm3CBaNwalgdp6qGUEKWGBjRoi/4
tgGD4NlIoAze3OTkKRb3ysqj3/8Xng==
=c0aq
-----END PGP SIGNATURE-----

--db2zigiccrbrx7pn--
