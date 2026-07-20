Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E024C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5201310E194;
	Mon, 20 Jul 2026 19:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DAzXCLcS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578D110E14E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 19:38:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8DBF40E2D;
 Mon, 20 Jul 2026 19:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959C31F000E9;
 Mon, 20 Jul 2026 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784576329;
 bh=o/a6nZ1Lv35/c1Av89l5GRSG3HuLAC3EUlJ4VJEf9OQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DAzXCLcSF4U9AdEYPGmx7RWF4Jkd2C8EbnCE0R+kQbJ2hZRpsdyFWUk847ORpbpqr
 MTRwQbV15Bsj2JFGpL1Ji9zGjpHbE7AOkVS+1ERTeILU9edeXUQ8bFYvOaHVD1Gw+s
 QouqTBe2TJyz4qKSvBUGO6++ilD9RDT7CE8rHMAiPwukcCH7cbfuNIKPCCeSbu1s13
 NABcVHZaTLHjJjcM/xTfxRreTe8MUrTGZtHgrd96497NWghrb3blJdQbdvPFPGDe+F
 2Mcn588Os0XXrprV8eH6r8pMXRX6Dfnhu8S8ORC0/KFfoOr7RRi7Q6qHGpHlULljhz
 XNt2AmbArXJzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ethosu: validate all tiles and the packed-channel
 peak in the cmdstream verifier
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720192044.19557-1-doruk@0sec.ai>
References: <20260720192044.19557-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 19:38:49 +0000
Message-Id: <20260720193849.959C31F000E9@smtp.kernel.org>
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
- [Critical] Missing lower-bound tracking for negative DMA strides allows t=
he NPU to access memory before the start of the buffer.
- [Critical] Missing feature matrix configuration parameters result in `-1`=
 defaults that cause integer underflow in bounds checks, leading to out-of-=
bounds DMA.
--

--- Patch [1]: [PATCH] accel/ethosu: validate all tiles and the packed-chan=
nel peak in the cmdstream verifier ---
commit 272f98612406533d182249a7aefbd612bfb04a39
Author: Doruk Tan Ozturk <doruk@0sec.ai>
Subject: accel/ethosu: validate all tiles and the packed-channel peak in th=
e cmdstream verifier

The patch addresses an issue where feat_matrix_length() computed the maximum
byte offset by evaluating a single presumed-worst corner. This allowed
unprivileged processes to craft command streams that bypassed submit checks
with undersized output buffers, leading to out-of-bounds DMA writes. The fix
evaluates the extent at every corner that can bound the populated tiles and
at the packed-channel peak.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 3401883e207fc..dfc499d7fb0c1 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -192,17 +192,19 @@ static u64 dma_length(struct ethosu_validated_cmdst=
ream_info *info,
>  	return len;
>  }

[Severity: Critical]
This is a pre-existing issue, but is there a missing lower-bound check for
negative DMA strides in dma_length()?

When dma->stride[0] is negative, this function reduces the computed length,
which allows the upper-bound check (len + offset) to pass:

	if (mode >=3D 1) {
		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
			return U64_MAX;
		len +=3D dma->stride[0];
		...

However, there is no lower-bound validation to ensure the minimum accessed
address does not drop below 0. Could an unprivileged user submit a command
stream with a negative stride and an offset near 0, causing the hardware
DMA engine to drop below offset 0 and access memory preceding the GEM buffe=
r?

> =20
> -static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *in=
fo,
> -			      struct feat_matrix *fm,
> -			      u32 x, u32 y, u32 c)
> +/*
> + * Compute the byte offset the NPU addresses for one feature-matrix coor=
dinate
> + * (x, y, c). Storage modes 0 and 1 route disjoint (x, y) sub-rectangles=
 to up
> + * to four independent tile bases; the caller must only pass coordinates=
 whose
> + * tiles it means to bound. Returns U64_MAX if the coordinate lands on a=
 tile
> + * whose base was never set by the command stream.
> + */
> +static u64 feat_matrix_addr(struct feat_matrix *fm, u32 x, u32 y, u32 c)
>  {

[ ... ]

> @@ -240,11 +242,66 @@ static u64 feat_matrix_length(struct ethosu_validat=
ed_cmdstream_info *info,
>  		break;
>  	}
> =20
> -	info->region_size[fm->region] =3D max(info->region_size[fm->region], ad=
dr + 1);
> -
>  	return addr;
>  }

[Severity: Critical]
This is a pre-existing issue, but does feat_matrix_addr() handle missing
configuration parameters correctly?

cmd_state_init() initializes cmd_state fields to 0xff, setting unprovided
s64 strides to -1. If a command stream omits a stride command, the stride
remains -1.

In feat_matrix_addr(), these -1 values act as subtractive strides:

	addr =3D fm->base[tile] + y * fm->stride_y;
	switch ((fm->precision >> 6) & 0x3) { // format
	case 0: //nhwc:
		addr +=3D x * fm->stride_x + c;

If a user provides a base offset large enough to prevent unsigned wrap-arou=
nd,
the maximum address evaluated in feat_matrix_length() simply remains the
initial base offset at coordinate (0,0,0), completely hiding the bounds of
the access.

If an attacker submits a job setting a large hardware stride, and a second
job omits the stride command, could the verifier use the subtractive -1 str=
ide
to pass bounds checks while the hardware performs out-of-bounds DMA using t=
he
retained large stride from the previous job?

> =20
> +/*
> + * Bound the region a feature matrix touches over the coordinate box
> + * [0, x] x [0, y] x [0, c].

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720192044.1955=
7-1-doruk@0sec.ai?part=3D1
