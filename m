Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FB0C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B8810F2C4;
	Thu, 13 Aug 2026 11:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j5miiyaI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C9210F2C4
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:18:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE50142D82;
 Thu, 13 Aug 2026 11:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6AB1F000E9;
 Thu, 13 Aug 2026 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786619895;
 bh=hhqm7Rk3Vig6GsHd6ISvD94CGXyEShQcWS3qyv+rbjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j5miiyaI5nEkAAIHItsOn5sPHGQotauajJ46aUFljlt7K4XPqC5kMqE9dSw6XhCe7
 KAEoy28JcprhSM+Sj8G/I+kUVOsguOh+ODyjO6GZ4KpEy73MCFvI6fRu4VgDI6dFtm
 eNMDT9cCjZ0ec8dHORPoWaEKpBa30SGARjbuu+NwzcyxUWsMzjuhxxW8v8dI4xTkfW
 XqxlbriSnAu/rU1jGGow4TUGSCZoEhI93Q4ILLwSgWV6lc730BhKwR+5WK6uoaULAV
 cxMv03+njPxae5I3VlENHiaqO/bAApSvR328XY5yEpxonBoxP0RYVJ7xL2zEO7NY5g
 kXZuJGPC374UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/17] drm/panthor: Flush the cleanup_wq in the
 unplug path
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-5-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-5-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:18:15 +0000
Message-Id: <20260813111815.8D6AB1F000E9@smtp.kernel.org>
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
- [Medium] Flushing a global, module-wide workqueue inside a device-specifi=
c unplug path stalls the unplug process for all active devices.

Pre-existing issues:
- [High] The patch adds `flush_workqueue(panthor_cleanup_wq)` to prevent Us=
e-After-Free (UAF), but it does not prevent new work items from being queue=
d after the flush completes, leaving a race window that still triggers UAFs.
--

--- Patch [5]: [PATCH v3 05/17] drm/panthor: Flush the cleanup_wq in the un=
plug path ---
commit ab033ca0df2b4b2d5ba70d4e669044aa6bb08bda
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Flush the cleanup_wq in the unplug path

If we don't do that, we might face various UAFs, because the resource
referenced by these work items might be gone by the time they get
executed.

Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-=
0-8836a74e0ef9@collabora.com?part=3D2

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 0182b72f19320..0b862d3c36058 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3365,6 +3365,12 @@ void panthor_mmu_unplug(struct panthor_device *ptd=
ev)
>  		}
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +
> +	/* Ensure any pending job cleanup work are executed before returning,
> +	 * otherwise those might access objects that are gone if the work is
> +	 * executed after other components are unplugged.
> +	 */
> +	flush_workqueue(panthor_cleanup_wq);
>  }

[Severity: Medium]
Since panthor_cleanup_wq is allocated globally in panthor_drv_init() as a
module-wide workqueue, will flushing it here stall the teardown for all
active devices?

If the system has multiple Panthor GPUs and another device has a backlog of
jobs or a stuck work item, it seems this could block the current device's
unplug thread until all unrelated work items complete.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5832dccfc0932..f18b2e03f2fd8 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
[ ... ]
> @@ -4074,6 +4074,12 @@ void panthor_sched_unplug(struct panthor_device *p=
tdev)
>  		sched->pm.has_ref =3D false;
>  	}
>  	mutex_unlock(&sched->lock);
> +
> +	/* Ensure any pending group release work are executed before returning,
> +	 * otherwise those might access objects that are gone if the work is
> +	 * executed after other components are unplugged.
> +	 */
> +	flush_workqueue(panthor_cleanup_wq);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this flush actually
prevent the UAF if userspace still holds an open DRM file descriptor?

When userspace closes the file descriptor after the unplug completes, it
triggers the teardown path:
drm_file_free() -> panthor_postclose() -> panthor_group_pool_destroy()

This drops group references, calling group_release(), which will call:
queue_work(panthor_cleanup_wq, &group->release_work);

Once drm_file_free() completes, the last reference drops and drm_dev_releas=
e()
synchronously frees the panthor_device memory. Then group->release_work exe=
cutes
asynchronously on the workqueue, accessing the freed group->ptdev and its
resources.

A similar race seems to exist in panthor_vm_bind_job_release() in
panthor_mmu.c, where dropped VM bind jobs queue cleanup_op_ctx_work after
the MMU flush. Can an unprivileged user trigger a GPU reset, wait for the
unplug, and then close the file descriptor to reliably hit this UAF?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D5
