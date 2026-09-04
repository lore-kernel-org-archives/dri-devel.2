Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4F3C79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E4210E603;
	Sat,  5 Sep 2026 15:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jKAAuPnW";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC0410E551
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:07:13 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-499f6e0bbabso662335b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523632; x=1789128432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gRzwySIKet2vXTJydQDUqffQLNKueIf8/ii+qy4BsUc=;
 b=jKAAuPnW9TjCntO5f+V3WgFadKiLwkj4SDpxV45DgvWZxgLc9YoNOCfV2pxwvEhKq+
 0rgqg6DO2at6Xp/RvJYcldAF+fAne2ieTR7RBn7J5TSFqXvey1ri3EK1SccrHKYfy2bF
 P0h84a3cB1+9/abPAVPVe0qYBqwPeBsnt1ixArhjYYcIRqJd1v+7n/UUriY33+ZRMXAe
 W6Qprr71kWB4miyEel89dpbdt0l4yUmcus9jut7W5YE6jIyf+rfDJWIF0RXPlFG4+v4E
 n2WRyfd7N+jDt8jpjnKahtvIJI0piA/7iV8uOhwKqQS1v/4sRpklgaOH6RarrFcgXFxy
 MfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523632; x=1789128432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gRzwySIKet2vXTJydQDUqffQLNKueIf8/ii+qy4BsUc=;
 b=QjOv0m2aLLQaXKEDOnhh6if5YGI7gIbPHYR713hr4KiDtPsvHwmXV4Y1urSWSSrc62
 QKeu+WMHWuWJ6hsPUj/fWZYwyVghbMnJ0YVlRVqP7JKdUwv90UkRBAnH1hPUYU+Jlslc
 u0Aa2i8VLYZSci+d7WDhVycDznXWr6a5i9o8H4tYQeyRxafw4TkNV2wm/cCO8L9au4dw
 fbFRFrxyhspfQCNA7ANkiuyzzoRBZmoutJXdLoKksj2WR99yl7xhubW5iKmzlhKeEoJp
 YsXLZWwd2sbcNg8r7/RpRb8exDX64Y1y1dB+XVqmLyutJiU0+OlNdFMdYRa5BGG6eB/p
 cZmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAUfm1yqEybiMQVlnYgVyv82q44UZOiXnWdLasLhj2iIlyNvk/nR7HWz2X/E8ukPHxnOkC4Z1xVRA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nT6B2sBpzRsv/4GWuISmFZJtuhaxY//eLN/NoMm/o4ZnPEPPEL
 xIIzLsRBGpcvd7RpRx7OB24XCmx6TgxNX31V2YWFAddLnqVL+5yJPzoH
X-Gm-Gg: AYBFou2a5Ti08C7qcGRKba7BSuN04g/cQNVPl5wTW3m9k8e7wDDj8FDb9iARlxQJ1mS
 pu+ks7JSLcZhDUGfYqL4NRoudZ/bYRtvJSkwxDu+tuJy4p7fYHe+Bbrx0s14xVsMJ97/ut6osL/
 /FF3sKBsiP1qn0oIosIH4uFzWESmj5k/lR+qcPZktQnNGYl6ftjPePrhNPoLNdcprk8fzD8F5AR
 Kck/irFq2dD1PI32ofiQGVELN8eiMDRUi3j0TpEY1o7oqMy33OlBY90DA2ehG39PWPN06bopEIK
 sTzvQp5HaYjtmmUC9ae7YRH+ZFUSwifoYJyHvPTexfQlZPk0musnkqV5Ofk9A5IjDbFkuHJZppw
 XKKWHPrUrxWXXRo7ghv3BPrc2/nG/9/Mr3bJdatDTriyO0V/1idul/u4AWW1Q0WdqabN8fjuYvB
 tRKPI8nsheSELn8qvs3UXgVBwiv6+lbHyZtcDABzpq5Xmm+99MwGkm1uNxD6EeaxJ8jBkJMK0aX
 HZM4XZEGwz7kH8=
X-Received: by 2002:a05:6820:4c09:b0:6b0:5bd1:4722 with SMTP id
 006d021491bc7-6b6faee256fmr3944633eaf.13.1788523632473; 
 Fri, 04 Sep 2026 05:07:12 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm9247100c88.2.2026.09.04.05.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:07:11 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH] drm: fix typos in comments
Date: Fri,  4 Sep 2026 17:37:05 +0530
Message-ID: <20260904120706.19154-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c    | 2 +-
 drivers/gpu/host1x/hw/intr_hw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0d2c0ab0a63e..d69c0153739f 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -520,7 +520,7 @@ static int tegra_hdmi_setup_audio(struct tegra_hdmi *hdmi)
 
 	/*
 	 * Tegra30 and later use a slightly modified version of the register
-	 * layout to accomodate for changes related to supporting HDA as the
+	 * layout to accommodate for changes related to supporting HDA as the
 	 * audio input source for HDMI. The source select field has moved to
 	 * the SOR_AUDIO_CNTRL0 register, but the error tolerance and frames
 	 * per block fields remain in the AUDIO_CNTRL0 register.
diff --git a/drivers/gpu/host1x/hw/intr_hw.c b/drivers/gpu/host1x/hw/intr_hw.c
index bd5b5ef62f35..afb68e47ecf6 100644
--- a/drivers/gpu/host1x/hw/intr_hw.c
+++ b/drivers/gpu/host1x/hw/intr_hw.c
@@ -93,7 +93,7 @@ host1x_intr_init_host_sync(struct host1x *host, u32 cpm)
 	host1x_sync_writel(host, 0, HOST1X_SYNC_IP_BUSY_TIMEOUT);
 
 	/*
-	 * increase the auto-ack timout to the maximum value. 2d will hang
+	 * increase the auto-ack timeout to the maximum value. 2d will hang
 	 * otherwise on Tegra2.
 	 */
 	host1x_sync_writel(host, 0xff, HOST1X_SYNC_CTXSW_TIMEOUT_CFG);
-- 
2.48.1

