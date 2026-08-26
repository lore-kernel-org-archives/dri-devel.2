Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC548C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC0010E1D4;
	Wed, 26 Aug 2026 03:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c0jyMwU5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D9510E1D4
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 03:50:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBE0843621;
 Wed, 26 Aug 2026 03:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E81F1F000E9;
 Wed, 26 Aug 2026 03:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787716234;
 bh=4fOz3U/zoNdV1rpFlljBj7IVSTFLKZSttztBx0zZwjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c0jyMwU5ops5HYjkUZar9R5P0fswUloplGul66cCyDH+ul3WGdnLieG4gTyws2Niq
 ybloV/zqk8Wh98apaahT+N7kVF0Vnm25bIA5g5AtnCHgrePYB4PXM0jifM+LPVIPU3
 90ZqnAWSqpOxGoM9loB0fEegvsv1mM7G+JC0S57n0CKJ/ENW0eCXbxaWt7IAHIDJQj
 RZnM9cGvHuf2uFBc2heymYhPWEfBleL0TIuMIq7MHc8smXEo0POj4RX2XAIbhc9CH3
 78HW4o6V6BqD1W489HU7pX66TWwGCgHSLeYOwbq44UuR/BSu7Gthq2hzQStsTDWpXl
 YlWh+eg7teg6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
References: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 03:50:34 +0000
Message-Id: <20260826035034.7E81F1F000E9@smtp.kernel.org>
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
- [Critical] Assigning the entire ADSP reserved memory to the DSP at probe =
time revokes HLOS access, causing a hypervisor memory protection fault (cra=
sh) or memory corruption when allocating and accessing invocation buffers.
- [High] If `fastrpc_rpmsg_probe()` fails after `fastrpc_init_reserved_mem(=
)` successfully assigns memory to the DSP, the error path fails to restore =
the TrustZone memory ownership to HLOS, permanently leaking the physical me=
mory.
- [Medium] Optimistic update of `cctx->audio_init_mem` leads to race condit=
ions and spurious failures for concurrent userspace callers.

Pre-existing issues:
- [High] The SDSP reserved memory assigned to the DSP during probe is never=
 unassigned back to HLOS during driver removal, permanently leaking the mem=
ory region.
- [High] If `copy_to_user()` fails in `fastrpc_req_mmap()`, the allocated b=
uffer is freed but left dangling in the `fl->mmaps` list, leading to a Use-=
After-Free.
- [High] The fastrpc misc device is registered and exposed to userspace bef=
ore its channel context locks and lists are initialized.
--

commit dae50ab7f799dede3c8a11c6a7a4fc6ab94ff1b7
Author: Jianping Li <jianping.li@oss.qualcomm.com>
Subject: misc: fastrpc: Allocate entire reserved memory for Audio PD in pro=
be

This patch modifies the fastrpc driver to allocate the entire Audio PD
reserved-memory region during the rpmsg probe instead of allowing userspace
to control it. It aims to prevent unbounded memory usage and memory leaks
by tying the region's lifetime to the rpmsg channel. The region is now
validated during static process creation rather than failing the probe if
it is missing.

Link: https://lore.kernel.org/all/20260814101955.234238-1-jianping.li@oss.q=
ualcomm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca867..af733997775d4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -1522,8 +1508,25 @@ static int fastrpc_init_create_static_process(stru=
ct fastrpc_user *fl,
>  	args[1].length =3D inbuf.namelen;
>  	args[1].fd =3D -1;
> =20
> -	pages[0].addr =3D fl->cctx->remote_heap->dma_addr;
> -	pages[0].size =3D fl->cctx->remote_heap->size;
> +	/*
> +	 * Audio PD is a static PD and retains the remote heap
> +	 * information across daemon restarts. Therefore only
> +	 * the first attach should provide heap information to
> +	 * DSP. Subsequent attaches reuse the previously
> +	 * initialized memory pool.
> +	 */
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	if (!cctx->audio_init_mem) {
> +		pages[0].addr =3D cctx->remote_heap_addr;
> +		pages[0].size =3D cctx->remote_heap_size;
> +		cctx->audio_init_mem =3D true;

[Severity: Medium]
Does optimistically setting cctx->audio_init_mem before the sleepable
fastrpc_internal_invoke() completes create a race condition?

If multiple threads concurrently call this function, secondary threads will
observe audio_init_mem =3D=3D true and send an INIT_CREATE_STATIC request w=
ithout
the required heap information. If the first thread fails in its invoke and =
rolls
back the flag in err_invoke, the secondary threads' requests will execute i=
n a
malformed state.

> +		inbuf.pageslen =3D 1;
> +		sent_heap =3D true;
> +	} else {
> +		pages[0].addr =3D 0;
> +		pages[0].size =3D 0;
> +	}
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> =20
>  	args[2].ptr =3D (u64)(uintptr_t) pages;
>  	args[2].length =3D sizeof(*pages);
[ ... ]
> @@ -2139,20 +2123,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *f=
l, char __user *argp)
>  	/* let the client know the address to use */
>  	req.vaddrout =3D rsp_msg.vaddr;
> =20
> -	/* Add memory to static PD pool, protection thru hypervisor */
> -	if (req.flags =3D=3D ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
> -		u64 src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> -
> -		err =3D qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
> -			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
> -		if (err) {
> -			dev_err(fl->sctx->dev,
> -				"Failed to assign memory dma_addr %pad size 0x%llx err %d",
> -				&buf->dma_addr, buf->size, err);
> -			goto err_assign;
> -		}
> -	}
> -
>  	spin_lock(&fl->lock);
>  	list_add_tail(&buf->node, &fl->mmaps);
>  	spin_unlock(&fl->lock);

[Severity: High]
This is a pre-existing issue, but does the cleanup path for this function
leave a dangling pointer in the fl->mmaps list?

If the subsequent copy_to_user() fails:

	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
		err =3D -EFAULT;
		goto err_assign;
	}

The code jumps to err_assign and calls fastrpc_req_munmap_impl(), which
frees the buffer via fastrpc_buf_free() but fails to remove the node from
the fl->mmaps list. This could lead to a double-free or use-after-free when
the user closes the file descriptor and fastrpc_user_free() iterates over
fl->mmaps.

[ ... ]
> @@ -2533,6 +2503,45 @@ static const struct of_device_id fastrpc_poll_supp=
orted_machines[] __maybe_unuse
>  	{},
>  };
> =20
> +static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
> +				     struct device *rdev, u32 domain_id)
> +{
> +	struct resource res;
> +	u64 src_perms;
> +	int err;
> +
> +	/* Only SDSP and ADSP domains use a reserved remote heap region */
> +	if (domain_id !=3D SDSP_DOMAIN_ID && domain_id !=3D ADSP_DOMAIN_ID)
> +		return 0;
> +
> +	err =3D of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
> +	if (err) {
> +		/*
> +		 * The reserved-memory region is optional at probe time. For
> +		 * the Audio PD (ADSP) domain its absence is validated later in
> +		 * fastrpc_init_create_static_process(), so keep probing here.
> +		 */
> +		return 0;
> +	}
> +
> +	/*
> +	 * Audio PD (ADSP) is a static PD: cache the region so its lifetime
> +	 * is tied to the rpmsg channel instead of being controlled by
> +	 * userspace.
> +	 */
> +	if (domain_id =3D=3D ADSP_DOMAIN_ID) {
> +		cctx->remote_heap_addr =3D res.start;
> +		cctx->remote_heap_size =3D resource_size(&res);
> +	}

[Severity: High]
This is a pre-existing issue, but by only saving the region details for the
ADSP domain, is the SDSP reserved memory leaked during driver removal?

In fastrpc_rpmsg_remove(), the cleanup logic uses cctx->remote_heap_size to
determine if unassignment is required:

	if (cctx->remote_heap_size && cctx->vmcount) {
		...
		err =3D qcom_scm_assign_mem(...);
	}

Since the size is strictly zero for SDSP, this bypasses the hypervisor
unassign for SDSP, permanently leaking the memory region.

> +
> +	if (!cctx->vmcount)
> +		return 0;
> +
> +	src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> +	return qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
> +				  cctx->vmperms, cctx->vmcount);

[Severity: Critical]
Does this assignment cause a hypervisor memory protection fault when alloca=
ting
invocation buffers?

In fastrpc_rpmsg_probe(), the reserved memory is bound to the rdev DMA pool:

	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");

Then here, the entire region is assigned to the DSP, stripping HLOS access.
When an RPC invocation occurs on a device without an SMMU (sid =3D=3D 0),
fastrpc_get_args() dynamically allocates the invocation payload buffer from
this same rdev DMA pool using fastrpc_remote_heap_alloc(), and the CPU atte=
mpts
to initialize it with memset(), which could trigger a hypervisor fault or
corrupt the DSP's remote heap.

> +}
> +
>  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  {
>  	struct device *rdev =3D &rpdev->dev;
> @@ -2580,21 +2589,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  		}
>  	}
> =20
> -	if (domain_id =3D=3D SDSP_DOMAIN_ID) {
> -		struct resource res;
> -		u64 src_perms;
> -
> -		err =3D of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
> -		if (!err) {
> -			src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> -
> -			err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perm=
s,
> -				    data->vmperms, data->vmcount);
> -			if (err)
> -				goto err_free_data;
> -		}
> -
> -	}
> +	err =3D fastrpc_init_reserved_mem(data, rdev, domain_id);
> +	if (err)
> +		goto err_free_data;

[Severity: High]
If a subsequent step in probe fails (for example, fastrpc_device_register()=
 or
of_platform_populate()), the error path err_free_data is taken. Because that
cleanup path lacks a reverse qcom_scm_assign_mem() call to restore the HLOS=
 VMID
ownership, does this permanently leak the physical memory and hypervisor st=
ate?

[Severity: High]
This is a pre-existing issue, but does fastrpc_rpmsg_probe() expose the misc
device to userspace before initializing its locks and lists?

fastrpc_device_register() calls misc_register(), exposing the device node to
userspace. Userspace can immediately open() the device, which calls
fastrpc_device_open(). This open function acquires cctx->lock and adds an
element to the cctx->users list. However, spin_lock_init(&data->lock) and
INIT_LIST_HEAD(&data->users) are executed later in the probe sequence. If
userspace opens the device in this race window, the kernel will access
uninitialized primitives.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826033803.475-=
1-jianping.li@oss.qualcomm.com?part=3D1
