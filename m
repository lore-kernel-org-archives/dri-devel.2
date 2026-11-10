Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF4606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVMNeYzC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536DC10EF8F;
	Tue, 10 Nov 2026 10:37:06 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257A810EF8F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:36:57 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5bccb867d6fso2319729e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794307015; cv=none;
 d=google.com; s=arc-20260327;
 b=qfGPQ+jOgE85BW6MTKeYuO+L7TpO+YJipKbONb9LZl9ODKnrGZgcKGyBidI0PyTF16
 g7NjQX9RDKJeSEX3DRryVfIZ3052PUIu/EqWd1XvcKtzo3nRjnINHYk+e/jGUJ3kg86b
 MSu6GgbDs/TYr+OacrQ6Zn8b90ISqyRJCw0GV2eSJV+Nt/TLViollJa137jDqEHcRAXl
 tfiJH0GPPU66DIupxizlRGuTYz+CYEnRJ0vlmUEObGA799cFtPvwyDesTuPgJ8o6ryGY
 PThydfC4Xh3N9kd7nwi36uir8hLic+owk3SItRotqstVj8JssmfTKpoeAHAyPtGhHHpy
 6Zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LOElH1vxD2BF5QjJ4dSWC0zMCWPZ1/SGqr8lDSB91pU=;
 fh=eaZA37743h9OGlFOIKP1vei3SGTivX8bULk7O7dZEec=;
 b=CETMai62eXxcWLqbQ92ACgMWssONYuwj1zScR/kJUInx0Jo8Ry/J6A9MQg6bWfC+KT
 1aqfNdFZOCF0B+bYlkEv46YpgFDj/ILAdj/PgwebF+Cr30VYN17/ahvbK3jgYeOb0cY1
 edzl4/EshVfPHxJWM4Gml8u/eihJtUtI7iw+hsyyW1ZT7DdSX0tTR0BNvR63w5HWAGZC
 zWEuV4kgSBpIlHPgEVjaOMPNAMkI2SXMqQNweB3Lu1MBHfIHyUuBheC5N/HrSTw3ESQC
 l+MSreKQ/9eQK/8HbmYZBXtvh+pkxonwlb9gHUMatEN1Z8wv2YqC24LLWErOUf8YV59Y
 fEOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794307015; x=1794911815; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LOElH1vxD2BF5QjJ4dSWC0zMCWPZ1/SGqr8lDSB91pU=;
 b=YVMNeYzCv3e4iUzPlWISxCiJJEW8wqGa5R4et3IcvaqrIz/A6g6Zgd5PocfhfBTlD3
 nOtaKXItJVYubI3rWpjwg7181ONbP8FWFvtq8P7hFogGHHAuh3pgNVg3QeeoBpO2wt9E
 Lo/PrLiaorWXri0EY2WWY6h/KvFZRNls2ldkLXCFzMtjh8rLEwCLjGf9GpZMf7JkcaBE
 MCkvCVw1dkh200YfyXQdhbsYuREPXJ68WdhiydJ9fgKk/aYBwHbt8VJqWnnxvtYpenBx
 WBYxaXNdas2oZn3ddvrMUVkjuCNWHAyeQQcaNlg7H1xSkAnN+3XROjGrpx8qxG9pZA5z
 TBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794307015; x=1794911815;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LOElH1vxD2BF5QjJ4dSWC0zMCWPZ1/SGqr8lDSB91pU=;
 b=u9pT+cSyfEjH6o82d0i9J/J1LHfMlKbFpBaC7zH3/4xOCffXa2XaTkAmWhPScC8WQ7
 bZF/XHOlVNBcsTUkzY8dQ1VYPwlLriCj97hCPZ0x0jayuVmDB358sIGXfLyfBYnHJFOq
 LcMxpVuJIfHX4P/LEYWHqbAONMLkIWWgM0cbrd1wdVJ6T9JObkWmGrvI98a6Z/RtWR+M
 pGN6ecWtmFiBSJYk6+Lc4J7o7bLa9vFzW3xSm8D7ELhfyRr2WZ0C8sDK4cXN0JsI2tTu
 bTOciqImL8QhrtqPCpRs6HDgiX7dDjdnmWatTEewZuUaoFdpJZ1vvCcGMSddyO3bUHto
 cIrg==
X-Gm-Message-State: APuU4Z8rYPGFFkGtoSyhAHwMby2PENJO1+gwiRhwOQo3ugHJjBSEUpvw
 RDTHuRXkSvx+mQJgawMTGm9koR8XA06hJRu0K5OHIbJqrr8a1XZkUZNxwiEg51OVuQzSo/n7rEH
 6tWNjhJx0PjrSYW7reSAhmgbmm8qDAVrh6FKd
X-Gm-Gg: AYBFou2bPxcB4sboIuhAtce2OvicJtbCLkK2oTs21/by97hwmXk6RgWrILtOYhU3Wly
 /TG9IW2uKdej2KFlLrmVvs4246qVmyiwfT/ZdONr6dBZbouUZB3XupcD+LKeHqgYrLzRB+1fgit
 dIdwEbaTOUaxWKTg6gJAPB8pwYRXXhq0Ud+S1iSqasGhrjtF8LkDVNJHfN1ez9mbn88Petr/8qO
 1UjKNKmfk56Bi7p3TsspnborBJ2dnMTJ3dPQCG5iiPOMniTqHkmbJoJcCukR0wcRiOsl5z9I4II
 xt8/uM0h1M1iLwSoXo/RzcvKOfQCr+XO90lzg0PizNtfmk+9TP4nRlEG6t+GnmAZFQulhFLwG8J
 vjb5wWmYB4Jo4WRRjsQ/GQL8A2rkLfZDx5oMY8NvMUwALSPSQMfHpKBhos9EoFVX57BIAnFbfRs
 IZWnnrxmfK7PMNTbOv3UfU29ra6/DT5LhBDBoxJP78hxDbiOzj3IBnvfFSAHdac9+2KieyIIht/
 3uCDKGzGij+YpNthgFeMdI298GTtR1iEVuh
X-Received: by 2002:a05:6512:1090:b0:5bf:c5e8:7451 with SMTP id
 2adb3069b0e04-5c156ef6a9amr665923e87.65.1794307014867; Tue, 10 Nov 2026
 02:36:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011154556.155831-1-kieweg.leander@gmail.com>
In-Reply-To: <20261011154556.155831-1-kieweg.leander@gmail.com>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Tue, 10 Nov 2026 11:36:42 +0100
X-Gm-Features: AclHuK8uvc2i2P_Jt29Mbu3rg5cUM-90uDWt_jYSqLTDdxYVxLIh3qQpLucOIBo
Message-ID: <CAMwcS0i-RQgWGHTUTVBwj8_is94siqwLg4mjgbN6qAhvosRb5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP
 GPU)
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

a gentle ping on v6 of the GlandaGPU series. Is there anything else I
should change before it can be merged?

Best regards,
Leander

Am So., 11. Okt. 2026 um 17:46 Uhr schrieb Leander Kieweg
<kieweg.leander@gmail.com>:
>
> This is v6 of the GlandaGPU DRM driver series [1][2][3][4][5]. It
> addresses review feedback from Thomas Zimmermann on v5.
>
> GlandaGPU is a small VHDL soft-IP 2D display controller, currently
> targeting a Terasic DE10-Standard (Cyclone V SoC). This series has
> been tested against a QEMU digital twin and on real hardware.
>
> Hardware/VHDL:   https://github.com/stiangglanda/GlandaGPU
> QEMU fork:       https://github.com/stiangglanda/qemu-glandagpu
> Userspace tests: https://github.com/stiangglanda/GlandaGPU-userspace-tests
>
> Changes since v5:
>
> driver core:
> - Replace the custom glanda_crtc_atomic_flush() with
>   drm_crtc_vblank_atomic_flush() (Thomas Zimmermann).
>
> On the QEMU device ID: it's currently a placeholder from the
> experimental range, since I haven't submitted the QEMU patch to get
> an official one yet. Is that fine to merge as is, with a follow-up
> kernel patch once the official ID is assigned?
>
> [1] v1: https://lore.kernel.org/dri-devel/20260714101146.200416-1-kieweg.leander@gmail.com/T/#t
> [2] v2: https://lore.kernel.org/dri-devel/20260730173643.256052-1-kieweg.leander@gmail.com/T/#t
> [3] v3: https://lore.kernel.org/dri-devel/20260824195418.17707-1-kieweg.leander@gmail.com/T/#t
> [4] v4: https://lore.kernel.org/dri-devel/20260913205007.118552-1-kieweg.leander@gmail.com/T/#t
> [5] v5: https://lore.kernel.org/dri-devel/20260920193944.110983-1-kieweg.leander@gmail.com/T/#t
>
> Leander Kieweg (2):
>   dt-bindings: display: Add GlandaGPU binding
>   drm/glanda: Add initial DRM driver for GlandaGPU
>
>  .../bindings/display/kieweg,gpu.yaml          |  56 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/tiny/Kconfig                  |  11 +
>  drivers/gpu/drm/tiny/Makefile                 |   1 +
>  drivers/gpu/drm/tiny/glandagpu.c              | 634 ++++++++++++++++++
>  6 files changed, 710 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml
>  create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
>
> --
> 2.43.0
>
