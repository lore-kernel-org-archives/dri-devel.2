Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7B4C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F78410F133;
	Thu, 20 Aug 2026 17:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e4nhKuW+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F45410F126
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:07:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5E10402C7;
 Thu, 20 Aug 2026 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFF21F000E9;
 Thu, 20 Aug 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787245669;
 bh=T67Q/jj8wwnNHIRPc0kP4vYvU4z7hUsKeju0G72HrSU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e4nhKuW+7yahgh58hEJlZmTCNJXau8inBfAkBpBI71FxdjVD0GIRVDI0CjGS+K7Lq
 tkdMTq1IDkNcaG6RAbXiX45VWkJm/2/2a7L7LEr+hcUeNdxlFs3FnEwVE2KqRAFWSM
 elMEM3mx7UQSM60tkp4f1OuL+ZymFAgIVLTpG9spSWWGGHviAym28im/d/6+qN9zrF
 juvbCt70SgK9ErseUgYXyKtY+ix18j1aZQ8YHmXZ7Me8gw42IVkmS+IUh4RFWo7IkA
 127KatqFKAzP/fJ9c9JvWfSzu2lIhbIAauIAl28QJh1cnHrSqoOcc4EAIZX9mzRYlZ
 EIgV7cLimyfZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] staging: fbtft: prefer snprintf over sprintf in
 fbtft-core.c
To: "Tomasz Unger" <tomasz.unger@yahoo.pl>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
References: <20260820-fbtft-v2-final-v2-1-44d107b04634.ref@yahoo.pl>
 <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:07:48 +0000
Message-Id: <20260820170749.6DFF21F000E9@smtp.kernel.org>
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
- [High] Integer overflow in `vmem_size` calculation leads to a small alloc=
ation, causing subsequent out-of-bounds reads/writes.
--

--- Patch [1]: [PATCH v2] staging: fbtft: prefer snprintf over sprintf in f=
btft-core.c ---
commit c1e6190003fe313b23e0964b72df871f88f45da7
Author: Tomasz Unger <tomasz.unger@yahoo.pl>

staging: fbtft: prefer snprintf over sprintf in fbtft-core.c

This commit replaces sprintf with snprintf for formatting stack buffers=20
text1 and text2 in fbtft-core.c. This prevents potential buffer overflows=20
even though the arguments theoretically fit within the 50-byte limits.

> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/f=
btft-core.c
> index ca0c38221c16b..9ea0442a337e5 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -784,10 +784,10 @@ int fbtft_register_framebuffer(struct fb_info *fb_i=
nfo)
>  	fbtft_sysfs_init(par);
> =20
>  	if (par->txbuf.buf && par->txbuf.len >=3D 1024)
> -		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
> +		snprintf(text1, sizeof(text1), ", %zu KiB buffer memory", par->txbuf.l=
en >> 10);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the memory
safety improvements in this file, I noticed a potential integer overflow in
fbtft_framebuffer_alloc() prior to memory allocation:

drivers/staging/fbtft/fbtft-core.c:fbtft_framebuffer_alloc() {
    ...
    vmem_size =3D display->width * display->height * bpp / 8;
    vmem =3D vzalloc(vmem_size);
    if (!vmem)
        goto release_framebuf;
    ...
}

Could this calculation wrap around 32-bit arithmetic if sufficiently large
dimensions (e.g., width=3D65544, height=3D4096, bpp=3D16) are provided from=
 the
device tree?

If display->width * display->height * bpp overflows, vmem_size could end up
as a small positive integer, leading to a small buffer allocation by vzallo=
c().

Later in fbtft_update_display(), the line length is calculated as
width * bpp / 8, which easily fits in 32 bits without overflowing. Does this
mean operations might attempt to read or write lengths larger than the
allocated vmem buffer, causing an out-of-bounds access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-fbtft-v2-f=
inal-v2-1-44d107b04634@yahoo.pl?part=3D1
