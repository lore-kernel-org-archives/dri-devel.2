Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C74C5DF6E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607D910E39A;
	Mon, 17 Aug 2026 06:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y8n5yT/V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E45C10E39A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:49:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05F5B41859;
 Mon, 17 Aug 2026 06:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264C1F000E9;
 Mon, 17 Aug 2026 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786949396;
 bh=AvmFz3nUKb8pvFYC0g++MD4RLobRZe1hE8JaoMTRsgM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y8n5yT/Vhcmc7RFyh1Hh313lAl07XATiv8f5Jj68ihR5j6mqBQqX2iJGwKFJdSwiI
 VBTiHVhMANhTq46WeB7wC3+YQYQ6VE++GQmX32R/OC5dVYQrdQV9VeaSzLOzrVSEQu
 fLak/Bkv/OjlyuZ/tE+pCYHPmuly1Rod3Y8y3/JOWpPfHBWYFf2rFJzKux8uHHtv4b
 tkzvcMaeYWbNzM5u0zaj6yqTullX7/+Olg4w3LWRvig1CQ+vO06B1tFkgWt0alOeG9
 /prTd24LBUk1pnSWKMDJBzK2QF3wi+aeB8SYryZ8Fa5zTw+1RPFbmSIfeMbc1u1+XK
 1FtDBF2jrftjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbdev: platinumfb: add error checking for ioremap calls
To: yuebingkun <yuebingkun@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817063942.308926-1-yuebingkun@kylinos.cn>
References: <20260817063942.308926-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 06:49:56 +0000
Message-Id: <20260817064956.B264C1F000E9@smtp.kernel.org>
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
- [High] Unchecked request_mem_region combined with unconditional release_m=
em_region causes resource corruption and Use-After-Free.
--

--- Patch [1]: [PATCH v2] fbdev: platinumfb: add error checking for ioremap=
 calls ---
commit a9dd2a2a25aeae119ea17d0f40c6cbdddde67dfd
Author: yuebingkun <yuebingkun@kylinos.cn>

fbdev: platinumfb: add error checking for ioremap calls
   =20
This commit adds error checking for ioremap() and ioremap_wt() calls in
platinumfb_probe(), avoiding NULL pointer dereferences by introducing
goto-based cleanup paths on failure.

> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/plati=
numfb.c
> index a08d955d9b439..f74c937c839f8 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
[ ... ]
> @@ -567,15 +567,30 @@ static int platinumfb_probe(struct platform_device*=
 odev)
[ ... ]
>  	pinfo->cmap_regs_phys =3D 0xf301b000;	/* XXX not in prom? */
>  	request_mem_region(pinfo->cmap_regs_phys, 0x1000, "platinumfb cmap");
>  	pinfo->cmap_regs =3D ioremap(pinfo->cmap_regs_phys, 0x1000);
> +	if (!pinfo->cmap_regs) {
> +		dev_err(&odev->dev, "failed to ioremap cmap registers\n");
> +		rc =3D -ENOMEM;
> +		goto err_release_cmap;
> +	}
[ ... ]
> +err_unmap_cmap:
> +	iounmap(pinfo->cmap_regs);
> +err_release_cmap:
> +	release_mem_region(pinfo->cmap_regs_phys, 0x1000);

[Severity: High]
This is a pre-existing issue, but I noticed the return value of
request_mem_region() is ignored just before the ioremap() call.

If request_mem_region() fails because the physical resource is already
claimed by platform code or another driver, probe continues. If a subsequent
step then fails, such as ioremap() returning NULL or platinum_init_fb()
failing, this newly added error path branches to err_release_cmap.

Since err_release_cmap unconditionally calls release_mem_region(), does this
risk freeing a resource that wasn't actually acquired? If the region size
and start address exactly match an existing claim, this could unlink and
free a resource owned by another driver, potentially causing a
use-after-free later.

Could we add a check for the return value of request_mem_region() so we
only release it if the driver successfully claimed it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817063942.3089=
26-1-yuebingkun@kylinos.cn?part=3D1
