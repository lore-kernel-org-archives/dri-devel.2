Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97FCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 02:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF44610EC4D;
	Mon,  8 Jun 2026 02:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LNM+0Ql2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDA010EC4D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:41:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09E8D4383D;
 Mon,  8 Jun 2026 02:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1481F00893;
 Mon,  8 Jun 2026 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780886483;
 bh=mwJrXmtqejKYCngZrxBQoyTb/fGdzAiXmkGHtx6i+jA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LNM+0Ql2/hqwTH6TJmDTcqTY36jPz3KLjscM9TZ1ZipqgSYUVVZYRZykzABJOmTN0
 313E0pon45P8+EYRtfWIzeg95ziEb0ujDniNJesOVLvGpLc8M/OOkhu4paBrXy2VZB
 fHfugn03bZpZ4re56EbFBps7Pc1VnJvwlyK6ExmZqn2Dmf68JmMbyepcBhFWemwCww
 t+7ltYvRjB74vaOOdSdtidfjXdZkPLhnd8TPQ8vueudXL1/kC/AKOyXN8RHV3YUSJh
 Js1y1vkH0FrIzrxWYmMdHVxy7c7KM91x6Ljkn0jk3+d588hqC1B1LydYz/ytVWRudB
 lBQgEMrBta3oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/verisilicon: add DCUltraLite chip identity
 to HWDB
To: "Joey Lu" <a0987203069@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260608023237.305036-6-a0987203069@gmail.com>
References: <20260608023237.305036-6-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 02:41:22 +0000
Message-Id: <20260608024123.9D1481F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A wildcard entry in vs_chip_identities shadows subsequent specific=
 entries, making them unreachable.
- [High] The IRQ handler is registered before DRM structures are initialize=
d, which can cause a NULL pointer dereference if an interrupt fires early o=
r if initialization fails.
--

commit ef807eaf736a3cb84d7613b4d88301061b410a1b
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DCUltraLite chip identity to HWDB

This commit registers the Nuvoton MA35D1 DCUltraLite chip identity in
the hardware database. It places the entry last in the list to act as a
gate for hardware recognition.

> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/veri=
silicon/vs_hwdb.c
> index 91524d16f7785..7d630a667a3f0 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -129,6 +129,16 @@ static struct vs_chip_identity vs_chip_identities[] =
=3D {

[Severity: High]
This is a pre-existing issue, but does the wildcard entry at the start of
vs_chip_identities prevent specific entries from being matched?

Looking at vs_chip_identities, the first entry uses a wildcard for the
customer ID:

static struct vs_chip_identity vs_chip_identities[] =3D {
	{
		.model =3D 0x8200,
		.revision =3D 0x5720,
		.customer_id =3D ~0U,
...

In vs_fill_chip_identity(), the search loop returns on the first match:

	for (i =3D 0; i < ARRAY_SIZE(vs_chip_identities); i++) {
		if (vs_chip_identities[i].model =3D=3D model &&
		    vs_chip_identities[i].revision =3D=3D revision &&
		    (vs_chip_identities[i].customer_id =3D=3D customer_id ||
		     vs_chip_identities[i].customer_id =3D=3D ~0U)) {
...

Because the ~0U entry comes first, wouldn't it shadow the subsequent specif=
ic=20
entries for the same model and revision (like customer_id 0x310 and 0x311),
preventing their specific formats from ever being applied?

>  		.max_cursor_size =3D 64,
>  		.formats =3D &vs_formats_no_yuv444,
>  	},
> +	{
> +		.model =3D 0x0,		/* DCUltraLite */
> +		.revision =3D 0x5560,
> +		.customer_id =3D 0x305,
> +
> +		.generation =3D VSDC_GEN_DC8000,
> +		.display_count =3D 1,
> +		.max_cursor_size =3D 32,
> +		.formats =3D &vs_formats_no_yuv444,
> +	},
>  };
> =20
>  int vs_fill_chip_identity(struct regmap *regs,

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for an early
interrupt to cause a NULL pointer dereference during probe?

In vs_dc_probe() from vs_dc.c, the IRQ handler is registered before DRM
structures are initialized:

	ret =3D devm_request_irq(dev, irq, vs_dc_irq_handler, 0,
			       dev_name(dev), dc);
...
	ret =3D vs_drm_initialize(dc, pdev);

If an interrupt fires during this window, the handler seems to unconditiona=
lly
dereference dc->drm_dev which is allocated later in vs_drm_initialize():

vs_drm_handle_irq() in vs_drm.c:
...
			if (dc->drm_dev->crtcs[i])
				drm_crtc_handle_vblank(&dc->drm_dev->crtcs[i]->base);

Could this lead to a panic if the hardware has a pending interrupt before D=
RM
is ready?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608023237.3050=
36-1-a0987203069@gmail.com?part=3D5
