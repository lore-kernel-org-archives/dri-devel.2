Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A08C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A18210F324;
	Thu, 13 Aug 2026 13:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="akEYZUvR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C842810F324
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:13:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B34DA400C5;
 Thu, 13 Aug 2026 13:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06C1F000E9;
 Thu, 13 Aug 2026 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786626825;
 bh=MRHbaB1RWuo55tchBkN4TdckPwEhaN30UeK0CCPC4Nw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=akEYZUvRrcq6Eh0seh43zuj4nnr9fYKOsa/fX+fk3kc/AYYjeM7aN7LbPvbHFpyE1
 xEp1PsIP55oC0Grvv6FpN53ygGOOmdlUkREeq67Ifvd+y3J+18tPCk9Q8/ee7TSCaI
 1BipquXeDuOn+SxgwgrfN+0HCUiNOOAdauxZ9uI/PZV4OiCicDBo6+AM5cZvb7rLWC
 yS2EZGyz6T6oACXy69IUoEbHl18mkmUnpvIW0mZlsonYPh64u7DY1mKvOrmWQhaEui
 R5Cq7CoCjmJAf7UiuOB6ZQC82sq2JysFJ3m/6V8dKT0kXRON3OpsOgvRsa7uJ2Bc3Q
 qK7Dt1qiWfcPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] fbdev: atyfb: Convert to managed PCI and ioremap API
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813125015.1097301-5-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
 <20260813125015.1097301-5-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:13:44 +0000
Message-Id: <20260813131345.6C06C1F000E9@smtp.kernel.org>
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

New issues:
- [High] Using a hardware-derived `bus_type` field to conditionally unmap d=
evm-managed resources leads to double-frees and double-unmaps on PCI device=
s.
- [High] Incorrect error check for `pcim_request_region` causes `atyfb_pci_=
probe` to always fail with `-EBUSY`.

Pre-existing issues:
- [High] `iounmap` is called on a memory pointer that was offset from its b=
ase allocation address for non-PCI (Atari) devices.
--

--- Patch [5]: [PATCH 5/5] fbdev: atyfb: Convert to managed PCI and ioremap=
 API ---
commit 9c27a62b3d8989d1641e7061c71fbeeb223ac2ec
Author: Shixiong Ou <oushixiong@kylinos.cn>

fbdev: atyfb: Convert to managed PCI and ioremap API

This commit converts the atyfb driver's PCI initialization path to use
devres-managed APIs like pcim_request_region() and devm_ioremap(). It also
restricts manual cleanup during driver removal to non-PCI devices only.

> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/a=
ty/atyfb_base.c
> index 9fc5af09f86c4..97cc8b6a93614 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c

[ ... ]

> @@ -3552,7 +3549,7 @@ static int atyfb_pci_probe(struct pci_dev *pdev,
>  	/* Reserve space */
>  	res_start =3D rp->start;
>  	res_size =3D resource_size(rp);
> -	if (!request_mem_region(res_start, res_size, "atyfb"))
> +	if (!pcim_request_region(pdev, rp - pdev->resource, "atyfb"))
>  		return -EBUSY;

[Severity: High]
Since pcim_request_region() returns 0 on success and a negative error code
on failure, will this condition cause the probe to fail unconditionally with
-EBUSY when the region is successfully requested?

[ ... ]

> @@ -3733,10 +3722,13 @@ static void atyfb_remove(struct fb_info *info)
>  	arch_phys_wc_del(par->wc_cookie);
> =20
>  #ifndef __sparc__
> -	if (par->ati_regbase)
> -		iounmap(par->ati_regbase);
> -	if (info->screen_base)
> -		iounmap(info->screen_base);
> +	/* For PCI devices, devm handles unmapping automatically */
> +	if (par->bus_type !=3D PCI) {
> +		if (par->ati_regbase)
> +			iounmap(par->ati_regbase);

[Severity: High]
Does par->bus_type reliably identify PCI devices at this point?

During device initialization in aty_init(), par->bus_type is overwritten wi=
th
a value read from a hardware register:

    par->bus_type =3D (stat0 >> 0) & 0x07;

If a PCI device reports a non-PCI bus type (like ISA) from the hardware
register, could this cause par->bus_type !=3D PCI to evaluate to true,
resulting in a double-unmap of the devm-managed ati_regbase here, as well as
a double-free of the memory region later in this function?

[Severity: High]
This is a pre-existing issue, but for non-PCI devices (like Atari),
par->ati_regbase can be initialized with an offset:

    par->ati_regbase =3D ioremap(phys_guiregbase[m64_num], 0x10000) +
                        0xFC00ul;

Since par->ati_regbase is an offset pointer in those cases, will passing it
directly to iounmap() here cause a kernel panic?

> +		if (info->screen_base)
> +			iounmap(info->screen_base);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813125015.1097=
301-1-oushixiong1025@163.com?part=3D5
