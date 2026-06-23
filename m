Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CA9CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B0D10ECA6;
	Tue, 23 Jun 2026 20:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LvDYwOgh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F72810ECA6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:42:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B29440C27;
 Tue, 23 Jun 2026 20:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1B1F000E9;
 Tue, 23 Jun 2026 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247341;
 bh=nM6mGBgzZ4avEBELhNUN4nytPFuPaGGDMPEjGL+Wwmw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LvDYwOghRzvuompYIEdVIBzFwYx4MsM9csD+STUS0QPyX+AUvDfc7IpahbPni9pf+
 Ft15aYE+CNkcEWh2+v9xoVrOEu8qOaKtmW+XcWGHGs0O3XP+bZNwk3EG69KsxwjulI
 Cvuib4GqogXJO2rBQOEpYwEZnT0lMLnXQC4h4+WBJtRk67gPHVHDdmKECWfaqtZf5p
 WmkWrtZ8Nf5eAeyQh1uYEmt8aeSgVVM768dcMFWUrQ2b2eneyzNYumWg+MI8ZNcyxt
 n6qGL2jGbJiYTXh3Pf0YmATfHq4ZY3RHSVmBrqQ0MBqFGOKArb2OYjqz4IcbS06Hez
 nLmYd6tgp0F4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
 <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:42:20 +0000
Message-Id: <20260623204220.CDB1B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The overlap check incorrectly rejects valid user VA mappings tha=
t end exactly at the upper boundary of the user VA space, effectively reduc=
ing the usable user VA space by one page.

Pre-existing issues:
- [High] The bounds check for the kernel-reserved VA range lacks integer ov=
erflow protection, allowing an attacker to bypass it and trigger undefined =
behavior and hardware register corruption.
--

commit 544d7f2ab2018dcefc4327336a2da6f6a37e4d4f
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panthor: Add vm_bind region with kbo range overlap check

This patch adds a check to ensure that user VM mappings do not overlap
with the kernel BO address space carve-out. It sets a boundary for the
user VA range at VM creation and enforces it during the vm_bind ioctl.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 31cc57029c12c..a8de4fe6b231b 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, boo=
l for_mcu,
>  		va_range =3D full_va_range;
>  	}
> =20
> +	vm->user_va_end =3D kernel_va_start - 1;
> +
>  	mutex_init(&vm->mm_lock);

[ ... ]

> @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *fi=
le,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
> =20
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (op->va + op->size > vm->user_va_end)
> +		return -EINVAL;

[Severity: Medium]
Since op->va + op->size represents the exclusive end of the mapping, and
vm->user_va_end is the inclusive upper bound (kernel_va_start - 1), does th=
is
reject valid mappings that end exactly at the boundary?

If a mapping ends exactly at kernel_va_start, op->va + op->size will be equ=
al
to kernel_va_start. The condition kernel_va_start > kernel_va_start - 1 will
evaluate to true and return -EINVAL, effectively reducing the usable user VA
space by one page.

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for this boun=
ds
check to be bypassed due to integer overflow?

If an unprivileged user calls the vm_bind ioctl with a sparse mapping and
parameters that overflow when added (for example, va =3D 0x200000 and
size =3D 0xffffffffffe00000), the wrapped va + size evaluates to 0. This
successfully bypasses the new check.

Later in the execution path, this bypass triggers undefined behavior when
pack_region_range() calculates region_end =3D start + size, which wraps to =
0.
This makes region_end - 1 equal to -1 (0xffffffffffffffff). The call to
fls64(*region_start ^ (region_end - 1)) then evaluates to 64, leading to
region_width =3D 63 and a shift by 64 (1ull << 64), which is undefined
behavior in C and corrupts the lockaddr hardware register.

> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-vm_bind_ch=
ecks-v2-0-b51abab35f71@collabora.com?part=3D1
