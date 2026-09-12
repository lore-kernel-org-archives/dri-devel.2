Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E007C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D2210E707;
	Sat, 12 Sep 2026 12:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZknuKtR6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3L3pRKL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624E410E710
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:43 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdYLY3457035
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IEuzA9pB4S2eUTwXiX8Bjz5BCBCQiMvGw2tVZpbC1TA=; b=ZknuKtR6i/4nrvbK
 9NIya6V+mqtIOrstzAc9YPZ+6esoETiQ/zRqT6wPKJHjq4JfiXPy+IvYmQTqKucS
 W89fpaNUokX84kWOXHZKLBvMnlH+5YpLm/JBuP/XrEcjGq1+Zl7voG1W76f9CKvm
 67mWK33/tYmskzLU7Ah5e6cEfl50OHuEd0GZ/uCeO7M1ayi9WyGTaAvosaWdmKfM
 jS6DRO0tJMSbXjaFFTjRryBAT23L8CLYedVG4rfsyEqeZLCcaSx2YDSYKjnIR9Hh
 ovkkoJsLjm9IWqxNroTmhJ1FuOrnEFrRA0so7p8T0Epioa01C5wvW/jy4CZ4OzxP
 7XlL6g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgxvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:42 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e9e1dd7fbso1334532241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217321; x=1789822121;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IEuzA9pB4S2eUTwXiX8Bjz5BCBCQiMvGw2tVZpbC1TA=;
 b=S3L3pRKL8vMOIAlswesNY2WSTFnpZwduW00bHV4djGqv1qr1VPJUoyBuCYK9B/+Zrz
 t8rhqBypUr0wBjNHWelOjpT7qmkf5Y0o99H1j5Vo0IFzT2POvYyJvE1oZlq8LwQFoSOq
 CfcAfxgFUoqK+3V/4T/izj/lwkDOGTlH9MrleFl7wy4RHCYR16s4WW6oHAgPFb882Gsb
 E/XtsLyRNe6AV2wEEoUcCkrna5uZQdXg757eqed2wXFM/VZFmTGUuu90Z7QahW43aiEo
 9NRHCOg+uk22um4GhjM5fqCjA+43ayv5ulnupngJl5qEpkm698eUGO4jhzHA0wuWx4Qk
 Z1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217321; x=1789822121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IEuzA9pB4S2eUTwXiX8Bjz5BCBCQiMvGw2tVZpbC1TA=;
 b=ABfMsio0bkGo2inhchQ9T/8tkb5jNp8w/NfBkywVdAZ1cfaQWsl4UoFNWkchE+oa05
 a/9yXLd13eyDHlUruXlqvf8rUgmM+3wbrrgRJwLjSLL9MqwsxvVPODkx7Jjo8Bdtjfbo
 Vu7liLXbaQrjjYMKliqYn7ecd8eUj1itsG5m+kUJbCvxhBz3Muklj5Pp1OX0r8BUamN4
 +jjrQX+uHMAQ7XvndPr3lPyCsEQz82VRSW7dfWqabETaZqQXcns1+F2Nc5usx0+4VzGG
 TSAeD8O5LRmIgdFWHOezCq6r/gcGMAn0HfYoS3rV6K8B+o2UqIAWcxWLdf6VESRr1Rh/
 +sLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhY23xr/v3SGCocV7gawyEiYSItaX0ST/q4DVBE/9HQX8SxhvnIzC36HlE6rxK9eNqzIr9PgsQCiA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktgtFNLYQFpIMN+iTIoDKe1X3nRDBbOc6ftJXWrZGayhHkT+2f
 6fkOdKtNts78jwQquIvQtPMiVb8JQC1rAYjzajvJP53ISBkgx8gJ/Y2//XxfSlcldL3dfHIdGi9
 pghakM44MH4hEvGJADzqyE359tRHnhg3kVIx1bJGADIosIftO4pMdj3L82YFsI0Rv41u7DpU=
X-Gm-Gg: AYBFou22+GbD9XCid52dd8atv3xWWfAfT6IQpksbw577xrFkqEmimuv2a/cSMhsdOmx
 AOMN1UMNc+ijNAdKI9XXwRgO44qzX6rtGQ/Y+sIVCJ07m97E8izv8Oo1jR8i+5U2c+WQT7goyAg
 Og05R4W6CegduAGvPyMiz39cE2zkLlRqH3uMdmRp9RmPIa7G1iF9VFx9zYrVZd98bKlkZKgP/Vc
 oYfYMSmEeVx5O5n4gbW6xJA/BOFtlYQQ+CrsJTroaP5Ht16/JpgSA9Ad6tAP0ZzrmcudM965cFI
 wj6oSmUExq6LEoH5uNbVvvPAFtoHFcHa45lW+ypbnZVkQalkcnZmO/D6swyK/S4U/nVL45MGiCN
 +fJ1LmsA+y+wtrwWyZ+V+vIqf2OrnriAI6j8u2LL6KE2adh5bPA3Kyh0OHdf0MIIxZdftN20v/H
 ejlbjdJnW9Z//l
X-Received: by 2002:a05:6102:54a9:b0:795:250:3c42 with SMTP id
 ada2fe7eead31-795a8bea5e5mr1997517137.7.1789217316580; 
 Sat, 12 Sep 2026 05:48:36 -0700 (PDT)
X-Received: by 2002:a05:6102:54a9:b0:795:250:3c42 with SMTP id
 ada2fe7eead31-795a8bea5e5mr1997509137.7.1789217316175; 
 Sat, 12 Sep 2026 05:48:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:26 +0300
Subject: [PATCH v3 6/8] drm/msm/dpu: clear the DSC blocks left by a
 previous reservation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-6-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ydrl/MgzzNOlJycAh3i4QDmPVM+vAZ0hud8oX8EvOlc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoXgnJYN/kKDWpHG1TLEUOdQfhtozvgIXpoD
 l9LOViy30KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFwAKCRCLPIo+Aiko
 1Xv4B/97dO92AC+MIGjcuHd/Vc+xoy1iFZgIql4yrfbhPFUNIX/qU5YnuaHVuv9hStw5j8UXlcF
 7UW6++IyemaoB3IJU8DM6JmfUv1f9JuhmeAKQCvtvW9gMcwnJEvXicAFar17RAAwKG+hTXVGAIq
 U044v8iRoZxlq3UCcExXeTgzeK1HJQbvP8il/BrSXPyFqNIJDzNifDPAbW1nwB2jN+hD+CIqrrt
 +qCyqbXIkPIoAsodw1lIYY6SVP23OuPTALStBF2BfadMGuA3zWS4cYUqLZqJyQE0PMaDv/yB8jh
 aJ9mjpxFvi2hu+Pb33D2w5/1z/DCtKoX0F5VqKRwJridxzAi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: MMDGNj9fkCGty2jHEE9CKjuqvbBYlYA6
X-Proofpoint-ORIG-GUID: MMDGNj9fkCGty2jHEE9CKjuqvbBYlYA6
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa54a2a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mN6KdvlfDCua2x_U6QQA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX7O+QlRf2ynKX
 npX55MM9eiYeza0hc11z3BBLeL36qJHsjEz/S7zi2JTbhRVgSI3zZX8CjPQbPujZ3LCSOvO4g86
 OEhwE8IoMR5pMCVg7hITjhODQvVZU7E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX6eMiVUG1NMT5
 gXqvZKo6deD3rU1IRbcd1SgVlHhUHXGoy7GDEra1WKWDYVUBYOr8R9eufU2r8jryj9vhOmPTwxZ
 xlvnTBXLH10QM//bNuj1z3oF1wzDAG6QEf73CokbZ2e0utNLjAJo19tv2OXmPGtwxpBiw72yDTS
 KT5u8Yqjjqg1ZUmeu2sdGUpu0IgiQ6dn37wTqbO0FSmHU1u60vPJTCXbWJ3GVOqxCPffn8i/A2K
 +NnhOxnN7gKnGGoOMDiNYiyJWQusr56dh+0Ouo85TqBl76kmfnVV1rA4lA3OJ9OZsRPMS0zUmfg
 1tVY9khj5UsY9BlvbbKfwY2DAvxuEFErKGsjBEE74sGBLIgDKyC+FguGm0x6H6Tve11+tZy/qrA
 /ipvdnr8zkthuxMz8N/R3XcDpg9dwTKHzqxRas3gCA+5EsPF4HNBtiOkrfmOPqms2wvDbuuu07H
 BHE2ba5j6kVaP64gw1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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

dpu_encoder_virt_atomic_mode_set() fills dpu_enc->hw_dsc[] with the DSC
blocks of the new reservation, but only the first num_dsc entries.  The
array is never cleared, so an encoder which once drove two DSC blocks
keeps pointing at the second one after it has been given a topology with
a single DSC.

dpu_encoder_use_dsc_merge() counts the non-NULL entries of the whole
array and compares them against the number of interfaces, so the leftover
pointer makes it report DSC merge for a topology which has none, and
dpu_encoder_prep_dsc() then programs DSC_MODE_MULTIPLEX into the only DSC
block that is really used.

Assign NULL when the new reservation has no block for the slot.

Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..50c49259a23e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1222,9 +1222,10 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	num_dsc = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 						drm_enc->crtc, DPU_HW_BLK_DSC,
 						hw_dsc, ARRAY_SIZE(hw_dsc));
-	for (i = 0; i < num_dsc; i++) {
-		dpu_enc->hw_dsc[i] = to_dpu_hw_dsc(hw_dsc[i]);
-		dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
+	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+		dpu_enc->hw_dsc[i] = i < num_dsc ? to_dpu_hw_dsc(hw_dsc[i]) : NULL;
+		if (dpu_enc->hw_dsc[i])
+			dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
 	}
 
 	dpu_enc->dsc_mask = dsc_mask;

-- 
2.47.3

