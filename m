Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1033BCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F43010F0D2;
	Mon,  8 Jun 2026 10:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lVRxYkXM";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E66310F0D2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:08:53 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYnnG4TRsz9sWC;
 Mon,  8 Jun 2026 12:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780913330; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSWjB7fWGs+wXhuVWq/9W4Hh/l44MANG3fySQbhFHak=;
 b=lVRxYkXMelHz/E4STNy7YmWsyFcebKfM3A8oJJB2/53t9PfwPUifUXFUIozI7KieC6Mrtw
 J8P7YF40fiXloP1hHN69Sk+pFiG8klJ3AoaeUv7YxYCld1VG4/0IYlP6LDgfTzTyLKPpqS
 PhouXImJXt+i3MZ46tHmPMGBgHPCREA7IxoUljnQpt8wcJEnHhypdT2zqV/FOgGMXQv9Et
 4F0/4o78lKJM+fhAufLb0ZWB/nNjupnXoLpT6DuelZrE/bVnQVAenjiav5jC/kuiwXonaO
 lu7FCbJMjFBb9KusCdWvt6f4ShOgGirXewfqJyZ5lem5782Wjnmq7IU3eW10VA==
Message-ID: <28fa48b63a6968999e40ff718ce06473e5baeb7c.camel@mailbox.org>
Subject: Re: [PATCH 3/3] drm/rocket: Drop the dedicated reset workqueue
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Tomeu Vizoso	
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Rob Herring
 <robh@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner	 <phasta@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Mon, 08 Jun 2026 12:08:45 +0200
In-Reply-To: <20260605-rocket-per-task-jobs-v1-3-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
 <20260605-rocket-per-task-jobs-v1-3-e3319adf3c49@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: d015d8fe82b1f750928
X-MBO-RS-META: w78z619rhxcs85s77k8knq4rbnkbipts
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 2026-06-05 at 13:07 -0300, Ma=C3=ADra Canal wrote:
> Each core allocated an ordered workqueue ("rocket-reset-%d") and passed
> it as the scheduler's timeout_wq. The only documented reason to provide a
> custom timeout_wq is to serialize the timeout handlers of several
> schedulers that share globally-reset hardware.
>=20

I think it's mostly about serializing timeouts for hardware where one
ring blocking can cause another ring to delay. So it's about catching
false-positive timeouts for certain rings.

>  That does not apply here:
> each core has its own scheduler and is reset independently
> (rocket_reset() only touches its own core). With the reset worker gone,
> the workqueue served solely as the timeout_wq.
>=20
> Drop it and let drm_sched fall back to the default timeout workqueue.

From what I can tell, much of the cleanup, especially this part, looks
quite non-controversial.


P.

>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/accel/rocket/rocket_core.h |=C2=A0 4 ----
> =C2=A0drivers/accel/rocket/rocket_job.c=C2=A0 | 15 +--------------
> =C2=A02 files changed, 1 insertion(+), 18 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/ro=
cket_core.h
> index f74dc99d07bb..607e4270f59c 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -46,10 +46,6 @@ struct rocket_core {
> =C2=A0
> =C2=A0	spinlock_t fence_lock;
> =C2=A0
> -	struct {
> -		struct workqueue_struct *wq;
> -	} reset;
> -
> =C2=A0	struct drm_gpu_scheduler sched;
> =C2=A0	u64 fence_context;
> =C2=A0	u64 emit_seqno;
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 871041eb7a1d..1a454559ecf4 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -467,33 +467,20 @@ int rocket_job_init(struct rocket_core *core)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	core->reset.wq =3D alloc_ordered_workqueue("rocket-reset-%d", 0, core->=
index);
> -	if (!core->reset.wq)
> -		return -ENOMEM;
> -
> =C2=A0	core->fence_context =3D dma_fence_context_alloc(1);
> =C2=A0
> -	args.timeout_wq =3D core->reset.wq;
> =C2=A0	ret =3D drm_sched_init(&core->sched, &args);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(core->dev, "Failed to create scheduler: %d.", ret);
> -		goto err_sched;
> +		return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> -
> -err_sched:
> -	drm_sched_fini(&core->sched);
> -
> -	destroy_workqueue(core->reset.wq);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void rocket_job_fini(struct rocket_core *core)
> =C2=A0{
> =C2=A0	drm_sched_fini(&core->sched);
> -
> -	destroy_workqueue(core->reset.wq);
> =C2=A0}
> =C2=A0
> =C2=A0int rocket_job_open(struct rocket_file_priv *rocket_priv)
