Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D6C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB4C10EB67;
	Tue, 18 Aug 2026 13:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iadpa/4s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A832E10EB67;
 Tue, 18 Aug 2026 13:04:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53213402B9;
 Tue, 18 Aug 2026 13:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1391F000E9;
 Tue, 18 Aug 2026 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787058276;
 bh=Fyr2rTcnJQyyFIFbxd0Nsnv3dEJzBm98+nePcwg0vk0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iadpa/4sPruxnUmQWiaFza8mqTnrrz82L1CH/7dSADIIhsOZMQZBgt8nvOy1FZLNS
 lqdaxpDCCTrP/t2ydy5r3hEg5p5cvzQlmIXOCwywnVknHqOtyF+rhh6YDCNIeJjxFY
 CNAq0UID2JtftEcU5VRdBBoSJU8BqqDz4UsWbnRhi5EqP9tCVovnuuZzPFTR0bpyED
 hBkFufkODMOge6y8vlDzTTZmZq34BTpxBV20dNhv/z2vZZzy021DFXisfn1AtRWUdi
 sP7usoakeCtOyuvjTZnXEEzA448QO7FZHFEoSq5gemiBtvOMfmEtaQpEMVFnFHA583
 B0vW5U3EAFHeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] drm/panic: Return -EINVAL if font is not available
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org, Frank.Li@kernel.org,
 intel-gfx@lists.freedesktop.org, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260818125012.468092-4-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:04:35 +0000
Message-Id: <20260818130435.BC1391F000E9@smtp.kernel.org>
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
- [High] Missing NULL check for the result of `kmap_local_page_try_from_pan=
ic()` in `drm_panic_write_pixel24_xpage()` leads to a NULL pointer derefere=
nce.
--

--- Patch [3]: [PATCH 03/12] drm/panic: Return -EINVAL if font is not avail=
able ---
commit 5ad93562bf6ffaf36ef771a5c8eebc2aa43f5621
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return -EINVAL if font is not available

Font lookup does not allocate memory. Hence reporting ENOMEM on
failed lookups is misleading. Report EINVAL instead.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 705b72bf0d839..96d238bfceee9 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c

[ ... ]

> static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_=
page,
> 					  unsigned int offset, u32 color)
> {
> 	u8 *vaddr2;
> 	u8 *p =3D vaddr + offset;
>=20
> 	vaddr2 =3D kmap_local_page_try_from_panic(next_page);
>=20
> 	*p++ =3D color & 0xff;
> 	color >>=3D 8;
>=20
> 	if (offset =3D=3D PAGE_SIZE - 1)
> 		p =3D vaddr2;
>=20
> 	*p++ =3D color & 0xff;

[Severity: High]
This isn't a bug introduced by this patch, but does=20
drm_panic_write_pixel24_xpage() lack a NULL check for vaddr2?

If the next page is located in HighMem, kmap_local_page_try_from_panic()
returns NULL since it is unsafe to map HighMem during a panic.

When vaddr2 is NULL and the offset crosses the page boundary
(PAGE_SIZE - 1 or PAGE_SIZE - 2), the write pointer p is set to vaddr2.
Would the subsequent write operation then dereference NULL, causing a
recursive panic that aborts the DRM panic handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D3
