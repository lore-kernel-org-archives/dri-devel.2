Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E49CC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F74A10E510;
	Sat, 12 Sep 2026 12:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i9Cuysr1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF2210E510
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:59:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A15560236;
 Sat, 12 Sep 2026 12:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC68D1F000FF;
 Sat, 12 Sep 2026 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789217975;
 bh=NR7Deq9qoGWlzpLO+QPgSGpnOi4+gQ8ycpy2hmlg8vo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i9Cuysr17RHWLK1I2yQAN7hkct4GiU5CQH+rwZkvbPG6pESVU7bUQfkh5bxdUxLRF
 fA0UEswlcrISyjlYoANxqvTzj9kDuLYDUCh4FdAtcPum3Ir2v48zfCgP/QhQcbOB8E
 /++jQ7Yg/fYVwpTjZmUL2kAbIF8FdsqmaGnMoA03VGaOgYB6YPML/EU/asluYtoV0J
 dVn22SrZZXRmfhc1dkFkpfXVhyVhSNKdzRSpbc0yDW8nd1QB1XrEw98GtmJ7jLkhsx
 OKIcxR/vnGUfx2xfACoew6mD/x6ax2Ihl/vueh7EOOAfdeMiWETl7m64TgxmAZ++Y/
 SNluXzA7h+qmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] drm/msm: release scanout framebuffers only after
 a vblank
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-4-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
 <20260912-fd-kms-fix-smmu-v3-4-a7ddc6fe2032@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 12:59:34 +0000
Message-Id: <20260912125934.CC68D1F000FF@smtp.kernel.org>
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
- [High] Concurrent execution of msm_crtc_queue_fb_unpin() and msm_crtc_vbl=
ank_off() causes a use-after-free of the unpin work item.
--

commit d546c6b2b93655071c146a3c50f9a3cb4baa8f1b
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/msm: release scanout framebuffers only after a vblank

This commit modifies the framebuffer cleanup process to defer unpinning
until after a vblank by scheduling a drm_vblank_work item. It also
provides a mechanism to release these works directly if the CRTC is
switched off and no further vblanks will arrive.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index f3e39c3907a93..4582ba040f6ff 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> @@ -165,6 +167,119 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc)
>  	vblank_ctrl_queue_work(priv, crtc, false);
>  }
> =20
> +struct msm_fb_unpin_work {
> +	struct drm_vblank_work base;
> +	struct list_head node;
> +	struct msm_kms_fb_unpin *pending;
> +	struct drm_framebuffer *fb;
> +};
> +
> +static void msm_kms_fb_unpin_release(struct msm_fb_unpin_work *unpin)
> +{
> +	msm_framebuffer_unpin(unpin->fb);
> +	drm_framebuffer_put(unpin->fb);
> +	kfree(unpin);
> +}
[ ... ]
> +void msm_crtc_vblank_off(struct drm_crtc *crtc)
> +{
[ ... ]
> +	for (;;) {
> +		spin_lock(&pending->lock);
> +		unpin =3D list_first_entry_or_null(&pending->fbs, typeof(*unpin),
> +						 node);
> +		if (unpin)
> +			list_del_init(&unpin->node);
> +		spin_unlock(&pending->lock);
> +
> +		if (!unpin)
> +			break;
> +
> +		drm_vblank_work_cancel_sync(&unpin->base);
> +		msm_kms_fb_unpin_release(unpin);

[Severity: High]
Is it possible for a concurrent msm_crtc_queue_fb_unpin() call to still be
holding the unpin pointer when this releases it?

If an atomic commit calls msm_crtc_queue_fb_unpin(), and a concurrent CRTC
disable commit concurrently calls msm_crtc_vblank_off() here, could the new=
ly
added unpin object be popped and freed before it has been scheduled?

> +	}
> +
> +out:
> +	drm_crtc_vblank_off(crtc);
> +}
> +
> +bool msm_crtc_queue_fb_unpin(struct drm_crtc *crtc, struct drm_framebuff=
er *fb)
> +{
[ ... ]
> +	drm_vblank_work_init(&unpin->base, crtc, msm_kms_fb_unpin_work);
> +
> +	spin_lock(&pending->lock);
> +	list_add_tail(&unpin->node, &pending->fbs);
> +	spin_unlock(&pending->lock);
> +
> +	if (drm_vblank_work_schedule(&unpin->base,
> +				     drm_crtc_vblank_count(crtc) + 1, true) !=3D 1) {

[Severity: High]
Can this sequence trigger a use-after-free or double-free?

Since the unpin object is published to pending->fbs before calling
drm_vblank_work_schedule(), and the lock is dropped, a concurrent
msm_crtc_vblank_off() could potentially grab the object from the list and
free it.

If that happens, does this code then attempt to access the freed unpin->bas=
e,
and potentially double-free it with the kfree(unpin) below if scheduling
fails?

> +		spin_lock(&pending->lock);
> +		list_del_init(&unpin->node);
> +		spin_unlock(&pending->lock);
> +
> +		drm_framebuffer_put(fb);
> +		kfree(unpin);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-fd-kms-fix=
-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com?part=3D4
