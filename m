Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72ACD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF6310ECE9;
	Thu, 11 Jun 2026 06:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eWra/w/U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E0E10ECE9
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:09:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD5DA60209;
 Thu, 11 Jun 2026 06:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9AC1F00893;
 Thu, 11 Jun 2026 06:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781158141;
 bh=J65hoBene/DjLvzKyTNQVJkFSn/x/X8k7JmsspCvzLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eWra/w/UWMkulkBpX7mjTaGrdoJTGp9ez7QeVehUwDk7C8/Z35JxtZEdKtvipbDos
 tjGIieBEamaS7gS7vKZg2KNQgP/KAUR/RwGZvAc5rjVKKIBhhACdIdRfDBYiCG4FDG
 GA4HV3BiO6TjliteaXjkIX2jHul4JRfxFSOG4JdJlVzzshXYeC/Yx3xPD4YQeGIseE
 eQwB9oyEDUnbtiukS9Zj3iQO1oH0Wnn79E6aQmmaFfU4dnlxO1KQYOCpHnlFDtiTGY
 vFEdrTi7lG2hHH0sxRs7hAp3tiA3JbXXkbj/Q6bjGQ5v1o0YKLteQLJPtnmWf9oLsn
 Rg8coBc3qeY2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Use threaded IRQ for IPC callback processing
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611055201.948726-1-karol.wachowski@linux.intel.com>
References: <20260611055201.948726-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:09:00 +0000
Message-Id: <20260611060901.6D9AC1F00893@smtp.kernel.org>
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
- [High] Firmware command queue leak and duplicate hardware initialization =
on the retry path in `ivpu_job_submit`.
--

commit 91623d3f3cc1b38781bd2f9f2354ef0fa3591d50
Author: Karol Wachowski <karol.wachowski@linux.intel.com>

accel/ivpu: Use threaded IRQ for IPC callback processing

Dispatching IPC callbacks from system_percpu_wq adds scheduling latency
that is neither bounded nor predictable, which hurts job completion
turnaround. Handle them from a threaded IRQ instead, and defer job
resource teardown to a dedicated unbounded workqueue.

> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index 521931d1f7fca..7320c97762832 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
[ ... ]
> @@ -709,6 +748,14 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 =
priority, u32 cmdq_id)
>  	}
> =20
>  	ret =3D ivpu_cmdq_register(file_priv, cmdq);
> +	if (ret =3D=3D -EBUSY && !flushed) {
> +		/* Doorbell may be held by jobs pending deferred cleanup */
> +		mutex_unlock(&file_priv->lock);
> +		mutex_unlock(&vdev->submitted_jobs_lock);
> +		flush_work(&vdev->job_destroy_work);
> +		flushed =3D true;
> +		goto retry;
> +	}

[Severity: High]
Does this retry loop cause duplicate firmware queue initialization and leak
resources?

If ivpu_cmdq_register() successfully calls ivpu_hws_cmdq_init() but then
ivpu_register_db() fails with -EBUSY, the function returns -EBUSY without
undoing the firmware queue initialization and leaves cmdq->db_id as 0:

drivers/accel/ivpu/ivpu_job.c:ivpu_cmdq_register() {
    ...
	if (vdev->fw->sched_mode =3D=3D VPU_SCHEDULING_MODE_HW) {
		ret =3D ivpu_hws_cmdq_init(file_priv, cmdq, VPU_ENGINE_COMPUTE, cmdq->pri=
ority);
		if (ret)
			return ret;
	}

	ret =3D ivpu_register_db(file_priv, cmdq);
	if (ret)
		return ret;  // Returns -EBUSY here, db_id is 0
    ...
}

When the goto retry path is taken, ivpu_cmdq_register() is called again
with the same cmdq. Because cmdq->db_id is still 0, the early bailout is
skipped, and ivpu_hws_cmdq_init() is called a second time.

Furthermore, if the retry also fails (or is not attempted), will this
leak the firmware resource? The unregister path seems to bail early if
db_id is 0:

drivers/accel/ivpu/ivpu_job.c:ivpu_cmdq_unregister() {
	if (!cmdq->db_id)
		return 0;
    ... // ivpu_jsm_hws_destroy_cmdq() is skipped
}

>  	if (ret) {
>  		ivpu_err(vdev, "Failed to register command queue: %d\n", ret);
>  		goto err_unlock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611055201.9487=
26-1-karol.wachowski@linux.intel.com?part=3D1
