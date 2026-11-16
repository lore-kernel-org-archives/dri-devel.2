Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQNekTbJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A414D10EF9F;
	Mon, 16 Nov 2026 11:51:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B300710EF9F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:51:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DFD243EC5;
 Mon, 16 Nov 2026 11:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0691F000C4;
 Mon, 16 Nov 2026 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794829861;
 bh=gzmeSfGW1JPAjRUUHIsDgS0E69cYBPQsNNg/Y3bhO5E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RQNekTbJaboHat8Cjpe+s4t8GB5cTiPRyCf27NwdPE+6YUoeTKbgMgiaMSvykfcqP
 nMdd+QwjmawxuQi6d8pcxzY9vgwKdGk916PoMxPvlpGN3rrBwMhTdivgx3/8qwhtfI
 2vBgsIetBjypqVZycz7WVk4jU514DyTTMe9RzXYhi8i7RkfFV6FJh7+S6dDVrPEtAw
 cHjyCatZL2/rRV8LCRt8y2+fLWMsMLcEr3HpPCkdzMuKKLxaJFT9iPe1uwTZhE+VOp
 KGoMAncivMLgWa5HSPB4g/Mgmj+Aj0tX4rUXJya++NEXo6mChTJS7ZxBLMNyAWPXVD
 s94hLSPr/hMww==
Message-ID: <sashiko-outbox-216960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/13] drm/panthor: Support FW init of protm
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261116112601.3483649-12-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
 <20261116112601.3483649-12-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:51:00 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/panthor: NULL pointer dereference in
  panthor_fw_query_protm_info()
- [Medium] drm/panthor: UAF or NULL dereference of fw->vm outside
  drm_dev_enter()
- [Low] drm/panthor: missing kernel-doc for protm member in struct
  panthor_fw
- [Low] drm/panthor: NULL shared_section->mem in
  panthor_fw_load_section_entry()
--

commit 5ac4027cd6058f1c3359662cdf5433f1c22a832b
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Support FW init of protm

This commit adds UAPI and firmware support to query protected mode
information and initialize the protected firmware section from a
userspace-supplied GEM buffer object.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index b565b362f401f..af86b1844ead8 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
[ ... ]
> @@ -267,6 +269,18 @@ struct panthor_fw {
>  		struct delayed_work ping_work;
>  	} watchdog;
> =20
> +	struct  {
> +		/** @protm.init_lock: Used to serialize protm initialization. */
> +		struct mutex init_lock;
> +
> +		/** @protm.inited: set to true when protm.section is initialized */
> +		bool inited;
> +
> +		/** @protm.section: The protected mode section. */
> +		struct panthor_fw_section *section;
> +
> +	} protm;

[Severity: Low]
This isn't a bug, but struct panthor_fw has a kernel-doc comment block and
protm is missing its top-level @protm description, which triggers a
kernel-doc warning with W=3D1 builds.

[ ... ]
> @@ -637,12 +659,6 @@ static int panthor_fw_load_section_entry(struct pant=
hor_device *ptdev,
>  		return -EINVAL;
>  	}
> =20
> -	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
> -		drm_warn(&ptdev->base,
> -			 "Firmware protected mode entry is not supported, ignoring");
> -		return 0;
> -	}
> -
>  	if (hdr.va.start =3D=3D CSF_MCU_SHARED_REGION_START &&
>  	    !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_SHARED)) {
>  		drm_err(&ptdev->base,
> @@ -694,7 +710,22 @@ static int panthor_fw_load_section_entry(struct pant=
hor_device *ptdev,
>  	section->size =3D section_size;
>  	section->va =3D hdr.va.start;
> =20
> -	if (section_size) {
> +	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
> +		guard(mutex)(&ptdev->fw->protm.init_lock);
> +
> +		if (ptdev->fw->protm.section) {
> +			drm_err(&ptdev->base,
> +				"Only one protected section supported\n");
> +			return -EINVAL;
> +		}
> +
> +		ptdev->fw->protm.section =3D section;
> +	}
> +
> +	/* Defer the section->mem creation if this is a protected entry.
> +	 * This will be populated when DRM_IOCTL_PANTHOR_PROTM_INIT is called.
> +	 */
> +	if (section->size && !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)) {
>  		u32 vm_map_flags =3D section_vm_map_flags(section);
> =20
>  		section->mem =3D panthor_kernel_bo_create(

[Severity: Low]
Can a malformed firmware binary cause a NULL pointer dereference of
ptdev->fw->shared_section->mem in panthor_fw_init_ifaces()?

If an entry at CSF_MCU_SHARED_REGION_START has both
CSF_FW_BINARY_IFACE_ENTRY_SHARED and CSF_FW_BINARY_IFACE_ENTRY_PROT set,
panthor_fw_load_section_entry() skips allocating section->mem and still
assigns ptdev->fw->shared_section =3D section, which
panthor_fw_init_ifaces() then dereferences via panthor_kernel_bo_size().
Rejecting CSF_FW_BINARY_IFACE_ENTRY_PROT when
CSF_FW_BINARY_IFACE_ENTRY_SHARED is set would prevent this.

[ ... ]
> @@ -1610,6 +1641,101 @@ int panthor_fw_protm_exit(struct panthor_device *=
ptdev, u32 timeout_ms)
>  	return panthor_fw_protm_exit_wait(ptdev, timeout_ms);
>  }
> =20
> +int panthor_fw_protm_init(struct drm_file *file,
> +			  struct drm_panthor_protm_init *args)
> +{
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct panthor_device *ptdev =3D pfile->ptdev;
> +	ssize_t vm_pgsz =3D panthor_vm_page_size(ptdev->fw->vm);
> +	struct panthor_fw_section *protm_section;
> +	struct panthor_kernel_bo *mem;
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
> +	mutex_lock(&ptdev->fw->protm.init_lock);
> +
> +	protm_section =3D ptdev->fw->protm.section;
> +
> +	if (!protm_section || !protm_section->size) {
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	if (ptdev->fw->protm.inited)
> +		goto out_unlock;
> +
> +	if (!drm_dev_enter(&ptdev->base, &cookie)) {
> +		ret =3D -ENODEV;
> +		goto out_unlock;
> +	}

[Severity: Medium]
Can calling panthor_vm_page_size(ptdev->fw->vm) before drm_dev_enter() here
(and without drm_dev_enter() in panthor_fw_query_protm_info() below) cause
a use-after-free or NULL pointer dereference if the device is unplugged
concurrently?

CPU0                                    CPU1
drm_ioctl_kernel()
  panthor_ioctl_protm_init()
    panthor_fw_protm_init()
                                        panthor_device_unplug()
                                          drm_dev_unplug(&ptdev->base)
                                          panthor_fw_unplug(ptdev)
                                            panthor_vm_put(ptdev->fw->vm)
                                            ptdev->fw->vm =3D NULL
      panthor_vm_page_size(ptdev->fw->vm)
        <-- NULL / UAF dereference
      ...
      drm_dev_enter(&ptdev->base, &cookie)

Evaluating panthor_vm_page_size(ptdev->fw->vm) only inside a
drm_dev_enter() section in both functions would avoid racing with
panthor_fw_unplug().

> +
> +	obj =3D drm_gem_object_lookup(file,
> +				    args->fw_protected_sections_bo_handle);
> +	if (!obj) {
> +		ret =3D -ENOENT;
> +		goto out_dev_exit;
> +	}
> +
> +	if (obj->size < ALIGN(ptdev->fw->protm.section->size, vm_pgsz)) {
> +		ret =3D -EINVAL;
> +		goto out_gem_put;
> +	}
> +
> +	vm_map_flags =3D section_vm_map_flags(protm_section);
> +
> +	mem =3D panthor_kernel_bo_create_from_gem(
> +		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
> +		protm_section->va, protm_section->size);
> +	if (IS_ERR(mem)) {
> +		ret =3D PTR_ERR(mem);
> +		goto out_gem_put;
> +	}
> +
> +	protm_section->mem =3D mem;
> +
> +	ptdev->fw->protm.inited =3D true;
> +
> +out_gem_put:
> +	drm_gem_object_put(obj);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +
> +out_unlock:
> +	mutex_unlock(&ptdev->fw->protm.init_lock);
> +
> +	return ret;
> +}
> +
> +bool panthor_fw_protm_is_inited(struct panthor_device *ptdev)
> +{
> +	guard(mutex)(&ptdev->fw->protm.init_lock);
> +	return ptdev->fw->protm.inited;
> +}
> +
> +void panthor_fw_query_protm_info(struct drm_file *file,
> +				 struct drm_panthor_protm_info *arg)
> +{
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct panthor_device *ptdev =3D pfile->ptdev;
> +	ssize_t vm_pgsz =3D panthor_vm_page_size(ptdev->fw->vm);
> +
> +	guard(mutex)(&ptdev->fw->protm.init_lock);
> +
> +	memset(arg, 0, sizeof(*arg));
> +	arg->state =3D ptdev->fw->protm.inited ? DRM_PANTHOR_PROTM_INITIALIZED =
: 0;
> +	arg->group_protected_suspend_buf_size =3D ptdev->fw->protm_suspend_size;
> +	arg->fw_protected_sections_size =3D  ALIGN(ptdev->fw->protm.section->si=
ze,
> +						 vm_pgsz);
> +}

[Severity: High]
Does panthor_fw_query_protm_info() dereference a NULL
ptdev->fw->protm.section when the loaded firmware has no protected section?

Unlike panthor_fw_protm_init(), which checks whether protm_section is NULL,
querying DRM_PANTHOR_DEV_QUERY_PROTM_INFO unconditionally reads
ptdev->fw->protm.section->size, allowing any user with render node access
to trigger a kernel NULL pointer dereference if the firmware binary lacks a
non-empty CSF_FW_BINARY_IFACE_ENTRY_PROT entry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116112601.3483=
649-1-ketil.johnsen@arm.com?part=3D11
