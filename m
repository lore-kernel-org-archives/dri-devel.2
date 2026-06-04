Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF3CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E42111A222;
	Thu,  4 Jun 2026 17:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LbooHSvY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CF711A222
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 998EA60052;
 Thu,  4 Jun 2026 17:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC551F00893;
 Thu,  4 Jun 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780595358;
 bh=BgSP3IPBoxNycat9P8BFSROqA3u+P0agcbJEIzc4wZA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LbooHSvY86GL9esSseycJggfk/BMM1g6wPNMqaAwuJ2FiG/4TroTLzKSD9RHoMRlf
 XaTVR/hjfp3RXo9Wev6oi5wSlEa3Z85gYq5jKpaB1OZINNMAGaqUYAV42B0EaG2+o4
 wTc2EU/fWBF5vOZGPCqZivi1R4wGGsgCzEkkIF67dwkxBcodE5E76ocX7DujdWV4NU
 132OY+Ol6Iwh9rsaVt3PELddX4IBBC8B7toqgJ/t+xB5glMHMDA5NXeOiU/ngpBCpN
 J1+U7QTCQyUxmEKqOsWEqk+USUq6H0U5OYIGzg+qpH9E87QnX7rEGHalRcD9Jxe9cy
 gq0MJOBs+ZiLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] drm/panfrost: Make reset sequence deal with an
 active HWPerf session
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:49:17 +0000
Message-Id: <20260604174918.2BC551F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Address Space reference (mmu->as_count) permanently leaks when har=
dware reset aborts perfcnt_enable_locked.
- [High] A TOCTOU race between disable_locked and the asynchronous reset wo=
rkqueue reintroduces the mmu->as_count underflow WARN.
- [Medium] A positive error code (EAGAIN) is incorrectly returned directly =
to userspace instead of the negative standard (-EAGAIN).
- [Medium] Spurious initialization failures occur for new perfcnt sessions =
due to a stale hw_reset_happened flag.
--

commit 555dc068f79668462a998f3ee4fa95ead697090d
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Make reset sequence deal with an active HWPerf session

This commit introduces a perfcnt HW reset path to handle active HWPerf
sessions during a HW reset. It renders perfcnt unusable after reset and
notifies the user to take recovery measures.

Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through uns=
table ioctls")

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ad1156678e91c..c2087ea705fe6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c

[ ... ]

> @@ -173,6 +187,16 @@ static int panfrost_perfcnt_enable_locked(struct pan=
frost_device *pfdev,
>  	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
>  		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> =20
> +	/* If a reset happened, we've no way of knowing whether it was between =
the time we called
> +	 * panfrost_mmu_as_get() or before perfcnt_enable(), so clearing this f=
lag and going forward
> +	 * isn't possible. We must clear the flag and try again in the hopes no=
 resets will happen
> +	 * between this and the next ioctl invocation.
> +	 */
> +	if (atomic_cmpxchg(&perfcnt->hw_reset_happened, 1, 0)) {
> +		ret =3D EAGAIN;

[Severity: Medium]
Does this return a positive error code directly to userspace instead of the
standard negative one (-EAGAIN)?

DRM ioctls pass positive return values directly back to user space as the
ioctl syscall result. Because of this, user space will incorrectly interpret
this as success and subsequently fail on dump ioctls since the session wasn=
't
actually enabled.

> +		goto err_disable;

[Severity: High]
Can this leak the Address Space reference if a hardware reset aborts the
enable sequence?

If a GPU reset occurs before panfrost_mmu_as_get() is called, the reset
handler clears mmu->as_count to 0, and then panfrost_mmu_as_get() increments
it to 1. The code subsequently detects the reset via the hw_reset_happened
flag, clears it, and jumps to err_disable here. Because err_disable skips
panfrost_mmu_as_put(), the AS slot reference is permanently leaked,
eventually exhausting the limited hardware AS slots.

> +	}
> +
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);

[ ... ]

> @@ -209,7 +235,8 @@ static int panfrost_perfcnt_disable_locked(struct pan=
frost_device *pfdev,
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>  	perfcnt->buf =3D NULL;
>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> +	if (!atomic_read(&perfcnt->hw_reset_happened))
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);

[Severity: High]
Could a race between this check and an asynchronous reset reintroduce the
mmu->as_count underflow WARN that this patch was explicitly intended to
prevent?

The non-atomic gap between reading the flag and executing
panfrost_mmu_as_put() creates an exposure window. If an interleaved
asynchronous hardware reset occurs in this window, panfrost_device_reset()
will clear mmu->as_count to 0. The subsequent execution of
panfrost_mmu_as_put() decrements it to -1, directly triggering the WARN.

>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping =3D NULL;
>  	pm_runtime_put_autosuspend(pfdev->base.dev);

[ ... ]

> @@ -346,3 +373,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *p=
fdev)
>  	/* Disable everything before leaving. */
>  	panfrost_perfcnt_gpu_disable(pfdev);
>  }
> +
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +
> +	/* Since this function will be called either from a scheduled HW reset
> +	 * or a runtime resume, tearing down any perfcnt resources means we're
> +	 * doomed to deadlocking with perfcnt_{enable/disable}, since we'd have
> +	 * to take the perfecnt lock. On top of that, it'd also violate DMA fen=
ce
> +	 * signalling rules because GFP_KERNEL allocations are made with the pe=
rfcnt
> +	 * lock taken in perfcnt_enable. In light of this, the only thing we ca=
n do
> +	 * is disabling perfcnt unconditionally, and notifying the perfcnt user=
 of
> +	 * the reset having happpened so that they can take recovery measures.
> +	 */
> +	panfrost_perfcnt_gpu_disable(pfdev);
> +	atomic_set(&perfcnt->hw_reset_happened, 1);

[Severity: Medium]
Will this unconditionally set the reset flag even if no perfcnt session is
active, causing the next new session to spuriously fail?

Since this function is called during any GPU reset, it sets the flag even
when perfcnt->user =3D=3D NULL. If user space later attempts to start a
completely new session, panfrost_perfcnt_enable_locked() will consume this
stale flag and abort with EAGAIN, functionally breaking the feature on the
first attempt after a reset.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-claude-fix=
es-v2-0-57c6bd4c1655@collabora.com?part=3D5
