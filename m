Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC1606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=GjHSPvXV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566AF112C44;
	Fri,  6 Nov 2026 09:18:48 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4CDED10E86E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=GjHSPvXVK7A94In5L/yZ6RVi2DQcwmrYMSAYiF7Ohj5pF54vxt9gH5VHr46X8sOhqTVpXrhTYBJ0x
 kj6j4sRO7ZPgJvIpsFXLyfpM//UtKC9V5ou6DftJjRJeSoaJU322Dyw6eg0HPbC9D/Ahpk+jINHUVK
 cZfGn3X5b/26Z1v0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aeaf1dfc73-77d43;
 Wed, 04 Nov 2026 16:50:39 +0800 (CST)
X-RM-TRANSID: 2ee16aeaf1dfc73-77d43
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from  (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeaf1dc8a0-1bc0c;
 Wed, 04 Nov 2026 16:50:39 +0800 (CST)
X-RM-TRANSID: 2ee76aeaf1dc8a0-1bc0c
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 1/2] drm/panel: boe-tv101wum-nl6: disable pp3300 on prepare()
 error paths
Date: Wed,  4 Nov 2026 16:50:34 +0800
Message-ID: <20261104085036.1441-2-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261104085036.1441-1-tangbin@cmss.chinamobile.com>
References: <20261104085036.1441-1-tangbin@cmss.chinamobile.com>
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

boe_panel_prepare() enables pp3300 first, but every later failing step
(pp1800/avdd/avee enable, NOP, init) returns or jumps to a cleanup chain
that disables pp1800/avdd/avee but never pp3300, even though the matching
unprepare() disables it. The regulator is reference-counted, so on repeated
prepare failure the pp3300 enable count accumulates (leak). Add a
poweroff3v3 label that disables pp3300 and route the pp1800-enable failure
to it; the existing labels fall through.

Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 150dff3ab..25cfd6e30 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1371,7 +1371,7 @@ static int boe_panel_prepare(struct drm_panel *panel)
 
 	ret = regulator_enable(boe->pp1800);
 	if (ret < 0)
-		return ret;
+		goto poweroff3v3;
 
 	usleep_range(3000, 5000);
 
@@ -1413,6 +1413,8 @@ static int boe_panel_prepare(struct drm_panel *panel)
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(boe->pp1800);
+poweroff3v3:
+	regulator_disable(boe->pp3300);
 
 	return ret;
 }
-- 
2.52.0.windows.1



