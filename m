Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D8606A335
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m11bvz/V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DA510EA74;
	Sun, 22 Nov 2026 13:15:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E34810E9C8
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:15:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4048434A7;
 Sun, 22 Nov 2026 13:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D70B1F000C0;
 Sun, 22 Nov 2026 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795353345;
 bh=SczrMTmk3vXoHLcnvsQTVFcUaGjO8jk6TkdA+hq3ha4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m11bvz/V0ozuxjYdLDTp5qYtgOVylrTZLcNeHKppDA+3mZ+UkED04osJsPsKqjBq7
 g2T+kKGwWvzamTYZKD5Z9jEvZt5mOYmvvlqakDVuO1uzsNuvsCTt8OXjPw9Ceq22ha
 IX8R4i3NWZnv8iJ0ZKTXKQN8RR+oo0Qxk3XrVszg/fgAL5/ZxpsdPHJVZmOCCW4eyr
 U2mCeB+SKUxqeiGiereNyD9AQL++n5u0v8f6O49ZXXOodj7O9qZqPjTzyb8H0Yu2x8
 XmHHZ/CfWKWLPt+xFN3Ba3d30EuO8OEycCNAaAGgU28867rxim6m2oJ8zwpcvyrqoH
 xDXKmvkGrhuBw==
Message-ID: <sashiko-outbox-227954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] drm/tyr: add BO-related ioctls
To: "Alvin Sun" <alvin.sun@linux.dev>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261122-tyr-ioctls-v7-10-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-10-3a2af624b992@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 13:15:44 +0000
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
- [High] drm/tyr: slab out-of-bounds access in bo_mmap_offset() on
  PRIME/dumb handles
- [Medium] drm/tyr: DRM_PANTHOR_BO_NO_MMAP objects remain CPU-mappable
  via mmap()
--

commit 7d9cd1ac18a4c56e418f19b4899916694572fe8a
Author: Alvin Sun <alvin.sun@linux.dev>

drm/tyr: add BO-related ioctls

This commit implements the PANTHOR_BO_CREATE and PANTHOR_BO_MMAP_OFFSET
ioctls for the Tyr DRM driver.

> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 8fccb42ab9e56..db57df68449cd 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -242,6 +242,100 @@ pub(crate) fn vm_get_state(
>              Ok(0)
>          })
>      }
> +
> +    pub(crate) fn bo_create(
> +        ddev: &TyrDrmDevice<Registered>,
> +        reg_data: &TyrDrmRegistrationData<'_>,
> +        bocreate: &mut uapi::drm_panthor_bo_create,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {

[ ... ]

> +        let bo =3D crate::gem::lookup_handle(file, bommap.handle).inspec=
t_err(|_| {
> +            dev_dbg!(ddev.as_ref(), "Invalid BO mmap handle: {}\n", bomm=
ap.handle);
> +        })?;
> +        if bo.flags() & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMA=
P !=3D 0 {

[Severity: High]
Can bo.flags() read past the end of the slab allocation when bommap.handle
comes from DRM_IOCTL_PRIME_FD_TO_HANDLE or DRM_IOCTL_MODE_CREATE_DUMB?

gem::shmem::Object::ALLOC_OPS wires up drm_gem_shmem_prime_import_sg_table
and drm_gem_shmem_dumb_create while leaving gem_create_object as None:

rust/kernel/drm/gem/shmem.rs:<Object<T> as driver::AllocImpl>::ALLOC_OPS {
        gem_create_object: None,
        ...
        gem_prime_import_sg_table: Some(bindings::drm_gem_shmem_prime_impor=
t_sg_table),
        dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
}

When gem_create_object is NULL, __drm_gem_shmem_create() allocates only
sizeof(struct drm_gem_shmem_object) rather than gem::shmem::Object<BoData>.
lookup_handle() then casts that bare drm_gem_shmem_object to
&gem::shmem::Object<BoData>, so bo.flags() reads BoData::flags out of
bounds.

> +            dev_dbg!(ddev.as_ref(), "BO mmap offset on NO_MMAP object\n"=
);
> +            return Err(EPERM);
> +        }
> +        bommap.offset =3D bo.create_mmap_offset().inspect_err(|_| {

[Severity: Medium]
Are DRM_PANTHOR_BO_NO_MMAP buffer objects still CPU-mappable even though
bo_mmap_offset() returns EPERM?

In bo_create(), new_object() calls __drm_gem_shmem_init(), which
unconditionally calls drm_gem_create_mmap_offset(), and bo.create_handle()
calls drm_vma_node_allow() to authorize the file to map that offset.
Because gem::shmem::Object::VTABLE sets mmap to drm_gem_shmem_object_mmap
without checking BoData::flags, userspace can still mmap() a NO_MMAP object
on the DRM fd (or via DRM_IOCTL_PRIME_HANDLE_TO_FD and mmap() on the
dma-buf fd).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-tyr-ioctls=
-v7-0-3a2af624b992@linux.dev?part=3D10
