Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DA4C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C0910ED1F;
	Wed, 19 Aug 2026 06:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YudeLNzm";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B971F10E4B0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:33:16 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cbedf318752so3147458a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787052796; x=1787657596; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ErnJauar7zJkf51R9QKk9qiVc4qZQuim79mLl/qt+gE=;
 b=YudeLNzm6FqE7Q58awF6+I03xCL8ojgvlaKpVhjgDFG7k/dKCjwlhzRIU3SN9ceJhe
 ibRQEA9oG5Idi+9tEIhOWD/fQV6bfOpiVYGXPVBDr261LetVv/3LCe2ejjCjE5lkGa7p
 UeuBrEq94n2vQLI3ChP0Dt8c/cvt7QiSLJ434AqsZI8VUj39pPJc0BGDdHC6F/DnoJpS
 FTBQpgkj+4W/2nGvW0CVTHH+9zfZRepCNvN2E9ZjL72gz4YD2sTfPH7B7jF9GqwU0r4z
 RyjimsId5JJEuB7SfHf43W1Bx+Zyxd0396avSJZBKXSMYkE5C2OpnLdmx0HO4NCYxYiw
 SoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787052796; x=1787657596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ErnJauar7zJkf51R9QKk9qiVc4qZQuim79mLl/qt+gE=;
 b=OePCT8bKnfHmpIqtUykyYOCIUzwcTWvV7VyEvjgDRbiiwTVk8Y0NDOO4Nyw+74QYRq
 Zby4SI+sv1v5JSIDCxmwawt5nIkDeZ07OIQT+2OwmSpPsZOzDtgJjS1O8SG3FjsQ5htU
 2C6FX+lX0NCt+wxFqY/RNO29nsUqhY7h/hZeYAxAadl6eB61fEbYFmqz5Kn7KtbbbkXD
 rPIfK1s5ieCDRvvsN82sFK7TyDJtRgG5ADE6r4jSOKWAQ1P2pg9k/qWvW9GsahqYGN1h
 bOVXhyBjyX8LhRo3HfuNiTqjlR22LnA+xrvm9ZC+ionXCP8QR9j3NRGs1Y9FjjyJiuGe
 ZRLw==
X-Gm-Message-State: AOJu0YzJe8NCRpXh6ZRGSWVQZWjFh4ILIHfVKBw45wzHqMutmf4TrGkV
 XoLWFuUK/8bD1pvzAcf2TnwJUB2GlGtGUS0DGHZIMBaP3AqKz2FrMBiOoTsaZuD4Be+U
X-Gm-Gg: AR+sD12jGVitEv8pPHLptJIBE9l2xUhBurN37PId0mu5TkFI6shZ7eHrJd6xYHc+bfn
 uBpB+IQpONNixJiz25dHP5wtZVkDNyHVXilVPbEPiP3Uk6gCMwPA+UY9gG1ppdNo4gFYrbygYx+
 gEey9njpnUEH20/wWYP+0pRVlapiU5fTjST4iV+vNX7GwKlVBq0kIIYEZ3hs/FlG/R9ISSeIUSR
 OXBhz1GWU+QvX84y4NyCvB5e4TFaGY/g3lmPcCOgNub9GEHwBVBcsYThCR3jPSJxVugv6ryVw1e
 J0c2nd4/zlltzMWW5mjg/mHfksYsr9q8ZmELMY6d4+5amTHe0tw54WSzWr0nqDryr1rbo2Qobgz
 0QmfcGorHbTkbxM9A3JqhEu244TAEk9gNi61LgiT1bF32AWtl/oIv1ScQcB29qo6lIjlBXhJN1l
 kpQdXH4Dw3PcQUeq02s7ajzItsc7VQu3v/4tNDBv45L3a4noOnTaczvgtR7/glfLQZ8mESFJFxq
 A1cpQU0wSrHEDyCfR5xuGfuVwioA4AhCGuwZLT/q9YdPf2I4zn0igYu2q2w3nCUNScU
X-Received: by 2002:a05:6a20:72a7:b0:3cc:4f34:3733 with SMTP id
 adf61e73a8af0-3cc71a6804bmr34073028637.10.1787052796166; 
 Tue, 18 Aug 2026 04:33:16 -0700 (PDT)
Received: from
 codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.119]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13c00dbc2sm2036427a12.15.2026.08.18.04.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:33:15 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 airlied@redhat.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/virtio: Fix possible memory allocation failure
Date: Tue, 18 Aug 2026 11:32:56 +0000
Message-ID: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

When kmem_cache_zalloc in virtio_gpu_get_vbuf fails, it will return
an error code. But none of its callers checks this error code, and
a core dump will take place.

Add __GFP_NOFAIL flag when calling kmem_cache_zalloc to make sure
it won't fail

Fixes: 6f3d9d0dd335 ("drm/virtio: Add drm_panic support")
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e5e1af8b8e8a..fdf0f3c2d3b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -93,7 +93,7 @@ virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgdev, int size)
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
+	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC | __GFP_NOFAIL);
 
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
 	vbuf->size = size;
-- 
2.53.0

