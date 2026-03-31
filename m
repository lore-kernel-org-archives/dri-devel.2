Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EB4FF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FDB10E991;
	Tue, 31 Mar 2026 09:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QGMSAp2y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BBF10E93E;
 Tue, 31 Mar 2026 09:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774947960; x=1806483960;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=LpF8CPUERwnfp4x/g1erifG3vovWpz9MwZQ00nw9QK4=;
 b=QGMSAp2ydbzc8+RQmik3S7EOtCOyC/NSVhJoPYih5BGWrnXS5XyZWVNX
 Tf+W1hnWtrPKrZbtogKjNcu8LOJONPjpl74GI+6HFglIizGBKx16gm0C3
 csBfNms1K3mZiHwGlLH8pzqZ2TtCvZT/4Lk15ecrCMqF8CHc1q/FeNmUn
 1WqeaSz4jt9l50boAKWdRGYjvbWNFckljyatJMp+UbbUI9pgS1RpXxa6s
 6IBxpATMJpyRC3d1rk4w1/y2a7F/u5SE6bRN5E62uVm0iZw0KxjtqDynX
 TdzIxqxfOwbPxC525bk07aq1N84Fxp2/d53NZyBDTC8EffNVQis9LAxd1 A==;
X-CSE-ConnectionGUID: adq4VKKNSDuLPJYLCo1NMg==
X-CSE-MsgGUID: fcf4NQzDSBSLVB79/Ka62A==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87420589"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87420589"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:05:59 -0700
X-CSE-ConnectionGUID: 1YFfipF4Teq64C5gkjHmSg==
X-CSE-MsgGUID: fgcUy/iTSdeKgYUMG6hLWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226559562"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 31 Mar 2026 02:05:54 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH v11 0/7] User readable error codes on atomic_ioctl failure
Date: Tue, 31 Mar 2026 14:33:52 +0530
Message-Id: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmNy2kC/03OywqDMBAF0F8pWXdKJhqjXfU/iouYRx2opiQiL
 eK/Nwp9LO9l7mEWllwkl9j5sLDoZkoUxhwQjwdmej3eHJDNBRNcSK5EDXoKAxkwjcLC20IqV7J
 8/IjO03OXrm3OPoYBpj46/ZtXQn3mMwJCpRujEW1hZXmhcXL3kwnDpvWUphBf+1tzvZmbUHEUz
 VeogUNpOtVxrzWX+Ce067q+ASG2mbPbAAAA
X-Change-ID: 20250728-atomic-c9713fd357e4
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, xaver.hugl@kde.org, 
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com, 
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Arun R Murthy <arun.r.murthy@intel.com>, 
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15-dev
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

The series focuses on providing a user readable error value on a failure
in drm_atomic_ioctl(). Usually -EINVAL is returned in most of the error
cases and it is difficult for the user to decode the error and get to
know the real cause for the error. If user gets to know the reason for
the error then corrective measurements can be taken up.

User will have to check for the capability
DRM_CAP_ATOMIC_ERROR_REPORTING before using this feature so as to ensure
that the driver supports failure reporting.

TODO: driver specific error codes are to be added and will be done in
the follow-up patches.

TODO: Once the series is merged the element 'reserved' used for sending
the failure code in struct drm_mode_atomic is to changed to err_code.

The IGT related changes are pushed for review @
https://patchwork.freedesktop.org/series/153330/

[RFC] changes for libdrm pushed for review @
https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/450

[DRAFT] KWin changes are pushed for review @
https://invent.kde.org/plasma/kwin/-/merge_requests/8991

    To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    To: suraj.kandpal@intel.com>
    To: Maxime Ripard <mripard@kernel.org>
    To: Thomas Zimmermann <tzimmermann@suse.de>
    To: David Airlie <airlied@gmail.com>
    To: Simona Vetter <simona@ffwll.ch>
    To: Jani Nikula <jani.nikula@linux.intel.com>
    To: Rodrigo Vivi <rodrigo.vivi@intel.com>
    To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
    To: Tvrtko Ursulin <tursulin@ursulin.net>
    To: xaver.hugl@kde.org
    To: harry.wentland@amd.com
    To: uma.shankar@intel.com
    To: louis.chauvet@bootlin.com
    To: naveen1.kumar@intel.com
    To: ramya.krishna.yella@intel.com
    Cc: dri-devel@lists.freedesktop.org
    Cc: intel-gfx@lists.freedesktop.org
    Cc: intel-xe@lists.freedesktop.org
    Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
Changes in v9:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v8: https://lore.kernel.org/r/20260129-atomic-v8-0-4cb7b0faa051@intel.com

---
Arun R Murthy (7):
      drm: Define user readable error codes for atomic ioctl
      drm/atomic: Add error_code element in atomic_state
      drm/atomic: Call complete_signaling only if prepare_signaling is done
      drm/atomic: Allocate atomic_state at the beginning of atomic_ioctl
      drm/atomic: Return user readable error in atomic_ioctl
      drm/i915/display: Error codes for async flip failures
      drm: Introduce DRM_CAP_ATOMIC_ERROR_REPORTING

 drivers/gpu/drm/drm_atomic.c                 | 31 ++++++++++
 drivers/gpu/drm/drm_atomic_uapi.c            | 89 ++++++++++++++++++++--------
 drivers/gpu/drm/drm_ioctl.c                  |  3 +
 drivers/gpu/drm/i915/display/intel_display.c | 25 ++++----
 include/drm/drm_atomic.h                     | 10 ++++
 include/uapi/drm/drm.h                       |  7 +++
 include/uapi/drm/drm_mode.h                  | 56 +++++++++++++++++
 7 files changed, 184 insertions(+), 37 deletions(-)
---
base-commit: 65b94118bc585aefc7095c0e9554c3bb12d98a69
change-id: 20250728-atomic-c9713fd357e4

Best regards,
-- 
Arun R Murthy <arun.r.murthy@intel.com>

