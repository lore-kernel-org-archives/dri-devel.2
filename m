Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4694CA5FE8
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1950210E721;
	Sat,  3 Oct 2026 01:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jdupZsx6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC08910E721
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:34:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F93F60DA0;
 Sat,  3 Oct 2026 01:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7271F000FF;
 Sat,  3 Oct 2026 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991270;
 bh=SU1fqTvptTyfGY5rpeVOWgHr8c/cH6hmCMMRBeq6R28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jdupZsx62z1gPYSM5uvoXjPicQZI5OaKwAnHhIAdVmqNF2QoS0o71MxtNqlgewqq5
 +86YP+iT9EmBubJh1deie6ySsnJFPZHAt74n/h7dXgnEPdUou/51EcW9njbGiFzN5I
 fNVM9bj5OFykPAXY1Nek5vEI76yussoSe4nxsRg9afm1GyZOsp7ACr6QXCDp9gcaGI
 zbR1ARUJazybB9mIA4YSJhZW9juWjqym9X8XIRkj34ZXaGtPE1D8JM0c5VD2Gm7rOg
 aAuLzgsDAH1XOboa93+0aeKUgHx+qXBigcVJTiNg0SwpkGCdWCcEdzaiLdJB2L5fyk
 QAa+ipvCy7Ewg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] drm/msm: release scanout framebuffers only
 after a vblank
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-3-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
 <20261003-fd-kms-fix-smmu-v4-3-2a44d4d8ac77@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:29 +0000
Message-Id: <20261003013429.DF7271F000FF@smtp.kernel.org>
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
- [High] drm/msm: premature unpin of framebuffers causing IOMMU fault
--

commit 86394032733ab2293f0e387866c3cbd603bc3285
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/msm: release scanout framebuffers only after a vblank

This commit defers scanout framebuffer release until a vblank by handing th=
em
to a drm_vblank_work per CRTC. On CRTC disable, pending works are flushed a=
nd
framebuffers are unpinned directly from msm_crtc_vblank_off().

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index 7e1df472592d3..cb497d419ab83 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> +/*
> + * The crtc stops fetching here, and with it the vblanks the pending wor=
ks are
> + * waiting for, so release the framebuffers directly.
> + */
> +static void msm_kms_fb_unpin_release_all(struct msm_kms_fb_unpin *pendin=
g)
> +{
[ ... ]
> +		drm_vblank_work_cancel_sync(&unpin->base);
> +		msm_kms_fb_unpin_release(unpin);
> +	}
> +}
> +
> +void msm_crtc_vblank_off(struct drm_crtc *crtc)
> +{
> +	struct msm_drm_private *priv =3D crtc->dev->dev_private;
> +	struct msm_kms *kms =3D priv->kms;
> +	unsigned int idx =3D drm_crtc_index(crtc);
> +
> +	if (kms && idx < ARRAY_SIZE(kms->fb_unpin))
> +		msm_kms_fb_unpin_release_all(&kms->fb_unpin[idx]);
> +
> +	drm_crtc_vblank_off(crtc);
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 77a2d1f6700d0..35daf46fc4257 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1213,7 +1213,7 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>  	}
> =20
>  	/* Disable/save vblank irq handling */
> -	drm_crtc_vblank_off(crtc);
> +	msm_crtc_vblank_off(crtc);

[Severity: High]
Can this lead to an IOMMU context fault if the display hardware is still=20
fetching the frame?

When a userspace application issues an async plane update followed closely =
by=20
a CRTC disable, the ongoing hardware fetch might hit an IOMMU fault because=
=20
the memory is unmapped immediately during the disable sequence.

Because msm_crtc_vblank_off() now synchronously unpins and unmaps all pendi=
ng=20
framebuffers via msm_kms_fb_unpin_release_all(), executing this before the=
=20
hardware is done fetching creates a race window.

Looking at dpu_crtc_disable(), we wait for the hardware to finish its curre=
nt=20
frame fetch much later in the function:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_disable() {
    ...
    msm_crtc_vblank_off(crtc);
    ...
    if (_dpu_crtc_wait_for_frame_done(crtc))
        DPU_ERROR(...);
    ...
}

Does this sequence leave a race window where the display is left reading=20
unmapped memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-fd-kms-fix=
-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com?part=3D3
