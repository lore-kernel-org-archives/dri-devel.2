Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00475C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 09:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D7F10E32D;
	Fri,  7 Aug 2026 09:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cgnKVRML";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B93810E32D
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786096321; x=1817632321;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nckWUvqxYBomBT0qk0CYLQmIUE0YhPuWnrKq/WEd7ko=;
 b=cgnKVRMLFC4Mh0SHSBzBzgYAhUr/drBNu4sfVBAhquyOikt/6MNzC86i
 kouluCgt1EmV/2dFcbwqMlfEiKVOtTyr0DdLGn2yo2IJObXqIpyKdcZe4
 zHATpYcMhYgrCD1sYI6zO6imc27KFdN5KbXwibjlm8oyEJK9S83qaDAmp
 MNK4wRx2/+WobPwBayTuWMoq/QhSg4ky9zqbZVgESqTDerSUlFZZbOUl9
 1FpyP0GXxU8fDlmroKdQPnHR5uU6Cm2yi/sIn/X39K37zo7z7WP52Sb46
 5qt1UDz/8y9dmTFTtpbeLiCKFr5S+XcfVEcymIiSvAzqWUNhCgF8JWqtC w==;
X-CSE-ConnectionGUID: XCC9JwwSTdGHmT42REILkA==
X-CSE-MsgGUID: xckmd4xRQy2zhYeFfFsRdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90582163"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="90582163"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 02:52:01 -0700
X-CSE-ConnectionGUID: HDVgAIaXTpe1qVy92RRnbg==
X-CSE-MsgGUID: jafg/z6ISnWQv/3Ju3CiRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="261840145"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 07 Aug 2026 02:51:59 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wsHF5-00000000Hn3-46Xs;
 Fri, 07 Aug 2026 09:51:55 +0000
Date: Fri, 7 Aug 2026 17:51:55 +0800
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
Message-ID: <202608071727.E43MoFeK-lkp@intel.com>
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
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.2-rc6 next-20260806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yousef-Alhouseen/misc-fastrpc-release-pending-invoke-refs-on-rpmsg-removal/20260807-130030
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20260624192700.5388-1-alhouseenyousef%40gmail.com
patch subject: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg removal
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260807/202608071727.E43MoFeK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260807/202608071727.E43MoFeK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608071727.E43MoFeK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_notify_context':
>> drivers/misc/fastrpc.c:2661:16: error: 'struct fastrpc_invoke_ctx' has no member named 'sent'
    2661 |         if (ctx->sent && !ctx->completed) {
         |                ^~
>> drivers/misc/fastrpc.c:2661:30: error: 'struct fastrpc_invoke_ctx' has no member named 'completed'
    2661 |         if (ctx->sent && !ctx->completed) {
         |                              ^~
   drivers/misc/fastrpc.c:2662:20: error: 'struct fastrpc_invoke_ctx' has no member named 'completed'
    2662 |                 ctx->completed = true;
         |                    ^~


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
