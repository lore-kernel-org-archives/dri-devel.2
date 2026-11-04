Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12874606D801
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA6E10EF97;
	Wed,  4 Nov 2026 08:58:05 +0000 (UTC)
X-Greylist: delayed 1786 seconds by postgrey-1.36 at gabe;
 Wed, 04 Nov 2026 03:05:02 UTC
Received: from sraa.de (sraa.de [85.214.240.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0588A10F988
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 03:05:02 +0000 (UTC)
Received: from [161.142.148.162] (helo=localhost.localdomain)
 by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <basti@sraa.de>)
 id 1xOQqJ-00Akzf-U7; Wed, 04 Nov 2026 03:35:16 +0100
From: Sebastian Raase <linux@sraa.de>
To: 
Cc: Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Sebastian Raase <linux@sraa.de>
Subject: [PATCH 1/2] fbdev: simplefb: Add mono framebuffer format
Date: Wed,  4 Nov 2026 10:34:49 +0800
Message-ID: <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793758480.git.linux@sraa.de>
References: <cover.1793758480.git.linux@sraa.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new simple-framebuffer format for monochrome 1 bit-per-pixel
framebuffers. Monochrome framebuffers are not true color, so their
visual is set to FB_VISUAL_MONO10 (set pixels are bright).

Signed-off-by: Sebastian Raase <linux@sraa.de>
---
 drivers/video/fbdev/simplefb.c         | 2 ++
 include/linux/platform_data/simplefb.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 60e5dcec201f..4662101885ec 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -583,6 +583,8 @@ static int simplefb_probe(struct platform_device *pdev)
 	info->fix.smem_start = mem->start;
 	info->fix.smem_len = resource_size(mem);
 	info->fix.line_length = params.stride;
+	if (params.format->bits_per_pixel == 1)
+		info->fix.visual = FB_VISUAL_MONO10;
 
 	info->var = simplefb_var;
 	info->var.xres = params.width;
diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platform_data/simplefb.h
index 4f94d52ac99f..9b6d822145c9 100644
--- a/include/linux/platform_data/simplefb.h
+++ b/include/linux/platform_data/simplefb.h
@@ -15,6 +15,7 @@
 /* format array, use it to initialize a "struct simplefb_format" array */
 #define SIMPLEFB_FORMATS \
 { \
+	{ "mono", 1, {0, 1}, {0, 1}, {0, 1}, {0, 0}, DRM_FORMAT_R1 }, \
 	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0}, DRM_FORMAT_RGB565 }, \
 	{ "r5g5b5a1", 16, {11, 5}, {6, 5}, {1, 5}, {0, 1}, DRM_FORMAT_RGBA5551 }, \
 	{ "x1r5g5b5", 16, {10, 5}, {5, 5}, {0, 5}, {0, 0}, DRM_FORMAT_XRGB1555 }, \
-- 
2.47.3

