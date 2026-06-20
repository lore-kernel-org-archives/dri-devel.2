Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76657CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5ADB10E276;
	Sat, 20 Jun 2026 19:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ew2OekyL";
	dkim-atps=neutral
Received: from smtp.smtpout.orange.fr (smtp-80.smtpout.orange.fr
 [80.12.242.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775C510E276;
 Sat, 20 Jun 2026 19:03:51 +0000 (UTC)
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
 by smtp.orange.fr with ESMTPSA
 id b0yqwzd9alGVGb0yqw9nCW; Sat, 20 Jun 2026 21:03:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1781982229;
 bh=Tnzf/9MYbLhRoMLq6dvHjdTcKxmYKFVyOTlXu1yZe5k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=Ew2OekyL8uTsQBxLeGyJ/LlvqL1cjFH8Bow26ldviiQkX9Q/ZNjmn07ByMPeELrTT
 UsCIdcryBYHQBcS0LwgFgaNwybqnw9aMrMvW98+GLVP0SbSWqG3csVG/QMiT48Bf8+
 E5hJHgcYSufOO9UoOUgB9saZhP3165/TSEOhavNJzRX3o+/cQ4CSH8lOPbAXiXT7de
 w8weFMji3UvE4PxqFZsxfZrpKuMuDLboveiAzElEUzH8vuntXjAXDXg/jsRlZxewK5
 U3K0/L/g8V29TtU0QLVt3F40H5qaRTvG5mXVt4mkotb3FauiMePD+EkSx/xYQBQxM3
 EDzzek7axzvbw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jun 2026 21:03:49 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Xiaogang Chen <xiaogang.chen@amd.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drm/amdkfd: Fix an error handling path in
 amdgpu_amdkfd_get_dmabuf_info()
Date: Sat, 20 Jun 2026 21:03:45 +0200
Message-ID: <44cbc1d12fc00121d40ce793074bc5e1d497c932.1781982199.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
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

If the memory allocation fails, the reference on 'dma_buf' still needs to
be released, as already done in the other error handling path.

Fixes: f54ce9e8cbd3 ("drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c693c508df1a..e1afdad07c43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -603,8 +603,10 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 		if (*metadata_size <= buffer_size) {
 			*metadata_buffer = kzalloc(*metadata_size, GFP_KERNEL);
 
-			if (!*metadata_buffer)
-				return -ENOMEM;
+			if (!*metadata_buffer) {
+				r = -ENOMEM;
+				goto out_put;
+			}
 
 			r = amdgpu_bo_get_metadata(bo, *metadata_buffer, *metadata_size,
 						   NULL, &metadata_flags);
-- 
2.54.0

