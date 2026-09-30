Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1313CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6DA10F1F2;
	Wed, 30 Sep 2026 07:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XNA1jd/G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBE510F1F2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:10:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CE22600D4;
 Wed, 30 Sep 2026 07:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5581F000FF;
 Wed, 30 Sep 2026 07:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790752204;
 bh=B+39851crvy7gNAFdzL9By/3zlqtRb9FMHA8cuJgnfw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XNA1jd/GN7Jd296mYvchK3yLQJPZrKVH9p2ADJKsS8bKHw5wuy2+QYNddq2O/VVSP
 0vhbc0jlUoRBcyjx7AzAyS/XK8XUQO/oC0SrH7OW2TjaMRXNGFSAoH9PVu08qk4P31
 e2tyP0h3n6DyFDjNsB9aIyO0NdGZNilPREMGsyaY6XahmC0I6YZ4B+OdmTk7SMeHbh
 fvxmxeIcI5ITS4Cf8Wlm2hPG8Eg1ysvAJ/qpNbQkjl6iINCqEqjIk1ZPQivqvjl5D5
 mNXkkUefF/xqbF5XpsaQmVsToxawhcGuFGCJxTBgWc0E3GO+/j+iktA4tM3C5aZB2v
 77Azp+1MWTnKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Fix race and double free in
 fastrpc_req_mmap() error path
To: "Yao Yiqi" <yaoyiqi3@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930063738.2966346-1-yaoyiqi3@huawei.com>
References: <20260930063738.2966346-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:10:03 +0000
Message-Id: <20260930071003.BF5581F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] misc: fastrpc: memory leak in fastrpc_req_mmap error path
--

commit 9824ed05459dfdc017a5b781dcfa0dc08576a6f0
Author: Yao Yiqi <yaoyiqi3@huawei.com>

misc: fastrpc: Fix race and double free in fastrpc_req_mmap() error path

This commit defers adding the allocated buffer to fl->mmaps until after
copy_to_user() succeeds. This prevents concurrent threads from accessing
the buffer prematurely, fixing a race condition and a double free.

Cc: stable@vger.kernel.org

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca867..d2c09bffd0af4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2153,15 +2153,15 @@ static int fastrpc_req_mmap(struct fastrpc_user *=
fl, char __user *argp)
>  		}
>  	}
> =20
> -	spin_lock(&fl->lock);
> -	list_add_tail(&buf->node, &fl->mmaps);
> -	spin_unlock(&fl->lock);
> -
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err =3D -EFAULT;
>  		goto err_assign;
>  	}
> =20
> +	spin_lock(&fl->lock);
> +	list_add_tail(&buf->node, &fl->mmaps);
> +	spin_unlock(&fl->lock);
> +

[Severity: High]
Could this introduce a permanent DMA memory leak on the error path?

fastrpc_req_mmap() is reachable via the FASTRPC_IOCTL_MMAP ioctl. If
copy_to_user() or qcom_scm_assign_mem() fails (which is trivial to force fr=
om
userspace by passing an invalid address), the error path jumps to err_assign
and calls fastrpc_req_munmap_impl(fl, buf).

If the IPC call to unmap the buffer from the DSP fails,
fastrpc_req_munmap_impl() intentionally leaves the buffer unfreed to prevent
reuse while the DSP still has access:

drivers/misc/fastrpc.c:fastrpc_req_munmap_impl() {
    ...
	if (!err) {
		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
		fastrpc_buf_free(buf);
	} else {
		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
	}
}

Previously, since the buffer was already on fl->mmaps, it would eventually =
be
cleaned up by fastrpc_user_free(). Because this patch delays adding the buf=
fer
to fl->mmaps until after copy_to_user() succeeds, the kernel loses its only
reference to the allocation if the DSP unmap fails.

Can we ensure the buffer is still tracked for cleanup in this scenario?

>  	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
>  		buf->raddr, buf->size);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063738.2966=
346-1-yaoyiqi3@huawei.com?part=3D1
