Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C19106F314
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFE210EA5F;
	Thu, 26 Mar 2026 09:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqypSFDr";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0380010E9E8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:43:21 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c757a9251faso360426a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774518200; x=1775123000;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKCyFU3ic+mjTuSY0uUxaZ2dkgAoaG2cSvjjvcWGNkc=;
 b=bqypSFDrpudo44Kec9jPBPMv8/Xv80b4B/t+o9yT78Nxy4acb+UR/ojcAFy0odVjz/
 0QAvtZ2dWYcgagtbaRjDev9h4UB1fOWhfNqSOZ7HCDfATl4BKB/ChiVCIeh+uRBrToJU
 yGW99eQ9imEnDuDCsKjHxtvFTM2Dsw+YFtCxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774518200; x=1775123000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKCyFU3ic+mjTuSY0uUxaZ2dkgAoaG2cSvjjvcWGNkc=;
 b=CPce8QC1dIjs8O/Nk4MN2fw473NQ6ex56kWNl7vRFjc5mqs7gGs8ltI1YMCqmKqIK2
 T0XH0kdO07JU3FJFsVQ71ExwOHagM8M78fX3C3QqsjzmuXi/YHQoZvt2Eot64SDJ4pA6
 3CV2Vkg/dQDJyPeKxshPkoPB8oL+hw5AYEvo4FFnpxUa2Y6v6m2aN+Ik0HlvFZye+pN5
 18V/x55FE+Guftr4gu+/wva69FI7iE3v0JqgTdsVf5TdAOgLwdzM8Lhs+fsemJFB6QMy
 oodFSb6hOghd98Iu7tYb9bDFgWhZabosFKyx4ziJuYFeh2kSfRS1VztB+LMLY2qnlwiO
 YOzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Pcr4fUA9gB/CRlERyXl5hSjXIKl33bHhoZ5+6RWOTPm0W3/7564ZZqv6Wf6dTrTQbL/4AU2fJ38=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoMY/KGjmM/YvBkCjBQDYXQ3mCR6UbKrhegrwk6uCjJR+wFaGY
 IDbN/vn6Js+EzW3zI/Y9ilUlWMcIIzyw+L66NghijACjxR2PmVVf8aBoQtqLN8v1Dw==
X-Gm-Gg: ATEYQzx8eOkNyV1VaJHLtFyrXwoM/swgYIBOlKUbxsObgB8HfYECt3kyfMYwTjIpx4a
 Yop5xNJEdOzp0nBau5ZI4lmksvK+RnmSDME80sud6Ya1dv/KidBMUac1wAlEZTdPKPX6MrgBF8w
 wB9hf3V3scLw3qx/4Pj7puo9CgOftDHp0St2Q1wlnP495B8qR7N44d9nvt8eTWgJHzXs5cI6UMB
 Opp3lPR3omACfid+7Jw2UwfWutmUYESWY1o/YagNHMlPS0/3f9hUGjVHxIgxgoMl+LQBmr0M4ay
 aBPE5riJBlyxTsZZvg1WtbuVsrdsYQRNSEHbNveYBx5XO9JvqkKdSCqAL989xGrVcGsZ0LKv69D
 nSE9DwxL48FC5irLYO2hUkjftSAtTE+c97ZNr3Q8KDOsqxMrni9arEF+EYA6l5B0BcG2tSzgIaA
 cnEh+2kU5iBRU5yHJPpPg9q9x3jbATj2NzFyJiAz1YhwnUKa6L9xsEA+cqRzKSBH23tWHMHXavj
 G1kDTbj716GvRNWPHo=
X-Received: by 2002:a05:6a20:7491:b0:398:9379:d056 with SMTP id
 adf61e73a8af0-39c4abeac6amr7815749637.16.1774518200463; 
 Thu, 26 Mar 2026 02:43:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76737f28fasm1673312a12.7.2026.03.26.02.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:43:20 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/exynos: Internalize exynos_drm_gem_free_object()
Date: Thu, 26 Mar 2026 17:43:03 +0800
Message-ID: <20260326094308.1161335-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326094308.1161335-1-wenst@chromium.org>
References: <20260326094308.1161335-1-wenst@chromium.org>
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

exynos_drm_gem_free_object() is only provided as a callback for GEM
objects. It does not need to be exposed to the rest of the driver.

Move it above where it is used and internalize it to just the GEM
functions.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 10 +++++-----
 drivers/gpu/drm/exynos/exynos_drm_gem.h |  3 ---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 69ef6cda1ce9..59fd736a1fb9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -133,6 +133,11 @@ void exynos_drm_gem_destroy(struct exynos_drm_gem *exynos_gem)
 	kfree(exynos_gem);
 }
 
+static void exynos_drm_gem_free_object(struct drm_gem_object *obj)
+{
+	exynos_drm_gem_destroy(to_exynos_gem(obj));
+}
+
 static const struct vm_operations_struct exynos_drm_gem_vm_ops = {
 	.open = drm_gem_vm_open,
 	.close = drm_gem_vm_close,
@@ -318,11 +323,6 @@ int exynos_drm_gem_get_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
-void exynos_drm_gem_free_object(struct drm_gem_object *obj)
-{
-	exynos_drm_gem_destroy(to_exynos_gem(obj));
-}
-
 int exynos_drm_gem_dumb_create(struct drm_file *file_priv,
 			       struct drm_device *dev,
 			       struct drm_mode_create_dumb *args)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
index 79d7e1a87419..8b5bd20ae8c1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
@@ -88,9 +88,6 @@ static inline void exynos_drm_gem_put(struct exynos_drm_gem *exynos_gem)
 int exynos_drm_gem_get_ioctl(struct drm_device *dev, void *data,
 				      struct drm_file *file_priv);
 
-/* free gem object. */
-void exynos_drm_gem_free_object(struct drm_gem_object *obj);
-
 /* create memory region for drm framebuffer. */
 int exynos_drm_gem_dumb_create(struct drm_file *file_priv,
 			       struct drm_device *dev,
-- 
2.53.0.1018.g2bb0e51243-goog

