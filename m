Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C32C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2F010FE4B;
	Wed, 14 Oct 2026 17:30:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7150110FE4B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9E8360229;
 Wed, 14 Oct 2026 17:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DF11F000C4;
 Wed, 14 Oct 2026 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998995;
 bh=ejp7bTjm6qejzW1A+hw2geD2x6HAdXs4O0Hm1EpWmUw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BFvlUSPnG1MLNoXRWBHwXs6Yy2Cyio7+2txOJa0UZwdCHzCbfMvEVdlJ0hVrFG+7v
 beZctTtpxMBKl4We+86tbctfH/Cq06D65HNV7rhlve4u5KXRKz78IEBZ0ZiqmWbowr
 EnctvQVHt5T5tHHo6i9RyvYx3m2XIQjr4r5myTUUzavgXmI9rUl/mKuf590Tl01uo5
 o9LN8Bl6EzyIrUQa7fFfNL6RXE1AS8vFPH4qgzmZeEHpb1ABUlU7pue9PHqftVAOP2
 YOrjA4LpIEX4Dpy8joIWkFY/GH8ZHOcQF4aMEe/JEmZ3UCF2CsbkSDIvx+7ZqDhL3B
 26zP5FJiHDaWw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:08 +0200
Subject: [PATCH 45/75] drm/tiny: gm12u320: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-45-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=mripard@kernel.org;
 h=from:subject:message-id; bh=E/JURo5jyk5jApTsJYjfI/igwrnjbjxiErfO6IIllYk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8dF2gnK/rvVqVLd9jlB7cDH4kD3Eo8P7dM/y9Wm+
 Nqu9ZHumMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABPhbmFs2LX+aokUo6pndKr8
 /ayHUtaMMwQDdK/dCZveJGSecvaHgZLKopITn0o+5CVlTr5Ut1qJsT7hLEP3BUHdzGk20p9PrQ+
 pu7W720Cy5/Wrar/XdUGSi3WOPWh2ai0PSeutM/sT83mpMAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The tiny: gm12u320 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/tiny/gm12u320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index ddc19cd3e03c..5c4004346ff8 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -545,11 +545,11 @@ static const struct drm_connector_helper_funcs gm12u320_conn_helper_funcs = {
 };
 
 static const struct drm_connector_funcs gm12u320_conn_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int gm12u320_conn_init(struct gm12u320_device *gm12u320)

-- 
2.55.0

