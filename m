Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78688C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16C610F06B;
	Thu, 27 Aug 2026 13:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oWh6vp51";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B19610F066;
 Thu, 27 Aug 2026 13:43:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AA62601EE;
 Thu, 27 Aug 2026 13:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766561F000E9;
 Thu, 27 Aug 2026 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787838210;
 bh=Tih5XzUwZEk1Mg+zRvMCSzhGeySMm1Q2dOD8ruF2zWg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oWh6vp51hn2hK2Zc52vMpmH3WaygNs0S+vMoysLIwKfwYUZ5R4MRz4sWR2b3ZDBsw
 5VvHzMGlMnA0Eyw3mbVqFBbLs14WNsEXfEbdqJTAUZ5h9iHDnYBX+LFG99d/B0ybHk
 3yXfpEEQskB5Yw6trd+uIMHX0db5yIxtG0hnZODb9jWJa2pfovKxDP8xcsttkkV65N
 CX92r3bPo5TfTKhEpuUy8HhoYAk++Ndxl1Nyvl9GRoAQtoyUypgUWnze/7itPlGFkd
 bRdRWsKO75Clli36tnhotYWpVcuKQZxV2xDB1BC0xk2KseL9BwUZjjLQzDmAMETK6H
 A7nbNBm6SDfvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm: Add common drm_user_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org
In-Reply-To: <20260827133226.4076593-2-srinivasan.shanmugam@amd.com>
References: <20260827133226.4076593-1-srinivasan.shanmugam@amd.com>
 <20260827133226.4076593-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:43:30 +0000
Message-Id: <20260827134330.766561F000E9@smtp.kernel.org>
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
- [High] drm_user_fence_cancel() causes a Use-After-Free if the fence has s=
ignaled, because it requires the caller to pass a fence pointer without req=
uiring the caller to hold a separate reference.
- [High] Contradictory documentation in drm_user_fence_cancel() instructs t=
he caller to put references that the function already puts internally, lead=
ing to double-free bugs.
--

commit dfafc94b5c524854a64ed37e415adef39795ad80
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add common drm_user_fence helper

This commit introduces a common DRM user fence helper providing a pattern
to access userspace memory from a kthread context when a GPU fence signals.
It implements a kref-managed, dma-fence-callback-to-workqueue pattern that
borrows the process MM.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> new file mode 100644
> index 0000000000000..a3b14245163ae
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c

[ ... ]

> +/**
> + * drm_user_fence_cancel - Cancel a pending user fence callback
> + * @ufence: user fence
> + * @fence: the same dma-fence passed to drm_user_fence_add_callback()
> + *
> + * Attempts to remove the pending callback before driver context teardow=
n.
> + * Must be called before the driver tears down its workqueue or ops.
> + *
> + * If the callback has already fired this is a no-op and returns false.
> + * If removal succeeds the caller must call drm_user_fence_put() to
> + * release the reference taken by drm_user_fence_add_callback(), and
> + * must also call dma_fence_put() to release the fence reference that
> + * was transferred at add_callback time.

[Severity: High]
The kernel-doc instructions here state that the caller must call
drm_user_fence_put() and dma_fence_put() upon success.

However, looking at the implementation of drm_user_fence_cancel() below,
it internally executes dma_fence_put() and drm_user_fence_put() before
returning true.

If a driver strictly follows this documentation, will it lead to double-free
bugs when they try to drop the references again?

> + *
> + * Return: true if callback was removed, false if it had already fired.
> + */
> +bool drm_user_fence_cancel(struct drm_user_fence *ufence,
> +			   struct dma_fence *fence)
> +{
> +	if (dma_fence_remove_callback(fence, &ufence->cb)) {

[Severity: High]
Can this result in a use-after-free if the fence has already signaled?

According to the drm_user_fence_add_callback() design, the caller transfers
its fence reference to the callback. If the fence signals asynchronously, t=
he
callback fires and internally drops that reference via dma_fence_put(). If
that was the last reference, the fence object is freed.

When the driver later initiates teardown and calls drm_user_fence_cancel(),
it passes this potentially dangling fence pointer to
dma_fence_remove_callback(), which dereferences it to acquire a spinlock.

Is there a way for the caller to safely cancel the callback without taking
and holding an additional reference to the fence?

> +		dma_fence_put(fence);
> +		drm_user_fence_put(ufence);
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_cancel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827133226.4076=
593-1-srinivasan.shanmugam@amd.com?part=3D1
