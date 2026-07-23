Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C188C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913F210E076;
	Thu, 23 Jul 2026 18:10:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D8A10E076
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:10:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FAB4600AD;
 Thu, 23 Jul 2026 18:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6FC1F000E9;
 Thu, 23 Jul 2026 18:10:45 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/gpusvm: Zero HMM PFNs before scanning ranges
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-drm-gpusvm-fixes-v3-1-4346a61d093a@gmail.com>
References: <20260723-drm-gpusvm-fixes-v3-1-4346a61d093a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:10:43 +0000
Message-Id: <20260723181045.9F6FC1F000E9@smtp.kernel.org>
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
- [Medium] Incomplete fix: drm_gpusvm_scan_mm() still passes uninitialized =
memory to hmm_range_fault()
--

--- Patch [1]: [PATCH v3] drm/gpusvm: Zero HMM PFNs before scanning ranges =
---
commit 94c866dacf02fc79cf17cd390ee14ceb8a723458
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

drm/gpusvm: Zero HMM PFNs before scanning ranges

This commit fixes an issue where drm_gpusvm_check_pages() passes an
uninitialized PFN array to HMM. It changes the allocation to use kvcalloc()
to ensure the array is zero-initialized before HMM scanning, which prevents
random memory contents from being interpreted as valid PFN flags.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index fcfe635bc1956..736c3a3e28f80 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -787,7 +787,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm =
*gpusvm,
> =20
>  	mmap_assert_locked(gpusvm->mm);
> =20
> -	pfns =3D kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	pfns =3D kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (!pfns)
>  		return false;

[Severity: Medium]
This isn't a bug introduced by this patch, but does the same fix need to be
applied to drm_gpusvm_scan_mm() in the same file?

drivers/gpu/drm/drm_gpusvm.c:drm_gpusvm_scan_mm() {
...
	pfns =3D kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
	if (!pfns)
		return DRM_GPUSVM_SCAN_UNPOPULATED;

	hmm_range.hmm_pfns =3D pfns;
...
}

It appears drm_gpusvm_scan_mm() also allocates the uninitialized PFN array
using kvmalloc_array() and passes it to hmm_range_fault() with default_flags
set to 0. It then reads pfns[i] to check HMM_PFN_VALID, leaving it
susceptible to the exact same uninitialized memory issue fixed here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-drm-gpusvm=
-fixes-v3-1-4346a61d093a@gmail.com?part=3D1
