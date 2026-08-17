Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF80CC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C5410E3DC;
	Mon, 17 Aug 2026 06:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M8AvXp/e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F3310E3DC
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACDD5601DE;
 Mon, 17 Aug 2026 06:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361DD1F00A3A;
 Mon, 17 Aug 2026 06:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786949099;
 bh=DBsGFKwV9nm0a75cswuHFOgYmlarN4m9D2CCxRmTbq0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M8AvXp/eaixxI96yUez/eNlHbQ0tqfI2FxXRaPjrkNU/eXE/XBagKtv1p+GTc3vZd
 0/ZDhVGfUZP3vSv0TpJ1SiyBTw1Cobc5N+3ep6jgn+LKmO5Azjzzr/oUXJjRcMed04
 cKQz5pL9IiC91BJfrwf3R4UBvK/WkxXdYtzxc2YTD8UCOiMCIeFuGubRhp/o42NYv8
 LXLJrueR2EZvnJnP51ykw3YWIs9A1/Yvs7kPofiBUHo3cG62hSAJk67p4oF5fUt7Bh
 S8aD8KoyUsEUJSq3HedoqRY9Fs7doRNvUZEXCZ/oPwoNpfauxrFQtmjzL+HtAOo7q+
 b18b4JkKbDBwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: platinumfb: add error checking for ioremap calls
To: yuebingkun <yuebingkun@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817063637.306865-1-yuebingkun@kylinos.cn>
References: <20260817063637.306865-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 06:44:58 +0000
Message-Id: <20260817064459.361DD1F00A3A@smtp.kernel.org>
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
- [High] The return value of `request_mem_region` for `cmap_regs_phys` is i=
gnored, and the error path unconditionally calls `release_mem_region` on it.
--

--- Patch [1]: [PATCH] fbdev: platinumfb: add error checking for ioremap ca=
lls ---
commit 71a977c44688a9c49d5d28cb513b56fa5a810a1d
Author: yuebingkun <yuebingkun@kylinos.cn>

fbdev: platinumfb: add error checking for ioremap calls

This commit adds error checking for ioremap() and ioremap_wt() calls in
platinumfb_probe() to prevent NULL pointer dereferences. It also transitions
the function to use goto-based cleanup for handling initialization failures.

> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/plati=
numfb.c
> index a08d955d9b439..f74c937c839f8 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c

[ ... ]

> @@ -623,13 +638,22 @@ static int platinumfb_probe(struct platform_device*=
 odev)
>  	dev_set_drvdata(&odev->dev, info);
> =20
>  	rc =3D platinum_init_fb(info);
> -	if (rc !=3D 0) {
> -		iounmap(pinfo->frame_buffer);
> -		iounmap(pinfo->platinum_regs);
> -		iounmap(pinfo->cmap_regs);
> -		framebuffer_release(info);
> -	}
> +	if (rc !=3D 0)
> +		goto err_unmap_cmap;
> +
> +	return 0;
> =20
> +err_unmap_cmap:
> +	iounmap(pinfo->cmap_regs);
> +err_release_cmap:
> +	release_mem_region(pinfo->cmap_regs_phys, 0x1000);

[Severity: High]
This is a pre-existing issue, but by adding this new error path, the code
propagates an unsafe assumption.

Earlier in platinumfb_probe(), the return value of request_mem_region()
is ignored:

	request_mem_region(pinfo->cmap_regs_phys, 0x1000, "platinumfb cmap");
	pinfo->cmap_regs =3D ioremap(pinfo->cmap_regs_phys, 0x1000);

If request_mem_region() fails (for instance, if the region is already
claimed), execution continues. If a subsequent step like ioremap() or
platinum_init_fb() then fails, the code will jump to this newly added
err_release_cmap label and unconditionally release the region.

Because __release_region() searches by address and doesn't verify the calle=
r,
could this forcefully free an I/O memory region that actually belongs to
another driver, potentially leading to resource tree corruption or a
use-after-free?

> +err_unmap_regs:
> +	iounmap(pinfo->platinum_regs);
> +err_unmap_fb:
> +	iounmap(pinfo->frame_buffer);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817063637.3068=
65-1-yuebingkun@kylinos.cn?part=3D1
