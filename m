Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B30CD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A800210E5F8;
	Mon, 15 Jun 2026 19:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifamvkoi";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7112E10E5F8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 19:36:01 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-9159da9bba5so278180685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781552160; x=1782156960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ilAD6oyPZ7+Z6NH640c4kq09bsKFwmP8miYWEEZmjKc=;
 b=ifamvkoiC4tCVG9RGMu/kXyCzrmBZX0vagr2NEkweTkZYl3IQeELnUTV0bQpixPlTA
 rm4gVwddHFT4nwlUiGmNk70QE5EKTbfOSO1uYI27fai7x8Jc9J5xGlPX+cWiOhhy0TUa
 r/LRcxvIgIl6SwTbcvMhsq+DYJKGTBF1BQF7HKQN7B/bX1GOjXJRLle+IhIQ0RWLCtKw
 XcY9z2Ml9W/f6w4uiNbL6KLMUjIZatjqGAh8Lno+Cz+9vNU5XJo8anFFq6KWF4e3rM4R
 9lO7C3KoWVg4JzwkWoj+AwFZz+u1P2oOtiddB7eA0lNFJuAp3YFEGYldEoJYdKzHhGi7
 hKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552160; x=1782156960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilAD6oyPZ7+Z6NH640c4kq09bsKFwmP8miYWEEZmjKc=;
 b=JbT3hSp/IgF5TBPfxF70bkBEtGVn5Q3kMaWWxQAmL9Q4DcmnEqRD+tvSc4PG907GGu
 VUkGnZYtDV1PgRtZQNC4E4LeTZ7QO/2zJgDtVglckRK7J8E24CLUIsrQ2CAtQnj8YftI
 EeCa0aXDYhrAfWpCGSiF8M1E9DUItiJtG8fxiVxIcFatCfyqVGagmhNxRlxF5iYWi/D3
 8iHkLg1Zi9LULzmURQD5P0fclcXSLgPwKWSi1tOsFwv6ENpfEo+BEVX9qAv5xZbfLhJ5
 iqEQwkyfOCR8dC/HJGHrP4aLxla9g/pftKq3kjaX7BxCC39dlFmvx9P9amJKp7wUhDKx
 x6YA==
X-Gm-Message-State: AOJu0YxhniaHJWpcMAdldPI89/4IeTGa+NM1qcRmHgoPdssXkVUhOd3Q
 fr0zJc42XQMsTTlVrPmfaiNNsG688ZbdOiBZxd5IiHuoM16v1B5UA7zd
X-Gm-Gg: Acq92OGYtMY7esZOqsf6tq6+lPZyKQiVC6yTIFERtUqyxhxupFrCj8/zvmXayzhgbwD
 IsDKyLVnQGGeS2SElyXKJKM7UEXeLA1Z7yAUDGvZipZnE0agmwB58rjYsi5A3TuFEjV7HBO2w+o
 S1JC2aPh+EYjC76phxyKsX02E+o3n/8HAJtiU8yVzp8Mn0cURLAqJ9mL8ZDvzPuVU10hxpX5/q4
 uUt+4hoB/0Xc8lAeg3QWdcjVEVBhssRSudVoa+1Uyw2TllDDm0cgxu+XI2SSxQehDEkRDSov/6+
 zEI5HS/Dx7gJj1iMQB8LMgzTE6tj2WDMYFA+E+KjjmmrOcrN53GkRfGV5ajJRF9VbFAgMPc6Lgv
 WZI3wRu6jZkjat+FZMN/pnEkCGJChBOVjUupphRLlMW8FqnIaqv7Ng43QtYoloH453cGV0+/iZ6
 FcBT6rM5u4RBeI5drEubfE8LT9dugrmWPuLEcwmQYa2Z39lIxU/F8=
X-Received: by 2002:a05:620a:19a7:b0:915:7732:ea7c with SMTP id
 af79cd13be357-91c48072442mr80258585a.43.1781552160197; 
 Mon, 15 Jun 2026 12:36:00 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00af50sm1319190785a.30.2026.06.15.12.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:59 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/mipi-dsi: Use put_device() on device_add() failure
Date: Mon, 15 Jun 2026 15:35:55 -0400
Message-ID: <20260615193555.757498-1-dbgh9129@gmail.com>
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

mipi_dsi_device_alloc() initializes the embedded struct device before
mipi_dsi_device_register_full() calls mipi_dsi_device_add(). If
device_add() fails, the code frees the DSI object directly with kfree(),
bypassing the device release callback.

Drop the initialized device reference with put_device() instead, so
mipi_dsi_dev_release() runs and releases resources owned by the device,
including the OF node reference.

Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..862d56eaf934 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -233,7 +233,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {
 		dev_err(host->dev, "failed to add DSI device %d\n", ret);
-		kfree(dsi);
+		put_device(&dsi->dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.43.0

