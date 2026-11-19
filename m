Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E24606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzZ1u5vT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEEC896EC;
	Thu, 19 Nov 2026 19:28:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25C8896EC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:28:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0340660D6F;
 Thu, 19 Nov 2026 19:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DB61F000C5;
 Thu, 19 Nov 2026 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795116492;
 bh=/GbGSCXf6XpTzzvUzr6IOk/d2sMtVlLQhz522lF2BOU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=TzZ1u5vTH6FM7zz4Pggkt4axxfyE2NZbMjj5rxnLC3gTHb7bepeDYWBv5/lbDdF9X
 k7xGzEZAV7JifQJ4r9wdcYplOZY3SX65Yrvr8SqmAfhvX4BGd1WZkSb1h788cNnoO0
 45YwyeVXYYJYrYL/5EzWXUSx4vfnUjexHxnj9/ovzi8Crh7gZuGRxMUlRUpCkVxCqD
 fxxMGN7ZGOdMNehtBzYmZ8t5OzhgrRBZ0oMc+ENDBusyUbtmbgH8fQ9CD5/VJuhMLz
 OPB9TURUaBN63uJWq5yTIz5wqPeWk34Js3FeT48EBHN0tFI1uEl1wwi9VXAi7+417S
 kiEJGJClzhOgw==
Message-ID: <sashiko-outbox-223883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panfrost: fix stuck reset.pending on JOB_BUS_FAULT
To: ThePedroo <pedro@performanc.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <a3b7a3f3-4da6-4a41-b842-cf9778dd7ba1@performanc.org>
References: <a3b7a3f3-4da6-4a41-b842-cf9778dd7ba1@performanc.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:28:12 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/panfrost: use-after-free in panfrost_jm_fini() [1]
--

commit 425df48a8a39ab3673476c8b751250446dcc35c8
Author: Pedro Ol=C3=ADmpio <pedro@performanc.org>

drm/panfrost: fix stuck reset.pending on JOB_BUS_FAULT

This commit replaces the drm_sched_fault() call in panfrost_job_handle_err()
with panfrost_device_schedule_reset() so that a GPU reset runs even after
job->done_fence has been signaled.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 3a46dd61cf87f..3c3107d706795 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -499,10 +499,8 @@ static void panfrost_job_handle_err(struct panfrost_=
device *pfdev,
> =20
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
> -	if (panfrost_exception_needs_reset(pfdev, js_status)) {
> -		atomic_set(&pfdev->reset.pending, 1);
> -		drm_sched_fault(&pfdev->js->queue[js].sched);
> -	}
> +	if (panfrost_exception_needs_reset(pfdev, js_status))
> +		panfrost_device_schedule_reset(pfdev);
>  }
> =20
>  static void panfrost_jm_handle_done(struct panfrost_device *pfdev,

[Severity: Critical]
This problem wasn't introduced by this patch, but can a pending
pfdev->reset.work item race with panfrost_jm_fini() [1] and access
js->queue[j].sched after drm_sched_fini()?

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_fini() {
    ...
	for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
		drm_sched_fini(&js->queue[j].sched);
	}

	disable_work_sync(&pfdev->reset.work);
    ...
}

CPU0                                    CPU1 (pfdev->reset.wq)
panfrost_jm_fini()
  drm_sched_fini(&js->queue[j].sched)
                                        panfrost_reset()
                                          drm_sched_stop() <-- use-after-fr=
ee
  disable_work_sync(&pfdev->reset.work)

If a reset queued via panfrost_device_schedule_reset() runs during driver
teardown before disable_work_sync() cancels it, panfrost_reset() calls
drm_sched_stop() on the already finalized scheduler.

[1] https://sashiko.dev/#/bug/linux-3c56dd27-0f33-4f82-a144-72279b21c756

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a3b7a3f3-4da6-4a41-=
b842-cf9778dd7ba1@performanc.org?part=3D1
