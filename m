Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99711C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C0D10F1FA;
	Fri, 31 Jul 2026 09:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bSi4fVwA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFCF10F1F8
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:47:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BC5F40A29;
 Fri, 31 Jul 2026 09:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BA61F000E9;
 Fri, 31 Jul 2026 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785491268;
 bh=HObyskRyMuqGryHDxj5ocASlF7QchH+68/EQPbxu0GY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bSi4fVwAQVe2+XTOYl42Fyl3bTOllNc3VSeDA4G4lnpdxbAeCdqJp2G/7pyRRBjjv
 BkX1EYr8ptJnD5/Ue1dJfXwxeq+eW5dKk77rlXaBwCYyj0DB0jYGBjD0vQVheTGNg0
 TO3fsbXweXik4VPKin9YmEV5+Z5mNL4SSzfRE9Sj0JvXdaKVV0YhKKRtWjy8ZAH8Vq
 3rFFazJodJYw/43VXQN8vniPpkz+9oI9mJZJnCrLSkz9r5W6dYOEGC/v4mnsex/Jc7
 GAcBLYJiCKW7KjE9n/FPZXFy2pi7xcFW9noMtfFPdir3DPsG9mzamSv9Cp9M/t0Qp4
 7OgXR0Nvrhq0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731093210.473-1-jianping.li@oss.qualcomm.com>
References: <20260731093210.473-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:47:47 +0000
Message-Id: <20260731094748.32BA61F000E9@smtp.kernel.org>
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
- [High] DT ABI Breakage: Making the `memory-region` property mandatory for=
 the ADSP domain causes probe failures on older platforms.
- [High] Resource Leak: Memory permissions assigned to the DSP are not rest=
ored if `fastrpc_rpmsg_probe` fails, permanently locking the memory region.
- [High] API Contract Violation: `FASTRPC_INIT_CREATE_STATIC` fails for non=
-ADSP domains because it sends a zero-sized remote heap.
- [Medium] Race Condition: Optimistic state update of `audio_init_mem` lead=
s to spurious initialization failures on concurrent ioctls.

Pre-existing issues:
- [Critical] Use-After-Free: Kernel buffer use-after-free in `fastrpc_req_m=
map` on `copy_to_user` failure.
- [High] Resource Leak: SDSP reserved memory permissions are never restored=
 during driver unbind.
--

--- Patch [1]: [PATCH v11] misc: fastrpc: Allocate entire reserved memory f=
or Audio PD in probe ---
commit edbdcebbb8f20e74e19b3ab96b26e3c17ffcc94c
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: Allocate entire reserved memory for Audio PD in probe

Allocating and freeing Audio PD memory from userspace is unsafe because
the kernel cannot reliably determine when the DSP has finished using the
memory. This commit allocates the entire Audio PD reserved-memory region
during rpmsg probe and ties its lifetime to the rpmsg channel.

Patch [v10]: https://lore.kernel.org/all/20260716095847.479-1-jianping.li@o=
ss.qualcomm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index dd51d475a74e1..e054e80584a25 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1501,23 +1501,26 @@ static int fastrpc_init_create_static_process(str=
uct fastrpc_user *fl,
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

[Severity: High]
Since remote_heap_addr and remote_heap_size are only populated for the
ADSP domain during probe, won't this unconditionally send a zero-sized remo=
te
heap with pageslen =3D 1 for other static domains like CDSP, SDSP, and MDSP?

Could this break static process creation on non-ADSP domains?

> +		cctx->audio_init_mem =3D true;

[Severity: Medium]
If this thread is preempted before invoking the DSP, could a concurrent
invocation of fastrpc_init_create_static_process() see audio_init_mem as
true, send a 0-sized remote heap, and reach the DSP first, causing a spurio=
us
initialization failure?

> +		inbuf.pageslen =3D 1;
> +		sent_heap =3D true;
> +	} else {
> +		pages[0].addr =3D 0;
> +		pages[0].size =3D 0;
> +	}
> +	spin_unlock_irqrestore(&cctx->lock, flags);

[ ... ]

> @@ -2143,20 +2120,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *f=
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

[Severity: Critical]
This is a pre-existing issue, but if the subsequent copy_to_user() fails,
does jumping to err_assign and freeing buf via fastrpc_req_munmap_impl()
leave a freed pointer in the fl->mmaps list since list_del(&buf->node)
isn't called?

Could unprivileged userspace exploit this use-after-free by intentionally
causing a fault here?

[ ... ]

> @@ -2584,12 +2547,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
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
> +
> +		if (err && domain_id =3D=3D ADSP_DOMAIN_ID) {
> +			dev_err(rdev, "missing mandatory remote heap memory-region\n");
> +			goto err_free_data;
> +		}

[Severity: High]
Does making the memory-region property mandatory for the ADSP domain break
device tree ABI compatibility for older platforms that do not define this
property in their fastrpc node?

> +
>  		if (!err) {
> +			if (domain_id =3D=3D ADSP_DOMAIN_ID) {
> +				data->remote_heap_addr =3D res.start;
> +				data->remote_heap_size =3D resource_size(&res);
> +			}
>  			src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> =20
>  			err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perm=
s,
>  								data->vmperms, data->vmcount);
>  			if (err)
>  				goto err_free_data;
>  		}

[Severity: High]
If a subsequent step in fastrpc_rpmsg_probe() fails and the code jumps
to err_free_data, are the memory permissions assigned to the DSP by
qcom_scm_assign_mem() permanently leaked since HLOS access is never restored
in the error path?

[ ... ]

> @@ -2698,8 +2671,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_devi=
ce *rpdev)
>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>  		list_del(&buf->node);
> =20
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> +	if (cctx->remote_heap_size && cctx->vmcount) {
> +		u64 src_perms =3D 0;
> +		struct qcom_scm_vmperm dst_perms;
> +
> +		for (i =3D 0; i < cctx->vmcount; i++)
> +			src_perms |=3D BIT(cctx->vmperms[i].vmid);
> +
> +		dst_perms.vmid =3D QCOM_SCM_VMID_HLOS;
> +		dst_perms.perm =3D QCOM_SCM_PERM_RWX;
> +
> +		err =3D qcom_scm_assign_mem(cctx->remote_heap_addr,
> +					  cctx->remote_heap_size, &src_perms,
> +					  &dst_perms, 1);

[Severity: High]
This is a pre-existing issue, but since remote_heap_size is only populated
for the ADSP domain, does this skip the restore step for the SDSP domain?

Could this lead to a permanent leak of the SDSP reserved memory region in
TrustZone when the driver is unbound?

> +		if (err)
> +			dev_err(&rpdev->dev,
> +				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
> +				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
> +	}
> =20
>  	of_platform_depopulate(&rpdev->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731093210.473-=
1-jianping.li@oss.qualcomm.com?part=3D1
