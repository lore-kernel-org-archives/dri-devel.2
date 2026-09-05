Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F7C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CE710FB53;
	Sat,  5 Sep 2026 00:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PP1TdVTD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E7810FB53
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:56:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F22D343B91
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C941F00A3D;
 Sat,  5 Sep 2026 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569788;
 bh=HVcj8+u1Adftycv3hl3a93bOPV7P5gwfwoEpw4It02k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PP1TdVTDJMJU4OVCiZTSQPZfi0kkMA8o/UgqjcAU4Dma3S08SZKs1S4i6C9edoCZS
 +6GQ30o9V24YU80zvBanSZj9sVrdMlSvpVEXxWIJdaUi6/EnzdRnCBBEWyUgb/cxDT
 uujIB/8KFOtcAeldw5Q/ZuWOcmaKPFP286Ypye8hmbF/jOgr4RxYcaRMp/NXWZb5vK
 CBpElSYooNn4Paao5nVmXc/UZZEGUzSOd4LO8OAuKoky6GGWaCpEkMtLzKJKu0Lltc
 dAlYnrvlvV5VvQjGNWWyf2RPauYDKoh86wjW+lPxtOWZn4Wi/sydOaT9rNrOUTEc+Z
 yJC+950TAc+EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/19] accel: ethosu: Account for feature map element
 size
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-11-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-11-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:56:28 +0000
Message-Id: <20260905005628.B2C941F00A3D@smtp.kernel.org>
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
- [Critical] Incomplete bounds validation for multi-tile feature maps in `f=
eat_matrix_size` allows the NPU to access memory outside the GEM buffer.
- [High] The `feat_matrix_length` function does not account for the 16-chan=
nel hardware brick alignment for NHCWB16 formats, underestimating the buffe=
r size.
--

commit 5efa0071e22603105740c81590f076bdcb4fef2a
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Account for feature map element size

The feature map bounds calculation currently accounts for only one byte
of the final element. This can leave the tail of B16, B32, and B64
elements outside the validated buffer, so the commit uses the feature map
element size when calculating the final byte.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index c54496fa08f4c..bca68fab05275 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -415,7 +415,7 @@ static u64 feat_matrix_length(struct ethosu_device *e=
dev,
>  		return U64_MAX;
>  	}
> =20
> -	if (check_add_overflow(addr, 1ULL, &offset))
> +	if (check_add_overflow(addr, (u64)element_size, &offset))

[Severity: High]
This isn't a bug introduced by this patch, but while the patch adds a missi=
ng
single element_size to the calculation, is it sufficient for NHCWB16 format=
s?

Looking slightly above in feat_matrix_length():

	case 1: //nhcwb16:
		element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);

		if (check_mul_overflow(c / 16, (u64)fm->stride_c, &offset) ||
		    check_add_overflow(addr, offset, &addr) ||
		    check_mul_overflow(16 * x + (c & 0xf), element_size, &offset) ||
		    check_add_overflow(addr, offset, &addr))
			return U64_MAX;
		break;

The Ethos-U NPU inherently processes NHCWB16 data in 16-channel bricks. If
the channel depth modulo 16 is less than 15, the hardware will still read
or write the full 16-element brick.

Because the validation calculation stops precisely after the specified chan=
nel
and doesn't appear to round up the offset to the 16-element brick boundary,
could it underestimate the required buffer size by up to 15 * element_size
bytes, leading to out-of-bounds hardware memory accesses?

>  		return U64_MAX;
> =20
>  	info->region_size[fm->region] =3D max(info->region_size[fm->region], of=
fset);


[Severity: Critical]
This is a pre-existing issue, but incomplete bounds validation for multi-ti=
le
feature maps in feat_matrix_size() might allow the NPU to access memory
outside the GEM buffer.

In drivers/accel/ethosu/ethosu_gem.c:feat_matrix_size():

	if (ethosu_is_u65(edev) || storage =3D=3D 0) {
		for (int xi =3D 0; xi < 2; xi++) {
			for (int yi =3D 0; yi < 2; yi++) {
				ret =3D feat_matrix_check_location(edev, info, st, fm, type,
								 xi ? x : 0,
								 yi ? y : 0, c, ofm,
								 max_len);
				if (ret)
					return ret;
			}
		}
		return 0;
	}

The loop evaluates the minimum and global maximum coordinates but skips the
internal boundary coordinates (like fm->width0) of intermediate tiles.

Similarly, for vertically split tiles (storage =3D=3D 1):

	if (storage =3D=3D 1) {
		ret =3D feat_matrix_check_location(edev, info, st, fm, type, x, 0, c,
						 ofm, max_len);

The maximum Y coordinate within the first tile (fm->height[0]) is completely
omitted from bounds validation.

If a multi-tile feature map is submitted, and tile 0's base address is
configured near the end of the GEM allocation, with a massive internal
width0 and stride_x for tile 0 (while properly bounding subsequent tiles
so the global maximum falls into tile 1), could this artificially bypass
validation for the rest of tile 0 and allow unconstrained memory accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D11
