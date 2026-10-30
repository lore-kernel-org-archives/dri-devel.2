Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD191606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ohBY4CfC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCAE1126A7;
	Fri, 30 Oct 2026 09:13:16 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [111.22.67.135])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9500E11268D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=ohBY4CfCdfNMfNxcKYYNAhE9WjRmH3Bef0DiveadKDnmWi98cA9TBe7jAqwidcmZDuKgqSD/jS3Jm
 1axd+tfu8i/PSA5syweKrxUgTtQUlb0k2W100V6CkGCC0/i8hrhotmqReDWUoe4gszgeAuWc4xJG7F
 WgULhl1gFEQRAGsE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ae4552aeac-73f7d;
 Fri, 30 Oct 2026 16:28:26 +0800 (CST)
X-RM-TRANSID: 2ee76ae4552aeac-73f7d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ae45529408-0243f;
 Fri, 30 Oct 2026 16:28:26 +0800 (CST)
X-RM-TRANSID: 2eea6ae45529408-0243f
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] drm/bridge: analogix_dp: Fix runtime PM refcount leak in
 set_bridge()
Date: Fri, 30 Oct 2026 16:28:20 +0800
Message-ID: <20261030082820.1457-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
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

analogix_dp_set_bridge() calls pm_runtime_get_sync() to power up the
DP core, but if the subsequent analogix_dp_init_analog_func() fails it
returns the error directly, without the matching pm_runtime_put_sync().
The two other error paths in the function already jump to the
out_dp_init label, which drops the reference.

Every failed bridge enable therefore increments the runtime PM usage
counter, and repeated failures (e.g. during hotplug storms) prevent
the device from ever runtime suspending again.

Jump to out_dp_init like the other error paths so the runtime PM
reference is released.

Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller init into runtime PM")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df696374..c9c1375a9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -998,7 +998,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 
 	ret = analogix_dp_init_analog_func(dp);
 	if (ret)
-		return ret;
+		goto out_dp_init;
 
 	/*
 	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,


