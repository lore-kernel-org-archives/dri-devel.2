Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76ACD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895A710F117;
	Thu,  7 May 2026 13:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZG+WGyRq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htJVHkOC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758B510F114
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AC8Ox879575
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HGml7biXVVWjOOR6Y1Gdb7Ld32RnBgrsNfRj6o0i/eM=; b=ZG+WGyRqHDvOsl96
 oAjPaXEzqoZrWjrQ7lUrLNR1vY2jdt/gUHiYAEadYdgJVY+6QUb+YwL28jIt0cAv
 BZuv6bqXUhPBtmMKQGY9mqhO0S8RT58N6jL6V1wx3CjKieCO2nv+qqRVjrp9RcRA
 732AaqfsT9iRFvMKV8EdyWESJVrAanxURFgFs8iudMsj5Kcmi8JR/b1Kum8kQjyG
 egWR08CE/gEcbDr38PpKMcvkvHtDTf6YUo8EFvvlYgx29/xKj5xGU7JIauWp4+mO
 zW0vizXlc+U5BTVCkh9dY9uc3AeSeVaj9h2+5Xi+Q2kQ7oPvPWMHzLBQA/urT1l4
 IWB8xA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1veq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba6ca20ceeso9497245ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159054; x=1778763854;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HGml7biXVVWjOOR6Y1Gdb7Ld32RnBgrsNfRj6o0i/eM=;
 b=htJVHkOCjlMQBvTOMY40RbXDaIUhX4gWAlupgozaQ5fsPwKv6QHGp0EA3e26QqRFKU
 K61wrk9LBGSW8nfWpcqOAqH3hvwr9RfnBtlOr991JSvwQp5FmOQpVcPDiY5oZcrFuwi5
 uo5Y2+eUldoMDQiwWzvDjE1XGFSxZE7xOfpVC4yse7J7UHRzlBlkcb3Me78VGqhTDfbQ
 ZAUQiHPwqnEPiGS8hHzJBq2l4vCyGRMYYwVaFAeOtEO1Z1QOXm2cpAXnYKT/Y24s6dNa
 eCduLJIFNKfjdjPjau6X0fX2IcWwmbUOhV2zQNwjYjtGQTn4aStg9AkyTjatzNWXTG6p
 g66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159054; x=1778763854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HGml7biXVVWjOOR6Y1Gdb7Ld32RnBgrsNfRj6o0i/eM=;
 b=IkJNEIAcIrdruSsiUvbprpKHO2ae/gGFimggADABWkB+VKkUtbc1r7oFjQB/hqOVRR
 E3Ne+3I+TsBE+3+BItV8ZL3J50ukuDuKLHOVlb64OcmXP9C+PR0MX3q6ibd7Bp7Iac4e
 iZevws+LAvwURinExFHHK2I00tH7WiCxxKTyQkYPyn93IdfISntYdQTJ5V+g0W9oliqy
 YHYIkPk8Uh3UJtKc6be0dO4o6nZ5sQasX1In/CEe05M7x7Uu1VxipC2GU9xbb6ex6ERY
 eGz7xMC+CQ43Momw1ajScSKpxo8GRkzZFj397FCWt6MP77BH3IHZgZmV1++SK2bY9Ty0
 LWHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yBkW6/NSRG6wR1pEAF7efPgjhzsT6p71h/jhnf0K5XenN2j2bvbahQ71zMDVQ/oQNoOa1zVsvyb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMG9NO8vJwnrktr2NL6xHq6BaBW/RREcJ5lPssvTPM4//3ttmv
 GmVIOyiZPknXntrflghL1B0Osbw1VX2nQDp+8LxMuIkzczff+GGWtWF4KrH2dDxBPfej2DzFcLd
 QTZlXASNpMGq/ZbptniVGtlqBIHFe7JNP1ecaDrYy+x8Yw7FE8Vmov3aHTMlOx9jL+rhfTys=
X-Gm-Gg: AeBDievSaRucMV8IXxKGp9SQ1RTMfKul4IbMH6GtInUtxLgPYcro7quoQQy/4fkcETd
 cTwivtfeQmEsKliLw1APnNrWBi0jEp/nUJejkp3F9DDNRctDGH9Zli3kVf64eUVbcnKxwrZKr95
 0iGeTLKpJk2ADYc14qNvh4NZ4uYewMWD3app7mrANruYWXnox3buDcJISiqPXR0btqnd0000Pyj
 VGExxVwGOj51xWwbBmhZ+1JqTNeqoy+Iym8Pa0y5Z9GJNnU0iSTczrRtqh24AVE3hSnijHIZfj/
 0gpHoks3bToFGwz1sKuuv1QPS7IsmKCttkGpaMevBZyjETniiggDGktEW7fXx0KsItD19tXiY/y
 gXm3GhlEr416KZgS4vVXcmNWlK+u3vtcgEv5mks1l6wWn3Mcu319Qq9HxILqRSPw65p42UN2YoB
 0lk7g7N2l4SwUPWfkJegHORCX4Kr9npQxmsc80NiKL4ueZIw==
X-Received: by 2002:a17:902:db12:b0:2b4:5cea:f619 with SMTP id
 d9443c01a7336-2ba79c10b84mr86598415ad.22.1778159054202; 
 Thu, 07 May 2026 06:04:14 -0700 (PDT)
X-Received: by 2002:a17:902:db12:b0:2b4:5cea:f619 with SMTP id
 d9443c01a7336-2ba79c10b84mr86597625ad.22.1778159053511; 
 Thu, 07 May 2026 06:04:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:19 +0300
Subject: [PATCH v4 23/29] soc: qcom: ubwc: set min_acc length to 64 for all
 UBWC 1.0 targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-23-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Nxn0ECja9MOevPIO6hY4R3LL49hKUqZQoSFEB/QFA80=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2HBa1QLkqifwL/HBfz5x5nw7s2kRgdvsGq/
 Fnr28Pz042JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhwAKCRCLPIo+Aiko
 1XqyB/9dxAVdmuGnKS9oEtRY58nIh2ICpjHSxdwoEWDJ8ahzt2MX+4+9PZg1bwDw8VRYOpfJUZf
 8uWOOIJy3XlHhyCrZt47Y9EWT7mGQ641L7+/Byu9drnE6Yca87Mrj2bft4ysOeVSBqSDzuKFeW+
 sFW9KPECm/JGnYNxYXiYvOQlYgG/NzKpAQpnaHSjcAJmL8UEZayqaSHusWAAjdR5oizbRe2y5dm
 MQ8g+knty/WWrjGvdXDMo30W8hQjk91GswrbDfHxRiy92NzlTKYH6L4oZN0x4j/5CUTyb0Qs7Mg
 OJUxhtcRDFP6huwS49k0dX24NYlj5f0EeXkb0R+hifNUGdKA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc8dcf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=5ZsywSmvcCt_NWGkcqUA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FKbOZ0lixjWaDWJ4cySK50Zx6QBNdkV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXx0IOZcbnznys
 kp5RPx0/uKpCfX14GtAFHfZGb7sXvoLZ4yx2M+dsC6icMZtIvhUetCJjm9LVVCGMK42C1T+Pf6Q
 zgAmSR+Hc2NC1XZTan4/KD9iK/Z9/MDGW3AI7l1VmEnbfZStKtAEIb03svVGFYjKLiDP+lbHq9D
 prNH6vxjolleP15FXsuPh3j758qX4WKrPpE5tbZLcuufj40IUslmke81D9+FqPvOv2dC+xUnlH6
 fqx21zDE+VglrXs228zEnoWFYAGXxshmNOXJ3IiBZ3uclObGrLT7pxXys/CazzNgq3CZX7wMvpw
 KQbf40DgIilyNIInHM7upsV/2K5L/JPE7TwYtmKVJ3RVmlYbl0EjKQP5hPh6r4Cf3hfv+xJdnz3
 6B1SXiUixJVhrczJx6/BQiC8BkiDMAkpYha0HV3swelUZrlrD+fsdS2tZbnWnbwllt5fiH6ytwK
 syYqmNG8bhdyo2RXupg==
X-Proofpoint-GUID: FKbOZ0lixjWaDWJ4cySK50Zx6QBNdkV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070130
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

According to the documentation, the MAL should be set for all UBWC 1.0
targets, no matter what is the version of the UBWC decoders are present
on the device. The helper comes from DPU / GPU world, where there was no
separate bit to control MAL before UBWC 2.0. As the helper is now being
used by other drivers too, correct the helper to return the correct MAL
value (Iris doesn't support UBWC 1.0 devices for now, so there is no
changes of the behaviour).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 83d2c2a7116c..0b5aa9d0343b 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -75,14 +75,9 @@ static inline bool qcom_ubwc_get_ubwc_mode(const struct qcom_ubwc_cfg_data *cfg)
 	return ret;
 }
 
-/*
- * This is the best guess, based on the MDSS driver, which worked so far.
- */
 static inline bool qcom_ubwc_min_acc_length_64b(const struct qcom_ubwc_cfg_data *cfg)
 {
-	return cfg->ubwc_enc_version == UBWC_1_0 &&
-		(cfg->ubwc_dec_version == UBWC_2_0 ||
-		 cfg->ubwc_dec_version == UBWC_3_0);
+	return cfg->ubwc_enc_version == UBWC_1_0;
 }
 
 static inline bool qcom_ubwc_macrotile_mode(const struct qcom_ubwc_cfg_data *cfg)

-- 
2.47.3

