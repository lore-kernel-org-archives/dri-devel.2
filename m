Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6AFC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDD010F197;
	Fri, 18 Sep 2026 06:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z/VpWsIa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF49610F18F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:07:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A92226057A;
 Fri, 18 Sep 2026 06:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422E81F000FF;
 Fri, 18 Sep 2026 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789711664;
 bh=Is++eyS98HumeL5lCa5qIHpmTIyp+ZFjZ0XhctInwKA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z/VpWsIaeLrjHx/96EoRyq8TI7yY+TKQQZbcQDwa21smS24glzxkuwFecbY8JbUoc
 ZqhmoNZdBS6wQeXerhx42Vec7yP1/6jhsn9+2YJEowfky0m9cBlLIqxpOKz2KIUiuC
 g9+O6z2ytFwSg8yqvJuawGKf0IXfQ/YvfZAvmst77PKHvhHhWWdQ8W3/OibUB+Ms4s
 emdqcTkb7YUtrzi1CMj8ZZogU32IlzfA2cvhXFqJP5u2JO/sih7pq7UQrmpySvhuQ0
 fBYU+FfRp6hlkZ2shwekagxmmOE7uKWlkPDG2D+tI+OOmsG+p/l0HsqFdZK/HtHsSa
 jrb6bonmyGcTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918055917.2133574-2-honghuan@amd.com>
References: <20260918055917.2133574-1-honghuan@amd.com>
 <20260918055917.2133574-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:07:43 +0000
Message-Id: <20260918060744.422E81F000FF@smtp.kernel.org>
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
- [Medium] virtio-gpu: premature UAPI addition of unassigned capability ID
--

commit 970261f0dfa422eb342665d66f5e54d6944eda73
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments. It assigns ID 8 to ROCm,
noting that a matching virtio-gpu specification change is in progress.

> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_=
gpu.h
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VENUS 4
>  #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>  #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 8

[Severity: Medium]
Is it safe to add VIRTIO_GPU_CAPSET_ROCM to the Linux UAPI before the virtio
specification has officially assigned it?

Adding an unassigned capability ID to the Linux UAPI creates a risk of a
permanent ABI collision. If the OASIS virtio technical committee assigns ID=
 8
to a different capability or chooses a different ID for ROCm, the Linux ABI
will conflict with the standard.

Since UAPI changes are immutable once released, could this lock the kernel
into a potentially non-compliant ABI if userspace software compiles against
this UAPI header and uses ID 8 to communicate with the virtio-gpu device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918055917.2133=
574-1-honghuan@amd.com?part=3D1
