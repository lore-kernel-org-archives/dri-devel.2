Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B91810E934;
	Mon, 29 Jun 2026 14:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvD2Gvqw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VZx1qn0j";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8890A10E931
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5F0Z2728548
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nQqaaloZaS5enQFI+d8KGIEPr3AeTZ/Dz4Bxlwebq68=; b=JvD2GvqwA25f4oVk
 7N6XZw4gJYRvggnRYLf6FnqxBHHwIF9dlsH9JJIsrgWZYfxf53Ip6C0l699E/VJC
 wtnHtqs5YpvA80D7BhCLyjd4XIS9o8DeTNAolS5ak/Cpa7CoPQqiD2CIYWd5D7Bo
 0NbusCyQtcXOHO9w0zCNN/vADCO5Z1oWDz10Ozf7k7vFlNRGG/BYxRISnq/3XvGY
 FqMhaIhzChfzsgJyG0PK7bqyJreIOaRWypiaPvZNtPsOIZHR53eP55sEbnYdv2Sg
 vFjY6MvB/GYhze6J0paLrcyqhh1cg9izuA3XHb1LOy4KhS4XKvQXI4yzRTDIq9o5
 uDssUA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8pkx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a87ef9713so42970991cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742613; x=1783347413;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQqaaloZaS5enQFI+d8KGIEPr3AeTZ/Dz4Bxlwebq68=;
 b=VZx1qn0ji9ZEeomf7XELiqtkJ35dAxq/U2UGgojXgy1MKciRkYue4KARI+B2ldDdlf
 yygJV/3nSIPRbWQzmO7eCORGoYzylRtWOCaBsjGqNmYoOsMl+BFClYXaRV23fQrI/9Dh
 Rt7eUHCSjhurYHsaopxdZThbFtGujzNGBtyFP0YuHehsSf+UFkpsoyDQ7iPzl8hxKbP7
 VKT0S//SDuAeYqVs2zScu5iZ7QAaXc+C9WREH/QIES/LwINVtYbB9CvM0cEWDIdbUILE
 yxSKz8TJXrpHA+eHzNtuRg3vJev5OfF23E1Nn2ye0NYZyU44OrdjOR04zPSdxul1Y9x1
 2HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742613; x=1783347413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nQqaaloZaS5enQFI+d8KGIEPr3AeTZ/Dz4Bxlwebq68=;
 b=sAUpyHPc2j5EUMKfSE8953QF33jotpZZVp+QvNeGEtY6B/SIzFNTgp/fpDxr7RxI18
 0Mems4LR33IcPgWN5sRS+u7boIp9AxCtyz6+u5eppZcnU1HOKGaPUTIfssjtl18ncgE8
 DussYX1HWeF4WHk6/YPB5WsmKP/UHOrvd4k1RcSDBWCtCjRFFr5QUZREXxSh7zr6OPOp
 TbPUsMDAX2c9SkRcp71ppVdljQX1VM8fgWku7wqGI/+6C1hHxC6SWIb0eG/xv8kDKEjL
 nGOr/5Q+3JIQTi1Du0YvJgNHojsuE/ErO6Wh5+ix6jSyRLcwPWIIMMY3r4/w5cNaemKX
 jYqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FRYbPQ1RD/76j/1lJRwei71viy5rFxIluu1dkI/QlxObVev2uS0dNMnVWMr9afmusQ73lXnCjQVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyavfhikEhEO51hN5IE8NAYZOTDB6BceK1E/RvDHaU6N6nw4cwz
 mLp2o92kwY/rsH96FLQhj/4NWb2mpNv/qeGXg9g+inz4bZA2BjqkSBhffMOIFNVjkXQ8vh2rC13
 4017DbGYEeBcF0aKIYz6l2BEb7C92tDmLf7J7m2+OGDNemM/vQA4vLFk379XAt2+OZI10Jkk=
X-Gm-Gg: AfdE7clubgyEBIeA7vzEuD1MuC+W/rUUuXckRPgd29/WsaI0r1tmPllsHCGl/W/5l1g
 /KCqcHymym+UO0LPG72fi7RZ7Q4+3vSSqN35IyZ1jeDWJqVWS/py5B5+NL3Oow44WKLVhwbNk2+
 LBuFlw34ZzBmfmvqMAyxgq9GxKPoybr1nw7+nAQp7XKJ+Wcv8KU25+joQlr5CckTSRXXXFE5vXR
 hLQ68JxPdL/PjBpvY1b4ceP6OZiTy0QD4MNmt6mENAEPtVZKNTgqxiG76BkmmHNP3UeqqJ10qLL
 ihFSbagTysloFUbn6FnRgC8n+4NWfjO/pquAdKQcDhlNPZvn3AZvLgccP+SnajjB9rx5k5cr4c8
 yaoIDaNwFM2pcEqVKcaPQkBHTbp+meySl2CZLtd9xFZE8H8zIO7iD+QHQ5ylVDM1/lg+Llg==
X-Received: by 2002:a05:620a:4107:b0:915:6ce1:3576 with SMTP id
 af79cd13be357-92601f1bdbfmr3942143285a.20.1782742612867; 
 Mon, 29 Jun 2026 07:16:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4107:b0:915:6ce1:3576 with SMTP id
 af79cd13be357-92601f1bdbfmr3942135885a.20.1782742612090; 
 Mon, 29 Jun 2026 07:16:52 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:51 -0700 (PDT)
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
Subject: [PATCH RESEND v5 20/25] drm/msm/dpu: expose dpu_encoder ops for DP
 MST reuse
Date: Mon, 29 Jun 2026 22:14:41 +0800
Message-ID: <20260629-msm-dp-mst-v5-20-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=3441;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Tea5Jce8MD/RzZsevZLf4xjvhzOhaNCerFeZKirGZak=;
 b=W7kVy9kZCtWevW5mfwZ7km/5fbrIgOf+iMotKR8RHLo6N+JtiqHQGD3YkAEeTErpGmO3fg171
 T5WVMEwKDAnCeLzkzsAmtXtLIY5nEd8aAddEhiCSucYojjSkwB9C1Fw
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y6YUm5ZmTfbGk1t-GPtr3A77Nb8Wtu8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX9T/N6q11mkJN
 sVVN/Sbl8LtqVL6XLgj/lmRujfvH/6MVA6MSuGSulMbOo5FwXhxCgPLE9W4m/PWInRxccHIlKB3
 LBZc7qcD05pMNSzQPcvs9eRDyvanW+VX9uliIFFFBHsnctBGbRKo/msmn64Yogu8BylKaQunOgs
 04iKXwiCyot8HRFS+LUl/K6YEVc9aGRFRKBiSXBGe0uWUFMEPxHupzLGmgjMLpPij9JQYph/C1T
 Fr8PgcFeapHnZ4za7qamcOB2ogq/xCNxRxQzPoh7+eeEjqksGy2Eq81cXvbyzs7HINwrOUCshjn
 53siwd9w44KYNIYY/JV6qfK2kxGRle5+PgK63xz4jaHJ8JJ8WwzwUbPUre03odLCxzZZqNPZ42M
 OLPNBfujwAWDUaHu8Ah9dX3JQf3P6sZvHSTyqihpsMNsh9hyVfZOUEcZH4NIN6lBYvkg/uLbfqd
 qYMvRqTdMVfidfKbOXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX4Ywp729WgJtZ
 r35kAH18sqz6235BptmbR5plw+YUBZ9E8Zi5YFzOLpWqs9bTIdfn3w9acRHtFpds6G6ai88Gcd5
 J+MrEhkZpvcxQ9JnOsHtfhxqzU1Cm3U=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a427e55 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8o_kNyP7FEPhiWKY2ewA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Y6YUm5ZmTfbGk1t-GPtr3A77Nb8Wtu8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
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

Export dpu_encoder_atomic_mode_set, dpu_encoder_phys_enable and
dpu_encoder_phys_disable so MST encoder helper funcs can reuse them.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 ++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 778e231d4967..1c74ff6f0dbd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1149,9 +1149,9 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
 	}
 }
 
-static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
-					     struct drm_crtc_state *crtc_state,
-					     struct drm_connector_state *conn_state)
+void dpu_encoder_atomic_mode_set(struct drm_encoder *drm_enc,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
 {
 	struct dpu_encoder_virt *dpu_enc;
 	struct msm_drm_private *priv;
@@ -1334,8 +1334,8 @@ void dpu_encoder_virt_runtime_resume(struct drm_encoder *drm_enc)
 	mutex_unlock(&dpu_enc->enc_lock);
 }
 
-static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
-					struct drm_atomic_commit *state)
+void dpu_encoder_phys_enable(struct drm_encoder *drm_enc,
+			     struct drm_atomic_commit *state)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	int ret = 0;
@@ -1381,8 +1381,8 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
 	mutex_unlock(&dpu_enc->enc_lock);
 }
 
-static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
-					struct drm_atomic_commit *state)
+void dpu_encoder_phys_disable(struct drm_encoder *drm_enc,
+			      struct drm_atomic_commit *state)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	struct drm_crtc *crtc;
@@ -2739,9 +2739,9 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 }
 
 static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
-	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
-	.atomic_disable = dpu_encoder_virt_atomic_disable,
-	.atomic_enable = dpu_encoder_virt_atomic_enable,
+	.atomic_mode_set = dpu_encoder_atomic_mode_set,
+	.atomic_disable  = dpu_encoder_phys_disable,
+	.atomic_enable   = dpu_encoder_phys_enable,
 };
 
 static const struct drm_encoder_funcs dpu_encoder_funcs = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4942097e7613..25ade3dbbeda 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -98,4 +98,10 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
 bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc);
 
 void dpu_encoder_start_frame_done_timer(struct drm_encoder *drm_enc);
+
+void dpu_encoder_phys_enable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void dpu_encoder_phys_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void dpu_encoder_atomic_mode_set(struct drm_encoder *enc,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state);
 #endif /* __DPU_ENCODER_H__ */

-- 
2.43.0

