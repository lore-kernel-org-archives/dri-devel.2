Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7C606A880
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czzKdeD5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B98110E291;
	Mon, 16 Nov 2026 18:00:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D0E10E291
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794852039; x=1826388039;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wWTaX5iA12+M0wZvVENhAikZT3twTo+LW7rgrLUSPGY=;
 b=czzKdeD5M0VQO/XLCplAUBt5kG6UTfNZAHDTc2cz0yCI3u0+CL5tG04V
 5sps0E3mUUYovZhtmiX5uRJpw/tbTenewKzM9T48fD1zkdDmsShyrgrGq
 /nU+js8h+5xqu/wvI7dUrLtZfzWDMfyCNWO9wVJX1rdYwrn2w5X/KXvCy
 6ICDeS6no7jIfC2xPDV2rMU8XlY0pizIVdYYaMtt3QuMLPCT9oG3i0WVi
 nsdpBpQAhnarZ/M8VkG9mSXahpIGWeZ7iqjHIkE4I6uAhd0vVOOhDKrf5
 t7uLxMsw8O32IUZT64R4Z7aQReydrPlOJ4bhFZ0XKk7Hz/1fMFJXjqaez w==;
X-CSE-ConnectionGUID: XUm0H7t4QBaDdpgY30SknA==
X-CSE-MsgGUID: BMiI8jIoQJCsAvyfhEePNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3632824"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3632824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 10:00:39 -0800
X-CSE-ConnectionGUID: RV4zCj+tTT6w/vcjLZb1Bw==
X-CSE-MsgGUID: r6GgFtjpRX2f2sT+idN6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9591695"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 16 Nov 2026 10:00:34 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xT10J-000000019Bc-1yxt;
 Mon, 16 Nov 2026 18:00:31 +0000
Date: Tue, 17 Nov 2026 02:00:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Akash Goel <akash.goel@arm.com>,
 Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: Re: [PATCH v5 11/13] drm/panthor: Support FW init of protm
Message-ID: <202611170131.5ommYcYW-lkp@intel.com>
References: <20261116112601.3483649-12-ketil.johnsen@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116112601.3483649-12-ketil.johnsen@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ketil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on next-20261113]
[cannot apply to linux-review/Ketil-Johnsen/drm-panthor-De-duplicate-FW-memory-section-sync/20261012-145929 linus/master v7.4-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ketil-Johnsen/drm-panthor-De-duplicate-FW-memory-section-sync/20261116-122549
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261116112601.3483649-12-ketil.johnsen%40arm.com
patch subject: [PATCH v5 11/13] drm/panthor: Support FW init of protm
config: sparc64-randconfig-1000-20261116 (https://download.01.org/0day-ci/archive/20261117/202611170131.5ommYcYW-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170131.5ommYcYW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170131.5ommYcYW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/gpu/drm/panthor/panthor_fw.c:145 Excess struct member 'start' description in 'panthor_fw_binary_section_entry_hdr' (did you mean one of: 'va.start', 'data.start')
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:145 Excess struct member 'end' description in 'panthor_fw_binary_section_entry_hdr' (did you mean one of: 'va.end', 'data.end')
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:208 Excess struct member 'buf' description in 'panthor_fw_section' (did you mean one of: 'data.buf')
>> Warning: drivers/gpu/drm/panthor/panthor_fw.c:299 struct member 'protm' not described in 'panthor_fw'
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:299 Excess struct member 'ping_work' description in 'panthor_fw' (did you mean one of: 'watchdog.ping_work')
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:145 Excess struct member 'start' description in 'panthor_fw_binary_section_entry_hdr' (did you mean one of: 'va.start', 'data.start')
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:145 Excess struct member 'end' description in 'panthor_fw_binary_section_entry_hdr' (did you mean one of: 'va.end', 'data.end')
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:208 Excess struct member 'buf' description in 'panthor_fw_section' (did you mean one of: 'data.buf')
>> Warning: drivers/gpu/drm/panthor/panthor_fw.c:299 struct member 'protm' not described in 'panthor_fw'
   Warning: drivers/gpu/drm/panthor/panthor_fw.c:299 Excess struct member 'ping_work' description in 'panthor_fw' (did you mean one of: 'watchdog.ping_work')

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
