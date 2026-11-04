Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9B606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xl30SfSI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F32112C56;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4CEA810E874
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=xl30SfSIXYTLSHqureyeLrvsSIeGRXXsKFGsyKzVtlKRFJ+SxRgEfwZm5NedaqTlTJuXJbTvYnJ4M
 K7vfPeS6dINBzZa8XQ0Ie7xEpTNkISNw80WU8x14CcvPSRRqWz9J0g7qmIUAhvR5shSDKpLaEYSUJ+
 XIjRHbgxgLtaLDxE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aeaf1dfc75-77d45;
 Wed, 04 Nov 2026 16:50:40 +0800 (CST)
X-RM-TRANSID: 2ee16aeaf1dfc75-77d45
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from  (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeaf1dc8a0-1bc0e;
 Wed, 04 Nov 2026 16:50:39 +0800 (CST)
X-RM-TRANSID: 2ee76aeaf1dc8a0-1bc0e
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 2/2] drm/panel: ilitek-ili9882t: disable pp3300 on prepare()
 error paths
Date: Wed,  4 Nov 2026 16:50:35 +0800
Message-ID: <20261104085036.1441-3-tangbin@cmss.chinamobile.com>
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

ili9882t_prepare() enables pp3300 first, but every later failing step
disables only pp1800/avdd/avee, never pp3300 (the matching unprepare()
does). The pp3300 enable count leaks across repeated prepare failures. Add
a poweroff3v3 label and route the pp1800-enable failure to it.

Fixes: e2450d32e5fb ("drm/panel: ili9882t: Break out as separate driver")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 6d07fe901..a80469bb1 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -618,7 +618,7 @@ static int ili9882t_prepare(struct drm_panel *panel)
 
 	ret = regulator_enable(ili->pp1800);
 	if (ret < 0)
-		return ret;
+		goto poweroff3v3;
 
 	usleep_range(3000, 5000);
 
@@ -660,6 +660,8 @@ static int ili9882t_prepare(struct drm_panel *panel)
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(ili->pp1800);
+poweroff3v3:
+	regulator_disable(ili->pp3300);
 
 	return ret;
 }
-- 
2.52.0.windows.1



