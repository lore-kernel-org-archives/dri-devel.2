Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C06E64013
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 11:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C3210E05F;
	Sun,  5 Apr 2026 11:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZUbgjDKP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0056710E05F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775388795; x=1806924795;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/R3qxzeMXpyD4RTwvc+cC5xS2OS6iPw9360rHfkSAdQ=;
 b=ZUbgjDKPvH8IoBT3CkcQRQPn/U7KAu1ywqXKzbXt93rJhnzpNdP0IERO
 Ly0rju3Ts79h2z3Xu+yIkWGkTTQ6knGG4OQ39r9JF51jsBibWT+ZCLTIn
 f+ttXIJEd+nhtX589Nhtm9g/vlSggK49z+vOuM3WT3jo+n/of4VpE6Hhi
 5pdgTyPWGV2ZKZyiZP6oU7zYdE8M1dU1Nzx6K4GJ0oLddZqW/ZG62MzrE
 z1bPsfK1mgNYk+GwLJLXc3jBnRc5SGd/l81hiPVcmYzMciPmk319HMeOD
 ZMzZnLTQYDPPqweLOW4VYNvyiapkeE3+dJGyTIrblpKmL9HCd/9/iWQMI g==;
X-CSE-ConnectionGUID: X3azy3deT9CnGLtjRez4Rg==
X-CSE-MsgGUID: i/NaYxO0QJKKTYgZFtnqMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="76565394"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; d="scan'208";a="76565394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2026 04:33:14 -0700
X-CSE-ConnectionGUID: x7IkFCwUQVGpkV2o2f7r3A==
X-CSE-MsgGUID: NlMhtsT/QD6p1Kzv6QwtOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; d="scan'208";a="222843456"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2)
 ([10.211.93.152])
 by fmviesa006.fm.intel.com with ESMTP; 05 Apr 2026 04:33:09 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w9Lj1-000000009qf-1WTz;
 Sun, 05 Apr 2026 11:33:07 +0000
Date: Sun, 5 Apr 2026 13:32:50 +0200
From: kernel test robot <lkp@intel.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 2/2] Documentation: drm: Remove drm_atomic_state
 rename entry
Message-ID: <202604051325.jSSmpYZj-lkp@intel.com>
References: <20260402-drm-drm-atomic-update-v3-2-b826f51ac511@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-drm-drm-atomic-update-v3-2-b826f51ac511@kernel.org>
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

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9bdbf7eb25b3121ef19533df4fb70f2c39fc0d6a]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-Rename-struct-drm_atomic_state-to-drm_atomic_commit/20260405-115623
base:   9bdbf7eb25b3121ef19533df4fb70f2c39fc0d6a
patch link:    https://lore.kernel.org/r/20260402-drm-drm-atomic-update-v3-2-b826f51ac511%40kernel.org
patch subject: [PATCH v3 2/2] Documentation: drm: Remove drm_atomic_state rename entry
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260405/202604051325.jSSmpYZj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604051325.jSSmpYZj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Examples
   ~~~~~~~~ [docutils]
>> Documentation/gpu/komeda-kms.rst:420: WARNING: Title underline too short.


vim +420 Documentation/gpu/komeda-kms.rst

557c37360eca86 james qian wang (Arm Technology China  2019-01-03  408) 
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  409)     struct komeda_component {
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  410)         struct drm_private_obj obj;
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  411)         ...
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  412)     }
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  413) 
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  414)     struct komeda_pipeline {
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  415)         struct drm_private_obj obj;
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  416)         ...
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  417)     }
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  418) 
77e56dfef2e28b Maxime Ripard                          2026-04-02  419  Tracking component_state/pipeline_state by drm_atomic_commit
557c37360eca86 james qian wang (Arm Technology China  2019-01-03 @420) -----------------------------------------------------------
557c37360eca86 james qian wang (Arm Technology China  2019-01-03  421) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
