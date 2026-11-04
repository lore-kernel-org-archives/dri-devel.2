Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC2606A330
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l9RSbETa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6FA10FCE2;
	Wed,  4 Nov 2026 16:13:53 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 04 Nov 2026 16:13:45 UTC
Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8D210FCF7
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:13:45 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=8h6G/EKHbetMFLZ3FoTwPAwj6jQwPZCmaugSiKT4/5M=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793808824; v=1; x=1794413624;
 b=l9RSbETaBpaa66ARvl/1EF1+GPT7ZSk2472DACu957EjIGMGw+yfpg4KpgliabVFTCcpsHMm
 OChwmzsTi5htLqhvkdtP461PCWd3ifCbXudTF4hthX8QhoRKqD9jVgldOEN9nKcQRe3jH8g/L7c
 bkik75JhtRKUHz9s20r2hOv4=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 64b2df2fbae2508c;
 Wed, 04 Nov 2026 16:07:38 +0000
X-Mizu-Trace-ID: 64b2df2fbae2508c
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, "H. Peter Anvin" <hpa@zytor.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, llvm@lists.linux.dev
Subject: [PATCH 0/4] Fix the x86 defconfig build with GCC 17
Date: Wed,  4 Nov 2026 08:07:17 -0800
Message-ID: <20261104160722.1637541-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix build warnings and failures (CONFIG_WERROR=y) with a GCC 17 build.
GCC 17 adds -Wconstant-logical-operand which is strict about operands
of && or || that fold to a constant other than 0 or 1.

In the past similar fixes have been done for clang, e.g.

  93f56de25937 2017-04-06 mac80211: Fix clang warning about constant operand in logical operation  [v4.12-rc1]
  ...
  dd7fe5d9fd6a 2024-01-17 rtc: max31335: Fix comparison in max31335_volatile_reg()                 [v6.8-rc1]

The reason this trips only with gcc is that clang's toggle is more
permissive:
 - it checks RHS only, not constant LHS.
 - Macros are not checked.

Fix is to effectively make a macro or condition return 0 or 1.

The patches are split up per subsystem and can go independently via
respective trees:

  1/4 x86/cpufeatures: the awk-generated *_MASK_BIT_SET() returns 0 or 1.
  2/4 wait: ___wait_is_interruptible() with a constant state.
  3/4 iommupt: PT_SUPPORTED_FEATURE() in the fvalog2_*() helpers.
  4/4 drm/i915: IS_POWER_OF_2() in reg_bits.h, and two Kconfig timeouts.

Tested on x86 defconfig with CONFIG_WERROR=y, at each patch:

 - GCC 17 trunk (20261103): each patch removes only its own errors. The
   build has no warnings after 4/4.
 - GCC 16.1: the build has no warnings. The .text of each object file
   does not change. The only differences come from the build timestamp
   and the release string.

Vineet Gupta (4):
  x86/cpufeatures: Make {REQUIRED,DISABLED}_MASK_BIT_SET() return 0 or 1
  wait: Make ___wait_is_interruptible() return 0 or 1
  iommupt: Make PT_SUPPORTED_FEATURE() return 0 or 1
  drm/i915: Avoid -Wconstant-logical-operand with GCC 17

 arch/x86/tools/cpufeaturemasks.awk          | 4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 drivers/gpu/drm/i915/i915_config.c          | 2 +-
 drivers/iommu/generic_pt/pt_defs.h          | 2 +-
 include/drm/intel/reg_bits.h                | 2 +-
 include/linux/wait.h                        | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.53.0-Meta

