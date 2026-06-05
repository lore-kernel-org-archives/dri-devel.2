Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D204CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 19:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589DC10E4F1;
	Fri,  5 Jun 2026 19:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oq83TGZW";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5707010E4F1
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 19:33:29 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso1615436f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780688008; x=1781292808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pEZDD9TlhQlFNvL79/mxsSDb2Yxob9rJ9xhLRrOMmv4=;
 b=oq83TGZW2j7YmUMKfK1bX5rx16+NjKJDFYFNW3zHF71pdvu9xjrRmAQj6i1D2WW/kH
 PP3Nr6S+JjKNPGEapFH7kKiJxtEmbHzlZikl9Z2+zOZFJezp5DC026LvkEslKJwJjpsv
 PmPsaDAnANqkg7LIM1X08xjNa6QSL619fspHF2Yn1heHGvXSzMFjaSqfA2eYlTRQTDri
 xk5b2JlA2Uas1ZK3O9ACGR0ZKoJGbSh05f4iTkAWUVpWjkHwfqXZifOffcu/4ASqVoYS
 ANxeLXULAf7wH6hqHQs76hmW1Sncv2ThlSHeu6h0jQ3YSrjL/bANQoJoXZbq4PtbqTu1
 wjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780688008; x=1781292808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEZDD9TlhQlFNvL79/mxsSDb2Yxob9rJ9xhLRrOMmv4=;
 b=HQOdC1r9btwGB3ugf4X3isTYEIP61829Koh3a+cjwQpt2l8MAvFcOHW1nVuDIjBTRR
 voi/NGyVDH7iHyGtpzrg210qw/XokGGpTVU5jUXR3f1/5Hc0AKRzkvGNMBG4rrJG5n1r
 xR+vsPyFLlI5w7ALWNXiQYu6PvQNwBdhddAZ+YLEl1UJ3f+WFvEvnP3eaAdkk+hEg3Bz
 xLjIZKjhMw8i9x0pfcYoGIFC6oV2DS+u99cPeT3PhBUnzhGplB0MfrCiUtH4Q2urUI1C
 eUpjFKdIhoU/DVCrE9JjyU38V+C5UkaJzf2Fb12EiAB/bYddzWQ68cUfeTNxsUC+ZCvP
 azrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rW0YHpC/RGq5U4vnyf7FWF0Nci+bFeOP8CQDhsljXqouxLyS5XCVYKnVFGR9ZqP4SuF5IOeBem5o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlVN8SoJ/0RCQICdJbbNfglLcOBorGJ4x4H41JnFedqa3OARQ3
 +4X1uiEdGx11dgJ8qht0uGCeRXVLfqnEfMplw+IJ/Vvfqq68BAST46iS
X-Gm-Gg: Acq92OEvIKhXYpc3gnILVu1gp+c/vhgxDu0zh0Y+6wh07h16g2G7JWSiEmcBR+jKUz4
 QS4Uzen/1MeRJTIXPlHrHFCXBmKpOzHCQ7hLGzbUI5UtK1/nXfAB8NeyK2nZBocUAH7+GydBh8G
 /wMFLHbdws2g+RdqHUB7jQGdySH6PoIblMA6ZRvX9/fvfVbprbWemqonB4t7we4Fhz5cUR6K2rp
 oRQRqNtMEe8wdKBsa3swtLiw5+9MJoTBqJlxuCnvhw+eWIfeSHXWdPP0SBOm9P9r2KsmSvXqt8E
 NmRji3dih1SSLEHoHUeTjQir3Ke8zoPGwb39ccwUIaIbAPh/5AK7CQrVAtaIzd2L4anC5COQmyL
 XwCvn9Luc4xdMxhBxHAPhYc3mLneLliMOeWCQcup+g84phe/M8v4o5xbqFkFpLseJ3Yo+hdyyxb
 L56I4wSLfj/MO9QV3Rbzj8x559FLmUSGDre1Tr3nnVX/BqFOTx1mUnr7l/FkgRY9uphcxqTuwV5
 wn5gLl+56Lq
X-Received: by 2002:adf:e68f:0:b0:45f:f142:d55d with SMTP id
 ffacd0b85a97d-460307761e2mr6539957f8f.39.1780688007512; 
 Fri, 05 Jun 2026 12:33:27 -0700 (PDT)
Received: from node ([202.47.63.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm28025464f8f.17.2026.06.05.12.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 12:33:27 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: include secondary weight/scale extents in
 region_size[] accounting
Date: Sat,  6 Jun 2026 00:33:11 +0500
Message-ID: <20260605193311.48008-1-meatuni001@gmail.com>
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

calc_sizes() updates region_size[] with the extent of weight[0] and
scale[0] within their hardware regions, but omits weight[1..3] and
scale[1]. Since no NPU_SET_WEIGHT1_REGION, NPU_SET_WEIGHT2_REGION,
NPU_SET_WEIGHT3_REGION, or NPU_SET_SCALE1_REGION commands exist in the
command set, secondary buffers implicitly share the same hardware region
as weight[0] and scale[0] respectively.

The omission means region_size[] reflects only the primary buffer extent.
If a secondary weight or scale buffer extends beyond the primary one,
region_size[] may underestimate the required GEM buffer size.

Fix by extending the region_size[] update in calc_sizes() to cover
weight[1..3] and scale[1], skipping entries that still hold the
U64_MAX/U32_MAX sentinel values written by cmd_state_init().

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 7994e7073..152733b6a 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -271,6 +271,8 @@ static int calc_sizes(struct drm_device *ddev,
 	}
 
 	if (weight) {
+		int i;
+
 		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
 			op, st->weight[0].region, st->weight[0].base,
 			st->weight[0].base + st->weight[0].length - 1);
@@ -280,6 +282,14 @@ static int calc_sizes(struct drm_device *ddev,
 		info->region_size[st->weight[0].region] =
 			max(info->region_size[st->weight[0].region],
 			    st->weight[0].base + st->weight[0].length);
+		for (i = 1; i < ARRAY_SIZE(st->weight); i++) {
+			if (st->weight[i].base == U64_MAX ||
+			    st->weight[i].length == U32_MAX)
+				continue;
+			info->region_size[st->weight[0].region] =
+				max(info->region_size[st->weight[0].region],
+				    st->weight[i].base + st->weight[i].length);
+		}
 	}
 
 	if (scale) {
@@ -292,6 +302,11 @@ static int calc_sizes(struct drm_device *ddev,
 		info->region_size[st->scale[0].region] =
 			max(info->region_size[st->scale[0].region],
 			    st->scale[0].base + st->scale[0].length);
+		if (st->scale[1].base != U64_MAX &&
+		    st->scale[1].length != U32_MAX)
+			info->region_size[st->scale[0].region] =
+				max(info->region_size[st->scale[0].region],
+				    st->scale[1].base + st->scale[1].length);
 	}
 
 	len = feat_matrix_length(info, &st->ofm, st->ofm.width,
-- 
2.54.0

