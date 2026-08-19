Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8CAC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF0010ED62;
	Wed, 19 Aug 2026 16:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EZ45mVbP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15ADA10ED62
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787158777; x=1818694777;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IOTVPUO0ZiUEmg41bEMQ7kpDRfBcTt+r8BmdyGIX5b8=;
 b=EZ45mVbPNrwrIxQxNqDukQW0DMiQF0ppEKVlMIlBsiE0LaCqgbG5VRCS
 fbK3m1uCVtSzZ0L0v6OYtoUzmRHj+r89tuLr+726oR4+9Dr3RHujdAiIh
 y4/K/HeJaTl079xluOZrC4FJ0QgCycZ2SGrKf96sHQQzmyaH02bxkq9JW
 q4fOqxrdj5nW7j1yqZjreTvEmRLwGdVfw1zNej+cDaBz8oV7EFnomPJh4
 p3f88J07HC+DofDtSHE6+p3yNxHmyuT2nsfVHXBw4vpAM7e63SLJhbe9+
 v3tO25ucNWeqRge3Vkw6sZVfl9sPS7LrN9G+4tiqun7MbjrHp38RW4ace A==;
X-CSE-ConnectionGUID: TEiOMK70QYCfQa1MtsLLKQ==
X-CSE-MsgGUID: hCJvr0XwRRqZcKgoOKrnQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98352309"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="98352309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 09:59:37 -0700
X-CSE-ConnectionGUID: UL1gamXjRPOcD03otLMATg==
X-CSE-MsgGUID: i6PhILTnTgKZeR+SeSVNgA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2026 09:59:33 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wwjdS-00000000fqn-15qv;
 Wed, 19 Aug 2026 16:59:30 +0000
Date: Thu, 20 Aug 2026 00:59:06 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Fastov <kfastov@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 David Hildenbrand <david@kernel.org>,
 Boris Brezillon <bbrezillon@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 Konstantin Fastov <kfastov@gmail.com>
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
Message-ID: <202608200018.9K0vPu3P-lkp@intel.com>
References: <20260804140403.16337-1-kfastov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804140403.16337-1-kfastov@gmail.com>
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

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on drm-misc/drm-misc-next linus/master v7.2 next-20260818]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Fastov/drm-gem-shmem-Install-writable-PTEs-for-write-faults/20260804-170403
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260804140403.16337-1-kfastov%40gmail.com
patch subject: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608200018.9K0vPu3P-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608200018.9K0vPu3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608200018.9K0vPu3P-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/memory.c:2887 function parameter 'mkwrite' not described in '__vmf_insert_pfn_prot'
>> Warning: mm/memory.c:2887 expecting prototype for vmf_insert_pfn_prot(). Prototype was for __vmf_insert_pfn_prot() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
