Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA425C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0CE10E0FD;
	Sun,  9 Aug 2026 20:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="e92XvWB9";
	dkim-atps=neutral
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6133E10E0FD
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:45:29 +0000 (UTC)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-80bb41f7f3cso12171787b3.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 13:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786308328; x=1786913128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XyGxfjuoeJ32dis7pvONjDYcrymIUOl2huVjP6Wi2rk=;
 b=UKMLi1lfxTl+PIjhsOgpdKucFSJlyxwbAUo0GvRVIfTiWKkMrpDxten+F1ts9f/9fb
 j3dLylzepeIew1suyo62Y+05qwVZmbv4jYp9di4qUU3OBY9D6KDVbMhh0yHfqP9N8dTz
 wmgH4Rr63+oFjcuNNV5Il8WXcWv1dPA0fb4MPedCXJSwSV0bD7BMtGHwaRbOZ5Es1GCL
 qY8csxyzUfTmMLDbnVY7ThLhmip0+Sv1Tw6SFC7pLfgWDv6eJJMMmaRFpKy7ait+9CWJ
 +pNPgIb3qvrbWJads0PX1lp1Vq1DgUxwJ0PZhHYxevoBWtfsULNSGnNJZ6YMrZ2ILYb+
 Wc/g==
X-Gm-Message-State: AOJu0YxmL0XsmR6zCVIk7u5J7e6kj/00bqyT+ym66BXLEiZF7mx/pCzh
 rFIiQpb5J3h3e0pDOlpzOdWyGbY1UiT5ebaPFo28x6BwstY0vk74UPIlLmtHAhjXVRdq+0WWp89
 rd/Py6QD3ntGwjW3G+xPzcep79SFBNrsw4XJEuZ+iIUnQPe/GhKM/x+g18CoGVStXp2T4I6pX1Z
 1jSZV4fG8g00YlsSJl5TyNygO61PpuBItXf0pYbZD1zvNgjVt6IwLh2z73ZjX4Ku3813K/M8UY7
 bmcwCdw8WYJEMS3Mm3Y
X-Gm-Gg: AR+sD12MrPee3vxHA8oxXY1wp0qjB6nXFlUkIWT6Y6Gml/5I/yv8ii+fyvczUuSBdTI
 0XVtUpiSSUmVyF6G2SG1IfwdXJBzM9hJjl7wROt25YPjpGn/scCKD1R5fEvN8s108IUmNlR08/x
 Who05A+ZuwZCa3UyEzup+tqzUMva3vDMASaUEHIwCSUJx9cd5OKitVInO6QBLY3kkXMUxWOU3QL
 uYm0qNkCCQAxH4eX+R8TiLNlBHvNthv9QH48xL9SGo1+02Qzrc5CF0pYi3uyCa58Zwh28P2RA1N
 d4xjjBayoRjL88fkcAGCp8ZCvLKbscjBBe28sxnnlaBf6lzEhevQDi+FNZ5oSdfLF+hg639cHM0
 pKlpQ9kOO8+YGaJ4ivtiutVa+EA5U7z8fASNOPIYqY+mxyO+8n4MYpMdAU6fqpfnWthZNNYC74z
 Zwde26EbsmHHl+yYCQDTC3bPMk1/XCxA==
X-Received: by 2002:a53:cd49:0:b0:664:dbfc:e46d with SMTP id
 956f58d0204a3-66ac2fafb9cmr11215062d50.35.1786308328032; 
 Sun, 09 Aug 2026 13:45:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-66acae35b0dsm297193d50.17.2026.08.09.13.45.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Aug 2026 13:45:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso22654311cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1786308326; x=1786913126;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XyGxfjuoeJ32dis7pvONjDYcrymIUOl2huVjP6Wi2rk=;
 b=e92XvWB96A+RVN44N2o0s7DD7QJiOwUzS7lRzh8x0GyIc8wxXpIdEW2vggmZ18m6Ac
 6hvd+BCrzLuOC+llUGQXNNWts6Aa5KcTNNx/sSv2mb0T/G6wJEWrwgKkEcFNhk8ZUj/r
 aY+t5P3qoBE8Lha1vPN3TzbQup+ZETN/i1bkE=
X-Received: by 2002:ac8:6903:0:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-52d0b220c2cmr284918951cf.32.1786308326229; 
 Sun, 09 Aug 2026 13:45:26 -0700 (PDT)
X-Received: by 2002:ac8:6903:0:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-52d0b220c2cmr284918641cf.32.1786308325694; 
 Sun, 09 Aug 2026 13:45:25 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d1659c1d8sm57920951cf.16.2026.08.09.13.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 13:45:23 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org,
 Youness HFA <hfa.youness@gmail.com>
Subject: [PATCH] drm/vmwgfx: validate pitch coming from userspace
Date: Sun,  9 Aug 2026 16:45:15 -0400
Message-ID: <20260809204515.211045-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Validate the pitch, alongside the box dimensions before trying
to copy data from the underlying surface. Fixes possible
out of bounds reads with cursor snooping.

Fixes: 2ac863719e51 ("vmwgfx: Snoop DMA transfers with non-covering sizes")
Cc: stable@vger.kernel.org
Reported-by: Youness HFA <hfa.youness@gmail.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500190..f4d14b00d7aa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -324,6 +324,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	u32 box_count;
+	u64 src_extent;
 	void *virtual;
 	bool is_iomem;
 	struct vmw_dma_cmd {
@@ -372,8 +373,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		return;
 	}
 
+	if (box->w == 0 || box->h == 0)
+		return;
+
+	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
+		     (u64)box->w * desc->pitchBytesPerBlock;
+	if (src_extent > bo->base.size) {
+		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
+			  src_extent, bo->base.size);
+		return;
+	}
+
 	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
-	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;
+	kmap_num = PFN_UP(src_extent);
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
@@ -387,14 +399,16 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
 	virtual = ttm_kmap_obj_virtual(&map, &is_iomem);
 
-	if (box->w == VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch == image_pitch) {
+	if (box->w == VMW_CURSOR_SNOOP_WIDTH &&
+	    box->h == VMW_CURSOR_SNOOP_HEIGHT &&
+	    cmd->dma.guest.pitch == image_pitch) {
 		memcpy(srf->snooper.image, virtual,
 		       VMW_CURSOR_SNOOP_HEIGHT * image_pitch);
 	} else {
 		/* Image is unsigned pointer. */
 		for (i = 0; i < box->h; i++)
 			memcpy(srf->snooper.image + i * image_pitch,
-			       virtual + i * cmd->dma.guest.pitch,
+			       virtual + (size_t)i * cmd->dma.guest.pitch,
 			       box->w * desc->pitchBytesPerBlock);
 	}
 	srf->snooper.id++;
-- 
2.53.0

