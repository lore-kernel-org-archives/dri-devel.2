Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D84606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M67Dsl6b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A21B10E2C8;
	Thu, 12 Nov 2026 03:54:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF7A10E2C8
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:54:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5FCA4170B;
 Thu, 12 Nov 2026 03:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0CA1F00A05;
 Thu, 12 Nov 2026 03:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794455677;
 bh=6OTphds3n7+ikjh/NyOCeJYkKdI0DBYPrjOiZwmZxVo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M67Dsl6bPkJ//RCTQdtNK0838HaPe6P3LBH2oqu7BfiqsguBHIELLH1u5ztQ3nK+v
 c0BkH/rYoacoFbmz6aiK7gDL9biSYEleo/XHScKM0TUQW5Z26GrUa9vNNWLpdWss0c
 yMInmFcoZ7hxkruIpWjj68WxaAEzhEBrBlhepkyipWORkjf1mgp6gg1fco0p0Se8bM
 7jlb3srlS6egtnk5RvdOdD0z0ncPFVPVbYuNdd/Y7xWK+NKywqJidtN4QPLR2Vv3zQ
 gQ9uSK7M+hppQQwEsOSkC9BbSINbVvhPOqiVg2ONWcQpwy85FCSUK/7D6Sz5t8iDON
 UMtm50ncnYvfA==
Message-ID: <sashiko-outbox-210300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/fl2000: Add frame streaming
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-fl2000-upstream-v2-3-201f87708cb0@gmail.com>
References: <20261111-fl2000-upstream-v2-0-201f87708cb0@gmail.com>
 <20261111-fl2000-upstream-v2-3-201f87708cb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:54:37 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/fl2000: stale damage replay on same-size mode set in
  fl2000_stream_mode_set()
--

commit fb468144aa76017b626067d45248552b6ec6cb90
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add frame streaming

This commit adds frame streaming support for the FL2000 USB display
adapter, converting damaged framebuffer rectangles into a shadow buffer and
sending frames over bulk USB transfers from a pool of scatter-gather
buffers.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_streaming.c b/drivers/gpu/drm/=
fl2000/fl2000_streaming.c
> new file mode 100644
> index 0000000000000..dad640de5ec1a
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_streaming.c

[ ... ]

> +static void fl2000_copy_rect(struct fl2000_stream *stream, void *dst, co=
nst struct drm_rect *r)
> +{
> +	u32 line_len =3D stream->width * stream->bytes_pix;
> +	size_t off, span;
> +	int x1, x2, y1, y2;
> +
> +	/*
> +	 * A rectangle can outlive the geometry it was recorded under: a mode
> +	 * change that keeps the buffer size keeps the buffers too.
> +	 */
> +	x1 =3D clamp(r->x1, 0, (int)stream->width);
> +	x2 =3D clamp(r->x2, 0, (int)stream->width);
> +	y1 =3D clamp(r->y1, 0, (int)stream->height);
> +	y2 =3D clamp(r->y2, 0, (int)stream->height);
> +	if (x1 >=3D x2 || y1 >=3D y2)
> +		return;
> +
> +	off =3D (size_t)x1 * stream->bytes_pix;
> +	span =3D (size_t)(x2 - x1) * stream->bytes_pix;
> +
> +	for (int y =3D y1; y < y2; y++) {
> +		size_t start =3D round_down((size_t)y * line_len + off, 8);
> +		size_t end =3D min_t(size_t, round_up((size_t)y * line_len + off + spa=
n, 8),
> +				   stream->buf_size);
> +
> +		memcpy(dst + start, stream->shadow + start, end - start);
> +	}
> +}

[ ... ]

> +int fl2000_stream_mode_set(struct fl2000_stream *stream, unsigned int wi=
dth,
> +			   unsigned int height, u32 bytes_pix)
> +{
> +	int ret;
> +	unsigned int size;
> +
> +	/* Round buffer size up to multiple of 8 to meet HW expectations */
> +	size =3D ALIGN(width * height * bytes_pix, 8);
> +
> +	guard(mutex)(&stream->shadow_lock);
> +
> +	/* If there are buffers with same size - keep them */
> +	if (stream->buf_size !=3D size) {
> +		/*
> +		 * Without a shadow nothing writes a frame, and an allocation that fai=
ls below
> +		 * must not leave the old, smaller one to be written with the new geom=
etry.
> +		 */
> +		fl2000_stream_put_buffers(stream);
> +		vfree(stream->shadow);
> +		stream->shadow =3D NULL;
> +		stream->buf_size =3D 0;
> +
> +		ret =3D fl2000_stream_get_buffers(stream, size);
> +		if (ret)
> +			return ret;
> +
> +		/* One full frame in the device format; only the CPU ever reads it */
> +		stream->shadow =3D vzalloc(size);
> +		if (!stream->shadow) {
> +			fl2000_stream_put_buffers(stream);
> +			return -ENOMEM;
> +		}
> +
> +		/* A buffer carrying zero has never been built and takes the full-copy=
 path */
> +		stream->shadow_seq++;
> +
> +		stream->buf_size =3D size;
> +	}
> +
> +	stream->bytes_pix =3D bytes_pix;
> +	stream->width =3D width;
> +	stream->height =3D height;
> +
> +	return 0;
> +}

[Severity: Medium]
When a mode change keeps the same aligned buffer size (for example,
800x600 at 3 bytes/pixel to 1200x600 at 2 bytes/pixel, or a 90-degree
rotation), can fl2000_stream_build() corrupt outgoing buffers by replaying
old damage rectangles under the new geometry?

When stream->buf_size =3D=3D size, fl2000_stream_mode_set() keeps stream->s=
hadow
and the existing buffers with their current sb->seq values.  Rectangles in
stream->damage_log from before the mode change were written using the old
stride and pixel size, but fl2000_copy_rect() replays them using the new
width and bytes_pix, copying the wrong byte ranges from stream->shadow
while marking sb->seq caught up.  Advancing stream->shadow_seq by
FL2000_DAMAGE_LOG (and clearing stream->shadow) when the geometry or format
changes would force retained buffers onto the full-copy path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-fl2000-ups=
tream-v2-0-201f87708cb0@gmail.com?part=3D3
