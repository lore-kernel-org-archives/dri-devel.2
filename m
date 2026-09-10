Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B9BC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE7410E2CD;
	Thu, 10 Sep 2026 19:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RX6TfLhg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81BA10E2CD
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:07:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19D766025B;
 Thu, 10 Sep 2026 19:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1691F00893;
 Thu, 10 Sep 2026 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789067253;
 bh=m2fRZGp8gbFI4Dtj+/5ZLUPI/n8mGXXWw4kaAtU0bfo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RX6TfLhgmSpJpoReGgo/4lVpvBjD0lLwmn5tnz7w1w+/FmOoZ8VQWAndrUKvLhDrI
 ZJK8GszNj3XuZIx0F9PelXIfxgjmJ+WqP6XBfVssKkxnC3CmUh1V84e+mQk37e1FOL
 ncyorCrdG7hlMYVjcxGuVk/o2sa/U82q7Q1oiB1txpu3AAIljogp+GLZkH6YsPpM9b
 eOBB4qPQUcEDXn05cs7TEjT3Z9vCh8bOsvSLA6+la4fXCVtD9k0+VgSDkHpOOGowFS
 LjH6UEY/D0Rw6c9TnC9cQ/iH2GpqJPTireL0NchlaOrvVv7UKRiezPH37tpke3G+6j
 oIIU8oWo6cI7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] drm/mipi-dbi: honour the plane source offset
 when flushing
To: "Jonathan Frazin" <frazinjonathan@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910185030.870-2-frazinjonathan@gmail.com>
References: <20260910185030.870-1-frazinjonathan@gmail.com>
 <20260910185030.870-2-frazinjonathan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:07:33 +0000
Message-Id: <20260910190733.9C1691F00893@smtp.kernel.org>
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
- [High] Partial updates in the sharp-memory driver corrupt the display bec=
ause framebuffer lines are unconditionally paired with panel line addresses=
 starting at 1. This problem wasn't introduced by this patch, but exists in=
 the current codebase.
--

commit d169c425f8ab54f8c291ce0979baadd0ddecc949
Author: Jonathan Frazin <frazinjonathan@gmail.com>

drm/mipi-dbi: honour the plane source offset when flushing

This commit updates mipi_dbi_fb_dirty() to account for the plane's source
offset. It subtracts src_x and src_y from the damage rectangle when
programming the column and page addresses, ensuring the correct panel window
is addressed for framebuffers larger than the panel.

> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_db=
i.c
> index 25cf04d029f77..38db45a9dbc35 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
[ ... ]
> @@ -298,8 +299,13 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src,=
 struct drm_framebuffer *fb,
>  		tr =3D src->vaddr; /* TODO: Use mapping abstraction properly */
>  	}
> =20
> -	mipi_dbi_set_window_address(dbidev, rect->x1, rect->x2 - 1, rect->y1,
> -				    rect->y2 - 1);
> +	/*
> +	 * @rect is in framebuffer coordinates and has been clipped to the plane
> +	 * src rectangle by the damage iterator. The panel is addressed relative
> +	 * to the src origin, so subtract it here.
> +	 */
> +	mipi_dbi_set_window_address(dbidev, rect->x1 - src_x, rect->x2 - 1 - sr=
c_x,
> +				    rect->y1 - src_y, rect->y2 - 1 - src_y);

[Severity: High]
This isn't a bug introduced by this patch, but looking at how partial updat=
es
are handled here, I noticed a pre-existing issue in the sharp-memory driver
where partial updates corrupt the display because framebuffer lines are
unconditionally paired with panel line addresses starting at 1.

Looking at drivers/gpu/drm/tiny/sharp-memory.c in
sharp_memory_set_tx_buffer_addresses():

	for (u32 line =3D 0; line < clip.y2; ++line)
		buffer[line * pitch] =3D line + 1;

The line addresses unconditionally start at 1 regardless of clip.y1, prepar=
ing
the transmit buffer with panel addresses starting at the top.

In drivers/gpu/drm/drm_format_helper.c:drm_fb_xrgb8888_to_mono():

		src32 =3D memcpy(src32, vaddr, len_src32);
		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
		drm_fb_gray8_to_mono_line(mono, gray8, linepixels);

Data is extracted from the correct y-offset in the source framebuffer but
written sequentially to the start of the destination buffer.

Then in drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_update_display():

	sharp_memory_set_tx_buffer_addresses(&tx_buffer[1], clip, pitch);
	sharp_memory_set_tx_buffer_data(&tx_buffer[2], fb, vmap, clip, pitch, fmtc=
nv_state);

	ret =3D sharp_memory_spi_write(smd->spi, tx_buffer, tx_buffer_size);

The offset data is placed at the start of the transmit buffer and the entire
buffer size is written to the SPI bus, pushing misaligned display data.

When a userspace compositor submits an atomic commit with damage clips where
clip.y1 > 0 (a partial update not starting at the top of the screen), the
damaged region from the framebuffer is extracted but written to the beginni=
ng
of the SPI transmit buffer. This causes the updated region to be drawn at t=
he
top of the display rather than its correct coordinates, and unmodified regi=
ons
below it are updated with stale or out-of-sync memory.

Since damage clips can be triggered by any unprivileged application indirec=
tly
through standard compositor operations, can this cause severe display
corruption in normal userspace usage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910185030.870-=
1-frazinjonathan@gmail.com?part=3D1
