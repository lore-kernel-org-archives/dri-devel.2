Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01059606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PORqWNSz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD85112C45;
	Fri,  6 Nov 2026 09:18:48 +0000 (UTC)
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com
 [111.22.67.151])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7FE3210EA1E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=PORqWNSz4Ay5034thcuwuJlqTACy4Fw0zvwgHPMyQfoNM73whaMEwRnZhElZgjv7Msj8lO19IiX9s
 EYxq9Vh+Xc2gTk7SCgQMRGYX+fC87pzHf3v3rR6N6bv0usEAeeHhJEZc9PhKY/l3+MwpQM9CQPPlci
 DqufPjjzgUX+BOaM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeafbfcd3d-69548;
 Wed, 04 Nov 2026 17:33:50 +0800 (CST)
X-RM-TRANSID: 2ee66aeafbfcd3d-69548
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from  (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeafbf81cb-1d56b;
 Wed, 04 Nov 2026 17:33:49 +0800 (CST)
X-RM-TRANSID: 2ee76aeafbf81cb-1d56b
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 2/3] drm/panel: otm8009a: disable supply on init_sequence
 failure
Date: Wed,  4 Nov 2026 17:33:43 +0800
Message-ID: <20261104093345.1674-3-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261104093345.1674-1-tangbin@cmss.chinamobile.com>
References: <20261104093345.1674-1-tangbin@cmss.chinamobile.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

otm8009a_prepare() enables ctx->supply then runs otm8009a_init_sequence();
on init failure it returns directly, leaking the supply (unprepare disables
it). Route through a disable_supply label.

Fixes: f0a5bb9803a9 ("drm/panel: Add support for OTM8009A panel driver")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 130520558..49cac3012 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -281,11 +281,15 @@ static int otm8009a_prepare(struct drm_panel *panel)
 
 	ret = otm8009a_init_sequence(ctx);
 	if (ret)
-		return ret;
+		goto disable_supply;
 
 	ctx->prepared = true;
 
 	return 0;
+
+disable_supply:
+	regulator_disable(ctx->supply);
+	return ret;
 }
 
 static int otm8009a_enable(struct drm_panel *panel)
-- 
2.52.0.windows.1



