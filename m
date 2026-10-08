Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED2CCA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056BE10FA9A;
	Thu,  8 Oct 2026 17:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NC3A8YCy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A80iWVkl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6596C10FA9A
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:24:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVhNk2124112
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 17:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v9gMdQZVtWrLDREFa3RZVdqt7+njT5mKnVjO2LPMX90=; b=NC3A8YCyLUwbUwI4
 OTYH/fYsZPPA4IeWRF2Fvy6yVjVw/SARYGnqWItooJ0QN105ZZScruekYx995NCY
 uzQ7u8j5yFBaeTd/YyHTwTko1KtQkqjgoo1djga6VPf4VYtM+EyoZXq33Bcm8T7K
 sfLU3ElgJTClEZkXgUo/sOReyqusrGYIB5TkOatxAQHVbiVEimRBrW+YumK1aqqb
 +z/5wJpEeTez1xZ2mg6jXX5WL1jd3RVxI9WqUEZLFQj+6zrfhaX7qZS0sgfDfbS1
 nHShDDVhECkJoMHAf6uAumllL6G1UdkF4PVbYD/+elQ4gNPfR4T3mwXau19YwWSQ
 BEJbrg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3bxws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:24:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so1737599a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791480266; x=1792085066;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v9gMdQZVtWrLDREFa3RZVdqt7+njT5mKnVjO2LPMX90=;
 b=A80iWVkl8SosL4JKKzTg5Zzs42sDk0YtHnMoAMITaEdzCTCdWWblT+eF6Gg6yw8mX0
 criATZF0ttj9Q57gSFKk/7qEG4c5LQQUsWHd78vqakQFamBZ6Ye8KLncPEFwqPUs98bM
 ZjNKfP/LIMmicv6jAcudxBPNgltwatYvZmrix7HF9FkiyCe+6mwlBiJ9XpVnXfy/8U2H
 VTygCdf1UwknFdY7EFdqyQyQQB3manFMA2Ymn7UTlqV04Qhi6aV/9kIq8mUPtkYXDIL2
 L+XHwSPk3c48C9Oxx2PEyod4Xs3Absk8NmSTRbrAeI2IsHm2ym2f0HAo39ZmXjPhIDse
 A1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480266; x=1792085066;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v9gMdQZVtWrLDREFa3RZVdqt7+njT5mKnVjO2LPMX90=;
 b=fp/LLWxClzJMtMB+YIcfrCV4K4ti5V3NsI4+foxdkMb3a+39wIB1/ZYN1ZJusoHFnK
 UuCH0noZYIl7uhRwp8s+RuM7/RlFPR/+oKHxW5EGgHWT16xiiwKVaNRhz6FSrfQKXuXE
 MDC8bhgAig0jjCS0ymCZ4ffToyJ16iU/YB47L4x9ksoYiiBy6eeDmTaJ8TFr4zx6d5zf
 G7rJW9e/YfGhgykBeWQbElW19k3j7vjzob/QpmQzfcmsr/XQ03odzk9xJ/MC44Mjj32p
 T5WwtVG6zZH6s9E2e6PE39cRYXAkL2L9HQ5jh+YpYTJbCwbrV9n6uIlk9QGtPYBvaUTr
 UqCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByInY2ztZasg5EpjNkt1w4ceM2H1oi3+cgsH++fgC8/dcYOc6/wBv3I2zGRPkkFVdk9ccVxVBTxpUY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJsh/GgkEvmj294CHJNdTnxU8uviCEYtOmI6tUpLmiC5b2t23j
 1omghhjILwaY4fPkq2joGMjGI4+5RcxR0cvhhQh1u4zmObDeQo1ljZdhEsHQGiykTGWzMoU1c59
 zTjlCzU38zW7JXHz3xWtrPbbmyyhMsH+zijSSS05i1wOv2XTmEHtm+DNWv1Y1MblGalFql9Q=
X-Gm-Gg: AYBFou203kvEmsp8v8BGJK1wRjpelo5vIdpeiZO5xyDKzfl979iKUxSVvLBPhfAzGUU
 aYpcKYvYeby0uEZ5W4zk2MDSJMpue0YgEkpuZa0lUcTiNDabQh0m2+S/+oa1xi00G9/f1YOpMu1
 tmAe2LMqekSDX2quenI9Nd5lbtrd8DUbLiWf6fJJQjOKuhDMHsKVuk4abGrHyhZgGKEfdfWX2cx
 hMW4ZkXKGCorAils4h+NIsxY09iDJlIRlQlzaXjuHNX0LFWG00POdJlYxx6Jh87g0Dcpr85WAZV
 3Y55iNk0UbJGKp7jLjIiwlf1Jc9JKfF/S4H2otEQDyA5XVwmgRlSDlrIiFQ2E9kQT57/9jXiLoA
 0J/eYQfV0fcDRKq4o4YCDClkwJg==
X-Received: by 2002:a17:90b:57ef:b0:3a0:a259:c67d with SMTP id
 98e67ed59e1d1-3a8a0851600mr5697322a91.20.1791480266386; 
 Thu, 08 Oct 2026 10:24:26 -0700 (PDT)
X-Received: by 2002:a17:90b:57ef:b0:3a0:a259:c67d with SMTP id
 98e67ed59e1d1-3a8a0851600mr5697293a91.20.1791480265927; 
 Thu, 08 Oct 2026 10:24:25 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3277c459sm47228a91.16.2026.10.08.10.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 10:24:25 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 22:53:48 +0530
Subject: [PATCH v4 2/6] drm/msm/dpu: do not assume a merged datapath when
 validating mode clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lm_fixes_final-v4-2-fa986071c3c1@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
In-Reply-To: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791480250; l=1410;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=Ci/PS665BjdBcch+dOPxtPE8vGyH3+My6ZiyIbuOWgM=;
 b=z8HH9Ia4oPJR2+l5VABIXCPrBwXDiAx5379BwT+dX7sr3efswNq0FhG5+k5B1GBrj9nTfgpZA
 Zb0DkZ0uih9C5ryuP63VX3vpsk9SRJtHT2G1G5I3CznmQO1mnNxbWHt
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-GUID: P_x6KiroQUWZNsDX1qh-WSw9f-j5EbZ2
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac7d1cb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=nDKeDdROtNiGmcSYc70A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX731Uqzr7lixK
 fQOuSHyDxYxbLmgjoE8Xgi9obQ4g3a8EkXczGQ+FYWw0Sbki/z5b2fD6BDjln07P/TENb8aAsZK
 8llmQGJ/mvb6smjl2o/PzUIkXRf7FuQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX3F0MZP/hW1La
 9xCc/R6IyXm3uOUr/cDk+GmbDT4ZhQOilNA6rhn/Y5od4zg60l0y9xvPNJpFaCXqjjyP0Cf6YdT
 7Lki8GmB5Ewjx6XiYAFHOgZIjAk2YkkMEbWO9uXIRKuuqeSk9YV2/K2aZimGwSKvsgWG7WdGE6M
 2G5bAIyopHC3akTkPvZtKLBEKm17P8LEHsx+PfHFPAnIOEEXxE4n+X6E5TqVAGAqCRsr3+H7Poz
 7OmCOBPu2LCr+axgQfyYnVWPL+5TFqJtUJ2YDZSo1Vud6E3duk+03c7H+WWysoiraEirg7/1qx4
 RoPQiT1bKOL9ddKtQ1E8nsgoL9+Vc7AWkLQ92gtUAc/GFISqym2tnlhRMawhe7OJNNRpfeR2D4l
 pGS1BPCDiRk/dc9verg4FDHsu4akjPnUWxvh96C2GplSr/ZI08B1SXS2bldmHsWQScNznbOw7rV
 HBz80TC1VRwPAqtO5vA==
X-Proofpoint-ORIG-GUID: P_x6KiroQUWZNsDX1qh-WSw9f-j5EbZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080069
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

dpu_crtc_mode_valid() halves the adjusted mode clock whenever the
hardware has a 3d_mux block, assuming the mode will be driven by two
layer mixers. Modes no wider than MAX_HDISPLAY_SPLIT are driven by a
single mixer, so for those the check permits twice the pixel rate the
datapath can sustain.

Divide by the mixer count the mode will really be driven by, as reported
by dpu_crtc_num_lm_for_mode(). Split modes still get the halved rate,
single mixer modes are held to what one mixer sustains, and parts
without a 3d_mux divide by one.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 0b51a4c5db57..209b25dbeb6c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1631,8 +1631,7 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 	adjusted_mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
 							    dpu_kms->perf.perf_cfg);
 
-	if (dpu_kms->catalog->caps->has_3d_merge)
-		adjusted_mode_clk /= 2;
+	adjusted_mode_clk /= dpu_crtc_num_lm_for_mode(dpu_kms, mode);
 
 	/*
 	 * The given mode, adjusted for the perf clock factor, should not exceed

-- 
2.34.1

