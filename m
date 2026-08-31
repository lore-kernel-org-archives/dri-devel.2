Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A78C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6511410E318;
	Mon, 31 Aug 2026 17:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J4SCZw3O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D4A10E318
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:20:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 347B24361D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCC51F000E9;
 Mon, 31 Aug 2026 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788196853;
 bh=XHigNdqYLNwk+KtJHwzLFPr6aBI/uoujNKfEtSlx7bc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J4SCZw3OUoEHiN8CnOc6pOy3Igt98776Cei2vT4fUI3MGR5jhL8IRnTGspe5HyNuE
 IALcNA5aBBZ5TZfKCIc/+sMp0bA9FwFCmri8j71LpC+KR3T2QI3Xczhrermr487GWy
 vJh44z8cjWDSNjevTfUn+iBnqZYAedBjsGkZtpKa0Zc7HjxB55KF81qZUNkTGXJ15A
 GSEZrEPq4z5bgPnI+AvOPKt/a8Helrdvyu7v7zp++y82EMEGj7x7xQNmwDZzaDBp9K
 Zs5vxbGBSCOP6qcFmvtxth57YtRpOpUUbOxj6lQpzmtC1rhIXZXtqpz0n2jSMxRlri
 biXWtYnoSHBtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amdgpu: use atomic operation to
 achieve lockless serialization
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-593-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-593-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:20:52 +0000
Message-Id: <20260831172052.ECCC51F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but dma_fence_is_sig=
naled_locked() is called without holding the required fence lock, leading t=
o a severe locking violation.
--

commit e72ef6207a108e0a367f5094ba262069966bfe78
Author: Sunil Khatri <sunil.khatri@amd.com>

drm/amdgpu: use atomic operation to achieve lockless serialization

This commit fixes a race condition in amdgpu_seq64_alloc where multiple cor=
es
could acquire the same free slot. It replaces non-atomic bit operations with
atomic test_and_set and clear operations.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_seq64.c
> index a0b479d5fff19..f4be192235889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:amdgpu_userq_fence_driver_s=
et_error():

	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);

	f =3D rcu_dereference_protected(&fence->base,
				      lockdep_is_held(&fence_drv->fence_list_lock));
	if (f && !dma_fence_is_signaled_locked(f))
		dma_fence_set_error(f, error);
	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but dma_fence_is_signaled_locked=
()
is called here without holding the required fence lock.

Is it safe to call dma_fence_is_signaled_locked() without holding the actual
fence lock (&userq_fence->lock)?

The function may internally invoke dma_fence_signal_locked(), which modifies
the fence state and iterates over wait callbacks without protection. Could =
this
cause race conditions and list corruption if another thread concurrently
accesses the fence?

Could this also trigger a kernel lockdep splat because
dma_fence_signal_locked() asserts that the lock is held?

Additionally, does the preceding rcu_dereference_protected(&fence->base)
irregularly pass a non-RCU pointer to an inline struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-593-sashal@kernel.org?part=3D1
