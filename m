Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B82C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184E210E200;
	Tue, 30 Jun 2026 14:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jsCIUDvv";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7788B10E200
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 14:46:07 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gqQtz6KCbz9tyS;
 Tue, 30 Jun 2026 16:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782830763; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=td3tFB9mSbocKcY7wsrXfJgzOu/KGrhFsokIWvDAN8c=;
 b=jsCIUDvvhEKgYl+MF20FP+zp/TLtbQUxVls8a/aE7NFdWKVYaYgIlHDFJdgBVojaACnt1O
 P1GdHwCmaodxogBlvs7DoHeB0H4M25ET7o4S6Y5pXgkfvyJ0gr7A6CLkAOHLhRHwXpYAV/
 NFrS6BBGQtjgI/NGI3LW8egco2Fc5JurYTihQHhoZbhMmsJmc2QHbnyMx1nNbycHydpowg
 vwmxT4mIbZJP1L7pEt9yMyRn+bcdGUrw97+vku9ytuJ7O9CtlHGPoczdPGdaB2yhc0EqGX
 zVzqcNoJ9lXvGajnUF1eMWiRh8ox+hZhACP7Li7mLqoW8PjgA/YokK9H80dPnA==
Message-ID: <11eddeafe60facdeac31779f36a7e4d52967bba3.camel@mailbox.org>
Subject: Re: [PATCH 03/10] drm/amdgpu: use dma_fence_test_signaled_flag()
From: Philipp Stanner <phasta@mailbox.org>
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch, 
 sumit.semwal@linaro.org, tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
Date: Tue, 30 Jun 2026 16:45:59 +0200
In-Reply-To: <20260624122917.2483-4-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-4-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: h6ibeto89pym1n4ypemmh4s8ym4z38jc
X-MBO-RS-ID: 1559734c5a0b76028f8
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-06-24 at 13:13 +0200, Christian K=C3=B6nig wrote:
> Instead of dma_fence_is_signaled_locked() use
> dma_fence_test_signaled_flag().
>=20
> The extra polling check seems unecessary for those use cases.

In this [1] recent discussion with Tvrtko I point out that we (i.e.,
DRM) would really greatly benefit from more verbose commit messages.
What is completely natural and self-explanatory to us might be far less
intuitive for those coming in 5 years.

You and I, we understand that dma_fence_is_signaled() can actively poll
a fence. I still think it is not intuitive, but it's a complex API. And
you personally also understand why an opportunistic poll is not
necessary for amdgpu. A new contributor, like a hacker who cares about
gaming on AMD hardware, who wants to help improve your driver, does not
know that.

Someone git-blaming one of those lines in a few years would just see
that a function was replaced with a function with a basically identical
name, and would not understand why the change was made.

The commit simply says "seems unnecessary". Why :)

I think fleshing it out more in the classical pattern (description of
current situation, description of the problem, then description of the
action the patch takes) is indeed more work for the author (to whom it
might appear like a waste of time to describe sth obvious), but would
also greatly benefit you personally, since it could reduce the amount
of times we have to tell folks "I don't know, there was a reason =E2=80=93 =
go
ask Christian" ;)


Gr=C3=BC=C3=9Fe,
Philipp


[1] https://lore.kernel.org/dri-devel/9f7fa57610d3d94324e09dc936f5f7f3c3d39=
0d3.camel@mailbox.org/


>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 8 ++++----
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
> =C2=A03 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index ea69b1bac7c6..1192b9800ff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -652,7 +652,7 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring=
 *ring, int error)
> =C2=A0
> =C2=A0		fence =3D rcu_dereference_protected(drv->fences[i],
> =C2=A0						=C2=A0 lockdep_is_held(&drv->lock));
> -		if (fence && !dma_fence_is_signaled_locked(fence))
> +		if (fence && !dma_fence_test_signaled_flag(fence))
> =C2=A0			dma_fence_set_error(fence, error);
> =C2=A0	}
> =C2=A0	spin_unlock_irqrestore(&drv->lock, flags);
> @@ -677,7 +677,7 @@ void amdgpu_fence_driver_force_completion(struct amdg=
pu_ring *ring,
> =C2=A0
> =C2=A0		fence =3D rcu_dereference_protected(drv->fences[i],
> =C2=A0						=C2=A0 lockdep_is_held(&drv->lock));
> -		if (fence && !dma_fence_is_signaled_locked(fence)) {
> +		if (fence && !dma_fence_test_signaled_flag(fence)) {
> =C2=A0			if (fence =3D=3D timedout_fence)
> =C2=A0				dma_fence_set_error(fence, -ETIME);
> =C2=A0			else
> @@ -738,7 +738,7 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct a=
mdgpu_ring *ring,
> =C2=A0		rcu_read_lock();
> =C2=A0		unprocessed =3D rcu_dereference(*ptr);
> =C2=A0
> -		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
> +		if (unprocessed && !dma_fence_test_signaled_flag(unprocessed)) {
> =C2=A0			fence =3D container_of(unprocessed, struct amdgpu_fence, base);
> =C2=A0			is_guilty_fence =3D fence =3D=3D guilty_fence;
> =C2=A0			is_guilty_context =3D fence->context =3D=3D guilty_fence->contex=
t;
> @@ -802,7 +802,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct a=
mdgpu_ring *ring,
> =C2=A0		rcu_read_lock();
> =C2=A0		unprocessed =3D rcu_dereference(*ptr);
> =C2=A0
> -		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> +		if (unprocessed && !dma_fence_test_signaled_flag(unprocessed)) {
> =C2=A0			fence =3D container_of(unprocessed, struct amdgpu_fence, base);
> =C2=A0
> =C2=A0			amdgpu_ring_backup_unprocessed_command(ring, fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index d6bee5c30073..ae9d6a2eefab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -460,7 +460,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ri=
ng, unsigned int vmid,
> =C2=A0		return false;
> =C2=A0
> =C2=A0	dma_fence_lock_irqsave(fence, flags);
> -	if (!dma_fence_is_signaled_locked(fence))
> +	if (!dma_fence_test_signaled_flag(fence))
> =C2=A0		dma_fence_set_error(fence, -ENODATA);
> =C2=A0	dma_fence_unlock_irqrestore(fence, flags);
> =C2=A0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a41fb72dba94..2cc6552a6399 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -426,7 +426,7 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_use=
rq_fence *fence,
> =C2=A0
> =C2=A0	f =3D rcu_dereference_protected(&fence->base,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_is_held(&fence_drv->fenc=
e_list_lock));
> -	if (f && !dma_fence_is_signaled_locked(f))
> +	if (f && !dma_fence_test_signaled_flag(f))
> =C2=A0		dma_fence_set_error(f, error);
> =C2=A0	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> =C2=A0}
