Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F54DC9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E3010E617;
	Sun, 27 Sep 2026 14:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JA0eYk+i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B13410E617;
 Sun, 27 Sep 2026 14:56:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8387E43740;
 Sun, 27 Sep 2026 14:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F5F1F000FF;
 Sun, 27 Sep 2026 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790520971;
 bh=Ewo/kFhfNF9BUM9+V8oV0ndAio75zzFZWkSpzJ/6QFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JA0eYk+icdXbhoC+ApA3bVeLwziBW0BHyQlLJ6143opdiBvujXIYGQpLW4IER7Zc1
 Y2U2jUjj4CXZCrfKzhltklUF43dkaYe8nSBhOz5ZHsWUDdy2+TgMA4hAKnlZKUHnfa
 lRY19NIiMIdg94oPVpaYm1k0XqyoMTyQNTvN6YEKgkw6meAOCN7XFgN0ud9GoyMa8t
 I8CGa3uh82SUi3hVqV2tsqNCGjF9O/xCjywAmEj51p4GXqfA8/LToN4lHCHmfDNYsk
 Hwt06RYisTcjRr8U7awX4jbblleX74vF9T5jI2TWd1Ps65hDkbzfwz4Xzc/xNXdZNv
 uID1lemqulIqg==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/radeon: Read the VRAM VBIOS signature with readb()
Date: Sun, 27 Sep 2026 16:55:04 +0200
Message-ID: <20260927145505.16883-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927145505.16883-1-kaloz@kernel.org>
References: <20260927145505.16883-1-kaloz@kernel.org>
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

igp_read_bios_from_vram() checked bios[0]/bios[1] with a plain
__iomem load, which faults on sparc64 before the copy runs at all.
radeon_read_bios() already reads its two signature bytes with
readb() ahead of its own copy; use the same accessor here, keeping
the check before the allocation.

Fixes: b442962a9e82 ("drm/radeon/kms: add support for "Surround View"")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Changes in v2:
- Read the signature with readb() before the allocation instead of
  checking the RAM copy, as radeon_read_bios() does.

 drivers/gpu/drm/radeon/radeon_bios.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 8595f4c6e2e5..1da6bf1c17ff 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -49,6 +49,7 @@
 static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 {
 	uint8_t __iomem *bios;
+	uint8_t val1, val2;
 	resource_size_t vram_base;
 	resource_size_t size = 256 * 1024; /* ??? */
 
@@ -63,7 +64,10 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
+	val1 = readb(&bios[0]);
+	val2 = readb(&bios[1]);
+
+	if (size == 0 || val1 != 0x55 || val2 != 0xaa) {
 		iounmap(bios);
 		return false;
 	}
-- 
2.47.3

