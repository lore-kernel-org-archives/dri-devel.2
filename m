Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A229A106B50D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE92810E8BB;
	Wed, 25 Mar 2026 12:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGOliJPa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0nQbx4K";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1026510E8B5
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:18 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBG8TB2993787
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 irP6RT3EqC1keUbn+JPZoRZk0Vj5ZSyp1qChfAmYbnI=; b=OGOliJPa4YiTJreq
 IF40yIMHdaV674yaQ6/BCUgtkAdMw/AQkSgEoqFZjXwQzyjgZAjOkK4HtOkBTXry
 gCMFMAasvo6nNSSH6nD76mxfB+rBcI+QoRt7nZRJ+9Sn+hfw9FCObzXJoELMasyY
 A+e2Zk/cj0lSCb7e65ev1Mxa0crYT1ieexCE/5nLzEw7GoQcexZk07GyKrVFeiaw
 PF2qCc/8vYo9prQedP4+67mVDEWTJRg1P7Rd7u4HTNUKzDjexqUfdkxoO7Pze3Q8
 Zakah/3TsjzNknJ/s5N4LfD79iwQ6g5fJ3Q1TFSvsmeF1/zFUOHAwnoT/mWhthYV
 B5LLyQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dy4gc4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b878a8c07so15428051cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441038; x=1775045838;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=irP6RT3EqC1keUbn+JPZoRZk0Vj5ZSyp1qChfAmYbnI=;
 b=Y0nQbx4KMcEdzs3o9heYdCMkVJouOFgZPVhrtkadxhts1XOvfScJVK+Yd1r3BGW+QF
 7esDXouUOU7EJedl51CcC5fQCsw2AFsAXkNYhyB4tOh+lDxl5xK2uGSsRPJkvl+EtrLZ
 PL5Vr3xLVrUZlieRGeVtEABaArR7rJvcuSuXnBJRuG9/cBGywGanx2ezgSpEh1gBFOnw
 E7o/vKQrfWPq/9CWAcbmoPGBNikzZB+JekRsUmBdWOdKv5S0qbsj4JXuH7lA5PrtgQ6q
 PNNvmwuzolZRG99BE4ntOSEqSVBMeUMYBHMmDRa46ZpNhZy1Pz0erPMkKxzcNmG2gWdF
 8sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441038; x=1775045838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=irP6RT3EqC1keUbn+JPZoRZk0Vj5ZSyp1qChfAmYbnI=;
 b=V5ZFoW+OEBRAWwe/2yfNYdvWW2Eka6A4AdwnuKKm+Vu8K1kPzt9syXVi94dSa9OOj2
 WpV8NzHGum2DMItFHvKqHNkzQeJ01cNFePn0ipa60sLx/wLSECk6z7OEpQOoYxGBDQoc
 CDIQqQX/xN5PDX35uo+nw+KehoslpBPz+3nQxNJrpQ4YIvNO+CaNn8ivVQBvL7LAO+bt
 ZWddzhrJ1xeagLBBDlXNGr8B3fmpgcNMy4PZCTZMjzm5Q37srtQL9nJ8gq3gqN8TIhX9
 aDoc8fgh5TBdnh75LEvRY7DAmhiMgYRhA8B/ru0kQfgUVP4YO6RV77pkNXzJa9MzKbwX
 k2bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF6upMTDe8gvoztP412xDyx1T2wbqz0fbi1GAg8kMRkahxUJh4DMp9sA2g1SwEFYcQ+mycLWBnjto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy74EvVu1lYhPMumRfecL5iph1ln+Dqis0MRIl4hMt1tEGtRqLG
 cYJeAa9ZFW2QTMAExjddg1HALxG7wcrDjm3jcsN92OW7vQdG9aKoGuTPM/pxeTsraETlP/AAxYD
 rW4Gfall55mR/YQKB5qvSOoIr+GsUi94uZ8EKgP1gZ/cNmIxg7eKENpWicg1Z5qZfyIW4gcw=
X-Gm-Gg: ATEYQzxkvondN/lfd9w1rzNK4ydCjEqk09H176O8rQEKb3Ydvaoit++anYx4g6jXlvk
 rwtgzZQhXOBY8CBlmYyF3JZCI9Tb5eHPzOrIvthunhXQu7bb4U2kngWfZc7vql67vsSwHrxxcE/
 4SPFkemtqER48izkt8+Xz3VgL5vkC8w7DJ5HeLlAYsKaZffBzOBCF1g7NTWU3QVAv8CsDFURUlN
 Fa8Ek3oY7EX5jfNrHXV9LKLSCIGEQkjoTyQMMf62OxDn+ga+kT2yuIAqnUortR0AUyQugetG58b
 qSblTCoKzWasrnnY8GaZOytv6Y6X1mHeELHhIAGUBfgThfjj+qmpMNI10rF7WgjJLGgbqPJCF6S
 N+DMUQ8tLwBUk7xqy//KWbWdKNAM9qwy3Mx3Bve3iDH6F
X-Received: by 2002:a05:622a:6209:b0:4f1:b742:35c2 with SMTP id
 d75a77b69052e-50b80d03dc2mr44208411cf.22.1774441037349; 
 Wed, 25 Mar 2026 05:17:17 -0700 (PDT)
X-Received: by 2002:a05:622a:6209:b0:4f1:b742:35c2 with SMTP id
 d75a77b69052e-50b80d03dc2mr44207501cf.22.1774441036612; 
 Wed, 25 Mar 2026 05:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:48 +0100
Subject: [PATCH v3 7/8] drm/msm/mdss: Add support for Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-7-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dV4c9N+VPGpt+iF/Qhlf6YTdOXhS50ODX2RZxCnCTzs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9I1HC8/lE2g52henzcDN/LUaKGKZ+lhFYvzu
 G+qPcCKI7iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSNQAKCRDBN2bmhouD
 14wbD/4nCZWhtKQnQsuJTn1BK2Yk1wuOUUIngkXPuaPDaezzzCI44lAJSkODp8V+bxZPpO/MyMK
 6Zhh8xP+mbnlT/xTWgljgDmYWK18MmdXL2LTdslHCF25LyslcyWH4UxvazIXnlKDWY+6DFxnJyD
 3QUyYasFV+46WkRUv2QU7Q3W/mToiL89Gn8pXL3WwR8yyNqEBtBMe4l5UtAEUaYjOdB+qLD3HU9
 Uj+imJdakiBI5RbM/4ssa+JMQ+kY7NMmIHc9/KKq+izO4y/1g4d2+NPI83YdgDjUUhgEboGlmu9
 w9JGBeKpSykz0Not4z7DNpmVg/XuOrw0OY6daehDEswf+BJ5TSi614I0pL3+NNIPSNEW5UoAaAV
 Y4Ar6D0Mb+1kALO/bIpod9ESXqOJzswPuAQj3iUHjRu36J35ykVrhpSca/cxAFC36EEvaFX24x1
 UzM+61H2dLxsbgEFem/NK0aLBX+LSb9c3rKflxK1uPDR0i7R5wyxL3OPrkDtqrpyqxmCyD5GE6M
 otquOOxDqD57AY6IWmGHwUlSZAi80eOUk23gR7+b8eO7G7zU0lJTkMcHNc2S+djKHfhHdcccshf
 vQFnTk2ZZ7SP/5OEtkZK3Le/e+ZbkUt60m7o0fLzOETls9xl+OPgWfL1WsJ25LCwLaV4ch4CSjM
 /Jr3XCq4JA3GUuQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX3L9r74zfr+jS
 4hXv+2g1OkGij0jL8qvAjq+41bjDN9eNJToTwAcvOiG6fsSjzA7zn4jYaLsK37gxzLHQ0D1CSVz
 sxgFWUKXjElXPlTXPYhphTmNrFuWnZdGkOB0+v2X4ysFtTo5GWnobLHEOYchdNYa+UqLcby95DD
 Lnf5vEnDJK4MzGaznQphHx/eXvn44xIO+zQl/FzT/JWrIWDWcScz18mnOZ6jPXqxm5mvo1XOchP
 KoOxmIGlALFJzOA5puAKWG5MCd8VuZetQ989ctzMxcIyxQkgJs6fSjEeRzpzYiEp8lrPne/2xi9
 +PUKNujgQR1oHbvGLLmEeLRYtKlaoVvmgM4zMwHOu3+HlarWRs13h5m1jm3A/c46d18sLTxoxNq
 bcPZ18fZ0CyYZ78afJ7+2Gi8IzI4ARoKBnx2ajcqLjnyqEtX5COi3kdiyPUER36H/F3kEv7ekeL
 l6/e6ZDqdjoBKo2gP8g==
X-Proofpoint-ORIG-GUID: L8uZ-CU8l-lFHEaJ1Rq8vd0IyXAcwReV
X-Proofpoint-GUID: L8uZ-CU8l-lFHEaJ1Rq8vd0IyXAcwReV
X-Authority-Analysis: v=2.4 cv=eeUwvrEH c=1 sm=1 tr=0 ts=69c3d24e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KosifQuNy-GW_fqSRSEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add support for the Qualcomm Eliza SoC platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9047e8d9ee89..a86776425f26 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -560,6 +560,7 @@ static const struct msm_mdss_data data_153k6 = {
 
 static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,mdss", .data = &data_153k6 },
+	{ .compatible = "qcom,eliza-mdss", .data = &data_57k },
 	{ .compatible = "qcom,glymur-mdss", .data = &data_57k },
 	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },

-- 
2.51.0

