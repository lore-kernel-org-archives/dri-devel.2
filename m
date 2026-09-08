Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98352C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7AD10ECD1;
	Tue,  8 Sep 2026 15:42:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1BA10ECD1
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:42:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E21F0601FA;
 Tue,  8 Sep 2026 15:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB01F00ADE;
 Tue,  8 Sep 2026 15:42:52 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] drm/msm: release scanout framebuffers only after
 a vblank
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-3-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
 <20260908-fd-kms-fix-smmu-v2-3-9391815742a8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:42:25 +0000
Message-Id: <20260908154252.A2FB01F00ADE@smtp.kernel.org>
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
- [High] Fatal NULL pointer dereference in msm_kms_fini_fb_unpin() when han=
dling initialization errors if msm_kms_init_fb_unpin() was not completed.
- [High] Deferred framebuffer unpin logic creates a TOCTOU race for shared =
framebuffers, leading to premature synchronous unpin and IOMMU faults.
--

commit ce24ef75bb4418725e7dde4f8dcb994be7c35638
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: release scanout framebuffers only after a vblank

This commit defers the release of scanout framebuffers until after a vblank
has occurred by queuing the unpin work via a vblank worker. It prevents
hardware from fetching unmapped memory by ensuring the new configuration is
fully latched before detaching the VMA.

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index dfe040d5260bc..2e317bec9fbbb 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
[ ... ]
> @@ -144,6 +145,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *=
fb, bool needed_dirtyfb)
> =20
>  	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
> =20
> +	if (crtc && msm_crtc_queue_fb_unpin(crtc, fb))
> +		goto out;
> +
>  	for (i =3D 0; i < n; i++) {
>  		msm_gem_unpin_iova(fb->obj[i], vm);
>  		msm_gem_vma_put(fb->obj[i]);

[Severity: High]
Does this deferred unpin logic handle shared framebuffers safely?

If a framebuffer is shared across multiple CRTCs and an atomic commit remov=
es
it from all of them simultaneously, msm_framebuffer_cleanup() is called
sequentially for each plane. The last plane processed drops prepare_count to
zero and funnels the unpin to a single CRTC.

If that final CRTC happens to be disabled (where crtc->state->active is fal=
se
in msm_crtc_queue_fb_unpin()), it returns false, causing an immediate
synchronous unpin here. This could fault any other active CRTCs that haven't
reached their vblank and are still actively scanning out the old frame.

Even if active, could the last processed CRTC reach its vblank and unpin the
buffer before slower CRTCs finish their frames?

[ ... ]
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index e5d0ea6294484..6a857ad3464c4 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> +void msm_kms_fini_fb_unpin(struct drm_device *dev)
> +{
> +	struct msm_drm_private *priv =3D dev->dev_private;
> +	struct msm_kms *kms =3D priv->kms;
> +	struct drm_crtc *crtc;
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		unsigned int idx =3D drm_crtc_index(crtc);
> +
> +		if (idx >=3D ARRAY_SIZE(kms->fb_unpin))
> +			continue;
> +
> +		drm_vblank_work_cancel_sync(&kms->fb_unpin[idx].vblank_work);

[Severity: High]
Can this cause a NULL pointer dereference on initialization error paths?

If msm_drm_kms_init() fails after CRTCs are created but before
msm_kms_init_fb_unpin() succeeds (for example, if drm_vblank_init() fails),
the error path calls msm_drm_kms_uninit(), which unconditionally calls
msm_kms_fini_fb_unpin().

Because the vblank_work structs were zero-allocated and never initialized,
drm_vblank_work_cancel_sync() will dereference a NULL work->vblank:

drivers/gpu/drm/drm_vblank_work.c:drm_vblank_work_cancel_sync() {
    struct drm_vblank_crtc *vblank =3D work->vblank;
    struct drm_device *dev =3D vblank->dev;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-fd-kms-fix=
-smmu-v2-0-9391815742a8@oss.qualcomm.com?part=3D3
