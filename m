Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D160A6F43
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0/t5NaC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C8D10E29D;
	Tue, 10 Nov 2026 07:58:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316E810E29D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:58:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3FF4437F3;
 Tue, 10 Nov 2026 07:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D8E1F0089F;
 Tue, 10 Nov 2026 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794297506;
 bh=286eXETOx/edwbh322I5nnmJH6ktsx8MfVMyK8RDuno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=o0/t5NaCv9p7Y/Uw5SC+1arX43PuF1/+0wP+ZgdvI641ixPJpA/puN5CDLFGzdXJc
 /Vv3tafs2wRgf4S2YCH0sgXh8Ssh8pt6Te89cnGYgCb+PIMnK5LKAA6GUK3HbGbpcu
 QUNrooSGMF7QQvvqIRhyDHUf1WxECPbKFtkqRZvtcrC2Ew9L1egcMznSUEC0i3rXrg
 DtGSfs4Ny9L/Em93cCw1T4CPxIeeO1yuMARrEFncWnrnZvS1SjHEcvaAtV5EXZLibW
 FGfu9JoSXU/0Q0IUB9U86UgCtpNPwC98IbPz8wJ0kZGDAFqjt01fNw8gkyLoCqSeMm
 A0UpboNEWLIcQ==
Message-ID: <sashiko-outbox-206548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] drm/panfrost: Don't resume a soft-stopped job after
 a GPU reset
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-panfrost-long-jobs-v1-4-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
 <20261110-panfrost-long-jobs-v1-4-24508939ae8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:58:26 +0000
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
- [Critical] drm/panfrost: missing PM runtime reference in
  panfrost_reset_work() [1]
--

commit 8ce48d8d6cacef2958a594210836f127d449cef8
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Don't resume a soft-stopped job after a GPU reset

This commit tracks GPU resets and fails soft-stopped jobs with -ECANCELED in
panfrost_job_run() if a GPU reset occurred after the job was stopped.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 3a46dd61cf87f..e1f3e5d717976 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c

[ ... ]

> @@ -728,6 +741,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>  			panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
>  		}
>  	}
> +	pfdev->reset.count++;
>  	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
>  	spin_unlock(&pfdev->js->job_lock);

[Severity: Critical]
This problem wasn't introduced by this patch, but can panfrost_reset() acce=
ss
hardware registers while the GPU is runtime suspended [1]?

Between panfrost_device_schedule_reset() queueing reset.work and the
workqueue executing panfrost_reset_work(), the active context can complete
and drop its runtime PM reference, allowing the GPU to suspend and gate its
clocks and power domains.  panfrost_reset_work() then calls panfrost_reset()
without holding a runtime PM reference:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_reset_work() {
	struct panfrost_device *pfdev;

	pfdev =3D container_of(work, struct panfrost_device, reset.work);
	panfrost_reset(pfdev, NULL);
}

When panfrost_reset() writes to MMIO registers such as JOB_INT_MASK on the
powered-down device, it triggers a synchronous external abort.

[1] https://sashiko.dev/#/bug/linux-57c30678-e800-4756-b926-145408a6717d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-panfrost-l=
ong-jobs-v1-0-24508939ae8d@gmail.com?part=3D4
