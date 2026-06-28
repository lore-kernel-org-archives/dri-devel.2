Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85C7C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D9110E4D9;
	Sun, 28 Jun 2026 14:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fpR7Q9V9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113A710E4D9
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:22:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50ADF60052;
 Sun, 28 Jun 2026 14:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC8A1F000E9;
 Sun, 28 Jun 2026 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782656575;
 bh=daVeP4WePQywLcnsTSHeu8H50li7/rXA+gwRhKzXkNg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fpR7Q9V9X5OeM7wICXOsdRekXOhxPww5M7as+j0b6JXL8BbIR8yLd8szWWtxnQBPJ
 rAQ0lcVX7jCPwNNyx51mHx0cU1xvioGp9F76lGC7/NVs7PPiLrW5t1n25r6t3/H8PK
 /NAICkU0dKLPh60KoLd6O45I6J30oTtLMp3mMBEu/ywPjdV5yU3+tLGQs8l9J0DjVn
 kn6ceTSeOng2a6beKFjzj9u7cR3RA1Z6VID8qjUE8tNM+NdJM0/AlPuZ/0iGJoCcXi
 03gmswqaYV7wtdz2eUwSr//KYMkYtm7mW6kueBZ/4AfN5YhuL0h7invAK0grZdvkZ8
 Qwj1wM0d0Iswg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915: fix kref leak in __live_active_setup error
 path
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628140327.46842-1-vulab@iscas.ac.cn>
References: <20260628140327.46842-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:22:54 +0000
Message-Id: <20260628142254.CFC8A1F000E9@smtp.kernel.org>
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
- [Medium] Memory leak of live_active object and preallocated barrier nodes=
 in live_active_barrier error path.
- [Medium] Memory leak of heap-allocated fence `submit` on multiple error p=
aths inside live_hwsp_read.
--

commit 7023619d481f3e0e660c2bb0c854c33e4fd279ed
Author: WenTao Liang <vulab@iscas.ac.cn>

drm/i915: fix kref leak in __live_active_setup error path

When heap_fence_create fails, the early error path calls kfree(active)
directly instead of __live_put(active), bypassing the kref_put path that
would call i915_active_fini for proper resource teardown. This skips
cleanup of the i915_active state while the initial kref from kref_init
remains unbalanced.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

> diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/d=
rm/i915/selftests/i915_active.c
> index 9fea2fabeac48..8ec7859da7626 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_active.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_active.c
> @@ -91,7 +91,7 @@ __live_active_setup(struct drm_i915_private *i915)
> =20
>  	submit =3D heap_fence_create(GFP_KERNEL);
>  	if (!submit) {
> -		kfree(active);
> +		__live_put(active);
>  		return ERR_PTR(-ENOMEM);
>  	}
> =20

[ ... ]

> @@ -221,11 +221,11 @@ static int live_active_barrier(void *arg)
>  	for_each_uabi_engine(engine, i915) {
>  		err =3D i915_active_acquire_preallocate_barrier(&active->base,
>  							      engine);
>  		if (err)
>  			break;
> =20
>  		i915_active_acquire_barrier(&active->base);
>  	}
> =20
>  	i915_active_release(&active->base);
>  	if (err)
>  		goto out;

[Severity: Medium]
This is a pre-existing issue, but does this loop exit on error and jump to =
out:,
skipping the __i915_active_wait() call?

If i915_active_acquire_preallocate_barrier() fails after at least one succe=
ssful
iteration, the preallocated proto-nodes added in previous iterations are ne=
ver
flushed or signaled.

This means active->base.count never reaches 0, which prevents __live_retire=
 from
being called and leaks the initial kref.

> diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/dr=
m/i915/gt/selftest_timeline.c
> --- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
> @@ -1026,10 +1026,10 @@ static int live_hwsp_read(void *arg)
>  		do {
>  			struct i915_sw_fence *submit;
>  			struct i915_request *rq;
>  			u32 hwsp, dummy;
> =20
>  			submit =3D heap_fence_create(GFP_KERNEL);
>  			if (!submit) {
>  				err =3D -ENOMEM;
>  				goto out;
>  			}
> =20
>  			err =3D create_watcher(&watcher[0], engine, SZ_4K);
>  			if (err)
>  				goto out;

[Severity: Medium]
This isn't a bug introduced by this patch, but can this leak the heap-alloc=
ated
submit fence?

If any subsequent setup step inside the loop fails (like create_watcher() h=
ere),
the code jumps to the out: label outside the loop.

Since submit is a local variable inside the loop, and the cleanup code at o=
ut:
does not free it, this looks like a permanent leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628140327.4684=
2-1-vulab@iscas.ac.cn?part=3D1
