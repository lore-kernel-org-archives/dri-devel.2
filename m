Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F6C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6F310E873;
	Tue, 28 Jul 2026 10:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pg0i3aWZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HX7L4dbz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0B510E875
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S81xgY1663585
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +qUZfolgL1Wa6VYURJUQCWKPWvHFKYbdxR2qbwjYNVs=; b=pg0i3aWZsICsPZW/
 Fg0T9jKtkF6I1NzmuyNEaeAfF2yVmMRFmGtyMIoQxL1Rp8HO/SRNwoCf/F5ziaSg
 FFtDwWtX2RTFmJLztFVMg+1YTOJh9IJECK8W8aDdM3pEM0SOZiyH31s18vPR7qcb
 OC7igRuakjEvSxop0KUjGLyrS+UoIN6v4A3Hvd3CUNE+BbzoRJ10OL0+pM+91fwc
 HsqDHK2dCPFPwikEBAc89wE8eIEsU3MS3sExifKk5XVkjoRFLfy73WobXCuVCahp
 ZNKTmepzDi/FRWCdu5PeQCOCEYajEcyaPy10pMN4q1dUPF9JzAZzx1Qihk1fXMJU
 fFyGEA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpptts2gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5283fa0656dso10577601cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234153; x=1785838953;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+qUZfolgL1Wa6VYURJUQCWKPWvHFKYbdxR2qbwjYNVs=;
 b=HX7L4dbzs6gNkIMLOtbf3QeQqp5yZXQT6nuQVO5JVcRT1MmqdfL19NJ2YnneT3KCs5
 wPULKwzDzPAwPFfOTZCvvlO/eFRdL1U5+GLheLQiI7i45qGkSq/t2asOYaLV9N6zPwI9
 ymmf6TCN1DXG1ce/+1IjCqaoOG/6rnJJxPp+wS2uTZUhKmogUjEpBHOZooOtd+o84wsJ
 el+mkim1/m5RS4Xj/Cfrj5B2xHRrytHu1yh4w8FOucSFuWwIOJJzl4SR1BGupYHuqHGI
 zFx3+qhjd3qyGeikMUrvUJF+zojjOWYkPPWnZ/2olvQHA+xLsO0Zuibk+NCIwKgm8vrK
 8ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234153; x=1785838953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+qUZfolgL1Wa6VYURJUQCWKPWvHFKYbdxR2qbwjYNVs=;
 b=tX9UhyY4VUPzGwpqDzEIZWwJT8OYn98/pc48VsmcxKXBXU6lG7CrJzCbVhPy1Wa0x9
 yvJrdMPvFz6ekt2L72bnvol7HXgLziTsesacWytSrXsvlC90w5OZ9rWHIfU1niGYR6XH
 Eet9jCLyAK4PIIwPFtpEklfp9AUwxW54Dc52DNOmXUDz0i9q0VbNpAOmIZ/Q2C/t4nir
 zRsZVKpLCeGk+MhLJ8c3CS6+VNUwOqOuB8h3vng2bb2mz7XilfSBanX9L5MmqanTTZXG
 CZmbYNju9p1hGpQzUYlKXeSTwuCR6AuDeTKfxHo+c+Uq9GkC8SJNj4qxpjUbM/4pZnkr
 Ic0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNdNO/Uv3AgrwJ2uAy6ei9Ba73XWEwCpY5HYv3Y7Zyq1jRfOzBXNPSwZFSmqiut89FVj8CNDW+AbA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAvI6z9JZ4xe5oLOqGvEdC1BuWC0/LlEpctwCYH73yLNjfezvx
 pTvtoO7tBjf/71zzO9qcMVs2SCG/eEnIMx6+IKd7S7Q7uCp3Dg5DW2eDG/UPjh5cud+50nFNwlx
 dnqsP9je14i4dF4TSYmRS1bLGBJJHzbBsFZrqosyFOy8FCj6CJxsLUf7aG5sXHFdLG51Yrwk=
X-Gm-Gg: AR+sD10pWPVMwdJr3yKrKh5tCtdUtdE3/qDNSWYtTkc/Sp9fwddr2G6ptX6A/AjQOvU
 ssGed87cySDbXV95D9ueySqMSzZ11QkuRjkHaT8LL8oBcIu02eCnHS74rzO+718/g5bORxf/nbU
 Gi/i0Yz30TAqpu9C5+9crlrBRs3ubzmuVm1OA+yGCUfVxnBP9k3ToVP9c9v7XkfIIiqk4e1HFS2
 wuy6fO1g+jl0co0mgyobfaD2GSmvicWKbM6vqQDH/L0MtSia7xBl0rF16tYIarXEIQXh6dcHRV7
 F+ANrVJ0Y4tRHirc3/GMZpZYIG21crVaXYqP7I5v+bF7aymY1wTbob+8j6BQTJIegpHebvQFu6B
 7NXuBAA7KQac0oKWxfH0YPWa9vc1Akjjy2J35eB2jT9TP6jtLqWTO61iQV+XlFPs=
X-Received: by 2002:ac8:5acd:0:b0:51b:fe30:b8d5 with SMTP id
 d75a77b69052e-529d7122607mr12401041cf.29.1785234153485; 
 Tue, 28 Jul 2026 03:22:33 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:51b:fe30:b8d5 with SMTP id
 d75a77b69052e-529d7122607mr12400791cf.29.1785234153067; 
 Tue, 28 Jul 2026 03:22:33 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:40 +0800
Subject: [PATCH v9 11/14] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-11-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=3896;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=zIJjql9mV2Sg5qOti+JyKR2/YpfT+bcSzOdOAEdO0ZU=;
 b=QVs/RFzFVYJr3+s6xUa42ixi/vFLa/GZO21ezw7njlcmE+MkppGvTWLVNX5tEiXQdpSEe8r+W
 Hkw/TwrozaODAAhzAUPh96fcEgEOLHnoLF4KSXRoCcCPTCRP48W8tA0
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX985T6uRIN4da
 MNCp9t+DJ6Ecanecpq0/kmp4bCxrptOMWz/n7OVJBa8jgGiMv5qTGa0clofmyWeLB+P1Aw6U+z1
 ZmPOSKXVS2eaiCvObaCs/w3dlUXzu4o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfXz98pS6Ne4yly
 mowYHP4fMV3As8KO68/oUosu1XENfAuEBVEOpk+mFRlQ4hH5b2eT/1tb9rf2Hc5Sa4sOBckXxaS
 vt2MDJjaiqkzcbyYyV+3YR/opAwe788oeAVqolJbPM/XpneThNf2viudLKDvRBMqGhQjhtUa7DB
 VNSRTOy+725Kp/lnCJD90Wu5olA+PWw6THKFCzjOYljxBDHdQ8PHtMnT09qafzwNzBZ9zXd7BOO
 dK6Q0JYBgVeqHZaztcYjqwFJw8B1JgyJKiL3EAM6EYoKyERzVHGnFQZV2C1lHH4VoA7tfkW0GG7
 RWZAvV6kNBMXchczvwOHcH9B2AlYXDn1GZOkxtRwcDEpp5p1e2MbSTfOHRKTRHBFSLae+JM2fDx
 KD9iLFAMKNV5kSRQF0m90EmeMF8o7V9cVe1jZVgJdR6+2Vw4aeCzrAE8N5+fBY+P5WEGedgNzAb
 xVtNke+sWxHg9WXqn3w==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a6882ea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=btynFov_yHAME20h-3wA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ex5Bgl1-69Fi8inO-L6QoFQ-uqKrY2Yn
X-Proofpoint-ORIG-GUID: ex5Bgl1-69Fi8inO-L6QoFQ-uqKrY2Yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Split dp_ctrl_off() into stream and link parts so that for MST
cases we can control the link and pixel parts separately.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 10 +++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++--
 drivers/gpu/drm/msm/dp/dp_display.c |  7 ++++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9bed5a2fd2e7..5d896593771e 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2215,7 +2215,7 @@ static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned l
 	return ret;
 }
 
-static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
@@ -2244,7 +2244,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
 	if (ret) {
@@ -2640,8 +2641,8 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_init(phy);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel)
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2655,7 +2656,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
-	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 00b430392a52..5902cf7e746a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -22,8 +22,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train);
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1b9b7a4e5db0..6e392a99438f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -727,15 +727,16 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
-		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_display_host_phy_exit(dp);
 	}
 

-- 
2.43.0

