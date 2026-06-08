Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A0CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 22:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A4610E395;
	Mon,  8 Jun 2026 22:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Id3YSbXt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF5110E395
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780957270; x=1812493270;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nOrvp/K0XgNlq7j+UTPcdpo4z07+p3UJ7MV7HzxAmi8=;
 b=Id3YSbXtSVNJoeiihWgmWeCthu1WD5NjbkWzDDkg4iJqfmVWXPbDVG6f
 Z2A1czMTT621uRdn890CTOzUanXlwaBFms7+xLwnvwJU0ZA6FcBO7VI6s
 JM1ZebXFgRg+EPDw69RpESFrPM/Exxxm5XJV7CKE9ZAoFHTpNjgoNiUH5
 0ww4oHwTfTQTNmurxFOvN0vY/FH8qKfn04zxI4QVXQQfwmbmVV2n397w/
 xsV2yTRE+PG2sMx8Z/cA7biK5ipclYwkVPO8zT5V/9+jtccF2706HN7Nu
 T4wt3B2P93N7MHKHajGNZNI8rSsuE6dnsWToILZeudyPyzk/R6mM8jg1F g==;
X-CSE-ConnectionGUID: nLqosKTBSrua3iUfcbdKpw==
X-CSE-MsgGUID: 0YJgqaysRj6v0IHZlv9XGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92383236"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="92383236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 15:21:09 -0700
X-CSE-ConnectionGUID: lJZjgeBlTN6jGd0GB9fJdQ==
X-CSE-MsgGUID: AFyYNntiSUuy9R2WgvdGkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="245774920"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4)
 ([10.211.93.152])
 by orviesa007.jf.intel.com with ESMTP; 08 Jun 2026 15:21:07 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wWiLA-000000003KT-1yBL;
 Mon, 08 Jun 2026 22:21:04 +0000
Date: Tue, 9 Jun 2026 00:20:52 +0200
From: kernel test robot <lkp@intel.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zack.rusin@broadcom.com>,
 David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH next] drivers/gpu/drm/vmwgfx/vmwgfx_msg: Use strscpy() to
 copy mks-guest-stat names
Message-ID: <202606090046.Gb27Aell-lkp@intel.com>
References: <20260608095523.2606-25-david.laight.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608095523.2606-25-david.laight.linux@gmail.com>
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

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260605]

url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/drivers-gpu-drm-vmwgfx-vmwgfx_msg-Use-strscpy-to-copy-mks-guest-stat-names/20260608-175822
base:   next-20260605
patch link:    https://lore.kernel.org/r/20260608095523.2606-25-david.laight.linux%40gmail.com
patch subject: [PATCH next] drivers/gpu/drm/vmwgfx/vmwgfx_msg: Use strscpy() to copy mks-guest-stat names
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260609/202606090046.Gb27Aell-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260609/202606090046.Gb27Aell-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606090046.Gb27Aell-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:666 function parameter 'lim' not described in 'mksstat_init_record_time'
>> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:666 function parameter 'lim' not described in 'mksstat_init_record_time'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
