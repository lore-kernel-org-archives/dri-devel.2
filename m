Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F4CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3628510F231;
	Thu, 25 Jun 2026 10:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdXdc/ZX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB6F10F231
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:27:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 349F54419E;
 Thu, 25 Jun 2026 10:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C61F000E9;
 Thu, 25 Jun 2026 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782383245;
 bh=Odk6jNOlozI4A6U2okIbwk9EklT7Ww6eXbFQ5gLfQRw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bdXdc/ZXa08QwjVI7uY90HHM/LztXJIzjvWhzSDJymX4XaMMzfk0dsVCg2ELKvVGi
 md5epos/4DIXi4+gfqsKVF4/mCQOmv6+SDwrrZW9EMtT5jfwmShHEZwcFjfG2HZ5zS
 /bYr6nwOyS7dP4YFV0nlqALt/KmBGYp1D8DT4j/QBOgz6kh8i5dRYLSZWN/HEADTgI
 xU/YDMVCD33SyE1ErjLWyIJ3MrjkCW3wXoC+yU8CD25tySDDwobo9f1WJjtfUmiqEK
 mHm28ER92ZGn7dYrOU8Whr1Arz319+4M6WkLSBgE7Z+mUZ7mEecyhONpdp4LBqr8tA
 sqHfwFAc8sygQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625094509.157581-6-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:27:24 +0000
Message-Id: <20260625102724.E34C61F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Dead code in mathematical overflow checks for framebuffer size a=
nd alignment

Pre-existing issues:
- [High] Missing bounds check for explicitly provided stride allows out-of-=
bounds writes
--

commit 192f927f236077dbe56914205861b2c980ca71ec
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: simpledrm: Validate mmap size against framebuffer size

The size of the mmap'ed framebuffer could be smaller than the minimum
required framebuffer size. Validate the resource size against the
framebuffer size.

> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index a899dfb747bfa..9e0711e0095a5 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c

[ ... ]

> @@ -623,6 +624,7 @@ static struct simpledrm_device *simpledrm_device_crea=
te(struct drm_driver *drv,
>  	u16 width_mm =3D 0, height_mm =3D 0;
>  	struct device_node *panel_node;
>  	const struct drm_format_info *format;
> +	u64 size;
>  	struct resource *res, *mem =3D NULL;
>  	struct drm_plane *primary_plane;
>  	struct drm_crtc *crtc;

[ ... ]

> @@ -713,6 +715,14 @@ static struct simpledrm_device *simpledrm_device_cre=
ate(struct drm_driver *drv,
>  		}
>  		stride =3D pitch;
>  	}
> +	if (check_mul_overflow(height, stride, &size)) {
> +		drm_err(dev, "framebuffer size exceeds maximum\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (ALIGN(size, PAGE_SIZE) < PAGE_SIZE) {
> +		drm_err(dev, "page-aligned framebuffer exceeds maximum\n");
> +		return ERR_PTR(-EINVAL);
> +	}

[Severity: Medium]
Are these overflow checks functioning as intended?

Looking at simpledrm_device_create() in drivers/gpu/drm/sysfb/simpledrm.c,
height and stride are 32-bit integers while size is a u64. Their maximum
possible product (~1.4e14) easily fits into size (~1.8e19), meaning
check_mul_overflow() mathematically cannot overflow here.

Additionally, the alignment check ALIGN(size, PAGE_SIZE) < PAGE_SIZE
only evaluates to true if size =3D=3D 0. Since both height and stride are
guaranteed to be strictly greater than 0 by earlier validation, size
cannot be 0. As a u64, the PAGE_SIZE alignment cannot wrap around,
making this check dead code.

> =20
>  	sysfb->fb_mode =3D drm_sysfb_mode(width, height, width_mm, height_mm);
>  	sysfb->fb_format =3D format;

[ ... ]

> @@ -738,6 +748,13 @@ static struct simpledrm_device *simpledrm_device_cre=
ate(struct drm_driver *drv,
> =20
>  		drm_dbg(dev, "using system memory framebuffer at %pr\n", mem);
> =20
> +		if (size > resource_size(mem)) {
> +			drm_err(dev,
> +				"framebuffer size of %llu exceeds memory range %pr\n",
> +				size, mem);
> +			return ERR_PTR(-EINVAL);
> +		}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the size calculation
allow out-of-bounds writes if the device tree provides an artificially
small stride?

Looking at simpledrm_device_create() in drivers/gpu/drm/sysfb/simpledrm.c,
if stride is provided explicitly by the device tree, it is never validated
against the minimum required pitch (width * bytes_per_pixel). A buggy or
malicious device tree could provide a stride of 1, resulting in an
artificially small computed size that easily passes this new
size > resource_size(mem) check.

During atomic updates, DRM shadow plane blitting functions like
drm_fb_memcpy() copy width * bytes_per_pixel bytes per row. The total
memory offset accessed would reach:
(height - 1) * stride + width * bytes_per_pixel

With an artificially small stride, this could greatly exceed the validated
size and mapped resource_size(mem), leading to an out-of-bounds write
into kernel or I/O memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094509.1575=
81-1-tzimmermann@suse.de?part=3D5
