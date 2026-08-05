Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63458C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B7610ECDD;
	Wed,  5 Aug 2026 06:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="igdJt2SW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2EF10ECDD;
 Wed,  5 Aug 2026 06:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785909883; x=1817445883;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4Dx2yDPCkyFQMbp325MbRQe6G9ZLtqCxCXhBkxJvRzc=;
 b=igdJt2SWRJ+yHuXCUiJ5ApS3xXOlVeQ5mO3LT1o4x4V7uDPQf0w+VBgQ
 Q+06s3P3oy12/NwanLqG1zEtbX6aeaBWp0cqskfrtma3vpNuA0so5EUUg
 s1jMxihRNaDrqr7g99JdlslRDttoHu+9H/w230CujJeJESzL1iuKzyL8b
 ZUSmV8CrpM29KGd9McpdW9+TUuquNtAUm+F4jTW1XGyfp/wn9AmxxQKGU
 MepqqBRH49gSRjEqiz5FFuwqh3G1K22LTSfjOJilu/+IEylEPd+baoOqh
 hbIhLq+BSt7V+E+bIWrRNIRu+pcxnthh+siR8sFRyGgosM+wdCR2nANIL g==;
X-CSE-ConnectionGUID: vZIVCj+xSumz4K1HZGBfRQ==
X-CSE-MsgGUID: ec+sZfEcRra27gHM72gbtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86483624"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86483624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 23:04:42 -0700
X-CSE-ConnectionGUID: lX7Ub0lbQMO/9qGURTdxDQ==
X-CSE-MsgGUID: NYLygFFYQbyp8lJZGyzVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="291653100"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 04 Aug 2026 23:04:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrUk0-00000000Bjh-3RBH;
 Wed, 05 Aug 2026 06:04:36 +0000
Date: Wed, 5 Aug 2026 14:03:16 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH] drm/xe/pf: clear pending packet on header init failure
Message-ID: <202608051326.aRuRqBCC-lkp@intel.com>
References: <20260708071502.722393-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708071502.722393-1-lgs201920130244@gmail.com>
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

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-xe/drm-xe-next]
[also build test ERROR on linus/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/drm-xe-pf-clear-pending-packet-on-header-init-failure/20260805-104621
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20260708071502.722393-1-lgs201920130244%40gmail.com
patch subject: [PATCH] drm/xe/pf: clear pending packet on header init failure
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260805/202608051326.aRuRqBCC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608051326.aRuRqBCC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608051326.aRuRqBCC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/xe/xe_sriov_packet.c: In function 'xe_sriov_packet_write_single':
>> drivers/gpu/drm/xe/xe_sriov_packet.c:350:17: error: unknown type name 'rturn'
     350 |                 rturn copied;
         |                 ^~~~~
>> drivers/gpu/drm/xe/xe_sriov_packet.c:350:23: warning: unused variable 'copied' [-Wunused-variable]
     350 |                 rturn copied;
         |                       ^~~~~~


vim +/rturn +350 drivers/gpu/drm/xe/xe_sriov_packet.c

   313	
   314	/**
   315	 * xe_sriov_packet_write_single() - Write migration data to a single packet.
   316	 * @xe: the &xe_device
   317	 * @vfid: the VF identifier
   318	 * @buf: start address of userspace buffer
   319	 * @len: requested write size from userspace
   320	 *
   321	 * Return: number of bytes that has been successfully written,
   322	 *	   -errno on failure.
   323	 */
   324	ssize_t xe_sriov_packet_write_single(struct xe_device *xe, unsigned int vfid,
   325					     const char __user *buf, size_t len)
   326	{
   327		struct xe_sriov_packet **data = pf_pick_pending(xe, vfid);
   328		ssize_t copied;
   329		bool writing_hdr;
   330		int ret;
   331	
   332		if (IS_ERR_OR_NULL(*data)) {
   333			*data = xe_sriov_packet_alloc(xe);
   334			if (!*data)
   335				return -ENOMEM;
   336		}
   337	
   338		writing_hdr = (*data)->hdr_remaining;
   339		if (writing_hdr)
   340			copied = pkt_hdr_write(*data, buf, len);
   341		else
   342			copied = pkt_data_write(*data, buf, len);
   343	
   344		if (copied < 0) {
   345			if (writing_hdr && !(*data)->hdr_remaining) {
   346				kfree(*data);
   347				*data = NULL;
   348			}
   349	
 > 350			rturn copied;
   351		}
   352	
   353		if ((*data)->hdr_remaining == 0 && (*data)->remaining == 0) {
   354			ret = xe_sriov_pf_migration_restore_produce(xe, vfid, *data);
   355			if (ret) {
   356				xe_sriov_packet_free(*data);
   357				*data = NULL;
   358	
   359				return ret;
   360			}
   361	
   362			*data = NULL;
   363		}
   364	
   365		return copied;
   366	}
   367	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
