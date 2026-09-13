Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A106C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF0C10EA45;
	Sun, 13 Sep 2026 22:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRFvO4IS";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8391C10EA42
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:30:29 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f70553dso262433766b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338628; x=1789943428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nuWBi8AkRdSYh4XWJN0FA1URQDZsOkE/8z/h99tbMSo=;
 b=IRFvO4ISyyX/Y2tTN3GZBEgW32ejhLqpZqia3s99NlvPEafEgbNUlcO/KdNa32kITG
 6WwLW7eFvdq5Xlne4AFXt094i+HglSL7rRpDvKhERDGuIj5U8+FEbheNosNRPb/lcyOc
 TWLKzhfqeMs947yQw/4pIiXIDya9QWlk7ov2OdX7du5GJXn8Dh+e/oJtTBtkorXyBjGx
 f0A6b3RgXpAgCoGMW/xr4MMcfU/A+GN74OoyGRfOthozz6mobxt7W+BOtZAqJ6yh2ACJ
 ryKsva83Vq4A1WnvG6mbMI7Ql6TCP4F+eJCKvICUThyGMcGI/Tz//MubjRMdvyPW0rpJ
 Rwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338628; x=1789943428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nuWBi8AkRdSYh4XWJN0FA1URQDZsOkE/8z/h99tbMSo=;
 b=Ep4qWL5B2LGrDWA6ma22auUJl4TgokUbOPbCpYmM/EwfEDH2CBjDLGR2t97K3095fa
 TVqkEErgl5oqaLoAWlrjrmDj00spccW1kCNDdpZYlovdXBECjhCu5D6ssU44x4McUDBp
 r1goc7LCRnUaDaSSTftD0+dCsU011j9yyUotxgkP5NAxoUGIV6KqpHn4xHgBmabjvyZB
 VJIv/6wE+rdveXW/Ert4biG37YZw/DvW3xQ0i1zFjqafbqL4qvhJz2S2A7oSCKFqn4fk
 OmEreLKXrrY4o2QLB+77gG6H5bsIMrsB8d56FBpjz3Z8IyP2iLYm1eEJ6TyFD41LskYH
 klCw==
X-Gm-Message-State: AFuF++lrQzBi9fuwGy1jS27/Zh4ZD1dyeQhIaL+k5eSLKNdme4H9sG5f
 bcrsccXawm7kVd1SziG++Hyfwn17FmUpcW/QI2qcRwASqhAp1WEEd8Ba
X-Gm-Gg: AYBFou3jz66GcsdxMaBhvaiVm64Q6kzPYIdphHNtkEAHOKGCIEfb/eFjuX9PGC2p4Az
 Ty+tl20yUTcqCqlAaHaKtl5E6taC5eSo7NVJ5LovDDBIA0uQZRJKPRkPud8asGo8O5Br6EoMwhv
 VOY7z6gRlvA6YW3N1ruR5IXh4sNzxyB/jnchaPLasWWzj19zGKd7KZ7lAWjO1H/d0oeZJiseh7g
 JkpVczRJ4EstWXVcwucfAHHoQAE+k342irkIfNx9feZioCYeeGvZ8jgYwSPjiggSsca4LmqoY2N
 xTd7mjYlXFHDSmoEh7mAZ0YbkCB+lCSGAgEetk7v9I1iqeJOUy0+guMWiId6VbHDIvMkCREqUnO
 kgC4LI81dajmAUyn1JFF7qMDpQJAYJ+kVMBAcsMwBZ2Ul7aO3QfRW+QwsCAKNBtydKZ7UKqIt7J
 +ZF+gStP9eDZBFLYsceiMvaoc36QmvfzNPZmVslb7wNYBtQDK1m/v/BVNuMMB9CmsN
X-Received: by 2002:a17:907:18c4:b0:c26:1648:a06e with SMTP id
 a640c23a62f3a-c29b87725e0mr3301666b.41.1789338627747; 
 Sun, 13 Sep 2026 15:30:27 -0700 (PDT)
Received: from beelink.. ([186.247.78.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:30:27 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 3/4] drm/qxl: reject relocations whose writes cross a page
 boundary
Date: Sun, 13 Sep 2026 19:29:59 -0300
Message-ID: <20260913223000.695299-4-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
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

apply_reloc() and apply_surf_reloc() map a single page via
qxl_bo_kmap_atomic_page() and then write 8 or 4 bytes at the
page-relative offset (dst_offset & ~PAGE_MASK).  When the offset is
near the end of the page the write extends past the mapped region into
adjacent kernel virtual address space.

For example, a BO relocation at page offset 4092 writes bytes 4092-4099,
crossing the 4096-byte page boundary.  The fixmap slot only covers one
page, so bytes 4096-4099 corrupt whatever virtual page follows in the
kernel's fixmap area.

Reject any relocation whose page-relative offset plus write width
exceeds PAGE_SIZE.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index e727a35c9..9fba6e26d 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -247,6 +247,12 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			goto out_free_bos;
 		}
 
+		if ((reloc_info[i].dst_offset & ~PAGE_MASK) + write_size >
+		    PAGE_SIZE) {
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
-- 
2.43.0

