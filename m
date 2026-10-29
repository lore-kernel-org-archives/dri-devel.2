Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E2606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQYNAnJY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3676B10E110;
	Thu, 29 Oct 2026 14:45:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870CD10E110
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:45:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 534F460267;
 Thu, 29 Oct 2026 14:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C257F1F01825;
 Thu, 29 Oct 2026 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793285146;
 bh=81x5aK74MMU6tNiEEvQe7CPsj4CjFBEjZosxKN9Bl+o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oQYNAnJYhj3UAsVTFrBnqld9blKPnE7WVbuat56mvI9UoVMgNEnxayZnLJ8IYMkz7
 oAJZMVcc15o1+vIgbfL8SIpSGCMQjynNfaDtNMMSOlfoZUBGQweEj/UIiC32rpmcT5
 rANKsXfC/H3LqX3qgdPG4bAMCQWGa+TiqxgI3joY6+mr/wDwboFCpfIfF+LHqeufjq
 993I04sVsG4IrJmYVhxqvIdaQgulGcfsGC2GCJnrzr54rW+Y7M0J0Q7znBh5soLSTN
 SjTwvBhKcZm/csSFe1nmz7VADCpmREee9h70dSMAf2HgJ9xvYMHGwGPMePDIzF1C7A
 Ci2Jwk/ybGe2Q==
Message-ID: <sashiko-outbox-189545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 14/14] drm/msm: enable LPAC on gen70900
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-14-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-14-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:45:45 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/msm: LPAC enabled on gen70900 without checking lpac_pdev or SW=
 fuse
- [High] drm/msm: a6xx_active_ring() and suspend ignore lpac_rb when LPAC i=
s enabled
- [High] drm/msm: wrong runtime PM device checked for LPAC in msm_iommu_tlb=
_flush_all()
- [High] drm/msm: failed parent-to-child device link skips LPAC SMMU TLB fl=
ushes
- [Medium] drm/msm: LPAC not enabled on gen70900 due to enable_lpac default=
ing to 0
- [Medium] drm/msm: mismatched always-on counter reads for LPAC in a7xx_sub=
mit()
- [Medium] drm/msm/adreno: missing LPAC GX registers in A750 IFPC restore l=
ists
--

commit 80cc6b84cce3401809bd7592d96a060ab6cb7da3
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: enable LPAC on gen70900

This commit adds ADRENO_QUIRK_LPAC to the gen70900 (Adreno 750) GPU entry in
a7xx_gpus[] so that LPAC is enabled on targets known to support it.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index 5ee00eead14c8..cd1bdb54429d3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1591,7 +1591,8 @@ static const struct adreno_info a7xx_gpus[] =3D {
>  		.quirks =3D ADRENO_QUIRK_HAS_CACHED_COHERENT |
>  			  ADRENO_QUIRK_HAS_HW_APRIV |
>  			  ADRENO_QUIRK_PREEMPTION |
> -			  ADRENO_QUIRK_IFPC,
> +			  ADRENO_QUIRK_IFPC |
> +			  ADRENO_QUIRK_LPAC,

[Severity: Medium]
Does setting ADRENO_QUIRK_LPAC here actually enable LPAC by default on
gen70900 when enable_lpac is not explicitly passed by the user?

In drivers/gpu/drm/msm/adreno/adreno_device.c, enable_lpac is initialized to
0 instead of -1:

    int enable_lpac =3D 0;
    MODULE_PARM_DESC(enable_lpac, "Enable LPAC (A7xx+ only) (1=3Don , 0=3Dd=
isable, -1=3Dauto (default))");
    module_param(enable_lpac, int, 0600);

When adreno_gpu_init() in drivers/gpu/drm/msm/adreno/adreno_gpu.c sets:

    adreno_gpu_config.has_lpac =3D !!(config->info->quirks & ADRENO_QUIRK_L=
PAC);

msm_gpu_init() in drivers/gpu/drm/msm/msm_gpu.c allocates an extra
msm_rbmemptrs slot for config->has_lpac, but then skips creating
gpu->lpac_rb because enable_lpac is 0:

    if (config->has_lpac && enable_lpac !=3D 0) {
        gpu->lpac_rb =3D msm_ringbuffer_new(gpu, nr_rings, memptrs, memptrs=
_iova);

Meanwhile, adreno_hw_init() in drivers/gpu/drm/msm/adreno/adreno_gpu.c only
checks the quirk rather than gpu->lpac_rb:

    if (info->quirks & ADRENO_QUIRK_LPAC) {
        ret =3D qcom_scm_set_gpu_smmu_lpac_aperture(1);

so qcom_scm_set_gpu_smmu_lpac_aperture(1) is still called during hardware
initialization even when LPAC is disabled. Additionally, because
config->has_lpac only checks ADRENO_QUIRK_LPAC, passing enable_lpac=3D1 can=
not
force-enable LPAC on A7xx+ targets that do not set the quirk.

Should enable_lpac be initialized to -1, and should adreno_hw_init() check
gpu->lpac_rb instead of ADRENO_QUIRK_LPAC?

[Severity: High]
What happens when booting a kernel with ADRENO_QUIRK_LPAC enabled on an
older SM8650 (gen70900) device tree that lacks the qcom,lpac child node, or
on a device where firmware fuses off LPAC?

In adreno_gpu_init() in drivers/gpu/drm/msm/adreno/adreno_gpu.c,
gpu->lpac_pdev is looked up via of_get_compatible_child(pdev->dev.of_node,
"qcom,lpac"). On an older DTB without that child node, gpu->lpac_pdev is
NULL, and adreno_iommu_create_vm() passes NULL for lpac_dev:

    mmu =3D msm_iommu_gpu_new(&pdev->dev,
                gpu->lpac_pdev ? &gpu->lpac_pdev->dev : NULL,
                gpu, quirks);

so iommu->lpac_domain (context bank 1) is never allocated and SID 1 remains
attached to context bank 0.

However, adreno_gpu_init() sets adreno_gpu_config.has_lpac solely from
ADRENO_QUIRK_LPAC without checking gpu->lpac_pdev, and adreno_hw_init()
unconditionally calls qcom_scm_set_gpu_smmu_lpac_aperture(1). When
gpu->lpac_rb is created and userspace submits to MSM_SUBMITQUEUE_LPAC,
a7xx_submit() -> a6xx_set_pagetable() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c executes:

    /* qcom-arm-smmu always maps asid and ctxbank 1:1 */
    ctxbank =3D asid =3D is_lpac;

and emits CP_SMMU_TABLE_UPDATE targeting uninitialized context bank 1 while
SID 1 still translates through context bank 0.

Similarly, in a6xx_gmu_secure_init() in
drivers/gpu/drm/msm/adreno/a6xx_gmu.c, REG_A7XX_CX_MISC_SW_FUSE_VALUE is
read after qcom_scm_gpu_init_regs() to check
A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING, but A7XX_CX_MISC_SW_FUSE_VALUE_LPAC
is not checked before hw_init() writes REG_A6XX_CP_LPAC_SQE_CNTL and runs
lpac_cp_init(), which can trigger a7xx_sw_fuse_violation_irq() if firmware
disables the LPAC software fuse.

Should LPAC enablement verify both that gpu->lpac_pdev is present and that
A7XX_CX_MISC_SW_FUSE_VALUE_LPAC is set?

[Severity: High]
With ADRENO_QUIRK_LPAC enabled on gen70900 and gpu->lpac_rb exposed to
userspace, how do hangcheck, fault recovery, and suspend handle the LPAC
ring?

In drivers/gpu/drm/msm/adreno/a6xx_gpu.c, a6xx_active_ring() always returns
a6xx_gpu->cur_ring (one of gpu->rb[0..gpu->nr_rings - 1]) and never returns
gpu->lpac_rb:

    static struct msm_ringbuffer *a6xx_active_ring(struct msm_gpu *gpu)
    {
        struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
        struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);

        return a6xx_gpu->cur_ring;
    }

In drivers/gpu/drm/msm/msm_gpu.c, hangcheck_handler() only checks
gpu->funcs->active_ring(gpu) for fence progress, so a hung submission on
gpu->lpac_rb while the GFX rings are idle will not be detected by software
hangcheck.

Furthermore, if hardware fault detection (a6xx_fault_detect_irq()) or
a7xx_sw_fuse_violation_irq() triggers on an LPAC job, a6xx_fault_detect_irq=
()
deletes gpu->hangcheck_timer, masks all GPU interrupts by writing 0 to
REG_A6XX_RBBM_INT_0_MASK, and queues gpu->recover_work. In recover_worker()
in drivers/gpu/drm/msm/msm_gpu.c:

    struct msm_ringbuffer *cur_ring =3D gpu->funcs->active_ring(gpu);
    ...
    submit =3D find_submit(cur_ring, cur_ring->memptrs->fence + 1);

    if (!submit)
        goto out_unlock;

If cur_ring is idle when LPAC faults, recover_worker() exits to out_unlock
without calling gpu->funcs->recover(gpu) or restoring
REG_A6XX_RBBM_INT_0_MASK, leaving GPU interrupts masked and the GPU wedged.
If cur_ring has a concurrent GFX submission, recover_worker() blames that
GFX submit, marks its VM unusable, advances cur_ring->memptrs->fence while
leaving gpu->lpac_rb->memptrs->fence unadvanced:

    for (i =3D 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
        struct msm_ringbuffer *ring =3D i < gpu->nr_rings ? gpu->rb[i] : gp=
u->lpac_rb;

        uint32_t fence =3D ring->memptrs->fence;

        if (ring =3D=3D cur_ring)
            ring->memptrs->fence =3D ++fence;

        msm_update_fence(ring->fctx, fence);
    }

and then replays the hung LPAC submission.

Also, in a6xx_gmu_pm_suspend() and a6xx_pm_suspend() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c, the loop clearing a6xx_gpu->shadow[]
only iterates up to gpu->nr_rings:

    if (a6xx_gpu->shadow_bo)
        for (i =3D 0; i < gpu->nr_rings; i++)
            a6xx_gpu->shadow[i] =3D 0;

leaving a6xx_gpu->shadow[gpu->nr_rings] for gpu->lpac_rb stale across
suspend.

Could hangcheck_handler(), recover_worker(), and the suspend shadow-clearing
loops be updated to account for gpu->lpac_rb?

[Severity: High]
When LPAC submissions on gen70900 switch context bank 1 (ASID 1) to
per-process TTBR0 pagetables via a6xx_set_pagetable(), will TLB invalidatio=
ns
on context bank 1 be skipped when those pagetables are unmapped or destroye=
d?

In msm_iommu_tlb_flush_all() and msm_iommu_tlb_flush_walk() in
drivers/gpu/drm/msm/msm_iommu.c, the primary context bank flushes check
pm_runtime_get_if_in_use(pagetable->iommu_dev), whereas the LPAC flushes
check pagetable->parent->lpac_dev:

    if (pagetable->parent->lpac_dev &&
        pm_runtime_get_if_in_use(pagetable->parent->lpac_dev)) {
        adreno_smmu =3D dev_get_drvdata(pagetable->parent->lpac_dev);

        pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);

        pm_runtime_put_autosuspend(pagetable->parent->lpac_dev);
    }

However, in adreno_gpu_init() in drivers/gpu/drm/msm/adreno/adreno_gpu.c:

    if (gpu->lpac_pdev) {
        pm_runtime_enable(&gpu->lpac_pdev->dev);
        if (!device_link_add(&pdev->dev, &gpu->lpac_pdev->dev,
                     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
            dev_err(&gpu->lpac_pdev->dev, "failed to link to lpac device\n"=
);
    }

Because gpu->lpac_pdev is populated from the child node under the GPU node =
in
arch/arm64/boot/dts/qcom/sm8650.dtsi via of_platform_populate(...,
&pdev->dev), &pdev->dev is the parent of &gpu->lpac_pdev->dev. Calling
device_link_add() with the parent (&pdev->dev) as consumer and its child
(&gpu->lpac_pdev->dev) as supplier fails in device_is_dependent() because
device_is_ancestor(consumer, supplier) is true.

As a result, lpac_dev has no runtime PM link, no bound driver, and no
autosuspend configuration, so it remains permanently in RPM_SUSPENDED with
usage_count =3D=3D 0. Even if lpac_dev were suspended while pagetable->iomm=
u_dev
is active, the SMMU hardware still retains cached TLB entries for context
bank 1. Because pm_runtime_get_if_in_use(pagetable->parent->lpac_dev) always
returns 0, tlb_flush_all() and tlb_flush_walk() are never called for context
bank 1 before page table pages are freed in msm_iommu_pagetable_destroy() or
__arm_lpae_unmap().

Should msm_iommu_tlb_flush_all() and msm_iommu_tlb_flush_walk() check
pagetable->iommu_dev (or shouldn't the runtime PM handling for lpac_dev be
fixed so context bank 1 TLBs are invalidated before freeing page tables)?

[Severity: Medium]
When LPAC is enabled on gen70900 alongside ADRENO_QUIRK_IFPC, are the LPAC =
GX
registers restored after an Inter-Frame Power Collapse (IFPC) cycle?

During hw_init() in drivers/gpu/drm/msm/adreno/a6xx_gpu.c, when gpu->lpac_rb
is present, the driver programs several GX-domain registers:

    if (gpu->lpac_rb)
        gpu_rmw(gpu, REG_A6XX_UCHE_DEBUG_CNTL_1, BIT(30), BIT(30));
    ...
    if (gpu->lpac_rb) {
        gpu_write(gpu, REG_A7XX_CP_LPAC_CHICKEN_DBG, 0x1);

        gpu_write(gpu, REG_A7XX_SP_CHICKEN_BITS_2, BIT(4));
        gpu_write(gpu, REG_A7XX_SP_LPAC_CHICKEN_BITS_2, BIT(4));
    }

In drivers/gpu/drm/msm/adreno/a6xx_catalog.c, a750_ifpc_reglist_regs includ=
es
REG_A6XX_CP_LPAC_PROTECT_CNTL, but REG_A6XX_UCHE_DEBUG_CNTL_1,
REG_A7XX_CP_LPAC_CHICKEN_DBG, REG_A7XX_SP_CHICKEN_BITS_2, and
REG_A7XX_SP_LPAC_CHICKEN_BITS_2 are absent from both a750_ifpc_reglist_regs
and a7xx_pwrup_reglist_regs, so their values will be lost when the GX domain
collapses during IFPC.

Should those four registers be added to the A750 IFPC / power-up register
lists?

>  		.funcs =3D &a7xx_gpu_funcs,

[Severity: Medium]
When gen70900 uses a7xx_gpu_funcs and submits LPAC jobs through
a7xx_submit() in drivers/gpu/drm/msm/adreno/a6xx_gpu.c, does alwayson_end
read from the wrong counter for LPAC?

At the start of a7xx_submit(), alwayson_start is sampled from
cp_always_on_counter when is_lpac is true:

    if (is_lpac)
        get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, =
index, alwayson_start));
    else
        get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, =
index, alwayson_start));

However, at the end of a7xx_submit(), alwayson_end is unconditionally
sampled from cp_always_on_context:

    get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, c=
pcycles_end));
    get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, inde=
x, alwayson_end));

When retire_submit() in drivers/gpu/drm/msm/msm_gpu.c computes:

    elapsed =3D (stats->alwayson_end - stats->alwayson_start) * 10000;

it subtracts CP_ALWAYS_ON_COUNTER from CP_ALWAYS_ON_CONTEXT, corrupting the
elapsed time, clock estimation, trace_msm_gpu_submit_retired(), and
ctx->elapsed_ns for LPAC submissions (note also that a7xx_submit() has an
unused local variable timestamp_iova).

Should the alwayson_end sample in a7xx_submit() also branch on is_lpac to
read cp_always_on_counter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D14
