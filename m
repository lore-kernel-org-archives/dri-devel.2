Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC29FC98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E7210F408;
	Thu, 24 Sep 2026 10:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JW5G3QSR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0D910F408
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:03:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52643600AA;
 Thu, 24 Sep 2026 10:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4CD1F00893;
 Thu, 24 Sep 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790244234;
 bh=+HblMzgUHnVQDLjO/UL0xqNapo4MemRaXVTdF4YjU0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JW5G3QSR/1PsI6AP59hEP/Mg67m9mz9jHYhWdTq/CUZ2uWZj1OPmRlMsHWi/kSCDD
 Trp1RShvkMuByWE3yBYVnvhCsFyQdYrcXasvN1coSqFaOJtbLktu17MCav7WwlZfbD
 eV4PM2bsB7TvhdpfdEfPIRy9xqzuI+4F6oNk5RDbJyAKiiyC6dY8V2RRfDI+EUI7Is
 f606NcwNz6rKzQ2bJhazsELfqO4IkqFaNWS7sEmyAyE9hTTpCRWg0VGF6h+dJ1vELK
 q6ih5cfB4/VxvoGNyxutc8ZtX2MNEsJlvltrblRIFQcB5lMrH2iW919cXA1ZNMBfS0
 FnfxEb5i61feA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
In-Reply-To: <20260924095556.1326164-2-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:03:53 +0000
Message-Id: <20260924100353.BD4CD1F00893@smtp.kernel.org>
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

> Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
> ROCm compute workloads in virtualized environments.
>=20
> ROCm (Radeon Open Compute) is AMD's open-source software platform
> for GPU compute and HPC workloads.
>=20
> ID 7 is already used by VIRCL, and gfxstream's rutabaga_gfx has
> already claimed IDs 7-9 ahead of any spec or kernel header update,
> so ROCm uses ID 10 to avoid a further collision. A matching
> virtio-gpu specification change is in progress to register this
> assignment.
>=20
> Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h
> for consistency with the other capability sets exposed through
> DRM_IOCTL_VIRTGPU_GET_CAPS.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D1

