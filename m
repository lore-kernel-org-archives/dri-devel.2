Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D2606E813
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcc25o6W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0F810FEC6;
	Wed,  4 Nov 2026 20:03:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B0E10FEC9
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:03:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89F0D4139C;
 Wed,  4 Nov 2026 20:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473F31F000C1;
 Wed,  4 Nov 2026 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793822590;
 bh=4FUxamKpcD1oLDU3L7OUQu6rIetIJ6tVX6NW4gd+ZxE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kcc25o6WMMhH+/vDRATacK1xBPHcdVeBc/qnvqKciWN31zKeKl8q2egHBSMNRNkwA
 WWiU2AieZIyOjK0ZqrxyA4p1197XJOePwALWrIEbvM9rk6py0wbBPbP822gdh+zDHb
 RjtG9w9qZebNHLUhGEC5hs7igt3hdN2wg33Q/7DYY4usaikHAtYHOJnSHOQoV1ZyLj
 PXiX4CCq7/1F0BFl4tMSvoE/Rpcnr/dvOZh066NrcNXaTOV0SjgWQaTWxnBdn7MKlk
 58UDCbhnPpzkb7S3eqE9eeHtS56QKb/sd2dUdKH+9vuIw3aU1IrfojPnKzaaTYqUqW
 fmhYTq+v7YDzA==
Message-ID: <sashiko-outbox-197988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/panfrost: Enable cycle counting when perfcnt
 is enabled
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104-panfrost-reset-races-fixes-v3-1-09868a88c351@collabora.com>
References: <20261104-panfrost-reset-races-fixes-v3-0-09868a88c351@collabora.com>
 <20261104-panfrost-reset-races-fixes-v3-1-09868a88c351@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:03:09 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panfrost: cycle_counter ref leak in panfrost_perfcnt_reset()=
 on timeout
--

commit 5c53c60920207774a536024e17e8e90206c7ae20
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panfrost: Enable cycle counting when perfcnt is enabled

This commit enables cycle counting when performance counters are active so
that block headers contain valid timestamps, and removes the warning in
panfrost_gpu_soft_reset() when resetting pfdev->cycle_counter.use_count.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index a9def452d5ef9..b26da057a1a01 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c

[ ... ]

> @@ -84,6 +86,7 @@ static int panfrost_perfcnt_hw_enable(struct panfrost_d=
evice *pfdev)
>  		return ret;
> =20
>  	perfcnt->owns_as_ref =3D true;
> +	panfrost_cycle_counter_get(pfdev);

[Severity: Medium]
As reported by Sashiko on v2 [1], can this leak a reference on
pfdev->cycle_counter.use_count if panfrost_gpu_soft_reset() times out
during panfrost_device_reset()?

In panfrost_gpu_soft_reset(), if both the soft reset and hard reset
polling loops time out, the function returns early before zeroing
pfdev->cycle_counter.use_count:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_soft_reset() {
	...
	if (ret) {
		...
		if (ret) {
			dev_err(pfdev->base.dev, "gpu hard reset timed out\n");
			return ret;
		}
	}
	...
	atomic_set(&pfdev->cycle_counter.use_count, 0);
}

However, panfrost_device_reset() ignores the return value of
panfrost_gpu_soft_reset() and continues with panfrost_mmu_reset() and
panfrost_perfcnt_reset():

drivers/gpu/drm/panfrost/panfrost_device.c:panfrost_device_reset() {
	...
	panfrost_gpu_soft_reset(pfdev);

	panfrost_gpu_power_on(pfdev);
	panfrost_mmu_reset(pfdev);
	...
	panfrost_perfcnt_reset(pfdev);
}

panfrost_perfcnt_reset() then clears perfcnt->owns_as_ref without
releasing the existing cycle counter reference and calls
panfrost_perfcnt_hw_enable(), which succeeds in panfrost_mmu_as_get() and
calls panfrost_cycle_counter_get() a second time:

drivers/gpu/drm/panfrost/panfrost_perfcnt.c:panfrost_perfcnt_reset() {
	...
	/* All active AS are released during the MMU post_reset. */
	perfcnt->owns_as_ref =3D false;
	perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
	if (panfrost_perfcnt_hw_enable(pfdev))
		perfcnt->state |=3D PANFROST_PERFCNT_SESSION_DEAD;
}

When the session is later disabled via panfrost_perfcnt_hw_disable(),
panfrost_cycle_counter_put() only decrements pfdev->cycle_counter.use_count
once, leaving a leaked reference count that prevents the cycle counter
from stopping.

[1] https://lore.kernel.org/r/20261103-panfrost-reset-races-fixes-v2-1-4542=
07b1d4e3@collabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-panfrost-r=
eset-races-fixes-v3-0-09868a88c351@collabora.com?part=3D1
