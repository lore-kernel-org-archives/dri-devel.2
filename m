Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F6ACA5FF7
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0849110EAEF;
	Sun,  4 Oct 2026 17:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VYMXCvOl";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1294510E178
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 10:28:01 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so458419a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791109680; x=1791714480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aOHR60kWFiiTF2Paz1Sgg2dVxODMmAsE+5qedw3hT08=;
 b=VYMXCvOlIhetP6VQgXtkyMh284tBOOTnQ9RkJi9YSobtxGLxhg0twBdMFyin43HuAj
 ytgiwaRBiU3U9kXtGqNkEUqVYCxBz07a4qHjqKYEV4G7bCl1UrHkybVEwUslAPNac19A
 9bCJlJ8xrzURtCl6R5U7WHEKR7AA75SWyxYTnw4XWF9d7JyhdVzzcTKbPBVy1T2zWIPK
 X86ZvqeLMi/R5MN4qj/6gP2H7+Mc49LnArVd0QXc2sGzsqA3tliDrtPReIgYkRVnmh1v
 ZCgdg9h3nu3NLCsoPwE9+mfslYhnkoNlR1HHxFFsK/idwWbMd5nTZ0meVerFFNT0gZ8L
 ZLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791109680; x=1791714480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aOHR60kWFiiTF2Paz1Sgg2dVxODMmAsE+5qedw3hT08=;
 b=tTqVLi5MNm81GHpTpHHqkwIcSsW2w4aqe8okaQN0yEa5gP2C7JH0g8AMOZEP+dOU1m
 zwGc6UCUjVHqJ2Wib/tpWOa8Rb9M2lPrM8M/KWoCltV8d2qmPZQqWl/Yx6EXwitl1zvD
 SHVd8REFORprv7wYJRfOkpEtq7OC53HIvslmCBd9XTCAQQnMSKBV3zHi36L6TVf3m+lh
 Lk6SwmAy75I3JCd8P2oW9jjwzWQ7zCFydwhIg7+HJexNYalfnlO8dieEHJn7mJtfAqjj
 sObc5k4yog/OQNdPrl2WYT62cSN5TzitCU3XKX/WNIqlxJVzc7k3h+gDw93/ARIM8HCQ
 VD/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIISFlmZzMbfOtC+RKwqfI/Cfc4VNVG9KJwRZ/WYOiKKPJQoIDgy5++HyzBnv7XPKfHLAnR1SlU84=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjwOhNa3HNBkV/aFtwpcCPTuCjPf/l885zmKfICi+goBjPLokk
 5ZGetWuhIxKwR31qY/fhKbFUSIXkXSNPAcm5tBeRaIsr2nTupV1T6QJE
X-Gm-Gg: AYBFou1vrqLVIFMRwhcPoEW8EndF4X9ATAkPqB2MrrWGzQsTFGeMPhWIdx5aDLisXAd
 aRIPkKnnIeAfeuZVJ4CST+qcj9RDD34UZUw4q5Lv++DbT2feMG5N4HHlJC107AEGQIhSd7OhpGZ
 4zfBjtaY2hmGWoYPcT0YNbNFMRf4lzH1Ov8lkq7avrFpLgC0vhuUCdKacSDVbc+beH3I8zICaDd
 wXbeLIg4lijgGwolkzmVi8xAdsP+YyKHabpS9EnnIk/LSgWsDN/yFVgvIyr3zLkfh2MY497GM1s
 R9r9KOlze2AX0TC3010z3T7kjtnMT6WWv8e+1BNhQ3eWyaUFSCpxkBhSOwG677fYZmLVlkPfaQ0
 uFGVpvGEVNEpEEAGqc/jBg06No6UqzF5cKXU1tbEtZCk59+uv9Qk19yZ0kFpYUlKhuhMEAwwhLE
 p1NQDF3JwLHCoGdf3NhMN4qZyaczLFkbfgB7D3VdIyRDvY8WAXYYEOuh/Zs8hYL/9cZTVvfxSuG
 ofBZCl7hIIHow==
X-Received: by 2002:a17:90b:4a4a:b0:3a6:f90b:20cd with SMTP id
 98e67ed59e1d1-3a6f90b2630mr5714179a91.6.1791109680484; 
 Sun, 04 Oct 2026 03:28:00 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4262cfsm6192927a91.6.2026.10.04.03.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 03:27:59 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: round up the compressed INTF width
Date: Sun,  4 Oct 2026 19:27:58 +0900
Message-ID: <20261004102758.84436-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

For DSI with DSC, drm_mode_to_intf_timing_params() scales the INTF
active width by bpp / (3 * bits_per_component) and rounds down. The DSI
host computes the same width with DIV_ROUND_UP, both for the pixel clock
(dsi_adjust_pclk_for_compression()) and for the active width it programs
(dsi_timing_setup(), from bytes per line). When the division is not
exact the INTF line is one pclk shorter than the DSI line, and the DSI
FIFO overflows.

Example: a bonded DSI video-mode panel, 952 pixels per link, DSC 8 bpp at
10 bpc: 952 * 8 / 30 = 253.87, so the INTF uses 253 and the DSI 254.

Round up, as the DSI host does. Qualcomm's downstream SDE driver also
rounds this width up, and Pengyu Luo needed the same rounding on the
Legion Y700 gen 4 [1].

Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850) with that panel, with a
module parameter selecting the rounding: rounding down, DPMS off/on gives
no vblank and 14000-17000 DSI FIFO error interrupts per second
(dsi_err_worker: status=4); rounding up, the picture comes back and there
are no errors. Only tested on this device.

Link: https://lore.kernel.org/all/CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com/ [1]
Fixes: f9ce482d7dc0 ("drm/msm/dpu: fix video mode DSC for DSI")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
This does not touch the divisor discussed in the RGB101010 thread
(bits_per_component * 3 vs 24, with and without widebus); that patch
was dropped from the series pending that discussion [2]. This one only
makes the rounding match the DSI host. The panel here uses widebus.

[2] https://lore.kernel.org/all/20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me/

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index ba810f26ea30..2ac517db50fc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -134,8 +134,8 @@ static void drm_mode_to_intf_timing_params(
 		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
 		 * fractional part if there is fraction
 		 */
-		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
-				(dsc->bits_per_component * 3);
+		timing->width = DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_int(dsc),
+					     dsc->bits_per_component * 3);
 		timing->xres = timing->width;
 		timing->dce_bytes_per_line = msm_dsc_get_bytes_per_line(dsc);
 	}
-- 
2.43.0

