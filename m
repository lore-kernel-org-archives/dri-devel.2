Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E1C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB46210EDB3;
	Thu, 30 Jul 2026 04:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S4qYXgfz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C997010EDB3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:57:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44712408BC;
 Thu, 30 Jul 2026 04:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF32A1F000E9;
 Thu, 30 Jul 2026 04:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785387441;
 bh=IrhcOKQz42NqaJbvEkpGPyIs0aV7LviguFVmPIrRaKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S4qYXgfzCWh7KIv3C5d2fYBMmuVRqogW1vm/sp4TXQsH/Xb91VLt8/3wfFQcENmHt
 kXz0r/z1DRykQlju4KTZt1l2umZKZd+S2NDtuko8NCWN4pV8zO2m3pfazWoBoXjAs5
 e/wI8Y0JXVfNZxduBErY+03ud34tgJc9vXhehSda8EbRe/3WyOpbEIJXncgtRSK+8Q
 nigDivPQ4Ex+FImluk/9slHxTqZ/SVUg31ZSRHmoTRNmfekhow9+0W9z5hYyqGQUgb
 iiwN1GYET/QR3xn1SRET6rsylklfXafzT96niKdQG+T8+q3oH0wu1XwwT2BigssNAF
 /k2oPV5e53rhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/tegra: Drop reference on postfence
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260730-b4-host1x-syncobj-wait-v1-3-afa730410392@nvidia.com>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
 <20260730-b4-host1x-syncobj-wait-v1-3-afa730410392@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:57:20 +0000
Message-Id: <20260730045720.DF32A1F000E9@smtp.kernel.org>
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
- [High] The job submission ioctl can return an error to user-space after t=
he job has already been successfully committed to hardware, violating the '=
point of no return' principle.
--

--- Patch [3]: [PATCH 3/6] drm/tegra: Drop reference on postfence ---
commit 3dc23eb6eb77ce1c25e7c0e305986ed6dd337897
Author: Mikko Perttunen <mperttunen@nvidia.com>

drm/tegra: Drop reference on postfence

This commit drops the extra fence reference by calling dma_fence_put()
after drm_syncobj_replace_fence() is used in the job submission path.

> diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submi=
t.c
> index 3f20b5a244476..658396f2e9549 100644
> --- a/drivers/gpu/drm/tegra/submit.c
> +++ b/drivers/gpu/drm/tegra/submit.c
[ ... ]
> @@ -645,21 +645,22 @@ int tegra_drm_ioctl_channel_submit(struct drm_devic=
e *drm, void *data,
> =20
>  	/* Submit job to hardware. */
>  	err =3D host1x_job_submit(job);
>  	if (err) {
>  		SUBMIT_ERR(context, "host1x job submission failed: %d", err);
>  		goto unpin_job;
>  	}
> =20
>  	/* Return postfences to userspace and add fences to DMA reservations. */
>  	args->syncpt.value =3D job->syncpt_end;
> =20
>  	if (syncobj) {
>  		struct dma_fence *fence =3D host1x_fence_create(job->syncpt, job->sync=
pt_end, true);
>  		if (IS_ERR(fence)) {
>  			err =3D PTR_ERR(fence);
>  			SUBMIT_ERR(context, "failed to create postfence: %d", err);
>  			goto put_job;
>  		}

[Severity: High]
This is a pre-existing issue, but returning an error to user-space here
after host1x_job_submit() has already succeeded seems problematic.

If host1x_fence_create() fails, the error path (goto put_job) drops the loc=
al
job reference and returns the error to userspace. Because userspace receives
an error from the ioctl, it might incorrectly assume the job was not
submitted and could free or reuse the command and data buffers.=20

Since the GPU is already asynchronously executing the job, could this lead =
to
the hardware accessing freed memory and causing IOMMU faults or memory
corruption?

> =20
>  		drm_syncobj_replace_fence(syncobj, fence);
> +		dma_fence_put(fence);
>  	}
> =20
>  	goto put_job;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-b4-host1x-=
syncobj-wait-v1-0-afa730410392@nvidia.com?part=3D3
