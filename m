Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4DDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B457810E0FA;
	Mon, 13 Jul 2026 10:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ioVvDgMa";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F096810E8FE;
 Mon, 13 Jul 2026 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783940319;
 bh=CFvRifISqpjztbxD6ia6T3+vhSFdflja51r+XaALe0c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ioVvDgMaiSWyGtW7hYsVfUOn0brD7n9VtNk8/pOvLJ4alxmfgHA94De4CWKwul29x
 IxAlBx19KwqccKsE8KA6QZUeLqApdixn/AKBBLQ+EC0kjamjM0wrFKMNFqjjcUd4eW
 8rBlPpS4tlUZq5t3BH85X+d9c2IRXzf+kGfWaTW1tY97g4mfHYiIPsD8IxEbUCV/3F
 3Q7BInZkvnecja/JQ6RXasRNTNoZybnDvmw6e/DpslbJXZsSj/nKKyGs6wluRItYVL
 /kqsrtS4kzloIbR3HsyoTpJIbMZ+lKiToWOz35dzoHN6WFBTVsNZGa4Gq7l315jVUA
 rAAv+fcECzIcg==
Message-ID: <41c1ec3b-e397-419b-bd92-4b923cee6ed0@lankhorst.se>
Date: Mon, 13 Jul 2026 12:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] drm/intel/display: Changes required to make vblank
 evasion PREEMPT_RT safe.
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260702072154.171324-1-dev@lankhorst.se>
 <alEFKfqD-69wOVxJ@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <alEFKfqD-69wOVxJ@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hey,

On 7/10/26 16:43, Ville Syrjälä wrote:
> On Thu, Jul 02, 2026 at 09:21:43AM +0200, Maarten Lankhorst wrote:
>> CONFIG_PREEMPT_RT requires code to be as deterministic as possible,
>> and codes with interrupts disabled cannot use spinlocks.
>>
>> In order to handle this correctly, we ensure any locking requirements
>> are handled before disabling interrupts, and only start locking again
>> after interrupts are re-enabled and timing sensitive path completed.
>>
>> This also has the benefit of making the vblank evasion code more
>> deterministic; without locking there's much less jitter.
>>
>> Previously, we scheduled vblank work on completion.
>> This is now handled by scheduling the vblank in advance, only arming
>> it upon completion without locks.
> 
> Sashiko found a bunch of stuff that I was also thinking would be
> a problem. Don't think I'll need to repeat it here.
> 
> I'm still thinking the easy way out would be to just convert
> everything to raw spinlocks. The uncore lock I think should become
> easier to deal with once I manage to move all of it into the
> display code. I admit that the vblank locking is kinda annoying
> and potentially inefficient. I've been pondering about making the
> vblank locks to per-crtc to at least avoid some unnecessary contention,
> but the fact that a lot of the drivers poke at the vblank internals
> directly makes it a lot more work than it should be :/

I'll do the full wmb instead of the smp wmb, should hopefully fix it.

In general, the approach I'm taking was ensuring that no raw spinlocks are
ever needed. Every lock is taken before disabling interrupts, and then we
run the time sensitive code only after checking there's enough time left.

This means that even on PROVE_LOCKING, there is no contention of locks,
and the VBLANK_EVASION_TIME_US could be set to 100 µs even with
PROVE_LOCKING set. You can take the uncore lock in advance just like any
other lock if required, but no contention should happen and it can be
taken as normal not raw spinlock.

> 
>>
>> Maarten Lankhorst (9):
>>   drm/vblank_work: Add methods to schedule vblank_work in 2 stages
>>   drm/vblank: Add a 2-stage version of drm_crtc_arm_vblank_event
>>   drm/intel/display: Make intel_crtc_arm_vblank_event static
>>   drm/intel/display: Convert vblank event handling to 2-stage arming
>>   drm/i915/display: Move vblank put until after critical section
>>   drm/i915/display: Remove locking from intel_vblank_evade critical
>>     section
>>   drm/i915/display: Handle vlv dsi workaround in scanline_in_safe_range
>>     too
>>   drm/i915/display: Make get_vblank_counter use intel_de_read_fw()
>>   drm/i915/display: Do not take uncore lock in i915_get_vblank_counter
>>
>> Mike Galbraith (1):
>>   drm/i915: Use preempt_disable/enable_rt() where recommended
>>
>>  drivers/gpu/drm/drm_vblank.c                  |  64 +++++++++-
>>  drivers/gpu/drm/drm_vblank_work.c             | 110 +++++++++++++----
>>  drivers/gpu/drm/i915/display/intel_crtc.c     |  86 ++++++-------
>>  drivers/gpu/drm/i915/display/intel_crtc.h     |   1 -
>>  drivers/gpu/drm/i915/display/intel_cursor.c   |   8 +-
>>  drivers/gpu/drm/i915/display/intel_de.h       |   8 ++
>>  drivers/gpu/drm/i915/display/intel_vblank.c   | 115 ++++++++++--------
>>  drivers/gpu/drm/i915/display/intel_vblank.h   |   1 +
>>  drivers/gpu/drm/i915/intel_uncore.h           |  26 ++--
>>  .../drm/xe/compat-i915-headers/intel_uncore.h |   7 ++
>>  include/drm/drm_vblank.h                      |  14 ++-
>>  include/drm/drm_vblank_work.h                 |  12 ++
>>  12 files changed, 324 insertions(+), 128 deletions(-)
>>
>> -- 
>> 2.53.0
> 
Kind regards,
~Maarten
