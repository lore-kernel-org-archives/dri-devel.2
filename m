Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41738C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6664D10E6CB;
	Mon,  7 Sep 2026 08:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="R7uZ8zux";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B13310E6CB
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:23:48 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so27415635e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788769427; x=1789374227;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=toPH+1ZArk/DDhOFULiU+peDd7xkrEZ/LBY2wlar/aY=;
 b=R7uZ8zuxtLgiCE1gFEGjkRKmP+rppVSKxUXofZoFNYykc/8HvJdB61qeGTZAgrbus+
 9tQfl7nSxUCj1kFXSQobgnvMfsRFPOOMzXLcko4vKJOWsaMZXZlwJN/Bv4OMUHbynLI/
 GKRT6VU/YPbnk/p4D8fNDW8Xkmq/9oooTblFEM3vj07ICxcAa0LCcPL4y40S0ixIu5wu
 IJTG2qmeZZ4SY8/kcH3Xadytg4CcFjTz1oIfQi2gEVEeEUcX5y2JW5ZxylabHjm8zXQJ
 bKzPhevZ0AkIhzdwS+eBJ7LwSEvAhydVIMW2LwyJayKPyez6Vp2eWKdCfF4NRJkl6Lzj
 fEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788769427; x=1789374227;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=toPH+1ZArk/DDhOFULiU+peDd7xkrEZ/LBY2wlar/aY=;
 b=CEur/PWP8Nn7WesIzQQ20U4MGBMjbiOOuC82I3GDAKY91vwwBgvZIdLf/iQmBX/EuC
 gtUoHYC+ZEY8ihKdD+MRWk0x2tA/B2KL/m6g0N901LA9WZkYsatEtEtjqXpA52hFuMmY
 vHkxvRIxh3e342Y0rFeEdiSSbnYeR4cZErtL60QG+fmjsGufZ6L7AQgKCIE+kB4+I4ff
 G7czW2qDHhPvXW2vFm8nXcp+eI23cz9SeyM9zYuiTlsRq/fprK8fSyLGtcAPLiwUURvH
 0llpreniJsSAZZwpbrRtyDfH/U5DY7c0CVsgEDJ/l/9Z7hdvg5jcb286PuMee/BGdZrw
 F/LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznfbrEwgKswcgCr4PRzKYBPBCJiEsurkVCmlxs6mrbmz4Juz385d/guVyxt5y351kWXfDARYDlBlw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5AMAjD3Vqjmt+JLm6/mqmJIZ7wkY7GWL9rlSs33FPJ3wQzTHT
 P7xtmUUE3yMArr2bWCDR4EX2oHroUOP6uT41Y/IKRLdyGXe3YXGheGuRpXRRKN7wTDM=
X-Gm-Gg: AYBFou073K/seMyaMnAs1HnPGsTHH7UWr0hvTvOXHOFA7/6Q3zzyHg+XniqWeWYffxJ
 xAmzUAY9gcqcsFzQtHTOecAONd+awkaUwzWTmK1Ea69RQEjAmMg4PQTTlNNDHTd9O/pQzpsy4Va
 4+GBaCZ+KJTNgDCshRe07gzAqNMB1Z1yYw0hd0ji9geK0f/QniOrxPQFTwvFXHBxALnUZiUoVwr
 FeOUkxayC3fEjTcQPz2U9uBK8MVLXjlbSBdvL7J1kRE2LqpzVdS9ZyT6QyYHvYH81HqmtIYeV3D
 6ASNt6ihPudA9iatMEf/R3OcSfsREnuVRCEURASsVFOEHvIASXkphQUAoONtY2869ixWcBpOfrX
 1fK9itTqlmmo4zLfSo8ex4PDEsHyGIf/fk7rlEjyNpLlKSjQaU6MQKEFosjGDPW9XACqAz6pVeM
 m8+fDVijVnerNLArYNrIh4zEMeoPp/7d6JkDjKC6BV9jn2pH9QwaHLmVFJi6Qxi9OdJSq3RbFvJ
 4pGHIULUkRg+ZgqII6Ttp4DBbyofMaBKQqnSuQW8irWjfSQiZgTDkpRgTUdIg==
X-Received: by 2002:a05:600c:348e:b0:49d:622:df25 with SMTP id
 5b1f17b1804b1-49d0622dff1mr104970285e9.1.1788769427009; 
 Mon, 07 Sep 2026 01:23:47 -0700 (PDT)
Received: from localhost
 (p200300f65f19a9047ae53bb37ada872a.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:7ae5:3bb3:7ada:872a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-485883953cfsm22327326f8f.13.2026.09.07.01.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 01:23:46 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:23:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH v3 11/19] soc: starfive: Add jh7110-hdmi-subsystem driver
Message-ID: <ap50F4QOw7jbcvI6@monoceros>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132729eucas1p1bd78eb90feaf90b6265c13fc7bf43ada@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-11-484f9ae72715@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dohx7bkeczkqrdqr"
Content-Disposition: inline
In-Reply-To: <20260904-jh7110-clean-send-v3-11-484f9ae72715@samsung.com>
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


--dohx7bkeczkqrdqr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 11/19] soc: starfive: Add jh7110-hdmi-subsystem driver
MIME-Version: 1.0

Hello Michael,

On Fri, Sep 04, 2026 at 03:27:12PM +0200, Michal Wilczynski wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't add includes for <linux/mod_devicetable.h> as it introduces
many unneeded build dependencies. Either rely on
<linux/platform_device.h> providing of_device_id (IMHO preferred), or
include <linux/device-id/of.h> directly.

The same applies to two more patches in this series.

Best regards
Uwe

--dohx7bkeczkqrdqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqedI8ACgkQj4D7WH0S
/k4SQAf+JxaOkTt0KXEdMeiFgnBOg/VvLQ2tgwyYbYV25ymCW6f+E/Oz3WAI4IDD
S5sDwYSMfEN2g+u3IdIzE3kZhVEAdkv+iyA6MExPzaVz9qaS/A5RwGIGRO8EtmbY
OnW/GTowIQWQH8Fs2w7pe+ITRAhjl+9OOwdM2Y5h4x+EZD4CUz4apRozxIz62mu0
rv5S6v/JdJiz/WNpikSdNzKKIKdq56RUI2KHXKfjqnvCkAHwAVnPfgCH+HNcpJSX
wljKv3FOemKlAJV4uNgIjZs2QqmcGZbZ0acdyNWZ++YujYR8wLjOkQ0loi8lNg/x
i6GGu8ylq1Jcpp7HF98D268WTb+1Fg==
=jV7I
-----END PGP SIGNATURE-----

--dohx7bkeczkqrdqr--
