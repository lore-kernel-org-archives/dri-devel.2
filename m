Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27002CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7875310F3BF;
	Fri, 12 Jun 2026 09:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZgxVGOE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31FD10F3BF
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:37:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F60D6001D;
 Fri, 12 Jun 2026 09:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C341F000E9;
 Fri, 12 Jun 2026 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781257021;
 bh=yB5ugW/sVMGDIqspU7Ip/5q9sSMIKMofu4odr1xeiOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bZgxVGOEJofiTnrp+ulyOi9ioehHaYeo2RBhmt7szv3EtYuVHfFHuCDOTniVlQPJJ
 L0GfgvMqOB7IacP5pzX7A2gqY2v5GZl5jwZLgsfQXlDAyrhn+apC1hTf1/7Oq3hDc3
 zbd9GqMMOyt66hwPWNE3clgmE+nXH17FAK93ad9Ury/IyIpQeA0H+/C90zsw5QdU14
 pTxL1IMIA9vz2gXx+t7SLu7npEOS/yN7Dke5mVQa+etBKbuoTshqFdGrMfjjrY8nJ7
 NEIMUJp7Y8UtrqPpOsM1Q6era7vlvjk5qUtAyT7EXxNn/cYtuuMP0DFQBEP0yKql37
 pRfX6vrLAkqQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/18] drm/amdgpu: add SVM range migration helpers
 for drm_pagemap
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-18-ray.huang@amd.com>
References: <20260612090928.29682-18-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:37:01 +0000
Message-Id: <20260612093701.A6C341F000E9@smtp.kernel.org>
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
- [High] Missing fallback eviction on final `drm_pagemap_populate_mm()` fai=
lure leaves the SVM range in an unsupported mixed memory state.
- [Medium] Non-atomic read of bitfield `migrate_devmem` races with concurre=
nt `WRITE_ONCE` updates to the shared `__flags` 16-bit word.
- [Medium] Silently ignoring the return value of `drm_gpusvm_range_evict()`=
 masks critical errors like `-ENOMEM`.
--

commit e6b94e0182e48c1aeaf810ada96dbc179693edad
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/amdgpu: add SVM range migration helpers for drm_pagemap

This commit adds per-range migration helpers for SVM VRAM migration via
drm_pagemap. It implements functions to check migration capabilities, wrap
RAM-to-VRAM migration with eviction retries, and check device memory suppor=
t.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
> new file mode 100644
> index 0000000000000..91dfd0420c001
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
> @@ -0,0 +1,120 @@

[ ... ]

> +static bool
> +range_in_vram(struct drm_gpusvm_range *range)
> +{
> +	struct drm_gpusvm_pages_flags flags =3D {
> +		/* Pairs with WRITE_ONCE in drm_gpusvm_get_pages() */
> +		.__flags =3D READ_ONCE(range->pages.flags.__flags),
> +	};
> +
> +	return flags.has_devmem_pages;
> +}
> +
> +static bool
> +range_needs_migrate_to_vram(struct drm_gpusvm_range *range)
> +{
> +	if (!range->pages.flags.migrate_devmem)

[Severity: Medium]
Since migrate_devmem is part of a bitfield that shares the 16-bit __flags
word with dynamically updated flags like has_devmem_pages, does this direct
access introduce a data race?

Concurrent threads, such as MMU notifiers, update these flags using
WRITE_ONCE(svm_pages->flags.__flags, ...). Under the C11 memory model, read=
ing
a bitfield non-atomically while an atomic write occurs to the same memory
location can cause torn reads. Would it be better to use READ_ONCE() to read
the entire flags word into a local variable before checking the bit, similar
to how range_in_vram() does it above?

> +		return false;
> +	if (range_in_vram(range))
> +		return false;
> +
> +	return true;
> +}

[ ... ]

> +int
> +amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
> +				 struct drm_gpusvm_range *range)
> +{
> +	struct drm_pagemap *dpagemap;
> +	unsigned long start, end;
> +	int ret, retries =3D 1;
> +
> +	if (!range_needs_migrate_to_vram(range))
> +		return 0;
> +
> +	dpagemap =3D amdgpu_svm_get_dpagemap(svm);
> +	if (!dpagemap)
> +		return -ENODEV;
> +
> +	start =3D drm_gpusvm_range_start(range);
> +	end =3D drm_gpusvm_range_end(range);
> +
> +	do {
> +		ret =3D drm_pagemap_populate_mm(dpagemap, start, end,
> +					      svm->gpusvm.mm, 0);
> +
> +		if (ret =3D=3D -EBUSY && retries)
> +			drm_gpusvm_range_evict(&svm->gpusvm, range);

[Severity: Medium]
Should we check the return value of drm_gpusvm_range_evict() here?

If the eviction fails due to -ENOMEM when allocating the PFN array, or -ETI=
ME
from a timeout, the code will loop and retry the migration, which will fail
again with -EBUSY. The caller would then receive -EBUSY instead of the true
underlying error, masking the failure and misdirecting upper-layer error
handling.

> +	} while (ret =3D=3D -EBUSY && retries--);

[Severity: High]
What happens if the final retry of drm_pagemap_populate_mm() fails with
-EBUSY when retries is 0?

Since the loop exits without calling drm_gpusvm_range_evict(), the range is
left partially migrated. AMDGPU SVM sets allow_mixed =3D false, so a subseq=
uent
amdgpu_svm_range_get_pages() on this range will return -EOPNOTSUPP.

If the migration attributes later change to prefer system memory, the GPU
fault handler will skip VRAM migration and directly call
amdgpu_svm_range_get_pages(), which fails with -EOPNOTSUPP. The error handl=
er
then calls amdgpu_svm_range_evict(), but because has_devmem_pages is false
(since it was never successfully mapped to the GPU), it returns early doing
nothing. Could this create a permanent failure loop that breaks GPU access =
to
the range?

> +
> +	if (ret) {
> +		AMDGPU_SVM_TRACE("migrate_to_vram failed: ret=3D%d [0x%lx-0x%lx]\n",
> +				 ret, start, end);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D17
