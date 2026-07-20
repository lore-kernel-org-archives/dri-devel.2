Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2459FC4452F
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3D910E220;
	Mon, 20 Jul 2026 23:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RrEJLK+N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE2010E225
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 23:34:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E5E5F410BD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 23:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D081F000E9;
 Mon, 20 Jul 2026 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784590458;
 bh=qNNia4lMuvQpT0U54orSqNaD2VkdP9PUB22oJtneRNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RrEJLK+NTIQ8VCEgg8tDRacQADCP6O/XKQPnvdwzS4Vk+aZxN4Ju7r3HdN7d2McbJ
 zrDiUMIM7Zcb8SnOEWEIPRNFOC6lnVPAzD8kcUA+4TJ5310oQKUgKWpL9p4nXjZ4qr
 ym/lP7UdG3qVFDATAaj03GwfxQn4hTmMpdK2iTXS1vrq6yVmdWm6RgjEJLkVdGmin1
 F90p9bsybwA6nBb2FcUdj8fYZHu4hyRutGOWsgYzwQSG8wDTFN8eGpdECPza7ly/c2
 pJwpwn1XvQH5XW6DM5m/wf98losqR7UK4Hvev+KI2rTo30NKMdefqM1bITh+ENJaRa
 FQ9PimYb0ZXlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] accel: ethosu: Fix element size accounting for cmd
 stream validation
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720231450.485221-1-robh@kernel.org>
References: <20260720231450.485221-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 23:34:18 +0000
Message-Id: <20260720233418.A7D081F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The command stream validation silently ignores unsupported/unk=
nown formats (values 2 and 3), under-calculating the required buffer size a=
nd allowing out-of-bounds memory accesses.
- [Critical] Buffer bounds validation incorrectly evaluates the memory foot=
print only at the maximum dimension indices, missing active tiles and faili=
ng on negative strides or overflows.
--

--- Patch [1]: [PATCH 1/2] accel: ethosu: Fix element size accounting for c=
md stream validation ---
commit 295d16016ba05ed08c0ba3586bc6d83af9ebb17a
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Fix element size accounting for cmd stream validation

There are 2 issues with the element size handling in the command stream
validation which result in too small of a size calculated when the
element size is 16/32/64 bits.

For NHWC format, the element size is simply missing from the
calculation.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 3401883e207fc..1daff32610c71 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -194,7 +194,7 @@ static u64 dma_length(struct ethosu_validated_cmdstre=
am_info *info,

[Severity: Critical]
This is a pre-existing issue, but does the buffer bounds validation in
feat_matrix_length() correctly evaluate the memory footprint for all tiles
and negative strides?

Looking at the calculation earlier in the function:

	switch (storage) {
	case 0:
		if (x >=3D fm->width0 + 1) {
			x -=3D fm->width0 + 1;
			tile +=3D 1;
		}
		if (y >=3D fm->height[tile] + 1) {
			y -=3D fm->height[tile] + 1;
			tile +=3D 2;
		}
		break;
	case 1:
		if (y >=3D fm->height[1] + 1) {
			y -=3D fm->height[1] + 1;
			tile =3D 2;
		} else if (y >=3D fm->height[0] + 1) {
			y -=3D fm->height[0] + 1;
			tile =3D 1;
		}
		break;

By evaluating the maximum memory requirement only at the maximum y dimensio=
n,
the driver seems to fail validating accesses at y=3D0, which would result i=
n a
higher address if stride_y is negative.

Additionally, when a tensor spans multiple tiles (e.g. tile =3D 2), the
validation logic checks only the last tile, entirely skipping bounds checks
for the earlier tiles. Could a userspace process bypass validation by
setting these unchecked bases to out-of-bounds addresses, leading to
out-of-bounds DMA?

>  static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *in=
fo,
>  			      struct feat_matrix *fm,
> -			      u32 x, u32 y, u32 c)
> +			      u32 x, u32 y, u32 c, bool ofm)
>  {
>  	u32 element_size, storage =3D fm->precision >> 14;
>  	int tile =3D 0;

[ ... ]

> @@ -231,10 +231,11 @@ static u64 feat_matrix_length(struct ethosu_validat=
ed_cmdstream_info *info,
> =20
>  	switch ((fm->precision >> 6) & 0x3) { // format

[Severity: Critical]
This isn't a bug introduced by this patch, but what happens here if a
userspace process submits a command stream with a precision format of
2 or 3?

Since the switch lacks handling for cases 2 and 3, it seems to silently fall
through and bypass adding the x and c components to the address offset.
Does this cause the validation routine to compute a falsely small memory
footprint, potentially allowing the command to execute on a
smaller-than-required buffer and perform out-of-bounds DMA access?

>  	case 0: //nhwc:
> -		addr +=3D x * fm->stride_x + c;
> +		element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
> +		addr +=3D x * fm->stride_x + c * element_size;
>  		break;
>  	case 1: //nhcwb16:
> -		element_size =3D BIT((fm->precision >> 1) & 0x3);
> +		element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
> =20
>  		addr +=3D (c / 16) * fm->stride_c + (16 * x + (c & 0xf)) * element_siz=
e;
>  		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720231450.4852=
21-1-robh@kernel.org?part=3D1
