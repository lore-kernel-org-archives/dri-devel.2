Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6457C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D659A10E0D5;
	Wed, 12 Aug 2026 06:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kEn9UvL1";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4613710E0D5;
 Wed, 12 Aug 2026 06:51:07 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hKfJp5HJTz8tyn;
 Wed, 12 Aug 2026 08:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1786517464; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqUcPPYLa1DMjRbDFm2x6DWrts41qlTCDa5xchY2uwY=;
 b=kEn9UvL1OKBs9R/ssaKhB2y4M4kcq1Yy/myJoLAMJG4isVQmJ91bJ2ocWKJAeOSe+34jJ5
 W1bNw1gHtfUsvVLlSKTa6WhqC5lsdX60ZTH9w6+inbKtE0RiUdBOJ+z0jhOUDjZAkgkNhc
 gI0/7gYVoXUhmFXE2HsuiGtTSJsz9phe9Sk0jiiCbyUzrfy+MpXxp37/7QFvO5WVH+Y5C+
 CNHQ2LJ+s4K7UWPgTCHorRQDF8WcF6L4GBjpfDLbWlPnhANYWfJn7WIx0ZbfiEJrj3+gGm
 D37oQmvMZP67vSmlUErpcX2wiV+8IXU5+cEwX1Tw7EppVCD6lhxyKdrLYY77YQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of phasta@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=phasta@mailbox.org
Message-ID: <7df541d56edc935326eed7cad14dd80a0aba61de.camel@mailbox.org>
Subject: Re: [PATCH v3 00/19] Revert switching default DRM scheduler policy
 to fair
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Matthew Brost	
 <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, Philipp
 Stanner	 <phasta@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>
Date: Wed, 12 Aug 2026 08:50:23 +0200
In-Reply-To: <20260811163139.99746-1-tvrtko.ursulin@igalia.com>
References: <20260811163139.99746-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: f7fwy1ocy3myd71b5jupwiruzk4x1f5a
X-MBO-RS-ID: 0f406911fbffb3a7ece
X-Rspamd-Queue-Id: 4hKfJp5HJTz8tyn
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

On Tue, 2026-08-11 at 17:31 +0100, Tvrtko Ursulin wrote:
> There was a late minute user regression report[1] so lets revert this so =
it can
> be debugged in peace.
>=20
> I have not been able to locally reproduce it yet, but at least a partial =
fix
> looks to be this[2]. Further debug will be needed, possibly after the hol=
iday/
> vacation season is over.
>=20
> [1] https://lore.kernel.org/dri-devel/TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Ei=
hzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=3D=
@proton.me/
> [2] https://lore.kernel.org/dri-devel/20260811134223.96203-1-tvrtko.ursul=
in@igalia.com/
>=20
> Cc: Luke.Wildhardt@proton.me
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>=20
> v2:
> =C2=A0* Forgot the SoBs.
>=20
> v3:
> =C2=A0* Rebased for drm-misc-fixes.

Why is one patch now missing? Used to be 20.

And it would seem you forgot the Acked-bys.


P.

>=20
> Tvrtko Ursulin (19):
> =C2=A0 Revert "drm/sched: Remove drm_sched_init_args->num_rqs"
> =C2=A0 Revert "drm/xe: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/v3d: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/sched: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/panthor: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/panfrost: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/nouveau: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/msm: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/lima: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/imagination: Remove drm_sched_init_args->num_rqs usage=
"
> =C2=A0 Revert "drm/etnaviv: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/amdgpu: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "accel/ethosu: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "accel/rocket: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "accel/amdxdna: Remove drm_sched_init_args->num_rqs usage"
> =C2=A0 Revert "drm/sched: Embed run queue singleton into the scheduler"
> =C2=A0 Revert "drm/sched: Remove FIFO and RR and simplify to a single run
> =C2=A0=C2=A0=C2=A0 queue"
> =C2=A0 Revert "drm/sched: Switch default policy to fair"
> =C2=A0 drm/sched: Mark fair policy as experimental
>=20
> =C2=A0drivers/accel/amdxdna/aie2_ctx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/accel/ethosu/ethosu_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/accel/rocket/rocket_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 27 ++--
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0drivers/gpu/drm/etnaviv/etnaviv_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/imagination/pvr_queue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/lima/lima_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/msm/msm_gem_vma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/msm/msm_ringbuffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/panfrost/panfrost_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/panthor/panthor_mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/panthor/panthor_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 52 ++++++--
> =C2=A0drivers/gpu/drm/scheduler/sched_fence.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/scheduler/sched_internal.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 15 ++-
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 121 +++++++++++++++---
> =C2=A0drivers/gpu/drm/scheduler/sched_rq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 87 +++++++++----
> =C2=A0.../gpu/drm/scheduler/tests/mock_scheduler.c=C2=A0 |=C2=A0=C2=A0 1 =
+
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/xe/xe_dep_scheduler.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/xe/xe_execlist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/xe/xe_gpu_scheduler.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 42 +++++-
> =C2=A030 files changed, 304 insertions(+), 95 deletions(-)
