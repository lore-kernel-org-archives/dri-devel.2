Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE7CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF8E10F3C8;
	Fri, 12 Jun 2026 09:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W4bBRXpp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0A710F3C8
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:37:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 407204392F;
 Fri, 12 Jun 2026 09:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6DA1F000E9;
 Fri, 12 Jun 2026 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781257076;
 bh=AGkAKfB6Ai0DVl6XDGAfoo8luJBNPcU1QWDmB1hp2Ng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W4bBRXpp/en0itfcEyOylWjPJI13D3NUGNXJJoDWOfU7erGmqTZzt8J0dmbL/WnX3
 2FijbL/suUGy8xmZnSxpREvJGjlDOEvsfdG98Hzzupl/wXQjY/OJrp5W2VJ079oQQt
 BvUboEP0Tuzp310lY+q4ih4qPplXEbzLzU6bclH74M381UZDj7+8tFUeUM/JC7Khv9
 QTY7ZlZm5IZ8FNWdMX3uHKUSFaThnUnc/51U+d+u8KUIrPNd1kJcMn9AxziIXygQpL
 Ck9mfGDTs/W+p8/3HZNOAoMo3FWteI4Kyippc/qYGydjENjfJcQZAP0AwKdI8JzD67
 hVTo9vEQ/kuwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/18] drm/amdgpu: add SVM ioctl entry and fault
 handler module
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-12-ray.huang@amd.com>
References: <20260612090928.29682-12-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:37:55 +0000
Message-Id: <20260612093756.0F6DA1F000E9@smtp.kernel.org>
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
- [Critical] The `attr_range` pointer is accessed outside of `attr_tree->lo=
ck`, leading to a Use-After-Free if the range is concurrently removed and f=
reed.
- [High] Missing error return on write fault for a read-only range causes a=
n infinite page fault storm.
- [High] Unsynchronized lazy initialization of SVM context allows concurren=
t ioctls to cause double initialization and memory leaks.
- [High] Incomplete verification of BO overlaps allows SVM attribute ranges=
 to be created over valid BO mappings.
--

commit be4228299e9765ce7330b2f088decf851f4116cf
Author: Honglei Huang <honghuan@amd.com>

drm/amdgpu: add SVM ioctl entry and fault handler module

This commit adds the ioctl entry point and fault handling module for the
AMDGPU SVM implementation. It introduces capabilities to process range
attributes, garbage collect unmapped memory, and handle GPU page faults.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_svm.c
> index 7aae13e642508..9d25357de5d3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

[ ... ]

> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +	struct amdgpu_device *adev =3D drm_to_adev(dev);
> +	struct drm_amdgpu_gem_svm *args =3D data;
> +	struct drm_amdgpu_svm_attribute *attrs =3D NULL;
> +	struct amdgpu_vm *vm;
> +	size_t attrs_size =3D 0;
> +	int ret =3D 0;
> +
> +	AMDGPU_SVM_TRACE("ioctl op=3D%u va:[0x%llx-0x%llx)-0x%llx nattr=3D%u\n",
> +			 args->operation, args->start_addr, args->start_addr + args->size,
> +			 args->size, args->nattr);
> +
> +	vm =3D &fpriv->vm;
> +	if (!amdgpu_svm_is_enabled(vm)) {
> +		ret =3D amdgpu_svm_init(adev, vm);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
Could this lockless check allow multiple ioctls to initialize the SVM conte=
xt
concurrently?

The DRM ioctl mechanism allows concurrent execution from userspace. If
multiple threads call amdgpu_gem_svm_ioctl() on a newly created VM context =
at
the same time, they might all see !amdgpu_svm_is_enabled(vm).

This could cause multiple calls to amdgpu_svm_init(), overwriting vm->svm a=
nd
leaking the structure, workqueues, and attribute trees.

Should this check and initialization be protected by a lock?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_svm_fault.c
> new file mode 100644
> index 0000000000000..a92a1a4f2436f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c

[ ... ]

> +static int fault_get_unregistered_attrs(struct amdgpu_svm *svm,
> +					    unsigned long fault_addr,
> +					    unsigned long attr_start_page,
> +					    unsigned long attr_last_page,
> +					    struct amdgpu_svm_attr_range **out)
> +{

[ ... ]

> +	r =3D amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
> +					&bo_start, &bo_last);
> +	if (r =3D=3D -EADDRINUSE) {
> +		if (fault_page >=3D bo_start && fault_page <=3D bo_last)
> +			return -EFAULT;
> +
> +		/* Narrow to single page if expanded range overlaps BO */
> +		start_page =3D fault_page;
> +		last_page =3D fault_page;
> +	} else if (r) {
> +		return r;
> +	}
> +
> +	mutex_lock(&attr_tree->lock);
> +	range =3D amdgpu_svm_attr_range_alloc(start_page, last_page, &attrs);

[Severity: High]
When narrowing the range to a single page after detecting a BO overlap, is =
it
possible for the narrowed range to overlap with a different BO mapping?

The code checks the original range against BO mappings using
amdgpu_svm_attr_check_vm_bo(). If there is an overlap, it narrows the range
to just [fault_page, fault_page] and proceeds directly to allocation.

If the VMA contains multiple BO mappings and fault_page happens to fall
inside a second overlapping BO mapping that wasn't the first one returned
by the interval tree, this logic will skip checking the new narrowed range.

Could this allow SVM attribute ranges to be created over valid BO mappings,
silently overwriting the BO's GPU mapping?

[ ... ]

> +static int fault_map_range(struct amdgpu_svm *svm,
> +			       unsigned long fault_addr,
> +			       const struct amdgpu_svm_attr_range *attr_range,
> +			       bool write_fault)
> +{

[ ... ]

> +	if (write_fault && map_ctx.read_only) {
> +		AMDGPU_SVM_WARN("write fault on read-only range: fault=3D0x%lx range=
=3D[0x%lx-0x%lx)\n",
> +				 fault_addr, drm_gpusvm_range_start(&range->base),
> +				 drm_gpusvm_range_end(&range->base));
> +	}
> +
> +	if (ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,

[Severity: High]
Does this missing error return lead to an infinite page fault loop?

When a write fault occurs on a read-only range, the code logs a warning but
continues execution. It proceeds to populate the GPU page tables with
read-only permissions and returns 0 indicating success.

Because success is returned, the GPU hardware will immediately retry the
write access. Since the page table is still read-only, this will
immediately trigger another page fault.

Should this path return an error like -EPERM to prevent a fault storm and
a potential Denial of Service?

[ ... ]

> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> +			    uint64_t fault_page, uint64_t ts,
> +			    bool write_fault)
> +{

[ ... ]

> +	amdgpu_svm_lock(svm);
> +
> +	mutex_lock(&svm->attr_tree->lock);
> +	attr_range =3D amdgpu_svm_attr_get_bounds_locked(svm->attr_tree,
> +						       fault_page,
> +						       &attr_start_page, &attr_last_page);
> +	mutex_unlock(&svm->attr_tree->lock);
> +	if (!attr_range) {
> +		ret =3D fault_get_unregistered_attrs(svm, fault_addr,
> +							      attr_start_page,
> +							      attr_last_page,
> +							      &attr_range);
> +		if (ret) {
> +			if (ret =3D=3D -EFAULT)
> +				goto out_no_vma;
> +			goto out_unlock;
> +		}
> +	}
> +	ret =3D fault_map_range(svm, fault_addr, attr_range,
> +					 write_fault);

[Severity: Critical]
Is there a use-after-free risk for attr_range here?

The attr_range is retrieved while holding svm->attr_tree->lock. The lock is
then released, and the unreferenced attr_range is passed down to
fault_map_range().

Concurrently, a reset ioctl (AMDGPU_SVM_OP_RESET_ATTR) could execute
amdgpu_svm_attr_clear() which acquires attr_tree->lock. This can remove
and free the range while amdgpu_svm_handle_fault() is still running.

Once attr_tree->lock is released by the reset ioctl, could this path
dereference the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D11
