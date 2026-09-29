Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F0AC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60EF10EC9A;
	Tue, 29 Sep 2026 04:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ewv7jiZS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JAh2qasg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6825110EC97
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:08 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T4759B3390850
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f7PIozI1KYXukehfMITcmRTUTQDLUTgogibtC6enQ78=; b=ewv7jiZShJ4BP58w
 C8gVLfP5Kb/BVY6NyHOla0G8/ym9+H7ckMK3fF12USJpeR8ufIUYH4939RDGWFqa
 6bEPFWmC4jtxInbQOpI2tVxn/WZqu8kigjLvWLAD6NyUmbKJqA/UO+XhJFC0lfUV
 FYKpuXIe+tvlImnG38Ypuk02NksVv+ewWUa93uHDQy7NDDQt3kHrDZhmGM7YNI5D
 GGwXlGEM9e5FivZtYfbAqbVIJ+SsmHAiO9PHEixTH8SKRbSSN9frNl8Dr9BBDsEj
 xzpkjOWBNo+fAiGLgaS7ce8VMsKwLHKKmqnp4Vg/IxtIWwtjjwcXUmSuUoV9ZlC1
 sAoPYA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkgvcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5e9c2ec1so93780585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656027; x=1791260827;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f7PIozI1KYXukehfMITcmRTUTQDLUTgogibtC6enQ78=;
 b=JAh2qasg6WeBDkq/fash6MfITRK5+QhwJQDCo/iuve3EFy5fBJunQ/3ukFdWGXvvsu
 lCx/YZ6rqMopS8ArpwnXzTod88kzbJkmKg891jpAhsawQtePpDJSRO6EBgSEuIXIVpSx
 CMArYlT4cewcECmINvjp26CBKQP8xTPuNywCSoTE8JEhS3eoOH8BGD69OtSmXyMPJD/W
 F05MKvAGVv0WW00xDWwOOm/akRf7+hRrv7tZEeuHpzpW7I8qgp3CrEQl4fAWL4bK543p
 rQuv2zCRjFBkvr9/WttjX7EuvQ6Ez1oHtbjKduJt5CHf12K5EwHxZoI5/Ox9KXs54fr0
 tW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656027; x=1791260827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f7PIozI1KYXukehfMITcmRTUTQDLUTgogibtC6enQ78=;
 b=exrapN202CkJhzyCv1S9hZFRMuf/v4qs0OWyecnckscz5D3Xw3TxUU6flbGZKGNK2E
 EXk/pG9PK27UAeiZmLE5rF6wKCTyEbiNILVRCdAd1WANeIoQ1Xcq+HpHyZWhnR90cMnn
 R7k2j3liiMkbXO3o8+57f4AFb1TGl9PFHuf3QgLLkYJxTJ5NjycaP7zr71oZ4oQhJ1j2
 qJL/eGe8Qj6zDoAWjmtrl+QiOWkwYC8gqaqzyFT5rOsX7VbIL6vAZyfdehzgnfBCFy0d
 B648IrPCbr7PgeX9rbo/P/1uqHUiXQ++jf5iUZ+pJN7SMUoMXFilD6atRC2qQgaH3/QI
 cDOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByVd8IBF6NXtpx8ZWKt0PYy+1askQJEq+cM2qMxQwbCwGLrVzpatGvrNLFXJstA418Z1ZyTP/KD6bI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5yjz/w8YGAZG6gNTmL3moelVTWGMOTsdGeKYAhuUM2/olSJBG
 9OhFvL4fk8AMvSSFkEX1ImOlEio8I/v3cD7OYMwehPtHX/7Dx3twqECLHNqib6tRPUl4X+ExrfJ
 IlVltXsBe7CLPIoVl9r0aG1io+3axNO8YsyQEKDBb2ThUrkjD52VHwdN8xWe0X8gpW75EVQg=
X-Gm-Gg: AYBFou2yVEJvnxZuUF+hNlikT6bPs3GpVphbX5Vf3gIV3ocwZwQCfG2AgXuzQq2tWlP
 8auaRy7dTGxQ3174niZZDzViz5dC75djB5kKbOay4V1ThRSEcBHBeOj9qqTemp9YWRWBtusegU5
 JLhsWllkBt1NJoUbRdSd41IfvXKPb0Gs12V9zDxu224lLPWq42rTPF7QQiDGltHfBUxTiD+4NIC
 iQZBP3HRv/Ox093VrxLorN/c7s76AHgqYoOrScV8rpSXGlLbcfb2SJDTUZUn60JmZ8tUE/L0jIK
 bBKOvpkbzfCGIvMxHQqPx6N5ao1UOvxPEk+OXPt63ghkvNDE3LtE1/DG2nCbVhWwalu1lb2C/A0
 0aIjHRKgZvqFmH8y3nTWPdrS2nz9n+6fAS5NnLLt2Kx3XQOSSLRh4pVRUeUaWaJs=
X-Received: by 2002:a05:620a:1988:b0:93c:664e:e205 with SMTP id
 af79cd13be357-93c8be72680mr271828385a.11.1790656026515; 
 Mon, 28 Sep 2026 21:27:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1988:b0:93c:664e:e205 with SMTP id
 af79cd13be357-93c8be72680mr271824385a.11.1790656025635; 
 Mon, 28 Sep 2026 21:27:05 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:05 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:32 +0800
Subject: [PATCH v7 08/35] drm/msm/dp: add support to send ACT packets for MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=6702;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=umzYwO+E3zHLMdJeG0T1ILIuY+ntgI4C0yeSt+qisDM=;
 b=h3KjKmUtxY5quAa3E+ojMX45U6BxcQeGuWBsPvBUB/uoGGRR/te1BtiDB+sRMol/CmF1xVxqu
 0uDHA6A0PhyB4C6NRWPAfVXzVY9uSNo9Y1Rx3DoXwazZJpl0nDBXFa+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX7QNTu5pwlArV
 ldD2vvVl8u90q3+XHwRlhiCfYCYR+94oxJPiigWYpnb0QFC4ygqqPRRyw8T2yghuadDFUsUHXHm
 oqDQEIBw9OH3i3Fv9oPci78tct9s/Aojtwd41BH15twKkb6XxdWZWq/5QKOtCDoPTBl4i8xmNcp
 lG3L+zz42ZRWnlj8qpW9nOUgFYDA2+RhHX8akH+6nN9A//lYkvih/arTZlvHi1lojSTgB8KwHmr
 tBpyle0t/MKoqTpD3jDEc585BNzqiozISfX760wPMSRKqKMelRzF09P/YocWEgeTeGArmbns9l0
 yTdnt1VtfRAIkcxpceDY12GzOcrOUdZZQ9UkOLfG3+cIGQcuzYkPDOYuLWr9J+MyR4AuUYceaKx
 nuBmjcJhtZq1SUZMDngaLG5QrcNe82brrghT6JdfmVGJmY4mnr2Yo9ckbCF6MtOX76t92goRg9D
 YqnWUDiFXelO5Kusx/Q==
X-Proofpoint-GUID: ZzZTYJObUgAjRHPupCY7L18cndqw3rS-
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abb3e1b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=F2S7ry5v5sxRTjZyeP4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZzZTYJObUgAjRHPupCY7L18cndqw3rS-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXwvAfA2xkkTx1
 qjKOJ3Sda7L8jbKMZYf4n1xqxcEcb9R79o2DeeTaQI+jcBGf+5BRLEpp2tLW3aZ4SMjRsIn6bXV
 vvNAB0EVvtGdfep5T1Sa7nfqsVB4hLI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
 drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
 5 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index e1614bc49a7c..65d22505c2b6 100644
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
@@ -2614,7 +2646,8 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel,
+			  bool mst_active)
 {
 	int ret = 0;
 	bool mainlink_ready = false;
@@ -2626,6 +2659,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	ctrl->mst_active = mst_active;
+
 	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 
 	if (msm_dp_ctrl->wide_bus_en || panel->msm_dp_mode.out_fmt_is_yuv_420)
@@ -2657,6 +2692,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
+	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
+	if (ret)
+		return ret;
+
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 	if (ret)
 		return ret;
@@ -2694,6 +2733,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
+	ctrl->mst_active = false;
+
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
@@ -2873,6 +2914,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->link_base = link_base;
 	ctrl->mst2link_base = mst2link_base;
 	ctrl->mst3link_base = mst3link_base;
+	ctrl->mst_active = false;
 
 	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 80d9258501b4..41a69447001c 100644
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
@@ -59,4 +60,6 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
+int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
+			     struct msm_dp_panel *panel);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bb5e35e11b4d..85517099543e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -672,7 +672,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -1518,6 +1518,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 		return;
 
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
 
 static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 83117e7619f3..472429d09200 100644
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
index 265da58e064c..9263e61c794c 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -330,6 +330,7 @@
 #define MMSS_DP1_SDP_CFG3			(0x000004e8)
 #define REG_DP_DP0_RG				(0x000004f8)
 #define REG_DP_DP1_RG				(0x000004fc)
+#define REG_DP_MST_ACT				(0x00000500)
 
 #define MMSS_DP_BIST_ENABLE			(0x00000000)
 #define DP_BIST_ENABLE_DPBIST_EN		(0x00000001)

-- 
2.43.0

