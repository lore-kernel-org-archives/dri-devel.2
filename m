Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C013CCA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD5910EAE8;
	Sun,  4 Oct 2026 17:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XfpL6C0F";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF16B10E113
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 09:35:05 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3a0a911e8d6so338667a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791106505; x=1791711305; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ieoCN8zHQyjpKwxBxBu39ADqPAcaD3Ug1famBdxjyE0=;
 b=XfpL6C0Fe0+p45S1K6pflXETK+mFjxyTe82U6y9NjkKDCEnMl9fajubgghCBbwQ0aS
 N5CgdRiB5CSrHSA7XXdXMK4795lYcdiBKR445nDEeAwbVZFpxRrHDIYSu7DVWMYHwE4x
 xzQtBsz1GiiAkxtPuGZeEh9FKquMHbaMUUvoJlZVMRwSeEwo7vkmUL/90F0zyV+9duWV
 tLARMwtFzShnbnp/GxGDRTH3MNnIIJqbnS1ihOWciHbFMaCWBRET6couDfdxU3sjF2Sv
 uw95GzRKXahqIGbC5YqNmL8PgPDRWLvc1JrcBA1IITwRpwvtjPDy7+5c+8iZeLLvVO7s
 c5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791106505; x=1791711305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ieoCN8zHQyjpKwxBxBu39ADqPAcaD3Ug1famBdxjyE0=;
 b=LAFpS4HtzHk974hF4B2U4TZ6i8PlgV53yGG9uiS6kCzHtw9kwtwbBz78HpUN7gcXK5
 GFWSLWmDURuRJQjWXg5/6oqGahCkPrLzdaGE03UHky9kt1c9PxChd+0dEjUNatRTS0aZ
 zmBh0YKwp4rZURLs4+9VBS310kXZ0s29kMOlMxqKsUvyEIIV2Q3gCCiAk+1pEAUrNvFR
 pZHmHyTyWHxWMA7XrMiPuhOCHEAJKYRrTL86GNVb6XNPKLoVTvRk/4lK415aSdDNog0E
 BNwPMoysQ+vzS4148wbJa9fDNzm6BIqshyuT0icstLS4sqtBs6xkbfoLzPJVSjhV6lv9
 CmBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAm8mRYjE9bHhUOoegkzv9bt4/RrQeuiRreZOP6RHKWX5yX0Sxi9fVoFNb2B02uOZ4kJNSs7ghifw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIcYNkRPFi2HqqKCyDKQlKu5T1SPIXUPPfmCrLw6xpuAHzhuA1P
 K/gCWSoaJeOlGLnMIJ2DVvWdn11I4eqJMsWsGYy010vl3wIW+zmSS/jE
X-Gm-Gg: AYBFou2piaFPNZY3GInbuhD2VA9ZqwuhAlVv1f/K/G2UqcpeUxjEBBJTXlsmDnopj8C
 aW2JdPcZNfLDaolxuLEe1aXixbljk0Qm52uswRH/r2a9cFUXgxvGWQppMAMdhTVo74UisAUHt73
 0+5PKiNVzFyP9tNto7CGmSWgQV1cKiSmmZfFcjLi/LLVhuOZ5f9S7XouleZcCxJaB23Gs7BbybO
 Xh52S1mot8Q/TR2jCq3I/sHJ5d4xN9pDZbhzYRQyDogT+3OHSuVXOCXaOnMRFWlfuakeTTLIJc7
 e3bt7DfGVdXXQ3D6wTE/EZiMDmJL0qm6SU4OJmQziNymZCff7/hdQGJyylx4VBm60oaGo2aAz5y
 AFnnqfS/KTBwQBkjf4X9kfNkHA1FOFXLjERAM+J6iTZEqdMHBZSXKmMhqBM3EWADuW1HVtJ/V4I
 /eSiZARAQO5Vk2poOcgl4Ah02PGlYV3phLEi/bMeLt0/gfMO0qUA7pFCDKOzmyKXcirsgZpt64V
 gDRLK9qF5D1ow==
X-Received: by 2002:a17:90b:544b:b0:3a0:cb48:df6b with SMTP id
 98e67ed59e1d1-3a7873db380mr3330070a91.34.1791106505312; 
 Sun, 04 Oct 2026 02:35:05 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f7383535sm2682884a12.20.2026.10.04.02.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:35:04 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Joonhoe Kim <26rote@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/msm/dpu: Add INT2 GDSC power domain support
 for Kaanapali
Date: Sun,  4 Oct 2026 18:35:01 +0900
Message-ID: <20261004093501.74290-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
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

On Tue, Sep 15, 2026 at 05:27:47PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8750) has an additional INT2 GDSC

(Nit: Kaanapali is SM8850.)

Tested on a Lenovo Legion Tab Y700 Gen 5 (SM8850), v7.3-rc4, bonded DSI
panel with DSC plus DP over USB-C:

 - without the series the INT2 GDSC stays off with no consumer; with it
   the DPU holds it on while the display is on
 - DPMS off turns INT2 and CORE off, DPMS on brings them back; s2idle
   works
 - with a DP monitor attached the cursor plane lands on DMA5 (sspp_13)
   and scans out fine; VIG2/VIG3 were not exercised

Tested-by: Joonhoe Kim <26rote@gmail.com>
