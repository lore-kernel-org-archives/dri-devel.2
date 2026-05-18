Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFBFCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FDA10E8CD;
	Mon, 18 May 2026 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kCvTcmWi";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E424D10E8CD;
 Mon, 18 May 2026 15:01:56 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gK1H50xWcz9v50;
 Mon, 18 May 2026 17:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1779116513; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDUFG3QH/zn6Pfjyji/Qqlp3OYsc/LM+HLI24lCrrXk=;
 b=kCvTcmWitl6r0wU+738S/qKBalalles5Mi9GzjMrsXjFkg8DvZXF0Af0391ujRu3ciuhV4
 6a+4JpyMUE1A2GNSC80Hzfu6K38OgWH51vjshjCehnSXDB8XqPusFyi9a4azpx1au6Wuw8
 H+ssFYU/GA9cU0ggK6RpFQGq9vKhvD7iXjq0WnyTRkAolSpt6SqvwAt/2rPTNkOrqIneWL
 ps599r2wMW8FpwzKnlhw4fJUQVbKjLX8uIw1dNFfdVUSxBfKdd7vdbsStlPC5gag+SH6SZ
 sL4isC6las8iOF5BOx7Hib17nw5KI/sp1EA9v2YH5O0rNvimj4D/kb/8RqNlTg==
Message-ID: <81783d0807a5ffac93f61eddba0d2f595d7f239f.camel@mailbox.org>
Subject: Re: [PATCH v3 06/11] drm: Use trace_call__##name() at guarded
 tracepoint call sites
From: Philipp Stanner <phasta@mailbox.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>
Date: Mon, 18 May 2026 17:01:42 +0200
In-Reply-To: <20260515135932.2238842-1-vineeth@bitbyteword.org>
References: <20260515135932.2238842-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 1678094390674a1865d
X-MBO-RS-META: pqim3bixj3ebt8cs9fmnjx4xowyx5n3y
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

On Fri, 2026-05-15 at 09:59 -0400, Vineeth Pillai (Google) wrote:
> From: Vineeth Pillai <vineeth@bitbyteword.org>
>=20
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.

The "foo" terminology is unusual I think? I always wrote it with regex,
like "trace_*()".



>=20
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth=
@bitbyteword.org/

I'd put this in a Link: tag section below.

>=20
> Parts of the original v2 series have already been merged in mainline.
> This patch is being reposted as a follow-up cleanup for the remaining
> unmerged pieces.

So this v3 series as a whole is a followup to that v2?

>=20
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> =C2=A04 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index b24d5d21be5f..cb0b5cb07d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1004,7 +1004,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_pa=
rser *p)
> =C2=A0		struct amdgpu_job *job =3D p->jobs[i];
> =C2=A0
> =C2=A0		for (j =3D 0; j < job->num_ibs; ++j)
> -			trace_amdgpu_cs(p, job, &job->ibs[j]);
> +			trace_call__amdgpu_cs(p, job, &job->ibs[j]);
> =C2=A0	}
> =C2=A0}
> =C2=A0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 9ba9de16a27a..a36ae94c425f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1415,7 +1415,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,=
 struct amdgpu_bo_va *bo_va,
> =C2=A0
> =C2=A0	if (trace_amdgpu_vm_bo_mapping_enabled()) {
> =C2=A0		list_for_each_entry(mapping, &bo_va->valids, list)
> -			trace_amdgpu_vm_bo_mapping(mapping);
> +			trace_call__amdgpu_vm_bo_mapping(mapping);
> =C2=A0	}
> =C2=A0
> =C2=A0error_free:
> @@ -2183,7 +2183,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, st=
ruct ww_acquire_ctx *ticket)
> =C2=A0				continue;
> =C2=A0		}
> =C2=A0
> -		trace_amdgpu_vm_bo_cs(mapping);
> +		trace_call__amdgpu_vm_bo_cs(mapping);
> =C2=A0	}
> =C2=A0}
> =C2=A0
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5fc5d5608506..fbdc12cdd6bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5263,11 +5263,11 @@ static void amdgpu_dm_backlight_set_level(struct =
amdgpu_display_manager *dm,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (trace_amdgpu_dm_brightness_enabled()) {
> -		trace_amdgpu_dm_brightness(__builtin_return_address(0),
> -					=C2=A0=C2=A0 user_brightness,
> -					=C2=A0=C2=A0 brightness,
> -					=C2=A0=C2=A0 caps->aux_support,
> -					=C2=A0=C2=A0 power_supply_is_system_supplied() > 0);
> +		trace_call__amdgpu_dm_brightness(__builtin_return_address(0),
> +						 user_brightness,
> +						 brightness,
> +						 caps->aux_support,
> +						 power_supply_is_system_supplied() > 0);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (caps->aux_support) {
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index fe174a4857be..185a2636b599 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -429,7 +429,8 @@ static bool drm_sched_entity_add_dependency_cb(struct=
 drm_sched_entity *entity,
> =C2=A0
> =C2=A0	if (trace_drm_sched_job_unschedulable_enabled() &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity-=
>dependency->flags))
> -		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
> +		trace_call__drm_sched_job_unschedulable(sched_job,
> +							entity->dependency);

I would be more happy if you sacrifice a bit of space here and keep it
a single line since the if condition is already quite convoluted and
challenging to read.


P.

> =C2=A0
> =C2=A0	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
> =C2=A0				=C2=A0=C2=A0=C2=A0 drm_sched_entity_wakeup))
> @@ -586,7 +587,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *=
sched_job)
> =C2=A0		unsigned long index;
> =C2=A0
> =C2=A0		xa_for_each(&sched_job->dependencies, index, entry)
> -			trace_drm_sched_job_add_dep(sched_job, entry);
> +			trace_call__drm_sched_job_add_dep(sched_job, entry);
> =C2=A0	}
> =C2=A0	atomic_inc(entity->rq->sched->score);
> =C2=A0	WRITE_ONCE(entity->last_user, current->group_leader);

