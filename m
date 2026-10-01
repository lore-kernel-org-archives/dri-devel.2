Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC49CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A8810E2B2;
	Thu,  1 Oct 2026 11:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I6URjSfQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8971010E259;
 Thu,  1 Oct 2026 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790855451; x=1822391451;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=P0+uWiHIfgAvnr6p/jiSzEYtzmPFw4b0lDd1UgMM484=;
 b=I6URjSfQRYeQ498mhHbpKVyw0V5TRrZJg5C3WRB3kL3cWDXvVvYiSp2q
 Lfq+iSkriPItXxiNetDrXYbKwD0erNMV4PBX5ha+KW+o6RI73+kMUbwNA
 OUqrrdDeQcxzxdZsAuAgsvh29KwZ90fAU7/LNta/jA7jRCVYrhA152kJV
 zhG9MtNZmq68rJXl5nk7ccT/L1mhMmRsQaTtX6pqSX+CTjCP1HfEKEWjj
 ifeSvi0TwdDZ4CaFiDiXCvBYXlJWUK0IbjG2OVfe2zAxxVYbDT/63FT2K
 Jn92psS+0NgP9qzpL6n8+vZMt+/zxwTxk6KMh8nHM+ke2tMJ5ntOCoo7J Q==;
X-CSE-ConnectionGUID: Od6qBgsKSIekU68/HnMq0w==
X-CSE-MsgGUID: 1mP5Nen0RaKhCr4fxyPdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="109092615"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="109092615"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:50:51 -0700
X-CSE-ConnectionGUID: IX6f4tIXQc2B/0eot1IXng==
X-CSE-MsgGUID: DwoN/6jiSrOIbpHhqpzvWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="313923843"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.5])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:50:47 -0700
Date: Thu, 1 Oct 2026 14:50:44 +0300
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-gt-next
Message-ID: <ar5JFG3BmldEdDzF@jlahtine-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Hi Dave & Sima,

Here goes the singular drm-intel-gt-next PR towards 7.4.

It's all fixes really. Endless loop fix for RCU teardown,
fix for UAF in command parsing for Gen9 blitter engines and
one WARN splat fix for RPS boosting.

Then some min*() code simplication and selftest fixes.

Regards, Joonas

***

drm-intel-gt-next-2026-10-01:

Driver Changes:

- Fix incorrect RCU teardown order (Christian)
- Fix potential UAF in command parsing code (Krzysztof)

- Avoid WARN splat during RPS boosting race (Krzysztof)
- Use simpler versions of min*() functions (Andy)
- Selftest improvements (Sk, Krzysztof, Jansuz)

The following changes since commit 682ea2d28d18bb06f9fc663cb5ab7e80dc0e606a:

  drm/i915/selftests: Fix GT PM sort comparators (2026-07-15 13:06:07 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-gt-next-2026-10-01

for you to fetch changes up to ca4a6deadad15b91ee083afe445fa6bdbfb68206:

  drm/i915/gt: Unmask interrupts only when ACTIVE is true (2026-09-30 11:58:59 +0200)

----------------------------------------------------------------
Driver Changes:

- Fix incorrect RCU teardown order (Christian)
- Fix potential UAF in command parsing code (Krzysztof)

- Avoid WARN splat during RPS boosting race (Krzysztof)
- Use simpler versions of min*() functions (Andy)
- Selftest improvements (Sk, Krzysztof, Jansuz)

----------------------------------------------------------------
Andy Shevchenko (1):
      drm/i915/gem: Use simpler versions of min*()

Christian König (1):
      drm/i915: fix incorrect RCU teardown order

Janusz Krzysztofik (1):
      drm/i915/selftests: Wait longer for request to start

Krzysztof Karas (3):
      drm/i915/selftest: Fix a typo in alloc_workqueue call
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Sk Anirban (1):
      drm/i915/selftests: Report missing RC0 power as an error

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c     |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c      | 10 +++-------
 drivers/gpu/drm/i915/gt/intel_rps.c            |  3 ++-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c   |  2 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c         |  4 ++--
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c |  2 +-
 7 files changed, 11 insertions(+), 14 deletions(-)
