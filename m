Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC591606AE71
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gyAGYXu0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E7A10EAC5;
	Wed, 11 Nov 2026 23:48:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34F610E4C0;
 Wed, 11 Nov 2026 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794440918; x=1825976918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qiTprQcvixtyWKG6YcvfO8nQP3PU4VUrniMboE6NSkI=;
 b=gyAGYXu0++GouxpOqlvz4AE0UESwZiHddy1GtCYInd4ZlrehbkYhRlUS
 6e8Hz+pLp5W/fJ0NWTiK65HE6GIAwM+0my0QS1OF8JzK44J4ot8aBYyb7
 i+9SWp2KFqMCwzNFDgR5HpO8wntHWySXxhDftp7AFRBzXi4JzSmu0FFyS
 oHsM8lPMo4g81t6nzOB3Pmg8mJIrPwn0LnJ1oHHp+2HDWskrfoGr9dm5y
 0+0jdhqTvxnTEyLyEssOJ7pa7dcljB2d1gqYbY8TR/aXHxfWzgrRFowpQ
 RcqorQm77jx+WDNuJsF1sesslbNczN3ECI+rn+Il94jv94TGlZZua77fi A==;
X-CSE-ConnectionGUID: cpNKlzRGSuKr5BbO1WHA+g==
X-CSE-MsgGUID: 4HmpEg5HRv2dG7CjLscvMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3226625"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3226625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 15:48:37 -0800
X-CSE-ConnectionGUID: VLtbyyzhTuu5gT0SuDLr3w==
X-CSE-MsgGUID: LreG1qb0TWiBf5byqg7Q0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8512387"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com)
 ([10.3.206.11])
 by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 15:48:34 -0800
From: Pavel Popov <pavel.e.popov@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Popov <pavel.e.popov@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "David S . Miller" <davem@davemloft.net>,
 x86@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
Date: Wed, 11 Nov 2026 16:48:17 -0700
Message-ID: <20261111234821.4814-5-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111234821.4814-1-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

<asm/cpu_device_id.h> now has a generic version, so the #ifdef
CONFIG_X86 around the include is no longer needed.

od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
it is in mainline.

[1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com

 drivers/cpufreq/cpufreq_ondemand.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
index 2ca8f1aaf2e..0e33865f9d3 100644
--- a/drivers/cpufreq/cpufreq_ondemand.h
+++ b/drivers/cpufreq/cpufreq_ondemand.h
@@ -6,6 +6,8 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
+#include <asm/cpu_device_id.h>
+
 #include "cpufreq_governor.h"
 
 struct od_policy_dbs_info {
@@ -26,8 +28,6 @@ struct od_dbs_tuners {
 };
 
 #ifdef CONFIG_X86
-#include <asm/cpu_device_id.h>
-
 /*
  * Not all CPUs want IO time to be accounted as busy; this depends on
  * how efficient idling at a higher frequency/voltage is.
-- 
2.54.0

