Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64328C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDDA10E066;
	Wed,  2 Sep 2026 19:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AWjOEIz4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B548310E066
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:56:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0E95600D1;
 Wed,  2 Sep 2026 19:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674731F000E9;
 Wed,  2 Sep 2026 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378982;
 bh=10x6Qfa484vUoSmRE5BMQB0rKNsWs+cOdvzIHI+eMFY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AWjOEIz4Xp72NdWg4hT5nwQ5I7PC9NbwsBaPJWe3V5l0+OqCCs3tgQ7hIGdB/WsGK
 vLuM2om5ZDygCUR8YfgWMMhplCvOgizXzNzCkvfctF1/hxOGr+Sv/HkHA6on/J9o08
 7Eb/E4W894DRIGWWlsG3Jz7nAIFgjjO/IDpCxxUD5cktfpfmslJ/qzsVVcYMu3QiJt
 C7Rwb6ZRcJgV0vekcrpQvkxVJ3u1Oke+/F4hFgLYkEJVl7Ei8oB0CSczqRjeaEoyuz
 8+6wz4ku5MYscEpEGEqjCuLBM/Sp+wHNhVl6AznAwayUDRL22yUx2ARqFY1Uqp+rwL
 HSfa1KsWSiPmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Use devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902194041.1999834-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902194041.1999834-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:56:21 +0000
Message-Id: <20260902195622.674731F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a critical lifetime mismatch by tying the=
 reserved memory region's release to the device unbind phase via `devm_of_r=
eserved_mem_device_init()`. The fastrpc driver allows user-specific DMA buf=
fers (held by `miscdev` open file descriptors) to outlive the device's unbi=
nd phase. When userspace closes the file descriptor after `remove()` has co=
mpleted, `fastrpc_buf_free()` calls `dma_free_coherent()` on `rdev`. Becaus=
e the devres cleanup has already executed and cleared the device's coherent=
 memory pool (`dev->dma_mem =3D NULL`), `dma_free_coherent()` falls back to=
 freeing the reserved memory pages into the general kernel buddy allocator,=
 causing severe memory corruption.

Pre-existing issues:
- [High] In `fastrpc_rpmsg_probe()`, `rdev->dma_mask` is pointed to the dyn=
amically allocated `&data->dma_mask`. If the probe function fails later (e.=
g., in `of_platform_populate()`), `data` is freed via `kfree(data)`, but `r=
dev->dma_mask` is not cleared. This leaves a dangling pointer in the persis=
tent `rpmsg_device` structure that can lead to a Use-After-Free if the DMA =
mask is later queried by the driver core or during reprobe.
- [High] For `SDSP_DOMAIN_ID`, the entire reserved memory region is assigne=
d to the DSP via `qcom_scm_assign_mem()`. However, the driver fails to reve=
rt this assignment back to `QCOM_SCM_VMID_HLOS` on subsequent probe error p=
aths and in `fastrpc_rpmsg_remove()`. As a result, the physical memory rema=
ins permanently owned by TrustZone, preventing driver reload and potentiall=
y causing hypervisor faults on subsequent Linux accesses.
- [High] Missing NULL check for `cctx->rpdev` in `fastrpc_remote_heap_alloc=
` leading to a potential crash if ioctls are called after device removal.
- [High] The fastrpc misc devices are registered and exposed to userspace b=
efore their critical context data structures (locks, IDR, refcount, rpdev) =
are initialized.
- [High] Use-after-free of child platform_device pointer during buffer free=
ing.
--

commit 690dc3f2f1a71f7a802b45a29611ac1e33c88795
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

misc: fastrpc: Use devm_of_reserved_mem_device_init()

The commit updates the fastrpc driver to use the devres-managed
devm_of_reserved_mem_device_init() during probe. This ensures the reserved
memory region is automatically released on device removal.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec1..21f084c76f81d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2562,7 +2562,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		return -EINVAL;
>  	}
> =20
> -	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
> +	if (devm_of_reserved_mem_device_init(rdev))

[Severity: Critical]
Does this introduce a lifetime mismatch for user-specific DMA buffers?

By tying the reserved memory region's release to the device unbind phase via
devres, the region is cleared before all userspace file descriptors might be
closed. The fastrpc driver allows user-specific DMA buffers (held by miscdev
open file descriptors) to outlive the device's unbind phase.

It allocates user-managed memory from the rdev reserved memory pool, which
outlives device unbind:

drivers/misc/fastrpc.c:fastrpc_remote_heap_alloc() {
    ...
    struct device *rdev =3D &fl->cctx->rpdev->dev;

    return  __fastrpc_buf_alloc(fl, rdev, size, obuf);
    ...
}

When userspace closes the file descriptor after remove() has completed,
fastrpc_buf_free() calls dma_free_coherent() on rdev:

drivers/misc/fastrpc.c:fastrpc_buf_free() {
    ...
    dma_free_coherent(buf->dev, buf->size, buf->virt,
                      fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr)=
);
    ...
}

Because the devres cleanup has already executed and cleared the device's
coherent memory pool, will dma_free_coherent() fall back to freeing the
reserved memory pages into the general kernel buddy allocator, causing seve=
re
memory corruption?

>  		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
> =20
>  	vmcount =3D of_property_read_variable_u32_array(rdev->of_node,

[Severity: High]
This is a pre-existing issue, but does fastrpc_rpmsg_probe() leave a dangli=
ng
pointer if probe fails?

During probe, rdev->dma_mask is pointed to dynamically allocated memory:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
    rdev->dma_mask =3D &data->dma_mask;
    ...
}

If a subsequent step like of_platform_populate() fails, the error path
frees data:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
err_free_data:
    kfree(data);
    return err;
}

Since rdev->dma_mask is not cleared, could this result in a Use-After-Free
if the rpmsg bus or driver core later queries the dangling DMA mask pointer?


[Severity: High]
This is a pre-existing issue, but does the driver permanently lose physical
memory to TrustZone on probe error or device unbind?

For SDSP_DOMAIN_ID, the entire reserved memory region is assigned to the DS=
P:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
    err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
                              data->vmperms, data->vmcount);
    ...
}

However, neither the probe error paths:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
err_deregister_fdev:
    if (data->fdevice)
    ...
}

nor fastrpc_rpmsg_remove() revert this assignment back to QCOM_SCM_VMID_HLO=
S.

Can this cause hypervisor faults (XPU/SMMU violation) and kernel panics if
the kernel attempts to reuse the physical memory after device unbind or
driver reload?


[Severity: High]
This is a pre-existing issue, but is there a missing NULL check for
cctx->rpdev in fastrpc_remote_heap_alloc()?

During device unbind, cctx->rpdev is cleared:

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    cctx->rpdev =3D NULL;
    ...
}

If ioctls like FASTRPC_IOCTL_MMAP are called after device removal,
fastrpc_remote_heap_alloc() dereferences the pointer without checking:

drivers/misc/fastrpc.c:fastrpc_remote_heap_alloc() {
    ...
    struct device *rdev =3D &fl->cctx->rpdev->dev;
    ...
}

Could this result in a NULL pointer dereference and a kernel crash?


[Severity: High]
This is a pre-existing issue, but are the fastrpc misc devices exposed to
userspace too early during probe?

The misc device is registered before its downstream context fields are
initialized:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
    err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
    ...
}

If userspace calls open() on the device node exactly between misc_register()
and the initialization of context structures (like locks, IDR, refcount),
could functions like fastrpc_session_alloc() acquire an uninitialized lock:

drivers/misc/fastrpc.c:fastrpc_session_alloc() {
    ...
    spin_lock_irqsave(&cctx->lock, flags);
    ...
}

Would this lead to a kernel panic under lock debugging?


[Severity: High]
This is a pre-existing issue, but is there a use-after-free of the child
platform_device pointer during buffer freeing?

When a buffer is allocated, an un-referenced pointer to a child
platform_device is stored:

drivers/misc/fastrpc.c:__fastrpc_buf_alloc() {
    ...
    buf->dev =3D dev;
    ...
}

If the parent rpmsg device is unbound, of_platform_depopulate() destroys
the child platform devices. If a user subsequently closes their file
descriptor, fastrpc_buf_free() dereferences the freed pointer:

drivers/misc/fastrpc.c:fastrpc_buf_free() {
    ...
    dma_free_coherent(buf->dev, buf->size, buf->virt,
                      fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr)=
);
    ...
}

Could this result in memory corruption or a kernel crash when the dangling
pointer is passed to dma_free_coherent()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902194041.1999=
834-1-mukesh.ojha@oss.qualcomm.com?part=3D1
