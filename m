Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E231CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7378210F2FF;
	Thu, 30 Apr 2026 10:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QRJYvsJ/";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D786510F2FE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:45:35 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso6542255e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777545934; x=1778150734;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7/qTgiSduryCJLbI+Aigbf7KhKUJKWDOpYZhzDaMIs=;
 b=QRJYvsJ/piFCD+Jst0xwXjvHVFBMEyM8Sj/EYDJNoe6WQr3A9Gusg96aWuJKF038o3
 L+zv3voSDmimSoOcWr1MCrJKx2EVn0x7GAsptFYx+ZD9yO7/JDcTaUQWu2IWTjuCSGGr
 qOOkH4bzMmIJOfY5ij2Zl49+yKiwfwVuk2FbBKNuk8i9/YmGNhCyqesYKcizsVbOiRNt
 8uyRczD4clLoH8doZNpp7QUxQ0A2MiNU5H+c5AvLmNzxLyL9GJr1W1Ec9xdkoYyhQCkD
 EGQqSxdgo/Y20tYCpFzSyG26iec6Yo7hTlObNdHV3dmm9GNRdoxqJ+hmMbykSxQfVbGi
 4TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545934; x=1778150734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7/qTgiSduryCJLbI+Aigbf7KhKUJKWDOpYZhzDaMIs=;
 b=LYDYiaalbi/MKVLXSZil/QafaVgpCabHtJP2QjGo1dOjxsXu9fzQhxorQt5AJCn+Ww
 pjRBjwk7eiSN5VnMxKASAjJsXGrYTV4SFGiqy0Q03+7Lw5Qwkr8UFbYyebAAiW682Cxs
 uHRcJmt8lKcMgSOk0I3s54Zr7qPgdQB7g56ilNCBm6QWCw+nrKZOXXajK4407oWilKXY
 8dQWXqLU2FnejMrxTJerwFkycjIUzC3XSIKblW5fk1FZO5lCcmYs4FBUGuqW8+PlgqR8
 s0zvC5qjkIeeSL3YmcGI4uWeKfdRVQPSKtwJzoOWd4h9az9khFgljOKV7xp7dFVEMiw6
 WPig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qlxG8U3I2XNyiYVQ0ZvwIUMPZwcwTsVIkDn3NN77j1QIcZBo9wdSeekJf+rSfZxGXq5SxH+/eByY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFcUYcov5s3SwNdQcEbmAfgswKX0Uz7/p52UaEjBH1AA3j38+R
 1UEzGbP22//Uh7yeakZiGCTJxPQRHWnHYUVDxpDMWtZw3sZ9VcVpBV6HOM/98XuWL/E=
X-Gm-Gg: AeBDiet08ixLFbjjqLBD/txbUvXsIIe9hVyVmgzPYC+esOX6nk3B3ee5NQMoaVQkYeD
 WChAfhzbikZqM2DXx1+wA+LCNcorJwioojcyE417uVuWP0O8Dl0Oxl1OvINuWBX2SbDzYOMyiUz
 yAU5L4HSNlVpkA2xWcpDBIIZXGpKvETgts1rqBiZ8tOSx8gK3lXH73+3wFjjL0spzqZr43lLZKg
 HS++Xzw5o2EW78032r5Vi+JhIzWihWf1juZbrQWp0W+C27bZ+DkFVZNRrcFjhGwnn+yDlCQTSHg
 TjScNYVd9ZAcO/PcePdeWhIM/hJTRkcDiN/V+MF3Rc336cpRk2SOYTtKNqQfC6T6MbTukoM9MTf
 RsACuP37A5ogPD1KstYwqWpUOPpzGjYy5oTX+R2SYjakjq+DDhnT7o2ZPqiaxP0KXAgh5th19t5
 M2HdYbykxl1/o79pxfX1gyj4sNl/+Ha8uYtivf4n5hySceClv98Tja5f7WWa/+vRGMKpB4J04Qp
 CAZh41Gh4oFp4QDdHeRKjntPA==
X-Received: by 2002:a05:600c:3b28:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48a8445e761mr39999115e9.21.1777545934335; 
 Thu, 30 Apr 2026 03:45:34 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08c77bcc4a3b99186a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:c77b:cc4a:3b99:186a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-447b4216675sm12376652f8f.11.2026.04.30.03.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:45:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v1 1/3] drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
Date: Thu, 30 Apr 2026 12:45:13 +0200
Message-ID: <3205129f75aba48bd1ad8fc810cf6a18e718206d.1777545446.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
References: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=bY5scivWCC2QTs0wJVID2C581qyzm5bKb6i6lvmbw90=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8zK7aEIcNN3AwWoJDGoS/agY68a2msbkJcPsh
 3oyjs8vrbyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafMyuwAKCRCPgPtYfRL+
 TuyACACMhgpzfuGCItxt3QzhJzcdiZa65P64fB73yU0gyKraR+ZUZTsU2XoWs2O+O8tb+BEMMSM
 Pl51SqkvZplWq7c7HyNG0je4bN+VqaAFV1rTjhdxFJnpCiSM8RvViXhIWit9jldSEzi/mYhUtCd
 TRsCjDJ4ua4b0Yl/kG7E04KRkrtHzrakRxM87fBlVNWDN+nji052wLc3/2d7LP4LlUy/DepfpOl
 lztFEOZMxCrXecNq6uiJAN/SbOBYfplLEBUY7enDJsbSLJ9KzejtCTEsMHfGkj6uMR8xrcYkGda
 uWgBPuRhScstYs6wj+HzLpxg6mVY2MsI7HnQp77taovicElv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

The <drm/drm_pciids.h> header only defines radeon_PCI_IDS which isn't
used in the amdgpu driver. So drop the useless include statement.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8b71834a73df..1239fb32311f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -28,7 +28,6 @@
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
-#include <drm/drm_pciids.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
-- 
2.47.3

