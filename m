Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A61C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E497210E92A;
	Mon, 29 Jun 2026 14:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SA2t4ZUt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eXWlE1E3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D8610E939
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3b02646904
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tCpD6xAZSemtTL+9Sj4aRdpF6Ft4cWCqG/pZrWlkyU0=; b=SA2t4ZUteBgd1rj7
 exIOfEuL+Aok2ShujCWlbvvvda6AhiJ40hpur1WIlL3dkN38pWH2G6ugvSrLRVAz
 K66uClc/53KCsLXztoWhIolhamg+xHzgvgSBTuTBATpNF8r2MNfnAbPpEQAY9yiB
 4aUtszoLhmFp4aRpcMRHcldGJIYUax84xmGcF4NiH7FOx963TxVkSuvTw1b6HCOC
 X8brI3y37VyPh2Fl46EeRKuXeHG04bs082sFTVWHSXdCVSKb+iSRZVNxc8X7LfOV
 o2+jKlRoWjxQxqJRFAIG2Hju0LumB600cHAO86vy+JVxvvO30+VpiPvGDHRKVdbH
 FCEkkA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tsnqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:54 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73843d3623dso594618137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742553; x=1783347353;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCpD6xAZSemtTL+9Sj4aRdpF6Ft4cWCqG/pZrWlkyU0=;
 b=eXWlE1E32ajdwV9Vn5wMUHu7YO1PCXfmAJxmndMgF9s1Rdx6fDJvV5j+/Uf79Q9sPU
 qynUm7ZuXCN8k9NZE42AuNFCflbOC2N9Y0D6GkfBRUPp1T/Xd0lJq1pOgt49hgW7KzEy
 27Vk+awe66tQjQdcFZdez3uoF+0L/n5LcHGPCoF5xQfrigE4HYMRFQR2wlBiu8XTA3zl
 m9/KRgqnwzSmFNo3xEC8N9lv9N2fjL5zI8C6pjWuqGJiBkrm83sgIt3jGdojQKQwHjqN
 KyZOpAqPThVKyQE9gB+tRAZWQou/Fw20Q2fyfvmJLxKtdugbLhaWpPBBa7V6BXKUwA0I
 lwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742553; x=1783347353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tCpD6xAZSemtTL+9Sj4aRdpF6Ft4cWCqG/pZrWlkyU0=;
 b=eg/QZI6ad8mdBlJeuZqdinExhtE3GaZdkEtZtcvVQtWfeO0MLmQs/CLl2Gh2DQfMDX
 hsQy/nktkVlJWcsNLBAJtxEBmBanKxlqTWKZfEJ7V3A7nNAnOmWWjDpqsPQv8uVB+jWU
 4JC6x5yLA3V5cfdouCeMTGAV2DH4tMk2+O0/YtTeYRraqxFZSn4gBxOAoCndjrMKYPHh
 sZtpcHAQTJHFJkwvd/7oXlj1I0QzFvjv/649ig0qTTHfdUN+NUNUXoF/A4Bafo5tLIDD
 1StvCD9dLQD0cvCnxjOxDKoGXNn6TnJ5gOfvBtKymSTRfbXmKhoC00eISgloScijSQJ9
 uwiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBsTe9QTp+Qg0iYGPyQGa3BQZdk6MwelzxP7/wpQF97O9YR0xeVjtDOLCmycVX/j2TyG4qdFhFP50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlQ6otDXlcCjpgmCFPdm5KL45N7tURCq6FwUKK6aepgz1ncyFM
 lcXPwkk8hNvmyu7+sAvHtSOyVd6uCHk/Dd5orysYBxF2cFXLZWzJcvMElrxF0+QHuRM3xbCMj+T
 syfLowGsBvyRrqVzg6Ac+7ejS+ZVdH/Q+g0e5J0vhxbGfDcfIK9ybLEPFhEOSLII0xhyJPA4=
X-Gm-Gg: AfdE7cnlQBL4yuEd075Z6fBugeAkBcmQLj8hMG6aurZrf7Z7T+cHCSTdN60sqypzDZv
 LmxmrrLPrprt2fLueuDEs9qdgIJw2DAXp2u92wQ/VYgreoTdDjQ5pdPSgN2FIK8oSa35Upq8QGo
 UUjYSyxFe+HrblNuSUiVtg4hsb2fhZVhwninLEJtYZcq8eA1djKiOvAVFLCxu2XZmSrBsDC1A4M
 xdWT6/oNUg+LmQgZ9V572BG8aZmVLH31NDlaHSc9RT9QCkREHly+gideS13q51qlLu+Usap8pfq
 RiyzaELaf25JDAMcFviMN3M7C0cCp36MrfnQepdhKux3UoCqzXGz0TgY4IcLvO6+UT64RlmEzD4
 gVQAPVd5yA+UbZI41n6d7V+dL8yJFjedbS89ZfNStKYyTIPTxZy47cqoEwpgLJHB/C7Rb6A==
X-Received: by 2002:a05:6102:5124:b0:738:e37c:9c13 with SMTP id
 ada2fe7eead31-738e37ca631mr1294252137.5.1782742552784; 
 Mon, 29 Jun 2026 07:15:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:738:e37c:9c13 with SMTP id
 ada2fe7eead31-738e37ca631mr1294157137.5.1782742551820; 
 Mon, 29 Jun 2026 07:15:51 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:51 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v5 09/25] drm/msm/dp: Add support for sending VCPF
 packets in DP controller
Date: Mon, 29 Jun 2026 22:14:30 +0800
Message-ID: <20260629-msm-dp-mst-v5-9-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=7616;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kb9DHa7CnMIQxIpNCRuaqgUzGVz97zztaJU+4N6igXw=;
 b=favLKT8z5ADUipsHj32imlJm6j6wQCmaSDU+332gCXCCvvS0jpI2inIiu1tfuab5guoHk7rwm
 6FNsCd/qFGCC6SH71S9JsF6Tn6e+jXs+2u/fIBZOgC3wGo2tjuZrFyh
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX1ocy6HCdnu2D
 L3w0GLJKqjZwcBS7k2GKJAVtT0eK/41XtlRaSnkqTE7a+pBSRP6cPe2VQTLX/mq/0FHCdD3yCKz
 1w2r6iBetFdIjI+stiyrmLOob2ljrsMpGrYSP4SmdhEQAjadzsF6SwVaOUtvwJ80xg9OpcH4SQs
 UhcULrWqi2j8JJBEjWXsIjLX2zux1ewn4c/FKYBKVqF8fRobzLfeePou1hURrZpQ1K4sOO1pg4M
 oK40V2XXl5WEjrh1366e6u7WXQYrR4mZorWJPIkoB8UjsinviPxMP3TAShe8mhtHOj+AXuMrX0u
 VT6qum5VXrtA57A1GgkKLOS4YlENIkwayoD6VZeR0W/CvuNanCiZqph5kCdMbeT3q9caEePq0uo
 zPvWfqztjNuLDVzu0Orws8jYeDWTZPVIYZE3R+tvakivi4ddU1PqpyaKo/6mLf626NKxx4WySfO
 YHhc5U6HiuFvx8BqK1g==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a427e1a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=unrKvF7sv23klRea54oA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX91y8IPJVrH+Q
 jta+apCKcUa4zphdA5JCopYXFf+FMPKb2ALJqj5oYMLhG9R/Ps2W6y6wuNi1U+2TjBZp16zSdEF
 PRTEEzhi0cyQdfYHFnXLZvrq9jcgN68=
X-Proofpoint-ORIG-GUID: -OqgSwxFYzqJGkxNFrMaXE9P_DEe8RjQ
X-Proofpoint-GUID: -OqgSwxFYzqJGkxNFrMaXE9P_DEe8RjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

