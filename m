Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B8CD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260F310E12A;
	Tue,  9 Jun 2026 07:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="I+2iY3HI";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3721F10E0DF
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:40:47 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2c0c2c7e0c5so35167305ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 23:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1780987247; x=1781592047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wJZ7+G5MHdWe6DS9iCcA3/QXeotlfCF5qGg0VkBgloE=;
 b=I+2iY3HIHZ7fUf5S9Qk4tl6AgTw5khX0XaeSVu0rqllP64W3Z3SLuklo6Wp3ZOosPS
 P9Z4kJ+o2kUHB0sB5mdW4MOwL6+PrP+C3tmQlf1ze+dL/mu0OnLuC7dfXqAtdXTFAToK
 vi2u7Wy0axL03qQoxy7PEq4jgHbq0VU/u0BWoABG1fa4nbHIFb2yoD2uMtPnDDjhTvSV
 AMoqhx2+FKyxPh+Je2YJp7bTXaWbIzyfnxKnDmzrwmnSSHLRdEzTnGaw9lgxaApmn2iJ
 GmygiKOTuDbe25KZ29vf04vNXja8NZ2bEyLvruWsHs04R6NRDzMF+hxgQU5+kcdSg6if
 UQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780987247; x=1781592047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJZ7+G5MHdWe6DS9iCcA3/QXeotlfCF5qGg0VkBgloE=;
 b=HN7aCoRlhyjL4lCcQumaauIaIIIBPoX7wG0PRUbzoJGByIzYj1y1DAT7GHyoht3/Ep
 V4XQd9Z04N9yf7Bakb7B0Nrol3tMRXesjbYz+0Tm/bfJ4KebRoK5tRySI0GWLf/ixJQx
 zQp7X+OBpQor/z1Zd+GF09SMKkYbWmhEwSgZ+yfVF1mRq84frrwgFDPSA6hcQcxWy8Hr
 U6G0SGbNE6wjVOo4ucjsHbk/0ef81w3T98qqNaM9Q2J+sTSE7hIXcc2H0jXlw90com52
 Y1G3kP3WR8gQwqJuBZ9dmmbKfubSOQkMfA2pc3ElM7bexvtdXCCs+mVGO9ezZYVxfsSy
 t/BQ==
X-Gm-Message-State: AOJu0Yx5jm37NrXW8yQ6zMu/TyPNZPW8AP5bgMuNQpQQZcTi3GTjhCLZ
 B9dNm/YL0TWf9saYFPJ/hMuV/aB9hIFVPeHK1to33/HohuBZK+x+sJ5JpEP8yhCEZNTezgdT3dQ
 U33FzYGqT
X-Gm-Gg: Acq92OE8PhQJucdlNJ7nfQfTMrwce5LW9e9I6QlFgHTLJAwUDzyJFRs0DAw4nfAFmpv
 gT4Jzb0ICqv3Lw84uHw/4jjECbZdKOeX2bmGVrMSyBMgdkIJBeoL9LQvYCpqGTg8hu4RRTIHhRA
 JC3J9yxjdjxI21ZFnFq/jOcEbiTkW5F52U5jZUojAbKvOFipN2rTlruX9EuYnfzIyWKCvy2XanO
 SgMKxjonvHDVxjMAP+L07bv5/qP3mD60oNEqLKILfLNHRjvt4mBf4CtRc5mBgPPRFYGhfFVWH7q
 /EWnDBvmI9zSG+ABuoI5Xd9FG7onhuhTN899QSifnsVtVHhxcZ/5RurKAaaYlvje1U5iANXIodA
 elVDWlPCW5Cs8ekiL0AT77rOnF3hz/Ctox09UkZedRMSgXPkjHvStwFOtVF80xU6GHc6ynWVo6m
 ZTVKVQentmuoJspItcmpoN5WJ8IQ==
X-Received: by 2002:a17:902:e747:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2c2a1bcd562mr20139995ad.12.1780987246654; 
 Mon, 08 Jun 2026 23:40:46 -0700 (PDT)
Received: from p1.. ([73.140.210.38]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649ab01sm193687995ad.71.2026.06.08.23.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 23:40:46 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, bestswngs@gmail.com,
 Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] drm/edid: fix OOB read in drm_parse_tiled_block()
Date: Mon,  8 Jun 2026 23:40:38 -0700
Message-ID: <20260609064038.2799482-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:14 +0000
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

drm_parse_tiled_block() casts the DisplayID block to a
struct displayid_tiled_block and reads the full fixed layout up to
tile->topology_id[7] without checking block->num_bytes. The DisplayID
iterator only validates the declared payload length, so a crafted EDID
can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes at
the end of a DisplayID extension. The read then runs past the end of the
exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.

Add a minimum-length check, as drm_parse_vesa_mso_data() already does.

  BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
  Read of size 2 at addr ffff888010077700 by task exploit/147
   dump_stack_lvl (lib/dump_stack.c:94 ...)
   print_report (mm/kasan/report.c:378 ...)
   kasan_report (mm/kasan/report.c:595)
   drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
   bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:574)
   drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_helper.c:426)
   status_store (drivers/gpu/drm/drm_sysfs.c:219)
   ...
   vfs_write (fs/read_write.c:595 fs/read_write.c:688)
   ksys_write (fs/read_write.c:740)

Fixes: 40d9b043a89e ("drm/connector: store tile information from displayid (v3)")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/gpu/drm/drm_edid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 404208bf23a6..92054ac82fe2 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
 	u8 num_v_tile, num_h_tile;
 	struct drm_tile_group *tg;
 
+	if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] Unexpected tiled block size %u\n",
+			    connector->base.id, connector->name, block->num_bytes);
+		return;
+	}
+
 	w = tile->tile_size[0] | tile->tile_size[1] << 8;
 	h = tile->tile_size[2] | tile->tile_size[3] << 8;
 
-- 
2.43.0

