Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BEDCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EE7112058;
	Fri,  9 Oct 2026 10:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gtaMZMIi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AAF112058
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791542119; x=1823078119;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MdDd40xdrLHiIdxTsGMSfQgOcKsmowKhQAg2xWrd3YE=;
 b=gtaMZMIi3we3JbpQQdyOY5kDWPAftT/FnhfLp6212nj6pV/gJcx74ckL
 fgrFbI0QMem0oUj5OCldMjzFAkb3P+LyVvBdkJn84MkxGZPQWoK1VU9LM
 VYgITGrYEkqkVnpejev0uXHGApXnkKcQwMh0PtuOSwD8YgcuWwFbuMKHy
 WLDQRDDUqrTj9AcjMM6ZF2mcJgbjEmCy1GSNKQSp6ggGUcdtbcgoAc6sJ
 CiaA/k6eaMibX/nBaetIOr/2dDmdu3U2JaM3mzoCmTfqkj5Rj9xMJvHrP
 Ze6xyl1r60Dt9/xkBKRUXYJ5CHw+4/Yo8MHX3JBmErX1s+rQl0idZ55W6 w==;
X-CSE-ConnectionGUID: T2flm4kKQ6moM9oyflTtng==
X-CSE-MsgGUID: 5Q0+9o5TRluU2m9pvQLJrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="226349"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="226349"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:35:18 -0700
X-CSE-ConnectionGUID: Foae2iWPT5KceI19Zc9wqQ==
X-CSE-MsgGUID: F6X5ZtNWRK6CM62SdzeM9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="605296"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 09 Oct 2026 03:35:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xF7wR-000000005dY-2o3F;
 Fri, 09 Oct 2026 10:35:07 +0000
Date: Fri, 9 Oct 2026 18:35:01 +0800
From: kernel test robot <lkp@intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Karl Mehltretter <kmehltretter@gmail.com>,
 Hans Verkuil <hverkuil@kernel.org>, Florian Echtler <floe@butterbrot.org>,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
Message-ID: <202610091847.RMZt5Cy1-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 2c3418fffa9d037b2038a6db48be63f9e2291806]

url:    https://github.com/intel-lab-lkp/linux/commits/Karl-Mehltretter/Input-sur40-fix-DMA-handling-in-video-capture/20261007-074430
base:   2c3418fffa9d037b2038a6db48be63f9e2291806
patch link:    https://lore.kernel.org/r/20261007054430.40155-1-kmehltretter%40gmail.com
patch subject: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
config: arm-randconfig-1003-20261009 (https://download.01.org/0day-ci/archive/20261009/202610091847.RMZt5Cy1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610091847.RMZt5Cy1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610091847.RMZt5Cy1-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/input/touchscreen/sur40.ko: module uses symbol 'dma_buf_begin_cpu_access' from namespace 'DMA_BUF', but does not import it.
>> ERROR: modpost: drivers/input/touchscreen/sur40.ko: module uses symbol 'dma_buf_end_cpu_access' from namespace 'DMA_BUF', but does not import it.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
