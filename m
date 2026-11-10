Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098260A3808
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EUAPswNr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dv5k1BOG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F9B10EDB9;
	Tue, 10 Nov 2026 04:55:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A780010EDAB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA49tYu1767213
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4znigap+a+C2TrdqAIG1LBvzWkm9M9ecXvpeFOsy1KQ=; b=EUAPswNrY/FqCzhk
 opTIYtUWnW/pSG4BsgZrfINQHYfFU3oVJa/6vAAJKnRJcJm9p+kA2RIzFiYUbIH0
 xgCP7uHbnVRDWZfI+9hUKGYz2E7ijUTVE2AI8l6JpJMcPXLr0gHyaVVfzFON3Mp3
 toNyCmEyMSnsyGGrEDXI5J9eO8EtLJmDYffr67KVfT9AQzDHQeWFNIW68d+V5sbB
 y9E/DmOV68EUgJWiElNWTzwFx1rNZcgWBznGOGmLTkSBhPScYk+KHztwopLFfALL
 cEgA/JebMAyOANS7tCxBk7Kql9QS1Mdy8RolZ+EQNdSZsJILt8nPd2MJF5FzXqYf
 Hz0vlA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp093r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-944138ed63fso284559385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286530; x=1794891330;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4znigap+a+C2TrdqAIG1LBvzWkm9M9ecXvpeFOsy1KQ=;
 b=dv5k1BOGKshH2hcuKnzdbdu/fLdSlsmt443qh85o/8lbAgXi121IFeUG86hT8KQHMY
 qBUIsrbE2bIBLO0lXzc7RDobinJ4UBCpTxQu6pkgJrunU5loclgye8niqKbDRVOCQR6u
 4ToZguUZWb2yT8cMYd5AMEP9cS0U/mpuysqQUI0K2ySSORmoy2RoKJNUDkouFo+UTRRd
 ujyFgar5TTV5YCIEqg8XO+s5Ny4coii/O73CIwjJ2411oLWfeWWf7aLqSOZrIV8aE3IQ
 7HWpc3C55QcWmQLPsU+REyMgDpvl8f3pAOcnkLGp3zZR8WQy5AID/bQiN9s8HiPyEbkU
 J6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286530; x=1794891330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4znigap+a+C2TrdqAIG1LBvzWkm9M9ecXvpeFOsy1KQ=;
 b=An31afxyyAB9ZIK3rF7QnwupC0QiWaml5aCrWxpcmU3t+mz/L+/zkIHbA9y9karDGF
 fQPhmj/c4QOS77nG+gPBwNCSn6rpjHj4E+v724Akc3Yb7waMBw1rFhp3FY2sKgmvTEtH
 vwWYAeRCCWc5Fea6bzlH/mxqnRsz5G8XIXxlq4Ekp/5xnc02JQo80zEGa7uDTXatw7Nw
 1VwEPjuu1zHPjgWWj+HCKhp0S58Btc7ntc6doN+uHhpepRF+u6R/Xy5jMg10P0WdVmGh
 eaxqUiTKVAxGMz3qQo334l+sMaOKvYSN6lk2vNMpD3JKEXWRB2XSU5Uj5JXRfnLtnGjR
 24Yw==
X-Forwarded-Encrypted: i=1;
 AL+hErGWjfrmf3x3oyurutdkmdjc/f7DixIh5ffYmXPNC+qquqJc7zLP7Oy/ltP9mysVHhGVsYwRhOQsJjQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Z25X/OjGzLp2YHL6zY6+MXLuVbtIoyeOQ+dW5ys061wCIRqT8
 tZFEiQwvK63vAjczup2Kl2E2ItklsZ2L5UcfTai+5PUeZ/z4yyQliJ9bGqslMYqOe2LhlkB+y9+
 l+bVYoedd7xfrNiUBXg61MjLltiiD2b8/G9grycSEpxExDeXzb2V23YDXklSzdfvMV2z9FM2cEx
 NLSnV3Dw==
X-Gm-Gg: AYBFou0I6rO2B0YuT03oFd9nL8Bnxij7DofeIoLQjbYtiw2yEuU00Psi4Wd0EMs8TOh
 ZyG8iz87lC1riYxpNHMRtKriFRMAPQflboqDVUIc5RXJwZtNZ7bbSlLD3qw9h77zYdwrPeLIixH
 om3YPCwsQ24OdrSg15R0gSq6NVh17bMUj1toxYIi1yVwJbp+/IW/rycapN1EAfPdZy5sa11Vr61
 dQAogfxQ6KGVT3EAPp4qVZQ3mB1WmSvLLMLrS9Wxg46cp7W7srJPvWlukobC4hqJ++S6By4I3Wm
 Eg6njTAn52n0xwFo+/wB3IJF/kCUd0nhvYuB7jOaIQ//5icUd+KkaB/yw9t7CK22EHQuRlQtaTu
 qMWkf4fEgXit/lsqCS/vAEVW4GSnBvc+ASdHT1qkIEIxnJWEyJ4+6nXGQ8YcSMUbCg7qBDdXpGw
 6Pqb90cOYVQpL0XLet95CHI3+azLDBUteSWI49
X-Received: by 2002:a05:620a:4043:b0:93e:96e0:25b8 with SMTP id
 af79cd13be357-9479f331a08mr288347985a.42.1794286530034; 
 Mon, 09 Nov 2026 20:55:30 -0800 (PST)
X-Received: by 2002:a05:620a:4043:b0:93e:96e0:25b8 with SMTP id
 af79cd13be357-9479f331a08mr288346385a.42.1794286529569; 
 Mon, 09 Nov 2026 20:55:29 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:29 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:32 +0800
Subject: [PATCH v8 11/29] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-11-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=3825;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=WcSG5FkGjNalbzWcrp4rU22MtewjiNFIQT7LAviddgU=;
 b=CQW0ge4y7W+gi7bpjyGppXezH87gJkcqHHx9M0FOpkHwRrL7RGlbZ5+5TymeIRA+CGgKKE2wH
 soK+ryFdyTzBw0MHMtuFHfi4UxxrBB50vAGEgbUxdLTzHBSqGlKdkqZ
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: wbNspClNXTIWdJOvOVb0tzl9sMnbrh5c
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af2a3c3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kCKOgzAXqFYlHSlaV6AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX6nEZ2hC+d+jI
 lqO+KPfxSl2l4t6ekIihSJJ/sAkN58ybZo2/91rqeWY7X3/77R5a7VAeZEp+rQDbUqZZBQ8tLnQ
 hiMNmfcusTahy4Knsc1z+d8WoZWFlgBjWZ/UKq/WQCJrvfhOVGNYTGP2038617HgXVR3MgfYOYp
 njRmaimtpXi8nabRPAgO4WcGWEbTcezvdfNhR6J/Y2l6P8T5RiTou0xrnO9sOQ4gxuh+sbi0PQd
 lLZBWhbk6FrrxB7HiiIIljMLZqsyNk9JG4m07GMS3XKkEyKLzMRIBG7B+LPR+cNYp4PhG3UfcxG
 y342siH3XgfCb85vPTtJuSYtxVF9+joP07ARV8IsJmnQj4b32iFPcVkeZ34FzEgJCFaWe6kUmef
 YAKUEGmkH3s2G2YtRNZXQXjdJ5JbH8ziBoXbJ9q+2hcmalrbnCCbAvTTn1BMvQuyP9U3D+KOKb0
 FF7Wat5it0eC60O+8bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX08/+zok1iW6Z
 SgK85e3N9VZ0qwDGsBKl3yvpMzDesal2jlKJ5gF72m3L3F2tE+1YbQvAuGgEVvNo+bGcYSKEwHf
 2n4Hq/1CRMW5Y/X5JGLHdtyDY912pT0=
X-Proofpoint-GUID: wbNspClNXTIWdJOvOVb0tzl9sMnbrh5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

Add an API msm_dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 +++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 0b34db3bd5d2..06c370c5ea09 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3126,6 +3126,15 @@ bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ctrl->stream_clks_on[stream_id];
 }
 
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	return ctrl->num_pixel_clks;
+}
+
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
 			struct drm_dp_aux *aux,
 			struct phy *phy,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 9478f127c6d3..8db5f714519d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -61,6 +61,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
 int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 			     struct msm_dp_panel *panel);
 void msm_dp_ctrl_mst_timeslot_setup(struct msm_dp_ctrl *msm_dp_ctrl,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6a522cc71a2a..fa027659a079 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -536,6 +536,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	return rc;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	if (stream_id >= msm_dp_ctrl_get_stream_cnt(dp->ctrl)) {
+		DRM_ERROR("invalid stream_id %d\n", stream_id);
+		return NULL;
+	}
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
+				    dp->pixel_base[stream_id]);
+
+	if (IS_ERR(dp_panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	dp_panel->stream_id = stream_id;
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index b0b7570cb16c..96be45c3dc92 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -59,4 +59,6 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

