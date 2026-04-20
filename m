Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD56F36C5C
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEEF10E565;
	Mon, 20 Apr 2026 12:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="BTtkW0rv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XuBD0YP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BTtkW0rv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XuBD0YP";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBD110E565
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:11:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF91A6A88D;
 Mon, 20 Apr 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776687095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzwUh6pCznz5HqTIRSCRcJRYLupiDoXr7K0IPk3O1iI=;
 b=BTtkW0rvE2i6mXSymo3LxVy9xqzTi/Xt0JiEpblSPVZ9LTZQ9+OPtGYIH798Id3PDDHplB
 TUcEdxm8kzspzWBmHnoDCCvhxSHo//Q99TtkBcc4I+p+xC1YCiPD+BJf30EV/xxdBznzr5
 3f1ey/3kqlC/HNgUl6r6vWFjZcMtuXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776687095;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzwUh6pCznz5HqTIRSCRcJRYLupiDoXr7K0IPk3O1iI=;
 b=1XuBD0YP/yCcK8kfqGQT7OlUpfbTwxFo+gFz8m6z5wpjabMpti49rijGhr+w+2eroRFM8r
 wWaIhsjB9qQJKYAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776687095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzwUh6pCznz5HqTIRSCRcJRYLupiDoXr7K0IPk3O1iI=;
 b=BTtkW0rvE2i6mXSymo3LxVy9xqzTi/Xt0JiEpblSPVZ9LTZQ9+OPtGYIH798Id3PDDHplB
 TUcEdxm8kzspzWBmHnoDCCvhxSHo//Q99TtkBcc4I+p+xC1YCiPD+BJf30EV/xxdBznzr5
 3f1ey/3kqlC/HNgUl6r6vWFjZcMtuXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776687095;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzwUh6pCznz5HqTIRSCRcJRYLupiDoXr7K0IPk3O1iI=;
 b=1XuBD0YP/yCcK8kfqGQT7OlUpfbTwxFo+gFz8m6z5wpjabMpti49rijGhr+w+2eroRFM8r
 wWaIhsjB9qQJKYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57EA8593B0;
 Mon, 20 Apr 2026 12:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6AkEFPcX5mkGZQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 12:11:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, sumit.semwal@linaro.org,
 yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/4] drm/hibmc: Do not use cpp from struct drm_format_info
Date: Mon, 20 Apr 2026 14:09:59 +0200
Message-ID: <20260420121130.200133-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420121130.200133-1-tzimmermann@suse.de>
References: <20260420121130.200133-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Replace uses of struct drm_format_info's cpp with appropriate interfaces.
The cpp field contains the characters per pixel. It is deprecated and
should be avoided.

Calculate the line width in bytes with drm_format_info_min_pitch(). This
is the preferred way of getting pixel and line sizes.

Program HIB_CRT_DISP_CTL_FORMAT from the format's 4CC code instead of
calculating the field's value from the cpp.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index c4f9ebd9250d..20ab933b0f12 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -83,8 +83,8 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
 static void hibmc_plane_atomic_update(struct drm_plane *plane,
 				      struct drm_atomic_state *state)
 {
-	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
-									   plane);
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_framebuffer *fb = new_state->fb;
 	u32 reg;
 	s64 gpu_addr = 0;
 	u32 line_l;
@@ -102,7 +102,7 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 
 	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
 
-	reg = new_state->fb->width * (new_state->fb->format->cpp[0]);
+	reg = drm_format_info_min_pitch(fb->format, 0, fb->width);
 
 	line_l = new_state->fb->pitches[0];
 	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
@@ -112,8 +112,14 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 	/* SET PIXEL FORMAT */
 	reg = readl(priv->mmio + HIBMC_CRT_DISP_CTL);
 	reg &= ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
-	reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT,
-			   new_state->fb->format->cpp[0] * 8 / 16);
+	switch (fb->format->format) {
+	case DRM_FORMAT_XRGB8888:
+		reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT, 2);
+		break;
+	case DRM_FORMAT_RGB565:
+		reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT, 1);
+		break;
+	}
 	writel(reg, priv->mmio + HIBMC_CRT_DISP_CTL);
 }
 
-- 
2.53.0

