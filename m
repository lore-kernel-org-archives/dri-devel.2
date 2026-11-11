Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F660A5BD7
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CHiFtZWu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57AE10EAB8;
	Wed, 11 Nov 2026 23:48:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DE210E4B6;
 Wed, 11 Nov 2026 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794440914; x=1825976914;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d/q7ALXLdCkJJkZQuQByGC710SnlqrlqU7uR1PxYHvk=;
 b=CHiFtZWu6HhsgWUcC4X/jFNfyPXRngSvyRZUqepLBP68WhkMoRUkd5II
 0afJi6N+xGKMx1zgnXGOb6zVsMYzsZRn7ZUKnu7t4qT7Mm7MTVvZBP1kk
 YB6G8UNVShsgo9ptgTtdqKjsMqeDzsHg8ywz0WxPwAkdPaU2BgI23uBOp
 WxHRbjiH0IveNvmdz2zJAEXBXSp+btqSthRIDaSwz4NJdxtPTxE/8qui5
 o8c1h3/31NV4calu/cYYlxjWiMyxEd/fFM1MZC1tRI4mD7JQLlHY5s7zq
 0Wv1XKwedjTfXhHC2jLkSxq3ZG8+UuCmanDtc/e3Wq4PgO6B7FOs4rfn/ g==;
X-CSE-ConnectionGUID: IqLPpkcwTb2OnelHJpdsVw==
X-CSE-MsgGUID: q8kJ5qA6R6OfAIUSzVdaHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3226608"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3226608"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 15:48:34 -0800
X-CSE-ConnectionGUID: djsE3xf9RyyMNtRku7cWRA==
X-CSE-MsgGUID: 80aUsZCoRNu+l8Tm+TbN1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8512370"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com)
 ([10.3.206.11])
 by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 15:48:31 -0800
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
Subject: [PATCH 3/7] drm/amdgpu: Include <asm/cpu_device_id.h> unconditionally
Date: Wed, 11 Nov 2026 16:48:16 -0700
Message-ID: <20261111234821.4814-4-pavel.e.popov@intel.com>
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

<asm/intel-family.h> is included by <asm/cpu_device_id.h>.

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
it is in mainline.

[1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 19a566187df..fc4e7273630 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -88,10 +88,7 @@
 
 #include <drm/drm_drv.h>
 
-#if IS_ENABLED(CONFIG_X86)
-#include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
-#endif
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
-- 
2.54.0

