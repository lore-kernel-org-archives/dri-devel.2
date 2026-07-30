Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B2FC55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04DE10F181;
	Fri, 31 Jul 2026 06:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVD9NO/v";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D8410E144
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:27:15 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2069997a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785414435; x=1786019235; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nY21TCjMLC68nQGz7B4rPYSEfj4hhFqBLreSGblBeOQ=;
 b=QVD9NO/vLEiouU6BtkOH1CiuSKtDKKCwESiwtIVPIKLObNqBtxdtG7MBz+L5jM3hPc
 jlzp/CUnQP3V8z6hyfqxlrzK+obUOILUuDlTfrKeU2BbfQFZtWG4X8snzlOq8IVAyx7N
 iPQZH/oCXgoqVr+2Hs2o/EjOZ6aldUqi/Trog61+GezO0xPo+Yb4iStc2qCN1zADx36O
 lUPbi4zN6Iv+4ZMwE8IRZXdZ5Akt5shW3fgq1y+JTL30pqECsd6yltfC5ng+AdYnv0cx
 46VmqNTSyHyFB9Yqn1eVRdrHJDJ7l4oifDFKahVPRoU6ioGfkrM83FhUxW6IfabEfpgl
 18gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785414435; x=1786019235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nY21TCjMLC68nQGz7B4rPYSEfj4hhFqBLreSGblBeOQ=;
 b=XFI06eP+YW6KbN5GlI3oLndSgJvVtaqz8s4zjHoL3dcefNmIVOG0FSV+IKTWJ7F0Lu
 MUQxRQHcjSIdgC+BpF9kw9GaBy2VtS8X7JuEOZKOoQKzeTf3yBAp6Dfx3YkhyfucNnP6
 1Q4ZdK2F6/V5+e/jF93apf1+DmKVtI2auDGTBWIT7+8BYkIq+yJlQi/zftGH64SYUcvI
 8RMgNHsT8Q5KbCFrl8aJQZyG+HU+jeiObFzB/0hgQZqrxV2hC5YPdQijETAVm+K88zMk
 7DX5kpjMSXuuczg2jwY7ZgHIDF3xbWAp+l5imsS38xppN2x8RvAY1YR9yPnQ5wkr5GwU
 XVsw==
X-Gm-Message-State: AOJu0YwqVD3+5KJnnQnBm10LV+2w5JC9ozEKoedeI6U55+snIsULQu54
 Za9QVbf6Yi8mgQ41ZFuMIiDco8lVuPtMyTaEW9SmO6KGtvXPJNsWKdKn
X-Gm-Gg: AR+sD13HB6I6Sb4JhYccy4EWSlZR5vsYiqudiAp00ej2zimXEe/CDne1IxDIby09YZc
 Ug1RpjasbswkrsYiJE94ZREhNJw15miVw+2zdtW9C5gcD01cSqgZxARAMAH6lA4quJ4FT5R0Q0U
 e5klSHRxEfWZMlsb0MA7/65KaMc1g2mLtgz0oZqhjENBuntQ0ZAWmSVreyf2LIHI0XcCMe0/nTj
 NYnvaueHYjDJFXdSW0mrOcc/tLgIzn5CaQmfzV0Z+0eK53rU0oSUZUBHU31EZjDUU/gPFrcS03F
 KRZl+8GDeYrcUjvGn+xp9aSiNp1FwD3V4ZKmbDm6TygxvMGBesXRTsz3qCv2oXT1qr0A7eZ5lZ0
 ogEWC4zuVcuVw3Dp1EeInPRtRddzkf8B9obtfnNlYrqtQfMusShGVcNQ8KHoctDX43d4PTCtkFt
 /e6mpFTmp1oSE2iG98bSynZ+FQUnQ7yZqrQE2JqHednXe6brRWT1Xn5JC9NaemANFXIJOubXsGe
 twFF24gQjcOsdKB7UyC1Z3xZvGX+5NyRX0XG20EEj5ywuY=
X-Received: by 2002:a17:90b:4fc4:b0:38d:a150:ee04 with SMTP id
 98e67ed59e1d1-38f9bee9096mr2142153a91.30.1785414434964; 
 Thu, 30 Jul 2026 05:27:14 -0700 (PDT)
Received: from junsungpark-QEMU-Virtual-Machine ([210.97.63.13])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f9b2844e5sm1021765a91.0.2026.07.30.05.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:27:14 -0700 (PDT)
From: junsungpark774@gmail.com
To: tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Park Junsung <junsungpark774@gmail.com>
Subject: [PATCH] drivers: drm: remove drm_simple_encoder_init then inline with
 drm_encoder_init
Date: Thu, 30 Jul 2026 17:49:08 +0900
Message-ID: <20260730084908.109270-1-junsungpark774@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

From: Park Junsung <junsungpark774@gmail.com>

remove drm_simple_encoder_init which is noted as a unnecessary
intermediate layer in the TODO list
and inline it into drm_encoder_init.

to achieve this,
declare and define drm_encoder_funcs with the static keyword.

has been verified by module compilation with no errors on modified area.

Signed-off-by: Park Junsung <junsungpark774@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index a026bd35ef48..52d9bb46ea95 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -44,6 +44,10 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
+static const struct drm_encoder_funcs drm_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static bool qxl_head_enabled(struct qxl_head *head)
 {
 	return head->width && head->height;
@@ -1169,10 +1173,11 @@ static int qdev_output_init(struct drm_device *dev, int num_output)
 	drm_connector_init(dev, &qxl_output->base,
 			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
 
-	ret = drm_simple_encoder_init(dev, &qxl_output->enc,
-				      DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, &qxl_output->enc,
+			       &drm_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
-		drm_err(dev, "drm_simple_encoder_init() failed, error %d\n",
+		drm_err(dev, "drm_encoder_init() failed, error %d\n",
 			ret);
 		goto err_drm_connector_cleanup;
 	}
-- 
2.53.0

