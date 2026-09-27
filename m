Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE80C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6650710E4ED;
	Sun, 27 Sep 2026 10:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+f4gLSs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10CE10E477;
 Sun, 27 Sep 2026 10:57:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E07560D7B;
 Sun, 27 Sep 2026 10:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61121F00893;
 Sun, 27 Sep 2026 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790506620;
 bh=o+ilA+uiXo3fEvOMt/RW1tqOfV75NJRUJnmzfGk27BU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I+f4gLSsGPgtaHDq/bsXRsOy/6uaJW0CJ/N532wUt+z2DU2ZUlDARz5+s1/P3ACGs
 f1pVVjkUq5Z5fZDx1YMGHnBSk1t+YsILrD822jJ2t2PdD3d7+3GlKfynJLiSx7+PTs
 /MlfZP5AZQAmckRquaLBi0a7FesVnjK/lUdEvdO5zNBBQ2cXLEUqKOFctaFu8y2TuO
 MmVRpEGc47V+3mJL6ixSR2vvW0QPF7BdMZOdiHUE4F7S9s397qHb+VaDOXTb6AOF/9
 b4Nh/wguDQER1rYEcSLkPU2Hgx4LnQEy8iI1vbeLxG0rqvT+keCU5U0HypKxVJQRby
 gn9w6TYdWVXKw==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] drm/radeon: Check the VBIOS signature after copying it
 from VRAM
Date: Sun, 27 Sep 2026 12:55:54 +0200
Message-ID: <20260927105555.8771-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927105555.8771-1-kaloz@kernel.org>
References: <20260927105555.8771-1-kaloz@kernel.org>
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

On sparc64 a plain load through an ioremap() cookie is not a valid
access and faults; igp_read_bios_from_vram() does exactly that to check
the VBIOS signature, so radeon KMS never gets past this BIOS-fetch
attempt. Check the memcpy_fromio() copy instead, matching the file's
other paths.

Fixes: b442962a9e82 ("drm/radeon/kms: add support for "Surround View"")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 8595f4c6e2e5..a8367e481182 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -63,10 +63,6 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
-		iounmap(bios);
-		return false;
-	}
 	rdev->bios = kmalloc(size, GFP_KERNEL);
 	if (rdev->bios == NULL) {
 		iounmap(bios);
@@ -74,6 +70,12 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 	}
 	memcpy_fromio(rdev->bios, bios, size);
 	iounmap(bios);
+
+	if (size == 0 || rdev->bios[0] != 0x55 || rdev->bios[1] != 0xaa) {
+		kfree(rdev->bios);
+		rdev->bios = NULL;
+		return false;
+	}
 	return true;
 }
 
-- 
2.47.3

