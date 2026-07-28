Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F6EC54F55
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D0910E971;
	Tue, 28 Jul 2026 16:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UbTQMuMu";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5644410E904
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:35:24 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso47867675e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785245723; x=1785850523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWKFfRMOGev4kY9jS3nRnQFe62NXbyE1RAtN86oZDL8=;
 b=UbTQMuMu1mGVqoUI1OlFWxeZXEwYfanZf8gSR6CjG2FuaJNlD7f8KSY3cmUGfOxkER
 wFfLws6hWSNJOssjAF6Ru7l0rCEsmGZAITblEdEWeMtumiJh0PmxxdS8vsTUiI1Wv20T
 ouGv4thzZPVFlqooosiS1aAxACyRl+BNGookkw+a4q8zSo3C4Qd4xsig/nWvZhyBrn1r
 khwBijt9HbOyEKKQKcc7UX8zNtBsA+Qti+LSr0gyF4DCDXljVCy36CvnNjJNvMigATHW
 A9Xab42t9j7go7cXr8/DSJKP7yXEOGyQbmkDbGs14Vu6JEHk89BQYJCyuJ7Z5CYWG+IH
 MhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245723; x=1785850523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWKFfRMOGev4kY9jS3nRnQFe62NXbyE1RAtN86oZDL8=;
 b=NUMPUC7w6gojj641Zk07YCpqKauIBGvlTUFrV+hP5MS0YPO34fDCw7v/nTbhA1oo7E
 nIguPWM37eTAbHmqqCN29HFr3jSwaRJWR2yQVlHqwxIR22F5RC9O9aywsiLDr+zKS8CP
 9ANHbz+gzUyguRKwCrLPOs9bIzkQFSUWQzwNrqPb+V8hA9u0qVtCATnWRnEEe1k2aqyP
 NJHWBsXEV7mcSCg0bvQQr9g1xj7LdWHJUkhoT/8hR/M4KT7axhIXuI1Jupe5Zl7uKlWh
 +qYkvGRa0B93wDpmM70PCa1ZLyTmQgMEGz/jzIciGcOCuweERAvathxcoBuM2xzH/vNy
 UnlA==
X-Gm-Message-State: AOJu0Yyf5fYLZNkgtDyYnxrDtknfAF1omlfY03AWgP/qohNcGhY2UcDW
 sXtZo27IDXQknrip07yngNf7NjOK7ilUVl5Ps3t7EbuMJoCp5WzNM5U0dfzdf7hDs/8=
X-Gm-Gg: AR+sD10Ajc33dylYQXeUQhrv25IT1CL9ZAG7eXc7zqXs0rqgcuOarC19NJ5l9KqKjNd
 8rhHCH4VljkuClbfJPYYJXh/OW6skI6OrfkL/dCHyTwAtNfo3ujFLJsNXKx+luu9VQBR1ZQ8xIW
 jfaNeH7D4pZipA9NgoyOZyFDQp5ZptaVlwIaICzi+xqI1mzdLz7BB2G9HZX7639LK+cTa5bBfpa
 VTZzy3/NNqOzmqTD34Vanxth0q1+1eKHeKMd/VGCberEHXQfbll9Qtf2NfRZbTzO2RilyIk9WE6
 k5ZkZcHqhVb7DFKCSCYX5pN++k03IXEml4rc2ygf1hAK1Xrke/Re7AIMXwEZwA6YzPMZa+2+5JY
 I+v/WHDvLYtNY3DsyZQO12ayfOVK6w26Jmx6y3zJEcTo81sHtlkX2nRf8l9BZOhweNnE0K56X
X-Received: by 2002:a05:600c:6290:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-496c65986a2mr26079295e9.37.1785245722321; 
 Tue, 28 Jul 2026 06:35:22 -0700 (PDT)
Received: from pop-os ([86.120.213.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c46240c4sm78616675e9.12.2026.07.28.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:35:21 -0700 (PDT)
From: Baba Dan Constantin <babadany2999@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Baba Dan Constantin <babadany2999@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/doc: Add kernel-doc for struct drm_mode_card_res
Date: Tue, 28 Jul 2026 16:35:10 +0300
Message-ID: <20260728133511.115212-1-babadany2999@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 16:11:15 +0000
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

Add missing kernel-doc documentation for struct drm_mode_card_res
used by the DRM_IOCTL_MODE_GETRESOURCES ioctl.

Signed-off-by: Baba Dan Constantin <babadany2999@gmail.com>
---
 include/uapi/drm/drm_mode.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 381a3e857d4e..5db85b559bf6 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -249,18 +249,54 @@ struct drm_mode_modeinfo {
 	char name[DRM_DISPLAY_MODE_LEN];
 };
 
+/**
+ * struct drm_mode_card_res - Get GPU card resources metadata.
+ *
+ * User-space can perform a GETRESOURCES ioctl to retrieve information about a
+ * GPU card. User-space is expected to retrieve framebuffers, CRTC objects,
+ * connectors and encoders by performing this ioctl at least twice: the first
+ * time to retrieve the number of elements, the second time to retrieve the
+ * elements themselves.
+ *
+ * To retrieve the number of elements, set @count_fbs, @count_crtcs,
+ * @count_connectors and @count_encoders to 0.
+ *
+ * To retrieve the elements, allocate arrays for @fb_id_ptr, @crtc_id_ptr,
+ * @connector_id_ptr and @encoder_id_ptr to their capacity.
+ *
+ * Performing the ioctl only twice may be racy: the number of elements may have
+ * changed with a hotplug event in-between the two ioctls. User-space is expected
+ * to retry the last ioctl until the number of elements stabilizes.
+ *
+ * Unlike GETCONNECTOR, GETRESOURCES will fill arrays up to the provided count
+ * capacity, even if the actual element count has increased.
+ */
 struct drm_mode_card_res {
+	/** @fb_id_ptr: Pointer to ``__u32`` array of framebuffer IDs. */
 	__u64 fb_id_ptr;
+	/** @crtc_id_ptr: Pointer to ``__u32`` array of CRTC IDs.  */
 	__u64 crtc_id_ptr;
+	/** @connector_id_ptr: Pointer to ``__u32`` array of connector IDs. */
 	__u64 connector_id_ptr;
+	/** @encoder_id_ptr: Pointer to ``__u32`` array of encoder IDs. */
 	__u64 encoder_id_ptr;
+
+	/** @count_fbs: Number of framebuffers. */
 	__u32 count_fbs;
+	/** @count_crtcs: Number of CRTCs. */
 	__u32 count_crtcs;
+	/** @count_connectors: Number of connectors. */
 	__u32 count_connectors;
+	/** @count_encoders: Number of encoders. */
 	__u32 count_encoders;
+
+	/** @min_width: Minimum framebuffer width supported by this GPU card. */
 	__u32 min_width;
+	/** @max_width: Maximum framebuffer width supported by this GPU card. */
 	__u32 max_width;
+	/** @min_height: Minimum framebuffer height supported by this GPU card. */
 	__u32 min_height;
+	/** @max_height: Maximum framebuffer height supported by this GPU card. */
 	__u32 max_height;
 };
 
-- 
2.54.0

