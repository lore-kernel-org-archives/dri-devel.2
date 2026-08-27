Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CDAC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F7510F1D0;
	Thu, 27 Aug 2026 20:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZR/vNwB8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F6910F1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:56:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB1FE601EF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D471F000E9;
 Thu, 27 Aug 2026 20:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787864161;
 bh=M9LbTLcIKWGTuhUXblJDV/fMCP/odpke2zXiSi7Do7Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZR/vNwB81HeREV/LDqDOeHFUvH0MyXI5J0a1lnceG5ItaMBi1g3+o1PoUk1oCOm1v
 WJbaKWLMFdNKQujrGDOayUb2T+n5sTsCxuOT1qJABuXRaa+ZDsk6y7VObm5KGBVU/o
 BnHWryOZ6cH0uHdLgKk84U2RQt+rUXcR9CZvOWqR8A7z5A9+GVdKJI0fv4b5oMu9cn
 AsiPqhtunNPxXLvfmG/ztG+OT0O+aO8wO0TkNqr4gMvS3I+fQuMUZmIVPToxis6hT1
 b31ErV71zG44bLAZByqX7TRX2NPQxeKV7sTJezLlfxAzLFnyeiloMJTk9Qq9YMTkYD
 GjKLAog2rTLYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] accel: ethosu: Validate OFM transpose
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-11-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-11-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:56:01 +0000
Message-Id: <20260827205601.82D471F000E9@smtp.kernel.org>
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
- [Critical] Inconsistent extraction of the 'storage' configuration bitfiel=
d between `feat_matrix_size` and `feat_matrix_length` allows an attacker to=
 bypass bounds checking for `base[3]` on U65 devices, leading to arbitrary =
out-of-bounds memory accesses by the NPU.
--

commit bea32820db5d7b74645ac247f33a7633b6b22166
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate OFM transpose

This commit permutes the output endpoint before validating its tile and
stride accesses on U85 devices, while rejecting reserved transpose encoding=
s.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index a042e650f626a..ad36fb8b3b302 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -283,6 +329,9 @@ static int feat_matrix_size(struct ethosu_device *ede=
v,
>  	int ret;
> =20
>  	*max_len =3D 0;
> +	ret =3D feat_matrix_permute(edev, fm, &x, &y, &c, ofm);
> +	if (ret)
> +		return ret;
> =20
>  	if (ethosu_is_u65(edev) || storage =3D=3D 0) {

[Severity: Critical]
This isn't a bug introduced by this patch, but does this inconsistent
extraction of the storage bitfield lead to missing bounds checks for the
4th tile on U65 devices?

In feat_matrix_size(), storage is correctly forced to 0 for U65 hardware:

drivers/accel/ethosu/ethosu_gem.c:feat_matrix_size() {
	u32 storage =3D ethosu_is_u65(edev) ? 0 : fm->precision >> 14;
    ...
}

This ensures the loop checks all 4 possible tile coordinates. However,
feat_matrix_length() extracts it directly from the precision bits without
checking if the hardware is U65:

drivers/accel/ethosu/ethosu_gem.c:feat_matrix_length() {
	u32 element_size, storage =3D fm->precision >> 14;
    ...
}

If a user provides a command stream with bits 14-15 set to 1 (indicating
storage =3D 1) and sets a large, out-of-bounds offset for base[3],
feat_matrix_size() forces storage =3D 0 and delegates address computation to
feat_matrix_length().

Because feat_matrix_length() uses the unmasked storage =3D 1 value, its tile
computation logic will only ever produce tile =3D 1 or tile =3D 2. As a res=
ult,
the 4th tile (base[3]) is never visited or verified against the GEM buffer
size.

The previous commit "accel: ethosu: Validate all feature map tiles"
attempted to fix U65 tile validation, but left the direct bitwise extraction
in feat_matrix_length() intact.

Since U65 hardware natively uses 2x2 tiling and ignores the storage bits,
could this allow the NPU DMA engine to access arbitrary physical memory
outside the provided GEM buffers when evaluating the true coordinates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D11
