Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43049CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9846A10E1BA;
	Fri,  5 Jun 2026 18:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P3vNxrj+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8FE10E1BA
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:20:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D01F541AE0;
 Fri,  5 Jun 2026 18:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB81F00893;
 Fri,  5 Jun 2026 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780683612;
 bh=4Gy7Mwn7h/1ysuo620/lZvaFEpzBO8a3R/Y/dld9O4A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P3vNxrj+yNNxAiOCkUYSabKyWWfp+CIcTq3FG3c4dBzHvultKBDkaeilf1W8scH01
 O3LV65HVy9a2g68H3O708PTVl+DH0sxKyHgWdEUvH5k3NB1sGIzUlc1+FKEkw3+BG6
 oWVM9aBju6z0jy4nxMVs8x33S26U0OSd4hsdjdgvCPxYPeQytO+Izoew9EbQ0OKURL
 qNGPqN4jn9kHnx5Ds5ubw55PV5f/+p2Z9BtNqMEX2V6TBITQAE5kAjqZHAv3COFl2p
 1kmJCcNxJhOEFWEQOCyic/dYqz/QokpSqsPCk4oBQZj+d984U/ShWzTpCwTcoDEZZV
 nK9zlEXyMWFyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/rocket: Drop the dedicated reset workqueue
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-rocket-per-task-jobs-v1-3-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-3-e3319adf3c49@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:20:12 +0000
Message-Id: <20260605182012.95CB81F00893@smtp.kernel.org>
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
- [High] Memory leak of the dynamically allocated `scheds` array in `rocket=
_job_open()` on error paths and when `num_cores =3D=3D 1`.
--

commit 49abb67c60d7da03b194fc958eb96f281bc20ffc
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/rocket: Drop the dedicated reset workqueue

Each core allocated an ordered workqueue to serialize timeout handlers, whi=
ch
is unnecessary since each core is reset independently. With the reset worker
gone, the workqueue served solely as the timeout_wq. This patch drops the
dedicated workqueue and lets drm_sched fall back to the default timeout
workqueue.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 871041eb7a1dc..1a454559ecf49 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c

[ ... ]

>  void rocket_job_fini(struct rocket_core *core)
>  {
>  	drm_sched_fini(&core->sched);
> -
> -	destroy_workqueue(core->reset.wq);
>  }
> =20
>  int rocket_job_open(struct rocket_file_priv *rocket_priv)

[Severity: High]
This isn't a bug introduced by this patch, but is there a memory leak of the
dynamically allocated scheds array on error paths and when rdev->num_cores
equals 1?

Looking at drivers/accel/rocket/rocket_job.c:rocket_job_open():

	struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
							 rdev->num_cores);
	...
	ret =3D drm_sched_entity_init(&rocket_priv->sched_entity,
				    DRM_SCHED_PRIORITY_NORMAL,
				    scheds,
				    rdev->num_cores, NULL);
	if (WARN_ON(ret))
		return ret;

If drm_sched_entity_init() fails, the function returns directly and the
scheds array is leaked.

Additionally, if drm_sched_entity_init() succeeds but rdev->num_cores =3D=
=3D 1,
drm_sched_entity_init() explicitly drops the reference by setting
entity->sched_list to NULL:

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_init() {
	...
	entity->sched_list =3D num_sched_list > 1 ? sched_list : NULL;
	...
}

Because rocket_job_close() relies on entity->sched_list to free the memory:

drivers/accel/rocket/rocket_job.c:rocket_job_close() {
	...
	kfree(entity->sched_list);
	...
}

Calling kfree() with NULL resolves cleanly but permanently loses the origin=
al
scheds array allocation. Can this be used to trigger kernel memory exhausti=
on
by repeatedly calling open() and close() on the DRM device file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rocket-per=
-task-jobs-v1-0-e3319adf3c49@igalia.com?part=3D3
