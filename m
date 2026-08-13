Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A15C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992B910F2E5;
	Fri, 14 Aug 2026 07:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eStXfPie";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854F110F44F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:10:26 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so1795065e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786641025; x=1787245825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cZ5ZVury4cSm6TIivP+oeyuQjJii9GLDK9hKbjIQnF8=;
 b=eStXfPieOHyIymNoZNyTWx/SzM/uxiiCT1WY+w3wfRPV+6N0LMux8PEOrbso1NDgWj
 VPltR6liSjmbw5B4zuGTAfLkgx3kCW3JZomDH8rxnKuRItxh2baMUSOhufJy0yATuifD
 4kCufrRZ2q//ypC7mj7rU1vWdpOLxsiPSrD0Q8swOfSNZrhyRAFJ/GlJ1pFc3EONNZFl
 MB+d56WoiopqUknPDZAgeoLuo9vRhAXITNfyo7xlNiJJwULar6jaCZaW9roq5pWzUsQP
 LPKd/434xFqy9Ntnl81hQK/M47qwsIF5kustMamnxUaABKtfJ0n5jLHUBFqMHo+MRqWl
 s3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641025; x=1787245825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZ5ZVury4cSm6TIivP+oeyuQjJii9GLDK9hKbjIQnF8=;
 b=kKXa1OQjTUP3aDZjiJIL7J31pJrvdbMB0J2TKU7AbUgzarQRQVXiHLzFd2XIhcK+SH
 JaG1oquJZhL2PP8luPP5tPXQ7h+C9tBgP/Gql8peQQF46v1Vq9bsYsCQA7xPLPR/m0gx
 Qw2p+hUxqeVrMoCiKwi93DspapmSTgnA9gY92oECTdiPN1qNpALQJNeAFZO6Egb21bOv
 I4T2EPLv/fUjNEyuMspsBKRzLbXPEIvpvcH2gSzRflBdT01sBX7SaSklWVAqVePv0kis
 yG+QDMA5fcvyWzVHAZq8gsgFe+X7FOjL4lW+lj9+X32hgLDEJ23nkECoMkbbAl+GcBbM
 pdAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeVKOesKtqm48ne4XCW8o1bBG5q6i1oWQ7IYnUYdXhL8lpm2Xl6beO2M1VaL0oaWFht4dpTjm8+qs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmcTd6g43ewzYfIoMH90W1syl3MsUxo1u9rg4mJCHKjzFNzkp9
 uZl/Xj+I5EHvjaDPb+4fJSsknfvivwh+q1nzkdMiG6jv/QEEcmN2P5G3
X-Gm-Gg: AR+sD10krc3PAdl1CfcDt1g1W23rowbTOggBs6w+D6oaCpJNUiDDbEYag3wtmpgDlQd
 SOhX2MrpZktUN8aWJx46EsE5KG4UhU3xtjkZKzcm5RnQ593jLeSmRV6oudyPhvmBORKb8eQBo5A
 W8yHAfbEa2fpRmhjnXjOGwZVFGcVCZAbFD/1gOfjdXbmQaDC3Vwong65FXpfzNBhzEo4wAncV+r
 YD8XScDTqYQz+TeXQUumDxLvNqsLQNQrNnOUoE7gkVojCLbD2PWYMmWkt7JgrNGdpY687b91Is5
 WAVRsDRVvnAr6PCx7mbhsEp59GcHgYK/TChPlzuw79m3HK3CMp83tQEnh6xMduMTCs1DsqjYd7F
 QXuLZrbWBsSEnfy0Z76G1WDOWfpZ1KIBUY9ILJpE+iWJ3Mggo1yOzqrg2CdGeEZaPJDl5poySrb
 0/g093ej3ZrP8e1meUE1I+V/OIh7kuXDaFPnzVC/80klhCu3q0UHY21YAgC1XHw7s7YyNWiSk=
X-Received: by 2002:a05:600c:8519:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-499821f20efmr106473135e9.10.1786641024765; 
 Thu, 13 Aug 2026 10:10:24 -0700 (PDT)
Received: from cachyos-x8664 ([77.83.245.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b0f6b1sm76662355e9.4.2026.08.13.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:10:24 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com,
 roman.li@amd.com, stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH] drm/amd/display: Scale custom brightness curve from full range
Date: Thu, 13 Aug 2026 22:09:59 +0500
Message-ID: <20260813170959.22073-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Custom brightness curves use an 8-bit input signal.  After exporting the
full PWM range to userspace, the curve normalizer still divides requests
by the physical PWM span.  On panels with a nonzero minimum PWM level,
this can produce a curve input greater than 255 and send an invalid
backlight level to DC.

Scale the userspace [0..max] range to the curve's [0..255] range
instead.  This retains the full advertised range and keeps the reverse
readback conversion unchanged.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40d82a3ee..533c69f0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
+/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
 
 /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
@@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 				      unsigned int min, unsigned int max,
 				      uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 
-- 
2.55.0

