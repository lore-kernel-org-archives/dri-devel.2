Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE99CC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0171A10EDBF;
	Tue, 11 Aug 2026 21:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UC4BFU/l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28DE10EDBF
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:58:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EE47439CF;
 Tue, 11 Aug 2026 21:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D401F000E9;
 Tue, 11 Aug 2026 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485508;
 bh=wYMMMkUoPoL75RvjFFbxcpjBAhLoV3EaTvwKNkqTcQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UC4BFU/luTMhCMTTaOomvehjmubGDK/yJjkK0EszhaMkNzNSBCBc602f/8pPz3r0z
 a0BCaQDrg30urBfao4cT8dyjwPVyT1k1FOgvc9Y3lQh+1lrmC7DqIr5nB0hfY6jcp/
 7zAW2fYKuFMJmgFhJFM+vc2NKg6suNF+v7+pYpQKEXqy9ho5YBoay3dUPLXpw3XYVx
 GS8Jfefnqx0VIjZ6Aa6wZ09bfDQnT6zWldQhCmXsASedTAJPWYU4D4sU6bKJpi+L+l
 ikhOJjX6BpkL9kFI9Lw+dUupNthGrPA2f46ukLA6A8+K1vy1FZ3mWsCgMCw7s60NA1
 OG2grYKhPShuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-10-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-10-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:58:27 +0000
Message-Id: <20260811215828.00D401F000E9@smtp.kernel.org>
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
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition on timeout in=
 panfrost_perfcnt_enable_locked() causes MMU Address Space leak and use-aft=
er-free risk.
- [High] Incorrect handling of perfcnt->reset_failed causes MMU AS referenc=
e underflows and leaks.
- [Medium] State loss of reset notification flag in panfrost_perfcnt_dump_l=
ocked() due to premature clearing.
--

--- Patch [10]: [PATCH v5 10/11] drm/panfrost: Fix races between perfcnt an=
d reset sequence ---
Note: The format of this review has been altered to use a free-form summary
rather than inline diff quoting due to recitation restrictions.

commit 3ad1a2b0fa637dba7c60b8e41dbe3e3239112852
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Fix perfcnt reset sequence and expand dump uAPI

This commit modifies the Panfrost driver to use a reset read/write semaphore
to prevent race conditions during performance counter teardowns. It also
expands the DRM uAPI for the perfcnt dump operation to notify userspace if
a reset occurred, allowing it to handle counter resets properly.

[Severity: High]
Can this sequence cause an MMU Address Space leak and a use-after-free risk?

In panfrost_perfcnt_enable_locked() in
drivers/gpu/drm/panfrost/panfrost_perfcnt.c, the code locklessly checks
!perfcnt->reset_happened after the wait for completion times out.=20

If a GPU reset occurs between this lockless check and the acquisition of
pfdev->reset.lock at the err_vunmap label, the reset worker will see an act=
ive
session because perfcnt->user is not yet NULL. The reset worker would then
call panfrost_perfcnt_postreset(), allocating an AS reference and programmi=
ng
the GPU.=20

When the original thread subsequently acquires the lock, it clears
perfcnt->user and frees the buffer without calling panfrost_mmu_as_put().
Would this leave the GPU hardware active and writing to an unmapped buffer?

[Severity: Medium]
Does clearing the reset flag before the wait completes successfully cause
userspace to lose the reset notification?

In panfrost_perfcnt_dump_locked() in
drivers/gpu/drm/panfrost/panfrost_perfcnt.c, perfcnt->reset_happened is
destructively cleared to false before calling
wait_for_completion_interruptible_timeout().=20

If the wait is interrupted by a signal, it returns -ERESTARTSYS. The syscall
would be restarted, but since the reset_happened flag was already cleared,
the second attempt will falsely report to userspace that no reset occurred,
leading to incorrect accumulation of performance counters.

[Severity: High]
Could the current handling of perfcnt->reset_failed cause MMU AS reference
underflows or leaks?

In panfrost_perfcnt_postreset() in
drivers/gpu/drm/panfrost/panfrost_perfcnt.c, perfcnt->reset_failed is set to
true on failure, but it does not appear to be cleared on success.=20

If panfrost_mmu_reset() resets all AS counts to 0 and postreset fails,
panfrost_perfcnt_disable_locked() still unconditionally calls
panfrost_mmu_as_put() without checking if reset_failed is true. This drops
the count to -1 and triggers a WARN_ON.

Alternatively, if a subsequent reset occurs and postreset succeeds, the
failure to clear reset_failed means the next call to
panfrost_perfcnt_dump_locked() will see reset_failed as true and call
panfrost_perfcnt_hw_enable() again. This would double-acquire the AS, which
is only put once when disabled, leading to a permanent leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D10
