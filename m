Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D7606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ay1ilRfm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE73B1129DA;
	Fri, 30 Oct 2026 21:04:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96FD1129DA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:04:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B990760619;
 Fri, 30 Oct 2026 21:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5911F000C1;
 Fri, 30 Oct 2026 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793394283;
 bh=NPFiM/mPglgOgxQA4WWsEhKO1nnbnFRsPyW70cB5ByU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ay1ilRfmv8fhnaQT6ZLzNNBQY5WOZeVIx0hmJZ1QuhUxbcjZpKS8FKbRLKWNv1iAf
 c+3pIHw5xRLrBfqJnESjvHQpucBe977FIfY/9G+LjB/AGgqhuLxKWMmXYUuxhxWn/F
 7Hxvj4FQMIhju9tx8c8Vbgy6tOrGMYkfBGcCQiCm9DdjhFdXrBGgJthzlI6KG1zLoL
 zE8Oo+RuM+444d6Cs0IJekFjypRgeufwIXlP5IpdbPgRLBHrVlfvs/mQpL+PU95wc+
 mQVxc8m87dvR3VfWyLio6rOVyKR3m/Mqdbj1od3AsaOMvTd2iVuay3CfEogYemrCw3
 R6cgf934WQ4+g==
Message-ID: <sashiko-outbox-191509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/12] drm/shmem: Provide a generic {begin,
 end}_cpu_access() implementation
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-v3d-cached-maps-v1-2-0a6a6b363382@igalia.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
 <20261030-v3d-cached-maps-v1-2-0a6a6b363382@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:04:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/shmem: wrong vmap flush order in drm_gem_shmem_prime_end_cpu=
_access()
--

commit 4543a541900e1a7c8880d3f04fbf76393b153371
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/shmem: Provide a generic {begin, end}_cpu_access() implementation

This commit adds default dma_buf_ops implementations for map_dma_buf,
unmap_dma_buf, begin_cpu_access, and end_cpu_access to drm_gem_shmem_helper
so that CPU caches and vmap ranges are synchronized across the exporter and
all mapped attachments.

[Severity: Medium]
In drivers/gpu/drm/drm_gem_shmem_helper.c, inside
drm_gem_shmem_prime_end_cpu_access() (around line 1093), should
flush_kernel_vmap_range(shmem->vaddr, shmem->base.size) be called before
iterating over dma_buf->attachments and calling
dma_sync_sgtable_for_device(attach->dev, sgt, dir)?

Currently, drm_gem_shmem_prime_end_cpu_access() syncs each attachment's
sg_table for the device first, then calls flush_kernel_vmap_range() on
shmem->vaddr, and finally calls dma_sync_sgtable_for_device() on shmem->sgt.

When a cacheable shmem GEM object (with map_wc set to false) is exported,
mapped by an importing device via drm_gem_shmem_prime_map_dma_buf(), and
also mapped into kernel virtual address space via drm_gem_shmem_vmap_locked=
(),
modifications made through shmem->vaddr may sit in a virtually indexed or
aliasing cache line (such as on 32-bit arm with vivt or vipt-aliasing caches
and an outer l2 cache, or mips with primary d-cache aliasing). Calling
dma_sync_sgtable_for_device() on the importer attachments before
flush_kernel_vmap_range() means the virtual alias in shmem->vaddr has not y=
et
been written back when dma_sync_sgtable_for_device() cleans the physical
mapping, cleans the outer cache, or copies to swiotlb bounce buffers, which
can leave importing devices reading stale data.

As documented in Documentation/core-api/cachetlb.rst and done in other
dma-buf exporters such as system_heap_dma_buf_end_cpu_access() and
cma_heap_dma_buf_end_cpu_access(), flush_kernel_vmap_range() should happen
before all dma_sync_sgtable_for_device() calls.

Similarly, in drm_gem_shmem_prime_begin_cpu_access() (around line 1058),
invalidate_kernel_vmap_range(shmem->vaddr, shmem->base.size) is placed
between syncing shmem->sgt and syncing dma_buf->attachments. Should
invalidate_kernel_vmap_range() be called after all
dma_sync_sgtable_for_cpu() calls have completed so that both exporter and
importer sg_table syncs are ordered consistently with respect to the kernel
vmap range invalidation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-v3d-cached=
-maps-v1-0-0a6a6b363382@igalia.com?part=3D2
