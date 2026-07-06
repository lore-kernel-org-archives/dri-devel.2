Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E629C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7879010E9FC;
	Mon,  6 Jul 2026 17:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gMLSLWKR";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AC410E9FC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:16:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so22911125e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783358186; x=1783962986;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JN5vDAyeeb4SlfTuLPS7JMWqVvfxk/NEHX0zcl//X2E=;
 b=gMLSLWKR2rYGdGS17n46792sLbg2T/Xq9wLri9T7qhlM5hVWTWpZyMHtFiiXeqClr9
 28/zVViJa5YOyrEqNSW+iiBG8BgMpuwslg9/Z2LLQGFWlVNaWHKtNcfu5mTt70/2WwCM
 NBTQTyHOmLgRuHqtOLi6uAfC3xWKtj3FWMUqzkZuabMJmlSNjRC8bsi5YSmuyQPjy9+c
 EICh9BuU8/V1YXhi/dH8af/ibIYY4HbDS/G9NAYwdKXr50cwyLPtpdCpfsilznPo+Uau
 wHOBM7ZBkePPEx/QirxKqHdPUt3Ftlhv/Psl6k2OXDy8vZtT3JNSxi57yR2CeaMdeoJ1
 mjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783358186; x=1783962986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JN5vDAyeeb4SlfTuLPS7JMWqVvfxk/NEHX0zcl//X2E=;
 b=bfuyYcpH2KTnwYwQXOd1XqCCXwkDXNaZeC9XDJ99vjLKwCixPLvIHRPzen9qKPQR5O
 bCqV4tCqePH3Qj3l+YbnaiOyqx+ZOxz2RlPNoQlg0gZPGoR/kUCIUVnotwFfIYE1HzSM
 S2ZKdG9MDGLqaUn0EIidMqESWB17yLfgkMlXnTJEnZ+5LGaqpEPoDwU1fwJN5hdpWy6n
 dbvK+r4kkFIJ3MpkEoCtxnL4KVTY57+02o8dOaCyZ5uygQ/AYMgJ9Ji43lQ/bxCNqm7N
 QYaaLxTkbqJE3oJpadTivzjFlbEt6Knt6cfr+oITKS4KetR4zxJSd8QB9rYyMNrEXzPN
 OQAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop2EosGKY7pm3zrYZ16aYg2G0YsyXzlDZsLfvqsr6112Gqn1iiGvGny5uR1NeOJoqUmWTmmM7olyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaJnEEkyLGTU8mpAHFWC0CoU+OR1+pu12KkOLd1WXwlB+Hzbqd
 bTtr1/ZZRzlYYVAcYWnBeVRwCcbkUBlE34hxb8JwU2Z/d/ULiooiajTG6IkEskfrQAg=
X-Gm-Gg: AfdE7cnrBvmWoFyAOQa85rRRSdN++lzqRYFXUr77l5+3wKwavdUDP0YCVMebP8cgyQg
 6U26orKcpXl4lYZQABy67oP2tPAiOW7Q9if3Tc8W6d3sLgty8LhWt3cAC0mw606xSWvQVsBbrfP
 3XOTU1ukUg9CRhfWrLQ+c3+n+nZJZy6VOiWpOKn6DfdM0dpShafyczpjvYkC5bu9bb1trSn6P5h
 rVxNs1BUQKRDn/cA152oI5Gn2PXKk+U2DLI9Yrk8JdcimDXcGV9DnAEmjGYQFpHRwBH5lkYbCXV
 GstcRlZzsOZuoGrWKowkXQRaIRLXFVK/B1UxrVoussdMWCwPlNGhZsKm9kuHsMMELG6vrzB7gLE
 hAZw1uN4MvOrcSTyl3qut4O4LlpPHvL98BsPtE/5+w+5HE6FZ4h2vJO89LyeJsDCCMe+ItG6qEV
 yghzdCU+FcAgPegObkKHS5J3oAhHTNa7lFA7rekt7ELn4VzaDvWkHqXRXBv9z0pJzwaKNVGuNGF
 Vs=
X-Received: by 2002:a05:600c:c168:b0:493:a960:a0bf with SMTP id
 5b1f17b1804b1-493df064184mr17991555e9.21.1783358185799; 
 Mon, 06 Jul 2026 10:16:25 -0700 (PDT)
Received: from localhost
 (p200300f65f47db0404eb41111570ffdc.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4eb:4111:1570:ffdc])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493cce040b4sm397138515e9.10.2026.07.06.10.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:16:25 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:16:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
Message-ID: <akvis8eaFYh0Ktmj@monoceros>
References: <20260704-asteroids-panel-support-v3-0-38dc92570579@pm.me>
 <20260704-asteroids-panel-support-v3-2-38dc92570579@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ts3aubgs6edhoq5r"
Content-Disposition: inline
In-Reply-To: <20260704-asteroids-panel-support-v3-2-38dc92570579@pm.me>
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


--ts3aubgs6edhoq5r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
MIME-Version: 1.0

Hello,

On Sat, Jul 04, 2026 at 08:24:19AM +0000, Alexander Koskovich wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need.

Thanks
Uwe

--ts3aubgs6edhoq5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpL4uUACgkQj4D7WH0S
/k53TwgAq9CpmcrLTfGp+dOydDPdV1igTy61onUd9jWdDbU+D/G4OCdRu8JGnOJ9
jI59b375/S22e9n+2vt3uld+ewyFSRgTJlKiBCdv7z2jAUllWtO9oYgpjFrIz6qL
bUQ3O7iHto8IJRd7L8YLZc0VLjfe0gHQSGx4xL6nyYvhDTXFiR+w/NgTMSpsaLbI
2YRIbZrVrVZoJ3UcjZ1wASmVEpteCjf5n/bPsfQ6ZjMOYTi3oSCrl7zN+fpfnJES
JAk4UBG24Wrr5+Gedw3fDkkajG3ZuSNpS/iiaAteeo6etoroJTnqYkQiRfdUO2mo
PHklD5QTxS39B8MYg6yB1EKWy9XArQ==
=R1yv
-----END PGP SIGNATURE-----

--ts3aubgs6edhoq5r--
