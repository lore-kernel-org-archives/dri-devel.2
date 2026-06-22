Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46399CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E56C10E695;
	Mon, 22 Jun 2026 12:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FlSEBVnx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7189E10E695
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED399401CC;
 Mon, 22 Jun 2026 12:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4A31F000E9;
 Mon, 22 Jun 2026 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782131791;
 bh=G+3A1UBzmJkF6RD9iuqBkgqnMMUyYvENWZnCDa7vx8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FlSEBVnxk/IlTxjwLSrS7qtf/7BIgwPVK/eHgaJyz5/7QZMeExGsl2vicTMe2pcw4
 v9jA5KcbVQZCVBw808xWI3V/DIdhSIqqdIo/T8xufmw2BRqyOiPo/pzVpSVC8mxSxz
 4evDs/zUyJFawORPyD49cQIjbCbCg5kEGKli0HVcZhnXxHE+kSAtt2aqS7Yb7fiuGp
 MTbg0/T4L61T2EA1I6/xrxZQgnC8ohtQGdVs61QAGq8s4kJKEg3ApQ8A5WC1M85yYn
 +BWvD4oy4XveDozvxMYv6hAVzpZAjSJr0nn1RrWYzW/6p30T79Nj6IYbs3YfJIr52k
 fB0HXhL3TKOcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622122604.32500-2-amit.barzilai22@gmail.com>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
 <20260622122604.32500-2-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:36:30 +0000
Message-Id: <20260622123631.8B4A31F000E9@smtp.kernel.org>
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
- [High] Potential 1-byte out-of-bounds read past the heap buffer in `ssd13=
2x_update_rect` when device width is configured to an odd value.
--

commit de1c71cf327dfb3f916baab562b7b1c9945af5e9
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: fix column and row end address in partial updates for ssd132x

This commit corrects the relative end addresses used in the "Set Column Add=
ress"
and "Set Row Address" commands for SSD132X controllers during partial screen
updates. It ensures that the absolute addresses are correctly calculated and
sent to the controller.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

[ ... ]

> @@ -864,12 +864,13 @@ static int ssd132x_update_rect(struct ssd130x_devic=
e *ssd130x,
>  	 */
> =20
>  	/* Set column start and end */
> -	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segmen=
t_width, columns - 1);
> +	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segmen=
t_width,
> +				x / segment_width + columns - 1);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set row start and end */
> -	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, rows - =
1);
> +	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, y + row=
s - 1);
>  	if (ret < 0)
>  		return ret;
> =20
>  	for (i =3D 0; i < height; i++) {
>  		/* Process pair of pixels and combine them into a single byte */
>  		for (j =3D 0; j < width; j +=3D segment_width) {
>  			u8 n1 =3D buf[i * width + j];
>  			u8 n2 =3D buf[i * width + j + 1];

[Severity: High]
This is a pre-existing issue, but could this loop read out of bounds if the
device tree specifies an odd solomon,width (e.g., 129)?

If the device width is configured to an odd value, the update rectangle's
width can also be odd. The buffer array is allocated in
ssd132x_primary_plane_atomic_check() with exactly pitch * height bytes
(where pitch equals width).

During the last iteration of the final row, j + 1 would evaluate to width.
This causes the n2 assignment to access buf[height * width], which is one
byte past the requested allocation size.

Can this trigger a KASAN out-of-bounds read warning or scramble display
output on odd-width panels by reading across row boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622122604.3250=
0-1-amit.barzilai22@gmail.com?part=3D1
