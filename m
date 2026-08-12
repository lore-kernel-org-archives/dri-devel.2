Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083CDC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4E910EF04;
	Wed, 12 Aug 2026 09:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q6z2quvp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7DA10EF04;
 Wed, 12 Aug 2026 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786525613; x=1818061613;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=Qx0OD7N8fR4RoI994yDtaotPNUvi+xj1ddSBuBNwiv0=;
 b=Q6z2quvp/X3QLhtqAnq1NghDQzRkOdvdrPaVFBKPBCfn+MgOKSR5rGB8
 mKcAdXfonuzxApfJinekLc3wSdkdYDi3s+qvobJOYE/79haKyF0jr+M0S
 PX49az9cdHHblJvE2/ZioRtw9MHXQ3Qvz0M3oBJU1WrMQ9pKUIktJ3UGC
 JQSAf2igw/XLga2sUyH0+pNXGdtjGW3TeGYmP35/YNVKRMq3D5OUwqcD0
 HVvlpG7BDgY5lAsZn4pjc8B+vCI6HFDX5MzNGQ5+1vLOKx7UFlAD0qsl1
 /hTa2dmvZCO53AfcgXbr9Bm2G2sJtBUt6Ys9sF6/yO5eXUey3zKjEpNor Q==;
X-CSE-ConnectionGUID: z1fKL/USTiGqdUk+ZHRV6Q==
X-CSE-MsgGUID: pq2E5OFXS+WPvErorjaY8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98430926"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="98430926"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:06:53 -0700
X-CSE-ConnectionGUID: wS+t9YkyQ8irymKV65XIPg==
X-CSE-MsgGUID: uo0MK6N/QtiG2Qf+YNAPTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="263631249"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.141])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:06:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>, intel-gfx@lists.freedesktop.org
Cc: matthew.brost@intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net,
 dri-devel@lists.freedesktop.org, weifeng.liu@intel.com
Subject: Re: [PATCH] drm/i915: Make suspend idle wait uninterruptible
In-Reply-To: <ee7f26285f8ca8a8993f8cb62b4d893e4106b10c.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260805064539.1034880-1-weifeng.liu.z@gmail.com>
 <ee7f26285f8ca8a8993f8cb62b4d893e4106b10c.camel@gmail.com>
Date: Wed, 12 Aug 2026 12:06:47 +0300
Message-ID: <c0cc3364b35c8648df3ff407606cf13835eb449f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Wed, 12 Aug 2026, Weifeng Liu <weifeng.liu.z@gmail.com> wrote:
> Gentle ping. I would like to provide some additional context about the
> issue this patch is trying to fix.

Have you filed a bug over at [1]? If not, please do, and add the
information there, with logs, and point at this thread too.

Thanks,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html




>
> A customer observed a shutdown hang in an automated S3 resume and
> power-off test. This issue occurs after resuming from S3 and later
> starting the power-off sequence. During process teardown, i915 reports
> GuC CT errors such as:
>
>   i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: CT: Unsolicited response
> message: len 1, data 0xe0000100 (fence 2941, last 2945)
>   i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: CT: Failed to handle HXG
> message (-ENOKEY) 00 01 00 e0
>   i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: CT: Failed to process CT
> message (-ENOKEY) 01 00 7d 0b 00 01 00 e0
>
> No rendering or display failure was observed before shutdown. The GuC
> error appears to be related to inconsistent context state after S3, but
> this patch does not attempt to fix that underlying issue; I focused on
> fixing the shutdown hang issue currently.
>
> With initcall_debug enabled, the last device shutdown message is:
>
>   i915 0000:00:02.0: shutdown
>
> and device_shutdown() does not make further progress.
>
> While investigating this hang, I found that wait_for_suspend() assumes
> that intel_gt_wait_for_idle() either succeeds or returns -ETIME.
> However, the request retirement and GuC pending-message waits are
> interruptible and may return -EINTR or -ERESTARTSYS when the shutdown
> task has a pending signal. These errors bypass the existing wedge and
> cleanup path, after which wait_for_suspend() may block waiting for a GT
> wakeref that cannot be released.
>
> As a diagnostic experiment, adding a timeout to
> intel_wakeref_wait_for_idle() allowed the power-off sequence to
> complete consistently. I did not propose that approach upstream because
> continuing suspend with an active GT would weaken the existing suspend
> invariant.
>
> Instead, this patch makes only GT idle wait used by wait_for_suspend()
> uninterruptible. It retains the existing timeout and wedges the GT only
> if that timeout expires. All other intel_gt_wait_for_idle() callers
> remain interruptible.
>
> Does this approach look reasonable, or would you prefer a different way
> to prevent signals from bypassing the existing timeout recovery path?
>
> And I'll be very grateful if you can provide some hints about the root
> cause of the GuC error.
>
> Best regards,
> Weifeng
>
> On Wed, 2026-08-05 at 14:45 +0800, Weifeng Liu wrote:
>> wait_for_suspend() only handles -ETIME from the GT idle wait.
>> However,
>> the wait can also be interrupted by a pending signal while retiring
>> requests or waiting for GuC messages, e.g., during the reboot process
>> invoked by init. This skips the wedge and cleanup path and may leave
>> suspend waiting indefinitely for a leaked wakeref.
>>=20
>> Make only the suspend idle wait uninterruptible while preserving its
>> existing timeout. Other callers remain interruptible, and the GT is
>> still wedged only when the timeout expires.
>>=20
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Assisted-by: OpenCode:GPT-5.6-Sol
>> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
>> ---
>> =C2=A0drivers/gpu/drm/i915/gt/intel_gt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++++++++++++++--
>> --
>> =C2=A0drivers/gpu/drm/i915/gt/intel_gt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0drivers/gpu/drm/i915/gt/intel_gt_pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>> =C2=A0drivers/gpu/drm/i915/gt/intel_gt_requests.c=C2=A0=C2=A0 |=C2=A0 8 =
++++---
>> =C2=A0drivers/gpu/drm/i915/gt/intel_gt_requests.h=C2=A0=C2=A0 | 13 +++++=
+++--
>> =C2=A0drivers/gpu/drm/i915/gt/uc/intel_guc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>> =C2=A0.../gpu/drm/i915/gt/uc/intel_guc_submission.c |=C2=A0 5 ++--
>> =C2=A0drivers/gpu/drm/i915/gt/uc/intel_uc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++--
>> =C2=A08 files changed, 47 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c
>> b/drivers/gpu/drm/i915/gt/intel_gt.c
>> index 5c7f862f7100..5eaa52f535d4 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
>> @@ -659,7 +659,9 @@ static void __intel_gt_disable(struct intel_gt
>> *gt)
>> =C2=A0	GEM_BUG_ON(intel_gt_pm_is_awake(gt));
>> =C2=A0}
>> =C2=A0
>> -int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
>> +static int __intel_gt_wait_for_idle(struct intel_gt *gt,
>> +				=C2=A0=C2=A0=C2=A0 bool interruptible,
>> +				=C2=A0=C2=A0=C2=A0 long timeout)
>> =C2=A0{
>> =C2=A0	long remaining_timeout;
>> =C2=A0
>> @@ -667,10 +669,11 @@ int intel_gt_wait_for_idle(struct intel_gt *gt,
>> long timeout)
>> =C2=A0	if (!intel_gt_pm_is_awake(gt))
>> =C2=A0		return 0;
>> =C2=A0
>> -	while ((timeout =3D intel_gt_retire_requests_timeout(gt,
>> timeout,
>> -							=C2=A0=C2=A0
>> &remaining_timeout)) > 0) {
>> +	while ((timeout =3D __intel_gt_retire_requests_timeout(gt,
>> interruptible,
>> +							=C2=A0=C2=A0=C2=A0=C2=A0
>> timeout,
>> +							=C2=A0=C2=A0=C2=A0=C2=A0
>> &remaining_timeout)) > 0) {
>> =C2=A0		cond_resched();
>> -		if (signal_pending(current))
>> +		if (interruptible && signal_pending(current))
>> =C2=A0			return -EINTR;
>> =C2=A0	}
>> =C2=A0
>> @@ -680,7 +683,18 @@ int intel_gt_wait_for_idle(struct intel_gt *gt,
>> long timeout)
>> =C2=A0	if (remaining_timeout < 0)
>> =C2=A0		remaining_timeout =3D 0;
>> =C2=A0
>> -	return intel_uc_wait_for_idle(&gt->uc, remaining_timeout);
>> +	return intel_uc_wait_for_idle(&gt->uc, interruptible,
>> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remaining_timeout);
>> +}
>> +
>> +int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
>> +{
>> +	return __intel_gt_wait_for_idle(gt, true, timeout);
>> +}
>> +
>> +int intel_gt_wait_for_idle_uninterruptible(struct intel_gt *gt, long
>> timeout)
>> +{
>> +	return __intel_gt_wait_for_idle(gt, false, timeout);
>> =C2=A0}
>> =C2=A0
>> =C2=A0int intel_gt_init(struct intel_gt *gt)
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h
>> b/drivers/gpu/drm/i915/gt/intel_gt.h
>> index 998ca029b73a..6c7e5415f1dc 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt.h
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt.h
>> @@ -143,6 +143,7 @@ void intel_gt_driver_release(struct intel_gt
>> *gt);
>> =C2=A0void intel_gt_driver_late_release_all(struct drm_i915_private
>> *i915);
>> =C2=A0
>> =C2=A0int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout);
>> +int intel_gt_wait_for_idle_uninterruptible(struct intel_gt *gt, long
>> timeout);
>> =C2=A0
>> =C2=A0void intel_gt_check_and_clear_faults(struct intel_gt *gt);
>> =C2=A0i915_reg_t intel_gt_perf_limit_reasons_reg(struct intel_gt *gt);
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.c
>> b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
>> index c7f59d60fac6..9fe31aa07ae8 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt_pm.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
>> @@ -315,7 +315,8 @@ static void wait_for_suspend(struct intel_gt *gt)
>> =C2=A0	if (!intel_gt_pm_is_awake(gt))
>> =C2=A0		return;
>> =C2=A0
>> -	if (intel_gt_wait_for_idle(gt, I915_GT_SUSPEND_IDLE_TIMEOUT)
>> =3D=3D -ETIME) {
>> +	if (intel_gt_wait_for_idle_uninterruptible(gt,
>> +						=C2=A0=C2=A0
>> I915_GT_SUSPEND_IDLE_TIMEOUT) =3D=3D -ETIME) {
>> =C2=A0		/*
>> =C2=A0		 * Forcibly cancel outstanding work and leave
>> =C2=A0		 * the gpu quiet.
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> index 93298820bee2..b37e8f1d0b5c 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> @@ -130,8 +130,10 @@ void intel_engine_fini_retire(struct
>> intel_engine_cs *engine)
>> =C2=A0	GEM_BUG_ON(engine->retire);
>> =C2=A0}
>> =C2=A0
>> -long intel_gt_retire_requests_timeout(struct intel_gt *gt, long
>> timeout,
>> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long *remaining_timeout)
>> +long __intel_gt_retire_requests_timeout(struct intel_gt *gt,
>> +					bool interruptible,
>> +					long timeout,
>> +					long *remaining_timeout)
>> =C2=A0{
>> =C2=A0	struct intel_gt_timelines *timelines =3D &gt->timelines;
>> =C2=A0	struct intel_timeline *tl, *tn;
>> @@ -159,7 +161,7 @@ long intel_gt_retire_requests_timeout(struct
>> intel_gt *gt, long timeout,
>> =C2=A0				mutex_unlock(&tl->mutex);
>> =C2=A0
>> =C2=A0				timeout =3D
>> dma_fence_wait_timeout(fence,
>> -=09=09=09=09=09=09=09=09
>> true,
>> +=09=09=09=09=09=09=09=09
>> interruptible,
>> =C2=A0=09=09=09=09=09=09=09=09
>> timeout);
>> =C2=A0				dma_fence_put(fence);
>> =C2=A0
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.h
>> b/drivers/gpu/drm/i915/gt/intel_gt_requests.h
>> index d2969f68dd64..9242f85f4040 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt_requests.h
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.h
>> @@ -12,8 +12,17 @@ struct intel_engine_cs;
>> =C2=A0struct intel_gt;
>> =C2=A0struct intel_timeline;
>> =C2=A0
>> -long intel_gt_retire_requests_timeout(struct intel_gt *gt, long
>> timeout,
>> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long *remaining_timeout);
>> +long __intel_gt_retire_requests_timeout(struct intel_gt *gt,
>> +					bool interruptible,
>> +					long timeout,
>> +					long *remaining_timeout);
>> +static inline long
>> +intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout,
>> +				 long *remaining_timeout)
>> +{
>> +	return __intel_gt_retire_requests_timeout(gt, true, timeout,
>> +						=C2=A0=C2=A0=C2=A0
>> remaining_timeout);
>> +}
>> =C2=A0static inline void intel_gt_retire_requests(struct intel_gt *gt)
>> =C2=A0{
>> =C2=A0	intel_gt_retire_requests_timeout(gt, 0, NULL);
>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
>> b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
>> index 053780f562c1..b5f4fddf5c1d 100644
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
>> @@ -509,7 +509,8 @@ static inline void intel_guc_disable_msg(struct
>> intel_guc *guc, u32 mask)
>> =C2=A0	spin_unlock_irq(&guc->irq_lock);
>> =C2=A0}
>> =C2=A0
>> -int intel_guc_wait_for_idle(struct intel_guc *guc, long timeout);
>> +int intel_guc_wait_for_idle(struct intel_guc *guc, bool
>> interruptible,
>> +			=C2=A0=C2=A0=C2=A0 long timeout);
>> =C2=A0
>> =C2=A0int intel_guc_deregister_done_process_msg(struct intel_guc *guc,
>> =C2=A0					=C2=A0 const u32 *msg, u32 len);
>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> index 788e59cdfac9..aa74208c2b4e 100644
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> @@ -680,14 +680,15 @@ int intel_guc_wait_for_pending_msg(struct
>> intel_guc *guc,
>> =C2=A0	return (timeout < 0) ? timeout : 0;
>> =C2=A0}
>> =C2=A0
>> -int intel_guc_wait_for_idle(struct intel_guc *guc, long timeout)
>> +int intel_guc_wait_for_idle(struct intel_guc *guc, bool
>> interruptible,
>> +			=C2=A0=C2=A0=C2=A0 long timeout)
>> =C2=A0{
>> =C2=A0	if (!intel_uc_uses_guc_submission(&guc_to_gt(guc)->uc))
>> =C2=A0		return 0;
>> =C2=A0
>> =C2=A0	return intel_guc_wait_for_pending_msg(guc,
>> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &guc-
>> >outstanding_submission_g2h,
>> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true, timeout);
>> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interruptible,
>> timeout);
>> =C2=A0}
>> =C2=A0
>> =C2=A0static int guc_context_policy_init_v70(struct intel_context *ce,
>> bool loop);
>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc.h
>> b/drivers/gpu/drm/i915/gt/uc/intel_uc.h
>> index 014bb7d83689..b62fe3b96b64 100644
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_uc.h
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_uc.h
>> @@ -96,9 +96,11 @@ uc_state_checkers(gsc, gsc_uc);
>> =C2=A0#undef uc_state_checkers
>> =C2=A0#undef __uc_state_checker
>> =C2=A0
>> -static inline int intel_uc_wait_for_idle(struct intel_uc *uc, long
>> timeout)
>> +static inline int intel_uc_wait_for_idle(struct intel_uc *uc,
>> +					 bool interruptible,
>> +					 long timeout)
>> =C2=A0{
>> -	return intel_guc_wait_for_idle(&uc->guc, timeout);
>> +	return intel_guc_wait_for_idle(&uc->guc, interruptible,
>> timeout);
>> =C2=A0}
>> =C2=A0
>> =C2=A0#define intel_uc_ops_function(_NAME, _OPS, _TYPE, _RET) \

--=20
Jani Nikula, Intel
