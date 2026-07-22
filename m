Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6251AC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AE910EFD6;
	Thu, 23 Jul 2026 07:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pbhKTwMO";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB89B10EE6C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:46:07 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-81ea0b7d137so101439357b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784742367; cv=none;
 d=google.com; s=arc-20260327;
 b=eEpKGEQ2ag3jNWCTrlxsezARhUhIuzU1eXHeL+yJ2mSgJUDSMjLE/Ugzq8kVPKaT3F
 CocqEkCOJxVPNvmkCKWUKbVhB1ny0qVmictijzEmnuB7xRb507LbLwlDHukBjDRO1CsS
 le0fB2gCYMUj5ZHmzuKk4f2lxQQDpT3z2nrUY1q6sq817lcFV+p+AOtmzoB5GzDIt9cg
 jMNlR2i+Oqjp7H+nwFFgAd4pJwj+xlmHsNKfqNd/m3rCvGLvldhcK3sD5g9VnbLFfgGd
 2HS+wBUyxxrRjZcZjWf3dNLfYVpH+O8OSDNSrqHFmSp3ZtP+iI8ayPWuJi3GxKWtaw99
 eAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NY0BPoPhydtdhrGuYU9lkB78bJBp+Q7loo84kGkYU5k=;
 fh=RHt77CxFI8VNyQoQZGD2p5fp2XohHPbsKAwEtyIE+Go=;
 b=kqqpoCMdfWI0O7ylhHy9WhwxM8K19z3BbeAvv6IkyLPIoFdxGZOKrS8fX+KxbCJeko
 GD9UL674cDRJCGvWOV5xpe3P20rovXnC5f6i/s4jFrU0J59ivW39Bu53TewlI5ZHIOtw
 lIEaIGb92RbXsx04oQxv4ui9xnSQ3C02ibPB+YpYWPIJkM9zf3YYQvTmHOLJqrDOclsg
 yiBQNLBOjhrkTt2VLWI/RNMBbCwag2yF7s34NJ9pw/E3GvlBQjPVfpC5TK7WkeolKvDJ
 M5Ae6fak+WyZVYNboCM7yWpuy/zmxr0jiqN8eLSZYRxE4QkjdEUcleLGZmNSsO5dkSPO
 9fjw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784742367; x=1785347167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NY0BPoPhydtdhrGuYU9lkB78bJBp+Q7loo84kGkYU5k=;
 b=pbhKTwMOgedqcRAQPCtalH1zt5fZCxwiQSejLc+UYnCZqBsl8eRdcatjM9Pr4G7HMn
 TTdkhBXY0AgWeiQbXuAJOU5mAGbFf8ZXTKNby/IUIjM9t9hKjEe0zW9RVT1BbbAS0UMd
 z+lFLNZOsLA2/aZCfFUmSCaFwdofpEFkRu2iC36JSNA9j776zb5uWemFnRNPrEaVYe5O
 Lu3ATJVIbsn19UBaU2UcfvpHd5ztrZuvgzy/qKFos7KBf14wdNaBxNgbt2zVQ+QnNY34
 P0rUjPlIvsIdmkQ89h78O+4APgI3PqWtxW3OEIvQsT7/Dn9ymQgrpz4m+914LDxYb4QC
 PG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784742367; x=1785347167;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NY0BPoPhydtdhrGuYU9lkB78bJBp+Q7loo84kGkYU5k=;
 b=NHYQIdYQSDi9v0i34VucAITgcxfoPNH5tgey4CmEw7IBhLp12WdqTewJc+gORKn1kk
 +TQGSConmYJz1XW+UEiUMaMnYARc1Em28sM9PkvwZYrPA3yR+3MvPFzLRwD2KpEBrB2x
 kcyBtv5ba9016Nre05dDv3ZuqUsr3uAwUhhAp2UntVpgGZ2COdOCoUHIB3E2Z5AbLE/A
 a3GLBPaQCkrKrsjkY4WJC86uWRzj4KIARGfEzlJQSvFSTw0dT7U8QhzRYtNFKtD9ZBK+
 jvhhFbaFpgtR8B9HQSh8ob+K4ejRdWbVn070vy8qBR5uA+GTP3w/7AvQPXG5YdwTUkC3
 DWHw==
X-Gm-Message-State: AOJu0YzPeNG7LmDUYpnp9vdO+owpCjQOtDapz7rXDo7UXp1qKKN9k9uH
 dQfsLhsdopafy7L05S9cbCZVy7UhQpdGns4lM2izbjIfVK4Ru4O2Zh5BLhtnONY3lVbq+3HCFiK
 knvhVu0NDNTTsHK+RY+FJFeR7u9h0xU0=
X-Gm-Gg: AR+sD13v6VjbuAuMnNsS1kNCMAufHmYAMbkXEKKqzJuupzdvt1162Igwko949rKqQws
 ktsLhGqh4gkKeOB7KwypQbTRnxiRZ5jrcYH2FjY0sN9O8i085IZxP+5WYFesASf5m9EGwtsb2v9
 mhv1tQ26LtVye/qilXH51X296m5PCKihB1T58QbmljbYzjfX5ZL9sVBCEftZOYwPAm3X64aY/Ds
 RRkVeBtv1f6RqCDNBlUabqrfdP+tp7fNIr1wM0v0kAve5yWEprM4v5W2RIJaskJ2KecNwH2zAaW
 zqNrMJpO1v2s4vpR621OEWPxfZ7eIE7FcBf6IZCaBg1eq2UR
X-Received: by 2002:a05:690c:d95:b0:81e:6b13:4463 with SMTP id
 00721157ae682-81ef28589dfmr73888517b3.46.1784742366645; Wed, 22 Jul 2026
 10:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-2-talesam@gmail.com>
In-Reply-To: <20260722004654.744249-2-talesam@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Wed, 22 Jul 2026 14:45:54 -0300
X-Gm-Features: AUfX_mwbV_Fjr2pW0jOY4oQceeRdMWcX52TH3s2sOUlieXpWSymoMYR2XNGkDY0
Message-ID: <CAHBRX4EmGgHtxzGVqgCFQesZmh1b7mjujgvybwFsW5X9t4FbZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] drm/xe/mcr: Keep GT forcewake during MCR steering
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
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

Thanks for the review.

  Agreed - the capture list locking concern is in xe_guc_capture.c and
pre-dates this patch, which only touches the MCR steering lock path.
  It seems worth tracking separately; I can file a report for it.

Em ter., 21 de jul. de 2026 =C3=A0s 21:47, Tales A. Mendon=C3=A7a
<talesam@gmail.com> escreveu:
>
> On MTL and newer platforms xe uses STEER_SEMAPHORE to synchronize MCR
> steering with external agents such as firmware. The current code waits
> only 10us for the semaphore, while already holding the software MCR
> spinlock, and fires drm_WARN_ON_ONCE() with a full stack trace when the
> wait times out. On an Arrow Lake-P system this triggers during resume
> while firmware still owns the semaphore:
>
>   drm_WARN_ON_ONCE(ret =3D=3D -110)
>   WARNING: drivers/gpu/drm/xe/xe_gt_mcr.c:697 mcr_lock
>
> Port the i915 MCR locking model (intel_gt_mcr_lock/unlock) to xe:
>
> - Wait for the hardware semaphore before taking the software spinlock,
>   so the wait may sleep instead of spinning inside the critical
>   section.
> - Allow up to 100ms for firmware to release the semaphore, matching
>   i915.
> - Demote the WARN stack to a rate-limited GT error, using the same
>   message as i915 for easier cross-driver triage.
> - Grab GT forcewake before touching the semaphore and hold it over the
>   entire lock/steer/unlock cycle (Wa_22018931422). The steering
>   registers are in an "always on" domain with respect to RC6, but are
>   sensitive while higher-level platform sleep states are
>   entering/exiting.
>
> The GT resume/reset paths already hold XE_FORCEWAKE_ALL around their
> MCR accesses, so the forcewake reference taken here is usually just a
> refcount increment; it closes the Wa_22018931422 window for the
> remaining callers (debugfs, OA, EU stall, etc.).
>
> mcr_lock() may now sleep; add might_sleep() to document and enforce
> that contract. All current callers are in process context.
>
> Signed-off-by: Tales A. Mendon=C3=A7a <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_gt_mcr.c | 70 +++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mc=
r.c
> index a97b236dab7..e1e3c0688dc 100644
> --- a/drivers/gpu/drm/xe/xe_gt_mcr.c
> +++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
> @@ -10,6 +10,8 @@
>
>  #include "regs/xe_gt_regs.h"
>  #include "xe_assert.h"
> +#include "xe_device.h"
> +#include "xe_force_wake.h"
>  #include "xe_gt_printk.h"
>  #include "xe_gt_topology.h"
>  #include "xe_gt_types.h"
> @@ -58,6 +60,8 @@ enum {
>         MCR_OP_WRITE
>  };
>
> +#define MCR_STEER_SEMAPHORE_TIMEOUT_US 100000
> +
>  static const struct xe_mmio_range xelp_l3bank_steering_table[] =3D {
>         { 0x00B100, 0x00B3FF },
>         {},
> @@ -692,33 +696,58 @@ bool xe_gt_mcr_get_nonterminated_steering(struct xe=
_gt *gt,
>   * to synchronize with external clients (e.g., firmware), so a semaphore
>   * register will also need to be taken.
>   */
> -static void mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
> +static unsigned int mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
>  {
>         struct xe_device *xe =3D gt_to_xe(gt);
> +       unsigned int fw_ref =3D 0;
>         int ret =3D 0;
>
> -       spin_lock(&gt->mcr_lock);
> +       might_sleep();
>
>         /*
>          * Starting with MTL we also need to grab a semaphore register
>          * to synchronize with external agents (e.g., firmware) that now
>          * shares the same steering control register. The semaphore is ob=
tained
>          * when a read to the relevant register returns 1.
> +        *
> +        * The steering control and semaphore registers are inside an
> +        * "always on" power domain with respect to RC6.  However there
> +        * are some issues if higher-level platform sleep states are
> +        * entering/exiting at the same time these registers are accessed=
.
> +        * Grabbing GT forcewake and holding it over the entire
> +        * lock/steer/unlock cycle ensures that those sleep states have
> +        * fully exited before we access these registers, matching what
> +        * i915 does in intel_gt_mcr_lock().
> +        *
> +        * Wa_22018931422
>          */
> -       if (GRAPHICS_VERx100(xe) >=3D 1270)
> -               ret =3D xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0=
x1, 10, NULL,
> -                                    true);
> +       if (GRAPHICS_VERx100(xe) >=3D 1270) {
> +               fw_ref =3D xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
> +               if (!xe_force_wake_ref_has_domain(fw_ref, XE_FW_GT))
> +                       xe_gt_err_ratelimited(gt, "failed to get MCR forc=
ewake\n");
> +
> +               ret =3D xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0=
x1,
> +                                    MCR_STEER_SEMAPHORE_TIMEOUT_US, NULL=
,
> +                                    false);
> +       }
> +
> +       spin_lock(&gt->mcr_lock);
> +
> +       if (ret =3D=3D -ETIMEDOUT)
> +               xe_gt_err_ratelimited(gt, "hardware MCR steering semaphor=
e timed out\n");
>
> -       xe_gt_WARN_ON_ONCE(gt, ret =3D=3D -ETIMEDOUT);
> +       return fw_ref;
>  }
>
> -static void mcr_unlock(struct xe_gt *gt) __releases(&gt->mcr_lock)
> +static void mcr_unlock(struct xe_gt *gt, unsigned int fw_ref) __releases=
(&gt->mcr_lock)
>  {
> +       spin_unlock(&gt->mcr_lock);
> +
>         /* Release hardware semaphore - this is done by writing 1 to the =
register */
> -       if (GRAPHICS_VERx100(gt_to_xe(gt)) >=3D 1270)
> +       if (GRAPHICS_VERx100(gt_to_xe(gt)) >=3D 1270) {
>                 xe_mmio_write32(&gt->mmio, STEER_SEMAPHORE, 0x1);
> -
> -       spin_unlock(&gt->mcr_lock);
> +               xe_force_wake_put(gt_to_fw(gt), fw_ref);
> +       }
>  }
>
>  /*
> @@ -807,10 +836,11 @@ u32 xe_gt_mcr_unicast_read_any(struct xe_gt *gt, st=
ruct xe_reg_mcr reg_mcr)
>                                                      &group, &instance);
>
>         if (steer) {
> -               mcr_lock(gt);
> +               unsigned int fw_ref =3D mcr_lock(gt);
> +
>                 val =3D rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ,
>                                            group, instance, 0);
> -               mcr_unlock(gt);
> +               mcr_unlock(gt, fw_ref);
>         } else {
>                 val =3D xe_mmio_read32(&gt->mmio, reg);
>         }
> @@ -832,13 +862,14 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
>                            struct xe_reg_mcr reg_mcr,
>                            int group, int instance)
>  {
> +       unsigned int fw_ref;
>         u32 val;
>
>         xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
>
> -       mcr_lock(gt);
> +       fw_ref =3D mcr_lock(gt);
>         val =3D rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ, group, ins=
tance, 0);
> -       mcr_unlock(gt);
> +       mcr_unlock(gt, fw_ref);
>
>         return val;
>  }
> @@ -857,11 +888,13 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
>  void xe_gt_mcr_unicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr=
,
>                              u32 value, int group, int instance)
>  {
> +       unsigned int fw_ref;
> +
>         xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
>
> -       mcr_lock(gt);
> +       fw_ref =3D mcr_lock(gt);
>         rw_with_mcr_steering(gt, reg_mcr, MCR_OP_WRITE, group, instance, =
value);
> -       mcr_unlock(gt);
> +       mcr_unlock(gt, fw_ref);
>  }
>
>  /**
> @@ -876,6 +909,7 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, stru=
ct xe_reg_mcr reg_mcr,
>                                u32 value)
>  {
>         struct xe_reg reg =3D to_xe_reg(reg_mcr);
> +       unsigned int fw_ref;
>
>         xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
>
> @@ -884,9 +918,9 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, stru=
ct xe_reg_mcr reg_mcr,
>          * access, the MULTICAST bit should already be set, so there's no=
 need
>          * to touch the steering register.
>          */
> -       mcr_lock(gt);
> +       fw_ref =3D mcr_lock(gt);
>         xe_mmio_write32(&gt->mmio, reg, value);
> -       mcr_unlock(gt);
> +       mcr_unlock(gt, fw_ref);
>  }
>
>  void xe_gt_mcr_steering_dump(struct xe_gt *gt, struct drm_printer *p)
> --
> 2.55.0
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
