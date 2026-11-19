Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1A606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQhDaIx3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SksGQ3SN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452B71120EA;
	Thu, 19 Nov 2026 08:25:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F061120EB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wGqk1534880
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZH8g5O7xKZ8B/5uGCTIRgFSOntIBxLOYrFe+k+/F1Kg=; b=PQhDaIx34f5igQzz
 fb/racrc4Kj1eUdohsR4x//9ypXftx+cPyuy3Q3O2Ov9rs1iERD7/+W+0kySR16n
 2NondoLpQq/n1PZIWt4GaM4Lqw5mBBzsxczIjIHjgVkQOavxFIBkNMogR4izdYfr
 AEd8uRsO7nYBZCMh7h+xigFdMIImxhh3bzm3sIKpBMnlKLjHvrT0/dBHqORwpjsp
 nfxxkpLZQ6q1ruDxlb4WSCfcPzCmqEjHyc8tvL6Hmt79lR/+1OeQ6tsBOkRkV78g
 I8je17vf0jl3LM/QsiIQo4hpVcACXj4a9wSv9JdSbjbLfmsTyzdP3tVPZIMHqp+f
 eVxa8w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcc5fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495dd0f07eso393090285a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076680; x=1795681480;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZH8g5O7xKZ8B/5uGCTIRgFSOntIBxLOYrFe+k+/F1Kg=;
 b=SksGQ3SN1dV2qJvndkVzijOSqfm2/YnBNqx1XxXWfL3R8lpGA6L5aYdD0ownlHN6hL
 zQcu5dpunT6zA9ruTcf7Runp6qGpmZMon5W+a4Mk3/LI2wpq1uY3Hwjt7MT++wAOoPRV
 no2UBvMsA1Mhq5Sybns3f3ZdtiQggtTizBj1CxDXtF92yocawlddBOtL71s4hBFOOaBm
 rNKLxF1cJUyE7A242zEVSsxCmX5eNwSeJ0PqQ7/5xn4NjrCw1v3NfcKnmeT6p6CUZqr9
 N6vskT2tn9TCwesPdmi/4o+KeWINSpz78A64XgsXRspOw5YpeyzyXYLRPmNKnslOZkQe
 8R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076680; x=1795681480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZH8g5O7xKZ8B/5uGCTIRgFSOntIBxLOYrFe+k+/F1Kg=;
 b=Yt5YlKFBazXhbURdgMGDCh9S/EO+IZWQWUqBFAWtl1XXM5GmjBsCXKL0zuveBeKowy
 Aff9bsrlV0HDPhFye+qb58IqE5xl8Ry7vISXR82CovpzalmNCL64bir8JtqbKcUIFS7D
 7VgOoJQ07Otf8WwMUrYHFBkVeeY9lN6Fg/eE4xhUiJ838A4IVklN/zwBOlN1fsaNPIsN
 GvXKrDj63ACkwgXuekKYs/hm/IyY9F0ckX95w0cDb4Fa2m1sP/sDHbvzhFSo2o/9uNM1
 AqxCcaxCjx5GeB4l4FJPwBq0JkrGDa6hO0TPuZTUrF0BshWDduIF1wjr5H5jc09F3c7M
 6Biw==
X-Forwarded-Encrypted: i=1;
 AL+hErFaa73Ve9CkKhPeGIxEV9deCmBUqAu5wWqR0d5hoWexT+xABURzHyIIdKiglQJUVwox5va5M4sYRnc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9129mr/1ZsDNVpm37/NOvJhEmHvG1KiJ0rsKJlJSPHrNczsFpJ
 oD5SMTZIQzEREV7JALw1/xy1Ie5ZPSElCv2U961wPZY/Flw/PcXfCTbmQOuX6vK3o2MBsrdStbT
 /AoB7Dguf+qcOZyiQpE0X0pIujITiNV9LaVsoE9xMEjLWLCWUf6iJvNOApRXEzGYXeHYVCdo=
X-Gm-Gg: AYBFou1x5ZSdUkcm6UaxIwuLNJoEYUJYiLDJmEl3zT13cJoBiGds4PoiWIut6LDz6+0
 8zkZpBqD4o1pj0Xv3APcpYo6J+4TO6yCjHG+yH08rFWneb4uwh8nrAJFzWM0U5C8znYLXW0Lbre
 Mby52NPd6qwJnhMQXJGyw8NAnJEHD2eTQHMQkejdibgBsGji4y2z9F8GAmMAHSK3xTHtSuiCgW3
 mtMyHO0HlIeDIURRua2MmvgMXHJblLIf6/3NnNah7MMmhT1gYUezGOvX4ATn58n8cBPT2dopBas
 ra2rZz2tKKTsYRwJ1uG+XVL6lEheMnfct9UxLaYbEbXlCC2mu2oHhymCl80M8RX5GHt5Jux0N2v
 rM+XbUG8/TkmFwi+bTGxVEfGIbgzYAYt0Ogfhvpu2jXCYxKQXH9h+snbHY7uvCCkrHVVUdAhy7v
 obPaSxot9vocMOb7u5YMZWfKwdn+jtkAYC6QRn
X-Received: by 2002:a05:620a:199b:b0:93e:bcbf:4ad with SMTP id
 af79cd13be357-949995b3038mr899388685a.33.1795076679646; 
 Thu, 19 Nov 2026 00:24:39 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:93e:bcbf:4ad with SMTP id
 af79cd13be357-949995b3038mr899386085a.33.1795076679178; 
 Thu, 19 Nov 2026 00:24:39 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:38 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:04 +0800
Subject: [PATCH v9 02/29] drm/msm/dp: add support to send ACT packets for MST
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-2-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=7052;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=54CLADPkO1fN9/Xb9//dtv4gcTRKYDDXr98jRbYT/UY=;
 b=dvdCGqSL4JZFf/15f9H0YK8YhldT1R8jO1ne+Jsnl2+I+Hog3BfOeIlGhMPwGL2MpakJsBqIy
 p8kWVSJm661DekOtyK/HTwPPDSDlkBpNN1BSceuyVLawoFOGHYd34B1
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afeb248 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=F2S7ry5v5sxRTjZyeP4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX/ahGBshHtBOb
 QAq4J4H1iT47g/YcVFrGm97tnpCnj+TcgJ7chs48zBwo9yyBd/A6Lj880zDJF5HVe6HkOHidcLd
 KmSKr/9r8q5v/pdBJBjrKv7reqDZXz03JGWxM7fD2igFfwIeCbvBSOc177K9wpevx9VMbI0gG6K
 dpgAS61W+Mq0mCiW9dsTeLikAs8X2b3kYXg0qREH8rpwCrD0VE8juw/JIQHekUUlepxVZdmx4kw
 pxGbiT4GNRZ1oQATTRHB+TmaO+h06MAj3/fcFGhn9NIIt5VDtTavDmL/yYzkG2EDd+QFjHBofkC
 l/pbd2OtQqCZ30TJKp4Ruk1Ip/2W5ifpdtq0mY6PITNPxmMjV+8Rcw9VFf1rYQI4Y35uvhYjrxz
 IpU6DYZAUp+e7fDWATIgNW1Te8A/0zIS11k96BmhGIqkeXE6b4GD3uY+laNYaSgNnZ5LKZEdJGw
 8D66WSCRAx/0XcTk39Q==
X-Proofpoint-ORIG-GUID: yrnAVhz4cwEdK9Zd80ZUd6toZjYRAosO
X-Proofpoint-GUID: yrnAVhz4cwEdK9Zd80ZUd6toZjYRAosO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0kOBB0AIC+k1
 DRgqBpr5vIS2LkgpxItT12wDy/0/pWZFk3XBEH1U3pey2+LgzfuEPjX2hkvnve4mQnP9WnnPjSi
 JHh5nXTCr8pGAi/VSl3bvdr0/abOrc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
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
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 50 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++-
 drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
 5 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 32d4d5743eb36..1b4aaaca0ad99 100644
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
@@ -2666,15 +2701,23 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
+	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
+	if (ret)
+		goto err_pclk;
+
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 	if (ret)
-		return ret;
+		goto err_pclk;
 
 	mainlink_ready = msm_dp_ctrl_mainlink_ready(ctrl);
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
 	return ret;
+
+err_pclk:
+	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl, panel->stream_id);
+	return ret;
 }
 
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2703,6 +2746,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
+	ctrl->mst_mode = false;
+
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
@@ -2882,6 +2927,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
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

