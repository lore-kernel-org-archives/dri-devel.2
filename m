Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71496606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2HdL5X7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8299910E53E;
	Mon,  2 Nov 2026 04:32:40 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB2310E50D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 04:32:33 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36a17a332ecso4208299eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 20:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793593953; x=1794198753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=urssvPG3HxZMZLTOqJI/oNPuF6G5AsBo3NCrXStBrUE=;
 b=C2HdL5X7yCudx84PJQ/u4e+6fNWzzk1hEnDKkSFXSfOBwykYxYilUUX4Gl02HuR2Tb
 5Tr6M2sFPVLY7aCVTU8YRTNp8b/WFyZxJ9/OkzdVUor3+NbfAIc1tDRm+v8IPfmLRFsC
 wCiyJU94r9nZJNUVAe7JExQBZKd5fx7VecRz0DZTuMjjs7OgeQqMw4xIleDMYrm8Qa2v
 g7k8O9HFKfyNEon7qyFwuuey1i/osEwzZkMXQq8LA7sczGKg0f1BLRT2fs+38wDH27D8
 8InIYkKCc7/i2Obn53bUTnSmb3lJil20dygLmt+G+0w4WzaKHAoCPw0YnNvHkBo9c/Hz
 SIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793593953; x=1794198753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=urssvPG3HxZMZLTOqJI/oNPuF6G5AsBo3NCrXStBrUE=;
 b=XX40SqK9a2mK1AkXPc19q5S5KGzNMfAqsi2zmNrL7D9vGh5BndV+idvepDNNxmNdaG
 kqZcDX3UuREZpIMIPeDekICXXvDXzSYfRRvbo/uX2VMMpYRZKQokpsv5BDDebkUFk1Hx
 NqTTbLcxGpQuzhBlwIkHPI3JU03+Fja8dfRPCvN93Ma/i0/U7762IYUbVVrvgbs5nWWp
 iJkpZKmssPS4+xMrQTVznz1Y8V4Nql8wxGGYehTb10vi4trJPSgoO6l9cZ/MtzPvkiKY
 YXpnrNL8pEyH0PzhbQh+3x4si6Xb3HwEP52QQejd7a4ZVvgXmINnuM+2HpFxSC52AodH
 N1tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTIyrwRKQoLTPvKVkXOIRnvg865M6cgB/faF01dAxNRjKDSTzQHAZhG5BAChTJwvhX8X9dCOwOBXU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/mRbX7oGMIfw+QsnZdfHAuhHEYK20dCsUZ6laWmNYY951/HiUj
 RsTGM6yYzARAwRFSdmt/Ij/DhECRkbkxz6QU0CLzqfLkWV74ZNK2sf2Z
X-Gm-Gg: AYBFou3PJ3DK4Sftnb3PFuHTwmA2zdRYWOm+KUlKNpe+LSNOkga5nf12DuXLe3sNfJ4
 6KDk2Mkg5Pj1JIXIXs2xFSfIN22KI6uBVOxN/pWwp0v2Q3fI1LfJJ1GiXDzfz6EqzvDjmR0cOI4
 tMxoumxy3l1m36kWBB8WYWvtEA0ImJzn56SmM+c+h0rXao6m4cfPdLd0xUw1XbqmvV4DT8YD5nJ
 6P+AcFo4raR5CDl+1YecUn+7HsTt3z2ad/BZfJ26RcSB5dlLOR/lcisMJgEITZmjrBgmF15VszO
 5oefyQkSGOIygVd0MlYc2df4kizpXmscanPsRa+Kwejt+0zY4sDIqYwAp+GAi6nfLvKY5gUaWQW
 0dnBmmGTAva/+6RY/zLJPvLOEiG9+quVsfc/4EUAHJwLuaCIUOJdvrkIG+qeQEwoYRgkFEF0Vlt
 hTXnceSo6SoJYv7o5tNcKknH5vNY9cXVCnn21qyV3SdXM2a33ycjQ1tEIwJNNs8dcfk/ZjyTzEC
 NwgET4kDHaepg7zATwIHdX4lAN+axl7m47r9xOzwwNU0El80j8877pMjPRLKeBtUlacNIO4+FcD
 pr1flDgm8dN5C6NbyFHBToh0q3g7WM/s9+10b1F3onSUt0L1As02BnoBvMglPohonksdghwa7Ck
 /mnYtmZxI9AWznm64XCnO5J/GDMr8bRFqQ12UN2Y=
X-Received: by 2002:a05:7300:c00e:20b0:36a:2289:c599 with SMTP id
 5a478bee46e88-36a4243a674mr17385958eec.29.1793593952793; 
 Sun, 01 Nov 2026 20:32:32 -0800 (PST)
Received: from NB150512.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm38581063eec.26.2026.11.01.20.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:32:32 -0800 (PST)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH v2 3/5] drm/panel: feiyang-fy07024di26a30d: Use
 mipi_dsi_*_multi() functions
Date: Mon,  2 Nov 2026 12:32:13 +0800
Message-ID: <20261102043215.990351-4-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102043215.990351-1-hungen3108@gmail.com>
References: <20261102043215.990351-1-hungen3108@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the deprecated MIPI DSI DCS helpers with their _multi variants,
as suggested in Documentation/gpu/todo.rst.

Replace the initialization command table and loop with seven direct
mipi_dsi_dcs_write_seq_multi() calls. Preserve the original command
order and values, using lowercase hexadecimal literals.

In prepare(), the first failed DCS write prevents subsequent transfers
and its error is propagated through the cleanup path added by the
preceding patch. The helpers also log command failures.

In unprepare(), clear accum_err between commands so that ENTER_SLEEP_MODE
is still attempted if SET_DISPLAY_OFF fails, preserving the original
error handling behavior.

In disable(), ignore SET_DISPLAY_OFF errors to allow drm_panel_disable()
to clear panel->enabled, avoiding a stale enabled state after the panel
is powered off. This follows commit 00efe8a68565 ("drm/panel:
ronbo-rb070d30: Ignore DCS errors in disable()"). Command failures
remain logged by the helper.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    Changes in v2:
    - Replace the initialization command table with direct
      mipi_dsi_dcs_write_seq_multi() calls, as suggested by Doug.
    - Route initialization errors through the cleanup path added in 1/5.
    - Convert initialization command values to lowercase hex.
    - Drop the previous Reviewed-by tag due to the initialization rework.
    
    The seven initialization commands were checked against the original
    table; their order and values are unchanged.

 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 68 +++++++++----------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index bb4cc1ea2ece..fa304eb7453b 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -13,8 +13,6 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 
-#define FEIYANG_INIT_CMD_LEN	2
-
 struct feiyang {
 	struct drm_panel	panel;
 	struct mipi_dsi_device	*dsi;
@@ -29,25 +27,21 @@ static inline struct feiyang *panel_to_feiyang(struct drm_panel *panel)
 	return container_of(panel, struct feiyang, panel);
 }
 
-struct feiyang_init_cmd {
-	u8 data[FEIYANG_INIT_CMD_LEN];
-};
-
-static const struct feiyang_init_cmd feiyang_init_cmds[] = {
-	{ .data = { 0x80, 0x58 } },
-	{ .data = { 0x81, 0x47 } },
-	{ .data = { 0x82, 0xD4 } },
-	{ .data = { 0x83, 0x88 } },
-	{ .data = { 0x84, 0xA9 } },
-	{ .data = { 0x85, 0xC3 } },
-	{ .data = { 0x86, 0x82 } },
-};
+static void feiyang_init(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x58);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x47);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x82, 0xd4);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x83, 0x88);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x85, 0xc3);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x86, 0x82);
+}
 
 static int feiyang_prepare(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	unsigned int i;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 	int ret;
 
 	ret = regulator_enable(ctx->dvdd);
@@ -77,15 +71,10 @@ static int feiyang_prepare(struct drm_panel *panel)
 	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
 	msleep(200);
 
-	for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
-		const struct feiyang_init_cmd *cmd =
-						&feiyang_init_cmds[i];
-
-		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
-						FEIYANG_INIT_CMD_LEN);
-		if (ret < 0)
-			goto assert_reset;
-	}
+	feiyang_init(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
+	if (ret < 0)
+		goto assert_reset;
 
 	return 0;
 
@@ -104,32 +93,41 @@ static int feiyang_prepare(struct drm_panel *panel)
 static int feiyang_enable(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
 	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
 	msleep(200);
 
-	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
 }
 
 static int feiyang_disable(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	return mipi_dsi_dcs_set_display_off(ctx->dsi);
+	/*
+	 * Returning an error would leave panel->enabled set, causing the
+	 * next enable to be skipped even after unprepare powers off the panel.
+	 * The helper above already logs any command failure.
+	 */
+	return 0;
 }
 
 static int feiyang_unprepare(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	/* Attempt to enter sleep mode even if display off failed. */
+	dsi_ctx.accum_err = 0;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
 	msleep(200);
-- 
2.43.0

