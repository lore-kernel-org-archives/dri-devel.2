Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96730606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbeo6X+a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54B410E76C;
	Sun,  8 Nov 2026 05:43:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C0510E76C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:43:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9DED413CB;
 Sun,  8 Nov 2026 05:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505B71F0089F;
 Sun,  8 Nov 2026 05:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794116623;
 bh=B5uSPgp6C3w7tYT5AapiwY7CIm7uyt7qCIB+A9vHHBE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mbeo6X+aPZsnmOkRiH9j3wfP1+wiQQ5WY3I102ReiEfBU+ZSEscrRB7xsGfz1Ak/d
 xzs3sd6rU3/jO1ZAdby6WMIdKztwwkDHrnRcehRuh3EW64zenLZITdcYOi9JVxixUO
 klzvQSJAyc1SwZ9vAUmUZ3MSptkg7JxpQO3mq3KIY91CA2UrbdhH+KROoY0Vo/4Yo7
 Xo797cHwoipet+9w9ufE+PXhierzKZAhDLPScHMXyPrLTieMMI/ePZ41Fgez8SJGU5
 86ywzlrUEISAm3lwmiic2kT+fXHbKZ9fP3hFOZPtS5bulab1epuhJr9Lct+oYUc0qv
 8s8nbWYPmFOag==
Message-ID: <sashiko-outbox-203590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] drm/imagination: Add VM_BIND ioctl
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261108-pvr-vm-bind-v2-4-730103d2cc9a@gmail.com>
References: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
 <20261108-pvr-vm-bind-v2-4-730103d2cc9a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 05:43:42 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Critical] drm/imagination: UAF on page tables in pvr_vm_bind() after
  unlock
--

commit d5bbe10d571fc12d872392309205546a1d09b850
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Add VM_BIND ioctl

This commit adds the DRM_IOCTL_PVR_VM_BIND ioctl to apply a batch of map and
unmap operations to a VM context, and bumps the driver minor version to 2.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 2d522a8e46ad6..8203d5f081d5d 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1135,6 +1135,168 @@ pvr_ioctl_vm_unmap(struct drm_device *drm_dev, vo=
id *raw_args,
[ ... ]
> +static int
> +pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
> +		  struct drm_file *file)
> +{
[ ... ]
> +	descs =3D pvr_vm_bind_descs_from_uapi(pvr_file, uapi_ops, args->ops.cou=
nt);
> +	kvfree(uapi_ops);
> +	if (IS_ERR(descs)) {
> +		err =3D PTR_ERR(descs);
> +		goto err_put_vm_context;
> +	}
> +
> +	err =3D pvr_vm_bind(vm_ctx, descs, args->ops.count);

[Severity: Critical]
Can concurrent VM operations on the same vm_ctx cause a use-after-free on
op_ctx->curr_page.l0_table and l1_table in pvr_vm_bind()?

drivers/gpu/drm/imagination/pvr_vm.c:pvr_vm_bind() {
	...
	mutex_lock(&vm_ctx->lock);

	for (u32 i =3D 0; !err && i < desc_count; i++)
		err =3D pvr_vm_bind_op_exec(&bind_ops[i]);

	mutex_unlock(&vm_ctx->lock);

	pvr_vm_bind_ops_free(bind_ops, desc_count);
	...
}

pvr_vm_bind_op_exec() caches raw pointers to L0 and L1 page tables in
op_ctx->curr_page.l0_table and l1_table and defers the final DMA sync until
pvr_vm_bind_ops_free() -> pvr_vm_bind_op_fini() ->
pvr_mmu_op_context_destroy() -> pvr_mmu_op_context_sync(), which runs after
vm_ctx->lock has been dropped:

CPU0                                  CPU1
pvr_ioctl_vm_bind()
  pvr_vm_bind()
    mutex_lock(&vm_ctx->lock)
    pvr_vm_bind_op_exec()
      ...
      op_ctx->curr_page.l0_table =3D ...
    mutex_unlock(&vm_ctx->lock)
                                      pvr_ioctl_vm_bind() / pvr_ioctl_vm_un=
map()
                                        pvr_vm_bind()
                                          mutex_lock(&vm_ctx->lock)
                                          pvr_vm_bind_op_exec()
                                            ...
                                            pvr_page_table_l1_remove()
                                          mutex_unlock(&vm_ctx->lock)
                                          pvr_vm_bind_ops_free()
                                            ...
                                            pvr_page_table_l0_free()
    pvr_vm_bind_ops_free()
      ...
      pvr_mmu_op_context_sync_manual()
        pvr_page_table_l0_sync(op_ctx->curr_page.l0_table)
          <-- use-after-free

Once CPU0 drops vm_ctx->lock, CPU1 can unmap the remaining entries in those
page tables and free them before CPU0 runs pvr_mmu_op_context_sync_manual(),
causing CPU0 to dereference freed page table structs and sync unmapped back=
ing
pages.

A later patch in this series, commit "drm/imagination: Add asynchronous
VM_BIND", calls pvr_mmu_op_context_sync() and pvr_mmu_flush_exec() under
vm_ctx->lock in pvr_vm_bind_run_job(), but synchronous pvr_vm_bind() still
leaves them outside the lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-pvr-vm-bin=
d-v2-0-730103d2cc9a@gmail.com?part=3D4
