Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6654C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8C510F05B;
	Wed, 12 Aug 2026 15:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z2d7gQNJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677D310F05B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:05:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43FA960A92;
 Wed, 12 Aug 2026 15:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9841F000E9;
 Wed, 12 Aug 2026 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786547125;
 bh=AiT6eeKVQR2JnMnQSnr5xcCXQVV9+tIoVKNc0R9EQ6E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z2d7gQNJBaVlQnKyWvkITG7E/rA5pvLXO7q84eMF0HPf1+GIp4RxJpyNfvaZE6Rcn
 1e+b8JqIN50mdx4wAPTgsv4qAvpCIP5cCr+HrAH79KBpq3hJ4TpRdQP3gbOOmu76xD
 Tyg/Z1g7Z+nQDYXXY2CiFuIsjZRDOATpujpt5aPi7U44Hc6EPhfJBPtnvc66xc0Wfx
 RlTBu2GVJg0Ed69EFZ8jLZN36sArrRY7JdIfuCwwHUkJ8wdQ7bk3d8CiP32cxYI8El
 EuAe5w9v+sKVWxSUceabm6w/vrQYPQAH/dVUBGQlrkhbwX8W6EcGmku9oMEAeGAaTS
 V678ud5I+p3vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] drm/panthor: Take reqs_lock in soft_reset for
 clearing pending_reqs
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
 <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:05:24 +0000
Message-Id: <20260812150524.CE9841F000E9@smtp.kernel.org>
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
- [High] Timeout paths in GPU and PWR requests return early without clearin=
g pending flags, permanently breaking subsequent requests.
--

--- Patch [3]: [PATCH v4 3/3] drm/panthor: Take reqs_lock in soft_reset for=
 clearing pending_reqs ---
commit d885508a531cdec1cd82fefa1c02cfc762aa4b05
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

This commit adds a missing lock around the clearing of pending_reqs in
panthor_gpu_soft_reset().

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index 55e33f145b40b..fb2702e1e0a2e 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -424,7 +424,10 @@ int panthor_gpu_soft_reset(struct panthor_device *pt=
dev)
>  		return -ETIMEDOUT;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning early here permanently wed=
ge
the state machine?

If a hardware timeout occurs, this path returns -ETIMEDOUT and bypasses the
cleanup of pending_reqs. Subsequent calls to panthor_gpu_soft_reset() will
then hit the drm_WARN_ON for GPU_IRQ_RESET_COMPLETED, skip issuing the actu=
al
hardware command, and inevitably time out again.

Similar issues appear to exist in the timeout paths for
panthor_gpu_flush_caches() and panthor_pwr_reset() where early returns
bypass clearing the pending flags.

> =20
> -	ptdev->gpu->pending_reqs =3D 0;
> +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +		ptdev->gpu->pending_reqs =3D 0;
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-panthor-ca=
che-flush-fix-v4-0-751e32901898@collabora.com?part=3D3
