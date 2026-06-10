Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602C2CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DA610E8CC;
	Wed, 10 Jun 2026 11:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EKeE0fCR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A187A10E8CC
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781089959; x=1812625959;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=cmgYCH7bAKow3n+v3GCCkyP/zSVvV5OBIjoYeOEHYJ0=;
 b=EKeE0fCRbG6W44RgWYw0CreZTotLrp3ShkGbE3J0YsfNUFSfw/SPo7IO
 wogay5JImcN4TGhHTQ5lVN4Hnrrn2ZHxNGW2KcODnFSaPaWechXNfzsBv
 UfmynRDGpEBoqgo4+1rK5l5Uv+chOCDlovY9eDYrN4DAKwKB0k0TUioeo
 KHV96HAq/Mn+GDyCUmPlgv0fAI7uzKrJEG2/8itZre/v1T3ZWFQ0m7bwJ
 XCsH9JUwKwo6PHLAMuq4OQDQVMCnhqD7VxJNuIP78XR2Qq5p6IHj1B7pO
 e6HEKP+DanWWzOVHSOgfF4KmrGhS73JeSPiK89H6uGLVJ+2AwDE/Vpso1 g==;
X-CSE-ConnectionGUID: xNGpCl8nRiC1+ZrjFypK4Q==
X-CSE-MsgGUID: nMfa3ruWQJ+5De9ZlMoruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81944480"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81944480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:12:39 -0700
X-CSE-ConnectionGUID: mRjzvZLJTg668CQ+F5VaaQ==
X-CSE-MsgGUID: dalGLgk7Tduj3Sxr/zDMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="248012738"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 10 Jun 2026 04:12:37 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wXGrL-00000000LKI-0DyM;
 Wed, 10 Jun 2026 11:12:35 +0000
Date: Wed, 10 Jun 2026 19:11:36 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?"Ma=C3=ADra?= Canal" <mcanal@igalia.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [drm-misc:drm-misc-next 8/13] Warning:
 drivers/gpu/drm/v3d/v3d_submit.c:85 function parameter 'submit' not described
 in 'v3d_lookup_bos'
Message-ID: <202606101838.EX8oSATj-lkp@intel.com>
User-Agent: s-nail v14.9.25
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Ma=C3=ADra,

FYI, the error/warning was bisected to this commit, please ignore it if it'=
s irrelevant.

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
head:   2df5efb45425b48fbf5a3c1f36a686af26871009
commit: f59d986943afbb97443cf91f45b1dc2c6fb6bebc [8/13] drm/v3d: Convert su=
bmit helpers to operate on struct v3d_submit
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/202606=
10/202606101838.EX8oSATj-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260610/202606101838.EX8oSATj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606101838.EX8oSATj-lkp@i=
ntel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/v3d/v3d_submit.c:85 function parameter 'submit'=
 not described in 'v3d_lookup_bos'
>> Warning: drivers/gpu/drm/v3d/v3d_submit.c:85 function parameter 'submit'=
 not described in 'v3d_lookup_bos'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
