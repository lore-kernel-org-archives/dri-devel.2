Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4055CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3581B10E6ED;
	Mon, 22 Jun 2026 13:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dRLHPz8/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756D910E6ED
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:33:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2235E40775;
 Mon, 22 Jun 2026 13:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE891F000E9;
 Mon, 22 Jun 2026 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782135189;
 bh=n8pewD7zr/xd3l/1NFCbsdBdLbePHQlH/KFWXDAor+Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dRLHPz8/TDQIwi+LRcE+FX0sboeQBAk5gBQim2SOue2/fvwvbKlc26IFB0AwiJraz
 iP/kxVZPaqlQKAZN8KC691nZuxt22qRnzoDo5zTOJL+rC96QtzEkqiX4pXUwBsCguE
 a5T1djjU47x/m2S/Zd2sFj3FPtZd+HbtyJYzYwgsk1YvabN2Uc8UawKiHFn9sRUAQP
 X7HewGoczOOKflGICQnR+33SaeitZBmarhsBU2BC2WeF4GdAt58l50ShW04mPvIOIU
 2+bsa2DDX7PQXzJj/DJg4taDkav9/smhbKz/VepOMirICb4YLwO1JPb2Tk4r0kAQU3
 0H0uanPjx16JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622132433.722823-6-tzimmermann@suse.de>
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 13:33:08 +0000
Message-Id: <20260622133308.DBE891F000E9@smtp.kernel.org>
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
- [High] The validation check comparing the memory resource size against th=
e required framebuffer size is inverted, causing valid device tree configur=
ations to fail probing and bypassing protection for undersized framebuffers.
- [Low] The condition `if (size < PAGE_SIZE)` functions as a check for a ze=
ro-sized framebuffer rather than an alignment overflow guard, resulting in =
a misleading error message.
--

commit fe687b775049a45634b1930d3d958d911916b07a
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: simpledrm: Validate mmap size against framebuffer size

The size of the mmap'ed framebuffer could be smaller than the minimum
required framebuffer size. Validate the resource size against the
framebuffer size.

Buggy firmware that triggers this check should be fixed up with a quirk
on a case-by-case base.

> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index 76b9a3f5c4efa..a04f0c852ea48 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c

[ ... ]

> @@ -704,6 +706,15 @@ static struct simpledrm_device *simpledrm_device_cre=
ate(struct drm_driver *drv,
>  		}
>  		stride =3D pitch;
>  	}
> +	if (check_mul_overflow(height, stride, &size)) {
> +		drm_err(dev, "framebuffer size exceeds maximum\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	size =3D ALIGN(size, PAGE_SIZE);
> +	if (size < PAGE_SIZE) {
> +		drm_err(dev, "framebuffer alignment exceeds maximum\n");

[Severity: Low]
Does this code accurately report an alignment overflow?

Because both height and stride are bounded by INT_MAX, their product
(size) cannot exceed ~2^62, meaning the ALIGN operation will not overflow
a 64-bit integer.

The condition size < PAGE_SIZE will only be true if size was exactly 0
before alignment. While rejecting a zero-sized framebuffer is correct,
the error message 'framebuffer alignment exceeds maximum' might be
misleading for developers debugging initialization failures.

> +		return ERR_PTR(-EINVAL);
> +	}
> =20
>  	sysfb->fb_mode =3D drm_sysfb_mode(width, height, width_mm, height_mm);
>  	sysfb->fb_format =3D format;

[ ... ]

> @@ -729,6 +740,13 @@ static struct simpledrm_device *simpledrm_device_cre=
ate(struct drm_driver *drv,
> =20
>  		drm_dbg(dev, "using system memory framebuffer at %pr\n", mem);
> =20
> +		if (resource_size(mem) > size) {
> +			drm_err(dev,
> +				"framebuffer size of %llu exceeds memory range %pr\n",

[Severity: High]
Is the validation check here inverted?

The condition evaluates to true when the provided memory region is larger
than the required framebuffer size, which is a valid configuration when
the reserved-memory region is larger than the exact resolution requires.

This logic inversion causes the driver to incorrectly log 'framebuffer size=
...
exceeds memory range' and abort probing for valid configurations, while
allowing memory regions that are actually too small.

Will this bypass the intended validation and potentially lead to out-of-bou=
nds
memory accesses if the framebuffer is not fully backed by the memory resour=
ce?

> +				size, mem);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
>  		screen_base =3D devm_memremap(dev->dev, mem->start, resource_size(mem)=
, MEMREMAP_WC);
>  		if (IS_ERR(screen_base))
>  			return screen_base;

[ ... ]

> @@ -762,6 +780,13 @@ static struct simpledrm_device *simpledrm_device_cre=
ate(struct drm_driver *drv,
>  			mem =3D res;
>  		}
> =20
> +		if (resource_size(mem) > size) {
> +			drm_err(dev,
> +				"framebuffer size of %llu exceeds memory range %pr\n",

[Severity: High]
Is this check also inverted for the I/O memory path?

Similar to the system memory path above, this will reject valid framebuffers
that fit within the memory range and allow undersized ones.

> +				size, mem);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
>  		screen_base =3D devm_ioremap_wc(&pdev->dev, mem->start, resource_size(=
mem));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622132433.7228=
23-1-tzimmermann@suse.de?part=3D5
