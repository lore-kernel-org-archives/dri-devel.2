Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9598C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2578510FB72;
	Sat,  5 Sep 2026 01:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cwMvLzqN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AEE10FB72
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:03:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75F60600E2
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0247C1F00A3D;
 Sat,  5 Sep 2026 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570206;
 bh=fWZU2sDwBeghdlEt10wez5tUPhS/f3fRKJZi4MtG+9E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cwMvLzqNuO2E6fzL6kDmcGm7Fn2p7pAY7xIGgl/uOxuGe2W3DG153kG9k6Yn1C0ar
 BT1gRV2dtr4PE3ziAjmUzkl9kjPQjRMtgelG22Z2t2QYerRAscBbynYQzWuWl2xsxh
 NVpU2D+jesM69ByJ+ybXr+YoNPVhb96jMjsfD40lOJGYOpCjaZDmcATYPkCGyKupbT
 +jqvSx1mKxlVlMv+QVKy1eduPXQ0hZPa7OjAmvudXsQbuXp1EC8bZwhQjb3MrqnIPX
 GP0IM/E87kEUPnVvT2K73OV5aJRzEC8vMZilVJAUtVVsJ71WI29zw47H5Jnt8Li0lJ
 jVtc1XkxVho7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/19] accel: ethosu: Split U65 and U85 DMA length
 validation
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-17-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-17-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:03:25 +0000
Message-Id: <20260905010326.0247C1F00A3D@smtp.kernel.org>
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
- [Critical] For Ethos-U65, the shared DMA skip values are parsed and assig=
ned only to the destination stride, leaving the source stride uninitialized=
 (zero). This causes the driver to severely underestimate the required sour=
ce buffer size, allowing userspace to bypass bounds validation and trigger =
out-of-bounds memory accesses.
--

commit f80309886975bd6af6358046bb0e792268687173
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Split U65 and U85 DMA length validation

This commit splits the DMA length calculation in the Ethos-U driver into
separate versions for U65 and U85 to handle their slightly different
programming models. The U65 uses skip values added to the size, while
the U85 uses independent signed stride values.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index c3dad3f80c34b..559fbf55f12d5 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -225,40 +225,92 @@ static bool dma_params_valid(struct ethosu_device *=
edev, struct cmd_state *st,
[ ... ]
> +static u64 dma_length_u65(struct ethosu_validated_cmdstream_info *info,
> +			  struct dma_state *dma_st,
> +			  struct dma *dma)
>  {
>  	s8 mode =3D dma->mode;
>  	u64 len =3D dma->len;
> =20
> -	if (!dma_params_valid(edev, st, dma_st, dma, region_cmd, addr_cmd))
> -		return U64_MAX;
> +	if (mode >=3D 1) {
> +		if (check_add_overflow(len, (u64)dma->stride[0], &len) ||
> +		    check_mul_overflow(len, (u64)dma_st->size0, &len))
> +			return U64_MAX;
> +	}

[Severity: Critical]
Does this code underestimate the bounding memory range for the source buffe=
r?

When evaluating the source DMA length for U65, dma->stride[0] will be 0
because ethosu_gem_cmdstream_copy_and_validate() only assigns the skip
value to the destination stride. This bypasses the skip value expansion and
could allow userspace to bypass bounds validation, potentially triggering
out-of-bounds memory accesses.

[ ... ]
> @@ -1047,16 +1099,28 @@ static int ethosu_gem_cmdstream_copy_and_validate=
(struct drm_device *ddev,
>  			st.dma.size1 =3D param;
>  			break;
>  		case NPU_SET_DMA0_SRC_STRIDE0:
> -			st.dma.src.stride[0] =3D ((s64)addr << 24) >> 24;
> +			if (ethosu_is_u65(edev))
> +				st.dma.dst.stride[0] =3D addr;

[Severity: Critical]
Is it intentional that the user-provided shared stride is only assigned to
the destination stride here?

This leaves the source stride, st.dma.src.stride[0], uninitialized (0)
for U65, leading to the regression in dma_length_u65() where length bounds
are underestimated. Should this also be assigned to st.dma.src.stride[0]
for U65?

> +			else
> +				st.dma.src.stride[0] =3D sign_extend64(addr, 39);
>  			break;
>  		case NPU_SET_DMA0_SRC_STRIDE1:
> -			st.dma.src.stride[1] =3D ((s64)addr << 24) >> 24;
> +			if (ethosu_is_u65(edev))
> +				st.dma.dst.stride[1] =3D addr;

[Severity: Critical]
Does this same regression occur for stride 1?

It appears this also leaves st.dma.src.stride[1] uninitialized for U65.

> +			else
> +				st.dma.src.stride[1] =3D sign_extend64(addr, 39);
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D17
