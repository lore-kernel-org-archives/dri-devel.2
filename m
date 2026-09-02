Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350D6C61DD3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 01:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8182610E35D;
	Wed,  2 Sep 2026 01:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E0VIb1se";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DAA10E35D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 01:47:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2507843BD0;
 Wed,  2 Sep 2026 01:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F861F000E9;
 Wed,  2 Sep 2026 01:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788313626;
 bh=vpmSdezWVRPEBcJ0BTkuEiV+OKY1HizUnUUiYjsVAKw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E0VIb1se5KhoyfoK52i65nxNkIAovW5hzIQUK0nld6DR7KlFwZnrFy9wYViLUeOeV
 KOoY528A5YpGsu0sUBW7nNG3oiycnKr63Xa4jLXB8F0DGQQvB3Df+c5wPwC+G+A/Ic
 LxyYwbgS8PxZSIcL/fPxMSkVBRCUgeK22rVp7S+Xe0U1F9TRFZ8HAnbXZlSQJNAcNm
 L4+EZkxyf9NGHq9I2BPK8Fr9/Xf6iTxBbmhMa7+zh9JdQZqLfAtkR2jQU0khrZIQO7
 IvBtoTDB2KCQwdEZpxR6cLhWItdh2j265cgjzCyhLjd/BoGyGbmrnEPX3Fep6XXuap
 a4q2zAAg+ppGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: RCU-free the scheduler-containing hwctx
 private
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902012712.880520-1-malhyuk97@gmail.com>
References: <20260902012712.880520-1-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:47:05 +0000
Message-Id: <20260902014705.D9F861F000E9@smtp.kernel.org>
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
- [High] kfree_rcu() is insufficient to prevent Use-After-Free on `fence->s=
ched->name` because exported fences can arbitrarily outlive the RCU grace p=
eriod.
- [High] Synchronous freeing of `hwctx` and `hwctx->name` causes Use-After-=
Free when `amdxdna_fence_get_timeline_name()` accesses them.
- [High] Use-after-free of `job->hwctx` and `job->hwctx->priv` in `aie2_job=
_release()` due to a TOCTOU race with waitqueue evaluation.
--

commit 136ff3c744e0784aadc2c898c0217b9fc55732e6
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
Subject: accel/amdxdna: RCU-free the scheduler-containing hwctx private

This commit modifies aie2_hwctx_fini() to free the scheduler-containing
private struct with kfree_rcu() instead of kfree(). It aims to address a
dma-fence lifetime contract violation where exported fences can outlive the
hardware context, causing a KASAN slab-use-after-free on priv->sched->name.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index baf9a8b90a4d6..cef750007b47d 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -843,7 +843,7 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
> =20
>  	mutex_destroy(&hwctx->priv->io_lock);
>  	kfree(hwctx->col_list);
> -	kfree(hwctx->priv);
> +	kfree_rcu(hwctx->priv, rcu);

[Severity: High]
This isn't a bug introduced by this patch, but is kfree_rcu() sufficient to
prevent a Use-After-Free on fence->sched->name?

Exported fences can arbitrarily outlive the RCU grace period. If userspace
exports the syncobj to a sync_file fd via DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD,
then destroys the hardware context, hwctx->priv is freed after an RCU grace
period. However, if userspace later calls SYNC_IOC_FILE_INFO on the
sync_file fd, it will invoke dma_fence_timeline_name() and dereference the
dangling fence->sched pointer. The RCU grace period only protects against
concurrent lookups, not against prolonged userspace holds on the fence.

>  	kfree(hwctx->cus);
>  }

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race with waitqueue
evaluation between aie2_job_release() and aie2_hwctx_fini() that leads to
a Use-After-Free?

In aie2_job_release(), a thread could increment the counter and get
preempted before calling wake_up():

drivers/accel/amdxdna/aie2_ctx.c:aie2_job_release() {
	atomic64_inc(&job->hwctx->job_free_cnt);
	// <--- Preempted here
	wake_up(&job->hwctx->priv->job_free_wq);
}

Concurrently, aie2_hwctx_fini() is waiting:

drivers/accel/amdxdna/aie2_ctx.c:aie2_hwctx_fini() {
	wait_event(hwctx->priv->job_free_wq,
		   atomic64_read(&hwctx->job_submit_cnt) =3D=3D
		   atomic64_read(&hwctx->job_free_cnt));
	...
}

The wait_event condition locklessly evaluates to true and returns
immediately. Context destruction continues, and hwctx is freed. When
the preempted thread resumes, it calls
wake_up(&job->hwctx->priv->job_free_wq), which writes to the freed
waitqueue spinlock, potentially causing spinlock corruption and a panic.

[Severity: High]
This is a pre-existing issue, but does synchronous freeing of hwctx and
hwctx->name in amdxdna_hwctx_destroy_rcu() also cause a Use-After-Free?

Similar to the above issue, if userspace holds a sync_file and destroys
the context, amdxdna_hwctx_destroy_rcu() synchronously frees hwctx and
hwctx->name:

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_hwctx_destroy_rcu() {
	...
	kfree(hwctx->name);
	kfree(hwctx);
}

When the user later closes the sync_file fd, the reference count of the
drm_sched_fence drops to zero, triggering dma_fence_release(). The
tracepoint trace_dma_fence_destroy() then calls
amdxdna_fence_get_timeline_name(), which dereferences the freed
hwctx->name:

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_fence_get_timeline_name() {
	return xdna_fence->hwctx->name;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902012712.8805=
20-1-malhyuk97@gmail.com?part=3D1
