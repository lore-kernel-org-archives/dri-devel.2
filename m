Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8857CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E2F10E08B;
	Wed, 20 May 2026 08:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xx5oDvuW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A0210E08B
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779265248; x=1810801248;
 h=date:from:to:cc:subject:message-id;
 bh=tMHbdwf7+MMKMapZGtefcm1fa9iTRzscq/6IxI7Ofzw=;
 b=Xx5oDvuWPw8AaJ1w7TYiwBtdfxVeXDO5dFkmWknzQBe1cgUOLmkaJfkM
 oe+wvA3GqfTW96zrNKVYjYVacE+xCrz8tvbw5QJ8hV5SOjlGDuC6ut4vC
 BHCK3VRPv0Xfwc44PCTY7ELYmLRUC6AZW1fUB/sscBYJ0Cd4BAAUqNwbF
 XGSSOl1SI1Q5836Q0K2gmouGHlNx44VIvnQ09AUaSWjBY+SFzmc6bUpdV
 P4feBwzu2HMkQg3xzw5IiWNgvJwwL1g1RMsEGAHi3UNaIM/MVi6d2Hcmk
 dgu+F6b1sNk9Qwwn0MLc77d9NGjcUPHIYgfB1SOgczI3AgforP7OyJQhg g==;
X-CSE-ConnectionGUID: hhiXuW6bTDOFOnp6hJNKyA==
X-CSE-MsgGUID: KYYZI+tmQeS3PGADxnvxUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80274161"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80274161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 01:20:48 -0700
X-CSE-ConnectionGUID: 6GShBFt3QIiybkW/AFD7BA==
X-CSE-MsgGUID: F/7m8kqSRt+Ks2kPhllAGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="241899900"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
 by fmviesa004.fm.intel.com with ESMTP; 20 May 2026 01:20:46 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wPcAW-000000002nt-0g6H;
 Wed, 20 May 2026 08:20:44 +0000
Date: Wed, 20 May 2026 16:20:17 +0800
From: kernel test robot <lkp@intel.com>
To: Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Matt Coster <matt.coster@imgtec.com>
Subject: [drm-misc:for-linux-next 3/5]
 drivers/gpu/drm/imagination/pvr_power.c:382:23: error: too few arguments to
 function 'pvr_power_fw_disable'; expected 3, have 2
Message-ID: <202605201611.xeaMCL0O-lkp@intel.com>
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

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git for-linux-next
head:   c1079aebb4de218caa86c44f9a53700d1a582683
commit: 42577ba79fbfbc6c2f246d523cb22a66329d4826 [3/5] drm/imagination: Rename FW booted to FW initialised
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260520/202605201611.xeaMCL0O-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605201611.xeaMCL0O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605201611.xeaMCL0O-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/imagination/pvr_power.c: In function 'pvr_power_device_suspend':
>> drivers/gpu/drm/imagination/pvr_power.c:382:23: error: too few arguments to function 'pvr_power_fw_disable'; expected 3, have 2
     382 |                 err = pvr_power_fw_disable(pvr_dev, false);
         |                       ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_power.c:93:1: note: declared here
      93 | pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_power.c: In function 'pvr_power_device_resume':
>> drivers/gpu/drm/imagination/pvr_power.c:412:23: error: too few arguments to function 'pvr_power_fw_enable'; expected 2, have 1
     412 |                 err = pvr_power_fw_enable(pvr_dev);
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_power.c:122:1: note: declared here
     122 | pvr_power_fw_enable(struct pvr_device *pvr_dev, bool rpm_resume)
         | ^~~~~~~~~~~~~~~~~~~


vim +/pvr_power_fw_disable +382 drivers/gpu/drm/imagination/pvr_power.c

   368	
   369	int
   370	pvr_power_device_suspend(struct device *dev)
   371	{
   372		struct platform_device *plat_dev = to_platform_device(dev);
   373		struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
   374		struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
   375		int err = 0;
   376		int idx;
   377	
   378		if (!drm_dev_enter(drm_dev, &idx))
   379			return -EIO;
   380	
   381		if (pvr_dev->fw_dev.initialised) {
 > 382			err = pvr_power_fw_disable(pvr_dev, false);
   383			if (err)
   384				goto err_drm_dev_exit;
   385		}
   386	
   387		err = pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
   388	
   389	err_drm_dev_exit:
   390		drm_dev_exit(idx);
   391	
   392		return err;
   393	}
   394	
   395	int
   396	pvr_power_device_resume(struct device *dev)
   397	{
   398		struct platform_device *plat_dev = to_platform_device(dev);
   399		struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
   400		struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
   401		int idx;
   402		int err;
   403	
   404		if (!drm_dev_enter(drm_dev, &idx))
   405			return -EIO;
   406	
   407		err = pvr_dev->device_data->pwr_ops->power_on(pvr_dev);
   408		if (err)
   409			goto err_drm_dev_exit;
   410	
   411		if (pvr_dev->fw_dev.initialised) {
 > 412			err = pvr_power_fw_enable(pvr_dev);
   413			if (err)
   414				goto err_power_off;
   415		}
   416	
   417		drm_dev_exit(idx);
   418	
   419		return 0;
   420	
   421	err_power_off:
   422		pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
   423	
   424	err_drm_dev_exit:
   425		drm_dev_exit(idx);
   426	
   427		return err;
   428	}
   429	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
