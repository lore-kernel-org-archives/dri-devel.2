Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CE7CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD2310EEE9;
	Wed,  6 May 2026 22:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FYYVQUlU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D935C10EEE9;
 Wed,  6 May 2026 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778105854; x=1809641854;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sSBdSxsfHapwhnk8JWsFU92IVShCY53vUe1hkAP78Xk=;
 b=FYYVQUlUuOdgu6QOMScu03H4VqahhfCgK8iUGrroFE3kHmH/N1ER7+mq
 iMX7/L3AvyXxUXa8boelSbeYNu8H+R5toB5MJdw4bbHyb/eu/EtYF7STK
 udJsvFXLHf+9UAGd2LUjf7GRZLlOSfIqig76nMMn4rxIt8L4RdbOreFVr
 0AcVFQag1uLSXQEtKY2zY70+wDYszcEtVX3qlI0y5kdELX2hTnTLj3c1L
 0L7IK60piEPjr+EEGC0X9MrndzHI7nGohIGsPkiiimQxeFSOGj6s38S2y
 4FpfNOxA4wPdKU++tpPT5cnV97joS91Zu57LtoI8hFJT7IykWx8wVxpj4 w==;
X-CSE-ConnectionGUID: rENedALCQO2uuvr/tNzeTg==
X-CSE-MsgGUID: pekZhiNwRjelBQbOUtTrQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89638198"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="89638198"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 15:16:42 -0700
X-CSE-ConnectionGUID: JIThJWJVRKuSM5IItQBo2Q==
X-CSE-MsgGUID: 8T928h7nSWWvXYEh0v5dug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="238072298"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 06 May 2026 15:16:36 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wKkXg-000000001Gz-27pO;
 Wed, 06 May 2026 22:16:32 +0000
Date: Thu, 7 May 2026 06:15:55 +0800
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
Message-ID: <202605070624.Fss9vEZt-lkp@intel.com>
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
[also build test WARNING on linus/master v7.1-rc2]
[cannot apply to next-20260506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Melissa-Wen/drm-atomic-only-add-colorop-state-from-active-color-pipeline/20260504-102820
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260501132527.522320-7-mwen%40igalia.com
patch subject: [PATCH v4 6/6] drm/amd/display: use plane color_mgmt_changed to track colorop changes
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260507/202605070624.Fss9vEZt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260507/202605070624.Fss9vEZt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605070624.Fss9vEZt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_atomic.c:1625 function parameter 'plane_state' not described in 'drm_atomic_add_affected_colorops'
>> Warning: drivers/gpu/drm/drm_atomic.c:1625 function parameter 'plane_state' not described in 'drm_atomic_add_affected_colorops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
