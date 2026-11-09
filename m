Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C58606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioNdLPKL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724C810E561;
	Mon,  9 Nov 2026 01:05:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4D010E561
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 01:05:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D64A61188;
 Mon,  9 Nov 2026 01:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3391F0089F;
 Mon,  9 Nov 2026 01:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794186337;
 bh=kF+LoXziY8ZJ5yiTcBKC+DTZesxn6WN9aw1+SWEYAhE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ioNdLPKLDEcO6kb87pawCStwLQ06pM+C2lrsW+oKYigjHIIvGk8Rllj7S1pdZgGbz
 pskWujImqi1lcoToR1YCQgnxdd8pSYYgWlUv+cwbHwVD6s5+5AX6DWK8BtV/pPboV6
 Wrp+gFkmD++qn4kYjD7CnMcbRNWkqqZe7UfV8n9zqFyw7OxPhl2RgJ0KSR14AKyp1E
 CO/K9EUgZeGS9ebxEzq4Bt726toY6dYCtVO3gUjpJrAaXMwEu8SD5wDfoVAiQs/AUB
 A+xkz8uqOmW0Ne/43en1GuxTVMpTWOILKkcgPxu4tfcLVPvbrd4wPzaOLnSXs1py3G
 1LlsDl8D6CAeg==
Message-ID: <sashiko-outbox-204278@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] drm/tyr: add BO-related ioctls
To: "Ke Sun" <sunke@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261109-tyr-ioctls-v6-10-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
 <20261109-tyr-ioctls-v6-10-b2896bf2b3c9@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:05:36 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/tyr: slab-out-of-bounds access in bo_mmap_offset() on
  imported or dumb BOs
- [Medium] drm/tyr: NO_MMAP buffer objects remain mappable via mmap()
  and PRIME
--

commit 31c4893f869db54a6627810d48273b6077efa3af
Author: Alvin Sun <alvin.sun@linux.dev>

drm/tyr: add BO-related ioctls

This commit implements the PANTHOR_BO_CREATE and PANTHOR_BO_MMAP_OFFSET
ioctls for allocating GEM buffer objects and retrieving their mmap offsets.

> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index b982e8db2c4c1..f99bb2992d87a 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs

[ ... ]

> +    pub(crate) fn bo_mmap_offset(
> +        ddev: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +        bommap: &mut uapi::drm_panthor_bo_mmap_offset,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {
> +        if bommap.pad !=3D 0 {
> +            dev_dbg!(
> +                ddev.as_ref(),
> +                "BO mmap offset pad not zero: {}\n",
> +                bommap.pad
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let bo =3D crate::gem::lookup_handle(file, bommap.handle).inspec=
t_err(|_| {
> +            dev_dbg!(ddev.as_ref(), "Invalid BO mmap handle: {}\n", bomm=
ap.handle);
> +        })?;

[Severity: High]
Can passing a PRIME-imported or dumb-buffer handle to bo_mmap_offset() read
past the end of the GEM object allocation when bo.flags() is called below?

rust/kernel/drm/gem/shmem.rs:Object::ALLOC_OPS {
    ...
        gem_create_object: None,
    ...
        gem_prime_import_sg_table: Some(bindings::drm_gem_shmem_prime_impor=
t_sg_table),
        dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
    ...
}

Because gem_create_object is None while gem_prime_import_sg_table and
dumb_create are wired up, DRM_IOCTL_PRIME_FD_TO_HANDLE (or
DRM_IOCTL_MODE_CREATE_DUMB) calls __drm_gem_shmem_create() and allocates a
bare struct drm_gem_shmem_object rather than a gem::shmem::Object<BoData>.
lookup_handle() casts that pointer to gem::shmem::Object<BoData>, so calling
bo.flags() reads self.inner.flags out of bounds in the slab allocation.

> +        if bo.flags() & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMA=
P !=3D 0 {
> +            dev_dbg!(ddev.as_ref(), "BO mmap offset on NO_MMAP object\n"=
);
> +            return Err(EPERM);
> +        }

[Severity: Medium]
Can userspace still CPU-map a DRM_PANTHOR_BO_NO_MMAP buffer object despite
this check?

In bo_create(), new_object() calls __drm_gem_shmem_init(), which allocates
the object's VMA offset via drm_gem_create_mmap_offset(), and
bo.create_handle() authorizes that offset for the file via
drm_vma_node_allow().  Because gem::shmem::Object<BoData>::VTABLE sets mmap
directly to drm_gem_shmem_object_mmap() without inspecting BoData::flags,
userspace can export a DRM_PANTHOR_BO_NO_MMAP handle with
DRM_IOCTL_PRIME_HANDLE_TO_FD and mmap() the returned dma-buf fd (or mmap()
the DRM fd directly using the pre-allocated VMA offset).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-tyr-ioctls=
-v6-0-b2896bf2b3c9@kylinos.cn?part=3D10
