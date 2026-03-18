Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F311077609
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421DA10E18D;
	Wed, 18 Mar 2026 19:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Rdh4GvnX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960FE10E18D;
 Wed, 18 Mar 2026 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773862541; x=1805398541;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=afMn9spXkrUU+N2aaHeBIllMcoSBOQY+2Duh84Hc3Lg=;
 b=Rdh4GvnX9Ff4NUHJSCYwr1UsRe+N3N6eBHbpX0ufHZvMPUKUX6PD/KtD
 vynCArtwk0lu3shIE2qend6v74C+LY/a6qXhdPbHWUlN0ew+SPyJ3B9Mu
 wu89CqmeU47v+6Jhru9wwXs/K0izJGbIuWlz3T/EGc/6AwzgLppz4x8ol
 /m5px4SVt/Csn3M2aB+uM75cJMHqQhb9t+rM/3svN7DGLA/HM5AZk/o/J
 t3DWNc733cKfgbURqRH51s8IOLx56EF2KkHtzuyCHjQGe5jHpx5axl7YD
 n8uL7WP310Prjt/jw6LCd/7GWXS3sCZJ0e05QMGK5Vc+sxPKhvbefet7c w==;
X-CSE-ConnectionGUID: alBlXgZcSRiTzCvY7GWOYA==
X-CSE-MsgGUID: gMpCuavGQGCdFB8+i4+SMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="77536520"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="77536520"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 12:35:40 -0700
X-CSE-ConnectionGUID: 1xULVR8AQM6h5v2lbnkBFg==
X-CSE-MsgGUID: 874DppwrThu+VoC6XgAptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="222698701"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2026 12:35:35 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w2wg0-000000003J7-24Hx;
 Wed, 18 Mar 2026 19:35:32 +0000
Date: Thu, 19 Mar 2026 03:35:13 +0800
From: kernel test robot <lkp@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v2 1/5] Introduce Xe Uncorrectable Error Handling
Message-ID: <202603190311.jqPlioXj-lkp@intel.com>
References: <20260318064016.374656-8-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318064016.374656-8-mallesh.koujalagi@intel.com>
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

Hi Mallesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on drm-misc/drm-misc-next drm/drm-next next-20260318]
[cannot apply to linus/master v7.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mallesh-Koujalagi/Introduce-Xe-Uncorrectable-Error-Handling/20260318-153303
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20260318064016.374656-8-mallesh.koujalagi%40intel.com
patch subject: [PATCH v2 1/5] Introduce Xe Uncorrectable Error Handling
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260319/202603190311.jqPlioXj-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190311.jqPlioXj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190311.jqPlioXj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_ras.c:241:4: warning: variable 'action' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     241 |                         default:
         |                         ^~~~~~~
   drivers/gpu/drm/xe/xe_ras.c:250:8: note: uninitialized use occurs here
     250 |                         if (action > final_action)
         |                             ^~~~~~
   drivers/gpu/drm/xe/xe_ras.c:227:4: note: variable 'action' is declared here
     227 |                         enum xe_ras_recovery_action action;
         |                         ^
   1 warning generated.


vim +/action +241 drivers/gpu/drm/xe/xe_ras.c

   177	
   178	/**
   179	 * xe_ras_process_errors - Process and contain hardware errors
   180	 * @xe: xe device instance
   181	 *
   182	 * Get error details from system controller and return recovery
   183	 * method. Called only from PCI error handling.
   184	 *
   185	 * Returns: recovery action to be taken
   186	 */
   187	enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
   188	{
   189		struct xe_sysctrl_mailbox_command command = {0};
   190		struct xe_ras_get_error_response response;
   191		enum xe_ras_recovery_action final_action;
   192		size_t rlen;
   193		int ret;
   194	
   195		/* Default action */
   196		final_action = XE_RAS_RECOVERY_ACTION_RECOVERED;
   197	
   198		if (!xe->info.has_sysctrl)
   199			return XE_RAS_RECOVERY_ACTION_RESET;
   200	
   201		xe_ras_prepare_sysctrl_command(&command, XE_SYSCTRL_CMD_GET_SOC_ERROR, NULL, 0,
   202					       &response, sizeof(response));
   203	
   204		do {
   205			memset(&response, 0, sizeof(response));
   206			rlen = 0;
   207	
   208			ret = xe_sysctrl_send_command(xe, &command, &rlen);
   209			if (ret || !rlen) {
   210				xe_err(xe, "[RAS]: Sysctrl error ret %d\n", ret);
   211				goto err;
   212			}
   213	
   214			if (rlen != sizeof(response)) {
   215				xe_err(xe, "[RAS]: Sysctrl response does not match len!!\n");
   216				goto err;
   217			}
   218	
   219			if (response.num_errors > XE_RAS_NUM_ERROR_ARR) {
   220				xe_err(xe, "[RAS]: Number of errors out of bound (%d)\n",
   221				       XE_RAS_NUM_ERROR_ARR);
   222				goto err;
   223			}
   224	
   225			for (int i = 0; i < response.num_errors; i++) {
   226				struct xe_ras_error_array arr = response.error_arr[i];
   227				enum xe_ras_recovery_action action;
   228				struct xe_ras_error_class error_class;
   229				u8 component;
   230	
   231				error_class = arr.error_class;
   232				component = error_class.common.component;
   233	
   234				switch (component) {
   235				case XE_RAS_COMPONENT_CORE_COMPUTE:
   236					action = handle_compute_errors(xe, &arr);
   237					break;
   238				case XE_RAS_COMPONENT_SOC_INTERNAL:
   239					action = handle_soc_internal_errors(xe, &arr);
   240					break;
 > 241				default:
   242					xe_err(xe, "[RAS]: Unknown error component %u\n", component);
   243					break;
   244				}
   245	
   246				/*
   247				 * Retain the highest severity action. Process and log all errors
   248				 * and then take appropriate recovery action
   249				 */
   250				if (action > final_action)
   251					final_action = action;
   252			}
   253	
   254		} while (response.additional_errors);
   255	
   256		return final_action;
   257	
   258	err:
   259		return XE_RAS_RECOVERY_ACTION_RESET;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
