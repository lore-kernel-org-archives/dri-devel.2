Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42087606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKUed69S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C0310E430;
	Thu, 26 Nov 2026 21:12:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630E510E430;
 Thu, 26 Nov 2026 21:12:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B6C841AFB;
 Thu, 26 Nov 2026 21:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C80C1F00896;
 Thu, 26 Nov 2026 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795727552;
 bh=MdzgDsHVnnB1m8Mwp838mv9IK/Ph/RBe6xwjyftJfjY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bKUed69SB56qYGIg7PqWZoqVDqZLDTVdsspepwS3GzEu4cXKl3+seRlZ8iTriVwC9
 BN07xBFQhdjdEV1wjrevd7+CET0Rb0TI5hnZeX6QG1K7gcDw8T5RG5ACsEE6btc0Jx
 5oqByvVEe2fSkECH8fObGZw4IBaEJ5hB42r1CvXy+6mpi4XRAA+E++eZe0sQ34GCcw
 6+Ogy8OrTMcMMnUajp0XV2IXun6j1+/NPJ74G0nGisLAT3utA8zCVui8g8f8eG8YFY
 PKCflXWKs8cTI6Vqxe6g9QoOzK0jkOlXXrhD7lhYTaRZBfqrm/BqldVxGSd0p6CIa3
 LowS8vP9udSCQ==
Message-ID: <sashiko-outbox-236214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/xe: hold video decode work and HuC queries for
 a pending DG2 HuC load
To: "Arisa Snowbell" <arisa.snowbell@gmail.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261126205758.49845-5-arisa.snowbell@gmail.com>
References: <20261126205758.49845-1-arisa.snowbell@gmail.com>
 <20261126205758.49845-5-arisa.snowbell@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:12:31 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/xe: race in query_uc_fw_version() during GT reset returns
  -ENODEV
- [Medium] drm/xe: video decode jobs miss post-reset HuC load fence in
  xe_exec_ioctl()
--

commit 5dc281ce1c152eb029eef3dac3ecc0b42e37b1fb
Author: Arisa Snowbell <arisa.snowbell@gmail.com>

drm/xe: hold video decode work and HuC queries for a pending DG2 HuC load

This commit adds a dependency on the pending DG2 HuC MEI load fence for
video decode jobs in xe_exec_ioctl() and waits for that fence in
query_uc_fw_version() before reporting the HuC firmware version.

> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index 0e6a197a8e85e..020dc78948910 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
[ ... ]
> @@ -334,6 +336,17 @@ int xe_exec_ioctl(struct drm_device *dev, void *data=
, struct drm_file *file)
>  	if (err)
>  		goto err_put_job;
> =20
> +	/* as on i915, video decode must not run before a pending HuC load */
> +	if (q->class =3D=3D XE_ENGINE_CLASS_VIDEO_DECODE) {
> +		struct dma_fence *huc_load =3D xe_huc_mei_load_fence(&q->gt->uc.huc);
> +
> +		if (huc_load) {
> +			err =3D drm_sched_job_add_dependency(&job->drm, huc_load);
> +			if (err)
> +				goto err_put_job;
> +		}
> +	}
> +
>  	if (!xe_vm_in_lr_mode(vm)) {
>  		err =3D xe_svm_notifier_lock_interruptible(vm);
>  		if (err)

[Severity: Medium]
Can video decode jobs still run before the post-reset HuC load finishes if
a GT reset occurs?

CPU0 (gt_reset_worker)            CPU1
xe_uc_stop_prepare()
  xe_huc_mei_stop()
    huc_mei_go_down()
      huc_mei_settle_locked()
      mei->state =3D XE_HUC_MEI_DOWN
      mei->load =3D NULL
xe_uc_stop()
do_gt_reset()
do_gt_restart()
                                  xe_exec_ioctl()
                                    xe_huc_mei_load_fence() -> NULL
                                    xe_sched_job_push(job)
  xe_uc_load_hw()
    xe_huc_auth()
      xe_huc_mei_start()
        mei->state =3D XE_HUC_MEI_LOADING
        queue_work(..., &mei->auth)
  xe_uc_start()
    ...
      guc_exec_queue_start()      <-- job runs before mei->auth finishes

At the start of a GT reset, huc_mei_go_down() signals any pre-reset
mei->load fence and sets mei->state to XE_HUC_MEI_DOWN until
xe_huc_mei_start() runs at the end of xe_uc_load_hw().  During that window
xe_huc_mei_load_fence() returns NULL, so jobs submitted in xe_exec_ioctl()
acquire no fence dependency, and jobs already queued in q->entity or
replayed from sched->pending_list had their pre-reset fence signaled.
When xe_uc_start() restarts the queue schedulers immediately after
xe_huc_mei_start(), those video decode jobs are submitted to the GuC
before the asynchronous HuC load completes.

> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index 9cc35fc83954f..696bae5eea3b3 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
[ ... ]
> @@ -619,6 +621,9 @@ query_uc_fw_version(struct xe_device *xe, struct drm_=
xe_device_query *query)
>  			break;
> =20
>  		huc =3D &media_gt->uc.huc;
> +		ret =3D xe_huc_mei_wait(huc);
> +		if (ret)
> +			return ret;
>  		if (huc->fw.status =3D=3D XE_UC_FIRMWARE_RUNNING)
>  			version =3D &huc->fw.versions.found[XE_UC_FW_VER_RELEASE];
>  		break;

[Severity: Medium]
Can query_uc_fw_version() still return -ENODEV during a GT reset instead
of waiting for the post-reset HuC load?

CPU0 (gt_reset_worker)            CPU1
xe_uc_stop_prepare()
  xe_huc_mei_stop()
    huc_mei_go_down()
      huc_mei_settle_locked()
      mei->state =3D XE_HUC_MEI_DOWN
      mei->load =3D NULL
...
do_gt_restart()
  xe_uc_sanitize_reset()
    ...
      huc->fw.status =3D XE_UC_FIRMWARE_LOADABLE
                                  query_uc_fw_version()
                                    xe_huc_mei_wait()
                                      xe_huc_mei_load_fence() -> NULL
                                    huc->fw.status !=3D XE_UC_FIRMWARE_RUNN=
ING
                                    return -ENODEV
  xe_uc_load_hw()
    xe_huc_auth()
      xe_huc_mei_start()

Between xe_huc_mei_stop() and xe_huc_mei_start(), mei->state is
XE_HUC_MEI_DOWN and xe_huc_mei_load_fence() returns NULL:

drivers/gpu/drm/xe/xe_huc_mei.c:xe_huc_mei_load_fence() {
	guard(spinlock_irqsave)(&mei->state_lock);
	if (mei->state !=3D XE_HUC_MEI_LOADING || !mei->load)
		return NULL;

	return dma_fence_get(mei->load);
}

Meanwhile xe_uc_sanitize_reset() resets huc->fw.status to
XE_UC_FIRMWARE_LOADABLE before xe_uc_load_hw() uploads GuC firmware and
calls xe_huc_mei_start().  A query running in that window (or woken early
when huc_mei_go_down() signals a pre-reset load fence) returns 0 from
xe_huc_mei_wait(), sees huc->fw.status !=3D XE_UC_FIRMWARE_RUNNING, and
returns -ENODEV to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126205758.4984=
5-2-arisa.snowbell@gmail.com?part=3D4
