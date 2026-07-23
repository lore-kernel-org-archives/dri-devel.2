Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F781C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A6310E4D9;
	Thu, 23 Jul 2026 17:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jE3u7Xv1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4C710E4D9
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 308B94005C;
 Thu, 23 Jul 2026 17:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12221F000E9;
 Thu, 23 Jul 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784829259;
 bh=4a3WCBaF2d54wq/QflDBhU3ZrKf7L+sZt6qilimb1w4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jE3u7Xv1imYw3t4h4RrdPM1HIrsb+M+SO3Y/fxY29QjeFTHMi1zlhMoGgeXcyP3Zy
 +cB49+x0E/+khvdpNTZXNaBfXNQUhdaviowL0YURc811yION+ib7G6WIWWG0kTY1lK
 LBPWM2UXlfw3cXWuK2etZ6uIQxLvzE6kgAJX6L44EAGu0VvPP7h+agJf/4MIEsh+08
 tNvl3O0UfHHgWPlrVKgkq+mrh4CnoHponlk44qRu8MUczzrCW2b781zNmxd/hqSl2U
 xJp8E4g8jWVxQNOhNFX6Rq49Xut/rBJdHrONazRalT8bUeXLankds0TfhUZB8/cmwZ
 bQBknHH08qKfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260723-hmm-v10-v11-8-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723-hmm-v10-v11-8-c55b003a4b61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:54:18 +0000
Message-Id: <20260723175418.D12221F000E9@smtp.kernel.org>
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
- [High] Missing `mmput()` on the `pfns` allocation failure path causes an =
`mm_struct` refcount leak.
--

--- Patch [8]: [PATCH v11 8/8] drm/gpusvm: Use hmm_range_fault_unlocked_tim=
eout() for range faults ---
commit 83e2ac7a16c88b9dee7c9dc0f7c00f0dcd69b81d
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

drm/gpusvm: Use hmm_range_fault_unlocked_timeout() for range faults

This commit replaces open-coded HMM fault loops that hold the mmap read lock
with the hmm_range_fault_unlocked_timeout() helper. It delegates the lock
acquisition and retry logic to the helper while maintaining the existing
timeout budgets.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..e912e994beb21 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1736,24 +1708,12 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpu=
svm,
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this allocation failure path leak the
mm_struct reference?

In drm_gpusvm_range_evict() in drivers/gpu/drm/drm_gpusvm.c, earlier in this
function mmget_not_zero(mm) successfully acquires a reference to the mm. If
the subsequent kvmalloc_array() call fails, the function immediately returns
-ENOMEM.

Should there be an mmput(mm) before returning to prevent leaking the
mm_struct reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-hmm-v10-v1=
1-0-c55b003a4b61@gmail.com?part=3D8
