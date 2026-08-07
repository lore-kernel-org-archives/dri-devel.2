Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25552C5AD2B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC9110F5CB;
	Fri,  7 Aug 2026 21:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MbSNVWAc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B4F10F5CB
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786139943; x=1817675943;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VHasMxwYYXoJ56pQ6QNc0I3jpPvwUq9cgskiwUeSXio=;
 b=MbSNVWAcL1RtxR9sepmbKNBAsqXq0BwfMn6DF9uzGJRlu7bFBookfBaD
 Pon9gMrZV9Ha4VuFyjLwzVfknC2MAy409dCjAMm3xRwQg0qxl29Lx1A2m
 ytCG5Vy71R5HOiVN4qZxXKE49bnfCJB6Eq5Q2q35lhbLS4gZekzuwsxhW
 iToRTHkjNGFJRRS0/8WU08DBI09TRJ5yzufJxza9hio0RbvK7xY1v1xcp
 MbXtawRwyREpgD91Uga7wsyLvyN91Mm2Rkzvvi2Jan+ldwtHq1wCaEMd3
 7rwClh1D1Uhd6rDyIPYqGce+w8s+Uup/znFIpIGcVcXXXfy8lxZ0AbY0k A==;
X-CSE-ConnectionGUID: mLaHwXSNQVCzHmHRRAtC/Q==
X-CSE-MsgGUID: 9fZ4R+fZTDa5sGOGMDRRTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86832703"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="86832703"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 14:59:03 -0700
X-CSE-ConnectionGUID: wVy+Db44TLCulX9GeFNTiA==
X-CSE-MsgGUID: mYEkk1BZSOGLZ6Os7eMDyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="259887401"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2026 14:59:00 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wsSaf-00000000JLt-0feH;
 Fri, 07 Aug 2026 21:58:57 +0000
Date: Sat, 8 Aug 2026 05:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: Re: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg
 removal
Message-ID: <202608080508.UGzRE4ZX-lkp@intel.com>
References: <20260624192700.5388-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624192700.5388-1-alhouseenyousef@gmail.com>
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

Hi Yousef,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yousef-Alhouseen/misc-fastrpc-release-pending-invoke-refs-on-rpmsg-removal/20260807-130030
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20260624192700.5388-1-alhouseenyousef%40gmail.com
patch subject: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg removal
config: s390-randconfig-r122-20260807 (https://download.01.org/0day-ci/archive/20260808/202608080508.UGzRE4ZX-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080508.UGzRE4ZX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080508.UGzRE4ZX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/misc/fastrpc.c:2661:11: error: no member named 'sent' in 'struct fastrpc_invoke_ctx'
    2661 |         if (ctx->sent && !ctx->completed) {
         |             ~~~  ^
>> drivers/misc/fastrpc.c:2661:25: error: no member named 'completed' in 'struct fastrpc_invoke_ctx'
    2661 |         if (ctx->sent && !ctx->completed) {
         |                           ~~~  ^
   drivers/misc/fastrpc.c:2662:8: error: no member named 'completed' in 'struct fastrpc_invoke_ctx'
    2662 |                 ctx->completed = true;
         |                 ~~~  ^
   3 errors generated.


vim +2661 drivers/misc/fastrpc.c

  2656	
  2657	static int fastrpc_notify_context(int id, void *ptr, void *data)
  2658	{
  2659		struct fastrpc_invoke_ctx *ctx = ptr;
  2660	
> 2661		if (ctx->sent && !ctx->completed) {
  2662			ctx->completed = true;
  2663			schedule_work(&ctx->put_work);
  2664		}
  2665	
  2666		ctx->retval = -EPIPE;
  2667		complete(&ctx->work);
  2668	
  2669		return 0;
  2670	}
  2671	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
