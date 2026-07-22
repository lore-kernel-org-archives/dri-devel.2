Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C1C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507AF10ECA7;
	Wed, 22 Jul 2026 07:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVOWFxNB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF4C10ECA7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:33:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D90743C57;
 Wed, 22 Jul 2026 07:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569E81F000E9;
 Wed, 22 Jul 2026 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784705629;
 bh=L2ae8DNWor28g6YUgskPHUqW438n4E1i42D3ZfLf3cU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SVOWFxNBO0GFp6780X9vQVPoqXQgzPVnvtAjxwrg5cdm6g8ccYfnUCp9cvjuA+P2s
 kO5b6OTyiaZL1GEBt0pE07s7OuhFDozo7U21bkh5LDfTNGInMoWWry/zZDfczgKInF
 y2XIjCOJd3ja/bn/WXaUNLb3vt4uXLgIO3jdMb7/sefiLHLFjDfB4D/sEFLxxS6FnE
 5FVBj0iJdesFmGQrH8oIoeTD00EwBWiQYptBRsX6Or3FsFH2jSrWL7rVM8APIpiXdF
 L7uqf6vFze9pFkVqv/aQkUQCmlfkEcAjcXEl+VNuf+BO038XLgphphqcJEED+dhPiL
 n2y2YbP+5TZdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915: Replace sleep with GT idle wait
To: "Andi Shyti" <andi.shyti@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722072228.1080796-1-andi.shyti@linux.intel.com>
References: <20260722072228.1080796-1-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:33:48 +0000
Message-Id: <20260722073349.569E81F000E9@smtp.kernel.org>
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
- [High] Deadlock and Livelock in Shrinker Context due to Unbounded Wait
- [High] Interruptible Wait Context Bypasses Idle Check on Process Teardown
- [Medium] Logical Flaw / Unprotected Race Condition
--

--- Patch [1]: [PATCH] drm/i915: Replace sleep with GT idle wait ---
Note: Due to recitation restrictions, this review uses a free-form summary
format instead of inline diff quoting.

commit bab9a6699de3297b57259875ce548885d879b359
Author: Andi Shyti <andi.shyti@linux.intel.com>
drm/i915: Replace sleep with GT idle wait

This patch replaces the short sleep in i915_gem_gtt_finish_pages() with
a call to intel_gt_wait_for_idle() to wait for the GT to become idle before
unmapping DMA pages.

[Severity: High]
When i915_gem_gtt_finish_pages() is called from the i915 memory shrinker
during direct reclaim, could the unbounded intel_gt_wait_for_idle() result
in a livelock?=20

If direct reclaim is triggered by an allocation in __i915_request_create(),
the thread may already hold tl->mutex. The shrinker calls
intel_gt_wait_for_idle(), which loops over
intel_gt_retire_requests_timeout(). The retire function will attempt a
mutex_trylock(&tl->mutex), fail because the current thread holds it,
increment active_count, and return MAX_SCHEDULE_TIMEOUT. This appears to
cause the while loop in intel_gt_wait_for_idle() to spin infinitely without
sleeping.

Additionally, does waiting on dma-fences during memory reclaim violate
lockdep fs_reclaim rules, since fence signaling can depend on memory
allocations?

[Severity: High]
Could the use of intel_gt_wait_for_idle() bypass the intended delay during
process teardown?=20

The intel_gt_wait_for_idle() function checks signal_pending(current) and
aborts immediately with -EINTR. If a process holding GPU objects receives a
fatal signal like SIGKILL, signal_pending will be true.=20

Since i915_gem_gtt_finish_pages() falls through and proceeds even when the
wait fails, it will call dma_unmap_sg() immediately. This means the DMA
pages could be unmapped while the GPU pipeline is still actively executing,
bypassing the delay that the previous uninterruptible usleep_range()
provided.

[Severity: Medium]
Does this change completely close the race condition it aims to fix?

The patch removes the comment acknowledging that more requests can be
submitted, but it appears there is no locking or GT suspension between the
idle check returning and the unmap operation executing.=20

As soon as intel_gt_wait_for_idle() returns, could a concurrent thread
immediately submit new requests before dma_unmap_sg() is actually called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722072228.1080=
796-1-andi.shyti@linux.intel.com?part=3D1
