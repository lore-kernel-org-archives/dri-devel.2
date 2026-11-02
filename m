Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D3606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qw0D/m8I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F6B10ECA4;
	Mon,  2 Nov 2026 10:42:54 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D2210ECA4;
 Mon,  2 Nov 2026 10:42:49 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jJ7ZZ1Yg5zMlhg;
 Mon, 02 Nov 2026 11:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793616166; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jObuHRsCSR9IFpZLb/aXXTzGpA/BD+w9fEoP98E8Ox0=;
 b=qw0D/m8Imytu8ZsgVsa+ETNeTdvMDlbM3R4/4L3q80Whi+kdxmJtsdEITuvILnSrWGWYb5
 D8TSTvx8OiPK9fJ+rLrSCKvwEIGsqve5mjLEB7BglGw5TdCtLdlJcfsHhJ3uxPW1vo73Sw
 XIn/5cG2F6QpxkcPyZ+pV+k2vOqSPsXGsetddGJ13z0W8SO9kpyTKmzEO0jRWlvfjkNRMC
 sdJz3seKpWrRpD9w/q9nA3a7cbjGrTqrrTJmWgq/5tpSUNJkfYnAImxmU/HOdvbe2dxf4q
 BXcVC5I9aYQgfyiTdftNOxVAkYRR/99qGHj1hyOCC0t16VsEfhKZGyhKXIlb0g==
Message-ID: <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>, 	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 11:42:42 +0100
In-Reply-To: <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 96b871bb8528972feba
X-MBO-RS-META: 6ic51pac587qqeu37c4brbfhyxpg39nf
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
> Another consequence of the recent revert of
> 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run=
 queue")
> is that after the revert we need to adjust entity->rq_priority when
> runtime priority changes are requested.
>=20
> Only amdgpu does that so the impact is minimal.
>  Also considering dynamic
> priority changes are largely broken there, due currently broken entity
> scheduler list handling where the special case of a single scheduler can
> never change it's run-queue. And coupled with the fact for the rest a two=
-
> tier approach of drm_sched_entity_set_priority() and
> drm_sched_entity_modify_sched() is used, where later directly maps to
> different hardware queue priority by replacing the set of schedulers
> completely.
>=20
> Hence the regression is limited to rings which have multiple instances
> other than compute and graphics, which would be SDMA only, for which I am
> not sure any userspace actually does dynamic priority changes in the firs=
t
> place.

I can't fully grasp what the bug actually is. So is it that we forgot
to adjust the priority in the CFS series, or is it that the partial
revert made this necessary?

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: <stable@vger.kernel.org> # v7.2+
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index e12709b7bd0c..03e68b4102d5 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -456,6 +456,8 @@ void drm_sched_entity_set_priority(struct drm_sched_e=
ntity *entity,
> =C2=A0{
> =C2=A0	spin_lock(&entity->lock);
> =C2=A0	entity->priority =3D priority;
> +	if (drm_sched_policy !=3D DRM_SCHED_POLICY_FAIR)
> +		entity->rq_priority =3D priority;
> =C2=A0	spin_unlock(&entity->lock);

So is there always a bug, or only for FAIR?


> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_set_priority);
