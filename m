Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C9CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0FF10F0EE;
	Mon, 12 Oct 2026 13:15:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A25110F0EE
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:15:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D242460229;
 Mon, 12 Oct 2026 13:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FF01F0089C;
 Mon, 12 Oct 2026 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810923;
 bh=iWvbiVXEDdFAB6V3bl5YXHMahiNtOYj35nPnYL8Yqd8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JgvSU7DG2VatOXTTPHGmz9rPd65v5r4HHj8LsLKfC5zQVLnzr4lSjGdqlEa+Va6tu
 qzy1Ekti8FpVDXB/DFowIDB61VEgnBaMDOWGkog85iRnoJKCqDUXbBxhvK7/kCnq6A
 U/SgoGlJ9Gg1Md7nKcCnta+GX2n9Y47MYZDtiId/hRpK02yl3eqkNUdbOz/ym7veUT
 5tAInFuXOF5X/tiblmWYQA/03Hbsin4n5hL1SwXzbD5dhCugZe8Zg7zC8p3Cl/y2ai
 WVOIARRayB+ltbLs6OPxyQxU+sQs9YCuW4JMxX1pagDkoO5SkpWkeEV1N7Sjhgau8i
 hPaz/Cso5aL0Q==
Message-ID: <sashiko-outbox-168153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/12] drm/panthor: Support FW init of protm
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012125940.3291951-11-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-11-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:15:22 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] drm: kernel crash on FW reload due to mapping protected PROT s=
ection
- [High] drm: data race on protm_section->mem causes ERR_PTR dereference
- [Medium] drm: mixing goto-based cleanup and guard() in panthor_fw_protm_i=
nit
- [Medium] drm/panthor: missing VA reservation for PROT section allows auto=
-VA clash
- [Low] drm: data race in panthor_ioctl_dev_query copying PROTM_INFO
--

commit 6a74417abb2feb49f589b33202b41b8e8a067ce4
Author: Boris Brezillon <boris.brezillon@collabora.com>
Subject: drm/panthor: Support FW init of protm

This commit adds support for initializing the Mali GPU firmware's protected
mode (protm) memory section. It introduces user queries for protm state and=
 a
new ioctl for user-initiated protected mode initialization.

> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index 51a2e5358cd51..cc1c050ea3806 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
[ ... ]
> @@ -991,6 +997,9 @@ static int panthor_ioctl_dev_query(struct drm_device =
*ddev, void *data, struct d
>  	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
> =20
> +	case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->protm.info);

[Severity: Low]
Is it safe to directly pass ptdev->protm.info to PANTHOR_UOBJ_SET() here?

Since panthor_fw_protm_init() updates the state field concurrently using
smp_store_release(), this byte/word copy in copy_to_user() might race
and copy torn state to userspace.

Should this create a local copy using smp_load_acquire() before passing it
to copy_to_user(), similar to how timestamp_info is handled?

> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index fc07796fc9ef7..0af6addfd55a5 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
[ ... ]
> @@ -462,6 +470,9 @@ static void panthor_fw_init_section_mem(struct pantho=
r_device *ptdev,
>  	    !(section->flags & CSF_FW_BINARY_IFACE_ENTRY_ZERO))
>  		return;
> =20
> +	if (!section->mem)
> +		return;

[Severity: High]
Does this check properly handle the error pointer state?

If panthor_fw_protm_init() is currently executing concurrently,
section->mem might briefly contain an ERR_PTR if
panthor_kernel_bo_create_from_gem() fails.

Since the reset worker reads section->mem without holding the
protm_init_lock, could it observe the intermediate ERR_PTR, bypass this
check, and crash when panthor_kernel_bo_vmap() dereferences it?

> +
>  	ret =3D panthor_kernel_bo_vmap(section->mem);
>  	if (drm_WARN_ON(&ptdev->base, ret))
>  		return;
> =20
>  	memcpy(section->mem->kmap, section->data.buf, section->data.size);

[Severity: Critical]
Will this cause a secure fault (SError) or kernel panic during a GPU reset?

If PROTM_INIT was successfully called by userspace, section->mem now
holds protected memory. During a slow reset, panthor_reload_fw_sections()
iterates over all firmware sections and unconditionally calls
panthor_fw_init_section_mem().

If it processes the PROT section, it will attempt to vmap and
memset/memcpy the protected memory from the CPU non-secure world. Should
this function or the reload loop explicitly skip the
CSF_FW_BINARY_IFACE_ENTRY_PROT section to avoid a secure fault?

[ ... ]
> @@ -678,7 +683,22 @@ static int panthor_fw_load_section_entry(struct pant=
hor_device *ptdev,
>  	section->size =3D section_size;
>  	section->va =3D hdr.va.start;
> =20
> -	if (section_size) {
> +	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
> +		if (ptdev->fw->protm_section) {
> +			drm_err(&ptdev->base,
> +				"Only one protected section supported\n");
> +			return -EINVAL;
> +		}
> +
> +		ptdev->protm.info.fw_protected_sections_size =3D
> +			ALIGN(section->size, vm_pgsz);
> +		ptdev->fw->protm_section =3D section;
> +	}
> +
> +	/* Defer the section->mem creation if this is a protected entry.
> +	 * This will be populated when DRM_IOCTL_PANTHOR_PROTM_INIT is called.
> +	 */
> +	if (section->size && !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)) {

[Severity: Medium]
Does skipping the memory allocation here also unintentionally skip reserving
the virtual address in the firmware VM?

If the firmware binary places the protected mode (PROT) section within the
kernel_auto_va range, and we skip panthor_kernel_bo_create() (which
allocates the VA), could an unprivileged user allocating queues or suspend
buffers steal this unreserved VA?

This would later cause panthor_fw_protm_init() to fail with -ENOSPC when
it attempts to reserve the exact VA. Should the VA still be reserved early,
even if memory allocation is deferred?

>  		u32 vm_map_flags =3D section_vm_map_flags(section);
> =20
>  		section->mem =3D panthor_kernel_bo_create(
[ ... ]
> @@ -1585,6 +1610,70 @@ int panthor_fw_protm_exit(struct panthor_device *p=
tdev, u32 timeout_ms)
>  	return panthor_fw_protm_exit_wait(ptdev, timeout_ms);
>  }
> =20
> +int panthor_fw_protm_init(struct drm_file *file,
> +			  struct drm_panthor_protm_init *args)
> +{
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct panthor_device *ptdev =3D pfile->ptdev;
> +	struct panthor_fw_section *protm_section =3D ptdev->fw->protm_section;
> +	struct drm_gem_object *obj;
> +	u32 vm_map_flags;
> +	int cookie, ret =3D 0;
> +
> +	if (!capable(CAP_SYS_MODULE))
> +		return -EPERM;
> +
> +	if (args->pad)
> +		return -EINVAL;
> +
> +	if (!protm_section || !protm_section->size)
> +		return -EINVAL;
> +
> +	guard(mutex)(&ptdev->fw->protm_init_lock);

[Severity: Medium]
This isn't a bug, but this function mixes scope-based cleanup
(guard(mutex)) with traditional goto cleanup labels (like
goto out_gem_put).

According to the cleanup helpers documentation, goto and scope-based
cleanup should not be mixed in the same function. Could all resources in
this function be converted to use scope-based cleanup to avoid ownership
confusion?

> +
> +	/* Thread safe access so other readers do not need protm_init_lock */
> +	if (smp_load_acquire(&ptdev->protm.info.state) &
> +	    DRM_PANTHOR_PROTM_INITIALIZED)
> +		return 0;
> +
> +	if (!drm_dev_enter(&ptdev->base, &cookie))
> +		return -ENODEV;
> +
> +	obj =3D drm_gem_object_lookup(file,
> +				    args->fw_protected_sections_bo_handle);
> +	if (!obj) {
> +		ret =3D -ENOENT;
> +		goto out_dev_exit;
> +	}
> +
> +	if (obj->size < ptdev->protm.info.fw_protected_sections_size) {
> +		ret =3D -EINVAL;
> +		goto out_gem_put;
> +	}
> +
> +	vm_map_flags =3D section_vm_map_flags(protm_section);
> +
> +	protm_section->mem =3D panthor_kernel_bo_create_from_gem(
> +		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
> +		protm_section->va, protm_section->size);
> +	if (IS_ERR(protm_section->mem)) {
> +		ret =3D PTR_ERR(protm_section->mem);
> +		protm_section->mem =3D NULL;

[Severity: High]
Is it safe to assign directly to the globally visible protm_section->mem
before checking for errors?

If this allocation fails, protm_section->mem briefly holds an ERR_PTR
until the error check clears it. A concurrent GPU reset worker, which reads
section->mem without holding protm_init_lock, could observe this
intermediate state and crash when trying to vmap it.

Should the result be stored in a local variable and only assigned to
protm_section->mem upon success?

> +		goto out_gem_put;
> +	}
> +
> +	/* Make sure all above is completed before we update state */
> +	smp_store_release(&ptdev->protm.info.state,
> +			  DRM_PANTHOR_PROTM_INITIALIZED);
> +
> +out_gem_put:
> +	drm_gem_object_put(obj);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012125940.3291=
951-1-ketil.johnsen@arm.com?part=3D10
