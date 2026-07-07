Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC2CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA5A10E2FD;
	Tue,  7 Jul 2026 20:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n+p5XpWz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1066C10E2FD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 20:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2051C60008;
 Tue,  7 Jul 2026 20:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE481F000E9;
 Tue,  7 Jul 2026 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783456590;
 bh=POrG6qkfJiarOcMeOQ5RTn5pJZ577jR2zHE5D9A9gV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n+p5XpWzu81704MjV0AB0A4BGbnJhbAzJkK336XvNors/0sYWED/Ltya6JCSytVHW
 eqYH3PtcJkPlCIvwlz9K0HQXdIiU2bpMQu7qYGG8iv4kEWY4wN188kBBJ0DQGwnUq7
 OLqT4EEWx/NGWcrMyUlItdb0/YPto+OWAdpaHqX39DObF4iYoR5sDh7o5qTyboYC/e
 CKaMgIR4DF3j3cud409xfSfZXuFkkIUnSIgQkfpg0Av/BH1CJRDegzuLmzUFTTtpoT
 0FoVfxaYFyKihTgKVGOexxsQpCowCQWiFSeUc7PZb9EUCPtil6Sz2ju0DM2DdBlXqA
 GfbNstfVAbs2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] accel/amdxdna: Fix potential NULL pointer
 dereference of abo->client
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707201556.562191-1-lizhi.hou@amd.com>
References: <20260707201556.562191-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 20:36:30 +0000
Message-Id: <20260707203630.AEE481F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double put of GEM object on the error path of amdxdna_insert_pages=
()
- [High] Missing self-import check in amdxdna_gem_prime_import causes dupli=
cate GEM objects
--

--- Patch [1]: [PATCH V2] accel/amdxdna: Fix potential NULL pointer derefer=
ence of abo->client ---
commit d74333f9f2549a77933710d6e3e66ba616b070a4
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix potential NULL pointer dereference of abo->client

This commit fixes a potential NULL pointer dereference when a BO handle is
closed but the underlying GEM object remains alive. It avoids accessing
abo->client in code paths executing after the handle closure.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index c562d3ae6f3f5..1adb7e57f50ce 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
amdxdna_insert_pages() while reviewing this file:

        ret =3D vm_insert_pages(vma, vma->vm_start, abo->base.pages,
                              &num_pages);
        if (ret) {
                XDNA_ERR(xdna, "Failed insert pages %d", ret);
                vma->vm_ops->close(vma);
                return ret;
        }

Does calling close() here prematurely drop the GEM object reference?

When userspace calls mmap() on an AMDXDNA BO, drm_gem_mmap_obj() acquires a
reference to the GEM object and calls the driver's .mmap callback, which
eventually calls amdxdna_insert_pages().

If vm_insert_pages() fails, the driver explicitly calls
vma->vm_ops->close(vma), which drops the GEM object reference. The error is
then returned back to drm_gem_mmap_obj(), which executes its own error path
and calls drm_gem_object_put() a second time.

Could this double-put cause an underflow of the object's reference count and
lead to a use-after-free of the GEM object?


[Severity: High]
This is also a pre-existing issue, but does amdxdna_gem_prime_import() miss
a self-import check?

struct drm_gem_object *
amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
{
        struct dma_buf_attachment *attach;
        struct amdxdna_gem_obj *abo;
        struct drm_gem_object *gobj;
        struct sg_table *sgt;
        int ret;

        get_dma_buf(dma_buf);

        attach =3D dma_buf_attach(dma_buf, dev->dev);

Since the DRM core defers to the driver's .gem_prime_import callback, and
this function unconditionally creates a new amdxdna_gem_obj without checking
if the DMA-BUF was originally exported by the same device, could this create
duplicate GEM objects for the same memory?

It looks like unprivileged userspace could export a BO via PRIME to a file
descriptor and import it back into the same device, which might break handle
de-duplication and cause state tracking inconsistencies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707201556.5621=
91-1-lizhi.hou@amd.com?part=3D1
