Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35F7C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6601E10F5BB;
	Thu,  3 Sep 2026 13:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DZCrxAD5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751BB10F5C4
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:39:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32F4B40832;
 Thu,  3 Sep 2026 13:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDADC1F000E9;
 Thu,  3 Sep 2026 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788442766;
 bh=IzYyHg+H/+36rtyX5/Cw+1f1Q1XwiVna7VJw7CMPVqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DZCrxAD5Jwul79YjLvnA9vLlKRjcCAHAlblsSimoIluaAUwLS14PTRbeR9I6tvlcc
 2umZoFsHrbs0S8T/gZRXwKlxyJCEnMTt6NT9S5YVneJwd54vjLMTHB0WXAeMUjedTj
 n58aacgW0klrW61MEPy1AeIm8QsxbJS62SqWQcJDHRJQBvyD0sHGxaOJbuD901jT00
 Jm5qQiZIiFTb8EpK8+exZaJGXLFnmoo/ctreOlI/3bI0h0ReZB+OATzP5/zwSjf471
 0dhJVyzEIjm6+alk+Fo85YBQSo89UYoCklTLL/3nnqpNsAjH4b4YqMn+BjZ774J3U4
 jwz7BnhkgkEQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm: release scanout framebuffers only after a
 vblank
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903-fd-kms-fix-smmu-v1-2-608d02491666@oss.qualcomm.com>
References: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
 <20260903-fd-kms-fix-smmu-v1-2-608d02491666@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:39:25 +0000
Message-Id: <20260903133925.EDADC1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Unpin worker accesses freed `kms->vm` during teardown because =
`destroy_workqueue(kms->wq)` is called after `kms->vm` is destroyed.
- [Critical] Unconditional cleanup of uninitialized `drm_vblank_work` struc=
ts causes a NULL pointer dereference in `msm_kms_destroy` on systems with f=
ewer than MAX_CRTCS (8).
- [High] Teardown race in `msm_kms_destroy` causes a spurious WARN_ON becau=
se flip works are cleaned up before the workqueue is flushed.
- [High] Framebuffers and their pinned GPU memory leak permanently when a C=
RTC is disabled because `drm_vblank_work_schedule()` returns 0 when the CRT=
C is off, bypassing the manual flip work commit.

Pre-existing issues:
- [High] Concurrent prepare_fb and cleanup_fb of a shared framebuffer cause=
s `msm_fb->iova` to be erroneously zeroed out, leading to IOMMU faults.
--

commit e00895b91abad99d555ba6e2dfe2858e778599be
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/msm: release scanout framebuffers only after a vblank

This commit delays the release of scanout framebuffers until after a vblank
event completes to prevent the display hardware from fetching unmapped memo=
ry
during an atomic commit. It defers the unpin operations to a workqueue runn=
ing
from the vblank irq context.

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index 934337202afd4..0865ecce77de2 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
[ ... ]
> @@ -127,6 +128,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *=
fb, bool needed_dirtyfb)
> =20
>  	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
> =20
> +	if (crtc && msm_crtc_queue_fb_unpin(crtc, fb))
> +		return;
> +

[Severity: High]
This is a pre-existing issue, but can a concurrent atomic commit cause IOMMU
faults here?

The lockless gap between atomic_dec_return(&msm_fb->prepare_count) (which
occurs earlier in this function) and the memset(msm_fb->iova, 0, ...)
creates a time-of-check to time-of-use race.=20

If msm_framebuffer_prepare() runs concurrently on the same framebuffer, it
can increment prepare_count and pin the valid IOVAs before this unprotected
memset executes, overwriting the newly pinned, valid IOVAs with zeros. The
display hardware is then programmed with IOVA 0, causing it to read unmapped
memory.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index e5d0ea6294484..bf56fbe99a346 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> +void msm_kms_fb_unpin_worker(struct drm_flip_work *work, void *val)
> +{
> +	struct drm_framebuffer *fb =3D val;
> +	struct msm_drm_private *priv =3D fb->dev->dev_private;
> +	struct drm_gpuvm *vm =3D priv->kms->vm;
> +	int i, n =3D fb->format->num_planes;
> +
> +	for (i =3D 0; i < n; i++) {
> +		msm_gem_unpin_iova(fb->obj[i], vm);

[Severity: Critical]
Can this unpin worker dereference a freed vm pointer during module unload?

During driver teardown, mdp4_kms_destroy() and mdp5_kms_destroy() drop the
final reference and free the VM. Following that, msm_kms_destroy() is called
which invokes destroy_workqueue(kms->wq).=20

Because the workqueue is drained after the VM is already destroyed, any pen=
ding
unpin tasks will execute, read the freed priv->kms->vm pointer, and cause a
fatal use-after-free crash when attempting to unpin the memory.

[ ... ]
> +bool msm_crtc_queue_fb_unpin(struct drm_crtc *crtc, struct drm_framebuff=
er *fb)
> +{
> +	struct msm_drm_private *priv =3D crtc->dev->dev_private;
> +	struct msm_kms *kms =3D priv->kms;
> +	unsigned int idx =3D drm_crtc_index(crtc);
> +
> +	if (!kms || idx >=3D ARRAY_SIZE(kms->fb_unpin))
> +		return false;
> +
> +	drm_framebuffer_get(fb);
> +	drm_flip_work_queue(&kms->fb_unpin[idx].work, fb);
> +
> +	/* no vblank to wait for: the crtc is off, so it is not fetching */
> +	if (drm_vblank_work_schedule(&kms->fb_unpin[idx].vblank_work,
> +				     drm_crtc_vblank_count(crtc) + 1, true) < 0)
> +		drm_flip_work_commit(&kms->fb_unpin[idx].work, kms->wq);
> +
> +	return true;
> +}

[Severity: High]
Does this code permanently leak framebuffers when a CRTC is disabled?

The fallback check assumes drm_vblank_work_schedule() returns a negative
error code when the CRTC is off. However, looking at the drm core:

drm_vblank_work_schedule() {
    ...
    spin_lock(&dev->vbl_lock);
    inmodeset =3D vblank->inmodeset;
    spin_unlock(&dev->vbl_lock);
    if (inmodeset)
        goto out; // returns 0
    ...
}

Because drm_vblank_work_schedule() returns 0 instead of < 0 when
vblank->inmodeset is true, the manual drm_flip_work_commit() fallback is
bypassed. This leaves the unpin work permanently queued, leaking the
framebuffer and its pinned GPU memory since no worker will be scheduled.

> diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
> index f25b31e502d21..4b73132b5f6ea 100644
> --- a/drivers/gpu/drm/msm/msm_kms.h
> +++ b/drivers/gpu/drm/msm/msm_kms.h
[ ... ]
> @@ -203,6 +227,11 @@ static inline void msm_kms_destroy(struct msm_kms *k=
ms)
>  	for (i =3D 0; i < ARRAY_SIZE(kms->pending_timers); i++)
>  		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
> =20
> +	for (i =3D 0; i < ARRAY_SIZE(kms->fb_unpin); i++) {
> +		drm_vblank_work_cancel_sync(&kms->fb_unpin[i].vblank_work);
> +		drm_flip_work_cleanup(&kms->fb_unpin[i].work);
> +	}
> +

[Severity: Critical]
Does this unconditional teardown loop cause a NULL pointer dereference on
systems with fewer than MAX_CRTCS?

msm_kms_init_fb_unpin() initializes vblank_work structures only for the
actually registered CRTCs. If the hardware has fewer CRTCs than MAX_CRTCS
(8), the remaining array entries are left zero-initialized.=20

drm_vblank_work_cancel_sync() immediately dereferences work->vblank to get
the device pointer, which will cause a fatal crash for those uninitialized
entries.

[Severity: High]
Can this teardown order cause a spurious kernel warning?

drm_flip_work_cleanup() expects the work->commited and work->queued lists to
be empty and will trigger a WARN_ON if they are not. Because it is called
here before destroy_workqueue(kms->wq) has flushed the pending tasks, the
work items may still be actively queued.

>  	destroy_workqueue(kms->wq);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-fd-kms-fix=
-smmu-v1-0-608d02491666@oss.qualcomm.com?part=3D2
