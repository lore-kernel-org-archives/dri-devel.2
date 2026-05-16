Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032CCD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DD410E492;
	Sat, 16 May 2026 11:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sTxnAB0A";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CC910E46A
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:53 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso4615765e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929612; x=1779534412; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfXCZmKhXGPb19F0Jw5wedNIT6lbmZvd88iLNzyg/OY=;
 b=sTxnAB0A2Xr1HJe0yebh3vCuYMygYewexgxpyH5VN5qJpaYMy6bWoZ2k+dIXZcoTVB
 EgFVQV0mH10REBR7BSBZHFR8A5L6FeqAIpeHaNHCjOWe374Q3MFvf933qH6q7pgylm4L
 8HXoVkFLjshJlKi3uF0MZ4IXQYLrPdJWK2ha7x3uoGP1KOmKOIaXdVnzvoPpmUimLnlW
 GrkgBKohpgq44vyJt126h/Juu/JB6m1xmxxSZo2l4fuhESFD+vm6G869cR2EC6NejPmY
 Z7e9oj+oTVofCsxXrdk/+fFHzMT0qLZZPKDeQsIy1Mn7gV9Z2c4I4fYYI3o2RL8FQN55
 Fz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929612; x=1779534412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lfXCZmKhXGPb19F0Jw5wedNIT6lbmZvd88iLNzyg/OY=;
 b=Csb0lAC1T2Jcy8P5sCe4pnMhjGQrfKJLeC1Q83soVkyHKoHtBMLNxS5mI0ET3CGzJy
 LdolDMem/+IygiqjqxmFkPJ6yWhUiGdyrr24PsyEvHHAknYXfmcrZ5sg3a5C9nBoGrE3
 tBZe9ZhpTch43y+PDcy/TSKpm2chDGfO/omi4PR/xcrNcabmV+BKWtTryHnM3cHEE4l5
 Hw/5qplgqQIFoa0ohIRRWFSk7aVymk6pI13ZpQB4gRnYvEtjJ5PEBn+gJ0ch0V1O7VhQ
 eBQT0yB9k9xJ4czXnR6ywPpQ6/X1VtdstXulpyiRHNvBmiyyXoDy5xfQzEbZFplLVyo4
 /0Qg==
X-Gm-Message-State: AOJu0Yzb6oXDylB95YCPn8qm3YEL0J1rk6GWy6HcleSfmoyCiigZ3q5K
 dwcGqnbddMaM02l2g4GlS5xAG5MGWVfMWQxdHpaHSKEVk9j8Ya7PjsWK
X-Gm-Gg: Acq92OEQ4Ax0lMDZ2w6Lug8H7FfE/YnslRZK66eUCvPftELXlny5wr+7uHzyk8fS1As
 5gfDBfvBpur+lbeg2YH7KaeWOpMFadTtvksQdbXFc+YhfQyfYY76jvxOIsJDQYhwOwOYH9t2FRc
 y29KPgdF/bPhngxXprN52Iy317ZBWzs+uxXD1MvHT5CY9mEMF74l1A2mtis/67gR+VVH7kebLEq
 Y4JjpkhxpfWakexrQmq2mSdTgDUGaidnDXtVNlJSlCVQpHgKS6d4+lx7pTU5tMdbCuJ6r/GxWR9
 VJy9fv9A6lQbAeq1rPhgncrPeEFBDPMz80BJhK4NFuGAMOaJ0WqArLlOJgUD5Vg0XeNn3ATr/R2
 U2pyLv1BNmq+oi+EX5cBiqziETM+ZJrfwVnV+G4JPRhu2OWu35nWzktgeRGcPANTqBW1hk4wl7g
 4jVisVRE9fKLB31RmK8AsEQ1w7UpX8mJuwAoI0FocjYIxwRzlqBt8kulbD+OpdsNCOUBR9OGfPL
 u48WtE=
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48fe60ed839mr106842125e9.11.1778929612138; 
 Sat, 16 May 2026 04:06:52 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:51 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:09 +0200
Subject: [PATCH 06/12] drm/syncobj: add drm_syncobj_transfer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-6-88ede9d98a81@gmail.com>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
In-Reply-To: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=2747;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=crfpaYowwqJxJnvwODKb3NMb9L0ciSXP5LaWzS0yZzY=;
 b=4LnJkSRcgHTRmc5hqP/RVVAq8z7NN5hqbrYXKUhKI6Ju4If09ezCwoSL5J4pmggyrT/r6k6gL
 MSWHYqto26NBUeuZWgCz0Yq5OF0t6VAVcTQcC9DTxb9GREciFiuCzd0
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

This makes the logic from drm_syncobj_transfer_ioctl available to
callers that already have two drm_syncobj.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 36 +++++++++++++++++++++++++++++-------
 include/drm/drm_syncobj.h     |  3 +++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index a746e787882d..8ccfbd972191 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1031,13 +1031,9 @@ drm_syncobj_transfer_ioctl(struct drm_device *dev, void *data,
 		goto err_dst;
 	}
 
-	if (args->dst_point)
-		ret = drm_syncobj_transfer_to_timeline(src, args->src_point,
-						       dst, args->dst_point,
-						       args->flags);
-	else
-		ret = drm_syncobj_transfer_to_binary(src, args->src_point,
-						     dst, args->flags);
+	ret = drm_syncobj_transfer(src, args->src_point,
+				   dst, args->dst_point,
+				   args->flags);
 
 	drm_syncobj_put(dst);
 err_dst:
@@ -1046,6 +1042,32 @@ drm_syncobj_transfer_ioctl(struct drm_device *dev, void *data,
 	return ret;
 }
 
+/**
+ * drm_syncobj_transfer - transfer a fence between syncobjs
+ * @src: source syncobj
+ * @src_point: source point
+ * @dst: destination syncobj
+ * @dst_point: destination point
+ * @flags: DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT or 0
+ *
+ * Copies the fence at @src_point in @src to @dst_point in @dst.
+ *
+ * Returns 0 on success or a negative error value on failure.
+ */
+int drm_syncobj_transfer(struct drm_syncobj *src, u64 src_point,
+			 struct drm_syncobj *dst, u64 dst_point,
+			 u32 flags)
+{
+	if (dst_point)
+		return drm_syncobj_transfer_to_timeline(src, src_point,
+							dst, dst_point,
+							flags);
+	else
+		return drm_syncobj_transfer_to_binary(src, src_point,
+						      dst, flags);
+}
+EXPORT_SYMBOL(drm_syncobj_transfer);
+
 static void syncobj_wait_fence_func(struct dma_fence *fence,
 				    struct dma_fence_cb *cb)
 {
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 85e7ca7f7896..ec8042d61466 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -136,6 +136,9 @@ signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 					   ktime_t *deadline);
 int drm_syncobj_register_eventfd(struct drm_syncobj *syncobj,
 				 int ev_fd, u64 point, u32 flags);
+int drm_syncobj_transfer(struct drm_syncobj *src, u64 src_point,
+			 struct drm_syncobj *dst, u64 dst_point,
+			 u32 flags);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

