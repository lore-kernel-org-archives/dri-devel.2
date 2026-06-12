Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE3BCD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D6E10F3BC;
	Fri, 12 Jun 2026 09:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L+F+S/qJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E6510F3BC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:30:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 591E741797;
 Fri, 12 Jun 2026 09:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD71F000E9;
 Fri, 12 Jun 2026 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256619;
 bh=O0WUKvXKAjM7FFvR2tMNH4pMo3e6KBVehNgYc+hXxlM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L+F+S/qJDe7Gi4oycVZUGO4hgDCSLw8wxnKIJhLDyQ9mtO32lyiyMhxhIcy+0eWdU
 z6EiUmqGngVX5/M+PODdxQSbOcYJOvG2jWvG1lhnRZZW1DpTYRArWORhZfQF0A0FGe
 OtH6jLx5z1zbY86B/nSM/Vuz16seMJRaOvtd0LvtaKVTJPjktORnt2uvH2FeMja5Lt
 q8o2PC+wcAqMYPuYbpG9kdU7hKs3/esHUWU6k/XhSy8odFDn0Z2gzldqiDDhchXQci
 YfHWI9Vr0HBZqyjadE7Hjuw1Iqc7KFg0Yg9NqUI04NWgNV/v66qe3rwXc0uJzLhpOR
 BEUUHov/ReMxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/18] drm/amdgpu: add VRAM migration infrastructure
 for drm_pagemap
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-14-ray.huang@amd.com>
References: <20260612090928.29682-14-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:30:18 +0000
Message-Id: <20260612093019.18AD71F000E9@smtp.kernel.org>
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
- [High] Missing drm_pagemap teardown leads to module/drm_device reference =
leaks, and devm_kzalloc usage leads to use-after-free and kfree() panic.
- [Medium] Resource leak in amdgpu_svm_migration_init error path.
--

commit 3b8c30d59e9fe758a437cc04f508914b553acea9
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/amdgpu: add VRAM migration infrastructure for drm_pagemap

This commit introduces the VRAM migration infrastructure for AMDGPU SVM
using drm_pagemap. It adds the amdgpu_pagemap wrapper, defines the relevant
owner macros, and implements amdgpu_svm_migration_init() to register
ZONE_DEVICE pages and initialize the pagemap.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_migrate.c
> new file mode 100644
> index 0000000000000..6b40f7477793a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
[ ... ]
> +const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops =3D { };

[Severity: High]
Does this missing .destroy callback cause issues during teardown?

If drm_pagemap_destroy() falls back to kfree(dpagemap), will calling kfree()
on memory allocated via devm_kzalloc() below trigger a kernel panic?

[ ... ]
> +int amdgpu_svm_migration_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_pagemap *svm_dm;
> +	struct dev_pagemap *pgmap;
> +	struct resource *res =3D NULL;
> +	unsigned long size;
> +	void *r;
[ ... ]
> +	svm_dm =3D devm_kzalloc(adev->dev, sizeof(*svm_dm), GFP_KERNEL);
> +	if (!svm_dm)
> +		return -ENOMEM;
[ ... ]
> +	r =3D devm_memremap_pages(adev->dev, pgmap);
> +	if (IS_ERR(r)) {
> +		dev_err(adev->dev, "SVM: failed to register HMM device memory\n");
> +		if (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE && res)
> +			devm_release_mem_region(adev->dev, res->start, resource_size(res));
> +		pgmap->type =3D 0;
> +		return PTR_ERR(r);
> +	}
> +
> +	if (drm_pagemap_init(&svm_dm->dpagemap, pgmap, adev_to_drm(adev),
> +							&amdgpu_svm_drm_pagemap_ops)) {

[Severity: High]
Can this initialization leak drm_device and module references?

Since there isn't a teardown action registered (like devm_add_action) to ca=
ll
drm_pagemap_put() on unbind, it seems these references might never be relea=
sed.

Additionally, if the device unbinds while VRAM pages are active, devm will
free svm_dm. Could this cause a use-after-free when active pages later
access the freed dpagemap?

> +		dev_err(adev->dev, "SVM: failed to init drm_pagemap\n");
> +		return -EINVAL;

[Severity: Medium]
If drm_pagemap_init() fails, does this error path permanently leak the
ZONE_DEVICE pagemap structures and the IO region?

Because the caller might continue device initialization without unbinding,
the devm-managed resources from devm_request_free_mem_region() and
devm_memremap_pages() seem to remain active indefinitely. Should this path
manually clean up these resources before returning?

> +	}
> +	svm_dm->adev =3D adev;
> +	svm_dm->hpa_base =3D pgmap->range.start;
> +	svm_dm->initialized =3D true;
> +	adev->apagemap =3D svm_dm;
> +
> +	dev_info(adev->dev, "SVM: registered %ldMB device memory, hpa_base=3D0x=
%llx\n",
> +			size >> 20, svm_dm->hpa_base);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D13
