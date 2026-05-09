Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10217CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EA510E409;
	Sun, 10 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNKQNnRH";
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135AE10E197
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 16:24:28 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7dcd54a8d17so186556a34.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778343867; x=1778948667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYSUkeQk08X5s5eiMKardz3dR/jsqi1HIQzkNjMFZNU=;
 b=bNKQNnRH3frfDVqRmtApxVheo+ntM2oqFfI/tvJLuA2LryNMQprnT6kI05IJ9o/x25
 nTC0Y96M6O8KgR4InBS4pjeG4QhDAqbEs7lSNp+gvaxRrtko1PfOsgRXdC8hbhiX4vJ1
 pkXHqFPd41PrdwBx4J0YZNpbbythPPS7b4AM6vy8WFk+ZK9ILDKtsQkZj/SNFiF3t/Ov
 /QS+WjOOdBY1p2wCT9EIFq7GiM4h1Y2OssaiqvBs0QS/NzXhcqKZz6qwQLL8oCUry10n
 rZw8qXI80K2lPDDoVzt4VCohOIGEtj6tdRp2zNIjey+umzcw5gQGHhtzROit3ssA8toW
 +IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778343867; x=1778948667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vYSUkeQk08X5s5eiMKardz3dR/jsqi1HIQzkNjMFZNU=;
 b=pV6Hfx22B/cWfLXBRssDtGPMpycdA+rwvRAHXva0ZUl0qDEt10X8rKa0CiLsPWyWyj
 FilfRMv6RXLLyNVm3o3OchzTFz+xz/ALcHJu8qGFUkHTtRmpol0L2g6VWW/wmZL3V+a0
 iAoaOaiWetLBPe5za9Z27or4cYV7r8llKNFbgYHj19OLG+dUOalvxjJjw5NsR4fneASb
 cb/1IboBAG7h5n27Y0mt7oqq+k2hO0U1+j6Kh1L46wQ4aeo+YAd4T46qT8vl9QwRYy3q
 AKoiX4DrCSFFZ+BM8g2yBrWLg9rNJKI4GNa5nrxP6rpoDJo5VxChluu4ft4txmKzeZLU
 VRxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pCNLinkHPtJ/sqg3tWMXtC0YvbehMQG6ioyb0+TAAcv8tIry1vrMWtX/sEjuMHQJopOnvcLANxzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyokH8CitIffqPg3Z1f6gx2E/kobH1YTcuIaYYgSgOpF0TtDLZx
 aC2u4uuRXvdrHGkWjjm0BsV3ZugE4D5/OSL7v25Y2q/7Eg1R6WKVryW1G8AoFb0vYkw=
X-Gm-Gg: Acq92OFz6W+rUqTyDNkyWH//5mp0TPn0dZT511eoPK5j1LaA1qaOQVOBXOVKrjYfA50
 E7o5vrb9qWhWBVFSzmTQjzUl0veEV9doQRyxF/Jixkdc8jbcS7v3Ukyi3Y7uX33jIQNMYclFQA+
 3SLEXfB5i577Bx97MJHrRseQQWvQCXIcgmet0KkLLJ3jh9w7rB2U32CDbTIXxVopBdc+KampzNg
 bAOneXrzmzvnppG8txojBDd2S0hgDsW/uN26aC9Brh9TedBrmxWLSbtuarbtk065p9/pOh3MUgR
 flnNkI/aVaLsptCVuY55PvWDXo33xXXEDI5a1uWP6QORbSIhUZj4TwBenTl4oic2GRpyf49hvPm
 ZfPGSG6VRaGSUu4gr62yfFxzeApZWaHDw4W5vkP4o3G8CZQClIU60qHaz/jS2pD8UTJLv1N7mLy
 JTTQAMD66rYTtbY6wJIWydAEe3U2YO7HFx4OB2KS9kbJyuThk2ifl7xqRcxHjjpyj5LRAavXiT7
 VP9u2IKXJCoyMTNU/OSnogl//Aooqq1tgQ=
X-Received: by 2002:a05:6808:19a3:b0:467:53b0:b414 with SMTP id
 5614622812f47-480451ce0c8mr5800487b6e.6.1778343867067; 
 Sat, 09 May 2026 09:24:27 -0700 (PDT)
Received: from localhost ([136.49.184.116]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b2c87sm17071559b6e.4.2026.05.09.09.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 09:24:26 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 mika.kahola@intel.com, stable@vger.kernel.org,
 Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 3/3] drm/i915/cx0: return errors from CX0 PLL enable on failure
Date: Sat,  9 May 2026 11:24:07 -0500
Message-ID: <20260509162407.510539-4-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
References: <20260509162407.510539-1-aaron1esau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

intel_cx0pll_enable() silently continues when the PHY fails to come
out of SOC reset or the PLL fails to lock. When the CX0 PHY MSGBUS
is unresponsive, this causes all subsequent PLL register writes to be
silently dropped and the PLL lock request to time out, leaving the
display hardware in a broken state.

Return -ETIMEDOUT from intel_cx0_phy_lane_reset() when the PHY fails
to come out of SOC reset. Return -ETIMEDOUT from intel_cx0pll_enable()
when the PLL fails to lock. Propagate these errors through
intel_mtl_pll_enable() and mtl_pll_enable() to the shared DPLL
framework, which (as of the previous patch) will abort the CRTC
enable sequence rather than driving a pipe with a non-functional PLL.

Fixes: 51390cc0e00a ("drm/i915/mtl: Add Support for C10 PHY message bus and pll programming")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 47 ++++++++++++-------
 drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +--
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |  4 +-
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 4cacea802..f5c8444ef 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3103,8 +3103,8 @@ static u32 intel_cx0_get_pclk_refclk_ack(u8 lane_mask)
 	return val;
 }
 
-static void intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
-				     bool lane_reversal)
+static int intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
+				    bool lane_reversal)
 {
 	struct intel_display *display = to_intel_display(encoder);
 	enum port port = encoder->port;
@@ -3121,10 +3121,12 @@ static void intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
 
 	if (intel_de_wait_for_set_us(display, XELPDP_PORT_BUF_CTL1(display, port),
 				     XELPDP_PORT_BUF_SOC_PHY_READY,
-				     XELPDP_PORT_BUF_SOC_READY_TIMEOUT_US))
-		drm_warn(display->drm,
-			 "PHY %c failed to bring out of SOC reset\n",
-			 phy_name(phy));
+				     XELPDP_PORT_BUF_SOC_READY_TIMEOUT_US)) {
+		drm_err(display->drm,
+			"PHY %c failed to bring out of SOC reset\n",
+			phy_name(phy));
+		return -ETIMEDOUT;
+	}
 
 	intel_de_rmw(display, XELPDP_PORT_BUF_CTL2(display, port), lane_pipe_reset,
 		     lane_pipe_reset);
@@ -3160,6 +3162,8 @@ static void intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
 		drm_warn(display->drm,
 			 "PHY %c failed to bring out of lane reset\n",
 			 phy_name(phy));
+
+	return 0;
 }
 
 static void intel_cx0_program_phy_lane(struct intel_encoder *encoder, int lane_count,
@@ -3220,17 +3224,18 @@ static u32 intel_cx0_get_pclk_pll_ack(u8 lane_mask)
 	return val;
 }
 
-static void intel_cx0pll_enable(struct intel_encoder *encoder,
-				const struct intel_cx0pll_state *pll_state)
+static int intel_cx0pll_enable(struct intel_encoder *encoder,
+			       const struct intel_cx0pll_state *pll_state)
 {
 	int port_clock = pll_state->use_c10 ? pll_state->c10.clock : pll_state->c20.clock;
 	struct intel_display *display = to_intel_display(encoder);
 	enum phy phy = intel_encoder_to_phy(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
+	struct ref_tracker *wakeref = intel_cx0_phy_transaction_begin(encoder);
 	bool lane_reversal = dig_port->lane_reversal;
 	u8 maxpclk_lane = lane_reversal ? INTEL_CX0_LANE1 :
 					  INTEL_CX0_LANE0;
-	struct ref_tracker *wakeref = intel_cx0_phy_transaction_begin(encoder);
+	int ret;
 
 	/*
 	 * Lane reversal is never used in DP-alt mode, in that case the
@@ -3246,7 +3251,9 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 	intel_program_port_clock_ctl(encoder, pll_state, port_clock, lane_reversal);
 
 	/* 2. Bring PHY out of reset. */
-	intel_cx0_phy_lane_reset(encoder, lane_reversal);
+	ret = intel_cx0_phy_lane_reset(encoder, lane_reversal);
+	if (ret)
+		goto out;
 
 	/*
 	 * 3. Change Phy power state to Ready.
@@ -3296,9 +3303,12 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 	if (intel_de_wait_us(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port),
 			     intel_cx0_get_pclk_pll_ack(INTEL_CX0_BOTH_LANES),
 			     intel_cx0_get_pclk_pll_ack(maxpclk_lane),
-			     XELPDP_PCLK_PLL_ENABLE_TIMEOUT_US, NULL))
-		drm_warn(display->drm, "Port %c PLL not locked\n",
-			 phy_name(phy));
+			     XELPDP_PCLK_PLL_ENABLE_TIMEOUT_US, NULL)) {
+		drm_err(display->drm, "Port %c PLL not locked\n",
+			phy_name(phy));
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 
 	/*
 	 * 11. Follow the Display Voltage Frequency Switching Sequence After
@@ -3320,7 +3330,10 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 						    XELPDP_P2_STATE_READY);
 	}
 
+out:
 	intel_cx0_phy_transaction_end(encoder, wakeref);
+
+	return ret;
 }
 
 void intel_mtl_tbt_pll_calc_state(struct intel_dpll_hw_state *hw_state)
@@ -3458,11 +3471,11 @@ void intel_mtl_tbt_pll_enable_clock(struct intel_encoder *encoder, int port_cloc
 		       port_clock);
 }
 
-void intel_mtl_pll_enable(struct intel_encoder *encoder,
-			  struct intel_dpll *pll,
-			  const struct intel_dpll_hw_state *dpll_hw_state)
+int intel_mtl_pll_enable(struct intel_encoder *encoder,
+			 struct intel_dpll *pll,
+			 const struct intel_dpll_hw_state *dpll_hw_state)
 {
-	intel_cx0pll_enable(encoder, &dpll_hw_state->cx0pll);
+	return intel_cx0pll_enable(encoder, &dpll_hw_state->cx0pll);
 }
 
 void intel_mtl_pll_enable_clock(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.h b/drivers/gpu/drm/i915/display/intel_cx0_phy.h
index ae98ac23e..1d6cc32d7 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.h
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.h
@@ -28,9 +28,9 @@ struct intel_hdmi;
 void intel_clear_response_ready_flag(struct intel_encoder *encoder,
 				     int lane);
 bool intel_encoder_is_c10phy(struct intel_encoder *encoder);
-void intel_mtl_pll_enable(struct intel_encoder *encoder,
-			  struct intel_dpll *pll,
-			  const struct intel_dpll_hw_state *dpll_hw_state);
+int intel_mtl_pll_enable(struct intel_encoder *encoder,
+			 struct intel_dpll *pll,
+			 const struct intel_dpll_hw_state *dpll_hw_state);
 void intel_mtl_pll_disable(struct intel_encoder *encoder);
 enum icl_port_dpll_id
 intel_mtl_port_pll_type(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 78fd2e5f9..ce31deadc 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -4441,9 +4441,7 @@ static int mtl_pll_enable(struct intel_display *display,
 	if (drm_WARN_ON(display->drm, !encoder))
 		return -ENODEV;
 
-	intel_mtl_pll_enable(encoder, pll, dpll_hw_state);
-
-	return 0;
+	return intel_mtl_pll_enable(encoder, pll, dpll_hw_state);
 }
 
 static void mtl_pll_disable(struct intel_display *display,
-- 
2.54.0

