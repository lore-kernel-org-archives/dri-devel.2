Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD50BCD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 03:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53CE10E234;
	Sun, 17 May 2026 03:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S4l13bMl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE2410E231;
 Sun, 17 May 2026 03:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778988555; x=1810524555;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=W3hxyvPQIHp6N/EcjsueATTuNczPa4vrB3d34Qz9f4g=;
 b=S4l13bMlFmEjdLx1mo9Iitbi+FsPalL9bkNG/tCq2Dswcof4uVREoInl
 3fbNrSa1aRjKKW1a23AMY7wOORmk6FGk42hZoYOJ2tKWdUXYttMFEroTq
 eLvD4iHKej4bL2HFQ+DWl4wi3rnhLA8L+DYBGjP0gdUJQQHuGsRZb9Yta
 v5WizlRf3k4tVH4/AUBPhdtRUqwi06G8z5iJTJtqUw40dWXyaKDzn0vX/
 VFwO0G/6VjtUjZdeag9Usqry9dtH6tRl8YN45JsJuOFZey9EY3iFml6Nq
 DKcVriwPG4gGX1BPEzRM0qUcIO165LB0c4xWfjZkBEZSIRqIjUzcv8UW/ A==;
X-CSE-ConnectionGUID: KsBZG2adSL2TS1rfnj3aYg==
X-CSE-MsgGUID: eAxIL18wQ4aKPyVBsryRow==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90583159"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="90583159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2026 20:29:14 -0700
X-CSE-ConnectionGUID: hI1MqPDSRMqXqMwfZi0H0A==
X-CSE-MsgGUID: 4UbGB/DXS5WdSw+SZJgpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="243075114"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 16 May 2026 20:29:13 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wOSBh-000000001KU-4664;
 Sun, 17 May 2026 03:29:09 +0000
Date: Sun, 17 May 2026 11:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Gilles Risch <gilles.risch@gmail.com>, alexander.deucher@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: Re: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11, 1 /
 DCE3.1 systems
Message-ID: <202605171126.1g7CRkTZ-lkp@intel.com>
References: <20260516185226.3005-1-gilles.risch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516185226.3005-1-gilles.risch@gmail.com>
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

Hi Gilles,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gilles-Risch/drm-radeon-fix-eDP-resume-from-suspend-on-iMac11-1-DCE3-1-systems/20260517-025343
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260516185226.3005-1-gilles.risch%40gmail.com
patch subject: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11, 1 / DCE3.1 systems
config: riscv-randconfig-001-20260517 (https://download.01.org/0day-ci/archive/20260517/202605171126.1g7CRkTZ-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260517/202605171126.1g7CRkTZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605171126.1g7CRkTZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/radeon/atombios_encoders.c:1386:7: error: call to undeclared function 'ASIC_IS_DCE31'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1386 |         if (!ASIC_IS_DCE31(rdev))
         |              ^
   drivers/gpu/drm/radeon/atombios_encoders.c:1710:30: error: call to undeclared function 'ASIC_IS_DCE31'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1710 |                         if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev))
         |                                                   ^
   drivers/gpu/drm/radeon/atombios_encoders.c:1727:29: error: call to undeclared function 'ASIC_IS_DCE31'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1727 |                 if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)) {
         |                                           ^
   3 errors generated.


vim +/ASIC_IS_DCE31 +1386 drivers/gpu/drm/radeon/atombios_encoders.c

  1372	
  1373	bool
  1374	atombios_set_edp_panel_power(struct drm_connector *connector, int action)
  1375	{
  1376		struct radeon_connector *radeon_connector = to_radeon_connector(connector);
  1377		struct drm_device *dev = radeon_connector->base.dev;
  1378		struct radeon_device *rdev = dev->dev_private;
  1379		union dig_transmitter_control args;
  1380		int index = GetIndexIntoMasterTable(COMMAND, UNIPHYTransmitterControl);
  1381		uint8_t frev, crev;
  1382	
  1383		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
  1384			goto done;
  1385	
> 1386		if (!ASIC_IS_DCE31(rdev))
  1387			goto done;
  1388	
  1389		if ((action != ATOM_TRANSMITTER_ACTION_POWER_ON) &&
  1390		    (action != ATOM_TRANSMITTER_ACTION_POWER_OFF))
  1391			goto done;
  1392	
  1393		if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
  1394			goto done;
  1395	
  1396		memset(&args, 0, sizeof(args));
  1397	
  1398		args.v1.ucAction = action;
  1399	
  1400		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
  1401	
  1402		/* wait for the panel to power up */
  1403		if (action == ATOM_TRANSMITTER_ACTION_POWER_ON) {
  1404			int i;
  1405	
  1406			for (i = 0; i < 300; i++) {
  1407				if (radeon_hpd_sense(rdev, radeon_connector->hpd.hpd))
  1408					return true;
  1409				mdelay(1);
  1410			}
  1411			return false;
  1412		}
  1413	done:
  1414		return true;
  1415	}
  1416	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
