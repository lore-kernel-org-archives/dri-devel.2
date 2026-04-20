Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDCDF588E4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB63A10E0E2;
	Mon, 20 Apr 2026 15:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jh2vyudi";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058FD10E0E2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:07:09 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43d6fbd0954so2674769f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776697628; x=1777302428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynS4V1zPnfRYyra1R+IgeuqIvRmeRjBbGLtQrOc/Ilg=;
 b=Jh2vyudiFiZEQSnBLas6dOjW7E5Iwpewv1opnh+hRjmFU+mSgZeNOraWibi7C9rd6W
 UBQoUimzrnCspF8k+YdB6sUe4RZTK2MkyIt2VRIoEk8B7Ll101MhDPcqzSgR5UYIIA/q
 EkI5MgSC5N4uv5IFASKlUUjzNsa9o9PLxRly+lVm5lp8PaULL5P1TTDxiPQneHDYqxPQ
 Nyuud4JZ+t2zq3WRjNTN9YBO/17yzvF2VOs39fipd+TY3WphYqiPoCjgIq5DteywmWAI
 58QHZa1eyBO3xpcRasWqrgkY20KsLxjgGY371Ak18nyyMZ41Zb66A68wOZ7TpBLdcYjj
 UzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776697628; x=1777302428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ynS4V1zPnfRYyra1R+IgeuqIvRmeRjBbGLtQrOc/Ilg=;
 b=JeYwhgBAWs+xggCcLzic1tYVHRGLU15ILVeeAVYWhr34ormH2yII9vb+ZKxoA2Rcfa
 AEqpx9DBitqAuABHhYhI5MstCIx7xMOHCTOSZFLsccXSHDf46IgruBVXKcuVoYl/4ZHy
 jXd30i0vLpkEMAoz11LcYsPS+OU4IUcsoVaTD853t/eRaaH5AIQoYTQzhZYVhE0BomX+
 dleRrootFPHz+2MKWJAnHG/jZsd/7hQHNi4QKIx4e2CceDZiAFX5ul664bDgauT62SBN
 ZVUiaZsdb89WP8PqmRHrr7NHnsbwfXT3Dec9cG6HLpKZLQHnCphnR9oSRXP5hOFvcXzB
 +kug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vNcdxVJFu7/UGiKVaWte16+1OIvOlWs7FQqTfvAdcWD257elnkYu15VephcgBF1GPnoE2NKPu1vs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya7c5bqHlotf+GVDYORynJzPKM3ty4kdHNXYkzrU5jGfFO+nFB
 rPG/leMjqhrmOAiuMZVMlkv8Agb/bWhGFsiBi9M/LjAa1pbLO7a1AExM
X-Gm-Gg: AeBDiet6XSa8vDkCvtnnTnZuIJe7bSQWZKQIujkxsLi55zSKWKpvYcQnBKEXeRMB31w
 g3ubmEdv/ZRp5fZkqMBCZOr+sIy6BrBDaQVVJjbQM2+N69HeHAry7AsBd++v2aL85g38paBlPUx
 i7jC2oMHZlnJ1pJ+Y7fkBJTW6irt26h0NPcPxJWN3tv7GAufrjE6NhGDTYyNxM12pBs2kFgoSkf
 CukNX5qymiwyXjSHaj2FmYuJJ1rh+/8Nq60MuF0Kt64i+OjZFsX8VYBq+NljM47Lk6OmsOl+5Uy
 7pUzE9hkStqtpo+L60NReY4ZhbwKj+qn3GkcJAqmELddkklHRDucU/t0ly4kLAbL6mYP3ydcLSF
 Uord6wSKS9f/QhFWZoMVkBvWV+s1LuX2R0wQFJhapxDaYtFpHjKdP0FbPTbTd5v8JVFpiLdwJnb
 SEgUdw50L1OJigJF2b/d15ZC5K0FVwm44uu9TrafwbC8n5eeFNIg9LQo77Fv+B51qWXuAO7Qs=
X-Received: by 2002:a05:6000:1889:b0:43b:8f4e:27f8 with SMTP id
 ffacd0b85a97d-43fe3dc12e6mr21117601f8f.12.1776697628278; 
 Mon, 20 Apr 2026 08:07:08 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a79esm31927136f8f.17.2026.04.20.08.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 08:07:07 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Edmund Dea <edmund.j.dea@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 2/2] drm/kmb: unwind partially enabled DSI clocks on error
Date: Mon, 20 Apr 2026 17:06:58 +0200
Message-ID: <20260420150658.165734-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420150658.165734-1-osama.abdelkader@gmail.com>
References: <20260420150658.165734-1-osama.abdelkader@gmail.com>
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

If enabling clk_mipi_ecfg or clk_mipi_cfg fails, disable any clocks that
were successfully prepared/enabled earlier in kmb_dsi_clk_enable().

This avoids leaking enabled clocks on probe failure paths.
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 500dc00ba6ae..3ec16b1aa16c 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -1526,17 +1526,23 @@ static int kmb_dsi_clk_enable(struct kmb_dsi *kmb_dsi)
 	ret = clk_prepare_enable(kmb_dsi->clk_mipi_ecfg);
 	if (ret) {
 		dev_err(dev, "Failed to enable MIPI_ECFG clock: %d\n", ret);
-		return ret;
+		goto err_disable_mipi;
 	}
 
 	ret = clk_prepare_enable(kmb_dsi->clk_mipi_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to enable MIPI_CFG clock: %d\n", ret);
-		return ret;
+		goto err_disable_mipi_ecfg;
 	}
 
 	dev_info(dev, "SUCCESS : enabled MIPI clocks\n");
 	return 0;
+
+err_disable_mipi_ecfg:
+	clk_disable_unprepare(kmb_dsi->clk_mipi_ecfg);
+err_disable_mipi:
+	clk_disable_unprepare(kmb_dsi->clk_mipi);
+	return ret;
 }
 
 int kmb_dsi_clk_init(struct kmb_dsi *kmb_dsi)
-- 
2.43.0

