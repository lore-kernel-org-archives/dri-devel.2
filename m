Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E32FC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAF610E3E2;
	Sat, 19 Sep 2026 22:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NA+Mk1yX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E6710E3E2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:57:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CE1D4181B;
 Sat, 19 Sep 2026 22:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A0F1F000FF;
 Sat, 19 Sep 2026 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858644;
 bh=U9qn2YPu/kuODsNCYOT7344LiNDxnUtyGo3cHLUPQkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NA+Mk1yXKDFn62miq9FJT5ODoAcA35owRRVNpveR8mMtSY+msdZBi3Hdg+1O7/M3/
 GSqC0ZjjlM/lrK//Ww1xSlrAAtve4rFepgSEBGDPJCuOiBDjz2EieexVXWSDBv0WlE
 mwhZFz2Wn6E+M97xUeESD7pa1ykXhJiGxiSKwaoX7iSvUVYJmMleahVgZVWyZ2D8F+
 IsLUCmNrb8w1NlEXIgTqspMTTTDtc2MEdRClZf/W4MMHGX+XXpCy+FYZ4qm6rfBmC8
 oxt54kHxmCSl5+fYq4jkWFAdigEV5aoPOzL6LHABscqb771ZP3gNFmHAGIadp2lEYk
 ZnApXT6gt8tmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gud: fix bulk_len divide-by-zero, connector bitmap
 OOB, and short USB reads
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919223510.3888975-1-benquike@gmail.com>
References: <20260919223510.3888975-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:57:23 +0000
Message-Id: <20260919225724.22A0F1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/gud: probe unconditionally fails on non-DMA devices due to uni=
nitialized access
- [High] drm/gud: Use-After-Free of shadow_buf in background flush worker
- [High] drm/gud: Heap Buffer Overflow in shadow_buf during framebuffer res=
ize
- [High] drm/gud: NULL pointer dereference in flush worker after vcalloc fa=
ilure
- [Medium] drm/gud: Incomplete damage coordinate alignment yields unaligned=
 width
--

commit 25423c5e9ff4d00f13c41b50149983a21e74d1aa
Author: Hui Peng <benquike@gmail.com>

drm/gud: fix bulk_len divide-by-zero, connector bitmap OOB, and short USB r=
eads

This commit adds bounds checks during the probe process, updates shadow
buffer management in queue damage, and rounds down coordinates to block
width for damage flushes.

> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
[ ... ]
> @@ -495,6 +497,10 @@ static int gud_probe(struct usb_interface *intf, con=
st struct usb_device_id *id)
>  		put_device(dma_dev);
>  	} else {
>  		dev_warn(dev, "buffer sharing not supported"); /* not an error */
> +	if (!drm->mode_config.min_width || !drm->mode_config.min_height ||
> +	    drm->mode_config.max_width < drm->mode_config.min_width ||
> +	    drm->mode_config.max_height < drm->mode_config.min_height)
> +		return -EINVAL;

[Severity: High]
Does this unconditionally fail the probe for devices without DMA?

Inside the else branch, this newly added bounds check evaluates fields in
drm->mode_config, but drmm_mode_config_init() and the descriptor
assignments have not yet been executed. Since this memory is
zero-initialized, !drm->mode_config.min_width evaluates to true and the
function unconditionally returns -EINVAL.

>  	}
> =20
[ ... ]
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
[ ... ]
> @@ -156,10 +156,14 @@ static int gud_prep_flush(struct gud_device *gdrm, =
struct drm_framebuffer *fb,
>  			  struct drm_format_conv_state *fmtcnv_state)
>  {
>  	u8 compression =3D gdrm->compression;
> +	unsigned int block_width =3D drm_format_info_block_width(format, 0);
>  	struct iosys_map dst;
>  	void *vaddr, *buf;
>  	size_t pitch, len;
> =20
> +	if (block_width > 1)
> +		rect->x1 =3D ALIGN_DOWN(rect->x1, block_width);

[Severity: Medium]
Will this result in an unaligned rectangle width?

ALIGN_DOWN is applied to rect->x1, but rect->x2 is not adjusted. Because
the rectangle width is dynamically calculated as x2 - x1, this isolated
modification of x1 without a corresponding adjustment to x2 can result in
a width that is no longer a multiple of block_width.

> +
>  	pitch =3D drm_format_info_min_pitch(format, 0, drm_rect_width(rect));
[ ... ]
> @@ -335,12 +339,21 @@ static void gud_flush_damage(struct gud_device *gdr=
m, struct drm_framebuffer *fb
>  	if (format->format =3D=3D DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulati=
on_format)
>  		format =3D gdrm->xrgb8888_emulation_format;
> =20
> +	block_width =3D drm_format_info_block_width(format, 0);
> +	if (block_width > 1)
> +		damage->x1 =3D ALIGN_DOWN(damage->x1, block_width);

[Severity: Medium]
Does this have the same alignment issue as in gud_prep_flush()?
Adjusting damage->x1 without adjusting damage->x2 might result in an
unaligned width when calculating x2 - x1.

> +
>  	/* Split update if it's too big */
[ ... ]
> @@ -399,6 +412,13 @@ static int gud_fb_queue_damage(struct gud_device *gd=
rm, struct drm_framebuffer *
> =20
>  	mutex_lock(&gdrm->damage_lock);
> =20
> +	if (gdrm->shadow_buf && gdrm->fb &&
> +	    (fb->pitches[0] !=3D gdrm->fb->pitches[0] || fb->height !=3D gdrm->=
fb->height)) {
> +		vfree(gdrm->shadow_buf);
> +		gdrm->shadow_buf =3D NULL;

[Severity: High]
Can this lead to a use-after-free of gdrm->shadow_buf if the asynchronous
worker gud_flush_work() is currently running?

The worker clears gdrm->fb and drops the lock while performing a lengthy
USB bulk transfer. Concurrently, if a new frame with different dimensions
is queued, gdrm->fb may be set to the new fb, and a subsequent frame could
trigger this vfree() while the worker is still actively accessing the
buffer.

[Severity: High]
Additionally, does the && gdrm->fb condition bypass the reallocation block
when the background worker is active?

If gud_flush_work() has set gdrm->fb to NULL, the reallocation check fails.
This bypasses the buffer reallocation, and subsequently drm_fb_memcpy()
will copy data from a larger framebuffer into the undersized shadow_buf,
causing a heap buffer overflow.

> +		gud_clear_damage(gdrm);
> +	}
> +
>  	if (!gdrm->shadow_buf) {
>  		gdrm->shadow_buf =3D vcalloc(fb->pitches[0], fb->height);
>  		if (!gdrm->shadow_buf) {
>  			mutex_unlock(&gdrm->damage_lock);
>  			return -ENOMEM;

[Severity: High]
What happens if vcalloc() fails here?

If the function returns -ENOMEM without clearing gdrm->fb or canceling the
pending gud_flush_work(), the worker will eventually run, see a valid
gdrm->fb, and pass a NULL shadow map along with a cleared damage rect to
gud_flush_damage(). Because gud_clear_damage() sets y1 =3D INT_MAX and y2 =
=3D 0,
calculating drm_rect_height(damage) will yield a negative number, which
underflows to a massive positive iteration count and leads to repeated calls
to gud_prep_flush() dereferencing a NULL source virtual address.

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223510.3888=
975-1-benquike@gmail.com?part=3D1
