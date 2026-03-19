Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B61090248
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF95E10E900;
	Thu, 19 Mar 2026 16:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="kSmivpU0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UZ0ThgTc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kSmivpU0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UZ0ThgTc";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB4510E8F9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08B255BD7E;
 Thu, 19 Mar 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lQ0dzJCQOKL220mHC4h+zKzgoA+bTLhr6+OiWb1gqg=;
 b=kSmivpU0fAQL4pyAIrCZN5TID1ldF2MQ6se4R14yftkK4CRZzG5YSmpG3O0fASmLUr/9ZJ
 TYpIz1NPChdOh+wkQBV+9dzR1IWZYq2d+C1xFuM1XtcmoiBCJDucGrkNj7mg1Nrt8D9neA
 BOUMo/jIuERaNWRey6i1DNp7hMnPCCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lQ0dzJCQOKL220mHC4h+zKzgoA+bTLhr6+OiWb1gqg=;
 b=UZ0ThgTcZKchk0+43taNCDp8/8SYYJ0hiS+9kDU1fqgYnCR9wU+9yY+aVWGti+6YgXnXXb
 7bOG+m0yBXrKmiBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lQ0dzJCQOKL220mHC4h+zKzgoA+bTLhr6+OiWb1gqg=;
 b=kSmivpU0fAQL4pyAIrCZN5TID1ldF2MQ6se4R14yftkK4CRZzG5YSmpG3O0fASmLUr/9ZJ
 TYpIz1NPChdOh+wkQBV+9dzR1IWZYq2d+C1xFuM1XtcmoiBCJDucGrkNj7mg1Nrt8D9neA
 BOUMo/jIuERaNWRey6i1DNp7hMnPCCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lQ0dzJCQOKL220mHC4h+zKzgoA+bTLhr6+OiWb1gqg=;
 b=UZ0ThgTcZKchk0+43taNCDp8/8SYYJ0hiS+9kDU1fqgYnCR9wU+9yY+aVWGti+6YgXnXXb
 7bOG+m0yBXrKmiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83FB34275A;
 Thu, 19 Mar 2026 16:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kMncHs4dvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 12/16] drm/st7735r: Rename struct st7735r_priv to struct
 st7735r_device
Date: Thu, 19 Mar 2026 16:59:48 +0100
Message-ID: <20260319160110.109610-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
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

Rename the driver's device struct according to DRM conventions. Also
add a helper to upcast from struct drm_device. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/sitronix/st7735r.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index 1a34c7ba460b..9dd915765a6b 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -52,18 +52,22 @@ struct st7735r_cfg {
 	unsigned int rgb:1;		/* RGB (vs. BGR) */
 };
 
-struct st7735r_priv {
+struct st7735r_device {
 	struct mipi_dbi_dev dbidev;	/* Must be first for .release() */
 	const struct st7735r_cfg *cfg;
 };
 
+static struct st7735r_device *to_st7735r_device(struct drm_device *drm)
+{
+	return container_of(drm_to_mipi_dbi_dev(drm), struct st7735r_device, dbidev);
+}
+
 static void st7735r_pipe_enable(struct drm_simple_display_pipe *pipe,
 				struct drm_crtc_state *crtc_state,
 				struct drm_plane_state *plane_state)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
-	struct st7735r_priv *priv = container_of(dbidev, struct st7735r_priv,
-						 dbidev);
+	struct st7735r_device *priv = to_st7735r_device(pipe->crtc.dev);
+	struct mipi_dbi_dev *dbidev = &priv->dbidev;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	int ret, idx;
 	u8 addr_mode;
@@ -184,7 +188,7 @@ static int st7735r_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	const struct st7735r_cfg *cfg;
 	struct mipi_dbi_dev *dbidev;
-	struct st7735r_priv *priv;
+	struct st7735r_device *priv;
 	struct drm_device *drm;
 	struct mipi_dbi *dbi;
 	struct gpio_desc *dc;
@@ -196,7 +200,7 @@ static int st7735r_probe(struct spi_device *spi)
 		cfg = (void *)spi_get_device_id(spi)->driver_data;
 
 	priv = devm_drm_dev_alloc(dev, &st7735r_driver,
-				  struct st7735r_priv, dbidev.drm);
+				  struct st7735r_device, dbidev.drm);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-- 
2.53.0

