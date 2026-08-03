Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9DBC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B8A10E025;
	Mon,  3 Aug 2026 16:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CXhcWL7m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E5F10E025
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:45:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2300243DC8
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8AB1F00A3D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785775511;
 bh=wXOfikKqyccWdJOmPTIyOaKQPXwqCCx6SW5ye3VQI60=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=CXhcWL7mortE0CcKd5DgcgHtjMqibzHh9VXgayuANcJBFLhZY+7AtgZFvbSNEjGWa
 t3HjFlqALsihyptzu1FwMlEBa5deZ7h0z3aG6joVcg1xNq6gONLoy0mepNFQgTJHhT
 c/s6RMg85AJFJG6B52m8s+McP5UrKBXiLPKzpFZhJVgJX+qTSHlk8y0j/kFKA3qwJD
 r7Las/NUVaIrFrI6CuawqmeZPbhO8rza0Uhf3YBVaeKQwaIbf2ditfyV3BoZz9ENa2
 RyD9iw5kWLOiHdPfXpQRSlkbevx91sSizFDDxtGtiyMH5Fh36LuDjRINbq6t+6a4Up
 Wv4OIwM+vaFlw==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5b2a44a3b66so3709299e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:45:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4jZJyO88PbliyASUWZu2vSXr9MMIAj3VzL7xLcNoWspQshEAPcAUufxbj4J7j43g+Mz27T1oxwIc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBvUGy7l8Di3ESozO0LA9VWPa/qZ8usaFDagQdibb8NCni2srW
 hrI138DpT8Bin8DxebeGnfO3RX4rBBrbg4A2Yfi9drab3bQ0zJERMt6sw9m5Pv+YK/9qIich1fH
 UloC5x5IRONwWCmAcPnDFjncpjPInRBQ=
X-Received: by 2002:ac2:442d:0:b0:5b0:21e3:672a with SMTP id
 2adb3069b0e04-5b2e4f936cemr1411737e87.56.1785775509359; Mon, 03 Aug 2026
 09:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <52eb247169b268054302afa71e598add0b04748d.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <52eb247169b268054302afa71e598add0b04748d.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 00:44:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v67+AR+UDSM6tJSDtJw_zje164F8CmjUJaFegDr=txmUaw@mail.gmail.com>
X-Gm-Features: AUfX_mwkv5wRgU6YrCVP-n9_AeYgFr7hs0G3AjcJP388guGB69s2xIov8DPXNPg
Message-ID: <CAGb2v67+AR+UDSM6tJSDtJw_zje164F8CmjUJaFegDr=txmUaw@mail.gmail.com>
Subject: Re: [PATCH 04/13] drm/sun4i: tcon-top: Keep mixer routes distinct
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Both mixer selectors reset to TCON 0. Selecting the same TCON for both
> mixers causes black or corrupted output.
>
> When a route would collide, park the other mixer on another described
> TCON, or an unused selector if none exists.
>
> Since the TCON index is now used as a shift, also reject negative
> values.
>
> Tested on Orange Pi 3 with TCON_LCD0 and TCON_TV0.
>
> Link: https://lore.kernel.org/linux-sunxi/Zn8GVkpwXwhaUFno@titan/
> Link: https://lore.kernel.org/linux-sunxi/20241108-tcon_fix-v1-1-616218cc=
0d5f@jookia.org/
> Fixes: 05db311a792d ("drm/sun4i: tcon-top: Add helpers for mux switching"=
)
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

Though I have a couple nits.
> ---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 71 +++++++++++++++++++++-----
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  6 +++
>  2 files changed, 65 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> index 8adda578c51b..9cbd655518b2 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -25,6 +25,49 @@ static bool sun8i_tcon_top_node_is_tcon_top(struct dev=
ice_node *node)
>         return !!of_match_node(sun8i_tcon_top_of_table, node);
>  }
>
> +static unsigned int sun8i_tcon_top_get_tcon_map(struct device_node *node=
)
> +{
> +       static const u32 out_ports[] =3D {
> +               TCON_TOP_MIXER0_OUT_PORT,
> +               TCON_TOP_MIXER1_OUT_PORT,
> +       };
> +       unsigned int i, map =3D 0;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(out_ports); i++) {

You can declare `i` directly in the for statement.

> +               struct device_node *port;
> +
> +               port =3D of_graph_get_port_by_id(node, out_ports[i]);

You could probably use the __free() cleanup macro and make `port`
scoped and put the reference automatically.

> +               if (!port)
> +                       continue;
> +
> +               for_each_of_graph_port_endpoint(port, ep) {
> +                       struct of_endpoint endpoint;
> +
> +                       if (of_graph_parse_endpoint(ep, &endpoint))
> +                               continue;
> +
> +                       if (endpoint.id < TCON_TOP_PORT_TCON_NUM)
> +                               map |=3D BIT(endpoint.id);
> +               }
> +
> +               of_node_put(port);

And this line wouldn't be needed.

> +       }
> +
> +       return map;
> +}
> +

[...]
