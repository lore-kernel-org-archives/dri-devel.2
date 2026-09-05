Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C392C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B7A10FB79;
	Sat,  5 Sep 2026 01:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="msAHWrjN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6C310FB79
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:05:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C59154132D
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866411F00A3D;
 Sat,  5 Sep 2026 01:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570323;
 bh=2sJiSD34X1+FE11e+kfUkJofuh5eVi12pXZwHag/4QQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=msAHWrjNNgg28M6D+jJ8y4QPg53MspFTcE/FdLz67coZfCV6yeuGq1PEsmUiqgNwS
 MBCcZUWdlrznehwSdWwJG53eDm1M+U5M/x1760fUGVP9bqekyGUrT4nucpN7Wc+TrT
 H/33dDEc82aWfICwYtQa4FBGELAj9vt6MTndeU2Xr55A1GWhsGSuz3xjObBTw6mMYI
 Jl6ApgSih5bMtgVEtn4DVj4IiILujMAEdyzskGeYWw8z4p/bWocaPP1nDCQBTyK0so
 kcn6xGhZPoI+YFcLCR/phfADz21xEoC/CpcBlNHeuhdvzXIPrqKrgM6hdLCbiZdWnM
 mJ2uJ7xlQKR/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/19] accel: ethosu: Validate OFM transpose
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-18-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-18-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:05:23 +0000
Message-Id: <20260905010523.866411F00A3D@smtp.kernel.org>
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
- [Critical] feat_matrix_size completely fails to evaluate intermediate til=
e boundaries, allowing arbitrary out-of-bounds DMA access
- [High] feat_matrix_length assumes monotonic address growth for nhcwb16 fo=
rmat, underestimating buffer bounds by up to 60 bytes
--

commit 5cfa238ea5bc9f37e1c0be661f6a282b416aafb4
Author: Rob Herring (Arm) <robh@kernel.org>
Subject: accel: ethosu: Validate OFM transpose

U85 OFM dimensions are specified before transposition, while
tile bases and strides address the transposed feature map. Permute
the output endpoint before validating its tile and stride accesses.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 559fbf55f12d5..8114447891b25 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -397,6 +397,52 @@ static int feat_matrix_validate(struct ethosu_device=
 *edev,
> =20
>  	return 0;
>  }
> +
> +static int feat_matrix_permute(struct ethosu_device *edev,
> +			       struct feat_matrix *fm, u32 *x, u32 *y,
> +			       u32 *c, bool ofm)
> +{

[ ... ]

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  static u64 feat_matrix_length(struct ethosu_device *edev,
>  			      struct ethosu_validated_cmdstream_info *info,
>  			      struct cmd_state *st, struct feat_matrix *fm,

[Severity: High]
This isn't a bug introduced by this patch, but feat_matrix_length() assumes
monotonic address growth for the nhcwb16 format, underestimating buffer
bounds by up to 60 bytes.

For the nhcwb16 format, the address offset calculation:

    check_mul_overflow(c / 16, (u64)fm->stride_c, &offset) ||
    ...
    check_mul_overflow(16 * x + (c & 0xf), element_size, &offset)

is not monotonic with respect to c if stride_c is smaller than
15 * element_size (which userspace fully controls).

Because the validator only checks the offset at the maximum depth,
malicious userspace can set stride_c to 0 and c_max to 16. It then
evaluates only at c=3D16, which yields 16 * x * element_size.

However, the hardware will also access c=3D15, resulting in a larger offset
of 16 * x * element_size + 15 * element_size. This allows out-of-bounds DMA
access into adjacent kernel memory.

Can this logic be updated to evaluate the maximum offset accurately by
accounting for intermediate values of c?

> @@ -502,6 +548,9 @@ static int feat_matrix_size(struct ethosu_device *ede=
v,
>  	int ret;
> =20
>  	*max_len =3D 0;
> +	ret =3D feat_matrix_permute(edev, fm, &x, &y, &c, ofm);
> +	if (ret)
> +		return ret;
> =20
>  	if (ethosu_is_u65(edev) || storage =3D=3D 0) {
>  		for (int xi =3D 0; xi < 2; xi++) {
>  			for (int yi =3D 0; yi < 2; yi++) {
>  				ret =3D feat_matrix_check_location(edev, info, st, fm, type,
>  								 xi ? x : 0,
>  								 yi ? y : 0, c, ofm,
>  								 max_len);

[Severity: Critical]
This is a pre-existing issue, but feat_matrix_size() completely fails to
evaluate intermediate tile boundaries, allowing arbitrary out-of-bounds DMA
access.

For tiled matrices (storage =3D=3D 0 or storage =3D=3D 1), each tile has an
independent base address. The maximum memory offset within tile 0 occurs
at x =3D min(x, fm->width0) and y =3D min(y, fm->height[0]).

The validator never evaluates these intermediate maxima:

For storage =3D=3D 0, it only evaluates x at 0 and max_x in the loop:

    for (int xi =3D 0; xi < 2; xi++) {
        for (int yi =3D 0; yi < 2; yi++) {
            ret =3D feat_matrix_check_location(..., xi ? x : 0, yi ? y : 0,=
 ...);

This misses the local maximum x offset inside tile 0 (fm->width0).

For storage =3D=3D 1, it evaluates y at 0 and fm->height[1]:

    if (fm->height[0] < fm->height[1] && fm->height[1] <=3D y) {
        ret =3D feat_matrix_check_location(..., x, fm->height[1], ...);

This completely skips the end of tile 0 (fm->height[0]), leaving the max
offset for tile 0 unvalidated.

Userspace can bypass validation by setting base[0] near the end of the
buffer while base[0] + offset(x, fm->height[0]) massively overflows it.

Could this be corrected to evaluate the local maxima for tile boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D18
