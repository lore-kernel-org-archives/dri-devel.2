Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929A606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfjRE0+W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7708610E3ED;
	Wed, 11 Nov 2026 11:18:19 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8737310E3ED
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:18:12 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3700ed8dbe3so5406164eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 03:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794395892; cv=none;
 d=google.com; s=arc-20260327;
 b=JXRhjqQhCZo6Ghm1AyibL6HKeZnT6HeDZfI73SH0JQQsJrOz4oIPQ6KUyVhBYER1ur
 E9jR0KD22pvMpJZVyQUM4CFUJSwNZrMAH55mNVBZObezZt4gpK7Ey57Jh8nrwklcVdS+
 I9Jn7HGex+ZSbUHQBwWUYIL9Y0Fwn66/ROEVtbH27SkquoimUF1jPI/7hN42i3jCuYQn
 Eqj+KGdF+dBZ1aN0Oeb0jGVzmpkZoPJSzUn/6kcxdSk8WQMduKvJyGDVRkNOr2cagiqJ
 N+MeseMEM/C85Ao7bHo0+FEAPucyAd14h0STNzzVxwoEEaV1qq1TZBOqmoI/pLr/MsF9
 Gz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r1oyng5HmTkXJYBOjO4xwXQ4nKo/fyLrx6V7oMlvY/A=;
 fh=A6HbTTw15IO1mUdskjzF83v/K8eBewGKi0KrS3REtHs=;
 b=KMtt5sNnUGYApVsRm71yz0de7DmThKsGtcw8L6P1Reytmfl5dixnozTu6u8HIMu5AN
 bjoBjr4oeuu7eqTBzEqKqgaMv0zjQXWPwytzqs0nBYVu5bHylwPjeTfEOQ/eKSLahw0P
 z56BnuBQcHVy4Tsde+G+iJnRCTGP0xSsdYRhz+Ep6fB5OXacs1K6zQaCeKNQN70ydKyH
 XlwqVUm09mowPSONCRR21iZCOVWaMEse0rxyLHdeT7aObh6yqOkOfyF1f8jVO6O49aeH
 njCEAqL1RknsaI9udv1hTtGK4MWyS2mYkrP1OqOwfjTlLz4Rq9QjsM8qQbFhv4xkmnUu
 b7/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794395892; x=1795000692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r1oyng5HmTkXJYBOjO4xwXQ4nKo/fyLrx6V7oMlvY/A=;
 b=GfjRE0+W0hlxnktso1sk9/mAM4J1WDLXY0WV5m2ki+3MzwdrVBluCaOHT7wLmkEZ95
 24lGGaTbXfznZiWF73Ku6oYuoVZbpETtWJBsifop3RV4oNsBUd9858Z0Figwy+kWjZGq
 5CA/YE7z14N8Vpc2MT0tSb+Ffcx4sXZHrSJGW/FUqOJacwQuUNy+1iJ12/SEkRoM6bHQ
 Ua+9BaF2u9z/VyIkVq/pMZIiVsS74Cvi3KmR5UDKuzur3S6Dp/wLnHl469lFNJK7TCpv
 A3tiEBWI60f4FSVf92HbUzAFmSELbyTnJCd8DZv1eH8bZzmtrZ48xfMo1orJr/LTde6F
 Lq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794395892; x=1795000692;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r1oyng5HmTkXJYBOjO4xwXQ4nKo/fyLrx6V7oMlvY/A=;
 b=PwoNfFVg8ddDq0wsF1MT/Ks0T6ysTMy6hoUZwLRyyzLCC7E7NleEpuV0PEx0D3SZvm
 cKGUnFiQiQzqqveHzlh006gKO6sZ7MT6O7NTzjbaVAIFxVV0lPOjx9q8JKkUQo4j5RVk
 Rgsye5d5FFYJUCNsx6l0TpgZSCzq1fLO3l6z7xjxFSJ0GFPmMf6h+WP4MwOFIR8fJY7Y
 dw8gTMenzdWGXrQbYK+ckvKhz3EE8KhWc5+lVK4GkC3hBXwLEc3QA3qNRBp0+xPuwVrx
 YqbHscCGXOxSR2VhAG1RQxpldsAc5yRVXJwugi/tWpTRaaa6OS+aaFiLoSc3r4ldh7LE
 fiHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFWZglKCSaBTUBjh5LPONw/YMfNiqZKRljHtxUHEF5DAImn6XAMahWxbfCSNSY3ZFYiN+z77lMysJQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/+yHgcKTep1y2u5ob0CpFvMv58eTAXHbFrwukzbkoB9kgB/bf0
 NpLjiGSE8vNF9Shqod3FQuYK9HFkmrxICgKDL3iA6Zqma03m8gZDOZ3uvODHg5smjphYwOMmuZ5
 yPqM0d9PARHifoFQ/YBY7flOr4ODM0Q4=
X-Gm-Gg: AYBFou2qnmroCbUkkk3TWqKXw71AbpNC/ue8AsROh7JPP+6m72Q8rQgroXzSWcTfSmK
 JeMoZFF1a7KQqL+wtf8O0o0uhlbXuiq27CDFRY2s6GUivTvMlH9645W22bgUfCJ509rsM0knHE9
 bK+YaBrAUIulXaiLx7WTWHqMnrmLk+jjgvuZQn5bgQROUW3qg1FKgFHdIYNeSGyYSkTv1p3AFSM
 QNGnEvPvwNG4pSKEUPqa/9oPNt6hDOBhVUHtgb6WqrY7FGw8J9fY91Dhcwq9UUFAtDfP9ReYedI
 97FfWVvt/zwezIB9rXa7zt90vcv+xi2H0mYeEZG+A1XggKrH7d1Qg8jPQv98jEbhmbnB85Qpd+G
 Y8ZzkEgfNF/pgS9ArD5Qbdaw4BEuRbn/xOuixBNwOngi0bjSUesb1CvSqczSDFMgo7y77rgnAnd
 nnBDPtanjkPYTelYS2QzpfMjxjjdkGkQ==
X-Received: by 2002:a05:7300:d942:b0:375:50d9:474e with SMTP id
 5a478bee46e88-3768366a40amr2582746eec.4.1794395891501; Wed, 11 Nov 2026
 03:18:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 11 Nov 2026 13:18:00 +0200
X-Gm-Features: AclHuK-O2dC4RAUcsZW-78NPaZ5DVC69K9fHpFDz6S6p3zKh72SRrQsMpZxuDAU
Message-ID: <CAPVz0n0-jBU3jnDsA4FmAkiF22Bqba=87_VRU3P1H2dzHHbteA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Joel Selvaraj <jo@jsfamily.in>, Jagan Teki <jagan@amarulasolutions.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Nickolay Goppen <setotau@mainlining.org>, Robert Chiras <robert.chiras@nxp.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>, 
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>, 
 Arpit Saini <arpit.saini@oss.qualcomm.com>, Michael Walle <mwalle@kernel.org>, 
 Ritesh Kumar <quic_riteshk@quicinc.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Danila Tikhonov <danila@mainlining.org>, Jens Reidel <adrian@travitia.xyz>, 
 Michael Srba <Michael.Srba@seznam.cz>, Shawn Guo <shawn.guo@linaro.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Romain TISSERAND <romain.tisserand@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=81=D1=80, 11 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:0=
3 Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> DSI panels can be placed under DSI bus directly and many Linux DRM
> drivers will work fine with it: mipi_dsi_host_register() adds device for
> such panel and DRM driver does not use OF graph to configure lanes.  The
> affected here Linux panel drivers do not use OF graph, either.
>
> Requiring graph port for such panels is tying the binding to one
> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
> requires the port.  The port is not needed for the hardware to operate
> and for some of the Linux drivers, so it should be optional.
>
> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> Remaining one Ilitek is fixed in:
> https://lore.kernel.org/all/20261109160706.2272332-2-romain.tisserand@gma=
il.com/
> ---
>  .../devicetree/bindings/display/panel/anbernic,td4310.yaml       | 1 -
>  Documentation/devicetree/bindings/display/panel/boe,td4320.yaml  | 1 -
>  .../devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml      | 1 -
>  Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml | 1 -
>  .../devicetree/bindings/display/panel/elida,kd35t133.yaml        | 1 -
>  .../bindings/display/panel/feiyang,fy07024di26a30d.yaml          | 1 -
>  .../devicetree/bindings/display/panel/himax,hx83112a.yaml        | 1 -
>  .../devicetree/bindings/display/panel/himax,hx83112b.yaml        | 1 -
>  .../devicetree/bindings/display/panel/himax,hx8394.yaml          | 1 -
>  .../devicetree/bindings/display/panel/ilitek,ili7807s.yaml       | 1 -
>  .../devicetree/bindings/display/panel/ilitek,ili9805.yaml        | 1 -
>  .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml       | 1 -
>  Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml  | 1 -
>  .../devicetree/bindings/display/panel/novatek,nt35532.yaml       | 1 -
>  .../devicetree/bindings/display/panel/novatek,nt36672a.yaml      | 1 -
>  .../devicetree/bindings/display/panel/novatek,nt36672e.yaml      | 1 -
>  .../devicetree/bindings/display/panel/novatek,nt37801.yaml       | 1 -
>  .../devicetree/bindings/display/panel/novatek,nt51021.yaml       | 1 -
>  .../devicetree/bindings/display/panel/raydium,rm67191.yaml       | 1 -
>  .../devicetree/bindings/display/panel/raydium,rm67200.yaml       | 1 -
>  .../devicetree/bindings/display/panel/raydium,rm69220.yaml       | 1 -
>  .../devicetree/bindings/display/panel/raydium,rm692e5.yaml       | 1 -
>  .../devicetree/bindings/display/panel/renesas,r61307.yaml        | 1 -
>  .../devicetree/bindings/display/panel/renesas,r69328.yaml        | 1 -
>  .../devicetree/bindings/display/panel/ronbo,rb070d30.yaml        | 1 -
>  .../devicetree/bindings/display/panel/samsung,ams581vf01.yaml    | 1 -
>  .../devicetree/bindings/display/panel/samsung,ams639rq08.yaml    | 1 -
>  .../bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml       | 1 -
>  .../devicetree/bindings/display/panel/samsung,sofef01-m.yaml     | 1 -
>  .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml       | 1 -
>  .../bindings/display/panel/sony,tulip-truly-nt35521.yaml         | 1 -
>  .../devicetree/bindings/display/panel/startek,kd070fhfid015.yaml | 1 -
>  .../devicetree/bindings/display/panel/synaptics,r63353.yaml      | 1 -
>  .../devicetree/bindings/display/panel/visionox,g2647fb105.yaml   | 1 -
>  .../devicetree/bindings/display/panel/visionox,r66451.yaml       | 1 -
>  .../devicetree/bindings/display/panel/visionox,rm69299.yaml      | 1 -
>  .../devicetree/bindings/display/panel/visionox,rm692e5.yaml      | 1 -
>  .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml     | 1 -
>  .../devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml    | 1 -
>  39 files changed, 39 deletions(-)
>

Thanks!

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # for renesas
r61307 and r69328
