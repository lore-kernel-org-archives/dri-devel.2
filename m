Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA9BE9905D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BD610E924;
	Fri, 10 Apr 2026 09:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRjVzElQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MO7G/Ycs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E06910E920
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oIin1925143
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VZzNBEVNfQONkq54ts470xxouWY76yWan6UzpjU3w8s=; b=CRjVzElQ1tRsp8f3
 uR5un3eESVJ36efLwc0QJUnvEoMXRLCgxfQDVrd2yTlxiJXxjrLiIfD1ivXMLi4Z
 v2KhDv43vcCFYaTTdjuxqbFsPhNWu8uCnLP4H+hSAfqPy2wLeU2Fyjwhk2lmf0H0
 ObptMLKX5gELBGrz3qPEm0+SXdm/uTSAu74uplTZ+QjzSiXfvnJn4K3bycKjLgpP
 FsqOjMKjQR24T3KaXSF2BSSMomjhNexsGxyHPO40tmLkMbzs+84zOF46I5C70Srt
 6Z/p92aMIAOtrC/Gir3GoEurefge0dV54heK0XIgUWIC7wAOfdg50O0AKVod5flY
 zZvLNg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjrtc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a31df1907cso51968786d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813793; x=1776418593;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VZzNBEVNfQONkq54ts470xxouWY76yWan6UzpjU3w8s=;
 b=MO7G/YcsSaL1L4aqzhb/n8TILiGYBcW5Bm86QXjZlsjHLwYVYwFz6Tnvur3l2ne6vd
 Nr1zN420QrAQk+u/4/8Hu1NA+d0s3qCdcTCQB+/Y7nZSkMDvmzmiLRCgiZGVAfb2hljP
 bTr9bIbhRqjKHvyCaX3XEKzhgJnPyqaPVbiFrqcRfGTxg4LFZiBfaKMIGblyWy8lyvwp
 nGPd6VmSgQUrKVGQaPiZdchKQl/8sJA8SccHBPAQpw3UxosQQ41THCnJAUymW5AdXJbD
 QC+k35hrv36IojArSa9YmJfGNoIgPFAeO1mGIDWW1xxbHxzHiavCgJ+uOADl2P4txl+r
 ozHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813793; x=1776418593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VZzNBEVNfQONkq54ts470xxouWY76yWan6UzpjU3w8s=;
 b=QEoppEQtkEMoDQuK3xBcOsrP8FhcxsdpY/ojq0eIkgYTKTFDO4ggdsjlJ9lR5Bpmxt
 OGa6CLopRlkoLnCv8KWa8RVuGmAoRPB+/d/Eiz0FkoxbZk/R4P9WoNUd4DQx2oJz4Vx9
 c7f3Q3idMWBpkJ3qRcZ6X1drNsx+mYn8Z11NdskDfu3Euv7UbUI3bPni6rK2yWkYHyHZ
 Ruwglw1SiNQhrQBrImnCfIrfLBso8JY7DguMGY6hCpT+08xl04xbcnbeCaCsQ4UyoG5M
 RsV84yLe80BvJgS3rfhldAYEkX1IWN427Ti+DceTLDLyeJqwrR7YAda/duEvV9a0+Aqs
 NnFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXW1EcsmKgLoqFCKgCxxxKGwHKViwLsow5kFStoNeRCHFZ5yvfg9aOVFpuNEjoWmyG4jhhF7Ckr9U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxyeda92DYZafFj7FA604k0BlFz9q2kMKd7iAPNpZGjAZ39qb3n
 vi2aBF6ZR1Fhasv9E4ZY/KpYWxewt+lQqUHnrAc8rbwBsPmNmTQL3duHVtXZgkTO2o7sS7Xmz9T
 fVY83q10BMPvYBHDgWHTWdN8etqSxGWpYgaVYKswxKATwAnPVdw7M/g+2pbzdHntKxvr0N2U=
X-Gm-Gg: AeBDieuAvLsnCxG9JhYvF5HTqeuUU+i6Edj+ceQbKjDVmFW1d2atj2r2f4JQuL3fttp
 kY7DkH3fqrokj3JNiU9+66BKRxO9+O012xi8X1Z0619b34AdW7tFZmu2f2Wd94jtn4IfQN0jZaU
 YHD6/boclws7wPQBP3RvYyOT9Hi8v9vrpjvcpUFh/V14a17lyufGUnyofwbBmQUlIqXgNzNuL4f
 pPpZRWJXsQ1Jj925gxytCnySHimaiDjVIfEGztoO1lns+pP5OHeU3X28NTGoqH142fmxj9Pvg/k
 pkb0iLkJZZi/XHHdMbNEMCN8CYJ/hWfi+2yB7xJY/6XeiNQdFLTumy20bLVhGEtbtXXYcM104ig
 N5ckmz93RnyQpaDoXfZTZQBvHtnQ9ZQDD3727cMFSTrHfBoxDhy5yPQrNfdH3RuqMwAtPmHvYUT
 9xqwIvlx8=
X-Received: by 2002:ad4:4ee4:0:b0:89c:a2c8:9432 with SMTP id
 6a1803df08f44-8ac8602249dmr33805276d6.0.1775813792852; 
 Fri, 10 Apr 2026 02:36:32 -0700 (PDT)
X-Received: by 2002:ad4:4ee4:0:b0:89c:a2c8:9432 with SMTP id
 6a1803df08f44-8ac8602249dmr33804826d6.0.1775813792224; 
 Fri, 10 Apr 2026 02:36:32 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:31 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:07 +0800
Subject: [PATCH v4 32/39] drm/msm/dpu: initialize encoders per stream for
 DP MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-32-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2364;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=hh7cPjxyA+5XkQy2l4wuOiGfJywbpFosqHP2MMCA2HE=;
 b=P2+SxIBHLLxI66zJRWxm2TlBTA3piaOS0zYEWENl24H+1AWttps72/9mFA4jfPDqTRWHyrQ5g
 r22R534dqxGA5SL6ieWB9KE3KchshXYhUDljaLOApiAnU9enNx1wrQY
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8c4a1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CHjaKMol-vWaWBnFkvwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 1Xw-khlfVVsZjrb0SzH29mzQy7ppSi8Y
X-Proofpoint-ORIG-GUID: 1Xw-khlfVVsZjrb0SzH29mzQy7ppSi8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX5S45foe6ZwiA
 RHPjDcKTeAm+vapPXDxu3fp8w98k//l2Forsw0WnG+H5gmEXgifbC09ceaBbqG/l6C4dtJXDUTo
 ehigSaZaH0uIZP0thy2seo+IXywsGtwWh7KoF/mh8Xa+c+kLgkxrTPw7adbohW8DaVVPYhUSWva
 RbZnRHvD8Ft8k5AITIRhG1K4hyStt45Fc4Ol2ByKm/urye6psL0a2EnqKNL3GthenOqKRssM0JU
 SNHpvH35XZ9T6SRMzvvyd6OR085yhO/DzfzoSXzRvuiM4QGVS7axAFPEsbmLk5e1683QzQLinDv
 l61e0pTxjyhFV9lqBDatGJ0MyFMUeBzJXdwW4X7KxHN925m9x+XJ2hT1GdNeNCw1iBVopDN3/a1
 A7wJFl36jZyu9+ph8oJ5aYZSrQCjM3rmpBQrKFfpIvBT6wHdA9SwehijZKHxqMSnfPwpbrsoYBy
 lKQzM6gi80xwOrMRuHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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

Simply initialize MST encoders for MST-capable DP controllers, and
introduce msm_dp_get_mst_max_stream to query MST streams.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h           |  7 ++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 61d7e65469b3..090e7d790593 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -653,7 +653,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 	struct msm_display_info info;
 	bool yuv_supported;
 	int rc;
-	int i;
+	int i, stream_id, stream_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
 		if (!priv->kms->dp[i])
@@ -676,6 +676,18 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
 			return rc;
 		}
+
+		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
+
+		if (stream_cnt > 1) {
+			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
+				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
+				if (IS_ERR(encoder)) {
+					DPU_ERROR("encoder init failed for dp mst display\n");
+					return PTR_ERR(encoder);
+				}
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6d847d593f1a..3061eca49cb2 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -362,7 +362,7 @@ bool msm_dp_is_yuv_420_enabled(const struct msm_dp *dp_display,
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
-
+int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -379,6 +379,11 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
+static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }

-- 
2.43.0

