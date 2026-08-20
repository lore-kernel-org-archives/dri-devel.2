Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB06C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB3A10EF51;
	Thu, 20 Aug 2026 08:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W9Jn8XMz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0405810EF51
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:44:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5B5F436CA;
 Thu, 20 Aug 2026 08:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9481F000E9;
 Thu, 20 Aug 2026 08:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787215464;
 bh=zTMUNQgLwck/SJsDeQz3HJEY1eY9aWCR8PacSAGKRbk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W9Jn8XMzUpoRhRGR73OPwfyz4zISb87k1mOC1N4+4SXEJbaPIxNlz+xS37eUC1BP3
 XshqpK+GwuuuSUPb1QpKcEsvOPatGsdX5+9cW8H5bcwZ/ZDkakT5XYTiYRW1fFE+o6
 4QzZtvGw4T5wizFAk7KZh7cLyvx0PzOZgFdsZdp7rDflqxus2XTt3ZTD/m2Au5KgWh
 /c4X0aFMlCm9WoBzAfFoDU56Q5cR69NrjcYiZHawBJP6oTZqOTOOTu3DcZQmVH32da
 NV1k9/oKc2GJb6lbSFqNI3h+jGNjjmcvqrUS3IlwMt1tEBx2uGpdYKP/nr9/g/SG4S
 9miHmkSCoA3TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vkms: Fix vertical read step for R1/R2/R4 formats
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820083123.544655-3-oushixiong1025@163.com>
References: <20260820083123.544655-1-oushixiong1025@163.com>
 <20260820083123.544655-3-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 08:44:24 +0000
Message-Id: <20260820084424.7F9481F000E9@smtp.kernel.org>
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
- [High] Integer overflow in `packed_pixels_offset()` causes a massive out-=
of-bounds kernel memory read.
--

--- Patch [1]: [PATCH] drm/vkms: Fix vertical read step for R1/R2/R4 format=
s ---
commit 27fa0b8f7b4814c63740fbad03cf74d10431bd82
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/vkms: Fix vertical read step for R1/R2/R4 formats

This commit fixes the vertical read step for R1/R2/R4 formats by using the
block height instead of block width to calculate byte offsets. This prevents
out-of-bounds reads and incorrect sampling when rotating or reflecting plan=
es.

> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/v=
kms_formats.c
> index dfb8e13cba87a..1e3a6af9cea52 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -103,11 +103,11 @@ static int get_block_step_bytes(struct drm_framebuf=
fer *fb, enum pixel_read_dire
>  	case READ_RIGHT_TO_LEFT:
>  		return -fb->format->char_per_block[plane_index];
>  	case READ_TOP_TO_BOTTOM:
> -		return (int)fb->pitches[plane_index] * drm_format_info_block_width(fb-=
>format,
> -										   plane_index);
> -	case READ_BOTTOM_TO_TOP:
> -		return -(int)fb->pitches[plane_index] * drm_format_info_block_width(fb=
->format,
> +		return (int)fb->pitches[plane_index] * drm_format_info_block_height(fb=
->format,
>  										    plane_index);
> +	case READ_BOTTOM_TO_TOP:
> +		return -(int)fb->pitches[plane_index] * drm_format_info_block_height(f=
b->format,
> +										     plane_index);
>  	}
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential integer
overflow in packed_pixels_offset() in the same file.

If a user configures a framebuffer with a specific height and pitch (e.g.,
height =3D 3 and pitch =3D 0x40000000), this satisfies the bounds check in
framebuffer_check(), but might cause an issue during VKMS software composit=
ion:

drivers/gpu/drm/vkms/vkms_formats.c:packed_pixels_offset() {
...
	int block_y =3D y / drm_format_info_block_height(format, plane_index);
	int block_pitch =3D fb->pitches[plane_index] * drm_format_info_block_heigh=
t(format,
										  plane_index);
	*rem_x =3D x % drm_format_info_block_width(format, plane_index);
	*rem_y =3D y % drm_format_info_block_height(format, plane_index);
	*offset =3D fb->offsets[plane_index] +
		  block_y * block_pitch +
		  block_x * format->char_per_block[plane_index];
...
}

Since block_pitch and block_y are signed 32-bit integers, could the
multiplication of block_y * block_pitch overflow into a negative value?

This negative offset propagates to *offset, and later in packed_pixels_addr=
():

drivers/gpu/drm/vkms/vkms_formats.c:packed_pixels_addr() {
...
	packed_pixels_offset(frame_info, x, y, plane_index, &offset, rem_x, rem_y);
	*addr =3D (u8 *)frame_info->map[0].vaddr + offset;
}

Could adding this signed 32-bit integer offset to the 64-bit virtual address
pointer trigger sign-extension, effectively subtracting a large amount from
the base address and allowing an out-of-bounds kernel memory read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820083123.5446=
55-3-oushixiong1025@163.com?part=3D1
