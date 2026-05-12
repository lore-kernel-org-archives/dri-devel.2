Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854D5CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3C910E2C3;
	Tue, 12 May 2026 20:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzHTNS+x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i99/sEjr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B5010E0CA
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:35 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CDgUNc680321
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SkHOXs1v/pCbA8JFYyhJRkUq8O19fMYyqzXVYS8eqYk=; b=JzHTNS+xpFW1jkVP
 pOsQ5gGOvHPAo75Qg00C/p/ACKxvkR2nAc6MnbVxPO8JP0zbI0zRdx9F3tFM3VER
 +3MC37GAokAzXpMZ0QLWEz7GZpNaH+44BiYO+WKoaAWZYX0FLcjqnmC2U2sWNZCE
 z6VM7lGNhK75LVRKDNtD8xRebPOSNKGxFpMu3NdIOOidM/8y0iiyw4rkk3r6yEjc
 IB93PV1ZenShPm9rW28gOOGo6VVG0y7gJRU5jVH2ei0l3B0hYKhf6mpcJ4T6/O7u
 51fWn0wKR0Qx0VyGbcznnNkZMEV1XyEbkwtfO3iEPFCYEY04Vx+XoCFDheuWnlLz
 CeNeTA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avhp4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c827bda2e60so1979337a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778619213; x=1779224013;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SkHOXs1v/pCbA8JFYyhJRkUq8O19fMYyqzXVYS8eqYk=;
 b=i99/sEjrhLissBhuC0JUiqH2F6lz8FC6Oqcpqaw3XlHwFSAXzXLxKoYVUlC69qbdJg
 ejkF+cwGpILGWUNm9HwgtrrMdsDFHkYyclgamNKJCArRL2MZ8mkX/gMNS/1lUnxnSOy+
 +wcp9J6HZoPzG/PNiwV5W02k/QddxmSeFp/Gxke0ahT6mag3OJddOy5N8K37yO+mCkAG
 ZSM7GknXmwKbSmlGOwAFROZkF6/Q1zgb6zWqD6JGUPxiiDcAJOz9efzWwLruLkrNwCpG
 wzvpA4GVOoisI+rIcXdEFM1W65tTmKzx/CwHTQ6YspnCx/p6zGdrrV/ncxjFnm2z9MHT
 QIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619213; x=1779224013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SkHOXs1v/pCbA8JFYyhJRkUq8O19fMYyqzXVYS8eqYk=;
 b=Holi/gOXSJOFfVgDvZ3fqnTYvvNa7KeOqJQk9Mra4zltvp1QlCY8xxwS/EyqloPcao
 BLl37m9LWfdajNM1Lj/78q8YkDu0lLylQ9mADhxWbwLGsdZEI1XS7ziTJp61tvbcFz7I
 1K/XgH+AXIC3ZHAPzvLQ/HV6hPSQgGhkyQ/3Idj4x+YbcVAnc7IJid3yyXT1BzcNzwsK
 dWu6euRekPk0DDtybSqAhYZ+wXdnpvVkoXgPMT//VCM84Nn40uK14Hz3AniImhIcnyDv
 sC+p4z8YKxnmLP3y/3JSb0x5C2GIiKUjquO/E/HZtU8DU/bEiAQ+Glx/0+JlV6s2G2vB
 Ydqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XEZLyQg8k5JZ2fymRsIik0fboPlwWSH88DCE6C1OL4hgTy+SExdEwKNbuCi1YCofKejwZyWh55eM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxqEAcExCTBR60LVKjHT/h7lSBfCoxHK0vRQEopV02HHFnqeBN
 cBpA/Ru+A6yOP7XjDRiRvinxIDuAtZB27whWFQT/btITPuR7jKpYq2l2kZp74G2reHgrf/dwbF6
 BWP6+nilqOqwgiy3sMw6SlIXV61behVAr9IHo04NZ5cagqNq9ikCFynQbyRAQIh7rAxSQiFWEGr
 HprGc=
X-Gm-Gg: Acq92OFjr9gMH5hkQu6bWfWjVmEY+fhUpfPB1kwiXxienCNzqpjcjrMtPPKrtgiDqRV
 7g+1A8RcJ1XDAN+S5OPqy5HAq1gT08/mhYULJLKeCQOB6XybdG1x34J6ADIHXP1wsGXhnquuZEH
 hA9vsYeMe4Pwso9ZtHNuZN77W+sHnvHqM7/+aVBsOikf2YuezUV+8x53oJuoWEwq5Zud4ykWSjn
 BKormcKTLu4zl7lpXdq3R1KwJu21Db4pR/wGy+PYleln/SLa9+pixmcG9KjpJj6AnMnkoGh4FaE
 +9TJPt9v8Jyh60ujO+XQ6NRhBouG4b7MlY3z7lD6pWfKy5S7xFwjAc0M6sc82B/O73HOX6Z08BB
 NFccPSp8jCUuZViO/pvgI+ag3/FcuRDWnT2n6Rbozk2rVtA==
X-Received: by 2002:a05:6a00:4397:b0:824:a22c:c6d7 with SMTP id
 d2e1a72fcca58-83f03fd68bdmr270198b3a.18.1778619213068; 
 Tue, 12 May 2026 13:53:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:4397:b0:824:a22c:c6d7 with SMTP id
 d2e1a72fcca58-83f03fd68bdmr270180b3a.18.1778619212601; 
 Tue, 12 May 2026 13:53:32 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm25453004b3a.15.2026.05.12.13.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:53:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 02:22:58 +0530
Subject: [PATCH RFT 3/5] drm/msm/adreno: Fix invalid drvdata typecast in
 adreno_remove()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-gmu-sync-state-fix-v1-3-6e33e6aa9b4f@oss.qualcomm.com>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
In-Reply-To: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778619193; l=1326;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=K8MdpY6XMsl1Tggb4WHji+dp3CRcvvp1nn7mA74lPSM=;
 b=9ccjXNhWsV+/S0pMs0dFGNgEHhzV5zQuUwdYYa52QEABfcg8KlXrsYrMehhxEpR2a4zVSKiTy
 oJAbRyqXwMlB1K7LPEmHtZ1mb2qfsUAM5kV8LRXHbbIVFlngF75D0I2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: s-IimdFdNHNZvC2-io-95Hod1-sd9u5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfXxuRXixDwmrI2
 SdrfPYYtK51wkJl1A5Ts0NE2ge7f6u2oUQ/1c/VceIr+sgcmc/yXpnu7Sgl8TtogwDP9+ooSoOY
 x6V1atRqDyMvIxwC3rKBcwYX597znogODenajePOnem6z/JxbbijhUWFZnT6z9Vx7fEyyJJJT+Z
 mICekFA6Vjd4V70n6kCrKrs1RhUFdZExVFTUPMPnwJDaHlJ0MIGi1MVxxlIIdYpmyjceIkgB+IU
 5i5oe3gkh004ofCKAOKWuGPweYV7iT0ibGWscmchcqLLYO6QTR0hSgYY+VpNpiSUyE2BYCwycUM
 0eiyTFjTUC99VDz6XK3UQoEGISv4t6ywsREc/7ZLldzbw4nBMdatT2WgiEOEFBcO+3HomKyy0QY
 cCnPL//sNapiU6cc6q1h0QafWMz9ZqD6f7SJH3/4cxP4p6sKnJyOdQfpTWAhyZlMSSyczqoYhZD
 yPK50YotUTmHeLZXkwA==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a03934e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XPVHBuiRDinS94PRiAYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: s-IimdFdNHNZvC2-io-95Hod1-sd9u5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120214
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

adreno_remove() decides between component_del() and msm_gpu_remove()
based on platform_get_drvdata(pdev), interpreted as a struct
msm_drm_private *. That dereference is wrong because msm_gpu_init()
overwrites the GPU pdev's drvdata with adreno_smmu_priv pointer.

Fix this by using msm_gpu_use_separate_drm_dev() instead of relying on
drvdata.

Fixes: 643515a9cd09 ("drm/msm: rework binding of Imageon GPUs")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 3052f3e36de0..66953e551d86 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -279,12 +279,10 @@ static int adreno_probe(struct platform_device *pdev)
 
 static void adreno_remove(struct platform_device *pdev)
 {
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
-
-	if (priv->kms_init)
-		component_del(&pdev->dev, &a3xx_ops);
-	else
+	if (msm_gpu_use_separate_drm_dev(pdev))
 		msm_gpu_remove(pdev, &a3xx_ops);
+	else
+		component_del(&pdev->dev, &a3xx_ops);
 }
 
 static void adreno_shutdown(struct platform_device *pdev)

-- 
2.51.0

