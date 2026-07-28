Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A017C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C79910E8FE;
	Tue, 28 Jul 2026 13:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iQjuHdFk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0316410E8F8;
 Tue, 28 Jul 2026 13:21:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DD8142E0F;
 Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0BB1F00A3D;
 Tue, 28 Jul 2026 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785244865;
 bh=WzbjNysmiUvYLH752H5oOl/ZbZFr3wIfjqCltPziglE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iQjuHdFk7CXYfjYUqGCIYetzNIAaMQXM1L2CDqh5x8Y4pIfL6p1yTKvpyZk/EStr1
 BvucOV/NMy7AE56/uUpMsTuZ4Qwld2hywhWSPboV2EOedgOAHDrQjerV5MKGOI3bWb
 YAgoK/jF09iPxDnn2Pa6FwUZWGgqyuvXCDdF6HkJlG2alfCPCJFyceyci36iRQ8EsG
 nnKbX4YV5ItQbFVl+mFZgwlasQEGTYK8uLPse3xGH526ETdAdYzPaJ6E232ULhvAdH
 7aBFqEagRrRWHVBf5yvsVLzRcPEVSGDQ9hLWqnwmgd8OLHF+jpYzmL/4cccbLwZEXj
 gzrnIv+Jq8b8g==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 28 Jul 2026 15:20:45 +0200
Subject: [PATCH 1/3] drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-topic-dpu_power-v1-1-e7783b859a70@oss.qualcomm.com>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
In-Reply-To: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, 
 Vara Reddy <quic_varar@quicinc.com>, Stephen Boyd <swboyd@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Archit Taneja <architt@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tanmay Shah <tanmay@codeaurora.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785244852; l=1130;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=yfqTGowzRcTl5W6r1eNs68O8Q1W7J54QaQ8unavorIE=;
 b=H83w8sIqf9L0xGK9zWX6S7lFaH+HNY8giZXgBSR74Zw8vXLW/hsUOLGsaaxkjPoqzqywr+4nM
 h0hPWwrE9F4A/V5XXr0yXo6kzqhi/0hhjWrvTroUjb2Nky7lGsqo6/w
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

dev_pm_opp_set_rate(0) removes the vote specified in required-opps but
does not actually park the clock, making it run without the necessary
power backing. Prevent that from happening when
_dpu_core_perf_get_core_clk_rate() returns 0.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 2ff255d7795e..fea173e37464 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -394,6 +394,10 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
 
 		trace_dpu_core_perf_update_clk(kms->dev, !crtc->enabled, clk_rate);
 
+		/* If we're going offline, PM callbacks will disable the clocks instead */
+		if (!clk_rate)
+			return 0;
+
 		clk_rate = min(clk_rate, kms->perf.max_core_clk_rate);
 		ret = dev_pm_opp_set_rate(&kms->pdev->dev, clk_rate);
 		if (ret) {

-- 
2.55.0

