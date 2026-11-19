Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A8606A338
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Sjcw85jh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117DA112672;
	Thu, 19 Nov 2026 17:08:59 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44247112679
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:08:52 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ee04c49451so32412855ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108132; x=1795712932;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=leZoYmjJmyNxHBhQX+s+ycI0JfAwE3smojnVnGGLUJM=;
 b=Sjcw85jh8OPsY8bwaXbSXPnJQ+dN1SDIeJMptTKp0I3ZwVXJDA7neJwNfxiN4qKyF4
 FXueryfwbt18s9tbXUJII2ObgcgpNJAZBevvNVj16NljPngPrkwaeuFmiPg0nvKATPdj
 0z3UOtB62pzm1181e3tn+Ys4Xw6f6MQJraELqv4Ad2N2uHIdkCObqLPDMfm6FwK7nTMC
 7ti9+PdkbHvXTA0FYJ3hOO5MFH8GQ9rbq7CexrQp4F9Tsx3PSastpwVO92wlsuZbxk7H
 +a2/QLkiT3aQse0CZNQsMaM5vgFreCUVPF/ePyNGL/2j7ok9nnAmbS3/D3zBkp7g36xD
 bVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108132; x=1795712932;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=leZoYmjJmyNxHBhQX+s+ycI0JfAwE3smojnVnGGLUJM=;
 b=wiiC+6MNGlw8O9FhOO973IyscmPyws+QheYe930t/Js/X6nM4cO+m56j1Stc0evGv7
 4aXvceQxwWuT09xF45Sp81IX+BHbXWdpv1pneSr/GXkJZ5On1SPBJ+5P0+BcvF1sIjx7
 QEwUUoQ0TOuoYl1J29zGMBENRlhMUgYESM5KjM0isuk0JYGUbEAYKrHf1Y+Wvd/Vr7fK
 4iLSvQvBhqBR2FygH2VTLx6R2UEoeAgesOXx/fg0OeR62nDD44eP7RzIHZZp6A2rzD6W
 piy+PXq1wquO8RO4kPbIEwP+MEX8phGANiKrhtDsXtNMz7u/TFsEBHXxO2Oy6vk/5qw4
 milA==
X-Forwarded-Encrypted: i=1;
 AL+hErE3GdV2WEk1TgECbtTx3FQBKjCGL/fbdyOIoDzwermvBO1g8Zpraj9mup25zEotFS/y6IxclyElodA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wdg6iFl3u1jFwG5W2urLQKWwIVsVxNeswOd5M4fjInDseOxwv
 fe9lzdi2n/eGELdqvWxdEbVOXohN/2Z0zLv25n2vBfEnKXA3+ovwD36uUJa9Ue7GtxfpPlCvtSZ
 nMjs5Gpu7RA==
X-Received: from plri11.prod.google.com ([2002:a17:903:32cb:b0:2ed:a98:181b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e807:b0:2ee:1fab:158f
 with SMTP id d9443c01a7336-2f03f167d4emr5365765ad.43.1795108131385; Thu, 19
 Nov 2026 09:08:51 -0800 (PST)
Date: Thu, 19 Nov 2026 09:08:18 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170818.1528087-1-irogers@google.com>
Subject: [PATCH] drm/panel: dsi-cm: Normalize mipi_dsi_dcs_read/write() return
 values
From: Ian Rogers <irogers@google.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When commit d4cf15372868 ("drm/omap: panel-dsi-cm: use DSI helpers")
converted dsicm_dcs_read_1() and dsicm_dcs_write_1() to
mipi_dsi_dcs_read() and mipi_dsi_dcs_write(), all callers in panel-dsi-cm
continued to check 'if (r)' expecting 0 on success and a negative errno on
failure. While OMAP's dsi_vc_dcs_read() populates the buffer and returns 0
on a successful read, mipi_dsi_dcs_read() on standard MIPI DSI hosts and
mipi_dsi_dcs_write() return the positive byte count transferred on
success:

1. A 1-byte DCS read returning 1 causes dsicm_get_id(),
   num_dsi_errors_show(), and hw_revision_show() to treat success as a
   non-zero return value (exposing 1 byte of uninitialized sysfs buffer).
2. If a DSI host returns 0 without writing the output byte,
   dsicm_power_on() and hw_revision_show() read uninitialized stack bytes
   (id1, id2, id3).
3. A successful 2-byte DCS write returns 2, causing dsicm_power_on() to
   abort at 'if (r) goto err;'.

Normalize both dsicm_dcs_read_1() and dsicm_dcs_write_1() to propagate
negative error codes and return 0 on non-negative return values (handling
both OMAP DSI returning 0 and standard DSI hosts returning byte counts),
zero-initialize *data in dsicm_dcs_read_1(), and zero-initialize id1,
id2, and id3 in hw_revision_show().

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Verified with a C unit test and build-tested under
LLVM=1 W=1 (-Werror) and -Wconditional-uninitialized; not tested on DSI
command-mode panel hardware.

Fixes: d4cf15372868 ("drm/omap: panel-dsi-cm: use DSI helpers")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/panel/panel-dsi-cm.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index ae6e9ffc46cb..1b40fe4f08d8 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -109,12 +109,25 @@ static void hw_guard_wait(struct panel_drv_data *ddata)
 
 static int dsicm_dcs_read_1(struct panel_drv_data *ddata, u8 dcs_cmd, u8 *data)
 {
-	return mipi_dsi_dcs_read(ddata->dsi, dcs_cmd, data, 1);
+	ssize_t ret;
+
+	*data = 0;
+	ret = mipi_dsi_dcs_read(ddata->dsi, dcs_cmd, data, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int dsicm_dcs_write_1(struct panel_drv_data *ddata, u8 dcs_cmd, u8 param)
 {
-	return mipi_dsi_dcs_write(ddata->dsi, dcs_cmd, &param, 1);
+	ssize_t ret;
+
+	ret = mipi_dsi_dcs_write(ddata->dsi, dcs_cmd, &param, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int dsicm_sleep_in(struct panel_drv_data *ddata)
@@ -238,7 +251,7 @@ static ssize_t hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
-	u8 id1, id2, id3;
+	u8 id1 = 0, id2 = 0, id3 = 0;
 	int r = -ENODEV;
 
 	mutex_lock(&ddata->lock);
-- 
2.56.1.708.g77570a6a1d-goog

