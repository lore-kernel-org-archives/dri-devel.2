Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087CCC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 09:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EA510E3DC;
	Sat, 22 Aug 2026 09:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CWE99l12";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EDB10E3DC
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 09:58:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F9AD6001A;
 Sat, 22 Aug 2026 09:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0651F000E9;
 Sat, 22 Aug 2026 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787392689;
 bh=vAHdrnxi+Z2j3CkQKlqlicU2mGfvNAlReKvLySiBpWM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CWE99l12bvUTs/yaXTVVWUcDw06ALQ6PedJXHZDuQ98b/hAi4nXvAMUHykZGlPILx
 NJQpjzZOQt0x9uP2/T1q+CUshGebC6Cl6uKGlx1OGpafJuVe4x3tH3vSvxpWckrHvK
 SxoBXomYIj2KohAWlrmcH8nZH1Pf9quLEoOlv9aBQAAuUrKLmZXbqiTfAhVQHIdNOv
 UR2RHFnuB/pkLHkUvM4iHM5lG7JcNBcH4ak1VH4K0aqFKlA8EMFI1rM+HvPvS0CjZP
 BWaAnp+NRPzBfA5YtSMMw+RC5wNOLxesogS/YoZQP1ZpSBMQPvOjZens4c9aduE6qw
 kp4LwSSzkgZiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in
 panel_enabled()
To: "Helge Deller" <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260822094805.421002-1-deller@gmx.de>
References: <20260822094805.421002-1-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:58:08 +0000
Message-Id: <20260822095809.1D0651F000E9@smtp.kernel.org>
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
- [High] Hardcoded little-endian assumption when transmitting the command b=
yte breaks the driver on big-endian architectures.
--

--- Patch [1]: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in panel_en=
abled() ---
commit a9e06be56fc1b74d7c6e76133e9ea1c25675a615
Author: Helge Deller <deller@gmx.de>
Subject: fbdev: omapfb: Fix __be32 sparse warning in panel_enabled()

This commit resolves a sparse warning in panel_enabled() by explicitly
reading the display status into a __be32 variable. It then converts this
value to CPU endianness using __be32_to_cpu() before checking the bits.

Closes: https://lore.kernel.org/oe-kbuild-all/202608211811.lps93xao-lkp@int=
el.com/

> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565a=
km.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> index 8f430d9e80549..0202ca8cbfc23 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> @@ -210,12 +210,13 @@ static void set_display_state(struct panel_drv_data=
 *ddata, int enabled)
> =20
>  static int panel_enabled(struct panel_drv_data *ddata)
>  {
> +	__be32 disp_status_be;
>  	u32 disp_status;
>  	int enabled;
> =20
>  	acx565akm_read(ddata, MIPID_CMD_READ_DISP_STATUS,
> -			(u8 *)&disp_status, 4);

[Severity: High]
This is a pre-existing issue, but while looking at endianness fixes in this
file, does acx565akm_transfer() have a similar issue on big-endian
architectures?

When acx565akm_read() calls acx565akm_transfer(), it passes the command as
an int:

drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c:acx565akm_=
transfer() {
    ...
    cmd &=3D  0xff;
    x->tx_buf =3D &cmd;
    x->bits_per_word =3D 9;
    x->len =3D 2;
    ...
}

Because bits_per_word > 8, the SPI controller reads the buffer as a 16-bit
integer. Taking the address of a 32-bit int on a little-endian system yields
the command byte in the lowest bits. However, on big-endian systems, &cmd
points to the most significant bytes (which are 0x00).

Will the SPI controller end up transmitting 0x0000 instead of the requested
command on big-endian architectures?

> -	disp_status =3D __be32_to_cpu(disp_status);
> +			(u8 *)&disp_status_be, 4);
> +	disp_status =3D __be32_to_cpu(disp_status_be);
>  	enabled =3D (disp_status & (1 << 17)) && (disp_status & (1 << 10));
>  	dev_dbg(&ddata->spi->dev,
>  		"LCD panel %senabled by bootloader (status 0x%04x)\n",
>  		enabled ? "" : "not ", disp_status);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822094805.4210=
02-1-deller@gmx.de?part=3D1
