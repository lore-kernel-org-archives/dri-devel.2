Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8D0C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8C210F505;
	Fri, 17 Jul 2026 11:10:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLX/SoMR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E647710F505
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:10:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96113403F8;
 Fri, 17 Jul 2026 11:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B15D1F000E9;
 Fri, 17 Jul 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784286616;
 bh=RsPVVzvwALAhxVqUmrQebA8Ami6YPcWDsOVfFHHKbNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NLX/SoMR/TbHxUDdfpEHfRlVgxmpVmxCv9hUpC7kQbiSI8kaleRhOQPZ4PhvSfugH
 x4/Zzup5uST/Ouxk+SHz7DvK1rBLp99cO1iYfzookX3tl40umR6fgUc5ephUEKPyqN
 xxLz6z2FNdCtcBjx5oS+suBdU4EB0JsAtFzjkHk+Y/yVeU6LSK3wPykhao5yCs3JPv
 jk5xAwkIeffgaPSfjx3ArSpdXFCWgQMX+osFE7u7J5qAsUHweOi/0mSD2wFWytX5va
 MJpRajQ//gON+JywDadUPHhW3HVNzTnQD3Xkc51w8C/Gpajiopec5PnMQ10ZtFj4Mn
 7apj3PJ7fKY9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-9-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-9-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:10:15 +0000
Message-Id: <20260717111016.4B15D1F000E9@smtp.kernel.org>
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
- [High] cla_vma_fault() unconditionally assumes FAULT_FLAG_ALLOW_RETRY is =
set, triggering a WARN_ON and SIGBUS during normal per-VMA lock faults.
- [High] cla_vma_open() silently ignores errors from cla_ctx_map(), leading=
 to a context refcount imbalance and a deterministic NULL pointer dereferen=
ce.
- [Medium] Concurrent ioctl queries race with CPU hotplug device setup, lea=
king uninitialized or partially updated accelerator descriptors to userspac=
e.
--

--- Patch [8]: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface ---
commit 5559b4038bdef30d19e3f3c9904b6bfa29dc03ab
Author: Ryan Roberts <ryan.roberts@arm.com>
Subject: misc/arm-cla: Add userspace interface

This commit adds a character device interface for the Arm CLA driver,
allowing userspace to enumerate hardware and map accelerator register frame=
s.
It defines version 1 of the UAPI with a GET_PARAM ioctl for querying device
telemetry. Additionally, it implements shared read-write mmap support for
CLA register pages, utilizing a domain scheduler to resolve faults.

> diff --git a/drivers/misc/arm-cla/cla-user.c b/drivers/misc/arm-cla/cla-u=
ser.c
> new file mode 100644
> index 0000000000000..415328a653b7f
> --- /dev/null
> +++ b/drivers/misc/arm-cla/cla-user.c
[ ... ]
> @@ -0,0 +1,351 @@
[ ... ]
> +static long cla_ioctl_get_param(unsigned long arg)
> +{
[ ... ]
> +	case ARM_CLA_PARAM_DEV_ACCELS:
> +		param.value =3D cla_lut_pg[dev_id]->accelerators;
> +		break;
> +	case ARM_CLA_PARAM_ACCEL_IIDR:
> +		param.value =3D cla_lut_pg[dev_id]->accel_descs[accel_id].iidr;

[Severity: Medium]
Can concurrent ioctl queries race with CPU hotplug device setup here?

During CPU hotplug, cla_dev_setup() calls cla_dev_setup_accel() which
modifies accel_descs fields without holding dev->lock.=20

Concurrently, userspace can invoke this ioctl and read these fields without
any locks or memory barriers.

Because there is no synchronization, could an out-of-order read see the
dev->accelerators bit set before the corresponding accel_descs fields are
visible, returning uninitialized or stale telemetry data to userspace?

> +		break;
> +	case ARM_CLA_PARAM_ACCEL_DEVARCH:
> +		param.value =3D cla_lut_pg[dev_id]->accel_descs[accel_id].devarch;
> +		break;
[ ... ]
> +static void cla_vma_open(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * A vma previously created with cla_file_mmap() has been duplicated
> +	 * within the same mm (most likely due to mremap). While this could also
> +	 * be called for duplication into a new mm (via fork), we set
> +	 * VM_DONTCOPY on the original mmap, so this will never happen. So the
> +	 * contexts covered by this new vma already exist.
> +	 */
> +	struct cla_domain *domain;
> +
> +	cla_for_each_mapped_domain(vma, domain)
> +		cla_ctx_map(domain, vma->vm_mm, vma->vm_file);

[Severity: High]
Does this code need to check the return value of cla_ctx_map()?

If a VMA is duplicated (e.g., via mremap with MREMAP_MAYMOVE) and the
domain is in a broken state, cla_ctx_map() will return ERR_PTR(-EIO)
without incrementing the context refcount.

Because cla_vma_open() silently ignores this error, the refcount remains
unbalanced. When the old VMA is subsequently closed, cla_ctx_unmap() drops
the refcount to zero and frees the context.

When the new VMA is closed, cla_ctx_unmap() will fail to find the context:

drivers/misc/arm-cla/cla-ctx.c:cla_ctx_unmap() {
    ...
    ctx =3D cla_domain_lookup_ctx(domain, mm, file);
    WARN_ON(!ctx);

    if (!refcount_dec_and_test(&ctx->mapped)) {
    ...
}

Could this lead to an unconditional NULL pointer dereference of ctx?

> +}
> +
> +static void cla_vma_close(struct vm_area_struct *vma)
[ ... ]
> +static vm_fault_t cla_vma_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct cla_domain *domain;
> +	struct cla_dev *dev;
> +	struct cla_ctx *ctx;
> +	unsigned long pg;
> +
> +	/*
> +	 * Reassignment needs mmap_lock, so we cannot wait while holding it.
> +	 * Luckily, this flag is only missing in some exotic cases which do not
> +	 * apply for this VM_IO | VM_PFNMAP vma. i.e. GUP without
> +	 * FOLL_UNLOCKABLE or FOLL_NOWAIT or fixup_user_fault(unlocked=3DNULL),
> +	 * used by futex fault-in path.
> +	 */
> +	if (WARN_ON(!(vmf->flags & FAULT_FLAG_ALLOW_RETRY)))
> +		return VM_FAULT_SIGBUS;

[Severity: High]
Is it safe to unconditionally assume FAULT_FLAG_ALLOW_RETRY is set here?

Under the per-VMA lock fault path (which is the default for modern kernels),
FAULT_FLAG_VMA_LOCK is set but FAULT_FLAG_ALLOW_RETRY is explicitly absent.

Consequently, any normal page fault handled under the VMA lock will hit this
branch, returning VM_FAULT_SIGBUS and breaking normal memory access.

Additionally, because this is user-controllable, could the WARN_ON allow an
unprivileged local attacker to spam the kernel log or crash the system if
panic_on_warn is enabled?

> +
> +	pg =3D vma->vm_pgoff + ((vmf->address - vma->vm_start) >> PAGE_SHIFT);
> +	dev =3D cla_lut_pg[pg];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D8
