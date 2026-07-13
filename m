Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097B7C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6390510E32E;
	Mon, 13 Jul 2026 09:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TPR3xo07";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E2A10E32E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 09:11:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 196B4436E8;
 Mon, 13 Jul 2026 09:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71241F000E9;
 Mon, 13 Jul 2026 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783933863;
 bh=LHKv1vs7yJ3OJ5tdBF/G/J+9NhCg16dWEpdlk082his=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TPR3xo075wA+GmBusyOYuaiHWC96VTQXkhsnLXOjdNVi1abHIR4KEvwG1vq8QY4W4
 UNxfW2VUnkzJsJZ3uyO58QQl8xcnJqY3yrQ1nlQA7t5EKyRZ8K8VgJuleJF1/3iGWY
 B37I9ZwVpjfhCagX+dQlP9MbMoHc6hLz1z5M/wtGSbrjxdavSvuu7xUWYBFp8CZLg/
 79kHclJ0SIiV1PMSOt0Vnx7RjPBlQXVpiOX1z8F6zISOFSoYxQaZvWwOvkXngo6Yqn
 7HKMRl54dJw5C7pqviEW89M5bdhjUtMlbl3loH7/DcPieYvZQbq2Vkcse6dZ8qzz5H
 gClohddo40pAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-vm_bind_checks-v5-1-0d2314af8d9d@collabora.com>
References: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
 <20260713-vm_bind_checks-v5-1-0d2314af8d9d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 09:11:02 +0000
Message-Id: <20260713091102.C71241F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Zero-size asynchronous VM_BIND operations can corrupt the drm_gpuv=
m interval tree.
--

--- Patch [1]: [PATCH v5 1/2] drm/panthor: Add vm_bind region with kbo rang=
e overlap check ---
commit 0c0faa58a385567244a3f75b05f6667907422807
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panthor: Add vm_bind region with kbo range overlap check

When a VM is created, the caller has to specify the range of the address
space carve-out set aside for mapping kernel buffer objects. That means
vm_bind mappings of userspace-exposed objects should not intersect with
that region, which this patch checks during the vm_bind ioctl.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 31cc57029c12c..910c8e579770d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *fi=
le,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
> =20
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (range_overflows(op->va, op->size, vm->user_va_range))
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does this function need to reject
op->size =3D=3D 0 before proceeding?

A zero-size map operation is currently treated as aligned, and
range_overflows() will return false, allowing it to pass this validation.

If userspace passes a zero size, inserting a zero-size interval into the
interval tree will compute an end address of addr - 1. This violates the
red-black augmented tree invariants which require start to be less than
or equal to last.

Could this cause structural corruption of the interval subtree values,
leading to subsequent tree traversals silently failing to find mapped
regions? Unlike the sync path, panthor_vm_bind_job_create() appears to lack
a size check for asynchronous jobs, which might allow unprivileged
userspace to trigger this directly.

>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-vm_bind_ch=
ecks-v5-0-0d2314af8d9d@collabora.com?part=3D1
