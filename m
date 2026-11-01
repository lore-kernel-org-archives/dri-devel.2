Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E98606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRu6s7Tu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533F710E096;
	Sun,  1 Nov 2026 18:20:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498A410E096
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:20:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF750434AE;
 Sun,  1 Nov 2026 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997F1F000C1;
 Sun,  1 Nov 2026 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793557213;
 bh=enZP+tJ1PEvfFplG1IxuI9x3MDmj8M1ZaXnc7EgO8zg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dRu6s7TusuqMUzdag4xOFOTU1qmDB322GoRwAJdS1fV4CBMA5r46O/K5GqlueuTVn
 2tq1ohmnKoYD/QwZJWDpWeSozV2ob5CH3Cvfmw6gx13gNkQqf4aBcK+qsHQxqHys5o
 q7Hr3NWOD7gBAv7boqSgJ1xG9EQXqhqpq9alkXie5Yt1v1fRoNh6JcqdOk+KSAIwea
 qdpejORRxCOzj216QLh4O+pcBnbnsl7mAC9atxPIEigQ4mLdwK5WIZ9H6+5kfgf1fr
 P8z0MbEbWgf2Ugg0BAOcY5UWnODYn02s/px4BNmUwdmFO2W2oG5FPd45mp0P7v9Hwk
 6U3owaYE6ua1A==
Message-ID: <sashiko-outbox-192563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/msm: free the crash state asynchronously
To: "Nico Angelo Dela Cruz" <nicoangelodelacruz@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
 <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:20:13 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: premature flush_work() of crashstate_free_work in msm_gpu=
_cleanup()
--

commit 9e216db338c387162280bcdd65d14c7f062f6e18
Author: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>

drm/msm: free the crash state asynchronously

This commit defers msm_gpu_crashstate_put() in msm_gpu_devcoredump_free() to
a work item on system_dfl_wq so that synchronous free callbacks from
dev_coredumpm() do not recursively acquire gpu->lock.

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index caa86279f561d..fded78fdbf8db 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c

[ ... ]

> @@ -1047,6 +1062,10 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
> =20
>  	DBG("%s", gpu->name);
> =20
> +	/* May be unset if probe failed before msm_gpu_init() */
> +	if (gpu->crashstate_free_work.func)
> +		flush_work(&gpu->crashstate_free_work);

[Severity: High]
Could flushing gpu->crashstate_free_work at the beginning of
msm_gpu_cleanup() lead to a use-after-free of struct msm_gpu if
msm_gpu_devcoredump_free() is invoked later during teardown?

In msm_gpu_cleanup(), the MMU fault handler and gpu->worker are only stopped
further down:

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_cleanup() {
	if (gpu->crashstate_free_work.func)
		flush_work(&gpu->crashstate_free_work);
	...
	if (!IS_ERR_OR_NULL(gpu->vm)) {
		struct msm_mmu *mmu =3D to_msm_vm(gpu->vm)->mmu;
		mmu->funcs->detach(mmu);
		drm_gpuvm_put(gpu->vm);
	}

	if (gpu->worker) {
		kthread_destroy_worker(gpu->worker);
	}
}

Both recover_worker() (running on gpu->worker) and adreno_fault_handler()
call msm_gpu_crashstate_capture() -> dev_coredumpm(...,
msm_gpu_devcoredump_free). During unbind in adreno_unbind(), if
adreno_system_suspend() times out waiting for a hung GPU or returns once
retire_submits() drops active_submits to zero before recover_worker()
finishes, adreno_unbind() proceeds to gpu->funcs->destroy(gpu) ->
adreno_gpu_cleanup() -> msm_gpu_cleanup().

If kthread_destroy_worker(gpu->worker) drains a pending recover_work (or a
fault occurs before mmu->funcs->detach(mmu)) and dev_coredumpm() fails or
devcoredump is disabled, msm_gpu_devcoredump_free() will queue
gpu->crashstate_free_work on system_dfl_wq after the flush_work() at the top
of msm_gpu_cleanup() has already completed.

Similarly, if an earlier dev_coredumpm() succeeded and left an active
devcoredump device, msm_gpu_cleanup() does not call
dev_coredump_put(&gpu->pdev->dev) before flushing crashstate_free_work. When
that devcoredump later expires or is cleared via sysfs, devcd_dev_release()
calls msm_gpu_devcoredump_free(gpu) and queues gpu->crashstate_free_work.

Once msm_gpu_cleanup() and adreno_gpu_cleanup() return, the destroy callback
(such as a6xx_destroy()) frees the enclosing GPU structure with kfree(), so
msm_gpu_crashstate_free_worker() can subsequently run on system_dfl_wq and
dereference freed memory in msm_gpu_crashstate_put(gpu).

Should msm_gpu_cleanup() call dev_coredump_put(&gpu->pdev->dev) and
flush_work(&gpu->crashstate_free_work) after mmu->funcs->detach(mmu) and
kthread_destroy_worker(gpu->worker) have completed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101175553.5374=
6-1-nicoangelodelacruz@gmail.com?part=3D2
