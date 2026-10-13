Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA2DCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CA610E718;
	Tue, 13 Oct 2026 04:53:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6101110E718
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791867175; x=1823403175;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7nJXonqH+rTItmlVnwPmw97jci53LyFWF9nUOD8veiU=;
 b=N7z003vvlL1eTibe/Q+GnPScWPB/kWXmaocGF7vmfMLpsV0tTFPYNLGo
 HOD4XrrOEbhCjfbdCsxcuNy+SLd9TYyhhcDMhjiBj3wmN2kXccP7cfvTw
 RdYqQkhNDtNywGr9Ns/Vm8SOa2ZWoSE00HuU8q6H7aUQPrZ+sIwNmU7Zy
 kDPEbrAYTAcpyF/Pxs9+oioQLn1+BF9/H8puZ+u/6poQTLBmpDOoEl8Gj
 HW7CkIyTFvCbBnTtpgPtwR0SwGXybcZyeZ7SS6V9bceHxbebpqcMqXCy6
 ZoTOnotiY88rnqaP548Ob0cFiTaH4BcOcnnuXKB7+46G4Bm+dPe2tY4LZ w==;
X-CSE-ConnectionGUID: /vMth0gXQWCK1mU4sMY81Q==
X-CSE-MsgGUID: LdmWdzuFSnqW/xgP6LZbxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="587918"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="587918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 21:52:54 -0700
X-CSE-ConnectionGUID: xR7btsJ1QyWEWFokvgGAPg==
X-CSE-MsgGUID: cyp7orBbSmuCSvNAWurFcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="966189"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 12 Oct 2026 21:52:50 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xGUVL-00000000CXQ-2yVE;
 Tue, 13 Oct 2026 04:52:47 +0000
Date: Tue, 13 Oct 2026 12:52:40 +0800
From: kernel test robot <lkp@intel.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nd@arm.com,
 =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: Re: [PATCH v7 6/8] drm/panthor: Implement sample handling
Message-ID: <202610131207.5wGThJW9-lkp@intel.com>
References: <20261011-panthor-performance-counters-v7-6-12c32495062f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-panthor-performance-counters-v7-6-12c32495062f@arm.com>
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

Hi Lukas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4b7a49d66c8398a7984dff4ac54d1acc6b3a58df]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Zapolskas/drm-panthor-Add-performance-counter-uAPI/20261011-183648
base:   4b7a49d66c8398a7984dff4ac54d1acc6b3a58df
patch link:    https://lore.kernel.org/r/20261011-panthor-performance-counters-v7-6-12c32495062f%40arm.com
patch subject: [PATCH v7 6/8] drm/panthor: Implement sample handling
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20261013/202610131207.5wGThJW9-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261013/202610131207.5wGThJW9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610131207.5wGThJW9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/panthor/panthor_perf.c: In function 'session_accumulate_sample':
>> drivers/gpu/drm/panthor/panthor_perf.c:902:57: error: passing argument 2 of 'bitmap_from_arr64' from incompatible pointer type [-Wincompatible-pointer-types]
     902 |                 bitmap_from_arr64(enabled_ctrs, em->mask[dst_blk->header.block_type],
         |                                                 ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                         |
         |                                                         long unsigned int *
   In file included from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/interrupt_rc.h:17,
                    from include/linux/spinlock.h:60,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/drm/drm_file.h:34,
                    from drivers/gpu/drm/panthor/panthor_perf.c:5:
   include/linux/bitmap.h:322:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'long unsigned int *'
     322 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~


vim +/bitmap_from_arr64 +902 drivers/gpu/drm/panthor/panthor_perf.c

   875	
   876	/**
   877	 * session_accumulate_sample - Accumulate requested counters into an existing sample.
   878	 * @ptdev: Panthor device.
   879	 * @session: Perf session.
   880	 * @session_sample: Start of the destination sample, including its header.
   881	 * @perf_sample: Start of the intermediate sample, including its header.
   882	 *
   883	 * Firmware enable masks select groups of counters. Copy timestamps and accumulate
   884	 * only the counters requested by this session.
   885	 */
   886	static void session_accumulate_sample(struct panthor_device *ptdev,
   887					      struct panthor_perf_session *session,
   888					      u8 *session_sample, u8 *perf_sample)
   889	{
   890		const struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
   891		struct panthor_perf_enable_masks *em = session->enabled_counters;
   892		struct panthor_perf_sample_block_iter iter;
   893		const u32 counters = perf_info->counters_per_block;
   894	
   895		sample_block_iter_init(perf_info, perf_sample, session_sample, &iter);
   896	
   897		while (sample_block_iter_next(&iter)) {
   898			DECLARE_BITMAP(enabled_ctrs, PANTHOR_PERF_EM_BITS);
   899			const struct panthor_perf_counter_block *src_blk = iter.src_blk;
   900			struct panthor_perf_counter_block *dst_blk = iter.dst_blk;
   901	
 > 902			bitmap_from_arr64(enabled_ctrs, em->mask[dst_blk->header.block_type],
   903					  PANTHOR_PERF_EM_BITS);
   904			bitmap_clear(enabled_ctrs, 0, PANTHOR_HEADER_COUNTERS);
   905	
   906			dst_blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =
   907				src_blk->counters[PANTHOR_CTR_TIMESTAMP_HI];
   908			dst_blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =
   909				src_blk->counters[PANTHOR_CTR_TIMESTAMP_LO];
   910	
   911			for (size_t ctr_idx = PANTHOR_HEADER_COUNTERS; ctr_idx < counters; ctr_idx++)
   912				if (test_bit(ctr_idx, enabled_ctrs))
   913					dst_blk->counters[ctr_idx] += src_blk->counters[ctr_idx];
   914		}
   915	}
   916	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
