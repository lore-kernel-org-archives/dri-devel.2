Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB39CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32AC10ECDA;
	Tue, 16 Jun 2026 18:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="IzxT5nrO";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A8D10E1BD
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 18:47:50 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf1cda2b17so27092655ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1781549270; x=1782154070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNzWRIWcVuUVQ3D135xiCFoPDQ31KAN58/ChTPioRnM=;
 b=IzxT5nrOAO8KEZlFewuELgI9ahlFt4xIrN9MI7Ko7NlPCplU2PQLVB1vOq9lgIIPmZ
 kyeVIk55hj3Ecb4wf6ZMy8BaxpiprJNHbENW2t2K9mjh1q9e1rSoiGAs/XLbOlVRley7
 Y842NDj7sllnmg1cafgh/4koo2ban/2MlZeki4xwBEls4UQFaR23Z8d/FcD4Mdsodo+5
 nXRmYw2dac+H0RdirneTraPh8low4x+ycLJMuc9vo5SmalAL+T2ZHZJJLQEsQaRutPdP
 wZ8ukXdkPcVb8GszezL5qF7NXI68RXSwCsuh1gzTw/k2cxn060/Mvyo1SJtI+XJSMjJJ
 x6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549270; x=1782154070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNzWRIWcVuUVQ3D135xiCFoPDQ31KAN58/ChTPioRnM=;
 b=eFQrky0Z+qyTSXzKzv2+Ic6ZMOV/qZb4huOI5hQBKaXIrt5Ak7jNa7OI0KLeVxgkbc
 UBT0mDXN9cMTfxcHUjvYvO8rakRrHlRkE4FqvQMjO3AxjHAeQizw/c8FTbi++g8xca/K
 T2Uo0c1MdMAupP0nvjKOCcyC6t5o9Nx02/qWr7MzzfzADHHWWAL4CI7vjwcDDR0IlgRP
 dXGSXLOSomS7pjW8Idd3Zu5Int72fW38wD6HBmdITNk3SAcWWiAJLSbtVMZN/Ll9zSzL
 NZLk2ebDYRxwunHfKAd8OXfAtxHz1W7q6I/CrmX/YhPyrd7cK24iU1sXZlV5I3reS0kK
 O0eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8855Jk0maJqAlnDxEy6XY8Q+VUt2EFEFYlnbYGFTnz78ZN9nnRxowVtHbdVmxbbhUbJcybmv8O4sE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEOqWl/u6dzWzcqaJAhfFD7SbBX3Tzjcym49VaZmTG11Pbgd4D
 ncod4/hs51V5O/cQeg4NVIZStxEtQ7jNYt6AkGp/7WDnqMVsPtuVOV+Cux1mjmlbErvqZr7K1Vt
 cxmU=
X-Gm-Gg: Acq92OEv+Yy+S0sgYg4WhRUZqb/KrZ3y1FBTAOpVwGVj7rO7shw2ioCE8q0XXq4L2q7
 zkSstGzQrrBpGR2+YwUZ+udyJHE7wTZHbqRG/MbdLKBnDvlSX7o1xFIRJNopYjkxbA5K0la1tFT
 bhlMSsd5jSyrU8K3/V7YrehvTkuJipPzHaFLeUugh5ncEkUSoypgO9gzoyRbiz5e+QnEg+2zup0
 XYlHYVIemksUIVKczb8lhBpWlxMFtT4H9IgG1dmSA1boNollQq8+AP0dGN/zO77yYVI8yc4JNrV
 w2aCrLnFU0qny0OHZBq63w1yihhubOfBvCmMTnkPjlOs2COZVBJnuPp9uZ6ed44EhBn347ZF4qt
 3Rsopdig7b8HXveu62UqQz5ULiVcQ2DQNjD2dgAONp1FE1FwquWgClfMvBOMvkunnJHUd5xAkU3
 WTFEFkZUs=
X-Received: by 2002:a17:903:38c4:b0:2c0:aa5d:756f with SMTP id
 d9443c01a7336-2c699aa7769mr5150285ad.8.1781549270064; 
 Mon, 15 Jun 2026 11:47:50 -0700 (PDT)
Received: from p1.. ([2607:fb90:ecaf:62d0:f5d0:3c3:fdd2:d3c8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8c1f9sm112317845ad.59.2026.06.15.11.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:47:49 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: jani.nikula@linux.intel.com,
	dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, bestswngs@gmail.com,
 Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2] drm/edid: fix OOB read in drm_parse_tiled_block()
Date: Mon, 15 Jun 2026 11:47:37 -0700
Message-ID: <20260615184737.899892-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:18:52 +0000
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

Reject blocks shorter than the spec's 22-byte tiled payload before
reading the fixed struct, as drm_parse_vesa_mso_data() already does.

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
v2: use 22 instead of sizeof, based on the topology_id[9] fix:
https://lore.kernel.org/r/20260610141549.555605-1-jani.nikula@intel.com

 drivers/gpu/drm/drm_edid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 404208bf23a6..df3c25bac761 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -7575,6 +7575,14 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
 	u8 num_v_tile, num_h_tile;
 	struct drm_tile_group *tg;
 
+	/* tiled block payload per spec: cap 1 + topo 3 + size 4 + bezel 5 + id 9 = 22 */
+	if (block->num_bytes < 22) {
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

