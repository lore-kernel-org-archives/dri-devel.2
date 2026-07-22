Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A84C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D26D10EFE7;
	Thu, 23 Jul 2026 07:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZilkRKw";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022A110E4E5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 18:39:49 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-80814edb536so99097877b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784745588; cv=none;
 d=google.com; s=arc-20260327;
 b=p3chf5jqJ4wlnXBbdCv8SzsOQXSLQJx1lW6OjwcC0Fc9ShvivRYrMBdTKdjFkvZ14c
 BA4O8Nz0u2EwiFT3qL9mLJOWoDx5HVuHOM2BP2zea3YaTJfK5gUBFyGOZ8edda+A7OEi
 tYVyRNL5fRbogZkZTw2znFW/HLYj4L2MW8ocMX3YGoY6cqmtXRmjeAUxy2hHqbYYcFLy
 oiCxcAxzbP5n8xqQWQSNBtSSPqQGk9+85o0sRC3MTp2XOq4KgbujDDjoLEZIUFQgqxTX
 3Vxt9UduO6ycFjLXpkYOu4uBieF9EJ5qTJwFx61ZUlTgs8bfmnNEIIYC3bkP7DPfKxWQ
 BvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NtEJiIsjzHIffGZRfVDVLen19Z+kl6EfxzuajTiB9QI=;
 fh=qpO9RFBQ5NTQ9L28zv24/D3Htkr5HKEcyiLKuJxGTgE=;
 b=gJxucgqFxBh5C+LfL+gU1iUs9gS4c3BH8lsgHqiAmf3RsPEAyRm2GDkbddyTIc+vtr
 AFX4XkNcLGyvOJlKmy0rS6FiboO7UfZOMFGCm0Cceez/b2FBxf6CCPQpou01/GRIr9BL
 AWs1PzeoQ3EXsL7Gm3jhWwt2IUriI/KbeQeQCO+CKzF+MDbDFlKw1ud2F3LuT7Dag9zE
 yczaEBgzSKEOdLW1XIyMuKVkBz17iHI9gnydoedIkvB028eujkbdPRnGgS5TYSG1bIfs
 ug343RBKpT5AtqekIb7HNNRl/g6EZhsCYJBDWNhP7eP8/yLBEMJ0nvBwJI1frR9tusJx
 3eRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784745588; x=1785350388; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NtEJiIsjzHIffGZRfVDVLen19Z+kl6EfxzuajTiB9QI=;
 b=sZilkRKwWkIejFjcMFJA0YzNpu/Y+UVDDXCU2jmDCawb5h/ZUsQWqnjP5yflw5FbiI
 ZNd53CJSYUpH5jVo+YZ4TdObkcYLycmnUFYIlDTEF79lW+lnX6fLRktjfO5I4ukpsG/w
 UqxeOjybTqNdyuTvcpSsJWWiqPsX3/yi1Y/h1hf5mqIY5QetmE5hG9lS2CS8GcmqQml1
 Sc+ifOTJukVGVAygsYqvEXLNzVIuaQJw/JE4nasCtL4EayTinPO9SnCT8XLQ+iJViYKW
 3UpOZci4XONY8EtcI1zTvFiZuc7s5YWVngVT88nR0nysdRSL98Phd90DR1NjlnwVmsHG
 hGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745588; x=1785350388;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NtEJiIsjzHIffGZRfVDVLen19Z+kl6EfxzuajTiB9QI=;
 b=gl9GxjB8fV/OUrthcSO1IemBOwehiLC4ExElQmKhvSfp5iVSZtiGwZ9HVtrnY0dNE5
 JjXvt5HyHJlN3qKPjcTtQd3FXhFSY8hjoC9wp3dKSDb2z08kNAL8Ta5MFM+hDYphmmnc
 wlaxIAS86l2/JH+sfSRowFDlui1S8OiQT+d27dc//fElqfCckz0YY0HagshORViJwzLc
 CcJqHrb/LPvhz/KExblMM7d/Nys4Ln/CktQ8/UHHpkV7JunuTKAZS+/u16okZj+CoQPW
 DCUBp1zc3tOBuQNbILHXXBlU4yfH2iA5RIY3L22NEkhJ2WaMqGvjuGWFM9Eu6dv79eFu
 LeiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RruibGR5lLhoeJ35ockuPuJyUytDSvO/2i7DLMjf60uhVFOUt69hukVwE12wPIPfz23bwnl529/N/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCibyAU+zXpiwowl10rVopv3GaQKi9089rPGS/lbkL0MS62UUD
 UqXqMcnDTvI69kfGxlkzu5eFj42H5ngxWnb5EJHMlIs4BTbz0CjyndZBglW/tmbI1ZnA2Gwg/zf
 l+OjIzBYsKSY+LpI5OHPqKiut0dg4Sqo=
X-Gm-Gg: AR+sD13RAgmymz2HUWdapqpkwEsHIx1T1pr8yBRqo1vhv6gI1ssUAPhkvVTC/6BKefO
 lJLUuho93zdmzT4RmCVZ2yMPN1waFVddW4j9QtqbBDXOvGU2cesAhVnmtLSuawtf/VntlMsYNHA
 qNGACaAngwD75jAv/J6ySbZv+SPAtEKkIXqT57+9iZQJQ2C/NaHIOp/38NhVgX6VS3cWntKB76E
 4+1BXh+WBLsHFK9lHtfhaLFMNybjLUfHB2pSlbQtrWZj2zFmWbQ/SqfZiy3wM/xnoDgXGgNmPQA
 U8iSIPKYoRkN5EIOzUCE+srvzomIR7joR06PguibFPvgg63o
X-Received: by 2002:a05:690c:6903:b0:81e:bd02:b02c with SMTP id
 00721157ae682-81ef22e4828mr76243497b3.1.1784745587607; Wed, 22 Jul 2026
 11:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-2-talesam@gmail.com>
 <20260722181017.GF2327163@mdroper-desk1.amr.corp.intel.com>
In-Reply-To: <20260722181017.GF2327163@mdroper-desk1.amr.corp.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Wed, 22 Jul 2026 15:39:36 -0300
X-Gm-Features: AUfX_myjt1qIYvS7-JEyi7PtHUEq4RQ6hhRl4WmP77r2ZFcdpbyvtX2YI9Qp7A8
Message-ID: <CAHBRX4Ghmom2TLOkeXVYJtVua5ioaRka6wycS79pv9UkizfVRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] drm/xe/mcr: Keep GT forcewake during MCR steering
To: Matt Roper <matthew.d.roper@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, 
 rodrigo.vivi@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Hi Matt,

Thanks a lot for the context - and good to know this workaround had
already been prototyped on your side; that link is very helpful.

Understood regarding the platform policy (this is indeed a force_probe
setup on ARL).

Two questions to shape a possible v2:

1) Part of this patch is not the workaround itself: waiting for the
semaphore with a sleeping wait *before* taking the software spinlock
(instead of the 10us atomic spin inside it), and demoting the WARN
splat to a rate-limited GT error, both following i915. Would those be
acceptable on their own, with the forcewake hold (the actual
Wa_22018931422 part) dropped, or moved to the WA infrastructure gated
to the affected platforms?

2) If not, should I just drop this patch and keep 2-4? Patch 2 mirrors
i915's trivial resume-time sanitize, and 3-4 are platform-independent
CT/timeout robustness.

Happy to rework either way.

Thanks,
Tales

Em qua., 22 de jul. de 2026 =C3=A0s 15:10, Matt Roper
<matthew.d.roper@intel.com> escreveu:
>
> On Tue, Jul 21, 2026 at 09:46:51PM -0300, Tales A. Mendon=C3=A7a wrote:
> > On MTL and newer platforms xe uses STEER_SEMAPHORE to synchronize MCR
> > steering with external agents such as firmware. The current code waits
> > only 10us for the semaphore, while already holding the software MCR
> > spinlock, and fires drm_WARN_ON_ONCE() with a full stack trace when the
> > wait times out. On an Arrow Lake-P system this triggers during resume
> > while firmware still owns the semaphore:
> >
> >   drm_WARN_ON_ONCE(ret =3D=3D -110)
> >   WARNING: drivers/gpu/drm/xe/xe_gt_mcr.c:697 mcr_lock
> >
> > Port the i915 MCR locking model (intel_gt_mcr_lock/unlock) to xe:
> >
> > - Wait for the hardware semaphore before taking the software spinlock,
> >   so the wait may sleep instead of spinning inside the critical
> >   section.
> > - Allow up to 100ms for firmware to release the semaphore, matching
> >   i915.
> > - Demote the WARN stack to a rate-limited GT error, using the same
> >   message as i915 for easier cross-driver triage.
> > - Grab GT forcewake before touching the semaphore and hold it over the
> >   entire lock/steer/unlock cycle (Wa_22018931422). The steering
> >   registers are in an "always on" domain with respect to RC6, but are
> >   sensitive while higher-level platform sleep states are
> >   entering/exiting.
>
> This workaround only applies to specific platforms (MTL and ARL), but
> your implementation here is grabbing forcewake on all platforms, which
> we don't want to happen.  Workarounds should be implemented through the
> workaround layers of the driver (either RTP or OOB) so that they only
> apply on the specific platforms that need them.
>
> I did a previous implementation of this workaround a couple years ago:
>
> https://lore.kernel.org/all/20250114190242.2026743-2-matthew.d.roper@inte=
l.com/
>
> but we decided not to apply it because the Xe driver doesn't officially
> support MTL or ARL (using force_probe to force Xe to probe the device is
> only intended for driver developers, not end users).  Generally we only
> include workarounds in Xe for unsupported platforms like MTL/ARL if they
> also apply to one of the platforms that the driver is intended to
> support, or if the workaround is trivial (e.g., one extra RTP entry).
>
>
> Matt
>
> >
> > The GT resume/reset paths already hold XE_FORCEWAKE_ALL around their
> > MCR accesses, so the forcewake reference taken here is usually just a
> > refcount increment; it closes the Wa_22018931422 window for the
> > remaining callers (debugfs, OA, EU stall, etc.).
> >
> > mcr_lock() may now sleep; add might_sleep() to document and enforce
> > that contract. All current callers are in process context.
> >
> > Signed-off-by: Tales A. Mendon=C3=A7a <talesam@gmail.com>
> > ---
> >  drivers/gpu/drm/xe/xe_gt_mcr.c | 70 +++++++++++++++++++++++++---------
> >  1 file changed, 52 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_=
mcr.c
> > index a97b236dab7..e1e3c0688dc 100644
> > --- a/drivers/gpu/drm/xe/xe_gt_mcr.c
> > +++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
> > @@ -10,6 +10,8 @@
> >
> >  #include "regs/xe_gt_regs.h"
> >  #include "xe_assert.h"
> > +#include "xe_device.h"
> > +#include "xe_force_wake.h"
> >  #include "xe_gt_printk.h"
> >  #include "xe_gt_topology.h"
> >  #include "xe_gt_types.h"
> > @@ -58,6 +60,8 @@ enum {
> >       MCR_OP_WRITE
> >  };
> >
> > +#define MCR_STEER_SEMAPHORE_TIMEOUT_US       100000
> > +
> >  static const struct xe_mmio_range xelp_l3bank_steering_table[] =3D {
> >       { 0x00B100, 0x00B3FF },
> >       {},
> > @@ -692,33 +696,58 @@ bool xe_gt_mcr_get_nonterminated_steering(struct =
xe_gt *gt,
> >   * to synchronize with external clients (e.g., firmware), so a semapho=
re
> >   * register will also need to be taken.
> >   */
> > -static void mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
> > +static unsigned int mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_loc=
k)
> >  {
> >       struct xe_device *xe =3D gt_to_xe(gt);
> > +     unsigned int fw_ref =3D 0;
> >       int ret =3D 0;
> >
> > -     spin_lock(&gt->mcr_lock);
> > +     might_sleep();
> >
> >       /*
> >        * Starting with MTL we also need to grab a semaphore register
> >        * to synchronize with external agents (e.g., firmware) that now
> >        * shares the same steering control register. The semaphore is ob=
tained
> >        * when a read to the relevant register returns 1.
> > +      *
> > +      * The steering control and semaphore registers are inside an
> > +      * "always on" power domain with respect to RC6.  However there
> > +      * are some issues if higher-level platform sleep states are
> > +      * entering/exiting at the same time these registers are accessed=
.
> > +      * Grabbing GT forcewake and holding it over the entire
> > +      * lock/steer/unlock cycle ensures that those sleep states have
> > +      * fully exited before we access these registers, matching what
> > +      * i915 does in intel_gt_mcr_lock().
> > +      *
> > +      * Wa_22018931422
> >        */
> > -     if (GRAPHICS_VERx100(xe) >=3D 1270)
> > -             ret =3D xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0=
x1, 10, NULL,
> > -                                  true);
> > +     if (GRAPHICS_VERx100(xe) >=3D 1270) {
> > +             fw_ref =3D xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
> > +             if (!xe_force_wake_ref_has_domain(fw_ref, XE_FW_GT))
> > +                     xe_gt_err_ratelimited(gt, "failed to get MCR forc=
ewake\n");
> > +
> > +             ret =3D xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0=
x1,
> > +                                  MCR_STEER_SEMAPHORE_TIMEOUT_US, NULL=
,
> > +                                  false);
> > +     }
> > +
> > +     spin_lock(&gt->mcr_lock);
> > +
> > +     if (ret =3D=3D -ETIMEDOUT)
> > +             xe_gt_err_ratelimited(gt, "hardware MCR steering semaphor=
e timed out\n");
> >
> > -     xe_gt_WARN_ON_ONCE(gt, ret =3D=3D -ETIMEDOUT);
> > +     return fw_ref;
> >  }
> >
> > -static void mcr_unlock(struct xe_gt *gt) __releases(&gt->mcr_lock)
> > +static void mcr_unlock(struct xe_gt *gt, unsigned int fw_ref) __releas=
es(&gt->mcr_lock)
> >  {
> > +     spin_unlock(&gt->mcr_lock);
> > +
> >       /* Release hardware semaphore - this is done by writing 1 to the =
register */
> > -     if (GRAPHICS_VERx100(gt_to_xe(gt)) >=3D 1270)
> > +     if (GRAPHICS_VERx100(gt_to_xe(gt)) >=3D 1270) {
> >               xe_mmio_write32(&gt->mmio, STEER_SEMAPHORE, 0x1);
> > -
> > -     spin_unlock(&gt->mcr_lock);
> > +             xe_force_wake_put(gt_to_fw(gt), fw_ref);
> > +     }
> >  }
> >
> >  /*
> > @@ -807,10 +836,11 @@ u32 xe_gt_mcr_unicast_read_any(struct xe_gt *gt, =
struct xe_reg_mcr reg_mcr)
> >                                                    &group, &instance);
> >
> >       if (steer) {
> > -             mcr_lock(gt);
> > +             unsigned int fw_ref =3D mcr_lock(gt);
> > +
> >               val =3D rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ,
> >                                          group, instance, 0);
> > -             mcr_unlock(gt);
> > +             mcr_unlock(gt, fw_ref);
> >       } else {
> >               val =3D xe_mmio_read32(&gt->mmio, reg);
> >       }
> > @@ -832,13 +862,14 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
> >                          struct xe_reg_mcr reg_mcr,
> >                          int group, int instance)
> >  {
> > +     unsigned int fw_ref;
> >       u32 val;
> >
> >       xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
> >
> > -     mcr_lock(gt);
> > +     fw_ref =3D mcr_lock(gt);
> >       val =3D rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ, group, ins=
tance, 0);
> > -     mcr_unlock(gt);
> > +     mcr_unlock(gt, fw_ref);
> >
> >       return val;
> >  }
> > @@ -857,11 +888,13 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
> >  void xe_gt_mcr_unicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_m=
cr,
> >                            u32 value, int group, int instance)
> >  {
> > +     unsigned int fw_ref;
> > +
> >       xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
> >
> > -     mcr_lock(gt);
> > +     fw_ref =3D mcr_lock(gt);
> >       rw_with_mcr_steering(gt, reg_mcr, MCR_OP_WRITE, group, instance, =
value);
> > -     mcr_unlock(gt);
> > +     mcr_unlock(gt, fw_ref);
> >  }
> >
> >  /**
> > @@ -876,6 +909,7 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, st=
ruct xe_reg_mcr reg_mcr,
> >                              u32 value)
> >  {
> >       struct xe_reg reg =3D to_xe_reg(reg_mcr);
> > +     unsigned int fw_ref;
> >
> >       xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
> >
> > @@ -884,9 +918,9 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, st=
ruct xe_reg_mcr reg_mcr,
> >        * access, the MULTICAST bit should already be set, so there's no=
 need
> >        * to touch the steering register.
> >        */
> > -     mcr_lock(gt);
> > +     fw_ref =3D mcr_lock(gt);
> >       xe_mmio_write32(&gt->mmio, reg, value);
> > -     mcr_unlock(gt);
> > +     mcr_unlock(gt, fw_ref);
> >  }
> >
> >  void xe_gt_mcr_steering_dump(struct xe_gt *gt, struct drm_printer *p)
> > --
> > 2.55.0
> >
>
> --
> Matt Roper
> Graphics Software Engineer
> Linux GPU Platform Enablement
> Intel Corporation



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
