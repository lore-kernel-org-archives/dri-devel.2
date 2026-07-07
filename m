Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08318C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062FD10E444;
	Tue,  7 Jul 2026 06:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mu8lIpGz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7FE10E444
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 06:47:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E56F601DE;
 Tue,  7 Jul 2026 06:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DB51F000E9;
 Tue,  7 Jul 2026 06:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783406841;
 bh=c1DczCYwPlQ80/vplN4XRzpU9W+KIn0ip/iIG2A9uzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mu8lIpGzSJ15RGCkqc8OlWFYA0xKQgKiq1bgnqPXyJNneW62i6FfNUOaSsq6/k0+l
 Hx9yGpOw52WX0Jfc/5v1Y3VmeHKBqfvHPTic4Hf3AAeRFOyGFzcZaBIkeGU74Jt1u1
 DHXjnwEIT5EU4TgRCT5C8VWMb4TFIlMxgR1QPI5FKtHg6mZJYRP2k7pPExVEy0xSo2
 aHJ2lNUm4EbxopNVroicCTG0q6gT78bmrdmV/ZHON9Q3XonKqYs9ulZIt4K4kr2kDM
 UVISGemGHfyS+Jb2QNwiBc4sdWJds7YQPpaBTwI6iuOmaA0m4EE4SFjDPSkPnPfcVv
 hzLxVONklnbow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
References: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 06:47:20 +0000
Message-Id: <20260707064721.01DB51F000E9@smtp.kernel.org>
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
- [High] Race condition and logic flaw in clearing `cctx->audio_init_mem` a=
llows unsafe double-initialization of the DSP heap.
- [High] Concurrent execution of `FASTRPC_IOCTL_INIT_CREATE_STATIC` and `fa=
strpc_rpmsg_remove` causes Use-After-Free on `cctx->remote_heap`.

Pre-existing issues:
- [High] Permanent SCM memory leak from HLOS on probe error path.
- [High] SDSP domain SCM memory leak on driver unbind due to missing `cctx-=
>remote_heap` allocation.
- [High] Memory assigned via `ADSP_MMAP_REMOTE_HEAP_ADDR` is freed without =
restoring HLOS ownership.
- [High] Misc device is registered and exposed to userspace before its chan=
nel context is fully initialized.
--

--- Patch [1]: [PATCH v9] misc: fastrpc: Allocate entire reserved memory fo=
r Audio PD in probe ---
commit a011acdb04cd3c4edb5a740628e2c5ac611ab957
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: Allocate entire reserved memory for Audio PD in probe
   =20
Allocating and freeing Audio PD memory from userspace is unsafe because
the kernel cannot reliably determine when the DSP has finished using the
memory. This allocates the entire Audio PD reserved-memory region during
rpmsg probe and ties its lifetime to the rpmsg channel.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c681..1ec37e6c68a28 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1344,15 +1346,24 @@ static int fastrpc_init_create_static_process(str=
uct fastrpc_user *fl,
>  	struct fastrpc_init_create_static init;
>  	struct fastrpc_invoke_args *args;
>  	struct fastrpc_phy_page pages[1];
> +	struct fastrpc_channel_ctx *cctx =3D fl->cctx;
>  	char *name;
>  	int err;
>  	struct {
>  		int client_id;
>  		u32 namelen;
>  		u32 pageslen;
>  	} inbuf;
>  	u32 sc;
> +	unsigned long flags;
> +
> +	if (!cctx->remote_heap || !cctx->remote_heap->dma_addr ||
> +	    !cctx->remote_heap->size) {

[Severity: High]
Can this code race with fastrpc_rpmsg_remove()?

If the rpmsg channel is removed via driver unbind or DSP crash,
fastrpc_rpmsg_remove() frees cctx->remote_heap.=20

Since these pointers are dereferenced here without taking cctx->lock, could
this lead to a use-after-free if FASTRPC_IOCTL_INIT_CREATE_STATIC is called
concurrently?

> +		err =3D -ENOMEM;
> +		dev_err(fl->sctx->dev,
> +			"remote heap memory region is not added\n");
> +		return err;
> +	}
> =20
>  	args =3D kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);

[ ... ]

>  	return 0;
>  err_invoke:
> +	cctx->audio_init_mem =3D false;

[Severity: High]
Does this code unconditionally clear the initialization flag on any failure?

If fastrpc_internal_invoke() fails for any caller (like a timeout or bad
argument), this sets cctx->audio_init_mem to false without checking if the
current caller was the one that successfully set it to true.

Could this allow a subsequent caller to re-send the heap coordinates, leadi=
ng
to an unsafe double-initialization of the DSP heap?

>  	kfree(name);
>  err:

[ ... ]

> @@ -2418,12 +2400,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
>  		}
>  	}
> =20
> -	if (domain_id =3D=3D SDSP_DOMAIN_ID) {
> +	if (domain_id =3D=3D SDSP_DOMAIN_ID || domain_id =3D=3D ADSP_DOMAIN_ID)=
 {
>  		struct resource res;
>  		u64 src_perms;
> =20
>  		err =3D of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>  		if (!err) {
> +			if (domain_id =3D=3D ADSP_DOMAIN_ID) {
> +				data->remote_heap =3D
> +					kzalloc_obj(*data->remote_heap, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does this allocation strictly for ADSP
cause an SDSP memory leak?

Later in fastrpc_rpmsg_remove(), the newly added HLOS unassignment logic is
guarded by:

    if (cctx->remote_heap && cctx->vmcount)

Since data->remote_heap is never allocated for SDSP, it will be NULL and
the SCM unassignment will be silently skipped, permanently leaking the SDSP
reserved memory to the DSP on unbind.

> +				if (!data->remote_heap) {
> +					err =3D -ENOMEM;
> +					goto err_free_data;
> +				}
> +
> +				data->remote_heap->dma_addr =3D res.start;
> +				data->remote_heap->size =3D resource_size(&res);
> +			}
>  			src_perms =3D BIT(QCOM_SCM_VMID_HLOS);

[ ... ]

> @@ -2490,6 +2482,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		misc_deregister(&data->secure_fdevice->miscdev);
> =20
>  err_free_data:
> +	kfree(data->remote_heap);
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak
TrustZone memory?

If a subsequent step in fastrpc_rpmsg_probe() fails (such as
fastrpc_device_register() or of_platform_populate()), the code jumps here
to free the structures.

However, qcom_scm_assign_mem() was already called to transfer ownership to
the DSP VMIDs, and there is no reverse call here to restore memory ownership
back to HLOS.

[Severity: High]
This is a pre-existing issue, but does fastrpc_rpmsg_probe() expose the
misc device before initialization is complete?

Looking at fastrpc_rpmsg_probe():

    err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
    [ ... ]
    kref_init(&data->refcount);
    [ ... ]
    INIT_LIST_HEAD(&data->users);
    [ ... ]
    spin_lock_init(&data->lock);
    idr_init(&data->ctx_idr);

fastrpc_device_register() makes the file node instantly visible to userspac=
e.
If a user process opens it immediately, could it access uninitialized
data structures like data->lock or data->users in fastrpc_device_open()?

[Severity: High]
This is a pre-existing issue, but does fastrpc_req_munmap_impl() return mem=
ory
to the kernel allocator while it is still owned by TrustZone?

When fastrpc_req_mmap() handles ADSP_MMAP_REMOTE_HEAP_ADDR, it assigns the
memory to the DSP:

    err =3D qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
        &src_perms, fl->cctx->vmperms, fl->cctx->vmcount);

However, the unmap path in fastrpc_req_munmap_impl() calls
fastrpc_buf_free() which runs dma_free_coherent(). It doesn't appear to
invoke qcom_scm_assign_mem() to revert permissions back to HLOS before
freeing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707061733.495-=
1-jianping.li@oss.qualcomm.com?part=3D1
