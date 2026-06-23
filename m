Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C3ECDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E39F10ECAC;
	Tue, 23 Jun 2026 20:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cd0q4MMo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A684710ECAE
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:46:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6954F44224;
 Tue, 23 Jun 2026 20:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B41F000E9;
 Tue, 23 Jun 2026 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247603;
 bh=+XUVk/E5VL+UwBrCyVi9h75yQNar86xYv38pIDRU7tE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cd0q4MMoisM2waPtLeUPEpa26gDIQ82KDzPjlqehNdgsuVUTIyxQIUFDn1GpT6pWo
 /hibzcBPiW4eDIUl8fURCI6dzuyBdTTkJOf4pDW0RJCc5+0A+LxIgcaF0I3s49N8x4
 JXKxRVeSEbVblwhJ1l+0XY/RtZaGBzY56BLLztNVQXdjVIT8PuBSxkDSPLj+bpeTpo
 P4dZXGKQyEP9fimZPoxPgHxGo0d0+w5ZxDQYk2Bk+OqOKiuPcYBJD6kXVouQ+uNZTr
 xDcP0wuqMMxtg3/te4xEKhMHSHuwKXccY5EB50nR1pvt9WJUK5jwrnN8DRNruwYmSv
 b1c9NsUOcYU5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/v3d: Use write_to_buffer() helper in
 performance query copy
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-v3d-cpu-job-fixes-v2-3-fec132484fc4@igalia.com>
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
 <20260618-v3d-cpu-job-fixes-v2-3-fec132484fc4@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:46:42 +0000
Message-Id: <20260623204643.256B41F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing bounds validation on user-controlled offsets and strid=
es leads to arbitrary out-of-bounds kernel memory accesses.
- [Medium] Lockless read of 64-bit performance monitor counters can lead to=
 torn reads and data races.
--

commit 142086c1a0afebcf8603865523c8298d5a01c455
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Use write_to_buffer() helper in performance query copy

The copy of performance query results to the output buffer open-codes
the 32-bit/64-bit selection with two nearly identical loops. As the
write_to_buffer() helper already encapsulates the do_64bit decision,
use it instead of open-coding it.

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index 53deae1a2eda9..17751c8d7f163 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -594,15 +594,8 @@ v3d_write_performance_query_result(struct v3d_cpu_jo=
b *job, void *data,
> =20
>  		v3d_perfmon_stop(v3d, perfmon, true);
> =20
> -		if (job->copy.do_64bit) {
> -			for (j =3D 0; j < perfmon->ncounters; j++)
> -				write_to_buffer_64(data, offset + j,
> -						   perfmon->values[j]);
> -		} else {
> -			for (j =3D 0; j < perfmon->ncounters; j++)
> -				write_to_buffer_32(data, offset + j,
> -						   perfmon->values[j]);
> -		}
> +		for (j =3D 0; j < perfmon->ncounters; j++)
> +			write_to_buffer(data, offset + j, job->copy.do_64bit, perfmon->values=
[j]);

[Severity: Medium]
This is a pre-existing issue, but can this lockless read of perfmon->values=
[j]
cause a torn read or data race on 32-bit architectures?

If a user submits a GPU job and a CPU copy job using the same perfmon ID
concurrently, the GPU job's completion might invoke v3d_perfmon_stop(),
which updates the values array under perfmon->lock, while the CPU job
concurrently reads it locklessly here.

> =20
>  		v3d_perfmon_put(perfmon);
>  	}

[Severity: Critical]
This is a pre-existing issue, but does this code write outside the bounds
of bo->vaddr?

In v3d_submit.c:v3d_get_cpu_copy_performance_query_params(), the
user-provided offset and stride are accepted and stored without
validating them against the mapped BO size:

	job->copy.offset =3D copy.offset;
	job->copy.stride =3D copy.stride;

Later, in v3d_sched.c:v3d_copy_performance_query(), the unvalidated
offset is added to the vmap kernel virtual address:

	data =3D ((u8 *)bo->vaddr) + copy->offset;

And the destination pointer is incremented by an unvalidated stride for
subsequent writes:

	data +=3D copy->stride;

Can this lead to out-of-bounds kernel memory accesses if an incorrect
offset or stride is supplied via the V3D_SUBMIT_CPU ioctl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-v3d-cpu-jo=
b-fixes-v2-0-fec132484fc4@igalia.com?part=3D3
