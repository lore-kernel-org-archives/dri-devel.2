Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759160A2633
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YZGUwu4B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C44112C55;
	Fri, 20 Nov 2026 18:03:19 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A3C112C51
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:03:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 875681A1756;
 Fri, 20 Nov 2026 18:03:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 55736601B9;
 Fri, 20 Nov 2026 18:03:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5D2611BC08D7; Fri, 20 Nov 2026 19:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=M2KsKVZh/0pXQfV4BHEeYwLNAlBMvr5UC2AAQt/TdhA=;
 b=YZGUwu4BXgCS4IF+B9q6YlymSVEp8WLVK0HZ7E6C5HVEhfQYYHcqNylZICeff8y1qykTW1
 R8ZfEkpGZZX5dpWcPiyc3/Lxq4W/EAWha8jZi8PwUUx18JvUrQjwSq9MfA88oqX1hj9CxT
 h6PVXuFqeln5MyHAy8urZJcVRG8M0sir3HxwxMRq+AjyiQbiIYmk9z0UyAFJZ+KtAiQZdA
 VAUvOn/HzUNN1KDSWTVHWfgDP40EpmUw68gy6mz7cVXUA5gE0cH74aci9LLBxMVOOsj/yN
 +SP50QbnOAJRvIBMUvvmzWcGrGcIV5imSHBcOz3XKu8JPLJHk8Sb3tPeVorPOA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:50 +0100
Subject: [PATCH v6 08/43] drm/drm_color_mgmt: Expose drm_get_color_range_name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-8-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=FQuyITAwHZW3k0b/wCAt/2d14PBs+KuJlhaEd/K3ysQ=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr+cbjrRcDRNXUvm6RWSgNV1O3XosECsYmKT
 bw2YwNkkKmJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOISaBAAiTrl4/ys1CnVB4l465MwFcEq0MR9kpH
 FHOiTOO/ejk8DRQzqkwfmx45VxMxrbbijYUJazfQ24AuHN713PqlBjRwixLx9ohWZZRhUSBRDdf
 yU2f0JtP9zLdHzFTj9SEujanha7hKLaAMAJYXMIAXH0BgQx2yOxp8VfnTupBdJMOdsp7m1H4hTm
 dnvHIIytvpcJhSUlJG+kjkSkGnqtbSvUn93ebSLYJu5DKZg7uljtga1/IhhMfUDl/x8W268kfyb
 TZyOMGQ8R2Bm4KTu1ElwzJ7l3RjQcEr3ual4Y/Q1Mf+VX3WyKAWT09+lgysKqdMRTinApBO9UOm
 bhJoBaif4yVgMsUoIE8RcYO8w8E/tUyWT8VJd5dP92TfI8SJZgE+Ih+qcM7x01R8B7Z+ZVkflVA
 hU+RQd9qT6meeeHxaAMnUZJvDbs5zq+huAP1ruZGU/A6m5mjLmmVKrKM0resvWsZzyQSRUPF/4g
 Nw3t1y2rcZ/z+Jlj+2GABJanT4IwC84xIJLD07Ts9kZq9bk7+Wh7bwBRVvSO3qLcfKYXstO20z1
 91USgpuTZFHbFBvn4fnEjvIUzXhdaiuxgUGPsQ6T2emAStfN13I4tkW113JY/fjWli416aSeI9+
 NLSVbXx9xkufG9GWk4bUVT6DLwcZb86/WuyeJX4gjt6y/RL6/X5c=
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

drm_get_color_range_name can be useful to print debugging information.
Export it so it could be used from VKMS.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_color_mgmt.c    | 2 +-
 drivers/gpu/drm/drm_crtc_internal.h | 4 ----
 include/drm/drm_color_mgmt.h        | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index de219c23322f..a65fef5702ab 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -512,7 +512,7 @@ const char *drm_get_color_range_name(enum drm_color_range range)
 
 	return color_range_name[range];
 }
-EXPORT_SYMBOL_IF_KUNIT(drm_get_color_range_name);
+EXPORT_SYMBOL(drm_get_color_range_name);
 
 /**
  * drm_plane_create_color_properties - color encoding related plane properties
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index f3a3ffd358dc..168799fac7c8 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -38,7 +38,6 @@
 #include <linux/err.h>
 #include <linux/types.h>
 
-enum drm_color_range;
 enum drm_connector_force;
 enum drm_mode_status;
 
@@ -119,9 +118,6 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
 int drm_mode_destroy_dumb_ioctl(struct drm_device *dev,
 				void *data, struct drm_file *file_priv);
 
-/* drm_color_mgmt.c */
-const char *drm_get_color_range_name(enum drm_color_range range);
-
 /* IOCTLs */
 int drm_mode_gamma_get_ioctl(struct drm_device *dev,
 			     void *data, struct drm_file *file_priv);
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 133ca77d91c7..e91f494e5a63 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -114,6 +114,7 @@ enum drm_color_range {
 };
 
 const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
+const char *drm_get_color_range_name(enum drm_color_range range);
 
 int drm_plane_create_color_properties(struct drm_plane *plane,
 				      u32 supported_encodings,

-- 
2.56.0

