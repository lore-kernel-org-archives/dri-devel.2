Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18295C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232A510E3F3;
	Tue, 22 Sep 2026 06:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hwcKkz/m";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE72A10E3F3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=hB6olPrEKV3fDF3gk5JJycD+cvzOXy2XILdEkSxynjg=; b=hwcKkz/m/mf/JlGKfAurnHJnOV
 TAcdbbVu0BJxh8CxtP7sC4S5DV94R1WpNV1lQA+oxehYo3xkEqlfuMQUj4sq/z5OG6lcqu7NrXIgw
 SLJn0CiztNID8FrNMKPQm8NNLVEZUtlpNZqUzEyzXXFoLCMxw/bhHiLTfHH8rUPuZwFO/nrWOnDxL
 nl0fO3wP3htsk6bq/iSGjz16yZQgD4Xpw/p/QmdfxPkZCKE+3TJU3cOUW35bE8vcIgrny6kLpptMG
 pGoGWbFdqSEl1/6lt+1JwCadEPp8hTe6bvwuI+bMSVjQBnxiku/aFplnW5IEkr7RYs5ODGzMF5g1T
 MSOk0CJQ==;
Received: from [159.147.214.108] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8u6I-005TUo-4e; Tue, 22 Sep 2026 08:35:33 +0200
Message-ID: <ec0f9569d1b780394ef291d67b360629ca737c3e.camel@igalia.com>
Subject: Re: [PATCH 1/2] drm/v3d: Skip perfmon serialization while the
 device has no perfmon
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 22 Sep 2026 08:35:23 +0200
In-Reply-To: <20260921-v3d-quick-exit-perfmon-serialize-v1-1-e58aea1075e2@igalia.com>
References: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
 <20260921-v3d-quick-exit-perfmon-serialize-v1-1-e58aea1075e2@igalia.com>
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
> Every job merges its finished fence into the per-queue accumulator so
> that a job carrying a perfmon can later depend on everything still in
> flight. This is a (relatively high) cost that every job pays before
> it is submitted.
>=20
> Perfmons only exist while userspace runs a performance query, so the
> common case is a client paying that on every job for a dependency
> that is
> never actually added, increasing the submission latency.
>=20
> Address this situation by counting the number of perfmons alive on
> the
> device and returning early while that count is zero. This means that
> if
> no perfmon exists, v3d_serialize_for_perfmon() will bail out
> immediately.
>=20
> Jobs submitted while no perfmon is alive stay unaccounted and may
> overlap
> the first measured job. The count returns to zero whenever the last
> perfmon is destroyed, so that window reopens on every measurement
> cycle.
> Closing it would mean merging a fence on every submission for the
> lifetime of the device, so it is a reasonable compromise for the
> average
> use case.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.h=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++++
> =C2=A0drivers/gpu/drm/v3d/v3d_perfmon.c | 8 ++++++--
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c=C2=A0 | 7 +++++++
> =C2=A03 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h
> b/drivers/gpu/drm/v3d/v3d_drv.h
> index 79ef20c89ff2..cd544af8d8c8 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -84,6 +84,8 @@ struct v3d_queue_state {
> =C2=A0 * This way, only events related to a specific submission will be
> counted.
> =C2=A0 */
> =C2=A0struct v3d_perfmon {
> +	struct v3d_dev *v3d;
> +
> =C2=A0	/* Tracks the number of users of the perfmon, when this
> counter reaches
> =C2=A0	 * zero the perfmon is destroyed.
> =C2=A0	 */
> @@ -184,6 +186,11 @@ struct v3d_dev {
> =C2=A0		/* Perfmon currently programmed in HW (or NULL if
> none). */
> =C2=A0		struct v3d_perfmon *active;
> =C2=A0
> +		/* Number of perfmons alive on this device. Jobs are
> not
> +		 * serialized if the number is zero.
> +		 */
> +		atomic_t nperfmons;
> +

Maybe we should also amend the comment for the last_hw_fence field, to
make it explicit that last fence tracking is only accurate while
nperfmons > 0?

> =C2=A0		/* Finished fence of the most recently submitted job
> that
> =C2=A0		 * opened a serialization window (i.e. a job with a
> non-global
> =C2=A0		 * perfmon attached).
> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c
> b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index 07dab7fb3060..359334616bd8 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -217,8 +217,10 @@ void v3d_perfmon_get(struct v3d_perfmon
> *perfmon)
> =C2=A0
> =C2=A0void v3d_perfmon_put(struct v3d_perfmon *perfmon)
> =C2=A0{
> -	if (perfmon && refcount_dec_and_test(&perfmon->refcnt))
> +	if (perfmon && refcount_dec_and_test(&perfmon->refcnt)) {
> +		atomic_dec(&perfmon->v3d->perfmon_state.nperfmons);
> =C2=A0		kfree(perfmon);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static void v3d_perfmon_hw_start(struct v3d_dev *v3d, struct
> v3d_perfmon *perfmon)
> @@ -434,13 +436,15 @@ int v3d_perfmon_create_ioctl(struct drm_device
> *dev, void *data,
> =C2=A0		perfmon->counters[i] =3D req->counters[i];
> =C2=A0
> =C2=A0	perfmon->ncounters =3D req->ncounters;
> +	perfmon->v3d =3D v3d;
> =C2=A0
> =C2=A0	refcount_set(&perfmon->refcnt, 1);
> +	atomic_inc(&v3d->perfmon_state.nperfmons);
> =C2=A0
> =C2=A0	ret =3D xa_alloc(&v3d_priv->perfmons, &id, perfmon,
> xa_limit_32b,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> =C2=A0	if (ret < 0) {
> -		kfree(perfmon);
> +		v3d_perfmon_put(perfmon);
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
> b/drivers/gpu/drm/v3d/v3d_submit.c
> index 834d52030979..bc3c43fd4fd9 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -357,6 +357,10 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit
> *submit, u32 perfmon_id)
> =C2=A0 *
> =C2=A0 * We don't serialize the jobs when using a global perfmon as it's
> expected to
> =C2=A0 * track concurrent activity from all jobs.
> + *
> + * Keeping track of the in-flight jobs costs a fence merge per job,
> so it is
> + * only done while at least one perfmon is alive. Jobs submitted
> while no
> + * perfmon exists go untracked and may overlap the first measured
> job.
> =C2=A0 */
> =C2=A0static int
> =C2=A0v3d_serialize_for_perfmon(struct v3d_job *job)
> @@ -368,6 +372,9 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
> =C2=A0
> =C2=A0	lockdep_assert_held(&v3d->sched_lock);
> =C2=A0
> +	if (!atomic_read(&v3d->perfmon_state.nperfmons))
> +		return 0;
> +
> =C2=A0	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
> =C2=A0		is_global_perfmon =3D !!v3d->global_perfmon;
> =C2=A0
>=20

