Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FEC606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAlhb+iz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A18E10E3C4;
	Fri, 27 Nov 2026 19:38:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1040710E3C4;
 Fri, 27 Nov 2026 19:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795808274; x=1827344274;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zE+2E/0tKXQ7uwcDPT37wQcSd57BL3umH2kOyf1J+i4=;
 b=bAlhb+iziAkVsuGwvQPOcebXpacqpdxC9S83KGxilhaS/xqlnc+7wQZ9
 UXZ1RkYDIHRImezCR8uvdCeY7i6ZP14ZAIGC/POztBvSdYN1xqBzAHK8d
 GvHns7alfO6bD2D+Vt1ZvYlmVuaTXoQCSZiCeppAAhBunQjeSQakQIcwY
 W9l/ylF3YSJfWsA4BbAi3HTvoMnnV9I7w8HY8fWOsmyDAPupxzW7lwB1H
 +s3SJW2+Lu3l15vi5au4Sqc9910UvvXPBDxTilvPMvOLscbYUz91iDgp3
 lPsum2bm+ZTbxQEA7cecw8Uzi+vjLrBnxdt6IBbc2Eieu9koXm5v3ktmt g==;
X-CSE-ConnectionGUID: Q9z2Lh/dS2qeyZjRwbJ3UQ==
X-CSE-MsgGUID: JnYuvu6yTIiq/mYGt6LTIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4628016"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4628016"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 11:37:53 -0800
X-CSE-ConnectionGUID: DVB8FTOOQ5GNP2Nufelj7g==
X-CSE-MsgGUID: SBA8Mns1SkGxD8bxpMD/Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="14219744"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1)
 ([10.211.93.152])
 by fmviesa011.fm.intel.com with ESMTP; 27 Nov 2026 11:37:48 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xX1lS-000000000Ks-1jDf;
 Fri, 27 Nov 2026 19:37:46 +0000
Date: Fri, 27 Nov 2026 20:36:54 +0100
From: kernel test robot <lkp@intel.com>
To: Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
Subject: Re: [PATCH 3/6] drm/imagination: Save metadata from firmware
Message-ID: <20261127203348.WkidhfEf-lkp@intel.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexandru,

kernel test robot noticed the following build errors:

[auto build test ERROR on c88084027d0e922dd925b96e5a0d184ba04a8f43]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Dadu/drm-imagination-Remove-get_fw_obj_gpu_addr/20261125-134829
base:   c88084027d0e922dd925b96e5a0d184ba04a8f43
patch link:    https://lore.kernel.org/r/20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3%40imgtec.com
patch subject: [PATCH 3/6] drm/imagination: Save metadata from firmware
config: arm64-randconfig-r2102-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127203348.WkidhfEf-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127203348.WkidhfEf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127203348.WkidhfEf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pvr_exp_fw_support
   >>> referenced by pvr_fw_info.c:150 (drivers/gpu/drm/imagination/pvr_fw_info.c:150)
   >>>               drivers/gpu/drm/imagination/pvr_fw_info.o:(pvr_fw_load_metadata_and_device_info) in archive vmlinux.a
   >>> referenced by pvr_fw_info.c:150 (drivers/gpu/drm/imagination/pvr_fw_info.c:150)
   >>>               drivers/gpu/drm/imagination/pvr_fw_info.o:(pvr_fw_load_metadata_and_device_info) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
