Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3909AC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8CD10E762;
	Thu, 16 Jul 2026 10:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dytyv42U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9858F10E762
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC1636001A;
 Thu, 16 Jul 2026 10:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9A1F000E9;
 Thu, 16 Jul 2026 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784196694;
 bh=35OsHtqv4vUsAMsKep20Tt6rdgZDUPGbCnuG2pt//N8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dytyv42Uly3/rHyWnDX+eNf2eM/8cjDEsSBzwpqn/C2DzRYd38cExaRVBSaPuAYwH
 1Mh3T2MYVetyvT64BhucLzGx5N6uZBfI0um/AaedDgH9OxfteV8eQAeQ28WK9wi5le
 xae7D4/YzF62ZBr/0+8OlkCKj3Wo8t8Js91T+AnmmRhfSYHokEs5ty2dslcx5vFueV
 LOA6U3Tapk1gxzUHC43doAFI0z8ESV9/ry0dgl90XP37FRcZT2QLGm2aQW1mhtT1Ce
 Lgtp9lWLgm4wwSLy9Vfl7a0XNxtqVpPVebY7XEpfWtKv65jgB0UPVOLh7vGmRmxGzb
 pKsq3F6iXsKzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716095847.479-1-jianping.li@oss.qualcomm.com>
References: <20260716095847.479-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 10:11:33 +0000
Message-Id: <20260716101134.70B9A1F000E9@smtp.kernel.org>
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
- [Critical] Unconditional dereference of `cctx->remote_heap` causes a kern=
el panic when `FASTRPC_IOCTL_INIT_CREATE_STATIC` is invoked on non-ADSP dom=
ains or concurrently with device removal.
- [High] Missing rollback of hypervisor SCM memory assignment in the `fastr=
pc_rpmsg_probe` error path permanently leaks HLOS memory access permissions.
- [High] Mandating the `memory-region` property for the ADSP domain breaks =
backward compatibility with older Device Trees.
- [High] Probe unconditionally calls qcom_scm_assign_mem with a potentially=
 zero vmcount, which may cause probe failures or unrecoverable permission d=
rops.
- [High] Concurrent static process creations can leave the DSP process init=
ialized without a remote heap due to a race condition.

Pre-existing issues:
- [High] Memory access permissions assigned away from HLOS for the SDSP dom=
ain are never restored during teardown.
--

--- Patch [1]: [PATCH v10] misc: fastrpc: Allocate entire reserved memory f=
or Audio PD in probe ---
commit d3151c13cc6203a8d9909ed1502893583ed1fe94
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: Allocate entire reserved memory for Audio PD in probe
   =20
This commit shifts the allocation of the entire Audio PD reserved-memory
region to the rpmsg probe phase and ties its lifetime to the rpmsg channel.
This aims to prevent memory leaks from unbounded userspace heap requests and
ensures proper memory reclamation.
   =20
Link: https://lore.kernel.org/all/20260707061733.495-1-jianping.li@oss.qual=
comm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c681..03f633028c007 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1391,8 +1391,25 @@ static int fastrpc_init_create_static_process(stru=
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
> +		pages[0].addr =3D cctx->remote_heap->dma_addr;
> +		pages[0].size =3D cctx->remote_heap->size;
> +		cctx->audio_init_mem =3D true;
> +		inbuf.pageslen =3D 1;
> +		sent_heap =3D true;

[Severity: Critical]
Does this unconditional dereference of cctx->remote_heap cause a NULL point=
er
dereference for non-ADSP domains?

Looking at fastrpc_rpmsg_probe(), remote_heap is only allocated for the
ADSP_DOMAIN_ID. If a user with access to a non-ADSP fastrpc device node
(like /dev/fastrpc-cdsp) invokes the FASTRPC_IOCTL_INIT_CREATE_STATIC ioctl,
cctx->remote_heap will be NULL.

Additionally, could a concurrent device removal free cctx->remote_heap and
set it to NULL while this ioctl is executing, leading to a use-after-free
or NULL pointer dereference?

[Severity: High]
Can concurrent static process creations leave the DSP process initialized
without a remote heap due to a race condition?

If two threads call this ioctl concurrently, Thread A might set
cctx->audio_init_mem to true and proceed with the heap address. Thread B
would see the flag as true and proceed with a zeroed address.

If Thread A's remote invocation fails and it rolls back cctx->audio_init_mem
to false in the err_invoke path below, Thread B's invocation may have alrea=
dy
succeeded on the DSP without providing the required heap memory.

> +	} else {
> +		pages[0].addr =3D 0;
> +		pages[0].size =3D 0;
> +	}
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> =20
>  	args[2].ptr =3D (u64)(uintptr_t) pages;
>  	args[2].length =3D sizeof(*pages);

[ ... ]

> @@ -1427,27 +1427,11 @@ static int fastrpc_init_create_static_process(str=
uct fastrpc_user *fl,
> =20
>  	return 0;
>  err_invoke:
> -	if (fl->cctx->vmcount && scm_done) {

[ ... ]

> +	if (sent_heap) {
> +		spin_lock_irqsave(&cctx->lock, flags);
> +		cctx->audio_init_mem =3D false;
> +		spin_unlock_irqrestore(&cctx->lock, flags);
>  	}
> -err_map:
> -	fastrpc_buf_free(fl->cctx->remote_heap);
> -	fl->cctx->remote_heap =3D NULL;
> -err_name:
>  	kfree(name);
>  err:
>  	kfree(args);

[ ... ]

> @@ -2418,12 +2398,29 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
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
> +

[Severity: High]
Does mandating the memory-region property for the ADSP domain break
backward compatibility with older device trees?

Previously, if a device tree did not specify a reserved memory region for
ADSP, the driver dynamically allocated the remote heap. By explicitly faili=
ng
the probe when of_reserved_mem_region_to_resource() fails for ADSP_DOMAIN_I=
D,
older device trees might now fail to probe.

>  		if (!err) {
> +			if (domain_id =3D=3D ADSP_DOMAIN_ID) {
> +				data->remote_heap =3D
> +					kzalloc_obj(*data->remote_heap);
> +				if (!data->remote_heap) {
> +					err =3D -ENOMEM;
> +					goto err_free_data;
> +				}
> +
> +				data->remote_heap->dma_addr =3D res.start;
> +				data->remote_heap->size =3D resource_size(&res);
> +			}
>  			src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> =20
>  			err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perm=
s,
>  				    data->vmperms, data->vmcount);

[Severity: High]
Is it safe to call qcom_scm_assign_mem() unconditionally here without
verifying if data->vmcount is greater than zero?

If the qcom,vmids property is omitted in the device tree, vmcount will be 0.
Calling qcom_scm_assign_mem() with 0 destinations might cause a hypervisor
error or silently drop permissions. In the previous implementation, this
was guarded by checking if fl->cctx->vmcount was non-zero.

>  			if (err)
>  				goto err_free_data;
>  		}

[ ... ]

> @@ -2490,6 +2486,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		misc_deregister(&data->secure_fdevice->miscdev);
> =20
>  err_free_data:
> +	kfree(data->remote_heap);
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
Does the err_free_data path leak HLOS memory access permissions?

If qcom_scm_assign_mem() successfully transfers memory permissions to the D=
SP
during fastrpc_rpmsg_probe(), but a subsequent step fails, the code jumps
to err_free_data. The error path frees the allocated memory structures but
appears to miss calling qcom_scm_assign_mem() to revert the permissions back
to HLOS.

[ ... ]

> @@ -2529,8 +2527,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_devi=
ce *rpdev)
>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>  		list_del(&buf->node);
> =20
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> +	if (cctx->remote_heap && cctx->vmcount) {
> +		u64 src_perms =3D 0;
> +		struct qcom_scm_vmperm dst_perms;

[Severity: High]
This is a pre-existing issue, but does the cleanup path skip restoring
memory access permissions for the SDSP domain?

During fastrpc_rpmsg_probe(), memory access permissions are transferred to
the DSP for both SDSP_DOMAIN_ID and ADSP_DOMAIN_ID.

However, during teardown here, the permission restoration is explicitly
guarded by checking if cctx->remote_heap is populated. Since remote_heap
is only allocated for ADSP, it remains NULL for SDSP, skipping the
restoration logic entirely and potentially leaking the permissions.

> +
> +		for (i =3D 0; i < cctx->vmcount; i++)
> +			src_perms |=3D BIT(cctx->vmperms[i].vmid);
> +
> +		dst_perms.vmid =3D QCOM_SCM_VMID_HLOS;
> +		dst_perms.perm =3D QCOM_SCM_PERM_RWX;
> +
> +		err =3D qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
> +					  cctx->remote_heap->size, &src_perms,
> +					  &dst_perms, 1);
> +		if (err)
> +			dev_err(&rpdev->dev,
> +				"Failed to assign memory back to HLOS: dma_addr %pad size %#llx err =
%d\n",
> +				&cctx->remote_heap->dma_addr, cctx->remote_heap->size, err);
> +	}
> +
> +	kfree(cctx->remote_heap);
> +	cctx->remote_heap =3D NULL;
> =20
>  	of_platform_depopulate(&rpdev->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716095847.479-=
1-jianping.li@oss.qualcomm.com?part=3D1
