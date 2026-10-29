Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FB606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt3sCk4c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743D2112310;
	Thu, 29 Oct 2026 14:13:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5853E112310
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:12:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 210F3436CF;
 Thu, 29 Oct 2026 14:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5161F01829;
 Thu, 29 Oct 2026 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283174;
 bh=Qmg4zrdF8bequSMPzwwa/iaU8oZp9d1Z9AVgl7+Se14=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zt3sCk4cAI2PFIHoMmy3nimvyDJolUtPBrs5+IyNYkMViK6tFv8xSjV1jAuh/EzH9
 TeFtMmXCmNRa9uPhAHYTgLTF8yW4SXPqlURsfSzzaWhyFa9EZbcXEPjJatEvPTc5Va
 HZny+mWtAsTVfFJ+ztnbLcOzGpys2UFwE96f6yrIYkINXk9yDVrYkw6FFzF67xbsbF
 Z39Y+QXV4z+x5OGjRqU299XctZ22qgodd98LfzkluTBCOasrCbPuUIvltpS3QzgpgD
 dsg4XMxUVEsvt2vOvYumwL9sd7WIWVXk9FCdP8vhvMobbEExFSziHbCIAMVDfYRyuA
 yXOTPrgxpG2Kw==
Message-ID: <sashiko-outbox-189485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 02/14] drm/msm: add support for lpac_domain in
 msm_mmu
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-2-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-2-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:12:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/msm: wrong device passed to runtime PM in msm_iommu_tlb_flush_=
all()
- [High] drm/msm: missing TTBR0 rollback and NULL tlb deref in msm_iommu_pa=
getable_create()
- [High] drm/msm: missing iommu->domain unmap on error in msm_iommu_map()
- [Medium] drm/msm: race on fault_coredump_done between gpu and lpac fault =
handlers
--

commit 77527d316e1a6de39276075ddde03245b58f889d
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: add support for lpac_domain in msm_mmu

This commit adds support for a separate LPAC (Low Priority Async Compute)
iommu_domain in msm_mmu and keeps its mappings, TTBR0 configuration, fault
handling, and TLB invalidations synchronized with the main domain.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 058c71c82cf54..0e770ec91a83a 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c

[ ... ]

> @@ -450,14 +460,22 @@ static void msm_iommu_tlb_flush_all(void *cookie)
>  	struct msm_iommu_pagetable *pagetable =3D cookie;
>  	struct adreno_smmu_priv *adreno_smmu;
> =20
> -	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
> -		return;
> +	if (pm_runtime_get_if_in_use(pagetable->iommu_dev)) {
> +		adreno_smmu =3D dev_get_drvdata(pagetable->parent->dev);
> +
> +		pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
> +
> +		pm_runtime_put_autosuspend(pagetable->iommu_dev);
> +	}
> =20
> -	adreno_smmu =3D dev_get_drvdata(pagetable->parent->dev);
> +	if (pagetable->parent->lpac_dev &&
> +	    pm_runtime_get_if_in_use(pagetable->parent->lpac_dev)) {
> +		adreno_smmu =3D dev_get_drvdata(pagetable->parent->lpac_dev);
> =20
> -	pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
> +		pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
> =20
> -	pm_runtime_put_autosuspend(pagetable->iommu_dev);
> +		pm_runtime_put_autosuspend(pagetable->parent->lpac_dev);
> +	}
>  }
> =20
>  static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> @@ -466,14 +484,23 @@ static void msm_iommu_tlb_flush_walk(unsigned long =
iova, size_t size,
>  	struct msm_iommu_pagetable *pagetable =3D cookie;
>  	struct adreno_smmu_priv *adreno_smmu;
> =20
> -	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
> -		return;
> =20
> -	adreno_smmu =3D dev_get_drvdata(pagetable->parent->dev);
> +	if (pm_runtime_get_if_in_use(pagetable->iommu_dev)) {
> +		adreno_smmu =3D dev_get_drvdata(pagetable->parent->dev);
> +
> +		pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smm=
u->cookie);
> =20
> -	pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smmu=
->cookie);
> +		pm_runtime_put_autosuspend(pagetable->iommu_dev);
> +	}
> +
> +	if (pagetable->parent->lpac_dev &&
> +	    pm_runtime_get_if_in_use(pagetable->parent->lpac_dev)) {
> +		adreno_smmu =3D dev_get_drvdata(pagetable->parent->lpac_dev);
> =20
> -	pm_runtime_put_autosuspend(pagetable->iommu_dev);
> +		pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smm=
u->cookie);
> +
> +		pm_runtime_put_autosuspend(pagetable->parent->lpac_dev);
> +	}
>  }

[Severity: High]
Should msm_iommu_tlb_flush_all() and msm_iommu_tlb_flush_walk() keep the
runtime PM reference on pagetable->iommu_dev across both context bank flush=
es
instead of calling pm_runtime_get_if_in_use() and
pm_runtime_put_autosuspend() on pagetable->parent->lpac_dev?

In msm_iommu_pagetable_create(), pagetable->iommu_dev is initialized from
ttbr1_cfg->iommu_dev (the SMMU controller device), whereas
pagetable->parent->dev and pagetable->parent->lpac_dev are the GPU and LPAC
client devices. Both adreno_smmu->cookie and lpac_adreno_smmu->cookie access
context banks on that SMMU controller device.

When runtime PM is disabled on pagetable->parent->lpac_dev,
pm_runtime_get_if_in_use(pagetable->parent->lpac_dev) returns -EINVAL, which
evaluates as true in the if condition without incrementing usage_count. Aft=
er
pm_runtime_put_autosuspend(pagetable->iommu_dev) drops the SMMU reference at
the end of the primary flush block, the LPAC block can access unclocked SMMU
registers while pagetable->iommu_dev is suspended and then underflow the
runtime PM usage count on pagetable->parent->lpac_dev. Conversely, if runti=
me
PM is enabled on lpac_dev with a zero usage count while pagetable->iommu_dev
is active, pm_runtime_get_if_in_use(pagetable->parent->lpac_dev) returns 0
and skips the LPAC TLB flush.

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
> +
>  		BUG_ON(iommu->prr_page);
>  		if (adreno_smmu->set_prr_bit) {
>  			/*
> @@ -606,11 +650,16 @@ struct msm_mmu *msm_iommu_pagetable_create(struct m=
sm_mmu *parent, bool kernel_m
>  						  page_to_phys(iommu->prr_page));
>  			adreno_smmu->set_prr_bit(adreno_smmu->cookie, true);
>  		}
> +
> +		if (iommu->prr_page && lpac_adreno_smmu && lpac_adreno_smmu->set_prr_b=
it) {
> +			lpac_adreno_smmu->set_prr_addr(lpac_adreno_smmu->cookie,
> +						       page_to_phys(iommu->prr_page));
> +			lpac_adreno_smmu->set_prr_bit(lpac_adreno_smmu->cookie, true);
> +		}
>  	}
>  	mutex_unlock(&iommu->init_lock);
> =20
>  	/* Needed later for TLB flush */
> -	pagetable->parent =3D parent;
>  	pagetable->tlb =3D ttbr1_cfg->tlb;
>  	pagetable->pgsize_bitmap =3D ttbr0_cfg.pgsize_bitmap;
>  	pagetable->ttbr =3D ttbr0_cfg.arm_lpae_s1_cfg.ttbr;

[Severity: High]
What happens in msm_iommu_pagetable_create() if
lpac_adreno_smmu->set_ttbr0_cfg() fails after adreno_smmu->set_ttbr0_cfg()
has already succeeded?

Because the error path does not call
adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, NULL) before freeing
pagetable->pgtbl_ops, the primary context bank's TTBR0 remains enabled and
pointed at the freed root page table physical address, and subsequent calls
to msm_iommu_pagetable_create() will fail in qcom_adreno_smmu_set_ttbr0_cfg=
()
because ARM_SMMU_TCR_EPD0 is already cleared.

In addition, while pagetable->parent =3D parent was moved before
alloc_io_pgtable_ops(), pagetable->tlb =3D ttbr1_cfg->tlb is still assigned
after the init_lock block:

drivers/gpu/drm/msm/msm_iommu.c:msm_iommu_pagetable_create() {
    ...
	if (iommu->pagetables++ =3D=3D 0) {
		...
		if (lpac_adreno_smmu) {
			ret =3D lpac_adreno_smmu->set_ttbr0_cfg(...);
			if (ret) {
				...
				free_io_pgtable_ops(pagetable->pgtbl_ops);
				...
			}
		}
	}
	mutex_unlock(&iommu->init_lock);

	/* Needed later for TLB flush */
	pagetable->tlb =3D ttbr1_cfg->tlb;
}

When free_io_pgtable_ops() runs on either set_ttbr0_cfg() error path, it
calls io_pgtable_tlb_flush_all() -> msm_iommu_tlb_flush_all(), which
dereferences pagetable->tlb while it is still NULL. Should pagetable->tlb be
initialized before alloc_io_pgtable_ops(), and should the LPAC error path r=
oll
back adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, NULL)?

> @@ -646,6 +695,26 @@ static int msm_gpu_fault_handler(struct iommu_domain=
 *domain, struct device *dev
>  	return 0;
>  }
> =20
> +static int msm_lpac_fault_handler(struct iommu_domain *domain, struct de=
vice *dev,
> +		unsigned long iova, int flags, void *arg)
> +{
> +	struct msm_iommu *iommu =3D arg;
> +	struct adreno_smmu_priv *adreno_smmu =3D dev_get_drvdata(iommu->base.lp=
ac_dev);
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

[Severity: Medium]
Can msm_lpac_fault_handler() and msm_gpu_fault_handler() race on
adreno_gpu->fault_coredump_done when both context banks fault concurrently?

Because iommu->domain and iommu->lpac_domain use separate SMMU context banks
with separate threaded fault IRQs, both handlers can invoke
iommu->base.handler (a6xx_fault_handler() -> adreno_fault_handler()) at the
same time. In adreno_fault_handler(), do_devcoredump is evaluated before
gpu->lock is taken in msm_gpu_fault_crashstate_capture(), and
reinit_completion() and complete_all() on adreno_gpu->fault_coredump_done r=
un
outside gpu->lock:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_fault_handler() {
    ...
	do_devcoredump =3D info && (info->fsr & ARM_SMMU_FSR_SS) &&
		!gpu->crashstate && !READ_ONCE(priv->disable_devcoredump);
    ...
	if (do_devcoredump) {
		...
		reinit_completion(&adreno_gpu->fault_coredump_done);
		...
		msm_gpu_fault_crashstate_capture(gpu, &fault_info);

		complete_all(&adreno_gpu->fault_coredump_done);
	}
}

If both context banks stall on a fault while gpu->crashstate is still NULL,
can one handler call reinit_completion() or complete_all() while the other
context bank is still stalled in the SMMU, causing concurrent GMU waits on
adreno_gpu->fault_coredump_done to wake prematurely or race on the
completion?

[ ... ]

> @@ -689,6 +768,15 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64=
_t iova,
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (ret !=3D len)
> +		return -EINVAL;
> +
> +	if (iommu->lpac_domain) {
> +		ret =3D iommu_map_sgtable(iommu->lpac_domain, iova, sgt, prot);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return (ret =3D=3D len) ? 0 : -EINVAL;
>  }

[Severity: High]
If mapping into iommu->lpac_domain fails or maps fewer than len bytes in
msm_iommu_map(), does this leave the [iova, iova + len) mapping leaked in
iommu->domain?

When msm_iommu_map() returns an error to msm_gem_vma_map(), msm_vma->mapped
remains false, so msm_gem_vma_unmap() will not be called to clean up the
primary domain mapping. Should msm_iommu_map() call
iommu_unmap(iommu->domain, iova, len) when the iommu->lpac_domain mapping
fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D2
