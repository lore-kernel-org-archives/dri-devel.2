Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867AFF33805
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE60B10E327;
	Tue, 17 Mar 2026 06:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ktD7zVr7";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6676810E327
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:41:25 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso3746610a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773729685; x=1774334485;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvknyLemjW45Ap19tt73jCMr/JsVlCyt3yofdVpnnZw=;
 b=ktD7zVr7OCqdW97KNUhJ/rpGPQd/x6kU1k1TGPbroxw+vss54LkmCs/zTAPuWln8t7
 LgFNkMyFk4p4C/H9DTn42EiKvT3Q/n+WOf5NPeHy7sFPpE1/DD1oqinB4ktKzyGpJmS+
 GnqK892k4pwgSVvZx9Y0a7lXm7RWGNwHcEQsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773729685; x=1774334485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvknyLemjW45Ap19tt73jCMr/JsVlCyt3yofdVpnnZw=;
 b=tKhzGld5oL71UZsvHbXDhHsBWHSDPxZAa4ZqAFZd0Jcmdq/u/vytw6GvAKdtplrciD
 Fm0ZoMk3XjvY/klcdPufl9HfUzqWVDZu2273wQ5f10kqEjljwunhYDjKT7iSUWTSc3lb
 cdr0lPURhYEK3Qi/FSJUBglr4XbuQ8Agte99qdEwCQKWZCNHhEuYe7Ja3UECZTvNhvZz
 wpLBHL3ZVkqD6iCR8SRw4OIOT9mSMzQxzurz58Y9T+1Q3uy7VZ6IiHAIprS1wm6QBcdd
 C6SVO+jyCDkS7Padq0nW14fo67QH1nZ/mK94Ruzh+0QUjM5ENMb4EVcztb96Yo0EBuGD
 bcwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZiAijaXaxxTco4wZ8sBAWHiu7zYqCmEWsAM1/Hr+fYX8uIzkxwQg2OH5RrTc8F82kJronfO5yhEQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDP4MEdi5upOu3cNQ41vAZalKBUDjAkBVplWM7gDaztR4HmKos
 Z9XgHPtPTxzsEiwbuyQkA09TvA9FYnyo6YSaqthOscrnq4nvrvChj78iWSCaL4afTw==
X-Gm-Gg: ATEYQzxY62uNaMu5CMUkiU9O3fY7H/VjguO+xxhkApc8q77rF73u5cAddkfYWU8DiYn
 j3/6Mq5pEgJPCp/vwR7G445FZ/RQSUXbRbonD2P6UQWMtdTAU7NqmMixwih0cJUxDZAm0OFOhNC
 M5/n2ooNjsrbTKpredtWeNNb8KrDHWfgYaQJrHjAJBtv/jFbXewvlLxs8WfTtXvMsyUZ789hie6
 c9szUP6ORH15Nf4AgnRil3ltgYoVpcOnzMWs6nHhYjq9cxevr7WtFrsx0rzh+lkEkaGhPL08yZT
 2x/McKnRBEYp7E3kSmSYoBNQ3RvzzWa5YOX2bjKEO2DNZ4c//9zgYuAF3j4oeKFXALCWawbC8dN
 yXOw0W4XLdcFo1oHhgEn9uaTqq1JIiG5eB7l5Bh1VOZGoK7puH5YdriEOjAd+X3lKkwT0hYUTIL
 zhblNCmKwKWAn3De4ZOj7+21gDhrX4cOt4b5hUbfxd1QwooGO9IwKG7eCxRGbPbpO+dxHNeCt6o
 N5I+s0W
X-Received: by 2002:a17:903:2a90:b0:2ae:5628:a18a with SMTP id
 d9443c01a7336-2aeca940e72mr180774555ad.2.1773729684962; 
 Mon, 16 Mar 2026 23:41:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:a064:c65d:a199:5cb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece605231sm124269425ad.27.2026.03.16.23.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 23:41:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 2/4] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
Date: Tue, 17 Mar 2026 14:40:44 +0800
Message-ID: <20260317064049.696795-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260317064049.696795-1-wenst@chromium.org>
References: <20260317064049.696795-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Rob Herring <robh@kernel.org>

Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
drm_mode_create_dumb. This flag is for internal kernel use to indicate
if dumb buffer allocation needs a kernel mapping. This is needed only for
CMA where creating a kernel mapping or not has to be decided at allocation
time because creating a mapping on demand (with vmap()) is not guaranteed
to work. Several drivers are using CMA, but not the CMA helpers because
they distinguish between kernel and userspace allocations to create a
kernel mapping or not.

Update the callers of drm_mode_dumb_create() to set
drm_mode_dumb_create.flags to appropriate defaults. Currently, flags can
be set to anything by userspace, but is unused within the kernel. Let's
force flags to zero (no kernel mapping) for userspace callers by default.
For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
can override this as needed.

Signed-off-by: Rob Herring <robh@kernel.org>
[wenst@chromium.org: Emit warning if args->flags is not zero]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Emit warning if args->flags is not zero
---
 drivers/gpu/drm/drm_client.c       | 1 +
 drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
 include/uapi/drm/drm_mode.h        | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 46c465bce98c..1a57e7eadc0f 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -404,6 +404,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev *client, u32 width, u32 heig
 	dumb_args.width = width;
 	dumb_args.height = height;
 	dumb_args.bpp = drm_format_info_bpp(info, 0);
+	dumb_args.flags = DRM_MODE_DUMB_KERNEL_MAP;
 	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index e2b62e5fb891..ccdcc401d4dc 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *dev,
 	struct drm_mode_create_dumb *args = data;
 	int err;
 
+	if (args->flags)
+		drm_warn(dev, "drm_mode_create_dumb.flags is not zero.\n");
+	args->flags = 0;
+
 	err = drm_mode_create_dumb(dev, args, file_priv);
 	if (err) {
 		args->handle = 0;
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 3693d82b5279..7d5f50e4af70 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1272,6 +1272,8 @@ struct drm_mode_create_dumb {
 	__u64 size;
 };
 
+#define DRM_MODE_DUMB_KERNEL_MAP	(1<<0)	/* For internal kernel use */
+
 /* set up for mmap of a dumb scanout buffer */
 struct drm_mode_map_dumb {
 	/** Handle for the object being mapped. */
-- 
2.53.0.851.ga537e3e6e9-goog

