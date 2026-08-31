Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2600AC61DE8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5A610E181;
	Mon, 31 Aug 2026 05:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MP93Si8h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07BD10E181;
 Mon, 31 Aug 2026 05:56:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB655601DB;
 Mon, 31 Aug 2026 05:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7EA1F000E9;
 Mon, 31 Aug 2026 05:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788155802;
 bh=iCSV/Fxjd3kaA0oU+QWHDLGKK8o1+cuY+9yCEpzZCMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MP93Si8ho0f2e6iL9q5B3NtcHYSLjovHd76rG5OV+r0ekAYT1Dk+B5poswBseuKa/
 nEOoUJjldr3857OOxw3Pv71FkGJ8zzQV/sRQeR2UtyLdcmfSaseIaWevm6kYtQHTxJ
 RI1vEqZEm7kt9MisDsBKRoRaKWuMYV1ZOEh8ibuP64l8CK+DG9zzRSHVP4KPpP450l
 8L0yqAqDJDIFrXfj7sSVbAKe7lnXl6J7635RwssvYSqI0q7Skaa+Z0u74kdYok0Rf8
 l0s4PytIuTJUV9Bl+a0f3KyiE1200ahqKoIwUDMOoj3eEoT8KKuh7CkuDt2EXQM3Db
 05bNcUMa9N41g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260831054154.107602-4-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831054154.107602-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 05:56:41 +0000
Message-Id: <20260831055642.4B7EA1F000E9@smtp.kernel.org>
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
- [High] Possible Use-After-Free of xe_device when a foreign dma-fence sign=
als after device teardown.
--

commit 3bd2b743d1b606804ebc5081e49badce29c41a21
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm/xe: Convert xe_user_fence to drm_user_fence

Replace the open-coded user fence implementation in xe_sync.c with the
new common drm_user_fence helper.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..2d1e07792506e 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -19,36 +18,60 @@

[ ... ]

> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
> +{
> +	struct xe_user_fence *ufence =3D container_of(base, struct xe_user_fenc=
e, base);

[ ... ]

> +	if (mm_ok) {
> +		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
> +			drm_dbg(&ufence->xe->drm,
> +				"copy_to_user failed, user fence wasn't signaled\n");
> +	} else {
> +		drm_dbg(&ufence->xe->drm,
> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
> +	}
> +
> +	wake_up_all(&ufence->xe->ufence_wq);
> +}

[ ... ]

>  static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64=
 addr,
>  					       u64 value)
>  {
> @@ -63,51 +86,22 @@ static struct xe_user_fence *user_fence_create(struct=
 xe_device *xe, u64 addr,
>  	if (!ufence)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	ufence->xe =3D xe;
> -	kref_init(&ufence->refcount);
> -	ufence->addr =3D ptr;
> +	ufence->xe    =3D xe;
> +	ufence->addr  =3D ptr;
>  	ufence->value =3D value;
> -	ufence->mm =3D current->mm;
> -	mmgrab(ufence->mm);
> +	drm_user_fence_init(&ufence->base, xe->ordered_wq, &xe_ufence_ops);

[Severity: High]
This is a pre-existing issue, but does this code leave the xe_device vulner=
able
to a use-after-free when an external dma-fence signals after device teardow=
n?

When a user creates a user fence that depends on an external dma-fence (e.g=
.,
from amdgpu) by passing a syncobj, xe_sync_entry_parse() creates the user f=
ence
without taking a reference to the xe_device.

If the user then closes the xe file descriptor or the device is hot-unplugg=
ed,
the last reference to xe_device can be dropped. xe_sync_entry_cleanup()
drops the sync entry's reference to the user fence but does not cancel
the pending callback.

When the external dma-fence eventually signals, the callback invokes
queue_work(). Because the workqueue points to xe->ordered_wq which was alre=
ady
destroyed during device teardown, this causes a UAF crash. If the worker
does run, it will also access the freed xe_device pointer in xe_ufence_work=
er()
to wake up waiters.

Could user_fence_create() take a reference to the xe_device, or could
xe_sync_entry_cleanup() be updated to explicitly cancel the pending callbac=
k?

> =20
>  	return ufence;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827062142.4038=
272-1-srinivasan.shanmugam@amd.com?part=3D3
