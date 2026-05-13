Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C9CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 21:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1921810F073;
	Wed, 13 May 2026 21:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i626o3pP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7C210E341;
 Wed, 13 May 2026 21:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778707176; x=1810243176;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qfaGudcvJb8SuVmR+ev6ACuuwk22tesjsOI8ADGT+OM=;
 b=i626o3pPWrhJ5cu1gwvYOsu/3oiidqzvd++gLR0NV2+X6VN10/jrN5Wo
 2/Skg1yX1gnJDSEVAecIpxhjUFOxCuV7A4JdAgtGPHmr6yXVOe7dbC6c3
 YphJpRA1e7yX9jOBS9CpgMbDVY49RPGxhrQAZIHaitIWv4QLIj9UTcBL8
 zSnjLw+GYHci3sTftApyN8NoDW4Q9WBpvu6C3ocOFfh+UGgkp+PFC1a3c
 zzsLO8OYMBqbkX73qCXFAHi0HrS1v78C4CI4XW9iNaJUWZlF/Sgg0iSyq
 2tcRk0l5ojYv3QzP1PIijK9RPErOIZIP5G97/l5AZPVbZzD0HaUHYGLId A==;
X-CSE-ConnectionGUID: FIAEN7Z9R6GmEqOW9dJWCg==
X-CSE-MsgGUID: URv4Aj9iRg6qEC/5V3PRAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90221194"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; d="scan'208";a="90221194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 14:19:36 -0700
X-CSE-ConnectionGUID: B47wyUseQM6GkCVA5Irduw==
X-CSE-MsgGUID: ucbTwcsFQXqFyxerAl4R/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; d="scan'208";a="238311939"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 13 May 2026 14:19:33 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wNGzK-0000000058p-09DC;
 Wed, 13 May 2026 21:19:30 +0000
Date: Thu, 14 May 2026 05:18:36 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Hung <alex.hung@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 timur.kristof@gmail.com, pratap.nirujogi@amd.com,
 vitaly.prosyak@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig
Message-ID: <202605140506.TI8zPIBG-lkp@intel.com>
References: <20260505162018.1755740-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505162018.1755740-1-alex.hung@amd.com>
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

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Hung/drm-amdgpu-Remove-UML-build-exclusion-from-Kconfig/20260513-150500
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260505162018.1755740-1-alex.hung%40amd.com
patch subject: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20260514/202605140506.TI8zPIBG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605140506.TI8zPIBG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605140506.TI8zPIBG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In function 'kfd_cpumask_to_apic_id':
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2353:16: error: implicit declaration of function 'cpu_data' [-Wimplicit-function-declaration]
    2353 |         return cpu_data(first_cpu_of_numa_node).topo.apicid;
         |                ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2353:48: error: request for member 'topo' in something not a structure or union
    2353 |         return cpu_data(first_cpu_of_numa_node).topo.apicid;
         |                                                ^
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2357:1: warning: control reaches end of non-void function [-Wreturn-type]
    2357 | }
         | ^
--
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function 'kfd_fill_iolink_info_for_cpu':
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1830:34: error: implicit declaration of function 'cpu_data' [-Wimplicit-function-declaration]
    1830 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1830:33: error: lvalue required as unary '&' operand
    1830 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                 ^
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1833:14: error: invalid use of undefined type 'struct cpuinfo_x86'
    1833 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |              ^~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1833:30: error: 'X86_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_ANY'?
    1833 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |                              ^~~~~~~~~~~~~~
         |                              X86_VENDOR_ANY
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1833:30: note: each undeclared identifier is reported only once for each function it appears in


vim +/cpu_data +2353 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c

851a645efd0fee7 Felix Kuehling  2017-11-27  2342  
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2343  static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2344  {
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2345  	int first_cpu_of_numa_node;
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2346  
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2347  	if (!cpumask || cpumask == cpu_none_mask)
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2348  		return -1;
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2349  	first_cpu_of_numa_node = cpumask_first(cpumask);
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2350  	if (first_cpu_of_numa_node >= nr_cpu_ids)
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2351  		return -1;
df1dd4f4a7271eb Felix Kuehling  2019-01-02  2352  #ifdef CONFIG_X86_64
b9655e702dc5d85 Thomas Gleixner 2023-08-14 @2353  	return cpu_data(first_cpu_of_numa_node).topo.apicid;
df1dd4f4a7271eb Felix Kuehling  2019-01-02  2354  #else
df1dd4f4a7271eb Felix Kuehling  2019-01-02  2355  	return first_cpu_of_numa_node;
df1dd4f4a7271eb Felix Kuehling  2019-01-02  2356  #endif
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2357  }
520b8fb755ccfb0 Felix Kuehling  2017-12-08  2358  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
