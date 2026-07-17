Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22004C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D549D10F5FE;
	Fri, 17 Jul 2026 20:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ib6PxVPT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhV+hJTI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD60310F5FE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtQwX2883535
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JwmCQxui8//
 y9OuoPvnSLIPSYLXC2fHhEyhJF+VayoY=; b=Ib6PxVPThSMa4RiC/ab7ehcY6Fs
 IMOYcbieq56p2dYqLlYLUU6Bwh0lcCK76EseCJtr9LWW+/ej3/hJMNFc+uSsQE8A
 9GHR63LN/LXiM2hKABrIfJz4c3/H+26+jVKz2+EfLFR9UE0wzYGLG73FnnAq8uVt
 oaeVNNOqP7VkjBm1ZPKAYv0UOHOCArj3Tz+HE1ypXkLvERo/nxDytRFJTE2nf0TJ
 BqBvmJzA12ojitxb3nDyJu4G3c+Nn0hCaoEPbg5VVESrC99IJ/j3VO0sMs8ecYDi
 w3ufA1U5I5TARSlljyKnUNoOL1N6guhittD5XJQDuoq3OXlcIh7IwlsPE5w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrqd8rx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cec4226c70so116038545ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321338; x=1784926138;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwmCQxui8//y9OuoPvnSLIPSYLXC2fHhEyhJF+VayoY=;
 b=IhV+hJTI/oSnlrnj5yhxsWlWeQsf4Avm2WExbzUED1LlnrtpBA9e14jS1dsP7fLJBA
 O1IeJkhFb4Cipq/+sFVHATDXjVOTHBj/1JPTpHiz70sif08uF+lv2J9T6FBqM6+q8rBT
 atTNDPmQHZwvGneDOony2gxBizyW1UZo8ez9tEDLiObxBrSZoYfjQPwbes2NxFNxyor9
 2c4cKGX/Ftv+HaQNG1RN9UwJeWZxz5oPacKax1gp5R1ltNGJzyd3Q56NVl6Nj7gZ/cOv
 ZuS/lsCgbMl+Mfamdqr3dBncDniR7GKMb4EfL910yvaWdA+BX9ZCR/o2MwGPBjZygUlX
 jFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321338; x=1784926138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwmCQxui8//y9OuoPvnSLIPSYLXC2fHhEyhJF+VayoY=;
 b=NEg7SiqGbzRB6LppJNHwV4cJgG1Z1erXTi80IPlEQLWbhJCh9IHNo9dJqNc7axsdg8
 TePUtV8mo9U6AboUnxmTKnyvefiKaMRPvtoQDdIQcQLEPIRliZaijN3puv450iRIVLv8
 OXVteiIt6VYGvm4P8jg8zSElHi4rEDGjKeSTGXDfEtsjCplXRBuBRKJBTnw6bAEso+5X
 9lO0twLfGcCvPxjPt/qBwE60CXk+Dn8HIAtwuG1UyMFV7NZlxtT1LPpdLphzagzvDijM
 MjJIqqYnBhAamzOhcuxzDhKe+n8wJSWXNDbiQRVRJ5ggYR+8FzX1PoRgI2Gulkl+Y8fl
 RUYw==
X-Gm-Message-State: AOJu0YxcX6B4erJR3bfj6M8Qmr7nOc698Sm97rvu4IOHdb+0Z1sDp9my
 bj8lORu+zbJ9rFhdD0SxtmmjVyWpqvzIBdunMY5S/z/kLWiJ8tv7TdlPV8ViwG28BE9skiLDdB6
 MZ6f30DCABoNAm2f2yu0a4QtR8RiHK/EO4AgBRY65wn9I9gmEnL9Cn7nNw2lbbAMGtnwpPBYXW4
 0Djpo=
X-Gm-Gg: AfdE7ck9+qKuFKINJNLwhmTpp5yDz8lvx9FduPz0MxtAdjt62B1EYqIA+USpkMO5UIX
 06duuCLQuYw15sp/G/rQj8q3FoRrLafBYqOnm23AKigwIkLy9BWxabFpZThr6SZk3wWcHgTw5ti
 j95eagobm0wW9mmseaaoARciDClQy/5ydNIUTIjI5PzobMzeJVeVQRO/gPXY+ESBtYXQ0UiG6Ib
 Lt3KUWyfdxclT0vZqkn0BlraTb9bM6BaD/BjvLH5r9gizCoR/a/Y9krDeiVLwtyZtZxpNZ1zI4b
 5INTGlb2nvvRbpd9CGG50oXvU6bHi+NVT/QZbf1fpnTVKqCLHy7Od7Ypoh/kz96BMNac7FBboa5
 mKQJ/rZz4pUHOFt0btikK/IfohTo00BPZbKZ+UU0XBhxn8Vw=
X-Received: by 2002:a17:903:41cc:b0:2ca:1eef:5096 with SMTP id
 d9443c01a7336-2cf349b46b7mr44070065ad.36.1784321338528; 
 Fri, 17 Jul 2026 13:48:58 -0700 (PDT)
X-Received: by 2002:a17:903:41cc:b0:2ca:1eef:5096 with SMTP id
 d9443c01a7336-2cf349b46b7mr44069765ad.36.1784321338061; 
 Fri, 17 Jul 2026 13:48:58 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf49d0dea2sm1171635ad.71.2026.07.17.13.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:57 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/16] drm/msm: Remove redundant SIZE_MAX check
Date: Fri, 17 Jul 2026 13:48:22 -0700
Message-ID: <20260717204841.26120-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 73Ku5y8qBHP-LHXahfsJfxoILagW3nQx
X-Authority-Analysis: v=2.4 cv=DbYnbPtW c=1 sm=1 tr=0 ts=6a5a953b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 73Ku5y8qBHP-LHXahfsJfxoILagW3nQx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX63CyHjGXSbIB
 xh4xIZQIAjrRs6zVPNE0J38c38423XCaQYYAPrLpR7hVbX2KAGaU9WFnZHXRM/EpECGLPpj7INS
 XFgYMndD6faDigTwHVep7k5hn1JMmVg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX5a5FXK9yZ9Gx
 A1KJdHpFzTDlDRH4vbsW+BnY8Hq8q+L/D+flEym2IaDrXCHNzUqVSfL/gp2PLbf6XDdNGfjfQjE
 GbIiJXKGK+rP9EmzNm/Y0ujfjp3ZuVy2XBi65CRCzfILdQrdopco5im5EBDjv3zhcfxxDsNWCkJ
 0Qj5oiv39wyTYm6IvUwod0/1gpdMgydI4n2RHXY/vYExp7o78XU+IZutxU04BYCOsWpyvharhOI
 rY92sXLk1gRj+u8Gm1/jV50sKuTmuGMMyFH1iPTbZxHo3oH2kjaVCQ63X8hh1NNoXNBIGHgrdRW
 ZuQ6h0J2eI2R/sNwsDq9ovaksdO+bjxnG1BF8TlFwJe5KcwazdAQHU+hO67Po41lSos5+/apLXo
 kajp89i/IErO0xEr/osMvQDDWZiBNXx7iGWaMbwttzc1qQ33ZVgLV0jE7uTMdt9DpCyFaQ9MzGe
 79D4TUk/USYubuIjJIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

kmalloc() will already fail and return NULL if passed SIZE_MAX.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index aa48ea4e7f58..040354ee16d1 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -250,11 +250,6 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 
 		sz = array_size(submit_cmd.nr_relocs,
 				sizeof(struct drm_msm_gem_submit_reloc));
-		/* check for overflow: */
-		if (sz == SIZE_MAX) {
-			ret = -ENOMEM;
-			goto out;
-		}
 		submit->cmd[i].relocs = kmalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 		if (!submit->cmd[i].relocs) {
 			ret = -ENOMEM;
-- 
2.55.0

