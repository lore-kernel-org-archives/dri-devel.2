Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41CFCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6FC112051;
	Fri,  9 Oct 2026 10:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WOwZqqOI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06444112047
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:28:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD8DA43C19;
 Fri,  9 Oct 2026 10:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24381F000FF;
 Fri,  9 Oct 2026 10:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791541721;
 bh=KcjJWHOjRXlrXa7Ak1v6F2vkwDq91/14RSer9eXuClc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WOwZqqOIR6Jqn+7qN3CCF8vsXUygBbwHmhgpZj/4Lb8xwJO/gHQNYCy8J8qWu9lsf
 EQ6GKA6SF8dStKhCdZwElawmjegDbdb+FpbH7KeKK+WxJtt1z04OoO3IFsapoKt26D
 rNyqsL6L/jgYFpJpv2R08k5qcolSXpiF9hvVb4V3OtzMbqSz5XzJ5rV4y05YZMsCxq
 dY03GsXJ3TmbcBu20o0iPnBSLdyOBUp4vZxrRIklRhFoFMI7Nehxbu0f9Ze1eB3Kiq
 mPS67pl1NfbFYsEx2GOIas1u/QdHRQ5FgUe9ouhhNbcgPChpUOE+04BKVI8YvT3ZQF
 rR5fveuB8l/+w==
Message-ID: <sashiko-outbox-165236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] amdkfd: fix doorbell allocation race creating duplicate
 allocations
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
References: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:28:41 +0000
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
- [High] amdkfd: broken double-checked locking exposes unpinned doorbell BO
--

commit b7981a37c1ce3dead747819635554510915a169b
Author: Henry Martin <bsdhenrymartin@gmail.com>

amdkfd: fix doorbell allocation race creating duplicate allocations

This commit adds a double-checked locking mechanism to
kfd_alloc_process_doorbells to prevent racing threads from creating
duplicate doorbell allocations. It checks the proc_doorbells pointer
under the doorbell_mutex to synchronize allocation across lockless
call sites.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index fdcf7f2d1b5b4..07f881573837e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd=
, struct kfd_process_device *
>  	int r;
>  	struct qcm_process_device *qpd =3D &pdd->qpd;
> =20
> +	mutex_lock(&kfd->doorbell_mutex);
> +
> +	/* Another thread may have won the check-and-allocate race */
> +	if (qpd->proc_doorbells) {
> +		mutex_unlock(&kfd->doorbell_mutex);
> +		return 0;
> +	}
> +
>  	/* Allocate bitmap for dynamic doorbell allocation */
>  	qpd->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCES=
S,
>  					     GFP_KERNEL);

[ ... ]

> @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd=
, struct kfd_process_device *
>  		DRM_ERROR("Failed to allocate process doorbells\n");
>  		goto err;
>  	}
> +
> +	mutex_unlock(&kfd->doorbell_mutex);
>  	return 0;

[Severity: High]
Does this code expose an unpinned buffer object to lockless readers?

Since amdgpu_bo_create_kernel() writes the newly allocated buffer object
directly to the provided pointer (&qpd->proc_doorbells) before completing
the reserve and pin phases, this pointer becomes globally visible to any
thread performing the lockless check in kfd_get_process_doorbells():

    if (!pdd->qpd.proc_doorbells) {
        if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
            /* phys_addr_t 0 is error */
            return 0;
    }

Could a concurrent thread bypass the mutex, observe the partially
initialized buffer object, and use it to access invalid GPU memory offsets
before pinning is complete?  Could this also trigger a use-after-free if
the allocation subsequently fails to pin and is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009101842.3294=
707-1-bsdhenrymartin@gmail.com?part=3D1
