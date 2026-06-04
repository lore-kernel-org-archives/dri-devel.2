Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14D6CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BE51125B4;
	Thu,  4 Jun 2026 02:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KFWdpbkQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433AF1125B4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:50:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2469242DDC;
 Thu,  4 Jun 2026 02:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640C61F00893;
 Thu,  4 Jun 2026 02:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541455;
 bh=pjOu/2itNe48y+053sV/h1ePAyFLXJm5gIii7KfzOsU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KFWdpbkQCapOPbzgM+xpeMf28N8OwEsDGpt3pkl5ijz7LuB5PZYx/bLl56LL8G62L
 5+wOeOEKv5hyy5dRKdQLIDT0EVos/z3p64Yw99b/5nkX5FuqL8HkALGUF2/yZ3r2Uy
 aYS2HHcHHMn6bYelmTLm13chdfJpdqdVmaE1A2Cit6GMOWRiia2jD8myDGRevIeqRl
 yVsyhZWwMX/rQa7vl3DLxhh8R2Dr0WBuQKQcfWm4JkIp9UcOBIu8kifo7VhZ0pdB6W
 2+AqwcX5Ad0m7aMiNsJz6/F81qw3N6K2V012eqRe74zTrK/gYqsjuNvXCdJbnCnu4Y
 UQiv92oN3quZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] drm/v3d: Clear queue->active_job when
 v3d_fence_create() fails
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-2-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-2-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:50:54 +0000
Message-Id: <20260604025054.640C61F00893@smtp.kernel.org>
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
- [High] The `run_job` callbacks return `NULL` instead of propagating the e=
rror pointer when `v3d_fence_create()` fails, masking submission failures a=
nd causing the DRM scheduler to treat the job as successfully completed.
--

commit f3ab1695e1c90559d6118895b31f3b02289aee81
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Clear queue->active_job when v3d_fence_create() fails

This commit clears queue->active_job in the run_job callbacks for BIN, REND=
ER,
TFU, and CSD when v3d_fence_create() fails. It creates a failure path to
prevent dangling pointers when returning from a failed job submission.

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index 0e266b29317f3..46f4fc09c59ec 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
[ ... ]
> @@ -214,7 +210,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_s=
ched_job *sched_job)
> =20
>  	fence =3D v3d_fence_create(v3d, V3D_BIN);
>  	if (IS_ERR(fence))
> -		return NULL;
> +		goto out_clean_job;
[ ... ]
> @@ -242,6 +238,12 @@ static struct dma_fence *v3d_bin_job_run(struct drm_=
sched_job *sched_job)
>  	V3D_CORE_WRITE(0, V3D_CLE_CT0QEA, job->end);
> =20
>  	return fence;
> +
> +out_clean_job:
> +	spin_lock_irqsave(&queue->queue_lock, irqflags);
> +	queue->active_job =3D NULL;
> +	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	return NULL;

[Severity: High]
This is a pre-existing issue, but does returning NULL here mask the
submission failure from the DRM scheduler?

When v3d_fence_create() fails, it returns an error pointer. If the
v3d_bin_job_run() callback (and the other run_job callbacks modified
in this patch) returns NULL instead of propagating this error pointer,
the DRM scheduler treats the job as having completed synchronously and
successfully.

Could this allow dependent jobs to execute as if the hardware successfully
processed the command lists, potentially leading to GPU page faults or
userspace crashes? Should the callbacks propagate the error pointer back
to the scheduler instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D2
