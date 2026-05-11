Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31829CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BFE10E4F5;
	Mon, 11 May 2026 07:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KncHPMb9";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2C510E4EC
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:46:00 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5a8c6fc5fd3so826193e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778485559; x=1779090359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/vo+yztL0AmH8P24goXzbtezovr3DoQGmWB3EtlnhE=;
 b=KncHPMb9d8tCYxQqj65cMbjOGY4Me7TOaWPRX81ElMDOjh1e7Lxlj0sTioogC/CLry
 e+wCO/yfoYQOrkcDFYpQ1PX5dSlNhMYRlZUt4MmMBWXlo2KQwCAYtFcNLwGpTBqH/mhI
 95T1BpM+ZB0/t1Y5IF5vFrj4/WiAdw7Fv2tJm6Qm1QDfeU1MphC9VNJb8lwfimQKNxbP
 bc5Mce3AOuAYarmiO4atZ0YOb/60TtlHUkxio2LyoM12qn2kewytWXWH7tKVQGAf2qlH
 pdwk6uckv6CCFkm0EyZewhEvwCh9sMmKvt/UMVSBW6P4cEBm7DS+dfWTukgN3PGEpiIg
 rRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778485559; x=1779090359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/vo+yztL0AmH8P24goXzbtezovr3DoQGmWB3EtlnhE=;
 b=eTyp2uW5KJusohL5bn9Kft2PqWChsnwApNzgUgeacTev3Sq968HTTq22eg9R5CdiIL
 7INRgs00R0Cf5P5Kxqw24j22s5ZBgAPmN44CB7PdsoBrJA3wz+ldlLs4vFuNG8gy2xm7
 Ea52XEouczIKU5w98jzE5leXPZV2Ow0qAlOo5X+GkVTKnpjd6LLSq3uHXvW7Ed4BHJzi
 lXXo2LXo2Me7awa0gfA3jOgm0VBBP1oAOVXqqkPR9KF2PnMtZjjqvmtva374JJTg0Lfw
 yCZE2bmCIfXhalvCAm1LVB7BU3S5PaKSg3mYBVNyqH2u7m0JBKlTUMoG62zvfBLQOsnQ
 u7/Q==
X-Gm-Message-State: AOJu0YyK5/8wP766+j/t1Yq4+FnY8XfzwF4ojyhnU/ay27A3wgvMo846
 zOh6SIfyrCrp670yKFuHsxZdqck17zZnCnFyEOE3iE803YSbCBz2IPgq
X-Gm-Gg: Acq92OGTqDN/lOR4GzSVuFrYs75uHQwTOZpzLwx+Kv34XvPOg6ZC5iJ2ireuU2MhgDm
 R0/A+vPb1Tt+JlmhPzEiUzRjxI7hskOl9gy8rQvf0Ngu/QpyfFPyA57vgaSfFlESDZPr6jE8w1M
 3r/FjFUnG/+r6bYvOQImR/0SKl/oRwIEbTqby3x06G4TtdQAcWCJdkWgXOITCTOkzvwYygnXZIh
 7huy22GRNghbDedsFCmier2m061VvTEn6qaFOSlANJZSicfc7UFWfRusTf8yK4V13Womzmmr2iR
 P8zDKE1RxKOeXhDLnhapO9/EBhguirzItV3o5aojU1k+kbGhRNM7/RXSrNoKgqrB47msegP+GL4
 lIswPKHsj1+o280Dc7O4KLm4q7ZWjWvlrbfJIygT/uhMwueOTDttXrDdH9rLELBpjS3DLk6oebK
 zb29SW7k5Vcaf6
X-Received: by 2002:a05:6512:114f:b0:5a8:6cd7:3203 with SMTP id
 2adb3069b0e04-5a899b90511mr5387467e87.3.1778485558513; 
 Mon, 11 May 2026 00:45:58 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a952705asm2404394e87.32.2026.05.11.00.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:45:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2 RESEND] drm/tegra: dsi: re-add clear enable register if
 DSI was powered by bootloader
Date: Mon, 11 May 2026 10:45:37 +0300
Message-ID: <20260511074538.24563-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511074538.24563-1-clamor95@gmail.com>
References: <20260511074538.24563-1-clamor95@gmail.com>
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

Original commit b22fd0b9639e ("drm/tegra: dsi: Clear enable register if
powered by bootloader") was added to address the issue of DSI being in an
unknown state after the bootloader, ensuring correct panel configuration.
This worked fairly well under the assumption that the bootloader had set
up DSI; however, in cases where it did not, the device would hang because
a DSI read was called before the DSI hardware was ready.

Removing this workaround results in the issue described in the original
fix: the panel initialization sequence fails and the panel gets stuck in
an undefined state. This is especially noticeable with command mode panels

In order to properly address this issue, the original workaround is
restored and placed after the DSI hardware is prepared for R/W operations.
This fixes behavior for both cases: where DSI is set by the bootloader and
where DSI is untouched.

I have tested this change on Tegra20 (Motorola Atrix 4G),
Tegra114 (NVIDIA Tegra Note 7 and ASUS Transformer Pad TF701T), and
Tegra124 (Xiaomi Mi Pad) with U-Boot, using both bootloader-initialized
DSI and untouched DSI.

Fixes: b22fd0b9639e ("drm/tegra: dsi: Clear enable register if powered by bootloader")
Fixes: 660b299bed2a ("Revert "drm/tegra: dsi: Clear enable register if powered by bootloader"")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/dsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index fbab10bc5c41..e7fdd8c7ac12 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -936,6 +936,15 @@ static void tegra_dsi_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
+	/* If the bootloader enabled DSI it needs to be disabled
+	 * in order for the panel initialization commands to be
+	 * properly sent.
+	 */
+	value = tegra_dsi_readl(dsi, DSI_POWER_CONTROL);
+
+	if (value & DSI_POWER_CONTROL_ENABLE)
+		tegra_dsi_disable(dsi);
+
 	state = tegra_dsi_get_state(dsi);
 
 	tegra_dsi_set_timeout(dsi, state->bclk, state->vrefresh);
-- 
2.51.0

