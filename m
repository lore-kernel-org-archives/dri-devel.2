Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FCFC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E9E10E2CC;
	Fri, 14 Aug 2026 10:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GB/Mnohj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED54610E2CC
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:31:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8895E40862;
 Fri, 14 Aug 2026 10:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC3E1F00A3D;
 Fri, 14 Aug 2026 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786703490;
 bh=efsmY90amC3n0X7S65pBhx/ucpHHjHpwbiy0Odk0WDw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GB/Mnohjuwyrwv6IlY0/iuDWKaHEBc6HUEJOiarf1b9C1Id3etbVNdYLDT0uQzQ7d
 +lCiuTcv6THH5sM1bfhwxeNwwAYnVUnBNC3U/hR9aBuDn3Q8Y/u0S3pGYJvai0QzMr
 ludBiYBT37cKmKKMomO4n6Mwr8WgfYSE6ZZLlfQdSGaDBj+G1ZAKuaiMv447UqrhfW
 XM15N2fStIm5LQAQMtMi5M5tHON3pM+SKqc9I0HN5iMGkEtS8cNZnpLXaIjdHEAzkz
 Ac8e92AirY6shVWs+6LhFl6xglrlMGp10dtYHFiRhQCfHtq6gUNJsYmxk5Ug4ypK/9
 1fHpzCulDxuIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814101955.234238-1-jianping.li@oss.qualcomm.com>
References: <20260814101955.234238-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 10:31:29 +0000
Message-Id: <20260814103130.4CC3E1F00A3D@smtp.kernel.org>
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
- [High] TrustZone memory assignment is permanently leaked on probe error p=
aths.
- [High] Concurrent ioctl calls can cause the DSP to receive an uninitializ=
ed static process creation request out-of-order.
- [Medium] Unconditional TrustZone memory assignment during probe may fail =
or orphan memory for ADSP devices lacking VMIDs.
- [Medium] The `audio_init_mem` flag is incorrectly rolled back on remote i=
nvocation errors, allowing the static heap to be sent multiple times.

Pre-existing issues:
- [High] Permanent TrustZone memory leak for SDSP domains during driver rem=
oval.
--

--- Patch [1]: [PATCH v12] misc: fastrpc: Allocate entire reserved memory f=
or Audio PD in probe ---
commit f78e580b5ae96a440902b976778bd1f19b384768
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: Allocate entire reserved memory for Audio PD in probe

This commit allocates the entire Audio PD reserved-memory region during
rpmsg probe and ties its lifetime to the rpmsg channel. It removes
userspace-controlled allocation and freeing, ensuring memory is only
reclaimed when the DSP process is torn down.

Link: https://lore.kernel.org/all/20260731093210.473-1-jianping.li@oss.qual=
comm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec1..3f14a4673698e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1508,17 +1508,34 @@ static int fastrpc_init_create_static_process(str=
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
> +		cctx->audio_init_mem =3D true;
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
>  	args[2].fd =3D -1;
> =20
>  	sc =3D FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
> =20
>  	err =3D fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
>  				      sc, args);

[Severity: High]
Could this allow the DSP to receive an uninitialized static process creation
request out-of-order?

Two threads could concurrently execute the ioctl. Thread A acquires the loc=
k,
sees audio_init_mem is false, sets it to true, and sets pageslen =3D 1.
Thread B then acquires the lock, sees audio_init_mem is true, and sets
pageslen =3D 0.

Because fastrpc_internal_invoke() is called outside the lock, thread execut=
ion
order is unconstrained once the lock is released. Thread B could be schedul=
ed
such that its RPC payload (with pageslen =3D 0) reaches the DSP before Thre=
ad
A's initialization payload.

>  	if (err)
>  		goto err_invoke;
> =20
>  	kfree(args);
>  	kfree(name);
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

[Severity: Medium]
Is it safe to blindly roll back audio_init_mem if fastrpc_internal_invoke()
returns an error?

Because the DSP operates asynchronously, an interrupted kernel wait (such as
-ERESTARTSYS due to a received signal) does not necessarily mean the DSP
failed to process the request. Reverting this flag might allow the next
process attachment to send the heap configuration pages a second time, which
would violate the static process lifecycle.

[ ... ]

> @@ -2564,25 +2564,20 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
[ ... ]
> -	if (domain_id =3D=3D SDSP_DOMAIN_ID) {
> +	if (fastrpc_domain_has_reserved_heap(domain_id)) {
>  		struct resource res;
>  		u64 src_perms;
> =20
>  		err =3D of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>  		if (!err) {
> +			if (fastrpc_domain_uses_static_heap(domain_id)) {
> +				data->remote_heap_addr =3D res.start;
> +				data->remote_heap_size =3D resource_size(&res);
> +			}

[Severity: High]
This is a pre-existing issue, but does this logic permanently leak TrustZone
memory for SDSP domains when the driver is removed?

For SDSP domains, fastrpc_domain_has_reserved_heap() returns true, so memory
is assigned to the DSP VMID below. However,
fastrpc_domain_uses_static_heap() returns false for SDSP, so
data->remote_heap_size remains uninitialized as 0.

>  			src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> =20
>  			err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perm=
s,
>  				    data->vmperms, data->vmcount);

[Severity: Medium]
Is it intentional to call qcom_scm_assign_mem() unconditionally here, even
if data->vmcount is zero?

Previously, this assignment was explicitly guarded by checking vmcount.
If a device tree without the qcom,vmids property initializes the ADSP domai=
n,
could calling this with a destination count of 0 be rejected by TrustZone
and fail the probe? Additionally, if vmcount is 0, the memory is explicitly
skipped during cleanup, which would permanently leak it.

>  			if (err)
>  				goto err_free_data;
> +		} else {
> +			err =3D 0;
>  		}
> -
>  	}

[ ... ]

>  err_free_data:
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
Does this error path permanently leak the TrustZone memory assignment?

If any operation fails after the memory is successfully assigned to the DSP
VMID (for example, inside fastrpc_device_register() or
of_platform_populate()), the error handlers only free local data structures.
They do not appear to call qcom_scm_assign_mem() to revert the TrustZone
memory ownership back to HLOS.

[ ... ]

> @@ -2684,24 +2684,8 @@ static void fastrpc_rpmsg_remove(struct rpmsg_devi=
ce *rpdev)
[ ... ]
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> +	if (cctx->remote_heap_size && cctx->vmcount) {
> +		u64 src_perms =3D 0;
> +		struct qcom_scm_vmperm dst_perms;

[Severity: High]
This is a pre-existing issue, but does this condition permanently bypass
memory unassignment for SDSP domains?

Because remote_heap_size is intentionally left as 0 for SDSP domains during
probe, this cleanup block is skipped. This leaves the reserved memory
permanently assigned to the DSP VMID after module removal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814101955.2342=
38-1-jianping.li@oss.qualcomm.com?part=3D1
