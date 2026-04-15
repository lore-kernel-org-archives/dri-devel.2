Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31465F433D0
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE8210E7F0;
	Wed, 15 Apr 2026 23:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iux0nXrZ";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8698B10E7F0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:56:53 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35da8d037a5so3459999a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776297413; x=1776902213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xp8GECdo6fkmF6RF7s24GmXpqHFvjp00U23IEvlZ/4w=;
 b=Iux0nXrZAqvU4jird5Qd5bjxI8fsd5wdchtjMDNMN/2HT6oycgB7/1LvvOFKvUfl6M
 ZHtbAnQNEAklowOHq6NliOYQs43R5lxEcIa8cr60/ryIpCX0fZ/mPztrzw2VWRfrPFTQ
 ES8YrwZibYpDEmzDJ+9Zn7mRAwBW0tVb6KX43vALXIcqnKCXqKWlcFHxg2/Y0+u1s4Pr
 R9MpJfs65Jhe34g4Fz9MbfGgyKf1y99JEP6srFJ5e1v//CjRNnB7qjuhLndY6VKNBizs
 2iNFMxOBfaHzwV803GYIANfkFzb2G0vyJn92FhPZs9Z0jbEGasiwBZOzIso/x1EfcGsd
 u61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776297413; x=1776902213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp8GECdo6fkmF6RF7s24GmXpqHFvjp00U23IEvlZ/4w=;
 b=HumabN7uHezLVPhcS70CoUWVOl54y2aMc0mlOlnUnAf93f2o25AT2aNkBQG7qs+K0L
 LaOiaYJ51jnFI257eX1/lfGKAV9gflLcOoqSBAqhIvTWaxFv7tzw1bjA+Vm271lj/8Ad
 5Wvd/I33OF+Juy/wgiWUcwPrdWKulCBTs8An7fqU8asH7imCDCmT5DPrArrnVs0vCluA
 KAf5WKeYBPBOsbHe34Zq47+4fXIgMJgIWNfDhRiplyyM99hRrNq423BiDmA6zIu6ZRmd
 Pzh0iYd/+/+1PfV7wjmYHMZssgPQWNeBLwJWhJZnFIe9eF7SOVxN8yYjc9FCPDH61Fst
 7K2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FN4zO3b58lavfioM1A4+0ydU7rhEX4lwBVBurDqCswZOEj0NCiklzraAh24GFE7wb998wIlm8Oos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg7LqXwttmz//nql3jlEPjtAeSVo4p44uXQ0UZj4jfxPWzR44T
 wNiPxe5vuNS/Y2vwxnMQVB+70lI61IAwZ+iTUBzD4QX5WoYhrFGlAda2
X-Gm-Gg: AeBDiev3FqTZdff+feSGuPXb46Vuoqmht4t3Qi9uDTgiNtJpZYylA50yKE1mSfT2oko
 gwPSe2hRUebSz3i/iOe12KYDcpsloO6aeZjUcnGb6d0LF9aQwYdoppXxc8zf1TAvg/IYVwVYhX3
 +e3vaaiYIrODhOCe9Iz9yts3n0a+ugLsBpCKFSDllWkpvp925dLmpc4lC4CENl+NwJC21sBOCFO
 k2HaEcO96EVMa9QBgitVoF1RlgKFAflgqAHiSX7rJdJLnFCt8bA1mHa/RhP2TflfGwXzFmc1ioL
 wYrk3n56vYRNvPfJYe+5o2m2VDFbaw5VsyPOtb0Uaoe28WB0Q/sIXoJYPgme9dtQG9AgfROBkHd
 NYwaAKe+iD5kOLZxwlnSMex48a5rp3qI9VR0ARUCUeg7VOB8sMH047aHdT95+8BEPH+bajBy6DI
 iOj4Isa2hbd9mfOX6SQ8hZHkiDXmpiVpwOmbc+0sG9C4eXIJG89pekld7Ihcu1YwtzKkGHLo91D
 aQg5TKBItFcexSEQrzgfkjrKozLy8PVCKr2kHx9XteA742hDmlGbm/zPdws
X-Received: by 2002:a17:90b:3bcc:b0:35f:b64f:bf99 with SMTP id
 98e67ed59e1d1-35fb64fc0eemr13681551a91.29.1776297412829; 
 Wed, 15 Apr 2026 16:56:52 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net
 ([2601:1c0:5780:9200:39c1:ccbd:b65d:ad33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79581c3f7fsm2994678a12.26.2026.04.15.16.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:56:52 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: sumit.semwal@linaro.org,
	neil.armstrong@linaro.org
Cc: dianders@chromium.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH] drm/panel: novatek-nt36672a: Inline command sequences
Date: Wed, 15 Apr 2026 16:56:08 -0700
Message-ID: <20260415235608.8138-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Inline the command sequences and remove the nt36672a_send_cmds()
helper.

Small wrapper helpers around mipi_dsi_dcs_write_buffer_multi()
are discouraged as they add indirection without improving
readability and can increase code size.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 7e8b5e059575..2f75200806dd 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -79,19 +79,6 @@ static inline struct nt36672a_panel *to_nt36672a_panel(struct drm_panel *panel)
 	return container_of(panel, struct nt36672a_panel, base);
 }
 
-static void nt36672a_send_cmds(struct mipi_dsi_multi_context *dsi_ctx,
-			       const struct nt36672a_panel_cmd *cmds, int num)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++) {
-		const struct nt36672a_panel_cmd *cmd = &cmds[i];
-
-		/* cmd->data[0] is the DCS command, cmd->data[1] is the parameter */
-		mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd->data, sizeof(cmd->data));
-	}
-}
-
 static void nt36672a_panel_power_off(struct drm_panel *panel)
 {
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
@@ -108,10 +95,14 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 {
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->link };
+	unsigned int i;
 
 	/* send off cmds */
-	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->off_cmds,
-			   pinfo->desc->num_off_cmds);
+	for (i = 0; i < pinfo->desc->num_off_cmds; i++) {
+		const struct nt36672a_panel_cmd *cmd = &pinfo->desc->off_cmds[i];
+
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, (const u8 *)cmd->data, sizeof(cmd->data));
+	}
 
 	/* Reset error to continue with display off even if send_cmds failed */
 	dsi_ctx.accum_err = 0;
@@ -158,12 +149,16 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 {
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->link };
+	unsigned int i;
 
 	dsi_ctx.accum_err = nt36672a_panel_power_on(pinfo);
 
 	/* send first part of init cmds */
-	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_1,
-			   pinfo->desc->num_on_cmds_1);
+	for (i = 0; i < pinfo->desc->num_on_cmds_1; i++) {
+		const struct nt36672a_panel_cmd *cmd = &pinfo->desc->on_cmds_1[i];
+
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, (const u8 *)cmd->data, sizeof(cmd->data));
+	}
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
@@ -173,8 +168,11 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
 	/* Send rest of the init cmds */
-	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_2,
-			   pinfo->desc->num_on_cmds_2);
+	for (i = 0; i < pinfo->desc->num_on_cmds_2; i++) {
+		const struct nt36672a_panel_cmd *cmd = &pinfo->desc->on_cmds_2[i];
+
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, (const u8 *)cmd->data, sizeof(cmd->data));
+	}
 
 	mipi_dsi_msleep(&dsi_ctx, 120);
 
-- 
2.43.0

