Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003CFCD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 21:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391C310E882;
	Mon,  4 May 2026 21:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="efs7M1Qd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0889110E401;
 Mon,  4 May 2026 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777928932; x=1809464932;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/ipDyCkoQCQ98nDjtbpsZx5sq7C7nmufuz2KncDTW6s=;
 b=efs7M1Qd/2+NxiPKjxqskqwvPyYdeclujOGPTWRyNOFQi4KEj6JUEpmH
 H+UCIjq8LXw+WVrHKm/m0QHvxUK+WoIBp6KuBSiUQAlnl/n9K3OYsWu+c
 fnEC3y2ZQ1/WTDjUmWU2qAqI3CsD69+wptKBmnD6mShkqBdVyxPwDNKyi
 udARYPsm4gZAlgHv2OVxAt3AZFJavUgDEWxKDSBv1ezR+DoLzpCF1ddMy
 NWdy2HDvJzN0H4GvD6B5UPQINyRz5Q6tyT4f0EJmtk5Pn9im7D/0apoBQ
 QrJ7YNGT3FFFThETXGRBVCeUMwSa3Hv4o2Ar6pzaJV/ju1RGMTz5VX6pU Q==;
X-CSE-ConnectionGUID: leT53BoWSZGzeWQaScLxkA==
X-CSE-MsgGUID: /BBSHw+vRdCiZ24bdxBgmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82404897"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="82404897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 14:08:51 -0700
X-CSE-ConnectionGUID: HIViqR3kTDKctvIEI4m8hg==
X-CSE-MsgGUID: knAIF5i/T+GvtIfiNNcSnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="232484885"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f)
 ([10.211.93.152])
 by fmviesa007.fm.intel.com with ESMTP; 04 May 2026 14:08:44 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wK0Ww-000000005y9-0MTw;
 Mon, 04 May 2026 21:08:42 +0000
Date: Mon, 4 May 2026 23:08:28 +0200
From: kernel test robot <lkp@intel.com>
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: oe-kbuild-all@lists.linux.dev, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 6/6] drm/amd/display: use plane color_mgmt_changed to
 track colorop changes
Message-ID: <202605042355.hTox5m9T-lkp@intel.com>
References: <20260501132527.522320-7-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501132527.522320-7-mwen@igalia.com>
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

Hi Melissa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on next-20260430]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Melissa-Wen/drm-atomic-only-add-colorop-state-from-active-color-pipeline/20260504-102820
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260501132527.522320-7-mwen%40igalia.com
patch subject: [PATCH v4 6/6] drm/amd/display: use plane color_mgmt_changed to track colorop changes
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260504/202605042355.hTox5m9T-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260504/202605042355.hTox5m9T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605042355.hTox5m9T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_atomic.c:1625 function parameter 'plane_state' not described in 'drm_atomic_add_affected_colorops'
>> Warning: drivers/gpu/drm/drm_atomic.c:1625 function parameter 'plane_state' not described in 'drm_atomic_add_affected_colorops'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
