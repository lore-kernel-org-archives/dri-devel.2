Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC5C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D4A10F271;
	Thu,  2 Jul 2026 09:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/mDQ7xe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJlaBvWo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AD510F271
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:56 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628n3W33046377
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 09:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzssNrrhwsh4sqrlnwSb6YO2VDCtJexpyO/5tc+jank=; b=Q/mDQ7xelUqBQBIi
 pgU1MkWrAEY43QK8+SWGATyPNwy+PVWpi3A2ANEsVbSD4jOhh/EFJKeJvYjf/bhi
 e8Qr06vXoUIr9fWg+85Ke2/Mn9wzHTWTjoPcZxA3RL3MwTaL4/2sn0GH6UszU0oF
 Dms552YGpABdJPmYxVUEjv4tgdQhn5KDiC/h1DvgbTspHoIOWeT2vXsaO/f1dynN
 0d0+7TWcfA74x2fkIwsC/Iy61MVIIV9w/apFkErufgV33ZfSVJpjTy0aw37xcrcz
 /VfSRmd6PHXQWHblOY23S0Nitd/ibZygEFycb2ztgDNqM59NGHogaAO+YdMpR5L0
 YB3uZg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f58k3aupf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:36:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e606e8f3eso149707285a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782985015; x=1783589815;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qzssNrrhwsh4sqrlnwSb6YO2VDCtJexpyO/5tc+jank=;
 b=jJlaBvWo+cvQURxp/+Kal2NaBhf3o8VjEZ/SlXHeBfbQqzL8uSokDiRdtY1zGe/hU4
 5XQZwo5+A9JzVh9r2/3MxZ5b8EmgPRBJ7iQSoJFYm3os6GvSEKq74P6qFODVHoMyZ8Ec
 s2SyC0xWtE62awwHGKMrEB8tPoW1WkTLfjQL+O7LYw1lzq5K9DjrranYL4H2ET9L5weG
 rlu2f5vIJSGHFBeNXdscHfycQCzVE7If/Cg5liEBR84j7UI1ksn0rVSC3heoFDgrfEMA
 FQlD2UXQUIFRGJcJEKMeQ6iF0/kHMMGT/MyaHheqSRgvnY8ksLJ8c4MCAx5S4tfg9GUx
 dm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985015; x=1783589815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qzssNrrhwsh4sqrlnwSb6YO2VDCtJexpyO/5tc+jank=;
 b=BMfwjHuI5daZBbuwlXizTx1q7QYPvu73OYcDaNAHOYSVf/DvbOyXTF06Yy8UNH155h
 PnDO27pjfel/OdMP3AiI+y+AeeARgA8vsVvbDIPRzqsFd/oKkUNsOmZ8qlZXEDD3/bOD
 vP0/5r5WIH0QsBvBHx9iQVQGwZV1tRO1xlOuf+UbTYgqhZ4bT1IqnwjG1GztzieCLVDR
 OTfYDqul9UKFn18Uct+wQKDz/NNoxCQ27aWGwLee1SpL+Ue0TSDn8LgJ+qHdnKhAGSDS
 1emTrSG5ms/Lw6qltVBck3x/8oomZzBijlnONRLf5vfZr3p5SvfV+zh0JnCjc+dqy1K3
 rzHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jqVayZEC3pU8MF74g48RHRa7gHNe426SRjHkN1PhZWnZOx/i8oohz1J/cJ5LZPQwkUy7sLUQKO3Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLuMNDZ8fdGROIB0yfvtv7Nyv3sAcfc3Nz0G6TkuZteZ2uQwIR
 0CYcdhqqJqA8AHFKhNBVLkvjDKhT0dq5H4fhUEI3HH6O3hkSS0+1jYydm+pVwQMdPc/Mqp6GgZx
 QuFww/j/ned2xfwmazI9+rDk//yudP0eFlKuzAjIfo5Xmvqfdf/sGZM6VHPn4b+h2zL6qjSI=
X-Gm-Gg: AfdE7cks21t87Rcin+JPjVd87SvRg2o8l/IPIjOOnmTaeU3RkLWyIxw6VEf9ocONGoF
 iGVIb+sJdNu/r55cyWT3xLU5O5sbkvgV7XfJ/C3BwumyprAMiPpytmVhUJCInv06BRpdMHH5R6s
 5fGwp36Ts27gDhl7K3RXW0jNKb3ylRlMDQIDQG8sWqgsxWfRuJx1VFwKZ2me77cV4vkkwZNbKg8
 hexXvW6DrYzmTKm73F6Djpl+KrZV6C47QQ5rxlQaT/U0VBgZ5ITa//bB8vR3V8N6IFg3jsPv7nv
 kJblDfx6OU2j18v3R6C4YJdGnDxYQNlT9Bo52Wf/5l7Mp+YwWYC1LWstm9+JbqANUd77M4Og4PV
 Tx80k/4+L8eFbA9hSKP2HNSXbK9I3mdpPqwI=
X-Received: by 2002:a05:620a:2947:b0:92b:6805:91aa with SMTP id
 af79cd13be357-92e7851a911mr723527185a.66.1782985014712; 
 Thu, 02 Jul 2026 02:36:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2947:b0:92b:6805:91aa with SMTP id
 af79cd13be357-92e7851a911mr723522485a.66.1782985014066; 
 Thu, 02 Jul 2026 02:36:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3db964sm7101335f8f.8.2026.07.02.02.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:36:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:36:40 +0200
Subject: [PATCH v2 1/2] drm/msm/hdmi_bridge: Simplify register bit updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-drm-msm-hdmi-cleanup-v2-1-a4a4f0e8895b@oss.qualcomm.com>
References: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
In-Reply-To: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8199;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=0kUm6iZWqG5LNuIEW9ZY5XabEz3/uGXV5l9LMOHtqBU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqRjEvqg8NwMGHoCZ/+gBpwkyr3SceUxmA/vOq7
 DJm399oqveJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakYxLwAKCRDBN2bmhouD
 19LgD/93aR7dOpfuLnOeH0zp0JZOjdpjAIN0dUzgba07j3qfxLEum7tcivrOtw1wsreb2qQp9/s
 v4NP/EHsnf94y3fTBcL63hD1Te9mueY48vzoKbMUUxSLFZx8+fLGaJFq9hlOvFEIUsUbjyP0619
 XnacqiEwW3/GzHHe4+U4r7mhhXBI+M4jiQgDbaFWEy6WeCAB5qzn1j/c07QsnixWDunz4efGQDj
 5P/PQcv/cGo/CgojBYPFq0UzVcw00N4M+lpY1A3lHfTpiEciWuecIBPqyjD6TYSimUvEpjnc44S
 pXa5CJD1HBjmREagzxObJr0jc3WPsKPK1IO4IIWaByeRiCmZ4fm+3YGqTZx2oaZEDAjj3L1ZzSl
 kTA6aCwGF39ZcyigS6loMrqQ1gsMfLeJcMta9+yez2X/nI3jE9TMYYMfoPXRa8MBuKhcOvjm8y4
 8c2KbPrMLpvs0anV5joDwjyMEFPrrNs7mHirLOtrcLiAuqQDNOy3Smd3uclQFFvs/1tNDwEpieY
 U9gXSbxA2HLz+vOi15CwIpS4keeO34yq3Mx5zzpCNBrVYbpvrhXVrlwWzlK25CPI+BgsiEQur0E
 egSWRMOReNnM8ruSJDRXYs9qmroMVdorsF9nKIfj0kF9NfWMGdQDnmP8WjH4RS9XxJnECvmldNB
 /7qiPU1m0+zet+g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA5OCBTYWx0ZWRfX83iVtYmNjgDa
 wELaHqX8o1wTAmJi1veBjGVbSRqITQCM4NNPj1kxMf5WOisDmXtENE3ITEPz9QbLlytpqSaQop8
 k1tzs+GuHIWwrlsxrOxnN/YUOTJiTVced7Vyp+wy+qKquuT17lTBxx6hnzeooqABpHT/nUsaeER
 TwuOF4xY2mkuZUcruObSlRMkeG49m62mKk254n6bhVHWrl5iUETL/qXQ9+9GdVvWcwboA5BArEZ
 6os1tzOai4Mfmv+uY97wmL+/UD2WtDlK+/Pt1YikzuuI7oWpdjlPaHBOpHM69n7sIYD+m6yYfyN
 De2eFRvLrlpMPZdJRqDqBeYcRnTrzEV2p0nNeOqxJj3/LsRDwJs/xLDqCCG8QLKrA0X8Ev4SM/T
 zFT+VaT5MNP5P+ZZKvKQffGfh9RCh1NSjGFUzDAzUqc7o1LnIC9H/9KkD9UUp1OjHuFSb3MDYXQ
 DKCgXvmneOn2QvaYnBQ==
X-Authority-Analysis: v=2.4 cv=SuGgLvO0 c=1 sm=1 tr=0 ts=6a463137 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aOjUM9GFJvKfr9THBUUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA5OCBTYWx0ZWRfX3KYOipIg6F0w
 4ubV2SO02RtlvjRXGepUMsRWj9R6/1OXt2Wrj2WL88ms5qBK8oyHGPmEyx2/jSjnM9dHiNZJLKd
 yIeRX0nczmJYI/4rSN24bJlcnt89k0U=
X-Proofpoint-ORIG-GUID: aOne_97nUNRDtC0ytQllhhMmRkBgsaKX
X-Proofpoint-GUID: aOne_97nUNRDtC0ytQllhhMmRkBgsaKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020098
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

Simplify reister updates (read, apply mask, write) with a wrapper to
make code more obvious and avoid possible errors of reading and writing
to different registers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.h        | 19 +++++++
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 98 ++++++++++++++--------------------
 2 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 49433f7727c3..436d4f9fe346 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -112,6 +112,25 @@ static inline u32 hdmi_read(struct hdmi *hdmi, u32 reg)
 	return readl(hdmi->mmio + reg);
 }
 
+static inline void hdmi_clear_bits(struct hdmi *hdmi, u32 reg, u32 mask)
+{
+	u32 val;
+
+	val = hdmi_read(hdmi, reg);
+	val &= ~mask;
+	hdmi_write(hdmi, reg, val);
+}
+
+static inline void hdmi_update_bits(struct hdmi *hdmi, u32 reg, u32 mask, u32 data)
+{
+	u32 val;
+
+	val = hdmi_read(hdmi, reg);
+	val &= ~mask;
+	val |= data & mask;
+	hdmi_write(hdmi, reg, val);
+}
+
 static inline u32 hdmi_qfprom_read(struct hdmi *hdmi, u32 reg)
 {
 	return readl(hdmi->qfprom_mmio + reg);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index c4d5e0faf3b3..9773459250bd 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -58,16 +58,13 @@ static int msm_hdmi_bridge_clear_avi_infoframe(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
-	u32 val;
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
-	val &= ~(HDMI_INFOFRAME_CTRL0_AVI_SEND |
-		 HDMI_INFOFRAME_CTRL0_AVI_CONT);
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
+	hdmi_clear_bits(hdmi, REG_HDMI_INFOFRAME_CTRL0,
+			HDMI_INFOFRAME_CTRL0_AVI_SEND |
+			HDMI_INFOFRAME_CTRL0_AVI_CONT);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
-	val &= ~HDMI_INFOFRAME_CTRL1_AVI_INFO_LINE__MASK;
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
+	hdmi_clear_bits(hdmi, REG_HDMI_INFOFRAME_CTRL1,
+			HDMI_INFOFRAME_CTRL1_AVI_INFO_LINE__MASK);
 
 	return 0;
 }
@@ -76,18 +73,15 @@ static int msm_hdmi_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
-	u32 val;
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
-	val &= ~(HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
-		 HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
-		 HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |
-		 HDMI_INFOFRAME_CTRL0_AUDIO_INFO_UPDATE);
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
+	hdmi_clear_bits(hdmi, REG_HDMI_INFOFRAME_CTRL0,
+			HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
+			HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
+			HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |
+			HDMI_INFOFRAME_CTRL0_AUDIO_INFO_UPDATE);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
-	val &= ~HDMI_INFOFRAME_CTRL1_AUDIO_INFO_LINE__MASK;
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
+	hdmi_clear_bits(hdmi, REG_HDMI_INFOFRAME_CTRL1,
+			HDMI_INFOFRAME_CTRL1_AUDIO_INFO_LINE__MASK);
 
 	return 0;
 }
@@ -96,13 +90,11 @@ static int msm_hdmi_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
-	u32 val;
 
-	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
-	val &= ~(HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
-		 HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
-		 HDMI_GEN_PKT_CTRL_GENERIC1_LINE__MASK);
-	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+	hdmi_clear_bits(hdmi, REG_HDMI_GEN_PKT_CTRL,
+			HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
+			HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
+			HDMI_GEN_PKT_CTRL_GENERIC1_LINE__MASK);
 
 	return 0;
 }
@@ -111,14 +103,12 @@ static int msm_hdmi_bridge_clear_hdmi_infoframe(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
-	u32 val;
 
-	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
-	val &= ~(HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
-		 HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
-		 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
-		 HDMI_GEN_PKT_CTRL_GENERIC0_LINE__MASK);
-	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+	hdmi_clear_bits(hdmi, REG_HDMI_GEN_PKT_CTRL,
+			HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
+			HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
+			HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
+			HDMI_GEN_PKT_CTRL_GENERIC0_LINE__MASK);
 
 	return 0;
 }
@@ -129,7 +119,6 @@ static int msm_hdmi_bridge_write_avi_infoframe(struct drm_bridge *bridge,
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	u32 buf[4] = {};
-	u32 val;
 	int i;
 
 	if (len != HDMI_INFOFRAME_SIZE(AVI) || len - 3 > sizeof(buf)) {
@@ -153,15 +142,13 @@ static int msm_hdmi_bridge_write_avi_infoframe(struct drm_bridge *bridge,
 	for (i = 0; i < ARRAY_SIZE(buf); i++)
 		hdmi_write(hdmi, REG_HDMI_AVI_INFO(i), buf[i]);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
-	val |= HDMI_INFOFRAME_CTRL0_AVI_SEND |
-		HDMI_INFOFRAME_CTRL0_AVI_CONT;
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
+	hdmi_update_bits(hdmi, REG_HDMI_INFOFRAME_CTRL0,
+			 HDMI_INFOFRAME_CTRL0_AVI_SEND | HDMI_INFOFRAME_CTRL0_AVI_CONT,
+			 HDMI_INFOFRAME_CTRL0_AVI_SEND | HDMI_INFOFRAME_CTRL0_AVI_CONT);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
-	val &= ~HDMI_INFOFRAME_CTRL1_AVI_INFO_LINE__MASK;
-	val |= HDMI_INFOFRAME_CTRL1_AVI_INFO_LINE(AVI_IFRAME_LINE_NUMBER);
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
+	hdmi_update_bits(hdmi, REG_HDMI_INFOFRAME_CTRL1,
+			 HDMI_INFOFRAME_CTRL1_AVI_INFO_LINE__MASK,
+			 HDMI_INFOFRAME_CTRL1_AVI_INFO_LINE(AVI_IFRAME_LINE_NUMBER));
 
 	return 0;
 }
@@ -193,12 +180,11 @@ static int msm_hdmi_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 		   buffer[9] << 16 |
 		   buffer[10] << 24);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
-	val |= HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
-		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
-		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |
-		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_UPDATE;
-	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
+	val = HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
+	      HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
+	      HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |
+	      HDMI_INFOFRAME_CTRL0_AUDIO_INFO_UPDATE;
+	hdmi_update_bits(hdmi, REG_HDMI_INFOFRAME_CTRL0, val, val);
 
 	return 0;
 }
@@ -231,11 +217,10 @@ static int msm_hdmi_bridge_write_spd_infoframe(struct drm_bridge *bridge,
 	for (i = 0; i < ARRAY_SIZE(buf); i++)
 		hdmi_write(hdmi, REG_HDMI_GENERIC1(i), buf[i]);
 
-	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
-	val |= HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
-		 HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
-		 HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
-	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+	val = HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
+	      HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
+	      HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
+	hdmi_update_bits(hdmi, REG_HDMI_GEN_PKT_CTRL, val, val);
 
 	return 0;
 }
@@ -269,12 +254,11 @@ static int msm_hdmi_bridge_write_hdmi_infoframe(struct drm_bridge *bridge,
 	for (i = 0; i < ARRAY_SIZE(buf); i++)
 		hdmi_write(hdmi, REG_HDMI_GENERIC0(i), buf[i]);
 
-	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
-	val |= HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
-		 HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
-		 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
-		 HDMI_GEN_PKT_CTRL_GENERIC0_LINE(VENSPEC_IFRAME_LINE_NUMBER);
-	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+	val = HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
+	      HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
+	      HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
+	      HDMI_GEN_PKT_CTRL_GENERIC0_LINE(VENSPEC_IFRAME_LINE_NUMBER);
+	hdmi_update_bits(hdmi, REG_HDMI_GEN_PKT_CTRL, val, val);
 
 	return 0;
 }

-- 
2.53.0

