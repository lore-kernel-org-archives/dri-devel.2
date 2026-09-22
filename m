Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9373AC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C528110EBBE;
	Tue, 22 Sep 2026 07:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Nk+PXL76";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA2910EBBE
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=59xibbJUemzQCC658fwi3h9ioHpc3Bz7cuBElVF06Lc=; b=Nk+PXL762aOanPmJTIfsf/bkj2
 6ETN55saIl+o/kWaGukcbvVVRJwcfoEu+rX/JAtPOWoctMsSyde7RTrT8ylJrzeyQou/aSSMh+3UH
 Vd8tW+P/qtQHUEYCWGp92dR7cofK0e79ELxqCr8k9etySQxDIDpVHxHUCQkt8WXz7Pzqxp9m7wKJO
 LDcUc+sPCJVHwD8Bwhn2BdBsAxqhoCea2JHDKjeC2mBMSVtmeMmhjQu+hiBNK1dY4S1LpiA/4Bmh1
 gq0ojLmgsJqiKWZlTNNBSq49CZGqCBD8iWy7jdTT9GNEMJfA5Kxdo5qlYheU55M/xemZPGIjaV1Kg
 7ieeJeIQ==;
Received: from [159.147.214.108] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8ueq-005UGI-Ug; Tue, 22 Sep 2026 09:11:16 +0200
Message-ID: <94e65212ef62e2cf71bf483a36cfeaa88daa7144.camel@igalia.com>
Subject: Re: [PATCH 2/2] drm/v3d: Skip perfmon serialization while a global
 perfmon is set
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 22 Sep 2026 09:11:06 +0200
In-Reply-To: <20260921-v3d-quick-exit-perfmon-serialize-v1-2-e58aea1075e2@igalia.com>
References: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
 <20260921-v3d-quick-exit-perfmon-serialize-v1-2-e58aea1075e2@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

El lun, 21-09-2026 a las 18:24 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> A global perfmon counts concurrent activity from every job, so no
> dependency is added while one is set. Skip the accumulator for the
> jobs
> carrying no perfmon while a global perfmon is enabled, which is every
> job
> in the common case.
>=20
> Jobs carrying their own perfmon stay tracked. The global perfmon may
> be
> cleared before such a job runs, and the next job carrying a perfmon
> has
> to wait for it, otherwise both are in flight at once and only one
> gets
> programmed in the HW.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c | 18 ++++++++----------
> =C2=A01 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
> b/drivers/gpu/drm/v3d/v3d_submit.c
> index bc3c43fd4fd9..7548faab67ba 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -359,15 +359,15 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit
> *submit, u32 perfmon_id)
> =C2=A0 * track concurrent activity from all jobs.
> =C2=A0 *
> =C2=A0 * Keeping track of the in-flight jobs costs a fence merge per job,
> so it is
> - * only done while at least one perfmon is alive. Jobs submitted
> while no
> - * perfmon exists go untracked and may overlap the first measured
> job.
> + * only done while at least one perfmon is alive, and is skipped for
> the jobs
> + * carrying no perfmon while a global perfmon is set. Jobs submitted
> while
> + * tracking is off go untracked and may overlap the first measured
> job.
> =C2=A0 */
> =C2=A0static int
> =C2=A0v3d_serialize_for_perfmon(struct v3d_job *job)
> =C2=A0{
> =C2=A0	struct v3d_dev *v3d =3D job->v3d;
> =C2=A0	struct dma_fence *merged;
> -	bool is_global_perfmon;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	lockdep_assert_held(&v3d->sched_lock);
> @@ -375,11 +375,10 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
> =C2=A0	if (!atomic_read(&v3d->perfmon_state.nperfmons))
> =C2=A0		return 0;
> =C2=A0
> -	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
> -		is_global_perfmon =3D !!v3d->global_perfmon;
> -
> -	if (is_global_perfmon)
> -		goto publish;
> +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
> +		if (!job->perfmon && v3d->global_perfmon)
> +			return 0;

Same suggestion as in previous patch about updating docs for
last_hw_fence. This change means we don't update it in this case
either, to we should probably reflect that the field documentation.

> +	}
> =C2=A0
> =C2=A0	if (job->perfmon) {
> =C2=A0		for (enum v3d_queue q =3D 0; q < V3D_MAX_QUEUES; q++)
> {
> @@ -400,7 +399,6 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> -publish:
> =C2=A0	/*
> =C2=A0	 * Accumulate every in-flight job on this queue into one
> merged fence.
> =C2=A0	 * A HW queue is fed by several scheduler entities (one per-
> fd), so jobs
> @@ -414,7 +412,7 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
> =C2=A0	dma_fence_put(v3d->perfmon_state.last_hw_fence[job->queue]);
> =C2=A0	v3d->perfmon_state.last_hw_fence[job->queue] =3D merged;
> =C2=A0
> -	if (job->perfmon && !is_global_perfmon) {
> +	if (job->perfmon) {
> =C2=A0		dma_fence_put(v3d->perfmon_state.fence);
> =C2=A0		v3d->perfmon_state.fence =3D dma_fence_get(job-
> >done_fence);
> =C2=A0	}
>=20

