Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49AACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B6310F5C2;
	Thu,  1 Oct 2026 08:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CRKVanEd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E3B10F5C9;
 Thu,  1 Oct 2026 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790841893; x=1822377893;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=8dIYbbdN1q6BFjWPGfMLQzJ53nUs/6UpURK+/1qi3S8=;
 b=CRKVanEd7rrVINeLpRROTPreHEGnUgwTgHfNABSbIwQgLV8LXrG9TtRf
 zRm4nMA3kMq7Sid1cki6RG4KuutPgSD43fuBUj/4F/hlcVbKOIgCjAKqD
 dGUeGYPnH4adPuEzpR5iUE5Wkp9OZ1qC/gxe7v7dsVYQqkPy3nswNqTaM
 6DPFH4NZWnMs7hVNqteRJDJjA6b3OuMy+2FwAwcqBMltKU44bfADAeMkg
 ojSDidT+PcOj5KbqatV9BPDLMunOptgs6Ym3g3Qo3E7GhnLrIDOh8/woV
 QuujoW/UpdrYKR6nNt0RCV/Smc/33Cf5LgFoKbszzYzgo4gp8x+pmhgTX Q==;
X-CSE-ConnectionGUID: 6CAV2eQeQZKWovtlQaXS6Q==
X-CSE-MsgGUID: jU8fiNbqRzyGxrmr+/8h5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90647103"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90647103"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 01:04:53 -0700
X-CSE-ConnectionGUID: LQmWL4J5RlOORVHaIYgW8g==
X-CSE-MsgGUID: G5DnWiABRqiUv+u5Rx8lKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="280684290"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.29])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 01:04:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: Re: [PATCH v5 0/6] drm/i915/selftests: Modernize printing in i915
 selftests
In-Reply-To: <20261001074100.2694888-1-krzysztof.karas@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
Date: Thu, 01 Oct 2026 11:04:47 +0300
Message-ID: <37378902e0cfa4bb79e442fcd27fb0017d74ef95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 01 Oct 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> Currently, in many instances, i915 functions call pr_* macros
> to write a message to the system log. This way of printing
> lacks device context, which could be a valuable source of
> information. Many files in DRM already use drm_* prints to
> include that context, so it would be beneficial to do the same
> for i915 as well. Start small and convert i915 selftests first.
>
> v5:
>  * Reverted adding i915_* family of print macros (Jani, Andi);

On this version of the series,

Acked-by: Jani Nikula <jani.nikula@intel.com>

There are a few nitpicks, I might reply inline about them, but let's
just get this merged and over with, and *maybe* we can look at them
afterwards. Or not.

BR,
Jani.


>
> Krzysztof Karas (6):
>   drm/i915/selftests: Use gt_*/drm_* prints in core selftests
>   drm/i915/selftests: Use gt_*/drm_* prints in selftest helpers
>   drm/i915/gt/selftests: Use gt_* prints in aggregated gt selftests
>   drm/i915/gt/selftests: Use gt_* prints in gt standalone tests
>   drm/i915/gt/selftests: Use gt_* prints in gt selftest helpers
>   drm/i915/selftests: Use drm_* prints in i915_selftest.c
>
>  drivers/gpu/drm/i915/gt/selftest_context.c    |  20 +-
>  drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |   5 +-
>  .../drm/i915/gt/selftest_engine_heartbeat.c   |   7 +-
>  drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  31 ++-
>  drivers/gpu/drm/i915/gt/selftest_execlists.c  | 243 +++++++++++-------
>  drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  21 +-
>  drivers/gpu/drm/i915/gt/selftest_llc.c        |  25 +-
>  drivers/gpu/drm/i915/gt/selftest_migrate.c    |  47 ++--
>  drivers/gpu/drm/i915/gt/selftest_mocs.c       |   7 +-
>  drivers/gpu/drm/i915/gt/selftest_rc6.c        |  32 ++-
>  drivers/gpu/drm/i915/gt/selftest_reset.c      |  20 +-
>  drivers/gpu/drm/i915/gt/selftest_rps.c        | 126 +++++----
>  drivers/gpu/drm/i915/gt/selftest_slpc.c       |  79 ++++--
>  drivers/gpu/drm/i915/gt/selftest_tlb.c        |  24 +-
>  .../gpu/drm/i915/gt/selftest_workarounds.c    |  70 +++--
>  drivers/gpu/drm/i915/selftests/i915_active.c  |  12 +-
>  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 ++--
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 ++++++++----
>  drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
>  drivers/gpu/drm/i915/selftests/i915_request.c | 206 +++++++++------
>  .../gpu/drm/i915/selftests/i915_selftest.c    |  10 +-
>  drivers/gpu/drm/i915/selftests/i915_vma.c     | 187 +++++++++-----
>  .../gpu/drm/i915/selftests/igt_flush_test.c   |   4 +-
>  .../gpu/drm/i915/selftests/igt_live_test.c    |   6 +-
>  drivers/gpu/drm/i915/selftests/igt_reset.c    |   4 +-
>  .../i915/selftests/intel_scheduler_helpers.c  |   7 +-
>  drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
>  .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
>  28 files changed, 958 insertions(+), 509 deletions(-)

-- 
Jani Nikula, Intel
