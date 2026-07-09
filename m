Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B12C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F319D10E6C7;
	Thu,  9 Jul 2026 12:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E0eK326t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8D210E6C7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:40:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25C03600C3;
 Thu,  9 Jul 2026 12:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06C91F000E9;
 Thu,  9 Jul 2026 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600810;
 bh=Sbq6NQ7HoERldwSCK3d/tSh9Zxhji/rMrejDh0VyCGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E0eK326tSVZ10zRTrpk/RZ4vH60EnHT473CfgT31Y0ijneC3TgeHZUikXxLX0SRWl
 6N8bQ/4vDItyUZhJeRZTG4zAdL95zE1NRwCIkePC5z1Lh7ShByGSI/5z0ZUASghB/9
 SDP0EaMBXvCDbImyjXC+oULmbQozU7r5JFSx52Ea3xC1OBGPaXPZE61aC/t8WTmMDH
 Q5fC63FGSaiG345sdzhZZosVC8yqTHc8UgrBQFCQl2afYJ+3S9TJjAbtY+g2vBSget
 c4zDVWZD4vtP1TC6rEDkS++mCzt2Bq2f/GjupMko1U+Efm2LUPYToAeub9IsFWQXhm
 TyN6qllF5ur9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: Fix reference count leak in xe_pci_barrier_mmap()
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709123252.302944-1-yaolu@kylinos.cn>
References: <20260709123252.302944-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:40:10 +0000
Message-Id: <20260709124010.B06C91F000E9@smtp.kernel.org>
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
- [High] Removing `drm_dev_get()` from `xe_pci_barrier_mmap()` causes a dev=
ice reference count underflow, leading to a potential use-after-free of the=
 `xe_device`.
--

--- Patch [1]: [PATCH] drm/xe: Fix reference count leak in xe_pci_barrier_m=
map() ---
commit fb6604d312d887a8133909c7e0434e96c90e6a7d
Author: Lu Yao <yaolu@kylinos.cn>

drm/xe: Fix reference count leak in xe_pci_barrier_mmap()

This commit removes a drm_dev_get() call in xe_pci_barrier_mmap(), with the
stated assumption that the vm_ops .open and .close callbacks already handle
the reference counting.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -341,7 +341,6 @@ static int xe_pci_barrier_mmap(struct file *filp,
>  	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO);
>  	vma->vm_ops =3D &vm_ops_barrier;
>  	vma->vm_private_data =3D dev;
> -	drm_dev_get(vma->vm_private_data);

[Severity: High]
Will this removal lead to a device reference count underflow when the VMA
is eventually closed?

The memory management subsystem does not call a VMA's .open callback upon
initial creation via mmap(), it is only invoked during VMA duplication
like fork() or mremap(). Because the explicit drm_dev_get() is removed
in xe_pci_barrier_mmap(), the initial VMA is created without incrementing
the device reference count.

When the VMA is unmapped, barrier_close() unconditionally drops a reference:

static void barrier_close(struct vm_area_struct *vma)
{
        drm_dev_put(vma->vm_private_data);
}

Does this unmatched put cause a reference count underflow and potential
use-after-free of the drm_device?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709123252.3029=
44-1-yaolu@kylinos.cn?part=3D1
