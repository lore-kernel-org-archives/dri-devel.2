Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D5BCA6004
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 03:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2C710EB89;
	Sat, 10 Oct 2026 03:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cM2lTld8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CF510EB87
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 03:15:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4279560211;
 Sat, 10 Oct 2026 03:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AEC1F000FF;
 Sat, 10 Oct 2026 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791602152;
 bh=y5yXdaL4o+yXf7eZXbHZN4arSv2L0mmo5dexrWCQwtM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cM2lTld80CJtF9gQnGFmOA4UPJ8LHS7XAeOq6ktV3lVvTA1sN/SWLYWWaCQUDdDFi
 BcJDxws8UMwRX8pJVQKygMhozXerkHwTkPH++ALJ8ELSLgVvsZYP03mTN9u8XF6D5x
 mErJ++j62Kebei0Jg6KxZ6EIw99uABrFpGXcmdSqV/n1o+RcuGJZ11RuZzLy2wVN46
 R9zeIMEuYtvoAVkBBcGiR09Dj30P6gOAdFx72RhzvOV4LgHSwgfxxfaYXBigWh/GyT
 xZRvM+1sfggfeGyhy6EDISdR9Szv22j0370SHi99VdmuvH3ZOi4O+4wfK6/XUj9xK4
 q4YBq47geDYBg==
Message-ID: <sashiko-outbox-166239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
 <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 03:15:51 +0000
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
- [Critical] amdkfd: Double-Checked Locking vulnerability exposes unpinned =
doorbell BO to mmap
- [High] drm/amdkfd: TOCTOU race in doorbell allocation exposing unpinned BO
--

commit 8544c203ebbbee60344c5d18d017125a93e18d7c
Author: Henry Martin <bsdhenrymartin@gmail.com>

amdkfd: fix doorbell allocation race creating duplicate allocations

The commit adds a per-process-device mutex doorbell_mutex inside
kfd_alloc_process_doorbells() to fix a check-and-allocate race condition
where concurrent callers could create duplicate doorbell allocations.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index fdcf7f2d1b5b4..55acadc986bee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd=
, struct kfd_process_device *
>  	int r;
>  	struct qcm_process_device *qpd =3D &pdd->qpd;
> =20
> +	mutex_lock(&pdd->doorbell_mutex);
> +
> +	/* Another thread may have won the check-and-allocate race */
> +	if (qpd->proc_doorbells) {
> +		mutex_unlock(&pdd->doorbell_mutex);
> +		return 0;
> +	}
> +
>  	/* Allocate bitmap for dynamic doorbell allocation */
>  	qpd->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCES=
S,

[ ... ]

>  	/* Allocate doorbells for this process */
>  	r =3D amdgpu_bo_create_kernel(kfd->adev,
>  				    kfd_doorbell_process_slice(kfd),
>  				    PAGE_SIZE,
>  				    AMDGPU_GEM_DOMAIN_DOORBELL,
>  				    &qpd->proc_doorbells,
>  				    NULL,
>  				    NULL);
>  	if (r) {
>  		DRM_ERROR("Failed to allocate process doorbells\n");
>  		goto err;
>  	}
> +
> +	mutex_unlock(&pdd->doorbell_mutex);

[Severity: Critical]
Does moving the mutex inside this function create a double-checked locking
vulnerability since the outer check is lockless?

When kfd_get_process_doorbells() is called via mmap, it does a lockless che=
ck:

	if (!pdd->qpd.proc_doorbells) {
		if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
			/* phys_addr_t 0 is error */
			return 0;
	}

Concurrently, if another thread is inside kfd_alloc_process_doorbells() and
calls amdgpu_bo_create_kernel() while holding the doorbell_mutex, it assigns
the new BO pointer to &qpd->proc_doorbells before the BO is fully pinned.

Can the thread calling mmap() observe the non-NULL proc_doorbells pointer,
bypass the mutex entirely, and use the unpinned BO?  If it calls
amdgpu_bo_gpu_offset() on the unpinned BO, could it calculate a bogus physi=
cal
address and map unintended memory to userspace?

>  	return 0;
> =20
>  err:
>  	bitmap_free(qpd->doorbell_bitmap);
>  	qpd->doorbell_bitmap =3D NULL;
> +unlock:
> +	mutex_unlock(&pdd->doorbell_mutex);
>  	return r;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010030230.1764=
682-1-bsdhenrymartin@gmail.com?part=3D1
