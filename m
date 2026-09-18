Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94920C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 02:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C534510E7BC;
	Fri, 18 Sep 2026 02:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PAzbonfO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4682210E7BC
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 02:16:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58B30600AA;
 Fri, 18 Sep 2026 02:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D01F000FF;
 Fri, 18 Sep 2026 02:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789697798;
 bh=4CiRMjRojr6ANEBnN2WvoWepwKygnuPyfjcL7kwMGQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PAzbonfOcVvIn8Xyi3hzvzz9J80ocRh32ocluXh2IHwj+gM852KP3Bz6YSsOrwMkj
 VZW8EIVS5h8wy9/9wCjYkXVF5ql9LCUIM5fa1mOJWevMQhJrT3PLlHS95ytuFiym5G
 p/fG2CPHl7LhqO/PnWBvkdR/9D24XGWnbG8ukSmovtFkoheXo7bzYbCSljKgxK7Bvv
 2aAZIMuD7smCBxIZQKq9Edb6SycWVff6viwe3D7MBLJGt7Fsx6WQWPF0EAQg2hI7cf
 JS0zrBG/sECjghIfaUOgTJtcEgpdwiqSVQW3b6FlyPgKbqlov9iIuZO5i3JMqm3SBD
 feAdHFSqTEOwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918021154.1432154-2-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:16:37 +0000
Message-Id: <20260918021637.C32D01F000FF@smtp.kernel.org>
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
- [Medium] virtio: speculative UAPI capability set ID assignment
--

commit 45781e0bfdae22c4f82ae57badc273b48904b478
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments using ID 8. The commit
message notes that a matching virtio-gpu specification change is currently
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
Is it safe to speculatively assign a UAPI capability set ID while the virtio
specification change is still in progress?

If the virtio technical committee assigns ID 8 to a different capability set
or assigns a different ID to ROCm, the Linux kernel UAPI will permanently
diverge from the official OASIS standard, which could break interoperability
with spec-compliant hypervisors.

Should this UAPI addition wait until the specification assignment is formal=
ly
accepted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D1
