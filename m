Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B7C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B4910E30E;
	Tue, 21 Jul 2026 10:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b283yPTp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A4D10E30E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784631278; x=1816167278;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DKeQFTd3Iiy7rV8sH1YHLkAeSnwIeAynn0DUI+70BEg=;
 b=b283yPTp+qkYd6w/3J99LQRuCXwdLzpnWifWg8hE2C3B+anH0CqG2EXk
 7spx4ehrtOcZan+Tox0/cdJxDHDIxK2xIyxfrIcsFFs6vQxJHzmc4cLcJ
 bqYwOaUXKhUrRd4RhnN/WPk9EcRrBZWdrTP0/pGklREzYfEOYL1jBBtrS
 U63n/q1+jcuLbLutgrTKc4V6APewVvLS1EfdT90GGvBHS/IALI0yCdaTw
 EyyD6NJ6iSzMyqnbTs3sNWo4z4zm1aeF7WnfhHCTprL0Zfn/2VwCSH+nj
 MeCtku9ULml1kgv+mKBIwMl2jS+HvzngwP2Sn1ARWOshMiRQoX/toKmDa A==;
X-CSE-ConnectionGUID: CHYnWvUiR+GyXhY1tpl/Rw==
X-CSE-MsgGUID: H9fOtXiGTyC0M5miUsLjFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96587827"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="96587827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 03:54:37 -0700
X-CSE-ConnectionGUID: leKP3pC+TAS9sr+L39KXng==
X-CSE-MsgGUID: oA4LAes3S4qWkbLFaRLztw==
X-ExtLoop1: 1
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa003.fm.intel.com with ESMTP; 21 Jul 2026 03:54:34 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: dri-devel@lists.freedesktop.org,
	rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH] drm/drv: Add buffer bounds check in drm_dev_wedged_event()
Date: Tue, 21 Jul 2026 16:20:42 +0530
Message-ID: <20260721105041.642598-2-mallesh.koujalagi@intel.com>
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

event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes. Since
scnprintf() reserves space for the terminating null byte, it can write
at most 31 characters.

When len reaches WEDGE_STR_LEN - 1, only the null terminator fits in the
remaining space. Any further scnprintf() calls return 0 and additional
recovery method names are silently dropped, making the truncation hard
to detect.

Add a drm_WARN_ON() check for len >= WEDGE_STR_LEN - 1 before attempting
another write. If the buffer is already full, emit a warning and stop
processing further entries. This makes buffer truncation visible and
allows the loop to exit cleanly instead of silently ignoring recovery
methods.

Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 1ff0bf7cba6a..63eef0a19e99 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -578,6 +578,9 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
 			break;
 
+		if (drm_WARN_ON(dev, len >= WEDGE_STR_LEN - 1))
+			break;
+
 		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
 	}
 
-- 
2.48.1

