Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FD2CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F9D10F0D2;
	Wed,  7 Oct 2026 11:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LW8PpbnB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E6010F0D2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:50:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5F5442EA9;
 Wed,  7 Oct 2026 11:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C94A1F0089C;
 Wed,  7 Oct 2026 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791373821;
 bh=W/KQtoFU5PhbbAjk+ZpRe3aH3NqseXbxtAQAtpxCf7k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LW8PpbnBOOZsrwseAAhADf2oFZtshlKprTB0tFma4vdXKrOfPlbBt/KAbQV0/Y3lf
 rPHiHS7owTBlRzVS/79jHnJdPi8Cncj0Prn73SMEuPndXAFExIQAvERzJXg52hFRJ2
 WVeTOK4d8XG4+vdr2kJOZcPaO4aLfX+WMM5R7mX16xp2CN3STk96jclPbXEatxQInp
 gvDQGZIWC6V5kHAw0JCs3+512LKtCW+yIexV4torgO/13arTH06kkwz0GUyFQxrLWA
 tZtEny23v5i+zvgMTy1OXrlz/3qVCfOWkBVpGkgxu299JP8SExJ/f4CRPC3iqzsKNy
 +qjTLBMq5EzEg==
Message-ID: <sashiko-outbox-162941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] misc: fastrpc: handle multi-cell reg in context
 bank probe
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261007-extended-mapping-v2-2-5dca3aa2c2d3@oss.qualcomm.com>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
 <20261007-extended-mapping-v2-2-5dca3aa2c2d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:50:21 +0000
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
- [High] misc: fastrpc: out-of-bounds read due to index underflow bypassing=
 bounds check
--

commit a9dd81ce5afe0b6b73eb7394627f61e8448d9435
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: handle multi-cell reg in context bank probe

Platforms that use #address-cells =3D <2> on the fastrpc node encode the
context bank number in cell[1] of the reg property rather than cell[0].
Reading cell[0] on such platforms yields 0 for every context bank,
causing all sessions to share SID 0 and corrupting IOVA address
construction.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index b29c1fd00de28..5c7bb56cf46d0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2348,7 +2348,8 @@ static int fastrpc_cb_init(struct platform_device *=
pdev)
>  	if (!cctx)
>  		return -EINVAL;
> =20
> -	if (of_property_read_u32(dev->of_node, "reg", &sid))
> +	if (of_property_read_u32_index(dev->of_node, "reg",
> +				       of_n_addr_cells(dev->of_node) - 1, &sid))

[Severity: High]
Can this code underflow the index if a malformed device tree explicitly sets
#address-cells =3D <0> on the parent node?

If of_n_addr_cells() evaluates to 0, the unchecked subtraction introduces an
underflow. Because the index argument to of_property_read_u32_index() is a
u32, this implicitly casts -1 to 0xFFFFFFFF.

This propagates down to bypass bounds checking in the property reader:

drivers/of/property.c:of_property_read_u32_index() {
    ...
	const u32 *val =3D of_find_property_value_of_size(np, propname,
					((index + 1) * sizeof(*out_value)),
					0,
					NULL);
    ...
}

The index + 1 expression wraps to 0 here, reducing the min size to 0 and
defeating the internal length check inside of_find_property_value_of_size().

This subsequently triggers an out-of-bounds read when extracting the value:

drivers/of/property.c:of_property_read_u32_index() {
    ...
	*out_value =3D be32_to_cpup(((__be32 *)val) + index);
    ...
}

This pointer arithmetic adds 0xFFFFFFFF to the base property address, resul=
ting
in an immediate out-of-bounds memory dereference traversing approximately 1=
7 GB
past the base pointer.

>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> =20
>  	spin_lock_irqsave(&cctx->lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-extended-m=
apping-v2-0-5dca3aa2c2d3@oss.qualcomm.com?part=3D2
