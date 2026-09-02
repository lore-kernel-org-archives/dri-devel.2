Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1AFC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 01:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD4510E428;
	Wed,  2 Sep 2026 01:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jc4AQdEf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0D710E428
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 01:39:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2982600D4;
 Wed,  2 Sep 2026 01:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624C61F000E9;
 Wed,  2 Sep 2026 01:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788313192;
 bh=MKk3zq+Ap83K1L4l5wFZFHae11rKt7mfW9apOEW5Jnw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jc4AQdEfPMB7dmIhCJs7AnZeVeEChL/1HbrF+jD+/FPUr6JEp+uHD8Kd/a2L8tD1V
 BYSsnVOVs7q/6JAGAo3UbdtrJUSVloz7ux8rqvJFQUfAlgd0zGo4y4mYUDqSUEKV1f
 OcrXy3/jkk+D6jvDidGAQ3so77oCK1u6vUt2tyAgL/ym19IWVK5LYWjDtBjVzxap9J
 vJS5KdFk/DSG26obqBMvNt9Qsv1fCo1De+44g5ug3xa/zgrmnxpjt1wqoLnahn6X0F
 N3il6kgk47eBxGLlr4aw5jyk6DD3FRZhEZzV75QwGgvAnrJLPkz8XumowZOvBxN9nF
 /AV4Z6JzEPb+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: RCU-free the scheduler-containing
 nouveau_sched
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902012717.880724-1-malhyuk97@gmail.com>
References: <20260902012717.880724-1-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:39:51 +0000
Message-Id: <20260902013952.624C61F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free (Incomplete Fix)
--

commit a4cb3c10462917197ec6f8cdfe7a265ad10ef18a
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

drm/nouveau: RCU-free the scheduler-containing nouveau_sched

This commit attempts to fix a use-after-free issue by deferring the freeing
of the scheduler object to an RCU callback.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/no=
uveau/nouveau_sched.c
> index 8b9f935afe094..b3f02c490ecb6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
> @@ -517,7 +517,7 @@ nouveau_sched_destroy(struct nouveau_sched **psched)
>  	struct nouveau_sched *sched =3D *psched;
> =20
>  	nouveau_sched_fini(sched);
> -	kfree(sched);
> +	kfree_rcu(sched, rcu);

[Severity: High]
This isn't a bug introduced by this patch, but does this actually fix the
underlying use-after-free issue?

Using kfree_rcu() only defers freeing the scheduler by a single RCU grace
period. However, dma_fence objects exported to userspace (e.g., via
sync_file) can outlive this grace period since userspace controls the file
descriptor lifetime.

When userspace eventually queries the fence info, sync_fill_fence_info()
acquires a new rcu_read_lock() and calls dma_fence_timeline_name(), which
invokes drm_sched_fence_get_timeline_name():

drivers/gpu/drm/scheduler/sched_fence.c:drm_sched_fence_get_timeline_name()=
 {
    ...
    return (const char *)fence->sched->name;
}

Because the nouveau_sched memory is physically freed after the initial RCU
grace period elapses, this new RCU read-side critical section does not
protect it. Won't this unconditionally dereference fence->sched->name on
the already-freed memory, resulting in the exact same use-after-free read
this patch intends to fix?

> =20
>  	*psched =3D NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902012717.8807=
24-1-malhyuk97@gmail.com?part=3D1
