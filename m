Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA0ECD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8FE10E9F5;
	Tue, 16 Jun 2026 10:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="RJzqlwxy";
	dkim-atps=neutral
X-Greylist: delayed 2690 seconds by postgrey-1.36 at gabe;
 Tue, 16 Jun 2026 10:57:16 UTC
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E95E10E9F5
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=gE3/WfDSa7HkVALCmB39wguI2Aftq82r483KT7wbl6s=; b=RJzqlwxywKWwMa
 GlJTQGMXkxBkqAJSXx/oG6TR9CpRjeAw4GZoI3Ryj9ZVk0xbg6hOymFZOB0NQxyd+vn/Yj0eRVMOq
 HOSfjWbOFb01pbGNus1JEKHzSbIy+UJBeClRtkWcwj4Jio2J/hfe3stQvXVaHiteDeiEyblTL3bVI
 XQG1Dqf+W12o8Am2k5fdOydJmTZGFZgt7sq1ACE5bbETlTug4LW4hECZ5Omq581Ut8syjNw7zczP6
 5UF7XGUYwnaSjpDXJZNqrS2RGNJnT+M9wbFbtMqyYBi9CLwga/HYO9r0c0NxivwmZbOhWwSxDuT+A
 POJg4pROr9Nw2FiJK2gA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1wZQm6-0079Le-SV; Tue, 16 Jun 2026 11:12:06 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
 (envelope-from <ben@rainbowdash>) id 1wZQm6-000000011ND-2RvK;
 Tue, 16 Jun 2026 11:12:06 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] drm/bridge: tc358767: fix NULL return in tc_edid_read
Date: Tue, 16 Jun 2026 11:12:05 +0100
Message-Id: <20260616101205.243597-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
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

The tc_edid_read() function should return a NULL insead of a
0, to fix the following warning:

drivers/gpu/drm/bridge/tc358767.c:1726:24: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4097fef4b86b..f5688e1c85c6 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1723,7 +1723,7 @@ static const struct drm_edid *tc_edid_read(struct drm_bridge *bridge,
 	ret = tc_get_display_props(tc);
 	if (ret < 0) {
 		dev_err(tc->dev, "failed to read display props: %d\n", ret);
-		return 0;
+		return NULL;
 	}
 
 	return drm_edid_read_ddc(connector, &tc->aux.ddc);
-- 
2.37.2.352.g3c44437643

