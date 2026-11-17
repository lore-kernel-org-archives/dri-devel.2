Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AO59UyuW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55F910E0D6;
	Tue, 17 Nov 2026 20:49:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD8810E0D6;
 Tue, 17 Nov 2026 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794948591; x=1826484591;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=of3OpuqCe+xv7JIj1bArW1EVcNbtu9RMdNaP+TR4vlc=;
 b=AO59UyuWqa5DK8VeOv8E87tlYMq18l4BUp3viKU8e2UpkP3EaZH3tJ+w
 48lLPqMw3x+mSB24Fx/z3cws+AjNG2+ddXGc7NePLmLsNx0FL5xxcFdb1
 i3V2b7oSU4867yBXIbnneLKrv871jFUZWqehGJcJyzczQCdwZc/uSqjO2
 rQGQb1SWLi05ojzx1X6qk/QNtJZY7mJZYhi1qKN9Ck4ZC0zefT6/E5ZiN
 8qWf8xwH6HNoMQdGmf75b5bb1rYx1ApNISszLMdjOxo0gdgKp+jiG/Zhi
 QXC6VB5Q/2dvs79Wo75Cnmx5dTyVVT3qNXB49ACbGsYIj7X0ve3zGsB1t Q==;
X-CSE-ConnectionGUID: v8NF6z0NRxWueS3z4xjFpw==
X-CSE-MsgGUID: rpAWvhnVSfeFKjjodR2b9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3778702"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3778702"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:49:51 -0800
X-CSE-ConnectionGUID: R4eVa/JyRLWc8eS7YdD0ZQ==
X-CSE-MsgGUID: KGQHJuGkQBa+z4Sw0p3Mgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9716437"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 17 Nov 2026 12:49:48 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xTQ7d-00000001CRR-27DM;
 Tue, 17 Nov 2026 20:49:45 +0000
Date: Wed, 18 Nov 2026 04:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 14/19] drm/amd/display: Restrict the dc directory root to
 DC-internal builds
Message-ID: <202611180455.JKWVPyFi-lkp@intel.com>
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
config: i386-randconfig-1006-20260925 (https://download.01.org/0day-ci/archive/20261118/202611180455.JKWVPyFi-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261118/202611180455.JKWVPyFi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611180455.JKWVPyFi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
                    from drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c:24:
>> drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26:10: fatal error: dm_services_types.h: No such file or directory
      26 | #include "dm_services_types.h"
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +26 drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h

a2dd023a7788ba6 Eric Huang 2017-03-06  25  
20582319bce482e Rex Zhu    2018-06-20 @26  #include "dm_services_types.h"
20582319bce482e Rex Zhu    2018-06-20  27  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
