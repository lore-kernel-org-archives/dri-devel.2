Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBCECD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 19:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A04112BE0;
	Fri,  5 Jun 2026 19:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IMXBfEBq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD7F112BE0
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 19:50:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0B2640202;
 Fri,  5 Jun 2026 19:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5911F00893;
 Fri,  5 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780689039;
 bh=IqvMH7MHeIVv9BCfi265BzdL/jmGJNTwHNhBxPf9Fuc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IMXBfEBqM/hwY0WJJ0dqG9Of3lq4xhcevw41wZEfm5T+pUaI+v0z+kQLFESeatVTf
 0Baif3GJtBc8AMlYD+lwkgErsOdwGZmt24xpZOVjrN6322Xisyg9Iz/ZF+Bq3IMSsY
 jLcTodJ+VL7dRJnXo3tFWZTPSXTftwhinNg3422BTezX6MzvytVChE4i1GfyVZnOSl
 AjpEwlBLZIXwlDw6GBGLDgw+WvhIFIFf3qFzxFlNp6TlZmeCDER94iQDPbeI9FXW4D
 szzHqYqkpa11nW8YDe2APNzY9T8WsNcXODA+tGyoN+k9XiEOYT8X/V1YAgCj8cP17o
 hk+2xurwLeZJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ethosu: include secondary weight/scale extents in
 region_size[] accounting
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605193311.48008-1-meatuni001@gmail.com>
References: <20260605193311.48008-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:50:39 +0000
Message-Id: <20260605195039.AF5911F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Userspace can bypass GEM bounds validation for secondary weight an=
d scale buffers by explicitly setting their length to U32_MAX or omitting t=
heir base address initialization.
- [High] The feature matrix bounds calculation in `feat_matrix_length()` on=
ly evaluates the base address of the final active tile, ignoring earlier ti=
les and allowing OOB DMA.
- [High] DMA length validation fails to check the lower bound for operation=
s with negative strides, enabling OOB accesses before the GEM object's base=
 IOVA.
--

commit 7486f97fafb727f5b9b006f0446971da1e03b741
Author: Muhammad Bilal <meatuni001@gmail.com>
Subject: accel/ethosu: include secondary weight/scale extents in region_siz=
e[] accounting

This commit updates calc_sizes() to account for the extents of secondary
weight and scale buffers when calculating required GEM buffer sizes.
Previously, these secondary buffers were omitted from the region size
calculations, which could underestimate the required size.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -285,6 +285,8 @@ static int calc_sizes(struct drm_device *ddev,
>  	}
> =20
>  	if (weight) {
> +		int i;
> +
>  		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
>  			op, st->weight[0].region, st->weight[0].base,
>  			st->weight[0].base + st->weight[0].length - 1);
> @@ -294,6 +296,14 @@ static int calc_sizes(struct drm_device *ddev,
>  		info->region_size[st->weight[0].region] =3D
>  			max(info->region_size[st->weight[0].region],
>  			    st->weight[0].base + st->weight[0].length);
> +		for (i =3D 1; i < ARRAY_SIZE(st->weight); i++) {
> +			if (st->weight[i].base =3D=3D U64_MAX ||
> +			    st->weight[i].length =3D=3D U32_MAX)
> +				continue;

[Severity: High]
This isn't a bug introduced by this patch, but does this sentinel check in
calc_sizes() allow userspace to bypass validation for secondary weight
buffers?

If malicious userspace explicitly sends a command with a length of U32_MAX
and an out-of-bounds base address, this continue statement skips updating
the region size. Could the NPU hardware still execute the command using
the out-of-bounds base address, resulting in an out-of-bounds DMA access?
Alternatively, if the base address is omitted and left as U64_MAX, could
the hardware use a stale, out-of-bounds register offset from a previous
operation?

> +			info->region_size[st->weight[0].region] =3D
> +				max(info->region_size[st->weight[0].region],
> +				    st->weight[i].base + st->weight[i].length);
> +		}
>  	}
> =20
>  	if (scale) {
[ ... ]
> @@ -306,6 +316,11 @@ static int calc_sizes(struct drm_device *ddev,
>  		info->region_size[st->scale[0].region] =3D
>  			max(info->region_size[st->scale[0].region],
>  			    st->scale[0].base + st->scale[0].length);
> +		if (st->scale[1].base !=3D U64_MAX &&
> +		    st->scale[1].length !=3D U32_MAX)
> +			info->region_size[st->scale[0].region] =3D

[Severity: High]
This isn't a bug introduced by this patch, but the same sentinel bypass
issue exists here for the secondary scale buffer. Does this permit
arbitrary out-of-bounds DMA?

> +				max(info->region_size[st->scale[0].region],
> +				    st->scale[1].base + st->scale[1].length);
>  	}
> =20
>  	len =3D feat_matrix_length(info, &st->ofm, st->ofm.width,
>  				 st->ofm.height[2], st->ofm.depth);

[Severity: High]
This is a pre-existing issue, but does feat_matrix_length() properly
validate the base addresses of all tiles?

When calculating the feature matrix bounds in feat_matrix_length() in
drivers/accel/ethosu/ethosu_gem.c, the base address is validated like this:

	if (fm->base[tile] =3D=3D U64_MAX)
		return U64_MAX;

	addr =3D fm->base[tile] + y * fm->stride_y;

Could userspace set the base address of the first tile to an arbitrary
out-of-bounds address, and place the maximum spatial coordinates such that
they evaluate to the final tile? If so, the validation would only check the
base address of the final tile and ignore the earlier tiles, while the NPU
processes all tiles and performs an out-of-bounds DMA at the malicious
address.


[Severity: High]
This is another pre-existing issue, but does the bounds check logic in
dma_length() in drivers/accel/ethosu/ethosu_gem.c correctly handle negative
strides?

The function updates the upper bound without checking the lower bound
against 0:

	if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
		return U64_MAX;
	len +=3D dma->stride[0];

Since the NPU supports negative strides that move the access pointer
backwards, a negative stride with a small offset could evaluate to a
negative address and wrap around. Could this allow the NPU to perform DMA
accesses to memory locations before the base address of the GEM object,
bypassing memory protections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605193311.4800=
8-1-meatuni001@gmail.com?part=3D1
