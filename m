Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D9CCD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 08:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DB810E5FE;
	Mon,  4 May 2026 08:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kCu5jnFT";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE5710E09C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 08:11:26 +0000 (UTC)
Received: from monstersaurus.ideasonboard.com
 (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAA78175;
 Mon,  4 May 2026 10:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1777882282;
 bh=JtkOjmnls2PAluvKuJd5CBs2z7Hy2X6CWIrN7vy4oPA=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=kCu5jnFTth3/by1JhqEw8PBNF1u59C+iTkk8XB51Lr+z8MzMUm0lZaM+p0Xiz6Jcl
 qP6TdRT3OTe11pGve4qxhNRoBtluOZkg9q73cTLKOVSiU0xHckEkghskhV1gi+wv1/
 fjITDayWkeekLnJCgFFGtqV9Kg3Pna8qNYqAYRo4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <80e30578b6dd86664112320616c460c48dbd79f6.1777881435.git.geert+renesas@glider.be>
References: <80e30578b6dd86664112320616c460c48dbd79f6.1777881435.git.geert+renesas@glider.be>
Subject: Re: [PATCH] drm/rcar-du: Drop superfluous spaces after assignments
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
To: David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 04 May 2026 09:11:21 +0100
Message-ID: <177788228188.45302.9594019404927871888@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1
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

Quoting Geert Uytterhoeven (2026-05-04 08:58:23)
> There is no need for a double space after an assignment.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Lets stop these copying then:


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> This started with two instances, and got copied each time support for
> a new SoC was added...
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c b/drivers/gpu/=
drm/renesas/rcar-du/rcar_du_drv.c
> index 031d07f4508e9762..d9926c24984eb3db 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> @@ -137,7 +137,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
4a1_info =3D {
>         },
>         .num_lvds =3D 1,
>         .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(1),
> +       .dpll_mask =3D BIT(1),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a774b1_info =3D {
> @@ -168,7 +168,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
4b1_info =3D {
>         },
>         .num_lvds =3D 1,
>         .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(1),
> +       .dpll_mask =3D BIT(1),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a774c0_info =3D {
> @@ -196,7 +196,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
4c0_info =3D {
>         },
>         .num_lvds =3D 2,
>         .num_rpf =3D 4,
> -       .lvds_clk_mask =3D  BIT(1) | BIT(0),
> +       .lvds_clk_mask =3D BIT(1) | BIT(0),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a774e1_info =3D {
> @@ -227,7 +227,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
4e1_info =3D {
>         },
>         .num_lvds =3D 1,
>         .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(1),
> +       .dpll_mask =3D BIT(1),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a7779_info =3D {
> @@ -385,7 +385,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
95_info =3D {
>         },
>         .num_lvds =3D 1,
>         .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(2) | BIT(1),
> +       .dpll_mask =3D BIT(2) | BIT(1),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a7796_info =3D {
> @@ -416,7 +416,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
96_info =3D {
>         },
>         .num_lvds =3D 1,
>         .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(1),
> +       .dpll_mask =3D BIT(1),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a77965_info =3D {
> @@ -447,7 +447,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
965_info =3D {
>         },
>         .num_lvds =3D 1,
>         .num_rpf =3D 5,
> -       .dpll_mask =3D  BIT(1),
> +       .dpll_mask =3D BIT(1),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a77970_info =3D {
> @@ -502,7 +502,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
99x_info =3D {
>         },
>         .num_lvds =3D 2,
>         .num_rpf =3D 5,
> -       .lvds_clk_mask =3D  BIT(1) | BIT(0),
> +       .lvds_clk_mask =3D BIT(1) | BIT(0),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a779a0_info =3D {
> @@ -523,7 +523,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
9a0_info =3D {
>                 },
>         },
>         .num_rpf =3D 5,
> -       .dsi_clk_mask =3D  BIT(1) | BIT(0),
> +       .dsi_clk_mask =3D BIT(1) | BIT(0),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a779g0_info =3D {
> @@ -544,7 +544,7 @@ static const struct rcar_du_device_info rcar_du_r8a77=
9g0_info =3D {
>                 },
>         },
>         .num_rpf =3D 5,
> -       .dsi_clk_mask =3D  BIT(1) | BIT(0),
> +       .dsi_clk_mask =3D BIT(1) | BIT(0),
>  };
> =20
>  static const struct rcar_du_device_info rcar_du_r8a779h0_info =3D {
> --=20
> 2.43.0
>
