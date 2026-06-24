Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D78CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BC910E0DF;
	Wed, 24 Jun 2026 18:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XM368j7F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC25F10E0DF
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:01:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BAB9B40BEE;
 Wed, 24 Jun 2026 18:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A081F000E9;
 Wed, 24 Jun 2026 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782324105;
 bh=iUCEe2p/gU4X9gCg0PJMXB6u28ySiIJg+So6RnpTMR0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XM368j7FYY6sT80azOna/16I+hQU2fRd55PkibL3VjIcFNWU1E8UCMuKPFvJ4f1p+
 raIkAWC/9BQwBbGR33jUYbqJAy04Iw7kU4/UHxLvTjES7F8fkt4uczLDBlGpbZ0V41
 RCS2EZj9GmspmzclWie/4WAe2Z/gf/tfluZ8Ql0WQJ3B6wPEvxUR4+i/pTe3lURkQm
 O7SUsbYafPVpZg76CSh7nCWdrU/M1rmVytt6/yyjorgJBplKrtEMpniXktz9dRoezo
 cOx65u7Jnvl9Opxbg6LynhLRulEv75+k1Dxhv7LLFnELmA5AytjbN+IZQZl2w+IWqK
 SEj/NT/0dvo5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: remove mmap entry before remote unmap
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624174652.6792-1-alhouseenyousef@gmail.com>
References: <20260624174652.6792-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 18:01:45 +0000
Message-Id: <20260624180145.87A081F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free and list corruption on the `fastrpc_req_munmap` err=
or path due to unhandled race with `fastrpc_req_mmap`.

Pre-existing issues:
- [Critical] Missing TrustZone memory cleanup leads to a fatal hypervisor D=
enial of Service upon reallocation.
- [High] Concurrent double-unmap vulnerability leading to Use-After-Free in=
 `fastrpc_req_mem_unmap_impl`.
--

commit ddfb73eb827659f1e8a6e70335752c48fead38e3
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: remove mmap entry before remote unmap

This patch removes the buffer from the fastrpc user mmaps list before
calling into the DSP to unmap memory. If the remote unmap fails, the
buffer is added back to the list.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..964d3ab845f87 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1924,7 +1927,14 @@ static int fastrpc_req_munmap(struct fastrpc_user =
*fl, char __user *argp)
>  		return -EINVAL;
>  	}
> =20
> -	return fastrpc_req_munmap_impl(fl, buf);
> +	err =3D fastrpc_req_munmap_impl(fl, buf);
> +	if (err) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);

[Severity: High]
Can this fallback path corrupt the list?

If a concurrent thread calling fastrpc_req_mmap() fails in copy_to_user(),
it branches to err_assign and calls fastrpc_req_munmap_impl() while the
buffer is still attached to the fl->mmaps list.

If another thread concurrently calls fastrpc_req_munmap() on the same buffe=
r,
it detaches it from the list and calls fastrpc_req_munmap_impl(). If the fi=
rst
thread succeeds in the DSP unmap and frees the buffer, and the second thread
fails the DSP unmap, it will execute list_add_tail() on the already-freed
buffer.

> +		spin_unlock(&fl->lock);
> +	}
> +
> +	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the exact same concurrent
vulnerability you fixed in fastrpc_req_munmap() remains unaddressed in
fastrpc_req_mem_unmap_impl().

drivers/misc/fastrpc.c:fastrpc_req_mem_unmap_impl() {
    ...
	spin_lock(&fl->lock);
	list_for_each_entry_safe(iter, m, &fl->maps, node) {
		if ((req->fd < 0 || iter->fd =3D=3D req->fd) &&
		    (iter->raddr =3D=3D req->vaddr)) {
			map =3D iter;
			break;
		}
	}
	spin_unlock(&fl->lock);
    ...
	err =3D fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
				      &args[0]);
	if (err) {
		dev_err(dev, "unmmap\tpt fd =3D %d, 0x%09llx error\n",
			map->fd, map->raddr);
		return err;
	}
	fastrpc_map_put(map);
    ...
}

Could two threads calling FASTRPC_IOCTL_MEM_UNMAP on the same mapping both
find the map in fl->maps because the lock is dropped without detaching the
map or taking a reference?

If the first thread succeeds and frees the map, would the second thread
trigger a use-after-free when it logs the error, or a double-free if it
succeeds?

[Severity: Critical]
This is a pre-existing issue, but does fastrpc_buf_free() fail to restore
High-Level OS (HLOS) permissions before releasing memory?

When allocating memory with the ADSP_MMAP_REMOTE_HEAP_ADDR flag:

drivers/misc/fastrpc.c:fastrpc_req_mmap() {
    ...
	if (req.flags =3D=3D ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
		u64 src_perms =3D BIT(QCOM_SCM_VMID_HLOS);

		err =3D qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
    ...
}

This transfers physical memory ownership from HLOS to TrustZone. However, w=
hen
fastrpc_buf_free() is called:

drivers/misc/fastrpc.c:fastrpc_buf_free() {
	dma_free_coherent(buf->dev, buf->size, buf->virt,
			  fastrpc_ipa_to_dma_addr(buf->fl->cctx,
						  buf->dma_addr));
	kfree(buf);
}

The memory is returned to the kernel allocator without reverting the TrustZ=
one
assignment. Might a subsequent kernel allocation that touches this physical
memory trigger a fatal hypervisor exception and system crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624174652.6792=
-1-alhouseenyousef@gmail.com?part=3D1
