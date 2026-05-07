Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B53CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E0510F0D7;
	Thu,  7 May 2026 13:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gPADgdc2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kpDmQTpc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D069010F0C5
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6479mK84026622
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jnv3IJHVveO9Wr2l9i2vrKyKNiwoqkqE7X6w0Obsuxs=; b=gPADgdc2GN4ODD2S
 8381BlK7gBkFVvMWEq/3/bPMJpe0CImOdd326DS23RObjVb/DVr4nxobiI3QdtN7
 SfPVeDbc9IOyaGj5CMll/snKoE3Kl9F7muRknQ67dGhwhQDvRP02bwHYkYlqUK+G
 CntKtL659EtMQ7LUNSlU4p8ILfXSwT7vpb7fU4lBjAeTNYTjdUxQHXlUa+qGxnjl
 1DVj7/OGBrtdWrQ1xFx5CmKHNTCa+G/mrc8bJgBO0jBRZHmiUpNvqzyJy/WMeO/l
 rzT/qHPJC0/BBE1bjL2YgOo52IGztoSNXdkti9lBVabf6DZ1eq+lsshl7yf+huMH
 CL4xBQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t1yqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2adef9d486bso8821045ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778158996; x=1778763796;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jnv3IJHVveO9Wr2l9i2vrKyKNiwoqkqE7X6w0Obsuxs=;
 b=kpDmQTpc8S/rthoqaCFnEFQWfgHhjznBwAkulV5Lsyg4VhgpcfSlvnPBX0n7THG+u9
 rt65wMSK/n/KDCcsbpuxGot9SnO3MxBkW1Jw+n1DUz+T85kHP8NMurLqrWJombUqJ2oB
 RZUaAObDl45vfMBfX6i5MBc84Wf0AZITaZCsxcTqzSMjjo3JK/uBO0NgR6HqEe5sZRLD
 TQrnlUZzrrpP54D5PZUOewXHqsmQ5dX6cuZ+WWOPPCz18XWZHJSqs+u5eXwA2LBJC58S
 BpzR7uofftAwE1h5TxbaVjdfKSsPWakI2zsOPw/YygmyJ9h5p9kIAyagHhdaL2CEBsCV
 wnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158996; x=1778763796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jnv3IJHVveO9Wr2l9i2vrKyKNiwoqkqE7X6w0Obsuxs=;
 b=YxcI06sjgQDkZecv6XTJbYEbL2sSoW9xmUgkfuOzhRS3OIGVaX0QoO8zRMwxQxnnxS
 N7iuQyriePlocZKXQzQpRm/vP3Hfcmqej0GXCsZ3NCajXZEFOs4MQROCGIwEHdX2qGQc
 Ye6/qBAaqKQySdt/YBdl6XTGNetKF38f8AX5WVZ6XOfUEaelYlSHl+d/KZ0uxhMEEWxk
 YuxKUHIVMfu4xDFs8K6xYboL190licKQDWdWJPRdz6xEto9mt5wLxKEl798y7NN/MWIk
 2nYhaaxCZaJzJcz7DN7m0svPmZnXJ5JSO5vHuDvv890FiHNIFIAioWULebVYnv59tBOu
 jlbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PsWUvkWQgjhfcMj49HkTPOWuIEINfKCJEdKaNYW/yXjHV13Y6uXwjGFVE79o2cTJ1hQpWuQhKRls=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIml/FmkTtczQw/UPfe12g0FQSpXFsu3+TlriPUKfRYqVFmHsv
 2aBbo76FT4HfHczopr4eDmWB7NjOdhu72ixyS2VbEOf93Q73NGJQv/fvlHfnyH7tBkMX4FyaF4F
 MnbpEniAkS5vLT9j2Dnr2l6q/uCgcP+aWBNeZaG74HUoMjEGT05GtgrWbhHv1J2KoOVor4/w=
X-Gm-Gg: AeBDievXfrY12utrTWQgEGKpogSaOfaPktDEx84ux6ZiHfOZ+8lvcuMJPGmGDc454Ct
 hKbqvOWzVZqtCO/QgkA4KR76MWe2G3nyY31/dJrdWj84VsqHUs30FvOmLTBV0tkLtxJ65eIXRwt
 l3jiWAYEXIpsfQD799/bhWK1GRIXgDyT035cUWa6PYEfZBAa8QVXBXdpQtRqnoxwCwda3kmGwy4
 GFGpsEL4WegNVTbPgAySZv12+Xrr5yBR+6RQLSQtwk188h4l99JgvJWXDksrD54PjiRcQNzjqeD
 E5krKxHdTJd+sqtHxDYP/sUbOsrhO1lGhVFzR08G38Nq2uDqI9SbStZpVOH/nEP/cF0zT4CTRbS
 tfDelCRRJKZbrR+LJ90jUY1XqIfjce5QOSDkKVO3848f9TgxQqk1v9LxKzGVuAP/97/vkZeb1xU
 w+OtmIivNKOHdCYewc58NHrtlSUa4dc5vPPfcA9b6Y3IkINQ==
X-Received: by 2002:a17:902:db04:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2ba78b30aaamr81120755ad.8.1778158995411; 
 Thu, 07 May 2026 06:03:15 -0700 (PDT)
X-Received: by 2002:a17:902:db04:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2ba78b30aaamr81119995ad.8.1778158994785; 
 Thu, 07 May 2026 06:03:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:02:59 +0300
Subject: [PATCH v4 03/29] soc: qcom: ubwc: define helper for MDSS and
 Adreno drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-3-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NJiVsMMKzJws+Cks3lRdvlT1mL0gwv+c/6r+WaGQjLw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2EJ+8pOGUuuyBu0o3d2qvdC5hAWHh0TuDb8
 WyeNkc7lx2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhAAKCRCLPIo+Aiko
 1R8lB/4uHk56IVUJ/QuYvoKuKjNL+ak7J6dJHZKiFN8JN1hLoBndS8JqNZOmU3587DTMScfG+pC
 6vURC07s5Xwy3SlbakACSDvXGN7fqw7iE0CKwknZArh/qSOa53WZh5DBzwz70aVX9QaYz8Mlf8J
 Abzsnm4vFGBmnDj+xxtBEN9VdW2qaNDPqDzxyEjtp9JdX24AGk8s6AwhWgg/eL440WFM9ZUWnV5
 Qt76sg8u5vuvf65Ld+VLGRJRifa9FDIoPyNgA+aCYrcKu1HO1dAXIhtimmFk3cMPY2O1YWOC5R/
 X0+RGieOanVvF+uMil3Eo7SKo+jGxFoYF4EW/LERe2G1QVTc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc8d94 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=TXJx5zmxIxDbTTGRO54A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 4bROtxBlj2VQtvtvImSpsuCGaNSsL4v9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX3PtxiW6jrEWq
 KRF7d/G1Z5ZtM+5qkx0fy5lqza5KPk7TxGbjIVT/TrSuF88s3ngS7ql4kQAcUEiGShcCDDbPRSF
 HJH1fqWbS68pmXOuRt50IYBhMOn166HGNJgyZEuzSlGAhvAvxFQ4AleaDyYZqypTiR6L4uGhxbS
 uGkRkLC2sm9+wnwbyP7tbHxmVlkp+PvaEn+ph+9qG8o04vd2lC+W058rubOO2rDdpgHAZJBrQVT
 GM1twGLLcWzfV++uUNYsHSK5wy/y+FhvSvTckpVxjI8Z7FI37kt4lV+V12V85TFQfJG1fjUSIP5
 Qjda7c0GT0yP12We5B4NLQa8OEWLbC5iwsGfH/t+G084XDx8QjgiUDmL5gI0RLjijAA1/N05lCW
 gT+SRbhiC4F6nC9ila44HAXLKKOVHHJ2GEsrguXlgXtdYoyWOMb0xAmhAhlLHYDOKRLiaqrG4Pq
 W/cjnmL0nlnL/nK9ciw==
X-Proofpoint-GUID: 4bROtxBlj2VQtvtvImSpsuCGaNSsL4v9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Define special helper returning version setting for MDSS and A8xx
drivers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 319caed88775..8355ffe40f88 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -100,4 +100,20 @@ static inline u32 qcom_ubwc_swizzle(const struct qcom_ubwc_cfg_data *cfg)
 	return cfg->ubwc_swizzle;
 }
 
+static inline u32 qcom_ubwc_version_tag(const struct qcom_ubwc_cfg_data *cfg)
+{
+	if (cfg->ubwc_enc_version >= UBWC_6_0)
+		return 5;
+	if (cfg->ubwc_enc_version >= UBWC_5_0)
+		return 4;
+	if (cfg->ubwc_enc_version >= UBWC_4_3)
+		return 3;
+	if (cfg->ubwc_enc_version >= UBWC_4_0)
+		return 2;
+	if (cfg->ubwc_enc_version >= UBWC_3_0)
+		return 1;
+
+	return 0;
+}
+
 #endif /* __QCOM_UBWC_H__ */

-- 
2.47.3

