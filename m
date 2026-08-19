Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F95DC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E931C10E103;
	Wed, 19 Aug 2026 07:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IkzmdIEl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7F110E103
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787124519; x=1818660519;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bjxkUigIQF/FLCtfFhnV9suBNyW3HXulGmclH/su+eg=;
 b=IkzmdIEloAAXEUF07ftncPKx90VI++IU6Y8bYBnWKt4YTH6nZyPTr86a
 QyvMKStqsCx3ON6YtRJ84ch19EVWe7I1b8+vX4mu708Mj/PgOfZIkK+f6
 Kl7uyD2e+KHwoOl0oH1UI1REhCrFBiG7yGGFYJEgADrLn6WkUsqbSlnMv
 8Pau5YI3vb2D8D1ymzDUbA4ZRctxeB3Ad+GpYMb91YEcwzcZQ3LavFQDW
 FzvrU/IU63V0RYrYMwneerkilbQuZx6gMWS6Yl6ZpJvGAvey15pMhvJ6g
 wUxDccvxHD59AJvQQ4BwZv8igqpFozKsi3XPMNcyhJlFIk34aiatIEEYP Q==;
X-CSE-ConnectionGUID: BdqZ1z/XQy2j/4od02YrZw==
X-CSE-MsgGUID: 4Ab2BPlLRTSmtztjP8U6aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91439177"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="91439177"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 00:28:39 -0700
X-CSE-ConnectionGUID: FrrgiAu2Ri62gIJolx8YbQ==
X-CSE-MsgGUID: rJVwAm93To6OeUUeu/n7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="263729170"
Received: from tester.sh.intel.com ([10.112.106.126])
 by orviesa006.jf.intel.com with ESMTP; 19 Aug 2026 00:28:37 -0700
From: Tao Yu <tao1.yu@intel.com>
To: Ruben Wauters <rubenru09@aol.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tao Yu <tao1.yu@intel.com>,
 syzbot+9ae8e7884e451eaed5b4@syzkaller.appspotmail.com
Subject: [PATCH] drm/gud: validate TV mode names before creating enum property
Date: Wed, 19 Aug 2026 15:28:35 +0800
Message-Id: <20260819072835.4074130-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
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

The GUD protocol returns TV mode names as fixed-size
GUD_CONNECTOR_TV_MODE_NAME_LEN entries and requires each name to be
NUL-terminated.

gud_connector_add_tv_mode() currently passes each fixed-size entry
directly to drm_mode_create_tv_properties_legacy(), which eventually
reaches drm_property_add_enum() and strlen(). If a device returns an
entry without a terminating NUL byte, strlen() reads past the end of
the slot and can run beyond the allocated buffer, triggering an
out-of-bounds read.

Validate that each returned TV mode name contains a NUL terminator
within its fixed-size slot before passing it to the DRM property code.
If a malformed entry is found, reject the device response with -EIO.

This fixes the out-of-bounds read without changing the handling of
valid devices, and avoids silently truncating malformed protocol data.

Reported-by: syzbot+9ae8e7884e451eaed5b4@syzkaller.appspotmail.com
Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 drivers/gpu/drm/gud/gud_connector.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index ea0cca58b7c89..8141c3a1e30ad 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -396,8 +396,16 @@ static int gud_connector_add_tv_mode(struct gud_device *gdrm, struct drm_connect
 	}
 
 	num_modes = ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
-	for (i = 0; i < num_modes; i++)
-		modes[i] = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
+	for (i = 0; i < num_modes; i++) {
+		char *mode = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
+
+		if (!memchr(mode, '\0', GUD_CONNECTOR_TV_MODE_NAME_LEN)) {
+			ret = -EIO;
+			goto free;
+		}
+
+		modes[i] = mode;
+	}
 
 	ret = drm_mode_create_tv_properties_legacy(connector->dev, num_modes, modes);
 free:
-- 
2.34.1

