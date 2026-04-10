Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF0E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD33F10E927;
	Fri, 10 Apr 2026 09:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmD30h/Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHnEls3J";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0446E10E92B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:37:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A7MKE43934613
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pwcDuwy8Yl7ve/abmXSW9gOfw1XWb9w/unRXTRsbdGM=; b=UmD30h/Y6Uh7FrSN
 w8HdVwdkqFzzjakEVeZduyvCv8A7PgOANcVWOszKVvKyh4v/1Fl4BihpiVJD8jjP
 tB80nkOZXwj6jgCu2D00HAeyB3oQLZwwA9f2esDH+1p11VmGv+a3sfYQW9R453DL
 kyBK9MyFDKB4MKLkwQd6AOtU8CVBFJj41zZCqudhQsa/I7wcmm/M72BQQtk6EvCU
 aJ3+Xjv9Wi0eSCE6KT5wajs47xoNs6fhyrLgsqSAGafSDMEQ2oGO2jm4jR8W4rPA
 3LSDdhOf5e+4qHp12W9KEqlRyTftJjWgNJu7k/Qp8txP6ZMcAcS8W2W5rc2iajSa
 ihVCqw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sbg1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:37:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ac7ff4a18aso28433806d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813827; x=1776418627;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pwcDuwy8Yl7ve/abmXSW9gOfw1XWb9w/unRXTRsbdGM=;
 b=IHnEls3Jy+gMpRLDaObZI0kgtfoMaH7483Sc9VrgI6CoqxQ/ZY1krVvXxKoD1K2kzH
 /Ch8cL2rDpAFewT8t3/TpJ9jip1XO4ureE6GKNIxydsUHmcyExIG/+1O8AOQZ1+RFG3V
 VnRgoLRCvkXUk5hi1bXnUn9LdrPpVsiEsxNQT1vOlBjdfwwC+peI6Dso76lJ588MbJa3
 JIZ8qgjeQq/DfXTB56GgARTz3Tmm+T/FpEVwYqH5GLSOTThbnbYND2nw57pAfAiUmyHb
 anZi0xMLq2RnahhbJpPTaXAM9AKmEaotSmJ44p/nMM+oGjL/sz+t8MFtu5eg8Mjg40H5
 z0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813827; x=1776418627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pwcDuwy8Yl7ve/abmXSW9gOfw1XWb9w/unRXTRsbdGM=;
 b=cU9mFuvEH90R7pb1LegVid36iDOv9n747nJUd3sk+KpKmEMK8SF7D7lspSKMWAoDqF
 3l3izUOc3ftGXC55UJiL1rWxj3yhjLByjLnJWxk8QjuHP+nFgI8ArG5WhL+LeccPls71
 cC43owSKB6BafEOJ3k3xTjs68vixNX5ukGW0D0rARkR9IirgfACJClJB9bHhQNCp21s8
 fRorxETycatK744fpTirJyXmUv1uexGwPCXrEutLsZXdcIe8mMNwOlJT0yA61IKer0Kk
 cXuntNQJ4wOR/7oW72nW+l93qO6FfUc8+VhoP3A7piyegGWT+oFXesm9Hqin3vmuSO73
 YKUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1tod+Uf+owP9h5UGiJDym1Rp0JIvkyrMWiMOO0xORVWyKpEMA4TqSJNnarJZGH7J8sb/LAc+lHOg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTbCTOwasunr3kXE17IzOmwlTusSyhDZJbMgD0qmdbGXcJr76O
 4bgWCDfEklhhRTJw/c4LPfegOpuuQ7LNEGiQWQi7e37YuCCJtLPj+DX2OT9UeBu13y1WWHAtdm9
 AZtOueQ9u6DVnwD/Je1G0Jv5W9Je4FVBGTXiEZTN53JfpAT+0rM4gGkX7LoSZfJi39YwEicg=
X-Gm-Gg: AeBDiev+WwukIvlEQG3GX+U8dLOw1wT+ehS/uGL7y69oQZe34H5WlEcl4W2MgYbOoaU
 pJuduSjDoidadmWN337XlCpciuyc/aXNIqxsZlI0DBp/wZMkyOQ48/AnmcVb7nhIr7P0VtVBED1
 Gij9IdIpwd7ut8cMLSwpzvIak1Vz9mJXz0D6rGCccl72e7PbTKZnB/hf7xTzsp7uOrEWFeNNgGK
 b0r3Hc9XW0FWvOckuyL6PlAm3UqNMKX0XlwFkXW9yePXUSiON9ztUlmG7jdn5ezw8bqXcyj2UHv
 cQGzWHMxyfOyqdQDyP2pl5n+N2mNyVQaE7VWfFKuOxZhROJmt6Tpq2cvGrGsrzdpzAUPfSHhvcO
 2HQ1aJAZX2D+11HZrLaoMpxg8eagWPDwk/wv6LG1OhCSs9fs1mjWZOwPBufqlhoJOiCi7J+lGOf
 tjVVWKhfs=
X-Received: by 2002:ad4:5c83:0:b0:8a0:166a:4a0f with SMTP id
 6a1803df08f44-8ac8623be8cmr32206826d6.48.1775813827410; 
 Fri, 10 Apr 2026 02:37:07 -0700 (PDT)
X-Received: by 2002:ad4:5c83:0:b0:8a0:166a:4a0f with SMTP id
 6a1803df08f44-8ac8623be8cmr32206386d6.48.1775813826909; 
 Fri, 10 Apr 2026 02:37:06 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:37:06 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:14 +0800
Subject: [PATCH v4 39/39] drm/msm/dp: Add MST stream support for supported
 DP controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-39-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=5055;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=iMwTEQlSLqdMIjLd0OShc7tEQJwDmpIpI7plmhl2Ppk=;
 b=px7SlUcm5iFaAIhHhWYgr6H/gk/oToLLLHCVm9P87IRUEQz56O+VqMbU3shfdcsF1u9qPYrSP
 htEkTk0ua/rCYN1iG20pUn7fp1phB8aCIdFm0UxQ3k+ZRE5ZuYMKKey
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: yYuEVP3l0MKO9xYI6deBd5NpiRUyp2_P
X-Proofpoint-GUID: yYuEVP3l0MKO9xYI6deBd5NpiRUyp2_P
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8c4c4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=PGsfSfowbhEG1GcfnYsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfXwZnmVRb2UDio
 TGZDme8EYq6paLrU+271iKLncoQYSsUEOi38L0fkdAUzQejcXTgPI6CBxlgcDWmMEGrAJ3CceFL
 lbSjwgF8cwuVYu4ib83tHC0dnkjGA1sqhoVIED157xJ2BjhFpeCI71gqlPA6flM8VyMqaxxRE5m
 LuC6Qel401CSzx9Jh6EJGSggUQQ/UQhSTT0RnSxlM8PVMRaBVTpEqO9IOC8E9wKIu5Sg3tu2pcY
 8mcDZcud1xMxLlYiHO4IUmzXxKRViMYTldkEDuJVrTYtdbOTQdxSHJdjhTdLDNPgwZQElVNpllF
 0rF13HBFF6omyZ+OatqtOO171Bd1NNeHXFmupuccCFvecxnW7XoM77heeM9AYLfyu/xv3o3r/6a
 aAUUESVLCbPrQPC1I2xHHH7JkaSZA0Uwm9sV8WatC2ull66u7fbvN0A2now44W5bxLoxeR2pJi1
 2ZKwC36YP6iD+rsULBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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

Enables MST support for MSM DP controllers that support it, allowing each
controller to handle up to two or four DisplayPort streams. All necessary
MST support code was already implemented in the previous series of patches.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ca89e20b7563..f632b4f64ccc 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -107,16 +107,21 @@ struct msm_dp_desc {
 };
 
 static const struct msm_dp_desc msm_dp_desc_glymur[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
-	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
-	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2 },
+	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
+	  .mst_streams = 2 },
+	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true,
+	  .mst_streams = 2 },
 	{ .io_start = 0x0af6c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
-	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 4},
+	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
+	  .mst_streams = 2},
 	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{}
@@ -133,38 +138,47 @@ static const struct msm_dp_desc msm_dp_desc_sc7180[] = {
 };
 
 static const struct msm_dp_desc msm_dp_desc_sc7280[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2 },
 	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc msm_dp_desc_sc8180x[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2 },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc msm_dp_desc_sc8280xp[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
-	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2},
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
+	  .mst_streams = 2},
 	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
-	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
-	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2},
+	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
+	  .mst_streams = 2},
 	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc msm_dp_desc_sm8650[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2 },
 	{}
 };
 
 static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
-	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 2},
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
+	  .mst_streams = 2},
 	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
 	{}

-- 
2.43.0

