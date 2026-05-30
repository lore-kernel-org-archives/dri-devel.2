Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF1ECD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 20:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B351129B6;
	Sat, 30 May 2026 20:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NIkj0SNB";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFF61129B6
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 20:14:03 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so135822115ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780172043; x=1780776843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1qf4f+BNxnhTmbM00ciJYT0JiSIbIcC/mWAQYQHmlYk=;
 b=NIkj0SNBPlBig/7LdpIXmLKF7XD4/FY+XveYID++dB7/F4tZHQiKEMgbFdfeW4wB7K
 bhZr57TmtJ7XmgJ4aMWQBDrNMNMG4YWwlb0KyVSYylObHchbRJES/yaPHmDfV/KLniJ+
 V9KF4lcNz3YCVnq8I8Ffs0jqh4ZsfR3F4yWVDosHfxPAU9wfgximyKlHIZrLn7wAJkIq
 pt4VI5M5yclEVlsm2G+BJ4lVaGV4TFgrcgypB8pBkTeV6tIqY6eAxZBvRA4tqad9VTUB
 57nIr4fE06St8ZK4V4G0KzfPcm2tJkUYJLzZPkho8SagJBXodiLRc2Hv1rc4zTwaDv+C
 OT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780172043; x=1780776843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qf4f+BNxnhTmbM00ciJYT0JiSIbIcC/mWAQYQHmlYk=;
 b=kZrELl1jh9cLKOY0aHuG5CS3p0PWohd8lCCm6tWKxof2/UTqqvsBMAOeI1sOzhkrRi
 1uytctFAlFdGkWKNFEJZlAeHUJvy2o6QeB9Xw63hqJT0H4g+51jrzhhC/Cw8Vmrrrcws
 tofwkbzHbY3zAJ5wxVOJEm5KP7OwPxbETtnB6b2Oea8HyILfN5tjfw50V3k/kBLP3AfV
 tSyZov8yd8FBrUcacmR5oCDs1eLH3AZwbumdFscwRehp8E556F/gPu3Tw6baPqLA2ZYZ
 itue1PDUu1qkiqxehpe0yA5wfHR5da2d5fEzByvp1+a5FEgxl59Y2KgvuCcYAnxjdKtd
 ZT2g==
X-Gm-Message-State: AOJu0YwfQ9K8Vjiqedb2rym/gONAOpnvTORxqwB3CIVz4GhR88hh1bVE
 iaDDF6zTlqZGbFcoNUqeAjzLZlOx0C/XOA2L+avYKcFL5QAggwhWrs2vjI8vUKwn
X-Gm-Gg: Acq92OEX0cdiggPkxVfMOdORKSoYHv9bD2mvXFj+c3nW+gf0byc5czYBreeaWYATEUy
 HTU3RFt4PNL9PNM6m+HonKrN9HrOc3U9AiKUdjW7Ywdj3WznEqtoSgEx2q2mtRxVLRLQ6u9Zo06
 yhVirCNY9v4DTINiOHmmpyLxryTJTmrm0U183eiwHoAzZ6jmvOvl2jY4bWCcryjwxNa5y1NOH1F
 CKaT1m2cmgfVZsHR8ed4z0y88dd0Y1SY2TzFANFgTrpLFq0HtveF8OqW7Bk3G1qsyW9tYzemn9l
 osSAqvp7nB8MCQidLKc0IGyTBsgmIkIGxZL9t1jsTP4C1v2Z7Fcaakq5IDJU6oXUn9Ftms9QZMd
 HKymS4+N93Q7I1ibrIkzorM0s1L9wRU+odzB0/o2CwgKVOgj+ymHVFqJhmNKUJg4yMoxmKH7KFG
 ZNZUhvii+1Z/f/bA/dIQOi1ZR8Ac3Ayhe52XOasHSP1ckwDBDNsVT4hdedaYVA3Dg7GzhplITQq
 QpNOVAcTYX0jrnzTa9hDoKNwbYWQzSYWfWEeEJijrvpXw==
X-Received: by 2002:a17:903:41ce:b0:2c0:bcff:e198 with SMTP id
 d9443c01a7336-2c0bcffe31cmr14256265ad.41.1780172042762; 
 Sat, 30 May 2026 13:14:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23a10165sm54712715ad.31.2026.05.30.13.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 13:14:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display
 hardware), 
 freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display
 hardware), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dpu: fix parameter name in
 dpu_core_perf_adjusted_mode_clk kernel-doc
Date: Sat, 30 May 2026 13:13:42 -0700
Message-ID: <20260530201342.10538-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The kernel-doc referred to @crtc_clk_rate but the actual parameter is @mode_clk_rate.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 13cc658065c5..2ff255d7795e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -34,7 +34,7 @@ enum dpu_perf_mode {
 /**
  * dpu_core_perf_adjusted_mode_clk - Adjust given mode clock rate according to
  *   the perf clock factor.
- * @crtc_clk_rate - Unadjusted mode clock rate
+ * @mode_clk_rate: unadjusted mode clock rate
  * @perf_cfg: performance configuration
  */
 u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
--
2.54.0

