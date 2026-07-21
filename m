Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA7C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1075710E16D;
	Tue, 21 Jul 2026 13:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dAQbzqFJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BAED10E16D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:40:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D03F84175A;
 Tue, 21 Jul 2026 13:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BD51F00A3D;
 Tue, 21 Jul 2026 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784641250;
 bh=TwVvLTu/EOrrSlKQU642FcVqgxZwE0MMh5ZAx1Mso5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dAQbzqFJmBRfKB7YV4DtiOLf7XJxoZine9rkN4JR+1f/lf+ZDcA9E+jgHzSGJJ19h
 5TEsN5qwumnliPVXtvCHL/1KQZqN44C/n8DJN3L4gHrT/+r+cNqtE7Pk2rBwrY0xha
 iMiwJIit35DhwjWtuLZqO71/19gqCWE5Xhhn2Tr2m+H6brjVAm+DLSZ+eEW9XiuXrk
 ueTmbV58HgGAG1xZTS3XeiEMMxU5izwZ1/lzmN2kbIfn2mZ9VP4dYScEaQSul46W/X
 RkVmNnAAWYZJqzrDfRGYDyfrFr3Xw1Cuc7KtjD6kW9Tr6DKT91dAWS7N0YhiWBAreS
 Ba2Bo1skIJM4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gma500: Handle zero-length GMBUS writes
To: "Xuan Tang" <x14786623579@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721133200.844629-1-x14786623579@163.com>
References: <20260721133200.844629-1-x14786623579@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:40:50 +0000
Message-Id: <20260721134050.89BD51F00A3D@smtp.kernel.org>
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
- [High] The new while loop condition uses a bitwise AND (`&`) instead of a=
 logical AND (`&&`), causing it to evaluate incorrectly and terminate prema=
turely, completely breaking I2C writes for even lengths.

Pre-existing issues:
- [High] The patch fixes an out-of-bounds access for zero-length I2C writes=
 but leaves the exact same vulnerability unpatched in the I2C read path, ca=
using a massive heap buffer overflow.
--

--- Patch [1]: [PATCH] drm/gma500: Handle zero-length GMBUS writes ---
commit 95b6f28264b9df08009a4c63ada1cc3e62a730c8
Author: Xuan Tang <x14786623579@163.com>

drm/gma500: Handle zero-length GMBUS writes

This commit modifies the GMBUS write path in gmbus_xfer() to handle
zero-length I2C writes. It replaces a do-while loop with a while loop to
ensure the buffer is not accessed if the length is zero.

> diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma50=
0/intel_gmbus.c
> index 5933ae04a6aa5..dce3408a666f2 100644
> --- a/drivers/gpu/drm/gma500/intel_gmbus.c
> +++ b/drivers/gpu/drm/gma500/intel_gmbus.c
> @@ -294,9 +294,10 @@ gmbus_xfer(struct i2c_adapter *adapter,
>  			u32 val, loop;
> =20
>  			val =3D loop =3D 0;
> -			do {
> -				val |=3D *buf++ << (8 * loop);
> -			} while (--len && ++loop < 4);
> +			while (len & loop < 4) {

[Severity: High]
Does this condition evaluate correctly? In C, the relational operator <
has higher precedence than the bitwise AND &, so this evaluates as
(len & (loop < 4)).

For an even length, len & 1 is 0, which would cause the loop to exit
immediately without preloading any bytes into the GMBUS data register. Could
this break I2C writes for all even lengths?

[Severity: High]
This is a pre-existing issue, but the I2C read path in gmbus_xfer() appears
to have the exact same vulnerability that this patch fixes in the write pat=
h.

Looking at the I2C read path earlier in gmbus_xfer():

drivers/gpu/drm/gma500/intel_gmbus.c:gmbus_xfer() {
    ...
		if (msgs[i].flags & I2C_M_RD) {
			/* ... */
			do {
				/* ... */
				val =3D GMBUS_REG_READ(GMBUS3 + reg_offset);
				do {
					*buf++ =3D val & 0xff;
					val >>=3D 8;
				} while (--len && ++loop < 4);
			} while (len);
    ...
}

Will a zero-length I2C read request also unconditionally dereference buf
and underflow the 16-bit unsigned len to 65535, causing a massive
out-of-bounds write into the buffer memory?

> +				val |=3D *buf++ << (8 * loop++);
> +				len -=3D 1;
> +			}
> =20
>  			GMBUS_REG_WRITE(GMBUS3 + reg_offset, val);
>  			GMBUS_REG_WRITE(GMBUS1 + reg_offset,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721133200.8446=
29-1-x14786623579@163.com?part=3D1
