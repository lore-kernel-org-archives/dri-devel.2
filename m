Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A43C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A014E10F265;
	Fri, 24 Jul 2026 00:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IGTX8W2u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EBF10F265
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:12:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48EFD600AD;
 Fri, 24 Jul 2026 00:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50B51F00A3A;
 Fri, 24 Jul 2026 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784851975;
 bh=wRwUm8xmuHAmD5h6VHqmX9r/QAuQtSuvpzTQOouachM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IGTX8W2uth93XKmUKFAVnw0O1q9RmWntrLZaW16eS9l5jzpW4VltaiBUxZjpbB61l
 Et5YlZDN450K3i3m6aBcr0HmotWeQGyxyidT/0NSU8Sep/woNGA6gOsgLnDZdBCRKp
 /BPxSLTanzG+fFmA5wZt1xYd5369I08jjXkTyLs5ihnWZ+T9HT501/JLRi7SQpghCJ
 dkvRaaDFIn5mQEr6bi2IfJGVKeNEODtAGOu7pf7TFKD5ejLL7rl6ZYenfLA44WbkyF
 6X5cxr0FK9a7DijFNnU5QlMOUBiQQScnuwxJ3KREvPrTTvG5ahGPvOHcj7t54vtPd7
 hupCtMwM0a0cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-12-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-12-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:12:54 +0000
Message-Id: <20260724001254.D50B51F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Adding a field to `struct drm_panfrost_perfcnt_dump` breaks UA=
PI ABI compatibility.
- [High] Ignored return value of `panfrost_perfcnt_hw_enable()` causes MMU =
Address Space refcount imbalance and hardware enablement failure.
- [High] Missing `reinit_completion()` inside the retry loop causes prematu=
re success returns with incomplete data.
- [High] The dump retry logic uses an unsigned integer for a `>=3D 0` check=
, creating an infinite loop.
- [Medium] Early return in `panfrost_perfcnt_reset()` prevents `panfrost_pe=
rfcnt_enable_locked()` from surviving a concurrent reset.
- [Medium] A TOCTOU race in `panfrost_perfcnt_dump_locked()` can conceal ha=
rdware reset events from userspace.
- [Medium] `synchronize_irq()` is called before the GPU interrupt source is=
 masked.
--

--- Patch [12]: [PATCH v3 12/13] drm/panfrost: Fix races between perfcnt an=
d reset sequence ---
Note: The format of this report has been altered due to recitation
restrictions. Instead of providing inline diff quotes, this report provides=
 a
free-form summary of the findings.

commit 636e7ce6a7687c01b696bf2f1a79d4f8987d7340
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Fix races between perfcnt and reset sequence

This commit introduces a reset lock to govern hardware access during
performance counter operations. It also expands the DRM uAPI for the=20
perfcnt DUMP operation to notify userspace of hardware resets, and ensures
performance counter configuration is restored after a reset completes.

[Severity: Critical]
Adding the hw_reset field to struct drm_panfrost_perfcnt_dump changes its
size, and the ioctl macro is updated from DRM_IOW to DRM_IOWR. Does this
alter the generated ioctl number for DRM_IOCTL_PANFROST_PERFCNT_DUMP and
break backwards compatibility for existing userspace binaries?

[Severity: High]
In panfrost_perfcnt_enable_locked(), the return value of
panfrost_perfcnt_hw_enable() is ignored. Since panfrost_perfcnt_hw_enable()
can return an error if panfrost_mmu_as_get() fails to find a free Address
Space slot, will ignoring this error cause the subsequent teardown in
panfrost_perfcnt_disable_locked() to unconditionally call
panfrost_mmu_as_put() and trigger a refcount underflow?

[Severity: High]
In panfrost_perfcnt_dump_locked(), reinit_completion() is called outside the
dump_retry loop. If a hardware reset occurs just after the wait times out,
the reset handler calls complete(). Won't the next wait attempt inside the
retry loop see a positive done count and return immediately without actually
waiting for the new sample?

[Severity: High]
Also in panfrost_perfcnt_dump_locked(), the loop counter retries is declared
as a u64. Since it is an unsigned integer, won't the retry check
(--retries >=3D 0) wrap around to U64_MAX and always evaluate to true,
creating an infinite loop if the GPU undergoes continuous resets?

[Severity: Medium]
In panfrost_perfcnt_reset(), there is an early return if !perfcnt->user.
However, panfrost_perfcnt_enable_locked() expects reset_happened to be
updated to handle timeouts gracefully. Since perfcnt->user is not assigned
until after the wait completes in the enable function, won't a concurrent
reset hit this early return and fail to update reset_happened, causing an
unintended -ETIMEDOUT error?

[Severity: Medium]
In panfrost_perfcnt_dump_locked(), the *reset_happened flag exported to
userspace is only updated on the very first iteration of the retry loop. If=
 a
reset is detected by the atomic_cmpxchg check and the loop retries, will
userspace remain unaware of the reset if the second dump attempt succeeds?

[Severity: Medium]
In panfrost_device_reset(), panfrost_perfcnt_reset() is called, which then
calls synchronize_irq(pfdev->gpu_irq). However, the GPU interrupts are not
masked until panfrost_gpu_soft_reset() is executed on the following line.
Can the GPU raise a new interrupt immediately after synchronize_irq() retur=
ns
and before the mask is applied?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D12
