Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FEAC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13D310E212;
	Fri,  4 Sep 2026 16:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EbTzEGjK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C2410E212;
 Fri,  4 Sep 2026 16:58:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 898236020A;
 Fri,  4 Sep 2026 16:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BF21F00A3D;
 Fri,  4 Sep 2026 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788541085;
 bh=OSw3jFTUJDlaYCTzlQqqtTOVRog0fRddZC9Ld2kQL7Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EbTzEGjK+aXGGNyx3T4Rztwd9jWIOSOhir/K6D0wh/t4zZuIX6FdOn7sjMYwHU6AK
 BaO+2VEmPcHqKw3Vao0X9gbknASa3glJRdOekd/CQScYDElioAQBga7I6ZSxopnazK
 dZpQV88Mabc4gMvlZFLSmqosKMX0UUP+qA6Cgj8AAs7VmlZKNqEUXJqJik4N+9OegD
 PT/OQLBKKPtJoq1zNYzRHu+WeK20V2GMLNNOW/tl3bgL6O4Krry1FgLpnhsoKNFcTE
 YasMAQIqDXb/5FrPPpBiry+ujAsv6yhDbgSHvrPoWT9prDwzYKDYOP0q8HEC7YOCXd
 aBKGLKlqgL8Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] drm/gpusvm: keep a single DMA mapping inline for
 THP
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260904163956.3433293-6-honghuan@amd.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
 <20260904163956.3433293-6-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:58:04 +0000
Message-Id: <20260904165805.13BF21F00A3D@smtp.kernel.org>
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
- [Low] Incompatible pointer type in `xe_pt_stage_bind` when `CONFIG_DRM_XE=
_GPUSVM` is disabled, leading to a build failure.
--

commit ba41c31a99e11c5fd960b8101a85807f5290cd76
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: keep a single DMA mapping inline for THP

This commit optimizes drm_gpusvm_get_pages() by inlining a single DMA
mapping entry for Transparent Huge Pages (THP), reducing memory overhead.
It updates the accessors, including xe_pt_stage_bind() paths, to safely
handle the new union containing the inline address.

> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 5d990c1c3740a..96ea9735f34ce 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -831,7 +831,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma =
*vma,
>  			return -EAGAIN;
>  		}
>  		if (xe_svm_range_has_dma_mapping(range)) {
> -			xe_res_first_dma(range->pages.dma_addr, 0,
> +			xe_res_first_dma(drm_gpusvm_pages_first_dma(&range->pages), 0,

[Severity: Low]
Will this cause a build failure when compiling the driver with
CONFIG_DRM_XE_GPUSVM disabled?

When CONFIG_DRM_XE_GPUSVM is disabled, struct xe_svm_range uses an anonymous
struct for its pages field instead of struct drm_gpusvm_pages. Since
drm_gpusvm_pages_first_dma() expects a const struct drm_gpusvm_pages *,
passing &range->pages here appears to result in a compiler type mismatch
error.

>  					 xe_svm_range_size(range),
>  					 &curs);
>  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904163956.3433=
293-1-honghuan@amd.com?part=3D5
