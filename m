Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9D606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OlEOxDqt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CB8112C33;
	Fri,  6 Nov 2026 09:18:43 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id B2BED10E85F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=OlEOxDqtboHCjt/7u8sRo5FA6hmsAkm2KF0c4wuQ1HUYxqVIri9gooH3ok9ua271h8eHT35BvNE6m
 JftT199fQaaKec8tnFoIaCPqhqixWQfIjq5iRTzgsMGo1qUKrXoHxg8PUuCK790+yfsljThThTnABI
 QtiMxurzdJGqR5zY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aeafbfe1d1-a2146;
 Wed, 04 Nov 2026 17:33:50 +0800 (CST)
X-RM-TRANSID: 2ee96aeafbfe1d1-a2146
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from  (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeafbf81cb-1d570;
 Wed, 04 Nov 2026 17:33:50 +0800 (CST)
X-RM-TRANSID: 2ee76aeafbf81cb-1d570
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
Subject: [PATCH 3/3] drm/bridge: anx6345: disable dvdd12 on dvdd25 enable
 failure
Date: Wed,  4 Nov 2026 17:33:44 +0800
Message-ID: <20261104093345.1674-4-tangbin@cmss.chinamobile.com>
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

anx6345_power_on() enables dvdd12 then dvdd25; on dvdd25 failure it returns
directly (void function), leaking dvdd12 (poweroff disables both). Disable
dvdd12 before returning.

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 407834a03..f84427eae 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -294,6 +294,7 @@ static void anx6345_poweron(struct anx6345 *anx6345)
 	if (err) {
 		DRM_ERROR("Failed to enable dvdd25 regulator: %d\n",
 			  err);
+		regulator_disable(anx6345->dvdd12);
 		return;
 	}
 
-- 
2.52.0.windows.1



