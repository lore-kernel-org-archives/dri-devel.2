Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8E0C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF7010E25D;
	Tue, 14 Jul 2026 17:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gwxRmJjZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F7D10E25D
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 17:12:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF92860103;
 Tue, 14 Jul 2026 17:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F1A1F000E9;
 Tue, 14 Jul 2026 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784049149;
 bh=fgp8GBIpmdr7Ir+yQHazeWmKiueDjQz8Y/z9VXgLylI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gwxRmJjZJ4eZw3rT4LwiJcnVraM9RxAy9fDr8M/6vg0KUv6kX7UY3mx+n2jS7CI9r
 t88Qa9OI+qghnSmlgKDTv+HywNC+PYISC8xYFAzISOnomdFYiHTbRbEy3ngs3vK6/f
 ygv1SsWATZ8PwZfa3bWJKLZmjE8BCttQUPbriw88uZRQMDogWKOZ2e3m1HvF8vJECd
 CFY2h0kb8imK+d4v8YFpmRM8Bf9NbBtCsXY1CYQvEuL2v07rBaEGs3XYGag9oXmJHV
 BJpcIQg8yqomTR0vjZHyvsNpJBxBzVtMU11ZBX6btO0Hs0/meA/t+mb1qOM/xsg5k3
 MRs62BfHLQ0Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gpusvm: Fix MM reference leak in
 drm_gpusvm_range_evict
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714170025.3487974-1-matthew.brost@intel.com>
References: <20260714170025.3487974-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:12:29 +0000
Message-Id: <20260714171229.72F1A1F000E9@smtp.kernel.org>
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
- [High] The timeout loop in drm_gpusvm_range_evict can return 0 (success) =
without doing any work, or return -EBUSY instead of -ETIME on timeout.
--

--- Patch [1]: [PATCH] drm/gpusvm: Fix MM reference leak in drm_gpusvm_rang=
e_evict ---
commit 288b0fd8ba30a0ce9832357a667252b6d60749ce
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict

This commit fixes a reference leak in drm_gpusvm_range_evict(). It drops the
MM reference on the kvmalloc_array() failure path.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..9e02a33659d43 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1732,8 +1732,10 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpus=
vm,
>  		return -EFAULT;
> =20
>  	pfns =3D kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> -	if (!pfns)
> +	if (!pfns) {
> +		mmput(mm);
>  		return -ENOMEM;
> +	}
> =20
>  	hmm_range.hmm_pfns =3D pfns;
>  	while (!time_after(jiffies, timeout)) {

[Severity: High]
This is a pre-existing issue, but can this loop return 0 (success) without
doing any work if the timeout expires during the memory allocation?

The timeout is computed before calling kvmalloc_array() with GFP_KERNEL. If
memory pressure causes the allocation to block longer than the timeout,
this loop condition will evaluate to false immediately, and the function
will exit returning err =3D 0.

Additionally, if hmm_range_fault() returns -EBUSY and the timeout is
subsequently reached, the loop terminates here and incorrectly returns
-EBUSY rather than -ETIME.

Would it be safer to compute the timeout after the kvmalloc_array() call,
or check the expiration condition after the loop to ensure the correct error
code is returned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714170025.3487=
974-1-matthew.brost@intel.com?part=3D1
