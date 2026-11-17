Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664E606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIRuIEzW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BE710EE27;
	Tue, 17 Nov 2026 08:14:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B1B10EB46;
 Tue, 17 Nov 2026 08:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794903283; x=1826439283;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HNmUx0jrvNZHfbPCL0lRJuOzMXqXrDP37LApWQ+VGqo=;
 b=LIRuIEzWXHT6W14Zot/PA8K0urVntHnTCSIENZrMHH+VqyEn8KsDESb/
 zbcDxHcgnbObk4n+qvWLQUBkl/DNqoHtNjDuqjBoeIn045N7AM5Udh9x8
 Pk6v2p9ZhSM9MdgMSozAEDz6QVOVlh7Zz5l2KNrAhUEA+Dwksg81Mf68D
 DX13y1ewHcTftVPg+iDNIH90UL+D5KrWG6URIMg6Vb1VDFfhmSDiN5BgI
 /hUvuKQ/2Mth4KfSekmQHtl2aaSXe/kng6O4l1Zq/6bTbhDiifZ2/ShhG
 9psKKLw6iJC0rNds+QXVEDOaB9imhUWnVJ+5GONgSV8v74I6EOb82H0AA Q==;
X-CSE-ConnectionGUID: HhRe1UhvTES6xYkBpXpMvQ==
X-CSE-MsgGUID: Do9JAMsEQRyz9Skyr1hDiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3517175"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3517175"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 00:14:42 -0800
X-CSE-ConnectionGUID: HIAC5vPkQFS4EZd2BqhXXQ==
X-CSE-MsgGUID: t3tuitAFQPSxn+gSWM/hXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9947828"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2026 00:14:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xTEKq-00000001APf-071k;
 Tue, 17 Nov 2026 08:14:36 +0000
Date: Tue, 17 Nov 2026 16:14:03 +0800
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
Subject: Re: [PATCH 12/19] drm/amd/display: Migrate amdgpu_dm KUnit tests off
 struct dc internals
Message-ID: <202611171624.vqpwzkOB-lkp@intel.com>
References: <20261112-amdgpu-dc-cleanup-v1-12-0fae41718ad2@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-12-0fae41718ad2@redhat.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a6836fcbb5b22968019256025321d655b78bc49c]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie-via-B4-Relay/drm-amd-display-Drop-the-dead-vmid-module/20261112-114336
base:   a6836fcbb5b22968019256025321d655b78bc49c
patch link:    https://lore.kernel.org/r/20261112-amdgpu-dc-cleanup-v1-12-0fae41718ad2%40redhat.com
patch subject: [PATCH 12/19] drm/amd/display: Migrate amdgpu_dm KUnit tests off struct dc internals
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261117/202611171624.vqpwzkOB-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611171624.vqpwzkOB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611171624.vqpwzkOB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c:57:25: warning: cast from 'void (*)(struct dc *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      57 |         kunit_add_action(test, (kunit_action_t *)dc_test_destroy, dc);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +57 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c

    50	
    51	struct dc *dm_kunit_alloc_dc(struct kunit *test)
    52	{
    53		struct dc *dc;
    54	
    55		dc = dc_test_create();
    56		KUNIT_ASSERT_NOT_NULL(test, dc);
  > 57		kunit_add_action(test, (kunit_action_t *)dc_test_destroy, dc);
    58	
    59		return dc;
    60	}
    61	EXPORT_SYMBOL(dm_kunit_alloc_dc);
    62	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
