Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4F6CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87EF10E17F;
	Mon, 15 Jun 2026 04:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dIdhwjcp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD30E10E17F
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 04:13:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB6426008A;
 Mon, 15 Jun 2026 04:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887671F000E9;
 Mon, 15 Jun 2026 04:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781496813;
 bh=UHmB2RuLEBe4G8W+n/k8tQuqAcee1pijb0u5Bv9d/M4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dIdhwjcpp4k2PjCr5sSptgCERBMgUztZ/DczBhcXfn/it6F+HcxHAhKmtaUKCDVqg
 2suKDfA8q7Q8fCFO5mLyEqIHN6Wi74Q+FVE0qNYVBCzQgVZRz/AKq2yTWaqXt81pAI
 CLcR5E3lJur6gAUb/sUHhdtaAG8GXroIO1/XrzQ4FfB7RQtuQQ3yQTzvpDckUuTRnH
 ttRjxsaTdGagFD9NV0UL+nCfZfsNYFjweit1ixL8JEKjxxXYGytbETLTiTwDvPZSr1
 oDETTHbs8khORSROFLnffzkVjx9lMgAyOe1pm7gphfZgy6junKJ+n/VUxsSZmB+6h9
 DETTkRTqkRrwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbdev: claim Cyber2000 SPARC I/O aperture before
 ioremap
To: "Chintan Patel" <chintanlike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615040510.9299-1-chintanlike@gmail.com>
References: <20260615040510.9299-1-chintanlike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 04:13:33 +0000
Message-Id: <20260615041333.887671F000E9@smtp.kernel.org>
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
- [Low] Compilation error on SPARC due to referencing a non-existent 'dev' =
member in 'struct cfb_info' and incorrect macro usage.
--

commit e068b9e9c10bca9b6d3e0df275aaabe32f0555c2
Author: Chintan Patel <chintanlike@gmail.com>

fbdev: claim Cyber2000 SPARC I/O aperture before ioremap

This commit claims the memory resource associated with the Cyber2000
SPARC MMIO aperture before accessing it. It adds calls to request memory
regions and attempts to update the error logging.

> diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cybe=
r2000fb.c
> index 2d12f8e96c7ed..0b362842cab34 100644
> --- a/drivers/video/fbdev/cyber2000fb.c
> +++ b/drivers/video/fbdev/cyber2000fb.c
[ ... ]
> @@ -1620,9 +1621,14 @@ static int cyberpro_pci_enable_mmio(struct cfb_inf=
o *cfb)
>  	 */
>  	unsigned char __iomem *iop;
> =20
> +	if (!request_mem_region(0x3000000, 0x5000, "cyber2000fb iop")) {
> +		pci_err(cfb->dev, "cannot reserve I/O area 0x3000000\n");

[Severity: Low]
Does struct cfb_info have a member named dev? It appears this might
cause a build failure on SPARC architectures when compiling
cyberpro_pci_enable_mmio due to referencing a non-existent field.=20

Additionally, does pci_err() expect a struct pci_dev pointer as its
first argument rather than a standard struct device pointer?

> +		return -EBUSY;
> +	}
>  	iop =3D ioremap(0x3000000, 0x5000);
>  	if (iop =3D=3D NULL) {
> -		printk(KERN_ERR "iga5000: cannot map I/O\n");
> +		pci_err(cfb->dev, "cannot map I/O area\n");

[Severity: Low]
This looks like it will encounter the same compilation issue with
cfb->dev as the error path above.

> +		release_mem_region(0x3000000, 0x5000);
>  		return -ENOMEM;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615040510.9299=
-1-chintanlike@gmail.com?part=3D1
