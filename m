Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40075C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 03:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB1F10E41E;
	Sat, 18 Jul 2026 03:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X6xznPjz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9C410E41E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:22:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D31E40BE9;
 Sat, 18 Jul 2026 03:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266CE1F000E9;
 Sat, 18 Jul 2026 03:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784344949;
 bh=dwiwGKyPqy9MzIZpuFMrcKfYrPscbIfkR2JtX98D87Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X6xznPjzFpjynbmNf7KXbUFfO47OkceLSJ7KPnHlQSqCjHhQF7o0UqKLLQHuHHwoQ
 VDa0A+vBTxRJYNOz6CkXjn3W5DvS3hnBBrRoKsJrdB3LVXPqmf98MenJDwkvEIzUMp
 zAn8dQB0ULzNGgc2d7fb2xJi/uRqzqJBVjgySfzwiX9ml8MvXuPbsP+0x7VhVjBjWa
 K8DERMDkvgUKyXMdfuiJapKitPbpm25ymFhZSz2gBtkuFGBWVR6MTxhcw7rUwjpeh1
 BMVaz1tdpV0Axg1Slftb0bLxYfAPNBw4+wveMAugemYizAf5E5ymyMZ5aTILH4MqdQ
 QLa/ALWCxzL0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/8] iommu/rockchip: take all DT clocks
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260718031146.3368811-5-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 03:22:28 +0000
Message-Id: <20260718032229.266CE1F000E9@smtp.kernel.org>
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
- [High] Resource mapping loop incorrectly indexes `iommu->bases` array, le=
ading to gaps and invalid pointer dereferences
--

--- Patch [4]: [RFC PATCH v2 4/8] iommu/rockchip: take all DT clocks ---
commit 77bcbb4eca287b3632f08a8528235d32ff400f72
Author: Jiaxing Hu <gahing@gahingwoo.com>

iommu/rockchip: take all DT clocks
   =20
rk_iommu only enabled a fixed {aclk,iface} pair.  On the RK3576 NPU the
MMU sits behind the CBUF/DSU gates, so writes to DTE_ADDR are silently
dropped until those clocks run too (reads work, writes need more clocks).
Use devm_clk_bulk_get_all() to take every clock the devicetree provides
instead of a fixed pair, so a platform can list the full set it needs.
Clocks stay optional for the older clock-less devicetrees.

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 87ae036d64145..2ac65c0c5c0b4 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c

[ ... ]

> @@ -1254,25 +1249,20 @@ static int rk_iommu_probe(struct platform_device =
*pdev)

[Severity: High]
This is a pre-existing issue, but does the resource mapping loop in
rk_iommu_probe() incorrectly index the iommu->bases array?

If multiple memory resources are provided but one fails to map (for example,
if num_res =3D 2 and mapping for index 0 fails), iommu->bases[0] holds an
ERR_PTR while iommu->bases[1] holds the valid base. However, iommu->num_mmu
becomes 1.

Since subsequent driver loops iterate from 0 to num_mmu - 1 and
unconditionally dereference iommu->bases, this would lead to a crash on
iommu->bases[0].

Also, if num_res =3D=3D 0, devm_kcalloc() returns ZERO_SIZE_PTR and reading
iommu->bases[0] on the error path would panic:

	for (i =3D 0; i < num_res; i++) {
		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
		if (!res)
			continue;
		iommu->bases[i] =3D devm_ioremap_resource(&pdev->dev, res);
		if (IS_ERR(iommu->bases[i]))
			continue;
		iommu->num_mmu++;
	}
	if (iommu->num_mmu =3D=3D 0)
		return PTR_ERR(iommu->bases[0]);

Could we assign to iommu->bases[iommu->num_mmu] instead of iommu->bases[i]
to prevent gaps in the array, and handle the num_res =3D=3D 0 error path
differently?

> 	iommu->reset_disabled =3D device_property_read_bool(dev,
> 					"rockchip,disable-mmu-reset");
> =20
> -	iommu->num_clocks =3D ARRAY_SIZE(rk_iommu_clocks);
> -	iommu->clocks =3D devm_kcalloc(iommu->dev, iommu->num_clocks,
> -				     sizeof(*iommu->clocks), GFP_KERNEL);
> -	if (!iommu->clocks)
> -		return -ENOMEM;
> -
> -	for (i =3D 0; i < iommu->num_clocks; ++i)
> -		iommu->clocks[i].id =3D rk_iommu_clocks[i];
> -
> 	/*
> -	 * iommu clocks should be present for all new devices and devicetrees
> -	 * but there are older devicetrees without clocks out in the wild.
> -	 * So clocks as optional for the time being.
> +	 * Take every clock the devicetree provides.  Most IOMMU instances
> +	 * need exactly "aclk" + "iface", but e.g. the RK3576 NPU IOMMUs sit
> +	 * behind additional gates (CBUF/DSU) whose clocks must be running
> +	 * for register writes to land.  Clocks stay optional because there
> +	 * are older devicetrees without clocks out in the wild.
> 	 */
> -	err =3D devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
> +	err =3D devm_clk_bulk_get_all(iommu->dev, &iommu->clocks);
> 	if (err =3D=3D -ENOENT)
> 		iommu->num_clocks =3D 0;
> -	else if (err)
> +	else if (err < 0)
> 		return err;
> +	else
> +		iommu->num_clocks =3D err;
> =20
> 	err =3D clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
> 	if (err)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718031146.3368=
811-1-gahing@gahingwoo.com?part=3D4
