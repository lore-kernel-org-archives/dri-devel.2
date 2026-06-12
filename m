Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C987CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27C810F3B3;
	Fri, 12 Jun 2026 09:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mJSz/bc9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0249A10F3B3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:35:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F9B26001D;
 Fri, 12 Jun 2026 09:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3D1F00A3A;
 Fri, 12 Jun 2026 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256913;
 bh=MOne62Wu5bpnwG8+YtSgsHmqCOrjR9nEAQbGU6OiesU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mJSz/bc9YIoJ0Mb3qGpvplh2UpYxZO19uuYAlF7FhlWFWM4z0KuBFgesSEVDCXvmV
 SIDZ6/Quz08LMw7uHOWqJL7nF3cB7JSjkouaLXvLz+AJZgmUHJyTH6yDgF4DoS2atY
 YC8oEIwF2goByLPaERK4Ls7OdoQRJnAo9MIZiR4cazqgP40U6PV4IEQUcC/sXr0SfV
 ym/JgQfpdIeoTvtorPH45Sv9DGJw+lwDIgTj7aHqsylWO6Q8lnPUj+jnEPreE3h3u4
 ErrWDokGi9brtma9TObvEhLql16r8QQ62kZVZnRsfUus514S4FaGktNVlwsF8fccL8
 elXqwTJigMvUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/18] drm/amdgpu: hook up ZONE_DEVICE registration
 in device init and reset
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-17-ray.huang@amd.com>
References: <20260612090928.29682-17-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:35:13 +0000
Message-Id: <20260612093513.BFF3D1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Uncoordinated double registration of ZONE_DEVICE pages for VRA=
M causes PFN collisions, breaks KFD SVM migration on XGMI, and wastes syste=
m memory.
- [High] Ignoring the return value of `amdgpu_svm_migration_init()` masks c=
ritical initialization failures and causes a permanent, compounding memory =
leak of ZONE_DEVICE `struct page` arrays.
--

commit d498d3d35f13a60420ca6ba9733ca4560370b681
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/amdgpu: hook up ZONE_DEVICE registration in device init and reset

This patch calls amdgpu_svm_migration_init() in the device initialization
and XGMI reset-restore paths to register the GPU VRAM as a ZONE_DEVICE
region. This activates the drm_pagemap migration infrastructure before KFD
initialization.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 6608780ffef2f..60a8ba1b3095b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -4102,6 +4103,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> =20
>  	/* Don't init kfd if whole hive need to be reset during init */
>  	if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> +		amdgpu_svm_migration_init(adev);
>  		kgd2kfd_init_zone_device(adev);

[Severity: Critical]
Does this sequence result in an uncoordinated double registration of
ZONE_DEVICE pages for VRAM?

It appears both amdgpu_svm_migration_init() and kgd2kfd_init_zone_device()
independently attempt to allocate and register a dev_pagemap. On XGMI
coherent systems, if both attempt to map the exact same physical address
range (adev->gmc.aper_base), could the second call fail due to conflicting
mappings and silently break KFD SVM migration?

On non-XGMI configurations, would this successfully allocate two separate,
disjoint fake physical memory blocks for the same underlying VRAM,
redundantly allocating duplicate vmemmap struct page arrays and wasting
system memory?

[Severity: High]
Should the return value of amdgpu_svm_migration_init() be checked here?

Looking at amdgpu_svm_migration_init() in amdgpu_migrate.c, if
drm_pagemap_init() fails, it returns -EINVAL but does not unwind the prior
devm_memremap_pages() allocations. If the error is ignored here and probe
continues successfully, does this permanently leak the struct page arrays?

>  		kfd_update_svm_support_properties(adev);
>  	}
[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index da77e0ef129ba..c2ea540e392b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
[ ... ]
> @@ -87,6 +88,7 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwct=
xt(
>  		return r;
>  	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>  		if (!tmp_adev->kfd.init_complete) {
> +			amdgpu_svm_migration_init(tmp_adev);
>  			kgd2kfd_init_zone_device(tmp_adev);

[Severity: High]
Could the missing return value check here cause a compounding memory leak?

Because the struct page arrays are not freed on failure, and
adev->apagemap is not flagged as initialized, repeated XGMI resets might
re-execute this initialization function. Would this allocate new memory
regions and struct page arrays each time a reset occurs?

>  			amdgpu_amdkfd_device_init(tmp_adev);
>  			amdgpu_amdkfd_drm_client_create(tmp_adev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D16
