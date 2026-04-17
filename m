Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED9EF8E4AE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CF510E95A;
	Fri, 17 Apr 2026 06:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sLpqCkuP";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6054F10E96B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:50:07 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-59dea72099eso302615e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776408606; x=1777013406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkFD0nTtiMecWdiMYsq45f5KZ8ZJ53Zo2JaKZseIkhs=;
 b=sLpqCkuP7vwnwlbDxnf6mvu77GV1HT13MCIFl9IqadliKPO3LyqICYKMdjG9OGPgYa
 F0gaACHrbKexuY7N+MTWx5XIBwAp6/3O2O6hmKs+jueRUS9dRH7eoR47nxfKlasfu183
 k0MlBFGowSWaoLxYnRQgOC+MbY4J0Lnpwilwr4G9p3RBU4A65n2km5DTDo6lApwGn3ba
 zzTjuP2nhaXJlbS+z5X6o92BloiuEisCYihDfhFkKqj3Si3tlmxnr5HSWeIaozo1FMv8
 x8+78Is14Mc4nDlgB69+Qwfuvg/jbU6/09DSqeCs9A9//zjLhcemCZtsU7Lp5e1fe5NF
 438A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408606; x=1777013406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rkFD0nTtiMecWdiMYsq45f5KZ8ZJ53Zo2JaKZseIkhs=;
 b=Qqs7naUHqGbatz8tUjidtuSleCi05e5SrcMxuRtM8x/Lo8lDbsr/E4SQJwnzbeKBc0
 N0WgptOXfTMMJ2+kw0uMUJL0ehK3U8jigAeusHDUinjmoJZCP/AX3nDx7Dg3xeJLXUoN
 ykfSk5tSWL4bxeni/sW45IzJHcx5/RiFUoEm4Nn7sAiSgnFswNOZsHygLSslxFHJfVMX
 h/scJUhGetODBYpPXKJQeenbLCb1fCp9G2zdN8r9uSQXVkqrU6ZnSwzrdQQ11ZOfimvt
 3szcwbcCjR98Mfthc3zskODpRMnM/Ln30gqnVylKAQ6h1C7QzZwBQFoy3wxnbaAZSZ1p
 8GOQ==
X-Gm-Message-State: AOJu0YzKUT6LZ8ZyEmX75ju5iXPR0x1UfaSFktzijiH8QcQOhbO8+0wU
 t4trNCOyotPX1d+RkHl7k8Lrc5W436ZOXjz3z76vjcTpk11EZlkrZiwp
X-Gm-Gg: AeBDiesFYCeiUyGvqrZ3L2xjQQSfTsN4yXVBwTVmTcpmM/j5bGgiGh8mNBP36eIKUIm
 TcBDZcbw6DlWHymSWICyzQ8T5BKsFEkjPT5BW61SwYvopY/1QnqKYDuHlnasTqaxlSf7hA6MKnd
 BcHCBwC3fhz4gcw0eisSZUr2qZ4xjfOjiqEdCLxsIX8f0cUpEFZolm5+b/0qf7U0YtI3FmHY75V
 r7byD1Ddi54lBPvVtYpJyZPMVuKTrL79siDFSOrDDIbRPr7zSDDvS9ove6JPHIfxW147VB51ULY
 qTsoFs84Jm2/jDIQK6E3WTRTf+7+7rdJjFQGv7g4DCDAqxaj86CO8mTVGpXYTk0nkopnWRO29tY
 rKR1uR31Xf3g05YR1KzaI1SBfsHcH34Cjc64GZ//CIuziTrtE7QRpm7ZRFwN7tOFk1TdaDelMBe
 oxS7CiaTMLl/r9y2uHn5NB+r8=
X-Received: by 2002:a05:6512:3ca7:b0:5a4:d34:5b38 with SMTP id
 2adb3069b0e04-5a4172b7ba1mr423053e87.2.1776408605519; 
 Thu, 16 Apr 2026 23:50:05 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad143sm153202e87.7.2026.04.16.23.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:50:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3 RESEND] drm/bridge: simple-bridge: Add support for
 MStar TSUMU88ADT3-LF-1
Date: Fri, 17 Apr 2026 09:49:53 +0300
Message-ID: <20260417064953.20511-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417064953.20511-1-clamor95@gmail.com>
References: <20260417064953.20511-1-clamor95@gmail.com>
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

From: Maxim Schwalm <maxim.schwalm@gmail.com>

A simple HDMI bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 8aa31ca3c72d..cc13c98f9be6 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_match[] = {
 		.data = &(const struct simple_bridge_info) {
 			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
 		},
+	}, {
+		.compatible = "mstar,tsumu88adt3-lf-1",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "parade,ps185hdm",
 		.data = &(const struct simple_bridge_info) {
-- 
2.51.0

