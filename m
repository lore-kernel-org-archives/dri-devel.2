Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005BCA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C585B10E733;
	Thu,  8 Oct 2026 04:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ivtTTux4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D0510E733
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 04:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791433043; x=1822969043;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ICoeoosIWbTj/bG3WY0JednzspW3OE5fElre7njVj3w=;
 b=ivtTTux4Hsob5OE0BCrnGngGsV6wriiXaDqI+vYE9wlpHiEY8cTBbl90
 DHtRRh9EN+SkKnZQMvMv7slVwrGZjJM6V2Tu/O6hluzPjrn99sqfom24h
 E4MGQUCWXzfCn3RKrkNR2VkcVmdyUPTZEqbxjpWttryTaIbZHGewHZlkG
 j5imeZ7b7ZYS/cTPVICAMuwXMNKqo5YR9gh0PeTETx8wGSMD2U7O4ZI0U
 msWk+3jpGPaWt26EUhGyGCT0MxdlMC/AuNX/OBFsareB4wWMO8zV6caI1
 o320eGolBu4U5QYqHU/9aB0hPzc+/iUwRr2LBsU7NbIXMN3xtalLVJboF g==;
X-CSE-ConnectionGUID: JMOEOWIUSqGOvUtlkxqUtg==
X-CSE-MsgGUID: 8moAGmBjRgGqhEtsZl0jqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="93665"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="93665"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 21:17:22 -0700
X-CSE-ConnectionGUID: 1X/HIWkKQfaPub1ZSubZsA==
X-CSE-MsgGUID: 8OfYMzt+SP+/v2se8fG8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="229129"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 07 Oct 2026 21:17:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xEfZC-000000003yS-1WSy;
 Thu, 08 Oct 2026 04:17:14 +0000
Date: Thu, 8 Oct 2026 12:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Hans Verkuil <hverkuil@kernel.org>, Florian Echtler <floe@butterbrot.org>,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
Message-ID: <202610081252.0UqYKs2X-lkp@intel.com>
References: <20261007054430.40155-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007054430.40155-1-kmehltretter@gmail.com>
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

Hi Karl,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2c3418fffa9d037b2038a6db48be63f9e2291806]

url:    https://github.com/intel-lab-lkp/linux/commits/Karl-Mehltretter/Input-sur40-fix-DMA-handling-in-video-capture/20261007-074430
base:   2c3418fffa9d037b2038a6db48be63f9e2291806
patch link:    https://lore.kernel.org/r/20261007054430.40155-1-kmehltretter%40gmail.com
patch subject: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
config: arm64-randconfig-1003-20261007 (https://download.01.org/0day-ci/archive/20261008/202610081252.0UqYKs2X-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610081252.0UqYKs2X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610081252.0UqYKs2X-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/input/touchscreen/sur40.ko: module uses symbol 'dma_buf_begin_cpu_access' from namespace 'DMA_BUF', but does not import it.
>> WARNING: modpost: drivers/input/touchscreen/sur40.ko: module uses symbol 'dma_buf_end_cpu_access' from namespace 'DMA_BUF', but does not import it.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
