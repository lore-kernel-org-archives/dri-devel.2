Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2FAF8A16F
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290CA10E1E1;
	Thu, 16 Apr 2026 13:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="O8rAVMAS";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543D710E1E1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:11:03 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-6729caff479so310266a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776345062; x=1776949862;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D7qXRwsXJvN8ufnn9njyPtO9j+lMCL1yKcL7xg6ZmLM=;
 b=O8rAVMASwyrmShgWYq05LfFABl+zIXGgtTiDBXv1KMKTvWmgtaO1lLI/dxe4Qj+Qyb
 q86aRcPWUdlKb9fiUycPvFlkTYBUlRdoXqQPc74Izpe7Ha0nSivbM7CvvPrcWoLlPeyU
 +OQf65rGY1bzp+wN8efa/aN7s87H0aRKGix47xk3IEHb51VIgU8RakRRg6CURYhLojGw
 ttFAURJZcjEqKFh84qgPj0SWtps1PVVs53O18kre96ETI++XV+DMatKqalFpIR4VFgd1
 LhEn0YgcknvOBbc4lBtYH4+A8Ruegj5GGyUVLy/+h+ItSFCKEp7iwreYr7wXilo8QXRP
 UuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776345062; x=1776949862;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D7qXRwsXJvN8ufnn9njyPtO9j+lMCL1yKcL7xg6ZmLM=;
 b=oAI6j9TvT1gxocqdKB0hFyMQqr9KbIdyTf6SJVPOQGO4nDXD+/WA1FXDOHzrohsLOd
 o5WQSFAorYTN4RCPFj3qOvkElxGtz0fpLW8RwBKqxMTzQ8yLezhHyv+o+nCez8IIvlAR
 JD6gH9kONRtfW+6OmWz+y/uInTY2D9RP5IpaEkl7Ed+jI8lOCm2NNsCPd4vGRHADDd/H
 XFht+WPO6yAXS+n6sd2UdltAEDIlc6rbFD5j4dXYaPgECIANTbmXkWFpZsLgZOsnR7Go
 zQkHy/8ntGIVT6j/o667ZY4IpE5Ntm99AFKnqAuiYACuNWOWvhPEXwPrFKXCybNYm2eH
 R0Dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q0IggD5pz6fwr9p9ud9lGfMX0MfjrWZ54zikCbsAvrwKMQmIMqUL4rmYO2H4iYVO/7rxMqQ8zkzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd0hLv129/ZYlAOq0RfjC0wDlL7EeMasX3uHOq/U4nfstx97ig
 zR24+wav4Hvk0ya44LRcl6vUa7bAimPbyVkrKtzttHaSArxQstUXTz1CB4WqGiKLkZ2dqO6LEIC
 R/NeFwUdVLH8fEuchYA==
X-Received: from edt22.prod.google.com ([2002:a05:6402:4556:b0:671:8f2d:68d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4510:b0:672:4262:3cdd with SMTP id
 4fb4d7f45d1cf-67242623df1mr3231133a12.12.1776345061359; 
 Thu, 16 Apr 2026 06:11:01 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:10:54 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN3f4GkC/x2MywqAIBAAf0X23II9yX4lOpRutodKtCSQ/j3pM
 Ic5zCQI5JkCDCKBp8iBzyNLWQjQ23xYQjbZoZJVJ5uyQ+vuuKPxGYpo6cLWkOmVrtWy1JA752n
 l53+O0/t+B3D3v2MAAAA=
X-Change-Id: 20260416-gpuvm-drm-dev-get-5ded89c39bb3
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=+dm7UyoEuSxHlCr4Mbc3ZnFCws67YLpeI9cD1NZKHqk=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp4N/fbYNbhw/XMUDetKMqTT1tjMYbJ1AH8eui/
 A5xEHBy5nCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaeDf3wAKCRAEWL7uWMY5
 Rhj1EACGEo+zGQ8Yg6kj1/JEI1PrXF0W/R54VbbHRzBUPHtfQ8idvnLilchvFlSP81seiSXasnl
 UiPzfmvMBQ2bkrFoHBupqI6SGFnHXJAf3wbRu2NolrzAt+GWDo5y/4a7cFzgEz1/PuzsWY+mDrC
 JWbdecJMBwGciemxRuP/7MEo1ZXeZzd9Z2WfpbJ4dsWx/jsVTdsqdRG7TZ0nQLrrdcSdAa7vdhG
 hEEi0iPZm8/7I1bmcKY0uGtGKWs4u/XiToOAgHkQm0WfFtERK7GQ8KGRBz2bXG5zkx9UUAezGOD
 00jE66lSEp25xmpHvULZAMsG+sBF7DK2r7lLOQvjFWIe5nhGszO+kAQAT5wCwDqmfNiQmQqWmSw
 +qfvtRDjfjXzEutCfgxfjAZ/uONNGovkXrlfYsOzYZ0KDdEx+HPEYewaZ4W5MC0o9SedC/uAUM1
 ozqHRpMcCLyOZ21aXPbpwaX0LgyP1PHWOWqE08IHWxBstGVTzZXfx3b/a0SDKzE+uS2LED3EmGL
 OncNyIW18VPeeW5hKYDOCVsc3M6VcGVPbW5mZQF4MllcC7bZTH9+kj67vWY3Knpu5Z5K2JVc1OI
 cFGJzFnIIV53ynQbhdBbShar/rFob4V0DDWWD5Tz6sd6pJfSq4jxRvMh8XkbGAjcR/XZe+F9Yqc
 a1n6UaW8qScGcyA==
X-Mailer: b4 0.14.3
Message-ID: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
Subject: [PATCH] drm/gpuvm: take refcount on DRM device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

Currently GPUVM relies on the owner implicitly holding a refcount to the
drm device, and it does not implicitly take a refcount on the drm
device. This design is error-prone, so take a refcount on the device.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 44acfe4120d2..000e7910a899 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -25,6 +25,7 @@
  *
  */
 
+#include <drm/drm_drv.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_print.h>
 
@@ -1117,6 +1118,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	gpuvm->drm = drm;
 	gpuvm->r_obj = r_obj;
 
+	drm_dev_get(drm);
 	drm_gem_object_get(r_obj);
 
 	drm_gpuvm_warn_check_overflow(gpuvm, start_offset, range);
@@ -1160,13 +1162,15 @@ static void
 drm_gpuvm_free(struct kref *kref)
 {
 	struct drm_gpuvm *gpuvm = container_of(kref, struct drm_gpuvm, kref);
+	struct drm_device *drm = gpuvm->drm;
 
 	drm_gpuvm_fini(gpuvm);
 
-	if (drm_WARN_ON(gpuvm->drm, !gpuvm->ops->vm_free))
+	if (drm_WARN_ON(drm, !gpuvm->ops->vm_free))
 		return;
 
 	gpuvm->ops->vm_free(gpuvm);
+	drm_dev_put(drm);
 }
 
 /**

---
base-commit: 126c50bc2fb6ddfe5b7718de67bbd7592a1062bb
change-id: 20260416-gpuvm-drm-dev-get-5ded89c39bb3

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

