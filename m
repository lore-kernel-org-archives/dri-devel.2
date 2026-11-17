Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A19606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/He/fMk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D887710F613;
	Tue, 17 Nov 2026 10:46:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E017410F611;
 Tue, 17 Nov 2026 10:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E2B4633D2;
 Tue, 17 Nov 2026 10:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C91F000C4;
 Tue, 17 Nov 2026 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794912367;
 bh=jh6Dm2xAu0tM1p0MMRE7WESmg74QpZK1Tzgqwg2LPHw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G/He/fMk4p1HamOrfylhADo8Pdgbjpyagp1PA9SsbKqepctYHQAiXicjN1NcYjnvp
 o8C0ud6wvBZu1F3sqDnBVcgrKnVyiIbZCxpfFMCqyTG8GDodvV5xfUg5ChLYvcaUHt
 IrLIzK77HWnh0wQ1mWQIzsjQzCp00eAAc33wnDhc+rilTIkApUlMZO5DFLE8dKxo/8
 0Szyhv/cZRePuqoqPXeusElMHreJsESUlLmD9tNvxxXtmNpZy2mBQiXc8DrUWPIet2
 wX4G34054yAHxYJeAf7RmUcUZ0zgoQAWRVG1nnKZMye6ojm5GwkvTgggGAUkDIHv9r
 oOuXie6IrjWJQ==
Message-ID: <sashiko-outbox-218670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/sched: Disallow initializing entities with
 un-initialized schedulers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117100654.8593-2-tvrtko.ursulin@igalia.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:46:06 +0000
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
- [High] drm/sched: drm_sched_entity_init() breaks v3d_open() on V3D 3.3
- [Medium] drm/sched: uninitialized SR-IOV VCN0 scheduler in
  vcn_v3_0_limit_sched()
--

commit 5a80b965f793708bcd7eab260f9a3099009c1c8c
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Disallow initializing entities with un-initialized schedulers

This commit rejects uninitialized schedulers (where sched_rq is NULL) in
drm_sched_entity_init() with -EINVAL and in drm_sched_entity_modify_sched()
with a WARN_ON() and early return.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 03e68b4102d50..2844049d4c665 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -119,9 +119,16 @@ int drm_sched_entity_init(struct drm_sched_entity *e=
ntity,
>  			  unsigned int num_sched_list,
>  			  atomic_t *guilty)
>  {
> -	if (!entity || !sched_list || !num_sched_list || !sched_list[0])
> +	unsigned int i;
> +
> +	if (!entity || !sched_list || !num_sched_list)
>  		return -EINVAL;
> =20
> +	for (i =3D 0; i < num_sched_list; i++) {
> +		if (!sched_list[i] || !sched_list[i]->sched_rq)
> +			return -EINVAL;
> +	}

[Severity: High]
Does returning -EINVAL here break v3d_open() on V3D 3.3 hardware?

On V3D 3.3, v3d_has_csd(v3d) is false, so v3d_sched_init() skips
v3d_queue_sched_init() for V3D_CSD and V3D_CACHE_CLEAN, leaving their
sched_rq pointers NULL:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_sched_init() {
    ...
	if (v3d_has_csd(v3d)) {
		ret =3D v3d_queue_sched_init(v3d, &v3d_csd_sched_ops, V3D_CSD,
					   "v3d_csd");
		if (ret)
			goto fail;

		ret =3D v3d_queue_sched_init(v3d, &v3d_cache_clean_sched_ops,
					   V3D_CACHE_CLEAN, "v3d_cache_clean");
    ...
}

v3d_open() unconditionally calls drm_sched_entity_init() for all
V3D_MAX_QUEUES and aborts if it returns an error:

drivers/gpu/drm/v3d/v3d_drv.c:v3d_open() {
    ...
	for (i =3D 0; i < V3D_MAX_QUEUES; i++) {
		...
		sched =3D &v3d->queue[i].sched;
		ret =3D drm_sched_entity_init(&v3d_priv->sched_entity[i],
					    DRM_SCHED_PRIORITY_NORMAL, &sched,
					    1, NULL);
		if (ret)
			goto err_sched;
	}
    ...
}

Previously drm_sched_entity_init() logged a warning and returned 0; with
this regression, every open() of the DRM device node on V3D 3.3 fails with
-EINVAL.

[ ... ]

> @@ -192,7 +192,15 @@ void drm_sched_entity_modify_sched(struct drm_sched_=
entity *entity,
>  				    struct drm_gpu_scheduler **sched_list,
>  				    unsigned int num_sched_list)
>  {
> -	WARN_ON(!num_sched_list || !sched_list);
> +	unsigned int i;
> +
> +	if (WARN_ON(!num_sched_list || !sched_list))
> +		return;
> +
> +	for (i =3D 0; i < num_sched_list; i++) {
> +		if (WARN_ON(!sched_list[i] || !sched_list[i]->sched_rq))
> +			return;
> +	}

[Severity: Medium]
Can vcn_v3_0_limit_sched() hit this WARN_ON() when VCN0 decode is disabled
by the hypervisor under SR-IOV?

During vcn_v3_0_sw_init(), amdgpu_ring_init() places &inst[0].ring_dec.sched
into adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC][AMDGPU_RING_PRIO_DEFAULT].sched[=
0].
Later, vcn_v3_0_hw_init() sets ring->no_scheduler =3D true when the hypervi=
sor
has disabled VCN0 decode, which causes amdgpu_device_init_schedulers() to
skip drm_sched_init() and leave sched[0]->sched_rq NULL:

drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:vcn_v3_0_hw_init() {
    ...
			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
				ring->sched.ready =3D false;
				ring->no_scheduler =3D true;
				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
			}
    ...
}

Because vcn_v3_0_early_init() sets adev->vcn.harvest_config =3D 0 on SR-IOV,
an AV1 decode submission on VCN1 reaches vcn_v3_0_limit_sched(), passes the
AMDGPU_VCN_HARVEST_VCN0 check, and passes that uninitialized sched[0] to
drm_sched_entity_modify_sched():

drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:vcn_v3_0_limit_sched() {
	struct drm_gpu_scheduler **scheds;

	/* The create msg must be in the first IB submitted */
	if (atomic_read(&job->base.entity->fence_seq))
		return -EINVAL;

	/* if VCN0 is harvested, we can't support AV1 */
	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
		return -EINVAL;

	scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
		[AMDGPU_RING_PRIO_DEFAULT].sched;
	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
	return 0;
}

An unprivileged guest user submitting an AV1 decode job can trigger the
WARN_ON(), and the early return leaves the unsupported AV1 job scheduled on
VCN1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117100654.8593=
-1-tvrtko.ursulin@igalia.com?part=3D1
