Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF7606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tq2z47aH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B1F10F036;
	Sat, 14 Nov 2026 16:25:10 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8259D11281F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 21:45:32 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso8871465e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794606331; x=1795211131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oMXbsyiEGd3VJre2l0muSyjhtmpej/ppRBC0ERFe5Es=;
 b=tq2z47aHZN1dIuuyvllGmco9OoVdMnL1tLP56ias/YjeNLMP5YFI/k/j8wKnQ0b8FL
 ny0/7MdPOQp1twUGq4p6s2vUC9VBxbsRuY9Dx1LEuw8+nlAMwyDi4v4sVr5T1zmuTJfF
 cS8eun4AS503xh/Hea+3VvhxBYEsEBlx+8OLv6vEAnV+bUXEP7AUTACkVDUqgdO637Ok
 00hnN7gL8YKj8oSk+h3PRakxDdCzmFTHWfKG81k7pNV8GtriLNOIe58LeZCEtWS3CnPv
 J0WokEdRapKFbkScElrbPJiKHHe47jNd3Q0j/PgkPSo5xgxvd408XO5LjiDg1d1qcT5+
 LgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794606331; x=1795211131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oMXbsyiEGd3VJre2l0muSyjhtmpej/ppRBC0ERFe5Es=;
 b=aEZ9nbyE3025jE9SpNQJuj9OtWx5UwhwvYzqWBqezumJFl5gNkEn3+kPo8FQrwWOB5
 xb1Ij6ZGCMNK9F5guh8mHgpuEU1K/QtS3b3qVlxJJH4cCbKCitm1VaQj1CzkT2+F1dYc
 lAKbL/T6gJ5b9d0ix2IYCcOX7L0l/X8D6qVu2wepTvWyAHGg/rKDG4BVqVswPmivnRX0
 K9+Bea6JikC0j0dsqZHTpA3YdAUm/tj8BrTvXO8dU7Bs9m4enHvw2WW2hA/b81S8aUOC
 fsrGorJBSQiCjJJd06/0rg2pK3M/orw60X54Bz/yH6YGZ+/NPl6s91gW+064biyvAzgS
 amEw==
X-Gm-Message-State: APuU4Z+DSn9XBO0WDA34l7+47RgalKRu/0eeqNm7m/p/y0MaQv4g6aSV
 +xPkDKznPtkJlBgIfwCIaf3MGHt88IC8FvliIkAIS63U+2dmc9eOsA7P
X-Gm-Gg: AYBFou2KPuJ+gKqJwS3oZyK6S6YDNdLduFq/nFcg+wZFusnAThvnCNvmGt2mdDw78d2
 NuFmsn5n236uDYZUw3vvQAn9TJI48OdvZ0+jNFF8a2i3oyOfhl7gxDXxgzmjSvrcubD7WVh//3k
 xC3NeRFEbrEPs1t7jSoqFJuZnPsBCHcPEL0sc9JgM7fYmA5jk7mRhf0Ha7KdcIvjJO4HOcbnN2T
 6udkvsVok0hYMb147Z+J23r1gx5KbAAVrHFohUPU1OIRd4TDnjMG0IjCtgTHLGisOKWJ21+ZhrM
 qZKyghL9MEhlY6SMTUiYkf4Du9gQCcqMfYOFNJmkq4n2PDEMVv7cqSK+RIT1LpHIu7rnqyexvVb
 mN0YWBA00gAQVmcE/FMkLd6fPBpks1sR3rbLHdcCFikqgTnQX//zfO/6bj9ypYSlZ2v86qZiltI
 L/Lve+b+ozOj/1xjXx2fU+qA7qKg1UQJ3HQ3jIvx73gC41uqxz1uWD/L37fKGehUgTXaDUlPL8V
 kTGJsNOPIETqri25Q7et4eUWUWt9PDCer4lL6Ki8YaAv7ACytMvQlaIDK2LxSNRA3ecOU2MQy9O
 1hVBJ68DJWxF9rtMDAiSay4Z/L9DQOy4PnFXojZvtbruAHzKJcM=
X-Received: by 2002:a05:600c:46c9:b0:4a1:f8cb:7d70 with SMTP id
 5b1f17b1804b1-4bb55aa51ecmr89431065e9.24.1794606330704; 
 Fri, 13 Nov 2026 13:45:30 -0800 (PST)
Received: from vivobook-s16.fritz.box ([2a02:908:e843:f280:6cae:291b:a1:8362])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm8542479f8f.0.2026.11.13.13.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 13:45:29 -0800 (PST)
From: "Ingo A. Kubbilun" <ingo.kubbilun@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Ingo A. Kubbilun" <ingo.kubbilun@gmail.com>
Subject: [PATCH] drm/panel-edp: add BOE NE160QDM-NX4 (0x0d25)
Date: Fri, 13 Nov 2026 22:45:21 +0100
Message-ID: <20261113214526.231324-1-ingo.kubbilun@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

16" panel of the ASUS Vivobook S16 S3607QA. Without the entry the
driver warns "Unknown panel BOE 0x0d25, using conservative timings".

Developed with the help of an AI coding assistant (Anthropic Claude),
which drafted the changes from the Windows ACPI tables, existing device
trees and test logs; reviewed, built and tested on the device by the
submitter.

Signed-off-by: Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index bc16d6e30a5a..6ead44ca6d7b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2078,6 +2078,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV156FHM-N4S"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e200_d100, "NV140WUM-N64"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d25, &delay_200_500_e80, "NE160QDM-NX4"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d98, &delay_200_500_e50_po2e200_d100, "NV140FHM-N5B"),
-- 
2.47.3

