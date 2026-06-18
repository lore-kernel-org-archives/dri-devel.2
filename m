Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA67CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDBA910F302;
	Thu, 18 Jun 2026 14:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O/ycKOv7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A2E10F302
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:16:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32E4C60008;
 Thu, 18 Jun 2026 14:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64571F000E9;
 Thu, 18 Jun 2026 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781792192;
 bh=0vF2Lbl7PKNU3Op4IswjUlAmYZJM3H1wMwqZZRcxx3o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O/ycKOv7YeIGBr7/6abl6HCC5U6lMU39vxNmlWi2M1ec/2lwr9tQPHFF60Pc2Bdhk
 6aNHNUvdMcJgmIVUT/RuK1DHy/CLs77GguRdCYevMZMNp+/muuMqvRrsqZvj4mDzr3
 zXzbWe++2R849nRnaxgsctxt3jmIsP4LpwlaL1WF3E8zaEq9z5/HgX2gVUGW4A+omm
 5lrjGffc263mpXqw0zfFf4QdGzOPw62AYC3HAQ+Q2jQs/VL2MwWHqZeOM3kavVk3zN
 IQKbwNo2A1AQTL+2mEnZC8/T7DbY5X6xM2lbRs/tWQojvA+Ib6RC6sA+bmBW6m7mM9
 cnBRvWZdTH1Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
To: =?utf-8?b?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
References: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 14:16:31 +0000
Message-Id: <20260618141632.B64571F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Use-After-Free in get_driver_name() and get_timeline_name() du=
e to dma_fence RCU contract violation during CRTC teardown.
--

commit 4e03eb31730ff05ffb65d7d539f01df4c6b89099
Author: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

This patch removes a BUG_ON() in drm_crtc_fence_get_driver_name() that
was triggering because the dma_fence_ops get detached upon signaling.

> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba67564..31c8636e74677 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c

[ ... ]

> @@ -154,14 +157,6 @@ static void drm_crtc_crc_fini(struct drm_crtc *crtc)
>  #endif
>  }
> =20
> -static const struct dma_fence_ops drm_crtc_fence_ops;
> -
> -static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
> -{
> -	BUG_ON(rcu_access_pointer(fence->ops) !=3D &drm_crtc_fence_ops);
> -	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
> -}
> -
>  static const char *drm_crtc_fence_get_driver_name(struct dma_fence *fenc=
e)
>  {
>  	struct drm_crtc *crtc =3D fence_to_crtc(fence);

[Severity: Critical]
This is a pre-existing issue, but does removing this BUG_ON() unmask a
use-after-free during device teardown?

Looking at how these fences are managed, drm_crtc_create_fence() creates
a dma_fence without taking a reference to the drm_device or drm_crtc.
Because the sync_file framework exposes this fence to userspace, the fence
can outlive the CRTC.

The dma_fence contract requires that data accessed by dma_fence_ops (like
get_driver_name) must remain valid for an RCU grace period after the fence
is signaled. However, drm_crtc_cleanup() and the subsequent freeing of the
device do not wait for an RCU grace period via synchronize_rcu().

If userspace calls ioctl(SYNC_IOC_FILE_INFO) concurrently with a device
hot-unplug:

CPU1 (Userspace)
sync_file_get_name()
  ops =3D rcu_dereference(fence->ops);
  if (!dma_fence_test_signaled_flag())
    // Preempted or delayed here

CPU2 (Driver Teardown)
Signals the fence (setting fence->ops =3D NULL)
Destroys and frees the CRTC without waiting for an RCU grace period

CPU1 (Resumes)
  ops->get_driver_name(fence) -> drm_crtc_fence_get_driver_name()
  crtc =3D fence_to_crtc(fence); // Casts to the freed CRTC
  return crtc->dev->driver->name; // Use-after-free

While the BUG_ON() was causing spurious panics during normal operation,
it seems it was also inadvertently preventing this use-after-free from
proceeding silently.

Does the CRTC or DRM device need to be kept alive for the RCU grace period,
or should the fence hold a proper reference to prevent the use-after-free
when get_driver_name() and get_timeline_name() access the freed CRTC
structure?

>=20
> 	return crtc->dev->driver->name;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-linux-drm_=
crtc_fix2-v1-1-c03e77b36f34@linaro.org?part=3D1
