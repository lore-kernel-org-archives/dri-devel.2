Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D8ACD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 14:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647F910E77F;
	Mon, 11 May 2026 14:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jYt5c1Y4";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A72710E77F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=KVCLU3vdW/7zvUDHcovwk9olD8eQjBXMJn0q1qhgY2U=; b=jYt5c1Y4E7En0bz7KkGQICbgCk
 3+BiI46pcLBaiR00iP49kL5wkq+sVU2rr//fciVIINMugqmujdJLD6sOEu4ldidfjYjE1IKzr3LjK
 ROYJlWUoUk5fK/SJ+rU8obb0F7nt6+sJy3lm71scvVHxGvvShBIIuq1q1Y3k6ALrB6viTkto51GIz
 dorDMAOEwXWgRsJQTCr0sQDaYxcfPjKgazuZX4Pyolkv11mnlt/GxVBngDyxhsvVEiUiXTQJqnULS
 qDzIAd7ic1UvQ3gVqu3digasv9Br9btRJnrghtGuHzacp3Pm/PaVRER3r0CUAC87jo9/ROk9zOuQh
 vYqWfomg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wMRWS-000HO0-2O; Mon, 11 May 2026 16:22:16 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wMRWS-000DMv-0o; Mon, 11 May 2026 16:22:16 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/bridge: fsl-ldb: Add dev_err_probe for some error
 paths
Date: Mon, 11 May 2026 16:22:15 +0200
Message-ID: <2832185.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260327070122.3551058-1-alexander.stein@ew.tq-group.com>
References: <20260327070122.3551058-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27997/Mon May 11 08:24:57 2026)
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

Hi,

Am Freitag, 27. M=E4rz 2026, 08:01:21 CEST schrieb Alexander Stein:
> There are code paths which can return -EPROBE_DEFER during probe. Add
> missing error message for deferred probes.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Any feedback?

Thanks and best regards
Alexander

> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fs=
l-ldb.c
> index 7b71cde173e0c..cd4b9f6e1ced4 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -315,11 +315,13 @@ static int fsl_ldb_probe(struct platform_device *pd=
ev)
> =20
>  	fsl_ldb->clk =3D devm_clk_get(dev, "ldb");
>  	if (IS_ERR(fsl_ldb->clk))
> -		return PTR_ERR(fsl_ldb->clk);
> +		return dev_err_probe(dev, PTR_ERR(fsl_ldb->clk),
> +				     "Could not get ldb clock\n");
> =20
>  	fsl_ldb->regmap =3D syscon_node_to_regmap(dev->of_node->parent);
>  	if (IS_ERR(fsl_ldb->regmap))
> -		return PTR_ERR(fsl_ldb->regmap);
> +		return dev_err_probe(dev, PTR_ERR(fsl_ldb->regmap),
> +				     "Could not get syscon regmap\n");
> =20
>  	/* Locate the remote ports and the panel node */
>  	remote1 =3D of_graph_get_remote_node(dev->of_node, 1, 0);
> @@ -342,7 +344,8 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>  	panel =3D of_drm_find_panel(panel_node);
>  	of_node_put(panel_node);
>  	if (IS_ERR(panel))
> -		return PTR_ERR(panel);
> +		return dev_err_probe(dev, PTR_ERR(panel),
> +				     "Could not get panel\n");
> =20
>  	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"=
))
>  		fsl_ldb->use_termination_resistor =3D true;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


