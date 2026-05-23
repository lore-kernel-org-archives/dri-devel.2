Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4D0CD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 05:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA8610E2D5;
	Sat, 23 May 2026 05:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lXKa36XC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C6F10E2CB;
 Sat, 23 May 2026 05:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779512746; x=1811048746;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oDS8N6xhUFY5za2tnraZ+5wty3X3X4mA/8BTEGBeA9g=;
 b=lXKa36XCoNE+pH8h5BxDILCW3Tv0hJ1scjbfUvYNAo4YpmcwXKch7T8z
 8RxAmFoHNvrk0vrfJu+iLxTXcpRpvLW6NkiNao8vhMh/HyEecnq7oT3wo
 d4ia8TpS6p27GOPeF9HXZH+uBH3fYo3NbPR3dUzinH9LBMjS6oDHJb9/V
 UZmWT+Wp3qp0oLzW9AldX9OS3jnHBdCOH1TCxoG/A5pkVFJWx6SJJcDbP
 fzB0yTZAKM9UgkDj79asxa25BaNEazmCncH04e9B4djxfEqgL9fHS+8ne
 //RnaoDTHZcbvOtVljrczizgtqGvPtUA3VphqeMdXsMo7H7KY/dmhMK3R g==;
X-CSE-ConnectionGUID: F2T1f9NJRBqbYLTb+KIRNw==
X-CSE-MsgGUID: PoFoEhatQheZwJLIgJ0vUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013520"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="83013520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 22:05:45 -0700
X-CSE-ConnectionGUID: eSV9SZH7T1Kddhot6eatEA==
X-CSE-MsgGUID: MCfeo5ECTUGhuu/h0Osb6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="279199745"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:42 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/4] DRM RAS Fixes
Date: Sat, 23 May 2026 10:30:18 +0530
Message-ID: <20260523050212.557292-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

Detailed description in commit message.

v2: Use goto (Riana)
    Retain info as NULL on failure (Riana)

Raag Jadav (4):
  drm/ras: Cancel and free message on get counter failure
  drm/xe/drm_ras: Make counter allocation drm managed
  drm/xe/drm_ras: Add per node cleanup action
  drm/xe/hw_error: Use HW_ERR prefix in log

 drivers/gpu/drm/drm_ras.c        | 19 +++++-----
 drivers/gpu/drm/xe/xe_drm_ras.c  | 62 +++++++++++++-------------------
 drivers/gpu/drm/xe/xe_hw_error.c | 12 +++----
 3 files changed, 41 insertions(+), 52 deletions(-)

-- 
2.43.0

