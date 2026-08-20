Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D054C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE29010E7A9;
	Thu, 20 Aug 2026 20:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KcWNWn6o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B4E10E3B5;
 Thu, 20 Aug 2026 20:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787256216; x=1818792216;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=LHCc224nGAOTHCPvyYHQPXYvbYwbaBBUIN+G8M5gyUg=;
 b=KcWNWn6oWJO+AUyzOZXyrqf8cZxfHgto6gLEkl3kQkKvoWPmK9jD0b3Q
 QW4EvpJLduUm7l+t13rQWMHyuRigJhte8aCpwfmOS+Q4iKkZ7uvMGy9G/
 +iNyUU/NIPaC6ehNrhIYsuhfgMJ8x0FGIolArWAHKvUOA1zgJKhBQ/eIo
 HJ+g+zWImsBQnZz5w+Qjba9yUfboT5flIhKVLYNT2Eenjjn075aZtV8tc
 Gww1C4pHgKohFy+pnlHv3TP2pAh1JIGfBhsH0AuSyzotN93x4rJaPtmSl
 MXOQJprCl9NyE5IdXYTgpIIn+m/rGQKEW/sH/vBB6uh9fjb4th8UHY0JH w==;
X-CSE-ConnectionGUID: lK/H05SpRDKMRtgiczS7KA==
X-CSE-MsgGUID: L70/mRbISr2J+KbinQRywg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="86751759"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="86751759"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 13:03:35 -0700
X-CSE-ConnectionGUID: ygiIvzfSQ8WdTOkYK4ghlg==
X-CSE-MsgGUID: xW0Lr8tlSpKXv0xNwTihug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269957186"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.82])
 ([10.245.245.82])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 13:03:32 -0700
Message-ID: <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt
 on non-TT resources
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Nathan Bourgeois <iridescentrosesfall@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Matthew
 Auld <matthew.auld@intel.com>, David Airlie	 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 22:03:30 +0200
In-Reply-To: <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 2026-08-20 at 14:56 -0400, Nathan Bourgeois wrote:
> Hi,
> Sorry, I replied only to Matt by mistake earlier and didn't realize
> it
> was text-only. Here's the same reply for the list:
>=20
> Hi Matt,
>=20
> Thank you so much for reviewing this!
>=20
> > Reading the commit which added ttm_bo_setup_export, to me this
> > looks
> > like a bug in ttm_bo_setup_export() or in general TTM.
>=20
> > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > GTT objects get populated on first validate, and VRAM doesn't
> > use TT.'
>=20
> > I'd probably move this fix into ttm_bo_setup_export() and post it
> > for
> > discussion.
>=20
> I agree that this is a much cleaner and smaller fix, I initially
> wanted to keep
> the change scoped only to xe where it was causing an observable
> issue,
> but I will move it into ttm_bo_setup_export() given your
> recommendation.
>=20
> > It may also be the case that the ttm_tt preallocated with
> > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to
> > VRAM, as
> > that dangling ttm_tt could cause other issues. I'll need to take a
> > closer look at that angle.
>=20
> Yes, considering that this is essentially the source of this
> particular behavior
> it stands to reason that there may be other latent correctness issues
> caused
> by the dangling ttm_tt.
>=20
> > This part looks good as different patch from what I'm assuming will
> > be a
> > TTM fix.
>=20
> Yes, I'll submit a patch with RFC for discussing the
> ttm_bo_setup_export()
> changes and a second patch for the unit test.
>=20
> Best Regards,
> Nathan Bourgeois
>=20
>=20
> On Thu, Aug 20, 2026 at 2:01=E2=80=AFPM Nathan Bourgeois
> <iridescentrosesfall@gmail.com> wrote:
> >=20
> > Hi,
> >=20
> > Sorry, I replied only to Matt by mistake earlier. Here's the same
> > reply for the list:
> >=20
> > Hi Matt, Thank you so much for reviewing this! > Reading the commit
> > which added ttm_bo_setup_export, to me this looks
> > > like a bug in ttm_bo_setup_export() or in general TTM.
> >=20
> > > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > > GTT objects get populated on first validate, and VRAM doesn't
> > > use TT.'
> >=20
> > > I'd probably move this fix into ttm_bo_setup_export() and post it
> > > for
> > > discussion.
> >=20
> > I agree that this is a much cleaner and smaller fix, I initially
> > wanted to keep
> > the change scoped only to xe where it was causing an observable
> > issue,
> > but I will move it into ttm_bo_setup_export() given your
> > recommendation.
> >=20
> > > It may also be the case that the ttm_tt preallocated with
> > > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to
> > > VRAM, as
> > > that dangling ttm_tt could cause other issues. I'll need to take
> > > a
> > > closer look at that angle.
> >=20
> > Yes, considering that this is essentially the source of this
> > particular behavior
> > it stands to reason that there may be other latent correctness
> > issues caused
> > by the dangling ttm_tt.
> >=20
> > > This part looks good as different patch from what I'm assuming
> > > will be a
> > > TTM fix.
> >=20
> > Yes, I'll submit a patch with RFC for discussing the
> > ttm_bo_setup_export()
> > changes and a second patch for the unit test.
> >=20
> > Best Regards,
> > Nathan Bourgeois

When I read the purpose of the original commit, I wonder if this is the
correct solution.

Regardless of whether the bo will eventually be attached as a VRAM
(p2p) dma-buf or a system dma-buf, we essentially want to charge
upfront.

Shouldn't we just be calling xe_bo_validate() here instead of
ttm_tt_populate? (With the correct xe_validation_guard() wrapping).

 If it's a system bo, ttm_tt_populate would eventually be called. If
it's a VRAM bo, we'd correctly charge dmemcg, and if the bo gets
migrated to system as part of attach, whatever cgroup controller will
be used for system memory will most likely charge the same cgroup that
got charged for the VRAM.

/Thomas

> >=20
> > On Thu, Aug 20, 2026 at 1:03=E2=80=AFPM Matthew Brost
> > <matthew.brost@intel.com> wrote:
> > >=20
> > > On Wed, Aug 19, 2026 at 11:19:01PM -0400, Nathan Bourgeois wrote:
> > >=20
> > > Thanks the patch.
> > >=20
> > > > When a buffer object (BO) has a created but unpopulated ttm_tt
> > > > and is
> > > > exported, the default behavior populates the ttm_tt, even if
> > > > the manager
> > > > does not require a TT. This unnecessary host-side population
> > > > reduces
> > > > host memory available to the user.
> > > >=20
> > > > This occurs when a BO is created with XE_BO_FLAG_DEFER_BACKING
> > > > and
> > > > migration places the BO into a resource whose manager does not
> > > > use the
> > > > TT backing. The retained ttm_tt is not authoritative for
> > > > storage, yet
> > > > the default ttm_bo_setup_export() treats the existence of the
> > > > ttm_tt as
> > > > requiring population.
> > > >=20
> > >=20
> > > Thanks for explaining this, I see the problem.
> > >=20
> > > > The issue was reproduced with vLLM 0.27.1 loading
> > > > 0xSer0/DeepSeek-V4-Flash-180B (d3c704b) on a system with 128 GB
> > > > of RAM
> > > > and six Intel Arc Pro B70 GPUs providing 192 GB of VRAM.
> > > > Loading the
> > > > weights (100.61 GB) triggered host-memory exhaustion and OOM
> > > > events on
> > > > the baseline kernel.
> > > >=20
> > > > On Ubuntu 24.04 with 7.0-12-generic, the vLLM service cgroup
> > > > grew by
> > > > 115.84 GB on the instrumented baseline and by 15.34 GB with
> > > > this change,
> > > > a reduction of 100.50 GB. Diagnostic instrumentation counting
> > > > cumulative
> > > > TT pages across all six GPUs recorded 109.22 GB on baseline and
> > > > 8.72 GB
> > > > with this change. The reduction is 0.11 GB less than the model
> > > > weight
> > > > size.
> > > >=20
> > > > The change creates an Xe-local export setup helper which skips
> > > > ttm_bo_populate() when the BO has a current resource manager
> > > > and if that
> > > > manager has use_tt =3D=3D false. If the manager does not use TT,
> > > > then
> > > > population is skipped, while an absent manager conservatively
> > > > calls
> > > > ttm_bo_populate(). Behavior for a manager which requires a TT
> > > > backing
> > > > remains unchanged. Keep this policy local to Xe so other TTM
> > > > drivers
> > > > retain their existing export behavior.
> > > >=20
> > >=20
> > > Reading the commit which added ttm_bo_setup_export, to me this
> > > looks
> > > like a bug in ttm_bo_setup_export() or in general TTM.
> > >=20
> > > git format-patch -1 50243079865ae
> > >=20
> > > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > > GTT objects get populated on first validate, and VRAM doesn't
> > > use TT.'
> > >=20
> > > I'd probably move this fix into ttm_bo_setup_export() and post it
> > > for
> > > discussion.
> > >=20
> > > It may also be the case that the ttm_tt preallocated with
> > > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to
> > > VRAM, as
> > > that dangling ttm_tt could cause other issues. I'll need to take
> > > a
> > > closer look at that angle.
> > >=20
> > > > The regression test creates both the control case and the VRAM
> > > > migration
> > > > case. The control case creates the deferred BO in system RAM
> > > > and leaves
> > > > it there, which requires a TT and population when
> > > > xe_gem_prime_export() is
> > > > called. The VRAM migration case creates the deferred BO in
> > > > system RAM
> > > > and then migrates it to VRAM, which does not require a TT and
> > > > thus, when
> > > > xe_gem_prime_export() is called, no population occurs.
> > > >=20
> > >=20
> > > This part looks good as different patch from what I'm assuming
> > > will be a
> > > TTM fix.
> > >=20
> > > Matt
> > >=20
> > > > Fixes: 91494dee1091 ("xe: populate buffers before exporting
> > > > them.")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: Codex:gpt-5.6-sol
> > > > Signed-off-by: Nathan Bourgeois <iridescentrosesfall@gmail.com>
> > > > ---
> > > > Newer Testing:
> > > > - Built and booted b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
> > > > plus this patch on EPYC 7352 with six Intel Arc Pro B70.
> > > > - KUnit xe_live_test: xe_dma_buf_kunit: pass:6 fail:0 skip:0
> > > > total:6 PASS
> > > > - vLLM 0.27.1 loading DeepSeek-V4-Flash-0731 (full model
> > > > compared to REAP) on six Intel Arc Pro B70 GPUs: No OOM error,
> > > > 17.82 GB delta.
> > > > =C2=A0drivers/gpu/drm/xe/tests/xe_dma_buf.c | 105
> > > > ++++++++++++++++++++++++++
> > > > =C2=A0drivers/gpu/drm/xe/xe_dma_buf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 28 ++++++-
> > > > =C2=A02 files changed, 132 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > index 0be8440b3976..bff803ab7a57 100644
> > > > --- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > +++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > @@ -260,12 +260,117 @@ static const struct dma_buf_test_params
> > > > test_params[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > > > =C2=A0};
> > > >=20
> > > > +static void xe_test_dmabuf_export_deferred(struct xe_device
> > > > *xe, u32 bo_flags,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u32 mem_type, bool
> > > > expect_populated)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_exec *exec =3D XE_VALIDATION_O=
PT_OUT;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kunit *test =3D kunit_get_current_=
test();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource_manager *man;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf *dmabuf;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct xe_bo *bo;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t size =3D PAGE_SIZE;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* No VRAM on device? */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!ttm_manager_type(&xe->ttm, mem_type)=
)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (mem_type =3D=3D XE_PL_VRAM0 &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe->info.vram_fla=
gs & XE_VRAM_FLAGS_NEED64K)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 size =3D SZ_64K;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DEFER_BACKING places the BO in SY=
STEM and creates a
> > > > ttm_tt which
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is unpopulated. In the case of VR=
AM, migrating leaves
> > > > the ttm_tt
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * retained and unpopulated while VR=
AM becomes the real
> > > > backing.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 bo =3D xe_bo_create_user(xe, NULL, size,
> > > > DRM_XE_GEM_CPU_CACHING_WC,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bo_flags |
> > > > XE_BO_FLAG_DEFER_BACKING, NULL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(bo)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_FAIL(test, "BO creation failed: %pe\n",
> > > > bo);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 err =3D xe_bo_lock(bo, false);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_FAIL(test, "BO lock failed: %d\n", err);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_put_bo;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (bo->ttm.resource->mem_type !=3D mem_t=
ype)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 err =3D xe_bo_migrate(bo, mem_type, NULL, exec);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_FAIL(test, "BO migration to %u failed:
> > > > %d\n", mem_type,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
r);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_unlock;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 man =3D ttm_manager_type(bo->ttm.bdev, bo=
->ttm.resource-
> > > > >mem_type);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!man || !bo->ttm.ttm) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_FAIL(test, "Expected a retained unpopulated
> > > > TT\n");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_unlock;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Precondition: ttm_tt starts unpopulate=
d after
> > > > migration */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, man->use_tt, expect=
_populated);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_FALSE(test, ttm_tt_is_popula=
ted(bo-
> > > > >ttm.ttm));
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xe_bo_unlock(bo);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 dmabuf =3D xe_gem_prime_export(&bo->ttm.b=
ase, 0);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(dmabuf)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_FAIL(test, "dma-buf export failed: %pe\n",
> > > > dmabuf);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_put_bo;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 err =3D xe_bo_lock(bo, false);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_FAIL(test, "post-export BO lock failed:
> > > > %d\n", err);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_put_dmabuf;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Postcondition: if VRAM, ttm_tt remains=
 unpopulated, if
> > > > SYSTEM ttm_tt is populated */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, bo->ttm.resource->m=
em_type,
> > > > mem_type);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_NOT_NULL(test, bo->ttm.ttm);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (bo->ttm.ttm)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KUNIT_EXPECT_EQ(test, ttm_tt_is_populated(bo-
> > > > >ttm.ttm),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 expect_populated);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xe_bo_unlock(bo);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 dma_buf_put(dmabuf);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 drm_gem_object_put(&bo->ttm.base);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > +
> > > > +out_unlock:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xe_bo_unlock(bo);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 goto out_put_bo;
> > > > +out_put_dmabuf:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 dma_buf_put(dmabuf);
> > > > +out_put_bo:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 drm_gem_object_put(&bo->ttm.base);
> > > > +}
> > > > +
> > > > =C2=A0static int dma_buf_run_device(struct xe_device *xe)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dma_buf_test_params *pa=
rams;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kunit *test =3D kunit_get_cur=
rent_test();
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(xe_pm_runtime)(xe);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A retained TT must not be populat=
ed when VRAM is the
> > > > backing
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * resource.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xe_test_dmabuf_export_deferred(xe, XE_BO_=
FLAG_VRAM0,
> > > > XE_PL_VRAM0,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false=
);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Control case: deferred SYSTEM bac=
king must still be
> > > > populated
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before export.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xe_test_dmabuf_export_deferred(xe, XE_BO_=
FLAG_SYSTEM,
> > > > XE_PL_SYSTEM,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true)=
;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (params =3D test_params; params-=
>mem_mask; ++params) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct dma_buf_test_params p =3D *params;
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > index bf0728838ead..0c4e4e2e1a81 100644
> > > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > @@ -219,6 +219,32 @@ static const struct dma_buf_ops
> > > > xe_dmabuf_ops =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vunmap =3D drm_gem_dmabuf_vunmap,
> > > > =C2=A0};
> > > >=20
> > > > +static int xe_dma_bo_setup_export(struct ttm_buffer_object
> > > > *tbo,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_operation_ctx *ctx)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource_manager *man =3D NULL=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ttm_bo_reserve(tbo, false, false,=
 NULL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (tbo->resource)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 man =3D ttm_manager_type(tbo->bdev, tbo->resource-
> > > > >mem_type);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Do not populate BO-sized system p=
ages when backed by a
> > > > non-TT resource.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is Xe-specific; the generic =
ttm_bo_setup_export()
> > > > always populates.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (man && !man->use_tt)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D ttm_bo_populate(tbo, ctx);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_unreserve(tbo);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > +}
> > > > +
> > > > =C2=A0struct dma_buf *xe_gem_prime_export(struct drm_gem_object
> > > > *obj, int flags)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xe_bo *bo =3D gem_to_xe_bo(ob=
j);
> > > > @@ -257,7 +283,7 @@ struct dma_buf *xe_gem_prime_export(struct
> > > > drm_gem_object *obj, int flags)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_bo_willneed_get_locked(bo);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_bo_unlock(bo);
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ttm_bo_setup_export(&bo->ttm, &ct=
x);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D xe_dma_bo_setup_export(&bo->ttm, =
&ctx);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto out_put;
> > > >=20
> > > >=20
> > > > base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
> > > > --
> > > > 2.55.0
> > > >=20
