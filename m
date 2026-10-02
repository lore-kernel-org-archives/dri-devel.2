Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3A4CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3438810EAD2;
	Sun,  4 Oct 2026 17:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nahida.im header.i=@nahida.im header.b="hDJA5NKy";
	dkim-atps=neutral
Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com
 [74.125.229.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E6610E048
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 20:33:19 +0000 (UTC)
Received: by mail-dl2-f43.google.com with SMTP id
 a92af1059eb24-1460bcc512eso326c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nahida.im; s=nahida; t=1790973199; x=1791577999; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yaAbUTkeyv8L0kxjY02IfRoRrUD0iGjIWc7/EOPXNTA=;
 b=hDJA5NKy0p+5uDCm4kDf6ZnG/0o2Da17rXh9gDoSQLN0DGa9YnsUKTkGG66+kxM85L
 7/8raEbmJCA8amcx//rQyhLuGik2cnVJ5cAZrNRV4IlgVLmDnbSz76ABKndp6G+iyB0t
 fmWKpJZftuR0V/0slM6Tu4TPflxjm5M1U9MxgZVnfow0ol34PLu0OP+CrL4+oNGoo/UD
 j5gjaUFMnx2dki3VYYvmREq+uurCQPXZU6boqtsJRC97hno2xrxFyxaCiEK7iJnvA4xF
 OESVtp2pDjFVZCWd396lBuThlYdPQ6h2BSc3pLovWpMF1k+8xDnBg8BiphQC8SP+FuUX
 iADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790973199; x=1791577999;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yaAbUTkeyv8L0kxjY02IfRoRrUD0iGjIWc7/EOPXNTA=;
 b=HQ6YuQqx3Fg2Le8Rd/VRWpuMd9j3mX2vOre27zREwUmaX9HwYoZRPYuu+AnR6DcGTy
 pSg4xmLDDo9hnFbdvx6FjnlKpnT+2ktKx9I3qM/NT7k90fEGNXjnhfVTN9uyVFYO0gwr
 V7IBNIbK+yzL8SglcJqYdzhvkDyCw64uy9CFs9I8Skea3VHzNVm7UF96OACXfIrIwcpP
 P+PGQs+j77QOErSgV6SpGXTkaqPZl/6IG7PLHHGivFHLUMg4ctae62+u0fuDEAEIYL05
 JeRIka8N7oLsF6+1MOQl1hSJ9H6/XxVvlBZSIV50riap3CycA59wqR6HMpk8uv+4eP58
 71QQ==
X-Gm-Message-State: AFuF++lYxGi5V8py7tVcMNyj21Zk0Up33OaOfDLi0vubq/u1BLOsNs0P
 MTeXQ/S6s1F+s61kGxqwzDKYgLfAmnf0VOhAnvlDMmGixyy/mI8OCLwXXV77KAvawfJWFCfg0a+
 Bf6/sXd0zsmEO3g==
X-Gm-Gg: AYBFou1Mt2MPIv27D3ZDLpsxjYsCQ4RhQ+mProXwiED26Pr+xTn008ppJjyBq3FT39G
 xQTJhVsUcLs4hUvUnD2oa3x0gomKE2cadQ2YxZksX/JvAXYW4jjjpr2Dl3Ez7TVrC0wZzbBOJox
 pp2zmhVHajDqE5NGOx1NdKq8qhjBKgykYnby0x3UnLHfx+hM7+9z5P5TwXLRH7hqt1L3sgPOGD4
 F4+0svdUbEajNTKyQvdgJFMq4QDelrXIOaS4SW9rDtE3let3G8unKFpBRFiwC3AxVenQcgI7DfT
 5qUEnwVsr7zbocGYT+AQ7iXW9EQG14PQzw5EODdB45MHbflfJz5v37g/Hj8Hf9T7vnib6102KnX
 2Jt5OY3FAOk4gHupItTLm/VhKy2mbCqcItvQvEPC0bD5ze2UqoYT37c3iOnkzSEaJ057QqPf7kd
 vg7dU6BhkiS0d5zdtbIFT9O/60vuRTkAl3f542p3uTFMMKlvIqIbxFJjiNJ7U8yy/UFLc7nphnX
 oNq5xkOSxFH
X-Received: by 2002:a05:7022:ea9c:b0:151:ece6:b171 with SMTP id
 a92af1059eb24-151ecf6056amr107994c88.14.1790973198761; 
 Fri, 02 Oct 2026 13:33:18 -0700 (PDT)
Received: from akasha ([155.103.66.170]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f810bb13esm7239560c88.13.2026.10.02.13.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:33:18 -0700 (PDT)
From: =?UTF-8?q?=E7=BA=B3=E8=A5=BF=E5=A6=B2=20=C2=B7=20Nahida?= <me@nahida.im>
To: dri-devel@lists.freedesktop.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?=E7=BA=B3=E8=A5=BF=E5=A6=B2=20=C2=B7=20Nahida?= <me@nahida.im>
Subject: [PATCH] drm/panic: allow overriding panic QR code URL
Date: Sat,  3 Oct 2026 04:31:40 +0800
Message-ID: <20261002203140.121165-1-me@nahida.im>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

The base URL used for the panic QR code is currently fixed at build time
by CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL. Changing the panic report
endpoint therefore requires rebuilding the kernel.

Add a drm.panic_qr_url module parameter to allow overriding the URL at
boot or module load time, while keeping the Kconfig value as the
default.

Keep the parameter read-only after initialization so the panic path can
access it without additional synchronization.

Expose the configured URL to the DRM panic helper through an internal
getter so the helper can use the runtime value when generating the QR
code.

Assisted-by: LLM
Signed-off-by: 纳西妲 · Nahida <me@nahida.im>
---
Tested on x86_64:
- Full modular build with DRM=m and DRM_KMS_HELPER=m.
- QEMU/virtio-gpu runtime override with a non-empty Kconfig default URL.
- QEMU/virtio-gpu runtime fallback to the Kconfig default URL.
- QEMU/virtio-gpu runtime override with an empty Kconfig default URL.
- QEMU/virtio-gpu raw kmsg QR fallback with no configured URL.

 drivers/gpu/drm/Kconfig              |  9 +++++----
 drivers/gpu/drm/drm_panic.c          |  9 +++++++++
 drivers/gpu/drm/drm_panic_helper.c   | 12 +++++++-----
 drivers/gpu/drm/drm_panic_internal.h |  4 ++++
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b..3d9d421f0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -111,10 +111,11 @@ config DRM_PANIC_SCREEN_QR_CODE_URL
 	string "Base URL of the QR code in the panic screen"
 	depends on DRM_PANIC_SCREEN_QR_CODE
 	help
-	  This option sets the base URL to report the kernel panic. If it's set
-	  the QR code will contain the URL and the kmsg compressed with zlib as
-	  a URL parameter. If it's empty, the QR code will contain the kmsg as
-	  uncompressed text only.
+	  This option sets the default base URL to report the kernel panic. If
+	  it's set the QR code will contain the URL and the kmsg compressed with
+	  zlib as a URL parameter. If it's empty, the QR code will contain the
+	  kmsg as uncompressed text only. It can be overridden with the
+	  drm.panic_qr_url=<url> kernel parameter.
 	  There is a demo code in javascript, to decode and uncompress the kmsg
 	  data from the URL parameter at https://github.com/kdj0c/panic_report
 
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 9fe97c4ed..463544f71 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -49,6 +49,15 @@ MODULE_LICENSE("GPL");
 static uint panic_qr_version = CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
 module_param(panic_qr_version, uint, 0644);
 MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
+static char panic_qr_url[256] = CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL;
+module_param_string(panic_qr_url, panic_qr_url, sizeof(panic_qr_url), 0444);
+MODULE_PARM_DESC(panic_qr_url, "base URL of the QR code in the panic screen");
+
+const char *drm_panic_get_qr_url(void)
+{
+	return panic_qr_url;
+}
+EXPORT_SYMBOL_GPL(drm_panic_get_qr_url);
 #endif
 
 static enum drm_panic_type drm_panic_type = -1;
diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
index 8913c3d22..f98ffe564 100644
--- a/drivers/gpu/drm/drm_panic_helper.c
+++ b/drivers/gpu/drm/drm_panic_helper.c
@@ -609,7 +609,8 @@ static void drm_panic_helper_qr_exit(void)
 	stream.workspace = NULL;
 }
 
-static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_version)
+static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_version,
+					    const char *qr_url)
 {
 	struct kmsg_dump_iter iter;
 	char url[256];
@@ -618,8 +619,7 @@ static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_versi
 	int max_qr_data_size, url_len;
 
 	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
-			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
-			   utsname()->machine, utsname()->release);
+			   qr_url, utsname()->machine, utsname()->release);
 
 	max_qr_data_size = drm_panic_helper_qr_max_data_size(qr_version, url_len);
 	max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFER1_SIZE);
@@ -686,8 +686,10 @@ static int drm_panic_helper_get_qr_code_raw(u8 **qr_image, unsigned int qr_versi
 
 static int drm_panic_helper_get_qr_code(u8 **qr_image, unsigned int qr_version)
 {
-	if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
-		return drm_panic_helper_get_qr_code_url(qr_image, qr_version);
+	const char *qr_url = drm_panic_get_qr_url();
+
+	if (qr_url[0])
+		return drm_panic_helper_get_qr_code_url(qr_image, qr_version, qr_url);
 	else
 		return drm_panic_helper_get_qr_code_raw(qr_image, qr_version);
 }
diff --git a/drivers/gpu/drm/drm_panic_internal.h b/drivers/gpu/drm/drm_panic_internal.h
index fe6d514a0..f33552265 100644
--- a/drivers/gpu/drm/drm_panic_internal.h
+++ b/drivers/gpu/drm/drm_panic_internal.h
@@ -14,6 +14,10 @@ struct drm_device;
 
 #ifdef CONFIG_DRM_PANIC
 
+#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+const char *drm_panic_get_qr_url(void);
+#endif
+
 /**
  * drm_panic_lock - protect panic printing relevant state
  * @dev: struct drm_device

base-commit: 54e61ea6c492d69a1717018826d8340810c812eb
-- 
2.55.0

