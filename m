Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223ADC43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE15A10E41F;
	Sat, 27 Jun 2026 03:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pX3F8thD";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF59410E41D
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 836411A0A08;
 Sat, 27 Jun 2026 03:31:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4F97A60233;
 Sat, 27 Jun 2026 03:31:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2981D106F1167; 
 Sat, 27 Jun 2026 05:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531059; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LkKO+cSK/Ye05XIzMVJHZ3qVH0PlvYUH5JWHtBpBEuI=;
 b=pX3F8thDgWlixVnc0GtX9C887o7ALjgWZe8heGIZ45eh+ox/ibJA0BNbkXDWtBkwlgEl94
 sRDl2s25o5ZIsFwC8fJN1WKt19y0bafYatbIPRfR5FKMfaBH4YYC/UBx1geQ84Qd3N70Zg
 93Wk9H++T2NcTIEQGdx1FPFcXJAwEq3GKeTLlBY0M/1mSSqVWWjzqSz47Y2gfoTfYI+6iI
 CyBXJTHt73bVP7Yp+lGRMUSqcoCEMBqy1m0U4Ei9xWUx+k6WTgweUVHmr03fb6qI6NzdCF
 BMUswJJo9BcKuBGA/szEUF8qnSztJA01789bkscyGlonV5npddBuCJa3TlofJw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:21 +0200
Subject: [PATCH v5 04/38] drm/drm_color_mgmt: Expose drm_get_color_range_name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-4-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=VvRVYwMiTJsuiQCHjBp397SgToWhiUwd1PayCIWe6sM=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PdujJqeEY3EqPRbTz7xSCUiTYnxeklYJmQ1
 L20YyC2ydGJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLw0g/+JlcimzuVri+AhRx4HDkljurIN6TtZ1q
 jfuOu1Jfb53vagQQBoxIz3e0JMF7xKVdqt7nuxhJ5qppL/jZDyJ0iuRg2qv6vTyQ4IrUjn/yVg+
 u7ESkRKNKRNhqYvi/QZVBxB7w8+ITLQOkIpu4wpMBWXQ0XTcOUH1Smkjf4DyVXCJmJIvRdGqO5R
 ABYZZivS2hRCNHQuvJsaxJi3782McmH2oJeINFYcx5ePQXfLGIyQx6LIPzEBcHBoCUlVU8mhYAw
 qXGhWQUxsRh94KBRPVQHE3cgLHVdfuqj5QpfqNtCMAkOvBQP62/t9SYe24Veq4oIvWouiGQG5Zj
 U6lT1/JuUEOZr9SIi8KeZ4pNFIW8qc6oIH9pFFt5417c4w5J1A46e594L4G03XHSXeSPNof+ixS
 evZD2uTFcAVLEFe7V6nmKrHUMMMjditfqxlubc3yjyqy3cxt5IYiGobZcXe1Soewq7IDVLsPJtu
 5JjDKZZJ2TIScNLDFEkDGU3sAlLlFzqKtI1lDLrbkgnIRMmC9a55oQFUF253Ja84nVO3LQsYXVl
 Q61lcSppsKAnW+saLjPEQiiWPBFbe/rxVEBfHHlPenAlatoCPs4ZU+MA71TOT6MEdsmjGE8atTS
 DVnfVkYUV/AF8xmbfa0UT2I0DxZnkHnkgcM3mZtaxCJBojHnq0rY=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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
index b5635862dc91..8ec87d1c7433 100644
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
index bcd23eb0e531..4bf6bc0bcb5a 100644
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
2.54.0

