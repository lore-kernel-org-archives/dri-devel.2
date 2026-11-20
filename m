Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98A606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JyOkhE93
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1E6112C33;
	Fri, 20 Nov 2026 18:02:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D20E112C33
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:02:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5DD461A1755;
 Fri, 20 Nov 2026 18:02:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2B5FA601B9;
 Fri, 20 Nov 2026 18:02:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08F5011BC0997; Fri, 20 Nov 2026 19:02:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197759; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jMrUkp8Jmq4FQY+dGBtdQu4nbYZ89fJFnFeknoUPq/E=;
 b=JyOkhE93GeOL5lTKQlQNZ00zcP0xvqHpaNJbTodfvUE7c10KJhpJFtDnSc/ptuK5WS0g5Q
 IyRZDV1V5/mQfT4e+dIcjJ8gb1nqdEQ/xZjMkucRpfrZ2HslI92XY17vY1qbLL0v/K35Dp
 znZbF/iVUHIoAgsXO1MRmAiHpxBJQF/VIbFtWzk3B9o7kqCsNjsxBzmboK6CRmHvP2XGDT
 P5/J76QdI1w/ncIaFaKMiLQWLZ9X3nCj7Y21FnUhp0Fcz/dzmG6Xz0DHtqOJfy+sS5dXJ1
 bK3AAK8q4mrtT55nJM44m/0ZoE5Tw37lX5DNACpQBmjaGKYt+h8SOqUeTxTMwQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:47 +0100
Subject: [PATCH v6 05/43] drm/blend: Get a rotation name from its bitfield
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-5-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4038;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Ql0sub2TFJgazaz3gGeUjQQPDRlHWhBuiIAHC2Oi85M=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr9Gvnos0103sUReBNV8LYmxH74Bk8mt6icm
 xCnNLMw87mJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKjSQ//TNP0+gU+odETPPtHBRLYlmqr2JyypS4
 j+iSIcJ1CUPDhvGgCpF88TDJCuXIxfD2TdNEUqAM78Nq4DzH6G7XSAVAnJSvyusHdhRL3U+YlTm
 X53BTvNfWBltHJJ6zkH7b9gJwKn7A0ER33rKmy/+0b253z6jxsQtI9qOVCWsfbaCO5wCCm+s3EB
 bqQANh94txtfXRIrDCIkE1vjBewtFiNpWDADSXLFd+Y2iYha5kWV10PX7lf5MFubYlXeaXVqaFU
 5AdpQ/f1eEtiPFYW+ssUcxNNe5gg/V32hf52JVrbS3zmwyUz7Kns6gtvNuwtzYQIIKF88D8SWlH
 GiSc9bh4bHiwNro2kOyegpr8yg2VwC5lVjdK4bE3eA51IqWHnewUoPTyuLyB3M802NV2EAUtLuB
 k9nB+1hT1ZORD9rlI2UP5EbhU0i+FBCGSQi5TlwMKIFYO17u/CWIuqiS0Uvae5VjhBnWfpjyqA/
 P7AA2B3D2zrVghOjj9rBowlDlIc2W1tWaSGTKJWoP6nDMFYlMyHZ0+zfM4mjUoRLo7V8Z4Nv9BX
 j0iPx/l5tPC3ymZ5FrXBVJtHGSqdeIO9eNQi/kuGve+t3S/wtDsK9IspLjn5KsGPe+wmvYdWVhu
 R0kuD/PmEv/vFsSv6QiPLnsLyVE53lHdxF9Z6vFXL0FBv0Xpac0I=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extract the rotation/reflection name table and expose the
DRM_ROTATION_FMT()/DRM_ROTATION_FMT_ARGS() helpers to print a
human-readable rotation mask.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_blend.c | 19 ++++++++++---------
 include/drm/drm_blend.h     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index d17ae964fb21..b62f1db9c311 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -256,6 +256,15 @@ int drm_plane_create_alpha_property(struct drm_plane *plane)
 }
 EXPORT_SYMBOL(drm_plane_create_alpha_property);
 
+static const struct drm_prop_enum_list rotation_props[] = {
+	{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
+	{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
+	{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
+	{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
+	{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
+	{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
+};
+
 /**
  * drm_plane_create_rotation_property - create a new rotation property
  * @plane: drm plane
@@ -294,14 +303,6 @@ int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,
 				       unsigned int supported_rotations)
 {
-	static const struct drm_prop_enum_list props[] = {
-		{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
-		{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
-		{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
-		{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
-		{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
-		{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
-	};
 	struct drm_property *prop;
 
 	WARN_ON((supported_rotations & DRM_MODE_ROTATE_MASK) == 0);
@@ -309,7 +310,7 @@ int drm_plane_create_rotation_property(struct drm_plane *plane,
 	WARN_ON(rotation & ~supported_rotations);
 
 	prop = drm_property_create_bitmask(plane->dev, 0, "rotation",
-					   props, ARRAY_SIZE(props),
+					   rotation_props, ARRAY_SIZE(rotation_props),
 					   supported_rotations);
 	if (!prop)
 		return -ENOMEM;
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index bebbb77a8f21..f000b10a16e7 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -43,6 +43,40 @@ static inline bool drm_rotation_90_or_270(unsigned int rotation)
 
 #define DRM_BLEND_ALPHA_OPAQUE		0xffff
 
+/**
+ * DRM_ROTATION_FMT - printf format string describing a rotation bitmask
+ *
+ * To be used together with DRM_ROTATION_FMT_ARGS(), e.g.:
+ *
+ *	seq_printf(m, "rotation=" DRM_ROTATION_FMT "\n",
+ *		   DRM_ROTATION_FMT_ARGS(state->rotation));
+ *
+ * The result names every set bit, separated by single spaces, and ends
+ * with the raw value in parentheses, e.g.:
+ *
+ *	rotate-90 reflect-x (0x00000012)
+ *
+ * The trailing raw value ensures the output is never empty and never
+ * ends with a space, even when no bit is set.
+ */
+#define DRM_ROTATION_FMT "%s%s%s%s%s%s(0x%08x)"
+
+/**
+ * DRM_ROTATION_FMT_ARGS - printf arguments for DRM_ROTATION_FMT
+ * @rot: rotation bitmask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*)
+ *
+ * Evaluates @rot several times: only pass a variable or an expression
+ * without side effects.
+ */
+#define DRM_ROTATION_FMT_ARGS(rot) \
+	((rot) & DRM_MODE_ROTATE_0)   ? "rotate-0 "   : "", \
+	((rot) & DRM_MODE_ROTATE_90)  ? "rotate-90 "  : "", \
+	((rot) & DRM_MODE_ROTATE_180) ? "rotate-180 " : "", \
+	((rot) & DRM_MODE_ROTATE_270) ? "rotate-270 " : "", \
+	((rot) & DRM_MODE_REFLECT_X)  ? "reflect-x "  : "", \
+	((rot) & DRM_MODE_REFLECT_Y)  ? "reflect-y "  : "", \
+	(rot)
+
 int drm_plane_create_alpha_property(struct drm_plane *plane);
 int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,

-- 
2.56.0

