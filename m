Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257FCCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF0410E5CB;
	Wed, 13 May 2026 07:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B9t+S3Jh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB2010E5CB
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778658186; x=1810194186;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TKIRWVOLQGmRSLSxOp4ZdNKhRgrjTEEnbWY6atM2t+o=;
 b=B9t+S3JhHslHJriB8P9jEZnv4bkjYjqia/SCjdWtXGhc+kjV0vb7Pl+f
 LLpU6nKPoveOFRrSSlD1ZBy1wWpMJOvGacszkZv3tpBnaoTF/pNHUI+J5
 fdaPSdlQkCICG253gmt4TFCtHQf5cg2Ib5fcMN+4uAPvHmF0B7A2YqAyF
 55WU50BxCayc4/mx9iafPjmyIKJHpJzbdt0YLTCF2pNKxxUPUw0lno9mm
 etOf5BYvPZtZreQgn3KRtm+exam6tpdrNBJQVGjqEnSgp7ZVSaSn4sXXB
 oudLInQFTwcfWyIU3PyUf7O5/3ZgLavIwO35mjmi3WacgM9qz+YKnZQJW A==;
X-CSE-ConnectionGUID: Jm/N/AOKTlSKS1k3JRvfMg==
X-CSE-MsgGUID: VuLTNj4QRc6dWe/XXUdZWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79434661"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79434661"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 00:43:04 -0700
X-CSE-ConnectionGUID: etY6YsZNQ+2KOAxeE+d6UA==
X-CSE-MsgGUID: OX9chYK2S6KzFnE7qhylLA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 13 May 2026 00:43:01 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wN4F8-000000003gh-2C10;
 Wed, 13 May 2026 07:42:58 +0000
Date: Wed, 13 May 2026 15:41:58 +0800
From: kernel test robot <lkp@intel.com>
To: Melih Emik <melihemik@noirlang.tr>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Wei Liu <wei.liu@kernel.org>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Mukesh Rathor <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: make sh_mobile_lcdc independent of FB_DEVICE
Message-ID: <202605131530.ZsNIZEco-lkp@intel.com>
References: <20260509213041.BqkXfeyP@66089470-6549-4c3e-ae4b-211f3f79ee1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509213041.BqkXfeyP@66089470-6549-4c3e-ae4b-211f3f79ee1e>
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

Hi Melih,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Melih-Emik/fbdev-make-sh_mobile_lcdc-independent-of-FB_DEVICE/20260512-235223
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260509213041.BqkXfeyP%4066089470-6549-4c3e-ae4b-211f3f79ee1e
patch subject: [PATCH] fbdev: make sh_mobile_lcdc independent of FB_DEVICE
config: powerpc64-randconfig-r111-20260513 (https://download.01.org/0day-ci/archive/20260513/202605131530.ZsNIZEco-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131530.ZsNIZEco-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131530.ZsNIZEco-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/backlight.h:12,
                    from drivers/video/fbdev/sh_mobile_lcdcfb.c:12:
   drivers/video/fbdev/sh_mobile_lcdcfb.c: In function 'sh_mobile_lcdc_release':
>> drivers/video/fbdev/sh_mobile_lcdcfb.c:1787:14: error: 'struct fb_info' has no member named 'dev'
     dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
                 ^~
   include/linux/dev_printk.h:139:23: note: in definition of macro 'dev_no_printk'
       _dev_printk(level, dev, fmt, ##__VA_ARGS__); \
                          ^~~
   drivers/video/fbdev/sh_mobile_lcdcfb.c:1787:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
     ^~~~~~~
   drivers/video/fbdev/sh_mobile_lcdcfb.c: In function 'sh_mobile_lcdc_open':
   drivers/video/fbdev/sh_mobile_lcdcfb.c:1810:14: error: 'struct fb_info' has no member named 'dev'
     dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
                 ^~
   include/linux/dev_printk.h:139:23: note: in definition of macro 'dev_no_printk'
       _dev_printk(level, dev, fmt, ##__VA_ARGS__); \
                          ^~~
   drivers/video/fbdev/sh_mobile_lcdcfb.c:1810:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
     ^~~~~~~
   drivers/video/fbdev/sh_mobile_lcdcfb.c: In function 'sh_mobile_lcdc_set_par':
   drivers/video/fbdev/sh_mobile_lcdcfb.c:1894:15: error: 'struct fb_info' has no member named 'dev'
      dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
                  ^~
   include/linux/dev_printk.h:110:11: note: in definition of macro 'dev_printk_index_wrap'
      _p_func(dev, fmt, ##__VA_ARGS__);   \
              ^~~
   drivers/video/fbdev/sh_mobile_lcdcfb.c:1894:3: note: in expansion of macro 'dev_err'
      dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
      ^~~~~~~


vim +1787 drivers/video/fbdev/sh_mobile_lcdcfb.c

dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1777  
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1778  /*
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1779   * Locking: both .fb_release() and .fb_open() are called with info->lock held if
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1780   * user == 1, or with console sem held, if user == 0.
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1781   */
d7ad3342186330 drivers/video/sh_mobile_lcdcfb.c Laurent Pinchart      2011-11-22  1782  static int sh_mobile_lcdc_release(struct fb_info *info, int user)
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1783  {
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1784  	struct sh_mobile_lcdc_chan *ch = info->par;
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1785  
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1786  	mutex_lock(&ch->open_lock);
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14 @1787  	dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1788  
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1789  	ch->use_count--;
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1790  
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1791  	/* Nothing to reconfigure, when called from fbcon */
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1792  	if (user) {
ac751efa6a0d70 drivers/video/sh_mobile_lcdcfb.c Torben Hohn           2011-01-25  1793  		console_lock();
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1794  		sh_mobile_fb_reconfig(info);
ac751efa6a0d70 drivers/video/sh_mobile_lcdcfb.c Torben Hohn           2011-01-25  1795  		console_unlock();
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1796  	}
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1797  
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1798  	mutex_unlock(&ch->open_lock);
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1799  
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1800  	return 0;
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1801  }
dd210503b77ae0 drivers/video/sh_mobile_lcdcfb.c Guennadi Liakhovetski 2010-09-14  1802  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
