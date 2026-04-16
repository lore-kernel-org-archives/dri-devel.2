Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C858DF8A16B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E6B10E1C7;
	Thu, 16 Apr 2026 12:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LMSbVFDe";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C3C10E1C7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 12:09:33 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso2962637a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776341373; x=1776946173; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8l44xHaLOx+xTMPQRoRD77brBCTj78T5PJ1Dys9zxMU=;
 b=LMSbVFDe4md3/8uPnmkDZ4Y0yQIusTlPUye6ELAqlfKZDfSSKw26Ppzt9CyQ9J0AfZ
 NhsYHoVHredErRElcAG8dHCjKF5pkxckSC+ndaFx4NKT7b5unQ02+IxFdNMkswqE9Oxb
 dnbXbNrRxUEO3JRKOrc86YuU2JasMuV3Z9RzHTmgCSotRfPIDGWxKnSQw2myKpenYs+7
 sOzjFkISik6//YRX6wS2qDcWRJyIT2xjm/T/UVZLHmNxqCqhZvRU9qZxYijGop2Lmq3y
 zZjVEdtqU42O7BxxB2EgdE9+tYvdpB/a4GYn7mNrQI0jteT6KzAJb1eFqgzVdy2hLLeq
 VpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776341373; x=1776946173;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8l44xHaLOx+xTMPQRoRD77brBCTj78T5PJ1Dys9zxMU=;
 b=TIR0ewj5hiblpsdFA11pkLgcMUHu8NmememLfd3RUQv9fS0ui3hDTDP+GHAzRNjYat
 2E/dT0OHAv3JsWUzYCW/gm74+9ItmyXTJ4p8ptfYa9uROFPIUk+FAFy6kM3aycFYvr5J
 xHFK80aJJGC5bREpOlnoMVMnRgUfCGDSL25fMl3SQpL9rG8Zuea7C4pzBKGV6OsQwHXn
 zG+7cshMfzNHd5ukSrkcOpQhN1MHY/WXo89BrQpHnbEzGLd2ykVBghNbVDg8y0H/upXT
 HZqnpuJngh8SE5TnsAe3xss8IxHy8XxO/7joaVTBT7OhOLUjumdgXxXpBgomdSyxcW+O
 MVyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86RS6gvWLiDrU1ywz41zWkeV8C7d0qz75w0a+W2w5/iiR8Mkm7xqL/etSuiNIh4M0CLWmZ2Tzsuaw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPa7aHZitNomVoT+6/GvB3lT9myuKDXaoLygyms9CnuwHvUnB7
 2p9v75NA3ZRpnCsISovpe25+/R5rBq+y+yPHm6jvadtdltwgGF2tQm6bz9EaS0qzis0=
X-Gm-Gg: AeBDieuYsO/Lz4+2VBwOnOYmZUrF6H3TbUV+mJ2JI19K1AJWAc8G4gUhPXr+Ojhqp+i
 Fj7HATb2jWFxZCc3TE1wHjNx9V0PB+HWwSf9MaF224r0EugxZga24M4FfcZ002tEco2nEo5jfhX
 08y7BwBYavfJM51JX5iAH7NQvPhJbV4LZEpFI0scZK59eybBVRcF/yGdZQS3FTBTCCt5haeInXo
 zWcXAy7OzAb1kSENXsAlIkARUtjB2xPAfFTR7P7WUBuzFdlKzKUYuyAm8mwqASlPIRcvS4yCj/N
 59Sq7rxEEu9u4QueeJiBVYRunUiA70t2tETP+6Be2RBPrAL1/hI398Ce4fytC4NGOGvNKB060lM
 SYc3BL8omWJRHLvrf9nmGeXLrFs5TpiUMh7h2RscSSonkH3reeDKBcOhrxlYfF0qFqP2KIFI5kz
 AaRVuTHUAAsQzxRjZsrhwuuDZGGGl5oeTlCsYaIhqVGu60k1xWmfl6B47Q14AwG0uPBoNh7tLN2
 4tC44s7jmaQMalwT5S2A9qkCE6zaF8=
X-Received: by 2002:a05:6300:6b08:b0:3a0:129a:973f with SMTP id
 adf61e73a8af0-3a0129a9ae6mr15918942637.52.1776341372798; 
 Thu, 16 Apr 2026 05:09:32 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79581d6341sm4245089a12.30.2026.04.16.05.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 05:09:32 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 16 Apr 2026 20:09:29 +0800
Subject: [PATCH] gpu: host1x: mipi: Fix device_node reference leak in
 tegra_mipi_request()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-mipi-v1-1-9c027175abdf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHjR4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3dzMgkxdi5S0JOPkZDMT81QTJaDSgqLUtMwKsDHRsbW1ALbbWvN
 WAAAA
X-Change-ID: 20260416-mipi-8dfb3cc647e4
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776341371; l=1103;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=knUH34kPAdl0Glqyp0IYrLw7Xc3rugSSyGH/rGCenqQ=;
 b=ufNI0wiXlc4OTOmmF0jxOLfRsiv8Bi35YYGkHIae5wkX/CW+StNB3w6KThINmGtHYzUbUOplE
 oltVs94d89BCzlnacTuP+TWPLL1gsEx0ZPZM0QE7qiWj8nQ0EB6728V
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
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

In tegra_mipi_request(), when provider.np is not equal with args.np, it
returns without calling of_node_put(args.np), causing a reference leak.

Convert to use the existing goto out pattern to ensure proper cleanup.

Fixes: 767598d447aa ("gpu: host1x: mipi: Update tegra_mipi_request() to be node based")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/gpu/host1x/mipi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
index 01513b775d89..988681423981 100644
--- a/drivers/gpu/host1x/mipi.c
+++ b/drivers/gpu/host1x/mipi.c
@@ -114,8 +114,10 @@ struct tegra_mipi_device *tegra_mipi_request(struct device *device,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	if (provider.np != args.np)
-		return ERR_PTR(-ENODEV);
+	if (provider.np != args.np) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	mipidev = kzalloc_obj(*mipidev);
 	if (!mipidev) {

---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260416-mipi-8dfb3cc647e4

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

