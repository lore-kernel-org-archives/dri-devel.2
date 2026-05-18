Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030FBCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE7110E149;
	Mon, 18 May 2026 23:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="AZoBDsM4";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBE610E213
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:20:59 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-651bf695701so2797164d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146458; cv=none;
 d=google.com; s=arc-20240605;
 b=kt4+dpRS0f6cCcL56moE0v3N3ISJTQvGxbEIpuG8IJFzuDImUsncjOqvLPJf0nDVHt
 UB/frVw5iFsrJp2tJR+6gVvCt1+Ox3fMSQJNzvhKGKgBuipDltR9M+10kgLnX+LliSv2
 6Xb0HBN8h0kse2QZr1QwFbO0kjCpwwoiP3/Oxj8tn8vNk1wQvm3sszqX4VEKbFTfZa6P
 +mgq9GCDP3gZZ5gr8u3+KgE+FaGQadwkylJIcCDgKsDRz1ddQt5WohlbItL6UqPti9Fl
 oNnw7Axl+wns6EkX7S4V84o+WbzuEgJa+WKW43+S0KFu9KjqoKSGmRYuzqOUlmwZxfTJ
 WlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qyiC/6ER7XJQAQS9fYV1hi++02Ay+WfrOqQ6ixqtbHQ=;
 fh=Fx2khRydsmaAdl/aJKhroEH62r6hmM2r6fPNhmfpzdM=;
 b=B1xEEfQTObBCORWICtGxUXYdcatwYFK4t6IIlnwrkI2oNOX4dOfYfCYllUPhMxP2Cd
 8hyv2A89hkxptnbt129ERpjhaNcgimnMKoLusarO5oTNnUgFrXqLOFQboJ4qhvQ/zIdh
 oS3duPoZF1Ho5QfUGF9yTOm2Xdn0X9b8ywN8zD2lfRgw9xxh8L8ZGB36xK50jbcR7IEh
 vzjWP+SJgVUwGrTMrsmiTifdX3b77Vt7jV+F2dnctsjFac5H8bUQHVBKoE8ZNZdTQu9P
 0stIFKt/HYH4D2aUdjtOgfH0usc4Od9/yyXXIAkODK/Mz9PILjfKxrjCAebV0k9jejlw
 UTyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1779146458; x=1779751258;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyiC/6ER7XJQAQS9fYV1hi++02Ay+WfrOqQ6ixqtbHQ=;
 b=AZoBDsM4+UmK9xTQpYnH+tQmJczU3tysd/hHt8TozSrBKDRzU5H8Sl999edx/9dtFX
 LsVzaURGLffRfnqQjYMNlaxPjouyDrhQxJpXLXjEyeh64huo7hfPc5lslj0baj8MDgn2
 oB4v0v6Se1AwBmxk1p2hm2G4UgVE47oZKppL8bolgJ+ZDQtTP8PDR7SLgcWIjUyEphtG
 8SUPbQcFb2h5uaxFIqKbJkV20XYAKgAQHbCTfLvr6LvHof42YcIvQR7evr3HjuDda7tU
 15kZOBpaRIeeaZhNrkdDIOrkNjNYHTt6W0CHZoFt1jfsSMdaDyaPy1eNxigEWhMkGnR6
 I7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779146458; x=1779751258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qyiC/6ER7XJQAQS9fYV1hi++02Ay+WfrOqQ6ixqtbHQ=;
 b=LQc4rfYo2ktrSNYVsgd2AOTFuuDjnjL39N/cQic+UuSI3DomloHYpReO/2M2DMIDh1
 /XqV0Pu+5CQNQIKsZGArEXticCdpNXpezt4iAYVhvlIA7h1FfH9KAMNvKR1PgtQKvXOz
 Zw2FzuPgV/stSUSy/bGZniQ5DGxZ59OZPY31WE/XZOp15rGfz6SqzVcxu84LQLRnbJo0
 fD+del+GjEIkSAhw1sfzC480Z5IFXEtxQDRCGQ/Rv7Bpng4M7PDoTHXlyoW96pY7RV59
 UwvHfmZmEBPfiac61D5d4pVNNhQHo9rj8mMqho6nT5MBVCzNw/BAfXqn1zi/u1KTw+Fl
 Jdww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zd9FOq8cdNdgFk3e4LtwuZTdS1Pb+hZLAx6WLyAHVwozDOsrKxhlK4NTCCy8xOI7vGq7FDcsOVbM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgvQA8oPFUlHByhPW0yANhRyXGxZUjSkTVsCteewHtG+Jnz2HC
 ZoDkXlgdke8dRHQXJuNFsrkg8Wi7yP+gE2fFqRvNpGOF1XCFxt3BqaKdpQxRs8Uqf3h1J8ZKtNC
 7EoDzTCSMZPaXFlLpywOD4ET7FucJsANre6Gsa6RFgQ==
X-Gm-Gg: Acq92OEZTEzX38jxM3pZ3h+CY7XrimrfWAGebH3Unw86CReFiwZeNxPNbsBDhOiumtX
 xW8PYbThOGYhPIZ96yzRtQTZ4yHGZBod3/5VjybIJrb+dZvhYen7/237VTtoceHX1fWgjj7JcnY
 hINPdW0HdasghzXLvLGi7FWqf+9zm+k6LfJv49czBxSO42vPYoVq7EvCuAYeXjxO5WH4iEn0bZ0
 jLJHkgVEx/NBEGj50PcveFD7v0EQ2gkLL8PnceTb3h2GS/y588mdAffQOITzIJIj/zHzG9+oJCT
 z/xhqYhCIA==
X-Received: by 2002:a05:690e:148b:b0:65c:6164:f29a with SMTP id
 956f58d0204a3-65e22839e7fmr18959504d50.46.1779146457665; Mon, 18 May 2026
 16:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260515135932.2238842-1-vineeth@bitbyteword.org>
 <81783d0807a5ffac93f61eddba0d2f595d7f239f.camel@mailbox.org>
In-Reply-To: <81783d0807a5ffac93f61eddba0d2f595d7f239f.camel@mailbox.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 18 May 2026 19:20:46 -0400
X-Gm-Features: AVHnY4KAw0ZavPbDVfhEtyHlzriwrbmjQeDlQua14-BfS3GXG-7uIcLEub9UvWg
Message-ID: <CAO7JXPhMBd0xgDRO-gZ2HpSTnrj1OD67c39jrXWEKaowNc9GEA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] drm: Use trace_call__##name() at guarded
 tracepoint call sites
To: phasta@kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Steven Rostedt <rostedt@goodmis.org>, 
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 18, 2026 at 11:01=E2=80=AFAM Philipp Stanner <phasta@mailbox.or=
g> wrote:
>
> On Fri, 2026-05-15 at 09:59 -0400, Vineeth Pillai (Google) wrote:
> > From: Vineeth Pillai <vineeth@bitbyteword.org>
> >
> > Replace trace_foo() with the new trace_call__foo() at sites already
> > guarded by trace_foo_enabled(), avoiding a redundant
> > static_branch_unlikely() re-evaluation inside the tracepoint.
> > trace_call__foo() calls the tracepoint callbacks directly without
> > utilizing the static branch again.
>
> The "foo" terminology is unusual I think? I always wrote it with regex,
> like "trace_*()".
>
Sorry about the terminology. Part of the patches got merged this way,
so is it okay to continue the terminology to have consistency?

>
>
> >
> > Original v2 series:
> > https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vinee=
th@bitbyteword.org/
>
> I'd put this in a Link: tag section below.
>
Makes sense, will do. Steve also suggested to put this whole section
after "---" because it isn't relevant to the changes. Will fix this in
next iteration.

> >
> > Parts of the original v2 series have already been merged in mainline.
> > This patch is being reposted as a follow-up cleanup for the remaining
> > unmerged pieces.
>
> So this v3 series as a whole is a followup to that v2?
>
v3 is a follow up to remaining patches that were not merged with the
previous cycle. The core api and couple of patches went in the
previous cycle, so this is for rest of it.

The intention was to send this v3 as a direct patch to individual
subsystem maintainers but forgot to remove the numbering and hence
there might be a confusion. Will remove the numbering and send it  as
stand alone patch in the next iteration.

> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
> >  drivers/gpu/drm/scheduler/sched_entity.c          |  5 +++--
> >  4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index b24d5d21be5f..cb0b5cb07d57 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1004,7 +1004,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_=
parser *p)
> >               struct amdgpu_job *job =3D p->jobs[i];
> >
> >               for (j =3D 0; j < job->num_ibs; ++j)
> > -                     trace_amdgpu_cs(p, job, &job->ibs[j]);
> > +                     trace_call__amdgpu_cs(p, job, &job->ibs[j]);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 9ba9de16a27a..a36ae94c425f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1415,7 +1415,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v, struct amdgpu_bo_va *bo_va,
> >
> >       if (trace_amdgpu_vm_bo_mapping_enabled()) {
> >               list_for_each_entry(mapping, &bo_va->valids, list)
> > -                     trace_amdgpu_vm_bo_mapping(mapping);
> > +                     trace_call__amdgpu_vm_bo_mapping(mapping);
> >       }
> >
> >  error_free:
> > @@ -2183,7 +2183,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, =
struct ww_acquire_ctx *ticket)
> >                               continue;
> >               }
> >
> > -             trace_amdgpu_vm_bo_cs(mapping);
> > +             trace_call__amdgpu_vm_bo_cs(mapping);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 5fc5d5608506..fbdc12cdd6bb 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5263,11 +5263,11 @@ static void amdgpu_dm_backlight_set_level(struc=
t amdgpu_display_manager *dm,
> >       }
> >
> >       if (trace_amdgpu_dm_brightness_enabled()) {
> > -             trace_amdgpu_dm_brightness(__builtin_return_address(0),
> > -                                        user_brightness,
> > -                                        brightness,
> > -                                        caps->aux_support,
> > -                                        power_supply_is_system_supplie=
d() > 0);
> > +             trace_call__amdgpu_dm_brightness(__builtin_return_address=
(0),
> > +                                              user_brightness,
> > +                                              brightness,
> > +                                              caps->aux_support,
> > +                                              power_supply_is_system_s=
upplied() > 0);
> >       }
> >
> >       if (caps->aux_support) {
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm=
/scheduler/sched_entity.c
> > index fe174a4857be..185a2636b599 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -429,7 +429,8 @@ static bool drm_sched_entity_add_dependency_cb(stru=
ct drm_sched_entity *entity,
> >
> >       if (trace_drm_sched_job_unschedulable_enabled() &&
> >           !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->f=
lags))
> > -             trace_drm_sched_job_unschedulable(sched_job, entity->depe=
ndency);
> > +             trace_call__drm_sched_job_unschedulable(sched_job,
> > +                                                     entity->dependenc=
y);
>
> I would be more happy if you sacrifice a bit of space here and keep it
> a single line since the if condition is already quite convoluted and
> challenging to read.
>
I understand, will fix it in next iteration.

Thanks,
Vineeth
