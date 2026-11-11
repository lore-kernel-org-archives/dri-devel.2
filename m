Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E79606AE60
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E2QiMpt5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652CD10EADE;
	Wed, 11 Nov 2026 23:49:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A3E10E4C0;
 Wed, 11 Nov 2026 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794440925; x=1825976925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u5AVXTElJz7EZV2h5YwoTsJFHDCSeIjHVrhKH9eyfwI=;
 b=E2QiMpt5MfsPpHXSQPG5TZn+rJlTRWvUM4K5ky6tXx/I0iEjnhOgOS2G
 nxmlZF3+/u+mqIAb59MNyY7mcD30KviPBQ6TsbDBSO+mJIE9tirUDvURv
 pV4S/4oTU5HiISeNALAXNZA0UhBp89N0doGqyarllCqrtVOuMoz+jlx8X
 pvsltLHQvW65pHnHC3eEVwJJS814rHXnCUsab60rWdMukeOUSEtkfZ3Ml
 g6wVdNJGed3bTFYQIKV9b3lwSL5HXDp8bKK6X6ii3OP4k9gQ9njNftHPb
 N5/xLvwXs24XZ6muMaXE14nEpuHx2ogudzNDiPTQE8pcVUUGVKfd5uJWJ w==;
X-CSE-ConnectionGUID: vd0tOiCYTo+CpYtc7iql8A==
X-CSE-MsgGUID: 73iT4SS7RWGdW8SGjqnQmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3226664"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3226664"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 15:48:44 -0800
X-CSE-ConnectionGUID: o71bEf/wRTCxDbrm4F0BNA==
X-CSE-MsgGUID: YEu72Nx6Sn6B9UBCg1VsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8512405"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com)
 ([10.3.206.11])
 by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 15:48:41 -0800
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
Subject: [PATCH 6/7] tpm: Include <asm/cpu_device_id.h> unconditionally
Date: Wed, 11 Nov 2026 16:48:19 -0700
Message-ID: <20261111234821.4814-7-pavel.e.popov@intel.com>
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

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
it is in mainline.

[1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com

 drivers/char/tpm/tpm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index fa554c5ad80..ad1534aa00c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -28,9 +28,7 @@
 #include <linux/tpm.h>
 #include <linux/tpm_eventlog.h>
 
-#ifdef CONFIG_X86
 #include <asm/cpu_device_id.h>
-#endif
 
 #define TPM_MINOR		224	/* officially assigned */
 #define TPM_NUM_DEVICES		65536
-- 
2.54.0

