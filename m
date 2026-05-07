Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FC7CD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C3D10EF30;
	Thu,  7 May 2026 01:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMvFvXIE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JeEKihAc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744DA10EF30
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:11:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646KluQS4164213
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3cbC07/Eo3G+pDdHAs3dopFNLJBtcTLJDOfZanVclgA=; b=pMvFvXIET/A2RnL+
 hzq1xZFQUeIn9C7+c4CtIrTDKU9pi0Fm6isW4hVfYfhZAQc+U2+HSCE1HROibW5S
 ORXrnqbI/2PmqwHpdoqAMBYe8vGixZuGm3jenYWkO88L4GUR1Y0dStdns4+5gWH4
 U6G2zdhkCyaLwkWhiiUbUDdiQUeikLjzJw1JO+Of2IF2jKtyCeReYGZZpNsZDXSf
 tAoyZFZm71bsnQTsdPZmNHnWI0xWYbgxtek1nzgRqV4Yn5ZZLBINOmS9avIlYXtg
 B17rv21IaTH1phor5wRDhOG4OQVrniWCytFXLE4U1dQsJWKl50hyTKVsbdljHMYu
 gcTYoA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e078sj2xu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:11:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso8918891cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116260; x=1778721060;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3cbC07/Eo3G+pDdHAs3dopFNLJBtcTLJDOfZanVclgA=;
 b=JeEKihAcnH403YXVgvSOSqOzr8x2Q+3BVsU0i0vHTGRlYZNuAxLSdWBGUCJAGedP1/
 2QHJrmzjd79ajasbc9Shm5AaBlgjQg9lkzesc0WXm3AMwvUgWMy/PzPpRPdtzG5d0S63
 aIdVsVAxe/fQs/z6PuPdCP2c+kJQwN2qonfgroVf93MSmonJ5OAwTvLcwXZYbYY+Tz29
 wUN0bCVNk9mkpeWUtCXG7srhSkzrD6yri3E0PgVCnuYOjEqx/N+dndYGF4BKBZWlcBui
 kdw18QNiPaYLOF+zDX/9SgMLg3VlPd1/ao6T6luEmosmZZzs13WOJ+F7LOZNhZNWicTq
 N4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116260; x=1778721060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3cbC07/Eo3G+pDdHAs3dopFNLJBtcTLJDOfZanVclgA=;
 b=W733le0t1wvnMamQnuVFLONZurJPupMQF96Bv5GcFp9kVivgpj2q7+Hu2tfhIJ4ixQ
 5Oc8LKOKUE12bdLrrMlYFY4Y89SoBuCM1f5Zd0ed00KkfRWABQekoX8LkTqDgJk4C61g
 a1cikNEMfXs8px4JVEYPpthhYiBkZRYHKjdyZuZ6qKP15RqabPZ8q1A+17u9SyJUyXDZ
 tlFay1EmNO6287uwRWNmKNE85cjEgrN/R7JurhF9uxRQu97gauG8u8nj29R+NgLUSSZe
 BSKGWmap1/RMeEhBM0u+57I4ujJrXbdgl9bNponOfdskrcIx/xFkFKlOS6FhtLrYNwEn
 ATzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0jhivMuuyg6oCtwQ9Cq79PifqqBUzInboyWgHqRYh+rxZjZy1j03cxko6i0mRP4Pq2dmsJ94IECU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxU6ar/8n/BJ22zpOYQJVpRJDxibIdDT3baBy5hC4Do1+JZ2wyi
 do3wylvk/ZihJJGTBYAOJbuz2Y6idvH368MXp+vRjVA5DQeRh7eq162SjkKDnxNEj81DqrVPErP
 1XsrN6tbbeeDW783EEUcful1rcEagxD+3pR+yLD4LIIoIhkm/AOATtZcLAprQYGzkuqsonhE=
X-Gm-Gg: AeBDieuueB5jSEAeelHCXqWu9qNjYZECF03Ld36rU0etawkKK7fuDjfhggeMvN+JWUS
 PUkinYqVnmZE6P/ePEhH99qE1GiIi1mNemVGTaDoMLRBIAe90s/8vxr/mOPRe5wyiGRa6jdWq2B
 lMjl0zzRsSFEtmXdmEnVFZv7HvKOxCRNW0Yd5FYBtqBYcjZc+Wd8D995cecRTOY+Cnjc33a/4Pc
 Xbjo+rWMbMEY/kaPALcoJvLdJxcd7BoizKiT0HJLb5n6mzELB1P/nzxG3IXKRDppvzVdG1aLDZA
 T3Ucxzv4yDoSG4r84RPi5/qUrxJmlqKRbA+Zzm0dxOkbBaxomuRdkVv06ag/ecmWnn8GDhk66bG
 TvbjSb1DQEkqZJkl0JRzbAxR0NS/Mk7s62sPBNXyn/6SLT2SwwzrGNVY4BOei9wZX/wA6WfD3BR
 5Om+ovKx0xrwYBn9ACWXl2fv8DkrBPY6HHvhfO985EcZAoDA==
X-Received: by 2002:a05:622a:5a8d:b0:50f:bb01:9867 with SMTP id
 d75a77b69052e-51461e6a460mr74664961cf.25.1778116259790; 
 Wed, 06 May 2026 18:10:59 -0700 (PDT)
X-Received: by 2002:a05:622a:5a8d:b0:50f:bb01:9867 with SMTP id
 d75a77b69052e-51461e6a460mr74664661cf.25.1778116259396; 
 Wed, 06 May 2026 18:10:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:44 +0300
Subject: [PATCH v5 5/7] media: iris: don't specify bank_spreading in the
 source code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-5-e9a3aee53c49@oss.qualcomm.com>
References: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
In-Reply-To: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xVQKhBlnz8hXPbwNoQtAmXq/3flzYc2iyG4Mi3MNz1c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aUF7FROeuRR/ksxFtIZQ49QN/N6a+8IkF/d
 c73wr3U0NeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmlAAKCRCLPIo+Aiko
 1XvwB/4l+UjOdCNxWIfry0J6iuUu50dwJCcJTUw3jMhnMlKdt296zh+0eJWfXDCwIMHFzuUjrC7
 oj4iBSmob0UMxpKefeEH2H4Zlmc9VN5LK1lQPmnxcfInL4F6YGuqI1qzPAP6kWTpge0Z7F5RnLl
 F513ockCRmt+gSCZa28UOdPS2aoCQGMxKfl5usnxEQnC8DWOH5YY4/h0KFAOhepZUKgcXIgi8Ro
 C9KWxIsS5ltN+enFnjaQ7BDX9t+wzhauhlOHGC7Y/AJRb0122/9q5ChLPGTsw2a7PFVy49YHgCr
 hVmFynEbrI1m3tVxak70fmTu4GbH96S3mNzVGMyE0G0dd7L7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Lc8MLDfi c=1 sm=1 tr=0 ts=69fbe6a5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=fFUJnxvTdpzArna8SyMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfX5lfhUePozbE/
 kLwcZdN6Yb8Hfk4clhd9OiO2zJHQe7WzSITluFHKlO01yjHp2XMVYE5BF4JMyp0r7Y1qrK0GcMO
 pJXfTxqSvKD+89rsuuHKAGOOX/ErjCCsbTxt2CvOeVmCLxYneVUuAM06wTjr0a/YAiQOvESCrZj
 HmkJxirncsiqz43jlRyHmCL6K6GWPGexiz7SF5K6qx/lJTiR575mpK+Bw7SDwIc3OESktoAfyEn
 vdWzZn9PfJ6NVY2Bw6Uh3HAatAcyqbpYJWRw6S8qmVesXbgYnGCZZfoba/xVlSGBfv667j815vb
 ZS4bbB5Dz8XgNs7ZMxqknu7ZRle6Xn5tvH1gNVMcM7hgp39T+jZaodBqkEGMLdO+NjO/ShrsLcN
 WInxweK9W3wZMcqUjVgTKH1tgUHjyC5np13k6yxugyUU+6BPBpNck5HzNglSFI7WKsHxBBYYAHF
 FjLoW4n7ABTXrj7C9Xg==
X-Proofpoint-ORIG-GUID: o11DduXGRJARIlFIyUFjdygxFlHoL06z
X-Proofpoint-GUID: o11DduXGRJARIlFIyUFjdygxFlHoL06z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070009
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

The UBWC bank spreading is specified both in the Iris driver and in the
platform UBWC config. Use the platform UBWC configuration instead of
specifying it directly in the source.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c | 2 +-
 drivers/media/platform/qcom/iris/iris_platform_common.h | 1 -
 drivers/media/platform/qcom/iris/iris_platform_gen2.c   | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
index a4d9efdbb43b..a49394b92768 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
@@ -200,7 +200,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->bank_spreading;
+	payload = qcom_ubwc_bank_spread(ubwc);
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_BANK_SPREADING,
 				    HFI_HOST_FLAGS_NONE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index e217f15ef028..07c58cf3a14a 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -77,7 +77,6 @@ struct tz_cp_config {
 
 struct ubwc_config_data {
 	u32	max_channels;
-	u32	bank_spreading;
 };
 
 struct platform_inst_caps {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 8072f430bd26..4e617176dee4 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -792,7 +792,6 @@ static const char * const sm8550_opp_clk_table[] = {
 
 static struct ubwc_config_data ubwc_config_sm8550 = {
 	.max_channels = 8,
-	.bank_spreading = 1,
 };
 
 static const struct tz_cp_config tz_cp_config_sm8550[] = {

-- 
2.47.3

