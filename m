Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E932CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F0FE10E60B;
	Mon, 12 Oct 2026 17:16:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BAD10E60B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:16:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66A0D43954;
 Mon, 12 Oct 2026 17:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DC1F0089B;
 Mon, 12 Oct 2026 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791825382;
 bh=vjt68e4KYRNFsNQM20zCJ/UaG6uqN1Z03eGGl1ypjLU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iSJtBkPK3yNZuMQppPVOHN+zgEwqL5kcgkYjvXrS9jGJDdiytqHWl8hEWzHeEfi/D
 jmwTISBC+bSPUu5tw7Rd5h+cm5Nigxnq9YBZKHNWBmr1tDnQ2n7HbBcj4y7QhJhwX+
 09+SxvlCX+UWr58y44tT9/ezrrZLJuepojYDVB5laIM+ub46LEJ8meL3tFpw1V5qrk
 JxC6jIdDEzDjA/KIoFE7O6VV5u8FronWia0uyKDB2sJrptPNXdQ8Q7lp8xD5/1w9lv
 GERmM8+1FgNPCt08dFbIhj7fx/fB+b9HagwA6ZR37RvOVWJOvC2SK7UbGVQlbhVV5H
 K+6Kb989vWWrQ==
Message-ID: <sashiko-outbox-168448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/format-helper: Add XRGB8888 to UYVY conversion
To: "Ho Jie Feng" <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012170857.199561-1-hjf3108@gmail.com>
References: <20261012170857.199561-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:16:21 +0000
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
- [High] drm: heap buffer overflow in drm_fb_xrgb8888_to_uyvy_line() on odd=
 clip width
--

commit 4e505b4602c1fdbf4570529c2dce5fc08ba8b249
Author: Ho Jie Feng <hjf3108@gmail.com>
Subject: drm/format-helper: Add XRGB8888 to UYVY conversion

This commit adds a new format helper function, drm_fb_xrgb8888_to_uyvy(),
to convert XRGB8888 framebuffers to UYVY format. It is intended for devices
that use packed UYVY natively but need to support XRGB8888 framebuffers.

> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_fo=
rmat_helper.c
> index 6cddf05c493bd..606733ca43fb4 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
[ ... ]
> +static void drm_fb_xrgb8888_to_uyvy_line(void *dbuf, const void *sbuf, u=
nsigned int width)
> +{
> +	u8 *transfer_buffer =3D dbuf;
> +	const __le32 *temp_buffer =3D sbuf;
> +	unsigned int i, dst_offset =3D 0;
> +	unsigned int pixel1, pixel2;
> +	unsigned int r1, g1, b1, r2, g2, b2;
> +	unsigned int r, g, b;
> +	unsigned int v, y1, u, y2;
> +
> +	for (i =3D 0; i < width; i +=3D 2) {
> +		pixel1 =3D le32_to_cpup(&temp_buffer[i]);
> +		pixel2 =3D le32_to_cpup(&temp_buffer[i + 1]);

[Severity: High]
Does this code perform an out-of-bounds read if the damage clip width is od=
d?

If userspace provides a damage clip where the width is an odd number, on the
final iteration of this loop, it appears we will unconditionally read
temp_buffer[i + 1] past the end of the source buffer.

> +
> +		r1 =3D (pixel1 & 0x00ff0000) >> 16;
> +		g1 =3D (pixel1 & 0x0000ff00) >> 8;
> +		b1 =3D  pixel1 & 0x000000ff;
> +		r2 =3D (pixel2 & 0x00ff0000) >> 16;
> +		g2 =3D (pixel2 & 0x0000ff00) >> 8;
> +		b2 =3D  pixel2 & 0x000000ff;
> +
> +		y1 =3D drm_pixel_rgb_to_y_bt601(r1, g1, b1);
> +		y2 =3D drm_pixel_rgb_to_y_bt601(r2, g2, b2);
> +
> +		r =3D r1 + r2;
> +		g =3D g1 + g2;
> +		b =3D b1 + b2;
> +
> +		v =3D drm_pixel_rgb2_to_v_bt601(r, g, b);
> +		u =3D drm_pixel_rgb2_to_u_bt601(r, g, b);
> +
> +		transfer_buffer[dst_offset++] =3D u;
> +		transfer_buffer[dst_offset++] =3D y1;
> +		transfer_buffer[dst_offset++] =3D v;
> +		transfer_buffer[dst_offset++] =3D y2;

[Severity: High]
Can this write overflow the destination buffer boundary?

Since the destination line buffer size is calculated based on dst_pixsize =
=3D 2,
it expects 2 bytes per pixel. For an odd width, writing a 4-byte UYVY
macropixel (u, y1, v, y2) on the final iteration writes 4 bytes when only
2 bytes are expected for that final odd pixel.=20

This appears to overflow the destination buffer by 2 bytes per line,
potentially corrupting adjacent lines or causing a kernel heap buffer overf=
low
on the final line.

> +	}
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012170857.1995=
61-1-hjf3108@gmail.com?part=3D1
