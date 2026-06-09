Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96E2CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B9E10E069;
	Tue,  9 Jun 2026 03:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jdnsDVuP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3D210E069
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 03:16:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4B4C601E1;
 Tue,  9 Jun 2026 03:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46771F00893;
 Tue,  9 Jun 2026 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780974959;
 bh=6Fyv2AkughcFlPb3QtmxiD6Ld+02RwgYu7ptjQIY8/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jdnsDVuPocjfAC63CfTtiumjWNv1pF7bH+MCyktv2Ldr+mnyGTmjpyOPMWvYHLUMQ
 Sod1qvvAg5eK+SbDVetLsp76ETUmbDJ47capAgcvfsxThRJ79n95AP1OE9U4xiqYmV
 rBQaURS68YnKWSrLsi4UUYpf7LLfZUAHbzgsCAyQxq9K6zmZFKe3VuJEa5Be8ageN5
 cEgOPB1jL460OIHlOtPsJN2W1ToCqDiV2GN1YjkJD7LmPwztP2MGHdkxzxWWLP5n/n
 eIGl/J9OXiMisxu+BNeLiNr5W64eey8495C67+KWuHNLDi2Jtjr1N5aM/nx9nT4xcS
 /AxuDCa5bcunA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] misc: fastrpc: Allocate entire reserved memory
 for Audio PD in probe
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609025938.457-4-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-4-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:15:58 +0000
Message-Id: <20260609031558.D46771F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Unconditional call to `qcom_scm_assign_mem` during probe can resul=
t in an invalid TrustZone call or memory lockout if `data->vmcount` is 0.
- [High] Unconditional and lockless clearance of `cctx->audio_init_mem` on =
the static process error path corrupts initialization synchronization.
- [High] Removal of the dynamic heap fallback breaks Audio PD on older Devi=
ce Trees.
- [High] Missing rollback of `qcom_scm_assign_mem` on probe failure permane=
ntly locks out SCM memory.

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race condition leading to a =
NULL pointer dereference of `cctx->remote_heap`.
--

commit 780b6a562518105022f75b2b13f38c9dbad812e3
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: Allocate entire reserved memory for Audio PD in probe

This patch changes the Audio PD memory allocation to use the entire
reserved-memory region during rpmsg probe, tying its lifetime to the rpmsg
channel. It also adds explicit validation for the remote heap before sending
memory to the DSP.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 517884000331b..1942e74535e52 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1341,15 +1343,24 @@ static int fastrpc_init_create_static_process(str=
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
> +		err =3D -ENOMEM;
> +		dev_err(fl->sctx->dev,
> +			"remote heap memory region is not added\n");
> +		return err;
> +	}

[Severity: High]
Does the removal of the dynamic heap fallback break backwards compatibility?

In the original code, if the device tree lacked a memory-region, the heap w=
as
dynamically allocated via fastrpc_remote_heap_alloc(). Now, platforms with
older device trees will see FASTRPC_IOCTL_INIT_CREATE_STATIC fail with
-ENOMEM.

[ ... ]

> @@ -1409,8 +1395,17 @@ static int fastrpc_init_create_static_process(stru=
ct fastrpc_user *fl,
>  	args[1].length =3D inbuf.namelen;
>  	args[1].fd =3D -1;
> =20
> -	pages[0].addr =3D fl->cctx->remote_heap->dma_addr;
> -	pages[0].size =3D fl->cctx->remote_heap->size;
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	if (!cctx->audio_init_mem) {
> +		pages[0].addr =3D cctx->remote_heap->dma_addr;
> +		pages[0].size =3D cctx->remote_heap->size;

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer
dereference?

In fastrpc_init_create_static_process(), cctx->remote_heap is checked
locklessly at the start of the function. If a concurrent
fastrpc_rpmsg_remove() executes during a sleeping operation like
copy_from_user():

CPU1
fastrpc_rpmsg_remove()
    ...
    kfree(cctx->remote_heap);
    cctx->remote_heap =3D NULL;

Will CPU2's unconditional dereference of cctx->remote_heap->dma_addr inside
cctx->lock cause a kernel panic?

> +		cctx->audio_init_mem =3D true;
> +		inbuf.pageslen =3D 1;
> +	} else {
> +		pages[0].addr =3D 0;
> +		pages[0].size =3D 0;
> +	}
> +	spin_unlock_irqrestore(&cctx->lock, flags);

[ ... ]

> @@ -1428,27 +1423,7 @@ static int fastrpc_init_create_static_process(stru=
ct fastrpc_user *fl,
> =20
>  	return 0;
>  err_invoke:
> -	if (fl->cctx->vmcount && scm_done) {
> -		u64 src_perms =3D 0;
> -		struct qcom_scm_vmperm dst_perms;
> -		u32 i;
> -
> -		for (i =3D 0; i < fl->cctx->vmcount; i++)
> -			src_perms |=3D BIT(fl->cctx->vmperms[i].vmid);
> -
> -		dst_perms.vmid =3D QCOM_SCM_VMID_HLOS;
> -		dst_perms.perm =3D QCOM_SCM_PERM_RWX;
> -		err =3D qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
> -						(u64)fl->cctx->remote_heap->size,
> -						&src_perms, &dst_perms, 1);
> -		if (err)
> -			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x=
%llx err %d\n",
> -				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
> -	}
> -err_map:
> -	fastrpc_buf_free(fl->cctx->remote_heap);
> -	fl->cctx->remote_heap =3D NULL;
> -err_name:
> +	cctx->audio_init_mem =3D false;

[Severity: High]
Can this lockless assignment cause a data race that corrupts initialization
synchronization?

If Thread A successfully sets cctx->audio_init_mem =3D true inside cctx->lo=
ck
and proceeds, and Thread B concurrently executes the ioctl, skips
initialization because the flag is true, but then fails its invoke operatio=
n,
Thread B will unconditionally clear the flag for the entire channel. Does
this break the single-initialization guarantee?

>  	kfree(name);
>  err:
>  	kfree(args);

[ ... ]

> @@ -2415,12 +2390,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
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
> @@ -2428,7 +2414,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  			if (err)
>  				goto err_free_data;

[Severity: High]
Is it safe to call qcom_scm_assign_mem() here without verifying
data->vmcount > 0?

If the device tree lacks the qcom,vmids property, data->vmcount is 0. Passi=
ng
a dest_cnt of 0 to TrustZone could cause the SMC call to fail or permanently
lock out the memory by stripping HLOS permissions, especially since
fastrpc_rpmsg_remove() skips restoring memory if cctx->vmcount =3D=3D 0.

>  		}
>  	}

[ ... ]

> @@ -2487,6 +2472,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		misc_deregister(&data->secure_fdevice->miscdev);
> =20
>  err_free_data:
> +	kfree(data->remote_heap);
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
Is there a missing rollback for qcom_scm_assign_mem() on this error path?

If the initial assignment succeeds, but a subsequent probe step like
fastrpc_device_register() fails, the driver memory is freed but the
hypervisor mapping is not restored to QCOM_SCM_VMID_HLOS. Can this
permanently lock out the SCM memory and cause subsequent probes to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609025938.457-=
1-jianping.li@oss.qualcomm.com?part=3D3
