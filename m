Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C21606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOaOLP+j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8176810E29B;
	Wed,  4 Nov 2026 18:17:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A4E10E29B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:17:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0AE9609F9;
 Wed,  4 Nov 2026 18:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326681F000C1;
 Wed,  4 Nov 2026 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793816256;
 bh=6GEErmK/V8gIXJNye1Z4y9ld8qfohuE8TAQVdigNWjI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=NOaOLP+jcVA4O2H8Nb3y6Jhv20uaDaiflr54J+3GuSp7qTEAu5HGwCaFfY/CxUrIv
 Y4QjyDzDfysHqKAotR39IlPgRRsgxlrGx2Fx0HbAIQAryhGqNBNLjJKFgKZJzIldn/
 V9HdASfpOG44qbOmZGY/SeW3bulRoXhWi3xI6UiOpFN95i4DxFaptgKqzPI5MbOWyW
 D6ZUx8k6KgnUBkmKPLV29FBvm4PpX5cfB6Ip8mR47ISWsiXNuUwyMlE0lVTdQetMvz
 2y7YHG2ZxkfLiqStuDzA2tWbJu/ktBBI1YEj6SzWKLeky6tt2N+hFqBjrIKp7X+TTC
 GlHFmpe3ZqLLw==
Message-ID: <sashiko-outbox-197826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104175931.28475-6-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
 <20261104175931.28475-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:17:35 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm: runtime PM ref leak on early return in sel_worker()
- [Low] drm/msm/debugfs: stray revision note after Signed-off-by in commit =
message
--

commit 0021c5b2e7827c592eea3552f7dbac0b157fff35
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/debugfs: Use cleanup.h for gpu state dump

This series reworks IFPC and performance counter handling around GPU hardwa=
re
initialization and runtime PM, and updates msm_gpu_open() in debugfs to use
scope-based cleanup helpers.

>     drm/msm/debugfs: Use cleanup.h for gpu state dump
>    =20
>     Use scoped_guard/etc to simplify the error paths.
>    =20
>     Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>     Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>    =20
>     Reword, we are no longer reordering locking/runpm

[Severity: Low]
This isn't a bug, but it looks like a patch revision note was left after the
Signed-off-by line in the commit message. Should that trailing line be
removed?

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index 7fa2e858bd082..e6f4f9b098842 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -199,10 +199,17 @@ sel_worker(struct work_struct *w)
>  		return;
> =20
>  	scoped_guard (mutex, &gpu->lock) {
> +		/*
> +		 * If gpu still needs hw_init, bail.  We'll be rescheduled
> +		 * after hw_init, and there is no point to collect counters
> +		 * beforehand
> +		 */
> +		if (gpu->needs_hw_init)
> +			return;

[Severity: High]
Does this early return in sel_worker() leak the runtime PM usage reference =
on
&gpu->pdev->dev?

Earlier in sel_worker(), a runtime PM reference is acquired manually before
entering the scoped_guard(mutex, &gpu->lock) block, and released after the
block finishes:

drivers/gpu/drm/msm/msm_perfcntr.c:sel_worker() {
	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	scoped_guard (mutex, &gpu->lock) {
		if (gpu->needs_hw_init)
			return;
		...
	}

	pm_runtime_put_autosuspend(&gpu->pdev->dev);
}

When gpu->needs_hw_init is true while the device is runtime-active (for
example, if msm_ioctl_perfcntr_config() queues sel_work after
adreno_runtime_resume() sets gpu->needs_hw_init =3D true and before
msm_gpu_hw_init() clears it), returning from inside the scoped_guard block
unlocks gpu->lock via cleanup but skips pm_runtime_put_autosuspend() at the
end of sel_worker(), preventing the GPU from runtime-suspending again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104175931.2847=
5-1-robin.clark@oss.qualcomm.com?part=3D5
