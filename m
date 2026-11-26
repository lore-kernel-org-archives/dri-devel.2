Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C5606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lq0b51tc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE3510E1AB;
	Thu, 26 Nov 2026 05:13:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DFA10E1AB;
 Thu, 26 Nov 2026 05:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795669978; x=1827205978;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NqKhtBpJzofc/sJUBakwaXOayso/8xRaZnEIKxBMMEs=;
 b=Lq0b51tcsARYWLIWz1anX59ZBGIBS+ybu+IQhROW3UCSXIytxASPztaj
 pn9OFIEu92PjHiiaanflTQxtJE1cC6+Edy1KqP0PtnMYvmtMQaPX4W9Fn
 H1FpNwYRHCeknDqaTSbNS/jXCJR7VzYVci/3iO4q7dUVixtFGuxxra+9e
 XxIS2Co61yH2SZqfPVrwlAVGyopvdP1QZef/cT1XFfmC0HkcSkb62KZfe
 iT/zBaGPonnOr45iD4zf1V76APTMrvRC8Cqx63TMgYE6crcLSgRW89qI5
 GEvkxvxKjGzbsKJl2z6OL6ZoEOtIcbTNMMmxWNorE9RkuryXhZqbRYWpz Q==;
X-CSE-ConnectionGUID: FdMwZsxRQO2sJ41EEaDK2w==
X-CSE-MsgGUID: x+7tLkUtTYevK18l/sJ90w==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4632436"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4632436"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 21:12:57 -0800
X-CSE-ConnectionGUID: Oj6siLx/RmWUXqQXQG7QTw==
X-CSE-MsgGUID: DzDwKbanSm6fIbND0dzqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="14112070"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 25 Nov 2026 21:12:53 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWRmr-00000001TJi-3Ik9;
 Thu, 26 Nov 2026 05:12:49 +0000
Date: Thu, 26 Nov 2026 13:12:19 +0800
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
Message-ID: <20261126130340.K8Rznt4t-lkp@intel.com>
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
config: arm64-randconfig-1003-20261126 (https://download.01.org/0day-ci/archive/20261126/20261126130340.K8Rznt4t-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261126/20261126130340.K8Rznt4t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261126130340.K8Rznt4t-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/gpu/drm/imagination/powervr.ko: symbol 'pvr_exp_fw_support' undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
