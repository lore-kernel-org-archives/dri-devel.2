Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F86C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B626310E164;
	Mon, 21 Sep 2026 21:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BiNxly0V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E4510E164
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D9A4419C1;
 Mon, 21 Sep 2026 21:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6F51F000FF;
 Mon, 21 Sep 2026 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790026546;
 bh=wvAnyuazmbedx7hWL51jfLXPgElmT86Mo17ciMx+DcE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BiNxly0Vjs0IKdnOD1QK3RyEO11c6Rilu/M46ohJNMaJwBV3vyYBZ8DxXbWjnlpeV
 k3eO4cdVYFgrFHN7HMd0VB3bF5CIrQ9HutsnpE/JcuRhkXwLMDdeiSAH+8wPdAVG84
 xNkf4h386YZqByZcXCr5HVwKTNrddpW1vQ6rta/9n6b8NdfeEP+e/SJFUwfVTAEP1l
 C/rgIp0sbrnjRDUXOiTQKk1xAgwj50n4gRJtYf4ZB/O8yO3M+POYFa00EVgHp6kc5w
 XZglLEwlr7bX6gb290eFXlbUBOlwdtKnufdkOb9LmzrzvMuGc1OfgsE887pWohV3ao
 vZ5L6sB409pSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: Skip perfmon serialization while a global
 perfmon is set
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-v3d-quick-exit-perfmon-serialize-v1-2-e58aea1075e2@igalia.com>
References: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
 <20260921-v3d-quick-exit-perfmon-serialize-v1-2-e58aea1075e2@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:35:45 +0000
Message-Id: <20260921213546.3F6F51F000FF@smtp.kernel.org>
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
- [Medium] drm/v3d: counter pollution due to skipped job tracking with glob=
al perfmon
--

commit 16d01b295e0df230e5bdde84096f44906f1411fe
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Skip perfmon serialization while a global perfmon is set

A global perfmon counts concurrent activity from every job, so no dependency
is added while one is set. This patch skips the accumulator for the jobs
carrying no perfmon while a global perfmon is enabled.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index bc3c43fd4fd9e..7548faab67baa 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -375,11 +375,10 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
>  	if (!atomic_read(&v3d->perfmon_state.nperfmons))
>  		return 0;
> =20
> -	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
> -		is_global_perfmon =3D !!v3d->global_perfmon;
> -
> -	if (is_global_perfmon)
> -		goto publish;
> +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
> +		if (!job->perfmon && v3d->global_perfmon)
> +			return 0;

[Severity: Medium]
Does this early return cause subsequent local perfmon jobs to overlap with
untracked ones?

If a user sets a global perfmon and a job without a local perfmon is
submitted, v3d_serialize_for_perfmon() returns early here. By skipping the
publish step, the job is never added to last_hw_fence.

If the global perfmon is subsequently cleared and a job with a local perfmon
is submitted, it will check last_hw_fence but won't find a dependency for
the previously untracked job.

Could this result in both jobs executing concurrently and polluting the
performance counters for the local perfmon?

> +	}
> =20
>  	if (job->perfmon) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-v3d-quick-=
exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com?part=3D2
