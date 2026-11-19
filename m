Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03C606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF61F10FB00;
	Thu, 19 Nov 2026 07:34:00 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A13F10FB00
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:34:00 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5eae12762c9so696176e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795073639; x=1795678439;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=48uBQbOIW5SOxGa36ux7wu9e7/2VqH2xuOnahPVaDpg=;
 b=IaFHSoobzH0rTepzKTb6icpvwP4OIetNY5uSwUpsStMl60Eftzd42TAzYqNoR+4tou
 B3E9I6g5iEK3EGtnB69z6RQVSpTlqCUBtR37+M4Al7DEI9SSuWyO7cl4RmCAZZilq5q7
 1gab+KZAkSsngl1HQY80O0RX+2D5RhBxVH9iJ3p5/Nxqs/ISIamnIQR5j7E1c2o66w/P
 S1xBDibPsFijVtuQQNgcvbzJGZDRMWZd0BdYnEtjr1hO7dvarypcpRJLcUiHEkPMtWdk
 bnrx4NzjHaQm0o1rS67omfM7GTvA6rb0MuZ198RZdqD6F2J9kW52ZV6GTuw17k+8USKt
 p/9g==
X-Gm-Message-State: APuU4Z/qywrwsJWneGKEsoY21Nk1zWQw7nHXk7Do8chslyo+az9kkDVJ
 xgS9cStEpbSCW7kxRcpr8SDUqMEAcYPjlVTbRC39w2fBEiSEZVzkIKjkCzwoN1Ht
X-Gm-Gg: AYBFou0N22Ph8a+T2xQ2AqrrQrfjTi81/Uy2cFi6uqViji3CuOp3cZorQ8NsyUBsbIP
 ei+mclovCaEnD1m2IRWHJpFQCfRba6lfDdYRxfs+Mab4w7+OGKL/GwntAziT0hADUG7kQLTgxWe
 6Ztrhy1QmjH/hw7lCZWGqYPMMCPvPJdyRSmzDonDXcbBKvdn+DurJI9keUT1WAeunXExHkwg9qY
 FbD3/7Dkt1OyYJ3a721hWxydx49Mg17H9fU1TvGsmUj3QOJtMJGkVCVBzKVtgPzSfO8915Vkab/
 bArlX9dSES/CIvaFMoCrl40R70CXbpE9LyTl4WyE4rlRK5hBB9w+5byiFNYLpnsAAnQWtk8vm2Z
 PfoPw37eIJaj7AQho+Wc6VBgu/7SoPWWQIlZbOoKSzi/q3vmVmKcQMywXZsalhZ42VItSXu4Cyi
 ifsSLOP2xTojlEJLPZ0PH7b2FQYEpOoW17nUwjS1Y4b8HGu6GCqUzUrib20Y9z8twUEsjsk1+Vq
 EG5+6C7aNGrOZesogcj+XCztYY95tIBzENZfddsRy6NCBmhCUSNklbHyt/CjVFYtThLk8O6h7dO
 W50F9ZrvyZ7uiZyvhHXlaX75qmMs+066eSLY3RYaV46LgI8NydsJkI8WRHPwIYvACUdkqV/5h0m
 /PuSGYhAYK03M
X-Received: by 2002:a05:6122:1d8e:b0:5ea:e7aa:acb9 with SMTP id
 71dfb90a1353d-5ee64c3eb87mr2104838e0c.6.1795073638685; 
 Wed, 18 Nov 2026 23:33:58 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee64c1801fsm3625834e0c.0.2026.11.18.23.33.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 23:33:58 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-77bf892b496so699025137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:33:58 -0800 (PST)
X-Received: by 2002:a05:6102:c50:b0:7d0:5688:f4f3 with SMTP id
 ada2fe7eead31-7d6ba190840mr1767507137.1.1795073638117; Wed, 18 Nov 2026
 23:33:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
In-Reply-To: <20261118214518.29317-21-ville.syrjala@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 08:33:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXALVCBk5D9UqWLed6eMgOFYLv8HJNaNLvfuv9YaZ_mcA@mail.gmail.com>
X-Gm-Features: Aa3M54pJIRGM8tExrNH7BQLmQBPW2tJFU5szZzp83frb40V080lFIDwtqcIbTTc
Message-ID: <CAMuHMdXALVCBk5D9UqWLed6eMgOFYLv8HJNaNLvfuv9YaZ_mcA@mail.gmail.com>
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ville,

On Wed, 18 Nov 2026 at 22:47, Ville Syrjala
<ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> Make DRM_RCAR_VSP selectable with COMPILE_TEST=3Dy, and enable the hidden
> DRM_RCAR_WRITEBACK option by default, so the VSP and writeback code gets
> built for greater coverage. Builds fine on x86, x86_64, arm and arm64 at
> least.

> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig

> @@ -85,5 +85,5 @@ config DRM_RCAR_VSP
>
>  config DRM_RCAR_WRITEBACK
>         bool
> -       default y if ARM64
> +       default y if ARM64 || COMPILE_TEST
>         depends on DRM_RCAR_DU

Merely enabling COMPILE_TEST should not enable extra functionality.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
