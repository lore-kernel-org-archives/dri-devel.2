Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E45CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 19:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31A610E251;
	Sun, 10 May 2026 19:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MIQpQ9/w";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83CD10E251
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778440529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSff1/jlC/KCVsnlxPeLLqVDEAsoLX+CZn5Ceh75Mv0=;
 b=MIQpQ9/wjPDo3djivme0FTPmbP2MtdI6UCmDyj2Hp4pfhikpOY2HJYBhWhea5QC7uH4ZCi
 hJIk87gmiY8d+g4Dlk3EACnkOR4B6B7cdjk6VIoc+Uh7xFFfr4y93u0hzzfBQAC+kZpUqx
 Oce1wFx3YWsXnSluik/Gn+vjM8Y/THo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-_QaFK9fzOmWyECfmTcuAoQ-1; Sun, 10 May 2026 15:15:27 -0400
X-MC-Unique: _QaFK9fzOmWyECfmTcuAoQ-1
X-Mimecast-MFC-AGG-ID: _QaFK9fzOmWyECfmTcuAoQ_1778440526
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4518f777225so2400006f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778440526; x=1779045326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSff1/jlC/KCVsnlxPeLLqVDEAsoLX+CZn5Ceh75Mv0=;
 b=Lj72Jypal4K6F3tB2USSDtqb/l77HxFrKY1gdA/p7ETy1QshLGqfjQxqvb/zU7FSPt
 yqeXl1tpsYYtb3A4EOlrlVR3yLYH5w6OmIJQ2JakLzZUbCBN1eqFDK5Tea5z740cDZpt
 wkniJJQ9QlFDQwel+o28w1X1TRfPHj5QKFGDBx/DcaGkLjgjLsAvk6QYjiz75joB5k1e
 a38FNYvYKB+cORbmr9JUzW4zXnRSBVfOHfvwrh3t9sTxBKgmBUxdo0MWUW7JcOqLv/6Z
 X+zUPIwkf4KM/v0gMpe3FxKbjm8echtAFahVb4j5veRtJ/LujOxs8dMB3ht6H3wxZZFd
 kcJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Nkb765aT5aN59SELga+oNKRYeCMHPhTpZyyWbS9uHk/Pd/NoE531itFkDGBuZ0rLYiXMyaKFVGqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSXOVxWyiQswik85wNc1L6nzoP9dLQgUNHcqXCmDyY+Y/Z+rl3
 TWm01cqWIytgokGdyQ7itcpDPAiRUv9SL6bzevDZbuo921G+4+5qYQexbM98i+mXZA6CeHuPr1k
 MXmKh6QtVWcPuf8GTa6rWEy59qGLwD7EMW+Sdw4c9ha2M5R5Lh9Tb8IdSUbLc51v3mRMyKg==
X-Gm-Gg: Acq92OEBc1FhjPjMn6VJOtUFlWGlcQqcMBx3mluj8jMSge01QSDhtXm81WUCmMP9fMk
 p/qo6JyBoTgoyc19LarGkVrtsbjR6QncXgHVx6ZIZdioJlRDpoHPhMzq4kgGSLu98jQDhw1yas0
 2NtZucgN3Vp0Iw6L4qDviN39yu7J0GomSol47uy6kv+kYjHXezQxP3cs2znoaB2rOSgY9lIfvzR
 wv8raFCqaKMQvU9EClo5iCF8r5XwS0m+LzccCFz52ZRAyT0nrxBDQ9Ci4iyyqeswlF6+faOGm2Q
 pKkgWabAa8jKwH3QrE9BBdjCvpdvtwBzTNvyUMQ5dPa+g0qUuQF8DfruXyT82tDUZX3VWHO9kP/
 cXLMz6MZdYq/+syACmQBwtZsh+C+yJJpR3nphJK85DJQCl/M=
X-Received: by 2002:a5d:5f53:0:b0:43e:a69b:d810 with SMTP id
 ffacd0b85a97d-4515d9a0839mr34527734f8f.38.1778440526171; 
 Sun, 10 May 2026 12:15:26 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43e:a69b:d810 with SMTP id
 ffacd0b85a97d-4515d9a0839mr34527707f8f.38.1778440525714; 
 Sun, 10 May 2026 12:15:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e4bbebdsm21919341f8f.5.2026.05.10.12.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 12:15:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/bridge: it66121: Add bridge_to_it66121_ctx() helper
Date: Sun, 10 May 2026 21:14:47 +0200
Message-ID: <20260510191459.90769-2-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510191459.90769-1-javierm@redhat.com>
References: <20260510191459.90769-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HwXh6bnG4G6Luv0KMDFxYDhyaiwsbfdSRP7wvxD_47E_1778440526
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The driver just calls container_of() to obtain the it66121_ctx from a
drm_bridge, but follow the convention of other bridge drivers and add
a helper function to wrap this duplicated logic.

No functional change.

Assisted-by: Cursor:claude-4.6-opus
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/bridge/ite-it66121.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 19a027d75b61..038a67a32e39 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -315,6 +315,11 @@ struct it66121_ctx {
 	enum chip_id id;
 };
 
+static inline struct it66121_ctx *bridge_to_it66121_ctx(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct it66121_ctx, bridge);
+}
+
 static const struct regmap_range_cfg it66121_regmap_banks[] = {
 	{
 		.name = "it66121",
@@ -589,7 +594,7 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 				 struct drm_encoder *encoder,
 				 enum drm_bridge_attach_flags flags)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	int ret;
 
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
@@ -700,7 +705,7 @@ static u32 *it66121_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 						     u32 output_fmt,
 						     unsigned int *num_input_fmts)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	u32 *input_fmts;
 
 	*num_input_fmts = 0;
@@ -724,7 +729,7 @@ static u32 *it66121_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 static void it66121_bridge_enable(struct drm_bridge *bridge,
 				  struct drm_atomic_commit *state)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 
 	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 
@@ -734,7 +739,7 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
 static void it66121_bridge_disable(struct drm_bridge *bridge,
 				   struct drm_atomic_commit *state)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 
 	it66121_set_mute(ctx, true);
 
@@ -746,7 +751,7 @@ static int it66121_bridge_check(struct drm_bridge *bridge,
 				struct drm_crtc_state *crtc_state,
 				struct drm_connector_state *conn_state)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 
 	if (ctx->id == ID_IT6610) {
 		/* The IT6610 only supports these settings */
@@ -765,7 +770,7 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 			     const struct drm_display_mode *adjusted_mode)
 {
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	int ret;
 
 	mutex_lock(&ctx->lock);
@@ -829,7 +834,7 @@ static enum drm_mode_status it66121_bridge_mode_valid(struct drm_bridge *bridge,
 						      const struct drm_display_info *info,
 						      const struct drm_display_mode *mode)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	unsigned long max_clock;
 
 	max_clock = (ctx->bus_width == 12) ? 74250 : 148500;
@@ -846,7 +851,7 @@ static enum drm_mode_status it66121_bridge_mode_valid(struct drm_bridge *bridge,
 static enum drm_connector_status
 it66121_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 
 	return it66121_is_hpd_detect(ctx) ? connector_status_connected
 					  : connector_status_disconnected;
@@ -854,7 +859,7 @@ it66121_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector
 
 static void it66121_bridge_hpd_enable(struct drm_bridge *bridge)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	int ret;
 
 	ret = regmap_write_bits(ctx->regmap, IT66121_INT_MASK1_REG, IT66121_INT_MASK1_HPD, 0);
@@ -864,7 +869,7 @@ static void it66121_bridge_hpd_enable(struct drm_bridge *bridge)
 
 static void it66121_bridge_hpd_disable(struct drm_bridge *bridge)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	int ret;
 
 	ret = regmap_write_bits(ctx->regmap, IT66121_INT_MASK1_REG,
@@ -876,7 +881,7 @@ static void it66121_bridge_hpd_disable(struct drm_bridge *bridge)
 static const struct drm_edid *it66121_bridge_edid_read(struct drm_bridge *bridge,
 						       struct drm_connector *connector)
 {
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
 	const struct drm_edid *drm_edid;
 	int ret;
 
-- 
2.54.0

