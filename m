Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421C7C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3618810E51C;
	Thu, 27 Aug 2026 15:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hC/hnA2X";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337D710E513;
 Thu, 27 Aug 2026 15:29:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6125B600D2;
 Thu, 27 Aug 2026 15:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E6E1F000E9;
 Thu, 27 Aug 2026 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787844596;
 bh=aHK/HZzsKzlEw6KHxTYsXjb3SLL6O21BDMqAnE354bo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hC/hnA2XgXiDbdb/Vk6zlHeOTKhY2vrEwp9SJQ1ZzDKbm9V7HUNRilk96bePsSvm0
 8jBKehNYKCrOO8RxgOJTjoDXTCHiOzFIA0zBb9rytLdUKeFm0HAd1dLmRkxxKl7pMC
 AuXAIEy70FmljdykQHPd30sMGGf1R3Bey379VtlFQfRZ3WK8kdwnQEiAkIa2xoZif2
 1C0ojRKwhoiaFlXW9XCF0oFw+bkMbce8X02H1QyDvE1UzDY9+mLLDKO5lfkrh8sZYI
 oIk9ELkL0NW8ST1fU6lwT2XEnrN2z8kfj4AasAyoVQiN+koznItmJX5vgSQzFHCo9v
 N1HkATNO8rK8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm: Add common drm_user_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827151950.4080674-2-srinivasan.shanmugam@amd.com>
References: <20260827151950.4080674-1-srinivasan.shanmugam@amd.com>
 <20260827151950.4080674-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:29:55 +0000
Message-Id: <20260827152955.D2E6E1F000E9@smtp.kernel.org>
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
- [High] Memory leak of `drm_user_fence`, `mm_struct`, and `dma_fence` when=
 a pending work item is successfully cancelled.
--

commit 922879f241f70a69a977d292a4790f93e66ca3e2
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add common drm_user_fence helper

This commit introduces a common DRM user fence helper that provides a
kref-managed, MM-borrowing dma-fence-callback-to-workqueue pattern. This
allows drivers to access userspace memory from a kthread context when a
GPU fence signals.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> new file mode 100644
> index 0000000000000..5e6d4c1071306
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c
[ ... ]
> +void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
> +{
> +	drm_user_fence_cancel(ufence);
> +	cancel_work_sync(&ufence->work);

[Severity: High]
Can ignoring the return value of cancel_work_sync() cause a memory leak
of the drm_user_fence, mm_struct, and an extra dma_fence reference?

If a user arms a user fence and the hardware signals it, the signal
callback drm_user_fence_cb() queues the work item. If the user then tears
down the object before the work item executes, drm_user_fence_cancel_sync()
is called.

If cancel_work_sync() successfully dequeues the pending work, it returns
true, and drm_user_fence_work() will never run. This means the call to
drm_user_fence_put() at the end of drm_user_fence_work() is skipped:

static void drm_user_fence_work(struct work_struct *w)
{
    ...
    drm_user_fence_put(ufence);
}

Leaking the mm_struct pins memory, and leaking the dma_fence can prevent GPU
resource cleanup.

Would it be safer to check the return value and drop the reference?

	if (cancel_work_sync(&ufence->work))
		drm_user_fence_put(ufence);

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827151950.4080=
674-1-srinivasan.shanmugam@amd.com?part=3D1
