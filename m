Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A71ECD37A7
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF2B10F4FD;
	Fri,  8 May 2026 14:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k0GNSU10";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903E610E2C1
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 05FAA43A7F;
 Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74A8C2BCC7;
 Fri,  8 May 2026 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778251588;
 bh=SZt0Xpr/BjtnhzyexlgcWrKbKSkAxPxwD2uZDoo72MY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k0GNSU10PO8A209GclcjlNAHYHh0tUfHgCGxuABMbWj4U5pRW+B93DXIviHw3pfnL
 0cJ3TMgLiH+5OeehtfRQEannYtIIBNfjL1DkwRjagqakOqeIISIVeBgkDcxC4EhJOk
 a2D2YSqQMGH6/JqzOwPE6lIt8awL0EVkgCtyxNvRrf586y/0WGMBLrDALo8Womgt8A
 3tT+3T6Don5XouiUKODpu4HvyGfa5kB2JUa8RkZBWudnpizkuVyV2h3RcJU06a3cc1
 LgsrhQWHue+MSSWI6kg7ISMd4Xt89LkeF6rF3KdgXgyUg6x2VaoyrfHNbD2Nd+Oqlb
 oJJFYO0MDy79Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
 (envelope-from <johan@kernel.org>) id 1wLMTC-00000000FZ3-2fyi;
 Fri, 08 May 2026 16:46:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH 1/3] drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
Date: Fri,  8 May 2026 16:44:44 +0200
Message-ID: <20260508144446.59722-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508144446.59722-1-johan@kernel.org>
References: <20260508144446.59722-1-johan@kernel.org>
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

Make sure to drop the reference taken to the I2C adapter (and its
module) when setting up HDMI to allow the adapter to be deregistered.

Fixes: 1b082ccf5901 ("gma500: Add Oaktrail support")
Cc: stable@vger.kernel.org	# 3.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 58d7e191fd56..403d21cbb3a2 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -580,6 +580,7 @@ static int oaktrail_hdmi_get_modes(struct drm_connector *connector)
 	} else {
 		edid = (struct edid *)raw_edid;
 		/* FIXME ? edid = drm_get_edid(connector, i2c_adap); */
+		i2c_put_adapter(i2c_adap);
 	}
 
 	if (edid) {
-- 
2.53.0

