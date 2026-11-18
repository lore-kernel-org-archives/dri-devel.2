Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=A8TwVtAc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E364510E10F;
	Wed, 18 Nov 2026 12:00:54 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7192910E10F;
 Wed, 18 Nov 2026 12:00:48 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jV0Y94y1KzMlLF;
 Wed, 18 Nov 2026 13:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795003245; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OY+g+6QDPiw1W0rQAVEWer9awS0frRkWHlbCTJ+nNMs=;
 b=A8TwVtAchdEVBhuEDr2LNQibb3cr5j/i4Ws5KaM39ieGxK+UgdvC5fto2VcnVi2Mr8dusW
 aHGcvq05SWhQzhVXESbbnLrT65+n5WJVvokpy+8aOjKCdzF55uq5TyKcJQ8pXUgvjwjtM5
 0fzhZiOmxPHjgivXVEKWCoVNoRaiTCgf+rG3rLK6ZyyMNm917Ay1Je6sDkD1Qhp8VOXPa8
 l423IbtVUhKtLChC+vd8Sf8Vv+ORPaMTpUu/+LAf4n+nr7odFQ5JO/vELzrAAQ9a7obvRF
 MFuD3JknidoQxrvpTbZ8YNfE3nnSNy5Zy6YHKmBS/ZF75PWpjdiQly5pgFvTvg==
Message-ID: <be7d801d2affa69a758a6b825b4481073fc5354b.camel@mailbox.org>
Subject: Re: [PATCH 3/4] drm/sched: Remove the single scheduler special case
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, Simona Vetter	 <simona@ffwll.ch>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner	 <phasta@kernel.org>, "Cc:
 Tomeu Vizoso" <tomeu@tomeuvizoso.net>, Sidong Yang	 <sidong.yang@furiosa.ai>
Date: Wed, 18 Nov 2026 13:00:43 +0100
In-Reply-To: <20261117100654.8593-4-tvrtko.ursulin@igalia.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: cc949798cafa71dc15e
X-MBO-RS-META: mhua7xp8bftsguzxzfsa8jb75b8pjdd3
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Why do you call "single scheduler" a special case? That seems to be
quite a common case.

On Tue, 2026-11-17 at 10:06 +0000, Tvrtko Ursulin wrote:
> In order to untangle all this lets make this area behave consistently and
> store the single scheduler case directly in the entity. We can do that
> easily by creating an union between the current pointer to a list of
> schedulers, and a new pointer to the single scheduler.
>=20
> This allows removal of the special cases which artificially cleared
> entity->sched_list for a single scheduler case and fixes the amdgpu
> dynamic priority changes for the single IP instances.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: b3ac17667f11 ("drm/scheduler: rework entity creation")

Can you describe what the actual bug is?

> References: 8c23056bdc7a ("drm/scheduler: do not keep a copy of sched lis=
t")
> References: 977f7e1068be ("drm/amdgpu: allocate entities on demand")
> References: 2316a86bde49 ("drm/amdgpu: change hw sched list on ctx priori=
ty override")
> References: ac4eb83ab255 ("drm/sched: select new rq even if there is only=
 one v3")
> References: 981b04d96856 ("drm/sched: improve docs around drm_sched_entit=
y")
> References: 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to =
a single run queue")

This commit has been reverted.

Recently, I often end up a confused by your series'. Is this here
another RFC?

Is it a preparational patch for your CFS work?

> =C2=A0 *
> - * Note that the &sched_list must have at least one element to schedule =
the entity.
> + * Note that the &sched_list must have exactly one element to schedule t=
he
> + * entity. Callers which pass more than one scheduler on the @sched_list=
 must
> + * ensure the list remains valid for the lifetime of the entity.

What does that even mean, "valid"? Like, not deallocated?

How does drm_sched_entity_modify_sched() play into that?

> -	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_lis=
t);
> +	if (entity->num_sched_list =3D=3D 1)
> +		sched =3D entity->sched;
> +	else
> +		sched =3D drm_sched_pick_best(entity->sched_list,
> +					=C2=A0=C2=A0=C2=A0 entity->num_sched_list);

So what you want to achieve is that sched_list can never be NULL? How's
that a bug?

> -	struct drm_gpu_scheduler=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 **sc=
hed_list;
> +	union {
> +		/**
> +		 * @sched_list:
> +		 *
> +		 * A list of schedulers (struct drm_gpu_scheduler).=C2=A0 Jobs from
> +		 * this entity can be scheduled on any scheduler on this list.
> +		 *
> +		 * This can be modified by calling
> +		 * drm_sched_entity_modify_sched(). Locking is entirely up to
> +		 * the driver, see the above function for more details.
> +		 */
> +		struct drm_gpu_scheduler=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 **s=
ched_list;
> +
> +		/**
> +		 * @sched:
> +		 *
> +		 * A single struct drm_gpu_scheduler jobs from this entity will
> +		 * be scheduled on.
> +		 *
> +		 * This can be modified by calling
> +		 * drm_sched_entity_modify_sched(). Locking is entirely up to
> +		 * the driver, see the above function for more details.
> +		 */
> +		struct drm_gpu_scheduler=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *sc=
hed;
> +	};

So you now would have some mode where there is sometimes a list and
sometimes a pointer, and what it is can change dynamically through
drm_sched_entity_modify_sched()??

How would that untangle anything?


P.
