Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8681BCD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E8F10E863;
	Thu, 11 Jun 2026 20:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tt5qQr0W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D44910E863
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 20:26:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06D3D43E90;
 Thu, 11 Jun 2026 20:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F41F000E9;
 Thu, 11 Jun 2026 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781209562;
 bh=Y2aEaqIyGjSd9iLc8HlW106uLiozZT7UzRCWks28JO4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tt5qQr0WGRUH+Xv4ngGIc3GKBqN1pIkeat5LfM2kSHNq70IEbUINoV8wU57CWl1dc
 JbZ/41NCiE+OtQiQ/anzcuoWnM0LQyIe+vMckF0fMkm56MQvnIHqhBxPXPumBuxAWg
 CDNnESpzs6bLfSIG1BZDsU32F1vmwJKpPiMYYSKHK2hQzcLHsD6CMs/R9kdKmSY/x9
 T8CQCjctqP70EvIuaZOYMPmLF2Sf1a77lF/W8ecgfdf/Ix+ur7HxER+OnDGShUZa7K
 QtBaqLkbMPE2yXH8ceKHQcXFeYBJnBqTIDX7XmRytxmyoMRTQB8oQWvCJCMHZ4WKpt
 z7/7RVPqQlDMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260610193158.2614209-6-zhipingz@meta.com>
References: <20260610193158.2614209-6-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:26:01 +0000
Message-Id: <20260611202602.A63F41F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Off-by-one error in mlx5r_create_mkeys error handling path cau=
ses hardware mkey leak and invalid destroy.
- [High] Hardware mkeys are leaked in `ib_frmr_pools_set_pinned` if pushing=
 a handle to the pool's queue fails.
--

commit 08f720e58b52ed548a72c452a9bd15258e2e9264
Author: Zhiping Zhang <zhipingz@meta.com>

RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit queries dma-buf TPH metadata when registering a dma-buf MR for
peer-to-peer access, falling back to no-TPH if absent. It also transfers
the ST-table reference ownership to the hardware mkey handle rather than
the transient MR object, and updates the pool API to handle this transfer.

> diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/co=
re/frmr_pools.c
> --- a/drivers/infiniband/core/frmr_pools.c
> +++ b/drivers/infiniband/core/frmr_pools.c
[ ... ]
> @@ -430,16 +430,16 @@ int ib_frmr_pools_set_pinned(struct ib_device *devi=
ce, struct ib_frmr_key *key,
>  	ret =3D pools->pool_ops->create_frmrs(device, key, handles,
>  					    needed_handles);
>  	if (ret) {
>  		kfree(handles);
>  		return ret;
>  	}
> =20
>  	spin_lock(&pool->lock);
>  	for (i =3D 0; i < needed_handles; i++) {
>  		ret =3D push_handle_to_queue_locked(&pool->queue,
>  						  handles[i]);
>  		if (ret)
>  			goto end;
>  	}
> =20
>  end:
>  	spin_unlock(&pool->lock);
>  	kfree(handles);

[Severity: High]
This is a pre-existing issue, but can this error path leak the successfully
created hardware mkeys?

In ib_frmr_pools_set_pinned(), up to needed_handles hardware mkeys are
successfully created via create_frmrs(). If push_handle_to_queue_locked()
fails, the code jumps to the end: label and frees the handles array.

However, the mkeys that were successfully created but not yet pushed don't
appear to be explicitly destroyed here. Could this lead to a bulk resource
leak if queue page allocation fails?

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
[ ... ]
> @@ -335,16 +335,16 @@ static int mlx5r_create_mkeys(struct ib_device *dev=
ice, struct ib_frmr_key *key,
>  	for (i =3D 0; i < count; i++) {
>  		assign_mkey_variant(dev, handles + i, in);
>  		err =3D mlx5_core_create_mkey(dev->mdev, handles + i, in, inlen);
>  		if (err)
>  			goto free_in;
>  	}
>  free_in:
>  	kfree(in);
>  	if (err)
>  		for (; i > 0; i--)
>  			mlx5_core_destroy_mkey(dev->mdev, handles[i]);

[Severity: Critical]
This is a pre-existing issue, but does this rollback loop properly clean up
the successfully created mkeys?

When mlx5_core_create_mkey() fails at index i, the rollback loop=20
for (; i > 0; i--) attempts to destroy handles[i]. Because the creation
failed, handles[i] still contains the unallocated index preset by
assign_mkey_variant().

Executing mlx5_core_destroy_mkey() on this value could send a destroy
command for an unowned mkey, potentially causing hardware state corruption.

Additionally, since the loop stops at i > 0, does it permanently leak the
successfully created mkey at handles[0]?

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610193158.2614=
209-1-zhipingz@meta.com?part=3D5
