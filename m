Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC805C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5D510E106;
	Tue,  4 Aug 2026 21:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cjfMDq3g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C8310E106
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 21:08:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F40524050B;
 Tue,  4 Aug 2026 21:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5281F000E9;
 Tue,  4 Aug 2026 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785877692;
 bh=dyQxeLvHZPBPULeFpNhUPh6gqriPr/vtpzGh3phT2fA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cjfMDq3gt0pnZe307+Dt0YwLgGjrd/yjvjM9+Q8XpDh0RT2yXAvDMH+Z9j3mAFXxD
 Dfi60WSAK4NrrLZgxxxzlQMROqiFLlN48ez7KCM/+xsxiJOs5S3JW8tF3XbAz7LzAH
 kIdk1QNwuVpfT2N/t55HSr0s1afJ/aPxjFh0+KtqFqWuayw66OMkWMjoloIpYNpE4l
 WZTU3zbRxvz+D/dvkkk2fDuaEm9H+b8tqdvLh+k+RjRbkNcbiM9PjWMeqn1xlxz9Kv
 ZNQ1ManJxzUDypBnWp4lOFZqppGWc8FgDEANaYECUGm6EyzLz22z45qXilQcR0cV+2
 8umIB1faETYYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: display: allow the boot logo in a
 reserved memory region
To: "Max Pedraza" <maximpedraza@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260804225617.264861-5-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-5-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 21:08:12 +0000
Message-Id: <20260804210812.8A5281F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Arbitrary boot logo placement via device tree allows out-of-bounds=
 memory writes in framebuffer drivers.
- [Medium] The YAML schema enforces contradictory constraints by unconditio=
nally requiring inline image properties, making the new `memory-region` pro=
perty impossible to use without failing validation.
- [Medium] The kernel driver lacks any C implementation to parse or map the=
 newly added `memory-region` property.
- [Medium] Using `kmalloc` for potentially large image allocations will fai=
l for sizes exceeding `KMALLOC_MAX_SIZE`.
--

--- Patch [4]: [PATCH v2 4/6] dt-bindings: display: allow the boot logo in =
a reserved memory region ---
commit 53263fda0e15a2f2d945eb9940e2236f6120727d
Author: Max Pedraza <maximpedraza@gmail.com>

dt-bindings: display: allow the boot logo in a reserved memory region

This commit extends the boot logo device tree binding to support loading
the image from a reserved memory region. It adds a memory-region property
as a mutually exclusive alternative to providing the image data inline.

> Carrying the image in the device tree ties it to the device tree, but the
> image and where it goes on screen are independent axes of variation. One
> board sold to several customers wants several device trees that differ in
> the logo; one customer with several products built on that board wants the
> same logo placed differently on each panel. The second case would otherwi=
se
> mean duplicating the same image into every device tree.

[Severity: Medium]
Can allocating these large images fail?  Using kmalloc() for potentially
large image allocations up to the 32MB LOGO_DT_MAX_PIXELS limit will fail
for sizes exceeding KMALLOC_MAX_SIZE:

drivers/video/logo/logo.c:logo_dt_parse() {
	...
	data =3D kmalloc(npixels, GFP_KERNEL);
	if (!data) {
		ret =3D -ENOMEM;
		goto err_free_clut;
	}
	...
}

>=20
> Let the node point at a reserved memory region filled in by the bootloader
> instead, so one image can be shared by device trees that differ only in
> placement. The region starts with a small header carrying a magic number
> and the geometry, so the kernel can tell a logo from an empty or stale
> region and bounds check everything against the reservation.

[Severity: Medium]
Is the parsing logic for this feature missing from this patch series?  The
kernel driver lacks any C implementation to parse or map the newly added
memory-region property.

In drivers/video/logo/logo.c:logo_dt_parse(), it unconditionally checks
for the inline properties and returns an error if they are absent, with no
code to handle the memory-region property:

drivers/video/logo/logo.c:logo_dt_parse() {
	...
	ret =3D of_property_read_u32(np, "width", &width);
	if (ret)
		return ret;
	...
}

[Severity: High]
Are the placement coordinates actually bounds-checked?  Arbitrary boot
logo placement via device tree allows out-of-bounds memory writes in
framebuffer drivers.

In fb_logo_dt_place(), unvalidated coordinates from the DT are assigned
to image->dy:

drivers/video/fbdev/core/fb_logo.c:fb_logo_dt_place() {
	...
	image->dx =3D max(dx + p->offset_x, 0);
	image->dy =3D fb_logo_dt_top(info->var.yres, image->height);
}

In fb_do_show_logo(), the bounds checks are completely missing for the Y
axis depending on rotation:

drivers/video/fbdev/core/fb_logo.c:fb_do_show_logo() {
	...
	if (rotate =3D=3D FB_ROTATE_UR) {
		for (x =3D 0;
		     x < num && image->dx + image->width <=3D info->var.xres;
		     x++) {
			info->fbops->fb_imageblit(info, image);
	...
}

When fb_imageblit() is called, the driver computes an address using dy,
which will write far outside the framebuffer limits.

[ ... ]

> diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-cl=
ut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut=
224.yaml
> index a6a2069648359..7aec0cc2d3776 100644
> --- a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.y=
aml
> +++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.y=
aml
> @@ -59,6 +59,23 @@ properties:
>        index into the colour lookup table. The property length must be eq=
ual to
>        width multiplied by height.
> =20
> +  memory-region:
> +    maxItems: 1

[Severity: Medium]
Will this property always fail validation?  The top-level required list
permanently mandates width, height, clut, and data.  If a device
tree node is added using only memory-region, it fails the global
required check:

Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml:
required:
  - compatible
  - width
  - height
  - clut
  - data

If a node provides both, it fails the oneOf constraint since the subschemas
become mutually exclusive.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804225617.2648=
61-1-maximpedraza@gmail.com?part=3D4
