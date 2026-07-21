Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE38C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2F810E353;
	Tue, 21 Jul 2026 13:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SF9G7O5w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7DC10E353
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4514D600DA;
 Tue, 21 Jul 2026 13:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD0C1F00A3D;
 Tue, 21 Jul 2026 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784642247;
 bh=kf8eZ6K+bHuIGhOUWZxEqPuHsjwCiWazT1UrFg6LJPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SF9G7O5wHpiCCbpYmq7yLmHTim+6Ed4f6FudzcTiLQjoKen3SOb4XXgmNGfT6jMuS
 bqKSPPuW9uLQhkGyxNxuYoyKhdGGlrx1gexIihcX+HK0d6UaRdKyfJXYlpspHeHJRX
 b2kfSw91eHhKwv/PG5s+I6qfWZO6pDG/MRhGPynWZioLVlcF3aHIdn7PExH704B2EE
 5iKD/ZwgpSwd+n8qLjH6YUOYuqCOK5UemKU8fcTroii6r2Qul1xoxmoePpMtKel3Rp
 zaLpGDb9u/ISX0EOpQY8VNhBwUesOZlp4nmm5mYUPhnAZfRGKV8zqfW+vVSIT+MFXn
 u8KlxoHpGsLRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/gma500: Handle zero-length GMBUS writes
To: "Xuan Tang" <x14786623579@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721134910.844678-1-x14786623579@163.com>
References: <20260721134910.844678-1-x14786623579@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:57:26 +0000
Message-Id: <20260721135726.CFD0C1F00A3D@smtp.kernel.org>
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
- [High] Incomplete fix: The patch addresses an out-of-bounds access for ze=
ro-length I2C writes but entirely misses the identical bug in the zero-leng=
th I2C read path. If a zero-length read message is processed, the unconditi=
onal `do-while` loops will underflow `len` and write 65536 bytes out-of-bou=
nds to the `buf` pointer.
--

--- Patch [1]: [PATCH v2] drm/gma500: Handle zero-length GMBUS writes ---
commit 7fd0792ed62f6cc7ed832202067488e2f598937f
Author: Xuan Tang <x14786623579@163.com>

drm/gma500: Handle zero-length GMBUS writes

This commit fixes an out-of-bounds access in the GMBUS write path for
zero-length transfers. It changes a do-while loop to a while loop, preventi=
ng
the underflow of the length parameter and subsequent invalid memory access.

> diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma50=
0/intel_gmbus.c
> index 5933ae04a6aa5..d004e2a1feaee 100644
> --- a/drivers/gpu/drm/gma500/intel_gmbus.c
> +++ b/drivers/gpu/drm/gma500/intel_gmbus.c
> @@ -294,9 +294,10 @@ gmbus_xfer(struct i2c_adapter *adapter,

[Severity: High]
This is a pre-existing issue, but does the read path just above this fix
have the exact same vulnerability?

Looking at gmbus_xfer(), if an I2C message with I2C_M_RD is processed and
len is 0, the read path uses an identical unconditional do-while loop:

				val =3D GMBUS_REG_READ(GMBUS3 + reg_offset);
				do {
					*buf++ =3D val & 0xff;
					val >>=3D 8;
				} while (--len && ++loop < 4);
			} while (len);

Would this also underflow len and write 65536 bytes out-of-bounds to the buf
pointer?

>  			u32 val, loop;
> =20
>  			val =3D loop =3D 0;
> -			do {
> -				val |=3D *buf++ << (8 * loop);
> -			} while (--len && ++loop < 4);
> +			while (len && loop < 4) {
> +				val |=3D *buf++ << (8 * loop++);
> +				len -=3D 1;
> +			}
> =20
>  			GMBUS_REG_WRITE(GMBUS3 + reg_offset, val);
>  			GMBUS_REG_WRITE(GMBUS1 + reg_offset,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721134910.8446=
78-1-x14786623579@163.com?part=3D1
