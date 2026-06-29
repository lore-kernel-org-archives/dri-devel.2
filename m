Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA2CC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0489E10E8BC;
	Mon, 29 Jun 2026 13:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DABwoerj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdKNUUay";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6074D10E684
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATREn2592814
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tCpD6xAZSemtTL+9Sj4aRdpF6Ft4cWCqG/pZrWlkyU0=; b=DABwoerjBbjPHuDv
 UPF3anrifdMLwkqRqRVSUCoy096YMi6/Rhe/nE9IAbqfsXimuL/vPA5zJLEvQsdq
 vhryENNW9LsSf+ZHktG8Re3EIk6OHAQXHxta+hgfJAMKbI1y1SiC3SbsTKrLSCSS
 TvhWfNfpWa8zqWw8WNSnjCifK0BwSb/KSbvcqD6Fp6yyBAh0N5hkHLJL2zv7Q1uQ
 pa1/PnlXfOFl7B++XgTfPxjzHM3W4Frn0KbXmatyfhB3A4QNwxfWe2RmbC52pqzh
 XYYQikVk0yyuNfttrraNeBjqs2d3g+nSBDwTr6bbdTxDUssvW49s2ygAP/GBh62L
 dCAX4g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vht9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so36453806d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739037; x=1783343837;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tCpD6xAZSemtTL+9Sj4aRdpF6Ft4cWCqG/pZrWlkyU0=;
 b=LdKNUUayOWRXYmMwyO9TXPH0RGnIgCToSDt2QIhs1Y04mZSStQUUMU3aTdQKpuqjJB
 +t3ho5ogNc5Q4gP2zoExE+v1CyqEowwuONJNKbW/0Qmu135LG9uiKGxDNFo1OUgGJYu8
 Q77i6y9ePJAr63Oh2aZ3szLMaHgkBCqiqsvHGRVabrzawfgBR01aNTXpUVtwP6gTYWP+
 PNCYFbUdJr7+CTYSnGdaIvaW347cnrdw3da4sJ3FAHoS/0Y/vvAGTB0T4lAi6Zl95uzn
 biVIGxzziMlxHt9dWB8Dp3DraY5QjM8vtLFkSwiAf0AWSRmjAtTQnMGa1yppjJHCDiHu
 fgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739037; x=1783343837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tCpD6xAZSemtTL+9Sj4aRdpF6Ft4cWCqG/pZrWlkyU0=;
 b=MXavs1IG1Q6kULYhUW65tdKqMWpUu5EJCmrOkQy11XUQUHZJTKYrszklX4Qh7qjbVG
 m4TW5JZFEUEFtu4gB6yNEvhJMKoUvBbOxwXrmNx4ABn75EnZK8DSLY+KbfyJ1QnVZxPZ
 u4hrD0jvfvNXeyYRHuzBzi5dk724sa/YKxvTUjqKwkQ77z8GQeSo4am79Zc3OXL/G2K1
 PX1VMlsEDDiIC+DktZA43buAJHJulVSmUS1Rka1m7Veenr5l6IL+wjGB17W32JMUFIhg
 FXfEswwILBD0XVQio+Vc6g5ZNDcCMkp/b+19EhHBFJ+Z9Fc0EmKiQfBuoAjYFYCUR5Ii
 Nkhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGhlagGjody+dBQjLTpBAToGXdMwJOFllg5B7wLoHbq485TbJKrogTnP2AoS7rB4hs3CmEZukhgzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjCc+uKOMd4H+PGjMKZ8gm/dBPYQQK+MdcFe60OyBON0HiHEh+
 ldYbQL1kgXLr9PokoIjSGiu2EmlU466GhKF6wyttBukaalCCuW2zXFLgTjbWDd/UrChpYyy6687
 7OLo3/4smDJWCzPg0LTxs4OIWaiP/umOGK0OvShLuJekxWKO9SUKbrRQfaLvsjEW5+rYltr4=
X-Gm-Gg: AfdE7ckfHib1IjBLPvxHAuQSQRDufvIlfBbXJoUOEFhCS2aLgs7iArdpY5zJD/BldmS
 IcP6bQyzJcjzWTY1cFYEmUrrtmu7TYi4PdQpzKa8oHpXvBq48Rc9o3ACJ/8Q6j8iCBe7XgTdmXQ
 gAz+CuG4DdDjQBCSuorEd121a4OvDefyk/kEsVAkihIbEzg4N/4FWhUasDCUjHnuczyb2+QQxsz
 IrX1s2F0ntaaLCswf0EGYx41ecMaHeHAapftCeijZZ2kuA6OyUN5nzlf+57y/IrMK2Lg7qa14Ve
 JmftjmtespRNtfuiXuLh2V9Khc+iRNwsuhNui/4Uiqn1il4arXOea18g+NfZAszkpko4XX2q7pZ
 V7rW/s9UQQWYMgBSw21MyLXhqo2jNXbpQrfAR3JNhccxTOl7cxZjhiR2OnJ+wLS6ujBPtXaz4GA
 ==
X-Received: by 2002:a05:6214:212a:b0:8f0:744e:5692 with SMTP id
 6a1803df08f44-8f15abb40b1mr10159046d6.56.1782739035857; 
 Mon, 29 Jun 2026 06:17:15 -0700 (PDT)
X-Received: by 2002:a05:6214:212a:b0:8f0:744e:5692 with SMTP id
 6a1803df08f44-8f15abb40b1mr10158236d6.56.1782739034943; 
 Mon, 29 Jun 2026 06:17:14 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:14 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:27 +0800
Subject: [PATCH v5 09/25] drm/msm/dp: Add support for sending VCPF packets
 in DP controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-9-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=7616;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kb9DHa7CnMIQxIpNCRuaqgUzGVz97zztaJU+4N6igXw=;
 b=qBt8aAHxlHzwW/GlsJbLILJeqblpEe9KUNGkItVOKRW39WrBRKv1ZrGIu4FikPbSXGk7h7sWw
 6ua9I8uLPbXCxfWJ70cjehma1OZdbUKDivDIsHr68cEzdp5k/DqVcPF
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: EyuPFWTk5irDhLpiIJdX6dgcHIqo4_Wm
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a42705d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=unrKvF7sv23klRea54oA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX/J+Z/a7CXEA8
 szFVWa8bAqKUpXMY3SpSpILFyVZr6hIbiXDjvE+a5rObR12LR9vGbkYIHUDwhiUIdF59Fx01fiX
 qGr1yG/gVY0Q94srEuf3Tge2Co8sK8Q=
X-Proofpoint-ORIG-GUID: EyuPFWTk5irDhLpiIJdX6dgcHIqo4_Wm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX2IqmGBGd7fOs
 F5vr3ITZUwOERiGskt8OlfGROcq0ZjOp1MEy7pG1NZBfZWu2eHdQNk0TtuzvZPiid6Me8W136gg
 BUg+ZDZVR/Hqscfu7ovCjuhE/y+Ps4VBbs3zm9tu+E7o153zR2FZib1bBzCV8tupAcREJE1XiL4
 PNFBe3+WSfVQWDyqQSomiBeHP2zMKPhza7cnPJKqbQM/yHpt41zccMHBhG2KXLCzvA6J67lfq1G
 9Gau3ufvn/rOVoKgo/kQf+0PUDdUC4wWFiWTW0LsouyuK38NaZ4Syn+smKwFlQlWMStSFQlnZV1
 /OktojCq6W1WTGzvVmkXy88DTq8K8Eyv4UqpKoCVRBBghEUmb1r0jMFYxbqIaqmqi3t3GXsyXCl
 8MGEbicMSIarIqSk3Ecm4NrBKJbW3rEZfDrqJmFmhiFI6F9AzvMwnrRqRESmpZ0OL0Ro2Z0sE5E
 jkHKhdWHZChf2mTee2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

The VC Payload Fill (VCPF) sequence is inserted by the DP controller
when stream symbols are absent, typically before a stream is disabled.
Add support for triggering the VCPF sequence in the MSM DP controller.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_panel.c   |  2 ++
 drivers/gpu/drm/msm/dp/dp_reg.h     |  8 ++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 15df82a0caca..c4f1a68b1210 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -65,6 +65,11 @@
 	(PSR_UPDATE_MASK | PSR_CAPTURE_MASK | PSR_EXIT_MASK | \
 	PSR_UPDATE_ERROR_MASK | PSR_WAKE_ERROR_MASK)
 
+#define DP_INTERRUPT_STATUS5 \
+	(DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)
+#define DP_INTERRUPT_STATUS5_MASK \
+	(DP_INTERRUPT_STATUS5 << DP_INTERRUPT_STATUS_MASK_SHIFT)
+
 #define DP_CTRL_INTR_READY_FOR_VIDEO     BIT(0)
 #define DP_CTRL_INTR_IDLE_PATTERN_SENT  BIT(3)
 
@@ -398,6 +403,8 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 			DP_INTERRUPT_STATUS1_MASK);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2,
 			DP_INTERRUPT_STATUS2_MASK);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			 DP_INTERRUPT_STATUS5_MASK);
 }
 
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -407,6 +414,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS, 0x00);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2, 0x00);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5, 0x00);
 }
 
 static u32 msm_dp_ctrl_get_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
@@ -426,6 +434,20 @@ static void msm_dp_ctrl_config_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
 }
 
+static u32 msm_dp_ctrl_get_mst_interrupt(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 intr, intr_ack;
+
+	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS5);
+	intr &= ~DP_INTERRUPT_STATUS5_MASK;
+	intr_ack = (intr & DP_INTERRUPT_STATUS5)
+			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			 intr_ack | DP_INTERRUPT_STATUS5_MASK);
+
+	return intr;
+}
+
 static void msm_dp_ctrl_psr_mainlink_enable(struct msm_dp_ctrl_private *ctrl)
 {
 	u32 val;
@@ -525,6 +547,34 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
+/* Must be called with msm_dp_mst::mst_lock held */
+void msm_dp_ctrl_push_vcpf(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_ctrl_private *ctrl;
+	u32 state = 0x0;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->mst_active)
+		state |= DP_STATE_CTRL_PUSH_IDLE;
+	else if (msm_dp_panel->stream_id == DP_STREAM_0)
+		state |= DP_DP0_PUSH_VCPF;
+	else if (msm_dp_panel->stream_id == DP_STREAM_1)
+		state |= DP_DP1_PUSH_VCPF;
+	else
+		state |= DP_MSTLINK_PUSH_VCPF;
+
+	reinit_completion(&ctrl->idle_comp);
+
+	msm_dp_write_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_STATE_CTRL, state);
+
+	if (!wait_for_completion_timeout(&ctrl->idle_comp,
+			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
+		pr_warn("PUSH_VCPF pattern timedout\n");
+
+	drm_dbg_dp(ctrl->drm_dev, "vcpf sent\n");
+}
+
 static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 					    struct msm_dp_panel *msm_dp_panel)
 {
@@ -2994,6 +3044,13 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 		ret = IRQ_HANDLED;
 	}
 
+	isr = msm_dp_ctrl_get_mst_interrupt(ctrl);
+	if (isr & (DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)) {
+		drm_dbg_dp(ctrl->drm_dev, "vcpf sent\n");
+		complete(&ctrl->idle_comp);
+		ret = IRQ_HANDLED;
+	}
+
 	/* DP aux isr */
 	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
 	if (isr)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index e1d10ae20f70..88a02d52f61c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -27,6 +27,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			  struct msm_dp_panel *panel);
 void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_push_vcpf(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 36857d6ed313..1af56c84b82e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1524,7 +1524,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
 	msm_dp_ctrl_mst_stream_channel_slot_setup(msm_dp_display->ctrl);
 	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index ef2ded8ec4ea..cbbcc0dbf652 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -39,6 +39,8 @@ u32 msm_dp_stream_reg(enum msm_dp_stream_id id, u32 reg)
 		return reg;
 
 	switch (reg) {
+	case REG_DP_STATE_CTRL:
+		return is_s1 ? REG_DP_STATE_CTRL : REG_DP_MSTLINK_STATE_CTRL;
 	case REG_DP_CONFIGURATION_CTRL:
 		return is_s1 ? REG_DP1_CONFIGURATION_CTRL : REG_DP_MSTLINK_CONFIGURATION_CTRL;
 	case REG_DP_SOFTWARE_MVID:
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index f2bd96f3bbd0..ade7b362d650 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -42,9 +42,13 @@
 #define DP_INTR_FRAME_END		BIT(6)
 #define DP_INTR_CRC_UPDATED		BIT(9)
 
+#define DP_INTR_DP0_VCPF_SENT		BIT(0)
+#define DP_INTR_DP1_VCPF_SENT		BIT(3)
+
 #define REG_DP_INTR_STATUS3			(0x00000028)
 
 #define REG_DP_INTR_STATUS4			(0x0000002C)
+#define REG_DP_INTR_STATUS5			(0x00000034)
 #define PSR_UPDATE_INT				(0x00000001)
 #define PSR_CAPTURE_INT				(0x00000004)
 #define PSR_EXIT_INT				(0x00000010)
@@ -143,6 +147,8 @@
 #define DP_STATE_CTRL_LINK_TEST_CUSTOM_PATTERN	(0x00000040)
 #define DP_STATE_CTRL_SEND_VIDEO		(0x00000080)
 #define DP_STATE_CTRL_PUSH_IDLE			(0x00000100)
+#define DP_DP0_PUSH_VCPF			BIT(12)
+#define DP_DP1_PUSH_VCPF			BIT(14)
 
 #define REG_DP_CONFIGURATION_CTRL		(0x00000008)
 #define DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK	(0x00000001)
@@ -368,6 +374,8 @@
 #define REG_DP_DP0_RG				(0x000004F8)
 #define REG_DP_DP1_RG				(0x000004FC)
 
+#define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
+#define DP_MSTLINK_PUSH_VCPF			BIT(12)
 #define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
 #define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
 #define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003C)

-- 
2.43.0

