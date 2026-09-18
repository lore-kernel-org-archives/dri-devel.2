Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6503BC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90EA10E95F;
	Fri, 18 Sep 2026 08:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YZi9ex2v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A6210E95F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:29:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 967EC60A5B;
 Fri, 18 Sep 2026 08:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6D71F00893;
 Fri, 18 Sep 2026 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789720172;
 bh=RxntiYqUXXJlSx7sjaFrrfQgRwNvBNmkjmFbHHzBgRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YZi9ex2v2+Tao0uawchNTngBmLVFZhHxbuXo8akJALfM0IVA5sQ1fwGM3GUXimuAi
 E1Vo5uuubK099ECDeh8daBLJFpQFNfEoonvBzn5hReqEHrcyVse4v/yldJKWnKS7av
 1w04dHFX4jGFqn1mgOp0xBYKwFJ4WvpYiuws5BVHQ++T8ZwFXCf3CezSiHLd0h0GLX
 3ztrN6iwqARn1/fZXwIpd8PpD6I1Sbm1iRIgKuUHQNCLuBgxisWUT1nu/BamVS5925
 xf9OwV4uU+c+5dh3KfBd4RsNxWI8DVBhazZY7xJq8RRIniGtgNgiO4YjpOnTAyCNnL
 QM48RBNz2vpgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918082311.2213619-2-honghuan@amd.com>
References: <20260918082311.2213619-1-honghuan@amd.com>
 <20260918082311.2213619-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:29:31 +0000
Message-Id: <20260918082932.3C6D71F00893@smtp.kernel.org>
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
- [Medium] uapi: adding virtio-gpu capset ID based on unfinalized spec
--

commit ea09d5da0f728b0cac3bb14e59301965633c01f2
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM with ID 8 =
to
support ROCm compute workloads in virtualized environments. The commit mess=
age
notes that the virtio-gpu specification change for this assignment is curre=
ntly
in progress.

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
Is it safe to expose VIRTIO_GPU_CAPSET_ROCM to userspace as a stable,
immutable API before the specification is finalized?

The commit message explicitly states that the matching specification change
is only "in progress". Because Linux UAPI is strictly immutable, adding
constants for unfinalized specifications violates standard UAPI merging
practices.

If the OASIS virtio committee assigns ID 8 to a different capability or alt=
ers
the capability structure before finalizing the specification, Linux will be
permanently stuck with a UAPI definition that conflicts with the official
virtio specification. This could lead to hypervisor and guest incompatibili=
ty.

Should this UAPI addition wait until the specification is officially merged?

> =20
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918082311.2213=
619-1-honghuan@amd.com?part=3D1
