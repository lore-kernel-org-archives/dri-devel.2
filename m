Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11606CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 19:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B96C10E3D9;
	Sun, 10 May 2026 19:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gZOIhx41";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADB610E3A5
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778440535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5GqCf5R+p7fabe4GDp9/SkqKKTHiUv88WJZ+GaLKk0=;
 b=gZOIhx41dhJYz+n6aUgUVey3WvXIkFEnQ1BT7VzratRwbvPA21tPOlvc2KCohkJPx2Kr7r
 3aC3FNnUt4EsBdkLF7nMFSTlaASATW8U0LFxHl90I+/sud7Ba5kX3sUvqYwMh+oRjQEB8e
 5sYSfIuPLsyRFfiVdOBOCvbJ/h/1Yfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-iM6jDpThPoGc4Bc7BWUu7Q-1; Sun, 10 May 2026 15:15:32 -0400
X-MC-Unique: iM6jDpThPoGc4Bc7BWUu7Q-1
X-Mimecast-MFC-AGG-ID: iM6jDpThPoGc4Bc7BWUu7Q_1778440531
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48d1b294dfeso33756835e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778440531; x=1779045331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B5GqCf5R+p7fabe4GDp9/SkqKKTHiUv88WJZ+GaLKk0=;
 b=HSdj3uNBmKRGK1U9vc8htBbaIEkKtdQmQK6/JZYO7j2NY3LOxJIPX7l6M5ZxlJhXZA
 zF+7Q2ycFtq8XVEko5TaIVRNu/6Q/gJkqD61L8ZM00/JAtZOICFftAzT0xOzesCYz3Hf
 XOoFF+OCTkIZYiYJNGFgjTqnMo9p1ilDrUQse4zE/T2yLZxKBBv41RPLNFEkiCJPnlr4
 fGjdeR3QwAkzN7a7zBxxVWtVcbjUXCvXWirxb/UIvQslg1nzgYVgrmWKWkWQO19nS1GS
 w6Vjg+42m4azxtwk2sQnafL0SHATxHTnYZvYPwomYdOYHcq/VEqS7KyyUdi6acIrvjJZ
 05Ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8D05+G7ANkPUY0oklnfbwCcQsNlwhtQ6HH3n802bXpwlwXb53oYLIIu25++Mlgv3S4fiqiADj6eTE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywq9EQ+eySBzBcc2MM8ssPNGdVs1vYeXcnE0C1P3DWeVVbb42uj
 qJQf6EHP0VmbnhHAZOLtvqwVDt6Atc2jLiu7UJOivRH0DY384C0I/LOAzathIIPNPvIGnsiFV5i
 xnR+S7K65m6PezF9tWYpKm8ataeNGz+P9NetuCA5YUCz8tuHPgNm+tAFbE3h4rPmbt3vC5g==
X-Gm-Gg: Acq92OH3z8dfscdkVj/AEcrnIXFcuRSZp7+X78Yc2lT4KIygkRA/VZuj3HSi2msSd0L
 D23w85o3aa+bp2VM1XAjz3ACSSlRmxqB7VNZsQG3K2hi9dCzGt1ITyFtYgzTee+L8GtmFspgH5A
 01u075/xSbx5pdwEzVhDpGCsC6oV0lRayDtiKSPRbnTlEe3lhnPzt8qz95Vsu/MH5PMVmukOBBf
 ITdVSlFYfeVb7tbDCo+hxKXl1TQzM3kgCOIf7fmXOW8sbu7HwSs46jGH8sNYwc66tZYevDKXq3/
 aGvqWNSxMeIupbdsjCjr8/4tq7mF7lH7hyvyPjIw4QuEfuNksSRLjHnLUjE3Uj5dqCuwzSHfcSn
 M0broGPE3FULaG0dqB9p7Js75biy/q9g0BvAYYCM6oe6hoggwWrInl84E/Q==
X-Received: by 2002:a05:600c:c11c:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48e70804097mr77660835e9.26.1778440530910; 
 Sun, 10 May 2026 12:15:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c11c:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48e70804097mr77660435e9.26.1778440530284; 
 Sun, 10 May 2026 12:15:30 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45492271510sm24198854f8f.37.2026.05.10.12.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 12:15:28 -0700 (PDT)
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
Subject: [PATCH 2/3] drm/bridge: it66121: Add bridge-private atomic state
Date: Sun, 10 May 2026 21:14:48 +0200
Message-ID: <20260510191459.90769-3-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510191459.90769-1-javierm@redhat.com>
References: <20260510191459.90769-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7BhB2iJ7Z1JgdoKnbFLWQVEQ7uahD7N6hPDo7zBdxdU_1778440531
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

In preparation to support per-state configuration during atomic commits,
add a private bridge state data structure and access helpers. This will
be needed to store the display information sink mode, to determine if a
connector is HDMI or DVI.

No functional change.

Assisted-by: Cursor:claude-4.6-opus
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/bridge/ite-it66121.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 038a67a32e39..a203c94a27e5 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -320,6 +320,44 @@ static inline struct it66121_ctx *bridge_to_it66121_ctx(struct drm_bridge *bridg
 	return container_of(bridge, struct it66121_ctx, bridge);
 }
 
+struct it66121_bridge_state {
+	struct drm_bridge_state base;
+};
+
+static inline struct it66121_bridge_state *
+to_it66121_bridge_state(struct drm_bridge_state *state)
+{
+	return container_of(state, struct it66121_bridge_state, base);
+}
+
+static struct drm_bridge_state *
+it66121_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
+{
+	struct it66121_bridge_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_bridge_duplicate_state(bridge, &state->base);
+
+	return &state->base;
+}
+
+static struct drm_bridge_state *
+it66121_bridge_atomic_reset(struct drm_bridge *bridge)
+{
+	struct it66121_bridge_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_bridge_reset(bridge, &state->base);
+
+	return &state->base;
+}
+
 static const struct regmap_range_cfg it66121_regmap_banks[] = {
 	{
 		.name = "it66121",
@@ -908,9 +946,9 @@ static const struct drm_edid *it66121_bridge_edid_read(struct drm_bridge *bridge
 }
 
 static const struct drm_bridge_funcs it66121_bridge_funcs = {
-	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_duplicate_state = it66121_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_reset = it66121_bridge_atomic_reset,
 	.attach = it66121_bridge_attach,
 	.atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
-- 
2.54.0

