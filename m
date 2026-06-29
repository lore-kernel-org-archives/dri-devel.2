Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30721C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 03:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3E710E004;
	Mon, 29 Jun 2026 03:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibOhiVmR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205AA10E004
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:23:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCA2A40419;
 Mon, 29 Jun 2026 03:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEDD1F000E9;
 Mon, 29 Jun 2026 03:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782703423;
 bh=JT/iyyUL++TKCaPcU07oNXisD4zoxLG58GGkh5k6eKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ibOhiVmR35Q77dqnt+cEX3nkgl1h5xydrSaDOZkHKaqidtv8yQQh+3MBDF+wVnnTt
 nQTrXerW77jqRdCipFTi/9c2TaGFC0FeePye3T0BxqHaI2WZxr5mqQaTVrMLzRgije
 mCqodi68Qa25cKDkehH4LQyLtsTNSYtYySG9v8DaYRl43NWafCMZf3JMyqrVsbZY7Z
 BmiOifJ/M9AMCNzIb5tnSx61Ls5N3vruONrRLs6Py2o9HbruYuP/3e8GMptYjWUp+S
 FrhbuGcDI9APsaPbss0IC++GvmeenRce+zXBQatT45VdZ/yrpA2mRXfRdKLp7hhAO3
 E6ZkMHrJhKtHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against
 0-count input
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629031346.3875683-1-shoubaineng@gmail.com>
References: <20260629031346.3875683-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 03:23:42 +0000
Message-Id: <20260629032343.0EEDD1F000E9@smtp.kernel.org>
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
- [Critical] The commit message incorrectly claims that all in-tree callers=
 pre-filter the `num_fences =3D=3D 0` case. In reality, `amdgpu_userq_wait_=
return_fence_info()` can and does pass 0, meaning this patch actually fixes=
 a critical pre-existing use-of-uninitialized-memory vulnerability.
--

commit a22db32a014bd90abd28aebf26a5fc39ddb4a3cc
Author: Baineng Shou <shoubaineng@gmail.com>

dma-fence: Make dma_fence_dedup_array() robust against 0-count input

This commit updates dma_fence_dedup_array() to handle an input of 0 fences
by returning 0 early. It also explains how the previous implementation
incorrectly returned 1, which could lead to dereferencing uninitialized
fence slots in arrays.

> All in-tree callers currently filter num_fences =3D=3D 0 before invoking
> this helper (__dma_fence_unwrap_merge() bails out via the
> `if (count =3D=3D 0 || count =3D=3D 1)` fast path; amdgpu_userq_wait_*()
> cannot reach the dedup call with a zero local count because the
> amdgpu_userq_wait_add_fence() helper guarantees num_fences stays in
> [0, wait_info->num_fences], and wait_info->num_fences > 0 is enforced
> at the ioctl entry).

[Severity: Critical]
This is a pre-existing issue, but the commit message claims that all
in-tree callers pre-filter the num_fences =3D=3D 0 case. Is this description
accurate?

Looking at amdgpu_userq_wait_return_fence_info() in
drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c, if a user calls the ioctl
with wait_info->num_fences > 0 but with no actual handles, the local
num_fences variable will remain 0.

Prior to this patch, dma_fence_dedup_array(fences, 0) returned 1:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:amdgpu_userq_wait_return_fe=
nce_info() {
    ...
    num_fences =3D dma_fence_dedup_array(fences, num_fences);
    ...
}

This causes the subsequent loop to read fences[0], which contains
uninitialized kernel heap data from kmalloc_array(), and pass it to
dma_fence_wait():

drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:amdgpu_userq_wait_return_fe=
nce_info() {
    ...
    for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
        ...
        r =3D dma_fence_wait(fences[i], true);
    ...
}

Does this mean this patch actually fixes a pre-existing
use-of-uninitialized-memory regression that could lead to arbitrary code
execution?

If so, should this commit message be updated to reflect it is a security
fix and include a Cc: stable tag for backporting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629031346.3875=
683-1-shoubaineng@gmail.com?part=3D1
