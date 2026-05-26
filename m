Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E12CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7170910E667;
	Tue, 26 May 2026 14:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCEl6biR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ftvnGVcf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489F010E6A7
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsXvr1430513
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uZWxbq16V5d
 ge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=; b=oCEl6biRCeCTYulMumpMNwJUeIp
 pX3rblOuDvA723Y4LkqWTwAD2ycnETTh/Fvn6zJNwLGwtcAIPMLPcMJ/9XTcN5e4
 waXkdXj1VqQBL1YmYCXzvRC9bAx9VuRfKN/SGXVwNdWkQtchG+5HkRPf0Eu/LsNU
 OE6mVXlAbp+2PXFCGBM1KwrmhMPNnb7gLp9Xv1gQAFxP/Y1OJp8KXeWsJVkEQoy3
 HIohgZBSqzfPbQlJAThBE9xQB575PyJj7dvfchesMtTew4w9yTQcAs7gFAgtnIFh
 f6tPtpBpaAURMoRwJL9KFoq787jVBq8QdZEEdaXwEpwBTTD6LNv9EfxvWNQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv5m2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso48182875ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807237; x=1780412037;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZWxbq16V5dge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=;
 b=ftvnGVcfSPhpUT716EM394ItY8AF8RCOEscpnnHX+Qr97RKPq54e+ts28PvdVOpjdA
 RzrTdRUu22fB3LkDb4w3xikqHP08upx4Bom+aEp1v0RaVUd8lWXVeGeu5bzOJZPIoZPz
 V0HkiB5AZzd77jpiYF2W2NVsOgPquyTo4hPN8DJkpCYlfQ18QdDgv/CPezFjom3usrJP
 YC3o/pb1YLio+UIho/6H0AjQudWbSkzIu5uEgIzHwHxQtRDmZa34t1Du1si14KSx0WAb
 qS9Pj2ltJqO8OGq9FXlpbPOaMBaPzcl6pJwWIxHPPf2VXexaWtVCA1DFM+TKD5BcDf7y
 l7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807237; x=1780412037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZWxbq16V5dge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=;
 b=FcHe1WS5zLqw5cVjcmQ/eb/uADwTab+ce3fACVBR6JNzLbGngSjlafFNgJRWJxrPOv
 /9mtW/rhT1Zl2VQrkajJE+pyk/leQODlkHEKTZ8mIQuCintntvNuBl0vUIFmkaeQpEQB
 mX457ENbo275+QaSAfXIEj7esysl3Os4rLS5BZNVwFUj3RWCLKs7WYQDXSObj6CBWDHD
 fMhbLN8130uLXiJBf5X5SqEkDDIP/GzSP+zDWstQQrOh1KjoXZ81wP1nkogHNFoBAk/f
 fpZtZpq6f2dMg98La7Yl2tkbZ87UXmKfgBq1IWd5qd6MkHQGN2uSCJxybZZfFZEkoUWW
 +L4w==
X-Gm-Message-State: AOJu0YzpFoqCp1GjkowFqL8ogIkcehZcnhUMnsWfPUrLANxqMHmXkYS3
 1JopPHwKrRsC2WvdJaHgm5FmWy5q59sOaTZT+tDojbpjiL4P7xgTK1yongHuYOoc4toDiyLi5YE
 Ya4SwNAdbHNWjfonizVQYxc286QCKzNf0sc0gY/aEnf6gCkXltHADkBGI4bavpFAazq+gaMpsJU
 uX5lY=
X-Gm-Gg: Acq92OHHX8Jk3jylR2VdTMZ96RfjxPup+5gU6BC7HaHn62zlhhFXKCIC+IaBko0EcxX
 PcZR22QjE0UtkAPp/8RVUF8F4fr97mYpw2ANAyblcC5i88onaz9anOx8+uydnR+FeNs+YnVIgkn
 1WR1jetIM/GRNjRG61sStKGf7bK6mq947sDOEIaQaJUWk9MTOkQxjxnrrLDivUYgYEW2K/s3enT
 ivcBdgR6vfiHVf9pRKF23KeWtwFtWxMvskZVk2WYjUVA9FTF+SGy+irgKVexsnmLzAESeUHkcrx
 IPybi+K9i5NaA6xCfoqz33QqmMxA8DO716BYKEfRfJ9pMLLapj/R7AQlWXNcRyBzQhqJLxIwmOk
 i85W7bvJ7CZjMP+4EGMpDEm2Za8q7Op88VG3VgxL0pK0=
X-Received: by 2002:a17:902:ebc2:b0:2ba:6ffa:bde0 with SMTP id
 d9443c01a7336-2beb065b797mr204911235ad.19.1779807237030; 
 Tue, 26 May 2026 07:53:57 -0700 (PDT)
X-Received: by 2002:a17:902:ebc2:b0:2ba:6ffa:bde0 with SMTP id
 d9443c01a7336-2beb065b797mr204911065ad.19.1779807236553; 
 Tue, 26 May 2026 07:53:56 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56c4f8fsm126715195ad.26.2026.05.26.07.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:53:56 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Tue, 26 May 2026 07:50:36 -0700
Message-ID: <20260526145137.160554-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX1KrE2DdpoARY
 Rdn+rfbhUJk/wvnbj+2JGfNiIhPbkS/3wFZFYOpHmgGwCyBe1HxkhLXLIXi4CPepzkzgposqiv6
 1WXa74EHXgJ06GSwbeC5gn8+Hy8UrsrVTrIPVmmiWnZ38UbcKigeGlVKBtc3xQZPwaX3Ogsb++c
 wuiGx35s9YxxXXP7xsBttLiV/WuhW+M0xOmqy4CPH+ZOJc74qVAiFsbppxD/wIvYPxzAanUh14B
 7KShS9xCQ9f3vEYJrZeHT+0psvZLtMsOd36tIf2edar6QvZ05wHu1SZOCONBUc0ajU6z1C5bY8L
 ZdaDvftqjuWIeDoyHbyklA9b/1QPAnFSltgZoPN4ismOq5AEbtZpwtCthmwFT2VdHPy+Dt3+elC
 O/LYfpQ7N32TEa8YXYKc1tNNv5P7jjHC+/LO85nlkjlBoWcd4SBaMfyWWY1qpjn0zreMke0nKNf
 TsQvdpJj0VrOziHYcyg==
X-Proofpoint-GUID: sPCSltLSOA04__55nrpj24TD2Q5okeV1
X-Proofpoint-ORIG-GUID: sPCSltLSOA04__55nrpj24TD2Q5okeV1
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a15b405 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=RIk3oTIWcAeXYnX0VHsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260127
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.54.0

