Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5C9C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AB310E897;
	Fri, 18 Sep 2026 11:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ig+dMfJE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6FF10E897
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789730779; x=1821266779;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tGRz+xcU5qGQznIZVXbWr3WfcKFpc6nf1I9Ey6LydvE=;
 b=Ig+dMfJE0NUhq8d0CPG8g9ooLXCtQvILUk6wJdtDDWEuVFTfuyOfomKS
 Ws11JKoUercYBt0ALatwu7PUbkicrSNhTify/JqbFPvW7Q7CnWTp8NQqY
 hTGH098SXTtNOtEjyCRpBtnZn3/7lh6yUp+Rg+U0BopR+jofFuwhFDIgH
 dfDDNpy5RaEs8SRYVkkgEqgCnDfQ9GfJOZ8iHZPU4x2pjijrHEfHW7ERD
 v4mNXHkLLiXGJbe2bsHf+QDRzq9OCdwgTiJKWDUefkiesn/qKX3aU/jP2
 Y6s2P8rIn/EIvaLI5jeU84HFpuK1Li0o+ysV/erMSl6/fEZleejyXsveI g==;
X-CSE-ConnectionGUID: SRiSZUFIRUGlHEb+YDMTnQ==
X-CSE-MsgGUID: ADpQbltpRe22sv3qbMwSGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89161974"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="89161974"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:26:19 -0700
X-CSE-ConnectionGUID: Bxn5rxPtQIKGT1DV6Rs8Gw==
X-CSE-MsgGUID: vYzwKo1pSIK7kKpuOq84rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2776820"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 04:26:15 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7WjM-000000009h7-1lon;
 Fri, 18 Sep 2026 11:26:12 +0000
Date: Fri, 18 Sep 2026 19:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Claire DuSoleil <claire.m.dusoleil@gmail.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Claire DuSoleil <claire.m.dusoleil@gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
Message-ID: <202609182113.RjRMgrW6-lkp@intel.com>
References: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Claire,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claire-DuSoleil/drm-vmwgfx-Fix-GEM_CLOSE-returning-EINVAL-for-PRIME-imported-surfaces/20260917-111312
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260917181312.12473-1-claire.m.dusoleil%40gmail.com
patch subject: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for PRIME-imported surfaces
config: x86_64-buildonly-randconfig-1001-20260918 (https://download.01.org/0day-ci/archive/20260918/202609182113.RjRMgrW6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609182113.RjRMgrW6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609182113.RjRMgrW6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:263 function parameter 'file_priv' not described in 'vmw_user_resource_lookup_handle'
>> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:263 function parameter 'file_priv' not described in 'vmw_user_resource_lookup_handle'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
