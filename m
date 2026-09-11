Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD71C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB0710E38D;
	Fri, 11 Sep 2026 11:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N4DelB2I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565B110E38D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:55:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3C73417F1;
 Fri, 11 Sep 2026 11:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B177F1F000FF;
 Fri, 11 Sep 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789127702;
 bh=kqiSsmPpHOJ5vOAwllamxLoVs4TIwCJtD7UzKY7r7Ug=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N4DelB2IyhfoF7+FMBs91M1v8TlZuMb3r/vuoyXv7aQY3wOSrelncA12OnbCNSXEC
 jIZCGs7h/UtEoTQyk2c/Dbcy4J/VFYzEMq/HKQFnpZ2FmOZfyBs4qoL5Nsg/DEmTxD
 0dt2irGlH2mmbBCkIP6uoGbSOpWqd+Q6kDzqI0sjbVYjsU8Frdr9Aow43LOepQeicx
 Jak4HvdH+eiTpXCy+GFe5cKgXPIaZc0XeB53x7jtewPXC0xzcCiTr5TztR73B9um+l
 1W6R0GZWhN2Kw9mcGTwGeXJc9AG9rdEr5D7W+DyRFcZ3C23zwXbFDgmoF8vO6wLunr
 0gkf/DbObnHYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/panthor: Expose protected rendering features
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911114014.79139-7-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
 <20260911114014.79139-7-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:55:02 +0000
Message-Id: <20260911115502.B177F1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] An unprivileged userspace process can trigger a full GPU reset by =
omitting the protected suspend buffer during group creation and then submit=
ting commands that switch to protected mode.
- [High] Slow reset path triggers a NULL pointer dereference on the uniniti=
alized protected firmware section in `panthor_fw_init_section_mem`.
- [Low] Data race on the `ptdev->protm.info.state` flag.
- [Low] Mixing `guard()` and `goto`-based cleanup in `panthor_fw_protm_init=
` violates subsystem cleanup guidelines.
--

commit b7ec40f4bb5c3ae17349c8d0c7a683e90abc16c4
Author: Boris Brezillon <boris.brezillon@collabora.com>
Subject: drm/panthor: Expose protected rendering features

This commit introduces extensions to the Panthor uAPI to support protected
rendering. It adds a new IOCTL for providing protected firmware memory and
extends group creation to allow userspace to provide a protected suspend
buffer.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 96770ce34da84..4b44baf82a037 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c

[ ... ]

> @@ -644,35 +677,36 @@ static int panthor_fw_load_section_entry(struct pan=
thor_device *ptdev,
>  		section->name =3D name;
>  	}
> =20
> -	if (section_size) {
> -		u32 cache_mode =3D hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MA=
SK;
> -		u32 vm_map_flags =3D 0;
> -		u64 va =3D hdr.va.start;
> +	section->size =3D section_size;
> +	section->va =3D hdr.va.start;
> =20
> -		if (!(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
> -			vm_map_flags |=3D DRM_PANTHOR_VM_BIND_OP_MAP_READONLY;
> +	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
> +		if (ptdev->fw->protm_section) {
> +			drm_err(&ptdev->base,
> +				"Only one protected section supported\n");
> +			return -EINVAL;
> +		}
> =20
> -		if (!(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_EX))
> -			vm_map_flags |=3D DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC;
> +		ptdev->protm.info.fw_protected_sections_size =3D
> +			ALIGN(section->size, vm_pgsz);
> +		ptdev->fw->protm_section =3D section;
> +	}
> =20
> -		/* TODO: CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_*_COHERENT are mapped to
> -		 * non-cacheable for now. We might want to introduce a new
> -		 * IOMMU_xxx flag (or abuse IOMMU_MMIO, which maps to device
> -		 * memory and is currently not used by our driver) for
> -		 * AS_MEMATTR_AARCH64_SHARED memory, so we can take benefit
> -		 * of IO-coherent systems.
> -		 */
> -		if (cache_mode !=3D CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_CACHED)
> -			vm_map_flags |=3D DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED;
> +	/* Defer the section->mem creation if this is a protected entry.
> +	 * This will be populated when DRM_IOCTL_PANTHOR_PROTM_INIT is called.
> +	 */
> +	if (section->size && !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)) {
> +		u32 vm_map_flags =3D section_vm_map_flags(section);

[Severity: High]
Can this cause a kernel panic if a GPU hang occurs before the protected mode
is initialized?

Because section->mem is intentionally left as NULL here for protected
sections, if an unprivileged user triggers a GPU hang before calling the
PROTM_INIT ioctl, the slow reset path will be invoked. When
panthor_reload_fw_sections() iterates over all sections, it calls
panthor_fw_init_section_mem() which dereferences section->mem without check=
ing
if it is valid (e.g., bool was_mapped =3D !!section->mem->kmap).=20

Would it make sense to skip uninitialized protected sections during reset?

[ ... ]

> @@ -1566,6 +1605,66 @@ int panthor_fw_protm_exit(struct panthor_device *p=
tdev, u32 timeout_ms)
>  	return ret;
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

[Severity: Low]
Is it safe to mix guard() and goto-based cleanup in the same function?

The cleanup subsystem guidelines suggest avoiding the mixture of scope-based
locks like guard(mutex) with goto labels (such as out_gem_put and
out_dev_exit) in the same routine, as it can lead to confusing ownership
semantics and future maintenance bugs.

> +
> +	if (ptdev->protm.info.state & DRM_PANTHOR_PROTM_INITIALIZED)
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
> +	protm_section->mem =3D panthor_kernel_bo_import(
> +		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
> +		protm_section->va, protm_section->size);
> +	if (IS_ERR(protm_section->mem)) {
> +		ret =3D PTR_ERR(protm_section->mem);
> +		protm_section->mem =3D NULL;
> +		goto out_gem_put;
> +	}
> +
> +	ptdev->protm.info.state |=3D DRM_PANTHOR_PROTM_INITIALIZED;

[Severity: Low]
Could this non-atomic modification cause torn reads or compiler reordering
issues?

This updates ptdev->protm.info.state using a bitwise OR, but the same state
flag is read concurrently in cs_slot_process_protm_pending_event_locked()
without locks or READ_ONCE().

> +
> +out_gem_put:
> +	drm_gem_object_put(obj);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 1fe77e5c41995..d73fc2f6633a6 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -1429,10 +1429,15 @@ cs_slot_process_protm_pending_event_locked(struct=
 panthor_device *ptdev,
>  	if (!group)
>  		return;
> =20
> -	/* Do not allow user space work to switch into protected mode, as we
> -	 * do not fully support this quite yet.
> +	/* Do not allow user space work to switch into protected mode if we
> +	 * do not support protected mode on this device.
> +	 * User space should query (and init) this support before attempting
> +	 * to use such GPU instructions.
>  	 */
> -	atomic_or(BIT(cs_id), &group->fatal_queues);
> +	if (!(ptdev->protm.info.state & DRM_PANTHOR_PROTM_INITIALIZED))
> +		atomic_or(BIT(cs_id), &group->fatal_queues);
> +	else
> +		atomic_or(BIT(cs_id), &group->protm_pending_queues);
> =20
>  	sched_queue_delayed_work(sched, tick, 0);
>  }

[Severity: High]
Does this allow an unprivileged userspace process to trigger a full
system-wide GPU reset?

The logic here approves a transition to protected mode by only checking the
global DRM_PANTHOR_PROTM_INITIALIZED flag. However, if a user creates a
group with protected_suspend_bo_handle set to 0 (resulting in
group->protm_suspend_buf being NULL), they can still submit a PROT_REGION
command.=20

Because the scheduler does not verify if the specific group provided a valid
suspend buffer, the hardware interface gets programmed with a zero address
for the suspend buffer in panthor_group_bind_locked(). When the firmware
later attempts to suspend the group, it writes to address 0, causing an
unrecoverable exception and Denial of Service.

Should this also check if group->protm_suspend_buf is valid?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911114014.7913=
9-1-ketil.johnsen@arm.com?part=3D6
