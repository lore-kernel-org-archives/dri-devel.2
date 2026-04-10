Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F5E99064
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6530F10E922;
	Fri, 10 Apr 2026 09:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cu0gNcdw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R76kCPOp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CE310E921
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oTwF1925546
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CThD/5AMeBM6JcRkP/l6fYlNQZ0JmRoS9eNyVFEqViA=; b=cu0gNcdwqRd/2VRI
 eTicJkQ9g7dB9azYcylCw7LxiilyeyXGeBMhBtgfHyTT3CJGqI8iBIdpzEENG3aL
 Ui0fthYpi959ypFFX4aaiAQatH/PSvHX6dn2F80fb4LbkE3+zndpQX6qb7Wx2Lq/
 737TmoZlzA2a+A8bSZ+WCkUOnbkRUB/tlxNw8elG9Eos4htHh8SBecN4+PPeRoVP
 usuv8IHNCVSw1Cu9lHcvXJjevQhBNVZWiYc4gh5jnNJbv2TtBv3WNIjGVx3RWuFz
 s8ol465ptcz5oTWmdJVAu3Bl3681AFMK3F9ms53BLK6F+OKtiJjUYiVmXqXR0cld
 cxC0DA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjrtaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a0ef4a7021so29513536d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813773; x=1776418573;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CThD/5AMeBM6JcRkP/l6fYlNQZ0JmRoS9eNyVFEqViA=;
 b=R76kCPOpkG0dQIeSdh5LBBG9bX9e2dKARyWiOiLYbx91ZjxvCivqqfFkcyQh3Rvu/1
 /Y5HN2IJ8nooDr3LyaHsiHAp8nCAZCsnfnjfIifDOVVo/yfkvXP66Yw6Cijrxwmm67Wo
 ewtADzJ4BTACs3dfdEkV5Xkv+qEEtJQC2IPB4kvzcvNDZeE6dal+RSmF/QEbGrKTnen8
 pIR1TPks1ugfaDPT+3O1qtowpwbk4lB26ySluP/KpmD9LKXFOAYSz5mpbKoUUoyx0XQk
 SPL/ZLrpz1EzsYd2EX18Cwadxv07JQtoGsA6aRDUKX9/wU+j8eefOANR5w6yaGO114uU
 5kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813773; x=1776418573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CThD/5AMeBM6JcRkP/l6fYlNQZ0JmRoS9eNyVFEqViA=;
 b=kEJ/AOkhqUubmBEupua/TLzEJbnHUw8AjtxdCez6HRPUPz0Du6TC1XSnlk93SQKRiq
 jVwGJOgkbH6reh5a/Z4jNOBC1HNSkjCMZ8PjEuIrfXUiILOTkgokaXMUBG0LWL59MneY
 mj1Tc2582dfnY36lC3ESlUKevZ6PWxYJ4VL9+cv5Ajjbps3L4+uI1ynreCFO0XzxJI8I
 2G3rVx/AOefW+Y5akSekA1FwLtio+vEqHs5T3Tt+3csS51DmIgQqWloD6PJh7tjTiowx
 Lc2PCW6tSNEGnprrL82wwTaDVMeIjHUmf54NyQE/7QAjbY/1pKxQ41icU0/a/daiI/ur
 SI5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgo9toc03UHIriXSL7sd10+i6CUuRJqNxE5vPQM5zbwUZg4EFjoQwPsokEJS/HtiPh337UfL6Fmls=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2bgUnus0r/Tp+XI5i2NqlRLzWkphz8e+OHt12Upy4zJBNv7MD
 iK/QntuX8hXNQH/cQ3Wm7ydJNiY10PZRuXNakqF0GEKVrDLBUfjhuKPczEoEOOIn6nFiEcMwhyO
 nQ+w+f4VeyiGNKnAB9Ies9oAr3hoUBdfgS2Ftze5BRidNK6M0bP9N1gTUWZYFqaushBbfYF0=
X-Gm-Gg: AeBDies5jdbhVXd1EvKEgQuTFrrHMZiq3+P7jzxkC+WdtozUcucSWdpXats7qP6xwjm
 UNIN6gJBzuOk7utI041hSXrenQlmaRxWaWFgaXKZY0In9CwUIkVI3RYqOZI+ntvTaVsR4JZJfCK
 yvAI+mQsO7IwsYHqyC2GhBkL6gaqb1QkrCi+NKfNnZcZqiH8t7EVWJfVBRW5cSmVYBPIzRUp13N
 5ajKFzJtzLr1oXGku2OyathPlqNzQQ9MSAJCP1X6KjCfkmXVEkCQIi0vSHtT5ygJ5saoJg9LB+G
 pG54U8sHrakJzQaITKGbISrzNRuoHD2JOO0wRVPuEXpRhRRP/ZJXbYr7vwETaGt141qMKBDxZEh
 sd5ofaTwl9g2linIvprV9zBXvS9faIuJTuyEVemG/0Cy/qQo5Oq6npZArK/SNTSXVCR/L/drXEb
 RIRGjhHZQ=
X-Received: by 2002:a05:6214:8008:b0:8a1:8f74:3eab with SMTP id
 6a1803df08f44-8ac860c7db2mr29576876d6.9.1775813773232; 
 Fri, 10 Apr 2026 02:36:13 -0700 (PDT)
X-Received: by 2002:a05:6214:8008:b0:8a1:8f74:3eab with SMTP id
 6a1803df08f44-8ac860c7db2mr29576486d6.9.1775813772779; 
 Fri, 10 Apr 2026 02:36:12 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:12 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:03 +0800
Subject: [PATCH v4 28/39] drm/msm/dp: Mark the SST bridge disconnected when
 mst is active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-28-b20518dea8de@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=1012;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=k6iai2XwJqF9HQ6fP9coFSGKWj6p7U1qYefntORtujU=;
 b=NaLMEm4HX7teN+xR8vLnLQmdHzNB4iBVCT4BRua+7lyu7hyrqCu4EA4gyZD2p//WTkzyfzqrq
 faZfzcBRWTbDhW2PfQLVZaE7P1+RAiRVTB7Gf0ovZW6U6SkbA7Yzjjh
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8c48e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: squwcOvtdwiT_QveSwHgPvsXopo1Hq6y
X-Proofpoint-ORIG-GUID: squwcOvtdwiT_QveSwHgPvsXopo1Hq6y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX4JxBcp06/7yM
 cDjJOkOD2zmfUfEGg+DYdvS4ezNDJaG5Y+B/jQLOLE5f6hphL+cb/ymGJhMYszWZHbwI70SyFib
 DVj2BX7WW+xPxse3q2RA6Sk/4I+cwImfE3Prtvrbs5ooY+jfPVLzMuao0Jmksrf5qSwJYRWPK0X
 mrkICatN7tLm28opLMdmK8zWkGeFfw+4UVimW/PZphFLc5K9BkFLlzahXIqkaAv18lGmjSc1nLZ
 vv/0ks8D4rciMe5CIrBtrYc04+s6hOIbjB3+mZV2TTfRXuNq/GK6IOfqpHb2iPcE9PMISP8u8uo
 dv75tgM8yxJ7Rzd6BOSjj2AWd47R+viSOyEipIsSNf11RMzhkOwSW2vcMaiCFHfN2t9JUcl7fxa
 AtOYZWJYV4agSvhHy33GWECkGWKQx0c8cCabzLzWYjd+wRTzLp60OZ5UwMfZsLKAgwM+GiQLIqP
 Hqtk4UBFX8jslYNn+dQ==
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. This patch skips
detection for the SST bridge when MST is active.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e6ecbb3a688e..8ae690ce2b9f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -926,6 +926,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	if (dp->mst_active)
+		return status;
+
 	mutex_lock(&priv->plugged_lock);
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {

-- 
2.43.0

