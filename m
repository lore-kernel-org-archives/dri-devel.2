Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A781DC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B1D10EF06;
	Wed, 12 Aug 2026 09:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QIzUOxAK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E7C10EF05;
 Wed, 12 Aug 2026 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786525464; x=1818061464;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UdGB9+7e08qQfUZnrt6cY//dIOdB3U7twBuXZeLn08c=;
 b=QIzUOxAKCiFf14OlolDkg3Af3m7kFNiLzpc2bCqlMx66LL4rbkeiLxFu
 1mtLtVqs8VG3/nE0zeMoB66Ss3EEgDSgQkF07WAlZLxInVvEaN/yljaJ3
 X9DnTs4hyieVh1EkgZKiXw5uoa9GpfLgDNWj0JMQF4tEh4DY9M9QtZzDe
 k2Se9xVor5NjG/vvL/RDFv2hl8At2F47BuvjmqgdEUzdhYpi24FjipxaR
 Sd3JddqzID9Qk7RPBy7Vqpd+bbbMlbubMRpE3oxKk+Kd1aD9Ccm2EqhE0
 BcmMjfhFFXxRaL2yz5LVMTiJQNBkTjS+PrcA+pNCsdyBHdor+Se4ZUhGG w==;
X-CSE-ConnectionGUID: 2L3W+3kmSjiVr1ef33B1vQ==
X-CSE-MsgGUID: dJDD9a6rScKOtY46UUxX5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97660876"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="97660876"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:04:23 -0700
X-CSE-ConnectionGUID: S71a7UhDTxi0ed9Jw7tdmw==
X-CSE-MsgGUID: BXJuIXGgQY2PU8bGeeNyQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="257387293"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 02:04:21 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wu4sk-00000000QBy-3BXI;
 Wed, 12 Aug 2026 09:04:18 +0000
Date: Wed, 12 Aug 2026 17:03:39 +0800
From: kernel test robot <lkp@intel.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Pavitra Jha <jhapavitra98@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
Message-ID: <202608121611.JGbGRW2o-lkp@intel.com>
References: <20260708061835.111986-1-jhapavitra98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708061835.111986-1-jhapavitra98@gmail.com>
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

Hi Pavitra,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.2-rc7 next-20260810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavitra-Jha/drm-amdgpu-discovery-validate-table-offset-before-IP-discovery-header-cast/20260812-100224
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260708061835.111986-1-jhapavitra98%40gmail.com
patch subject: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP discovery header cast
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260812/202608121611.JGbGRW2o-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260812/202608121611.JGbGRW2o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608121611.JGbGRW2o-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/alpha/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/alpha/include/asm/bitops.h:472,
                    from include/linux/bitops.h:67,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/firmware.h:8,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:24:
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c: In function 'amdgpu_discovery_verify_npsinfo':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:534:32: error: invalid type argument of '->' (have 'struct table_info')
     534 |         if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
         |                                ^~
   include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:534:13: note: in expansion of macro 'le16_to_cpu'
     534 |         if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
         |             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:536:44: error: invalid type argument of '->' (have 'struct table_info')
     536 |                         le16_to_cpu((*info)->offset), table_id);
         |                                            ^~
   include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   include/linux/dev_printk.h:154:9: note: in expansion of macro 'dev_printk_index_wrap'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:535:17: note: in expansion of macro 'dev_err'
     535 |                 dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
         |                 ^~~~~~~
   In file included from include/linux/device.h:15,
                    from include/drm/drm_print.h:31,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:29,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:30,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:37,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:27:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:536:55: error: 'table_id' undeclared (first use in this function); did you mean 'table_info'?
     536 |                         le16_to_cpu((*info)->offset), table_id);
         |                                                       ^~~~~~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:535:17: note: in expansion of macro 'dev_err'
     535 |                 dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
         |                 ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:536:55: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:535:17: note: in expansion of macro 'dev_err'
     535 |                 dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
         |                 ^~~~~~~


vim +534 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

   508	
   509	static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
   510						   struct table_info *info)
   511	{
   512		uint8_t *discovery_bin = adev->discovery.bin;
   513		uint16_t checksum;
   514		uint16_t offset;
   515	
   516		offset = le16_to_cpu(info->offset);
   517		checksum = le16_to_cpu(info->checksum);
   518	
   519		struct nps_info_header *nhdr =
   520			(struct nps_info_header *)(discovery_bin + offset);
   521	
   522		if (le32_to_cpu(nhdr->table_id) != NPS_INFO_TABLE_ID) {
   523			dev_dbg(adev->dev, "invalid ip discovery nps info table id\n");
   524			return -EINVAL;
   525		}
   526	
   527		if (!amdgpu_discovery_verify_checksum(adev, discovery_bin + offset,
   528						      le32_to_cpu(nhdr->size_bytes),
   529						      checksum)) {
   530			dev_dbg(adev->dev, "invalid nps info data table checksum\n");
   531			return -EINVAL;
   532		}
   533	
 > 534		if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
   535			dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
 > 536				le16_to_cpu((*info)->offset), table_id);
   537			return -EINVAL;
   538		}
   539	
   540		return 0;
   541	}
   542	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
