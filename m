Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A5606EDD1
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MyDwC8CY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA4810EAC3;
	Wed, 11 Nov 2026 23:48:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDFE10EAC1;
 Wed, 11 Nov 2026 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794440928; x=1825976928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nn492t9vwWyNrSlbHv+ImXuNJXcsvtoFtn2kqzaYrJE=;
 b=MyDwC8CYx58Gq1PPnGXos1jG0sRdsLBAZkO4R6vtLizUvYgnf+cBUBc3
 iime9MArLvER9vGVqyWYWf14A2ZaQs4FPUFGUvasqPLNy4F++bb2zsOXP
 vZ6BMaicqrY2qPOnavtZO+dZxmU8qTFtSZiAfaMZqa1iVgkXVnh8Zemym
 xqq+4DxxDyOm61u8DDb/2Zt2pNn7+9C8Xw9jg0VzoIwb/hfRUQGVDkSp9
 fPrR28e8LkPb17HhzvI/d9IhCNHLfqUkI8PoLMnRk2s/rTzmmFH1/eAFG
 5Sz4b/gQrcWo6+O85yx+bNU9fwLotYyUqpkM4hna+Wku7usmfPeWXgAcD g==;
X-CSE-ConnectionGUID: cykHXQgrSdi0CRgyW8pq4A==
X-CSE-MsgGUID: SWwFr7mdSLiKQjYWxHBWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3226682"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3226682"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 15:48:47 -0800
X-CSE-ConnectionGUID: meJAifVaQEOpz/aGc9pt4Q==
X-CSE-MsgGUID: YrrcqYuLTPOSRGb2SidOoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8512421"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com)
 ([10.3.206.11])
 by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 15:48:44 -0800
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
Subject: [PATCH 7/7] crypto: ccp - Drop unused <asm/cpu_device_id.h> include
Date: Wed, 11 Nov 2026 16:48:20 -0700
Message-ID: <20261111234821.4814-8-pavel.e.popov@intel.com>
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

Nothing in ccp-dev.c uses <asm/cpu_device_id.h>; the CPU match table
it was included for is long gone. Drop the include and the #ifdef
CONFIG_X86 around it.

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/crypto/ccp/ccp-dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-dev.c b/drivers/crypto/ccp/ccp-dev.c
index 41d9bdac95d..017e7a6551f 100644
--- a/drivers/crypto/ccp/ccp-dev.c
+++ b/drivers/crypto/ccp/ccp-dev.c
@@ -21,9 +21,6 @@
 #include <linux/hw_random.h>
 #include <linux/cpu.h>
 #include <linux/atomic.h>
-#ifdef CONFIG_X86
-#include <asm/cpu_device_id.h>
-#endif
 #include <linux/ccp.h>
 
 #include "ccp-dev.h"
-- 
2.54.0

