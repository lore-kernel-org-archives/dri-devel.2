Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBADC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8395A10E166;
	Fri, 10 Jul 2026 09:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jkL2VyR+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FBF10E16B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:20:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10AED4034D;
 Fri, 10 Jul 2026 09:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAB31F00A3A;
 Fri, 10 Jul 2026 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783675233;
 bh=7Mt5b8CO2zkO4CpEijDH+xhW9FEqVsw4hb1eOg0DNsw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jkL2VyR+uAJbph75uTUeMQMt1m3KPk3cXGbROe1/k5XZ5frVWVFYUrX5uyI8GKKjL
 JqqS9kDXvAqfzm+Ri+WE2+OOjZlrJbz/hJzrJeCv41uVQjVu5d8z9Sp2X1ULN84Q7J
 BEPWsDZhc7qflfeGHVs25baRQxVk7G07OOmPlr6eEz7fTq4BO3FHuiftcHSK5Dc5NK
 3Kob9K1uNIo/7c9s8ZWMSyJe38wCu80RlDinwRlgr8PwcuK8N49aGlY+cFwGo2lOvl
 CwK23sLm0CyASo0ZYey+UlnHuObnxIQtGOHJRG2ZkdoVIegsuQUJUS3eYBDaeMcg6J
 qChbTi1ZzZ25w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/etnaviv: Reference count struct
 etnaviv_file_private
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710-etnaviv-reset-notification-v2-1-90cfebcf22a2@igalia.com>
References: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
 <20260710-etnaviv-reset-notification-v2-1-90cfebcf22a2@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:20:32 +0000
Message-Id: <20260710092033.AEAB31F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unchecked return value of drm_sched_entity_init leads to NULL poin=
ter dereference on file close.
--

--- Patch [1]: [PATCH v2 1/2] drm/etnaviv: Reference count struct etnaviv_f=
ile_private ---
commit ac09092a81050d73fa591427824ad978bbce1e24
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Reference count struct etnaviv_file_private

This commit introduces reference counting for etnaviv_file_private to ensure
the context remains alive while the GPU reset path is still running. The
scheduler timeout worker now holds a reference, avoiding a race with closing
the DRM file.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1a..a27ed014fb4e7 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
[ ... ]
> @@ -70,6 +83,8 @@ static int etnaviv_open(struct drm_device *dev, struct =
drm_file *file)
>  	if (!ctx)
>  		return -ENOMEM;
> =20
> +	kref_init(&ctx->refcount);
> +
>  	ret =3D xa_alloc_cyclic(&priv->active_contexts, &ctx->id, ctx,
>  			      xa_limit_32b, &priv->next_context_id, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does etnaviv_open() need to check the
return value of drm_sched_entity_init()?

Looking at etnaviv_open() just below this block, the driver initializes a
scheduler entity for each valid GPU without checking for failure:

etnaviv_open() {
        ...
        drm_sched_entity_init(&ctx->sched_entity[i],
                              DRM_SCHED_PRIORITY_NORMAL, &sched,
                              1, NULL);
        ...
}

If drm_sched_entity_init() fails (e.g., due to memory exhaustion),
entity->stats remains NULL.=20

Later, etnaviv_postclose() unconditionally tears down all entities:

etnaviv_postclose() {
        ...
        if (gpu)
                drm_sched_entity_destroy(&ctx->sched_entity[i]);
        ...
}

This eventually invokes drm_sched_entity_fini() in
drivers/gpu/drm/scheduler/sched_entity.c, which calls:

        drm_sched_entity_stats_put(entity->stats);

Could this cause a NULL pointer dereference in kref_put() when it attempts
to operate on the NULL entity->stats pointer during file close?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-etnaviv-re=
set-notification-v2-0-90cfebcf22a2@igalia.com?part=3D1
