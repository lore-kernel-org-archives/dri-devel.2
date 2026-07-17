Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0736C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1570410F515;
	Fri, 17 Jul 2026 11:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XmYtCBdA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YUvr3ZHs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE7F10F515
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:26:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HASxnN1632141
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1DCmfAQlPKoWgymsulNwEO
 u0w3/DzpAA9VDwyawz6Hw=; b=XmYtCBdArzM1aCC4aHxzPa4wBPD/cmrMBd1k0R
 TrqA2mrhiIjUioopjgbySq12HJMmWw1EWHXk4NS2zS2fpDVnJy0vcTBDAZFmIvbj
 G1jm9NY/ZCO1fOlpRtARje1C1kJMWziyI5yyahYlQ0SEaK/oYvwHx6xt+m302sL7
 H08TBDZ/DaT9mDvGjgTs0lNiQyLopx+9TPntPTGJyH8d4vU2Q/J5usFaYrtcCPa8
 Nmg1MFmtX/iQ7wmGEcY+RcaG0b4KL+r8ajmq1N9/m1cfMlwOfCpAH5SVszvXguEP
 TxvLK4GSu07WfX22FyGbrTpyVv/S7RqAyBFl1j22VkpxCXIg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0uscpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:26:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so6698428a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784287586; x=1784892386;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1DCmfAQlPKoWgymsulNwEOu0w3/DzpAA9VDwyawz6Hw=;
 b=YUvr3ZHsIlL5BnCKfPHeRiDlbcGJyPEfT57GmK5eVAwmgZLSpCOB3FXlHsG96qjxBa
 6ojv2vz1+PBzxM1WC2ahGPDc4l+KTIWG+R/ZF0Z3dCCsQJd+KPBBr0SWy/Z+oIRsQ19t
 WsXLiSDx/l7RYXS/kaRM3fD7tns8RBqfW8SCEW1+cGnHicXVmG7csoVLpcjrAqEe0Lxr
 kT/XfI65LTzzI5zji1wR0/iAAalbCtcExFv+Af4sO9veLyEKDThwWnKsEKqLZvJzV3WV
 7eOBHLTWbrZhSmlHHh98zzRJwqyRJHaGNLVRtgQZbulM1Cujn+2++s8s9NOlrVjBC15Q
 qMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784287586; x=1784892386;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1DCmfAQlPKoWgymsulNwEOu0w3/DzpAA9VDwyawz6Hw=;
 b=Ve2vUuykAgzJYVPji5E2dKasgXf1TH5pvNRkVkpl0AzGhojdR4ZSjnKwOP5uaq60Pj
 lh0QNlpetEq33IiOmzXGeybhcpog7NIfXkatbYxovzTvZE1ssYZl10Y4DrS+5x3PDOYv
 LR0++aG673knS9E9RFtWdTirEnmOm7XlR+VsJf7X+dsYdIlCO5QYzvYSJCH+BuxnlGYx
 5UqE3nhz66f7ibGQAmQ7VjgUZ+hgd7+JHBgQfGHKK1uC/K2y+A2EGpwbsUegL5q82yLf
 RQoSYsrMAv3BiKDUbGOF+sb0c15ir7jz2ZlRpsRUniXE2DaU8gm1qK5no53g3EwLzIdH
 XfaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RobFbCDzypmXHzkcKXPBvFCTEnlAznPrYp6vfuup2PQvkK3kgtKxUuyI7TbelCk0gqtaamWarr+tXI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxGsSZ3iJuOl9Gx0fXC6gUTY0djK1uMjwEUM0TfSWk2sXHugt9
 ybUpJ3fzunJ6oSrUKcVot01izhe+7z5xnTA71DTTjN0+xA92K7GM801PlLPViXb/YLLocHDIh/v
 /0/bo1tN+GKElDotXOoaMn9+OlgNMXOufSxWsEfBMRFJu6/1bnrruR3LKemsL3cRY11orHCQ=
X-Gm-Gg: AfdE7cmbl9UIMbUeNxjK+u2qC8ywflMYyvejN7wdoIeCBdJ7s/p/Jfk5X6paLwGsZLx
 jzyXHwLf6j/+RTc0JX7BXYgPlKzoVdpaIWbQ4YMmkQXaFkVp6rdQHurAsuxF+md/qMM1g8Rf14B
 XbBLruWIJ+clKIDZUd4XqyiiWmoP12HNBMgcubhYg57qeDABzpHet92VRIXSheHHE1/64DfFM8v
 8jJP7+4f9goGj3Tfn3OQXy9+6YAnQ/WHykeyhFxknt54pzGobqDHci7cWtxu9mLnvMfRPeEGgiw
 JYTBUtiTsyJHe/0T+kJhU0WSW0uAsbqeOvT0dwoTqylcE7QT2yK7X+15cJcoQApx+pgDJ84w+e5
 jl1hiZVEV6a1HUNACp0SThFlhGVk=
X-Received: by 2002:a17:903:15cf:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2cf34a22678mr21776205ad.38.1784287585578; 
 Fri, 17 Jul 2026 04:26:25 -0700 (PDT)
X-Received: by 2002:a17:903:15cf:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2cf34a22678mr21775695ad.38.1784287585013; 
 Fri, 17 Jul 2026 04:26:25 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf346d9b00sm9179345ad.53.2026.07.17.04.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 04:26:24 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 16:56:13 +0530
Subject: [PATCH] drm/msm/dp: add .shutdown to mask HPD IRQ before system
 shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFQRWmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nz3ZSC4ozSkpT88jxdAxNzS0OjtOQ0M4MkJaCGgqLUtMwKsGHRsbW
 1AJrgirBcAAAA
X-Change-ID: 20260717-dpshutdown-047912fcf60b
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784287580; l=2608;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=7DHD6sF6jdqNF7o3/oZNHxjqqzN4sJ5d0KCyGYiKKiU=;
 b=GSf66u+dk25WN+0jwRQaVANoC5putuu0JyPC8zueJU5M6/QUUZyAi8edlsA3tPh0MzbsGUEla
 gaZ0fAJJFlWCGymLGyF8k8XxxD46LhZCnBu17n+R249nZgpN5x0hxlF
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a1162 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0qqa2dpHJvpZ0q8GZ_YA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNSBTYWx0ZWRfX4Sjy7lGf6WwZ
 +iwDhHA67r53otcQZysVIdGmmOYMcymCMWoRZjHnFgB/KM9E76bKZx0Yei6mLNyz9hnktMsNplW
 R6vdVW5m6BaOGF5o84JShtzeTIUI7NNJqwluoPzGO7ff69V3iKwaA/iyOuULoDmnQfULN+sW+20
 q6FQi/C090G+vHxaUEy8xIYjgJwHAHQKzhUHGejfbSgZhPHWdNdX304HU2NO8v8XA4zgik7s09j
 yIxrHfSGnZpFBKiCwJAq8cONCjQDUQkb2vPS2m0qiXjhkLWLdl/X14UiPyASS29EY1Icnaavn6x
 ZG1k4Nd1FdQfZHdyX41ZRcqKc/XzaLkhOwe4Vk1XfX6ajVWwOpaFRZHYSRMSlEVT5Xqgmn1nmEQ
 Ega+MbJOA5OOipz52a7hsVV5Ky3ysQLmA9j2MJe6BhHNycaUDgQWfSlomwOm8WgnVjcsJDk4/SW
 cGagSB/gQFuUaiVyNqg==
X-Proofpoint-ORIG-GUID: BvininIOOr-WqAOwJbHR91QDUya2qPdA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNSBTYWx0ZWRfX4uA92nc70/ne
 l+ymg1VMxksfrSIMF3xEy+WVTHJh1msdmeDDyW5NqXvTagABv3Blca3Eg+EI5zML6S27HZvf05a
 GpI8za+do3ONhBRGooT0cYXf/uMATwU=
X-Proofpoint-GUID: BvininIOOr-WqAOwJbHR91QDUya2qPdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170115
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

On reboot, a late DP hot-plug-detect (HPD) IRQ can fire after
apps_smmu has already disabled translation for the display
subsystem, causing the HPD thread to kick off a new modeset that
drives DPU/DP hardware and DMA through a stale IOMMU mapping.

DPU's own .shutdown disables all CRTCs first, but a pending HPD IRQ
thread wakes up afterwards, reads the DPCD, and fires an unsolicited
hotplug event that triggers a second atomic commit turning the
display back on -- right as the IOMMU is disabling translation:

  systemd-shutdown[1]: Rebooting.
  msm_dpu: drm_atomic_commit: committing (shutdown disabling CRTCs)
  arm-smmu 3da0000.iommu: disabling translation
  msm_dpu: drm_dp_read_dpcd_caps (late HPD IRQ thread wakes up)
  msm_dpu: drm_sysfs_connector_hotplug_event: DP-1 hotplug event
  msm_dpu: drm_client_modeset_probe: DP-1 found preferred mode
  msm_dpu: drm_atomic_commit: committing (unsolicited, re-enables display)
  dpu_crtc_commit_kickoff: crtc94 first commit
  arm-smmu 15200000.iommu: disabling translation

Mask and flush the IRQ in .shutdown so no HPD event can retrigger a
modeset once shutdown has started.
Reported on lemans-evk and monaco-evk during reboot stress testing.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dc6f33809ca5..b4fbdeebf952 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1207,6 +1207,14 @@ static void msm_dp_display_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static void msm_dp_display_shutdown(struct platform_device *pdev)
+{
+	struct msm_dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
+
+	disable_irq(dp->irq);
+	synchronize_irq(dp->irq);
+}
+
 static int msm_dp_pm_runtime_suspend(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
@@ -1253,6 +1261,7 @@ static const struct dev_pm_ops msm_dp_pm_ops = {
 static struct platform_driver msm_dp_display_driver = {
 	.probe  = msm_dp_display_probe,
 	.remove = msm_dp_display_remove,
+	.shutdown = msm_dp_display_shutdown,
 	.driver = {
 		.name = "msm-dp-display",
 		.of_match_table = msm_dp_dt_match,

---
base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
change-id: 20260717-dpshutdown-047912fcf60b

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

