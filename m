Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273FAC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E1D10E038;
	Fri,  4 Sep 2026 08:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T405sYcm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E93010E011
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:18:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2DCF60A6D;
 Fri,  4 Sep 2026 08:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C321F00A3D;
 Fri,  4 Sep 2026 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509909;
 bh=0Doak3wM1mSe14BhuvRNBlJEtsVHIYiJI1VxPTGOnN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T405sYcmcmzvUnhXzYljkmzRcuTkM3RGcXxINrBrlln+KITAcvE9UxdJDp5uBhY+m
 LvpgtsSKtMC0WEfuSaIjYelmAAAU6Gac69eqoMA5x/SKqaa5PTNwx05JjQ5UueBSWb
 2ZqJ0FTYTLwpwS8DBsXeArvA5V2UiqUk1quRgWbMadiUWXJwojmbRTah/ghUts6eAb
 2F/RQVb/KAdp3HAkzLr8rSiJQfF4e3jAPgtje6rDClGhd5ng88VXs6Lw9bkXbpkW/r
 2v0AJJOArBkknfTh3j6SxmTWTj4VdLc1iMiwkoFqrtFvG3IEf/u81b/yV9W3Zr5Arc
 Lj2cNn/fqcOmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904080618.2098450-2-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:18:28 +0000
Message-Id: <20260904081829.67C321F00A3D@smtp.kernel.org>
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
- [High] The patch attempts to fix a Use-After-Free by caching the timeline=
 name in `fence->sched_name`, but it introduces a direct Use-After-Free of =
the string memory itself. The commit message incorrectly assumes all driver=
s pass a string literal or keep the string alive via RCU. However, `panthor=
` dynamically allocates the timeline name (`kasprintf`) and synchronously f=
rees it (`kfree(queue->name)`) when the queue is destroyed. Furthermore, fo=
r `xe`, `kfree_rcu` does not protect against a `sync_file` fd held open by =
userspace for an arbitrary duration (userspace holding an fd does not equat=
e to holding an RCU read lock). When userspace queries the fence info via t=
he `SYNC_IOC_FILE_INFO` ioctl after the string is freed, `drm_sched_fence_g=
et_timeline_name()` returns the cached pointer to the freed memory, leading=
 to an info leak to userspace.

Pre-existing issues:
- [High] The AMDGPU driver's `amdgpu_sync_same_dev()` function incorrectly =
assumes that any `drm_sched_fence` belongs to an AMDGPU ring. `to_drm_sched=
_fence()` returns non-NULL for *any* DRM scheduler fence globally (e.g., fr=
om `panthor`, `xe`, `nouveau`). If a foreign fence is passed via a `dma-buf=
` or `syncobj`, `amdgpu_sync_same_dev()` unconditionally calculates `ring =
=3D container_of(s_fence->sched, struct amdgpu_ring, sched)` and dereferenc=
es `ring->adev`. This results in an out-of-bounds read (Type Confusion). Ad=
ditionally, if the foreign fence originated from a per-context scheduler th=
at has been freed (like a destroyed `panthor` queue), this results in a Use=
-After-Free read.
- [High] The PowerVR driver's `pvr_queue_fence_is_native()` accesses `sched=
_fence->sched->ops` to determine if a fence is native to the driver. Howeve=
r, if the `drm_sched_fence` originated from a per-context scheduler (whethe=
r from `pvr` or another driver like `panthor`) and that scheduler has been =
destroyed, `sched_fence->sched` is a dangling pointer. Dereferencing it to =
check `->ops` causes a Use-After-Free read.
--

commit 99163b915ba8e6d549d23c04536ae0f2ac030b70
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

drm/sched: cache the timeline name to fix a use-after-free

This commit caches the scheduler's timeline name inside drm_sched_fence to
prevent a use-after-free when a userspace-held finished fence outlives a
per-context scheduler. It documents that the name must outlive the fence,
assuming all in-tree drivers pass string literals or keep the name alive.

>     Every in-tree driver passes a string literal, which satisfies this;

[Severity: High]
Is this assumption correct for all in-tree drivers?

For example, panthor dynamically allocates the timeline name and synchronou=
sly
frees it when the queue is destroyed:

drivers/gpu/drm/panthor/panthor_sched.c:group_free_queue() {
    ...
    kfree(queue->name);
    ...
}

If a user creates a panthor queue, submits a job to get a fence, exports it
to a sync_file, and destroys the queue, the string memory is freed. When
userspace then queries the fence info via the SYNC_IOC_FILE_INFO ioctl,
wouldn't the cached pointer point to freed memory, leading to an info leak?

> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/sc=
heduler/sched_fence.c
> index 096fe28aa9c9e..b2a842a1c9ba9 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(str=
uct dma_fence *fence)
>  static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
>  {
>  	struct drm_sched_fence *fence =3D to_drm_sched_fence(f);
> -	return (const char *)fence->sched->name;
> +
> +	/*
> +	 * Do not dereference fence->sched here: a userspace-held finished
> +	 * fence can outlive a per-context scheduler. Return the name cached
> +	 * in drm_sched_fence_init() instead.
> +	 */
> +	return fence->sched_name;

[Severity: High]
Does returning this cached pointer just replace the scheduler use-after-free
with a string memory use-after-free?

Because drivers like panthor can free the string memory synchronously during
queue destruction, this cached pointer will point to freed memory when read
by the caller.

[ ... ]

> @@ -228,6 +242,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fe=
nce,
>  	unsigned seq;
> =20
>  	fence->sched =3D entity->rq->sched;
> +	/*
> +	 * Cache the scheduler's timeline name. The finished fence may be
> +	 * exported to userspace and outlive @sched (per-context schedulers are
> +	 * freed on context teardown), so get_timeline_name() must not
> +	 * dereference @sched. The name is required to outlive any exported
> +	 * fence (see @name in struct drm_sched_init_args).
> +	 */
> +	fence->sched_name =3D fence->sched->name;

[Severity: High]
Does caching the string pointer here without taking ownership or extending
its lifetime erroneously assume the string will inherently outlive the fenc=
e?

This is a pre-existing issue, but the dangling fence->sched pointer causes
problems in other drivers as well when foreign fences are imported.

[Severity: High]
Does the AMDGPU driver's amdgpu_sync_same_dev() incorrectly assume any
drm_sched_fence globally belongs to an AMDGPU ring?

drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c:amdgpu_sync_same_dev() {
    ...
    ring =3D container_of(s_fence->sched, struct amdgpu_ring, sched);
    return ring->adev =3D=3D adev;
}

If a foreign fence from another driver (e.g., panthor) is passed via a dma-=
buf
or syncobj and used as an input dependency to the AMDGPU command submission
ioctl, this unconditional container_of() calculation will dereference an
invalid or freed pointer. Can this lead to an out-of-bounds type confusion
read, or a use-after-free read if the original per-context scheduler was
already destroyed?

This is also a pre-existing issue, but similar to the AMDGPU issue above,
does the PowerVR driver also dereference a freed scheduler pointer?

[Severity: High]
drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_fence_is_native() {
    ...
    if (sched_fence &&
        sched_fence->sched->ops =3D=3D &pvr_queue_sched_ops)
    ...
}

If a user exports a drm_sched_fence from a queue, destroys that queue (free=
ing
the scheduler), and then passes the fence as an input dependency to the PVR
job submission ioctl, sched_fence->sched will be a dangling pointer. Will
dereferencing it to check the ops field cause a use-after-free read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904080618.2098=
450-1-malhyuk97@gmail.com?part=3D1
