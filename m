Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E493CC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4466A10F236;
	Thu, 16 Jul 2026 08:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bpTwbyiL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D22D10F22A;
 Thu, 16 Jul 2026 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=iyWME1/Wlefybyl0ByxBWGf+Dl3rG+5VnCsnj9UCLrY=; b=bpTwbyiLiQ2
 eQhqbmepEoAgm+cFssiafkvLT+rYtsezCjb7ku7Ra0/yAbvUakaMGylnV4wHBhhi3q0luGTU5ROhh
 AmsQ5iDcYQTK9pxmvE9Cwvm2Fx69oB7t2DJPti5eO4aktgH7bgbMo2/1gtMlDZO/kEDP8xRdOcLYU
 cAwjnVqUmigPo/lFlFyK4GMoeU1zeBmSKLadY2wjjPK9tl65g095mEh4PdAXFUcDDiWZJOENNnOwy
 hV0ySqTxsBXrpHvbipEvt1zh6gBt9hvwNcWt+7kBU2qnXdgXdG0+57uN6XZKIKU1QvxfOKoEI003I
 8oo6thGPcMguP48TtBjFLnQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkHfT-00FosS-GO; Thu, 16 Jul 2026 10:42:07 +0200
Date: Thu, 16 Jul 2026 09:42:06 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-gt-next
Message-ID: <aliZXnfbOV-Mh8gZ@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


Hi Dave, Sima,

Here is the first pull request for 7.3. There isn't much to mention
though. Apart from the stream of AI-induced fixes, all of which have been
sent via fixes already, the only other changes are some misc stylistic
cleanups.

I will be away for the next two weeks so might send a late follow up in
the rc6 week if something interesting will land in the meantime.

Tvrtko

drm-intel-gt-next-2026-07-16:
Driver Changes:

Fixes/improvements/new stuff:

- Fix phys BO pread/pwrite with offset [gem] (Joonas Lahtinen)
- Add missing nospec on parallel submit slot [gem] (Joonas Lahtinen)
- Return NULL on error in active_instance (Joonas Lahtinen)
- Fix NULL deref in I915_CONTEXT_PARAM_SSEU [gem] (Joonas Lahtinen)
- Fix NULL deref on sched_engine alloc failure [gt] (Joonas Lahtinen)
- Do not leak siblings[] on proto context error [gem] (Joonas Lahtinen)

Miscellaneous:

- Return bool values from a boolean helper [gt] (Andi Shyti)
- Use correct selftest config symbol [gt] (Pengpeng Hou)
- Fix GT PM sort comparators [selftests] (Emre Cecanpunar)
- Return NULL for missing multi-lrc parent [guc] (Linmao Li)
The following changes since commit 6c064db893f548d57036fce17c6493808396e620:

  Revert "i915: don't use a vma that didn't match the context VM" (2026-05-20 10:46:41 +0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-gt-next-2026-07-16

for you to fetch changes up to 682ea2d28d18bb06f9fc663cb5ab7e80dc0e606a:

  drm/i915/selftests: Fix GT PM sort comparators (2026-07-15 13:06:07 +0100)

----------------------------------------------------------------
Driver Changes:

Fixes/improvements/new stuff:

- Fix phys BO pread/pwrite with offset [gem] (Joonas Lahtinen)
- Add missing nospec on parallel submit slot [gem] (Joonas Lahtinen)
- Return NULL on error in active_instance (Joonas Lahtinen)
- Fix NULL deref in I915_CONTEXT_PARAM_SSEU [gem] (Joonas Lahtinen)
- Fix NULL deref on sched_engine alloc failure [gt] (Joonas Lahtinen)
- Do not leak siblings[] on proto context error [gem] (Joonas Lahtinen)

Miscellaneous:

- Return bool values from a boolean helper [gt] (Andi Shyti)
- Use correct selftest config symbol [gt] (Pengpeng Hou)
- Fix GT PM sort comparators [selftests] (Emre Cecanpunar)
- Return NULL for missing multi-lrc parent [guc] (Linmao Li)

----------------------------------------------------------------
Andi Shyti (1):
      drm/i915/gt: Return bool values from a boolean helper

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Joonas Lahtinen (6):
      drm/i915/gem: Fix phys BO pread/pwrite with offset
      drm/i915/gem: Add missing nospec on parallel submit slot
      drm/i915: Return NULL on error in active_instance
      drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
      drm/i915/gt: Fix NULL deref on sched_engine alloc failure
      drm/i915/gem: Do not leak siblings[] on proto context error

Linmao Li (1):
      drm/i915/guc: Return NULL for missing multi-lrc parent

Pengpeng Hou (1):
      drm/i915/gt: use correct selftest config symbol

 drivers/gpu/drm/i915/gem/i915_gem_context.c        | 25 ++++++++++++++--------
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           | 19 ++++++++++++----
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |  2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   | 19 ++++++++--------
 drivers/gpu/drm/i915/gt/intel_reset.c              |  2 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |  8 +++----
 .../gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c    |  2 +-
 drivers/gpu/drm/i915/i915_active.c                 |  7 +++++-
 8 files changed, 54 insertions(+), 30 deletions(-)
