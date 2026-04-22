Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5C2F94CCF
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 06:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D2610E716;
	Wed, 22 Apr 2026 06:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aN1GEFoH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB80E10E7F2;
 Wed, 22 Apr 2026 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776839109; x=1808375109;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8+N+fKv7H2h5VOO+Z+El8qnaR3Ry59uYnjVpAB5dqX4=;
 b=aN1GEFoH4YnM4odfCJzRKwBJBVnfCysjZTYaAj5es8BPZOY20QZXN2S9
 onrYZxvp1AXxCdq2D/doPTNw/Kd9q5qk97S/h4KBMQR8asPL8lsRHR0kT
 K/wFD70stm36mPt5kus8439iHyJuvjjKZ6zj5bYNhmA3OVfcJ/5X+oDon
 BKf9p/d3/e7m6DRz3cpDz54J/Xw51RmkDbSXdCQGyREam0msHZGKNmTQB
 YdshpixuJxhQdLZEbWqEypsBksg6GTMxZFAQLywMRAat25fKFxJ+fWP5J
 uVLBQJWdJEEb7bkN49YnGYSjpGw7+xWgUBgOs1UHCRgG8ZrtvSwsEYoJv A==;
X-CSE-ConnectionGUID: LCwXx4tNR7aCjGwJMaSN+g==
X-CSE-MsgGUID: Xz5DjwlHTYaZIu5Fnd0YVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="95198575"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="95198575"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 23:25:08 -0700
X-CSE-ConnectionGUID: 5xau1z2JT+m3G+MrMCF//A==
X-CSE-MsgGUID: C3Q3kNx0RVS1Mq4uVTmnqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="237302928"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 23:25:04 -0700
Date: Wed, 22 Apr 2026 08:25:01 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 maarten@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
 rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v1 05/11] drm/xe/sysctrl: Add system controller interrupt
 handler
Message-ID: <aehpvfbxFX9V3_i3@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-6-raag.jadav@intel.com>
 <c5ae7bab-ee42-430f-abf1-e062439c1356@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ae7bab-ee42-430f-abf1-e062439c1356@intel.com>
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

On Wed, Apr 22, 2026 at 11:25:44AM +0530, Tauro, Riana wrote:
> On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > Add system controller interrupt handler which is denoted by 11th bit in
> > GFX master interrupt register. While at it, add worker for scheduling
> > system controller work.
> 
> Why do we need this series in the threshold patch. From what i see, we need
> only structures
> Can't we only redefine those here?
> 
> I know you will have to rebase again once any patch is merged. But this is
> unnecessary noise
> for the drm patch.

We have threshold crossed event so I thought it was relevant here. We can
merge it independently if you're okay with it.

Raag

> > Co-developed-by: Soham Purkait <soham.purkait@intel.com>
> > Signed-off-by: Soham Purkait <soham.purkait@intel.com>
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> > Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> > ---
> >   drivers/gpu/drm/xe/regs/xe_irq_regs.h |  1 +
> >   drivers/gpu/drm/xe/xe_irq.c           |  2 ++
> >   drivers/gpu/drm/xe/xe_sysctrl.c       | 35 +++++++++++++++++++++------
> >   drivers/gpu/drm/xe/xe_sysctrl.h       |  1 +
> >   drivers/gpu/drm/xe/xe_sysctrl_types.h |  4 +++
> >   5 files changed, 36 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/regs/xe_irq_regs.h b/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> > index 9d74f454d3ff..1d6b976c4de0 100644
> > --- a/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> > +++ b/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> > @@ -22,6 +22,7 @@
> >   #define   DISPLAY_IRQ				REG_BIT(16)
> >   #define   SOC_H2DMEMINT_IRQ			REG_BIT(13)
> >   #define   I2C_IRQ				REG_BIT(12)
> > +#define   SYSCTRL_IRQ				REG_BIT(11)
> >   #define   GT_DW_IRQ(x)				REG_BIT(x)
> >   /*
> > diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> > index 9a775c6588dc..e9f0b3cad06d 100644
> > --- a/drivers/gpu/drm/xe/xe_irq.c
> > +++ b/drivers/gpu/drm/xe/xe_irq.c
> > @@ -24,6 +24,7 @@
> >   #include "xe_mmio.h"
> >   #include "xe_pxp.h"
> >   #include "xe_sriov.h"
> > +#include "xe_sysctrl.h"
> >   #include "xe_tile.h"
> >   /*
> > @@ -525,6 +526,7 @@ static irqreturn_t dg1_irq_handler(int irq, void *arg)
> >   				xe_heci_csc_irq_handler(xe, master_ctl);
> >   			xe_display_irq_handler(xe, master_ctl);
> >   			xe_i2c_irq_handler(xe, master_ctl);
> > +			xe_sysctrl_irq_handler(xe, master_ctl);
> >   			xe_mert_irq_handler(xe, master_ctl);
> >   			gu_misc_iir = gu_misc_irq_ack(xe, master_ctl);
> >   		}
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl.c b/drivers/gpu/drm/xe/xe_sysctrl.c
> > index 2bcef304eb9a..7de3e73bd8e0 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl.c
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl.c
> > @@ -8,6 +8,7 @@
> >   #include <drm/drm_managed.h>
> > +#include "regs/xe_irq_regs.h"
> >   #include "regs/xe_sysctrl_regs.h"
> >   #include "xe_device.h"
> >   #include "xe_mmio.h"
> > @@ -30,10 +31,16 @@
> >   static void sysctrl_fini(void *arg)
> >   {
> >   	struct xe_device *xe = arg;
> > +	struct xe_sysctrl *sc = &xe->sc;
> > +	disable_work_sync(&sc->work);
> >   	xe->soc_remapper.set_sysctrl_region(xe, 0);
> >   }
> > +static void xe_sysctrl_work(struct work_struct *work)
> > +{
> > +}
> > +
> >   /**
> >    * xe_sysctrl_init() - Initialize System Controller subsystem
> >    * @xe: xe device instance
> > @@ -55,12 +62,6 @@ int xe_sysctrl_init(struct xe_device *xe)
> >   	if (!xe->info.has_sysctrl)
> >   		return 0;
> > -	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
> > -
> > -	ret = devm_add_action_or_reset(xe->drm.dev, sysctrl_fini, xe);
> > -	if (ret)
> > -		return ret;
> > -
> >   	sc->mmio = devm_kzalloc(xe->drm.dev, sizeof(*sc->mmio), GFP_KERNEL);
> >   	if (!sc->mmio)
> >   		return -ENOMEM;
> > @@ -73,9 +74,29 @@ int xe_sysctrl_init(struct xe_device *xe)
> >   	if (ret)
> >   		return ret;
> > +	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
> >   	xe_sysctrl_mailbox_init(sc);
> > +	INIT_WORK(&sc->work, xe_sysctrl_work);
> > -	return 0;
> > +	return devm_add_action_or_reset(xe->drm.dev, sysctrl_fini, xe);
> > +}
> > +
> > +/**
> > + * xe_sysctrl_irq_handler() - Handler for System Controller interrupts
> > + * @xe: xe device instance
> > + * @master_ctl: interrupt register
> > + *
> > + * Handle interrupts generated by System Controller.
> > + */
> > +void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl)
> > +{
> > +	struct xe_sysctrl *sc = &xe->sc;
> > +
> > +	if (!xe->info.has_sysctrl || !sc->work.func)
> > +		return;
> > +
> > +	if (master_ctl & SYSCTRL_IRQ)
> > +		schedule_work(&sc->work);
> >   }
> >   /**
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl.h b/drivers/gpu/drm/xe/xe_sysctrl.h
> > index f3b0f3716b2f..f7469bfc9324 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl.h
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl.h
> > @@ -17,6 +17,7 @@ static inline struct xe_device *sc_to_xe(struct xe_sysctrl *sc)
> >   }
> >   int xe_sysctrl_init(struct xe_device *xe);
> > +void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl);
> >   void xe_sysctrl_pm_resume(struct xe_device *xe);
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl_types.h b/drivers/gpu/drm/xe/xe_sysctrl_types.h
> > index 8217f6befe70..5f408d6491ef 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl_types.h
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl_types.h
> > @@ -8,6 +8,7 @@
> >   #include <linux/mutex.h>
> >   #include <linux/types.h>
> > +#include <linux/workqueue_types.h>
> >   struct xe_mmio;
> > @@ -27,6 +28,9 @@ struct xe_sysctrl {
> >   	/** @phase_bit: Message boundary phase toggle bit (0 or 1) */
> >   	bool phase_bit;
> > +
> > +	/** @work: Pending events worker */
> > +	struct work_struct work;
> >   };
> >   #endif
