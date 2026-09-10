Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC290C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1397410F35B;
	Thu, 10 Sep 2026 08:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DlFpcmCi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2341F10F35B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:08:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4941A600CB
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C603E1F000FF;
 Thu, 10 Sep 2026 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789027735;
 bh=d9NzW/E5M8u1n5uDLObm8woKJZgfVdSVM5sbmzC96eo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DlFpcmCiusLrYjFy6C5l5LEzXfRX8PF4tgVRquUD45EchZ50Y4Euy9feWrxfWAPlH
 zLyPPOVoOfYdQaWgCW3fRlOJHZV20KqdT/drRi4uPklqhrc7IcW5G4k/IPi7OhJ/7O
 noSD6SBHzxXkN8dVN0ZawPMrHneQQW422iH9Dg+swIj8m8FRdsslRFI2ePI+x4Y4q/
 dHDENk9yQJ0WcuBB8taymbL70uh4isvT+M2IDluMBL87Y5u34X4qFWZM6xjLpQrsjI
 utmPMPVLIgjy/xOkaWCJdKiQdhcdEtG7XTVBRk/UfkMvOBN8iQAHxtLhFxWpodSSSB
 ex7a/QV/8HVCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/sched: Lock drm_sched_rq_pop_entity()
 externally
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910075942.2000338-3-phasta@kernel.org>
References: <20260910075942.2000338-2-phasta@kernel.org>
 <20260910075942.2000338-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 08:08:54 +0000
Message-Id: <20260910080854.C603E1F000FF@smtp.kernel.org>
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
- [High] Pre-existing NULL pointer dereference in `drm_sched_job_arm()` if =
all schedulers in the entity's list are not ready.
--

commit 7804887bbadf221d2ccaad830fc83a57f0e74d93
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Lock drm_sched_rq_pop_entity() externally

As a preparational step for protecting entity->last_scheduled with a
spinlock, this commit modifies drm_sched_entity_pop_job() to lock
drm_sched_rq_pop_entity() externally.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index bf97508a45b9a..274d7a7022987 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -565,7 +565,9 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct=
 drm_sched_entity *entity)
> =20
>  	spsc_queue_pop(&entity->job_queue);
> =20
> +	spin_lock(&entity->lock);
>  	drm_sched_rq_pop_entity(entity);
> +	spin_unlock(&entity->lock);

[Severity: High]
This isn't a bug introduced by this patch, but this series leaves a
pre-existing NULL pointer dereference unresolved in the entity runqueue
selection path.

If all schedulers in the entity's list have sched->ready =3D=3D false (e.g.,
during a GPU hang or reset, as documented in the drm_sched_job_init
comments), drm_sched_pick_best() returns NULL. This causes
drm_sched_entity_select_rq() to assign NULL to entity->rq:

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_select_rq() {
    ...
    sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_lis=
t);
    rq =3D sched ? sched->sched_rq[entity->rq_priority] : NULL;
    if (rq !=3D entity->rq) {
        drm_sched_rq_remove_entity(entity->rq, entity);
        entity->rq =3D rq;
    }
    ...
}

Upon returning to drm_sched_job_arm(), the code unconditionally dereferences
the NULL entity->rq:

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_job_arm() {
    ...
    drm_sched_entity_select_rq(entity);
    sched =3D entity->rq->sched;
    ...
}

Can this lead to a kernel panic (NULL pointer dereference) if userspace
continues to submit jobs via ioctl after a hardware fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910075942.2000=
338-2-phasta@kernel.org?part=3D1
