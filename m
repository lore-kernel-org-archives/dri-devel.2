Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FE9C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4816910EE4C;
	Wed,  5 Aug 2026 13:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eg7TUbUJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D858B10EE4C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 13:07:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8808243536;
 Wed,  5 Aug 2026 13:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497EE1F000E9;
 Wed,  5 Aug 2026 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785935262;
 bh=x3A52jZb7SzPwIsZxQuH5sCiLIN1goj7EFvWoJGthD8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eg7TUbUJDeVy9yQKMXd3eHFjHy3o1CEfWA9xxydA5Za5lJVip6SkP2gC8xcgp2d6s
 OcW0uVzMoxv1VzG0vHijjLrThVRkNsT/Xm3AFVC55VrTKpKCszCSYxc1yAnv20tGRi
 3VHtswLtFmeHQjODspth6lj4SSQWU3BwMZ0oM/8HGlfwwVyU8vldA5ZmfFaXWF6XSn
 L4eX3SuFp51vC8uZdDD/qaovHAjieBaOkkSfaoqiabT4rfrAFjnnDS8zkHSVs3eoVg
 5hBWmYnDIDmddTVkvWvX8ILfr9gZ8bQI9OqGkLd9a3Q/b5ZU0boQEkNYiA2mjGXulf
 2z922pGGiG0DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem-dma: fix double GEM object put on the mmap
 error path
To: "Baul Lee" <baul.lee@xbow.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805124442.57426-1-baul.lee@xbow.com>
References: <20260805124442.57426-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:07:41 +0000
Message-Id: <20260805130742.497EE1F000E9@smtp.kernel.org>
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
- [High] Double-put causing Use-After-Free and memory leak on mmap paths in=
 exynos_drm_gem_mmap()
--

--- Patch [1]: [PATCH] drm/gem-dma: fix double GEM object put on the mmap e=
rror path ---
commit 381f3566395605c2a5479094f795c8569a814b8a
Author: Baul Lee <baul.lee@xbow.com>

drm/gem-dma: fix double GEM object put on the mmap error path

This commit removes drm_gem_vm_close() from the error path of
drm_gem_dma_mmap() to prevent a double-put of the GEM object. The caller
drm_gem_mmap_obj() already drops the reference on error, so the extra
put resulted in an underflow and use-after-free.

> exynos_drm_gem_mmap() and __tegra_gem_mmap() have the same error path.

[Severity: High]
This isn't a bug introduced by this patch, but since the commit message
mentions exynos_drm_gem_mmap() having the same error path, looking at that
function:

drivers/gpu/drm/exynos/exynos_drm_gem.c:exynos_drm_gem_mmap() {
    ...
	ret =3D exynos_drm_gem_mmap_buffer(exynos_gem, vma);
	if (ret)
		goto err_close_vm;

	return ret;

err_close_vm:
	drm_gem_vm_close(vma);

	return ret;
}

Can this cause a double-put leading to a use-after-free?

When returning an error, this explicitly calls drm_gem_vm_close(vma) which
drops a reference. The caller drm_gem_mmap_obj() will see the error and drop
the reference again, causing a double-put.

[Severity: High]
This is also a pre-existing issue, but looking at the import path earlier in
the same function:

drivers/gpu/drm/exynos/exynos_drm_gem.c:exynos_drm_gem_mmap() {
    ...
	if (obj->import_attach)
		return dma_buf_mmap(obj->dma_buf, vma, 0);
    ...
}

Does this code leak the GEM object?

On success, dma_buf_mmap() replaces vma->vm_ops and vma->vm_private_data
with the exporter's state without dropping the surplus reference acquired
by drm_gem_mmap_obj(). This could cause a memory leak when the VMA is
torn down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805124442.5742=
6-1-baul.lee@xbow.com?part=3D1
