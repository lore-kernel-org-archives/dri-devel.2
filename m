Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3A606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRuledst
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEE310E5E3;
	Tue, 20 Oct 2026 16:03:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72DCA10E5E3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:02:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74A72601F9;
 Tue, 20 Oct 2026 16:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101761F000C4;
 Tue, 20 Oct 2026 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792512173;
 bh=z9hT5uy7vQch54gn4wRSB+CV1YykAVoErY1V1s68JcQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XRuledstnIrHNdj5KwZf1Ewm4MF5eVjdzXr6w/I30zHYXBKRgoFa3PHTubX0dPY8g
 DouAVN60rPMumBL7RB1lpPk4IVJIPqrJK0ll6Y830yvigxzSQtpEOe295aCwQue0zX
 +TV/dJzFGlxruXL5ia7++xdT3B+LrMHIaWU0g9qp0hKytJlvqzoHj7t2kufafXP2gd
 70inGcQ86Dt1g7ShaWpL3W5bPf+EjwwwkDfaLkFPRTcyvWlpcxD9YxVfFIdIUYJSc1
 UKwtUwtyJDahR9q9gbMPaSD7/EXlAx3yR6aPzqDxUmrgHFGEj7JZ+ywkrlD+/oN/zv
 sglvT7XVr1XMg==
Message-ID: <sashiko-outbox-179327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] drm/sched: Disallow initializing entities with
 un-initialized schedulers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261020154123.33631-3-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:02:37 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/sched: drm_sched_entity_init() breaks v3d_open() on V3D 3.3
--

commit 607520d70e20fa56f0a8fa9eade2db9f019b764f
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Disallow initializing entities with un-initialized schedulers

This patch updates drm_sched_entity_init() to reject schedulers whose
run-queues have not been initialized, returning -EINVAL instead of logging
a warning and continuing.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index e12709b7bd0c3..95bb79b3d003a 100644
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
Does returning -EINVAL here when !sched_list[i]->sched_rq break
v3d_open() on V3D 3.3 hardware (V3D_GEN_33)?

During probe, v3d_sched_init() in drivers/gpu/drm/v3d/v3d_sched.c only
initializes the V3D_CSD and V3D_CACHE_CLEAN schedulers when
v3d_has_csd(v3d) is true:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_sched_init() {
	...
	if (v3d_has_csd(v3d)) {
		ret =3D v3d_queue_sched_init(v3d, &v3d_csd_sched_ops, V3D_CSD,
					   "v3d_csd");
		if (ret)
			goto fail;

		ret =3D v3d_queue_sched_init(v3d, &v3d_cache_clean_sched_ops,
					   V3D_CACHE_CLEAN, "v3d_cache_clean");
		if (ret)
			goto fail;
	}
	...
}

On V3D 3.3 platforms where !v3d_has_csd(v3d), those two schedulers are
never initialized via drm_sched_init(), leaving their sched_rq pointers
NULL.

However, when userspace opens the DRM device node, v3d_open() in
drivers/gpu/drm/v3d/v3d_drv.c unconditionally loops over all
V3D_MAX_QUEUES queues and fails if drm_sched_entity_init() returns an
error:

drivers/gpu/drm/v3d/v3d_drv.c:v3d_open() {
	...
	for (i =3D 0; i < V3D_MAX_QUEUES; i++) {
		v3d_priv->stats[i] =3D v3d_stats_alloc();
		if (!v3d_priv->stats[i]) {
			ret =3D -ENOMEM;
			goto err_stats;
		}

		sched =3D &v3d->queue[i].sched;
		ret =3D drm_sched_entity_init(&v3d_priv->sched_entity[i],
					    DRM_SCHED_PRIORITY_NORMAL, &sched,
					    1, NULL);
		if (ret)
			goto err_sched;
	}
	...
}

Previously, drm_sched_entity_init() logged a warning via pr_warn() and
returned 0, allowing v3d_open() to succeed. With this change, won't
every v3d_open() call on V3D 3.3 fail with -EINVAL?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020154123.3363=
1-1-tvrtko.ursulin@igalia.com?part=3D2
