Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C79CD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CD510E060;
	Tue,  9 Jun 2026 03:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EcPvvzt/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9C210E060
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 03:09:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFDC843236;
 Tue,  9 Jun 2026 03:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46381F00893;
 Tue,  9 Jun 2026 03:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780974578;
 bh=AoV/CQM8ZY6Q5fQPSNu3Iu0fWDKrYnXD21mBjTDihbc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EcPvvzt/MJzak98bqtbVaM7d4do6YDFs3QtzlfiRsRQd5ylm0BisazH0M3ndCHsxj
 kxlF5Yt3eQzpCL909M5VOvw2R+KoBWskhilAK2KuaSWRrf0cjUyuV7eztSUjvency4
 IR50k6X4xBLHvRfC+ZQHepb81h+JgCTdPxDcp/5/4B6Ymo6GrawjRsueLUMtY5125i
 2TRDNdyk31bDiWn5RVjTDb6GDT69vGp9OpKw69kOuZ4wF1X6naz6Lt5FkWvxoUBQ44
 s6DKqXRS1i6gsN8ED2HCpDlK7KcLsdfI/5+pNCtPnFvPQ2r+nwihYEro95Kbk4Srjm
 Hri1ogAbecYxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] misc: fastrpc: Remove buffer from list prior to
 unmap operation
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609025938.457-3-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-3-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:09:38 +0000
Message-Id: <20260609030938.B46381F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a critical use-after-free and list corrup=
tion vulnerability in the fastrpc_req_mmap() error path.

Pre-existing issues:
- [High] Concurrent accesses to fl->mmaps without holding fl->lock when han=
dling -ERESTARTSYS.
--

commit a53abf279a47f6742d5cb44fb5a332592c4787b8
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Remove buffer from list prior to unmap operation

This commit removes the buffer from the fastrpc user's mapped list before
calling the unmap operation to prevent concurrent unmap races. If the
unmap operation fails, the buffer is re-added to the list.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 96961217b8569..517884000331b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1889,9 +1889,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_u=
ser *fl, struct fastrpc_buf *
>  				      &args[0]);
>  	if (!err) {
>  		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
> -		spin_lock(&fl->lock);
> -		list_del(&buf->node);
> -		spin_unlock(&fl->lock);

[Severity: Critical]
Does removing this list_del() introduce a use-after-free in the error
path of fastrpc_req_mmap()?

When fastrpc_req_mmap() encounters a copy_to_user() failure after successfu=
lly
adding the buffer to the fl->mmaps list, it jumps to the err_assign label
and calls fastrpc_req_munmap_impl() without first unlinking the buffer:

drivers/misc/fastrpc.c:fastrpc_req_mmap() {
        ...
        spin_lock(&fl->lock);
        list_add_tail(&buf->node, &fl->mmaps);
        spin_unlock(&fl->lock);

        if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
                err =3D -EFAULT;
                goto err_assign;
        }
        ...
err_assign:
        fastrpc_req_munmap_impl(fl, buf);

        return err;
}

Since fastrpc_req_munmap_impl() no longer removes the buffer from fl->mmaps
before calling fastrpc_buf_free(), the freed buffer will remain in the
list. Subsequent traverses of fl->mmaps will trigger a use-after-free.

>  		fastrpc_buf_free(buf);
>  	} else {
>  		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);

[ ... ]

> @@ -1924,7 +1923,14 @@ static int fastrpc_req_munmap(struct fastrpc_user =
*fl, char __user *argp)
>  		return -EINVAL;
>  	}
> =20
> -	return fastrpc_req_munmap_impl(fl, buf);
> +	err =3D fastrpc_req_munmap_impl(fl, buf);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the mmap
list handling here, I noticed concurrent modifications to fl->mmaps happen
locklessly in fastrpc_internal_invoke() when handling -ERESTARTSYS:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
        ...
        if (err =3D=3D -ERESTARTSYS) {
                list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
                        list_del(&buf->node);
                        list_add_tail(&buf->node,=20
                                      &fl->cctx->invoke_interrupted_mmaps);
                }
        }
        ...
}

Can this lead to list corruption if another thread concurrently executes
fastrpc_req_mmap() or fastrpc_req_munmap() and modifies fl->mmaps with
fl->lock held?

> +	if (err) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +	}
> +
> +	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609025938.457-=
1-jianping.li@oss.qualcomm.com?part=3D2
