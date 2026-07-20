Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661E2C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F4B10E68D;
	Mon, 20 Jul 2026 06:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wqe5iLJs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cHK8iupN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE0A10E68D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNsJZP644653
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ylLRUd4CVKSO/kHhZcIuaA8UF2WRTOjszP/kyXRriFY=; b=Wqe5iLJsSiedL+nO
 SPsEZFQJhr/lBkR343Km51pBe1Z/QUQ3HkG/kHMlcIOrCU0CbQLz7WBG8Q8hXaiJ
 zvhjfedDVePDiOmwpFIwEeNUD4X5fizH6FV/TAqrdOYZwbxoNo6KglsaCJuMnwrr
 nopv8xv23UC1mWWSNMavIDjG8/KPsPupyNRk1fqGGVvTiCdSfqeOIK2mS3fw8/SU
 +GU/qYvnSQwSZYVSp3x+jnxu7LFOSJllh16I3qY1YIevMwX0oUtpZwqiaj2Lpoae
 xGMJP8Xm0Hh45/765pkSlXXo0nW86AfKIRd40ERXPDMaGxlWe/XFWjInqAk0KJMr
 uMZzxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvvn5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930a098ea19so560054485a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527915; x=1785132715;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ylLRUd4CVKSO/kHhZcIuaA8UF2WRTOjszP/kyXRriFY=;
 b=cHK8iupNDSEkHecJike/ATUIey+Lgy33VKWUlQEfg/rOzmTMkydcS/5Yjb9WkvIMwn
 y/+M1hZ0ffbfTSpDuJKMoFgN7/kDekva1EuNyvLnnvj3w+l1iFg6vIT+9bpaHLg4wQH1
 A1B4Mw8D4zPPHGDI26TxYWDAOLyOYLsrjo2qhIEk2loZx8W6Y9r1qxjcIgygeF6qFJPm
 IRMZZL8firTzUQMnOXWqXxADNltZac0LDc+QlBGRUNzYghA+pJw0ShgVfDhK/7thsNGN
 FaXPV1+ZyrDxMl/V2P8G+jbIF+/ogmnekXOTvndb6mClyVFSPrMoT/9l3dPDnjTX7E4r
 hAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527915; x=1785132715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ylLRUd4CVKSO/kHhZcIuaA8UF2WRTOjszP/kyXRriFY=;
 b=KITn01+O/ab3dLwSmpi9QK0pegGaYF5SsTyNr5bA1eNVGi4uJgzxtXSqbfQ5p/O7U9
 qf8usjzEKpI3T+Br4gbanN/YDSrSIi/izu1f/7mBPTpRwHw80PcBiYKEBShHvOIN8kLE
 gyB3GkjO61HJrEIbVAIwKoAkVkY+3GV0Z4TVXF6TsMcfLfhnpWpykbIArI1IibrKzjqw
 dkJ1FaSEW/SkpXS0691GiwIyerbzaByXvTLMKJNuchK/KDuf492DlgjIXkMB/Ty6kVhW
 JzGlxytJx1DfPI85TUVVg6AKPHCQg7GJQtB+z3mx5CTI8BLkaIxxaWnoLm1MW01+qch3
 38BQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptbo7tgXEXqhlzgqhh3dqrmVnRknyRbVdwntmFxc9aaBLt8eCE+bHjy1n+W3HRedq/oBHpvNI72Jw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAhPUva9/nQ1tma5S/oHJUDtD0ufeAFWRnHwGuSdcl5LT25mwk
 NZzvq/3gdoLDQh7N0Qzi7Tw66AH1wIWfzUENFqhRpMBMOffkuiJAK/GLF/4N8wkR9dsOj4w1/TR
 ZbaMAj1smzNhnWuPJWE3vAJusSgOuVmODeSkIUugWTibnujFGTZVr54rTMDePI1Y8It7IldQ=
X-Gm-Gg: AfdE7ck0ExA0evYA//zCa1tkDa2l4h9Grn7+sJ16cxKmhq5u3SO3c4pnMC4O9bF7F30
 BmhsyKmXx9EqS1WKC9BGaCDLOACdb9WflZYU9ekWtzdXYqe44QjV4wL3PWog7vMqrTbhJBD83zG
 Od3kCGsr26GC8Gil8tuRuxNo6TlcN2zowwnyYzQ3VPf+Niu4f83Oep2fJTydIg0HolEWAHGktQa
 TXf0hbOVcRHKZdMGp05Hrqc/6aQH76kz7ccdBrhyDM5w7MCSmxEVL/gwHbnIoXXfhNG8Ve5fXzZ
 zxKTE108/JD4P8tIiMpbTctq95cdkLzwkHNPmVZRS7zKP8CiCyKirH4n89kCw97lZ8lOsFoWC+g
 +ODfipRai28hVH9MNrErgdG2UNlLJ85vJmpGtq8FO/9/6SxOiz2lYHh+WqQkkBUQ=
X-Received: by 2002:a05:620a:370e:b0:930:9a84:d90b with SMTP id
 af79cd13be357-930b416db01mr1277262785a.50.1784527915163; 
 Sun, 19 Jul 2026 23:11:55 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:930:9a84:d90b with SMTP id
 af79cd13be357-930b416db01mr1277260585a.50.1784527914660; 
 Sun, 19 Jul 2026 23:11:54 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:54 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:21 +0800
Subject: [PATCH v8 14/15] drm/msm/dp: separate dp_display_prepare() into
 its own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-14-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=3743;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=mBYoC87KLINdqnZzZwKmgMGhIowtcsCVrUUNDqvxcdw=;
 b=a/BTRE6d9wccE7tbAn/n0CU6acf9zm1TIOHrJVwbItdm0fhgyPlCyZXA2XDUL/zky0LEq97xi
 sk4fkvED9iDCHwY2OxH3C4TuJaRcvD2yNCqPJTIZ0SZfgnakI4wR4pX
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: qjeGrMrALa_YQ5DeHJ8gJphdVVurR8cY
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5dbc2c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rHTcTV9uYuKpyGuOXCsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX0hFdV/p/7jUK
 K8AJDjRCVIhwQg++ivuDh252lqL8t313/UProdo0Kpwfy1MukR2RK9LoeLp1XpQH85tLSgipwgz
 O0OjgcUoy15XZjdSgrhUMSaMpK3tliwWzeASBHHBMfcwZ720goryNOgoMIWNA4EF2/HcGOieOPx
 ZOUmB+XWCVjghW8B+h2bMjVD+9H54EOPM1GxSkmlmwj2YkDwRFSG3dj8/RhLQkwoj3giViUhtYU
 uNxu7AugftQ9oQRyrKGKrJ+iwe2O2ccwgYqAJ26HdaY+icMVEZMCCtE8MLCJnu/3//5b5tXeWdi
 fPxw9gVhYF9wcs48GyJ/9AjUopgJ7TqG9ghIvsOV64Ch4GcoAVJTpIltv07AFllEZQ68cKVybZw
 PpHEynNB78nE2Xy4zkowqXGKmN6WTtUMf+esb6Xoa/CnAoj/aQlJkyZxXGNHg3srE97sUiAlkzg
 VXbZsAlJnLTse4NxgfA==
X-Proofpoint-ORIG-GUID: qjeGrMrALa_YQ5DeHJ8gJphdVVurR8cY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX23arRS2HbkrY
 sGXCKurJ7mxcwwbssUPUET4qVg5rj4IMm7nHVbTOR89SoNOS5GQyQx8xZgHIP3g++nDX+Bf+Dud
 fMrWSJODJjC8xzJWkLQbAZvE/x7WmRk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200067
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

For MST, the link setup should only be done once when multiple sinks are
enabled, while stream setup may run multiple times for each sink. Split
the link-related preparation out of msm_dp_display_atomic_enable() so it
can be called separately before the per-stream enable path.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 16 +++++++++++-----
 drivers/gpu/drm/msm/dp/dp_display.h |  5 +++--
 drivers/gpu/drm/msm/dp/dp_drm.c     |  6 ++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index deb21cee1183..74d885e38b8c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1405,8 +1405,8 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
-				  struct drm_atomic_commit *state)
+void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
@@ -1428,10 +1428,16 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 	}
 
 	rc = msm_dp_display_prepare_link(dp);
-	if (rc) {
+	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
-		return;
-	}
+}
+
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+	int rc = 0;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	rc = msm_dp_display_enable(dp);
 	if (rc)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 5116f7bbbd02..43ed79093e24 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -35,8 +35,9 @@ void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
 void msm_dp_display_atomic_post_disable(struct msm_dp *dp_display);
 void msm_dp_display_atomic_disable(struct msm_dp *dp_display);
-void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
-				  struct drm_atomic_commit *state);
+void msm_dp_display_atomic_prepare(struct msm_dp *dp_display,
+				   struct drm_atomic_commit *state);
+void msm_dp_display_atomic_enable(struct msm_dp *dp_display);
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index aa98f101b093..75ea52afd9f3 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -55,7 +55,8 @@ static void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->msm_dp_display;
 
-	msm_dp_display_atomic_enable(dp, state);
+	msm_dp_display_atomic_prepare(dp, state);
+	msm_dp_display_atomic_enable(dp);
 }
 
 static void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -152,7 +153,8 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	msm_dp_display_atomic_enable(dp, state);
+	msm_dp_display_atomic_prepare(dp, state);
+	msm_dp_display_atomic_enable(dp);
 }
 
 static void msm_edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,

-- 
2.43.0

