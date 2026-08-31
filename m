Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7AEC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3667B10E7AE;
	Mon, 31 Aug 2026 09:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OJT8C7FA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4FE10E7AE;
 Mon, 31 Aug 2026 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788169067; x=1819705067;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I+FH7vqNavd3MMiUI7IDPF6tBinkk656Y/7Kc1TpIHk=;
 b=OJT8C7FAMLk8vtWjDZr0XKe/l8jymGsooSI/z+gYhvywB22FNaC0MutY
 L2lT4rmBwoI3P5anXX3AUTZMXqBn9Oh0r3j7MJb0jwBF5/K+GyxYDZ2ak
 oCN5s4aDVGIe/7ZsCITipSObbMrNhkHUs5Z17L+wesZMNhyzBvIE72xCJ
 4Anv3/2KuxzsTabmbkTLGb03zJEkq0kJVzJYjOZQ9T54vIDI+sXVkQu+q
 GOKwf8vkAHue0JYE3tMy7Izbwjhke2vfCmo/V4tsMc7ItEjEQ1CA+sRCf
 tymPi9AvHnQ7WofqTBHez+HtGm5nxCPStiPU/Osg9ptUxM7ooDeKEDk1c w==;
X-CSE-ConnectionGUID: 0j2hD9xjQhCM8H7Wd7qi+A==
X-CSE-MsgGUID: pDSf4GaOStaGfORaKsrvIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88621249"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88621249"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 02:37:47 -0700
X-CSE-ConnectionGUID: py/k+RLOT6ivbSh98SeaPw==
X-CSE-MsgGUID: j9fuiToFQQOuIdcmmLaYNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267410674"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.148])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 02:37:44 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org
Subject: [PATCH] drm/i915/selftests: Wait longer for request to start
Date: Mon, 31 Aug 2026 11:33:08 +0200
Message-ID: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

CI extreamly sporadically (five times over last six mohths) reported
failures of igt@i915_selftest@live@hangcheck on ARL-S machines.  The
selftest was timing out while waiting up to 1 second for a request
supposed to trigger a GPU hang to be started.  It occurred possible to
reproduce this issue manually by running the selftest in a loop for a
few hours.

Among results from 5 occurrences reported by CI so far, and two manual
reproductions, two of them contained messages that suggested a
posssibility of the awaited request to actually start soon after
timeout.  With the timeout extended from 1 to 2 seconds, it occurred no
longer possible to trigger the failure, even when running the test in a
loop for 10, then for 12 hours, on the same machine where it was failing
before in 2-3 hours.

Assume the conditions that prevented the hang requests to start within 1
second were always transient, and 2 seconds is sufficient for those
requests to start effectively on machines in the CI environment.  Fix
the issue by using that value as the timeout.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16624
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 00dfc37221fac..53f3ce5c33a47 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -278,7 +278,7 @@ static bool wait_until_running(struct hang *h, struct i915_request *rq)
 			     10) &&
 		 wait_for(i915_seqno_passed(hws_seqno(h, rq),
 					    rq->fence.seqno),
-			  1000));
+			  2000));
 }
 
 static int igt_hang_sanitycheck(void *arg)
-- 
2.54.0

