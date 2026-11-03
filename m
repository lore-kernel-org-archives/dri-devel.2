Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AA606A334
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFJu44HU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D62A10F7DB;
	Tue,  3 Nov 2026 20:46:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BAB10F7DB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:46:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62238601EF;
 Tue,  3 Nov 2026 20:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DCA1F000C1;
 Tue,  3 Nov 2026 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793738787;
 bh=rXrqPLHTk9HaqyJJNeFFS8j7SSeM+kRUwUOFRyV0OGk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mFJu44HUmI3ogNB02MKjXJUez/tjkKZYu9bwHE9yU+RdE3i9ahB+4T7g45XRiE85s
 HDbg2mlvcA/qjLYTWF6EiM4cCqDo1AhaLbdK5aLY7J8ny9Jikma4MB/D1XIbt8ew6H
 W2j46wvyIz4QB8/iDHW8S3L7BNTeXWABXSW+dgvcEMtmbShIsmvb9U8urWoU0OC+VO
 mKe7eAsJVszvzqy01FcWivRC8h8oUPilIwrKvnNDaNeB+7R0dEOIggRG1PZrVA/vV/
 Zs8OxM/0Oy7kG702eLoZzbKJYpDf+/lEvho8VLlVeiGhToBkQNa5TOYeKIKemRZOT0
 T5osncv7r4fgQ==
Message-ID: <sashiko-outbox-196011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/panfrost: Enable cycle counting when perfcnt
 is enabled
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-panfrost-reset-races-fixes-v2-1-454207b1d4e3@collabora.com>
References: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
 <20261103-panfrost-reset-races-fixes-v2-1-454207b1d4e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:46:26 +0000
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

commit bc0ac72ceaf78a79c6a160afa6594381db03f37c
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panfrost: Enable cycle counting when perfcnt is enabled

This commit enables the GPU cycle counter while performance counters are
enabled so block headers receive valid timestamps, and drops the warning on
a non-zero cycle counter reference count during GPU soft reset.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gpu.c
> index 6081b27829e1f..7d66b1b509689 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -94,10 +94,10 @@ int panfrost_gpu_soft_reset(struct panfrost_device *p=
fdev)
>  		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
> =20
>  	/*
> -	 * All in-flight jobs should have released their cycle
> -	 * counter references upon reset, but let us make sure
> +	 * Even though all in-flight jobs should have released their cycle coun=
ter
> +	 * references upon reset, perfcnt's might still hang about.
>  	 */
> -	if (drm_WARN_ON(&pfdev->base, atomic_read(&pfdev->cycle_counter.use_cou=
nt) !=3D 0))
> +	if (atomic_read(&pfdev->cycle_counter.use_count) !=3D 0)
>  		atomic_set(&pfdev->cycle_counter.use_count, 0);
> =20
>  	return 0;
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
Can this leak a reference on pfdev->cycle_counter.use_count if the GPU reset
times out in panfrost_gpu_soft_reset()?

In drivers/gpu/drm/panfrost/panfrost_gpu.c, panfrost_gpu_soft_reset() retur=
ns
early if both soft and hard resets time out, before resetting
pfdev->cycle_counter.use_count to 0:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_soft_reset() {
	...
		if (ret) {
			dev_err(pfdev->base.dev, "gpu hard reset timed out\n");
			return ret;
		}
	}
	...
	if (atomic_read(&pfdev->cycle_counter.use_count) !=3D 0)
		atomic_set(&pfdev->cycle_counter.use_count, 0);
}

However, in drivers/gpu/drm/panfrost/panfrost_device.c,
panfrost_device_reset() ignores the return value of panfrost_gpu_soft_reset=
()
and still proceeds to call panfrost_mmu_reset() and panfrost_perfcnt_reset(=
):

drivers/gpu/drm/panfrost/panfrost_device.c:panfrost_device_reset() {
	guard(rwsem_write)(&pfdev->reset.lock);

	panfrost_gpu_soft_reset(pfdev);

	panfrost_gpu_power_on(pfdev);
	panfrost_mmu_reset(pfdev);
	...
	panfrost_perfcnt_reset(pfdev);
}

When an active perfcnt session is present, panfrost_perfcnt_reset() clears
perfcnt->owns_as_ref without dropping the existing cycle_counter reference
and calls panfrost_perfcnt_hw_enable():

drivers/gpu/drm/panfrost/panfrost_perfcnt.c:panfrost_perfcnt_reset() {
	...
	/* All active AS are released during the MMU post_reset. */
	perfcnt->owns_as_ref =3D false;
	perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
	if (panfrost_perfcnt_hw_enable(pfdev))
		perfcnt->state |=3D PANFROST_PERFCNT_SESSION_DEAD;
	...
}

Because panfrost_mmu_reset() cleared pfdev->as_alloc_mask,
panfrost_mmu_as_get() succeeds in panfrost_perfcnt_hw_enable() and
panfrost_cycle_counter_get() increments pfdev->cycle_counter.use_count a
second time without the prior reference having been cleared or released. Wh=
en
panfrost_perfcnt_hw_disable() is later called, panfrost_cycle_counter_put()
only decrements pfdev->cycle_counter.use_count once, leaving it non-zero and
preventing GPU_CMD_CYCLE_COUNT_STOP from being issued.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-panfrost-r=
eset-races-fixes-v2-0-454207b1d4e3@collabora.com?part=3D1
