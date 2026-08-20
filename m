Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AE4C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A79C10F1C9;
	Thu, 20 Aug 2026 22:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n950560h";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6CC10F165
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:57:05 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso482280a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787252224; cv=none;
 d=google.com; s=arc-20260327;
 b=i3hMdwy/od3tBs9bO6FK4wsaQFeU9ur7JDqh6UYHzceezFb6vfiRTKnt4FpfTh4OJw
 ZScs71lRNXD3zEB0jDPEpQzxGhXyrU9jB42CpDI6ql75VHuE8PquXMOuIcDmAyPxzv2v
 zv16peWNwQyhNs3Dp0DltqO6LbjY1dFIXpd9kjKdNNe648e2dsusTRCwHu0aNEisc5+k
 8lenMHxEkS0pODtOG6TeZZOqC8VAtWXaJ9K0+tQMl7ZjN6/NC0CBFFnQxza+b0eQF1Wf
 l87+IlbvVjcWa8mUsCjM/uoNwsUGeVzoTk3q3GpX955xktZxtW9msgLrJlxJtTGUky8R
 1rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=28nTqNIXpFZIlYV3zkCCU4nW4w23pcpXcVdHEcaI6bo=;
 fh=ceI6mqVZL9D1BBCclJYEipNH8SYfoA019Cf81x7ckpU=;
 b=bi5OKhe/H36qLe9N6Tq6RSNtct9MmSGj1v0wRgU2IcNHms7+bvUtA3ALKyzA0n5Xuu
 PQGUNxHB5iDxRhXtl/lm/6pgPdmVUst5mB5yV5caU8HlY0fDjCvfLS8eU5q/C2i8JbqD
 sCp1EYiGG0lFusAPGF0ovcsDil26i2v1sqUCupL6XbHi1gef2mBpQ6UhCO3oWIpVubn+
 HV2xjqIWP/0gU3TjPv0DHupQ44eJqBIqxKCQ+VDi2NL0kOmq+OcQg6BemFbhvz/PqAhx
 k5cL3CWcpBGqQ0uPh2+98QhfkSKcPs4/sw8u/zWZ8TD7Fi94/+TrHWQ6lVYg4NK5ckUK
 B6ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787252224; x=1787857024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=28nTqNIXpFZIlYV3zkCCU4nW4w23pcpXcVdHEcaI6bo=;
 b=n950560hbYNB3vAiVTJ9IfULF9CluQ5RqT32unbzsRDUKjS+adVijcae06wb1Tb75c
 Lwlix/p+R5992bYeM0S0t/2f2MIFjvWy57RZP9MeZFXvmSapilnrzdrHmguIYksprPbn
 t6uIL7qZA1owlVxMOhNYjpwoe+PkoG5V69FqN06OuSpcTlLrc0FRi2XPMXsuQi9qhEk5
 xwLx2M+CCGtDgSjW8/S1hwWefVIBJGhPhPLH4P5EamYGjScLSy31oZK/cYJocfZeo8Ji
 A0cCDLbTV4GXL0sxAdSX4Rk+RythgMmWwNNCmZISGJVaod5RDxuCem+F1RkzBkrqpm/z
 MnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252224; x=1787857024;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=28nTqNIXpFZIlYV3zkCCU4nW4w23pcpXcVdHEcaI6bo=;
 b=PEbSkSfOvfB0e1zxLDQJ6e55fMler6rLj7fZyhVIk+9BnStHMbsbZLFZ7SFXSNM9A6
 m8TWesnK7JhLHyNZL9ZWeTM1Y+2vGFa+hNQSX32KQS8w+3eLlVNneO7nyPBz8rS9wZWB
 w65626qhgpNrNAmKgimppdXvrUzjrHW1wU8na2jn0d4lrbJZ8VC3uU/uMurS5d5soY0C
 40Mw6nUPHzUIIGlhHQjHCL8Jhsgm8DuMGCAE5EEB3Q+jnG0FSKE6mDQkvhP+8018IAX8
 NNwr/CGGQD9cyo1oIDdekm1Srxmh0oQGW1MiTLAa18LowUVA0sVuqgTSjd1gqu9C9G3x
 ywNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpoFvEOtFrmQmOD+X8vqmHhGyjronl8PpQQewEMtuvjVG5kWY1ZC1rcUoYvE3S+eWbc0j6b1fZ9zo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBfU/rvFrVIjO1oC4ipjhNub+MYH7f/2AFJvgKHiT9ffo3i8JB
 +3H3cGwhDtBanobIITpytck808Hs/2xY+RKHxwfkO1UTk2XEdPxn/pDxMs0lFNvbuwv4EhP0j6u
 Bmr13kNWLRlsCYBSZ46em8PYVP3kxnVU=
X-Gm-Gg: AR+sD11CXecvlyEltn05iPF2CcIoYlEcbctiic+h5zDwFH1TAXXg6IQdklg7zq9OTLP
 oWsfNH1dkUnpgg76ulH/4yTfDllYJl01yXhvM1fBVWMyHRkIZwpfxUN/pas4RnlW4YrOtKaPeA8
 i0Yo0Fv3Cm3akIoTjITQ0MuYbulasEL2Uy4XDP1vVI8aY1+UpI/m3EFOGdgt8vnK9zpXEFkTUhQ
 rn+yn5McswwlizlnZigrt20HswErav8rVFDZX99Pfqwnv67+L4vJIec1aYAtgGn3uKLxzLOli3/
 +E4NveeWoDwQ84nFEC0GaQUFzSYzxKnKo2Q1nN2TKihVO03s1YVF3dsARWF3plOAM0MqylZJvC/
 Je5+PsQg8h8WcF1jJDp0dGu6U3tf4+yeFl4kxtqW6qWFe
X-Received: by 2002:a17:907:7241:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c246a4ac5ebmr40748266b.1.1787252223895; Thu, 20 Aug 2026
 11:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
In-Reply-To: <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
From: Nathan Bourgeois <iridescentrosesfall@gmail.com>
Date: Thu, 20 Aug 2026 14:56:52 -0400
X-Gm-Features: AcwNN1VFZVoBAP2FCtCz66XiuMlgDrXl0LKdENv4zVBal7urDS7LMc0qfIITFeM
Message-ID: <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

Hi,
Sorry, I replied only to Matt by mistake earlier and didn't realize it
was text-only. Here's the same reply for the list:

Hi Matt,

Thank you so much for reviewing this!

> Reading the commit which added ttm_bo_setup_export, to me this looks
> like a bug in ttm_bo_setup_export() or in general TTM.

> 'This only applies currently to TTM_PL_SYSTEM objects, because
> GTT objects get populated on first validate, and VRAM doesn't
> use TT.'

> I'd probably move this fix into ttm_bo_setup_export() and post it for
> discussion.

I agree that this is a much cleaner and smaller fix, I initially wanted to =
keep
the change scoped only to xe where it was causing an observable issue,
but I will move it into ttm_bo_setup_export() given your recommendation.

> It may also be the case that the ttm_tt preallocated with
> XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to VRAM, as
> that dangling ttm_tt could cause other issues. I'll need to take a
> closer look at that angle.

Yes, considering that this is essentially the source of this particular beh=
avior
it stands to reason that there may be other latent correctness issues cause=
d
by the dangling ttm_tt.

> This part looks good as different patch from what I'm assuming will be a
> TTM fix.

Yes, I'll submit a patch with RFC for discussing the ttm_bo_setup_export()
changes and a second patch for the unit test.

Best Regards,
Nathan Bourgeois


On Thu, Aug 20, 2026 at 2:01=E2=80=AFPM Nathan Bourgeois
<iridescentrosesfall@gmail.com> wrote:
>
> Hi,
>
> Sorry, I replied only to Matt by mistake earlier. Here's the same reply f=
or the list:
>
> Hi Matt, Thank you so much for reviewing this! > Reading the commit which=
 added ttm_bo_setup_export, to me this looks
> > like a bug in ttm_bo_setup_export() or in general TTM.
>
> > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > GTT objects get populated on first validate, and VRAM doesn't
> > use TT.'
>
> > I'd probably move this fix into ttm_bo_setup_export() and post it for
> > discussion.
>
> I agree that this is a much cleaner and smaller fix, I initially wanted t=
o keep
> the change scoped only to xe where it was causing an observable issue,
> but I will move it into ttm_bo_setup_export() given your recommendation.
>
> > It may also be the case that the ttm_tt preallocated with
> > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to VRAM, a=
s
> > that dangling ttm_tt could cause other issues. I'll need to take a
> > closer look at that angle.
>
> Yes, considering that this is essentially the source of this particular b=
ehavior
> it stands to reason that there may be other latent correctness issues cau=
sed
> by the dangling ttm_tt.
>
> > This part looks good as different patch from what I'm assuming will be =
a
> > TTM fix.
>
> Yes, I'll submit a patch with RFC for discussing the ttm_bo_setup_export(=
)
> changes and a second patch for the unit test.
>
> Best Regards,
> Nathan Bourgeois
>
> On Thu, Aug 20, 2026 at 1:03=E2=80=AFPM Matthew Brost <matthew.brost@inte=
l.com> wrote:
>>
>> On Wed, Aug 19, 2026 at 11:19:01PM -0400, Nathan Bourgeois wrote:
>>
>> Thanks the patch.
>>
>> > When a buffer object (BO) has a created but unpopulated ttm_tt and is
>> > exported, the default behavior populates the ttm_tt, even if the manag=
er
>> > does not require a TT. This unnecessary host-side population reduces
>> > host memory available to the user.
>> >
>> > This occurs when a BO is created with XE_BO_FLAG_DEFER_BACKING and
>> > migration places the BO into a resource whose manager does not use the
>> > TT backing. The retained ttm_tt is not authoritative for storage, yet
>> > the default ttm_bo_setup_export() treats the existence of the ttm_tt a=
s
>> > requiring population.
>> >
>>
>> Thanks for explaining this, I see the problem.
>>
>> > The issue was reproduced with vLLM 0.27.1 loading
>> > 0xSer0/DeepSeek-V4-Flash-180B (d3c704b) on a system with 128 GB of RAM
>> > and six Intel Arc Pro B70 GPUs providing 192 GB of VRAM. Loading the
>> > weights (100.61 GB) triggered host-memory exhaustion and OOM events on
>> > the baseline kernel.
>> >
>> > On Ubuntu 24.04 with 7.0-12-generic, the vLLM service cgroup grew by
>> > 115.84 GB on the instrumented baseline and by 15.34 GB with this chang=
e,
>> > a reduction of 100.50 GB. Diagnostic instrumentation counting cumulati=
ve
>> > TT pages across all six GPUs recorded 109.22 GB on baseline and 8.72 G=
B
>> > with this change. The reduction is 0.11 GB less than the model weight
>> > size.
>> >
>> > The change creates an Xe-local export setup helper which skips
>> > ttm_bo_populate() when the BO has a current resource manager and if th=
at
>> > manager has use_tt =3D=3D false. If the manager does not use TT, then
>> > population is skipped, while an absent manager conservatively calls
>> > ttm_bo_populate(). Behavior for a manager which requires a TT backing
>> > remains unchanged. Keep this policy local to Xe so other TTM drivers
>> > retain their existing export behavior.
>> >
>>
>> Reading the commit which added ttm_bo_setup_export, to me this looks
>> like a bug in ttm_bo_setup_export() or in general TTM.
>>
>> git format-patch -1 50243079865ae
>>
>> 'This only applies currently to TTM_PL_SYSTEM objects, because
>> GTT objects get populated on first validate, and VRAM doesn't
>> use TT.'
>>
>> I'd probably move this fix into ttm_bo_setup_export() and post it for
>> discussion.
>>
>> It may also be the case that the ttm_tt preallocated with
>> XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to VRAM, as
>> that dangling ttm_tt could cause other issues. I'll need to take a
>> closer look at that angle.
>>
>> > The regression test creates both the control case and the VRAM migrati=
on
>> > case. The control case creates the deferred BO in system RAM and leave=
s
>> > it there, which requires a TT and population when xe_gem_prime_export(=
) is
>> > called. The VRAM migration case creates the deferred BO in system RAM
>> > and then migrates it to VRAM, which does not require a TT and thus, wh=
en
>> > xe_gem_prime_export() is called, no population occurs.
>> >
>>
>> This part looks good as different patch from what I'm assuming will be a
>> TTM fix.
>>
>> Matt
>>
>> > Fixes: 91494dee1091 ("xe: populate buffers before exporting them.")
>> > Cc: stable@vger.kernel.org
>> > Assisted-by: Codex:gpt-5.6-sol
>> > Signed-off-by: Nathan Bourgeois <iridescentrosesfall@gmail.com>
>> > ---
>> > Newer Testing:
>> > - Built and booted b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6 plus this =
patch on EPYC 7352 with six Intel Arc Pro B70.
>> > - KUnit xe_live_test: xe_dma_buf_kunit: pass:6 fail:0 skip:0 total:6 P=
ASS
>> > - vLLM 0.27.1 loading DeepSeek-V4-Flash-0731 (full model compared to R=
EAP) on six Intel Arc Pro B70 GPUs: No OOM error, 17.82 GB delta.
>> >  drivers/gpu/drm/xe/tests/xe_dma_buf.c | 105 +++++++++++++++++++++++++=
+
>> >  drivers/gpu/drm/xe/xe_dma_buf.c       |  28 ++++++-
>> >  2 files changed, 132 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/x=
e/tests/xe_dma_buf.c
>> > index 0be8440b3976..bff803ab7a57 100644
>> > --- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
>> > +++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
>> > @@ -260,12 +260,117 @@ static const struct dma_buf_test_params test_pa=
rams[] =3D {
>> >       {}
>> >  };
>> >
>> > +static void xe_test_dmabuf_export_deferred(struct xe_device *xe, u32 =
bo_flags,
>> > +                                        u32 mem_type, bool expect_pop=
ulated)
>> > +{
>> > +     struct drm_exec *exec =3D XE_VALIDATION_OPT_OUT;
>> > +     struct kunit *test =3D kunit_get_current_test();
>> > +     struct ttm_resource_manager *man;
>> > +     struct dma_buf *dmabuf;
>> > +     struct xe_bo *bo;
>> > +     size_t size =3D PAGE_SIZE;
>> > +     int err;
>> > +
>> > +     /* No VRAM on device? */
>> > +     if (!ttm_manager_type(&xe->ttm, mem_type))
>> > +             return;
>> > +
>> > +     if (mem_type =3D=3D XE_PL_VRAM0 &&
>> > +         xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
>> > +             size =3D SZ_64K;
>> > +
>> > +     /*
>> > +      * DEFER_BACKING places the BO in SYSTEM and creates a ttm_tt wh=
ich
>> > +      * is unpopulated. In the case of VRAM, migrating leaves the ttm=
_tt
>> > +      * retained and unpopulated while VRAM becomes the real backing.
>> > +      */
>> > +     bo =3D xe_bo_create_user(xe, NULL, size, DRM_XE_GEM_CPU_CACHING_=
WC,
>> > +                            bo_flags | XE_BO_FLAG_DEFER_BACKING, NULL=
);
>> > +     if (IS_ERR(bo)) {
>> > +             KUNIT_FAIL(test, "BO creation failed: %pe\n", bo);
>> > +             return;
>> > +     }
>> > +
>> > +     err =3D xe_bo_lock(bo, false);
>> > +     if (err) {
>> > +             KUNIT_FAIL(test, "BO lock failed: %d\n", err);
>> > +             goto out_put_bo;
>> > +     }
>> > +
>> > +     if (bo->ttm.resource->mem_type !=3D mem_type)
>> > +             err =3D xe_bo_migrate(bo, mem_type, NULL, exec);
>> > +     if (err) {
>> > +             KUNIT_FAIL(test, "BO migration to %u failed: %d\n", mem_=
type,
>> > +                        err);
>> > +             goto out_unlock;
>> > +     }
>> > +
>> > +     man =3D ttm_manager_type(bo->ttm.bdev, bo->ttm.resource->mem_typ=
e);
>> > +     if (!man || !bo->ttm.ttm) {
>> > +             KUNIT_FAIL(test, "Expected a retained unpopulated TT\n")=
;
>> > +             goto out_unlock;
>> > +     }
>> > +
>> > +     /* Precondition: ttm_tt starts unpopulated after migration */
>> > +     KUNIT_EXPECT_EQ(test, man->use_tt, expect_populated);
>> > +     KUNIT_EXPECT_FALSE(test, ttm_tt_is_populated(bo->ttm.ttm));
>> > +
>> > +     xe_bo_unlock(bo);
>> > +
>> > +     dmabuf =3D xe_gem_prime_export(&bo->ttm.base, 0);
>> > +     if (IS_ERR(dmabuf)) {
>> > +             KUNIT_FAIL(test, "dma-buf export failed: %pe\n", dmabuf)=
;
>> > +             goto out_put_bo;
>> > +     }
>> > +
>> > +     err =3D xe_bo_lock(bo, false);
>> > +     if (err) {
>> > +             KUNIT_FAIL(test, "post-export BO lock failed: %d\n", err=
);
>> > +             goto out_put_dmabuf;
>> > +     }
>> > +
>> > +     /* Postcondition: if VRAM, ttm_tt remains unpopulated, if SYSTEM=
 ttm_tt is populated */
>> > +     KUNIT_EXPECT_EQ(test, bo->ttm.resource->mem_type, mem_type);
>> > +     KUNIT_EXPECT_NOT_NULL(test, bo->ttm.ttm);
>> > +     if (bo->ttm.ttm)
>> > +             KUNIT_EXPECT_EQ(test, ttm_tt_is_populated(bo->ttm.ttm),
>> > +                             expect_populated);
>> > +
>> > +     xe_bo_unlock(bo);
>> > +     dma_buf_put(dmabuf);
>> > +     drm_gem_object_put(&bo->ttm.base);
>> > +     return;
>> > +
>> > +out_unlock:
>> > +     xe_bo_unlock(bo);
>> > +     goto out_put_bo;
>> > +out_put_dmabuf:
>> > +     dma_buf_put(dmabuf);
>> > +out_put_bo:
>> > +     drm_gem_object_put(&bo->ttm.base);
>> > +}
>> > +
>> >  static int dma_buf_run_device(struct xe_device *xe)
>> >  {
>> >       const struct dma_buf_test_params *params;
>> >       struct kunit *test =3D kunit_get_current_test();
>> >
>> >       guard(xe_pm_runtime)(xe);
>> > +
>> > +     /*
>> > +      * A retained TT must not be populated when VRAM is the backing
>> > +      * resource.
>> > +      */
>> > +     xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_VRAM0, XE_PL_VRAM0=
,
>> > +                                    false);
>> > +
>> > +     /*
>> > +      * Control case: deferred SYSTEM backing must still be populated
>> > +      * before export.
>> > +      */
>> > +     xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_SYSTEM, XE_PL_SYST=
EM,
>> > +                                    true);
>> > +
>> >       for (params =3D test_params; params->mem_mask; ++params) {
>> >               struct dma_buf_test_params p =3D *params;
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_d=
ma_buf.c
>> > index bf0728838ead..0c4e4e2e1a81 100644
>> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>> > @@ -219,6 +219,32 @@ static const struct dma_buf_ops xe_dmabuf_ops =3D=
 {
>> >       .vunmap =3D drm_gem_dmabuf_vunmap,
>> >  };
>> >
>> > +static int xe_dma_bo_setup_export(struct ttm_buffer_object *tbo,
>> > +                               struct ttm_operation_ctx *ctx)
>> > +{
>> > +     struct ttm_resource_manager *man =3D NULL;
>> > +     int ret;
>> > +
>> > +     ret =3D ttm_bo_reserve(tbo, false, false, NULL);
>> > +     if (ret)
>> > +             return ret;
>> > +
>> > +     if (tbo->resource)
>> > +             man =3D ttm_manager_type(tbo->bdev, tbo->resource->mem_t=
ype);
>> > +
>> > +     /*
>> > +      * Do not populate BO-sized system pages when backed by a non-TT=
 resource.
>> > +      * This is Xe-specific; the generic ttm_bo_setup_export() always=
 populates.
>> > +      */
>> > +     if (man && !man->use_tt)
>> > +             ret =3D 0;
>> > +     else
>> > +             ret =3D ttm_bo_populate(tbo, ctx);
>> > +
>> > +     ttm_bo_unreserve(tbo);
>> > +     return ret;
>> > +}
>> > +
>> >  struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int f=
lags)
>> >  {
>> >       struct xe_bo *bo =3D gem_to_xe_bo(obj);
>> > @@ -257,7 +283,7 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem=
_object *obj, int flags)
>> >       xe_bo_willneed_get_locked(bo);
>> >       xe_bo_unlock(bo);
>> >
>> > -     ret =3D ttm_bo_setup_export(&bo->ttm, &ctx);
>> > +     ret =3D xe_dma_bo_setup_export(&bo->ttm, &ctx);
>> >       if (ret)
>> >               goto out_put;
>> >
>> >
>> > base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
>> > --
>> > 2.55.0
>> >
