Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5074CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3067710F405;
	Fri, 12 Jun 2026 09:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L5ZrQSEQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C9510F3FC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:38:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA20640BA2;
 Fri, 12 Jun 2026 09:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9902D1F000E9;
 Fri, 12 Jun 2026 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781257082;
 bh=gqikJJzxvmQEXU9Guzhx1KrEFWl+8j6fOTsqSUFlxIA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L5ZrQSEQH8DlnQmXxhAIo/LeH5/R+40+hNeDDbjY5ncnqL8OLtJ1/h2mxuXbps2yS
 PXHAlAGBzj4nYXc8Z/KH28iI5GTk1b+ryXnaCVWj2Uy/4M4K0XFL7YlbXWikEAEZC/
 VILu7Z3a1exh/y/BeqZ7jFVtP9edQQmZZq/4o18lHfOjEePxDe5L0BO9Oxzm0vS5uo
 dpKKlSGp60rD9+PwxFC/V4/3aBc31U+4t2PP2CZuez7dPFkC1ZvyfhfRQ1S6Z/FgVA
 rPOjyUPb95zfCOaVRDfiOgDn0oYR955meqKwTTi61WN+q1eYxmDinucbfwj+2+roB0
 vwwel+YUjfTiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/18] drm/amdgpu: implement SVM attribute
 set/get/clear operations
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-6-ray.huang@amd.com>
References: <20260612090928.29682-6-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:38:02 +0000
Message-Id: <20260612093802.9902D1F000E9@smtp.kernel.org>
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
- [High] State Desynchronization / Broken Retry Logic for hardware GPU mapp=
ing updates
- [High] Type Confusion / Struct Layout Mismatch on 32-bit platforms during=
 BO overlap detection
- [High] Kernel Resource Exhaustion (OOM) due to lack of interval tree merg=
ing
- [Medium] Unprivileged users can flood the kernel log by triggering BO ove=
rlap errors
- [Medium] Silent failure to apply attribute changes to virtual page 0
--

commit 5cf3077146707f9870d0ea122388797eb6226731
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/amdgpu: implement SVM attribute set/get/clear operations

This commit completes the attribute subsystem with validation, tree
modification, and a public API. It introduces attribute validation, flag
application, VMA range validation, VM BO overlap detection, tree
modification with gap/overlap handling, and public APIs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_svm_attr.c
> index ba09aa3c3fe4d..26e33defb8b9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
[ ... ]
> +int
> +amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
> +			    unsigned long start_page,
> +			    unsigned long last_page,
> +			    unsigned long *bo_start, unsigned long *bo_last)
> +{
[ ... ]
> +	node =3D interval_tree_iter_first(&vm->va, start_page, last_page);

[Severity: High]
Could this cause a struct layout mismatch on 32-bit platforms?

This passes the AMDGPU-specific vm->va tree to the generic
interval_tree_iter_first() macro, which expects the start and last fields
to be unsigned long. The vm->va tree uses uint64_t bounds. On 32-bit
architectures, this will read the incorrect layout and potentially corrupt
the interval bounds during the traversal.

> +	if (node) {
> +		AMDGPU_SVM_ERR("SVM range [0x%lx 0x%lx] overlaps with BO mapping [0x%l=
x 0x%lx]\n",
> +			       start_page, last_page, node->start, node->last);

[Severity: Medium]
Is there a risk of unprivileged userspace applications flooding the kernel =
log?

If a requested SVM range overlaps with an existing BO mapping, this
unconditionally logs an error using AMDGPU_SVM_ERR(). Since the start_page
and last_page parameters are controlled by user input, a malicious
application could repeatedly request overlapping ranges and cause massive
dmesg spam without any ratelimiting.

[ ... ]
> +static int
> +amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
> +			  const struct amdgpu_svm_attrs *default_attrs,
> +			  unsigned long start_page, unsigned long last_page,
> +			  uint32_t nattr,
> +			  const struct drm_amdgpu_svm_attribute *attrs,
> +			  struct attr_set_ctx *change)
> +{
[ ... ]
> +	/* Always create a range entry even when attrs equal defaults */
> +	range =3D amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs=
);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);

[Severity: High]
Can this lead to unbounded memory allocation and a potential kernel OOM?

New range nodes are unconditionally allocated and inserted into the tree
here without checking if they can be merged with adjacent identical ranges.
Because there is no max_map_count limit, a user application repeatedly
calling the ioctl on alternating pages could indefinitely fragment the
interval tree and exhaust kmem_cache.

[ ... ]
> +static int
> +amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
> +			     struct amdgpu_svm_attr_range *range,
> +			     unsigned long start_page, unsigned long last_page,
> +			     uint32_t nattr,
> +			     const struct drm_amdgpu_svm_attribute *attrs,
> +			     struct attr_set_ctx *change)
> +{
[ ... ]
> +	if (attr_same_attrs(range, nattr, attrs)) {
> +		/* Report old=3D=3Dnew so apply_attr_change can decide */
> +		attr_change_ctx_set(change, &old_attrs,
> +					       &old_attrs,
> +					       start_page, last_page);
> +		return 0;
> +	}

[Severity: High]
Does this logic cause state desynchronization during a retry?

During a retry attempt after a hardware mapping failure, the software inter=
val
tree has already been updated. This check will see that the requested
attributes perfectly match the tree, returning old=3D=3Dnew and fatally
short-circuiting the hardware update.

[ ... ]
> +	/* split head */
> +	if (start_page > range_start) {
> +		left =3D amdgpu_svm_attr_range_alloc(range_start, start_page - 1, &old=
_attrs);
> +		if (!left)
> +			return -ENOMEM;
> +	}

[Severity: High]
Can this split logic also contribute to kernel resource exhaustion?

Existing ranges are permanently split into smaller segments here with no
subsequent defragmentation or merging logic. This enables unbounded
fragmentation of the tree.

[ ... ]
> +static int
> +amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
> +			  const struct amdgpu_svm_attrs *default_attrs,
> +			  unsigned long start_page, unsigned long last_page,
> +			  uint32_t nattr,
> +			  const struct drm_amdgpu_svm_attribute *attrs)
> +{
[ ... ]
> +		ret =3D amdgpu_svm_apply_attr_change(svm,
> +						   &change.old_attrs,
> +						   &change.new_attrs,
> +						   change.start_page,
> +						   change.last_page);

[Severity: Medium]
Does this skip legitimate attribute changes for virtual page 0?

The amdgpu_svm_apply_attr_change() function contains a fast-return check:

drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c:amdgpu_svm_apply_attr_change() {
    ...
    if (!start_page && !last_page)
        return 0;
    ...
}

If a request is made to map memory exactly at virtual address 0
(start_page=3D0, last_page=3D0), it appears it would silently exit with suc=
cess
without actually applying the hardware attributes.

> +		amdgpu_svm_unlock(svm);
> +
> +		if (ret =3D=3D -EAGAIN) {
> +			need_retry =3D true;
> +			ret =3D 0;
> +		}

[Severity: High]
Is the software interval tree rolled back on failure here?

The software tree is updated prior to this hardware update attempt. If
amdgpu_svm_apply_attr_change() returns -EAGAIN, this merely sets a retry fl=
ag
without rolling back the tree. As noted earlier, this guarantees the
subsequent retry will skip the hardware update entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D5
