Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B72C43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EDA10E91A;
	Mon, 29 Jun 2026 14:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VKJExNGt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ivx480o7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E8A10E660
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3VB2601595
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i5I7/GYfl2jmAzQHd0ut9S5y6abt3vFLbK90TYMdM5k=; b=VKJExNGtutRzityu
 pT7/lB9dQJBP/1fy+5BjJR8+IGzFGk9ckhSOd0rs+ttSoTTeKiqr1xc3xg7kEMqR
 H6+TquKBQ2YWDRLI1XYngHrngIzj0yKl58qbLJC0aPe2N/6ZAfkASLoMswQtxIt7
 q3NVFyUFfaGJazIIvBkkR3OmOlswfaJud6/YigNDVmf/O/0aVZnOuIpSFUqIkTtN
 HQheY8uTnnnOVEz1qqiKehAs3WWG0Q3hbtOX8WiXXM303K683+a2ZWn+BPurGXzJ
 Ahd9iZt+He68sXWzQlnVzNmzP5DH6aRMQL/V+CNGj+PnkU/WFB4WJh7/R8Y7evth
 qkB8Yw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw97kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92b4b575561so632743485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742530; x=1783347330;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5I7/GYfl2jmAzQHd0ut9S5y6abt3vFLbK90TYMdM5k=;
 b=ivx480o75smqPzIWJgAs5uCB+LZbI59cani3cGVhlBk9D5/SyLo7qCNbUu2P+/gaqB
 XrefbkOuDmUTapy3mgGE/VyLyleKx2Gij69pBISogTzZcthPu1UxxLckpeTJGv+A0Aq9
 /htMxsaEde32n6212+mnC0kMcXgOkiHR8gbDfQYm7h61H+e4ZGuSAEFAbaWWdetCw9ne
 AfFBcINYcM7Ek4RNRjUnMszqC/8Yw09m0w5uYxaDLypMv20MqMLb+QzgFhF9MOot8OBZ
 3/9hWv9Pj1YgQKDEFNjKcu1W/OabEPiHNxAbfYxYoMyicRIlgGV6jqbl6vwgn9x+BMxO
 8+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742530; x=1783347330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5I7/GYfl2jmAzQHd0ut9S5y6abt3vFLbK90TYMdM5k=;
 b=rL1nIMNf5OEndEdoQQO6R2W0ncHipJBkL1UI7EoO1SmsJVlQH+UTjyNa9VN8aGAwfJ
 OEjj5VA/YdXcyF0e3jOnWuoqGVGxkXMi410rkcUgzCYrQtpJsTIYfSEMnLHypc51ov+K
 mfF1HxstWiL8RGi94SQJPJDQ9KoVFC3GDZPvBc7BvgfI2nf7zeH+7pv+9vbVkJR68143
 +brn9Ujnw2WJRT21DEzFG2/xBgUIclJOZKl6DtN2OlAVWB+IYphB+0kC4p5RvT/v/Mcn
 L4y0LDnLsBiRfVxY7ZPpLwWOsTN/RNDmtJBi2uSpifHzjiCBYGRceKI54q2wkU58sfaS
 wobg==
X-Forwarded-Encrypted: i=1;
 AFNElJ82CbzgUOVhr76QYG/+XGpB2y1mz0vNt2LFT5sPbfarZg58Eu1NUo2S/n+JUq/ECaKgyEcUpGafiA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfCXuJDTE7uCdtl2zAvkDTp5LWtNKI36gIm4JnKka+3wr2tXr0
 DI82qKvnz1EGXhdCldkO8/UM5RiRCyl60x1N6Mq3au+tf2PGvZGE3Z5haWo/XFtwJlrb9rbvqFw
 www0A1yVFswTSKxvWhwziYHiTRcs63IcFiOLlt6HLGxVyWMSDjtJky0UXuim7MMqQoBlv1ow=
X-Gm-Gg: AfdE7cmzqPxhTEdxXmNNvGPRaF5n2c+O8eCkPox0Tg+kcVz3eL+a1WzTrGLbI9rOEYY
 523MGfwNw8NLlDNLsGn6XmBAeg7p2tIDjRNJW9qodVDTCnkTPIU9x3vpwwnhE2wybgBW9wEYJkz
 d0tHUwgwTyByrqAzw7AV96S8GHRYfyLRJOtjlcpBhiMe5yyxnkSDPiOPWoxYLE2Z9trjbrEscs6
 B5qzMIbZVftCoITRfIH6DKpfCroYcpziYlm8Np12Gc+eJqUGaf8c1lhKbPzbTXB3IBDGM316wQX
 bISMU3OiE5z2Kk/FyzpOmVI2tCl6a9MGp8Y/Dv2EU31kuNGr8knB7f/6yUVdG0z0VgYtFj+HK8i
 RT12u9hU/uYNGrDvE5B0ABOytdFqT3/6bDVZbqvXGuY++tsKtaSiu2x7d/L68kj7VPt2utw==
X-Received: by 2002:a05:620a:29ca:b0:92e:5b63:224d with SMTP id
 af79cd13be357-92e5b6324fbmr225270785a.26.1782742528754; 
 Mon, 29 Jun 2026 07:15:28 -0700 (PDT)
X-Received: by 2002:a05:620a:29ca:b0:92e:5b63:224d with SMTP id
 af79cd13be357-92e5b6324fbmr225252085a.26.1782742527530; 
 Mon, 29 Jun 2026 07:15:27 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:27 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 05/25] drm/msm/dp: add support to send ACT packets
 for MST
Date: Mon, 29 Jun 2026 22:14:26 +0800
Message-ID: <20260629-msm-dp-mst-v5-5-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=6676;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=r08KKKkvMIlamabPFqv7xoxa+q/geEn5p6rbSAMhrAg=;
 b=jgQuXjghhW1PUmsB4lmxGSEVQZNxEKUNfUr6YPodEsaaMwGY+T3eosCrdW9HuWlWtgLPvdmwW
 qNasezMSTijB/P+pwz0vVu3J/wSSybnUa/k9uXNPl6zpaghfbuZXrTX
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXz+dW3avsgdro
 mHfR1rxhEAy7eG941F596TBhCRptXEXLs7xSi1qv2egxVTyFa1nm6VY55V42MxtY3hpU1B0KYMS
 dnH/nMACfp6WYecgvYrvhotRnGXtPrE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX04NbuSyStkZ/
 5OQ5DiQBr3KyouC4bTo2U/RoCpJe6HSAXSpYTDpzjDylE3nWgcQcSjRT10oeT72vVns4Rc2fz0O
 HlFg0umgW7cmoJnXf7wOP9Gp5LLD69P+9gS3jqet3OKDgeRTaTCoocONb8zPsAx6BeOdBa+AQ0z
 VDJzP0X9bbSQsl5iCsl2RvjeaK6aj3zr8zlLO1BQhqd4CMgwMH3w1zMq4w4bhRjxa9O1r6wGIBp
 WHtXQmoJ8pzh7IGMggpBxrAvBe8eGOfxWsqQJsqQpNQyf9RP8unifMj7mQefSTxCI8Bh44Un/sx
 +JwfLnPfTFi8fDG1eKoBTNz1visP703tyXs0rRas+IJTgiQRnmZMpU77YPx5FRgXCIs0Boy4wQl
 cTP9wgPBcHqFhcQi3GLwYoKPriSum9J1syjsMOKPHbx0v7Akt5OwBLYcRAJsjr7TB5+nq5Cqk5u
 kAqbiAx3G8cetlsLu0g==
X-Proofpoint-GUID: 1GAJqa7ij2sxN1NdMA9KRcVUwl3Pw9yp
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a427e03 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WyzI5VeO30yZZBqxhZsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1GAJqa7ij2sxN1NdMA9KRcVUwl3Pw9yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
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

Whenever virtual channel slot allocation changes, the DP
source must send the action control trigger sequence to notify
the sink about the same. This would be applicable during the
start and stop of the pixel stream. Add the infrastructure
to be able to send ACT packets for the DP controller when
operating in MST mode.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
 drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 5c491a925b4b..6754b10d418c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
 	bool core_clks_on;
 	bool link_clks_on;
 	bool stream_clks_on[DP_STREAM_MAX];
+	bool mst_active;
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -244,6 +245,37 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
 	return err;
 }
 
+int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
+			     struct msm_dp_panel *panel)
+{
+	struct msm_dp_ctrl_private *ctrl;
+	const struct drm_display_mode *mode;
+	u32 frame_time_ms;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->mst_active)
+		return 0;
+
+	mode = &panel->msm_dp_mode.drm_mode;
+	frame_time_ms = DIV_ROUND_UP((u64)mode->htotal * mode->vtotal,
+				     mode->clock) + 1;
+
+	msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
+	/* make sure ACT signal is performed */
+	wmb();
+
+	msleep(frame_time_ms);
+
+	/* Hardware clears this bit after sending 4 ACT headers */
+	if (msm_dp_read_link(ctrl, REG_DP_MST_ACT)) {
+		drm_dbg_dp(ctrl->drm_dev, "MST ACT trigger complete failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2610,7 +2642,8 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel,
+			  bool mst_active)
 {
 	int ret = 0;
 	bool mainlink_ready = false;
@@ -2623,6 +2656,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	ctrl->mst_active = mst_active;
+
 	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
@@ -2658,6 +2693,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
+	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
+	if (ret)
+		return ret;
+
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 	if (ret)
 		return ret;
@@ -2695,6 +2734,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
+	ctrl->mst_active = false;
+
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
@@ -2877,6 +2918,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->link_base = link_base;
 	ctrl->mst2link_base = mst2link_base;
 	ctrl->mst3link_base = mst3link_base;
+	ctrl->mst_active = false;
 
 	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 49d16911ae8b..6de028da85fb 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -18,7 +18,8 @@ struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			struct msm_dp_panel *panel);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel,
+			  bool mst_active);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train);
@@ -58,4 +59,6 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
+int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
+			     struct msm_dp_panel *panel);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c58896b351b3..acb581a8a541 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -673,7 +673,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -1509,6 +1509,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
 
 static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index d3d4ab98089d..e987de80522c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -19,6 +19,7 @@ struct msm_dp {
 	struct drm_bridge *bridge;
 	bool audio_enabled;
 	bool power_on;
+	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 310e5a1cc934..6808965878d4 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -156,6 +156,8 @@
 #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
 #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
 
+#define REG_DP_MST_ACT				(0x00000500)
+
 #define REG_DP_SOFTWARE_MVID			(0x00000010)
 #define REG_DP_SOFTWARE_NVID			(0x00000018)
 #define REG_DP_TOTAL_HOR_VER			(0x0000001C)

-- 
2.43.0

