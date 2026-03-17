Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779C7F33806
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E5810E0FC;
	Tue, 17 Mar 2026 06:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OkW/bg2u";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950A010E0FC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:41:22 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b056b7f783so2038635ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773729682; x=1774334482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1Qal9owEWmx10nMbdaip52xdARaCO/YU8MURG1lRk8=;
 b=OkW/bg2ulX+etPFcxg5OzzGcEYJG6GN0PvQaVc3iPAUtSxLZb3S2LQGSWa0GCTm7hF
 WnhcyypOCijDMapuyynbnXLHn7Od77MmCLkpbnTeqh84wztpihCl8ARiBhUZuxRLNNjZ
 07TP5XX+dzikvQXKkqwWamvPIATNd9EnDz6Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773729682; x=1774334482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m1Qal9owEWmx10nMbdaip52xdARaCO/YU8MURG1lRk8=;
 b=Mc/S2PWx7SD0nFaqN1jHqauy70LMY9ebBcnIss9iYzimVtfilPrtdw7HcMQ1QT7SHQ
 vaSoVYmZoC5rru42S62RpSUrA4kG+9N9SikknBHG8MQ9+H9PjKHktyfq+yV5kCfGzgWS
 E1BIDvIUVPYy3SSvAf3IVj8HNfZjiTu8G641lYUJYOl6ETmM6yd1UYPhJbs0PM7hVne3
 zBizAMe/KI8wTHn4Fgh7fEHkxVs6qARUqElYN7VBccZUK0tFjSDz9RNrGW4HBCdays5E
 PhLW0S6b12vEFwZ2jHTpv22K3ygNmImOrlHgr6FjGovZV+2COS2IHyj3+S/qBnf/cEXd
 O3iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkide7QRcmCYqmvzcVkW9dGgKADoMd6EABuPPA2UnkA4LwYXxXbVCwh+nXpyodwgaNcDuSjXaMhk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBhCM9436mtMd1q5GjIC6F+eOx/b0Ij6Zj/l4J4FE9MkVC8GGS
 O+c0+22layCgoIQim5TchJYtjFiyVL6U7+lKyd+dzGeOc5PdloKGsY8+XsIjy95SZw==
X-Gm-Gg: ATEYQzxUVPdIbsv6ttXyfPgK7Z8a12Hgh254hcoG5V7UytW2avBvyBwh+0HGJBES3jv
 H8k8vOTe6W/TXImaz+vXMXA8rHw2qkZvbihgFKv+VKSrkcsKxyCZlbOSbMpLUD+P/UGSn14a6gp
 8Gv5wTazTQSIf6zkQa8YWk3I+iL1x5zpvoyqDad4Q9DbKvJ+we+vZsNJ7lhZXOghm6fatwrIKeh
 g2QKeF56eXkZGOmEjKksRK8Pf8LjQLGq/6ND/SicaLhOMZSaKS/abITt6xAELDq9oH488TP4q5u
 SerMMYWdMvL2XEEG1qtHzCL5If8CnsEc8MtrZLWiVGcZZm8YczH9zCK7cPlQWQtEbcKn8CXIzUp
 Vc267un43U0+N70hTfccViwYVZKN2bMpNoljb0aCdunPgTPJGdrUTivNtR/nr0fT8pg0kdXlDAZ
 gglUyBYe0zq5wKqakW5ao8KlcBkpYFv6r4Kx+vDnzgOL5aktjl0PFoV42bzpfbyLvr3zW44wk/o
 3t7PPGz
X-Received: by 2002:a17:903:2411:b0:2ae:cd2c:8f30 with SMTP id
 d9443c01a7336-2b06357ec34mr19215525ad.1.1773729682153; 
 Mon, 16 Mar 2026 23:41:22 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:a064:c65d:a199:5cb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece605231sm124269425ad.27.2026.03.16.23.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 23:41:21 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 asahi@lists.linux.dev
Subject: [PATCH v2 1/4] drm/rcar-du: Use drm_gem_dma_get_sg_table() helper to
 get scatter gather table
Date: Tue, 17 Mar 2026 14:40:43 +0800
Message-ID: <20260317064049.696795-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260317064049.696795-1-wenst@chromium.org>
References: <20260317064049.696795-1-wenst@chromium.org>
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

The rcar-du driver is directly calling dma_get_sgtable() on a
drm_gem_dma_object. Not passing the dma_attrs field in may cause
problems when DMA_ATTR_NO_KERNEL_MAPPING is added to the GEM DMA
helpers gain support later.

Instead, use the drm_gem_dma_get_sg_table() helper to get the scatter
gather table.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- new patch

Not sure if we should add a helper like drm_fb_dma_get_gem_addr(). This
seems to be the only driver that is using a scatter gather table to pass
DMA addresses.
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
index 94c22d2db197..6a62608ee3a9 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
@@ -291,10 +291,16 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
 				dst = sg_next(dst);
 			}
 		} else {
-			ret = dma_get_sgtable(rcdu->dev, sgt, gem->vaddr,
-					      gem->dma_addr, gem->base.size);
-			if (ret)
+			struct sg_table *ret_sgt;
+
+			ret_sgt = drm_gem_dma_get_sg_table(gem);
+			if (IS_ERR(ret_sgt)) {
+				ret = PTR_ERR(ret_sgt);
 				goto fail;
+			}
+
+			memcpy(sgt, ret_sgt, sizeof(*sgt));
+			kfree(ret_sgt);
 		}
 
 		ret = vsp1_du_map_sg(vsp->vsp, sgt);
-- 
2.53.0.851.ga537e3e6e9-goog

