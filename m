Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491460A3802
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=odAHJsxI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dj9lRk4h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C05D10E2DA;
	Tue, 10 Nov 2026 04:55:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B14A10EDAD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA49u3i2294724
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YOeHFzSP/M2lE2RBxHF9yVFMDiuJq1eI6SXiZToljd8=; b=odAHJsxITZj+MolN
 vlQeds+o5gZXZCfXGy5JVhytvUR3SkZAtO1tl9HX5fJeqjS90GRJrM/OoDP/P3iN
 XUvdPYdXMasvyOVEMkEao/XMDlWbVLeZsD0Q5jhFtRtuImGpaKUe6rCP4FNTQrQw
 p8RX/0DhhnkPM/Wxl84BLY7H+8j9ContdCEjXHYdZoqnUsYhnANp2MwtSOb8MlMe
 ZOqDLqjUF0AtfhjKvbUaQwjFEmVMvzBzSXhT6xX5y93PEiAGUbcGPxU0Nh3md3yw
 qmGIeWEQeBIrp/pvhsvRFsWk7wB8bjgvV1oGlHHcg/uCTF1UMldWrOW2a7baOOCi
 XODvEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5un7c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso28838006d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286506; x=1794891306;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOeHFzSP/M2lE2RBxHF9yVFMDiuJq1eI6SXiZToljd8=;
 b=Dj9lRk4hQbpbqaHw1SNj23d0NsTFta1AZiOQuG5ukJ6BRzyJNhywSyLc9eu+wjxdCq
 Y91CQWpkB+tRFI7meZcPaka4hv1hxLye93SRacHxey9u3jKYItHyAb2EjPtirAlV8abR
 epTpvzBC8921KD2QakBtDuGktUJhdtGypcjFCzHYu9Nhfm9h+p2DexsL/3qMrDqETf7B
 bi1ksPsjbphaREOIa+tPdL/I6vN97ScZD9upFiC5Zuwjm2gnUcPNtgOgm8I7ia6NKyD2
 9JqBp65+xerPFA1ftNTdHJyu/XaRkqrSfZTi0DUDRj9NuPZkJph4ZRVVgNzHiGf8nwEw
 nqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286506; x=1794891306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YOeHFzSP/M2lE2RBxHF9yVFMDiuJq1eI6SXiZToljd8=;
 b=xvbTnSJaI6J81uz5Tu82LdyTH2ymTeG5FSE68CxyS9w8czTlZoxSlDxu+1A/oZLaWL
 4BMvRtoapAfbZaTaoLkUC9xvJVK+sRmf3wTGjcaiKvMFonamR9vxBa27bOqKNxWudleD
 ng+b7h0gI2HvzGdvFVIvTvr1ttjrx/cbHFV3GPFLcGSFM30X7B0wnbO88TQvxoKc5BKn
 ydNjzEq71ShiVK29KBj9T82ZKD15JbcDdW4Xt40Dby//I+4knqnWDou0A3tfgBguYkkF
 zETbUovfxjCmOsAgUdU8/vxjHaXGZTjFe4ukpDEhD6mifjtIT3iYXREMiaHYcO9yWDsS
 EF9w==
X-Forwarded-Encrypted: i=1;
 AL+hErHgAPvavb8omPSEGGv4SpiVkpA8dTdLm2EISFZwaPYC/xV6g0Fq23vEAHkZvpBLRM6UjBL9l1orlr8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Jbv7PSwMu4HUpWBjoUezIaGEe6GdD4LMSON8Q+Op8ZBufjW8V
 uEtqq1X9T0BSux3wQIDtw8xAEzMG9n3LONTcnkVcjgEYyi+/fcxskCUskJKqGB789uA0sBD/DUb
 Stx/5dQBb1vFq2Q5YCYxvIL3HgjM9YFZD/wxhDAxf2tDw4jBXhYvsJxg6cIIoyUhOuXu+MDo=
X-Gm-Gg: AYBFou2/SczR4z5KYx4h84G3AP/GuBPJVFGwdcofVnIS0UIKjiZYRvkskC1AuQ9SILJ
 c98yX1Q8fLi+TQiOnAsLoILh1pIIkJGfJkUDFBiWhmteadU3ofddKqdg65pr18IQkp6m6xcILLT
 gIih8HcdY4XK1u7tPit5XutQooXz4e8qDr8wU9b0gVzLg0cDQB3F+bW/T+RG7LJtOt//UN31rPx
 Z+IM0BwmqjEzYZssou4R9zEB/r6UaMOQfKzE6C75oAzhZnBGVAwZHpIlsW5DRkFRqqUuTUdMkaF
 n9WxRp1lxPoIXy1/rHv/XoFC2Rsb+zrsXljRr6W93fx8ECmWEXBKfxrMNKAH/yIrKoj4CGlYLRv
 G9Fg8F+824ymz1VKenA5bwAk7bVKGwkLDnQPQDcXd+vgjGLheI/8zisZxPPhOIrbX3dUMVOgRW9
 Yj+RK23c2GEZG7iGHkQ8g5792EiOtQVvlDceUw
X-Received: by 2002:a05:620a:46a7:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9479f1e8436mr255893585a.23.1794286505719; 
 Mon, 09 Nov 2026 20:55:05 -0800 (PST)
X-Received: by 2002:a05:620a:46a7:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9479f1e8436mr255890185a.23.1794286505234; 
 Mon, 09 Nov 2026 20:55:05 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:04 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:27 +0800
Subject: [PATCH v8 06/29] drm/msm/dp: add support for sending VCPF packets
 in DP controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-6-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=8277;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=AnPSKBPQwv/mJseBH4MWUaEZFwaWXwY/PyWgtH4ZzSc=;
 b=9EgZ5rtljGEBS84O2Z8wVDlLRCCcRkfeq+Fi3lgP7nSiOL7olA/2X5jNZlGsxfzOUBavG/P+W
 /WNjnpITY+6CCpxxmaudLQVYE/gIWn3CX9TiU5azjBsoAMg7iI10lfO
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXzv0CRBfAf7+g
 25bPHS9QftHNo45HxLp4x6GN6J51nt2lG/ItKzRA4pmBac//5N/i2N6yM2xbxTshZolCGM0b/il
 I92nbQjJU6ruHat2yF1lzmawsRjUOoU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX0tYdoxSrBcUS
 OyBWxeuvp7JdcFrbEZ8rlOgyrvd1O1pECVZpRgQwMQIzaUP5iqB9oevexS0jYO7ojCAGc2j7/Jz
 i1krCHWBj8NYYtCkDqBOn/M+oAWvA3lILH3f6noX+kk8pTebLXeoglK0WtGq1D0JHwowh+5Xgdx
 G77KgqQL3bK3U3T7MCvQQYRiMrDi+h+FypQKa55AUqjivr2FzQSPjgN4HnzqSATLuyQnFCl5Zyr
 cJEYDSjCQ+g4hdQhSSOoUspIAF7+GNikxkrpvTkBHR41fTHA9wGGbErJPOxZsfkA5GyyIhg//4x
 +FkfTLd5BLSuAp5XN8B9cfFc+Orea0EEMU5Is5rO+jqvAUERumdMCPpQpOh/nk6fAybTU9joseg
 byeyU3Y4uFGj8/3ODwEZ3ykeRpkY6WOoqcub8RE+NDT+L3nGx8+ObREdqsIsKjhHSIchFaD1GhK
 LzS4nqtYGUXLObKq7VA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af2a3aa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3K0hjHndsinMD8gLsdoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oXaVqosHT9ySBVczhgMjzlmfw0DUM23D
X-Proofpoint-GUID: oXaVqosHT9ySBVczhgMjzlmfw0DUM23D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The VC Payload Fill (VCPF) sequence is inserted by the DP controller
when stream symbols are absent, typically before a stream is disabled.
Add support for triggering the VCPF sequence in the MSM DP controller.

VCPF completion events for streams 2 and 3 are reported in STATUS7,
while streams 0 and 1 use STATUS5.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 86 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     | 12 ++++++
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 249c818fe79c5..8a2396aec6d5e 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -65,6 +65,16 @@
 	(PSR_UPDATE_MASK | PSR_CAPTURE_MASK | PSR_EXIT_MASK | \
 	PSR_UPDATE_ERROR_MASK | PSR_WAKE_ERROR_MASK)
 
+#define DP_INTERRUPT_STATUS5 \
+	(DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT)
+#define DP_INTERRUPT_STATUS5_MASK \
+	(DP_INTERRUPT_STATUS5 << DP_INTERRUPT_STATUS_MASK_SHIFT)
+
+#define DP_INTERRUPT_STATUS7 \
+	(DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)
+#define DP_INTERRUPT_STATUS7_MASK \
+	(DP_INTERRUPT_STATUS7 << DP_INTERRUPT_STATUS_MASK_SHIFT)
+
 #define DP_CTRL_INTR_READY_FOR_VIDEO     BIT(0)
 #define DP_CTRL_INTR_IDLE_PATTERN_SENT  BIT(3)
 
@@ -351,6 +361,12 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 			DP_INTERRUPT_STATUS1_MASK);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2,
 			DP_INTERRUPT_STATUS2_MASK);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			 DP_INTERRUPT_STATUS5_MASK);
+	if (ctrl->num_pixel_clks > DP_STREAM_2) {
+		msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7,
+				 DP_INTERRUPT_STATUS7_MASK);
+	}
 }
 
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -360,6 +376,9 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS, 0x00);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2, 0x00);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5, 0x00);
+	if (ctrl->num_pixel_clks > DP_STREAM_2)
+		msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7, 0x00);
 }
 
 static u32 msm_dp_ctrl_get_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
@@ -379,6 +398,34 @@ static void msm_dp_ctrl_config_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
 }
 
+static u32 msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(struct msm_dp_ctrl_private *ctrl)
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
+	return intr & DP_INTERRUPT_STATUS5;
+}
+
+static u32 msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 intr, intr_ack;
+
+	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS7);
+	intr &= ~DP_INTERRUPT_STATUS7_MASK;
+	intr_ack = (intr & DP_INTERRUPT_STATUS7)
+			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7,
+			 intr_ack | DP_INTERRUPT_STATUS7_MASK);
+
+	return intr & DP_INTERRUPT_STATUS7;
+}
+
 static void msm_dp_ctrl_psr_mainlink_enable(struct msm_dp_ctrl_private *ctrl)
 {
 	u32 val;
@@ -478,6 +525,35 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
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
+	if (!ctrl->mst_mode) {
+		msm_dp_ctrl_push_idle(msm_dp_ctrl);
+		return;
+	}
+
+	if (msm_dp_panel->stream_id == DP_STREAM_0)
+		state |= DP_STATE_CTRL_DP0_PUSH_VCPF;
+	else if (msm_dp_panel->stream_id == DP_STREAM_1)
+		state |= DP_STATE_CTRL_DP1_PUSH_VCPF;
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
+}
+
 static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 					    struct msm_dp_panel *msm_dp_panel)
 {
@@ -2810,6 +2886,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 		ret = IRQ_HANDLED;
 	}
 
+	isr = msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
+	if (ctrl->num_pixel_clks > DP_STREAM_2)
+		isr |= msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
+
+	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
+		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {
+		complete(&ctrl->idle_comp);
+		ret = IRQ_HANDLED;
+	}
+
 	/* DP aux isr */
 	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
 	if (isr)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 41a69447001cd..84ea37d8db2e3 100644
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
index 4862d0b42f290..f6d16c57afcc1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1524,7 +1524,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	if (!dp->power_on)
 		return;
 
-	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
 	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index cc74b1ed628ec..36cfd94ac1622 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -42,6 +42,9 @@
 #define DP_INTR_FRAME_END		BIT(6)
 #define DP_INTR_CRC_UPDATED		BIT(9)
 
+#define DP_INTR_MST_DP0_VCPF_SENT	BIT(0)
+#define DP_INTR_MST_DP1_VCPF_SENT	BIT(3)
+
 #define REG_DP_INTR_STATUS3			(0x00000028)
 
 #define REG_DP_INTR_STATUS4			(0x0000002C)
@@ -58,6 +61,12 @@
 #define PSR_UPDATE_ERROR_MASK			(0x00000008)
 #define PSR_WAKE_ERROR_MASK			(0x00000010)
 
+#define REG_DP_INTR_STATUS5			(0x00000034)
+
+#define REG_DP_INTR_STATUS7			(0x000000FC)
+#define DP_INTR_MST_DP2_VCPF_SENT	BIT(18)
+#define DP_INTR_MST_DP3_VCPF_SENT	BIT(21)
+
 #define REG_DP_DP_HPD_CTRL			(0x00000000)
 #define DP_DP_HPD_CTRL_HPD_EN			(0x00000001)
 
@@ -143,6 +152,8 @@
 #define DP_STATE_CTRL_LINK_TEST_CUSTOM_PATTERN	(0x00000040)
 #define DP_STATE_CTRL_SEND_VIDEO		(0x00000080)
 #define DP_STATE_CTRL_PUSH_IDLE			(0x00000100)
+#define DP_STATE_CTRL_DP0_PUSH_VCPF		BIT(12)
+#define DP_STATE_CTRL_DP1_PUSH_VCPF		BIT(14)
 
 #define REG_DP_CONFIGURATION_CTRL		(0x00000008)
 #define DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK	(0x00000001)
@@ -370,6 +381,7 @@
 
 /* Streams 2/3 registers, relative to mst2link_base / mst3link_base. */
 #define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
+#define DP_MSTLINK_PUSH_VCPF			BIT(12)
 #define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
 #define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
 #define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003c)

-- 
2.43.0

