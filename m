Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157DFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804E710EC1B;
	Tue, 28 Apr 2026 16:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AYjNJzkq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3170310EBC5
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777392138; x=1808928138;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4vxVHIIZ/PDoY3w74mri4vp9b0FaHMVU8XrOAVWh46Q=;
 b=AYjNJzkqQE0sbztW7uGX45ND3HHM/dAfMGLLy8pzMHWKAsWPeeWphaCd
 0fNXyjJ55n3zDc03rEdpBfg8E/tvnS6l/Uf9F9r8YrdQQwH85x6oseRnz
 8JSSPOni3Pd8ukjjM6ITgpog3JXAnVnZGMg37KCumqoJKAwti/agHXAk/
 96A7pg1QWAbbRp3gv83MBRCERy6Dsww2lBdIPyAPlySIbQyUaeRSgvxGX
 UrpzxEdFr6pxwPvww6GhISDE27p6aooYmY85c308w49O6biOBS6/gtl3C
 kr07juAGq1bbp8OmElVXMcdqtKd2DAshc8PwqPoO/UIgWGehsMi+f+SL8 w==;
X-CSE-ConnectionGUID: dW4PVsdYTJa4bCSCg4v/Kw==
X-CSE-MsgGUID: lT5fwlhLQeyD78BmvVJtgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95721496"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="95721496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:02:17 -0700
X-CSE-ConnectionGUID: L1Cy/JftRQu9VaQnwuF9iw==
X-CSE-MsgGUID: jJaF41UEQbiPr8/BtypxVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="235752357"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:02:13 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Simplify min_pixel_clock_rate calculation
Date: Wed, 29 Apr 2026 00:02:10 +0800
Message-ID: <20260428160210.2537326-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
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

In calculate_ovt_min_htotal, we compute min_pixel_clock_rate as
max_vrate * min_htotal * min_vtotal.  However, we already calculated the
value of max_vrate * min_vtotal as min_line_rate.  So, just use that as
part of the calculation.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 63814af7f1c1..9f9c9c65296f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5513,7 +5513,7 @@ static u32 calculate_ovt_min_htotal(const struct cta_rid *rid,
 
 	min_htotal = rid->hactive + max(OVT_MIN_HBLANK_444, *min_hblank);
 
-	min_pixel_clock_rate = max_vrate * min_htotal * min_vtotal;
+	min_pixel_clock_rate = min_line_rate * min_htotal;
 
 	htotal_granularity_chunk =
 		roundup_pow_of_two(DIV64_U64_ROUND_UP(min_pixel_clock_rate,
-- 
2.53.0

