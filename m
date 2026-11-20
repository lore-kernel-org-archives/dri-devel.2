Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C6606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Se+8VKle
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC9310E547;
	Fri, 20 Nov 2026 05:34:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9BA10E547;
 Fri, 20 Nov 2026 05:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795152854; x=1826688854;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OCVdDxMr1t8M6dHp++0c2NOjv52F3+0v0dMULJONneI=;
 b=Se+8VKledSyLPsq8TRDNBJGaVjJpmt6hPIVSnQLXmuDdDbf/QWALMxU0
 B6r8/btG4At5XhdVPQ4JSg9h1DRf9W4elT6sdJfIlrfTwjmwM/dLyASWS
 roBcWRdUrh4ZGMqjSeRWoI/LxgqMiHe8ZpopFcvRjVmdRh8I98XDqFOcY
 3Z+UoWvKfMepyRx+HvpVw0zATKUWkiJ/smAW18D5fnx3HMTiqzMDrqoCS
 euBKnPK+zFkVSeeyG+U3ykOex+JgSD5ZAH0JozOL9crNcisqQxSBGmAR8
 Z0pStrSCHN4AXPRmWS97+DIywPmq6R7kmHbrnQS5OMpN/p0I1AVtLHDSG g==;
X-CSE-ConnectionGUID: w6ftqdIKSumBMFbnE1aEPQ==
X-CSE-MsgGUID: Dx46SQH7SQm3Azmw8q95FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4031998"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4031998"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:34:13 -0800
X-CSE-ConnectionGUID: hAI4nHgNSKCbgnGuJPNlMA==
X-CSE-MsgGUID: +H9SVWYHQuKgfc2f9usO8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10612149"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 19 Nov 2026 21:34:12 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xUHGC-00000001HAZ-3rSc;
 Fri, 20 Nov 2026 05:34:08 +0000
Date: Fri, 20 Nov 2026 13:33:54 +0800
From: kernel test robot <lkp@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v4 19/20] drm/nouveau: Allow platform driver build with
 COMPILE_TEST=y
Message-ID: <202611201357.plofVxy6-lkp@intel.com>
References: <20261118214518.29317-20-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118214518.29317-20-ville.syrjala@linux.intel.com>
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

Hi Ville,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on next-20261116]
[cannot apply to linus/master v7.4-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ville-Syrjala/drm-tilcdc-Allow-build-without-__iowmb/20261118-234458
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261118214518.29317-20-ville.syrjala%40linux.intel.com
patch subject: [PATCH v4 19/20] drm/nouveau: Allow platform driver build with COMPILE_TEST=y
config: i386-buildonly-randconfig-1002-20261120 (https://download.01.org/0day-ci/archive/20261120/202611201357.plofVxy6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261120/202611201357.plofVxy6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611201357.plofVxy6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_platform.c: In function 'nouveau_platform_resume':
>> drivers/gpu/drm/nouveau/nouveau_platform.c:53:37: error: incompatible type for argument 1 of 'gk20a_devfreq_resume'
      53 |         return gk20a_devfreq_resume(dev);
         |                                     ^~~
         |                                     |
         |                                     struct device *
   In file included from drivers/gpu/drm/nouveau/nouveau_platform.c:24:
   drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a_devfreq.h:20:54: note: expected 'struct device' but argument is of type 'struct device *'
      20 | static inline int gk20a_devfreq_resume(struct device dev) { return 0; }
         |                                        ~~~~~~~~~~~~~~^~~
>> drivers/gpu/drm/nouveau/nouveau_platform.c:54:1: warning: control reaches end of non-void function [-Wreturn-type]
      54 | }
         | ^


vim +/gk20a_devfreq_resume +53 drivers/gpu/drm/nouveau/nouveau_platform.c

6ca1701cecdb2de Aaron Kling 2025-09-06  50  
6ca1701cecdb2de Aaron Kling 2025-09-06  51  static int nouveau_platform_resume(struct device *dev)
6ca1701cecdb2de Aaron Kling 2025-09-06  52  {
6ca1701cecdb2de Aaron Kling 2025-09-06 @53  	return gk20a_devfreq_resume(dev);
6ca1701cecdb2de Aaron Kling 2025-09-06 @54  }
6ca1701cecdb2de Aaron Kling 2025-09-06  55  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
