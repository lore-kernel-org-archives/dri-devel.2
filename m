Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C5D10F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E275210E270;
	Tue, 31 Mar 2026 16:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCRIoa83";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IziWIboF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F4010E1FE
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:12:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VBupUO2164257
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tMix2rwOSw7ExtQ0oKmbLtIuX8OjWbhd9N9
 jr86Gya0=; b=YCRIoa83uwK/Z7mBEXOzZbAEtp7HJTdKu4qZwNYf2cbFNkP4hHl
 3dbsprDEsITZDsCN7nBlQowgH4KHPHQoNfpOVfz/vp0pQSwXO+0fOtRiBt+iMEMJ
 od3zCQTvFG19fF7YoBcg7cR6b/H4ORTqCVd+IGbXzy6IYRe5gCkfdF8+2qbV1o/y
 gYFHgJMBGAWk0CpkKdhA6j6DUQm114TwtceR4SIopw4Sow2AIklEhpvp+1w9gTBP
 W0z9KEcnW6AcnzrcXWdN5i81jM8Rtni3nDaVNcqPMxWsN9Pz6p/iZsoJmB7ClcWh
 MutwvjwvppVT0ObngokJv2NcOdPVGW1Gx6A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d89ga2gcf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:12:11 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-5ffbf6d209aso10608363137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774973530; x=1775578330;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tMix2rwOSw7ExtQ0oKmbLtIuX8OjWbhd9N9jr86Gya0=;
 b=IziWIboFgem/ONbm9UldgT9EJc7C+gcBNRJ8KDBDfRC7PzQTgGw4pMLqZi+iXpJL/W
 74lWySlh3nU/agkibF0/gN2k+lDVO1sYUuMtw0uHBbb4kmSRiiIxPw8RWmlUAre8Em1l
 yO0rw2VkwisSaaUkCqvzM1zOtPSBb0ddkP9n2q66708JiM7ndISMBaj92oUzOLGJDj8W
 xdf7b5kYno3iiGwkkyISq6rTQ1pkrCtST9APKlX+2Eq+Nl/822GCGRE/zfM/STuZ3AFQ
 lXdpigE9+qj72yiOoMZ5J6I29QcR/xntRT2K5C440010yQ7/EDRDalBLGJB+eWjTDEW0
 fToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774973530; x=1775578330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMix2rwOSw7ExtQ0oKmbLtIuX8OjWbhd9N9jr86Gya0=;
 b=MRSZI7rJVk4B70bPUMaCn2PBehgc8dMkD1+oYBZqU3D2fzQXkR423O5GPPGC5JTmAb
 oq2VJsGHaMjjqst4ukrX46X6k3hbD6yQXXCQRWJ3pcSZe/zFyosPudN8NknA8D0ZHSYY
 kOkvNfTqrcSaHJ10a0t7ulOS6206LkqaobjYbkD3P6GmvDcdGsp3lUefg2bshX4KJF74
 ldi0ZQrcmgd+IJSB402/An2uaI3KXdo7T5oezEDGZEiTqxjzhiJlrcxRygQzuP8eXSQy
 p3INK2z6VpSSzBkYjgdQOf/G7xjBNKv827PoZBJIzhu3DbVjBodbuKJE0bCOLayzZUiw
 dBGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD0WhMBZZUXOxc2d/wg/QyvEwX4cXsmOitIy3hvZ9v7Udb48245OB3asYmEtnlrRLKTBa0i+bS0H4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJeeTD3N61FnuxQ8i9wVf1AF6BgTUqKny54xgJ8QXIAJF354W+
 NiPDcd+KW72V6Lj2fmeoxFSW3jC+sNw0YON3+Lhs3RNoLImy/nANMty4LuoT0mZ6wKUvs0NdTm7
 B3LStcokgW2fROR+dPbAAq0YNghkebwJW61c6amRkeyD/YHX7rkrOMaHxAKFoVNl0VcJUYoE=
X-Gm-Gg: ATEYQzye+oaoY41DZEAdfGr1+/hSj9NRP1RyNrZ0LkFJd8gfaZwO6VF/BPnc2NZRIs/
 PTET5z2p/ctYSVcbufBm2KZHe7HWOlySuTMiZxKqwbJ5y4Fg9AJ5RPHy3+1nyBTLL7VpaxxqKoK
 amBR2hJEBKDRywVWcAmMrCNCRVAshdIrpdzi7zDu+wmD5zKFyyYiIHJqiAhAhJlhG8WlRB8tY0z
 gxd1e49YpdnJytkSQh6IBk4i9kVsdoCo0m6gtK/AaDd0IPm8G0mrx09HxsV3g3Qj9MmAqVh6F9u
 gdCNAcojg4JpCR+6VdTt4Tssukxv5NqHPxbRj0Rn/Ul8eI/jtSkSxmCQSc5FX7/NIuhtRcCVSEi
 JDvAW6w4XYzFgMIci66Ym++EuHN5jgQdKgZr0
X-Received: by 2002:a05:6102:509f:b0:5f1:606f:2a14 with SMTP id
 ada2fe7eead31-604f9278af5mr7202459137.23.1774973530303; 
 Tue, 31 Mar 2026 09:12:10 -0700 (PDT)
X-Received: by 2002:a05:6102:509f:b0:5f1:606f:2a14 with SMTP id
 ada2fe7eead31-604f9278af5mr7202444137.23.1774973529852; 
 Tue, 31 Mar 2026 09:12:09 -0700 (PDT)
Received: from quoll ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93c0cfsm51343375e9.9.2026.03.31.09.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 09:12:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: eliza: Use Eliza-specific CWB array
Date: Tue, 31 Mar 2026 18:11:57 +0200
Message-ID: <20260331161156.211623-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=JgLPhw+ArucftIYa8makGu0FHnbrtt1zKZEQThMpFAc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpy/JNfDb5vpHJa7e04BJqZwv1y0MCREY9SF6L2
 5AcMKHVAdeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacvyTQAKCRDBN2bmhouD
 1/V9EACVgeoymDxslEnaYbRxKhzwaiax9UqfQiPmrou41/ed+x88LFuiKH7JmXST9IHALCbEIHg
 dVw6429iAs6txtzxEDzJ2ofK8JkOA85/o9FCJQeZ9BVjohbSrcKCcJwLtvRHjexWu5vCquSFkxt
 FfNAGIps7v9Fcnpu9/fx67du4qumcLZrSF80mcFsQ0y81lhNRq/5kHGTF1zdjwv0vwF+tYvNadY
 Hm5Kz4kp0VB4VRAH9QkSqKj60kTip9HM7zYRbiGIgvbJIEjegdkb7CltoNqBFM6avx1UetFAhit
 dZe4z9fSgdIM37BWktWsqNIebvK0qnggQxfzBY0imYOc5vgDL8ZNfs5ilo4RqNPVGwbiGX3EalW
 LT+Umo04OcOwachTELizrTdhObC7dAz23UXaZUClvvhDkIdqDJDw/EVhU1vAbkOwHreVee312Uq
 S2tcC/CshMjNcuAGmq1TrC81+ckMwW0jdAlZXLiTwDWuatKPKbtTbcCvP1MULozQLw9TAgKbvK7
 9m2hLpefnc5d2RNRhmNQcC1I2lsr27JHhZ6VL8//hf73I7KcqyEjJ30y+1pqLBivJ0G+qXhdK77
 ONIjDgg99e+VnS+QkUKNvZXgtdXWfuIr8+B6zja6dw4Ho9ASWXuyQtRcO9gF19vmOzup762Nusb
 VTRvgZsdf7HJSZg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KJpXzVFo c=1 sm=1 tr=0 ts=69cbf25b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=dRBQDy9s09Ah_ACL4fkA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: kIBmH9wdSVobD8AZ0fz-DtAzBPniu6ky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX9n4NrvMQhyl4
 0hmRHwwYsMiOmxmQnxiNr/UiJJU7Ko2uCSKVjEDR1loY8z6iygK7UV6/w6cWDYvqhkbuXVR8Avw
 1AtV3Co6LVYpWXWHPNSKG5hlrJ95J+YKAoeAwb27L80Z3YPdBOrFsI+bn21lQJjvFbgwyC5P0E5
 hfdfJY98K0cj2GiAu3NvafsozbS4sIFdb15k22rgzK8Wxj3eXyV2038e1yCuandpwpxV0szNfTP
 4ml4F12kdNtmWYNf7s5bUcn7+Br6cux/vSPSBAssRiSf8kN3Sa4qCnDvoJ01Vy79oauVobeVA+p
 QXoM++SJwQFduPwIYtwGgjAX4Kkpx6lv5NetQxVCS3oua4D4TcPhuxZ+unEE5E3jK+j2qJoz2z5
 j2ymFy2Q/fdj6x65PVudhJuvATOqXRkGKALLZOTX6AWaZFV/LAOdmlYqxi1QC/xLauMZAGBLaf/
 MmSVjfCreBhpDXqCKKA==
X-Proofpoint-ORIG-GUID: kIBmH9wdSVobD8AZ0fz-DtAzBPniu6ky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310154
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

The driver references CWB array from SM8650, but should use the Eliza
specific, which has different register space sizes.  This should not
have noticeable impact on function but is indeed confusing, since the
Eliza table is used for .cwb_count.

Fixes: 0eb707bbc7fc ("drm/msm/dpu: Add support for Eliza SoC")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Fix for a patch in next.
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
index b482a7e4e6c0..b93d32888972 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
@@ -353,7 +353,7 @@ const struct dpu_mdss_cfg dpu_eliza_cfg = {
 	.wb_count = ARRAY_SIZE(eliza_wb),
 	.wb = eliza_wb,
 	.cwb_count = ARRAY_SIZE(eliza_cwb),
-	.cwb = sm8650_cwb,
+	.cwb = eliza_cwb,
 	.intf_count = ARRAY_SIZE(eliza_intf),
 	.intf = eliza_intf,
 	.vbif = &sm8650_vbif,
-- 
2.51.0

