Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55674C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7D510E61D;
	Wed,  8 Jul 2026 15:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QpiC52vS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6560410E61D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:42:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BE13600C3;
 Wed,  8 Jul 2026 15:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D471F00A3A;
 Wed,  8 Jul 2026 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783525370;
 bh=Qtj/XoqzUceJE76zSpPKI3Y4F1yMb2WfqmACKfM5usM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QpiC52vSnQmXSmRhMcHoXR3mjH85mKad7a5rguE2emWMnjWiv9kKeQ6rHMuGB5c/I
 gPIpSPliAsGr4hlx0cEFMgwCeOGIas3UdGcArkH0Z8fV5IL3bgkAO2TFxvaHvULRB2
 6hxyycGCaOCg8FRzZWxp2luhSk2k2JpAkEGHdZMcpZNWpBVQ3wsfMXohV8Jy1Pmpya
 jG5iKMSgTCzROQ/HMqPh/dr5v0pYYQAjSe00SyewWl7tJBPp/hw8rv9bqbkED8+2uW
 6RodShltOPrVppkLGA+GSll1rve0iD+206gu6sLLUMYCK8/V21f3+xaQQabHR2ryu9
 Xnn/SfzgC/zag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
To: =?utf-8?b?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708-linux-drm_crtc_fix2-v2-1-cf72be75d75a@linaro.org>
References: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
 <20260708-linux-drm_crtc_fix2-v2-1-cf72be75d75a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:42:49 +0000
Message-Id: <20260708154250.07D471F00A3A@smtp.kernel.org>
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
- [Critical] Incomplete fix: UAF due to dangling dma_fence->extern_lock and=
 RCU-001 violation
--

--- Patch [1]: [PATCH v2 1/2] drm/drm_crtc: ensure dma_fence_ops remain val=
id during device unbind ---
commit be7b3e18f378ca6990d9039f7a24dee91cbb6d7d
Author: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind

This commit attempts to fix a use-after-free when userspace accesses a
dma_fence whose underlying CRTC has been destroyed. It adds a
synchronize_rcu() call to drm_crtc_cleanup() to ensure dma_fence_ops
remain valid during an RCU grace period.

Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e=
77b36f34@linaro.org?part=3D1

> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -501,6 +501,12 @@ void drm_crtc_cleanup(struct drm_crtc *crtc)
>  {
>  	struct drm_device *dev =3D crtc->dev;
> =20
> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
> +	 * the fence is signaled. This is necessary because our dma_fence_ops
> +	 * dereference crtc->dev.
> +	 */
> +	synchronize_rcu();

[Severity: Critical]
This is a pre-existing issue, but the fix seems incomplete and might leave
critical use-after-free paths open.

First, does this sequence leave the fence's external lock dangling? When
drm_crtc_create_fence() initializes the fence, it uses &crtc->fence_lock
as the external lock:

drm_crtc_create_fence() {
    ...
    dma_fence_init(fence, &drm_crtc_fence_ops, &crtc->fence_lock,
                   crtc->fence_context, ++crtc->fence_seqno);
    ...
}

If userspace calls ioctl(SYNC_IOC_FILE_INFO), sync_fill_fence_info()
unconditionally calls dma_fence_get_status(fence). This calls
dma_fence_lock_irqsave(), which attempts to acquire fence->lock.

If the CRTC has been freed, wouldn't this result in a use-after-free when
acquiring the spinlock? The synchronize_rcu() here protects RCU readers,
but fence->lock is accessed outside of RCU.

Second, does this violate the RCU removal-before-reclaim ordering if the
fence was never signaled?

If the fence isn't signaled (for example, during an error or unplug path),
dma_fence_signal() is never called and fence->ops is never set to NULL.

If fence->ops is not cleared before synchronize_rcu() is called, could new
RCU readers start after the grace period ends, see a non-NULL fence->ops,
and access the freed CRTC memory via ops->get_driver_name(fence)?

> +
>  	/* Note that the crtc_list is considered to be static; should we
>  	 * remove the drm_crtc at runtime we would have to decrement all

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-linux-drm_=
crtc_fix2-v2-0-cf72be75d75a@linaro.org?part=3D1
