Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2207C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E2910E049;
	Tue, 14 Jul 2026 12:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V+3JUEpf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6A810E049
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:08:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61E7D6132C;
 Tue, 14 Jul 2026 12:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA55A1F00A3D;
 Tue, 14 Jul 2026 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784030917;
 bh=5x5iZn6A634BKpVAMFzEBOyUyZVD/c4xCK5jyrshXgs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V+3JUEpf6Dc7Ut1FKr4W+E6we1VS96nAIN3g5/wf6NT6GsLEvK5WfO/PyWy0MAOPD
 GuKN6cyT9WGSzyPYh1cPPQXxmjtpiyzaHSL6HINI+TNDHhNiUr8/uTuOHTHXXRwUB7
 lSRGyn8COqCGQDSzVdWecUkYtVAczzGJS+NgJFbYw4KY9xUHJAJT1r5riATpMAj9WG
 EvmOKhXdgF7O9/Pv6b83EizAuzn9O8ENdbt7hAcNt8Sn3F0c/t1YwYXBcwsfeJ+Aje
 3IjUKeg/9/1K/gwkiZS4AwL1zUXXKHCzKTAInOiCRylFIV2lGT77jgvzV/YlSpIrhn
 zuE2WViUsDviA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] misc: fastrpc: don't publish fd before
 copy_to_user() succeeds
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714114654.3885457-3-shoubaineng@gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-3-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:08:36 +0000
Message-Id: <20260714120836.EA55A1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The `fastrpc_user` context can be used-after-free if an export=
ed dmabuf outlives the fastrpc device file descriptor.
- [Critical] Concurrent calls to `FASTRPC_IOCTL_MUNMAP` lead to list corrup=
tion, Use-After-Free, and Double-Free of a `fastrpc_buf`.
- [Critical] Concurrent calls to `FASTRPC_IOCTL_MEM_UNMAP` cause a Use-Afte=
r-Free and Double-Free of a `fastrpc_map`.
--

--- Patch [2]: [PATCH v3 2/2] misc: fastrpc: don't publish fd before copy_t=
o_user() succeeds ---
commit 385ee7a3198521d1682f7120112f746dede7b20d
Author: Baineng Shou <shoubaineng@gmail.com>
misc: fastrpc: don't publish fd before copy_to_user() succeeds

This commit fixes an issue where the DMA buffer file descriptor is publishe=
d=20
to userspace before a successful usercopy. It reserves an unused fd, perfor=
ms=20
the copy, and only installs the fd if the copy succeeds. On failure, it=20
cleanly unwinds the fd and buffer allocations.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..c5143cd257674 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -1709,24 +1709,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_us=
er *fl, char __user *argp)
>  		return err;
>  	}
> =20
> -	bp.fd =3D dma_buf_fd(buf->dmabuf, O_ACCMODE);
> +	bp.fd =3D get_unused_fd_flags(O_ACCMODE);

[Severity: Critical]
This is a pre-existing issue, but does fastrpc_buf_alloc() fail to take a=20
reference on the fastrpc_user context?

Looking just above this diff in fastrpc_dmabuf_alloc():

err =3D fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, &buf);

This allocates the buffer and assigns the user context to buf->fl, but does=
=20
not increment the user context's reference count. If the fastrpc device fil=
e=20
descriptor is closed, fastrpc_device_release() drops the reference to fl an=
d=20
frees it, meaning the exported dmabuf can outlive it.

If the dmabuf is closed later, fastrpc_release() calls fastrpc_buf_free(),=
=20
which dereferences the freed context here:

fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr)

Can this lead to a use-after-free of the fastrpc_user context?

[Severity: Critical]
This is also a pre-existing issue, but does concurrent execution of=20
FASTRPC_IOCTL_MUNMAP lead to list corruption or double-frees?

In fastrpc_req_munmap(), the buf pointer is located under the lock:

buf =3D iter;
break;

The lock is then dropped without taking a reference count on the buffer. Th=
e=20
raw pointer is passed to fastrpc_req_munmap_impl(). If two threads invoke=20
the ioctl concurrently with the same arguments, could they both find the=20
same buf and race?=20

They would both concurrently execute this in fastrpc_req_munmap_impl():

list_del(&buf->node);
spin_unlock(&fl->lock);
fastrpc_buf_free(buf);

Does this result in list_del() and fastrpc_buf_free() executing twice on=20
the same pointer?

[Severity: Critical]
This is another pre-existing issue, but does fastrpc_req_mem_unmap_impl()=20
have a similar race condition?

The map is extracted from the list under the lock, and then the lock is=20
dropped without incrementing the map's reference count:

map =3D iter;
break;
}
}
spin_unlock(&fl->lock);

Multiple threads could extract the same map pointer. If both threads=20
successfully proceed, they will both call:

fastrpc_map_put(map);

Since fastrpc_map_get() was never called during the lookup, does the first=
=20
thread drop the reference count to 0 and free the map prematurely? This=20
could cause the second thread to trigger a use-after-free on failure paths=
=20
or a double-free when calling fastrpc_map_put() again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714114654.3885=
457-1-shoubaineng@gmail.com?part=3D2
