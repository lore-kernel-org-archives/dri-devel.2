Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E1FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ABF10E443;
	Thu, 30 Apr 2026 14:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0oidcdv";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4469C10E443
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 14:17:52 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c76cce85bd9so369495a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777558672; x=1778163472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UAauNnnUvbl64aUzC2unbwx0Ap9yYy1g7lYHiG+b7UA=;
 b=F0oidcdvBYtw5AgKYQzWEXP2eMre9Tg1odWecOy8CUufdk4wwvdSXhUsJcq/7I50C9
 fmKIkPdvh5PSqyZQVN3+2ZVhNUuYJOzz5121Hg5O9GhFRNsXGZgyJj4gOFDa3e2w0erW
 78tVuUGuOfGgpDnHkiBGLAAvoQRfYn5OssQLNIOpi5jjh+lsnM4n7/ic4HFX+Z+HjKqQ
 d7lkTpQ/Ak3JK+bB41TdcQ4Fzdli3c6OHzdWwIeBfrFbJ4ebhSKVm+WX13scxcAo3vtg
 8HH7zteBbSc1ybqp2fsRG8CLfjqV56FfjRhtEVixdwOO4jpokqHbncf788ADCdWWB879
 Aj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777558672; x=1778163472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAauNnnUvbl64aUzC2unbwx0Ap9yYy1g7lYHiG+b7UA=;
 b=QPuklgTLTS4G//YrM0oVLUjTKUjcldY/cZ+AcRH2LASfSP/jPaDYq2bGXSudIBRorF
 lhtp7qyBs4DNxi1XVWfkHA4Ee30VcpwopMpbMx5eL0PZkiL7zWfhMxIWlNj9n7DfnJng
 aR2NnVydfSd47Tnhq9WLCLeGbqy/MjY7XRmVBCJwrk93g69HDSXDcNsJodpLpCIPA16m
 WhtZqMvKvZ9/ux7Q32d6ZUExLrU4+EeE8EL9DhyaYP6XLXj3WrCbqYMCPeXFCo5eEqVy
 B8yWsZkY0QsDq8pctwgbiffhrvmmz/k08iKkybbz+HjvyOPX+/sle3qfFFaUIbOHs/fz
 F0iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gzFlOQR5l6IW+2lkoL07/ImrS5O+InV6gEMn9OHS8QAxDwWqSMW4ZqR8e1liXoE/jKvpNkhSmUig=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/cRTUbh9ZCFfBDxLNSUjGUh6RwJ2F6wRbfopKDCCpfw3AQloc
 V++6WU4vm7WdhfYDbqnqphMPUaFM1VxwhBG51U2I7rsrjYYFc/8K3mQ=
X-Gm-Gg: AeBDiesyZqeZ93WZIHQGlzMdSUjo3kOc8fcVmWOP6t3gRw8yKwVE1HAV8Gpy3zt8Do5
 fjGPiFNHwhrkjMrxRmGQAgFD+f5Ao7ORWHzY7cEWeOZEaqNdjkDtpKOrLKtMXGS5zV2YBH16dtO
 yt0y25u5aFS+hegtx2O6sb1WfnCcHWe/fZ0Dh8Oeh7tO5DXtPIRSIghJfhre0T2auSTydXM0rxN
 KwYATj72lMkuJ+DFWSDg55D/r4mrRoCER+tvJiOgtC57lD3uo7YQMG6N9726oM8zDafbW5BP4D4
 nB9gSTP+iska4LrGEeWAZYgKRf7PX6SttTocSsFyV7VJ/pGhzDBxEsNe52pbq0gFTmsMWHW06rB
 Hsu4Q97TrnyhMDiBQlv3T5Nq63rnR/0DCCXeBbYLKnC53EJzFd6wVLeR/mMzIb6JVJsVITb7bjX
 JezRQq2B0t3E7H2x/JFF5VvAKXKROQBUHeE0N5NZif9UsQ17Ik6nC6Xisbd1HVlpXWs/JoFymEB
 bOGZPuC+Qxw6P5sdNK8elHN/qkXZmNUL89EnbpAXte7OLMrCaj9
X-Received: by 2002:a05:6a21:99a3:b0:3a0:129a:9748 with SMTP id
 adf61e73a8af0-3a3cf64411amr3702335637.25.1777558671481; 
 Thu, 30 Apr 2026 07:17:51 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd6514ec6sm4824456a12.31.2026.04.30.07.17.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Apr 2026 07:17:50 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=
 <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/panel: tdo-tl070wsh30: Use devm_drm_panel_add()
Date: Thu, 30 Apr 2026 23:17:38 +0900
Message-ID: <20260430141746.4214-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
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

From: Myeonghun Pak <mhun512@gmail.com>

tdo_tl070wsh30_panel_probe() registers the panel before attaching the DSI
device. If mipi_dsi_attach() fails, the driver's remove callback is not
called and the panel remains registered in the global DRM panel registry.

Use devm_drm_panel_add() so panel registration is automatically unwound on
probe failure and device removal, and drop the explicit drm_panel_remove()
from the remove callback.

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Drop the now-unused tdo_tl070wsh30 variable from remove.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 227f97f9b..2b4ea6f0d 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -169,9 +169,7 @@ static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
 	if (err)
 		return err;
 
-	drm_panel_add(&tdo_tl070wsh30->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &tdo_tl070wsh30->base);
 }
 
 static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
@@ -200,14 +198,12 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 
 static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
 {
-	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
 	int err;
 
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
-	drm_panel_remove(&tdo_tl070wsh30->base);
 }
 
 static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
-- 
2.49.0
