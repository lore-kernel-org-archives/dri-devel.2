Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEE606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+a0ez7V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A6910F572;
	Mon,  9 Nov 2026 22:46:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E0E10F572
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:46:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7321841737;
 Mon,  9 Nov 2026 22:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFAB1F0089F;
 Mon,  9 Nov 2026 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794264385;
 bh=T4ZZ1ikEyYI9WjgqoX/wEQsB934cMtTSYWKZe0WjRyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c+a0ez7VuhU72Ul6h6jsUV6b1BnlqmD7X+8n1S5GeMJKZWzzqqjDkmrx+UUbZvBYs
 d249Aj1zG28qfBCgBb78PREJ0GibOiLEHpuAM88QXxgqxtX8J2rEsjrj/h/6UqnYCS
 WrilX9e1o/PlkLFF/iW5zIoMsr9yUKJ2vukzjXSJZG0FpA2T2e7qV3XThxqO6aVrOL
 5d+gkn8R5NtvnXhMKkP5ZhV0ee73TiVjKnOBKSAN8Mps0IOKYkNs02ZfxQHi8SVPC9
 qXstvvwg3EtZz6rQ7Y0hwAHjzzFHgXVFRZ63LhZBVOSpAHbhfjD+Y2A1od4/2tPGz7
 hMa57jPAAXG+w==
Message-ID: <sashiko-outbox-205768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm: align kernel-managed GPU VAs to 64 KiB
To: "Gaurav Suman" <gauravsuman007@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109-msm-va-align-v1-1-2e9b576d2e4e@gmail.com>
References: <20261109-msm-va-align-v1-1-2e9b576d2e4e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:46:24 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/msm: sub-64K hole scan and VA fragmentation in
  msm_gem_vma_new()
--

commit dbbe11968537b24a2b140215f7ad31d5a022afb3
Author: Gaurav Suman <gauravsuman007@gmail.com>

drm/msm: align kernel-managed GPU VAs to 64 KiB

This commit aligns virtual address allocations in kernel-managed GPU VMs to
64 KiB in msm_gem_vma_new(), falling back to PAGE_SIZE alignment on -ENOSPC.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index f687a629629d3..2af4329128994 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -388,9 +388,20 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_=
gem_object *obj,
>  	if (vm->managed) {
>  		BUG_ON(offset !=3D 0);
>  		BUG_ON(!obj);  /* NULL mappings not valid for kernel managed VM */
> +		/*
> +		 * On a6xx (seen on A640) the CCU can read the 64 KiB-aligned
> +		 * start of the block that holds a bound render target. Align
> +		 * kernel-managed VAs to 64 KiB so that block start lies inside
> +		 * the buffer itself; callers with a tight fixed window, such as
> +		 * the GMU, fall back to page alignment.
> +		 */
>  		ret =3D drm_mm_insert_node_in_range(&vm->mm, &vma->node,
> -						obj->size, PAGE_SIZE, 0,
> +						obj->size, SZ_64K, 0,
>  						range_start, range_end, 0);
> +		if (ret =3D=3D -ENOSPC)
> +			ret =3D drm_mm_insert_node_in_range(&vm->mm, &vma->node,
> +							  obj->size, PAGE_SIZE, 0,
> +							  range_start, range_end, 0);

[Severity: Medium]
Does aligning vma->node to SZ_64K while keeping obj->size page-aligned
degrade small BO allocations in vm->mm to an O(N) hole scan and fragment
small kernel-managed VMs?

When obj->size is not a multiple of 64 KiB (such as a 4 KiB BO), rounding
the next allocation up to a 64 KiB boundary in drm_mm_insert_node_in_range()
leaves an unaligned gap of up to 60 KiB in vm->mm.holes_size that contains
no 64 KiB-aligned address.  Because mode 0 (DRM_MM_INSERT_BEST) starts at
the smallest hole >=3D obj->size and steps through vm->mm.holes_size in
non-decreasing size order, every subsequent SZ_64K-aligned allocation of a
small BO walks past all accumulated sub-64 KiB holes before reaching a
usable hole.

This also applies to all kernel-managed VMs rather than just a6xx: in
a2xx_create_vm(), the GPU VM is only 0xfff * SZ_64K (~256 MiB), so 4095
4 KiB BOs fragment the entire address space into 60 KiB holes and cause any
subsequent allocation of size >=3D 64 KiB to fail with -ENOSPC even with the
PAGE_SIZE fallback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-msm-va-ali=
gn-v1-1-2e9b576d2e4e@gmail.com?part=3D1
