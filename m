Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78C60A262A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pkm0SQFb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692AD112C4B;
	Fri, 20 Nov 2026 18:03:11 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06303112C51
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:03:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7D640C62223;
 Fri, 20 Nov 2026 18:03:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B2302601B9;
 Fri, 20 Nov 2026 18:03:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7077811BC0627; Fri, 20 Nov 2026 19:02:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197778; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Dxd22oXPPVAd5i5zCngTzre1VFtuF4ZUkxmeEL48voQ=;
 b=pkm0SQFb8M3bcqQeZnkkw0/lKbI3Y6LogNVyHOsvnHWarZgGDoJBZNUGkjWURpiY/VzgQw
 fDRMf6kWpBx/ZVYDIYHB2EG9zeWSIJBMlNrLb+wwQoWxsxzZqC5EC17IeQWuYz9KHh5M1s
 JHdZUd2xDuZZLvqHKI5+oNVqRBHJJx9hFVk3ChbmYSd/oBboabZyDlux5IY02VjWz6bghd
 Y8sajEZEhGIZWDcvlIOJxd1KWiuKdtNpvtInVG421OD/uf+5i3BqUUXNFserMKrnQ5YX34
 s0qxzROYxYniHzJzkQZTMCrKWVHXzEJKTWlznlWAgH/287vyd7gLvvI+eOxY5w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:49 +0100
Subject: [PATCH v6 07/43] drm/drm_color_mgmt: Expose
 drm_get_color_encoding_name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-7-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Pi/Cu5oTYXL4QYS3MGHduSiN+TssWPyVEHXB9lb9mI4=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr+4Vg55h/lTH3J4+X/q14CjBhla5wwy1QWx
 eB37dWG4cWJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKmzQ/+I4ZK1Pp5liIG7JWKUumvwiyQFv793+/
 jKUxDVJkcX9ZgcKsiB0B6dbKArtS6Sb5fB3CjMsAMYassWRL5giA30GUaJWikqFBik/HjydjEg0
 n5TSYecO5rcgtX8YtXuNL63YDl7xLNlNnrQHqAWUQiQVJaGB0uNS+c5EPwN0dmsz1MxKHSdy6Wu
 iwp9Qmsy9cn/0W5uX/nb8vEbrCqlpkEBUZ986Gw9j6E8uqigwtEiznivGEBA2ME04Nq0HfS/z9w
 ls7ZIskZTvC1t5DgD4CosgR66zkrg08kqq10C5Wby6MTFSbVOHHaT8wlxzzG0hcKjeSu5fi4RZd
 IdPXTT7TsKxgTC7bpZmOlQ7MQgPTlU9LC5aG/cLLlvDhDyypAYtRyDOxk+5F0bo5NGW0fiXOM8j
 bEvl22xny810eHeZ+9FXqYgGDcCRdWS8j8NBH2EiJkysN8Cq08E5qCZ1PLY+pbmO7K9FNGX4mFs
 ihjnRszGr2MyosnA+yiovB4HE/HvqhKey4XEhi+mKU4RBb+xLAJV22fqzpNPW1jaA6vwXo6d0iV
 vnZjtBvariBLnLCJ/XBwEEKeASHMcjWTrXNviMDTB7kdT6mfYtfBYIEyatk8M8KorosTgr2vm6O
 6kUEpu1r+1m8Acp3EKD/oHmX3zPquJ/IXAAHs2BuP+MHFakELGhg=
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

drm_get_color_encoding_name can be useful to display debug information
outside drm core. Export it so it could be used for VKMS

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_color_mgmt.c    | 2 +-
 drivers/gpu/drm/drm_crtc_internal.h | 2 --
 include/drm/drm_color_mgmt.h        | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index e4e31bc0153e..de219c23322f 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -496,7 +496,7 @@ const char *drm_get_color_encoding_name(enum drm_color_encoding encoding)
 
 	return color_encoding_name[encoding];
 }
-EXPORT_SYMBOL_IF_KUNIT(drm_get_color_encoding_name);
+EXPORT_SYMBOL(drm_get_color_encoding_name);
 
 /**
  * drm_get_color_range_name - return a string for color range
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 3492787c3697..f3a3ffd358dc 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -38,7 +38,6 @@
 #include <linux/err.h>
 #include <linux/types.h>
 
-enum drm_color_encoding;
 enum drm_color_range;
 enum drm_connector_force;
 enum drm_mode_status;
@@ -121,7 +120,6 @@ int drm_mode_destroy_dumb_ioctl(struct drm_device *dev,
 				void *data, struct drm_file *file_priv);
 
 /* drm_color_mgmt.c */
-const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
 const char *drm_get_color_range_name(enum drm_color_range range);
 
 /* IOCTLs */
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 5140691f476a..133ca77d91c7 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -113,6 +113,8 @@ enum drm_color_range {
 	DRM_COLOR_RANGE_MAX,
 };
 
+const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
+
 int drm_plane_create_color_properties(struct drm_plane *plane,
 				      u32 supported_encodings,
 				      u32 supported_ranges,

-- 
2.56.0

