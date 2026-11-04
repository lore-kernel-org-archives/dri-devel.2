Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74D606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bHi16SW7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DBE10E3B0;
	Wed,  4 Nov 2026 23:06:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107C310FF96;
 Wed,  4 Nov 2026 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793833569; x=1825369569;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+ECfdnCFVr+bFj/4l/NtjkT1wfbHg8aoX2RG1wcWvgU=;
 b=bHi16SW7zVfIOky6YbmeqlwPNrvutyzFigTvQLXX0cobS52cB/U0J1KM
 fxOQ3INmP6vyKPfbOp5d49v8UJjq/idZISzYsfmNonnyj9JdpzoCvXbHL
 UUJmcZjDWuFDRjfKS/AcZxUrwtcByHgjZhgJ2I5q5dvW3gTrTTRSFPqfF
 WbbX9OO6OT8g7w2W2CKpQQ5oVjJax93t37RfV/hhr4RT5GL0+lvdAhgyQ
 HdZ7W93RP8fLcol8H1GBapRgSGdjmHtkWsy42Rqm9w3Rpu/3yUNUkljEO
 fwnJ5Dtn1xMZZ+yyd/+vIuyT2gp+hHmLECsu1lLVPIVNmx1llgMe6tWx8 g==;
X-CSE-ConnectionGUID: yrAPukgjQyiRJTNaA6TZGQ==
X-CSE-MsgGUID: rI1qYq4OQ4GEedoCdJkO9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2513207"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2513207"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:06:08 -0800
X-CSE-ConnectionGUID: icH2gm+oQvu3Dx28Qmme0w==
X-CSE-MsgGUID: gs2t4EWnSoqt+/nSi6g7uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6864957"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.108])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:06:04 -0800
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: sima@freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH v4 0/2] DRM device registration fixes
Date: Thu,  5 Nov 2026 00:05:53 +0100
Message-ID: <20261104230555.71107-1-krzysztof.niemiec@intel.com>
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series contains patches pertaining the drm_dev_register() and
drm_dev_unregister() functions. Turns out drm_dev_register() doesn't
properly unwind its effects in the error path, causing confusion and
bugs.

Additionally, a related patch for i915 is bundled, as i915 mistakenly
calls drm_dev_unregister() in the error path triggered by failing
drm_dev_register(), which on one hand introduced a WARN_ON() in
drm_client_sysrq_unregister(), caused by calling it without a previous
_register() (as it was skipped in drm_dev_register()); but on the other
hand silenced yet another WARN_ON() later on in the error path in
drm_mode_config_cleanup(). With the other patch, the driver can just
handle the error from drm_dev_register() cleanly without calling
drm_dev_unregister(). This is explained in detail in both the patches.

v3 -> v4:
 - rebased
 - patch 1: removed the debugfs change (sashiko, Andi)
 - patch 1: reordered =false line (Andi)
 - patch 1: updated commit log

v2 -> v3:
 - Reorder the patches (Sebastian, Andi)


Krzysztof Niemiec (2):
  drm: Set dev->registered back to false in drm_dev_register()'s error
    path
  drm/i915: Remove drm_dev_unregister() from the error path during
    i915_driver_register()

 drivers/gpu/drm/drm_drv.c          | 2 ++
 drivers/gpu/drm/i915/i915_driver.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.55.0

