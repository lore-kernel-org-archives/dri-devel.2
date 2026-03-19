Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EF51090237
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918ED10E8F7;
	Thu, 19 Mar 2026 14:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c91Xt275";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591A910E8F7;
 Thu, 19 Mar 2026 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773931345; x=1805467345;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mF9P9xEJz/zLQh0w3IiPXoQ8nHlIRIchufmKBE0UE+M=;
 b=c91Xt275cj8iGjkHjYpIOlLYC3Aj9AOIl1L9CUfXlVH/x17YiEBi5Y7L
 d3+VhEePx1WGs2gLi8JouE2x32Fg+IAa97fE9mXwN26GarwahNyfq0zIz
 krIO6P5kbYqC6eLFj5AJA0K3ilCV4e5G9dcc4pOSpMyR/YYVNbhWbEx3H
 5C9Sqpy21eU0X9gvCd3gFAnGtsqdYev1r8kbcd6ZZSxbtpi2P16XqqlG7
 KzzHfdLgJIq6665PT4TGePNp2GLizNgepTk/pEWaF8+bMjBOfL7809vdH
 rlkGm5QxYk3bbg2OD8Q1yOhhUkNbiFO7oRTc+ms+KWhVWbSUDeDtolO9e Q==;
X-CSE-ConnectionGUID: b1vdBEurTCS5KDqeiVimcg==
X-CSE-MsgGUID: O3Hf4rfwRUa7Q6aEotRSlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86366920"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="86366920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 07:42:24 -0700
X-CSE-ConnectionGUID: MGdL+LA3RZamzQeX7nNpCQ==
X-CSE-MsgGUID: z3vJNvLtRmGLuwGF4pRSug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="253447977"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
 by orviesa002.jf.intel.com with ESMTP; 19 Mar 2026 07:42:19 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w3EZk-0000000019N-2qie;
 Thu, 19 Mar 2026 14:42:16 +0000
Date: Thu, 19 Mar 2026 22:42:09 +0800
From: kernel test robot <lkp@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: oe-kbuild-all@lists.linux.dev, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v2 1/5] Introduce Xe Uncorrectable Error Handling
Message-ID: <202603192221.3sEGGig7-lkp@intel.com>
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
config: csky-randconfig-r122-20260319 (https://download.01.org/0day-ci/archive/20260319/202603192221.3sEGGig7-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603192221.3sEGGig7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603192221.3sEGGig7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_ras.c:170:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] data @@     got unsigned int [assigned] [usertype] req_hdr @@
   drivers/gpu/drm/xe/xe_ras.c:170:18: sparse:     expected restricted __le32 [usertype] data
   drivers/gpu/drm/xe/xe_ras.c:170:18: sparse:     got unsigned int [assigned] [usertype] req_hdr

vim +170 drivers/gpu/drm/xe/xe_ras.c

   159	
   160	static void xe_ras_prepare_sysctrl_command(struct xe_sysctrl_mailbox_command *command,
   161						   u32 cmd_mask, void *request, size_t request_len,
   162						   void *response, size_t response_len)
   163	{
   164		struct xe_sysctrl_mailbox_app_msg_hdr hdr = {0};
   165		u32 req_hdr;
   166	
   167		req_hdr = FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
   168			  FIELD_PREP(APP_HDR_COMMAND_MASK, cmd_mask);
   169	
 > 170		hdr.data = req_hdr;
   171		command->header = hdr;
   172		command->data_in = request;
   173		command->data_in_len = request_len;
   174		command->data_out = response;
   175		command->data_out_len = response_len;
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
