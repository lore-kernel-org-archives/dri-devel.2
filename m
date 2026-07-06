Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD9DC44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15A010EAEA;
	Mon,  6 Jul 2026 22:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j24iF3lN";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC7710E3D3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:26:21 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8114a4542b2so53737247b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783376780; cv=none;
 d=google.com; s=arc-20260327;
 b=RM4CaFtvNP6d8NIHzUx2Sml7VXVPM/4iuPdaifji5YL3ozr3obn0j5oCmWJmQhehiM
 VMORmGvqfWAt8Fb/8FoJzE+he+NbWKfC862Xp0F2FrMJMRmmt5PsDJYIJrlNTopgDuFL
 dU4BLvQC0GoOz2HCMMh1+8DOy9pR6ULiUqjg9uEKKgOFCMXVsly3MVOBtnycQtm/ocfu
 jqjzJY84YzxBo2Zb3Y+uSmYiQ3+kDeeen3dXJR6q0n8CGKHzQ9fxXgxQyqIacDD2/1Rt
 7QpE0LVp8LWUFeMnMWORMcw5VZ1rBwHJBpD32V817FQAu6/1/9jTYCHjF1PgOxodOIKO
 95IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mki86kr8niXKxg0QierzRcVRah9gnZ+PrqetG+ldUJw=;
 fh=lhf3+D82ehgijUNnab7SNVmGo2K7kWQ3XSU3nE+mUtA=;
 b=FLn9sESIA7lfp/C6BSyC/G36Qr7LKYBSypW098rcGNjVYDY/SY1hUR06CBUuWuL62P
 Qy7SI5/5nZse0R91JXqCHOS0Ws1HdfE/do0o25ROb2gEMTns3BKJapFANzsww/MvHmDy
 U6f4G9sRM1G98Jlk33g/7CfJ6RF6reVLE2h7iOA4rWAQSRy2pBI5tQiAqyKXf6qHjrzt
 4SaWC5b0eyqZMlxwj6vR0MiO8nKxxud1qgBs1HmgVnfkk9TqhSP24uJMlqwqEFsv29Wc
 N+kHLGoL0YdnEnsRciDymXactfgx+fqPQzeTlA/qJH2K5TpkmfX1Hex61Dg8l0E8n+ag
 jr4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783376780; x=1783981580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mki86kr8niXKxg0QierzRcVRah9gnZ+PrqetG+ldUJw=;
 b=j24iF3lNsB8QsMf0vYaVXJiU/4o/V7/55+nrgvhDOLLrQvlQyOeUd66FY0Ao+EhS5R
 c3v6fc/kGP//QBii4gCH/6DLiI6AGxRL5MJ1BAFrm632nEAoqVTmL47o8IVazojE6UlH
 qjXOo9lTA/EAyIBUuur06hIV4xGfm6q1RcsPklSePSf4QK4g4KVkL3jBROAKz4cyf0tw
 DKhWzG5R9vRfSZCXWO1RMKU9c27wOwg7e1muChMcZF3GpHDqAjibzzuKX0xrAQQ7dXF+
 wrvyRWWGGfNlnnkT0oecje2gWbD2Ax80PDoxfYTh9bwI7lBSk8oR2J7aySQ9dsSwMivM
 BIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783376780; x=1783981580;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mki86kr8niXKxg0QierzRcVRah9gnZ+PrqetG+ldUJw=;
 b=ZHn/s84Xp6glRFTG4lR/ZQT7cXmP4Co9zXgVUkB6WKpys5hCEhGpYswmLVm1uXr6cz
 H16ybt8k25Ga7gqqTfayBXAVpDFXlIYhEaIuJFuEj+q8iBsWB4jueSF6obV4/CeH411q
 ww0/u1yy4vW9S/dc9WoTjpyJsG8x529/4ofF2i306wEfiyvyE5uoHNnUjSRa6SP2Zgyl
 eGkm1rVWfkC01JM0ArozHmEv1C1IdWsjK7bzXwCt2pmHmihoaf0lFZN9w0Q4NgIGYpIG
 TNhk/ckyiyAQ8NPuuCx0icrbHAQJz3enNtJ/Q8fcjBi/GFBNe++iTfHpQKj5AbDDhHSi
 JL7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRgBKkkjlBj8QZ9CtzKEWuB14PtuEC9FbXZaSbo6Ka7t5NNSVsUYA/gYa+ov2BmFPkUsFi0tGpJ5I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuRmgPay7BCMMqNUgtgQwkWatXvPkpZqrkD15hlcBtvTB5oGJz
 iUFFTBwKt3PseM5d674HytzqWuGIAGEpZX9oK6neGsxpF+2Ln8dMnWpM8Xlj2nHdYSA4qwIiiQi
 IiXxZNxmGq0OYmty+IJGm1gr3+V23ps0=
X-Gm-Gg: AfdE7cmxpanaRfY7ipT6JZ/C+med69Fdlv1gJv6ZFmDqpFcseoAg2vBxzlVqK8BKWAQ
 gHg/OMo4RvJDtp2jClc6Iqxh7NvmGZ+nfVZzZ5tuTMeBXRklOidfmYxO5Mn7vO5Rhvhy4o0qrDd
 ye4W5r6urVd+f1/Vr5MvuBVr2LKnFt1ER+1UGh3x7w9DLB3X1bz5+u8KuSeoTErmv4vIQ3cKnvH
 JQADPoHGEj5S4oxQdlklsQBAxe10s0V5Mzsvs+/kCn7/3Dvda8xItxvU86UuAHs9RN1I/ZFZpze
 kXazXkS3MWNUwV3no50asj/22IdOEtJNVxXz1y0giMEDrYuow90Wra+S2A==
X-Received: by 2002:a05:690c:6b84:b0:80c:85e5:875f with SMTP id
 00721157ae682-81be3ee8b23mr20223197b3.72.1783376780117; Mon, 06 Jul 2026
 15:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-2-43685ac1286b@gmx.de>
 <b2932c85fee8e4bf89fdd80ada8883c199d823c0.camel@linux.intel.com>
 <88614266-6ee3-4488-9e2f-030ae0266e0e@amd.com>
 <7031c630c987940d814eaef9d1696969be12d81b.camel@linux.intel.com>
 <5d56ec48-b0f0-4f03-8ec2-f8cc34cb3186@amd.com>
In-Reply-To: <5d56ec48-b0f0-4f03-8ec2-f8cc34cb3186@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 7 Jul 2026 08:26:04 +1000
X-Gm-Features: AVVi8CfbYEeW090IT8bVqWL5RXr0qeXR1gcz9_RpgIRFiO6JuKjyYjT9qEeIAlg
Message-ID: <CAPM=9txM41exh_jFJO3zi68oPdQiAXUeZNSXw2RdBiuYkJhw0Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/ttm: replace TTMs refcount with the DRM
 refcount v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Natalie Vock <natalie.vock@gmx.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>
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

Just cc'ing Danilo and Elliott, since I know we are starting to look
at rust and ttm interactions, and these sort of lifetime/refcount fun
might be something we need to solve in a rust compatible way.

On Tue, 7 Jul 2026 at 04:23, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 7/6/26 19:01, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2026-07-06 at 16:49 +0200, Christian K=C3=B6nig wrote:
> >> On 7/6/26 15:14, Thomas Hellstr=C3=B6m wrote:
> >>> On Fri, 2026-07-03 at 18:31 +0200, Natalie Vock wrote:
> >>>> From: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>
> >>>> Instead of keeping a separate reference count for the TTM object
> >>>> also
> >>>> use
> >>>> the reference count for DRM GEM objects inside TTM.
> >>>>
> >>>> Apart from avoiding two reference counts for one object this
> >>>> approach
> >>>> has
> >>>> the clear advantage of being able to use drm_exec inside TTM.
> >>>>
> >>>> v2: adjust XE assert as well and re-enable disabled test
> >>>> v3: handle another case in i915
> >>>> v4: set GEM driver funcs of transfer BOs to point to the TTM free
> >>>> callback (Natalie)
> >>>
> >>> I think the main review issue from the last time this was on the
> >>> table
> >>> was that we shouldn't resurrect the gem refcount. Apart from the
> >>> risc
> >>> of getting barriers wrong, both xe and IIRC i915 partly rely on the
> >>> gem
> >>> refcount never being resurrected and that callbacks for bos with
> >>> zero
> >>> gem refcount means that the gem part of the object is unusable.
> >>
> >> I've spend quite some time thinking about that and came to the
> >> conclusion that this is actually harmless.
> >>
> >> The drivers shouldn't be able to see the resurected BO, except if
> >> they go over the LRU list manually (which they shouldn't).
> >
> > The shrinker uses the TTM helpers for this. Basically the check needs
> > to be ported to use the zombie interface but the present change also
> > widens the window where we can't evict / shrink at all due to zero
> > refcounts.
> >
> > While it might be made harmless, resurrecting a refcount like this is
> > IMO not something that should leak into the gem refcount. Nobody else
> > does this in the kernel tree. The bo in reality becomes a zombie once
> > the gem refcount reaches zero.
>
> I don't really like the solution either, but I don't see much other optio=
n.
>
> >>> For example xe_bo.c:
> >>>
> >>>     if (!xe_bo_is_xe_bo(bo) || !xe_bo_get_unless_zero(xe_bo))
> >>>             return xe_bo_shrink_purge(ctx, bo, scanned);
> >>>
> >>> So IIRC the conclusion was when removing the ttm refcount we
> >>> shouldn't
> >>> attempt to resurrect the gem one. If the get_unless_zero() fails
> >>> during
> >>> evict walk, we simply find something to wait for. See previous
> >>> discussion there.
> >>
> >> Yeah, I considered that as well but the problem is we often doesn't
> >> have anything to wait on.
> >
> > That's not the conclusion of the previous discussion?
> >
> > https://lore.kernel.org/dri-devel/20250716160555.20217-2-christian.koen=
ig@amd.com/#r
>
> Well, I clearly rejected the idea to wait for the delayed delete worker b=
ecause that can cause deadlocks no matter how we do it.
>
> The only possibility I see is to grab a reference on the next busy fence =
and wait for that to signal.
>
> But that approach still leaves a window open where the cleanup worker has=
 not yet cleaned up the resource before we try to allocate a new one.
>
> The only two possibilities I see to close that window are:
> 1. Resurrect the GEM object.
> 2. Keep a reference to the GEM object while it is on the LRU.
>
> I would really like to do #2 instead, but that requires that we distinct =
between GEM object referenze and backing store reference.
>
> The GEM object does have some kind of backing store reference with the ha=
ndle_count field, but that unfortunately doesn't have the right semantic (e=
.g. only goes from 0->1 when you actually create a handle etc..).
>
> >>> I fully support removing the ttm refcount, but not if it means
> >>> resurrecting the gem refcount.
> >>>
> >>> If we want to sidestep that problem, in favour of getting the
> >>> proposed
> >>> locking functionality in and future proof it, I suggest using
> >>>
> >>> https://lore.kernel.org/all/20260605112700.181040-1-thomas.hellstrom@=
linux.intel.com/
> >>>
> >>> And rebase this series on that. This means we can use the ttm
> >>> refcount
> >>> for the transaction refcounting, and also that if we add a dma-buf
> >>> map
> >>> interface with a dma_resv_txn_obj, we could use that to also have
> >>> exhaustive eviction that originates from a dma_buf map.
> >>
> >> I don't think that this is a good idea. It just adds another layer of
> >> abstraction and doesn't solve the problem in any way possible.
> >
> > This comment confuses me. Exactly what problem isn't solved by this,
> > and which of the stated benefits/use-cases in the cover-letter do you
> > think aren't worthwhile?
>
> Of course could the drm_exec object work with different reference counter=
s, but as far as I can see that just complicates the situation and again cr=
eates a TTM specific solutions which I clearly want to avoid.
>
> I would rather go with the resurrection approach instead, that has less p=
otential for problem I think.
>
> Alaternatively we could re-work the whole GEM refcount/GEM handle count/T=
TM refcount mess, but that has even more potential to break.
>
> Regards,
> Christian.
>
>
> >
> > Also for reference: (Section at the end and follow-up messages)
> > https://lore.kernel.org/all/3716d43462188590743060755b37e3d060f7600f.ca=
mel@linux.intel.com/
> >
> > Thanks,
> > Thomas
> >
> >
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> /Thomas
> >>>
> >>>>
> >>>> Signed-off-by: tChristian K=C3=B6nig <christian.koenig@amd.com>
> >>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> >>>> ---
> >>>>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c          |  35 +++---
> >>>>  drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   8 +-
> >>>>  drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c    |   2 -
> >>>>  drivers/gpu/drm/ttm/ttm_bo.c                     | 135
> >>>> +++++++++++--
> >>>> ----------
> >>>>  drivers/gpu/drm/ttm/ttm_bo_internal.h            |  17 ++-
> >>>>  drivers/gpu/drm/ttm/ttm_bo_util.c                |  15 ++-
> >>>>  drivers/gpu/drm/xe/xe_bo.c                       |   2 +-
> >>>>  include/drm/ttm/ttm_bo.h                         |   9 --
> >>>>  8 files changed, 111 insertions(+), 112 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> >>>> b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> >>>> index df3fcc2b1248e..642296602de69 100644
> >>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> >>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> >>>> @@ -939,7 +939,7 @@ void i915_ttm_adjust_lru(struct
> >>>> drm_i915_gem_object *obj)
> >>>>     * Don't manipulate the TTM LRUs while in TTM bo
> >>>> destruction.
> >>>>     * We're called through i915_ttm_delete_mem_notify().
> >>>>     */
> >>>> -  if (!kref_read(&bo->kref))
> >>>> +  if (!kref_read(&bo->base.refcount))
> >>>>            return;
> >>>>
> >>>>    /*
> >>>> @@ -957,30 +957,21 @@ void i915_ttm_adjust_lru(struct
> >>>> drm_i915_gem_object *obj)
> >>>>     *
> >>>>     * TODO: consider maybe also bumping the shrinker list
> >>>> here
> >>>> when we have
> >>>>     * already unpinned it, which should give us something
> >>>> more
> >>>> like an LRU.
> >>>> -   *
> >>>> -   * TODO: There is a small window of opportunity for this
> >>>> function to
> >>>> -   * get called from eviction after we've dropped the last
> >>>> GEM
> >>>> refcount,
> >>>> -   * but before the TTM deleted flag is set on the object.
> >>>> Avoid
> >>>> -   * adjusting the shrinker list in such cases, since the
> >>>> object is
> >>>> -   * not available to the shrinker anyway due to its zero
> >>>> refcount.
> >>>> -   * To fix this properly we should move to a TTM shrinker
> >>>> LRU
> >>>> list for
> >>>> -   * these objects.
> >>>>     */
> >>>> -  if (kref_get_unless_zero(&obj->base.refcount)) {
> >>>> -          if (shrinkable !=3D obj->mm.ttm_shrinkable) {
> >>>> -                  if (shrinkable) {
> >>>> -                          if (obj->mm.madv =3D=3D
> >>>> I915_MADV_WILLNEED)
> >>>> -
> >>>>                                    __i915_gem_object_make_s
> >>>> hrinkable(obj);
> >>>> -                          else
> >>>> -
> >>>>                                    __i915_gem_object_make_p
> >>>> urgeable(obj);
> >>>> -                  } else {
> >>>> -
> >>>>                            i915_gem_object_make_unshrinkabl
> >>>> e(obj);
> >>>> -                  }
> >>>> -
> >>>> -                  obj->mm.ttm_shrinkable =3D shrinkable;
> >>>> +  i915_gem_object_get(obj);
> >>>> +  if (shrinkable !=3D obj->mm.ttm_shrinkable) {
> >>>> +          if (shrinkable) {
> >>>> +                  if (obj->mm.madv =3D=3D I915_MADV_WILLNEED)
> >>>> +                          __i915_gem_object_make_shrinkabl
> >>>> e(ob
> >>>> j);
> >>>> +                  else
> >>>> +                          __i915_gem_object_make_purgeable
> >>>> (obj
> >>>> );
> >>>> +          } else {
> >>>> +                  i915_gem_object_make_unshrinkable(obj);
> >>>>            }
> >>>> -          i915_gem_object_put(obj);
> >>>> +
> >>>> +          obj->mm.ttm_shrinkable =3D shrinkable;
> >>>>    }
> >>>> +  i915_gem_object_put(obj);
> >>>>
> >>>>    /*
> >>>>     * Put on the correct LRU list depending on the MADV
> >>>> status
> >>>> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >>>> b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >>>> index 56ad8ef325840..904cb4da6c9b3 100644
> >>>> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >>>> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >>>> @@ -127,7 +127,7 @@ static void
> >>>> ttm_bo_init_reserved_sys_man(struct
> >>>> kunit *test)
> >>>>    dma_resv_unlock(bo->base.resv);
> >>>>
> >>>>    KUNIT_EXPECT_EQ(test, err, 0);
> >>>> -  KUNIT_EXPECT_EQ(test, kref_read(&bo->kref), 1);
> >>>> +  KUNIT_EXPECT_EQ(test, kref_read(&bo->base.refcount), 1);
> >>>>    KUNIT_EXPECT_PTR_EQ(test, bo->bdev, priv->ttm_dev);
> >>>>    KUNIT_EXPECT_EQ(test, bo->type, bo_type);
> >>>>    KUNIT_EXPECT_EQ(test, bo->page_alignment, PAGE_SIZE);
> >>>> @@ -176,7 +176,7 @@ static void
> >>>> ttm_bo_init_reserved_mock_man(struct
> >>>> kunit *test)
> >>>>    dma_resv_unlock(bo->base.resv);
> >>>>
> >>>>    KUNIT_EXPECT_EQ(test, err, 0);
> >>>> -  KUNIT_EXPECT_EQ(test, kref_read(&bo->kref), 1);
> >>>> +  KUNIT_EXPECT_EQ(test, kref_read(&bo->base.refcount), 1);
> >>>>    KUNIT_EXPECT_PTR_EQ(test, bo->bdev, priv->ttm_dev);
> >>>>    KUNIT_EXPECT_EQ(test, bo->type, bo_type);
> >>>>    KUNIT_EXPECT_EQ(test, ctx.bytes_moved, size);
> >>>> @@ -969,6 +969,8 @@ static void
> >>>> ttm_bo_validate_allowed_only_evict(struct kunit *test)
> >>>>    ttm_mock_manager_fini(priv->ttm_dev, mem_multihop);
> >>>>  }
> >>>>
> >>>> +extern const struct drm_gem_object_funcs
> >>>> ttm_deleted_object_funcs;
> >>>> +
> >>>>  static void ttm_bo_validate_deleted_evict(struct kunit *test)
> >>>>  {
> >>>>    struct ttm_operation_ctx ctx_init =3D { }, ctx_val  =3D { };
> >>>> @@ -999,7 +1001,7 @@ static void
> >>>> ttm_bo_validate_deleted_evict(struct
> >>>> kunit *test)
> >>>>    KUNIT_EXPECT_EQ(test, ttm_resource_manager_usage(man),
> >>>> big);
> >>>>
> >>>>    dma_resv_unlock(bo_big->base.resv);
> >>>> -  bo_big->deleted =3D true;
> >>>> +  bo_big->base.funcs =3D &ttm_deleted_object_funcs;
> >>>>
> >>>>    bo_small =3D ttm_bo_kunit_init(test, test->priv, small,
> >>>> NULL);
> >>>>    bo_small->type =3D bo_type;
> >>>> diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> >>>> b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> >>>> index 5cfe8f3f80d75..b7ab19e0e4b2b 100644
> >>>> --- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> >>>> +++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> >>>> @@ -189,8 +189,6 @@ struct ttm_buffer_object
> >>>> *ttm_bo_kunit_init(struct kunit *test,
> >>>>    bo->bdev =3D devs->ttm_dev;
> >>>>    bo->destroy =3D dummy_ttm_bo_destroy;
> >>>>
> >>>> -  kref_init(&bo->kref);
> >>>> -
> >>>>    return bo;
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(ttm_bo_kunit_init);
> >>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> >>>> b/drivers/gpu/drm/ttm/ttm_bo.c
> >>>> index 3980f376e3ba4..2b470c1746f60 100644
> >>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> >>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> >>>> @@ -246,88 +246,84 @@ static void ttm_bo_delayed_delete(struct
> >>>> work_struct *work)
> >>>>    ttm_bo_put(bo);
> >>>>  }
> >>>>
> >>>> -static void ttm_bo_release(struct kref *kref)
> >>>> +/*
> >>>> + * All other callbacks should never ever be called on a deleted
> >>>> TTM
> >>>> object.
> >>>> + */
> >>>> +const struct drm_gem_object_funcs ttm_deleted_object_funcs =3D {
> >>>> +  .free =3D ttm_bo_free
> >>>> +};
> >>>> +EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_deleted_object_funcs);
> >>>> +
> >>>> +/* Returns true if the BO is about to get deleted */
> >>>> +static bool ttm_bo_is_zombie(struct ttm_buffer_object *bo)
> >>>> +{
> >>>> +  return bo->base.funcs =3D=3D &ttm_deleted_object_funcs;
> >>>> +}
> >>>> +
> >>>> +void ttm_bo_fini(struct ttm_buffer_object *bo)
> >>>>  {
> >>>> -  struct ttm_buffer_object *bo =3D
> >>>> -      container_of(kref, struct ttm_buffer_object, kref);
> >>>>    struct ttm_device *bdev =3D bo->bdev;
> >>>>    int ret;
> >>>>
> >>>>    WARN_ON_ONCE(bo->pin_count);
> >>>>    WARN_ON_ONCE(bo->bulk_move);
> >>>>
> >>>> -  if (!bo->deleted) {
> >>>> -          ret =3D ttm_bo_individualize_resv(bo);
> >>>> -          if (ret) {
> >>>> -                  /* Last resort, if we fail to allocate
> >>>> memory for the
> >>>> -                   * fences block for the BO to become
> >>>> idle
> >>>> -                   */
> >>>> -                  dma_resv_wait_timeout(bo->base.resv,
> >>>> -
> >>>> DMA_RESV_USAGE_BOOKKEEP, false,
> >>>> -                                        30 * HZ);
> >>>> -          }
> >>>> +  ret =3D ttm_bo_individualize_resv(bo);
> >>>> +  if (ret) {
> >>>> +          /* Last resort, if we fail to allocate memory
> >>>> for
> >>>> the
> >>>> +           * fences block for the BO to become idle
> >>>> +           */
> >>>> +          dma_resv_wait_timeout(bo->base.resv,
> >>>> DMA_RESV_USAGE_BOOKKEEP,
> >>>> +                                false, 30 * HZ);
> >>>> +  }
> >>>>
> >>>> -          if (bdev->funcs->release_notify)
> >>>> -                  bdev->funcs->release_notify(bo);
> >>>> +  if (bo->bdev->funcs->release_notify)
> >>>> +          bo->bdev->funcs->release_notify(bo);
> >>>>
> >>>> -          drm_vma_offset_remove(bdev->vma_manager, &bo-
> >>>>> base.vma_node);
> >>>> -          ttm_mem_io_free(bdev, bo->resource);
> >>>> +  drm_vma_offset_remove(bdev->vma_manager, &bo-
> >>>>> base.vma_node);
> >>>> +  ttm_mem_io_free(bdev, bo->resource);
> >>>>
> >>>> -          if (!dma_resv_test_signaled(&bo->base._resv,
> >>>> -
> >>>> DMA_RESV_USAGE_BOOKKEEP)
> >>>>>>
> >>>> -              (want_init_on_free() && (bo->ttm !=3D NULL))
> >>>> ||
> >>>> -              bo->type =3D=3D ttm_bo_type_sg ||
> >>>> -              !dma_resv_trylock(bo->base.resv)) {
> >>>> -                  /* The BO is not idle, resurrect it for
> >>>> delayed destroy */
> >>>> -                  ttm_bo_flush_all_fences(bo);
> >>>> -                  bo->deleted =3D true;
> >>>> +  if (!dma_resv_test_signaled(&bo->base._resv,
> >>>> DMA_RESV_USAGE_BOOKKEEP) ||
> >>>> +      (want_init_on_free() && (bo->ttm !=3D NULL)) ||
> >>>> +      bo->type =3D=3D ttm_bo_type_sg ||
> >>>> +      !dma_resv_trylock(bo->base.resv)) {
> >>>> +          /* The BO is not idle, resurrect it for delayed
> >>>> destroy */
> >>>> +          ttm_bo_flush_all_fences(bo);
> >>>>
> >>>> -                  spin_lock(&bdev->lru_lock);
> >>>> -
> >>>> -                  /*
> >>>> -                   * Make pinned bos immediately available
> >>>> to
> >>>> -                   * shrinkers, now that they are queued
> >>>> for
> >>>> -                   * destruction.
> >>>> -                   *
> >>>> -                   * FIXME: QXL is triggering this. Can be
> >>>> removed when the
> >>>> -                   * driver is fixed.
> >>>> -                   */
> >>>> -                  if (bo->pin_count) {
> >>>> -                          bo->pin_count =3D 0;
> >>>> -
> >>>>                            ttm_resource_move_to_lru_tail(bo-
> >>>>> resource);
> >>>> -                  }
> >>>> +          spin_lock(&bo->bdev->lru_lock);
> >>>>
> >>>> -                  kref_init(&bo->kref);
> >>>> -                  spin_unlock(&bdev->lru_lock);
> >>>> +          /*
> >>>> +           * Make pinned bos immediately available to
> >>>> +           * shrinkers, now that they are queued for
> >>>> +           * destruction.
> >>>> +           *
> >>>> +           * FIXME: QXL is triggering this. Can be removed
> >>>> when the
> >>>> +           * driver is fixed.
> >>>> +           */
> >>>> +          if (bo->pin_count) {
> >>>> +                  bo->pin_count =3D 0;
> >>>> +                  ttm_resource_move_to_lru_tail(bo-
> >>>>> resource);
> >>>> +          }
> >>>>
> >>>> -                  INIT_WORK(&bo->delayed_delete,
> >>>> ttm_bo_delayed_delete);
> >>>> +          kref_init(&bo->base.refcount);
> >>>> +          bo->base.funcs =3D &ttm_deleted_object_funcs;
> >>>> +          spin_unlock(&bo->bdev->lru_lock);
> >>>>
> >>>> -                  /* Schedule the worker on the closest
> >>>> NUMA
> >>>> node. This
> >>>> -                   * improves performance since system
> >>>> memory
> >>>> might be
> >>>> -                   * cleared on free and that is best done
> >>>> on
> >>>> a CPU core
> >>>> -                   * close to it.
> >>>> -                   */
> >>>> -                  queue_work_node(bdev->pool.nid, bdev-
> >>>>> wq,
> >>>> &bo->delayed_delete);
> >>>> -                  return;
> >>>> -          }
> >>>> +          INIT_WORK(&bo->delayed_delete,
> >>>> ttm_bo_delayed_delete);
> >>>>
> >>>> +          /* Schedule the worker on the closest NUMA node.
> >>>> This
> >>>> +           * improves performance since system memory
> >>>> might be
> >>>> +           * cleared on free and that is best done on a
> >>>> CPU
> >>>> core
> >>>> +           * close to it.
> >>>> +           */
> >>>> +          queue_work_node(bdev->pool.nid, bdev->wq, &bo-
> >>>>> delayed_delete);
> >>>> +  } else {
> >>>>            ttm_bo_cleanup_memtype_use(bo);
> >>>>            dma_resv_unlock(bo->base.resv);
> >>>> -  }
> >>>>
> >>>> -  atomic_dec(&ttm_glob.bo_count);
> >>>> -  bo->destroy(bo);
> >>>> -}
> >>>> -
> >>>> -/* TODO: remove! */
> >>>> -void ttm_bo_put(struct ttm_buffer_object *bo)
> >>>> -{
> >>>> -  kref_put(&bo->kref, ttm_bo_release);
> >>>> -}
> >>>> -
> >>>> -void ttm_bo_fini(struct ttm_buffer_object *bo)
> >>>> -{
> >>>> -  ttm_bo_put(bo);
> >>>> +          atomic_dec(&ttm_glob.bo_count);
> >>>> +          bo->destroy(bo);
> >>>> +  }
> >>>>  }
> >>>>  EXPORT_SYMBOL(ttm_bo_fini);
> >>>>
> >>>> @@ -470,7 +466,7 @@ int ttm_bo_evict_first(struct ttm_device
> >>>> *bdev,
> >>>> struct ttm_resource_manager *man
> >>>>    if (!bo->resource || bo->resource->mem_type !=3D mem_type)
> >>>>            goto out_bo_moved;
> >>>>
> >>>> -  if (bo->deleted) {
> >>>> +  if (ttm_bo_is_zombie(bo)) {
> >>>>            ret =3D ttm_bo_wait_ctx(bo, ctx);
> >>>>            if (!ret)
> >>>>                    ttm_bo_cleanup_memtype_use(bo);
> >>>> @@ -524,7 +520,7 @@ static s64 ttm_bo_evict_cb(struct
> >>>> ttm_lru_walk
> >>>> *walk, struct ttm_buffer_object *
> >>>>    if (bo->pin_count || !bo->bdev->funcs-
> >>>>> eviction_valuable(bo,
> >>>> evict_walk->place))
> >>>>            return 0;
> >>>>
> >>>> -  if (bo->deleted) {
> >>>> +  if (ttm_bo_is_zombie(bo)) {
> >>>>            lret =3D ttm_bo_wait_ctx(bo, walk->arg.ctx);
> >>>>            if (!lret)
> >>>>                    ttm_bo_cleanup_memtype_use(bo);
> >>>> @@ -624,7 +620,6 @@ static int ttm_bo_evict_alloc(struct
> >>>> ttm_device
> >>>> *bdev,
> >>>>  void ttm_bo_pin(struct ttm_buffer_object *bo)
> >>>>  {
> >>>>    dma_resv_assert_held(bo->base.resv);
> >>>> -  WARN_ON_ONCE(!kref_read(&bo->kref));
> >>>>    spin_lock(&bo->bdev->lru_lock);
> >>>>    if (bo->resource)
> >>>>            ttm_resource_del_bulk_move(bo->resource, bo);
> >>>> @@ -643,7 +638,6 @@ EXPORT_SYMBOL(ttm_bo_pin);
> >>>>  void ttm_bo_unpin(struct ttm_buffer_object *bo)
> >>>>  {
> >>>>    dma_resv_assert_held(bo->base.resv);
> >>>> -  WARN_ON_ONCE(!kref_read(&bo->kref));
> >>>>    if (WARN_ON_ONCE(!bo->pin_count))
> >>>>            return;
> >>>>
> >>>> @@ -934,7 +928,6 @@ int ttm_bo_init_reserved(struct ttm_device
> >>>> *bdev,
> >>>> struct ttm_buffer_object *bo,
> >>>>  {
> >>>>    int ret;
> >>>>
> >>>> -  kref_init(&bo->kref);
> >>>>    bo->bdev =3D bdev;
> >>>>    bo->type =3D type;
> >>>>    bo->page_alignment =3D alignment;
> >>>> @@ -1131,8 +1124,8 @@ ttm_bo_swapout_cb(struct ttm_lru_walk
> >>>> *walk,
> >>>> struct ttm_buffer_object *bo)
> >>>>            goto out;
> >>>>    }
> >>>>
> >>>> -  if (bo->deleted) {
> >>>> -          pgoff_t num_pages =3D tt->num_pages;
> >>>> +  if (ttm_bo_is_zombie(bo)) {
> >>>> +          pgoff_t num_pages =3D bo->ttm->num_pages;
> >>>>
> >>>>            ret =3D ttm_bo_wait_ctx(bo, ctx);
> >>>>            if (ret)
> >>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_internal.h
> >>>> b/drivers/gpu/drm/ttm/ttm_bo_internal.h
> >>>> index e0d48eac74b03..ded2a47be0bcb 100644
> >>>> --- a/drivers/gpu/drm/ttm/ttm_bo_internal.h
> >>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_internal.h
> >>>> @@ -27,6 +27,14 @@
> >>>>
> >>>>  #include <drm/ttm/ttm_bo.h>
> >>>>
> >>>> +static inline void ttm_bo_free(struct drm_gem_object *gobj)
> >>>> +{
> >>>> +  struct ttm_buffer_object *bo =3D container_of(gobj,
> >>>> typeof(*bo), base);
> >>>> +
> >>>> +  atomic_dec(&ttm_glob.bo_count);
> >>>> +  bo->destroy(bo);
> >>>> +}
> >>>> +
> >>>>  /**
> >>>>   * ttm_bo_get - reference a struct ttm_buffer_object
> >>>>   *
> >>>> @@ -34,7 +42,7 @@
> >>>>   */
> >>>>  static inline void ttm_bo_get(struct ttm_buffer_object *bo)
> >>>>  {
> >>>> -  kref_get(&bo->kref);
> >>>> +  drm_gem_object_get(&bo->base);
> >>>>  }
> >>>>
> >>>>  /**
> >>>> @@ -50,11 +58,14 @@ static inline void ttm_bo_get(struct
> >>>> ttm_buffer_object *bo)
> >>>>  static inline __must_check struct ttm_buffer_object *
> >>>>  ttm_bo_get_unless_zero(struct ttm_buffer_object *bo)
> >>>>  {
> >>>> -  if (!kref_get_unless_zero(&bo->kref))
> >>>> +  if (!kref_get_unless_zero(&bo->base.refcount))
> >>>>            return NULL;
> >>>>    return bo;
> >>>>  }
> >>>>
> >>>> -void ttm_bo_put(struct ttm_buffer_object *bo);
> >>>> +static inline void ttm_bo_put(struct ttm_buffer_object *bo)
> >>>> +{
> >>>> +  drm_gem_object_put(&bo->base);
> >>>> +}
> >>>>
> >>>>  #endif
> >>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> >>>> b/drivers/gpu/drm/ttm/ttm_bo_util.c
> >>>> index 3e3c201a02226..7ed085adf1c9b 100644
> >>>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> >>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> >>>> @@ -41,6 +41,18 @@
> >>>>
> >>>>  #include "ttm_bo_internal.h"
> >>>>
> >>>> +static void ttm_transfer_object_free(struct drm_gem_object *obj)
> >>>> +{
> >>>> +  struct ttm_buffer_object *bo =3D
> >>>> +          container_of(obj, struct ttm_buffer_object,
> >>>> base);
> >>>> +
> >>>> +  ttm_bo_fini(bo);
> >>>> +}
> >>>> +
> >>>> +const struct drm_gem_object_funcs ttm_transfer_object_funcs =3D {
> >>>> +  .free =3D ttm_transfer_object_free,
> >>>> +};
> >>>> +
> >>>>  struct ttm_transfer_obj {
> >>>>    struct ttm_buffer_object base;
> >>>>    struct ttm_buffer_object *bo;
> >>>> @@ -247,7 +259,8 @@ static int ttm_buffer_object_transfer(struct
> >>>> ttm_buffer_object *bo,
> >>>>    atomic_inc(&ttm_glob.bo_count);
> >>>>    drm_vma_node_reset(&fbo->base.base.vma_node);
> >>>>
> >>>> -  kref_init(&fbo->base.kref);
> >>>> +  kref_init(&fbo->base.base.refcount);
> >>>> +  fbo->base.base.funcs =3D &ttm_transfer_object_funcs;
> >>>>    fbo->base.destroy =3D &ttm_transfered_destroy;
> >>>>    fbo->base.pin_count =3D 0;
> >>>>    if (bo->type !=3D ttm_bo_type_sg)
> >>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c
> >>>> b/drivers/gpu/drm/xe/xe_bo.c
> >>>> index 85e6d9a0f575b..5843f850339c7 100644
> >>>> --- a/drivers/gpu/drm/xe/xe_bo.c
> >>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
> >>>> @@ -1651,7 +1651,7 @@ static bool
> >>>> xe_ttm_bo_lock_in_destructor(struct
> >>>> ttm_buffer_object *ttm_bo)
> >>>>    struct xe_device *xe =3D ttm_to_xe_device(ttm_bo->bdev);
> >>>>    bool locked;
> >>>>
> >>>> -  xe_assert(xe, !kref_read(&ttm_bo->kref));
> >>>> +  xe_assert(xe, !kref_read(&ttm_bo->base.refcount));
> >>>>
> >>>>    /*
> >>>>     * We can typically only race with TTM trylocking under
> >>>> the
> >>>> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> >>>> index 8310bc3d55f90..1eae9eea5ff32 100644
> >>>> --- a/include/drm/ttm/ttm_bo.h
> >>>> +++ b/include/drm/ttm/ttm_bo.h
> >>>> @@ -78,11 +78,8 @@ enum ttm_bo_type {
> >>>>   * @type: The bo type.
> >>>>   * @page_alignment: Page alignment.
> >>>>   * @destroy: Destruction function. If NULL, kfree is used.
> >>>> - * @kref: Reference count of this buffer object. When this
> >>>> refcount
> >>>> reaches
> >>>> - * zero, the object is destroyed or put on the delayed delete
> >>>> list.
> >>>>   * @resource: structure describing current placement.
> >>>>   * @ttm: TTM structure holding system pages.
> >>>> - * @deleted: True if the object is only a zombie and already
> >>>> deleted.
> >>>>   * @bulk_move: The bulk move object.
> >>>>   * @priority: Priority for LRU, BOs with lower priority are
> >>>> evicted
> >>>> first.
> >>>>   * @pin_count: Pin count.
> >>>> @@ -109,17 +106,11 @@ struct ttm_buffer_object {
> >>>>    uint32_t page_alignment;
> >>>>    void (*destroy) (struct ttm_buffer_object *);
> >>>>
> >>>> -  /*
> >>>> -  * Members not needing protection.
> >>>> -  */
> >>>> -  struct kref kref;
> >>>> -
> >>>>    /*
> >>>>     * Members protected by the bo::resv::reserved lock.
> >>>>     */
> >>>>    struct ttm_resource *resource;
> >>>>    struct ttm_tt *ttm;
> >>>> -  bool deleted;
> >>>>    struct ttm_lru_bulk_move *bulk_move;
> >>>>    unsigned priority;
> >>>>    unsigned pin_count;
>
