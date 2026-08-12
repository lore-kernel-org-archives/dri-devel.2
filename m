Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA2DC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574A310F25C;
	Thu, 13 Aug 2026 09:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="Ui+G+gW8";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848CB10EF3A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:06:01 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so6660435e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1786529160; x=1787133960; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8lTgpZKYeMDewjAwTo7awtsmXJS+XkKIAXMlp0xZDk0=;
 b=Ui+G+gW8oZpfq5XmUBXBeIoLRIZHVJmdWAGkRXAP4fh93TqYxzanpQWGo+h9RkdZt8
 DVgsEAe1+szPHbkv6iTUdDeyM9QHhP8fD6Lj2Xf2CBodrG54AyhG+T1/FYEzqLBL4DNd
 oQOfqmiujhZbWArWW8uRHnq456YyOkBCQtwiWfkqx8SPYictC4UWAGrQ740/rjctVAUK
 aZ5JRbsJO1U2e1uLdQlXTiCkx98QkYwQv0weDWlsMYq8x3tZK3+kS9Z7iHwD2CW5l4/H
 hYyoQ2PAc2TbvJWyhCtLpRVllDBqv+bRybDm7cTXen6zvuOZFsd3KXJusZHk56S4zzcP
 MDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786529160; x=1787133960;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8lTgpZKYeMDewjAwTo7awtsmXJS+XkKIAXMlp0xZDk0=;
 b=VNfHWZYSdG7zbUdrUVFsArU4Vh8TMEnzn89EhjRU6sRfbu59vLrovVl2KRaA8bFCGG
 z7ZtRw3pv8hmIbqqEwK4a82lxoUNZ/FL+Z55xF75QvORk9oflxivq+p7/wMehblwhPts
 bNOZpb+UD55cuHOERF1EJPNgMHTGHzMBUUm65oF6KirfquOwcSpNcOQ13F37Vmjv0Nrg
 PheXIQ09u54pMnEMfDjiNw388Lp9ZusQH7224BBfi3DGQMzRuKsyHZNROykFIOVxAsxt
 lXmLZ5KyRF0U48MA+f8Nk1HqJgS6SKT3xtBN/0FSfBOJuX012685XCu3ksnuckZ/CUPS
 m5Ww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+q0t7bXZB7gZl7I/CpwIEBjMLb6GnZD/K4vFa2TY19X0OKtrQszEXfi++CduJ/G2+EWxBR//VtQg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWwh8h7FwJChGhEZGDYw2GrFP26qePbuU1AxueoLPrIVzivojA
 CbwwR/J6SsYzyaUJXacMmM1Z3CHyCmidC71h2Vgo2GH625Y040kw/7oRI75rPNrzlrY=
X-Gm-Gg: AR+sD12Re7Fsp4ClI/6fS082UM4uow9WRuTj0qDdDT1DTfJHv2r3gBIxJ5w2VaR0C4k
 ZEjdZBvrLbswn5VkqKQiBTPl849tILmXM067bOwVtIIVyz3+Tjrk7AFwnnQ8ryTW5B7UQHoKhAb
 UkhDGYhk6BieZF75WFJ7kn8jueczs+LZnAmrVCuIED4HbBBK6ra/4Et/rpx6EvyWh9k7KeqMa6o
 9kogpamLR459jsEdJIvYD3TmnKaWpKtmeL/1MaW4dbkACHQhyCwyUORvzcMnnpKon0ZTtdJjESD
 OMPPQKg02za89NJ/cvJ4xdcxVaHVUnlJMqkdshubCKr0bnpuUnzi3MOPZo90YRHrFJuDWaK/MMd
 svHJhunE0brdUOcdM1vQrNSQ9+iWHIINboF+M8Ss3Kl2I3krhgq7v/AglF2TzWj0pz0R0SvyjJf
 8yklm8YTCy1GOmbZdhDq435O9KCe7E/64Z6h6weadhIWsmJKRyZYix5VUJIrCs1MQIVu4C+0qcO
 X45R+1AIH6ahtFSJi18L3Y6clPigsxi0ShZjGihJHpGUJ/u5PSJfvAmyI1elg==
X-Received: by 2002:a05:600c:8b33:b0:499:6a92:fff1 with SMTP id
 5b1f17b1804b1-4997c1706afmr55104685e9.18.1786529159744; 
 Wed, 12 Aug 2026 03:05:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c6:273c:cd01:ee86:877c:752a:fac6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eddbsm6568147f8f.31.2026.08.12.03.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:05:59 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Wed, 12 Aug 2026 11:05:52 +0100
Subject: [PATCH] drm/msm/dp: fix link bandwidth check when wide bus is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-msm-dp-link-bw-v1-1-b0e3ce1190be@imd-tec.com>
X-B4-Tracking: v=1; b=H4sIAH9FfGoC/yXMSQ6DMAxA0asgr2spRIy9SsWCBBdMS0Axk4S4O
 yldvsX/Bwh5JoFndICnlYVHFxA/IrBd7VpCboJBK52pItY4yIDNhF92HzQblqVOU1vkytgEQjR
 5evN+D1/V37KYnuz8u8B5XqQvVkRyAAAA
X-Change-ID: 20260812-msm-dp-link-bw-99255c870bc4
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

msm_dp_display_mode_valid() halves the pixel clock when either YUV420 or
wide bus is in use, then uses that halved value both for the controller
pixel clock limit and for the DP link bandwidth check.

Only YUV420 halves the data crossing the link. Wide bus widens the
internal DPU to DP interface to two pixels per clock, halving the
controller clock. Every pixel is still transmitted, so the link
bandwidth requirement remains.

As a result, modes needing up to twice the available link bandwidth pass
validation. On the IMDT QCS8550 SBC (rev5 with CYPD6125), where DP runs
over USB-C alt mode where only two lanes are available, 3840x2160@60 was
accepted despite needing 9.6 Gbps against the 8.64 Gbps the link can
carry.

Use a separate link pixel clock that is only halved for YUV420 for the
bandwidth calculation, leaving the wide bus halving to apply solely to
the controller pixel clock limit. With this, 4k@60 is correctly rejected
and 4k@30 selected instead.

Fixes: df9cf852ca30 ("drm/msm/dp: account for widebus and yuv420 during mode validation")
Assisted-by: Claude:claude-opus-5
Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..b2d6cb82a146 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -756,6 +756,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 	struct msm_dp_link_info *link_info;
 	u32 mode_rate_khz = 0, supported_rate_khz = 0, mode_bpp = 0;
 	int mode_pclk_khz = mode->clock;
+	int link_pclk_khz;
 	bool is_yuv_420;
 
 	if (!dp || !mode_pclk_khz || !dp->connector) {
@@ -775,6 +776,13 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
 		return MODE_NO_420;
 
+	/*
+	 * Only YUV 420 actually halves the link bandwidth, as wide bus only
+	 * halves the pixel clock within the SoC, while the link bandwidth
+	 * requirement remains the same.
+	 */
+	link_pclk_khz = is_yuv_420 ? mode_pclk_khz / 2 : mode_pclk_khz;
+
 	if (is_yuv_420 || msm_dp_display->wide_bus_supported)
 		mode_pclk_khz /= 2;
 
@@ -786,9 +794,9 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 		mode_bpp = default_bpp;
 
 	mode_bpp = msm_dp_panel_get_mode_bpp(msm_dp_display->panel,
-			mode_bpp, mode_pclk_khz);
+			mode_bpp, link_pclk_khz);
 
-	mode_rate_khz = mode_pclk_khz * mode_bpp;
+	mode_rate_khz = link_pclk_khz * mode_bpp;
 	supported_rate_khz = link_info->num_lanes * link_info->rate * 8;
 
 	if (mode_rate_khz > supported_rate_khz)

---
base-commit: 140b13475302601368c0cf4e193e66126a49feb3
change-id: 20260812-msm-dp-link-bw-99255c870bc4

Best regards,
--  
William Bright <william.bright@imd-tec.com>

