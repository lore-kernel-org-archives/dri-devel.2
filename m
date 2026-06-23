Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1341FCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6696410E374;
	Tue, 23 Jun 2026 20:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jP/pylDy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4B910E374
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:14:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44C144431E;
 Tue, 23 Jun 2026 20:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC441F000E9;
 Tue, 23 Jun 2026 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782245673;
 bh=XFlA3cUOn/bZKuFBzUekG19gFYA1pVOwR+syFFIMfME=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jP/pylDyb5DSkrhzGGXfJKLby56r2wZIIe6es5PVa9mQcJBJoBqNt1ir5pwxxIcjf
 eFogOhVTZr8NuCbfQ6UBoa1zLqZDeZSEflTDC13gAHiGv28dajRcQz+KcJok3mlnfY
 sE1HyvbUiLx1BrxeOI5Zd4hOcwzH+ebUkVsQSXZP0Iq/naHokHypTMIXhqSMe6k9/6
 VtPQ/mocKz8/5yl5dD1nZlCdHS3UrW7Qv7QzqPGgVSt9wduUXZRp94CtoqUFvwf+LA
 F9mHhc6pv8yJSve6FrLej3L3Udt0mf8MY5ittPRv39DglJ/VyhEsC7TixU+Nt3vqMl
 OuuoTULMUqimQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/panthor: Add vm_bind region with kbo range
 intersection check
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
References: <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:14:32 +0000
Message-Id: <20260623201433.0BC441F000E9@smtp.kernel.org>
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
- [Medium] Integer overflow in `panthor_vm_is_kernel_address()` bypasses th=
e newly added kernel BO range check.
--

commit 517863d5c6821783c9329a7a6ac1663177dce0ba
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panthor: Add vm_bind region with kbo range intersection check

This commit adds a check during VM binding to ensure that user-exposed BO
mappings do not intersect with the virtual address space carve-out reserved
for kernel BOs. It introduces panthor_vm_is_kernel_address() to evaluate if
the requested mapping overlaps with the kernel VA range.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 31cc57029c12c..5625f3d340318 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -1309,6 +1318,24 @@ static int panthor_vm_op_ctx_prealloc_pts(struct p=
anthor_vm_op_ctx *op_ctx)
>  	return 0;
>  }
> =20
> +static bool
> +panthor_vm_is_kernel_address(struct panthor_vm *vm,
> +			     const struct drm_panthor_vm_bind_op *op)
> +{
> +	u32 op_type =3D op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK;
> +	u64 end, kstart, krange, kend;
> +
> +	if (op_type =3D=3D DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
> +		return false;
> +
> +	end =3D op->va + op->size;
> +	kstart =3D vm->kernel_va.start;
> +	krange =3D vm->kernel_va.range;
> +	kend =3D kstart + krange;
> +
> +	return krange && op->va < kend && kstart < end;

[Severity: Medium]
Can this calculation integer overflow?

If a user provides an op->va and op->size that wrap around a 64-bit integer
when added, end becomes a small value.

This would cause the intersection check (kstart < end) to evaluate to false,
bypassing the newly added kernel BO range check.

Should this use an overflow safe check to validate the range before checking
the intersection?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-vm_bind_ch=
ecks-v1-0-956198602ae3@collabora.com?part=3D1
