Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0212606D916
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YKkCWlIq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05ED10E49A;
	Wed, 11 Nov 2026 23:48:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532BC10E47F;
 Wed, 11 Nov 2026 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794440905; x=1825976905;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9Cuegc/MuoDCo4oN8xNnf/pcpxsFdQP4keN2fSB0lfE=;
 b=YKkCWlIqbv+MntrVW1kAk69u3zKeJW/GD1CSSwTDnD0Ob5D5SSbeHTyk
 sn4s6B0i5m3smTrzwoOWuw267qBIEuwr6p478RQ98VMyz4jaTZMRqa8OI
 Mp21r62yVLog0SEOLH8g9oiiS+XJw8tIDfKJLWcW1+WPpeAw7Cp5eQZYK
 VUs4fCT9XSPPNw8Gz3Q+/XOcj+Zu8+5r8UpZ/bTqN71fy78UofwJ3iQkr
 kIUQnTrIexfFu5g6wwamCCXnSwSedS8eioqwBWo9afJjbK3YH1HEW9vGu
 ncLWDOk5VcDaCWPjN3+VQ7Q1bvv0OXHnM/7WRmlUPz3VLUvNTmBaQVuq2 g==;
X-CSE-ConnectionGUID: 8wuA8lVOSRGp3NDEc8FgNw==
X-CSE-MsgGUID: rfGeikJBQaOtIETc7n05Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3226555"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3226555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 15:48:24 -0800
X-CSE-ConnectionGUID: OBrl5lPZQVGsO4ZZ0YyItw==
X-CSE-MsgGUID: Wdq4BZXQSVqd2thien9rrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8512350"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com)
 ([10.3.206.11])
 by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 15:48:21 -0800
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
Subject: [PATCH 0/7] Include <asm/cpu_device_id.h> without #ifdef CONFIG_X86
Date: Wed, 11 Nov 2026 16:48:13 -0700
Message-ID: <20261111234821.4814-1-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
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

<asm/cpu_device_id.h> exists only on x86, so generic code that uses it
wraps the include in #ifdef CONFIG_X86. The P2PDMA series [1] adds a
generic version of the header, so the include can be unconditional.

This series drops the #ifdef around the include in the remaining
users, and in ccp, which does not use the header, the include itself.
Some of them also include <asm/intel-family.h>, which has no
generic version. That include is removed: on x86 it is already pulled
in by <asm/cpu_device_id.h>, and on other architectures the INTEL_*
model defines are not used. The #ifdef stays around code that needs
x86 for other reasons: CPU match tables using the INTEL_* model
defines and boot_cpu_data accesses.

Patches 1-6 are independent of each other and can go through the
respective trees once [1] has landed. Patch 7 does not depend on [1].

Based on mainline (7.4-rc2+) plus [1]. Built with x86_64 and arm64
allmodconfig, each patch separately.

[1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com

Pavel Popov (7):
  ACPI: mipi-disco-img: Include <asm/cpu_device_id.h> unconditionally
  drm/i915: Include <asm/cpu_device_id.h> unconditionally
  drm/amdgpu: Include <asm/cpu_device_id.h> unconditionally
  cpufreq: ondemand: Include <asm/cpu_device_id.h> unconditionally
  platform/x86: Include <asm/cpu_device_id.h> unconditionally in soc.h
  tpm: Include <asm/cpu_device_id.h> unconditionally
  crypto: ccp - Drop unused <asm/cpu_device_id.h> include

 drivers/acpi/mipi-disco-img.c              | 5 ++---
 drivers/char/tpm/tpm.h                     | 2 --
 drivers/cpufreq/cpufreq_ondemand.h         | 4 ++--
 drivers/crypto/ccp/ccp-dev.c               | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 drivers/gpu/drm/i915/intel_cpu_info.c      | 5 ++---
 include/linux/platform_data/x86/soc.h      | 5 ++---
 7 files changed, 8 insertions(+), 19 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
prerequisite-patch-id: 2a8952c8b8b6b019585a8bc449db628f458658cb
prerequisite-patch-id: 6b1715c7e4f230fedfcadf38303ce5966922caff
prerequisite-patch-id: 88872ad297c6b8ec80cb4ec4057ab281e10c148d
-- 
2.54.0

