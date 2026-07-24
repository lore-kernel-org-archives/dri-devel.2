Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6BBC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0C810E35F;
	Fri, 24 Jul 2026 06:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R4g4wFlk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C840B10E35F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784874851; x=1816410851;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mQVBjr/gG4iVez2YMklYm2tmU7dU6JGzbyJWrBTGKhU=;
 b=R4g4wFlkxxV5ZZ1f0QpRaipDe3c8Nq60OF36IAkF7r/6gihXEwpyqJqb
 gLhFfL4jr28iGFhAoUeYrTKoOmxqEMektdxO4+XDnwDYsh4OpZhUJVkNl
 KYt0baZp1YE6yQhStCzxRdLVR6O34PnS7iSex5nSKwEr/NKg4PW13Stmo
 L7Sw9xHD3Gt7aI0hsNnqAxjFK8fv/Md/L1QxWm/sRoGFQ2eahErcI5zYS
 UIfbSQm5LCwIQLPispKgzwGNpimKexCKSV3+B9yplQWsg6pSurTbeEBH7
 FxSezLIMP8c5KCi9HZHXguhNFP0iOW5qS56aBxbjEoDtH1FLJtvF+E+d1 Q==;
X-CSE-ConnectionGUID: oT73goQ1RpKFqnDp1wuTbw==
X-CSE-MsgGUID: nz4z0kRrQ8uQ0ibonl/lWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89362037"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="89362037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 23:34:10 -0700
X-CSE-ConnectionGUID: kssbPaKZSyueWf7d7Zuw2g==
X-CSE-MsgGUID: qpve7ojiSjCIW9DCpFTlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="259295813"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 23 Jul 2026 23:34:06 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: dri-devel@lists.freedesktop.org,
	rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v2] drm/drv: Add buffer bounds check in drm_dev_wedged_event()
Date: Fri, 24 Jul 2026 12:00:06 +0530
Message-ID: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
content bytes (token + comma) and requires one additional byte
for the NUL terminator within 'size'.

Without a bounds check, if the remaining space is insufficient,
scnprintf() silently truncates the recovery token mid-name,
producing a malformed uevent payload (e.g. "WEDGED=bus-reset,vendor-spe").

Add a pre-flight drm_WARN_ON() guard:

  len + strlen(recovery) + 1 >= WEDGE_STR_LEN

Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v2:
- Add proper logic to handle recovery string. (Raag)
---
 drivers/gpu/drm/drm_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e51ed959da89..e48b22ca38bd 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -586,6 +586,20 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
 			break;
 
+		/*
+		 * scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
+		 * content bytes (token + comma) and reserves 1 byte for NUL within
+		 * 'size'.  It fits without truncation when:
+		 *   len + strlen(recovery) + 1 <= WEDGE_STR_LEN - 1  (safe)
+		 * so warn and bail when:
+		 *   len + strlen(recovery) + 1 >= WEDGE_STR_LEN       (would truncate)
+		 * Note: ">= WEDGE_STR_LEN - 1" would be off-by-one — it would
+		 * incorrectly reject the exact-fit case where NUL lands on the last
+		 * valid byte (index WEDGE_STR_LEN - 1).
+		 */
+		if (drm_WARN_ON(dev, len + strlen(recovery) + 1 >= WEDGE_STR_LEN))
+			break;
+
 		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
 	}
 
-- 
2.48.1

