Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BA3CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A5210F0AC;
	Wed, 20 May 2026 14:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sr7amdMm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hs2McxPS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E3D10F0A5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:30 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDMNMd1725548
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UrwG1S/O3qAkBaF791AYRGLqRUMhO7W/iLd53FJSriU=; b=Sr7amdMmfYdMr+Zc
 VWcjkcLGyThlQ8ycj8LrvSrNHd+eJI8+TIO5+OERDI5sxeWr104+c783A3+0ARFB
 aMu6AxPef7T/xpQcTtKU/m8l3dWbPQVw+iPCThTZ3+0c+q7moL657Ihuh080CfZL
 zsFkqM3QWIrTBW8+/mfHtLD0YQLBD5Tz3DFLa5gOhaw8JC40xPDg9GlqH6P3sXmu
 tRrCrbZb0YGdm0ghmrPxrqHSG0m9WtdCK7ezHyALetH8s2+K52dvKCXdYNqMIp7h
 J7EewccH7oxtCid2TDWWQwPzNUBC+LsqRkEpYJKazVyMns1Xnw+dO04zUsylQ6uf
 +t8XlQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qn8ua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:29 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-57548c75628so3731384e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288689; x=1779893489;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UrwG1S/O3qAkBaF791AYRGLqRUMhO7W/iLd53FJSriU=;
 b=hs2McxPSZ9GGeHM6R8aLDaY5+a7htnF+085TPV45qIUcLGZBW/Q+jK+VumQonPFQgi
 u2MtWWua9x7RJWNEoSeZSxGRCWvUze/7EVpThW9QrOV4mkTItTfd6iKkEXaUR3yHzilN
 ME27aHkuxynLmt6LvKhzAvndl+/m1Rb+oPu2hl/adBRPJMN/amFv/WE7T9gw9O92nfSK
 xtn6z8eQHCBMhWfFg6GMBFWonZCqpeUAzrl/FO2RXeJrWYknIS6VITAFJxJMMyIVRNVf
 Q3MFzf/ix9jO8Ye/87y02QfyaMZDmY3aTj2nJLFsJjq8ZEkz1mLaUqPgUPGJzO/FzDmV
 dwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288689; x=1779893489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UrwG1S/O3qAkBaF791AYRGLqRUMhO7W/iLd53FJSriU=;
 b=Y6iZhhWpNsxi9CJVcwm1wKHgSixxJ6n1BIXU9mWf6jMMGBBV93ow33B93gS2kFw27l
 LKMRYx2IsJK8A1sjMjI2E4Fu542/vFefsfaLSVEiJ6v9iS+EBe7Ywqi94GdDhHgBAfmC
 WD7UR8wfFC+W/rGC4FnU849goxKW0NBKQTVY65v0I5zL+lcJk+DOTx6A4+W03WJKKhL2
 s8pw6vQ4buNF2uWvQtqvesheCJ+rO/zmziquzXdP4NalZIi0mYmAmkrrr2FcSb+1/BU0
 zTrDyGNz1tLYOLIj4PR+Jaq6rBUKuTcaSHcHk7o2D7B5g1T49oxBvMIEyNRYxcCQuIfr
 3fzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9jM4qh2n85Nh928JzMS2JyP00HWiDtf0j0Wd6qvmnID97jBM81+55BPpM42H9E++9iGrEStSKlvo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPm+ZpXQG1o9O7o7fIZSCQL6B41sY04KfdYQ5ZSvOhmzIwLYcO
 nPdUjrvaeJ7vajzTIw3A2jtMBSy0i+lBM/QCP3R/aIAZs14fFOvD8wgQAyEYn8+59G72NTkXvZz
 JSXmJ9v18fb+5j0X15rVRn6dQuH+eKffCQbXaaYawKJxR7oM/Jju8tIkx3IJYLAmPCpj23G8=
X-Gm-Gg: Acq92OHGGdGq1lswcftXIRTVwjXrZRaR49IVnjGX23rI7pZy28SP60QFP3MorsqQd3V
 8cI6hpeHBL3YcW/enTvNgKBb1etGQLVnQhHlakLTl+cMM1K2YPyhurx+p0JOhQVU6FhiVsM7kFz
 A0iOK9rUq8MaGO2qqDgVL7FGAYfuu4i3bzDB0ekVf00a3XRxm4g9K0SYeYEQdI+Xa3XhfTWI/b9
 VxmUSOVvpEnc444zoAaNkrjbiuISY2kx2Cvb+nXOTU69Z/v4+CB+wyBv8trRXI9V5Z6rObkfwtL
 9bni8WwngSnW6Oya83mCU4Wa9nwcMOYR4hxKtPSYoXA+PYnrSPgn+ygewJXhxrIxAFNaXO5eSte
 YV4PxqOozyEkh1v8NazDqcfXggR8uT26jl9v8xaRZlnmUlauW5YzB1MIHjBs3cVtvrjG2E1jyCl
 LfXH6MJNKzS70t6bvpIKZleICukURArC0W3O8=
X-Received: by 2002:a05:6122:2988:b0:56f:a3e2:66a4 with SMTP id
 71dfb90a1353d-5760be39af3mr12943020e0c.1.1779288688800; 
 Wed, 20 May 2026 07:51:28 -0700 (PDT)
X-Received: by 2002:a05:6122:2988:b0:56f:a3e2:66a4 with SMTP id
 71dfb90a1353d-5760be39af3mr12942975e0c.1.1779288688306; 
 Wed, 20 May 2026 07:51:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:10 +0300
Subject: [PATCH v5 03/28] soc: qcom: ubwc: add helper controlling AMSBC
 enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-3-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=819;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ExWr1JY9whNXUKFY5t0L4RzJXMMulXiTflbhGuiaHZI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpm7L98NiVy2c2G3dWVoragMCzQMvvnfaS3B
 rjM1n57BTCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZgAKCRCLPIo+Aiko
 1QSPCACCKpLUBk3NUYdB90kskEN18nV0MDp5L9vyeofmX/kuMqKVnnQtsrBNVeMUJ1cjSl7TX0G
 pr2GTtlNGfEAVhw+MI0axWiTiG0IQkgFl1X0vSvvXBu5Zod4D5SCgY6ggBJpLY3eDPlvYpT+qrS
 cVYtenD7qxrRndKv/Nkgd2gsGdAL1u2eMq8mDMiKXihAYz9pJLbcbBeSxY3uEtDT2yZK1a30w+O
 v5nak+iIo+62vUHowH7ST3EkEUc8QyMoFx6DOrWEXxmfKYRKwKe/yzzQXeecSI9z8cNPhyTXKXR
 wIJGgqw0IA62dIbrc/MGHHBOPHaEkUADxL4OA/rfKKBwRNgl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX3DrvUnwgI3Ab
 cn3rA4ODsGn4MOxDs1X5D46RAgRb3OWhXiIVv+JDle+sbTHPadNpCrad33Ni04TDjPmYeDizjF/
 NuKoF4p76hkBmuwlmRbdhadm/lu04CfOP728ap8wmeuiGLdPpg9hBa/mfOezV7nCX3N2K0Y/mIA
 m1D7sq0UTUsftMvVwTgFtiU6vwep5H7qJ/TsfhUr/+5BU9fBHXUnjLaaH5wKjjTAxx9pcY1pBf9
 EV3wWSNvk+rIjhKJHuMOq7wtJT5/YxZw+wHODACo+gNayU0pEVJD+Av3ETj7NrmMLrLCjcnXRBE
 tAYmYXuuHhjIgEobphLy+lqQIavWtLbb6mnO/dzoFBNhyMi2egSNVYHGcTRdsPgl12183mHVpkf
 wZLKC1ZIcsG4RHEdtjwIurDxCDmMhmpp8NezDv30L/wK2vz4BW7beVPpr9sUrtaBCvbQgshcOIE
 g4E0gpH14K9oq5x3cgg==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0dca71 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=WuC1ZyUpIfxNvbBu5HYA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: nPfvv5u_G7p8rFBJ6n-Kik7GgGYSZmPD
X-Proofpoint-ORIG-GUID: nPfvv5u_G7p8rFBJ6n-Kik7GgGYSZmPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200145
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

Adreno and MDSS drivers need to know whether to enable AMSBC. Add
separate helper, describing that feature.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 8355ffe40f88..83d2c2a7116c 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -116,4 +116,9 @@ static inline u32 qcom_ubwc_version_tag(const struct qcom_ubwc_cfg_data *cfg)
 	return 0;
 }
 
+static inline bool qcom_ubwc_enable_amsbc(const struct qcom_ubwc_cfg_data *cfg)
+{
+	return cfg->ubwc_enc_version >= UBWC_3_0;
+}
+
 #endif /* __QCOM_UBWC_H__ */

-- 
2.47.3

