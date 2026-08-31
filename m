Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92628C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E6210E29F;
	Mon, 31 Aug 2026 14:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DKSOjRKS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FB310E29F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:56:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A0BE43B0B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED4B1F000E9;
 Mon, 31 Aug 2026 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788188178;
 bh=fAx+yNbEJWs3UA8H9YGE3IbiFvXd/Ib0XLbel6EOyvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DKSOjRKSQv+WlujWmOUA65sxHSwheKUj4JQBwJpqPE+ivIsmqTByCE/Oos5Y/xxsA
 +F01A93vPvbAeJFimJrxIbPNjOoi/D4KB/8cOr9PV1CvwX7VeQloNoDwkYNfqCby3h
 QR8K+kmYXlFN0keTTxu1FP/yuzoeUlbCBrGUDaWC6WOgRCvZSK6l1QoLoEMFmgGJAV
 NspguotlCgnjsYgbsgjYUAHcTgk0B5/KdR56rfFWTWhos+Yk5oANGnRRMtMyfAUB5z
 NqCyLbFT2hBoCwLkUIfdwL+BL90f09svnZjdBL8G2K0dcqMXhWnF6VkEN+jLCZxfqO
 KBzN9aTufz6JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] drm/amdkfd: Properly acquire queue
 buffers in CRIU restore
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-183-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-183-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:56:17 +0000
Message-Id: <20260831145617.CED4B1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Asymmetric SVM range refcounting leading to potential GPU Use-=
After-Free via SDMA queues.
- [High] The gang_ctx_bo and wptr_bo_gart allocations in init_user_queue() =
are leaked when pqm_create_queue() fails during dev->dqm->ops.create_queue(=
).
--

commit d34532449fcac18c405929eee012b2621c7a7eec
Author: David Francis <David.Francis@amd.com>

drm/amdkfd: Properly acquire queue buffers in CRIU restore

When kfd_queue_acquire_buffers() was split off from
set_queue_properties_from_user(), set_queue_properties_from_criu()
was missed. Thus, set_queue_properties_from_criu() is not
filling out the buffer fields of queue_properties, which
can come up when subsequent code expects them to be non-null.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 7fbb5c274ccc4..b32bd79e0d41f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
[ ... ]
> @@ -1053,10 +1053,18 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>  	memset(&qp, 0, sizeof(qp));
>  	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx=
.xcc_mask));
> =20
> +	ret =3D kfd_queue_acquire_buffers(pdd, &qp);

[Severity: Critical]
This is a pre-existing issue, but does the SVM range refcounting asymmetry =
in
kfd_queue_acquire_buffers() and kfd_queue_release_buffers() lead to a
potential use-after-free for SDMA queues?

If a local user creates a COMPUTE queue using an SVM range as the CWSR area,
it increments the queue_refcount. If the user then creates an SDMA queue
passing the same SVM range address, kfd_queue_acquire_buffers() skips
kfd_queue_buffer_svm_get() because it's not a compute queue:

drivers/gpu/drm/amd/amdkfd/kfd_queue.c:kfd_queue_acquire_buffers() {
    ...
    /* only compute queue requires EOP buffer and CWSR area */
    if (properties->type !=3D KFD_QUEUE_TYPE_COMPUTE)
        goto out_unreserve;
    ...
}

However, when the SDMA queue is destroyed, kfd_queue_release_buffers()
unconditionally drops the refcount:

drivers/gpu/drm/amd/amdkfd/kfd_queue.c:kfd_queue_release_buffers() {
    ...
    kfd_queue_buffer_svm_put(pdd,
                             properties->ctx_save_restore_area_address,
                             total_cwsr_size);
    return 0;
}

When the memory is unmapped, svm_range_unmap_from_gpus() will see a refcount
of 0 and skip quiescing the COMPUTE queue, potentially allowing it to conti=
nue
writing to physical pages after they are returned to the OS.

> +	if (ret) {
> +		pr_debug("failed to acquire user queue buffers for CRIU\n");
> +		goto exit;
> +	}
> +
>  	print_queue_properties(&qp);
> =20
>  	ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd=
, ctl_stack, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does pqm_create_queue() leak
the gang_ctx_bo and wptr_bo_gart allocations if dev->dqm->ops.create_queue()
fails?

In the error handling path:

drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c:pqm_create_queue() {
    ...
err_create_queue:
    uninit_queue(q);
    if (kq)
        kernel_queue_uninit(kq);
    kfree(pqn);
    ...
}

The err_create_queue path calls uninit_queue(q), which kfrees the queue
structure, but it fails to call pqm_clean_queue_resource(). This leaks the
GTT allocations made earlier in init_user_queue(). A local user could
repeatedly exhaust the queue limit to trigger this error path and cause a G=
TT
memory leak.

>  	if (ret) {
> +		kfd_queue_unref_bo_vas(pdd, &qp);
> +		kfd_queue_release_buffers(pdd, &qp);
>  		pr_err("Failed to create new queue err:%d\n", ret);
>  		goto exit;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-183-sashal@kernel.org?part=3D1
