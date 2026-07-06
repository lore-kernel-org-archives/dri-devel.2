Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D003C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DD910E3E4;
	Mon,  6 Jul 2026 17:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="KhBFMW/+";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4378F10E3E4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:15:04 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so21053315e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783358103; x=1783962903;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RF1RLciQtjG4YNCucdZF2HdDsXHFqgT0XBY9emkA8n0=;
 b=KhBFMW/+EW49E4KRq0WTczF2IQBKLNAB+us/8T9u2ebHEhfFFqlnG5WNm7WOhuzyPm
 vt5C77/2NX7bMjO+EzvT+SQtQ9iZYJYPql3bkiiFgY+I6wLNZOvyl3oyDCFrcpC5SdfU
 zMq33/A6gf4BRPxSyhj8d9XtYPHsJ60/a7EhMvOhdCdMksNLwLQXftXTHVd7FV75/kOe
 RTPL6JIQ4lWdthBXhf4nM9GwOrafClvGcK6dLsxSE/IdVUpy1EnIzaJ0dVJsD/xmfmqu
 B1UA9HXo8cGETtudRKKOXRylxM0DU7M/U2I364xSJVugJPelCKolXu/YLHxgkpOzFybO
 yxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783358103; x=1783962903;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RF1RLciQtjG4YNCucdZF2HdDsXHFqgT0XBY9emkA8n0=;
 b=Dfc9IjOrPpBM6eZRflrcs3yjVDU0qsvYo546GcZosnbL28gd3uMC9595cerrPg/waI
 3xVKHnS4Du+ytjWfObCDyXtODRPZkyOSCzJAYm/S2DbtsnbtUrU17B3gT9YzcXQQvCV1
 Yp5+9rF7B3ZJXO6vxkz6I0qFFyWq0mqgACv0eaGeAUBnm19e/eckgMWzaEms70kM7746
 1zlBwXacFyha03afIOIfDeNoGDRxBMn1HmFCEftg7YUmzzghSWJDlKij2cezKEujdM/O
 S7mmlOZjXYwlWoPUy7S3dN+/CPHglioa5AHrHjxt9+Z4hkaNX3tZzddbRsXkyxQzNl0v
 iFtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEzJFn8m1tH9daH8/c3tPfDf4DHuq8XyKaQXqa5uTkPcCUxO7fMAb55jyvcfGuHXRKm008m0IgJcE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJX2sNSgpfgvqCakJwUTD6eUuLmZD5thD3rvKdDFcWGue3twcv
 ClenhmLyDQkNEoWo1Y6KJoB0vvhdFDmhX4nmn9s2v43acf2Nzr6lG0/USeyHvncU/Xs=
X-Gm-Gg: AfdE7clJPRnIX3T59zrM0q1mFlCEwtXEPYM9v8QV1HVbMkbHNtlVbY3ur2lgxfUgDsC
 jC+GOoc9HtXkoF/NK43tAJ969aYW4YoVHwcfhR8Qo24Tsu1o9wwcr6n/fIT881eD1FuV5nM1x9h
 8fr1EFAU7cuZb2fQv8aVfaprCGK5biRlXuGZUuVOg6MFfF/PEe9uzIdG4+0MKRz92h7TD//vpOr
 FC/UsJBy367T+3wXSZmAQMhWMdZDih+KhahgI2auqpa/JAefrZcguNDmaCHRrdpNp9bxEcnZR4h
 QMm3FDEsw9r/qmNonFTmyPFIp0yRdAXiR98SXQqQSUSJAYXvp9lZ3e0QJMoAkFOHUXEv0IUaJll
 Gvxi2jDZNfkS8vB/GeSAlARnuubAN27XGc/3vFvq5hj17Ae9Tu1ilOeAU2QeYAhnqMYnXUh0jkQ
 zr/o/WwpK/7XQ4FEoU0Ev6AfgNutMOCxFoO1W81fV3CD+wMd+j90dTF5Lm0GgUdIvgDP+IEKbaF
 T98CYCyTjkT0w==
X-Received: by 2002:a05:600c:c167:b0:493:c98f:12e3 with SMTP id
 5b1f17b1804b1-493df08f73cmr16568635e9.20.1783358103081; 
 Mon, 06 Jul 2026 10:15:03 -0700 (PDT)
Received: from localhost
 (p200300f65f47db0404eb41111570ffdc.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4eb:4111:1570:ffdc])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47aa039ad21sm26023396f8f.20.2026.07.06.10.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:15:02 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:15:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add Novatek NT36536 panel driver
Message-ID: <akviZb1CA-tKFSI9@monoceros>
References: <20260705153515.46147-1-mitltlatltl@gmail.com>
 <20260705153515.46147-3-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="czie455qko7w23og"
Content-Disposition: inline
In-Reply-To: <20260705153515.46147-3-mitltlatltl@gmail.com>
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


--czie455qko7w23og
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] drm/panel: Add Novatek NT36536 panel driver
MIME-Version: 1.0

Hello,

On Sun, Jul 05, 2026 at 11:35:15PM +0800, Pengyu Luo wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Just use the
<linux/device-id/*.h> headers that you actually need.

Thanks
Uwe

--czie455qko7w23og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpL4pMACgkQj4D7WH0S
/k71Dgf/fIQMTUxWesNkPMBne1wEoe4ixrA2JPnwCgHvLX8AFmOMOZdNC80u0jcU
I4Yj0CG+fu6Z5zRyYwmK5r8v+k0bIIt5nYlVkU18EUo/PtMIk6Q1kNxqlZYP0WTE
7qXx070DYHUpJGkyC7X3iiygPvwKHj1NicVCnb7wmZ/ntunppUGFncU1tGQdpZbM
NIxiiunocL5kSXIYK7dqQq2oqqOYx2fN1YQtx1b0nICN6WbnVoD4JPfwU1m3xeF0
cKCwPoWEZUSWL7DWQk+LXnfYMa2salrizZtHUnVqpj1JS/VJsshz92a8twZehx1A
TSGZLZSNWBX0OePr/wVbyNH9CPxbVw==
=NhIY
-----END PGP SIGNATURE-----

--czie455qko7w23og--
