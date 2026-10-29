Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4A606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jEFfocYz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A9B10E73A;
	Thu, 29 Oct 2026 01:42:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3897410E173;
 Thu, 29 Oct 2026 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793238130; x=1824774130;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kI+rIQ46Ui2Foc+Hy4QcTOcGm6ViOUJcvJFK4yI6ckA=;
 b=jEFfocYzUwuj6dydgCgLmwPVtq8gi66GfnSDNnRWMLuWJW8/sOPjAD2T
 +WZmWtDqMLh1HLqJoRTcNMZvTo1ipYTjJGueRxQcsaydJ51ro4kpFLHs+
 1wtux6DHyp8XbS//cUmOa3CCdVEJhW56+F9ZdjDDfuDL2/HAt7qxhdeob
 cO/epl2G/GMZADV+Q/d+quXjxBozgdfVCtVW5uTzZ706um00JHJVfeq/c
 y5HagthGqttH7rCOJp6cSms9y6DTtX60ayEa2uPOFs4amiv1du614qC0Z
 9nHk1lEhXN8ggBHHAEVc1k00CK9IyNMXQ7Z7m8he1GL65gz4j1otO1grL Q==;
X-CSE-ConnectionGUID: RI2Z0Ia/S/WsYE96vdRCgA==
X-CSE-MsgGUID: FCU8zi9fT2Wj2zCQ+T/QIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2005997"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="2005997"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:10 -0700
X-CSE-ConnectionGUID: 0LcEv9JTRsSknYVbUuRPXQ==
X-CSE-MsgGUID: 6h+ygPUySnyCqP1ScN2IOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6823172"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.30])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:07 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [RFC 0/5] Selftests fixes for multi-gt platforms in i915
Date: Thu, 29 Oct 2026 02:41:50 +0100
Message-ID: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series contains fixes in i915 selftests to make them work as
intended on multi-gt platforms like MTL.

Methodology to find these was: grep -R "to_gt()", and reading files that
use it. Some resulting files were omitted by choice.

The most notable example - gem/selftests/i915_gem_mman.c is ommited
despite *heavy* usage of to_gt(), due to the fact that i915's
implementation of GGTT mmap forces GT0 via to_gt(i915), so the way the
selftest works actually reflects the usage.

Files that only use mock device are also omitted due to the fact that
the mock device is hard-coded to have a single GT, so to_gt(i915) is
correct in that case. My reasoning for omission is that single gt is a
conscious, reasonable assumption to make when writing a mock device
test, and updating the tests to handle mutli-gt mock devices is out of
scope here and should be done IF there is ever a series adding multi-gt
to mock devices at all.

First two patches are "low-hanging fruits", where the tests already
depend on the passed GT parameter fully, they have just been mechanically
changed from i915->gt to to_gt(i915) when the multi-gt patches were
applied.

Patch 5 in the series (Port selftests that access ggtt) is written with
the weak assumption that separate GTs imply separate GGTTs, which is to
my knowledge not the case for example in MTL (where the media GT's
->ggtt will just point to the primary GT's ggtt). The way it is now is
generic and will work with separate GGTTs, however, if a stronger
assumption is preferred by the community (aka all platforms we will ever
run this on will have a single/shared GGTT), this patch can be dropped.

Patch 3 is also written with this assumption in mind, however, the PPGTT
part of the test should probably stay GT-specific, so it's not a simple
drop.

Patch 4 is opinionated in that there's two ways to accomplish the port:
run the affected test for each GT separately and skip on engines not
belonging on the currently processed GT, or run the test once, but
modify the lock such that it happens after selecting the engine and
affects engine->GT specifically. Patch 4 does latter right now.

Krzysztof Niemiec (5):
  drm/i915/selftests: Port GT-dependent selftests to work with multi-GT
    (low-hanging fruits part 1)
  drm/i915/selftests: Port GT-dependent selftests to work with multi-GT
    (low-hanging fruits part 2)
  drm/i915/selftests: Port i915_gem_gtt.c selftest file to multi-gt
  drm/i915/sefltests: Port i915_gem_context.c selftest file to multi-gt
  drm/i915/selftests: Port selftests that access ggtt to work with
    multi-gt

 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  8 +-
 .../i915/gem/selftests/i915_gem_client_blt.c  | 29 +++++--
 .../drm/i915/gem/selftests/i915_gem_context.c | 19 +++--
 .../drm/i915/gem/selftests/i915_gem_migrate.c | 11 ++-
 drivers/gpu/drm/i915/gt/selftest_context.c    | 16 +++-
 drivers/gpu/drm/i915/gt/selftest_engine.c     | 15 ++--
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  | 15 +++-
 .../drm/i915/gt/selftest_engine_heartbeat.c   | 22 ++++--
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 19 +++--
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      | 15 +++-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  | 24 +++---
 drivers/gpu/drm/i915/gt/selftest_lrc.c        | 11 ++-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    | 38 ++++++---
 drivers/gpu/drm/i915/gt/selftest_mocs.c       | 11 ++-
 drivers/gpu/drm/i915/gt/selftest_reset.c      | 20 +++--
 .../drm/i915/gt/selftest_ring_submission.c    | 15 +++-
 drivers/gpu/drm/i915/gt/selftest_timeline.c   | 15 +++-
 .../gpu/drm/i915/gt/selftest_workarounds.c    | 15 +++-
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c     | 20 +++--
 .../drm/i915/gt/uc/selftest_guc_hangcheck.c   | 20 +++--
 .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   | 20 +++--
 drivers/gpu/drm/i915/selftests/i915_active.c  |  8 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c     | 79 +++++++++++--------
 .../gpu/drm/i915/selftests/i915_gem_evict.c   | 15 +++-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 32 +++++---
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  8 +-
 drivers/gpu/drm/i915/selftests/i915_request.c |  8 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 16 +++-
 .../drm/i915/selftests/intel_memory_region.c  | 16 +++-
 drivers/gpu/drm/i915/selftests/intel_uncore.c | 11 ++-
 30 files changed, 409 insertions(+), 162 deletions(-)

-- 
2.55.0

