Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA36606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZhlyMMuc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F381A10E5DF;
	Mon, 23 Nov 2026 07:25:07 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4A110E5F1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:25:02 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2f02f04a426so24044815ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 23:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795418701; x=1796023501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rsARERdZD46Vb5O4JLoK8Z3OY4IcI9MHjMKxLTV0Ng0=;
 b=ZhlyMMucNOXDtwj+7JOtMZPwCZafwaFD01YHaH6BgNCk6QWjaA9BKlzWuWREKNmO2/
 0xwsg8tYFwPFdAW5aNH+xNCxoTORxPEw2uDR+UIZFRAUV3RUFciHeyRAVwDzrYPKJZUR
 AkjSWS6dBXSf7zeUAQtcUyFv0k0czACjPzg+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795418701; x=1796023501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rsARERdZD46Vb5O4JLoK8Z3OY4IcI9MHjMKxLTV0Ng0=;
 b=ZIawMEOQWNsFI4oDjoEmBRdTpsMUlACnZ2mFi1wrHmyJZTbCbR4FoLzasU0woPIqi/
 anfoBgvwPM+BvZRwNPf/dLoVNGn4r8inBjXxTnlY4jkywsLkDKc58hxUX6SmCznWQOXe
 RZHXHi63i37oQNpk+3CBgU+vWDTELfw6Do1b/TGbxYFNG3NVa6gFOmQTUFfRYlpAF5mB
 MAPc+5/rQlYC5RVC5xxAV3WTnh4eqdNdfQu7UYD+TjpCA3Ie94am0I0afKxk4IUcMF3B
 D3WV9u/7nDsRYVua1ARDTS+j0EodSrmjHwtW49eSx+f7NhuJVAMyvDJslAMWi50xUsBx
 C8Fg==
X-Forwarded-Encrypted: i=1;
 AL+hErEcuqbt5g1VOHc8MIcqRevsGYs5laYcjDy6oaQZgWh7nOPskRKQivNNqUYvTKh7t2W11yBBihcBS5M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zBJo212RNpDbEKWmQEU1IT2fDyZHZN3+88Z8aCNA5NOjz+4O2
 06+EdhbRei/0qdeKZyoixUjM0VKBggUDy4IqSCf4G6jqKu54K2HW12T2E4SEqx1J3Caf38MqUs1
 Xi7OjjA==
X-Gm-Gg: AZFdTZeD5xJBhD5s1c7Ti/BzU/55HCw9bIgwsAUFS7L8MkUzDj+vl/BKXpSnOwe270D
 shbQplYqhNYo5kuPPBihmFbWiiFxGPdJaKpmPEdagThPCu+NvwQx5z6VR7y6+YlPt46VrXpG7tI
 RA08/bNmbuko9KmQVwGVdwttvcaAEdVM+IEHjiN0Ox6guGJE7JrlDaLcLGmgXC+QKAyPHUn/sBP
 2ogmRn7l9eF4Zwl8kadwZYEcwP6meP28tbf0bhf5sKKhhe0doPWozvcFt9XBUjh9+eVnnZfZklZ
 hZ6uN7G7PorNLAFaWbGIHksfihjq+7tnUPTS9lkatvV82k8vh8JDT7T9aAyiQok63zx67NNY4c+
 24vfyMpLHUoqdMR8QgUrp9XaKM4/ny6Tzv5WMgcZxiIp6oATfRPKozj5VCjK7arMer/IiGWhkU7
 u3kRqejuhnHsCMxGn24GEO35Fkvt0yh1RvvW2avj0SsX1GLYpBK6a+lBQzVd2agm7ATiIC2+vy3
 sxShiBm0O7OSTn6ZPg5s85QrhI/HSaLTx8G/WRrWbsFvnVYaoL5cCURdDJAsil+Sonafdr8rqWq
 6c4BlORaHLosw13x1NMUwFWYgkdzwmKrFbtA9gM5BBuL98uW0rE5Eg35g3hI
X-Received: by 2002:a17:903:1acc:b0:2f0:a113:4e46 with SMTP id
 d9443c01a7336-2f0a1134e76mr11816085ad.48.1795418701534; 
 Sun, 22 Nov 2026 23:25:01 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:fde8:799d:8c83:f2ab])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2f03ee84294sm47180345ad.9.2026.11.22.23.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 23:25:01 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/exynos: Set supported modifiers during plane init
Date: Mon, 23 Nov 2026 15:24:54 +0800
Message-ID: <20261123072455.2221408-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The exynos driver currently checks the modifier in a helper called by
the plane atomic check helper callback. This check only concerns whether
the selected plane supports the tiled format or not. This is tied to
the plane's hardware capability.

Turns out the tiled support was added around the same time modifiers
were being plumbed through DRM planes. The latter provided a way to
describe per-plane modifier support.

Add a field to the hardware plane capability struct to allow adding
an optional list of supported modifiers. This is passed to
drm_universal_plane_init(). This also allows the core to generate
and pass to userspace a list of supported modifiers for each plane.

Also provide a .format_mod_supported callback to restrict
DRM_FORMAT_MOD_SAMSUNG_64_32_TILE to DRM_FORMAT_NV12, matching
framebuffer_check() so the mixer VP plane does not advertise the tiled
modifier for DRM_FORMAT_NV21, and validate modifiers against the plane's
modifier list.

EXYNOS_DRM_PLANE_CAP_TILE and the existing helper are removed, as the
check is now done by the DRM atomic check.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Add .format_mod_supported callback to restrict
  DRM_FORMAT_MOD_SAMSUNG_64_32_TILE to DRM_FORMAT_NV12 (Inki)
- Fix typo in commit message ("down" -> "done")
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 49 +++++++++--------------
 drivers/gpu/drm/exynos/exynos_mixer.c     |  8 +++-
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index b126cd129944..ab0edb826261 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -92,7 +92,6 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_DOUBLE	(1 << 0)
 #define EXYNOS_DRM_PLANE_CAP_SCALE	(1 << 1)
 #define EXYNOS_DRM_PLANE_CAP_ZPOS	(1 << 2)
-#define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
 #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
 #define EXYNOS_DRM_PLANE_CAP_WIN_BLEND	(1 << 5)
 
@@ -112,6 +111,7 @@ struct exynos_drm_plane_config {
 	const uint32_t *pixel_formats;
 	unsigned int num_pixel_formats;
 	unsigned int capabilities;
+	const uint64_t *modifiers;
 };
 
 /*
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 020e8c9cf7de..92ed00e2b6f9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/exynos_drm.h>
@@ -161,6 +162,23 @@ static void exynos_drm_plane_destroy_state(struct drm_plane *plane,
 	kfree(old_exynos_state);
 }
 
+static bool exynos_plane_format_mod_supported(struct drm_plane *plane,
+					      u32 format, u64 modifier)
+{
+	unsigned int i;
+
+	if (modifier == DRM_FORMAT_MOD_SAMSUNG_64_32_TILE &&
+	    format != DRM_FORMAT_NV12)
+		return false;
+
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (plane->modifiers[i] == modifier)
+			return true;
+	}
+
+	return false;
+}
+
 static struct drm_plane_funcs exynos_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
@@ -168,32 +186,9 @@ static struct drm_plane_funcs exynos_plane_funcs = {
 	.atomic_create_state = exynos_drm_plane_create_state,
 	.atomic_duplicate_state = exynos_drm_plane_duplicate_state,
 	.atomic_destroy_state = exynos_drm_plane_destroy_state,
+	.format_mod_supported = exynos_plane_format_mod_supported,
 };
 
-static int
-exynos_drm_plane_check_format(const struct exynos_drm_plane_config *config,
-			      struct exynos_drm_plane_state *state)
-{
-	struct drm_framebuffer *fb = state->base.fb;
-	struct drm_device *dev = fb->dev;
-
-	switch (fb->modifier) {
-	case DRM_FORMAT_MOD_SAMSUNG_64_32_TILE:
-		if (!(config->capabilities & EXYNOS_DRM_PLANE_CAP_TILE))
-			return -ENOTSUPP;
-		break;
-
-	case DRM_FORMAT_MOD_LINEAR:
-		break;
-
-	default:
-		DRM_DEV_ERROR(dev->dev, "unsupported pixel format modifier");
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
 static int
 exynos_drm_plane_check_size(const struct exynos_drm_plane_config *config,
 			    struct exynos_drm_plane_state *state)
@@ -241,10 +236,6 @@ static int exynos_plane_atomic_check(struct drm_plane *plane,
 	/* translate state into exynos_state */
 	exynos_plane_mode_set(exynos_state);
 
-	ret = exynos_drm_plane_check_format(exynos_plane->config, exynos_state);
-	if (ret)
-		return ret;
-
 	ret = exynos_drm_plane_check_size(exynos_plane->config, exynos_state);
 	return ret;
 }
@@ -308,7 +299,7 @@ int exynos_plane_init(struct drm_device *dev,
 				       &exynos_plane_funcs,
 				       config->pixel_formats,
 				       config->num_pixel_formats,
-				       NULL, config->type, NULL);
+				       config->modifiers, config->type, NULL);
 	if (err) {
 		DRM_DEV_ERROR(dev->dev, "failed to initialize plane\n");
 		return err;
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 9b210ff7449f..5da871e5ac9c 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -93,6 +93,12 @@ static const uint32_t vp_formats[] = {
 	DRM_FORMAT_NV21,
 };
 
+static const uint64_t vp_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_SAMSUNG_64_32_TILE,
+	DRM_FORMAT_MOD_INVALID
+};
+
 struct mixer_context {
 	struct platform_device *pdev;
 	struct device		*dev;
@@ -148,8 +154,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(vp_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_SCALE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_TILE |
 				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+		.modifiers = vp_modifiers,
 	},
 };
 
-- 
2.56.1.831.g720f3f5937-goog

