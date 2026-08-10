Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FDEC5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519FA10E21C;
	Mon, 10 Aug 2026 17:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eY4Xy+mm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A916C10E21C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 17:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 583BB41AD2;
 Mon, 10 Aug 2026 17:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DD11F000E9;
 Mon, 10 Aug 2026 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786382791;
 bh=VxkZ45hYJB8egn2bO4BYkMamxawoHV0L9E2rc428CU4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eY4Xy+mmLmwy/xisMD7U1PVsU8uxXZqN3YM7yi6QZ6HNmcpFfOR+a7TPl5DiS4anV
 8GDoK2J7liMUmO5TRP912vFbQy8XJdcJmuvDPvhEPZoGqEikY3EMFz9ldDNiREF0Gs
 jmb1jQPh2qoMD2KNiHFHX8gZfWSOPD/l4ZOdRG5cSImeRkIy/HFrvxU7vqTW4YOSCK
 xstm50Ao1mdsMrNvLthF2oWTNGvaBcqmQbERnpP8kLR1MPuCEFSc/pWDUnHF9YxWcQ
 cllHj9OgYh+j3KmzghFBFlhDueOuYom13ZQBIfuaQi26pDplSoo9XLFZpkVYW2VslA
 EWZ+4uFU/DvOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] drm/amdgpu: skip amdgpu_gart_unbind if the
 device is wedged
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810165322.24682-2-pierre-eric.pelloux-prayer@amd.com>
References: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
 <20260810165322.24682-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 17:26:30 +0000
Message-Id: <20260810172631.10DD11F000E9@smtp.kernel.org>
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
- [Critical] Skipping `amdgpu_gart_unbind` when the device is wedged leaves=
 GART PTEs pointing to freed system memory, enabling runaway DMA corruption.
--

--- Patch [2]: [PATCH v1 2/3] drm/amdgpu: skip amdgpu_gart_unbind if the de=
vice is wedged ---
commit 6802482fc9c63b1193bceee62eda365971bd0506
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: skip amdgpu_gart_unbind if the device is wedged

This commit modifies amdgpu_gart_unbind() to return early if the device is
wedged. This avoids unbinding GART pages during a wedged state.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index c4c21dbbbdbf8..09ddfccb81743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -315,7 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>  	uint64_t flags =3D 0;
>  	int idx;
> =20
> -	if (!adev->gart.ptr)
> +	if (!adev->gart.ptr || amdgpu_device_is_wedged(adev))
>  		return;

[Severity: Critical]
Does skipping this unbind leave GART PTEs pointing to freed system memory in
amdgpu_gart_unbind()?

When the GPU is wedged, the driver explicitly skips resetting the GPU but
signals all pending fences to unblock the system. TTM responds to these
signaled fences by freeing the backing memory of the completed or killed
jobs, returning the physical pages to the OS.

Because this new code returns early, it skips updating the GART PTEs to the
safe dummy_page_addr. If a userspace application hangs the GPU (e.g. an
infinite loop with memory writes), the application exits, and its memory is
reallocated to other processes or the kernel.

Could the hung GPU, which is deliberately left powered on and electrically
active by the wedge state, continue performing DMA writes through the stale
GART PTEs? This appears it would corrupt the newly allocated system memory,
causing silent corruption on systems where the IOMMU is disabled or running
in passthrough mode.

> =20
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810165322.2468=
2-1-pierre-eric.pelloux-prayer@amd.com?part=3D2
