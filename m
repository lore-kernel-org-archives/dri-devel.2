Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED87CD98C6
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7139410E776;
	Wed, 10 Jun 2026 07:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CKoEHIBk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0006010E776
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:24:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 987464052D;
 Wed, 10 Jun 2026 07:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDDA1F0089B;
 Wed, 10 Jun 2026 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781076284;
 bh=UuIX8kK4Ky3jKBy/ok5odAQ9WEDxmvaAI/C6KCwhT74=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CKoEHIBkMWuB4X5Z/nykj2jUMQw43yw9BQqlBtF2HqFRxShDtyz261In3rkdhU691
 JM5udovSQ6dmkjS7sqMV8ciiqeJ2TebKkf4QKf2GBzhqAWG2vgJo/KKZY3Ye7Rudem
 7kRw51FbLREH5n9MQJOWx5nt0zn9NRPQwnubdIdsvgetM//XLXr6PcOS4iCvYL3JEc
 Jw3SRnUx0k5oGYVhYxt8Jh1Wm43X+tYkSatG/SZM4zBniTxw78xcVuRZ7Sa4RBmg0S
 Q5a2NYMu2/O9AXnOVYWQEZKdbKjOcHUK5JEru+uRChX39wx4bas3gF0ZJV9Hhe8dU2
 0az2piLAK/1sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610071045.3414828-1-zhaojinming@uniontech.com>
References: <20260610071045.3414828-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 07:24:43 +0000
Message-Id: <20260610072444.5FDDA1F0089B@smtp.kernel.org>
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
- [High] Aborting a DRM scheduler job after calling drm_sched_job_arm() cor=
rupts scheduler state.
--

commit e1b7e4281cdb5c3f1d9985be73947531edf81dc5
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix error path handling in rocket_job_run()

This commit replaces pm_runtime_get_sync() with pm_runtime_resume_and_get()
in rocket_job_run() to correctly balance the usage counter on failure. It
also fixes dma_fence reference leaks and prevents returning an unsignaled
fence on error paths.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f960ccb..cf9f61682dd8b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c

[ ... ]

> 	scoped_guard(mutex, &rdev->sched_lock) {
> 		drm_sched_job_arm(&job->base);
>=20
> 		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finishe=
d);
>=20
> 		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &jo=
b->base, false);
> 		if (ret)
> 			goto err_unlock;

[Severity: High]
This isn't a bug introduced by this patch, but does this sequence corrupt t=
he
scheduler state?

In rocket_job_push(), if rocket_acquire_object_fences() fails, the job
setup is aborted via the goto err_unlock path where the caller invokes
drm_sched_job_cleanup().

Because drm_sched_job_arm() allocates sequence numbers and initializes
fences, aborting the job after it has been armed leaves gaps in the
sequence numbers. Can this lead to system hangs where waiters may wait
indefinitely for a missing sequence number?

Should fence acquisition be performed before arming the job?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610061915.1CA2=
81F00893@smtp.kernel.org?part=3D1
