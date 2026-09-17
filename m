Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1090CC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4048710E0E1;
	Thu, 17 Sep 2026 10:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QhBgFjDl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B2210E0E1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:33:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CA2060230;
 Thu, 17 Sep 2026 10:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A7D1F000FF;
 Thu, 17 Sep 2026 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789641212;
 bh=ystkHgfg/B2+LWhyt4IqYeXfy5fWKql2JcdLt5+qRwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QhBgFjDlrqKyxZblUiGQD0fHQ7o7EcENTQMUO9gWu7a0RsgvndkwR/+s8uj9OLpug
 kAEivoqIxthMuDsUrSKlzWLTR8J4o6Wbq9+ANIWp0vNcKNMsJYbN+W8/cij7xZH8T7
 siW7cElkAAdDHltBchifW1KHZOFkWUlQVSIQXf/H14qIxo5rg4BvCEDrgz6ii8JiNW
 h4VhCI7tQsl6ZZNVGgcUyUyI7xJ8YemICBuDeD1Dy2uFGqqZeppBkxsdyvQic35R8A
 u9ApcFFiw9CTn+u7bX2TCXKDFIBtoHufO1kSrOFVP6RQcx7vBMotBr/ZRpYnIK3aL1
 Mrt7EkrHKtuCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260917102540.1312102-2-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:33:31 +0000
Message-Id: <20260917103331.A8A7D1F000FF@smtp.kernel.org>
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
- [Medium] uapi: VIRTIO_GPU_CAPSET_ROCM defines unstandardized capset ID 8
--

commit ddbf02d8a1557a4976371db4a94be88bc1f7052f
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to the vir=
tio
gpu UAPI header to support ROCm compute workloads in virtualized environmen=
ts.

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
Does allocating this ID without specification standardization risk permanen=
t ABI
collisions?

If the virtio standard later assigns ID 8 to another capability, this UAPI
addition could cause a conflict. Furthermore, skipping ID 7 leaves an
undocumented gap that might conflict with virtio standardization protocols.
Has ID 8 been allocated in the upstream virtio specification?

> =20
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102540.1312=
102-1-honghuan@amd.com?part=3D1
