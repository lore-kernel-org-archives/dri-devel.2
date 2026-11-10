Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282A60A2617
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dtIYRTYw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NbNkuJ0o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249A310ED8C;
	Tue, 10 Nov 2026 04:54:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D4010ED8C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:47 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA49t8j1330048
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ruRaxGvMFDm0H+4zN7LbQ+8uAneeL+NMjMtpoe2WjRA=; b=dtIYRTYwvB5AOxv7
 7iS7rH2YgC05wtTgsmwTO3ijCVMxTaW6wxYn4GA0btiRveBTTmnlX8sXL14NCGoK
 TNhH2PYgzTEAwJZl4clRxF8Jm0yVAlf80OYE+dHNQ3SGralzcPY7Nl78NhgyL5pX
 I03e7xhEuw2XNndu24JL9AUWFyq2XjTdLAB2kY56Hlkit4egxBNPvP45VgEOhhWc
 8gU6B4hytK2AtSFmMR9HvbZOnwtgAij70xwAEsb3QJ/gO8/VO96EijwQg2daNrHc
 EtWjUB347YnYh5Gx1b0+/Xsl52xDmXWT98rICHgrfVIUWXChkDaiakbNYD43QLOD
 T3c35w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjbfx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so324488985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286486; x=1794891286;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ruRaxGvMFDm0H+4zN7LbQ+8uAneeL+NMjMtpoe2WjRA=;
 b=NbNkuJ0oPMgFx8XfUGmK2fgcVce0h+H/5w/3m3xQH1WclkSLioY7lLLKHyGfHFaCc+
 9htVGD8fwjIJuRKcuOExMd5GjaadF8XquDE0O3gCuN+lnfXBLpJKomD8OhSgbcpntDoW
 0YO+cCI4wJXVzhyw1QM7OFWP180JhX1+PkXYveSvZHe8iztAC2n3L/8w96D/wOVdfdvC
 KvQUnuIWiPEXJ7eOyu0TP2DKF+a1RyTv2nFCtqZbBnqiltuyr3u3Qzrrshz/gTUPCU4O
 kZ6zIntaeZ7L6qom3IkB8crAr6aIsSGRJnusvBY/0jCRO/n6Tg1Vc3x2GE/iFsLFqoSW
 oRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286486; x=1794891286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ruRaxGvMFDm0H+4zN7LbQ+8uAneeL+NMjMtpoe2WjRA=;
 b=YUt4vXMhYhNuPHohPPRb9JDrsy/lkCrKuyWFuJTDzHVviOiggDAaFbLcqz7/sVqXFG
 KzPEMnhInM4LJvjBmsE8cEyBKqg5ANO8rQtgQkto+ouuapOq3yfVqGEyrqWpcHaLyP9R
 Nbawf+iynXgjh9Sfc7IA4HyWcgSINT4LWmLvXAi+EtKMfNTa19PP4s0V8FbV/+bNewLW
 d1VywBOkaEn0Mw+lZX4H2r1bfsJqdR9kSceb5MTiWvkoetSMHRnsYlLJHoSyRWkleC7f
 E73iTTHwURuofJDfV8JF6KxWa0DpXMmnRLsLndN3fjbL2H+gWn8xoRRFNYoXrIju/Q9E
 ltPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFl71ZxeyvPf+BLo+B9XtfBXAn0pUpR4NH67z9qz5Djlzj+DLVc/1iw6Mj/ktERJPyiDPenWnS3aUk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9NdJcxb0smlWDng8bgPdA+/eL5Dpsud2/8iiYIuh70CsNJ13OE
 /NvsXRF8amLncuQpER8mou3c/eAjnH6QW1xFrk1XjrtbFs/FrVGxt0HGkiT/wXOQjCG5myfk5YH
 PjJztHBRrgApzc+U0Iv8tM12gan/imYCjNV24AXfv58MXNGSf0LGV7t21qty5qwuz2xNI7HA=
X-Gm-Gg: AYBFou3xWrooz1CqRaNjomWZmHEsgAuGNEXyIJMlqIDwIcQIRyaMnppEex6nBHmu1Ku
 ZvnwrKCTX/TuisogV97mrPYDbg4+BRt4h3rWy231TqaOGttjlKk3+xq+yfPgo+0GwgS8/8FwOcB
 O7huAlEJmACYrQ9KiBMMMyvwpAHJPTkc52i1wcMaYXS8wQRxPa29+wFdC07mPtslqvgEzeR3dWo
 ZNY9jXPDuEWeJcJsypmUL7NtUA1OISRQohOccJ1YgfSk1Qg7BL8kUvET1+GvsjkQ9dmJpzD9OgL
 JzP26pUJ2OzHQh5pMCemlYM5lkkSxwoWk/0Ua7kCoewgchmCJLRfE/BTKvKN3pUlWpg7v/jiM8+
 tR4vhAUrD3D8CzqmN2htfSAXO39rdmuEYzJryWuasBLCdElGhBwqzPhb6u4rTFI7RTfz/k+y6Cd
 iRKSHJsCi9te+qAC6WrhmiYWGvvCXQg57PZF6V
X-Received: by 2002:a05:620a:2849:b0:945:d6e9:9a8c with SMTP id
 af79cd13be357-9479f4e8106mr238498185a.33.1794286486249; 
 Mon, 09 Nov 2026 20:54:46 -0800 (PST)
X-Received: by 2002:a05:620a:2849:b0:945:d6e9:9a8c with SMTP id
 af79cd13be357-9479f4e8106mr238496585a.33.1794286485799; 
 Mon, 09 Nov 2026 20:54:45 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:54:45 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:23 +0800
Subject: [PATCH v8 02/29] drm/msm/dp: add support to send ACT packets for MST
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-2-d040fb33db5f@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=6703;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=XbLxRh0PZCM5SnxffQCQRKdW1ToMllyUCgQoYUJ0gkk=;
 b=MysI4TYuPMoAJUTAqOzj7J5u9cTkA/HYGlTIdMO3ftynMPESUFuSWwx4aKXWNJ+73NO1zGOlz
 FHTINv/QqbsAdSOn1mxc59s5bBqtRYVX5CRw2KECcDPucHMkqsACeyO
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: R8Fw2ut_hnDjU0_QtB_njV0tr0h9qTxG
X-Proofpoint-ORIG-GUID: R8Fw2ut_hnDjU0_QtB_njV0tr0h9qTxG
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af2a397 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=F2S7ry5v5sxRTjZyeP4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX6LqCT1UoDCtc
 trTsosS0Zu4rlZgevbxVt3sJa28/cW541veyhPP12Qo2FYeU+2n5znV7za+XTwuu5vrGAq7R67C
 Ztx0Vd7ZHJ7xFJFsXk5NsNMG6cXaKa8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4mLm3/OOg+By
 uXtddRtyXLIFPr7WNS7OJxLCxFJ9aIV5s46iewek7+2Pjzw5CVmisKbnvBtyle6h4yGbNtMjw2+
 BFp5SSspy5fyvQtXSjGg5DdBe/XT2fUqU/EJzQ0Pt7DPZzetJvvMuAUbe0/6J3WXUtN9sqNa+bH
 CeATELWuh64siiTw+mpgYi5rZiYwCh6A6i5pk2T0EizWgdZaQzUoMRA7uavh4IOe5vpPQ3bJdbP
 ANEXkUrh53uiLdk4ALs7r1uF9q4VS1wLGf/tbJ2BC8hemlRlst2/3ss/TU5J3oo1RTb0IMKCoKc
 m1HknCevI/r2z+pqr7AacTLuQMWbGLQYfP5awFmFrs1go6BdNHJISHswKAChRzvBFKOY9N5Czoc
 gYuHuD/z6Q00eLd4nnLUeRtWcpDjOKeOlNLpIesA4twFVB2CbP5z9yxeG3E2iyRDIz1FBQvjeLL
 aWU+vLERKSjVfCTXtGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
index 32d4d5743eb36..288f84c33275f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
 	bool core_clks_on;
 	bool link_clks_on;
 	bool stream_clks_on[DP_STREAM_MAX];
+	bool mst_mode;
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
+	if (!ctrl->mst_mode)
+		return 0;
+
+	mode = &panel->msm_dp_mode.drm_mode;
+	frame_time_ms = DIV_ROUND_UP_ULL((u64)mode->htotal * mode->vtotal,
+					 mode->clock) + 1;
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
@@ -2623,7 +2655,8 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel,
+			  bool mst_active)
 {
 	int ret = 0;
 	bool mainlink_ready = false;
@@ -2635,6 +2668,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	ctrl->mst_mode = mst_active;
+
 	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 
 	if (msm_dp_ctrl->wide_bus_en || panel->msm_dp_mode.out_fmt_is_yuv_420)
@@ -2666,6 +2701,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
+	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
+	if (ret)
+		return ret;
+
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 	if (ret)
 		return ret;
@@ -2703,6 +2742,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
+	ctrl->mst_mode = false;
+
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
@@ -2882,6 +2923,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->link_base = link_base;
 	ctrl->mst2link_base = mst2link_base;
 	ctrl->mst3link_base = mst3link_base;
+	ctrl->mst_mode = false;
 
 	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 80d9258501b49..41a69447001cd 100644
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
index ed899fcc91891..4862d0b42f290 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -679,7 +679,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -1525,6 +1525,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 		return;
 
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
 
 static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 83117e7619f31..472429d092009 100644
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
index 265da58e064cc..9263e61c794c8 100644
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

