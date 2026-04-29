Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF5CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F9D10F144;
	Wed, 29 Apr 2026 19:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k2QUmowe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C6310E3F4;
 Wed, 29 Apr 2026 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777489486; x=1809025486;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tsidYZBHseBKOISqltd/eKHnliZi9ZyEiXutHjbxvS0=;
 b=k2QUmowePQJYtexxH//yyHi8DUMMJF/dHdT01a7gK0DIdqkmM9J6XjC9
 /iEjVdMSCyxW1JuaCyD11ST3CIxh1i84mJP9oqkSNirrhao/LxUKVWsQr
 Pp9yH6vTlhLsxUrJzJ4++H7zaKuOdG1QWQR1d0FbPF/cJOc/XVsXdkAas
 By3cZv6YUQ30kng1fi0CACMzc9h4tIGVs3++8b9T4mpSTUzvD1eSj5hh5
 23G0vts2pj4jxs1rkLxkrIe/9QwRUZM0+57vISpXPz9niCerdbuupHQ4c
 5PbKIRsxo7augUoimnjisWGZb7Fmin2JuJZyCPz7vbH6vcYwjP4enTKSI w==;
X-CSE-ConnectionGUID: Mjdtlg9+Q7qm2hRJHWCKwA==
X-CSE-MsgGUID: 7pXjNAXEQ62fPmaxGEr6RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78536924"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="78536924"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 12:04:45 -0700
X-CSE-ConnectionGUID: wUoF0Hs8Tr2pd2NJYUbiCg==
X-CSE-MsgGUID: 1aNgzHMcQSSPenipv5Uycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="272481706"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 29 Apr 2026 12:04:42 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wIAD7-00000000BRA-48UD;
 Wed, 29 Apr 2026 19:04:37 +0000
Date: Thu, 30 Apr 2026 03:04:13 +0800
From: kernel test robot <lkp@intel.com>
To: Evgenii Burenchev <evg28bur@yandex.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Evgenii Burenchev <evg28bur@yandex.ru>,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon/rs780: prevent division by zero in refresh
 rate calculation
Message-ID: <202604300247.Gzeia1bh-lkp@intel.com>
References: <20260428190318.34413-1-evg28bur@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428190318.34413-1-evg28bur@yandex.ru>
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

Hi Evgenii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.1-rc1 next-20260428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evgenii-Burenchev/drm-radeon-rs780-prevent-division-by-zero-in-refresh-rate-calculation/20260429-055830
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260428190318.34413-1-evg28bur%40yandex.ru
patch subject: [PATCH] drm/radeon/rs780: prevent division by zero in refresh rate calculation
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260430/202604300247.Gzeia1bh-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300247.Gzeia1bh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300247.Gzeia1bh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/radeon/rs780_dpm.c: In function 'rs780_get_pm_mode_parameters':
>> drivers/gpu/drm/radeon/rs780_dpm.c:66:25: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      66 |                         if (crtc->mode.htotal && crtc->mode.vtotal)
         |                         ^~
   drivers/gpu/drm/radeon/rs780_dpm.c:68:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      68 |                                 if (pi->refresh_rate == 0)
         |                                 ^~


vim +/if +66 drivers/gpu/drm/radeon/rs780_dpm.c

9d67006e6ebc6c Alex Deucher      2013-04-12  48  
9d67006e6ebc6c Alex Deucher      2013-04-12  49  static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
9d67006e6ebc6c Alex Deucher      2013-04-12  50  {
9d67006e6ebc6c Alex Deucher      2013-04-12  51  	struct igp_power_info *pi = rs780_get_pi(rdev);
9d67006e6ebc6c Alex Deucher      2013-04-12  52  	struct radeon_mode_info *minfo = &rdev->mode_info;
9d67006e6ebc6c Alex Deucher      2013-04-12  53  	struct drm_crtc *crtc;
9d67006e6ebc6c Alex Deucher      2013-04-12  54  	struct radeon_crtc *radeon_crtc;
9d67006e6ebc6c Alex Deucher      2013-04-12  55  	int i;
9d67006e6ebc6c Alex Deucher      2013-04-12  56  
9d67006e6ebc6c Alex Deucher      2013-04-12  57  	/* defaults */
9d67006e6ebc6c Alex Deucher      2013-04-12  58  	pi->crtc_id = 0;
9d67006e6ebc6c Alex Deucher      2013-04-12  59  	pi->refresh_rate = 60;
9d67006e6ebc6c Alex Deucher      2013-04-12  60  
9d67006e6ebc6c Alex Deucher      2013-04-12  61  	for (i = 0; i < rdev->num_crtc; i++) {
9d67006e6ebc6c Alex Deucher      2013-04-12  62  		crtc = (struct drm_crtc *)minfo->crtcs[i];
9d67006e6ebc6c Alex Deucher      2013-04-12  63  		if (crtc && crtc->enabled) {
9d67006e6ebc6c Alex Deucher      2013-04-12  64  			radeon_crtc = to_radeon_crtc(crtc);
9d67006e6ebc6c Alex Deucher      2013-04-12  65  			pi->crtc_id = radeon_crtc->crtc_id;
9d67006e6ebc6c Alex Deucher      2013-04-12 @66  			if (crtc->mode.htotal && crtc->mode.vtotal)
c3eaa088277709 Alex Deucher      2013-09-13  67  				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
0d99a77de43b3f Evgenii Burenchev 2026-04-28  68  				if (pi->refresh_rate == 0)
0d99a77de43b3f Evgenii Burenchev 2026-04-28  69  					pi->refresh_rate = 60;
9d67006e6ebc6c Alex Deucher      2013-04-12  70  			break;
9d67006e6ebc6c Alex Deucher      2013-04-12  71  		}
9d67006e6ebc6c Alex Deucher      2013-04-12  72  	}
9d67006e6ebc6c Alex Deucher      2013-04-12  73  }
9d67006e6ebc6c Alex Deucher      2013-04-12  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
