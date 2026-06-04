Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02059CD6E55
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5840B1125BE;
	Thu,  4 Jun 2026 02:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JHbprFwa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204641125BE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:54:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C558601DD;
 Thu,  4 Jun 2026 02:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F7A1F00893;
 Thu,  4 Jun 2026 02:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541670;
 bh=CjxjUH6qE2M52wKEM/40WZUiRkCtznd4PxmUx2Ro6sw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JHbprFwaLodQV34BI/1im3MlSLroU7TU557CYyWlDtiQ8qfBl8+O43cl+7mR3Azmk
 sDbwAdhU5n3bmsjuukowJ3q+u1YWfCKBnfLe8zG1lyriBZXS+Gn9bnaB/0Tp4kmr23
 PHJdj+BbPHcyJjZjhLjaXkVfjvV4lzjFIsBMZVR/swEzUItRGKBr7az5pM3u/eqazQ
 YZoJNNkdloaTYtOiT2lQPAN/dtPySSDIs6ou2rHg5RTCr6XHxIzDsUQHAE25x5WYyO
 bv39Fu+vpovq3/wfWi69EcsW4iWzz5uE+IpLiGW1F80SbZQZUN+frL8JBOYfFkViM/
 l/Sx1N3C+oDMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/14] drm/v3d: Introduce struct v3d_submit and
 convert CL/TFU/CSD ioctls
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-8-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-8-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:54:29 +0000
Message-Id: <20260604025429.E0F7A1F00893@smtp.kernel.org>
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
- [High] Earlier jobs in the submission chain (BIN and RENDER) do not wait =
for implicit BO dependencies, leading to concurrent hardware access.
--

commit c2a10c5b0fe7c3f03c50306d4d031d5c5d2ba3a6
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls

As the V3D driver grew with time, different types of submission were added
and the submission code grew more complex, but the driver stuck with the
same abstractions.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index d80afbf2c03be..fcaf3a6cfddc6 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
[ ... ]
> @@ -984,99 +1088,71 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *=
data,
[ ... ]
> -	ret =3D v3d_lookup_bos(dev, file_priv, last_job,
> -			     args->bo_handles, args->bo_handle_count);
> -	if (ret)
> +	ret =3D v3d_lookup_bos(dev, file_priv,
> +			     submit.jobs[submit.job_count - 1],
> +			     args->bo_handles, args->bo_handle_count);
> +	if (ret)
>  		goto fail;
> =20
> -	ret =3D v3d_lock_bo_reservations(last_job, &exec);
> -	if (ret)
> -		goto fail;
> +	ret =3D v3d_lock_bo_reservations(submit.jobs[submit.job_count - 1],
> +				       &submit.exec);
> +	if (ret)
> +		goto fail;

[Severity: High]
This is a pre-existing issue, but since earlier jobs in the submission chain
(like BIN and RENDER) don't have these BOs associated with them, they
receive no implicit fences.

Because v3d_lookup_bos() only associates the BOs with the last job
(submit.jobs[submit.job_count - 1]), the earlier jobs have their bo_count
set to 0. Consequently, they skip adding implicit dependencies when
reservations are processed. Even if a subsequent patch updates the code
to iterate over all jobs to add dependencies, earlier jobs will still be
skipped because their job->bo_count is 0.

Could this cause the earlier jobs to be pushed to the hardware immediately,
allowing them to read BOs while they are still being written by previous
operations from other processes or hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D8
