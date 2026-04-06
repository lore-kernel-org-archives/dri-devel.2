Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE8EF4EC1
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 07:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B466710E1E4;
	Mon,  6 Apr 2026 07:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NGGTKKZ5";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F66010E1E4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 07:39:56 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso37405275e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775461195; x=1776065995; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkFD0nTtiMecWdiMYsq45f5KZ8ZJ53Zo2JaKZseIkhs=;
 b=NGGTKKZ5GJOceIQQkikq+ZwzQEM56EVtPB5R9cNXrlvNdB1xQPQq4OIHE+XGhKl0Jc
 GFJN/iK4SDDvuBTi4+zdD0Kny/wAlvSggS/vPRu+WbtDNFGjYLnnWeW6xdLSxHdWWjBe
 LSvAST59YVPkiewByMAWVa+Vvpgh9Zs9GckhuMsuDA9IskCNZFjKaO+cq5wWnnU09O7z
 3L2F1BR+SQgPd/BOd2ehksoRjls7mb9LRQp9XU9SssDwBCvK2rOxQTosSR7/xjJjZhBc
 51PxR6n8MF5oME/beF21xIDsefPBuertorZQn5szzinQf39bScNaTbCyEyI9RDiPTeWd
 2lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775461195; x=1776065995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rkFD0nTtiMecWdiMYsq45f5KZ8ZJ53Zo2JaKZseIkhs=;
 b=VWKAw1aZVkZGx/llX1kBrV1o1MR2XMjkSyQdw+UYY7LvWnZkIoImbA3s+l2Xp7hMeT
 0967r8014I/vaMGKEMFztXHty1gGgUcM5MuW82GDKSRcfNiIEt6DR42rlvZU2DDv55wB
 1u8FJMwpcvqCTk7P4AGmhtRllPakBjhbl6S+l5zuK/rV8NhBUwJkN/8xnsqTNMuN4erP
 +F+t1H0lJ4cKMddBigRO0/xurVf3KnfngCwM6sBFHARESZVmULk0hoix85jCttM1npVU
 QrauDgONsjn9q63MbQ3vkPiwAISyV8biRcsTJAtEdcYtz2XRM7CbBvDt7WVOmJaKtOaA
 wwPg==
X-Gm-Message-State: AOJu0Ywki321pXjQwnAYnpwXjPz3se2QimVGPbrbh6jR08Nphf8kCRo2
 VAO5c42U35f5LJALMMzPtoUcYkSSfOwP+R1EST5SZ9Bqb8gvjkc+BqsB
X-Gm-Gg: AeBDies0KMnL57Ck8yQ+g/j2hulMKZTWFFb4475yjFaUnnpxPI9svQ86Iwl/IlKdany
 MG7hYZQSDqzZj9nTZD4Ir6XlcedixzSrfhxcA8PLtzQAgU1Jwc32S5F4kKO9gOeUTlH2GKDtlTK
 MDyzVLRoqooCH2YdMd6JILmFiaWxViI/+3aX511YRs5vS5mm7qAgRMrsKDNTqG5eSt9jpCLf/JB
 NedSivka0yEkyIvBkToYuZbC+5fmZ7/iIqcivNldSeXDap6sEginLHIFRRRrOods2paRc1bQACM
 u66sUXtADEdgaugjDHMaN1Ny49CA52yhLCsOOH67+NXWUEMaSNFezxVPyso5go7leoHC2uHEku/
 HvWhn2f9qn0Myj+Ja0UDGOv2ubC1JxYI/a03up0mvGCPFqO5ZgvX9UduUB8EFbJZA+f3ku09532
 7pCGCRgTPgUIhK
X-Received: by 2002:a05:600c:3b18:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-4889970dbc6mr158926595e9.10.1775461194921; 
 Mon, 06 Apr 2026 00:39:54 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e83e906sm527201325e9.8.2026.04.06.00.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 00:39:54 -0700 (PDT)
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
Date: Mon,  6 Apr 2026 10:39:29 +0300
Message-ID: <20260406073930.24662-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406073930.24662-1-clamor95@gmail.com>
References: <20260406073930.24662-1-clamor95@gmail.com>
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

