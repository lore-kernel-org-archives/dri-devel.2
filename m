Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3035CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A2610EAE3;
	Sun,  4 Oct 2026 17:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nahida.im header.i=@nahida.im header.b="DNYUsJI5";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2987D10E00C
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 22:26:10 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a1681949b8so1191285e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nahida.im; s=nahida; t=1790979968; x=1791584768; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BiaxJRqGo6X1dko2yEPnGXMg7e78PjNfKxJLCypYRSM=;
 b=DNYUsJI5ZdOCx4iVWRDqurCqHx3SIjGlksp/ZZE6f+Kv9kz8dzuxdu3VTmE464xtg1
 0PRFQzKjkU94xq877yaIWAq/gueQ4x6ybh/RTtlyuFEB7Hx4vU+08pTMBVJWA8sjfPbS
 82h6We9gMM2auu4AAP+xCguX9odki9KvXtEVXj6IY209SYeykHO837xZyfWeb5njCe2R
 jBRnGZ7VSPxA2SQVbLYsFhN1C104RlGkrLjKGARdJgXPUsQRBvFVrrK4FDs9A147AghE
 pALsfZFlh6IHn4JfoDaPPohwtYjV980q9STOkrPVNQ1YacFP2hw6l8EpGUQRcgh4TBqL
 GRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790979968; x=1791584768;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BiaxJRqGo6X1dko2yEPnGXMg7e78PjNfKxJLCypYRSM=;
 b=lcV5VPW/GxgGWECh3t5IZ5w1PN8nbUbDP/VHqC81rbTdC0dO3bbuOqD4YOtOJ1zIbb
 DIGJeP5h8YgfOfkccK5zU5+2VcsycZJSMl2STyACkZXkwCglpkWoy8jekZdhPvHrKdVS
 UXONpJ6Uzb9X0AZjL9onHAKn3OQGqomoyNX1KHk82tt7e1p6NROKYGKBb7SltkenDES9
 meSlkh7LR0ffGrGBit1E+Au14a5j/FeiEZLEhmHZHBike+P06cr9+A/MqFHw+6rKe6Xp
 wm5N0MChjVEtcjm2hhXRRnrDGz5uVA3lmBNXRyP/y/6e3+bXSiZvl/TbTMr0Dxt1CsA4
 7Ocw==
X-Gm-Message-State: AFuF++mRcSXclUJffUQj7DVLlnTVwEpJzqBYNGhO+fCEYZ2+MCIbYFfo
 23viy+WYGTvUzwSTXwNjkHctn13Da6WAatyTKxkXx5KmnfU3+SUhoKila13ZZguKjCj1vdNs8RR
 JFtrd5Ilxv9m1ig==
X-Gm-Gg: AYBFou30xVybt7yVEQuUazyR96NmvvtSAFvRGh7RioBhx0VApL/HPU6SDsjuMaeikST
 +5xteeLz5NEzGboaTd+nds5AEMuK1pq/kojMjiX9AVIOvrtqFAWLbQSvfh6PCCDUS6Y+i0zbDAR
 OWzTsDkIF22gLA9djEKoD3c6iKsn+Rw0T3dK0eJEClrT3Nr2UBM/FOV4M8DcwZ4Dfo44mmjmmZS
 +xXg4Obm7urSi0eE7ExQs6PI4v0gNlq/ZI+Xg6yAuqoGKamMZgJvF7UXK2jP6HbgUBVAdw/DX2J
 qD9YhPcJEceDiGAygNfr9G/2vWQviuVKHaR2H9wDdGYQMue6s3J6eK29nCA2C56/1uMbgjEgSwS
 50uynf+B63ouH/C9R/JhnYCay2/sESaaImhk7ZJfL4iDNjpuO7MJJw9fu93MPA8IibuLJk6YOQq
 1cVvchqQQQCAjV6MPMThdlQf70Acycoc/yRDypKeje/KIGfM0XHbagjvOFSBViqP3FsPID0JU9R
 idwPifZh6eW
X-Received: by 2002:a05:600c:6992:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a02755fd98mr68431455e9.7.1790979967946; 
 Fri, 02 Oct 2026 15:26:07 -0700 (PDT)
Received: from akasha ([213.145.82.166]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380facfesm8968085f8f.23.2026.10.02.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 15:26:07 -0700 (PDT)
From: =?UTF-8?q?=E7=BA=B3=E8=A5=BF=E5=A6=B2=20=C2=B7=20Nahida?= <me@nahida.im>
To: dri-devel@lists.freedesktop.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?=E7=BA=B3=E8=A5=BF=E5=A6=B2=20=C2=B7=20Nahida?= <me@nahida.im>
Subject: [PATCH v2] drm/panic: allow overriding panic QR code URL
Date: Sat,  3 Oct 2026 06:20:21 +0800
Message-ID: <20261002222021.149450-1-me@nahida.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002203140.121165-1-me@nahida.im>
References: <20261002203140.121165-1-me@nahida.im>
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
v2:
- Grow the formatted URL buffer to accommodate the maximum 255-byte
  runtime base URL.
- Reject unexpectedly truncated formatted URLs.
- Test the maximum-length runtime URL.

v1: https://lore.kernel.org/r/20261002203140.121165-1-me@nahida.im

Tested on x86_64:
- Full modular build with DRM=m and DRM_KMS_HELPER=m.
- QEMU/virtio-gpu runtime override with a non-empty Kconfig default URL.
- QEMU/virtio-gpu runtime fallback to the Kconfig default URL.
- QEMU/virtio-gpu runtime override with an empty Kconfig default URL.
- QEMU/virtio-gpu raw kmsg QR fallback with no configured URL.
- QEMU/virtio-gpu runtime override with a 255-byte base URL.

 drivers/gpu/drm/Kconfig              |  9 +++++----
 drivers/gpu/drm/drm_panic.c          |  9 +++++++++
 drivers/gpu/drm/drm_panic_helper.c   | 17 +++++++++++------
 drivers/gpu/drm/drm_panic_internal.h |  4 ++++
 4 files changed, 29 insertions(+), 10 deletions(-)

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
index 8913c3d22..b0ea0b4e8 100644
--- a/drivers/gpu/drm/drm_panic_helper.c
+++ b/drivers/gpu/drm/drm_panic_helper.c
@@ -609,17 +609,20 @@ static void drm_panic_helper_qr_exit(void)
 	stream.workspace = NULL;
 }
 
-static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_version)
+static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_version,
+					    const char *qr_url)
 {
 	struct kmsg_dump_iter iter;
-	char url[256];
+	char url[512];
 	size_t kmsg_len, max_kmsg_size;
 	char *kmsg;
 	int max_qr_data_size, url_len;
 
 	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
-			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
-			   utsname()->machine, utsname()->release);
+			   qr_url, utsname()->machine, utsname()->release);
+
+	if (url_len >= (int)sizeof(url))
+		return -E2BIG;
 
 	max_qr_data_size = drm_panic_helper_qr_max_data_size(qr_version, url_len);
 	max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFER1_SIZE);
@@ -686,8 +689,10 @@ static int drm_panic_helper_get_qr_code_raw(u8 **qr_image, unsigned int qr_versi
 
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

