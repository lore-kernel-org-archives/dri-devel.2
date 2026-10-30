Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D81606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nFDu680s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E0C10E3D7;
	Sun,  1 Nov 2026 11:58:12 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [111.22.67.135])
 by gabe.freedesktop.org (Postfix) with ESMTP id D97CC10E89A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=nFDu680sWTPFHy4B3sLoILYc4GXFPEXQOnUHzZRCF31jhj38JpRrS62LE1t4+irWTmosP1frNFZYt
 k6RlXiZRanJlMCR/fcbNXWwTLu6KCJCwSTGM/J856hWHtGRAsnB9zKMo3jWrKmDcjySb+ISAKg2q3F
 KyIUzc06klWeWWIs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ae47bb817f-76269;
 Fri, 30 Oct 2026 19:13:07 +0800 (CST)
X-RM-TRANSID: 2ee76ae47bb817f-76269
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
 by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ae47bc0125-5c588;
 Fri, 30 Oct 2026 19:13:07 +0800 (CST)
X-RM-TRANSID: 2ee96ae47bc0125-5c588
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lucas Stach <l.stach@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v2] drm/imx/dcss: Fix clock leak on blkctl init failure
Date: Fri, 30 Oct 2026 19:13:03 +0800
Message-ID: <20261030111304.2205-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261030083342.1531-1-laixiangwu@cmss.chinamobile.com>
References: <20261030083342.1531-1-laixiangwu@cmss.chinamobile.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

dcss_submodules_init() enables the DCSS clocks before initializing the
submodules, but if the first submodule (blkctl) fails to initialize the
function returns directly, without disabling the clocks again. All the
later error paths already jump to err_clocks, which calls
dcss_clocks_disable().

Since the clocks are only devm-managed for their reference (devm_clk_get),
a blkctl init failure leaves all five DCSS clocks prepared and enabled.

Jump to err_clocks so the clocks are disabled like on the other error
paths.

Also rename the error labels of dcss_submodules_init() to the more
common err_<x> style, which describes what is cleaned up from each
label on, and update the gotos accordingly.

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Suggested-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

---
V1 -> V2: Also rename the error labels of dcss_submodules_init() and
update the gotos accordingly, as suggested in review.
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 7fd0c4c14..206679d52 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -70,45 +70,45 @@ static int dcss_submodules_init(struct dcss_dev *dcss)
 
 	ret = dcss_blkctl_init(dcss, base_addr + devtype->blkctl_ofs);
 	if (ret)
-		return ret;
+		goto err_clocks;
 
 	ret = dcss_ctxld_init(dcss, base_addr + devtype->ctxld_ofs);
 	if (ret)
-		goto ctxld_err;
+		goto err_clocks;
 
 	ret = dcss_dtg_init(dcss, base_addr + devtype->dtg_ofs);
 	if (ret)
-		goto dtg_err;
+		goto err_ctxld;
 
 	ret = dcss_ss_init(dcss, base_addr + devtype->ss_ofs);
 	if (ret)
-		goto ss_err;
+		goto err_dtg;
 
 	ret = dcss_dpr_init(dcss, base_addr + devtype->dpr_ofs);
 	if (ret)
-		goto dpr_err;
+		goto err_ss;
 
 	ret = dcss_scaler_init(dcss, base_addr + devtype->scaler_ofs);
 	if (ret)
-		goto scaler_err;
+		goto err_dpr;
 
 	dcss_clocks_disable(dcss);
 
 	return 0;
 
-scaler_err:
+err_dpr:
 	dcss_dpr_exit(dcss->dpr);
 
-dpr_err:
+err_ss:
 	dcss_ss_exit(dcss->ss);
 
-ss_err:
+err_dtg:
 	dcss_dtg_exit(dcss->dtg);
 
-dtg_err:
+err_ctxld:
 	dcss_ctxld_exit(dcss->ctxld);
 
-ctxld_err:
+err_clocks:
 	dcss_clocks_disable(dcss);
 
 	return ret;



