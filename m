Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63B7C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2275C10E799;
	Mon, 17 Aug 2026 12:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ezJ4VDt0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3242410E799;
 Mon, 17 Aug 2026 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786970794; x=1818506794;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=GCCShGLZVKOdzr3A/Zcu7hyC8d+KMfinoxQ0UwbtU7M=;
 b=ezJ4VDt0KCrm+pUdQIYrEumGAUsCThgpfA0WoLCt+k05FBkYvk4pb+YI
 KPHl/ZGBlmALAU1Cf5HFB3hbtgTTEruGVjfFBD6xjRFxRW7nZUQf2M0gC
 UCmsc+PhR9n43FHb9MOX0IN5qveh1U9N79yaCvtiGX5sMaZlNJWSm8xMM
 kAwoctkLVddRkcfL4r8gqIcCBscUOyVvPFG8r+bOA/Rz4tmghfAjwdAO/
 gNw9YmxeYDx+ZYgusbL1LmbxPid93fMqKe+wxt8qOz9M/UNXf7qT8+G6b
 bUccNvT4aa6b3v6EHtJTP2c6Zhsi21zmmderYF6NTI9NerHYR3dHTXEDA g==;
X-CSE-ConnectionGUID: ErvukmPkQiWvDB57BMBizA==
X-CSE-MsgGUID: tI5i7Fv6RdKIWt1XE80oqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86564683"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86564683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 05:46:34 -0700
X-CSE-ConnectionGUID: sPpsY5UMQFCrJzy2bnRiLA==
X-CSE-MsgGUID: TiMBwSIUSFW7eKRML9N7UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="263144311"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 17 Aug 2026 05:46:33 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wvwjV-00000000dSu-44Ph;
 Mon, 17 Aug 2026 12:46:29 +0000
Date: Mon, 17 Aug 2026 20:46:20 +0800
From: kernel test robot <lkp@intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [drm-tip:drm-tip 5/10] ERROR: modpost: "parse_hdmi_amd_vsdb"
 =?us-ascii?Q?[drivers/gpu/drm/amd/amdgpu/../display/amdgpu=5Fdm/tests/?=
 =?us-ascii?Q?amdgpu=5Fdm=5Fconnector=5Ftest.ko]?= undefined!
Message-ID: <202608172028.2FLcycRK-lkp@intel.com>
User-Agent: s-nail v14.9.25
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

tree:   https://gitlab.freedesktop.org/drm/tip.git drm-tip
head:   ceef0899403ceea5643d80a02bfdf9587f3845b8
commit: 443d3c62afbe3786b074bbb40f7449823c898738 [5/10] Merge remote-tracking branch 'drm-misc/drm-misc-next' into drm-tip
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260817/202608172028.2FLcycRK-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608172028.2FLcycRK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608172028.2FLcycRK-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "parse_hdmi_amd_vsdb" [drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
