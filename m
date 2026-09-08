Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644E3C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7521A10ECA5;
	Tue,  8 Sep 2026 15:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KkKrsSC7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/QWR8+6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251D910ECA4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1LfE2109768
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C08XeX2FFrQaQVRDvYflEJeFTvMG8k68onVOApp7D60=; b=KkKrsSC74ibZJDYD
 Zdbqms1mDt8QwUcTK7LbW/HWVd6kjbSXAbrG0IQR436BSN3/FpXUbczn60AZoriL
 b1K/5rx7VlxgoqFOTsLDU0ChXZY4bJrqa6HBzb8uutkyWvEhDdgojo1GNaTM08JM
 0YvXmHVudMUmeE947Wo6H5oYuEu3Px4og0uzZgr22dwcxKv1DaR9XHOUAWtBPWoC
 cXjvcklymnDBbqRlZtD/Caq4risVLl3nYnEcQihpVWp8cRN5LU7+mnyWSuxqXZoR
 XkFvpmxgqZgra0PBNBxKc9DcjyiUg17ZUUGqcbt4mCSd8O3vLLtE92piBVwiZjYy
 8aSq1Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjkshrdhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:22 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c6725e7891so1344943e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881061; x=1789485861;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C08XeX2FFrQaQVRDvYflEJeFTvMG8k68onVOApp7D60=;
 b=b/QWR8+6+Feyii0JJs9CRXA1GnSoJwpFl1CB5YM+GLQIsNqgewdgpGTq5kYgbeQl6s
 FK2G68gP3pvcwzYb4N4TyszB/VHAEWmWQZhpuWJ8PjpN4gfH0o7jjnU48iZvTUceT3mT
 ISBMjkCmwuf8fxaHo9KoYA6W0xSpNFgyszHYj4nEEurFnLMRQMdbFaylBXjuqb7wgqPF
 XfJjzmr+ZC+oHnbpETSpcOpf1nXW90MXNUvawZPgS/kzPuxWNWvZfSvsE4aIsKq2YywR
 NyU+QQGAAd9e++mbTENPYsTKvptb4WGcHdIgcgWGyyrurqVYn4bRF7XaEK3PhqmoGovX
 ctIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881061; x=1789485861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C08XeX2FFrQaQVRDvYflEJeFTvMG8k68onVOApp7D60=;
 b=q7JdE7HKJkcah50qbdswEM1B17okWxAerPz+7u8r7QUpfWDbAn5pvY1NCNRFLgz+3o
 GknVw9dYC4uGkKOm3wCvcb+eDOJpFyiAcl/JUp2HegyzCRIsHmYE51fFl34CVlhdkHHY
 JqZusOFMCEyD8Vc5pcISSyQtmsLDSHMRvgR2IrlVTiiZO5RWOA5TDMsmRuB+BRqs7Isb
 cwk0CFgVpHhQeg+rJ2QWNJIXYLN3XHlWhqZ6JyglOhyBioPCT7bua69I+2ydvC/T7Opw
 nHwk8AhJzNWb4r+cquPphkb0eMdqos6rgHf9MWm1EPadxAAerrgBm+500s4ueWxroohd
 GIyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz22p5lAxcpXdQZC0Yj+Q6eU5cfVL4ZSltVgzPQqwHEwX8S7GCpEJM+UUDRhVwPchhNlTe84f6NBnk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIowciZv6pgZRZQKje/Xbsl/x1gIrx8WlxdIr2zm1QEeX6atbH
 G1Xun5OJRQlH0WQy29muYm0ls73Ukj862okMqbMXcokOprXrPnSfky4E1uEQvfDwsg7BOhrYdUR
 OJeh9NSF5ZlXMlYAp9SOpYB+FTK9aZTBs5Sy8fS+nf86V6dT854EIcF99WRKg6vthishNv/M=
X-Gm-Gg: AYBFou3gO7LOQuBBZI6g0yU1RCXesWtIuOwtMeVcmf5qv3jKrSWutdDrSzt7amGKNrI
 2vUEMFv+MNOwz387C5Bb6MoRJP1/IvD/QseKj1MfQ/Y0rsFftoAGJMMcs9YJN1phVDruTCV8Yb0
 5dvILePwcEZ13oQIUxBfq8EiDtA2zuR/uQSyPQcET4ldDV9JOga5XV3F56addNMiokTeaoot0Th
 XJjW1XhDoonaRJZE5FWm80kPYwrqAucsPgFY0IG9WT5DMYp2m5WuiFOH04n40uEXwxQMYR6ToZf
 SGMeT0utKc0IY5DhcfbXuIbruldIvlD5QLvz3ZA4kOzMH9iYgD6C5sD8/p4PYAoneXubglunnJb
 +CJBIg3rLfR7FfZemS6/rc1ImY43y6/BEO6TKvgOWNCXWNct0iKsHEvGdwYKLBJ/6K+UpU/jTYd
 RkyoaYmhRmw8C4
X-Received: by 2002:a05:6123:2c8:b0:5bf:b3a0:388c with SMTP id
 71dfb90a1353d-5c7ed3e2247mr14515446e0c.6.1788881061580; 
 Tue, 08 Sep 2026 08:24:21 -0700 (PDT)
X-Received: by 2002:a05:6123:2c8:b0:5bf:b3a0:388c with SMTP id
 71dfb90a1353d-5c7ed3e2247mr14515383e0c.6.1788881061155; 
 Tue, 08 Sep 2026 08:24:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:24:12 +0300
Subject: [PATCH v2 4/6] drm/msm/dpu: clear the DSPP pointer when no DSPP is
 assigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fd-kms-fix-smmu-v2-4-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=42MaHuKsi9wtmIKNRqT8ly0SxW0ZKEjpv2W8+Aag/4g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqoCibn5CUU1Ow04wahu5gHr1DsZo3/NR0N0Sk5
 VTpdsBaCiGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqAomwAKCRCLPIo+Aiko
 1SVpB/9TAbiVdOnVqlVcKQe9lSIHzoBI24yUs+bAbtDG/7ykrOpriV2KajAJoLP6qwVWWvpalRN
 4BDCR+RWlsIpVeI86l0gZXLvxGTup2h7s9cpfXxWEQJajchJBKqk+BxFyQ1Sln+EAMkzf+wrtLp
 bR6D+maCB7fK3dpKDJtZmScyU0Ie45lyroyFf+3JKl4lD8azVjcbBCMn7hgw6JjwNey1beIWiW3
 p0Hg70PGoO1OjBYlCMuNHwye9JB6KnYoP2CNr4xf2Pfv21aCtGfR6bnrzyfpNwV0bOWj4H3ITyQ
 bFyyELqliUK4rJc5hKj6JVe5+RVItSBLAkriAWWIfHJUOww4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX4IxeGeNhzyq/
 URw4FMHgC5rtSN76PyiXWqLV8X7c3oa56soEiE/woJuVjr693TsirQWTtLpOp5vQSPZ+PJjvlYg
 ZdZe4Cua+PXwLIagBdRAgGcEnhjYfcQ=
X-Proofpoint-ORIG-GUID: yq-IBvhUPBOmimfs91B0tgcY18lkmRnZ
X-Authority-Analysis: v=2.4 cv=TammcxQh c=1 sm=1 tr=0 ts=6aa028a6 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jpbDcG_WXHA3xrgMYRUA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: yq-IBvhUPBOmimfs91B0tgcY18lkmRnZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX4yDC+2yAXgOy
 5f71nTHNNnFlHUUxtS7E9F+U0szh1p1u5QrCEC30N82lApkC43DFZtlxqh9/2X+zqbPLlOGJwjw
 FmXUqhH87P5NNT63x5Nb5hTOVqCJgFd6z1u9rnsr4EUXgubdHc8WxIkdXnwFZLW5/zO9Ln+u8QL
 npTXYEeXvtQjeA+jpRJMaNRh+waeiTzazvxNtAAgRrx8yaELI6aquuDXGVdk2mBm9rUiQB9hy9L
 RUTKa1gLffxKtpfyc+7oFC4NbIeoYG3r6S8rEr7Ts2mXKoy69TpUWE59uL9fPXK5oo1cfsdbEeR
 WsSCjoyzP4RPSz1F16LKiTwdgWqVtHZfT9HcKnWFrJh92TSoOQerbhIZF6t6T5uxD+mLafP+3uh
 +AxtdGdpmFeEvh57og2+CJFgCzkUkjB/8jwFzmv6wNq3CDMPkCF89RR9KoewzEssrAsvfdDvKmf
 AOQ3GPXhObHfgCmZVBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080166
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

dpu_crtc_assign_resources() only stores mixers[i].hw_dspp when the new
topology has a DSPP for that mixer, and dpu_crtc_duplicate_state() copies
the state with kmemdup(), so a crtc which once used a DSPP keeps a pointer
to it for the rest of its life -- across reservations which no longer own
that block.

Assign NULL when there is no DSPP for the mixer.

Fixes: 4259ff7ae509 ("drm/msm/dpu: add support for pcc color block in dpu driver")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index bf593020e8e4..5dc0c9aeaa5d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1480,8 +1480,8 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
 
 		cstate->mixers[i].hw_lm = to_dpu_hw_mixer(hw_lm[i]);
 		cstate->mixers[i].lm_ctl = to_dpu_hw_ctl(hw_ctl[ctl_idx]);
-		if (i < num_dspp)
-			cstate->mixers[i].hw_dspp = to_dpu_hw_dspp(hw_dspp[i]);
+		cstate->mixers[i].hw_dspp = i < num_dspp ?
+			to_dpu_hw_dspp(hw_dspp[i]) : NULL;
 	}
 
 	cstate->num_mixers = num_lm;

-- 
2.47.3

