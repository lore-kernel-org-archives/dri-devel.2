Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AF1C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A7110E22E;
	Sun,  5 Jul 2026 19:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="loeZolFM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FA010E22E
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:27:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75B4A401FA;
 Sun,  5 Jul 2026 19:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1509E1F000E9;
 Sun,  5 Jul 2026 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783279637;
 bh=jzL30vpdpNQVDzgod6XR4QT5tmP29Z67KX/njueQv9U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=loeZolFM3ZF20caIG38xWUL/LhpSZzFx2tyZta70QdytdRFAQYiGSZ1GaUqf/folC
 ejSmerYLhy19c6uObttxN+EGyF4cfz1TWK3hagcHZlG60qiQLH1Cgg0GMVJppZwcKn
 TMEzezBVHVsgYHHj4V9peOGy96kEk5tvEl3xUv8zfvc3cco5LxWMelUzewnB/eNola
 VyrqAigdK++YkPVYkps+d4icB0LoCTU8BcADUtKHB9+HS4Xlq0AZ9GT9GePiUgZWrl
 gq4qdfCqaHu5TOhMbKmIPTpxmGSLKBZGPdmJVhGZHOvkOSS2ic37xQXu+vgIHSNTdd
 4fa1tFkJ1xlVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 19:27:16 +0000
Message-Id: <20260705192717.1509E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Dangling pointer in LPAC device's driver data leads to Use-After-F=
ree.
- [High] Incorrect order of `device_link_add()` and `pm_runtime_enable()` c=
auses device link failure.
- [High] Severe memory and resource leak in `msm_iommu_new()` error paths.
- [High] LPAC fault handler retrieves fault information from the wrong hard=
ware block.
- [High] Missing rollback of main SMMU `set_ttbr0_cfg` upon LPAC configurat=
ion failure causes Use-After-Free.
- [Medium] Memory leak of the LPAC platform device reference.
- [Medium] Unbalanced `pm_runtime_enable()` for the LPAC device corrupts PM=
 state.
- [Medium] Calling `of_dma_configure()` explicitly on an already-instantiat=
ed platform device.
- [Medium] Double allocation of `prr_page` causing a memory leak, and incor=
rectly scoped cleanup.
- [Medium] Partial mapping failures in the main domain are silently ignored=
 if the LPAC domain maps successfully.
--

commit 8c24a0d4aac07c998e8a7b231ed5f964a1584875
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date:   Sun Jul 5 19:13:37 2026 +0000

    drm/msm: look for lpac from dts
   =20
    In order to associate the SID used by LPAC to it's own domain and
    context bank we need a separate node on the DTS.
   =20
    Add the code to look up that node on initialization.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index f3fc7032fadcd..71ce4cbbf27ae 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
[ ... ]
> @@ -1200,6 +1205,20 @@ int adreno_gpu_init(struct drm_device *drm, struct=
 platform_device *pdev,
>  	gpu->allow_relocs =3D config->info->family < ADRENO_6XX_GEN1;
>  	gpu->pdev =3D pdev;
> =20
> +	lpac_node =3D of_parse_phandle(pdev->dev.of_node, "qcom,lpac", 0);
> +	if (lpac_node)
> +		gpu->lpac_pdev =3D of_find_device_by_node(lpac_node);

[Severity: Medium]
Does this code leak the LPAC platform device reference?

of_find_device_by_node() acquires a reference to the LPAC platform device v=
ia
bus_find_device(). This reference is stored in gpu->lpac_pdev but is never
released using put_device(&gpu->lpac_pdev->dev) in the error paths of
adreno_gpu_init() or in the driver teardown path adreno_gpu_cleanup(), caus=
ing
a memory leak of the device structure.

> +	if (gpu->lpac_pdev) {
> +		of_dma_configure(&gpu->lpac_pdev->dev, lpac_node, true);

[Severity: Medium]
Is it correct to call of_dma_configure() explicitly on an already-instantia=
ted
platform device?

The LPAC platform device is instantiated by of_platform_populate(), meaning=
 it
has already been configured for DMA and probed by the IOMMU subsystem.
Re-calling of_dma_configure() explicitly on an active platform device
reallocates DMA mappings, violating driver core API contracts and potential=
ly
causing duplicate IOMMU attachments or resource leaks.

> +		platform_set_drvdata(gpu->lpac_pdev, &gpu->lpac_adreno_smmu);

[Severity: High]
Does this create a dangling pointer in the LPAC device's driver data that
could lead to a use-after-free?

platform_set_drvdata() sets the external LPAC device's driver data to point=
 to
&gpu->lpac_adreno_smmu, a field within the dynamically allocated msm_gpu.
On driver unbind or probe failure, msm_gpu is freed, but the LPAC device
(created by OF platform populate) persists.
The driver data is not cleared to NULL, leaving a dangling pointer. Subsequ=
ent
accesses to the device (e.g., via sysfs or another driver binding to it) wi=
ll
dereference freed memory.

> +		if (!device_link_add(&pdev->dev, &gpu->lpac_pdev->dev,
> +				     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
> +			dev_err(&gpu->lpac_pdev->dev, "failed to link to gpu device\n");
> +		pm_runtime_enable(&gpu->lpac_pdev->dev);

[Severity: High]
Does the incorrect order of device_link_add() and pm_runtime_enable() cause
the device link to fail?

device_link_add() is called with DL_FLAG_PM_RUNTIME, which internally calls
pm_runtime_get_sync() on the supplier (lpac_pdev).
Because pm_runtime_enable() hasn't been called on the supplier yet, it is
still disabled, causing pm_runtime_get_sync() to return -EACCES.
This causes device_link_add() to fail and return NULL, completely breaking =
the
runtime PM dependency between the GPU and LPAC.

[Severity: Medium]
Will this unbalance the pm_runtime_enable() for the LPAC device and corrupt=
 PM
state?

pm_runtime_enable() decreases the PM disable_depth of the LPAC device.
The matching pm_runtime_disable() is missing in the teardown path
adreno_gpu_cleanup().
Reloading the driver module will trigger a kernel warning for unbalanced PM
enable and corrupts the LPAC device's PM state machine.

> +	}
> +	if (lpac_node)
> +		of_node_put(lpac_node);
> +

[ ... ]
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 058c71c82cf54..19bee64adb7ca 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
[ ... ]
> @@ -224,6 +226,10 @@ static void msm_iommu_pagetable_destroy(struct msm_m=
mu *mmu)
>  	struct msm_iommu *iommu =3D to_msm_iommu(pagetable->parent);
>  	struct adreno_smmu_priv *adreno_smmu =3D
>  		dev_get_drvdata(pagetable->parent->dev);
> +	struct adreno_smmu_priv *lpac_adreno_smmu =3D NULL;
> +
> +	if (pagetable->parent->lpac_dev)
> +		lpac_adreno_smmu =3D dev_get_drvdata(pagetable->parent->lpac_dev);
> =20
>  	/*
>  	 * If this is the last attached pagetable for the parent,
> @@ -232,9 +238,13 @@ static void msm_iommu_pagetable_destroy(struct msm_m=
mu *mmu)
>  	mutex_lock(&iommu->init_lock);
>  	if (--iommu->pagetables =3D=3D 0) {
>  		adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, NULL);
> +		if (lpac_adreno_smmu)
> +			lpac_adreno_smmu->set_ttbr0_cfg(lpac_adreno_smmu->cookie, NULL);
> =20
>  		if (adreno_smmu->set_prr_bit) {
>  			adreno_smmu->set_prr_bit(adreno_smmu->cookie, false);
> +			if (lpac_adreno_smmu && lpac_adreno_smmu->set_prr_bit)
> +				lpac_adreno_smmu->set_prr_bit(lpac_adreno_smmu->cookie, false);

[Severity: Medium]
Will this incorrectly scope the LPAC PRR cleanup and cause a memory leak?

In msm_iommu_pagetable_destroy(), the cleanup for LPAC PRR is nested inside=
 the
condition for the main GPU PRR. If only the LPAC PRR is enabled, the page is
never freed.

>  			__free_page(iommu->prr_page);
>  			iommu->prr_page =3D NULL;
>  		}
[ ... ]
> @@ -588,6 +621,17 @@ struct msm_mmu *msm_iommu_pagetable_create(struct ms=
m_mmu *parent, bool kernel_m
>  			return ERR_PTR(ret);
>  		}
> =20
> +		if (lpac_adreno_smmu) {
> +			ret =3D lpac_adreno_smmu->set_ttbr0_cfg(lpac_adreno_smmu->cookie, &tt=
br0_cfg);
> +			if (ret) {
> +				iommu->pagetables--;
> +				mutex_unlock(&iommu->init_lock);
> +				free_io_pgtable_ops(pagetable->pgtbl_ops);
> +				kfree(pagetable);
> +				return ERR_PTR(ret);

[Severity: High]
Does this error path miss rolling back the main SMMU configuration, leading=
 to
a use-after-free?

In msm_iommu_pagetable_create(), set_ttbr0_cfg() programs the main SMMU
hardware with the new page tables.
If the subsequent set_ttbr0_cfg() for the LPAC SMMU fails, the function
immediately frees the page tables (free_io_pgtable_ops) and returns an erro=
r.
It fails to call set_ttbr0_cfg(..., NULL) for the main SMMU to unprogram it.
The main SMMU hardware is left actively configured to use the freed page
tables, resulting in a use-after-free of memory by the hardware.

> +			}
> +		}
> +
>  		BUG_ON(iommu->prr_page);
>  		if (adreno_smmu->set_prr_bit) {
>  			/*
> @@ -606,11 +650,17 @@ struct msm_mmu *msm_iommu_pagetable_create(struct m=
sm_mmu *parent, bool kernel_m
>  						  page_to_phys(iommu->prr_page));
>  			adreno_smmu->set_prr_bit(adreno_smmu->cookie, true);
>  		}
> +
> +		if (lpac_adreno_smmu && lpac_adreno_smmu->set_prr_bit) {
> +			iommu->prr_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);

[Severity: Medium]
Will this allocate prr_page a second time and leak the first allocation?

If both adreno_smmu->set_prr_bit and lpac_adreno_smmu->set_prr_bit are true,
iommu->prr_page is allocated twice in msm_iommu_pagetable_create(),
overwriting the pointer and leaking the first page.

> +			lpac_adreno_smmu->set_prr_addr(lpac_adreno_smmu->cookie,
> +						       page_to_phys(iommu->prr_page));
> +			lpac_adreno_smmu->set_prr_bit(lpac_adreno_smmu->cookie, true);
> +		}
>  	}
>  	mutex_unlock(&iommu->init_lock);
> =20
[ ... ]
> @@ -646,6 +696,26 @@ static int msm_gpu_fault_handler(struct iommu_domain=
 *domain, struct device *dev
>  	return 0;
>  }
> =20
> +static int msm_lpac_fault_handler(struct iommu_domain *domain, struct de=
vice *dev,
> +		unsigned long iova, int flags, void *arg)
> +{
> +	struct msm_iommu *iommu =3D arg;
> +	struct adreno_smmu_priv *adreno_smmu =3D dev_get_drvdata(iommu->base.de=
v);

[Severity: High]
Does the LPAC fault handler retrieve fault information from the wrong hardw=
are
block?

msm_lpac_fault_handler() retrieves the adreno_smmu driver data using
dev_get_drvdata(iommu->base.dev) (the main GPU device).
It then calls get_fault_info() using the main GPU SMMU's cookie.
This reads the fault registers of the main GPU hardware block rather than t=
he
LPAC block, leading to incorrect fault reporting and potentially failing to
clear the actual LPAC fault.

> +	struct adreno_smmu_fault_info info, *ptr =3D NULL;
> +
> +	if (adreno_smmu->get_fault_info) {
> +		adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);
> +		ptr =3D &info;
> +	}
> +
> +	if (iommu->base.handler)
> +		return iommu->base.handler(iommu->base.arg, iova, flags, ptr);
> +
> +	pr_warn_ratelimited("*** lpac fault: iova=3D%16lx, flags=3D%d\n", iova,=
 flags);
> +
> +	return 0;
> +}
[ ... ]
> @@ -689,6 +769,11 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64=
_t iova,
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (iommu->lpac_domain) {
> +		ret =3D iommu_map_sgtable(iommu->lpac_domain, iova, sgt, prot);
> +		WARN_ON(!ret);
> +	}

[Severity: Medium]
Are partial mapping failures in the main domain silently ignored if the LPAC
domain maps successfully?

In msm_iommu_map(), if iommu_map_sgtable() on the main domain returns a
size < len (but > 0), it is a partial failure.
The result ret is overwritten by the mapping result of the LPAC domain.
If the LPAC domain maps the full len, the function returns success 0,
completely masking the partial mapping failure of the main domain.

> +
>  	return (ret =3D=3D len) ? 0 : -EINVAL;
>  }
[ ... ]
> @@ -753,6 +843,30 @@ struct msm_mmu *msm_iommu_new(struct device *dev, un=
signed long quirks)
>  		return ERR_PTR(ret);
>  	}
> =20
> +	if (lpac_dev) {
> +		if (!device_iommu_mapped(lpac_dev))
> +			return ERR_PTR(-ENODEV);
> +
> +		lpac_domain =3D iommu_paging_domain_alloc(lpac_dev);
> +		if (IS_ERR(lpac_domain))
> +			return ERR_CAST(lpac_domain);

[Severity: High]
Does this early return cause a memory and resource leak in the error path?

If device_iommu_mapped(lpac_dev) is false or iommu_paging_domain_alloc()
fails for the LPAC device, the function returns an error early.
It fails to free the previously allocated iommu and domain structures, and
fails to detach the main dev from the domain.
Similarly, if iommu_attach_device() for LPAC fails below, it forgets to det=
ach
the main dev. This causes a permanent resource leak and leaves the device
attached to a freed domain.

> +
> +		iommu_set_pgtable_quirks(lpac_domain, quirks);
> +
> +		iommu->lpac_domain =3D lpac_domain;
> +		iommu->base.lpac_dev =3D lpac_dev;
> +	}
> +
> +	if (lpac_domain) {
> +		ret =3D iommu_attach_device(lpac_domain, lpac_dev);
> +		if (ret) {
> +			iommu_domain_free(domain);
> +			iommu_domain_free(lpac_domain);
> +			kfree(iommu);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
>  	return &iommu->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-descriptiv=
e-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com?part=3D3
