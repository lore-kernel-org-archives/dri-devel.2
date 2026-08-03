Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179D2C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D6110E4C2;
	Mon,  3 Aug 2026 09:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QSIAmVdp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717C210E4C2
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785748585; x=1817284585;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0AWkUrUKVJoqZ6CdD4ZAMmYbznLSh7I0O1/y40Szv8c=;
 b=QSIAmVdpVivJ1qoJMCWyWZIMeKZSzKM5lIWaGdeoa6iDtcTIC40lA7W5
 Sws8ys8p9ky4YDnosAbERcgMXrSx3L4V8qG5xqHuqaveTrk/ikD58zSI8
 4Tlm2nItf4zcss+1Fk4PZqLktWj3v/07faqF7pdYq5tRiQXhGuMBVmFgt
 Y0Eg9LGoItqeUXFRwHx6Nxu+BbEJsmubdCgJMP7PnZtGGp4iqu6ZI+ghE
 cf+/dr4KKTcArCCTj9h+NBP4pOG63gPx0/vmYGPxR/WfNhSDtmUpalrnp
 NpJxCLqZh6yx50sTz0+sL/aJpvep/Y2pROlX2w5uugn4qZDP7YvKV87f4 Q==;
X-CSE-ConnectionGUID: n8o1+M/aQJSIunxEXPMQZg==
X-CSE-MsgGUID: +H8yrqORTLm5S9kc33VeXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="88809038"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="88809038"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:16:25 -0700
X-CSE-ConnectionGUID: SNYpZugVRDGsN6PK9n75Ag==
X-CSE-MsgGUID: a2h6LZYISzqfsV60n/Zj8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="261767842"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 03 Aug 2026 02:16:23 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wqomS-000000006aP-2ed0;
 Mon, 03 Aug 2026 09:16:20 +0000
Date: Mon, 3 Aug 2026 17:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?=D3scar_Meg=EDa_L=F3pez?= <megia.oscar@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: oe-kbuild-all@lists.linux.dev,
 =?iso-8859-1?Q?=D3scar_Meg=EDa_L=F3pez?= <megia.oscar@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] Memory leak error in qxl unbind
Message-ID: <202608031736.7YYw01c3-lkp@intel.com>
References: <20260727114155.69204-1-megia.oscar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727114155.69204-1-megia.oscar@gmail.com>
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

Hi Óscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.2-rc5 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/scar-Meg-a-L-pez/Memory-leak-error-in-qxl-unbind/20260803-140059
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260727114155.69204-1-megia.oscar%40gmail.com
patch subject: [PATCH v3] Memory leak error in qxl unbind
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260803/202608031736.7YYw01c3-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260803/202608031736.7YYw01c3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608031736.7YYw01c3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/ttm/ttm_pool.c: In function 'ttm_pool_mgr_fini':
>> drivers/gpu/drm/ttm/ttm_pool.c:1510:9: error: 'backup_fault_inject' undeclared (first use in this function)
    1510 |     if (backup_fault_inject.dname) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/ttm_pool.c:1510:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/backup_fault_inject +1510 drivers/gpu/drm/ttm/ttm_pool.c

  1502	
  1503	/**
  1504	 * ttm_pool_mgr_fini - Finalize globals
  1505	 *
  1506	 * Cleanup the global pools and unregister the MM shrinker.
  1507	 */
  1508	void ttm_pool_mgr_fini(void)
  1509	{
> 1510	    if (backup_fault_inject.dname) {

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
