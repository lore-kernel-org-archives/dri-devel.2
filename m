Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E4606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfDuuuRH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D763112358;
	Thu, 29 Oct 2026 14:36:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5C8112358
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:36:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4769160092
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D721F01825;
 Thu, 29 Oct 2026 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793284575;
 bh=i2haA1E6rNUDZvVN3Jhx+0Y3d0ebG6OBB7V1SnW8bH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bfDuuuRHqC2MdWquCh8gYU3qZaM8ABLFcQDF/dMRwEmf0S/z6oOnsJhM5hMLSt9h/
 ur5pMan98Kp1RVbHL287gnnYu/oUHPfucQtPCnui2PEWg4RP0HEi7b00KMhQnpYfE+
 i7oIQybmkfQQr3NaBslgbpDUMVnu2Ss5YmgWdAcE/WINhKYDDDsLXw4+wT/t6u/Upq
 +UajDhohqfo81PNu0pyelQfz8UB3KIoR2cF8s96PDvr4uT5Yzihh2rs07ygNKDdzha
 ElUqHtbmQIVk4rvR6VhDo/y1sF/gc3Kwk4UUAY1Qn6VN9VyN2pWa/K4pt8QX6SBrQe
 lIghQs6WZaAGA==
Message-ID: <sashiko-outbox-189534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/31] accel: ethosu: Clear SRAM before submission
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-11-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-11-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:36:14 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] accel: ethosu: ethosu_job_sram_size() clobbers region 2 GEM BO=
 with SRAM addr
- [High] accel: ethosu: job->base.entity is always NULL in ethosu_job_set_i=
n_flight()
- [Medium] accel: ethosu: ethosu_job_close() clears sram_entity before kill=
ing entity
--

commit a7a26abf2b6252cbc62a4f8adc9daddbc6d61be4
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Clear SRAM before submission

This patch tracks the scheduler entity that last used the on-chip SRAM and
clears the SRAM before submitting a job from a different entity.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index ef95a8abd61e2..3976115902e83 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -45,11 +45,27 @@ static const struct dma_fence_ops ethosu_fence_ops =
=3D {
>  	.get_timeline_name =3D ethosu_fence_get_timeline_name,
>  };
> =20
> -static void ethosu_job_set_in_flight(struct ethosu_device *dev,
> -				     struct ethosu_job *job)
> +static u32 ethosu_job_sram_size(struct ethosu_job *job)
>  {
> +	struct ethosu_validated_cmdstream_info *cmd_info =3D
> +		to_ethosu_bo(job->cmd_bo)->info;
> +
> +	return cmd_info->region_size[ETHOSU_SRAM_REGION];
> +}
> +
> +static bool ethosu_job_set_in_flight(struct ethosu_device *dev,
> +				     struct ethosu_job *job, u32 sram_size)
> +{
> +	bool clear_sram =3D false;
> +
>  	guard(spinlock)(&dev->job_lock);
> +	if (sram_size && dev->sram_entity !=3D job->base.entity) {
> +		dev->sram_entity =3D job->base.entity;
> +		clear_sram =3D true;
> +	}

[Severity: High]
Isn't job->base.entity always NULL when ethosu_job_set_in_flight() is called
from ethosu_job_run()?

In the DRM scheduler, drm_sched_run_job_work() pops the job via
drm_sched_entity_pop_job() before invoking sched->ops->run_job(sched_job):

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_pop_job() {
	...
	/* Jobs and entities might have different lifecycles. Since we're
	 * removing the job from the entities queue, set the jobs entity pointer
	 * to NULL to prevent any future access of the entity through this job.
	 */
	sched_job->entity =3D NULL;

	return sched_job;
}

Because job->base.entity is set to NULL before ethosu_job_run() runs, and
dev->sram_entity starts at NULL, won't dev->sram_entity !=3D job->base.enti=
ty
always evaluate to false (NULL !=3D NULL), leaving clear_sram false so that
memset_io() in ethosu_job_hw_submit() never executes?

Would tracking job->base.s_fence->drm_client_id (or
job->base.s_fence->scheduled.context) instead of job->base.entity avoid thi=
s?

>  	dev->in_flight_job =3D job;
> +
> +	return clear_sram;
>  }
> =20
>  static struct ethosu_job *
> @@ -64,7 +80,8 @@ ethosu_job_clear_in_flight(struct ethosu_device *dev)
>  	return job;
>  }
> =20
> -static void ethosu_job_hw_submit(struct ethosu_device *dev, struct ethos=
u_job *job)
> +static void ethosu_job_hw_submit(struct ethosu_device *dev, struct ethos=
u_job *job,
> +				 u32 sram_size, bool clear_sram)
>  {
>  	struct drm_gem_dma_object *cmd_bo =3D to_drm_gem_dma_obj(job->cmd_bo);
>  	struct ethosu_validated_cmdstream_info *cmd_info =3D to_ethosu_bo(job->=
cmd_bo)->info;
> @@ -79,7 +96,12 @@ static void ethosu_job_hw_submit(struct ethosu_device =
*dev, struct ethosu_job *j
>  		dev_dbg(dev->base.dev, "Region %d base addr =3D %pad\n", region, &bo->=
dma_addr);
>  	}
> =20
> -	if (job->sram_size) {
> +	if (sram_size) {
> +		if (clear_sram) {
> +			memset_io(dev->sram, 0, dev->npu_info.sram_size);
> +			/* Order the SRAM clear before starting the NPU. */
> +			wmb();
> +		}
>  		writel_relaxed(lower_32_bits(dev->sramphys),
>  			       dev->regs + NPU_REG_BASEP(ETHOSU_SRAM_REGION));
>  		writel_relaxed(upper_32_bits(dev->sramphys),

[Severity: Critical]
When a job backs region 2 (ETHOSU_SRAM_REGION) with a GEM BO and sets
job->sram_size to 0, won't replacing the job->sram_size check with
ethosu_job_sram_size() overwrite the region 2 GEM BO DMA address with
dev->sramphys?

In ethosu_ioctl_submit_job(), region 2 is only reserved for on-chip SRAM wh=
en
job->sram_size is non-zero:

	/* BO region 2 is reserved if SRAM is used */
	if (job->region_bo_handles[ETHOSU_SRAM_REGION] && job->sram_size)
		return -EINVAL;

	if (edev->npu_info.sram_size < job->sram_size)
		return -EINVAL;

When job->sram_size is 0 and job->region_bo_handles[ETHOSU_SRAM_REGION] is
non-zero, ethosu_ioctl_submit_job() only validates
cmd_info->region_size[ETHOSU_SRAM_REGION] against gem->size, not against
edev->npu_info.sram_size.

Since ethosu_job_sram_size() unconditionally returns
cmd_info->region_size[ETHOSU_SRAM_REGION] (truncated to u32) without checki=
ng
job->sram_size, ethosu_job_hw_submit() will clobber
NPU_REG_BASEP(ETHOSU_SRAM_REGION) and NPU_REG_BASEP_HI(ETHOSU_SRAM_REGION)
with dev->sramphys, causing the NPU to perform unchecked DMA beyond the
bounds of on-chip SRAM (or at physical address 0 when no SRAM is configured=
).

Should this continue checking job->sram_size instead of
cmd_info->region_size[ETHOSU_SRAM_REGION]?

[ ... ]

> @@ -482,12 +507,22 @@ int ethosu_job_open(struct ethosu_file_priv *ethosu=
_priv)
>  	return ret;
>  }
> =20
> +static void ethosu_job_clear_sram_entity(struct ethosu_device *dev,
> +					 struct drm_sched_entity *entity)
> +{
> +	guard(spinlock)(&dev->job_lock);
> +	if (dev->sram_entity =3D=3D entity) {
> +		dev->sram_entity =3D NULL;
> +	}
> +}
> +
>  void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)
>  {
>  	struct ethosu_device *dev =3D ethosu_priv->edev;
>  	struct drm_sched_entity *entity =3D &ethosu_priv->sched_entity;
> =20
>  	scoped_guard(mutex, &dev->sched_lock) {
> +		ethosu_job_clear_sram_entity(dev, entity);
>  		drm_sched_entity_kill(entity);
>  		list_del(&ethosu_priv->sched_entity_list);
>  	}

[Severity: Medium]
Can ethosu_job_clear_sram_entity() race with ethosu_job_run() if it is call=
ed
before drm_sched_entity_kill()?

drm_sched_run_job_work() runs on the scheduler workqueue without holding
dev->sched_lock, invokes ethosu_job_run() -> ethosu_job_set_in_flight(), and
only signals entity->entity_idle after run_job() returns.

If ethosu_job_clear_sram_entity() runs before drm_sched_entity_kill() stops
the entity and waits on entity->entity_idle, a concurrent ethosu_job_run() =
can
repopulate dev->sram_entity right before ethosu_priv is freed in
ethosu_postclose(). If a subsequent open() reallocates ethosu_file_priv at =
the
same address, could the stale dev->sram_entity pointer match the new entity
and skip clearing SRAM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D11
