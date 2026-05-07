Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3105DCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8505D10EF16;
	Thu,  7 May 2026 01:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R47gjx3N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SEzIftXX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E91810EF16
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:11:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646HrX8S2581386
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /qBXAspLOui/eBATBY+xFXnkG3ex3UdKwBiljLWkZ0s=; b=R47gjx3NyZWvQVxM
 nIkpo3qtaZhNYaiPb5dGRfj1/JILarNgcXPqz+1UGW/NWV7GTZ3Kqm0GSoUZdKCF
 MBE9U0vjb27jEiI/49WP19JuySFF3B47XDhmeJZmQlOc2Nxm0k3AP4cHBcc+1j/G
 AlWWAKEek95+nx61atTXI57De3HMAg1FkAjjT5GK8DfN7kU8iqcQJhbw2gUPgay8
 2wV782VtmLtlel9nO6DnGWGQ/YnGBAZnwL2Jh2fB5IVvG+1Eeqfa1/9P7tJc9aWq
 FBfCTOxN509FcC2eyVqDLe6jt/8i6BiH48kFT/nYMdTgDXPutUHM33xeOo3EDD0G
 gSbZ+Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw402n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:11:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50df4c130dbso12267531cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116263; x=1778721063;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/qBXAspLOui/eBATBY+xFXnkG3ex3UdKwBiljLWkZ0s=;
 b=SEzIftXX1QTZzo8sQisNqrWjwiwlhBb5Vhooo/uGulBx/UBWFfMUF2hyrvZ0tXJOvK
 1bimMznGRXyJvXLpo0eCZzRoXC+BKv9woFJij2K13wN6Am5bEBIC8eK+PtIw1Gb/XTT9
 eBF7pOdmn6iA7ZpmJwPykvbRhKJSnfkhi0DkNlUwdm/caAPhvR0bdt/q9KLt432DMHEg
 D4789aWqAUepS0qaUbGmx6bvTVUEdE1ghvjMUUB/5os/H/eLc+tEfor9FQsytEaZ/c73
 cGgEz8HN40G3nNxHAnVrxfKyKm9jiNdC0djqJBvOQvp5Rj2BvPUmY1q1sndCbbCiTdqg
 IO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116263; x=1778721063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/qBXAspLOui/eBATBY+xFXnkG3ex3UdKwBiljLWkZ0s=;
 b=eht6r8ufbYH1Oj6YqOSVkOXR0DIeidIsVCJuNLwtMboBFIrIjzypZEfgT+gI5Co1U3
 h+jYlt6rquDs2sVPgso6b5Cn6aOoHSQOMznPVY5ZHhia6Rr825A1plLSXqg6PDBW4wMg
 Mtgne1afG5EaA9Nl8HmrQmprTbWwUImV6Jr8BRuFL07I/gmlBXlXmn/ey8mPwSAMmB0r
 u4Y/CNO+Vhru9yc7EgYM2l87YSj3ZWqc8TlZqvjftv3SsgHEXRmd4NjU2AY3HSvDmH0k
 BejD3rk8J01zVrjzYpB1/MadlhJHlxj72kxT/hKcrGf8IQiKJo0KiU1dMOx2LdFyIwgA
 e4QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6bCSxy0KPHFqPQuRDRgFHzA6AMBffzH24gmWgyxkM4qbhrrk/+snfxsRVm/HCwYz9QZ/NXB6+knw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqxs0017Yz/6Hyf0YL4LSfMBZRgOxJGjgrVYqCsx4pAJklVszk
 y5FkFTDtlc1E9/2QouFFAUH+XV9LFVqVWAwZC6HpRIu7P4xNwR0+CBP0FcrKvmvYj6pl3F+eVD8
 8MEirNj6fsHMt6XgseMlSLh3FO37LPGMBTX8bMnCm2dp4LjZdVg/L3eFRgXs/IFDmUYarkxE=
X-Gm-Gg: AeBDiev22xCnsvALd3vgT/NdLLmI1vo+uqo9UMz3VcLKHyiyTB1ucjoFjxy9Vswt3nH
 s6jwZr8PTnEHM6xLyp/J5rXyQW/0lbxUDgCHKmCoAGWl59G9qrdiO0e6ETOUZ2LoKtvq/DlD0yF
 6i134yKov728Q0Svz35hlYPJCnmEpCcmWeTDL/QYWuI+nO1I5/syShYb1JYan5+JFgqFHGoLrVo
 1Cg+PKovwbjvhPcbvmr8apA+GzYIyQjc/WKFyiRPOGgErtcs6O23LlPG5513JvJb7V66wCNVQTC
 SflkIIG2WcUZlDnlETG0e0BWquBOC5G8wlHpLM3TQ5eTDv+qSK0hvisLF1HOAT43gWffsku+t0z
 ztW3eO1eCFdpwTbFf8iWjG/Ae5XFUMzlcRO0ssu35YHYJ9TFIbMO5WnfvQ55OVqHStbG4cNMsO0
 35mxgPnhjweJlul1TaYh4gbqZ8m/CIkPXarmEhLOYAqklBkQ==
X-Received: by 2002:a05:622a:447:b0:50f:b427:7525 with SMTP id
 d75a77b69052e-51475cbe32amr12181371cf.42.1778116262937; 
 Wed, 06 May 2026 18:11:02 -0700 (PDT)
X-Received: by 2002:a05:622a:447:b0:50f:b427:7525 with SMTP id
 d75a77b69052e-51475cbe32amr12181081cf.42.1778116262505; 
 Wed, 06 May 2026 18:11:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:45 +0300
Subject: [PATCH v5 6/7] media: iris: don't specify max_channels in the
 source code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-6-e9a3aee53c49@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zii42vc933kIDeIsFaUR4oAw5uqkZPXC/RIXb2eV3yc=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+bvZ1PsTt248ugI6/Y3GrUOom+jFvt3SHDXBn83fbeJ4
 2uQ57P9nYzGLAyMXAyyYoosPgUtU2M2JYd92DG1HmYQKxPIFAYuTgGYSFYmB0NDWKthvWuYf1JG
 W82bKVWb87ULpkRMSVYxmL/l5J2sijlqHwT8OWK+/sj/Za+44/t29887rySzG4pccHX+EyK065z
 N6cQAScmaZpnZbtHMt/46aE7erD3TVOCo0Vnm/ukzbU54X1XIKPjK+k3dk5d5uRJ72JUqsdb5iT
 NyuzSXsXy4+W979rfQI/Mlri7iyFO0U1EtsDX7MP9D/LMnO17ISJpbS3MpL/9zNVCFKddq8SEdN
 lkh4Y6m5B/J145/j3+e9k/0/UkLe33tLnb2d9lpf8+6SkqxRuvc+7FDaIn1QqXo/wXVegLyrada
 37gx+Av76f3yk/2olbtu+QL3eTO0lial/+AwUuS2U2gCAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fbe6a7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=rTy9geyXzX0TkIcb0cAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfXwABKOEk1EGbF
 V5L1qTUdgByeef+JYt0ZLwVm+dpoGVmdlQK/w1coI7gfFU4f3mbh8phudQEIW9xxsgHssbuXi3e
 bSO9139xjmMhr2Sm/RKUvKBfY40hvbFSPRBWuSEa4cnJ7A+Pmvkf/bfDqIL2j7lHkXSFJEwUXxf
 BbRoCobKr47xD1xLPvKxyQ/w320HgRS5PDrYi2hkJWl4ydQi8zAN7n5TYtFiti7z95leT7QS87z
 /WkteTwwZzwTqtAMF2p9+sdGYvkdBbhCyRExjV76g1whpP+JDEHbFlSIJX4dOSmlQFklJmjicVA
 O+YLvDbKQlB9jVprnZt+S4uXMU7pL22zVrNMjw8uU4jZFJACP7J4iv8mzOcq4940YEaOhuSq0FP
 N/dXfN5vLilvKH6x5jJplPBPW9JUQixSYOU3yMy6xNbl+HgmbJH8Bb2F7WY5h8btg0EQ/ki6RfV
 EIT4rO4Kl6jAqBSjYmw==
X-Proofpoint-ORIG-GUID: JozIJ90dpaSBWCPkMwo-a2Q11ExHCPMq
X-Proofpoint-GUID: JozIJ90dpaSBWCPkMwo-a2Q11ExHCPMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070009
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

The UBWC max_channels spreading is specified in the Iris driver, but it
also can be calculated from the platform UBWC config. Use the platform
UBWC configuration instead of specifying it directly in the source.

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
index a49394b92768..0d05dd2afc07 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
@@ -140,7 +140,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->max_channels;
+	payload = qcom_ubwc_macrotile_mode(ubwc) ? 8 : 4;
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_MAX_CHANNELS,
 				    HFI_HOST_FLAGS_NONE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 07c58cf3a14a..e8b5446dce76 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -76,7 +76,6 @@ struct tz_cp_config {
 };
 
 struct ubwc_config_data {
-	u32	max_channels;
 };
 
 struct platform_inst_caps {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 4e617176dee4..05b1dd11abce 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -791,7 +791,6 @@ static const char * const sm8550_opp_clk_table[] = {
 };
 
 static struct ubwc_config_data ubwc_config_sm8550 = {
-	.max_channels = 8,
 };
 
 static const struct tz_cp_config tz_cp_config_sm8550[] = {

-- 
2.47.3

