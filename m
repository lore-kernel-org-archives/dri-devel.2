Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114C606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1k6agcWN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7DE11232A;
	Thu, 26 Nov 2026 11:29:46 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A4D10E60E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:29:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 299D11A1807;
 Thu, 26 Nov 2026 11:29:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9E1D60237;
 Thu, 26 Nov 2026 11:29:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 09FA711E6B306; Thu, 26 Nov 2026 12:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rZSkzkpoAYEQzNR03LeGNBwix6txHfxvHkvo1VKqHVY=;
 b=1k6agcWN+R6+AI+CsVIXZ/Pnwu/EcpZFAJtx3TNFHonTD6eOlOWsbUujl5WhpKTuZnft94
 2CBTXKlk/q5O1ZVFcCJGHTdCabQog6Xz5XfvZ7huzvg64Y2Boj3bsVzQuiVUrqwA7EGOz1
 mI6jIZ3ukQ8QScsbyTFhhIhSahhPnOlHuYa2EMr9khgu7ViEOX8iD8NdlwICsKiifpsuq+
 s6nhjDNTXHRfEkcYftbKsNOczYxCz2uED7eAvvpCEumc0Aqt2cXk+Fm0cUhBK/PeSkdroa
 +Jx+p1JINNVNnMyRoFVwAVs9TnSZ73u9lEwUU4+tncLEO7o5VJFOdzbbA/XS/w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:28:48 +0100
Subject: [PATCH v7 05/43] drm/drm_color_mgmt: Expose
 drm_get_color_encoding_name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-5-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
In-Reply-To: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
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
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
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
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
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
index f60216adcd31..c7aeb69b54c9 100644
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

