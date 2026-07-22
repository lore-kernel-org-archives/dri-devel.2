Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EF0C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6EB10E4F7;
	Wed, 22 Jul 2026 21:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zs4XDqwX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86DF10E4F7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:52:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 592A5412F0;
 Wed, 22 Jul 2026 21:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AF51F000E9;
 Wed, 22 Jul 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784757140;
 bh=CjGMbBkZhx7UWgji+UfMLm1HK/NA5rmTVH8ZGx2L6VY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zs4XDqwXM78XwKfj+WbvQIx8vi7ZgYhBKuM5TO4DUrCZkjceJnWgQApX5C6PB4P1R
 TRNmNFXiPIAhND+g+s0o7ilGyJEcb+6VFboWyNhDWbS0Lo+sVwpPKPh4Rq2+sNwm8l
 iVTJ/4UGgbSK/YA3AjdoD3RgrTL6V+53sX6G+Dc5f27QLu3+o/eno/I+Z1y5qpoNcj
 8FcEXajcpGSpJj4cXZX62wt6ufU6JrN6YsK09ATr0A1l7o5XdsAmVGE5sB5bDTSpBK
 rUrOydNYVehhDSokSlcdC997qM96XYAvIi1XNh3svcYo1BCQj1jpSSuUonji7SYA4h
 SAufJpp2z8X0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/11] drm/bridge: it6505: hold endpoint OF node
 reference while parsing it
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <8a9ec00b8464f0dec0242792f7f9d990d33589a0.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <8a9ec00b8464f0dec0242792f7f9d990d33589a0.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:52:19 +0000
Message-Id: <20260722215220.11AF51F000E9@smtp.kernel.org>
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
- [High] The local variable `link_frequencies` is used uninitialized if `of=
_property_read_variable_u64_array()` returns 0.
--

--- Patch [9]: [PATCH v5 09/11] drm/bridge: it6505: hold endpoint OF node r=
eference while parsing it ---
commit a152f40f457f0c59599e70de71a80bcac957ec14
Author: Daniel Golle <daniel@makrotopia.org>
Subject: drm/bridge: it6505: hold endpoint OF node reference while parsing =
it

This commit fixes an issue where the device tree endpoint node reference
is dropped before parsing is complete, which can cause a use-after-free
race if the node is freed dynamically. It defers the of_node_put() calls
to execute only after all property parsing has finished.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index e9208d827ce3d..6f23203d5f2a6 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
>  	ep =3D of_graph_get_endpoint_by_regs(np, 0, 0);
> -	of_node_put(ep);
> =20
>  	if (ep) {
>  		len =3D of_property_read_variable_u64_array(ep,
>  							  "link-frequencies",
>  							  &link_frequencies, 0,
>  							  1);
>  		if (len >=3D 0) {
>  			do_div(link_frequencies, 1000);

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
here in it6505_parse_dt(). If of_property_read_variable_u64_array() returns
0, does this code use an uninitialized link_frequencies stack variable?

The of_property_read_variable_u64_array() function is called with a minimum
size of 0. If the link-frequencies property in the device tree is empty or
less than 8 bytes long (such as a common syntax mistake where a 32-bit
integer is provided), the function computes the size as 0. It then returns
0 without modifying the link_frequencies output variable.

Because the subsequent check is "if (len >=3D 0)", it evaluates to true, and
do_div() will consume whatever garbage value happens to be on the stack.
Depending on the stack memory, this could result in incorrectly rejecting
valid display modes or causing unpredictable display pipeline failures.

Should this code check "if (len > 0)" instead to guarantee the variable was
actually populated before using it?

>  			it6505->max_dpi_pixel_clock =3D link_frequencies;
>  		} else {
>  			dev_err(dev, "error link frequencies, use default");
>  			*max_dpi_pixel_clock =3D DPI_PIXEL_CLK_MAX;
>  		}
> +		of_node_put(ep);
>  	} else {
>  		dev_err(dev, "error endpoint, use default");
>  		*max_dpi_pixel_clock =3D DPI_PIXEL_CLK_MAX;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D9
