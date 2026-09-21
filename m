Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7EC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6439C10E449;
	Mon, 21 Sep 2026 13:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F59WnyoV";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1D210E449
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:12:11 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so1748729a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789996331; x=1790601131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ig7/HqBzfoSVv6fdudTalNiMgAfFIlYLiYgMPPiaeeI=;
 b=F59WnyoVLnlT0SJ8jPJ0OohzjyaCrOQC9pD4pJ0MbB/dmVlvxsmgwBWuvqDWZ3Jr73
 ePyb32n3ipsaxNBXagPsxvMXQs3eBkTbHK19NHVeosz836O+HTuN1nsJziZSiLiRJX0H
 gZ/IJQWz+AH6em3H5TfyzCCWV8gYS3vLwEuzYLXKLJazOnXigdbv3fngIjGXUWyL7xBr
 ImSghp8Dealgl0Gx+sKFN9wUyV7bFznBF9/ku9B7IH41WWBMWlLJxppjm0CJBJTQL5Gg
 9Wy2sdp2nMbWCPXSzuZp6rIZpZ6mWBkdP8ZlcUg5SSh620pqsFVUv3pL186QDuR8VeQT
 FJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789996331; x=1790601131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ig7/HqBzfoSVv6fdudTalNiMgAfFIlYLiYgMPPiaeeI=;
 b=rgRHyLixGladT59NxuwN+1GmC0kUXCPJmsz3sfpM9YFlWDfqKfu889Ls1A+xxYkwWM
 0ljttGL2SzhJ/b3xPbNBfO7+RELPhrfW/7bAV4B7+sddIgwiINZkmMMN89+8l/Im67Bd
 4/1EeL6QErmsozHy+8a9CrY9+SN3Q2FYJcSU9D44SaJw0jy2dx1AKTaXNoVLi9G6VQ+Z
 E+AiPEPZROBzjwgDA1XSavwicMAMqI8ESDtroatuubxeY1wJzw7c32/r2J++rspQDJSE
 M+uv3pjpijR6pZcAW7msWFKqoJ1XKCI8X+K5Dq7x6t26VJbtnwL2UGKcFgKzqYLYyWyq
 r6uQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSb/BvX6ujZ5pq886c6slONRY0hZk9AkJAowg3qtKM4NnDAVU5n2MXH763X7oZyG9TXc3cX30Uqhc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++msXXZK4FEAs5lXzD6IbSvMbaXFTOkt8dC/a3csit0QG1sCznem
 54m365w/Se2b5agHRMulLWoaQzDiYTc5hOkARwX3ENI0IAJWNQLYJtzI5Vpa8leDr1RaBQ==
X-Gm-Gg: AYBFou25IpYU9G0BGCKKXxRw/iE8rzgtHNwM1ALnsb6NiIrHtPGfyIdAP1D/YkOoFdt
 7O1tSpy3Xp6BPNNw1VBALB86mM/zSJ5FOab1XlbBKB3Z3DejhgD0gtgGcf1NVOmQN1WyGTLlCig
 7sokPM2k92leNYOw29s7ZA21Ij/MfY4zQSaGP45EwmsIV1oQ6zDkJujSDPVbi5RMwzD+qpRYH4l
 B4+dAbWHFVkKCZhOXIumIwNKx7j+U9Otntgudsp8FGYOkLw7OuWD4aneIcwOaYtURyAtU45oCJH
 KUKsYNVSisx0prqtlRdzThBWbUiCJjYwyKWVw6nKFKI5/ogBrd+d70GEAefn59O13M6qDpiEEPa
 mHfL4tscReqPKRQVSk51TShxZuEXfrbXCXHLY5d+z4x2yiJ3Js/R/TNyhks14M4c73IH5ahRf8w
 Ccne9b/CbR2Amp8zYe1f04TiKjapipwe4GDyd0vUNiKsJshdVYN8vl+9MibQj/cpl4
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b64 with SMTP id
 98e67ed59e1d1-39e6c6a5438mr8799720a91.46.1789996330968; 
 Mon, 21 Sep 2026 06:12:10 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063bcecc6sm80447a91.12.2026.09.21.06.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:12:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Nancy.Lin" <nancy.lin@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: fix ovl adaptor platform device leak
Date: Mon, 21 Sep 2026 21:11:56 +0800
Message-ID: <20260921131156.403652-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mtk_drm_probe() creates an OVL adaptor platform device with
platform_device_register_data() when the display pipeline requires the
OVL adaptor.

If a later initialization step fails, the probe error path releases
the DRM resources without unregistering the already registered OVL
adaptor device. The normal remove path likewise leaves the device
registered after the DRM driver is unbound.

Keep track of whether the OVL adaptor was successfully registered and
unregister it on probe failure. Also recover the platform device from
the stored DDP component device and unregister it during normal
removal.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..d176e6496aa7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1060,7 +1060,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	struct mtk_mmsys_driver_data *mtk_drm_data;
 	struct device_node *node;
 	struct component_match *match = NULL;
-	struct platform_device *ovl_adaptor;
+	struct platform_device *ovl_adaptor = NULL;
 	int ret;
 	int i;
 
@@ -1205,6 +1205,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 err_pm:
 	pm_runtime_disable(dev);
 err_node:
+	if (ovl_adaptor)
+		platform_device_unregister(ovl_adaptor);
 	of_node_put(private->mutex_node);
 	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
 		of_node_put(private->comp_node[i]);
@@ -1214,9 +1216,15 @@ static int mtk_drm_probe(struct platform_device *pdev)
 static void mtk_drm_remove(struct platform_device *pdev)
 {
 	struct mtk_drm_private *private = platform_get_drvdata(pdev);
+	struct device *ovl_adaptor_dev;
 	int i;
 
+	ovl_adaptor_dev =
+		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev;
+
 	component_master_del(&pdev->dev, &mtk_drm_ops);
+	if (ovl_adaptor_dev)
+		platform_device_unregister(to_platform_device(ovl_adaptor_dev));
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
 	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
-- 
2.43.0

