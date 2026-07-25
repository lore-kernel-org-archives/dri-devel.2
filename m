Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EDCC531FC
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A7F10F39D;
	Sat, 25 Jul 2026 03:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DiHvpwB9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC5310E0D6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:15:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FE15406F1;
 Sat, 25 Jul 2026 03:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CC31F000E9;
 Sat, 25 Jul 2026 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949358;
 bh=V5F2XSq9vNYGp4ajcYragdOCT8MnNXbR5G1w3eeXucY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DiHvpwB9fioqWce2zwIka/glgJiKSZlJoDW0GXsaOnfcaoUMwbA48P0VNgeTZrEQN
 chGVAwICMvmbeODiHMzxtj3aV8urAGkTpG4gV17q/kVwu8Gmt3sdx2Bic7J98iDD1M
 4aaXeEyxcF6cofvp6uLF1/0tKlkq4CliKFHzXIKHtq4Xvy409J6wySRujYKk9eXpge
 bb8HdmuCPbbdMHmxgLOyuAvTY3YEY3o2D1oXPVlVD4pa9TVIvcQ57RGnzlk93D1zxT
 ttXFMgnJ3vBywTqxHhPxlxFK6vqqTpB3odK3SF3HEVQuHPIM5j1W/Rdq3a84H2nXd5
 nRsDbu6Q99qWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] drm/bridge: it6505: hold endpoint OF node
 reference while parsing it
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <d5abbb920321da662a735c880378513ff825fe39.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <d5abbb920321da662a735c880378513ff825fe39.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:15:57 +0000
Message-Id: <20260725031558.18CC31F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack variable `link_frequencies` is used if `of_pro=
perty_read_variable_u64_array()` reads 0 elements.
--

--- Patch [9]: [PATCH v6 09/13] drm/bridge: it6505: hold endpoint OF node r=
eference while parsing it ---
commit 635833fd1fe628586cc12b54a91fac7c8f243c4c
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: hold endpoint OF node reference while parsing it

This commit delays dropping the reference to endpoint nodes in it6505_parse=
_dt()
until after their properties have been parsed. This prevents a race conditi=
on
where the node could be freed while its properties are still being read when
CONFIG_OF_DYNAMIC is enabled.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
> @@ -3379,13 +3378,13 @@ static void it6505_parse_dt(struct it6505 *it6505)
[ ... ]
>  	ep =3D of_graph_get_endpoint_by_regs(np, 0, 0);
> -	of_node_put(ep);
> =20
>  	if (ep) {
>  		len =3D of_property_read_variable_u64_array(ep,

[Severity: High]
This is a pre-existing issue, but can this lead to using uninitialized stack
memory?

If the link-frequencies property exists in the device tree but is empty,
of_property_read_variable_u64_array() (called with sz_min set to 0) will
return 0 and leave the link_frequencies stack variable unmodified.

Since the subsequent check if (len >=3D 0) evaluates to true, won't the code
proceed to pass the uninitialized link_frequencies variable to do_div()
and use it to calculate the maximum DPI pixel clock?

> @@ -3405,6 +3404,7 @@ static void it6505_parse_dt(struct it6505 *it6505)
>  			dev_err(dev, "error link frequencies, use default");
>  			*max_dpi_pixel_clock =3D DPI_PIXEL_CLK_MAX;
>  		}
> +		of_node_put(ep);
>  	} else {
>  		dev_err(dev, "error endpoint, use default");
>  		*max_dpi_pixel_clock =3D DPI_PIXEL_CLK_MAX;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D9
