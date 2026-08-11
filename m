Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3435C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A66410E2DB;
	Tue, 11 Aug 2026 23:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HkcejG9u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA96510E2DB
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 23:03:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3B55409E1;
 Tue, 11 Aug 2026 23:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7841F000E9;
 Tue, 11 Aug 2026 23:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786489399;
 bh=CxJZFaM+j4jKnusC0Nz6ELroPCjJVgn0e/vaobI90vY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HkcejG9uMae7hD/S/jndCS1DpUgupTddagsfEfyMEMdUCf5uXT9761dNTikPzJVlC
 4LP2FUJrdChHBIy4IEbB0za3jwKxNZMQ+dgBXfzs61UVMIp6S22lh3D2/PCvllqkya
 Dd/5OMWA5WK/Mn3eH3I+Rk2Wu/El832xunms4cavU1SvErOnAbjz0mYCN8bEbl7jsh
 1mErEyq647XBUmSiRBXzu5i4fydYRm2aIh2TucRTeuw9b/ozB1LsWmp7P2fO1L8DND
 Ap8VDTAO5ddPyAaqDvd5gngsJbiTYut+vl5JElcEEMbeop2QtspNFfvLQgibWzfPqS
 tdz+F5xccUWQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: fix double-free in
 fastrpc_map_attach() error path
To: "Yifei Gao" <gyf161023@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811225102.1077841-1-gyf161023@gmail.com>
References: <20260806235056.456341-1-gyf161023@gmail.com>
 <20260811225102.1077841-1-gyf161023@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:03:19 +0000
Message-Id: <20260811230319.9A7841F000E9@smtp.kernel.org>
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
- [High] Routing the qcom_scm_assign_mem() failure path to get_err introduc=
es a massive DMA-buf and memory leak because fastrpc_free_map() aborts earl=
y on cleanup.

Pre-existing issues:
- [Critical] Lockless and un-referenced use of fastrpc_map pointers leads t=
o Use-After-Free vulnerabilities.
--

--- Patch [1]: [PATCH v2] misc: fastrpc: fix double-free in fastrpc_map_att=
ach() error path ---
commit e44cb66ae041e0f79b6c9be086dbcbf912aa8a9e
Author: Yifei Gao <gyf161023@gmail.com>

misc: fastrpc: fix double-free in fastrpc_map_attach() error path

This patch attempts to fix a double-free in the error path of
fastrpc_map_attach() by routing map->table-is-set failure branches to
get_err instead of map_err. This makes fastrpc_free_map() the sole owner
of the unmap/detach/put sequence for these branches.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index eb6c2a78d3c7b..d480a87752a7f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -881,7 +881,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl=
, int fd,
>  		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
>  				len, map->size);
>  		err =3D -EINVAL;
> -		goto map_err;
> +		goto get_err;
>  	}
>  	map->va =3D sg_virt(map->table->sgl);
>  	map->len =3D len;

[ ... ]

> @@ -904,7 +904,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl=
, int fd,
>  			dev_err(sess->dev,
>  				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
>  				&map->dma_addr, map->len, err);
> -			goto map_err;
> +			goto get_err;

[Severity: High]
Does routing this qcom_scm_assign_mem() failure to get_err introduce a memo=
ry
and DMA-buf leak?

When the forward assignment to TrustZone fails, map->attr is already set to
FASTRPC_ATTR_SECUREMAP. If we jump to get_err, fastrpc_map_put() is called
which in turn calls fastrpc_free_map(). Inside fastrpc_free_map(), it will
see this flag and attempt a reverse qcom_scm_assign_mem().

Since the forward assignment just failed, the reverse assignment will also
fail. Looking at fastrpc_free_map(), if the reverse assignment fails, it
returns early:

fastrpc_free_map() {
    ...
    if (map->attr & FASTRPC_ATTR_SECUREMAP) {
        ...
        err =3D qcom_scm_assign_mem(...);
        if (err)
            return;
    }
    ...
}

Will this early return completely skip dma_buf_unmap_attachment_unlocked(),
dma_buf_detach(), dma_buf_put(), and kfree(map), leaving untrusted user
space able to exhaust kernel memory?

>  		}
>  	}
>  	spin_lock(&fl->lock);

[Severity: Critical]
This is a pre-existing issue, but can the lockless use of fastrpc_map
pointers lead to a use-after-free elsewhere in this file?

In fastrpc_req_mem_unmap_impl(), the fl->maps list is searched under fl->lo=
ck
to find a map pointer. If the lock is then dropped without incrementing the
object's reference count, concurrent ioctls could free the map while it is
still being accessed.

A similar pattern appears in fastrpc_put_args() where fastrpc_map_lookup()
is called without taking a reference, returning an unreferenced pointer that
is later passed to fastrpc_map_put(), causing a refcount imbalance.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811225102.1077=
841-1-gyf161023@gmail.com?part=3D1
