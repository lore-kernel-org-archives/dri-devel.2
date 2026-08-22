Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4ACC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 09:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B4210E3CF;
	Sat, 22 Aug 2026 09:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DYSPOJFK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8746D10E3CF
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 09:07:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E55FD600E2;
 Sat, 22 Aug 2026 09:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624751F000E9;
 Sat, 22 Aug 2026 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787389677;
 bh=B00MqBtN7O2fMaJw/iYBe3Xcjn5EmqBfm1tD6JYIY1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DYSPOJFK946MwZrHVEPXQkOUz/Sn1VD4SqXPD5KFY1RLQY/9mwqWcadqdrngNkhuI
 D5bls7Kxkbaf3ACJSkYvNDZ+VUzQIPAh2mbEdN743cmlsKYZCvVUMzUKpgv4PrH7G4
 O6I4s8REz0EFALzO9r3ZEbwAwHBNA9Lt8br/4GEiPnGpKQ9b7GkjHCVSGDgdg+0QPm
 THCW01kQHeR4K8uc5eAiOQ0AewjaBJD/SpuNiNF48d4s7g9q1tHsZBaU5hUzg4sjEy
 6M5B3za730pIgWmX2+HSc4NGttgalexrWDuxWsH/nee5ssoem6XWD5sw0CCvz02EYP
 JxFe7RJiUgIdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on
 handle close
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
 <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:07:56 +0000
Message-Id: <20260822090757.624751F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Sleeping in atomic context
- [High] Deferred teardown TOCTOU race via flink name re-opening causing IO=
VA Use-After-Free
--

--- Patch [2]: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on h=
andle close ---
commit c4a550033efcf938dc9587175385266d18df3979
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: don't tear down shared VM mappings on handle close

This patch defers the teardown of shared GPU VM mappings until the vma_ref
count drops to zero. This aims to prevent pulling the buffer out from under
other files that still have it open when sharing a global VM address space
on targets without per-process pgtables.

Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 8b979d84bb958..f17ecd97b72a3 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
[ ... ]
> @@ -109,6 +114,12 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
>  	if (atomic_dec_return(&to_msm_bo(obj)->vma_ref))
>  		return;
> =20
> +	if (priv->gpu && priv->gpu->vm_shared) {
> +		dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false,
> +				      MAX_SCHEDULE_TIMEOUT);
> +		put_iova_spaces(obj, priv->gpu->vm, true, "vma_put");
> +	}
> +

[Severity: High]
This is a pre-existing issue, but can this lockless vma_ref check lead to an
IOVA use-after-free if a GEM handle is concurrently closed and re-opened via
flink?

If Thread A closes the last handle, atomic_dec_return() drops vma_ref to 0
and it proceeds to unmap the buffer. However, the flink name remains valid
until drm_gem_object_handle_put_unlocked() runs. If Thread B calls
DRM_IOCTL_GEM_OPEN concurrently, msm_gem_open() can increment vma_ref back =
to
1 and submit a job using the IOVA. Thread A then acquires locks in
put_iova_spaces() and unconditionally unmaps the buffer via
put_iova_spaces_locked() without re-verifying vma_ref:

drivers/gpu/drm/msm/msm_gem.c:put_iova_spaces_locked() {
    ...
    drm_gpuvm_bo_for_each_va_safe (vma, vmatmp, vm_bo) {
        msm_gem_vma_unmap(vma, reason);
        if (close)
            msm_gem_vma_close(vma);
    }
}

Will this destroy Thread B's mapping while its job is running, freeing the
IOVA for immediate reuse?

[Severity: High]
This isn't a bug introduced by this patch, but does adding these blocking
calls cause a scheduling while atomic panic when tearing down a writeback
connector?

The drm core function drm_writeback_connector_cleanup() holds a spinlock wi=
th
IRQs disabled when tearing down pending jobs:

drivers/gpu/drm/drm_writeback.c:drm_writeback_connector_cleanup() {
    spin_lock_irqsave(&wb_connector->job_lock, flags);
    list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
        list_del(&pos->list_entry);
        drm_writeback_cleanup_job(pos);
    }
}

This calls into msm_gem_vma_put() through the teardown path
(dpu_wb_conn_cleanup_job -> dpu_encoder_cleanup_wb_job ->
dpu_encoder_phys_wb_cleanup_wb_job -> msm_framebuffer_cleanup ->
msm_gem_vma_put).

Since dma_resv_wait_timeout() can wait indefinitely and put_iova_spaces()
acquires ww_mutexes via drm_exec, could this result in sleeping while holdi=
ng
a spinlock with IRQs disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-msm-fix-ex=
port-v1-0-917b3cbedd43@oss.qualcomm.com?part=3D2
