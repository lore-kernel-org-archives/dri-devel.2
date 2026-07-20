Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4672BC44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C7C10E7B2;
	Mon, 20 Jul 2026 07:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="AbJcrzGQ";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A74E10E04B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 02:54:28 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84a2dcec51cso8624792b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 19:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1784516068; x=1785120868; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rFljCtEFelRS88CSKI1hEHhcvhe70i1rvAJ6/7ijCss=;
 b=AbJcrzGQlYoUyRcfgSiJpcrIw4zzQtehuLks4DQFkGs4ae1ukEjj2kszUH1tLvprSo
 w/dMbIXd4lfxm97SQ5wSM/U4UGJpQovEDADrfY2N6By9GU4L2RlTRQ91k4pgq7Kpwlsz
 GXSABMmLP2jPQVBs+f6mGqTexgmgaWIdNfU+onvmUyVR3r6X8x04PByHRWtZ/h1Zkdwe
 H3w98L+Ixfo/FqjID3OSfKXZBSYSlqymS7ykxRHvLBpZQZwrCiJk2WMpy+iSAuEU5Rg9
 kukeiPRn1Lnl6gI3UAfYbP5WiRkuraxHcOb3zr90UCjaOak39CuQkRG0owtirSWcSntP
 kUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784516068; x=1785120868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rFljCtEFelRS88CSKI1hEHhcvhe70i1rvAJ6/7ijCss=;
 b=ThTAQN318D+fG2fQEjH0t7tSb/2NXN0idxAuzPHbsMwiKEpoKXxfMX6gWL1GmlXtFO
 EfnpVThscyA+ONSJNCVfcDk2cdBFTtwq5pSWbiV5rhATkmWvHoJiyBLMu0dTSouWy1li
 Fn+z/TlNmA0a/3s9joFGdO9h+ImXRnYvpcvzBHOATe6awtJsPou9+m9bmL1tj/s7PAx2
 9NrRG5OVyaWdqT21VN3q2kUTAJnO1z7fKkOEU8WpOpVURHM82vgBD5OM4HrbyYSc9mAD
 //IIcsmO1ZTJo8WYkKEMr07hqor8N002Sf3bAvNuel1gP+Icw57IuaUMEJVJTXDfTRDu
 Bqgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoU0f1E80canKxlGVwqsIG9yjd7tML8v35QYg8CeAFKEfHfZtG9jjFdR7aZqVehWdv3Qp/9bKF2IS8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYT+rEDI6/mR6C+L7xod6N2EuSbalxfA8cJMNMASnaoaAdr3xq
 bPykaTbFUUVOrSEZ36bNwMdrNXZkYn01wXb0niJL9RnymGFYVDohx0Kk06YH/JKvXlc=
X-Gm-Gg: AfdE7ckYhDHJFmgDUjPBP8OQAitJQUQdA+GOsLSGFU53Ba2x2rxLOcd+3jphECFDDRN
 RmCgxtG1gxjk6sbR2X+0tY3S+S/4bhdADTVkphlroFCmKIltVgFn9ezfLqH1vGnSCXSkcJri4R6
 /QdwMgE9kG/GMKmkn3aVJwLThgLlV9g5V+9+/BqaQ04tOuNTVQudGewwX++3Y8/WJd5i6/PfKxQ
 wWvvwGVRZQN5kt++hHHlne2C+pUKKKk/PUFBxePrGQoGEWl23KWEhd8rr+4fZm3DD3i3/zcR9gx
 CfKvjcu15fLLQDT4Lgk5MnXW+Gm1bNwJcQu31S/y1d0dbv0kHdGlemLEfGVNUvL8CTN39S7CIqH
 derSmcioKZLbnI/KxRU42MZq475tcanvb6cMnmQcO5fj5BEqBA+aBokdI0e2at4pk5gfRudgFZg
 wbM5b5ljTWI8tJY5tGuTm5ej6mV5OKtInu6ByEeq6PxlEimeMJVpfAk5zgrN6IBKv4+QlakJTMg
 ozP11g=
X-Received: by 2002:a05:6a00:cd2:b0:848:51b3:f3c2 with SMTP id
 d2e1a72fcca58-84c292c7125mr12415813b3a.33.1784516068464; 
 Sun, 19 Jul 2026 19:54:28 -0700 (PDT)
Received: from dio-Nitro-AN517-55.. (61-219-175-100.hinet-ip.hinet.net.
 [61.219.175.100]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2af317c8sm4562360b3a.30.2026.07.19.19.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 19:54:28 -0700 (PDT)
From: dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dianders@chromium.org, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, aj_cheng@compal.corp-partner.google.com,
 ajye_huang@compal.corp-partner.google.com,
 Dio Zhang <dioyc_zhang@compal.corp-partner.google.com>
Subject: [PATCH v2] drm/panel: panel-edp: Adjust T8 timing for AUO B116XAK01.6
Date: Mon, 20 Jul 2026 10:53:58 +0800
Message-Id: <20260720025358.2781136-1-dioyc_zhang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:04 +0000
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

From: Dio Zhang <dioyc_zhang@compal.corp-partner.google.com>

Screen garbage or flickering can be observed during mode changes(such
as VT switches) on systems using the AUO B116XAK01.6 and B140XTK02.4
panels.

This occurs because the backlight is enabled before the video signal
stabilizes. Waveform measurements show that the panel signal takes 
around 140ms to stabilize after a mode change, meaning the previous 50ms T8
timing was insufficient.

To resolve this issue, adjust the eDP panel delay entry from
delay_200_500_e50 to delay_200_500_e200 (increasing T8 from 50ms to 200ms).
This matches the updated panel specifications from AUO, which now formally
define T8 as 200ms to mask any display abnormalities during mode changes.

Signed-off-by: Dio Zhang <dioyc_zhang@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 8d3859cd3ddc..3a168bfffd4e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2055,7 +2055,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1999, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e200, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x203d, &delay_200_500_e50, "B140HTN02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x208d, &delay_200_500_e50, "B140HTN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
@@ -2074,7 +2074,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x67a8, &delay_200_500_e50, "B140XTK02.4"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x67a8, &delay_200_500_e200, "B140XTK02.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.34.1

