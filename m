Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189CFC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62BEF10E4FC;
	Fri, 18 Sep 2026 08:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mJ/YcKWn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835A110E4FC
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:07:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54092416C2;
 Fri, 18 Sep 2026 08:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A721F000FF;
 Fri, 18 Sep 2026 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789718863;
 bh=kLZp1b+Gzur29gsET+22nQblEomcKrmQT2nNcgCAnHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mJ/YcKWn1PskDYxPxi8a9/G/svFb8ERrhq/gT6A2bMcqp/BzUCTNXTgrhbtwO/4Wl
 7i1r8YXG8VMb0wPM/fIu5ZPIGWJRcdaMZIV8+0h2gTBTEfhFwblO5n/ZViDrUjSXS5
 PTzJFsl7kA6hBDrJM2V8qPlEHOMMXTzpoHsaxHYSP0TTUpcnvjq1+5S5yDHu1Xok7q
 w9pS9bCuVmzmvi2FHjuwsEhJaEAWe4WxwrGBXhBEz7DOad8cfpQqSWYVjBsTtdir+K
 V5gtJu89K1ShIdPGUeCFTbtw91RfEc2ANqE2mXqjyA7nWy5iq069FJ+fuNK4GcUiwV
 Ia2m9CDsse1ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918075600.2197253-2-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
 <20260918075600.2197253-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:07:42 +0000
Message-Id: <20260918080743.16A721F000FF@smtp.kernel.org>
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
- [Medium] virtio: premature UAPI addition and undocumented ID gap
--

commit 6c8027f028fb5e1fbc1a781cb6e95ed1a88e28f2
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads. It assigns ID 8 because ID 7 is used by VIRCL, and
mentions a virtio-gpu specification change is in progress.

> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_=
gpu.h
> index 4f530d90058c7..3d4dfadc9d789 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VENUS 4
>  #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>  #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 8

[Severity: Medium]
Is it safe to introduce VIRTIO_GPU_CAPSET_ROCM (ID 8) to the immutable Linux
UAPI while the corresponding virtio specification is still in progress?

If the OASIS virtio technical committee rejects the proposal, requests
changes, or assigns a different ID during the review process, the Linux
UAPI will be permanently divergent or broken.

Additionally, should a placeholder macro or documentation be added for the
skipped ID 7? Without it in the header, future developers might assume ID 7
is available and mistakenly reallocate it, creating a potential UAPI
compatibility issue.

> =20
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918075600.2197=
253-1-honghuan@amd.com?part=3D1
