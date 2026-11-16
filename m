Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F00606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QG59by4f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0F410F4C1;
	Mon, 16 Nov 2026 23:06:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1FB10F4C1;
 Mon, 16 Nov 2026 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794870357; x=1826406357;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kcQFXxnGkJ9oNAgHJPO9N2b/lV43VH+GcFEhMBJGoUI=;
 b=QG59by4fU9ZZRbwF3tZ+qnwPKFZIoVJdsuuANFhmhIiN4XHvMaY+ZfEL
 sw9Svk2940qDS+iSFVQgCXfEc51vFaDEnla1Jdwr+1xCLrpP+WnJGY5Hy
 kcCbENfH/otUQlFwGtO4aGdOd8XM6j/Gagj7BNoDP5tThTNTZsQF/kMnP
 iusFsq+3MJORHCNcXR9rYwGUvNUMiu8DVSEm6EOYsnn1Rx/kKgVu3oPbj
 VnGnXFWtzO1httI+7HXESV9Gs8UZtuA5XQO7eoeWJ9Hju5jB59xDfNsJi
 JRFSCaJg8I9aCqhrjAZCAgQDHBaBXAOKU+OoOxyHIJ7m1kS1ztzQvtTdL g==;
X-CSE-ConnectionGUID: 59+6gBLWTt+WNx4/M5AGkA==
X-CSE-MsgGUID: tXRjoj03SMCcAP4ZH25QLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3702940"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3702940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 15:05:55 -0800
X-CSE-ConnectionGUID: JOk2BLxRQkyDqAWtagEa9w==
X-CSE-MsgGUID: VefEQxsBRLOpbzW0P4yJ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9843600"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 16 Nov 2026 15:05:52 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xT5lk-000000019aF-3rOx;
 Mon, 16 Nov 2026 23:05:48 +0000
Date: Tue, 17 Nov 2026 07:05:19 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 14/19] drm/amd/display: Restrict the dc directory root to
 DC-internal builds
Message-ID: <202611170620.2eTup2uR-lkp@intel.com>
References: <20261112-amdgpu-dc-cleanup-v1-14-0fae41718ad2@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-14-0fae41718ad2@redhat.com>
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

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on a6836fcbb5b22968019256025321d655b78bc49c]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie-via-B4-Relay/drm-amd-display-Drop-the-dead-vmid-module/20261112-114336
base:   a6836fcbb5b22968019256025321d655b78bc49c
patch link:    https://lore.kernel.org/r/20261112-amdgpu-dc-cleanup-v1-14-0fae41718ad2%40redhat.com
patch subject: [PATCH 14/19] drm/amd/display: Restrict the dc directory root to DC-internal builds
config: x86_64-randconfig-1001-20261117 (https://download.01.org/0day-ci/archive/20261117/202611170620.2eTup2uR-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170620.2eTup2uR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170620.2eTup2uR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager_v12.c:25:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.h:32:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_priv.h:51:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:57:
>> drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26:10: fatal error: 'dm_services_types.h' file not found
      26 | #include "dm_services_types.h"
         |          ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +26 drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h

a2dd023a7788ba6 Eric Huang 2017-03-06  25  
20582319bce482e Rex Zhu    2018-06-20 @26  #include "dm_services_types.h"
20582319bce482e Rex Zhu    2018-06-20  27  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
