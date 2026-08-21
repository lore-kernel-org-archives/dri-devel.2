Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F89C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 790DF10E0A7;
	Fri, 21 Aug 2026 10:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z5i5MvRF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733CF10E0A7
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 10:13:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A407F60DB6;
 Fri, 21 Aug 2026 10:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3C11F000E9;
 Fri, 21 Aug 2026 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787307227;
 bh=ogetkg0Uuo6RHrWZmvNz4/ua4kBg7pP+uQeMUOIcWBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z5i5MvRFtgRlxMrMTzO/HxWLZgaSBkrTy2uIjTBmb8BJ91SfxlFU/TjABdejbOusQ
 m0Yk+Q/TU8UjcdbtTsOb0G/sfKuHc9Hu49rCmRYWxEz6P28HNfvBac+ORaCj6Ehy6o
 5bTW01s7JGPTD1igVzZmcEgQ/PC+m+XSoZrLfTu7ODYWUCWHwUWi6z4W43tah/XD1N
 vKKkt7viXZuUL0n3jM53hl+DD3UDFnmoNAjifyHYUkccq3moFai1WO6/MMzcoQdyX9
 Urr0fVOwO5eP1n8PxOmZm8sVA4TX1NndHJVG1VXuzjdW8zNXKHsI6+NUQbm+DrlnVq
 uj8jJjj9BvotQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/tegra: Make sure clk_init_data is fully
 initialized
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev
In-Reply-To: <9bc5029f7ad84b0b1e02be231a5abd7e5fa03946.1787239944.git.geert+renesas@glider.be>
References: <cover.1787239944.git.geert+renesas@glider.be>
 <9bc5029f7ad84b0b1e02be231a5abd7e5fa03946.1787239944.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:13:46 +0000
Message-Id: <20260821101347.1D3C11F000E9@smtp.kernel.org>
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
- [High] Missing bounds check on the `nvidia,interface` device tree propert=
y causes out-of-bounds array indexing and arbitrary MMIO access.
--

--- Patch [2]: [PATCH 2/2] drm/tegra: Make sure clk_init_data is fully init=
ialized ---
commit d6e18a3c09cc145658765914a32b191ad5da6aa8
Author: Geert Uytterhoeven <geert+renesas@glider.be>

drm/tegra: Make sure clk_init_data is fully initialized

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled. Make sure all members are fully initialized, to avoid such bugs,
and to prevent future breakage when converting drivers to a different
method for specifying the parents.

> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 802d2db7007af..c28557d0c96e5 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -596,8 +596,8 @@ static const struct clk_ops tegra_clk_sor_pad_ops =3D=
 {
>  static struct clk *tegra_clk_sor_pad_register(struct tegra_sor *sor,
>  					      const char *name)
>  {
> +	struct clk_init_data init =3D {};
>  	struct tegra_clk_sor_pad *pad;
> -	struct clk_init_data init;
>  	struct clk *clk;
> =20
>  	pad =3D devm_kzalloc(sor->dev, sizeof(*pad), GFP_KERNEL);

[ ... ]

>  	pad->sor =3D sor;
> =20
>  	init.name =3D name;
>  	init.flags =3D 0;
>  	init.parent_names =3D tegra_clk_sor_pad_parents[sor->index];

[Severity: High]
This is a pre-existing issue, but can this out-of-bounds array indexing
occur if the Device Tree provides an invalid "nvidia,interface" value?

In tegra_sor_parse_dt(), the "nvidia,interface" property is read and
assigned directly to sor->index without any bounds checking:

drivers/gpu/drm/tegra/sor.c:tegra_sor_parse_dt() {
	...
	err =3D of_property_read_u32(np, "nvidia,interface", &value);
	if (err < 0)
		return err;

	sor->index =3D value;
	...
}

If a malformed Device Tree is provided, does using this unbounded sor->inde=
x to
access the tegra_clk_sor_pad_parents array lead to an out-of-bounds memory =
read?

It appears it could also cause arbitrary MMIO reads and writes when computi=
ng
register offsets using DC_DISP_CORE_SOR_SET_CONTROL(sor->index).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787239944.gi=
t.geert+renesas@glider.be?part=3D2
