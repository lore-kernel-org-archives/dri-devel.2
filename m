Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0716CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4292E10EAE4;
	Tue, 30 Jun 2026 06:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hDSmK4Es";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E13210EB06
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:46:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D427143DAB;
 Tue, 30 Jun 2026 06:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977561F000E9;
 Tue, 30 Jun 2026 06:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782802011;
 bh=sUgMqtyi6slRlpsGR1VzJ9Fp1+PTyBy3CqTnk36ntNo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hDSmK4EsPPzzNFYfUttRkDMrYkEU+A+MdfZOI7ENmwI5f0q3pOfjJXdHut6MvnU7W
 4eDSez1d7IEonxnLVhvW62tW19yVBBxMZyWjCK6AWkd+Wqjthbr0Oe91UcIKHV8CJ5
 ee/yq7j9F4eW3oxyR4a0dC9726NloCllhfKBQULw/9JB+ki1K71gsWh2YmHHIBoh8N
 fkiklMb8HTF407g4Xd4OBZHS+hg3gV2ZzK7Z38ca6p/Ee4QYVfmU0isjR8k6/AqrEh
 9r4B8UWmmHOvBLI5+mJhH5bHYjc2qk1XFJfFVuy4DrO/YEQm7tCG37eKN+CX3L3/qm
 eZi+F57Mno2LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: fix UAF and kernel panic during
 cleanup on process abort
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630063409.475-1-jianping.li@oss.qualcomm.com>
References: <20260630063409.475-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:46:51 +0000
Message-Id: <20260630064651.977561F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] `fastrpc_cb_remove` locks uninitialized mutexes when matching =
unallocated sessions.
- [High] The patch intentionally leaks DMA allocations, dmabufs, and tracki=
ng structures to avoid a use-after-free on device unbind.
- [High] The error path in `fastrpc_map_attach` calls `dma_buf_detach` with=
out holding `fl->sctx->mutex`, circumventing the synchronization intended t=
o prevent use-after-free.

Pre-existing issues:
- [High] The error handling path in `fastrpc_map_attach` triggers double-de=
tach and double-put of dmabufs.
- [High] Preexisting memory leak in `fastrpc_free_map` during secure memory=
 assignment failure.
- [High] Array overwrite and race condition vulnerability due to blind decr=
ement of `sesscount` in `fastrpc_cb_remove` without array compaction.
- [High] Probe failure leaves a dangling device pointer in the active sessi=
on array.
--

commit 70c262510b69042fa36e0aa92b5ee69b7cc10c62
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: fix UAF and kernel panic during cleanup on process abort

This commit introduces mutex protection for map and buffer lifetimes to fix
use-after-free issues when a FastRPC client is aborted. It serializes clean=
up
against device teardown and skips operations when the device is gone.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -335,9 +337,14 @@ static void fastrpc_free_map(struct kref *ref)

[ ... ]

>  		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
>  			struct qcom_scm_vmperm perm;

[ ... ]

>  			err =3D qcom_scm_assign_mem(map->dma_addr, map->len,
>  				&src_perms, &perm, 1);
>  			if (err) {
>  				dev_err(map->fl->sctx->dev,
>  					"Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
>  					&map->dma_addr, map->len, err);
>  				return;

[Severity: High]
This is a pre-existing issue, but does this early return completely abandon
the release sequence?

If qcom_scm_assign_mem() fails, it looks like this returns immediately,
bypassing all subsequent teardown logic and permanently leaking the map on =
the
linked list along with the dmabuf references.

>  			}
>  		}
> +		mutex_lock(&fl->sctx->mutex);
> +		if (!fl->sctx->dev) {
> +			mutex_unlock(&fl->sctx->mutex);
> +			return;

[Severity: High]
Can this early return permanently leak the map and dmabuf?

If a process terminates after a device unbinds, fastrpc_cb_remove() sets dev
to NULL. When fastrpc_free_map() runs, it hits this early return and
completely bypasses the mandatory resource deallocation such as kfree(),
list_del(), and dma_buf_put().

> +		}
>  		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
>  						  DMA_BIDIRECTIONAL);
>  		dma_buf_detach(map->buf, map->attach);
>  		dma_buf_put(map->buf);
> +		mutex_unlock(&fl->sctx->mutex);
>  	}

[ ... ]

> @@ -422,9 +435,18 @@ static void fastrpc_buf_free(struct fastrpc_buf *buf)
>  	struct fastrpc_user *fl =3D buf->fl;
> =20
>  	if (!fl)
>  		return;
> +	mutex_lock(&fl->sctx->mutex);
> +	if (fl->sctx->dev) {
> +		dma_free_coherent(buf->dev, buf->size, buf->virt,
> +				  fastrpc_ipa_to_dma_addr(buf->fl->cctx,
> +							  buf->dma_addr));
> +		kfree(buf);
> +	}
> +	mutex_unlock(&fl->sctx->mutex);

[Severity: High]
Could the absence of an else-branch permanently leak the buffer memory?

Similar to fastrpc_free_map(), if the device is gone, skipping the
dma_free_coherent() and kfree() leaves the memory permanently leaked
instead of safely handling the cleanup.

>  }

[ ... ]

> @@ -855,19 +884,28 @@ static int fastrpc_map_attach(struct fastrpc_user *=
fl, int fd,

[ ... ]

>  	table =3D dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONA=
L);
>  	if (IS_ERR(table)) {
>  		err =3D PTR_ERR(table);
> +		mutex_unlock(&fl->sctx->mutex);
>  		goto map_err;

[Severity: High]
This is a pre-existing issue, but does jumping to map_err cause a double
detach and put of the dmabuf?

If we take this error path after map->table has been assigned, we execute:

fastrpc_map_attach()
  goto map_err;
  map_err:
    dma_buf_detach(map->buf, map->attach);
    ...
    fastrpc_map_put(map);

Because map->table is non-NULL, the kref release function fastrpc_free_map()
will re-execute dma_buf_detach() and dma_buf_put() on the identical
structures.

[Severity: High]
Would unlocking the mutex here expose the error path to a use-after-free?

By explicitly unlocking sctx->mutex before jumping to map_err, dma_buf_deta=
ch()
is called completely unprotected. A concurrent fastrpc_cb_remove() can run
between the unlock and detach, clearing the device and leading to a
use-after-free in dma_buf_detach() when it accesses attach->dev.

>  	}
>  	map->table =3D table;
> +	mutex_unlock(&fl->sctx->mutex);

[ ... ]

> @@ -2246,6 +2284,8 @@ static int fastrpc_cb_probe(struct platform_device =
*pdev)

[ ... ]

>  	sess =3D &cctx->session[cctx->sesscount++];
>  	sess->used =3D false;
>  	sess->valid =3D true;
>  	sess->dev =3D dev;
> +	mutex_init(&sess->mutex);
> +	sess->allocated =3D true;

[Severity: High]
This is a pre-existing issue, but does appending to sesscount here
blindly overwrite a trailing active session?

When fastrpc_cb_remove() executes, it decrements sesscount blindly without
shifting downstream array elements to close the gap. A subsequent probe
uses the decremented sesscount as an append index, corrupting the active
session.

With this patch, the newly added mutex_init() will now reinitialize an
in-use lock on that overwritten session.

>  	dev_set_drvdata(dev, sess);
>  	sess->sid =3D sid;

[ ... ]

> @@ -2260,6 +2300,8 @@ static int fastrpc_cb_probe(struct platform_device =
*pdev)

[ ... ]

>  			dup_sess =3D &cctx->session[cctx->sesscount++];
>  			memcpy(dup_sess, sess, sizeof(*dup_sess));
> +			mutex_init(&dup_sess->mutex);
> +			dup_sess->allocated =3D true;
>  		}
>  	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but does a probe failure
leave a dangling device pointer in the active session array?

Just below this hunk, dma_set_mask() is called. If that call fails, it
returns an error and aborts the probe. The driver core will destroy the
device, but FastRPC has already permanently registered the dangling dev
pointer into its session array.

> @@ -2282,6 +2324,11 @@ static void fastrpc_cb_remove(struct platform_devi=
ce *pdev)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	for (i =3D 0; i < FASTRPC_MAX_SESSIONS; i++) {
>  		if (cctx->session[i].sid =3D=3D sess->sid) {
> +			spin_unlock_irqrestore(&cctx->lock, flags);
> +			mutex_lock(&cctx->session[i].mutex);

[Severity: Critical]
Will this loop lock uninitialized mutexes when matching unallocated session=
s?

The elements beyond sesscount in cctx->session are zero-initialized.
If sess->sid is 0 (the default if a DT lacks a 'reg' property), the loop
condition cctx->session[i].sid =3D=3D sess->sid will match all unused slots.

This attempts to acquire an uninitialized, all-zero mutex, which might
lead to a panic or lockdep crash. Should this loop check
cctx->session[i].allocated?

> +			cctx->session[i].dev =3D NULL;
> +			mutex_unlock(&cctx->session[i].mutex);
> +			spin_lock_irqsave(&cctx->lock, flags);
>  			cctx->session[i].valid =3D false;
>  			cctx->sesscount--;

[Severity: High]
This is a pre-existing issue, but does decrementing sesscount without
moving elements create a discrepancy between the index and active entries?

As mentioned earlier, this blind decrement leaves a gap in the array that
leads to state corruption during the next probe.

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630063409.475-=
1-jianping.li@oss.qualcomm.com?part=3D1
