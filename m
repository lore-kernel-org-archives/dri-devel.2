Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697E4C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B4810E57C;
	Tue, 28 Jul 2026 13:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FCX90AJi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C1D10E57C;
 Tue, 28 Jul 2026 13:21:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58A4A600FC;
 Tue, 28 Jul 2026 13:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3F41F000E9;
 Tue, 28 Jul 2026 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785244859;
 bh=5wIfZ0sm6CEy7MJilr4iQeAgvnopeXOM1phyT95Vzgk=;
 h=From:Subject:Date:To:Cc;
 b=FCX90AJi2Tbai/riSjra6VQYBMpCeDvQ4iLopY+0oZbAQgHSgeEYL75P4gHwRpuXw
 P4b8TOTGuabvDniChxKuoYA3XnjakS6g8lYcr8jcvNm/w3NhjAlRH+3vZlutiObMqy
 S5eSnftlxkwsOUKnzLVmxV2HGwYU/sW3roGf4Zi72Zm25csgp+H7/wxoNnferhFMS8
 f50IQ2UNKYfrNBBg2RLx3LjlIfaSbruLmHHyb9kbOLhyt+0m/u+H1Gqz8tWeB7+xfv
 Cvk+Ai7/XVy+g+TFp4GyCRhXydMqh+vAjQA4tT6K5t1feMcHFWdixd0fIrO/XYAgXb
 s9Yc4k9UY7/fw==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/3] Remove brownout risks from DPU
Date: Tue, 28 Jul 2026 15:20:44 +0200
Message-Id: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDXR+ncVEaEGY6FNq0jE3RXLb
 /HeBRYNoYUquMDgTpbU6sHDAOTcrRMyGrxBRCKLclGwTWmSbNCu1epAw0Q8piWPe87LBHylDY5
 0fse6+W1dv6Dc3g3c9wMbMtZScwAAAA==
X-Change-ID: 20260728-topic-dpu_power-23f5913b1194
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785244852; l=994;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=DDTk0H5cNvK8WiltkuOC+5GnAZO1/0LoS+J7bv4xQsw=;
 b=+wjZYMXr9We+PzarZidZZBP6SyD/jlQVmwX2lbOnKcsuZA+MO3K9ry0Off/ndM1O97MtGcGCn
 ETFFMVxYf8MBMeT3GqgDbduIgj0GxW5MDu60xA84jVN3Pfaj13Yc8zp
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

Things generally run better when plugged in. That also happens to hold
for clocks. To ensure that is the case, remove calls that drop the
performance state votes while the clocks are still running.

This helps Glymur devices not crash upon resume when a display
(incl. the internal one) is plugged in.

The DSI patch is compile-tested only.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (3):
      drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
      drm/msm/dp: Drop dev_pm_opp_set_rate(0)
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 4 ++++
 drivers/gpu/drm/msm/dp/dp_ctrl.c              | 6 +-----
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)
---
base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
change-id: 20260728-topic-dpu_power-23f5913b1194

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

