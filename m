Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201AAF99C95
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58CE10E3B3;
	Sun, 19 Apr 2026 00:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ICKNsE+O";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D596510E3B3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776557758; x=1808093758;
 h=date:from:to:cc:subject:message-id;
 bh=0f831QMgV5m08OSru3grZxpQxwfcHwj2qjqR7bdSiIc=;
 b=ICKNsE+O8hZI56qd7EfXiRPLYDSSj916uT5zjHjlqZKoBaBWdAqUJtEk
 4IwRbUN3vg6eDidKqoG4nrBfIGKHOzDPZ7R7Rt7mD+k6QlGDBEZAXDGF6
 yQhs5vBcpoCApvh660PmLdSCcVkZNOiFYjAZvCWYR+zPn9ApxLHEMN7cq
 Dkdq+V8hfOreSR8QMUPcB3j9sDD5nfC413c0T5cQ8uQHsre1CznF5rzBL
 OiY6VhcQ/3w2QVMcoU+Z6d+Y1vSuQGWXYerE9HEpLcKqwv5NdSK/RSEYf
 O+lfipGoktio1wpKqU+ovxLpavhuV1IeF1ade7WSqjYEnD5wi4pJroXzX A==;
X-CSE-ConnectionGUID: mND7I2i/TeGaO0BBbMx7Uw==
X-CSE-MsgGUID: HDNT1DpLR5KmevDn+yWcUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77228044"
X-IronPort-AV: E=Sophos;i="6.23,187,1770624000"; d="scan'208";a="77228044"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2026 17:15:57 -0700
X-CSE-ConnectionGUID: oZmluQoeQFqEjC7wu6zylQ==
X-CSE-MsgGUID: j/9mLiTdRjmddm3ESwgxkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,187,1770624000"; d="scan'208";a="224868987"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 18 Apr 2026 17:15:55 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wEFpJ-000000001bs-0Pex;
 Sun, 19 Apr 2026 00:15:53 +0000
Date: Sun, 19 Apr 2026 08:15:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Linus Walleij <linusw@kernel.org>
Subject: [drm-misc:drm-misc-next 16/19] Warning:
 drivers/gpu/drm/drm_panel.c:119 function parameter 'dev' not described in
 'devm_drm_panel_add'
Message-ID: <202604190843.wiFWsofZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
head:   17394e05b295e4936e0ed50d2f02ed7f08fd4f7d
commit: e43a8e3ad8fa3c2c2220a06fa46545c7ff82a9b7 [16/19] drm/panel: add devm_drm_panel_add() helper
config: openrisc-randconfig-r071-20260419 (https://download.01.org/0day-ci/archive/20260419/202604190843.wiFWsofZ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260419/202604190843.wiFWsofZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604190843.wiFWsofZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev' not described in 'devm_drm_panel_add'
>> Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev' not described in 'devm_drm_panel_add'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
