Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB26AC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B8210E0B6;
	Sat, 26 Sep 2026 23:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LFCP+kio";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLeyRfx2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4125910E07D
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QH02iC880292
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1Apv0bUxILz0xu2ZX14w9Q
 0OojfUdgyE9G78ZnXEiQM=; b=LFCP+kioTfYKE9EjEwgd5wQFAtZ5DIbPw1I3dH
 SO56H5gpIqzG+IBCamhCQAM066L4K1SyyyWQ3c88ZtkDPgaIrBHWGm8bWZxa8PH0
 ufaNXS9IFLvpMfxjQ+kuwOc6vY8qtlEJhsWoTguWYD84qkN7/qIHB6lXn2aG+xT2
 EXwri8dk6vq3IzUbpu4WmOHKyEO1VKHeIYyZtdWzLjioJKDuGIWnO3ftKgBgQoiF
 Uf3YMxhGo4igPNPrYfgb5PHPCPfJ63m6tg1Goh4ZzasfawrkMeDOHNtt1+nQqd3Q
 DunIIerqHaV20eBQZFq6lYRRZmOPQ4hGbybHQ5UFGy+N+hLQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mw9xny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53332bda5c6so8678421cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790464814; x=1791069614;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Apv0bUxILz0xu2ZX14w9Q0OojfUdgyE9G78ZnXEiQM=;
 b=VLeyRfx2fgltDYgrIjNHUIH882i1qR5CtnLBd7Zus2YuM+fj/BQgulAf/MWNmI60sR
 7UEWkGLq73SCLMrATXriZ2lXUIpy8cJa1EGm3U05x1wwjb3ttzzKyAULQHk3FdYpBOse
 dl+XvQh/teD2u0ONBowtoNT+iYn+np7GukWRXhQZYCK8mcr4C5S7FDkaMb09LUzImzJW
 7v/cnF5IVEaThu7oUM28UWsjCCjzEjSbApS5hKV5H8BKynhruQU4V4DPhL+1Kwkhgqkc
 0xJsY6Y0/Xf3czOjKYRWDJE+1XVy3FXDWDz4l2RSLJ+nGEUAaYZuwfJdrztBzXZMrWFU
 nWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790464814; x=1791069614;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1Apv0bUxILz0xu2ZX14w9Q0OojfUdgyE9G78ZnXEiQM=;
 b=r6k36SfipZmjAhw4TBiUvQ41BgeMG2CYMtYk6dp28jZ8yF0pHzPGo3XRJud6UzC54M
 W2m9IO/gZqkoHAZH5pdwUScKtgOmaLF1kru6KLYCfGML2ZzvudbcA4MERdBM6igFF2Xy
 TUJ2PnwriA6uXHyWATbU6waJRn8KkyOHVDY/p7HV/6Ei0FtLuF2vgh2JLIkoXC1hv6KC
 HGXHTFa/6BRk/6Ai2UgayEKMppx5Lw0yx0n27K3TdTt2kI/PPK0I+9o9bpiCY+uUrW+l
 nNqqrFi41zZ+U8h9Z66N2fDjUpNVm2Nt9qkvQ7NyR2/O1aWKGkd0mHvTLdGmEjDWDIEB
 HELA==
X-Forwarded-Encrypted: i=1;
 AKwUvByz76N+rXY4oOOJ+1RrhJtIkyhrR9IUCXrTXMo5OzdCrJQthST2zN7a5SSTc2uQdc4PfZ70UfnkLZE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k++rmNRXmgn4FrV398EydS62kZ4pkHm49q3P95ZQzcZtz69RZ6
 /418FYAKLsM8mc7+I1AqyLwXxeSLaAdF6hfHs82oyff+koTOHNdRnNzedsR572FGezGq9Or7Z5b
 flKJdLm0imyenHGRrTkL0ny/BNUomawKgrsWgyoCq8HNKphSgHISrAwPBroAHAHA60TWVoWU=
X-Gm-Gg: AYBFou3E+BOMdUgWn0ufD8LtgzhwLN5tH2MMg7xp8GENFAflDreE4uO1G0KRbxwKg03
 GTZzZACKvBuXPr4c0pRz9fnoIJjrKPNwdNqkl5YT/1T5MI5boSqApLzEQBsUz6aqPnDK0EZiy1Q
 AOftLn7++Q+fK6RfRyOqeTS2hiJj923TWVuB+l+nxRwhXolkREFfnGwtYl1pcvleKlaobfMypFq
 e9I3ev2U/hyCB3jmqgFA2TV1fDJA+TKZbfc4tqLf5/tC1cYJRDTnqSUTwOg2LWORpwBxJWiJyKl
 hBS0oQs1MvRaVf56KAm/rE/KmJiUjWyePFOVOQLaWa1rBC+j5saI8lizgPL6D2kH/eC21gSviGv
 1gmf9LQAd4T/JBoi0NKVTkAL5unWUVRfs4YKfmJwItMasJo3iqJ4MWkdJa5q8bmL6eMcMANURhF
 H1P/CnrSBRIUJt
X-Received: by 2002:a05:622a:310:b0:532:d36c:708f with SMTP id
 d75a77b69052e-5330b70c4b6mr119234051cf.30.1790464814330; 
 Sat, 26 Sep 2026 16:20:14 -0700 (PDT)
X-Received: by 2002:a05:622a:310:b0:532:d36c:708f with SMTP id
 d75a77b69052e-5330b70c4b6mr119233621cf.30.1790464813825; 
 Sat, 26 Sep 2026 16:20:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a64c3274fdsm17676311fa.38.2026.09.26.16.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:20:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/msm/adreno: implement progress handlers for a3xx
 and a5xx
Date: Sun, 27 Sep 2026 02:20:06 +0300
Message-Id: <20260927-adreno-progress-v1-0-f0bbbd6a4ac7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZTuGoC/yXMQQ5AMBBA0avIrDWpShRXEQt0MBatzCAScXfF8
 i3+v0CQCQXq5ALGg4SCj8jSBIa58xMqctFgtCl0ZazqHKMPauUwMYqo0o6VcbrMcltArFbGkc7
 v2LS/Ze8XHLZ3A/f9AFCMinxzAAAA
X-Change-ID: 20260927-adreno-progress-87f92d081376
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hjHuHiBLPXeUk5bCF3QBOyyC5Mqbbj635QxQ6KydDgE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBquFMqjNDriOYaePmDwAq71b3O064p4ktvyxjMv
 x6PbbfqAOyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCarhTKgAKCRCLPIo+Aiko
 1TxJCACiaQuVb82DBrnCRZFAUVZzWCobCtUOEwZGV7KpF2T5FUqnNxXLC41Zf/d8CgIqiGH/Yq4
 SoZVdcbZKQc5DbR8STm+Jsvb1B6cmdiBjujoSDaev6qQpt3g21kvGo5OMDvcNwOs/5Fb17CjPid
 J3Wnwg3BUOAPVlJWMzZvznWMPjE4RjdyIZeYXJ7RTvucfUbkEn6KIbFv6L47cfFtRseLBvtXkQi
 MECQuPDKHR16FSzaWzYAAddcuDRGRen6b3HMPWoPorW14I0Ekh73ZOLFzdk3p5P00HPKSLeKhgP
 B4zuwFt2ErijU3DfMU/GhM/QaqbOzqkcJe7nbRqJIWiBY86R
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: YmWrpYF71jZmB_UdnuFb1mvsNhihXQ-T
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab8532f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=NlBUUgI1MX_TVLqZzjEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: YmWrpYF71jZmB_UdnuFb1mvsNhihXQ-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA5MyBTYWx0ZWRfXyhhmMqzmlB1j
 S8WMb6OPkKrpPVvHdf/vnLKaxlksQ/dDzvUxhAlHskJRAP9nR2OuaPuzBV5bC5KMicv9aCq27c1
 YbVlOv8ZbGGsF0IOQaK+Ob7KiOrGJgnFxLH23tZGoUPomiZB/i0DyGu9IsTFU6yDb2j9Vpy5BaY
 pErH6Sv33+95pG/yUn6yIyKB7ZAFzYgz7ofMuI8n7PzzgZtg/BSLbTik1HXL1NPDekH0g8SRjmn
 BAfmUNcn8iRwciRncCQ+zXZo1d9PayO+hX2p8dU9gGvvDx5jZkRFoe3yE3oI93tHzj7n7XHhSo0
 UXYwKYMhUmmjyExW9eTTBGNf7j/49uwZ9PfKyPFohF0tCwhR0LBXyK3dakAeV51wf5E8N/DBq1i
 NhQdRce86L73l6KZ7iuSAcv9wX9UYSyy/5FeZJtmSq9A0SGXan9vHhtWfq98eXNYBYeIpsECHOY
 U1tE5qw70K0kbB0v2OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA5MyBTYWx0ZWRfX+cXFezjBNRnL
 kd/aFBMy9Zn1jfyc6hD8xXr8cqJv/bljtLzjTRwS2TBMHuWNUEtFbEe1xRS0Uu/6JX3j6QjF3Qw
 XFuuRcvb8gtY5g5ZKCz1FW31jACnHg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260093
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

Adreno A3xx and A5xx don't have progress callbacks, so any submit still
running when the hangcheck timer expires is declared hung, and long
compute or drawing dispatches are reset while still making progress.

Implement a3xx_progress() and a5xx_progress() callbacks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/msm/a3xx: Add hangcheck progress detection
      drm/msm/a5xx: Add hangcheck progress detection

 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h |  2 ++
 3 files changed, 47 insertions(+)
---
base-commit: a15fac810c76397ec9f62a6fc26c4d7ab6e238a7
change-id: 20260927-adreno-progress-87f92d081376

Best regards,
--  
With best wishes
Dmitry

