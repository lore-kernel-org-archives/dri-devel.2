Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3C5CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 00:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DEE10E027;
	Mon, 18 May 2026 00:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TyLrwLQ3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCBC10E027
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 00:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779064632; x=1810600632;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=njCHD/f2c63V8LMp47w0Fa8+2DaLQ7hDfr8h1FESJmM=;
 b=TyLrwLQ3DgVkzJ+ezbAet/BKnVAG1Jpq7ldVQQfCVYOORtz9vvNnjIWm
 eAsrpPNYl5C+XafN/BsFIjrrSVm89KX1rFdLpVPU8Po4mJdgl8Lj01eek
 qxSoxIh+L+iA17MsJlMGcaOXQ90gOscVTgIir9Z1SzeIqNjC48hstdBOd
 hlTZc5ptKtJEdNUMrvyCOHtFiEjJugBzdr0B2iZwdUmLTSm71Rid6mKFo
 nsu+nyYi8d27I2DO+D9rOki+iZH+32r1DSbKO3Kl4RLfnb4hzWzZ+cid0
 0ekj4RWRC+jHzJaJQmxSVqhjSQ5xLZAPxGQhS+UJrqv0nppR+nH/5Sgah g==;
X-CSE-ConnectionGUID: 5JtyMuPuQXyu7ypP6nFI5A==
X-CSE-MsgGUID: e7nBkRh+QPK4um6Q+LsHKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79962005"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="79962005"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 17:37:10 -0700
X-CSE-ConnectionGUID: gNBWH3h/Tw2aZI7jq7rx2w==
X-CSE-MsgGUID: qE6UX6E7QzqQs1xmFqH5XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="243569814"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 17 May 2026 17:37:06 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wOlyg-0000000027q-21fG;
 Mon, 18 May 2026 00:37:02 +0000
Date: Mon, 18 May 2026 08:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: vishnu.saini@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, prahlad.valluru@oss.qualcomm.com,
 Ravi Agola <raviagol@qti.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
Message-ID: <202605180800.luZQCJZK-lkp@intel.com>
References: <20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 4c26e162947f91aa78ba57dd4fddd38fc80e7d60]

url:    https://github.com/intel-lab-lkp/linux/commits/vishnu-saini-oss-qualcomm-com/drm-bridge-lt9611uxc-support-displays-with-up-to-4-EDID-blocks/20260518-021632
base:   4c26e162947f91aa78ba57dd4fddd38fc80e7d60
patch link:    https://lore.kernel.org/r/20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b%40oss.qualcomm.com
patch subject: [PATCH] drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks
config: i386-randconfig-014-20260518 (https://download.01.org/0day-ci/archive/20260518/202605180800.luZQCJZK-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260518/202605180800.luZQCJZK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605180800.luZQCJZK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:386,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/paravirt.h:19,
                    from arch/x86/include/asm/irqflags.h:100,
                    from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/firmware.h:8,
                    from drivers/gpu/drm/bridge/lontium-lt9611uxc.c:7:
   In function 'memcmp',
       inlined from 'lt9611uxc_get_edid_block' at drivers/gpu/drm/bridge/lontium-lt9611uxc.c:454:23:
>> include/linux/fortify-string.h:719:25: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object (2nd parameter)
     719 |                         __read_overflow2();
         |                         ^~~~~~~~~~~~~~~~~~


vim +/__read_overflow2 +719 include/linux/fortify-string.h

a28a6e860c6cf23 Francis Laniel 2021-02-25  708  
92df138a8d663ce Kees Cook      2022-02-08  709  __FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
281d0c962752fb4 Kees Cook      2022-02-08  710  int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t size)
a28a6e860c6cf23 Francis Laniel 2021-02-25  711  {
21a2c74b0a2a784 Kees Cook      2023-04-07  712  	const size_t p_size = __struct_size(p);
21a2c74b0a2a784 Kees Cook      2023-04-07  713  	const size_t q_size = __struct_size(q);
a28a6e860c6cf23 Francis Laniel 2021-02-25  714  
a28a6e860c6cf23 Francis Laniel 2021-02-25  715  	if (__builtin_constant_p(size)) {
fa35198f39571bb Kees Cook      2022-09-19  716  		if (__compiletime_lessthan(p_size, size))
a28a6e860c6cf23 Francis Laniel 2021-02-25  717  			__read_overflow();
fa35198f39571bb Kees Cook      2022-09-19  718  		if (__compiletime_lessthan(q_size, size))
a28a6e860c6cf23 Francis Laniel 2021-02-25 @719  			__read_overflow2();
a28a6e860c6cf23 Francis Laniel 2021-02-25  720  	}
3d965b33e40d973 Kees Cook      2023-04-07  721  	if (p_size < size)
3d965b33e40d973 Kees Cook      2023-04-07  722  		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, p_size, size, INT_MIN);
3d965b33e40d973 Kees Cook      2023-04-07  723  	else if (q_size < size)
3d965b33e40d973 Kees Cook      2023-04-07  724  		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, q_size, size, INT_MIN);
a28a6e860c6cf23 Francis Laniel 2021-02-25  725  	return __underlying_memcmp(p, q, size);
a28a6e860c6cf23 Francis Laniel 2021-02-25  726  }
a28a6e860c6cf23 Francis Laniel 2021-02-25  727  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
