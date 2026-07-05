Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91228C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB21A10E259;
	Sun,  5 Jul 2026 19:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kPu+S6aC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E2C10E259
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C7FF424CC;
 Sun,  5 Jul 2026 19:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD9D1F000E9;
 Sun,  5 Jul 2026 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783279675;
 bh=0W7QPVl2xOehqGT/ASXZcSI1JMi72IhhzPAtrJ8b6dk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kPu+S6aCpUYeiqidGG/lF912u7FB14vvQvnQIAO6MZNBnN0k0tJsFs0wlmMmK4vpt
 n4B552qDWPesa3rqOfQFT0bSY8/SPdpoLOUMvE7p8fr02KVCWqKY04LXxins2JfAtv
 pO10YIA/WlNHLDSuqNRcdMUx+/OTc8U8jrpL06AokVYOa7CMHlCr7aWqSNuGVcwhzh
 +nTTD/zU0Es4IuoJIg6pci+WSb5QcE/pQ5rwKPJFUmlogZ31R48cUEWCnDlbPKaMPm
 Ald/S7Zx4P03r8JdJO4gn+/wLquS/I2Ht5NEPc8KK/I7UqB8RzU+t3HDrWjSrC2MYt
 I8f/HTAjiruLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/13] drm/msm: add support for lpac_domain in msm_mmu
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-2-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-2-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 19:27:54 +0000
Message-Id: <20260705192755.3CD9D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Error paths in msm_iommu_new() leak allocated structures and fail =
to detach the primary device.
- [High] Double allocation of iommu->prr_page overwrites the pointer, leaki=
ng memory, and cleanup logic is improperly gated.
- [High] Missing rollback of the primary SMMU TTBR0 configuration when LPAC=
 TTBR0 setup fails.
- [High] msm_iommu_map leaves stale mappings in the primary domain if LPAC =
mapping fails.
- [Medium] The LPAC fault handler fetches fault information from the primar=
y SMMU instead of the LPAC SMMU.
--

commit 2c00819136c6aa733650fd70add5fb287b7ba815
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: add support for lpac_domain in msm_mmu

This commit adds an iommu_domain for LPAC (Low Power Audio Subsystem
context) and attempts to keep it in sync with the main domain. This allows
LPAC to use a separate context bank to update page tables independently.

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
>  			__free_page(iommu->prr_page);
>  			iommu->prr_page =3D NULL;
>  		}

[Severity: High]
If the primary SMMU does not support PRR (so adreno_smmu->set_prr_bit is
false/NULL) but the LPAC SMMU does, does this logic bypass the LPAC PRR
teardown and leak iommu->prr_page?

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
> +			}
> +		}

[Severity: High]
If lpac_adreno_smmu->set_ttbr0_cfg() fails here, does this error path
leave the primary SMMU TTBR0 actively configured to point to page tables
that are about to be freed?

Should there be a rollback for adreno_smmu->set_ttbr0_cfg() before returnin=
g?

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
> +			lpac_adreno_smmu->set_prr_addr(lpac_adreno_smmu->cookie,
> +						       page_to_phys(iommu->prr_page));
> +			lpac_adreno_smmu->set_prr_bit(lpac_adreno_smmu->cookie, true);
> +		}
>  	}
>  	mutex_unlock(&iommu->init_lock);

[Severity: High]
If both the primary SMMU and the LPAC SMMU have set_prr_bit, will this
second call to alloc_page() unconditionally overwrite iommu->prr_page
and leak the first page allocation?

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
> +	struct adreno_smmu_fault_info info, *ptr =3D NULL;
> +
> +	if (adreno_smmu->get_fault_info) {
> +		adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);
> +		ptr =3D &info;
> +	}

[Severity: Medium]
Does this fetch the fault information from the primary SMMU instead of the
LPAC SMMU?

Using iommu->base.lpac_dev instead of iommu->base.dev for dev_get_drvdata()
might be needed to read the correct hardware registers.

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
> +
>  	return (ret =3D=3D len) ? 0 : -EINVAL;
>  }

[Severity: High]
If iommu_map_sgtable() fails for the LPAC domain (e.g. returning a negative
error), does this error path leave stale mappings in the primary domain?

Since the function returns an error without an unmap rollback, the caller
might eventually free the underlying physical pages, potentially leaving a
dangling mapping in the primary domain.

[ ... ]

> @@ -753,6 +843,30 @@ struct msm_mmu *msm_iommu_new(struct device *dev, un=
signed long quirks)
>  		return ERR_PTR(ret);
>  	}
> =20
> +	if (lpac_dev) {
> +		if (!device_iommu_mapped(lpac_dev))
> +			return ERR_PTR(-ENODEV);

[Severity: High]
Can this early return cause a memory leak? It appears to bypass the cleanup
of the iommu struct and the main domain that were allocated earlier in this
function.

> +
> +		lpac_domain =3D iommu_paging_domain_alloc(lpac_dev);
> +		if (IS_ERR(lpac_domain))
> +			return ERR_CAST(lpac_domain);
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

[Severity: High]
If iommu_attach_device() fails for the LPAC domain, does this error path
forget to detach the primary domain?

The primary domain was successfully attached earlier in the function via
iommu_attach_device(iommu->domain, dev), so an iommu_detach_device() call
might be missing before returning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-descriptiv=
e-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com?part=3D2
