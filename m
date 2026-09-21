Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D72C982F0
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8494410E6E2;
	Mon, 21 Sep 2026 13:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q2lZ3wlM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B80B89BE8;
 Mon, 21 Sep 2026 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789996139; x=1821532139;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dlU2sv3GOnPl4hnq2vNhiNWK6nIwI0ZVNNO+yeg0CEg=;
 b=Q2lZ3wlMgJv4nom1RiNfg26IZS7opOboOf5O1LoHK24YbLXG5EKrsd4n
 WQzeoXxuduzTcnIPfUC15NN0IUqT5CVnAaSN6sVDyrVpd4JqqlFizRiSb
 aUIFYe5Wi3VBHSjNf15x/F9z3UodUvNbnmcb+IJ88zd2s5EZ0IFZczfAA
 DK8BzQQjz8uF/hsxYqwyfVcxW3dukdknxxuxL22fLUdJZ5TFuRKhOKSWL
 9I2hdPwrKAyggUkeIhpVc1rQ+RPIgB8dMbDzNecVn6f/OjA/rzmfp7Se5
 GJQo02c9dHwneiYg/LnyHYJyjU8of0j98SASEO02Uv3aT62rgzT9GGfzH A==;
X-CSE-ConnectionGUID: l5e1SwZETf+rQ61+9O6xXA==
X-CSE-MsgGUID: aNEVIeKDSZ64VYW8ejaU6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101855943"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="101855943"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 06:08:58 -0700
X-CSE-ConnectionGUID: S+QfeygrQIW9g4Et2nI+0Q==
X-CSE-MsgGUID: r/JoBeZhT+qpU0SBZyfiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3678295"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa011.fm.intel.com with ESMTP; 21 Sep 2026 06:08:57 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 ankit.k.nautiyal@intel.com, adarsh.g.m@intel.com,
 Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH libdrm 0/2] Get active crtc list
Date: Mon, 21 Sep 2026 18:37:44 +0530
Message-Id: <20260921130747.2557722-1-arun.r.murthy@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

drmModeGetResources() tells the system capability and not runtime
availability of the hardware resource.
DRM_IOCTL_MODE_GETCRTC only tells userspace which CRTCs are enabled
through KMS, not which are active in hardware. A pipe can be actively
scanning out without being enabled through the KMS state, so relying on
GETCRTC alone would report such a CRTC as free and assignable when it is
not.
Add new function drmModeGetCrtcList that enumerates the crtc list.

Arun R Murthy (2):
  xf86drmMode: add drmModeGetCrtcList() to enumerate available CRTCs
  tests/crtclist: add utility to inspect CRTC usage

 core-symbols.txt  |   2 +
 tests/crtclist.c  | 116 +++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build |   9 ++++
 xf86drmMode.c     | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 xf86drmMode.h     |  38 ++++++++++++++
 5 files changed, 288 insertions(+)
 create mode 100644 tests/crtclist.c

-- 
2.25.1

